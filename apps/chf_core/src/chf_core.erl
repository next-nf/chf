%% chf_core.erl — Public API for the CHF core charging engine.
%%
%% Convenience façade that ties together session supervision,
%% registry lookups, and per-session call dispatch.
-module(chf_core).

-export([
    create_session/1,
    session_initial/2,
    session_update/2,
    session_terminate/2,
    find_session/1
]).

%%====================================================================
%% API
%%====================================================================

%% @doc Start a new charging session process under chf_session_sup.
%%
%% Info :: #{session_id => binary(), imsi => binary(),
%%           type => online | offline | converged}
%%
%% Returns {ok, Pid} or {error, Reason}.
-spec create_session(map()) -> {ok, pid()} | {error, term()}.
create_session(#{session_id := _SessionId, imsi := _Imsi, type := _Type} = Info) ->
    supervisor:start_child(chf_session_sup, [Info]).

%% @doc Send an initial charging request to the identified session.
-spec session_initial(SessionId :: binary(), RequestData :: map()) ->
    {ok, map()} | ok | {error, term()}.
session_initial(SessionId, RequestData) ->
    case find_session(SessionId) of
        {ok, Pid}          -> chf_session:initial(Pid, RequestData);
        {error, _} = Err   -> Err
    end.

%% @doc Send an update (interim) charging request to the identified session.
-spec session_update(SessionId :: binary(), RequestData :: map()) ->
    {ok, map()} | ok | {error, term()}.
session_update(SessionId, RequestData) ->
    case find_session(SessionId) of
        {ok, Pid}          -> chf_session:update(Pid, RequestData);
        {error, _} = Err   -> Err
    end.

%% @doc Send a terminate request to the identified session.
-spec session_terminate(SessionId :: binary(), RequestData :: map()) ->
    ok | {error, term()}.
session_terminate(SessionId, RequestData) ->
    case find_session(SessionId) of
        {ok, Pid}          -> chf_session:terminate_session(Pid, RequestData);
        {error, _} = Err   -> Err
    end.

%% @doc Resolve a SessionId to a live session pid via the registry.
-spec find_session(SessionId :: binary()) -> {ok, pid()} | {error, not_found}.
find_session(SessionId) ->
    chf_session_reg:lookup(SessionId).
