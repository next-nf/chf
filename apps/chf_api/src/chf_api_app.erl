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
