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
     post_non_binary_imsi_400].

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
    Headers = [{<<"content-type">>, <<"application/json">>}],
    BodyBin = iolist_to_binary(json:encode(Body)),
    StreamRef = case Method of
        put  -> gun:put(ConnPid, Path, Headers, BodyBin);
        post -> gun:post(ConnPid, Path, Headers, BodyBin)
    end,
    {response, IsFin, Status, _H} = gun:await(ConnPid, StreamRef),
    _ = case IsFin of nofin -> gun:await_body(ConnPid, StreamRef); fin -> ok end,
    Status.

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
