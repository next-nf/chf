-module(chf_provision_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    chf_provision_sup:start_link().

stop(_State) ->
    ok.
