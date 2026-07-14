%% SPDX-License-Identifier: AGPL-3.0-or-later
%%
%% Copyright (C) 2026 Nathan Foster <next-nf@proton.me>
%%
%% This program is free software: you can redistribute it and/or modify
%% it under the terms of the GNU Affero General Public License as
%% published by the Free Software Foundation, either version 3 of the
%% License, or (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU Affero General Public License for more details.
%%
%% You should have received a copy of the GNU Affero General Public License
%% along with this program.  If not, see <https://www.gnu.org/licenses/>.

-module(chf_charging_property_SUITE).
-moduledoc "Charging-correctness gate — the Phase 1 safety proof.\n"
           "\n"
           "Proves that N concurrent charging operations against ONE balance document\n"
           "never over-deduct, under version-CAS alone (no `syn` in Phase 1). The only\n"
           "guards are the backend's optimistic CAS (`version_conflict` → facade retry)\n"
           "and the money `Fun`'s `insufficient_balance` abort.\n"
           "\n"
           "## Cases\n"
           "- `no_over_deduction` — conservation under concurrency: 50 workers × 20\n"
           "  iterations hammer one account with reserve→(full-commit | refund). Every\n"
           "  op uses a UNIQUE session id and UNIQUE idempotency tokens so nothing dedups\n"
           "  by accident. After draining the outbox, three quantities must be equal:\n"
           "  the drop in `total`, the sum the workers committed, and the sum of `used`\n"
           "  over all materialised CDRs. Any lost update, double-charge, or CDR loss\n"
           "  breaks this gapless equality.\n"
           "- `reserve_never_negative_under_oversubscription` — a thundering herd of 40\n"
           "  workers each reserve a chunk against a small budget (demand >> supply).\n"
           "  `available` must never go negative and the aggregate of successful\n"
           "  reservations must never exceed the budget.\n"
           "- `contention_is_real` — evidence that the concurrency above genuinely\n"
           "  forces `version_conflict` retries. Drives the same single-account hammer\n"
           "  through `chf_db:update/3` with a Fun-invocation counter; because `update/3`\n"
           "  re-invokes the Fun on each CAS retry, (invocations > operations) proves\n"
           "  retries occurred.\n"
           "\n"
           "## Determinism\n"
           "Each worker seeds `rand` from its own worker id (fixed per worker), so a\n"
           "failing run reproduces the exact amount sequence. Money is integers only.".
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

%% Case 1 parameters.
-define(ACCOUNT,       <<"a1">>).
-define(SEED_TOTAL,    1_000_000).
-define(N_WORKERS,     50).
-define(M_ITERS,       20).
-define(MAX_AMT,       2000).

%% Case 2 parameters (oversubscription).
-define(OS_ACCOUNT,    <<"a2">>).
-define(OS_TOTAL,      10_000).
-define(OS_WORKERS,    40).
-define(OS_CHUNK,      1000).

%% ETS table used by the contention probe to count Fun invocations.
-define(PROBE_TAB, chf_charging_probe_counter).

%% Balance collection atom (matches chf_data's ?BALANCE).
-define(BALANCE_COLL, balance).

all() ->
    [no_over_deduction,
     reserve_never_negative_under_oversubscription,
     contention_is_real].

%%--------------------------------------------------------------------
%% Suite / testcase lifecycle (Mnesia-ram + chf_db_mnesia + drainer,
%% mirroring chf_cdr_drainer_SUITE).
%%--------------------------------------------------------------------

init_per_suite(Config) ->
    ok = setup_mnesia_ram(),
    persistent_term:put({chf_db, backend}, chf_db_mnesia),
    application:set_env(chf_db, backend_opts, #{storage => ram_copies}),
    {ok, _Pid} = chf_db_mnesia:start_link(#{}),
    ok = chf_data:ensure_collections(),
    ok = chf_db_mnesia:wait_ready([subscriber, balance, charging_session, cdr]),
    {ok, _DrainerPid} = chf_cdr_drainer:start(),
    Config.

end_per_suite(_Config) ->
    catch gen_server:stop(chf_cdr_drainer),
    catch gen_server:stop(chf_db_mnesia),
    teardown_mnesia(),
    ok.

init_per_testcase(_TC, Config) ->
    lists:foreach(fun mnesia:clear_table/1,
                  [subscriber, balance, charging_session, cdr]),
    Config.

end_per_testcase(_TC, _Config) ->
    ok.

%%--------------------------------------------------------------------
%% Case 1 — no_over_deduction (conservation under concurrency).
%%
%% Seed a1 with total = 1_000_000. Spawn N=50 workers; each loops M=20
%% times. Each iteration uses a unique session id AND unique idempotency
%% tokens derived from {WorkerId, Iter} so nothing dedups by accident.
%% Each iteration: reserve(random Amt in 1..?MAX_AMT); on {error,
%% insufficient_balance} skip (a legitimate outcome); on ok choose
%% (fixed 50/50 by the worker's own seeded rand) FULL commit (Used=Amt)
%% or refund. Only full commits and refunds are used — no partial commit
%% — so every reservation is either fully consumed (removed) or refunded
%% (removed), and the final reservation map must be empty.
%%--------------------------------------------------------------------

no_over_deduction(_) ->
    {ok, _} = chf_data:balance_topup_or_set(?ACCOUNT, ?SEED_TOTAL),

    Parent = self(),
    Pids = [spawn_worker(Parent, W) || W <- lists:seq(1, ?N_WORKERS)],
    Committed = await_workers(Pids, 0),

    %% Drain the outbox so pending_cdrs materialise into the cdr collection.
    ok = chf_cdr_drainer:drain_once(),

    {ok, B} = chf_data:balance_get(?ACCOUNT),

    %% Invariant 1: available is never negative.
    ?assert(chf_balance:available(B) >= 0),

    %% Invariant 2: every reservation settled/released — full-commit or refund
    %% only, so the map ends empty.
    ?assertEqual(#{}, maps:get(<<"reservations">>, B)),

    %% Invariant 3 (load-bearing conservation): the drop in total equals the sum
    %% the workers committed equals the sum of used over all CDRs.
    TotalSpent = ?SEED_TOTAL - maps:get(<<"total">>, B),
    ?assertEqual(TotalSpent, Committed),
    CdrSpent = sum_committed_from_cdrs(),
    ?assertEqual(TotalSpent, CdrSpent),

    ct:pal("no_over_deduction: workers committed ~p micro-units; total dropped "
           "by ~p; CDRs recorded ~p; final available ~p, reservations empty.",
           [Committed, TotalSpent, CdrSpent, chf_balance:available(B)]),
    ok.

%% Worker loop: M iterations of reserve→(full-commit | refund), returning the
%% exact total it successfully COMMITTED so the harness knows ground-truth spend.
spawn_worker(Parent, WorkerId) ->
    {Pid, _Ref} =
        spawn_monitor(
          fun() ->
              %% Fixed per-worker seed so a failing run reproduces deterministically.
              rand:seed(exsss, {WorkerId, WorkerId * 7 + 1, WorkerId * 13 + 3}),
              Committed = worker_loop(WorkerId, 1, 0),
              Parent ! {worker_done, self(), Committed}
          end),
    Pid.

worker_loop(_WorkerId, Iter, Acc) when Iter > ?M_ITERS ->
    Acc;
worker_loop(WorkerId, Iter, Acc) ->
    Session   = session_id(WorkerId, Iter),
    RG        = <<"rg1">>,
    Amt       = rand:uniform(?MAX_AMT),                 %% 1..?MAX_AMT
    ResTok    = token(WorkerId, Iter, <<"res">>),
    case chf_data:balance_reserve(?ACCOUNT, Session, RG, Amt, ResTok) of
        {error, insufficient_balance} ->
            %% Legitimate: budget too low right now. Skip — no charge.
            worker_loop(WorkerId, Iter + 1, Acc);
        ok ->
            case rand:uniform(2) of
                1 ->
                    %% Full commit: Used == Amt, so the reservation is removed.
                    CdrId  = cdr_id(WorkerId, Iter),
                    ComTok = token(WorkerId, Iter, <<"com">>),
                    ok = chf_data:balance_commit(?ACCOUNT, Session, Amt, CdrId, ComTok),
                    worker_loop(WorkerId, Iter + 1, Acc + Amt);
                2 ->
                    %% Refund: release the hold, no charge.
                    RefTok = token(WorkerId, Iter, <<"ref">>),
                    ok = chf_data:balance_refund(?ACCOUNT, Session, RefTok),
                    worker_loop(WorkerId, Iter + 1, Acc)
            end
    end.

%% Await all workers via their monitors, summing committed totals. Fails the test
%% if any worker crashes (DOWN with non-normal reason) — no leaked processes.
await_workers([], Acc) ->
    Acc;
await_workers(Pids, Acc) ->
    receive
        {worker_done, Pid, Committed} ->
            await_workers(lists:delete(Pid, Pids), Acc + Committed);
        {'DOWN', _Ref, process, Pid, normal} ->
            await_workers(lists:delete(Pid, Pids), Acc);
        {'DOWN', _Ref, process, Pid, Reason} ->
            ct:fail("worker ~p crashed: ~p", [Pid, Reason])
    after 60_000 ->
        ct:fail("timed out waiting for workers; still pending: ~p", [Pids])
    end.

%% Sum <<"used">> over every CDR belonging to a1's sessions. Each worker/iter
%% owns a distinct session id; we list CDRs per session and sum.
sum_committed_from_cdrs() ->
    Sessions = [session_id(W, I)
                || W <- lists:seq(1, ?N_WORKERS), I <- lists:seq(1, ?M_ITERS)],
    lists:foldl(
      fun(Session, Acc) ->
          {ok, Cdrs} = chf_data:cdr_list(Session),
          Acc + lists:sum([maps:get(<<"used">>, C) || C <- Cdrs])
      end, 0, Sessions).

%%--------------------------------------------------------------------
%% Case 2 — reserve_never_negative_under_oversubscription.
%%
%% Seed a small total (10_000). Spawn 40 workers each trying to reserve a
%% 1000-unit chunk once, concurrently — total demand (40_000) >> available.
%% Each successful reserve HOLDS (no commit/refund) so they accumulate.
%% Assert: available >= 0 AND Σ(successful reserves) <= budget. The number of
%% successful reserves is bounded by the budget (10_000 / 1000 = 10) — CAS +
%% the insufficient_balance abort are the only guards.
%%--------------------------------------------------------------------

reserve_never_negative_under_oversubscription(_) ->
    {ok, _} = chf_data:balance_topup_or_set(?OS_ACCOUNT, ?OS_TOTAL),

    Parent = self(),
    Pids = [spawn_os_worker(Parent, W) || W <- lists:seq(1, ?OS_WORKERS)],
    Successes = await_os_workers(Pids, 0),

    {ok, B} = chf_data:balance_get(?OS_ACCOUNT),

    %% available never negative.
    ?assert(chf_balance:available(B) >= 0),

    %% The aggregate reserved never exceeds the budget.
    ReservedTotal = chf_balance:reserved_total(B),
    ?assert(ReservedTotal =< ?OS_TOTAL),

    %% Σ(successful-reserve amounts) == aggregate held == Successes × chunk, and
    %% that must fit within the budget. With a 1000-unit chunk and a 10_000
    %% budget the ceiling is exactly 10 successful reserves.
    ?assertEqual(Successes * ?OS_CHUNK, ReservedTotal),
    ?assert(Successes * ?OS_CHUNK =< ?OS_TOTAL),
    ?assert(Successes =< ?OS_TOTAL div ?OS_CHUNK),

    ct:pal("oversubscription: ~p/~p workers reserved ~p each; aggregate held ~p "
           "of budget ~p; available ~p.",
           [Successes, ?OS_WORKERS, ?OS_CHUNK, ReservedTotal, ?OS_TOTAL,
            chf_balance:available(B)]),
    ok.

spawn_os_worker(Parent, WorkerId) ->
    {Pid, _Ref} =
        spawn_monitor(
          fun() ->
              Session = session_id(WorkerId, 0),
              Tok     = token(WorkerId, 0, <<"os">>),
              R = chf_data:balance_reserve(?OS_ACCOUNT, Session, <<"rg1">>,
                                           ?OS_CHUNK, Tok),
              Ok = case R of
                       ok                            -> 1;
                       {error, insufficient_balance} -> 0
                   end,
              Parent ! {os_done, self(), Ok}
          end),
    Pid.

await_os_workers([], Acc) ->
    Acc;
await_os_workers(Pids, Acc) ->
    receive
        {os_done, Pid, Ok} ->
            await_os_workers(lists:delete(Pid, Pids), Acc + Ok);
        {'DOWN', _Ref, process, Pid, normal} ->
            await_os_workers(lists:delete(Pid, Pids), Acc);
        {'DOWN', _Ref, process, Pid, Reason} ->
            ct:fail("oversubscription worker ~p crashed: ~p", [Pid, Reason])
    after 60_000 ->
        ct:fail("timed out waiting for oversubscription workers: ~p", [Pids])
    end.

%%--------------------------------------------------------------------
%% Case 3 — contention_is_real.
%%
%% Evidence that single-account concurrency genuinely forces version_conflict
%% retries in chf_db:update/3. We drive the same thundering herd through
%% update/3 directly with a Fun that increments an ETS counter on EVERY
%% invocation. Because update/3 re-invokes the Fun once per CAS attempt,
%% total invocations > number of operations exactly when retries happened.
%% This is a test-only probe of the real facade retry path — no production
%% code is touched.
%%--------------------------------------------------------------------

contention_is_real(_) ->
    ets:new(?PROBE_TAB, [named_table, public, set]),
    ets:insert(?PROBE_TAB, {invocations, 0}),

    Account = <<"probe">>,
    {ok, _} = chf_data:balance_topup_or_set(Account, ?SEED_TOTAL),

    NWorkers = ?N_WORKERS,
    Ops = ?M_ITERS,
    Parent = self(),
    Pids = [spawn_probe_worker(Parent, Account, Ops)
            || _W <- lists:seq(1, NWorkers)],
    ok = await_probe_workers(Pids),

    [{invocations, Invocations}] = ets:lookup(?PROBE_TAB, invocations),
    ets:delete(?PROBE_TAB),

    TotalOps = NWorkers * Ops,
    Retries = Invocations - TotalOps,
    ct:pal("contention_is_real: ~p ops over one account caused ~p Fun "
           "invocations => ~p version_conflict retries.",
           [TotalOps, Invocations, Retries]),

    %% Every successful update invokes the Fun at least once; a retry invokes it
    %% again. More invocations than operations proves real CAS contention.
    ?assert(Invocations > TotalOps),
    ?assert(Retries > 0),
    ok.

spawn_probe_worker(Parent, Account, Ops) ->
    {Pid, _Ref} =
        spawn_monitor(
          fun() ->
              probe_loop(Account, Ops),
              Parent ! {probe_done, self()}
          end),
    Pid.

probe_loop(_Account, 0) ->
    ok;
probe_loop(Account, N) ->
    %% A trivial no-op update: bump the counter each time the Fun runs (i.e. each
    %% CAS attempt) and touch a field so the write is non-degenerate.
    Fun = fun(Doc) ->
              ets:update_counter(?PROBE_TAB, invocations, 1),
              Bump = maps:get(<<"total">>, Doc, 0),
              {ok, Doc#{<<"total">> => Bump}}
          end,
    {ok, _Doc, _V} = chf_db:update(?BALANCE_COLL, Account, Fun),
    probe_loop(Account, N - 1).

await_probe_workers([]) ->
    ok;
await_probe_workers(Pids) ->
    receive
        {probe_done, Pid} ->
            await_probe_workers(lists:delete(Pid, Pids));
        {'DOWN', _Ref, process, Pid, normal} ->
            await_probe_workers(lists:delete(Pid, Pids));
        {'DOWN', _Ref, process, Pid, Reason} ->
            ct:fail("probe worker ~p crashed: ~p", [Pid, Reason])
    after 60_000 ->
        ct:fail("timed out waiting for probe workers: ~p", [Pids])
    end.

%%--------------------------------------------------------------------
%% Id / token helpers — guarantee uniqueness per {WorkerId, Iter, Kind}.
%%--------------------------------------------------------------------

session_id(WorkerId, Iter) ->
    iolist_to_binary(["sess-", integer_to_binary(WorkerId), "-",
                      integer_to_binary(Iter)]).

cdr_id(WorkerId, Iter) ->
    iolist_to_binary(["cdr-", integer_to_binary(WorkerId), "-",
                      integer_to_binary(Iter)]).

token(WorkerId, Iter, Kind) ->
    iolist_to_binary(["tok-", Kind, "-", integer_to_binary(WorkerId), "-",
                      integer_to_binary(Iter)]).

%%--------------------------------------------------------------------
%% Mnesia lifecycle helpers.
%%--------------------------------------------------------------------

setup_mnesia_ram() ->
    application:stop(mnesia),
    ok = mnesia:delete_schema([node()]),
    ok = application:start(mnesia).

teardown_mnesia() ->
    application:stop(mnesia),
    mnesia:delete_schema([node()]),
    ok.
