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

-define(DEFAULT_QUOTA, 10000000).  %% micro-units

%%====================================================================
%% API
%%====================================================================

%% @doc Handle an initial charging request for a set of RatingGroups.
%%
%% RatingGroups :: [#{rating_group => non_neg_integer(),
%%                    requested_units => integer()}]
%%
%% Returns {ok, #{RatingGroup => GrantedAmount}} or {error, Reason}.
-spec initial_request(Imsi :: binary(), RatingGroups :: [map()]) ->
    {ok, #{non_neg_integer() => integer()}} | {error, term()}.
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
    {ok, #{non_neg_integer() => integer()}} | {error, term()}.
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
            lists:foreach(fun(RG) ->
                Used     = maps:get(used_units,     RG, 0),
                Reserved = maps:get(reserved_units, RG, 0),
                Refund   = max(0, Reserved - Used),
                if Used   > 0 -> _ = chf_db:balance_commit(AccountId, Used); true -> ok end,
                if Refund > 0 -> _ = chf_db:balance_refund(AccountId, Refund); true -> ok end
            end, RatingGroups),
            ok;
        {error, not_found} ->
            {error, subscriber_not_found}
    end.

%%====================================================================
%% Internal helpers
%%====================================================================

-spec lookup_active_subscriber(binary()) ->
    {ok, #subscriber{}} | {error, subscriber_not_found | subscriber_suspended}.
lookup_active_subscriber(Imsi) ->
    case chf_db:subscriber_lookup(Imsi) of
        {ok, #subscriber{status = active} = Sub} ->
            {ok, Sub};
        {ok, #subscriber{status = suspended}} ->
            {error, subscriber_suspended};
        {ok, #subscriber{status = terminated}} ->
            {error, subscriber_suspended};
        {error, not_found} ->
            {error, subscriber_not_found}
    end.

%% Reserve quota for each RatingGroup, accumulating granted amounts.
-spec grant_units(#subscriber{}, [map()], #{non_neg_integer() => integer()}) ->
    {ok, #{non_neg_integer() => integer()}} | {error, term()}.
grant_units(_Sub, [], Acc) ->
    {ok, Acc};
grant_units(Sub, [RG | Rest], Acc) ->
    AccountId   = Sub#subscriber.account_id,
    RGId        = maps:get(rating_group, RG),
    Requested   = maps:get(requested_units, RG, 0),
    DefaultQuota = rg_quota(Sub, RGId),
    GrantAmount  = min(Requested, DefaultQuota),
    case chf_db:balance_reserve(AccountId, GrantAmount) of
        {ok, _Balance} ->
            grant_units(Sub, Rest, Acc#{RGId => GrantAmount});
        {error, Reason} ->
            {error, Reason}
    end.

%% Commit used units for each RatingGroup.
-spec commit_used(binary(), [map()]) -> ok | {error, term()}.
commit_used(_AccountId, []) ->
    ok;
commit_used(AccountId, [RG | Rest]) ->
    Used = maps:get(used_units, RG, 0),
    case chf_db:balance_commit(AccountId, Used) of
        {ok, _} -> commit_used(AccountId, Rest);
        {error, Reason} -> {error, Reason}
    end.

%% Retrieve the configured quota for a RatingGroup (falls back to default).
-spec rg_quota(#subscriber{}, non_neg_integer()) -> integer().
rg_quota(Sub, RGId) ->
    RGMap = Sub#subscriber.rating_groups,
    case maps:find(RGId, RGMap) of
        {ok, #{quota := Q}} -> Q;
        _                   -> ?DEFAULT_QUOTA
    end.
