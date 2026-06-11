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

-module(chf_api_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Port = application:get_env(chf_api, port, 8080),
    Ip   = application:get_env(chf_api, ip, {127,0,0,1}),
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/api/v1/subscribers",               chf_api_subscriber_h, []},
            {"/api/v1/subscribers/:imsi",          chf_api_subscriber_h, []},
            {"/api/v1/subscribers/:imsi/balance",  chf_api_balance_h,    []}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(chf_api_listener,
        [{port, Port}, {ip, Ip}],
        #{env => #{dispatch => Dispatch}}),
    chf_api_sup:start_link().

stop(_State) ->
    cowboy:stop_listener(chf_api_listener).
