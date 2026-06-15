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
%% Called by chf_session for online/converged sessions.
%% All balance operations go through chf_db, which delegates to the
%% configured backend (default: chf_db_mnesia).
-module(chf_online).

-include_lib("chf_db/include/chf_db.hrl").

-export([initial_request/2, update_request/2, terminate_request/2]).

%%====================================================================
%% API
%%====================================================================

%% @doc Handle an initial charging request for a set of RatingGroups.
%%
%% RatingGroups :: [#{rating_group => non_neg_integer(),
%%                    requested_units => integer()}]
%%
%% Returns {ok, #{RatingGroup => #{granted => integer(), outcome => atom()}}}
%% or {error, Reason}.
-spec initial_request(Imsi :: binary(), RatingGroups :: [map()]) ->
    {ok, #{non_neg_integer() => #{granted => non_neg_integer(),
                                  outcome => granted | final_grant | credit_limit_reached}}} |
    {error, term()}.
initial_request(Imsi, RatingGroups) ->
    case lookup_active_subscriber(Imsi) of
        {ok, Sub} ->
            grant_units(Sub, RatingGroups, #{});
        {error, _} = Err ->
            Err
    end.

%% @doc Handle an update (interim) charging request.
%%
%% RatingGroups :: [#{rating_group  => non_neg_integer(),
%%                    used_units    => integer(),
%%                    requested_units => integer()}]
-spec update_request(Imsi :: binary(), RatingGroups :: [map()]) ->
    {ok, #{non_neg_integer() => #{granted => non_neg_integer(),
                                  outcome => granted | final_grant | credit_limit_reached}}} |
    {error, term()}.
update_request(Imsi, RatingGroups) ->
    case lookup_active_subscriber(Imsi) of
        {ok, Sub} ->
            AccountId = Sub#subscriber.account_id,
            %% First commit all used units, then re-grant.
            case commit_used(AccountId, RatingGroups) of
                ok ->
                    grant_units(Sub, RatingGroups, #{});
                {error, _} = Err ->
                    Err
            end;
        {error, _} = Err ->
            Err
    end.

%% @doc Handle a session-terminate charging request.
%%
%% RatingGroups :: [#{rating_group   => non_neg_integer(),
%%                    used_units     => integer(),   %% final delta usage
%%                    reserved_units => integer()}]   %% outstanding reservation
-spec terminate_request(Imsi :: binary(), RatingGroups :: [map()]) ->
    ok | {error, term()}.
terminate_request(Imsi, RatingGroups) ->
    case chf_db:subscriber_lookup(Imsi) of
        {ok, Sub} ->
            AccountId = Sub#subscriber.account_id,
            %% Commit final usage and refund the unused reservation per RG.
            %% Capture each balance-op result: record the *real* OTEL outcome and
            %% accumulate failures so the caller can observe (and alert on) lost
            %% money rather than the previous behaviour of discarding the result
            %% and recording an unconditional `ok`.
            Errors = lists:foldl(fun(RG, ErrAcc0) ->
                Used     = maps:get(used_units,     RG, 0),
                Reserved = maps:get(reserved_units, RG, 0),
                Refund   = max(0, Reserved - Used),
                ErrAcc1 = if Used > 0 ->
                                 record_balance_op(commit, AccountId, Used, ErrAcc0);
                             true -> ErrAcc0
                          end,
                if Refund > 0 ->
                       record_balance_op(refund, AccountId, Refund, ErrAcc1);
                   true -> ErrAcc1
                end
            end, [], RatingGroups),
            case Errors of
                [] -> ok;
                _  -> {error, {terminate_balance_errors, lists:reverse(Errors)}}
            end;
        {error, not_found} ->
            {error, subscriber_not_found}
    end.

%% Apply one terminate-time balance op (commit|refund), record the real OTEL
%% outcome, and prepend {Op, Reason} to the error accumulator on failure.
-spec record_balance_op(commit | refund, binary(), integer(), [term()]) -> [term()].
record_balance_op(commit, AccountId, Amount, ErrAcc) ->
    classify(commit, chf_db:balance_commit(AccountId, Amount), ErrAcc);
record_balance_op(refund, AccountId, Amount, ErrAcc) ->
    classify(refund, chf_db:balance_refund(AccountId, Amount), ErrAcc).

