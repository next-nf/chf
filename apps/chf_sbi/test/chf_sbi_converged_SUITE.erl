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
     release_empty_body,
     update_session_terminated,
     release_session_terminated,
     wrong_content_type,
     create_insufficient_balance_403,
     update_large_body_413,
     converged_response_final_unit_indication,
     converged_response_full_grant_no_fui,
     converged_response_final_grant_fui_with_grant].

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
    meck:expect(chf_core, session_initial, fun(_, _) ->
        {ok, #{1 => #{granted => 5000000, outcome => granted}}} end),

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
    meck:expect(chf_core, session_update, fun(_, _) ->
        {ok, #{1 => #{granted => 5000000, outcome => granted}}} end),

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

%% TS 32.291 §6.1 allows an empty body on release (the SMF may have nothing
%% to report). The handler currently reads the body and rejects <<>> as 400 —
%% this is stricter than the spec. NOTE: gap — TS 32.291 §6.1.4 permits an
%% empty ChargingDataRequest body on release; the handler should treat an empty
%% body as an empty multipleUnitUsage list and return 204, not 400.
release_empty_body(Config) ->
    ConnPid = ?config(conn, Config),
    Headers = [{<<"content-type">>, <<"application/json">>}],
    StreamRef = gun:post(ConnPid,
        "/nchf-convergedcharging/v3/chargingdata/ref123/release",
        Headers, <<>>),
    {response, _Fin, Status, _RespHeaders} = gun:await(ConnPid, StreamRef),
    %% Current behavior: 400. NOTE: TS 32.291 §6.1.4 allows an empty release
    %% body; this should ideally be 204 per the spec.
    ?assertEqual(400, Status).

%% session_terminated on update maps to 404 via chf_sbi_error:reason_to_problem/1.
update_session_terminated(Config) ->
    ConnPid = ?config(conn, Config),
    meck:expect(chf_core, session_update, fun(_, _) -> {error, session_terminated} end),

    Body = #{<<"multipleUnitUsage">> => []},
    {Status, _RespHeaders, _RespBody} = post_json(ConnPid,
        "/nchf-convergedcharging/v3/chargingdata/ref123/update", Body),

    ?assertEqual(404, Status).

%% session_terminated on release maps to 404 via chf_sbi_error:reason_to_problem/1.
release_session_terminated(Config) ->
    ConnPid = ?config(conn, Config),
    meck:expect(chf_core, session_terminate, fun(_, _) -> {error, session_terminated} end),

    Body = #{<<"multipleUnitUsage">> => []},
    {Status, _RespHeaders, _RespBody} = post_json(ConnPid,
        "/nchf-convergedcharging/v3/chargingdata/ref123/release", Body),

    ?assertEqual(404, Status).

%% The handler does not enforce Content-Type: it decodes whatever arrives and
%% relies on the JSON parser to reject non-JSON payloads. A wrong Content-Type
%% with valid JSON still returns 200 (on update). NOTE: gap — TS 32.291 requires
%% Content-Type: application/json; the handler should return 415 on mismatch.
wrong_content_type(Config) ->
    ConnPid = ?config(conn, Config),
    meck:expect(chf_core, session_update, fun(_, _) ->
        {ok, #{1 => #{granted => 5000000, outcome => granted}}} end),
    Body = json:encode(#{<<"multipleUnitUsage">> => []}),
    Headers = [{<<"content-type">>, <<"text/plain">>}],
    StreamRef = gun:post(ConnPid,
        "/nchf-convergedcharging/v3/chargingdata/ref123/update",
        Headers, Body),
    {response, nofin, Status, _RespHeaders} = gun:await(ConnPid, StreamRef),
    %% Current behavior: 200 — handler does not check Content-Type.
    %% NOTE: TS 32.291 requires Content-Type: application/json; 415 would be
    %% the correct response.
    ?assertEqual(200, Status).

create_insufficient_balance_403(Config) ->
    ConnPid = ?config(conn, Config),
    meck:expect(chf_core, create_session,  fun(_) -> {ok, <<"s">>} end),
    meck:expect(chf_core, session_initial, fun(_, _) -> {error, insufficient_balance} end),
    %% The handler cleans up the orphaned session on an initial failure.
    meck:expect(chf_core, session_terminate, fun(_, _) -> ok end),
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

converged_response_final_unit_indication(Config) ->
    ConnPid = ?config(conn, Config),
    meck:expect(chf_core, create_session,  fun(_) -> {ok, <<"s">>} end),
    meck:expect(chf_core, session_initial, fun(_, _) ->
        {ok, #{1 => #{granted => 0, outcome => credit_limit_reached}}} end),
    Body = #{<<"subscriberIdentifier">> => #{<<"sUPI">> => <<"imsi-001010123456789">>},
             <<"multipleUnitUsage">> => [#{<<"ratingGroup">> => 1,
                                           <<"requestedUnit">> => #{<<"totalVolume">> => 1000}}]},
    {201, _H, RespBody} = post_json(ConnPid, "/nchf-convergedcharging/v3/chargingdata", Body),
    #{<<"multipleUnitInformation">> := [MUI]} = decode(RespBody),
    ?assertEqual(4012, maps:get(<<"resultCode">>, MUI)),
    ?assertEqual(<<"TERMINATE">>,
                 maps:get(<<"finalUnitAction">>, maps:get(<<"finalUnitIndication">>, MUI))),
    ?assertNot(maps:is_key(<<"grantedUnit">>, MUI)).

converged_response_full_grant_no_fui(Config) ->
    ConnPid = ?config(conn, Config),
    meck:expect(chf_core, create_session,  fun(_) -> {ok, <<"s">>} end),
    meck:expect(chf_core, session_initial, fun(_, _) ->
        {ok, #{1 => #{granted => 1000, outcome => granted}}} end),
    Body = #{<<"subscriberIdentifier">> => #{<<"sUPI">> => <<"imsi-001010123456789">>},
             <<"multipleUnitUsage">> => [#{<<"ratingGroup">> => 1,
                                           <<"requestedUnit">> => #{<<"totalVolume">> => 1000}}]},
    {201, _H, RespBody} = post_json(ConnPid, "/nchf-convergedcharging/v3/chargingdata", Body),
    #{<<"multipleUnitInformation">> := [MUI]} = decode(RespBody),
    ?assertEqual(2001, maps:get(<<"resultCode">>, MUI)),
    ?assertNot(maps:is_key(<<"finalUnitIndication">>, MUI)),
    ?assertEqual(1000, maps:get(<<"totalVolume">>, maps:get(<<"grantedUnit">>, MUI))).

%% final_grant: last grant before exhaustion — 2001 + grantedUnit AND FUI(TERMINATE).
converged_response_final_grant_fui_with_grant(Config) ->
    ConnPid = ?config(conn, Config),
    meck:expect(chf_core, create_session,  fun(_) -> {ok, <<"s">>} end),
    meck:expect(chf_core, session_initial, fun(_, _) ->
        {ok, #{1 => #{granted => 500, outcome => final_grant}}} end),
    Body = #{<<"subscriberIdentifier">> => #{<<"sUPI">> => <<"imsi-001010123456789">>},
             <<"multipleUnitUsage">> => [#{<<"ratingGroup">> => 1,
                                           <<"requestedUnit">> => #{<<"totalVolume">> => 1000}}]},
    {201, _H, RespBody} = post_json(ConnPid, "/nchf-convergedcharging/v3/chargingdata", Body),
    #{<<"multipleUnitInformation">> := [MUI]} = decode(RespBody),
    ?assertEqual(2001, maps:get(<<"resultCode">>, MUI)),
    ?assertEqual(500, maps:get(<<"totalVolume">>, maps:get(<<"grantedUnit">>, MUI))),
    ?assertEqual(<<"TERMINATE">>,
                 maps:get(<<"finalUnitAction">>, maps:get(<<"finalUnitIndication">>, MUI))).

%%====================================================================
%% Internal helpers
%%====================================================================

decode(Bin) -> chf_sbi_json:decode(Bin).

post_json(ConnPid, Path, Body) ->
    Headers = [{<<"content-type">>, <<"application/json">>}],
    StreamRef = gun:post(ConnPid, Path, Headers, iolist_to_binary(json:encode(Body))),
    {response, IsFin, Status, RespHeaders} = gun:await(ConnPid, StreamRef),
    RespBody = case IsFin of
        nofin -> {ok, B} = gun:await_body(ConnPid, StreamRef), B;
        fin   -> <<>>
    end,
    {Status, RespHeaders, RespBody}.
