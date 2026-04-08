%% chf_provision_balance_h.erl — Cowboy HTTP handler for balance resources.
%%
%% Routes (State carries the sub-operation tag):
%%   GET  /api/v1/subscribers/:imsi/balance          — get balance    (State=[])
%%   POST /api/v1/subscribers/:imsi/balance/topup    — topup          (State=[topup])
%%   POST /api/v1/subscribers/:imsi/balance/adjust   — adjust         (State=[adjust])
-module(chf_provision_balance_h).
-behaviour(cowboy_handler).

-include_lib("chf_db/include/chf_db.hrl").

-export([init/2]).

%%====================================================================
%% Cowboy callback
%%====================================================================

init(Req, State) ->
    Method = cowboy_req:method(Req),
    handle(Method, State, Req, State).

%%====================================================================
%% Method + operation dispatch
%%====================================================================

%% GET balance
handle(<<"GET">>, [], Req, State) ->
    Imsi = cowboy_req:binding(imsi, Req),
    case lookup_account(Imsi) of
        {error, Reason} ->
            Req2 = reply_error(404, Reason, Req),
            {ok, Req2, State};
        {ok, AccountId} ->
            case chf_db:balance_get(AccountId) of
                {ok, Balance} ->
                    Body = chf_provision_json:encode_balance(Balance),
                    Req2 = reply(200, Body, Req),
                    {ok, Req2, State};
                {error, not_found} ->
                    Req2 = reply_error(404, <<"balance not found">>, Req),
                    {ok, Req2, State};
                {error, Err} ->
                    Req2 = reply_error(500, format_error(Err), Req),
                    {ok, Req2, State}
            end
    end;

%% POST topup
handle(<<"POST">>, [topup], Req, State) ->
    Imsi = cowboy_req:binding(imsi, Req),
    case lookup_account(Imsi) of
        {error, Reason} ->
            Req2 = reply_error(404, Reason, Req),
            {ok, Req2, State};
        {ok, AccountId} ->
            case read_amount(Req) of
                {error, Reason, Req2} ->
                    Req3 = reply_error(400, Reason, Req2),
                    {ok, Req3, State};
                {ok, Amount, Req2} when Amount < 0 ->
                    Req3 = reply_error(400, <<"topup amount must be non-negative">>, Req2),
                    {ok, Req3, State};
                {ok, Amount, Req2} ->
                    case chf_db:balance_topup(AccountId, Amount) of
                        {ok, Balance} ->
                            Body = chf_provision_json:encode_balance(Balance),
                            Req3 = reply(200, Body, Req2),
                            {ok, Req3, State};
                        {error, Err} ->
                            Req3 = reply_error(500, format_error(Err), Req2),
                            {ok, Req3, State}
                    end
            end
    end;

%% POST adjust (positive or negative)
handle(<<"POST">>, [adjust], Req, State) ->
    Imsi = cowboy_req:binding(imsi, Req),
    case lookup_account(Imsi) of
        {error, Reason} ->
            Req2 = reply_error(404, Reason, Req),
            {ok, Req2, State};
        {ok, AccountId} ->
            case read_amount(Req) of
                {error, Reason, Req2} ->
                    Req3 = reply_error(400, Reason, Req2),
                    {ok, Req3, State};
                {ok, Amount, Req2} ->
                    Result = do_adjust(AccountId, Amount),
                    case Result of
                        {ok, Balance} ->
                            Body = chf_provision_json:encode_balance(Balance),
                            Req3 = reply(200, Body, Req2),
                            {ok, Req3, State};
                        {error, AdjErr} ->
                            Req3 = reply_error(500, format_error(AdjErr), Req2),
                            {ok, Req3, State}
                    end
            end
    end;

handle(_Method, _Op, Req, State) ->
    Req2 = reply_error(405, <<"method not allowed">>, Req),
    {ok, Req2, State}.

%%====================================================================
%% Helpers
%%====================================================================

%% Apply a balance adjustment (positive = topup, negative = reserve+commit).
do_adjust(AccountId, Amount) when Amount >= 0 ->
    chf_db:balance_topup(AccountId, Amount);
do_adjust(AccountId, Amount) ->
    Abs = -Amount,
    case chf_db:balance_reserve(AccountId, Abs) of
        {ok, _} -> chf_db:balance_commit(AccountId, Abs);
        Err     -> Err
    end.

%% Lookup subscriber by IMSI and return {ok, AccountId} | {error, Reason}.
lookup_account(Imsi) ->
    case chf_db:subscriber_lookup(Imsi) of
        {ok, #subscriber{account_id = AccountId}} -> {ok, AccountId};
        {error, not_found} -> {error, <<"subscriber not found">>}
    end.

%% Read body and extract the `amount` field (integer).
read_amount(Req) ->
    case cowboy_req:read_body(Req) of
        {ok, <<>>, Req2} ->
            {error, <<"empty request body">>, Req2};
        {ok, Bin, Req2} ->
            try
                {Map, _, _} = chf_provision_json:decode(Bin),
                case maps:find(amount, Map) of
                    {ok, Amount} when is_integer(Amount) ->
                        {ok, Amount, Req2};
                    {ok, _} ->
                        {error, <<"amount must be an integer">>, Req2};
                    error ->
                        {error, <<"missing required field: amount">>, Req2}
                end
            catch
                _:_ ->
                    {error, <<"invalid JSON">>, Req2}
            end;
        {error, _} = Err ->
            {error, format_error(Err), Req}
    end.

reply(Status, Body, Req) ->
    cowboy_req:reply(Status,
        #{<<"content-type">> => <<"application/json">>},
        Body, Req).

reply_error(Status, Msg, Req) when is_binary(Msg) ->
    Body = chf_provision_json:encode(#{<<"error">> => Msg}),
    reply(Status, Body, Req);
reply_error(Status, Msg, Req) ->
    reply_error(Status, iolist_to_binary(io_lib:format("~p", [Msg])), Req).

format_error(Err) when is_binary(Err) -> Err;
format_error(Err) -> iolist_to_binary(io_lib:format("~p", [Err])).
