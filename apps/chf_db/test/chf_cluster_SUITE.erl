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
-include_lib("chf_db/include/chf_db.hrl").

all() ->
    [configured_nodes_includes_self, configured_nodes_empty_is_self,
     connected_is_self_when_alone,
     quorum_alone_is_true, quorum_minority_is_false,
     {group, cluster}].

groups() ->
    [{cluster, [], [two_nodes_replicate_balance,
                    no_double_spend_across_nodes,
                    only_one_sweeper_active,
                    sweeper_takeover_on_nodedown]}].

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
    [{peers, [{P1, N1}, {P2, N2}]}, {peer_nodes, Nodes} | Config];
init_per_group(_, Config) ->
    Config.

end_per_group(cluster, Config) ->
    lists:foreach(fun({P, _N}) ->
        %% sweeper_takeover_on_nodedown may have already stopped one peer via
        %% peer:stop; calling it a second time throws {EXIT, noproc}.
        catch peer:stop(P)
    end, ?config(peers, Config)),
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
    {ok, _Started1} = peer:call(Peer, application, ensure_all_started, [chf_db]),
    %% Also start chf_core so the singleton sweeper (chf_session_sweeper) runs
    %% on each peer.  chf_core depends on chf_otel; ensure_all_started handles
    %% the full transitive dep chain.
    {ok, _Started2} = peer:call(Peer, application, ensure_all_started, [chf_core]),
    ok.

%%--------------------------------------------------------------------
%% Cluster group tests
%%--------------------------------------------------------------------

two_nodes_replicate_balance(Config) ->
    [N1, N2] = ?config(peer_nodes, Config),
    %% Both nodes must hold a disc_copies replica of the balance table.
    %% N1 created it as seed; N2 added itself via add_table_copy during its
    %% chf_db_mnesia:init/1.
    Copies = rpc:call(N1, mnesia, table_info, [balance, disc_copies]),
    ?assert(lists:member(N1, Copies)),
    ?assert(lists:member(N2, Copies)).

no_double_spend_across_nodes(Config) ->
    [N1, N2] = ?config(peer_nodes, Config),
    Sub = make_subscriber(<<"001">>, <<"acc">>),
    ok = rpc:call(N1, chf_db, subscriber_create, [Sub]),
    {ok, _} = rpc:call(N1, chf_db, balance_topup, [<<"acc">>, 1000]),
    Self = self(),
    %% 12 concurrent reservations of 100 each (6 per node) against a 1000-unit
    %% balance.  Mnesia distributed transactions must serialize access so the
    %% total granted never exceeds the available balance.
    Nodes = lists:flatten(lists:duplicate(6, [N1, N2])),
    [spawn(fun() ->
        R = rpc:call(Node, chf_db, balance_reserve_up_to, [<<"acc">>, 100]),
        Self ! {done, R}
     end) || Node <- Nodes],
    Granted = lists:sum([receive {done, {ok, G, _}} -> G; {done, _} -> 0 end
                         || _ <- Nodes]),
    {ok, B} = rpc:call(N1, chf_db, balance_get, [<<"acc">>]),
    ?assert(Granted =< 1000),
    ?assertEqual(B#balance.reserved, Granted),
    ?assertEqual(B#balance.available, B#balance.total - B#balance.reserved).

only_one_sweeper_active(Config) ->
    [N1, N2] = ?config(peer_nodes, Config),
    %% Both nodes run chf_core (and therefore chf_session_sweeper), but exactly
    %% one of them should hold the global :chf_session_sweeper registration.
    P1 = rpc:call(N1, global, whereis_name, [chf_session_sweeper]),
    P2 = rpc:call(N2, global, whereis_name, [chf_session_sweeper]),
    ?assertEqual(P1, P2),
    ?assert(is_pid(P1)).

%% The sweeper's takeover path is triggered by a {nodedown, N} kernel event,
%% not by the global name becoming free.  To exercise the real mechanism we
%% must bring the holder node's distribution down.  We use peer:stop/1 on the
%% holder's peer process: that terminates the OS process, which causes a real
%% nodedown on the surviving node and triggers try_become_active/1.
sweeper_takeover_on_nodedown(Config) ->
    Peers     = ?config(peers, Config),
    [N1, N2]  = ?config(peer_nodes, Config),
    %% Determine which node currently holds the global sweeper.
    HolderNode = node(rpc:call(N1, global, whereis_name, [chf_session_sweeper])),
    {OtherNode, HolderPeer} = case HolderNode of
        N1 -> {N2, element(1, lists:keyfind(N1, 2, Peers))};
        N2 -> {N1, element(1, lists:keyfind(N2, 2, Peers))}
    end,
    %% Tear down the holder's OS node so the survivor receives {nodedown, ...}.
    ok = peer:stop(HolderPeer),
    %% Poll until the surviving node registers a new local sweeper (up to ~5 s).
    true = test_until(fun() ->
        P = rpc:call(OtherNode, global, whereis_name, [chf_session_sweeper]),
        is_pid(P) andalso node(P) =:= OtherNode
    end, 50, 100),
    ok.

%%--------------------------------------------------------------------
%% Helpers
%%--------------------------------------------------------------------

%% Build a minimal #subscriber{} record suitable for chf_db:subscriber_create/1.
make_subscriber(Imsi, AccountId) ->
    Now = erlang:system_time(millisecond),
    #subscriber{imsi          = Imsi,
                msisdn        = <<"49", Imsi/binary>>,
                account_id    = AccountId,
                status        = active,
                rating_groups = #{},
                created_at    = Now,
                updated_at    = Now}.

%% Poll Fun up to Retries times with SleepMs between attempts.
%% Returns true if Fun returned true within the deadline, false otherwise.
test_until(_Fun, 0, _SleepMs) ->
    false;
test_until(Fun, Retries, SleepMs) ->
    case Fun() of
        true  -> true;
        false ->
            timer:sleep(SleepMs),
            test_until(Fun, Retries - 1, SleepMs)
    end.

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

quorum_alone_is_true(_) ->
    application:set_env(chf, cluster_nodes, [node()]),
    {ok, _} = chf_cluster:start_link(),
    ?assert(chf_cluster:in_quorum()),
    gen_server:stop(chf_cluster).

quorum_minority_is_false(_) ->
    application:set_env(chf, cluster_nodes, [node(), 'a@nohost', 'b@nohost']),
    {ok, _} = chf_cluster:start_link(),
    ?assertNot(chf_cluster:in_quorum()),   %% sees only self (1 of 3)
    gen_server:stop(chf_cluster).
