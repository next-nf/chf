%% chf_session.erl — gen_server managing a single charging session.
%%
%% Each session handles multiple RatingGroups and delegates the actual
%% charging logic to chf_online / chf_offline based on session type.
%% For converged sessions, both modules are called.
%%
%% An idle timer fires after `session_idle_timeout` ms (default 5 min).
%% On expiry the session auto-terminates and the process stops.
-module(chf_session).
-behaviour(gen_server).

-include_lib("chf_db/include/chf_db.hrl").

-export([start_link/1, initial/2, update/2, terminate_session/2]).

-export([init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2]).

-define(DEFAULT_IDLE_TIMEOUT, 300000).  %% 5 minutes in ms

-record(state, {
    session_id   :: binary(),
    imsi         :: binary(),
    session_type :: online | offline | converged,
    %% Per-RatingGroup tracking: RGId => integer amount
    granted_units :: #{non_neg_integer() => integer()},
    used_units    :: #{non_neg_integer() => integer()},
    idle_timer    :: reference() | undefined
}).

%%====================================================================
%% API
%%====================================================================

%% @doc Start a session gen_server.
%%
%% Info :: #{session_id => binary(), imsi => binary(), type => online | offline | converged}
-spec start_link(map()) -> {ok, pid()} | {error, term()}.
start_link(#{session_id := SessionId, imsi := Imsi, type := Type} = _Info) ->
    gen_server:start_link(?MODULE, {SessionId, Imsi, Type}, []).

%% @doc Send an initial charging request to the session.
-spec initial(Pid :: pid(), RequestData :: map()) ->
    {ok, map()} | ok | {error, term()}.
initial(Pid, RequestData) ->
    gen_server:call(Pid, {initial, RequestData}).

%% @doc Send an update (interim) charging request to the session.
-spec update(Pid :: pid(), RequestData :: map()) ->
    {ok, map()} | ok | {error, term()}.
update(Pid, RequestData) ->
    gen_server:call(Pid, {update, RequestData}).

%% @doc Send a terminate request to the session.
%%      The session process stops after handling this.
-spec terminate_session(Pid :: pid(), RequestData :: map()) ->
    ok | {error, term()}.
terminate_session(Pid, RequestData) ->
    gen_server:call(Pid, {terminate_session, RequestData}).

%%====================================================================
%% gen_server callbacks
%%====================================================================

init({SessionId, Imsi, Type}) ->
    %% Register in the session registry.
    chf_session_reg:register(SessionId, self()),
    %% Persist the session record to the DB.
    Now = erlang:system_time(millisecond),
    Session = #charging_session{
        session_id    = SessionId,
        imsi          = Imsi,
        type          = Type,
        state         = initial,
        granted_units = #{},
        used_units    = #{},
        created_at    = Now,
        updated_at    = Now
    },
    _ = chf_db:session_store(Session),
    State = #state{
        session_id    = SessionId,
        imsi          = Imsi,
        session_type  = Type,
        granted_units = #{},
        used_units    = #{},
        idle_timer    = undefined
    },
    {ok, reset_idle_timer(State)}.

%% ---- Initial -------------------------------------------------------

handle_call({initial, RequestData}, _From, State) ->
    RatingGroups = maps:get(rating_groups, RequestData, []),
    {Reply, NewState} = handle_initial(RatingGroups, State),
    {reply, Reply, reset_idle_timer(NewState)};

%% ---- Update --------------------------------------------------------

handle_call({update, RequestData}, _From, State) ->
    RatingGroups = maps:get(rating_groups, RequestData, []),
    {Reply, NewState} = handle_update(RatingGroups, State),
    {reply, Reply, reset_idle_timer(NewState)};

%% ---- Terminate -----------------------------------------------------

handle_call({terminate_session, RequestData}, _From, State) ->
    RatingGroups = maps:get(rating_groups, RequestData, []),
    Reply = handle_terminate(RatingGroups, State),
    %% Update the DB record to terminated state and clean up registry.
    finalize_session(State),
    {stop, normal, Reply, State};

