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
     cdr_write_and_list].

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
%% Internal helpers
%%--------------------------------------------------------------------

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
