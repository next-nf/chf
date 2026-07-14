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

%% chf_session_sweeper.erl — Cluster-singleton periodic sweeper for stale sessions.
%%
%% Every node starts this gen_server, but only one node is ACTIVE at a time.
%% The active node wins global:register_name(chf_session_sweeper, self());
%% the rest are STANDBY. When a nodedown is received, standby nodes race to
%% take over via global:register_name. The active node performs the periodic
%% sweep; standby nodes ignore sweep timer messages.
%%
%% Phase 1 is single-node: there is no cluster quorum gate (the syn-based
%% chf_cluster is a Phase 2 concern). Correctness rests on version-CAS on the
%% authoritative balance document. The sweep terminates stale descriptive
%% sessions; chf_core:session_terminate_if_stale releases (refunds) the balance
%% reservation for each session it ends.
-module(chf_session_sweeper).
-behaviour(gen_server).

-include_lib("kernel/include/logger.hrl").

-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

-define(DEFAULT_IDLE_TIMEOUT, 300000).   %% 5 minutes
-define(DEFAULT_SWEEP_INTERVAL, 60000).  %% 1 minute

%%====================================================================
%% API
%%====================================================================

-spec start_link() -> {ok, pid()} | {error, term()}.
start_link() ->
    %% No local name registration — identity is managed via :global so that
    %% only one instance is active cluster-wide.
    gen_server:start_link(?MODULE, [], []).

%%====================================================================
%% gen_server callbacks
%%====================================================================

init([]) ->
    Interval = application:get_env(chf_core, sweep_interval,
                                    ?DEFAULT_SWEEP_INTERVAL),
    IdleTimeout = application:get_env(chf_core, session_idle_timeout,
                                       ?DEFAULT_IDLE_TIMEOUT),
    %% Monitor node up/down events so standby nodes can attempt takeover.
    %% Guard for non-distributed CT (nonode@nohost): net_kernel is not running.
    case node() of
        nonode@nohost -> ok;
        _             -> net_kernel:monitor_nodes(true)
    end,
    State0 = #{interval => Interval, idle_timeout => IdleTimeout, active => false},
    State1 = try_become_active(State0),
    {ok, State1}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

%% Active node: run the sweep, then reschedule.
handle_info(sweep, #{active := true, interval := Interval, idle_timeout := IdleTimeout} = State) ->
    sweep(IdleTimeout),
    schedule(Interval),
    {noreply, State};
%% Standby node: ignore stray sweep timer (fired before we went standby, or
%% scheduled by a previous active run).
handle_info(sweep, State) ->
    {noreply, State};
%% A node went down — if we are standby, race to become the new active.
handle_info({nodedown, _N}, #{active := false} = State) ->
    {noreply, try_become_active(State)};
handle_info({nodedown, _N}, State) ->
    {noreply, State};
handle_info({nodeup, _N}, State) ->
    {noreply, State};
handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    %% Stop monitoring nodes on a non-distributed node (guard avoids badarg).
    case node() of
        nonode@nohost -> ok;
        _             -> net_kernel:monitor_nodes(false)
    end,
    ok.

%%====================================================================
%% Internal
%%====================================================================

%% Try to register globally as the active sweeper.  If we win, schedule the
%% first sweep; if we lose (another node already holds the name), stay standby.
try_become_active(#{interval := Interval} = State) ->
    case global:register_name(chf_session_sweeper, self()) of
        yes ->
            ?LOG_INFO("Session sweeper ACTIVE on ~p: interval=~wms idle_timeout=~wms",
                      [node(), Interval, maps:get(idle_timeout, State)]),
            schedule(Interval),
            State#{active => true};
        no ->
            ?LOG_INFO("Session sweeper STANDBY on ~p", [node()]),
            State#{active => false}
    end.

schedule(Interval) ->
    erlang:send_after(Interval, self(), sweep).

sweep(MaxAge) ->
    {ok, Sessions} = chf_data:session_list_active(),
    lists:foreach(fun(S) ->
        SId = maps:get(<<"session_id">>, S),
        case chf_core:session_terminate_if_stale(SId, MaxAge) of
            ok      -> ?LOG_INFO("Sweeper: terminated stale session ~s", [SId]);
            skipped -> ok;
            _Other  -> ok
        end
    end, Sessions).
