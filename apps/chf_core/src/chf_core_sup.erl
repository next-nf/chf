-module(chf_core_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

-spec start_link() -> {ok, pid()} | {error, term()}.
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    SupFlags = #{
        strategy  => one_for_one,
        intensity => 5,
        period    => 10
    },
    Children = [
        %% Session sweeper — periodically terminates stale sessions.
        #{
            id       => chf_session_sweeper,
            start    => {chf_session_sweeper, start_link, []},
            restart  => permanent,
            shutdown => 5000,
            type     => worker,
            modules  => [chf_session_sweeper]
        }
    ],
    {ok, {SupFlags, Children}}.
