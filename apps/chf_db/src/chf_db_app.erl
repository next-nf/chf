-module(chf_db_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    case chf_db:init() of
        ok ->
            chf_db_sup:start_link();
        {error, Reason} ->
            {error, {chf_db_init_failed, Reason}}
    end.

stop(_State) ->
    ok.
