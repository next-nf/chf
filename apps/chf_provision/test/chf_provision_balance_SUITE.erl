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

-module(chf_provision_balance_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").
-include_lib("chf_db/include/chf_db.hrl").

all() ->
    [put_sets_absolute_total,
     put_below_reserved_409].

init_per_suite(Config) ->
    {ok, _} = application:ensure_all_started(cowboy),
    {ok, _} = application:ensure_all_started(gun),
    Dispatch = cowboy_router:compile([{'_', [
        {"/api/v1/subscribers/:imsi/balance", chf_provision_balance_h, []}
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
    Sub = #subscriber{imsi = <<"001">>, msisdn = <<"49">>, account_id = <<"a">>,
                      status = active, rating_groups = #{},
                      created_at = 0, updated_at = 0},
    ok = chf_db:subscriber_create(Sub),
    {ok, _} = chf_db:balance_topup(<<"a">>, 3000),
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

put_req(ConnPid, Path, Body) ->
    Headers = [{<<"content-type">>, <<"application/json">>}],
    StreamRef = gun:put(ConnPid, Path, Headers, iolist_to_binary(json:encode(Body))),
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
    Decoded = chf_provision_json:decode(Body),
    ?assertEqual(5000, maps:get(<<"total">>, Decoded)).

put_below_reserved_409(Config) ->
    ConnPid = ?config(conn, Config),
    {ok, _} = chf_db:balance_reserve(<<"a">>, 2000),
    {Status, _Body} = put_req(ConnPid, "/api/v1/subscribers/001/balance",
                              #{<<"total">> => 1000}),
    ?assertEqual(409, Status).
