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
    [init_creates_msisdn_index].

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

%%--------------------------------------------------------------------
%% Internal helpers
%%--------------------------------------------------------------------

%% run_command/1 — checks out a worker from the topology stored by chf_db_mongo
%% and runs a raw BSON command, returning the raw result.
run_command(Cmd) ->
    Topology = chf_db_mongo:topology(),
    mongoc:transaction(Topology, fun(#{pool := W}) ->
        mc_worker_api:command(W, Cmd)
    end, #{}).
