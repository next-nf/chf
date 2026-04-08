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
