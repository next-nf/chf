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
     {group, cluster},
     {group, cluster3}].

groups() ->
    [{cluster, [], [two_nodes_replicate_balance,
                    no_double_spend_across_nodes,
                    only_one_sweeper_active,
                    sweeper_takeover_on_nodedown]},
     {cluster3, [], [minority_refuses_to_charge]}].

init_per_suite(Config) -> Config.
end_per_suite(_Config) ->
    %% quorum_minority_is_false leaves {chf_cluster, in_quorum} = false in
    %% persistent_term (global); reset it so later suites (e.g. the Mongo
    %% backend's charging tests via chf_core:with_quorum) aren't blocked.
    persistent_term:put({chf_cluster, in_quorum}, true),
    ok.

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
init_per_group(cluster3, Config) ->
    %% The CT node must be distributed so peer nodes can connect back.
    case net_kernel:start([ct_chf_db, shortnames]) of
        {ok, _}                       -> ok;
        {error, {already_started, _}} -> ok
    end,
    erlang:set_cookie(node(), 'next-chf-cookie'),
    {ok, P1, N1} = peer:start(#{name => chf1, connection => 0,
                                 args => ["-setcookie", "next-chf-cookie"]}),
    {ok, P2, N2} = peer:start(#{name => chf2, connection => 0,
                                 args => ["-setcookie", "next-chf-cookie"]}),
    {ok, P3, N3} = peer:start(#{name => chf3, connection => 0,
                                 args => ["-setcookie", "next-chf-cookie"]}),
    Nodes = [N1, N2, N3],
    %% Sequential setup: nodes must start one at a time so each subsequent node
    %% finds a fully-initialised Mnesia schema to merge with.
    lists:foreach(fun(P) -> setup_peer(P, Nodes) end, [P1, P2, P3]),
    [{peers3, [{P1, N1}, {P2, N2}, {P3, N3}]}, {peer_nodes3, Nodes} | Config];
init_per_group(_, Config) ->
    Config.

end_per_group(cluster, Config) ->
    lists:foreach(fun({P, _N}) ->
        %% sweeper_takeover_on_nodedown may have already stopped one peer via
        %% peer:stop; calling it a second time throws {EXIT, noproc}.
        catch peer:stop(P)
    end, ?config(peers, Config)),
    ok;
end_per_group(cluster3, Config) ->
    lists:foreach(fun({P, _N}) ->
        %% Wrap peer:stop/1 in catch: a peer may already be stopped (e.g. by a
        %% takeover test), so stopping it again throws — ignore that.
        catch peer:stop(P)
    end, ?config(peers3, Config)),
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
%% cluster3 group tests
%%--------------------------------------------------------------------

%% In a 3-node cluster, place N3 into a minority partition of 1 and confirm it
%% refuses to charge while the majority side (N1) continues charging.
%%
%% Network-layer isolation via disconnect_node/1 is unreliable in this
%% environment: Mnesia's internal protocol negotiation re-establishes Erlang
%% distribution connections within milliseconds of a disconnect, racing against
%% the quorum check.  Instead we use chf_cluster's own configuration path:
%% override N3's cluster_nodes to two phantom peers that will never be reachable,
%% then trigger a quorum refresh — this deterministically places N3 in minority
%% (1 of 3, connected = [N3] only) without depending on TCP timing.
%% N1's cluster_nodes remain [N1, N2, N3] and N1 sees N2 in nodes(), so N1
%% stays in quorum (2 of 3 = strict majority).
minority_refuses_to_charge(Config) ->
    [N1, _N2, N3] = ?config(peer_nodes3, Config),
    %% Redirect N3 to phantom peers so connected_nodes/0 on N3 returns only [N3].
    %% chf_cluster:connected_nodes/0 filters cluster_nodes() ∩ nodes(), so as
    %% long as the phantoms are unreachable (never in nodes()), 1/3 < majority.
    Phantoms = [N3, 'phantom1@nohost', 'phantom2@nohost'],
    ok = rpc:call(N3, application, set_env, [chf, cluster_nodes, Phantoms]),
    %% Force a quorum recomputation on N3 with the new config.
    false = rpc:call(N3, chf_cluster, refresh_quorum, []),
    %% Confirm N3 sees itself as minority.
    ?assertEqual(false, rpc:call(N3, chf_cluster, in_quorum, [])),
    %% Confirm N1 is still in quorum (majority side is unaffected).
    ?assertEqual(true, rpc:call(N1, chf_cluster, in_quorum, [])),
    %% Majority side (N1) must still be able to charge.
    ok  = rpc:call(N1, chf_db, subscriber_create, [make_subscriber(<<"001">>, <<"a">>)]),
    {ok, _} = rpc:call(N1, chf_db, balance_topup, [<<"a">>, 1000000]),
    {ok, _} = rpc:call(N1, chf_core, create_session,
                       [#{session_id => <<"q">>, imsi => <<"001">>, type => online}]),
    ?assertMatch({ok, _},
                 rpc:call(N1, chf_core, session_initial,
                          [<<"q">>, #{rating_groups => [rg(1, 100, 0)]}])),
    %% Minority side (N3) must refuse all charging ops — the with_quorum/1 gate
    %% in chf_core fires before any session or balance lookup, so even a
    %% non-existent session returns no_quorum rather than not_found.
    ?assertEqual({error, no_quorum},
                 rpc:call(N3, chf_core, session_initial,
                          [<<"q3">>, #{rating_groups => [rg(1, 100, 0)]}])).

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

%% Build a rating-group request map for use in session_initial/session_update.
rg(Id, Req, Used) ->
    #{rating_group => Id, requested_units => Req, used_units => Used}.

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
