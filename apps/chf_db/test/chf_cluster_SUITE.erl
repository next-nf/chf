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

-module(chf_cluster_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

all() ->
    [configured_nodes_includes_self, configured_nodes_empty_is_self,
     connected_is_self_when_alone,
     {group, cluster}].

groups() ->
    [{cluster, [], [two_nodes_replicate_balance]}].

init_per_suite(Config) -> Config.
end_per_suite(_Config) -> ok.

init_per_group(cluster, Config) ->
    %% The CT node must be distributed so peer nodes can connect back.
    case net_kernel:start([ct_chf_db, shortnames]) of
        {ok, _}                       -> ok;
        {error, {already_started, _}} -> ok
    end,
    %% Align cookie so Erlang distribution between CT node and peers works.
    erlang:set_cookie(node(), 'next-chf-cookie'),
    %% Use connection => 0 (TCP on a random port) instead of standard_io so
    %% that CT framework IO capture cannot break the peer control channel.
    {ok, P1, N1} = peer:start(#{name => chf1, connection => 0,
                                 args => ["-setcookie", "next-chf-cookie"]}),
    {ok, P2, N2} = peer:start(#{name => chf2, connection => 0,
                                 args => ["-setcookie", "next-chf-cookie"]}),
    Nodes = [N1, N2],
    %% Sequential setup: P1 first (single-node seed), then P2 (joins P1).
    %% When P1 starts, P2 is alive but has no mnesia yet, so P1 boots as
    %% single-node seed.  When P2 starts, P1 already has all tables, so P2
    %% merges P1's schema and adds a disc_copies replica per table.
    %% MUST NOT be parallelised — P1's init/1 has to fully complete before P2
    %% calls change_config/2, or both nodes race and seed disjoint schemas
    %% (see the split-brain KNOWN LIMITATION note in chf_db_mnesia:init/1).
    lists:foreach(fun(P) -> setup_peer(P, Nodes) end, [P1, P2]),
    [{peers, [P1, P2]}, {peer_nodes, Nodes} | Config];
init_per_group(_, Config) ->
    Config.

end_per_group(cluster, Config) ->
    lists:foreach(fun(P) -> peer:stop(P) end, ?config(peers, Config)),
    ok;
end_per_group(_, _) ->
    ok.

setup_peer(Peer, Nodes) ->
    %% Load all beam paths from the running CT node into the peer so it can
    %% find chf_db, chf_cluster, mnesia, etc. without a release.
    ok = peer:call(Peer, code, add_pathsa, [code:get_path()]),
    %% Give each peer a unique, fresh Mnesia directory so that stale schemas
    %% from prior test runs (same short node name, different run) never cause
    %% a schema-merge conflict or {already_exists} mismatch.
    MnesiaDir = peer:call(Peer, erlang, apply,
                          [fun() ->
                               D = filename:join(["/tmp", atom_to_list(node()), "mnesia"]),
                               ok = filelib:ensure_path(D),
                               %% Delete any stale Mnesia files from a previous run.
                               _ = [file:delete(F) || F <- filelib:wildcard(filename:join(D, "*"))],
                               D
                           end, []]),
    ok = peer:call(Peer, application, set_env, [mnesia, dir, MnesiaDir]),
    %% Configure the cluster node list and backend before starting chf_db.
    ok = peer:call(Peer, application, set_env, [chf, cluster_nodes, Nodes]),
    ok = peer:call(Peer, application, set_env, [chf_db, backend, chf_db_mnesia]),
    {ok, _Started} = peer:call(Peer, application, ensure_all_started, [chf_db]),
    ok.

%%--------------------------------------------------------------------
%% Cluster group test
%%--------------------------------------------------------------------

two_nodes_replicate_balance(Config) ->
    [N1, N2] = ?config(peer_nodes, Config),
    %% Both nodes must hold a disc_copies replica of the balance table.
    %% N1 created it as seed; N2 added itself via add_table_copy during its
    %% chf_db_mnesia:init/1.
    Copies = rpc:call(N1, mnesia, table_info, [balance, disc_copies]),
    ?assert(lists:member(N1, Copies)),
    ?assert(lists:member(N2, Copies)).

%%--------------------------------------------------------------------
%% Single-node / unit tests (default path, always run)
%%--------------------------------------------------------------------

configured_nodes_includes_self(_) ->
    application:set_env(chf, cluster_nodes, [node()]),
    ?assertEqual([node()], chf_cluster:cluster_nodes()).

configured_nodes_empty_is_self(_) ->
    application:set_env(chf, cluster_nodes, []),
    ?assertEqual([node()], chf_cluster:cluster_nodes()).

connected_is_self_when_alone(_) ->
    application:set_env(chf, cluster_nodes, [node()]),
    {ok, _} = chf_cluster:start_link(),
    ?assertEqual([node()], lists:sort(chf_cluster:connected_nodes())),
    gen_server:stop(chf_cluster).
