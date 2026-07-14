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

-module(chf_api_balance_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

all() ->
    [put_sets_absolute_total,
     put_below_reserved_409,
     get_balance_200,
     patch_positive_topup,
     patch_negative_debit,
     patch_float_value_400,
     patch_nonexistent_subscriber_404,
     patch_insufficient_balance_409].

init_per_suite(Config) ->
    {ok, _} = application:ensure_all_started(cowboy),
    {ok, _} = application:ensure_all_started(gun),
    Dispatch = cowboy_router:compile([{'_', [
        {"/api/v1/subscribers/:imsi/balance", chf_api_balance_h, []}
    ]}]),
    {ok, _} = cowboy:start_clear(prov_bal_listener, [{port, 0}],
        #{env => #{dispatch => Dispatch}}),
    Port = ranch:get_port(prov_bal_listener),
    [{port, Port} | Config].

end_per_suite(_Config) ->
    cowboy:stop_listener(prov_bal_listener),
    ok.

init_per_testcase(_TC, Config) ->
    setup_mnesia(),
    %% Seed subscriber IMSI 001 -> account "a" with total 3000.
    Sub = #{<<"imsi">> => <<"001">>, <<"msisdn">> => <<"49">>,
            <<"account_id">> => <<"a">>, <<"status">> => <<"active">>,
            <<"rating_groups">> => #{}, <<"created_at">> => 0, <<"updated_at">> => 0},
    ok = chf_data:subscriber_create(Sub),
    {ok, _} = chf_data:balance_topup(<<"a">>, 3000),
    Port = ?config(port, Config),
    {ok, ConnPid} = gun:open("127.0.0.1", Port, #{protocols => [http]}),
    {ok, http} = gun:await_up(ConnPid),
    [{conn, ConnPid} | Config].

end_per_testcase(_TC, Config) ->
    gun:close(?config(conn, Config)),
    catch gen_server:stop(chf_db_mnesia),
    mnesia:stop(),
    ok.

setup_mnesia() ->
    application:set_env(chf_db, backend, chf_db_mnesia),
    application:set_env(chf_db, backend_opts, #{storage => ram_copies}),
    persistent_term:put({chf_db, backend}, chf_db_mnesia),
    catch gen_server:stop(chf_db_mnesia),
    mnesia:stop(),
    ok = mnesia:start(),
    {ok, _Pid} = chf_db_mnesia:start_link(#{}),
    ok = chf_data:ensure_collections(),
    ok = chf_db_mnesia:wait_ready([subscriber, balance, charging_session, cdr]),
    ok.

put_req(ConnPid, Path, Body) ->
    method_req(ConnPid, put, Path, Body).

patch_req(ConnPid, Path, Body) ->
    method_req(ConnPid, patch, Path, Body).

get_req(ConnPid, Path) ->
    StreamRef = gun:get(ConnPid, Path, []),
    {response, IsFin, Status, _H} = gun:await(ConnPid, StreamRef),
    RespBody = case IsFin of
        nofin -> {ok, B} = gun:await_body(ConnPid, StreamRef), B;
        fin   -> <<>>
    end,
    {Status, RespBody}.

method_req(ConnPid, Method, Path, Body) ->
    Headers = [{<<"content-type">>, <<"application/json">>}],
    Bin = iolist_to_binary(json:encode(Body)),
    StreamRef = case Method of
        put   -> gun:put(ConnPid, Path, Headers, Bin);
        patch -> gun:patch(ConnPid, Path, Headers, Bin)
    end,
    {response, IsFin, Status, _H} = gun:await(ConnPid, StreamRef),
    RespBody = case IsFin of
        nofin -> {ok, B} = gun:await_body(ConnPid, StreamRef), B;
        fin   -> <<>>
    end,
    {Status, RespBody}.

put_sets_absolute_total(Config) ->
    ConnPid = ?config(conn, Config),
    {Status, Body} = put_req(ConnPid, "/api/v1/subscribers/001/balance",
                             #{<<"total">> => 5000}),
    ?assertEqual(200, Status),
    Decoded = chf_api_json:decode(Body),
    ?assertEqual(5000, maps:get(<<"total">>, Decoded)).

put_below_reserved_409(Config) ->
    ConnPid = ?config(conn, Config),
    %% Hold a reservation for a session so the new absolute total (1000) would
    %% drop below the reserved amount (2000) -> total_below_reserved -> 409.
    ok = chf_data:balance_reserve(<<"a">>, <<"sess-x">>, <<"1">>, 2000, <<"tok-x">>),
    {Status, _Body} = put_req(ConnPid, "/api/v1/subscribers/001/balance",
                              #{<<"total">> => 1000}),
    ?assertEqual(409, Status).

get_balance_200(Config) ->
    ConnPid = ?config(conn, Config),
    {Status, Body} = get_req(ConnPid, "/api/v1/subscribers/001/balance"),
    ?assertEqual(200, Status),
    Decoded = chf_api_json:decode(Body),
    ?assertEqual(3000, maps:get(<<"total">>, Decoded)),
    ?assertEqual(0, maps:get(<<"reserved">>, Decoded)),
    ?assertEqual(3000, maps:get(<<"available">>, Decoded)).

patch_positive_topup(Config) ->
    ConnPid = ?config(conn, Config),
    {Status, Body} = patch_req(ConnPid, "/api/v1/subscribers/001/balance",
                               #{<<"credit">> => 2000}),
    ?assertEqual(200, Status),
    Decoded = chf_api_json:decode(Body),
    %% After topup of 2000, total should be 3000+2000=5000
    ?assertEqual(5000, maps:get(<<"total">>, Decoded)).

patch_negative_debit(Config) ->
    ConnPid = ?config(conn, Config),
    {Status, Body} = patch_req(ConnPid, "/api/v1/subscribers/001/balance",
                               #{<<"credit">> => -1000}),
    ?assertEqual(200, Status),
    Decoded = chf_api_json:decode(Body),
    %% After debit of 1000 from 3000, total=2000
    ?assertEqual(2000, maps:get(<<"total">>, Decoded)),
    %% reserve+commit leaves reserved=0
    ?assertEqual(0, maps:get(<<"reserved">>, Decoded)).

patch_float_value_400(Config) ->
    ConnPid = ?config(conn, Config),
    %% json:encode/1 will encode 1.5 as a float; handler expects integer
    {Status, _Body} = patch_req(ConnPid, "/api/v1/subscribers/001/balance",
                                #{<<"credit">> => 1.5}),
    ?assertEqual(400, Status).

patch_nonexistent_subscriber_404(Config) ->
    ConnPid = ?config(conn, Config),
    {Status, _Body} = patch_req(ConnPid, "/api/v1/subscribers/no-such/balance",
                                #{<<"credit">> => 100}),
    ?assertEqual(404, Status).

patch_insufficient_balance_409(Config) ->
    ConnPid = ?config(conn, Config),
    %% Try to debit more than available
    {Status, _Body} = patch_req(ConnPid, "/api/v1/subscribers/001/balance",
                                #{<<"credit">> => -99999}),
    ?assertEqual(409, Status).
