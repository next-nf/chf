-module(chf_diameter_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    chf_diameter_sup:start_link().

stop(_State) ->
    ok.
