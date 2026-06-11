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

%% chf_sbi_error.erl — RFC 7807 Problem Details helper for the 5G CHF REST API.
%%
%% Builds and sends application/problem+json responses as required by
%% 3GPP TS 32.291 and RFC 7807.
-module(chf_sbi_error).

-export([problem_details/3, reply_error/4, reason_to_problem/1]).

%%====================================================================
%% API
%%====================================================================

%% @doc Build an RFC 7807 Problem Details JSON body.
%%
%% problem_details(Status, Title, Detail) -> binary()
-spec problem_details(non_neg_integer(), binary(), binary()) -> binary().
problem_details(Status, Title, Detail) ->
    chf_sbi_json:encode(#{
        <<"type">>   => <<"about:blank">>,
        <<"title">>  => Title,
        <<"status">> => Status,
        <<"detail">> => Detail
    }).

%% @doc Send an RFC 7807 Problem Details HTTP response.
%%
%% reply_error(Status, Title, Detail, Req) -> Req2
-spec reply_error(non_neg_integer(), binary(), binary(), cowboy_req:req()) ->
    cowboy_req:req().
reply_error(Status, Title, Detail, Req) ->
    Body = problem_details(Status, Title, Detail),
    cowboy_req:reply(Status,
        #{<<"content-type">> => <<"application/problem+json">>},
        Body, Req).

%% @doc Map an internal chf_core/chf_online error reason to a
%% {Status, Title, Detail} triple per TS 32.291. Never leaks internal terms.
-spec reason_to_problem(term()) -> {non_neg_integer(), binary(), binary()}.
reason_to_problem(not_found) ->
    {404, <<"NOT_FOUND">>, <<"No charging session with the given reference">>};
reason_to_problem(session_terminated) ->
    {404, <<"NOT_FOUND">>, <<"The charging session has been terminated">>};
reason_to_problem(session_exists) ->
    {409, <<"CONFLICT">>, <<"A charging session with this reference already exists">>};
reason_to_problem(insufficient_balance) ->
    {403, <<"QUOTA_LIMIT_REACHED">>, <<"Insufficient account balance">>};
reason_to_problem(subscriber_not_found) ->
    {404, <<"USER_UNKNOWN">>, <<"Unknown subscriber">>};
reason_to_problem(subscriber_suspended) ->
    {403, <<"SUBSCRIPTION_NOT_ACTIVE">>, <<"Subscriber is not active">>};
reason_to_problem(_) ->
    {500, <<"INTERNAL_ERROR">>, <<"Internal charging error">>}.
