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
-moduledoc "Charging session orchestration over the `chf_data` seam.\n"
           "\n"
           "The old `chf_db:session_transaction/2` coupling (session + balance + CDR\n"
           "in one Mnesia activity) is GONE. Each charging operation is now:\n"
           "  1. move money via `chf_data:balance_reserve/commit/refund` — the\n"
           "     AUTHORITATIVE single-document CAS step (a commit stamps the\n"
           "     pending_cdr inside the balance doc; no inline CDR write); then\n"
           "  2. write the DESCRIPTIVE `charging_session` via `chf_data:session_store/1`\n"
           "     (reporting-only reported_used/granted maps, NOT authoritative).\n"
           "The balance move happens FIRST; on a crash between the two the balance is\n"
           "authoritative and the session is reconstructable (Task 6 reconciles).\n"
           "\n"
           "Idempotency tokens are derived from the CCR request identity — the\n"
           "(Session-Id, CC-Request-Number) pair carried on the charging request —\n"
           "plus a phase tag for each money sub-operation. A retransmitted CCR (same\n"
           "Session-Id, same CC-Request-Number) therefore re-derives the SAME token\n"
           "for each sub-op, so chf_balance's idempotency ring returns the prior\n"
           "result without re-charging. The descriptive session's request_seq is\n"
           "retained for reporting only; it is NO LONGER the money-token source (it\n"
           "advances on the persisted session AFTER the money ops, so keying the\n"
           "token on it re-charged a lost-CCA retransmit).".

-include_lib("kernel/include/logger.hrl").

-export([
    create_session/1,
    session_initial/2,
    session_update/2,
    session_terminate/2,
    session_terminate_if_stale/2
]).

%% Per-rating-group charging outcome returned by session_initial/session_update.
-type outcome_map() ::
    #{non_neg_integer() => #{granted => non_neg_integer(),
                             outcome => granted | final_grant | credit_limit_reached}}.
-export_type([outcome_map/0]).

%% Descriptive-session field literals.
-define(F_SESSION_ID,    <<"session_id">>).
-define(F_IMSI,          <<"imsi">>).
-define(F_ACCOUNT_ID,    <<"account_id">>).
-define(F_TYPE,          <<"type">>).
-define(F_STATE,         <<"state">>).
-define(F_GRANTED_UNITS, <<"granted_units">>).
-define(F_USED_UNITS,    <<"used_units">>).
-define(F_REQUEST_SEQ,   <<"request_seq">>).
-define(F_CREATED_AT,    <<"created_at">>).
-define(F_UPDATED_AT,    <<"updated_at">>).

%%====================================================================
%% API
%%====================================================================

