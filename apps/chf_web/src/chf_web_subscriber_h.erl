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
    case chf_data:subscriber_lookup(Imsi) of
        {ok, Sub} ->
            Balance = get_balance(maps:get(<<"account_id">>, Sub)),
            reply(200, subscriber_to_map(Sub, Balance), Req0, State);
        {error, not_found} ->
            reply(404, #{<<"error">> => <<"not_found">>}, Req0, State)
    end.

get_balance(AccountId) ->
    case chf_data:balance_get(AccountId) of
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
                    case chf_data:subscriber_create(Sub) of
                        ok ->
                            %% Materialise an empty balance row, matching
                            %% chf_api_subscriber_h, so the subscriber is
                            %% immediately chargeable (a missing balance row
                            %% would otherwise surface as insufficient_balance).
                            _ = chf_data:balance_topup(maps:get(<<"account_id">>, Sub), 0),
                            reply(201, #{<<"status">> => <<"created">>,
                                         <<"imsi">>   => maps:get(<<"imsi">>, Sub)},
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
            {ok, #{
                <<"imsi">>          => Imsi,
                <<"msisdn">>        => Msisdn,
                <<"account_id">>    => AccountId,
                <<"status">>        => <<"active">>,
                <<"rating_groups">> => #{},
                <<"created_at">>    => Now,
                <<"updated_at">>    => Now
            }}
    end.

%%====================================================================
%% Serialisation
%%====================================================================

subscriber_to_map(Sub, Balance) ->
    RGs = maps:get(<<"rating_groups">>, Sub, #{}),
    M = #{
        <<"imsi">>          => maps:get(<<"imsi">>, Sub, <<>>),
        <<"msisdn">>        => maps:get(<<"msisdn">>, Sub, <<>>),
        <<"account_id">>    => maps:get(<<"account_id">>, Sub, <<>>),
        <<"status">>        => maps:get(<<"status">>, Sub, <<"active">>),
        <<"rating_groups">> => maps:fold(fun(K, V, A) ->
                                    A#{integer_to_binary(K) => rg_config_to_map(V)}
                               end, #{}, RGs),
        <<"created_at">>    => maps:get(<<"created_at">>, Sub, 0),
        <<"updated_at">>    => maps:get(<<"updated_at">>, Sub, 0)
    },
    case Balance of
        undefined -> M;
        _ ->
            Total     = maps:get(<<"total">>, Balance, 0),
            Available = chf_balance:available(Balance),
            M#{<<"balance">> => #{
                <<"total">>     => Total,
                <<"reserved">>  => Total - Available,
                <<"available">> => Available
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
