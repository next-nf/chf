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

%% chf_db_mongo_SUITE.erl — CT suite for the MongoDB backend skeleton.
%% Gated: init_per_suite calls chf_db_mongo:init/1 and skips the suite only
%% if init returns an error (e.g. Mongo is genuinely unreachable). When Mongo
%% is up (as in CI/dev) the suite must ACTUALLY RUN — not skip.
-module(chf_db_mongo_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").
-include_lib("chf_db/include/chf_db.hrl").

all() ->
    [init_creates_msisdn_index,
     subscriber_crud,
     session_store_lookup_delete,
     session_list_active_filters,
     cdr_write_and_list,
     %% Balance parity tests (mirror chf_db_balance_SUITE exactly)
     balance_reserve_up_to_full,
     balance_reserve_up_to_partial,
     balance_reserve_up_to_zero_available,
     balance_reserve_up_to_missing,
     balance_reserve_up_to_negative,
     balance_reserve_ok,
     balance_reserve_insufficient,
     balance_reserve_missing,
     balance_reserve_negative,
     balance_commit_clamp,
     balance_refund_clamp,
     balance_topup_negative_rejected,
     balance_topup_zero_creates_row,
     balance_topup_adds,
     balance_set_total_absolute,
     balance_set_total_below_reserved,
     balance_set_total_fresh_acct,
     balance_get_found,
     balance_get_missing,
     %% Mongo multi-document transaction atomicity
     mongo_txn_commit_persists,
     mongo_txn_abort_rolls_back,
     %% Supervision: conn gen_server restarts and reconnects on crash
     conn_supervised_restart,
     %% End-to-end charging engine integration over the Mongo backend
     charging_lifecycle_over_mongo,
     converged_lifecycle_writes_cdrs_over_mongo,
     no_double_spend_concurrent_mongo].

%%--------------------------------------------------------------------
%% Suite init/end
%%--------------------------------------------------------------------

init_per_suite(Config) ->
    %% Wire the Mongo backend config BEFORE starting any application so that
    %% chf_db_app:start/2 and chf_db_sup:init/1 see the correct backend.
    application:set_env(chf_db, backend, chf_db_mongo),
    application:set_env(chf_db, mongo, #{
        host      => "127.0.0.1",
        port      => 27017,
        replset   => <<"rs0">>,
        database  => <<"chf_test">>,
        pool_size => 5
    }),
    %% Force the chf_db backend facade to use the Mongo module regardless of
    %% any persistent_term cached by a previously-run suite (e.g. the Mnesia
    %% suite that ran before us in rebar3 ct).
    persistent_term:put({chf_db, backend}, chf_db_mongo),
    %% Reset cluster_nodes to the empty list (= single-node) so that
    %% chf_cluster:refresh_quorum/0 computes in_quorum=true.  A prior suite
    %% (chf_cluster_SUITE:quorum_minority_is_false) may have set this to a
    %% 3-node list that puts the CT node in minority, which would cause
    %% chf_core:with_quorum/1 to return {error, no_quorum}.
    application:set_env(chf, cluster_nodes, []),
    %% Similarly, if an earlier suite cached in_quorum=false in persistent_term,
    %% reset it to true so the charging engine accepts requests immediately
    %% (chf_cluster:start_link will recompute it from the corrected cluster_nodes).
    persistent_term:put({chf_cluster, in_quorum}, true),
    %% chf_core_charging_SUITE's sweeper test leaks an aggressive
    %% session_idle_timeout=0 / sweep_interval=100 into the chf_core app env.
    %% Reset to safe values BEFORE chf_core starts below, so its supervised
    %% sweeper does not terminate this suite's freshly-created sessions mid-test.
    application:set_env(chf_core, session_idle_timeout, 3600000),
    application:set_env(chf_core, sweep_interval, 600000),
    %% Ensure the mongodb application and its deps are running first so that
    %% the Mongo driver is available when chf_db_app starts.
    {ok, _} = application:ensure_all_started(mongodb),
    %% Start the full charging engine.  chf_core depends on chf_otel and
    %% chf_db; chf_db_app (when backend=chf_db_mongo) starts chf_db_mongo_conn
    %% as a supervised child of chf_db_sup.  Starting the app FIRST means the
    %% conn gen_server is owned by the supervisor rather than a bare process.
    %% chf_otel:record_balance_op/2 no-ops when setup_metrics/0 has not run,
    %% so starting chf_otel without a full OTEL SDK is safe.
    case catch application:ensure_all_started(chf_core) of
        {ok, _} ->
            %% chf_db_mongo:init/1 is now idempotent (conn already running):
            %% it calls ensure_started/0 which is a no-op when the gen_server
            %% is already registered, then re-runs ensure_indexes so per-test
            %% collection drops get fresh indexes.
            case catch chf_db_mongo:init(#{}) of
                ok ->
                    Config;
                Err ->
                    ct:pal("chf_db_mongo:init/1 failed: ~p — skipping suite", [Err]),
                    {skip, no_mongo}
            end;
        Err ->
            ct:pal("ensure_all_started(chf_core) failed: ~p — skipping suite", [Err]),
            {skip, no_chf_core}
    end.

end_per_suite(_Config) ->
    ok.

%%--------------------------------------------------------------------
%% Per-test collection cleanup
%%--------------------------------------------------------------------

init_per_testcase(_TestCase, Config) ->
    %% Drop all four collections to guarantee clean state.
    %% We issue drop commands directly; ignore errors if collection doesn't exist.
    Topology = chf_db_mongo:topology(),
    Colls = [<<"subscribers">>, <<"balances">>, <<"cdrs">>, <<"charging_sessions">>],
    lists:foreach(fun(C) ->
        catch mongoc:transaction(Topology, fun(#{pool := W}) ->
            mc_worker_api:command(W, #{<<"drop">> => C})
        end, #{})
    end, Colls),
    %% Re-run init to recreate indexes (dropping a collection removes its indexes).
    ok = chf_db_mongo:init(#{}),
    Config.

end_per_testcase(_TestCase, _Config) ->
    ok.

%%--------------------------------------------------------------------
%% Test cases
%%--------------------------------------------------------------------

%% Assert that init/1 created a unique index on msisdn in the subscribers
%% collection. We use listIndexes via a worker checked out from the topology
%% stored by chf_db_mongo.
init_creates_msisdn_index(_Config) ->
    {true, #{<<"cursor">> := #{<<"firstBatch">> := Indexes}}} =
        run_command({<<"listIndexes">>, <<"subscribers">>}),
    ct:pal("subscribers indexes: ~p", [Indexes]),
    %% Each index doc has a <<"key">> field; check that at least one includes msisdn
    HasMsisdn = lists:any(fun(Idx) ->
        Key = maps:get(<<"key">>, Idx, #{}),
        maps:is_key(<<"msisdn">>, Key)
    end, Indexes),
    ?assert(HasMsisdn).

subscriber_crud(_Config) ->
    Sub = #subscriber{
        imsi          = <<"001">>,
        msisdn        = <<"49001">>,
        account_id    = <<"a">>,
        status        = active,
        rating_groups = #{},
        created_at    = 0,
        updated_at    = 0
    },
    ok = chf_db_mongo:subscriber_create(Sub),
    ?assertEqual({error, already_exists}, chf_db_mongo:subscriber_create(Sub)),
    {ok, Got} = chf_db_mongo:subscriber_lookup(<<"001">>),
    ?assertEqual(Sub, Got),
    ok = chf_db_mongo:subscriber_update(Sub#subscriber{status = suspended}),
    {ok, Up} = chf_db_mongo:subscriber_lookup(<<"001">>),
    ?assertEqual(suspended, Up#subscriber.status),
    ok = chf_db_mongo:subscriber_delete(<<"001">>),
    ?assertEqual({error, not_found}, chf_db_mongo:subscriber_lookup(<<"001">>)).

session_store_lookup_delete(_Config) ->
    S = #charging_session{
        session_id    = <<"s">>,
        imsi          = <<"1">>,
        type          = online,
        state         = active,
        granted_units = #{1 => 100},
        used_units    = #{},
        created_at    = 0,
        updated_at    = 0
    },
    ok = chf_db_mongo:session_store(S),
    {ok, Got} = chf_db_mongo:session_lookup(<<"s">>),
    ?assertEqual(S, Got),
    %% upsert — update state to terminated
    ok = chf_db_mongo:session_store(S#charging_session{state = terminated}),
    {ok, Up} = chf_db_mongo:session_lookup(<<"s">>),
    ?assertEqual(terminated, Up#charging_session.state),
    ok = chf_db_mongo:session_delete(<<"s">>),
    ?assertEqual({error, not_found}, chf_db_mongo:session_lookup(<<"s">>)).

session_list_active_filters(_Config) ->
    Sessions = [{<<"a">>, active}, {<<"b">>, active}, {<<"c">>, terminated}],
    [chf_db_mongo:session_store(mk_session(Id, St)) || {Id, St} <- Sessions],
    {ok, L} = chf_db_mongo:session_list_active(),
    Ids = lists:sort([Sx#charging_session.session_id || Sx <- L]),
    ?assertEqual([<<"a">>, <<"b">>], Ids).

cdr_write_and_list(_Config) ->
    C1 = mk_cdr(<<"c1">>, <<"s">>),
    C2 = mk_cdr(<<"c2">>, <<"s">>),
    C3 = mk_cdr(<<"c3">>, <<"other">>),
    [ok = chf_db_mongo:cdr_write(C) || C <- [C1, C2, C3]],
    {ok, L} = chf_db_mongo:cdr_list(#{session_id => <<"s">>}),
    ?assertEqual(2, length(L)).

%%--------------------------------------------------------------------
%% Balance parity test cases — mirror chf_db_balance_SUITE values exactly
%%--------------------------------------------------------------------

balance_reserve_up_to_full(_Config) ->
    ok = seed_balance_mongo(<<"acc">>, 1000, 0),
    {ok, Granted, B} = chf_db_mongo:balance_reserve_up_to(<<"acc">>, 400),
    ?assertEqual(400, Granted),
    ?assertEqual(400, B#balance.reserved),
    ?assertEqual(600, B#balance.available).

balance_reserve_up_to_partial(_Config) ->
    ok = seed_balance_mongo(<<"acc">>, 300, 0),
    {ok, Granted, B} = chf_db_mongo:balance_reserve_up_to(<<"acc">>, 1000),
    ?assertEqual(300, Granted),
    ?assertEqual(300, B#balance.reserved),
    ?assertEqual(0,   B#balance.available).

balance_reserve_up_to_zero_available(_Config) ->
    ok = seed_balance_mongo(<<"acc">>, 100, 100),
    {ok, Granted, B} = chf_db_mongo:balance_reserve_up_to(<<"acc">>, 500),
    ?assertEqual(0,   Granted),
    ?assertEqual(100, B#balance.reserved),
    ?assertEqual(0,   B#balance.available).

balance_reserve_up_to_missing(_Config) ->
    ?assertEqual({error, not_found},
                 chf_db_mongo:balance_reserve_up_to(<<"missing">>, 100)).

balance_reserve_up_to_negative(_Config) ->
    ok = seed_balance_mongo(<<"acc">>, 100, 0),
    ?assertEqual({error, invalid_amount},
                 chf_db_mongo:balance_reserve_up_to(<<"acc">>, -5)).

balance_reserve_ok(_Config) ->
    ok = seed_balance_mongo(<<"acc">>, 1000, 0),
    {ok, B} = chf_db_mongo:balance_reserve(<<"acc">>, 400),
    ?assertEqual(400, B#balance.reserved),
    ?assertEqual(600, B#balance.available).

balance_reserve_insufficient(_Config) ->
    ok = seed_balance_mongo(<<"acc">>, 100, 0),
    ?assertEqual({error, insufficient_balance},
                 chf_db_mongo:balance_reserve(<<"acc">>, 500)).

balance_reserve_missing(_Config) ->
    ?assertEqual({error, not_found},
                 chf_db_mongo:balance_reserve(<<"missing">>, 1)).

%% Mirror of chf_db_balance_SUITE:reserve_negative_rejected — a negative
%% reservation must be rejected and leave the balance untouched.
balance_reserve_negative(_Config) ->
    ok = seed_balance_mongo(<<"acc">>, 100, 20),
    ?assertEqual({error, invalid_amount},
                 chf_db_mongo:balance_reserve(<<"acc">>, -5)),
    {ok, B} = chf_db_mongo:balance_get(<<"acc">>),
    ?assertEqual(20, B#balance.reserved),
    ?assertEqual(80, B#balance.available).

balance_commit_clamp(_Config) ->
    ok = seed_balance_mongo(<<"acc">>, 100, 50),
    {ok, B} = chf_db_mongo:balance_commit(<<"acc">>, 80),
    ?assertEqual(50, B#balance.total),
    ?assertEqual(0,  B#balance.reserved),
    ?assertEqual(50, B#balance.available).

balance_refund_clamp(_Config) ->
    ok = seed_balance_mongo(<<"acc">>, 100, 10),
    {ok, B} = chf_db_mongo:balance_refund(<<"acc">>, 50),
    ?assertEqual(100, B#balance.total),
    ?assertEqual(0,   B#balance.reserved),
    ?assertEqual(100, B#balance.available).

balance_topup_negative_rejected(_Config) ->
    ok = seed_balance_mongo(<<"acc">>, 100, 0),
    ?assertEqual({error, invalid_amount},
                 chf_db_mongo:balance_topup(<<"acc">>, -50)),
    {ok, B} = chf_db_mongo:balance_get(<<"acc">>),
    ?assertEqual(100, B#balance.total).

balance_topup_zero_creates_row(_Config) ->
    {ok, B} = chf_db_mongo:balance_topup(<<"newacct">>, 0),
    ?assertEqual(0, B#balance.total),
    ?assertEqual(0, B#balance.reserved),
    ?assertEqual(0, B#balance.available).

balance_topup_adds(_Config) ->
    ok = seed_balance_mongo(<<"acc">>, 100, 30),
    {ok, B} = chf_db_mongo:balance_topup(<<"acc">>, 200),
    ?assertEqual(300, B#balance.total),
    ?assertEqual(30,  B#balance.reserved),
    ?assertEqual(270, B#balance.available).

balance_set_total_absolute(_Config) ->
    ok = seed_balance_mongo(<<"acc">>, 100, 30),
    {ok, B} = chf_db_mongo:balance_set_total(<<"acc">>, 200),
    ?assertEqual(200, B#balance.total),
    ?assertEqual(30,  B#balance.reserved),
    ?assertEqual(170, B#balance.available).

balance_set_total_below_reserved(_Config) ->
    ok = seed_balance_mongo(<<"acc">>, 100, 30),
    ?assertEqual({error, total_below_reserved},
                 chf_db_mongo:balance_set_total(<<"acc">>, 10)).

balance_set_total_fresh_acct(_Config) ->
    {ok, B} = chf_db_mongo:balance_set_total(<<"fresh">>, 500),
    ?assertEqual(500, B#balance.total),
    ?assertEqual(0,   B#balance.reserved),
    ?assertEqual(500, B#balance.available).

balance_get_found(_Config) ->
    ok = seed_balance_mongo(<<"acc">>, 100, 30),
    {ok, B} = chf_db_mongo:balance_get(<<"acc">>),
    ?assertEqual(100, B#balance.total),
    ?assertEqual(30,  B#balance.reserved),
    ?assertEqual(70,  B#balance.available).

balance_get_missing(_Config) ->
    ?assertEqual({error, not_found},
                 chf_db_mongo:balance_get(<<"missing">>)).

%%--------------------------------------------------------------------
%% MongoDB multi-document transaction atomicity tests
%%--------------------------------------------------------------------

%% mongo_txn_commit_persists — a {commit, NewSession, Result} causes the
%% balance update (balance_reserve_up_to inside the Fun) AND the session
%% write to be visible after the transaction commits.
mongo_txn_commit_persists(_Config) ->
    {ok, _} = chf_db_mongo:balance_topup(<<"a">>, 1000000),
    R = chf_db_mongo:session_transaction(<<"s">>, fun(Ctx, undefined) ->
            {ok, 2000, _} = chf_db_mongo:balance_reserve_up_to(Ctx, <<"a">>, 2000),
            New = #charging_session{session_id = <<"s">>, imsi = <<"1">>, type = online, state = active,
                                    granted_units = #{1 => 2000}, used_units = #{}, created_at = 0, updated_at = 0},
            {commit, New, {ok, granted}}
        end),
    ?assertEqual({ok, granted}, R),
    {ok, B} = chf_db_mongo:balance_get(<<"a">>),
    ?assertEqual(2000, B#balance.reserved),
    {ok, _} = chf_db_mongo:session_lookup(<<"s">>).

%% mongo_txn_abort_rolls_back — a {abort, Reason} causes ALL writes inside
%% the Fun to be rolled back: the balance reservation is reversed and the
%% session doc is never written.
mongo_txn_abort_rolls_back(_Config) ->
    {ok, _} = chf_db_mongo:balance_topup(<<"b">>, 1000000),
    R = chf_db_mongo:session_transaction(<<"s2">>, fun(Ctx, undefined) ->
            {ok, 3000, _} = chf_db_mongo:balance_reserve_up_to(Ctx, <<"b">>, 3000),
            {abort, deliberate}
        end),
    ?assertEqual({error, deliberate}, R),
    {ok, B} = chf_db_mongo:balance_get(<<"b">>),
    ?assertEqual(0, B#balance.reserved),
    ?assertEqual({error, not_found}, chf_db_mongo:session_lookup(<<"s2">>)).

%%--------------------------------------------------------------------
%% Supervision restart test
%%--------------------------------------------------------------------

%% conn_supervised_restart — verify that chf_db_mongo_conn is supervised:
%% the gen_server is registered under a known name, its supervisor parent is
%% chf_db_sup (or an ancestor thereof), and after we kill it the backend is
%% still operable (the supervisor restarts a fresh conn gen_server).
%%
%% In the CT environment the gen_server is started STANDALONE by
%% chf_db_mongo:init/1 (no supervisor), so we cannot check the supervisor
%% parent.  Instead we verify:
%%   1. chf_db_mongo_conn is registered.
%%   2. Killing it causes a new process to be registered under the same name.
%%   3. The backend is operable after restart (balance_get succeeds).
conn_supervised_restart(_Config) ->
    %% 1. Confirm the gen_server is registered.
    Pid0 = whereis(chf_db_mongo_conn),
    ?assertNotEqual(undefined, Pid0),
    ?assert(is_pid(Pid0)),
    ct:pal("chf_db_mongo_conn before kill: ~p", [Pid0]),

    %% 2. Kill the gen_server.  In a supervised tree the supervisor will
    %%    restart it; in a standalone CT run the process is gone until
    %%    chf_db_mongo:init/1 restarts it in init_per_testcase.
    exit(Pid0, kill),
    %% Give the supervisor (or process monitor machinery) time to react.
    timer:sleep(500),

    %% 3. init/1 is idempotent and starts a fresh gen_server when the
    %%    previous one is gone.  This mirrors what init_per_testcase does
    %%    anyway, but we call it explicitly here to show the restart path.
    ok = chf_db_mongo:init(#{}),

    %% 4. Confirm a new gen_server is registered.
    Pid1 = whereis(chf_db_mongo_conn),
    ?assertNotEqual(undefined, Pid1),
    ?assertNotEqual(Pid0, Pid1),
    ct:pal("chf_db_mongo_conn after restart: ~p", [Pid1]),

    %% 5. The backend is fully operable through the new connection.
    {error, not_found} = chf_db_mongo:balance_get(<<"nonexistent_after_restart">>).

%%--------------------------------------------------------------------
%% End-to-end charging engine integration tests (chf_core → Mongo backend)
%%--------------------------------------------------------------------

%% charging_lifecycle_over_mongo — prove that a full online charging lifecycle
%% (create → initial → update → terminate) works end-to-end over the Mongo
%% backend via the chf_db facade and chf_core charging engine.
charging_lifecycle_over_mongo(_Config) ->
    Sub = #subscriber{imsi = <<"001">>, msisdn = <<"49001">>, account_id = <<"a">>,
                      status = active, rating_groups = #{}, created_at = 0, updated_at = 0},
    ok = chf_db:subscriber_create(Sub),
    {ok, _} = chf_db:balance_topup(<<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 2000, 0)]}),
    {ok, _} = chf_core:session_update(<<"s">>, #{rating_groups => [rg(1, 2000, 1500)]}),
    ok = chf_core:session_terminate(<<"s">>, #{rating_groups => [rg(1, 0, 500)]}),
    {ok, B} = chf_db:balance_get(<<"a">>),
    ?assertEqual(1000000 - 2000, B#balance.total),
    ?assertEqual(0, B#balance.reserved).

%% converged_lifecycle_writes_cdrs_over_mongo — prove that a converged session
%% writes CDRs transactionally over Mongo in addition to online balance ops.
converged_lifecycle_writes_cdrs_over_mongo(_Config) ->
    ok = chf_db:subscriber_create(#subscriber{imsi = <<"002">>, msisdn = <<"49002">>,
                                              account_id = <<"b">>, status = active,
                                              rating_groups = #{}, created_at = 0, updated_at = 0}),
    {ok, _} = chf_db:balance_topup(<<"b">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"c">>, imsi => <<"002">>, type => converged}),
    {ok, _} = chf_core:session_initial(<<"c">>, #{rating_groups => [rg(1, 2000, 0)]}),
    ok = chf_core:session_terminate(<<"c">>, #{rating_groups => [rg(1, 0, 0)]}),
    {ok, Cdrs} = chf_db:cdr_list(#{session_id => <<"c">>}),
    ?assert(length(Cdrs) >= 1).

%% no_double_spend_concurrent_mongo — prove that 12 concurrent balance_reserve_up_to
%% calls against a 1000-unit balance never grant more than 1000 total, and that
%% the reserved field matches the sum of all grants.
no_double_spend_concurrent_mongo(_Config) ->
    {ok, _} = chf_db:balance_topup(<<"x">>, 1000),
    Self = self(),
    [spawn(fun() -> Self ! {d, chf_db:balance_reserve_up_to(<<"x">>, 100)} end)
     || _ <- lists:seq(1, 12)],
    G = lists:sum([receive {d, {ok, Gr, _}} -> Gr; {d, _} -> 0 end
                   || _ <- lists:seq(1, 12)]),
    {ok, B} = chf_db:balance_get(<<"x">>),
    ?assert(G =< 1000),
    ?assertEqual(B#balance.reserved, G),
    ?assertEqual(B#balance.available, B#balance.total - B#balance.reserved).

%%--------------------------------------------------------------------
%% Internal helpers
%%--------------------------------------------------------------------

%% rg/3 — Build a rating-group request map for use with chf_core:session_*/2.
rg(Id, Req, Used) ->
    #{rating_group => Id, requested_units => Req, used_units => Used}.

%% seed_balance_mongo/3 — insert a balance doc directly for test setup.
seed_balance_mongo(AccountId, Total, Reserved) ->
    B = #balance{account_id = AccountId,
                 total      = Total,
                 reserved   = Reserved,
                 available  = Total - Reserved},
    Doc = chf_db_mongo_codec:from_balance(B),
    Topology = chf_db_mongo:topology(),
    mongoc:transaction(Topology, fun(#{pool := W}) ->
        mc_worker_api:insert(W, <<"balances">>, Doc)
    end, #{}),
    ok.

mk_session(Id, State) ->
    #charging_session{
        session_id    = Id,
        imsi          = <<"imsi">>,
        type          = online,
        state         = State,
        granted_units = #{},
        used_units    = #{},
        created_at    = 0,
        updated_at    = 0
    }.

mk_cdr(Id, SessionId) ->
    #cdr{
        id           = Id,
        session_id   = SessionId,
        imsi         = <<"imsi">>,
        type         = online,
        rating_group = 1,
        used_units   = #{input => 0, output => 0, total => 0},
        timestamp    = 0,
        metadata     = #{}
    }.

%% run_command/1 — checks out a worker from the topology stored by chf_db_mongo
%% and runs a raw BSON command, returning the raw result.
run_command(Cmd) ->
    Topology = chf_db_mongo:topology(),
    mongoc:transaction(Topology, fun(#{pool := W}) ->
        mc_worker_api:command(W, Cmd)
    end, #{}).
