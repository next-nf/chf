-module(chf_web_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    chf_web_sup:start_link().

stop(_State) ->
    ok.
