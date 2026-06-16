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

%% chf_cluster.erl — Static-list cluster membership + node monitoring (Phase 2).
%%
%% Reads the configured peer node list from {chf, cluster_nodes}, connects to
%% all peers at startup, and monitors node up/down events.  Quorum (strict
%% majority) is computed on init and after every nodeup/nodedown event; the
%% result is cached in persistent_term so the charging path can read it without
%% a gen_server call.
%%
%% Configuration (sys.config):
%%   {chf, [{cluster_nodes, []}]}   %% empty = single-node; add peer atoms for clustering
%%
%% cluster_nodes/0 always includes the local node via usort, so an empty list
%% produces [node()].
-module(chf_cluster).
-behaviour(gen_server).

-include_lib("kernel/include/logger.hrl").

-export([start_link/0, cluster_nodes/0, connected_nodes/0, in_quorum/0, refresh_quorum/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

-define(QUORUM_PT, {chf_cluster, in_quorum}).

%%====================================================================
%% Public API
%%====================================================================

%% @doc Return the full set of configured cluster nodes (always includes self).
-spec cluster_nodes() -> [node()].
cluster_nodes() ->
    Configured = application:get_env(chf, cluster_nodes, []),
    lists:usort([node() | Configured]).

%% @doc Return the subset of cluster nodes that are currently connected
%%      (self is always included).
-spec connected_nodes() -> [node()].
connected_nodes() ->
    Others = [N || N <- cluster_nodes(), N =/= node(), lists:member(N, nodes())],
    lists:usort([node() | Others]).

%% @doc Return true if this node can see a strict majority of configured nodes.
%%      Defaults to true so that a single-node or unconfigured deployment
%%      charges normally before the first refresh.
-spec in_quorum() -> boolean().
in_quorum() ->
    persistent_term:get(?QUORUM_PT, true).

%% @doc Recompute quorum and cache it in persistent_term.
-spec refresh_quorum() -> boolean().
refresh_quorum() ->
    Total     = length(cluster_nodes()),
    Connected = length(connected_nodes()),
    InQuorum  = Connected * 2 > Total,   %% strict majority
    persistent_term:put(?QUORUM_PT, InQuorum),
    InQuorum.

%%====================================================================
%% gen_server lifecycle
%%====================================================================

-spec start_link() -> {ok, pid()} | {error, term()}.
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init([]) ->
    %% net_kernel:monitor_nodes/1 requires a distributed node; guard so the
    %% module works in a non-distributed (nonode@nohost) test/dev environment.
    _ = case node() of
            nonode@nohost -> ok;
            _             -> net_kernel:monitor_nodes(true)
        end,
    _ = [net_kernel:connect_node(N) || N <- cluster_nodes(), N =/= node()],
    ?LOG_INFO("chf_cluster: configured nodes ~p", [cluster_nodes()]),
    refresh_quorum(),
    {ok, #{}}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info({nodeup, N}, State) ->
    ?LOG_INFO("chf_cluster: nodeup ~p (connected: ~p)", [N, connected_nodes()]),
    refresh_quorum(),
    {noreply, State};
handle_info({nodedown, N}, State) ->
    ?LOG_WARNING("chf_cluster: nodedown ~p (connected: ~p)", [N, connected_nodes()]),
    refresh_quorum(),
    {noreply, State};
handle_info(_Msg, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    _ = case node() of
            nonode@nohost -> ok;
            _             -> net_kernel:monitor_nodes(false)
        end,
    ok.
