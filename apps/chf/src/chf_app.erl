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

-module(chf_app).
-behaviour(application).

-include_lib("kernel/include/logger.hrl").

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    ?LOG_INFO("Next-CHF starting..."),
    ?LOG_INFO("  Provisioning API: ~s",
              [listener_info(chf_provision, port, 8080)]),
    ?LOG_INFO("  5G CHF API:       ~s",
              [listener_info(chf_api, port, 8443)]),
    ?LOG_INFO("  Web UI:           ~s",
              [listener_info(chf_web, port, 8081)]),
    ?LOG_INFO("  DIAMETER:         ~s",
              [diameter_info()]),
    chf_sup:start_link().

stop(_State) ->
    ?LOG_INFO("Next-CHF stopping..."),
    ok.

%%====================================================================
%% Internal
%%====================================================================

listener_info(App, Key, Default) ->
    Port = application:get_env(App, Key, Default),
    Ip = application:get_env(App, ip, {127,0,0,1}),
    io_lib:format("~s:~w", [inet:ntoa(Ip), Port]).

diameter_info() ->
    Listen = application:get_env(chf_diameter, listen, []),
    lists:flatten(
        lists:join(", ",
            [io_lib:format("~s:~w", [inet:ntoa(IP), Port])
             || {tcp, IP, Port} <- Listen])).
