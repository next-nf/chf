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
     balance_get_missing].

%%--------------------------------------------------------------------
%% Suite init/end
%%--------------------------------------------------------------------

init_per_suite(Config) ->
    %% Wire the Mongo backend config
    application:set_env(chf_db, backend, chf_db_mongo),
    application:set_env(chf_db, mongo, #{
        host      => "127.0.0.1",
        port      => 27017,
        replset   => <<"rs0">>,
        database  => <<"chf_test">>,
        pool_size => 5
    }),
    %% Ensure the mongodb application and its deps are running
    {ok, _} = application:ensure_all_started(mongodb),
    %% Attempt to init the backend — skip only on genuine failure
    case catch chf_db_mongo:init(#{}) of
        ok ->
            Config;
        Err ->
            ct:pal("chf_db_mongo:init/1 failed: ~p — skipping suite", [Err]),
            {skip, no_mongo}
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
%% Internal helpers
%%--------------------------------------------------------------------

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
