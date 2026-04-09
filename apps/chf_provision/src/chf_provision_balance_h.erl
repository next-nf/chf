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

%% chf_provision_balance_h.erl — Cowboy REST handler for balance resources.
%%
%% Routes:
%%   GET   /api/v1/subscribers/:imsi/balance — read balance
%%   PATCH /api/v1/subscribers/:imsi/balance — adjust balance (credit field)
%%   PUT   /api/v1/subscribers/:imsi/balance — set absolute balance
-module(chf_provision_balance_h).

-include_lib("chf_db/include/chf_db.hrl").

-export([init/2,
         allowed_methods/2,
         content_types_provided/2,
         content_types_accepted/2,
         resource_exists/2,
         to_json/2,
         from_json/2]).

-record(state, {
    imsi       :: binary(),
    account_id :: binary() | undefined,
    balance    :: #balance{} | undefined
}).

%%====================================================================
%% REST callbacks
%%====================================================================

init(Req, _Opts) ->
    Imsi = cowboy_req:binding(imsi, Req),
    {cowboy_rest, Req, #state{imsi = Imsi}}.

allowed_methods(Req, State) ->
    {[<<"GET">>, <<"PUT">>, <<"PATCH">>], Req, State}.

content_types_provided(Req, State) ->
    {[{<<"application/json">>, to_json}], Req, State}.

content_types_accepted(Req, State) ->
    {[{<<"application/json">>, from_json}], Req, State}.

resource_exists(Req, #state{imsi = Imsi} = State) ->
    case chf_db:subscriber_lookup(Imsi) of
        {ok, #subscriber{account_id = AccountId}} ->
            case chf_db:balance_get(AccountId) of
                {ok, Balance} ->
                    {true, Req, State#state{account_id = AccountId,
                                            balance = Balance}};
                {error, not_found} ->
                    %% Subscriber exists but no balance yet — still a valid resource
                    {true, Req, State#state{account_id = AccountId}}
            end;
        {error, not_found} ->
            {false, Req, State}
    end.

%%====================================================================
%% GET — provide JSON representation
%%====================================================================

to_json(Req, #state{balance = Balance} = State) when Balance =/= undefined ->
    Body = chf_provision_json:encode_balance(Balance),
    {Body, Req, State};
to_json(Req, #state{account_id = AccountId} = State) ->
    %% No balance record yet — return zeroes
    Body = chf_provision_json:encode(#{
        <<"account_id">> => AccountId,
        <<"total">> => 0,
        <<"reserved">> => 0,
        <<"available">> => 0
    }),
    {Body, Req, State}.

%%====================================================================
%% PUT / PATCH — accept JSON
%%====================================================================

from_json(Req, State) ->
    Method = cowboy_req:method(Req),
    {ok, RawBody, Req2} = cowboy_req:read_body(Req),
    case decode_body(RawBody) of
        {error, Reason} ->
            reply_error(400, Reason, Req2, State);
        {ok, Fields} ->
            case Method of
                <<"PUT">>   -> handle_put(Fields, Req2, State);
                <<"PATCH">> -> handle_patch(Fields, Req2, State)
            end
    end.

%%====================================================================
%% PUT — set absolute balance value
%%====================================================================

handle_put(Fields, Req, #state{account_id = AccountId, balance = OldBal} = State) ->
    case maps:find(total, Fields) of
        {ok, NewTotal} when is_integer(NewTotal), NewTotal >= 0 ->
            %% Calculate delta from current total (or 0 if no balance yet)
            CurrentTotal = case OldBal of
                               undefined -> 0;
                               #balance{total = T} -> T
                           end,
            Delta = NewTotal - CurrentTotal,
            Result = apply_delta(AccountId, Delta),
            respond_with_balance(Result, Req, State);
        {ok, _} ->
            reply_error(400, <<"total must be a non-negative integer">>, Req, State);
        error ->
            reply_error(400, <<"missing required field: total">>, Req, State)
    end.

%%====================================================================
%% PATCH — relative adjustment via credit field
%%====================================================================

handle_patch(Fields, Req, #state{account_id = AccountId} = State) ->
    case maps:find(credit, Fields) of
        {ok, Amount} when is_integer(Amount) ->
            Result = apply_delta(AccountId, Amount),
            respond_with_balance(Result, Req, State);
        {ok, _} ->
            reply_error(400, <<"credit must be an integer">>, Req, State);
        error ->
            reply_error(400, <<"missing required field: credit">>, Req, State)
    end.

%%====================================================================
%% Helpers
%%====================================================================

%% Apply a balance delta: positive = topup, negative = reserve+commit (debit).
apply_delta(AccountId, Amount) when Amount >= 0 ->
    chf_db:balance_topup(AccountId, Amount);
apply_delta(AccountId, Amount) ->
    Abs = -Amount,
    case chf_db:balance_reserve(AccountId, Abs) of
        {ok, _} -> chf_db:balance_commit(AccountId, Abs);
        Err     -> Err
    end.

respond_with_balance({ok, Balance}, Req, State) ->
    Body = chf_provision_json:encode_balance(Balance),
    Req2 = cowboy_req:set_resp_body(Body, Req),
    {true, Req2, State#state{balance = Balance}};
respond_with_balance({error, insufficient_balance}, Req, State) ->
    reply_error(409, <<"insufficient balance">>, Req, State);
respond_with_balance({error, Err}, Req, State) ->
    reply_error(500, format_error(Err), Req, State).

decode_body(<<>>) ->
    {error, <<"empty request body">>};
decode_body(Bin) ->
    try
        {Map, _, _} = chf_provision_json:decode(Bin),
        {ok, Map}
    catch
        _:_ -> {error, <<"invalid JSON">>}
    end.

reply_error(Status, Msg, Req, State) ->
    Body = chf_provision_json:encode(#{<<"error">> => Msg}),
    Req2 = cowboy_req:set_resp_header(<<"content-type">>, <<"application/json">>, Req),
    Req3 = cowboy_req:set_resp_body(Body, Req2),
    {stop, cowboy_req:reply(Status, Req3), State}.

format_error(Err) when is_binary(Err) -> Err;
format_error(Err) -> iolist_to_binary(io_lib:format("~p", [Err])).
