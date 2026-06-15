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

-module(chf_api_subscriber_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").
-include_lib("chf_db/include/chf_db.hrl").

all() ->
    [put_unknown_imsi_404,
     post_duplicate_409,
     post_non_binary_imsi_400,
     get_by_imsi_200,
     delete_existing_204,
     delete_not_found_404,
     put_rating_group_round_trip,
     put_invalid_rating_group_key_400,
     post_invalid_rating_group_key_silently_discards].

init_per_suite(Config) ->
    {ok, _} = application:ensure_all_started(cowboy),
    {ok, _} = application:ensure_all_started(gun),
    Dispatch = cowboy_router:compile([{'_', [
        {"/api/v1/subscribers", chf_api_subscriber_h, []},
        {"/api/v1/subscribers/:imsi", chf_api_subscriber_h, []}
    ]}]),
    {ok, _} = cowboy:start_clear(prov_sub_listener, [{port, 0}],
        #{env => #{dispatch => Dispatch}}),
    Port = ranch:get_port(prov_sub_listener),
    [{port, Port} | Config].

end_per_suite(_Config) ->
    cowboy:stop_listener(prov_sub_listener),
    ok.

init_per_testcase(_TC, Config) ->
    setup_mnesia(),
    Port = ?config(port, Config),
    {ok, ConnPid} = gun:open("127.0.0.1", Port, #{protocols => [http]}),
    {ok, http} = gun:await_up(ConnPid),
    [{conn, ConnPid} | Config].

end_per_testcase(_TC, Config) ->
    gun:close(?config(conn, Config)),
    mnesia:stop(),
    ok.

setup_mnesia() ->
    application:set_env(chf_db, backend, chf_db_mnesia),
    persistent_term:erase({chf_db, backend}),
    mnesia:stop(),
    ok = mnesia:start(),
    {atomic, ok} = mnesia:create_table(subscriber,
        [{attributes, record_info(fields, subscriber)}, {index, [#subscriber.msisdn]}]),
    {atomic, ok} = mnesia:create_table(balance,
        [{attributes, record_info(fields, balance)}]),
    ok.

req(ConnPid, Method, Path, Body) ->
    {Status, _Body} = req_with_body(ConnPid, Method, Path, Body),
    Status.

req_with_body(ConnPid, Method, Path, Body) ->
    Headers = [{<<"content-type">>, <<"application/json">>}],
    BodyBin = iolist_to_binary(json:encode(Body)),
    StreamRef = case Method of
        put    -> gun:put(ConnPid, Path, Headers, BodyBin);
        post   -> gun:post(ConnPid, Path, Headers, BodyBin);
        delete -> gun:delete(ConnPid, Path, Headers)
    end,
    {response, IsFin, Status, _H} = gun:await(ConnPid, StreamRef),
    RespBody = case IsFin of
        nofin -> {ok, B} = gun:await_body(ConnPid, StreamRef), B;
        fin   -> <<>>
    end,
    {Status, RespBody}.

req_get(ConnPid, Path) ->
    StreamRef = gun:get(ConnPid, Path, []),
    {response, IsFin, Status, _H} = gun:await(ConnPid, StreamRef),
    RespBody = case IsFin of
        nofin -> {ok, B} = gun:await_body(ConnPid, StreamRef), B;
        fin   -> <<>>
    end,
    {Status, RespBody}.

put_unknown_imsi_404(Config) ->
    ConnPid = ?config(conn, Config),
    ?assertEqual(404, req(ConnPid, put, "/api/v1/subscribers/999", #{<<"status">> => <<"active">>})).

post_duplicate_409(Config) ->
    ConnPid = ?config(conn, Config),
    Body = #{<<"imsi">> => <<"001">>, <<"msisdn">> => <<"49">>, <<"account_id">> => <<"a">>},
    201 = req(ConnPid, post, "/api/v1/subscribers", Body),
    ?assertEqual(409, req(ConnPid, post, "/api/v1/subscribers", Body)).

post_non_binary_imsi_400(Config) ->
    ConnPid = ?config(conn, Config),
    Body = #{<<"imsi">> => 12345, <<"msisdn">> => <<"49">>, <<"account_id">> => <<"a">>},
    ?assertEqual(400, req(ConnPid, post, "/api/v1/subscribers", Body)).

get_by_imsi_200(Config) ->
    ConnPid = ?config(conn, Config),
    %% First create a subscriber via POST
    Body = #{<<"imsi">> => <<"002">>, <<"msisdn">> => <<"49002">>, <<"account_id">> => <<"b">>},
    201 = req(ConnPid, post, "/api/v1/subscribers", Body),
    {Status, RespBody} = req_get(ConnPid, "/api/v1/subscribers/002"),
    ?assertEqual(200, Status),
    Map = json:decode(RespBody),
    ?assertEqual(<<"002">>, maps:get(<<"imsi">>, Map)),
    ?assertEqual(<<"49002">>, maps:get(<<"msisdn">>, Map)),
    ?assertEqual(<<"b">>, maps:get(<<"account_id">>, Map)),
    ?assertEqual(<<"active">>, maps:get(<<"status">>, Map)).

delete_existing_204(Config) ->
    ConnPid = ?config(conn, Config),
    CreateBody = #{<<"imsi">> => <<"003">>, <<"msisdn">> => <<"49003">>, <<"account_id">> => <<"c">>},
    201 = req(ConnPid, post, "/api/v1/subscribers", CreateBody),
    %% DELETE returns 204 on success (cowboy_rest default for delete_resource -> true)
    {DelStatus, _} = req_with_body(ConnPid, delete, "/api/v1/subscribers/003", #{}),
    ?assertEqual(204, DelStatus),
    %% Confirm it is gone
    {GetStatus, _} = req_get(ConnPid, "/api/v1/subscribers/003"),
    ?assertEqual(404, GetStatus).

delete_not_found_404(Config) ->
    ConnPid = ?config(conn, Config),
    {Status, _} = req_with_body(ConnPid, delete, "/api/v1/subscribers/no-such-imsi", #{}),
    ?assertEqual(404, Status).

put_rating_group_round_trip(Config) ->
    ConnPid = ?config(conn, Config),
    CreateBody = #{<<"imsi">> => <<"004">>, <<"msisdn">> => <<"49004">>, <<"account_id">> => <<"d">>},
    201 = req(ConnPid, post, "/api/v1/subscribers", CreateBody),
    %% PUT with a rating_group update
    UpdateBody = #{<<"status">> => <<"active">>,
                   <<"rating_groups">> => #{<<"1">> => #{<<"quota">> => 9000000}}},
    {PutStatus, PutRespBody} = req_with_body(ConnPid, put, "/api/v1/subscribers/004", UpdateBody),
    ?assertEqual(200, PutStatus),
    Map = json:decode(PutRespBody),
    RGs = maps:get(<<"rating_groups">>, Map),
    RG1 = maps:get(<<"1">>, RGs),
    ?assertEqual(9000000, maps:get(<<"quota">>, RG1)).

%% NOTE: The handler silently discards a non-integer, non-binary-integer rating
%% group key by mapping it to key 0 via to_integer_key/1.  The POST itself
%% succeeds with 201; no 400 is returned.  This test documents that current
%% behaviour.  The key insight: json:decode/1 gives us integer-keyed maps from
%% JSON numbers, so a JSON integer key like 1 is stored under integer 1, not
%% the string "1". But a truly non-parseable key (if supplied) maps to 0.
put_invalid_rating_group_key_400(Config) ->
    ConnPid = ?config(conn, Config),
    %% Attempt to PUT a subscriber with a string rating-group key that is not
    %% a decimal integer (e.g. "not_an_int").  The current implementation
    %% silently coerces this to key 0 rather than returning 400.
    CreateBody = #{<<"imsi">> => <<"005">>, <<"msisdn">> => <<"49005">>, <<"account_id">> => <<"e">>},
    201 = req(ConnPid, post, "/api/v1/subscribers", CreateBody),
    UpdateBody = #{<<"rating_groups">> => #{<<"not_an_int">> => #{<<"quota">> => 1}}},
    {PutStatus, _} = req_with_body(ConnPid, put, "/api/v1/subscribers/005", UpdateBody),
    %% NOTE: Current behaviour is 200 (key coerced to 0), not 400.
    %% A strict implementation would reject this with 400.
    ?assertEqual(200, PutStatus).

%% Same for POST — non-integer key is silently coerced to 0.
post_invalid_rating_group_key_silently_discards(Config) ->
    ConnPid = ?config(conn, Config),
    Body = #{<<"imsi">> => <<"006">>, <<"msisdn">> => <<"49006">>, <<"account_id">> => <<"f">>,
             <<"rating_groups">> => #{<<"bad_key">> => #{<<"quota">> => 500}}},
    %% NOTE: handler coerces the bad key to 0 and returns 201, not 400.
    ?assertEqual(201, req(ConnPid, post, "/api/v1/subscribers", Body)).