handle_call(_Request, _From, State) ->
    {reply, {error, unknown_call}, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

%% Idle timer expired — auto-terminate.
handle_info({idle_timeout, Ref}, #state{idle_timer = Ref} = State) ->
    handle_terminate([], State),
    finalize_session(State),
    {stop, normal, State};

handle_info({idle_timeout, _OldRef}, State) ->
    %% Stale timer message (timer was reset) — ignore.
    {noreply, State};

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

%%====================================================================
%% Internal — charging logic dispatch
%%====================================================================

-spec handle_initial([map()], #state{}) -> {term(), #state{}}.
handle_initial(RatingGroups, #state{session_type = Type, imsi = Imsi,
                                    session_id = SessionId} = State) ->
    OnlineResult =
        case Type of
            T when T =:= online; T =:= converged ->
                chf_online:initial_request(Imsi, RatingGroups);
            offline ->
                {ok, #{}}
        end,
    OfflineResult =
        case Type of
            T2 when T2 =:= offline; T2 =:= converged ->
                chf_offline:initial_request(Imsi, SessionId);
            online ->
                ok
        end,
    case {OnlineResult, OfflineResult} of
        {{ok, GrantedMap}, _} ->
            NewGranted = maps:merge(State#state.granted_units, GrantedMap),
            NewState   = State#state{granted_units = NewGranted},
            {{ok, GrantedMap}, NewState};
        {{error, Reason}, _} ->
            {{error, Reason}, State}
    end.

-spec handle_update([map()], #state{}) -> {term(), #state{}}.
handle_update(RatingGroups, #state{session_type = Type, imsi = Imsi,
                                   session_id = SessionId} = State) ->
    %% Accumulate used units from this update into state.
    NewUsed = lists:foldl(fun(RG, Acc) ->
        RGId = maps:get(rating_group, RG),
        Used = maps:get(used_units, RG, 0),
        Prev = maps:get(RGId, Acc, 0),
        Acc#{RGId => Prev + Used}
    end, State#state.used_units, RatingGroups),

    OnlineResult =
        case Type of
            T when T =:= online; T =:= converged ->
                chf_online:update_request(Imsi, RatingGroups);
            offline ->
                {ok, #{}}
        end,

    case Type of
        T2 when T2 =:= offline; T2 =:= converged ->
            chf_offline:update_request(Imsi, #{
                session_id    => SessionId,
                rating_groups => RatingGroups
            });
        online -> ok
    end,

    case OnlineResult of
        {ok, GrantedMap} ->
            NewGranted = maps:merge(State#state.granted_units, GrantedMap),
            NewState   = State#state{granted_units = NewGranted,
                                     used_units    = NewUsed},
            {{ok, GrantedMap}, NewState};
        {error, Reason} ->
            {{error, Reason}, State#state{used_units = NewUsed}}
    end.

-spec handle_terminate([map()], #state{}) -> ok | {error, term()}.
handle_terminate(RatingGroups, #state{session_type = Type, imsi = Imsi,
                                      session_id = SessionId,
                                      granted_units = Granted,
                                      used_units = UsedSoFar}) ->
    %% Merge any final used_units from the terminate request into totals.
    FinalUsed = lists:foldl(fun(RG, Acc) ->
        RGId = maps:get(rating_group, RG),
        Used = maps:get(used_units, RG, 0),
        Prev = maps:get(RGId, Acc, 0),
        Acc#{RGId => Prev + Used}
    end, UsedSoFar, RatingGroups),

    %% Build annotated RatingGroup list with granted amounts for online refund.
    AnnotatedRGs = maps:fold(fun(RGId, TotalUsed, Acc) ->
        [#{rating_group  => RGId,
           used_units    => TotalUsed,
           granted_units => maps:get(RGId, Granted, 0)} | Acc]
    end, [], FinalUsed),

    case Type of
        T when T =:= online; T =:= converged ->
            chf_online:terminate_request(Imsi, AnnotatedRGs);
        offline -> ok
    end,

    case Type of
        T2 when T2 =:= offline; T2 =:= converged ->
            chf_offline:terminate_request(Imsi, #{
                session_id    => SessionId,
                rating_groups => [#{rating_group => RGId,
                                    used_units   => TotalUsed}
                                  || #{rating_group := RGId,
                                       used_units   := TotalUsed} <- AnnotatedRGs]
            });
        online -> ok
    end,
    ok.

%%====================================================================
%% Internal helpers
%%====================================================================

-spec reset_idle_timer(#state{}) -> #state{}.
reset_idle_timer(#state{idle_timer = OldRef} = State) ->
    %% Cancel the previous timer if present.
    case OldRef of
        undefined -> ok;
        _         -> erlang:cancel_timer(OldRef)
    end,
    Timeout = application:get_env(chf_core, session_idle_timeout,
                                   ?DEFAULT_IDLE_TIMEOUT),
    State#state{idle_timer = schedule_idle(Timeout)}.

%% We embed the Ref inside the message so that stale messages from
%% cancelled timers can be distinguished in handle_info.
-spec schedule_idle(non_neg_integer()) -> reference().
schedule_idle(Timeout) ->
    Ref = make_ref(),
    erlang:send_after(Timeout, self(), {idle_timeout, Ref}),
    Ref.

-spec finalize_session(#state{}) -> ok.
finalize_session(#state{session_id = SessionId, imsi = Imsi, session_type = Type,
                         granted_units = Granted, used_units = Used}) ->
    chf_session_reg:unregister(SessionId),
    Now = erlang:system_time(millisecond),
    Session = #charging_session{
        session_id    = SessionId,
        imsi          = Imsi,
        type          = Type,
        state         = terminated,
        granted_units = Granted,
        used_units    = Used,
        created_at    = Now,
        updated_at    = Now
    },
    _ = chf_db:session_store(Session),
    ok.
