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

%% chf_sbi_converged_SUITE.erl — CT integration tests for Nchf_ConvergedCharging handler.
-module(chf_sbi_converged_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

%%====================================================================
%% CT callbacks
%%====================================================================

all() ->
    [create_session_success,
     create_session_missing_imsi,
     update_session_success,
     update_session_not_found,
     release_session_success,
     release_session_not_found,
     create_insufficient_balance_403,
     update_large_body_413].

init_per_suite(Config) ->
    %% Start cowboy and ranch if not already running.
    {ok, _} = application:ensure_all_started(cowboy),

    Dispatch = cowboy_router:compile([{'_', [
        {"/nchf-convergedcharging/v3/chargingdata",
         chf_sbi_converged_h, []},
        {"/nchf-convergedcharging/v3/chargingdata/:chargingDataRef",
         chf_sbi_converged_h, []},
        {"/nchf-convergedcharging/v3/chargingdata/:chargingDataRef/update",
         chf_sbi_converged_h, [update]},
        {"/nchf-convergedcharging/v3/chargingdata/:chargingDataRef/release",
         chf_sbi_converged_h, [release]}
    ]}]),

    {ok, _} = cowboy:start_clear(converged_test_listener,
        [{port, 0}],
        #{env => #{dispatch => Dispatch}}),

    Port = ranch:get_port(converged_test_listener),

    %% Ensure gun is started.
    {ok, _} = application:ensure_all_started(gun),

    [{port, Port} | Config].

end_per_suite(_Config) ->
    cowboy:stop_listener(converged_test_listener),
    ok.

init_per_testcase(_TestCase, Config) ->
    meck:new(chf_core, [non_strict, no_link]),
    Port = ?config(port, Config),
    {ok, ConnPid} = gun:open("127.0.0.1", Port, #{protocols => [http]}),
    {ok, http} = gun:await_up(ConnPid),
    [{conn, ConnPid} | Config].

end_per_testcase(_TestCase, Config) ->
    ConnPid = ?config(conn, Config),
    gun:close(ConnPid),
    meck:unload(chf_core),
    ok.

%%====================================================================
%% Test cases
%%====================================================================

create_session_success(Config) ->
    ConnPid = ?config(conn, Config),
    meck:expect(chf_core, create_session, fun(_) -> {ok, <<"test-session-1">>} end),
    meck:expect(chf_core, session_initial, fun(_, _) -> {ok, #{1 => 5000000}} end),

    Body = #{<<"subscriberIdentifier">> => #{<<"sUPI">> => <<"imsi-001010123456789">>},
             <<"multipleUnitUsage">>    => [
                 #{<<"ratingGroup">>   => 1,
                   <<"requestedUnit">> => #{<<"totalVolume">> => 10000000}}
             ]},
    {Status, RespHeaders, RespBody} = post_json(ConnPid,
        "/nchf-convergedcharging/v3/chargingdata", Body),

    ?assertEqual(201, Status),
    Location = proplists:get_value(<<"location">>, RespHeaders),
    ?assertMatch(<<"/nchf-convergedcharging/v3/chargingdata/", _/binary>>, Location),

    Decoded = chf_sbi_json:decode(RespBody),
    ?assertMatch(#{<<"multipleUnitInformation">> := [_ | _]}, Decoded).

create_session_missing_imsi(Config) ->
    ConnPid = ?config(conn, Config),
    %% No chf_core mock needed — handler returns 400 before calling chf_core.

    {Status, _RespHeaders, _RespBody} = post_json(ConnPid,
        "/nchf-convergedcharging/v3/chargingdata", #{}),

    ?assertEqual(400, Status).

update_session_success(Config) ->
    ConnPid = ?config(conn, Config),
    meck:expect(chf_core, session_update, fun(_, _) -> {ok, #{1 => 5000000}} end),

    Body = #{<<"multipleUnitUsage">> => [
        #{<<"ratingGroup">>   => 1,
          <<"requestedUnit">> => #{<<"totalVolume">> => 10000000}}
    ]},
    {Status, _RespHeaders, RespBody} = post_json(ConnPid,
        "/nchf-convergedcharging/v3/chargingdata/ref123/update", Body),

    ?assertEqual(200, Status),
    Decoded = chf_sbi_json:decode(RespBody),
    ?assertMatch(#{<<"multipleUnitInformation">> := [_ | _]}, Decoded).

update_session_not_found(Config) ->
    ConnPid = ?config(conn, Config),
    meck:expect(chf_core, session_update, fun(_, _) -> {error, not_found} end),

    Body = #{<<"multipleUnitUsage">> => []},
    {Status, _RespHeaders, _RespBody} = post_json(ConnPid,
        "/nchf-convergedcharging/v3/chargingdata/nosuchref/update", Body),

    ?assertEqual(404, Status).

release_session_success(Config) ->
    ConnPid = ?config(conn, Config),
    meck:expect(chf_core, session_terminate, fun(_, _) -> ok end),

    Body = #{<<"multipleUnitUsage">> => [
        #{<<"ratingGroup">>         => 1,
          <<"usedUnitContainer">>   => [#{<<"totalVolume">> => 3000000}]}
    ]},
    {Status, _RespHeaders, _RespBody} = post_json(ConnPid,
        "/nchf-convergedcharging/v3/chargingdata/ref123/release", Body),

    ?assertEqual(204, Status).

release_session_not_found(Config) ->
    ConnPid = ?config(conn, Config),
    meck:expect(chf_core, session_terminate, fun(_, _) -> {error, not_found} end),

    Body = #{<<"multipleUnitUsage">> => []},
    {Status, _RespHeaders, _RespBody} = post_json(ConnPid,
        "/nchf-convergedcharging/v3/chargingdata/nosuchref/release", Body),

    ?assertEqual(404, Status).

create_insufficient_balance_403(Config) ->
    ConnPid = ?config(conn, Config),
    meck:expect(chf_core, create_session,  fun(_) -> {ok, <<"s">>} end),
    meck:expect(chf_core, session_initial, fun(_, _) -> {error, insufficient_balance} end),
    Body = #{<<"subscriberIdentifier">> => #{<<"sUPI">> => <<"imsi-001010123456789">>}},
    {Status, _H, RespBody} = post_json(ConnPid,
        "/nchf-convergedcharging/v3/chargingdata", Body),
    ?assertEqual(403, Status),
    ?assertEqual(nomatch, binary:match(RespBody, <<"insufficient_balance">>)).

update_large_body_413(Config) ->
    ConnPid = ?config(conn, Config),
    meck:expect(chf_core, session_update, fun(_, _) -> {ok, #{}} end),
    Big = binary:copy(<<"x">>, 2 * 1024 * 1024),
    Json = <<"{\"pad\":\"", Big/binary, "\"}">>,
    Headers = [{<<"content-type">>, <<"application/json">>}],
    StreamRef = gun:post(ConnPid,
        "/nchf-convergedcharging/v3/chargingdata/ref/update", Headers, Json),
    {response, _, Status, _} = gun:await(ConnPid, StreamRef),
    ?assertEqual(413, Status).

%%====================================================================
%% Internal helpers
%%====================================================================

post_json(ConnPid, Path, Body) ->
    Headers = [{<<"content-type">>, <<"application/json">>}],
    StreamRef = gun:post(ConnPid, Path, Headers, iolist_to_binary(json:encode(Body))),
    {response, IsFin, Status, RespHeaders} = gun:await(ConnPid, StreamRef),
    RespBody = case IsFin of
        nofin -> {ok, B} = gun:await_body(ConnPid, StreamRef), B;
        fin   -> <<>>
    end,
    {Status, RespHeaders, RespBody}.
