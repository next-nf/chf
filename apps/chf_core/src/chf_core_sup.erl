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
        %% Session registry — must start before any session processes.
        #{
            id       => chf_session_reg,
            start    => {chf_session_reg, start_link, []},
            restart  => permanent,
            shutdown => 5000,
            type     => worker,
            modules  => [chf_session_reg]
        },
        %% Session supervisor — simple_one_for_one pool for chf_session workers.
        #{
            id       => chf_session_sup,
            start    => {chf_session_sup, start_link, []},
            restart  => permanent,
            shutdown => infinity,
            type     => supervisor,
            modules  => [chf_session_sup]
        }
    ],
    {ok, {SupFlags, Children}}.
