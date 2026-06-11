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

%% chf_session_sweeper.erl — Periodic sweeper for stale charging sessions.
%%
%% Scans the charging_session table for active sessions whose
%% updated_at timestamp exceeds the idle timeout.  Stale sessions
%% are terminated via chf_core:session_terminate_if_stale/2 so that
%% proper balance refunds and CDR finalization occur.
-module(chf_session_sweeper).
-behaviour(gen_server).

-include_lib("chf_db/include/chf_db.hrl").
-include_lib("kernel/include/logger.hrl").

-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2]).

-define(DEFAULT_IDLE_TIMEOUT, 300000).   %% 5 minutes
-define(DEFAULT_SWEEP_INTERVAL, 60000).  %% 1 minute

%%====================================================================
%% API
%%====================================================================

-spec start_link() -> {ok, pid()} | {error, term()}.
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%%====================================================================
%% gen_server callbacks
%%====================================================================

init([]) ->
    Interval = application:get_env(chf_core, sweep_interval,
                                    ?DEFAULT_SWEEP_INTERVAL),
    IdleTimeout = application:get_env(chf_core, session_idle_timeout,
                                       ?DEFAULT_IDLE_TIMEOUT),
    ?LOG_INFO("Session sweeper started: interval=~wms idle_timeout=~wms",
              [Interval, IdleTimeout]),
    schedule(Interval),
    {ok, #{interval => Interval, idle_timeout => IdleTimeout}}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(sweep, #{interval := Interval, idle_timeout := IdleTimeout} = State) ->
    sweep(IdleTimeout),
    schedule(Interval),
    {noreply, State};
handle_info(_Info, State) ->
    {noreply, State}.

%%====================================================================
%% Internal
%%====================================================================

schedule(Interval) ->
    erlang:send_after(Interval, self(), sweep).

sweep(MaxAge) ->
    case chf_db:session_list_active() of
        {ok, Sessions} ->
            lists:foreach(fun(#charging_session{session_id = SId}) ->
                case chf_core:session_terminate_if_stale(SId, MaxAge) of
                    ok      -> ?LOG_INFO("Sweeper: terminated stale session ~s", [SId]);
                    skipped -> ok;
                    _Other  -> ok
                end
            end, Sessions);
        _Error ->
            ok
    end.
