-module(chf_diameter_app).
-behaviour(application).

-include_lib("kernel/include/logger.hrl").

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    %% The OTP diameter application must be running before we start our service.
    ok = diameter:start(),
    chf_diameter_sup:start_link().

stop(_State) ->
    %% Tear down our service and then the diameter stack.
    _ = diameter:stop_service('next-chf'),
    _ = diameter:stop(),
    ok.
