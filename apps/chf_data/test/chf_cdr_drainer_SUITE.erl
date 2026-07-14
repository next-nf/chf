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

-module(chf_cdr_drainer_SUITE).
-moduledoc "Integration tests for `chf_cdr_drainer`. Exercises the four scenarios:\n"
           "(a) happy path — pending marker → drain_once/0 → CDR created, marker cleared;\n"
           "(b) exactly-once under crash injection — CDR already present, drain_once/0\n"
           "    handles {error, exists} as success and clears the marker, exactly 1 CDR;\n"
           "(c) no markers — drain_once/0 is a no-op;\n"
           "(d) zero-usage stub — used=0 marker is cleared but no CDR is emitted.".
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

all() ->
    [happy_path,
     exactly_once_under_crash,
     no_markers_noop,
     zero_usage_stub_cleared].

%%--------------------------------------------------------------------
%% Suite / testcase lifecycle
%%--------------------------------------------------------------------

init_per_suite(Config) ->
    ok = setup_mnesia_ram(),
    persistent_term:put({chf_db, backend}, chf_db_mnesia),
    application:set_env(chf_db, backend_opts, #{storage => ram_copies}),
    {ok, _Pid} = chf_db_mnesia:start_link(#{}),
    ok = chf_data:ensure_collections(),
    ok = chf_db_mnesia:wait_ready([subscriber, balance, charging_session, cdr]),
    %% Use start/0 (not start_link/0) so the CT init_per_suite process's normal
    %% exit does not propagate to the drainer via the OTP link. start_link would
    %% tie the drainer's lifetime to the CT init process; start/0 avoids that.
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
%% (a) Happy path: seed balance, commit (stamps pending marker), drain_once/0
%%     → CDR exists via cdr_list and pending_cdrs is now empty.
%%--------------------------------------------------------------------

happy_path(_) ->
    AccountId = <<"acc-happy">>,
    SessionId = <<"sess-happy">>,
    CdrId     = <<"cdr-happy-1">>,
    seed_balance(AccountId, 1000),
    ok = chf_data:balance_reserve(AccountId, SessionId, <<"rg1">>, 500, <<"r-h1">>),
    ok = chf_data:balance_commit(AccountId, SessionId, 400, CdrId, <<"c-h1">>),

    %% Confirm the marker is pending before drain.
    {ok, B0} = chf_data:balance_get(AccountId),
    Pending0 = maps:get(<<"pending_cdrs">>, B0),
    ?assertEqual(1, length(Pending0)),

    ok = chf_cdr_drainer:drain_once(),

    %% CDR must now exist for the session.
    {ok, Cdrs} = chf_data:cdr_list(SessionId),
    ?assertEqual(1, length(Cdrs)),
    [Cdr] = Cdrs,
    ?assertEqual(400, maps:get(<<"used">>, Cdr)),
    ?assertEqual(SessionId, maps:get(<<"session_id">>, Cdr)),

    %% pending_cdrs must be cleared.
    {ok, B1} = chf_data:balance_get(AccountId),
    ?assertEqual([], maps:get(<<"pending_cdrs">>, B1)).

%%--------------------------------------------------------------------
%% (b) Exactly-once under crash injection.
%%     Simulate a crash BETWEEN create(cdr) and the marker-clearing update:
%%     - manually stamp a pending_cdr marker on the balance
%%     - manually call chf_db:create(cdr, ...) to pre-create the CDR (crash point A)
%%     - leave pending_cdrs intact (crash killed the process before marker clear)
%%     Then run drain_once/0 — it must:
%%       - get {error, exists} on the second create (handled as success)
%%       - clear the marker
%%       - leave exactly ONE CDR (not two)
%%--------------------------------------------------------------------

exactly_once_under_crash(_) ->
    AccountId = <<"acc-eoc">>,
    SessionId = <<"sess-eoc">>,
    CdrId     = <<"cdr-eoc-1">>,
    seed_balance(AccountId, 1000),

    %% Stamp a pending_cdr marker directly (simulates a committed balance update
    %% where the drainer died after create(cdr) but before clearing the marker).
    Marker = #{<<"cdr_id">>       => CdrId,
               <<"session_id">>   => SessionId,
               <<"rating_group">> => <<"rg1">>,
               <<"used">>         => 300,
               <<"ts">>           => erlang:system_time(millisecond)},
    stamp_pending_cdr(AccountId, Marker),

    %% Simulate the drainer having already created the CDR (crash after create,
    %% before marker clear).
    CdrDoc = chf_cdr:to_doc(Marker),
    {ok, _V} = chf_db:create(cdr, CdrId, CdrDoc),

    %% Sanity: one CDR exists, marker still pending.
    {ok, CdrsBeforeDrain} = chf_data:cdr_list(SessionId),
    ?assertEqual(1, length(CdrsBeforeDrain)),
    {ok, B0} = chf_data:balance_get(AccountId),
    ?assertEqual(1, length(maps:get(<<"pending_cdrs">>, B0))),

    %% Now drain: must tolerate {error, exists}, clear marker, leave exactly 1 CDR.
    ok = chf_cdr_drainer:drain_once(),

    {ok, CdrsAfterDrain} = chf_data:cdr_list(SessionId),
    ?assertEqual(1, length(CdrsAfterDrain)),

    {ok, B1} = chf_data:balance_get(AccountId),
    ?assertEqual([], maps:get(<<"pending_cdrs">>, B1)).

%%--------------------------------------------------------------------
%% (c) No markers → drain_once/0 is a no-op (no crash, no CDRs).
%%--------------------------------------------------------------------

no_markers_noop(_) ->
    AccountId = <<"acc-noop">>,
    seed_balance(AccountId, 500),

    ok = chf_cdr_drainer:drain_once(),

    %% No CDRs should exist for any session.
    {ok, Cdrs} = chf_data:cdr_list(<<"any-session">>),
    ?assertEqual([], Cdrs),

    %% Balance untouched.
    {ok, B} = chf_data:balance_get(AccountId),
    ?assertEqual([], maps:get(<<"pending_cdrs">>, B)).

%%--------------------------------------------------------------------
%% (d) Zero-usage stub: a pending_cdr with used=0 is cleared but
%%     no CDR is emitted.
%%--------------------------------------------------------------------

zero_usage_stub_cleared(_) ->
    AccountId = <<"acc-zero">>,
    SessionId = <<"sess-zero">>,
    CdrId     = <<"cdr-zero-1">>,
    seed_balance(AccountId, 1000),

    %% Stamp a zero-usage marker (produced by a commit that clamped to 0,
    %% e.g. negative Used or no reservation held).
    Marker = #{<<"cdr_id">>       => CdrId,
               <<"session_id">>   => SessionId,
               <<"rating_group">> => <<>>,
               <<"used">>         => 0,
               <<"ts">>           => erlang:system_time(millisecond)},
    stamp_pending_cdr(AccountId, Marker),

    ok = chf_cdr_drainer:drain_once(),

    %% No CDR should have been created.
    {ok, Cdrs} = chf_data:cdr_list(SessionId),
    ?assertEqual([], Cdrs),

    %% Marker must be cleared (pending_cdrs empty).
    {ok, B} = chf_data:balance_get(AccountId),
    ?assertEqual([], maps:get(<<"pending_cdrs">>, B)).

%%--------------------------------------------------------------------
%% Helpers
%%--------------------------------------------------------------------

seed_balance(AccountId, Total) ->
    Doc = chf_balance:to_doc(#{<<"account_id">> => AccountId, <<"total">> => Total}),
    {ok, _V} = chf_db:put(balance, AccountId, Doc),
    ok.

%% Directly stamp a pending_cdr marker onto the balance document via a CAS update.
%% Used to set up crash-injection and zero-usage scenarios without going through
%% the full reserve/commit flow.
stamp_pending_cdr(AccountId, Marker) ->
    Fun = fun(Doc) ->
              Pending = maps:get(<<"pending_cdrs">>, Doc, []),
              {ok, Doc#{<<"pending_cdrs">> => Pending ++ [Marker]}}
          end,
    {ok, _Doc, _V} = chf_db:update(balance, AccountId, Fun),
    ok.

setup_mnesia_ram() ->
    application:stop(mnesia),
    ok = mnesia:delete_schema([node()]),
    ok = application:start(mnesia).

teardown_mnesia() ->
    application:stop(mnesia),
    mnesia:delete_schema([node()]),
    ok.
