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

%% chf_db_mongo_conn.erl — Supervised MongoDB connection owner for the
%% chf_db_mongo backend.
%%
%% Design
%% ------
%% mongoc:connect/3 calls mc_topology:start_link internally, which links the
%% topology gen_server to the calling process.  When the caller exits, the
%% topology dies with it.  This gen_server is the long-lived owner of that
%% link: it calls mongoc:connect/3 in its init/1, stores the topology handle
%% in persistent_term (so all chf_db_mongo callers can retrieve it cheaply),
%% ensures the required indexes, and then loops forever trapping exits.
%%
%% If the topology gen_server crashes it sends an EXIT signal that this process
%% traps. handle_info/2 catches it and returns {stop, topology_down, State},
%% which causes the supervisor (chf_db_sup) to restart this gen_server, which
%% in turn calls mongoc:connect/3 again — re-establishing the connection.
%%
%% Supervisor placement
%% --------------------
%% chf_db_sup adds this gen_server as a permanent child ONLY when the
%% configured backend is chf_db_mongo.  For the Mnesia backend the child list
%% is unchanged, so no Mongo connection is ever opened.
%%
%% Standalone use (CT tests)
%% -------------------------
%% chf_db_mongo:init/1 calls chf_db_mongo_conn:ensure_started/0, which starts
%% this gen_server via start_link/0 if it is not already registered.  In a
%% supervised production node the gen_server is already alive (started by the
%% sup), so ensure_started/0 is a cheap no-op.  When called from
%% init_per_testcase (which drops and recreates collections), ensure_started/0
%% additionally issues a synchronous ensure_indexes call so the test gets fresh
%% indexes on each test case.

-module(chf_db_mongo_conn).
-behaviour(gen_server).

-export([start_link/0, start/0, ensure_started/0, ensure_indexes/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2]).

-define(SERVER, ?MODULE).

%%====================================================================
%% Public API
%%====================================================================

%% start_link/0 — Start and link the connection gen_server.
%% Called by chf_db_sup when adding it as a supervised child.
-spec start_link() -> {ok, pid()} | {error, term()}.
start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%% start/0 — Start the connection gen_server WITHOUT a link.
%% Used by ensure_started/0 in standalone (test) mode so the gen_server
%% survives independently of the calling process.
-spec start() -> {ok, pid()} | {error, term()}.
start() ->
    gen_server:start({local, ?SERVER}, ?MODULE, [], []).

%% ensure_started/0 — Idempotent: start the gen_server if not running,
%% then trigger an ensure_indexes call to (re-)create any missing indexes.
%% Used by chf_db_mongo:init/1 for both first-time startup (tests) and
%% per-test-case index refresh.
%%
%% Uses start/0 (no link) in standalone mode so the gen_server persists
%% across test cases even when the init_per_suite process exits.
-spec ensure_started() -> ok | {error, term()}.
ensure_started() ->
    case whereis(?SERVER) of
        undefined ->
            case start() of
                {ok, _Pid}                       -> ok;
                {error, {already_started, _Pid}} -> ok;
                {error, Reason}                  -> {error, Reason}
            end;
        _Pid ->
            %% Already running (supervised or from a prior init call).
            %% Re-run ensure_indexes so per-test-case collection drops get
            %% their indexes recreated.
            ensure_indexes()
    end.

%% ensure_indexes/0 — Synchronous call: (re-)create all required indexes.
%% Idempotent per MongoDB semantics (existing indexes are silently ignored).
-spec ensure_indexes() -> ok | {error, term()}.
ensure_indexes() ->
    gen_server:call(?SERVER, ensure_indexes, 30000).

%%====================================================================
%% gen_server callbacks
%%====================================================================

init([]) ->
    %% Trap exits so a topology crash sends us an EXIT message rather than
    %% killing this process.  handle_info catches it and returns {stop,...}
    %% so the supervisor restarts us (and we reconnect).
    process_flag(trap_exit, true),
    case do_connect() of
        {ok, Topology} ->
            persistent_term:put({chf_db_mongo, topology}, Topology),
            case chf_db_mongo:ensure_indexes(Topology) of
                ok ->
                    {ok, #{topology => Topology}};
                {error, Reason} ->
                    %% Clean up before failing so the registered name and
                    %% topology handle don't leak.
                    persistent_term:erase({chf_db_mongo, topology}),
                    catch mongoc:disconnect(Topology),
                    {stop, {ensure_indexes_failed, Reason}}
            end;
        {error, Reason} ->
            {stop, {connect_failed, Reason}}
    end.

handle_call(ensure_indexes, _From, #{topology := Topology} = State) ->
    Result = chf_db_mongo:ensure_indexes(Topology),
    {reply, Result, State};
handle_call(_Req, _From, State) ->
    {reply, {error, unknown_call}, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info({'EXIT', Pid, Reason}, #{topology := Topology} = State) when Pid =:= Topology ->
    %% The topology gen_server crashed.  Erase the stale handle from
    %% persistent_term and tell the supervisor to restart us (which
    %% reconnects in init/1).
    persistent_term:erase({chf_db_mongo, topology}),
    {stop, {topology_down, Reason}, State};
handle_info({'EXIT', _Pid, _Reason}, State) ->
    %% EXIT from a pool worker or other linked process — ignore.
    {noreply, State};
handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    %% persistent_term entry is already erased on topology crash; if we are
    %% stopping cleanly (supervisor shutdown) also erase it so a fresh
    %% gen_server starts with a clean slate.
    persistent_term:erase({chf_db_mongo, topology}),
    ok.

%%====================================================================
%% Internal
%%====================================================================

-spec do_connect() -> {ok, pid()} | {error, term()}.
do_connect() ->
    Cfg      = application:get_env(chf_db, mongo, #{}),
    Host     = maps:get(host,      Cfg, "127.0.0.1"),
    Port     = maps:get(port,      Cfg, 27017),
    ReplSet  = maps:get(replset,   Cfg, <<"rs0">>),
    Database = maps:get(database,  Cfg, <<"chf">>),
    PoolSize = maps:get(pool_size, Cfg, 5),
    HostStr  = Host ++ ":" ++ integer_to_list(Port),
    %% Wait for any previous topology pool process to exit and release the
    %% chf_db_mongo_pool name before we try to register it again.  This is
    %% needed on supervisor-driven restarts: the old pool may still be dying
    %% when our new init/1 runs.
    ok = wait_pool_unregistered(50),
    mongoc:connect(
        {rs, ReplSet, [HostStr]},
        [{name, chf_db_mongo_pool}, {register, chf_db_mongo_pool}, {pool_size, PoolSize}],
        [{database, Database}]
    ).

%% wait_pool_unregistered/1 — Poll until chf_db_mongo_pool is no longer
%% registered or until Retries * 100 ms have elapsed.  Returns ok either
%% way; if the name never disappears the subsequent connect attempt will
%% fail with a badarg from register/2 (acceptable — supervisor will retry).
-spec wait_pool_unregistered(non_neg_integer()) -> ok.
wait_pool_unregistered(0) ->
    ok;
wait_pool_unregistered(Retries) ->
    case whereis(chf_db_mongo_pool) of
        undefined -> ok;
        _Pid      ->
            timer:sleep(100),
            wait_pool_unregistered(Retries - 1)
    end.
