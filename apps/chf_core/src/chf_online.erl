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

%% chf_online.erl — Stateless online charging logic.
%%
%% Called by chf_core for online/converged sessions. All money moves through the
%% chf_data seam's single-document balance operations (reserve/commit/refund),
%% each an atomic CAS read-modify-write inside the backend transaction.
%%
%% Reservation model (Phase 1): the balance holds ONE reservation per session,
%% keyed by SessionId. A session's grant across several rating groups is summed
%% into that single hold — reserve REPLACES the hold with the new cumulative
%% amount, so the caller passes the running total it wants held. The per-RG grant
%% breakdown and the reporting-only used/granted maps live on the DESCRIPTIVE
%% charging_session (chf_core), not here.
%%
%% Idempotency: every money op carries a stable IdemToken derived from the
%% charging request identity (see chf_core), so a retransmitted CCR does not
%% double-charge.
-module(chf_online).

-export([initial_request/5, update_request/6, terminate_request/5]).

-type outcome() :: granted | final_grant | credit_limit_reached.
-type outcome_map() ::
    #{non_neg_integer() => #{granted => non_neg_integer(), outcome => outcome()}}.
-export_type([outcome_map/0]).

%%====================================================================
%% API
%%====================================================================

%% @doc Handle an initial charging request for a set of RatingGroups.
%%
%% RatingGroups :: [#{rating_group => non_neg_integer(),
%%                    requested_units => integer()}]
%% HeldByRG :: #{non_neg_integer() => non_neg_integer()} — the currently-held
%%             grant per RG for this session (empty on a fresh session).
%%
%% Returns {ok, OutcomeMap} where OutcomeMap is the per-RG grant decision, or
%% {error, Reason} if the subscriber is missing / not active.
-spec initial_request(SessionId :: binary(), Imsi :: binary(),
                      RatingGroups :: [map()],
                      HeldByRG :: #{non_neg_integer() => non_neg_integer()},
                      IdemToken :: binary()) ->
    {ok, outcome_map()} | {error, term()}.
initial_request(SessionId, Imsi, RatingGroups, HeldByRG, IdemToken) ->
    case lookup_active_subscriber(Imsi) of
        {ok, Sub} ->
            grant(SessionId, Sub, RatingGroups, HeldByRG, IdemToken);
        {error, _} = Err ->
            Err
    end.

%% @doc Handle an update (interim) charging request: commit the reported used
%% units for the session, then re-grant for the requested units.
%%
%% RatingGroups :: [#{rating_group  => non_neg_integer(),
%%                    used_units    => integer(),
%%                    requested_units => integer()}]
-spec update_request(SessionId :: binary(), Imsi :: binary(),
                     RatingGroups :: [map()],
                     HeldByRG :: #{non_neg_integer() => non_neg_integer()},
                     TotalUsed :: non_neg_integer(),
                     IdemBase :: binary()) ->
    {ok, outcome_map()} | {error, term()}.
update_request(SessionId, Imsi, RatingGroups, HeldByRG, TotalUsed, IdemBase) ->
    case lookup_active_subscriber(Imsi) of
        {ok, Sub} ->
            AccountId = maps:get(<<"account_id">>, Sub),
            %% Commit the cumulative reported usage first (authoritative money
            %% step). The commit clamps to the held amount and reduces the hold;
            %% the residual stays reserved. Then re-grant on top of the residual.
            case commit_used(AccountId, SessionId, TotalUsed,
                             <<IdemBase/binary, "-commit">>) of
                ok ->
                    HeldByRG1 = drain_held(HeldByRG, TotalUsed),
                    grant(SessionId, Sub, RatingGroups, HeldByRG1,
                          <<IdemBase/binary, "-grant">>);
                {error, _} = Err ->
                    Err
            end;
        {error, _} = Err ->
            Err
    end.

%% @doc Handle a session-terminate charging request: commit the final reported
%% usage, then release (refund) whatever remains held for the session.
-spec terminate_request(SessionId :: binary(), Imsi :: binary(),
                        TotalUsed :: non_neg_integer(),
                        AccountId :: binary(), IdemBase :: binary()) ->
    ok | {error, term()}.
