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

%% chf_web_subscriber_h.erl — Subscriber management handler.
%%
%% GET  /api/subscribers/:imsi  — subscriber details + balance
%% POST /api/subscribers        — create subscriber
-module(chf_web_subscriber_h).

-include_lib("chf_db/include/chf_db.hrl").

-export([init/2]).

init(Req0, State) ->
    case cowboy_req:method(Req0) of
        <<"GET">>  -> handle_get(Req0, State);
        <<"POST">> -> handle_post(Req0, State);
        _          -> reply(405, #{<<"error">> => <<"method not allowed">>}, Req0, State)
    end.

%%====================================================================
%% GET
%%====================================================================

handle_get(Req0, State) ->
    case cowboy_req:binding(imsi, Req0) of
        undefined ->
            reply(400, #{<<"error">> => <<"imsi required">>}, Req0, State);
        Imsi ->
            get_subscriber(Imsi, Req0, State)
    end.

get_subscriber(Imsi, Req0, State) ->
    case chf_db:subscriber_lookup(Imsi) of
        {ok, Sub} ->
            Balance = get_balance(Sub#subscriber.account_id),
            reply(200, subscriber_to_map(Sub, Balance), Req0, State);
        {error, not_found} ->
            reply(404, #{<<"error">> => <<"not_found">>}, Req0, State)
    end.

get_balance(AccountId) ->
    case chf_db:balance_get(AccountId) of
        {ok, Bal} -> Bal;
        _         -> undefined
    end.

%%====================================================================
%% POST
%%====================================================================

handle_post(Req0, State) ->
    {ok, Body, Req1} = cowboy_req:read_body(Req0),
    case parse_json(Body) of
        {ok, Map} ->
            case build_subscriber(Map) of
                {ok, Sub} ->
                    case chf_db:subscriber_create(Sub) of
                        ok ->
                            reply(201, #{<<"status">> => <<"created">>,
                                         <<"imsi">>   => Sub#subscriber.imsi},
                                  Req1, State);
                        {error, Reason} ->
                            reply(409, #{<<"error">> => iolist_to_binary(
                                            io_lib:format("~p", [Reason]))},
                                  Req1, State)
                    end;
                {error, Msg} ->
                    reply(400, #{<<"error">> => Msg}, Req1, State)
            end;
        {error, _} ->
            reply(400, #{<<"error">> => <<"invalid json">>}, Req1, State)
    end.

build_subscriber(Map) ->
    case {maps:get(<<"imsi">>, Map, undefined),
          maps:get(<<"msisdn">>, Map, undefined),
          maps:get(<<"account_id">>, Map, undefined)} of
        {undefined, _, _} -> {error, <<"imsi required">>};
        {_, undefined, _} -> {error, <<"msisdn required">>};
        {_, _, undefined} -> {error, <<"account_id required">>};
        {Imsi, Msisdn, AccountId} ->
            Now = erlang:system_time(millisecond),
            {ok, #subscriber{
                imsi          = Imsi,
                msisdn        = Msisdn,
                account_id    = AccountId,
                status        = active,
                rating_groups = #{},
                created_at    = Now,
                updated_at    = Now
            }}
    end.

%%====================================================================
%% Serialisation
%%====================================================================

subscriber_to_map(#subscriber{
        imsi          = Imsi,
        msisdn        = Msisdn,
        account_id    = AccountId,
        status        = Status,
        rating_groups = RGs,
        created_at    = CreatedAt,
        updated_at    = UpdatedAt}, Balance) ->
    M = #{
        <<"imsi">>          => Imsi,
        <<"msisdn">>        => Msisdn,
        <<"account_id">>    => AccountId,
        <<"status">>        => atom_to_binary(Status, utf8),
        <<"rating_groups">> => maps:fold(fun(K, V, A) ->
                                    A#{integer_to_binary(K) => rg_config_to_map(V)}
                               end, #{}, RGs),
        <<"created_at">>    => CreatedAt,
        <<"updated_at">>    => UpdatedAt
    },
    case Balance of
        undefined -> M;
        #balance{total = T, reserved = R, available = Av} ->
            M#{<<"balance">> => #{
                <<"total">>     => T,
                <<"reserved">>  => R,
                <<"available">> => Av
            }}
    end.

rg_config_to_map(Cfg) when is_map(Cfg) ->
    maps:fold(fun(K, V, A) ->
        Key = if is_atom(K) -> atom_to_binary(K, utf8); true -> K end,
        A#{Key => V}
    end, #{}, Cfg);
rg_config_to_map(_) -> #{}.

%%====================================================================
%% Helpers
%%====================================================================

parse_json(Body) ->
    try {ok, json:decode(Body)}
    catch _:_ -> {error, invalid}
    end.

reply(Status, Data, Req0, State) ->
    Body = iolist_to_binary(json:encode(Data)),
    Req  = cowboy_req:reply(Status,
             #{<<"content-type">> => <<"application/json">>},
             Body, Req0),
    {ok, Req, State}.
