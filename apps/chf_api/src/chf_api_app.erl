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
    chf_api_json:ensure_atoms(),
    Port = application:get_env(chf_api, port, 8443),
    Ip   = application:get_env(chf_api, ip, {127, 0, 0, 1}),

    Dispatch = cowboy_router:compile([
        {'_', [
            %% Nchf_ConvergedCharging (TS 32.291 §6.1)
            {"/nchf-convergedcharging/v3/chargingdata",
             chf_api_converged_h, []},
            {"/nchf-convergedcharging/v3/chargingdata/:chargingDataRef",
             chf_api_converged_h, []},
            {"/nchf-convergedcharging/v3/chargingdata/:chargingDataRef/update",
             chf_api_converged_h, [update]},
            {"/nchf-convergedcharging/v3/chargingdata/:chargingDataRef/release",
             chf_api_converged_h, [release]},

            %% Nchf_OfflineOnlyCharging (TS 32.291 §6.2)
            {"/nchf-offlineonlycharging/v1/offlinechargingdata",
             chf_api_offline_h, []},
            {"/nchf-offlineonlycharging/v1/offlinechargingdata/:offlineChargingDataRef",
             chf_api_offline_h, []},
            {"/nchf-offlineonlycharging/v1/offlinechargingdata/:offlineChargingDataRef/update",
             chf_api_offline_h, [update]},
            {"/nchf-offlineonlycharging/v1/offlinechargingdata/:offlineChargingDataRef/release",
             chf_api_offline_h, [release]}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(chf_api_listener,
        [{port, Port}, {ip, Ip}],
        #{env => #{dispatch => Dispatch}}),
    chf_api_sup:start_link().

stop(_State) ->
    cowboy:stop_listener(chf_api_listener).