-spec create_session(map()) -> {ok, binary()} | {error, term()}.
create_session(#{session_id := SessionId, imsi := Imsi, type := Type}) ->
    Now = now_ms(),
    New = #{?F_SESSION_ID    => SessionId,
            ?F_IMSI          => Imsi,
            ?F_ACCOUNT_ID    => account_id_for(Imsi),
            ?F_TYPE          => type_to_bin(Type),
            ?F_STATE         => <<"active">>,
            ?F_GRANTED_UNITS => #{},
            ?F_USED_UNITS    => #{},
            ?F_REQUEST_SEQ   => 0,
            ?F_CREATED_AT    => Now,
            ?F_UPDATED_AT    => Now},
    case chf_data:session_lookup(SessionId) of
        {ok, #{?F_STATE := <<"active">>}} ->
            {error, session_exists};
        _ ->
            %% undefined / not_found / terminated — (re)create.
            ok = chf_data:session_store(New),
            {ok, SessionId}
    end.

-spec session_initial(SessionId :: binary(), RequestData :: map()) ->
    {ok, outcome_map()} | {error, term()}.
session_initial(SessionId, RequestData) ->
    with_active_session(SessionId, fun(S) -> do_initial(S, RequestData) end).

-spec session_update(SessionId :: binary(), RequestData :: map()) ->
    {ok, outcome_map()} | {error, term()}.
session_update(SessionId, RequestData) ->
    with_active_session(SessionId, fun(S) -> do_update(S, RequestData) end).

-spec session_terminate(SessionId :: binary(), RequestData :: map()) ->
    ok | {error, term()}.
session_terminate(SessionId, RequestData) ->
    case chf_data:session_lookup(SessionId) of
        {ok, #{?F_STATE := <<"active">>} = S} -> do_terminate(S, RequestData);
        {ok, #{?F_STATE := <<"terminated">>}} -> ok;
        {error, not_found}                    -> {error, not_found}
    end.

%% @doc Terminate a session only if it is still stale (used by the sweeper).
%% The staleness re-check happens against the current descriptive session.
-spec session_terminate_if_stale(SessionId :: binary(), MaxAge :: integer()) ->
    ok | skipped | {error, term()}.
session_terminate_if_stale(SessionId, MaxAge) ->
    Now = now_ms(),
    case chf_data:session_lookup(SessionId) of
        {ok, #{?F_STATE := <<"active">>, ?F_UPDATED_AT := U} = S}
          when (Now - U) > MaxAge ->
            do_terminate(S, #{rating_groups => []});
        {ok, #{?F_STATE := <<"active">>}}     -> skipped;
        {ok, #{?F_STATE := <<"terminated">>}} -> ok;
        {error, not_found}                    -> {error, not_found}
    end.

%%====================================================================
%% Internal — dispatch guard
%%====================================================================

with_active_session(SessionId, Fun) ->
    case chf_data:session_lookup(SessionId) of
        {ok, #{?F_STATE := <<"active">>} = S} -> Fun(S);
        {ok, #{?F_STATE := <<"terminated">>}} -> {error, session_terminated};
        {error, not_found}                    -> {error, not_found}
    end.

%%====================================================================
%% Internal — Initial
%%====================================================================

do_initial(Session, RequestData) ->
    Type      = type_atom(maps:get(?F_TYPE, Session)),
    Imsi      = maps:get(?F_IMSI, Session),
    SessionId = maps:get(?F_SESSION_ID, Session),
    Held0     = maps:get(?F_GRANTED_UNITS, Session, #{}),
    RatingGroups = maps:get(rating_groups, RequestData, []),
    Token = idem(SessionId, <<"initial">>, RequestData),
    OnlineResult = case is_online(Type) of
        true  -> chf_online:initial_request(SessionId, Imsi, RatingGroups, Held0, Token);
        false -> {ok, #{}}
    end,
    case OnlineResult of
        {ok, OutcomeMap} ->
            log_charging_error(offline_initial, SessionId,
                               maybe_offline_initial(Type, Imsi, SessionId)),
            NewHeld = add_grants(Held0, granted_amounts(OutcomeMap)),
            Updated = Session#{?F_GRANTED_UNITS => NewHeld,
                               ?F_REQUEST_SEQ   => seq(Session) + 1,
                               ?F_UPDATED_AT    => now_ms()},
            ok = chf_data:session_store(Updated),
            {ok, OutcomeMap};
        {error, Reason} ->
            {error, Reason}
    end.

%%====================================================================
%% Internal — Update
%%====================================================================

do_update(Session, RequestData) ->
    Type      = type_atom(maps:get(?F_TYPE, Session)),
    Imsi      = maps:get(?F_IMSI, Session),
    SessionId = maps:get(?F_SESSION_ID, Session),
    Held0     = maps:get(?F_GRANTED_UNITS, Session, #{}),
    Used0     = maps:get(?F_USED_UNITS, Session, #{}),
    RatingGroups = maps:get(rating_groups, RequestData, []),
    UsedThis  = used_map(RatingGroups),
    NewUsed   = merge_add(Used0, UsedThis),
    UsedTotal = sum(UsedThis),
    IdemBase  = idem(SessionId, <<"update">>, RequestData),
    OnlineResult = case is_online(Type) of
        true  -> chf_online:update_request(SessionId, Imsi, RatingGroups, Held0,
                                           UsedTotal, IdemBase);
        false -> {ok, #{}}
    end,
    case OnlineResult of
        {ok, OutcomeMap} ->
            log_charging_error(offline_update, SessionId,
                               maybe_offline_update(Type, Imsi, SessionId, RatingGroups)),
            Held1   = subtract_used(Held0, UsedThis),
            NewHeld = add_grants(Held1, granted_amounts(OutcomeMap)),
            Updated = Session#{?F_GRANTED_UNITS => NewHeld,
                               ?F_USED_UNITS    => NewUsed,
                               ?F_REQUEST_SEQ   => seq(Session) + 1,
                               ?F_UPDATED_AT    => now_ms()},
            ok = chf_data:session_store(Updated),
            {ok, OutcomeMap};
        {error, Reason} ->
            {error, Reason}
    end.

%%====================================================================
%% Internal — Terminate
%%====================================================================

do_terminate(Session, RequestData) ->
    Type      = type_atom(maps:get(?F_TYPE, Session)),
    Imsi      = maps:get(?F_IMSI, Session),
    SessionId = maps:get(?F_SESSION_ID, Session),
    AccountId = maps:get(?F_ACCOUNT_ID, Session),
    Used0     = maps:get(?F_USED_UNITS, Session, #{}),
    RatingGroups = maps:get(rating_groups, RequestData, []),
    UsedThis  = used_map(RatingGroups),
    FinalUsed = merge_add(Used0, UsedThis),
    UsedTotal = sum(UsedThis),
    IdemBase  = idem(SessionId, <<"terminate">>, RequestData),
    %% Authoritative money FIRST: commit the final reported usage and release the
    %% residual hold for the session. Errors are logged + OTEL-recorded but do
    %% NOT block the terminate — the session must end so it does not linger.
    OnlineRes = case is_online(Type) of
        true  -> chf_online:terminate_request(SessionId, Imsi, UsedTotal,
                                              AccountId, IdemBase);
        false -> ok
    end,
    log_charging_error(online_terminate, SessionId, OnlineRes),
    log_charging_error(offline_terminate, SessionId,
                       maybe_offline_terminate(Type, Imsi, SessionId, FinalUsed)),
    %% Descriptive session write SECOND.
    Terminated = Session#{?F_STATE         => <<"terminated">>,
                          ?F_GRANTED_UNITS => #{},
                          ?F_USED_UNITS    => FinalUsed,
                          ?F_REQUEST_SEQ   => seq(Session) + 1,
                          ?F_UPDATED_AT    => now_ms()},
    ok = chf_data:session_store(Terminated),
    ok.

%%====================================================================
%% Internal — offline dispatch
%%====================================================================

maybe_offline_initial(Type, Imsi, SessionId) when Type =:= offline; Type =:= converged ->
    chf_offline:initial_request(Imsi, SessionId);
maybe_offline_initial(_, _, _) ->
    ok.

maybe_offline_update(Type, Imsi, SessionId, RatingGroups)
  when Type =:= offline; Type =:= converged ->
    chf_offline:update_request(Imsi, #{session_id => SessionId,
                                       rating_groups => RatingGroups});
maybe_offline_update(_, _, _, _) ->
    ok.

maybe_offline_terminate(Type, Imsi, SessionId, FinalUsed)
  when Type =:= offline; Type =:= converged ->
    RGs = [#{rating_group => RG, used_units => U} || {RG, U} <- maps:to_list(FinalUsed)],
    chf_offline:terminate_request(Imsi, #{session_id => SessionId, rating_groups => RGs});
maybe_offline_terminate(_, _, _, _) ->
    ok.

%%====================================================================
%% Internal — helpers
%%====================================================================

is_online(online)    -> true;
is_online(converged) -> true;
is_online(offline)   -> false.

type_to_bin(online)    -> <<"online">>;
type_to_bin(offline)   -> <<"offline">>;
type_to_bin(converged) -> <<"converged">>.

type_atom(<<"online">>)    -> online;
type_atom(<<"offline">>)   -> offline;
type_atom(<<"converged">>) -> converged.

%% account_id lookup for a fresh descriptive session; falls back to <<>> if the
%% subscriber is not (yet) present. The session is descriptive, so a missing
%% account_id here is not fatal — online charging re-resolves via the subscriber.
account_id_for(Imsi) ->
    case chf_data:subscriber_lookup(Imsi) of
        {ok, Sub} -> maps:get(<<"account_id">>, Sub, <<>>);
        _         -> <<>>
    end.

%% Derive a stable idempotency token from the CCR request identity — the
%% (Session-Id, CC-Request-Number) pair carried on the charging request — and a
%% phase tag. The CC-Request-Number is the per-request identity in Gy/Ro/Rf, so a
%% retransmitted CCR (same Session-Id, same CC-Request-Number) re-derives the SAME
%% token for the same phase, and chf_balance's idempotency ring returns the prior
%% result without re-charging. Multiple money sub-ops within one CCR (e.g.
%% commit/grant/refund) each append their own suffix downstream (chf_online), so
%% they stay distinct-but-stable.
%%
%% Fallback: when no CC-Request-Number is present (an internal, non-CCR caller
%% such as the sweeper-driven refund, or an SBI request that has no CCR number),
%% key on the session id + phase alone. A sweeper refund is naturally idempotent
%% via the terminated-state / absent-reservation check, so the token collapsing to
%% one value per session+phase is safe there.
idem(SessionId, Phase, RequestData) ->
    case maps:find(cc_request_number, RequestData) of
        {ok, N} when is_integer(N) ->
            iolist_to_binary([SessionId, $-, Phase, $-, integer_to_binary(N)]);
        _ ->
            iolist_to_binary([SessionId, $-, Phase])
    end.

seq(Session) -> maps:get(?F_REQUEST_SEQ, Session, 0).

now_ms() -> erlang:system_time(millisecond).

used_map(RatingGroups) ->
    lists:foldl(fun(RG, Acc) ->
        RGId = maps:get(rating_group, RG),
        Used = maps:get(used_units, RG, 0),
        Acc#{RGId => maps:get(RGId, Acc, 0) + Used}
    end, #{}, RatingGroups).

add_grants(Held, GrantedMap) ->
    maps:fold(fun(RGId, Granted, Acc) ->
        Acc#{RGId => maps:get(RGId, Acc, 0) + Granted}
    end, Held, GrantedMap).

subtract_used(Held, UsedThis) ->
    maps:fold(fun(RGId, Used, Acc) ->
        Acc#{RGId => max(0, maps:get(RGId, Acc, 0) - Used)}
    end, Held, UsedThis).

merge_add(A, B) ->
    maps:fold(fun(K, V, Acc) -> Acc#{K => maps:get(K, Acc, 0) + V} end, A, B).

sum(M) -> maps:fold(fun(_K, V, Acc) -> Acc + V end, 0, M).

%% Project an outcome map (#{RGId => #{granted => G, outcome => _}}) down to
%% a plain grant map (#{RGId => G}).
-spec granted_amounts(outcome_map()) -> #{non_neg_integer() => non_neg_integer()}.
granted_amounts(OutcomeMap) ->
    maps:map(fun(_RGId, #{granted := G}) -> G end, OutcomeMap).

log_charging_error(_Stage, _SessionId, ok) -> ok;
log_charging_error(Stage, SessionId, {error, Reason}) ->
    ?LOG_ERROR("chf_core: ~p for session ~s reported errors; balance/CDR state "
               "may be inconsistent: ~p", [Stage, SessionId, Reason]),
    ok.
