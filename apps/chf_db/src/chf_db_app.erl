-module(chf_db_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    chf_db_sup:start_link().

stop(_State) ->
    ok.