classify(Op, {ok, _}, ErrAcc) ->
    chf_otel:record_balance_op(Op, ok),
    ErrAcc;
classify(Op, {error, Reason}, ErrAcc) ->
    chf_otel:record_balance_op(Op, Reason),
    [{Op, Reason} | ErrAcc].

%%====================================================================
%% Internal helpers
%%====================================================================

-spec lookup_active_subscriber(binary()) ->
    {ok, #subscriber{}} |
    {error, subscriber_not_found | subscriber_suspended | subscriber_terminated}.
lookup_active_subscriber(Imsi) ->
    case chf_db:subscriber_lookup(Imsi) of
        {ok, #subscriber{status = active} = Sub} ->
            {ok, Sub};
        {ok, #subscriber{status = suspended}} ->
            {error, subscriber_suspended};
        {ok, #subscriber{status = terminated}} ->
            {error, subscriber_terminated};
        {error, not_found} ->
            {error, subscriber_not_found}
    end.

%% Reserve quota for each RatingGroup, accumulating per-RG outcome maps.
%% Never returns {error, _}: balance exhaustion / a missing balance record is
%% absorbed into the credit_limit_reached outcome (see reserve_rg/2).
-spec grant_units(#subscriber{}, [map()],
                  #{non_neg_integer() => #{granted => non_neg_integer(),
                                           outcome => granted | final_grant | credit_limit_reached}}) ->
    {ok, #{non_neg_integer() => #{granted => non_neg_integer(),
                                  outcome => granted | final_grant | credit_limit_reached}}}.
grant_units(_Sub, [], Acc) ->
    {ok, Acc};
grant_units(Sub, [RG | Rest], Acc) ->
    AccountId = Sub#subscriber.account_id,
    RGId      = maps:get(rating_group, RG),
    Requested = maps:get(requested_units, RG, 0),
    Desired   = min(Requested, rg_quota(Sub, RGId)),
    {Granted, Outcome} = reserve_rg(AccountId, Desired),
    grant_units(Sub, Rest, Acc#{RGId => #{granted => Granted, outcome => Outcome}}).

-spec reserve_rg(binary(), non_neg_integer()) ->
    {non_neg_integer(), granted | final_grant | credit_limit_reached}.
reserve_rg(_AccountId, 0) -> {0, granted};
reserve_rg(AccountId, Desired) ->
    case chf_db:balance_reserve_up_to(AccountId, Desired) of
        {ok, Desired, _}                         -> chf_otel:record_balance_op(reserve, ok),
                                                    {Desired, granted};
        {ok, 0, _}                               -> chf_otel:record_balance_op(reserve, credit_limit_reached),
                                                    {0, credit_limit_reached};
        {ok, Granted, _} when Granted < Desired  -> chf_otel:record_balance_op(reserve, ok),
                                                    {Granted, final_grant};
        {error, not_found}                       -> chf_otel:record_balance_op(reserve, credit_limit_reached),
                                                    {0, credit_limit_reached}
    end.

%% Commit used units for each RatingGroup.
-spec commit_used(binary(), [map()]) -> ok | {error, term()}.
commit_used(_AccountId, []) ->
    ok;
commit_used(AccountId, [RG | Rest]) ->
    Used = maps:get(used_units, RG, 0),
    case chf_db:balance_commit(AccountId, Used) of
        {ok, _} ->
            chf_otel:record_balance_op(commit, ok),
            commit_used(AccountId, Rest);
        {error, Reason} ->
            chf_otel:record_balance_op(commit, Reason),
            {error, Reason}
    end.

%% Retrieve the configured quota for a RatingGroup (falls back to default).
-spec rg_quota(#subscriber{}, non_neg_integer()) -> integer().
rg_quota(Sub, RGId) ->
    RGMap = Sub#subscriber.rating_groups,
    case maps:find(RGId, RGMap) of
        {ok, #{quota := Q}} -> Q;
        %% Read from the chf_core app env (chf_online is a module of chf_core,
        %% not a loaded application — a {chf_online,...} sys.config block would
        %% be silently ignored).
        _                   -> application:get_env(chf_core, default_quota, 10000000)
    end.
