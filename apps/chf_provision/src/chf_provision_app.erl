-module(chf_provision_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    chf_provision_json:ensure_atoms(),
    Port = application:get_env(chf_provision, port, 8080),
    Ip   = application:get_env(chf_provision, ip, {127,0,0,1}),
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/api/v1/subscribers",               chf_provision_subscriber_h, []},
            {"/api/v1/subscribers/:imsi",          chf_provision_subscriber_h, []},
            {"/api/v1/subscribers/:imsi/balance",  chf_provision_balance_h,    []}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(chf_provision_listener,
        [{port, Port}, {ip, Ip}],
        #{env => #{dispatch => Dispatch}}),
    chf_provision_sup:start_link().

stop(_State) ->
    cowboy:stop_listener(chf_provision_listener).
