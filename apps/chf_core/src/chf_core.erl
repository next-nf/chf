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

-module(chf_core).

-include_lib("chf_db/include/chf_db.hrl").
-include_lib("kernel/include/logger.hrl").

-export([
    create_session/1,
    session_initial/2,
    session_update/2,
    session_terminate/2,
    session_terminate_if_stale/2
]).

%% Per-rating-group charging outcome returned by session_initial/session_update.
%% For offline-only sessions the map is empty (no online grant processing).
-type outcome_map() ::
    #{non_neg_integer() => #{granted => non_neg_integer(),
                             outcome => granted | final_grant | credit_limit_reached}}.
-export_type([outcome_map/0]).

%%====================================================================
%% API
%%====================================================================

-spec create_session(map()) -> {ok, binary()} | {error, term()}.
create_session(#{session_id := SessionId, imsi := Imsi, type := Type}) ->
    Now = now_ms(),
    New = #charging_session{
        session_id    = SessionId,
        imsi          = Imsi,
        type          = Type,
        state         = active,
        granted_units = #{},
        used_units    = #{},
        created_at    = Now,
        updated_at    = Now
    },
    chf_db:session_transaction(SessionId, fun
        (_Ctx, undefined) ->
            {commit, New, {ok, SessionId}};
        (_Ctx, #charging_session{state = terminated}) ->
            {commit, New, {ok, SessionId}};
        (_Ctx, #charging_session{state = active}) ->
            {abort, session_exists}
    end).

-spec session_initial(SessionId :: binary(), RequestData :: map()) ->
    {ok, outcome_map()} | {error, term()}.
session_initial(SessionId, RequestData) ->
    with_quorum(fun() ->
        chf_db:session_transaction(SessionId, fun
            (Ctx, #charging_session{state = active} = S) -> do_initial(Ctx, S, RequestData);
            (_Ctx, #charging_session{state = terminated}) -> {abort, session_terminated};
            (_Ctx, undefined)                             -> {abort, not_found}
        end)
    end).

-spec session_update(SessionId :: binary(), RequestData :: map()) ->
    {ok, outcome_map()} | {error, term()}.
session_update(SessionId, RequestData) ->
    with_quorum(fun() ->
        chf_db:session_transaction(SessionId, fun
            (Ctx, #charging_session{state = active} = S) -> do_update(Ctx, S, RequestData);
            (_Ctx, #charging_session{state = terminated}) -> {abort, session_terminated};
            (_Ctx, undefined)                             -> {abort, not_found}
        end)
    end).

-spec session_terminate(SessionId :: binary(), RequestData :: map()) ->
    ok | {error, term()}.
session_terminate(SessionId, RequestData) ->
    with_quorum(fun() ->
        chf_db:session_transaction(SessionId, fun
            (Ctx, #charging_session{state = active} = S) -> do_terminate(Ctx, S, RequestData);
            (_Ctx, #charging_session{state = terminated}) -> {result, ok};
            (_Ctx, undefined)                             -> {abort, not_found}
        end)
    end).

%% @doc Terminate a session only if it is still stale (used by the sweeper).
%% The staleness re-check happens under the session write lock against the
%% current record, closing the snapshot race.
-spec session_terminate_if_stale(SessionId :: binary(), MaxAge :: integer()) ->
    ok | skipped | {error, term()}.
session_terminate_if_stale(SessionId, MaxAge) ->
    with_quorum(fun() ->
        Now = now_ms(),
        chf_db:session_transaction(SessionId, fun
            (Ctx, #charging_session{state = active, updated_at = U} = S)
              when (Now - U) > MaxAge ->
                do_terminate(Ctx, S, #{rating_groups => []});
            (_Ctx, #charging_session{state = active}) ->
                {result, skipped};
            (_Ctx, #charging_session{state = terminated}) ->
                {result, ok};
            (_Ctx, undefined) ->
                {result, {error, not_found}}
        end)
    end).

%%====================================================================
%% Internal — Initial
%%====================================================================

do_initial(Ctx,
           #charging_session{type = Type, imsi = Imsi, session_id = SessionId,
                             granted_units = Outstanding0} = Session,
           RequestData) ->
    RatingGroups = maps:get(rating_groups, RequestData, []),
    OnlineResult = case is_online(Type) of
        true  -> chf_online:initial_request(Ctx, Imsi, RatingGroups);
        false -> {ok, #{}}
    end,
    case OnlineResult of
        {ok, OutcomeMap} ->
            log_charging_error(offline_initial, SessionId,
                               maybe_offline_initial(Ctx, Type, Imsi, SessionId)),
            NewOutstanding = add_grants(Outstanding0, granted_amounts(OutcomeMap)),
            Updated = Session#charging_session{
                granted_units = NewOutstanding,
                updated_at    = now_ms()
            },
            {commit, Updated, {ok, OutcomeMap}};
        {error, Reason} ->
            {abort, Reason}
    end.

%%====================================================================
%% Internal — Update
%%====================================================================

do_update(Ctx,
          #charging_session{type = Type, imsi = Imsi, session_id = SessionId,
                            granted_units = Outstanding0,
                            used_units = Used0} = Session,
          RequestData) ->
    RatingGroups = maps:get(rating_groups, RequestData, []),
    UsedThis = used_map(RatingGroups),
    NewUsed  = merge_add(Used0, UsedThis),
    OnlineResult = case is_online(Type) of
        true  -> chf_online:update_request(Ctx, Imsi, RatingGroups);
        false -> {ok, #{}}
    end,
    case OnlineResult of
        {ok, OutcomeMap} ->
            log_charging_error(offline_update, SessionId,
                               maybe_offline_update(Ctx, Type, Imsi, SessionId, RatingGroups)),
            Outstanding1   = subtract_used(Outstanding0, UsedThis),
            NewOutstanding = add_grants(Outstanding1, granted_amounts(OutcomeMap)),
            Updated = Session#charging_session{
                granted_units = NewOutstanding,
                used_units    = NewUsed,
                updated_at    = now_ms()
            },
            {commit, Updated, {ok, OutcomeMap}};
        {error, Reason} ->
            {abort, Reason}
    end.

%%====================================================================
%% Internal — Terminate
%%====================================================================

do_terminate(Ctx,
             #charging_session{type = Type, imsi = Imsi, session_id = SessionId,
                               granted_units = Outstanding0,
                               used_units = Used0} = Session,
             RequestData) ->
    RatingGroups = maps:get(rating_groups, RequestData, []),
    UsedThis  = used_map(RatingGroups),
    FinalUsed = merge_add(Used0, UsedThis),
    RGKeys = lists:usort(maps:keys(Outstanding0) ++ maps:keys(UsedThis)),
    Instr = [#{rating_group   => RG,
               used_units     => maps:get(RG, UsedThis, 0),
               reserved_units => maps:get(RG, Outstanding0, 0)} || RG <- RGKeys],
    OnlineRes = case is_online(Type) of
        true  -> chf_online:terminate_request(Ctx, Imsi, Instr);
        false -> ok
    end,
    log_charging_error(online_terminate, SessionId, OnlineRes),
    log_charging_error(offline_terminate, SessionId,
                       maybe_offline_terminate(Ctx, Type, Imsi, SessionId, FinalUsed)),
    %% Terminate always commits: a charging session must end (otherwise it blocks
    %% re-use and lingers for the sweeper). Balance/CDR failures above are logged
    %% (and OTEL-recorded in chf_online) so the discrepancy is observable/alertable
    %% rather than silently swallowed.
    Terminated = Session#charging_session{
        state         = terminated,
        granted_units = #{},
        used_units    = FinalUsed,
        updated_at    = now_ms()
    },
    {commit, Terminated, ok}.

%%====================================================================
%% Internal — offline dispatch
%%====================================================================

maybe_offline_initial(Ctx, Type, Imsi, SessionId) when Type =:= offline; Type =:= converged ->
    chf_offline:initial_request(Ctx, Imsi, SessionId);
maybe_offline_initial(_, _, _, _) ->
    ok.

maybe_offline_update(Ctx, Type, Imsi, SessionId, RatingGroups)
  when Type =:= offline; Type =:= converged ->
    chf_offline:update_request(Ctx, Imsi, #{session_id => SessionId,
                                            rating_groups => RatingGroups});
maybe_offline_update(_, _, _, _, _) ->
    ok.

maybe_offline_terminate(Ctx, Type, Imsi, SessionId, FinalUsed)
  when Type =:= offline; Type =:= converged ->
    RGs = [#{rating_group => RG, used_units => U} || {RG, U} <- maps:to_list(FinalUsed)],
    chf_offline:terminate_request(Ctx, Imsi, #{session_id => SessionId, rating_groups => RGs});
maybe_offline_terminate(_, _, _, _, _) ->
    ok.

%%====================================================================
%% Internal — helpers
%%====================================================================

is_online(online)    -> true;
is_online(converged) -> true;
is_online(offline)   -> false.

%% Charging side-effects (balance ops, CDR writes) are best-effort with respect
%% to the session state machine: a failure must not silently vanish, but neither
%% should it abort a terminate or leave the session wedged. Log at ERROR so the
%% inconsistency is observable; chf_online additionally records OTEL outcomes.
log_charging_error(_Stage, _SessionId, ok)      -> ok;
log_charging_error(Stage, SessionId, {error, Reason}) ->
    ?LOG_ERROR("chf_core: ~p for session ~s reported errors; balance/CDR state "
               "may be inconsistent: ~p", [Stage, SessionId, Reason]),
    ok.

now_ms() -> erlang:system_time(millisecond).

used_map(RatingGroups) ->
    lists:foldl(fun(RG, Acc) ->
        RGId = maps:get(rating_group, RG),
        Used = maps:get(used_units, RG, 0),
        Acc#{RGId => maps:get(RGId, Acc, 0) + Used}
    end, #{}, RatingGroups).

add_grants(Outstanding, GrantedMap) ->
    maps:fold(fun(RGId, Granted, Acc) ->
        Acc#{RGId => maps:get(RGId, Acc, 0) + Granted}
    end, Outstanding, GrantedMap).

subtract_used(Outstanding, UsedThis) ->
    maps:fold(fun(RGId, Used, Acc) ->
        Acc#{RGId => max(0, maps:get(RGId, Acc, 0) - Used)}
    end, Outstanding, UsedThis).

merge_add(A, B) ->
    maps:fold(fun(K, V, Acc) -> Acc#{K => maps:get(K, Acc, 0) + V} end, A, B).

%% Project an outcome map (#{RGId => #{granted => G, outcome => _}}) down to
%% a plain grant map (#{RGId => G}) for use with add_grants/subtract_used.
-spec granted_amounts(outcome_map()) -> #{non_neg_integer() => non_neg_integer()}.
granted_amounts(OutcomeMap) ->
    maps:map(fun(_RGId, #{granted := G}) -> G end, OutcomeMap).

%% Guard: only execute Fun() when this node is in quorum (strict majority of
%% configured cluster nodes reachable).  On a minority partition, charging
%% mutations are refused with {error, no_quorum} — fail-closed so a split-brain
%% node cannot double-spend balances while the majority side continues operating.
%% create_session/1 is intentionally NOT gated: writing a new session record
%% carries no balance risk.  The session_initial that follows IS gated and will
%% return no_quorum, so the record is created but never charged; any such
%% orphaned session is reclaimed by the sweeper once quorum is restored.
-spec with_quorum(fun(() -> R)) -> R | {error, no_quorum}.
with_quorum(Fun) ->
    case chf_cluster:in_quorum() of
        true  -> Fun();
        false -> {error, no_quorum}
    end.
