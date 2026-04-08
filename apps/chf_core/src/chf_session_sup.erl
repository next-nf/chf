%% chf_session_sup.erl — simple_one_for_one supervisor for chf_session processes.
%%
%% Sessions are started via supervisor:start_child/2 and are temporary
%% (no auto-restart on crash — the protocol layer handles re-auth if needed).
-module(chf_session_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

-spec start_link() -> {ok, pid()} | {error, term()}.
start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init([]) ->
    SupFlags = #{
        strategy  => simple_one_for_one,
        intensity => 0,
        period    => 1
    },
    ChildSpec = #{
        id       => chf_session,
        start    => {chf_session, start_link, []},
        restart  => temporary,
        shutdown => 5000,
        type     => worker,
        modules  => [chf_session]
    },
    {ok, {SupFlags, [ChildSpec]}}.
