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

%% chf_db_mongo.erl — MongoDB backend skeleton for chf_db.
%%
%% Phase-1 foundation: connection bring-up, index creation, and persistent_term
%% storage of the topology handle. Codec and full callback implementations are
%% delivered in subsequent tasks.
%%
%% NOTE: -behaviour(chf_db_backend) is intentionally NOT declared here.
%% Adding it now would trigger "behaviour callback missing" warnings for the 23
%% unimplemented callbacks, which would fail the build under warnings_as_errors.
%% The attribute will be added in the task that delivers the final callback
%% (once all 23 stubs + the two implemented here are complete).
%%
%% Supervision note: mongoc:connect/3 uses mc_topology:start_link internally,
%% which links the topology gen_server to the calling process. If the caller
%% exits, the topology dies too. To prevent this, init/1 spawns a dedicated
%% keeper process (chf_db_mongo_keeper) that owns the link. The keeper is a
%% simple receive-loop process registered under {chf_db_mongo, keeper}. It
%% traps exits so that a topology crash does not kill the keeper; instead the
%% keeper can report or restart.
%%
%% In production the keeper is started by chf_db_mongo:init/1 which is called
%% from chf_db_app:start/2 (the application master process, which is long-lived).
%% The keeper process then becomes the parent of the topology. Both survive for
%% the life of the chf_db application.
-module(chf_db_mongo).

-include_lib("chf_db/include/chf_db.hrl").

-export([
    init/1,
    topology/0
]).

%% internal export — keeper loop (called via spawn, not direct)
-export([keeper_loop/0]).

%%====================================================================
%% Public API
%%====================================================================

%% init/1 — Connect to the MongoDB replica set, store the topology in
%% persistent_term, and ensure all required indexes exist.
%%
%% Reads configuration from the {chf_db, mongo, Cfg} application env.
%% Defaults: host "127.0.0.1", port 27017, replset <<"rs0">>,
%%           database <<"chf">>, pool_size 5.
-spec init(map()) -> ok | {error, term()}.
init(_Opts) ->
    Cfg      = application:get_env(chf_db, mongo, #{}),
    Host     = maps:get(host,      Cfg, "127.0.0.1"),
    Port     = maps:get(port,      Cfg, 27017),
    ReplSet  = maps:get(replset,   Cfg, <<"rs0">>),
    Database = maps:get(database,  Cfg, <<"chf">>),
    PoolSize = maps:get(pool_size, Cfg, 5),

    HostStr = Host ++ ":" ++ integer_to_list(Port),

    %% If a topology is already registered (e.g. re-init in the same node),
    %% reuse it rather than spawning a second supervisor under the same name.
    case whereis(chf_db_mongo_pool) of
        Existing when is_pid(Existing), node(Existing) =:= node() ->
            case is_process_alive(Existing) of
                true ->
                    persistent_term:put({chf_db_mongo, topology}, Existing),
                    ensure_indexes(Existing);
                false ->
                    do_connect(ReplSet, HostStr, PoolSize, Database)
            end;
        _ ->
            do_connect(ReplSet, HostStr, PoolSize, Database)
    end.

%% topology/0 — Return the stored topology handle (pid or registered name).
-spec topology() -> pid() | atom().
topology() ->
    persistent_term:get({chf_db_mongo, topology}).

%%====================================================================
%% Internal: keeper process
%%====================================================================

%% keeper_loop/0 — A long-lived process that owns the link to the mc_topology
%% gen_server. By trapping exits the keeper survives individual topology crashes
%% (they will be restarted by a future supervisor integration). The keeper is
%% spawned once per node and stays alive for the lifetime of the chf_db app.
keeper_loop() ->
    process_flag(trap_exit, true),
    receive
        {'EXIT', _Pid, _Reason} ->
            %% Topology died. Stay alive; a future restart mechanism or
            %% application stop will handle cleanup.
            keeper_loop();
        stop ->
            ok;
        _ ->
            keeper_loop()
    end.

%% do_connect/4 — Spawn keeper, connect from keeper context, store topology.
-spec do_connect(binary(), string(), pos_integer(), binary()) -> ok | {error, term()}.
do_connect(ReplSet, HostStr, PoolSize, Database) ->
    %% Spawn the keeper process so that mc_topology:start_link's link is owned
    %% by the keeper, not by the init/1 caller (which may be short-lived in CT).
    Caller = self(),
    Keeper = spawn(fun() ->
        %% Register so we can find it on re-init
        catch register(chf_db_mongo_keeper, self()),
        process_flag(trap_exit, true),
        ConnResult = mongoc:connect(
            {rs, ReplSet, [HostStr]},
            [{name, chf_db_mongo_pool}, {register, chf_db_mongo_pool}, {pool_size, PoolSize}],
            [{database, Database}]
        ),
        Caller ! {connect_result, self(), ConnResult},
        keeper_loop()
    end),
    receive
        {connect_result, Keeper, {ok, Topology}} ->
            persistent_term:put({chf_db_mongo, topology}, Topology),
            ensure_indexes(Topology);
        {connect_result, Keeper, {error, Reason}} ->
            exit(Keeper, shutdown),
            {error, Reason}
    after 30000 ->
        exit(Keeper, shutdown),
        {error, connect_timeout}
    end.

%%====================================================================
%% Internal: index management
%%====================================================================

%% ensure_indexes/1 — Create required indexes on all collections.
%% MongoDB ignores createIndexes for indexes that already exist (idempotent).
-spec ensure_indexes(pid() | atom()) -> ok | {error, term()}.
ensure_indexes(Topology) ->
    case create_index(Topology, <<"subscribers">>,
                      #{<<"msisdn">> => 1}, #{<<"unique">> => true}) of
        ok ->
            case create_index(Topology, <<"cdrs">>,
                              #{<<"session_id">> => 1}, #{}) of
                ok ->
                    create_index(Topology, <<"charging_sessions">>,
                                 #{<<"state">> => 1}, #{});
                {error, _} = Err ->
                    Err
            end;
        {error, _} = Err ->
            Err
    end.

%% create_index/4 — Issue a createIndexes command for a single index.
-spec create_index(pid() | atom(), binary(), map(), map()) -> ok | {error, term()}.
create_index(Topology, Collection, KeySpec, ExtraOpts) ->
    IndexDoc = maps:merge(#{<<"key">> => KeySpec, <<"name">> => index_name(KeySpec)},
                          ExtraOpts),
    Cmd = #{
        <<"createIndexes">> => Collection,
        <<"indexes">>       => [IndexDoc]
    },
    case mongoc:transaction(Topology, fun(#{pool := W}) ->
        mc_worker_api:command(W, Cmd)
    end, #{}) of
        {true, _} ->
            ok;
        {false, Reply} ->
            {error, Reply}
    end.

%% index_name/1 — Derive a canonical index name from its key spec map,
%% e.g. #{<<"msisdn">> => 1} -> <<"msisdn_1">>.
-spec index_name(map()) -> binary().
index_name(KeySpec) ->
    Parts = lists:sort(maps:to_list(KeySpec)),
    iolist_to_binary(
        lists:join(<<"_">>, [[K, <<"_">>, integer_to_binary(D)] || {K, D} <- Parts])
    ).
