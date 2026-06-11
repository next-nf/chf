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

%% chf_diameter_rf_SUITE.erl — CT tests for chf_diameter_rf:handle_request/3.
%%
%% Mocks chf_core to isolate the Rf handler from the charging engine.
-module(chf_diameter_rf_SUITE).

-compile(export_all).

-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").
-include_lib("diameter/include/diameter.hrl").
-include_lib("chf_diameter/include/diameter_3gpp_ts32_299_rf.hrl").

-define(ART_EVENT,   1).
-define(ART_START,   2).
-define(ART_INTERIM, 3).
-define(ART_STOP,    4).

-define(DIAMETER_SUCCESS,          2001).
-define(DIAMETER_UNABLE_TO_COMPLY, 5012).
-define(DIAMETER_USER_UNKNOWN,     5030).

%%====================================================================
%% CT callbacks
%%====================================================================

all() ->
    [acr_start_success,
     acr_start_no_imsi,
     acr_interim_success,
     acr_stop_success,
     acr_event_success].

init_per_suite(Config) ->
    Config.

end_per_suite(_Config) ->
    ok.

init_per_testcase(_TestCase, Config) ->
    meck:new(chf_core, [non_strict, no_link]),
    Config.

end_per_testcase(_TestCase, _Config) ->
    meck:unload(chf_core),
    ok.

%%====================================================================
%% Helpers
%%====================================================================

make_caps() ->
    #diameter_caps{
        origin_host  = {<<"chf.example.com">>, <<"peer.example.com">>},
        origin_realm = {<<"example.com">>, <<"peer.example.com">>},
        vendor_id    = 0,
        product_name = <<"test">>
    }.

make_acr(SessionId, RecordType, UserName) ->
    #diameter_rf_ACR{
        'Session-Id'               = SessionId,
        'Origin-Host'              = <<"peer.example.com">>,
        'Origin-Realm'             = <<"peer.example.com">>,
        'Destination-Realm'        = <<"example.com">>,
        'Accounting-Record-Type'   = RecordType,
        'Accounting-Record-Number' = 0,
        'User-Name'                = UserName,
        'Service-Information'      = []
    }.

call_handler(ACR) ->
    Packet  = #diameter_packet{msg = ACR},
    Caps    = make_caps(),
    PeerRef = make_ref(),
    chf_diameter_rf:handle_request(Packet, <<"chf_rf">>, {PeerRef, Caps}).

%%====================================================================
%% Test cases
%%====================================================================

acr_start_success(_Config) ->
    meck:expect(chf_core, create_session,  fun(_) -> {ok, <<"test-session">>} end),
    meck:expect(chf_core, session_initial, fun(_, _) -> {ok, #{}} end),

    SessionId = <<"rf-session-start">>,
    ACR = make_acr(SessionId, ?ART_START, [<<"001010123456789">>]),

    Result = call_handler(ACR),

    ?assertMatch({reply, #diameter_rf_ACA{
        'Result-Code' = ?DIAMETER_SUCCESS
    }}, Result),

    {reply, ACA} = Result,
    ?assertEqual(SessionId, ACA#diameter_rf_ACA.'Session-Id').

acr_start_no_imsi(_Config) ->
    SessionId = <<"rf-session-no-imsi">>,
    ACR = make_acr(SessionId, ?ART_START, []),

    Result = call_handler(ACR),

    ?assertMatch({reply, #diameter_rf_ACA{
        'Result-Code' = ?DIAMETER_USER_UNKNOWN
    }}, Result).

acr_interim_success(_Config) ->
    meck:expect(chf_core, session_update, fun(_, _) -> {ok, #{}} end),

    SessionId = <<"rf-session-interim">>,
    ACR = make_acr(SessionId, ?ART_INTERIM, [<<"001010123456789">>]),

    Result = call_handler(ACR),

    ?assertMatch({reply, #diameter_rf_ACA{
        'Result-Code' = ?DIAMETER_SUCCESS
    }}, Result).

acr_stop_success(_Config) ->
    meck:expect(chf_core, session_terminate, fun(_, _) -> ok end),

    SessionId = <<"rf-session-stop">>,
    ACR = make_acr(SessionId, ?ART_STOP, [<<"001010123456789">>]),

    Result = call_handler(ACR),

    ?assertMatch({reply, #diameter_rf_ACA{
        'Result-Code' = ?DIAMETER_SUCCESS
    }}, Result).

acr_event_success(_Config) ->
    meck:expect(chf_core, create_session,   fun(_) -> {ok, <<"test-session">>} end),
    meck:expect(chf_core, session_initial,  fun(_, _) -> {ok, #{}} end),
    meck:expect(chf_core, session_terminate, fun(_, _) -> ok end),

    SessionId = <<"rf-session-event">>,
    ACR = make_acr(SessionId, ?ART_EVENT, [<<"001010123456789">>]),

    Result = call_handler(ACR),

    ?assertMatch({reply, #diameter_rf_ACA{
        'Result-Code' = ?DIAMETER_SUCCESS
    }}, Result).
