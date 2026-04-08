-module(chf_diameter_app).
-behaviour(application).

-include_lib("kernel/include/logger.hrl").

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    %% diameter is listed as a dependency in .app.src so it's already started.
    chf_diameter_sup:start_link().

stop(_State) ->
    _ = diameter:stop_service('next-chf'),
    ok.