terminate_request(SessionId, _Imsi, TotalUsed, AccountId, IdemBase) ->
    %% Commit final usage (may be 0), then release the residual hold. Both are
    %% idempotent on their tokens, so a retransmitted terminate is a no-op.
    CommitRes = case TotalUsed > 0 of
                    true  -> classify(commit, chf_data:balance_commit(
                                AccountId, SessionId, TotalUsed,
                                chf_data:cdr_generate_id(),
                                <<IdemBase/binary, "-commit">>));
                    false -> ok
                end,
    RefundRes = classify(refund, chf_data:balance_refund(
                    AccountId, SessionId, <<IdemBase/binary, "-refund">>)),
    case {CommitRes, RefundRes} of
        {ok, ok} -> ok;
        _        -> {error, {terminate_balance_errors,
                             [E || E <- [CommitRes, RefundRes], E =/= ok]}}
    end.

%%====================================================================
%% Internal helpers
%%====================================================================

-spec lookup_active_subscriber(binary()) ->
    {ok, map()} |
    {error, subscriber_not_found | subscriber_suspended | subscriber_terminated}.
lookup_active_subscriber(Imsi) ->
    case chf_data:subscriber_lookup(Imsi) of
        {ok, #{<<"status">> := <<"active">>} = Sub}     -> {ok, Sub};
        {ok, #{<<"status">> := <<"suspended">>}}        -> {error, subscriber_suspended};
        {ok, #{<<"status">> := <<"terminated">>}}       -> {error, subscriber_terminated};
        {ok, _Sub}                                      -> {error, subscriber_suspended};
        {error, not_found}                              -> {error, subscriber_not_found}
    end.

%% Compute the per-RG grant for this request by draining the account's currently
%% available balance, then reserve the new cumulative session hold in one op.
%% Available is read once; grants are apportioned in RG order (matching the old
%% sequential-drain behaviour). The new cumulative hold is
%% (existing held total) + (sum of new grants).
-spec grant(binary(), map(), [map()],
            #{non_neg_integer() => non_neg_integer()}, binary()) ->
    {ok, outcome_map()} | {error, term()}.
grant(SessionId, Sub, RatingGroups, HeldByRG, IdemToken) ->
    AccountId = maps:get(<<"account_id">>, Sub),
    Available = available(AccountId),
    {Outcomes, GrantByRG, TotalNew} =
        apportion(Sub, RatingGroups, Available, #{}, #{}, 0),
    case TotalNew of
        0 ->
            %% Nothing new to hold; leave the existing reservation untouched.
            {ok, Outcomes};
        _ ->
            NewHeldByRG = merge_add(HeldByRG, GrantByRG),
            NewHoldTotal = maps:fold(fun(_RG, V, Acc) -> Acc + V end, 0, NewHeldByRG),
            RGTag = rg_tag(GrantByRG),
            case chf_data:balance_reserve(AccountId, SessionId, RGTag,
                                          NewHoldTotal, IdemToken) of
                ok ->
                    chf_otel:record_balance_op(reserve, ok),
                    {ok, Outcomes};
                {error, insufficient_balance} ->
                    %% Should not happen (we sized to available), but degrade to
                    %% credit_limit_reached rather than failing the request.
                    chf_otel:record_balance_op(reserve, credit_limit_reached),
                    {ok, all_credit_limited(RatingGroups)};
                {error, not_found} ->
                    chf_otel:record_balance_op(reserve, credit_limit_reached),
                    {ok, all_credit_limited(RatingGroups)}
            end
    end.

%% Walk the requested RGs, granting min(requested, quota, remaining-available)
%% for each and tagging the outcome. Accumulates the per-RG grant map and the
%% total newly-granted amount.
apportion(_Sub, [], _Remaining, Outcomes, GrantByRG, TotalNew) ->
    {Outcomes, GrantByRG, TotalNew};
apportion(Sub, [RG | Rest], Remaining, Outcomes, GrantByRG, TotalNew) ->
    RGId      = maps:get(rating_group, RG),
    Requested = maps:get(requested_units, RG, 0),
    Desired   = min(Requested, rg_quota(Sub, RGId)),
    Grant     = min(Desired, max(0, Remaining)),
    Outcome   = outcome_for(Desired, Grant),
    Outcomes1 = Outcomes#{RGId => #{granted => Grant, outcome => Outcome}},
    GrantByRG1 = case Grant > 0 of
                     true  -> GrantByRG#{RGId => maps:get(RGId, GrantByRG, 0) + Grant};
                     false -> GrantByRG
                 end,
    apportion(Sub, Rest, Remaining - Grant, Outcomes1, GrantByRG1, TotalNew + Grant).

-spec outcome_for(non_neg_integer(), non_neg_integer()) -> outcome().
outcome_for(0, 0)                        -> granted;
outcome_for(_Desired, 0)                 -> credit_limit_reached;
outcome_for(Desired, Grant) when Grant < Desired -> final_grant;
outcome_for(_Desired, _Grant)            -> granted.

%% Commit reported usage for the session (authoritative). Best-effort: a failure
%% is recorded and surfaced to the caller as {error, _}.
-spec commit_used(binary(), binary(), non_neg_integer(), binary()) ->
    ok | {error, term()}.
commit_used(_AccountId, _SessionId, 0, _Token) ->
    ok;
commit_used(AccountId, SessionId, Used, Token) ->
    CdrId = chf_data:cdr_generate_id(),
    case classify(commit, chf_data:balance_commit(AccountId, SessionId, Used,
                                                  CdrId, Token)) of
        ok    -> ok;
        Error -> {error, Error}
    end.

classify(Op, ok) ->
    chf_otel:record_balance_op(Op, ok),
    ok;
classify(Op, {error, Reason}) ->
    chf_otel:record_balance_op(Op, Reason),
    {Op, Reason}.

%% available/1 — read the account's derived available balance (0 if no row).
-spec available(binary()) -> non_neg_integer().
available(AccountId) ->
    case chf_data:balance_get(AccountId) of
        {ok, Bal}          -> max(0, chf_balance:available(Bal));
        {error, not_found} -> 0
    end.

%% Reduce the per-RG held map after a commit consumed `Used` (in RG order).
drain_held(HeldByRG, Used) ->
    {Result, _Left} =
        lists:foldl(fun({RGId, Held}, {Acc, Left}) ->
            Take = min(Held, Left),
            Remaining = Held - Take,
            Acc1 = case Remaining > 0 of
                       true  -> Acc#{RGId => Remaining};
                       false -> Acc
                   end,
            {Acc1, Left - Take}
        end, {#{}, Used}, maps:to_list(HeldByRG)),
    Result.

merge_add(A, B) ->
    maps:fold(fun(K, V, Acc) -> Acc#{K => maps:get(K, Acc, 0) + V} end, A, B).

%% Pick a representative RG tag (binary) for the aggregated reservation. The
%% reservation holds a session-wide sum; the tag is informational only.
rg_tag(GrantByRG) ->
    case maps:keys(GrantByRG) of
        [RGId | _] -> integer_to_binary(RGId);
        []         -> <<>>
    end.

all_credit_limited(RatingGroups) ->
    lists:foldl(fun(RG, Acc) ->
        RGId = maps:get(rating_group, RG),
        Acc#{RGId => #{granted => 0, outcome => credit_limit_reached}}
    end, #{}, RatingGroups).

%% Retrieve the configured quota for a RatingGroup (falls back to default).
-spec rg_quota(map(), non_neg_integer()) -> integer().
rg_quota(Sub, RGId) ->
    RGMap = maps:get(<<"rating_groups">>, Sub, #{}),
    case maps:find(RGId, RGMap) of
        {ok, #{quota := Q}} -> Q;
        _                   -> application:get_env(chf_core, default_quota, 10000000)
    end.
