%% SPDX-License-Identifier: AGPL-3.0-or-later
%%
%% Copyright (C) 2026 Nathan Foster <next-nf@proton.me>
%%
%% This program is free software: you can redistribute it and/or modify
%% it under the terms of the GNU Affero General Public License as
%% published by the Free Software Foundation, either version 3 of the
%% License, or (at your option) any later version.
%%
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU Affero General Public License for more details.
%%
%% You should have received a copy of the GNU Affero General Public License
%% along with this program.  If not, see <https://www.gnu.org/licenses/>.

%% chf_core.erl — Public API for the CHF core charging engine.
%%
%% Orchestrates charging session lifecycle with DB-backed state.
%% Session state is persisted in chf_db on every operation so it
%% survives process crashes and node restarts.
-module(chf_core).

-include_lib("chf_db/include/chf_db.hrl").

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

%% @doc Create a new charging session in the database.
%%
%% Info :: #{session_id => binary(), imsi => binary(),
%%           type => online | offline | converged}
-spec create_session(map()) -> {ok, binary()} | {error, term()}.
create_session(#{session_id := SessionId, imsi := Imsi, type := Type}) ->
    Now = erlang:system_time(millisecond),
    Session = #charging_session{
        session_id    = SessionId,
        imsi          = Imsi,
        type          = Type,
        state         = active,
        granted_units = #{},
        used_units    = #{},
        created_at    = Now,
        updated_at    = Now
    },
    case chf_db:session_store(Session) of
        ok -> {ok, SessionId};
        {error, _} = Err -> Err
    end.

%% @doc Handle an initial charging request for a session.
-spec session_initial(SessionId :: binary(), RequestData :: map()) ->
    {ok, map()} | {error, term()}.
session_initial(SessionId, RequestData) ->
    case chf_db:session_lookup(SessionId) of
        {ok, #charging_session{state = active} = Session} ->
            do_initial(Session, RequestData);
        {ok, #charging_session{state = terminated}} ->
            {error, session_terminated};
        {error, not_found} ->
            {error, not_found}
    end.

%% @doc Handle an update (interim) charging request.
-spec session_update(SessionId :: binary(), RequestData :: map()) ->
    {ok, map()} | {error, term()}.
session_update(SessionId, RequestData) ->
    case chf_db:session_lookup(SessionId) of
        {ok, #charging_session{state = active} = Session} ->
            do_update(Session, RequestData);
        {ok, #charging_session{state = terminated}} ->
            {error, session_terminated};
        {error, not_found} ->
            {error, not_found}
    end.

%% @doc Handle a terminate request for a session.
-spec session_terminate(SessionId :: binary(), RequestData :: map()) ->
    ok | {error, term()}.
session_terminate(SessionId, RequestData) ->
    case chf_db:session_lookup(SessionId) of
        {ok, #charging_session{state = active} = Session} ->
            do_terminate(Session, RequestData);
        {ok, #charging_session{state = terminated}} ->
            ok;
        {error, not_found} ->
            {error, not_found}
    end.

%% @doc Look up a session by ID.
-spec find_session(SessionId :: binary()) ->
    {ok, #charging_session{}} | {error, not_found}.
find_session(SessionId) ->
    chf_db:session_lookup(SessionId).

%%====================================================================
%% Internal — Initial
%%====================================================================

do_initial(#charging_session{type = Type, imsi = Imsi,
                              session_id = SessionId} = Session,
           RequestData) ->
    RatingGroups = maps:get(rating_groups, RequestData, []),

    OnlineResult =
        case Type of
            T when T =:= online; T =:= converged ->
                chf_online:initial_request(Imsi, RatingGroups);
            offline ->
                {ok, #{}}
        end,

    case Type of
        T2 when T2 =:= offline; T2 =:= converged ->
            chf_offline:initial_request(Imsi, SessionId);
        online ->
            ok
    end,

    case OnlineResult of
        {ok, GrantedMap} ->
            NewGranted = maps:merge(Session#charging_session.granted_units,
                                    GrantedMap),
            Updated = Session#charging_session{
                granted_units = NewGranted,
                updated_at    = erlang:system_time(millisecond)
            },
            chf_db:session_store(Updated),
            {ok, GrantedMap};
        {error, Reason} ->
            {error, Reason}
    end.

%%====================================================================
%% Internal — Update
%%====================================================================

do_update(#charging_session{type = Type, imsi = Imsi,
                             session_id = SessionId} = Session,
          RequestData) ->
    RatingGroups = maps:get(rating_groups, RequestData, []),

    %% Accumulate used units from this update into session totals.
    NewUsed = lists:foldl(fun(RG, Acc) ->
        RGId = maps:get(rating_group, RG),
        Used = maps:get(used_units, RG, 0),
        Prev = maps:get(RGId, Acc, 0),
        Acc#{RGId => Prev + Used}
    end, Session#charging_session.used_units, RatingGroups),

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
            NewGranted = maps:merge(Session#charging_session.granted_units,
                                    GrantedMap),
            Updated = Session#charging_session{
                granted_units = NewGranted,
                used_units    = NewUsed,
                updated_at    = erlang:system_time(millisecond)
            },
            chf_db:session_store(Updated),
            {ok, GrantedMap};
        {error, Reason} ->
            %% Still persist the used_units even on error.
            Updated = Session#charging_session{
                used_units = NewUsed,
                updated_at = erlang:system_time(millisecond)
            },
            chf_db:session_store(Updated),
            {error, Reason}
    end.

%%====================================================================
%% Internal — Terminate
%%====================================================================

do_terminate(#charging_session{type = Type, imsi = Imsi,
                                session_id = SessionId,
                                granted_units = Granted,
                                used_units = UsedSoFar} = Session,
             RequestData) ->
    RatingGroups = maps:get(rating_groups, RequestData, []),

    %% Merge any final used_units from the terminate request.
    FinalUsed = lists:foldl(fun(RG, Acc) ->
        RGId = maps:get(rating_group, RG),
        Used = maps:get(used_units, RG, 0),
        Prev = maps:get(RGId, Acc, 0),
        Acc#{RGId => Prev + Used}
    end, UsedSoFar, RatingGroups),

    %% Build annotated RatingGroup list with granted amounts for refund.
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

    %% Mark session as terminated in DB.
    Terminated = Session#charging_session{
        state      = terminated,
        used_units = FinalUsed,
        updated_at = erlang:system_time(millisecond)
    },
    chf_db:session_store(Terminated),
    ok.
