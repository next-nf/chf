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

%% chf_diameter_gy_SUITE.erl — CT tests for chf_diameter_gy:handle_request/3.
%%
%% Mocks chf_core to isolate the Gy handler from the charging engine.
-module(chf_diameter_gy_SUITE).

-compile(export_all).

-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").
-include_lib("diameter/include/diameter.hrl").
-include_lib("chf_diameter/include/diameter_3gpp_ts32_299_ro.hrl").

%% These are intentionally literal protocol constants, NOT the generated
%% dictionary macros the production code uses. The test thus acts as an
%% independent oracle: production derives these values from the dictionary,
%% the test pins the actual on-wire integers, and they must agree. Replacing
%% them with the generated macros would mask a wrong dictionary enum/value.
-define(END_USER_IMSI,  1).
-define(CCR_INITIAL,    1).
-define(CCR_UPDATE,     2).
-define(CCR_TERMINATE,  3).

-define(DIAMETER_SUCCESS,              2001).
-define(DIAMETER_TOO_BUSY,             3004).
-define(DIAMETER_UNABLE_TO_COMPLY,     5012).
-define(DIAMETER_USER_UNKNOWN,         5030).
-define(DIAMETER_END_USER_SERVICE_DENIED, 4010).
-define(DIAMETER_CREDIT_LIMIT_REACHED,    4012).
-define(DIAMETER_UNKNOWN_SESSION_ID,      5002).

%%====================================================================
%% CT callbacks
%%====================================================================

all() ->
    [ccr_initial_success,
     ccr_initial_no_imsi,
     ccr_initial_core_error,
     ccr_update_success,
     ccr_terminate_success,
     ccr_unknown_error,
     ccr_initial_credit_limited_grants_zero,
     ccr_update_unknown_session,
     ccr_update_session_terminated,
     ccr_event_request,
     ccr_initial_multi_mscc,
     ccr_mscc_full_grant_no_fui,
     ccr_mscc_final_grant_has_fui,
     ccr_mscc_credit_limit_has_fui_4012,
     ccr_initial_no_quorum_too_busy].

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

make_sub_id_imsi(Imsi) ->
    #'diameter_ro_Subscription-Id'{
        'Subscription-Id-Type' = ?END_USER_IMSI,
        'Subscription-Id-Data' = Imsi
    }.

make_rsu(Octets) ->
    #'diameter_ro_Requested-Service-Unit'{
        'CC-Total-Octets' = [Octets]
    }.

make_usu(Octets) ->
    #'diameter_ro_Used-Service-Unit'{
        'CC-Total-Octets' = [Octets]
    }.

make_mscc(RG, RequestedOctets, UsedOctets) ->
    #'diameter_ro_Multiple-Services-Credit-Control'{
        'Rating-Group'           = [RG],
        'Requested-Service-Unit' = [make_rsu(RequestedOctets)],
        'Used-Service-Unit'      = [make_usu(UsedOctets)]
    }.

make_ccr(SessionId, ReqType, SubIdList, MSCCList) ->
    #diameter_ro_CCR{
        'Session-Id'                       = SessionId,
        'Origin-Host'                      = <<"peer.example.com">>,
        'Origin-Realm'                     = <<"peer.example.com">>,
        'Destination-Realm'                = <<"example.com">>,
        'Auth-Application-Id'              = 4,
        'Service-Context-Id'               = <<"32251@3gpp.org">>,
        'CC-Request-Type'                  = ReqType,
        'CC-Request-Number'                = 0,
        'Subscription-Id'                  = SubIdList,
        'Multiple-Services-Credit-Control' = MSCCList
    }.

call_handler(CCR) ->
    Packet = #diameter_packet{msg = CCR},
    Caps   = make_caps(),
    PeerRef = make_ref(),
    chf_diameter_gy:handle_request(Packet, <<"chf_gy">>, {PeerRef, Caps}).

%%====================================================================
%% Test cases
%%====================================================================

ccr_initial_success(_Config) ->
    meck:expect(chf_core, create_session,  fun(_) -> {ok, <<"test-session">>} end),
    meck:expect(chf_core, session_initial, fun(_, _) ->
        {ok, #{1 => #{granted => 5000000, outcome => granted}}} end),

    SessionId = <<"test-session-1">>,
    SubId = make_sub_id_imsi(<<"001010123456789">>),
    MSCC  = make_mscc(1, 10000000, 0),
    CCR   = make_ccr(SessionId, ?CCR_INITIAL, [SubId], [MSCC]),

    Result = call_handler(CCR),

    ?assertMatch({reply, #diameter_ro_CCA{
        'Result-Code' = ?DIAMETER_SUCCESS
    }}, Result),

    {reply, CCA} = Result,
    ?assertEqual(SessionId, CCA#diameter_ro_CCA.'Session-Id'),
    ?assertEqual(1, length(CCA#diameter_ro_CCA.'Multiple-Services-Credit-Control')).

ccr_initial_no_imsi(_Config) ->
    SessionId = <<"test-session-no-imsi">>,
    CCR = make_ccr(SessionId, ?CCR_INITIAL, [], []),

    Result = call_handler(CCR),

    ?assertMatch({reply, #diameter_ro_CCA{
        'Result-Code' = ?DIAMETER_USER_UNKNOWN
    }}, Result).

ccr_initial_core_error(_Config) ->
    meck:expect(chf_core, create_session, fun(_) -> {error, subscriber_not_found} end),

    SessionId = <<"test-session-no-sub">>,
    SubId = make_sub_id_imsi(<<"001010000000001">>),
    CCR   = make_ccr(SessionId, ?CCR_INITIAL, [SubId], []),

    Result = call_handler(CCR),

    ?assertMatch({reply, #diameter_ro_CCA{
        'Result-Code' = ?DIAMETER_USER_UNKNOWN
    }}, Result).

ccr_update_success(_Config) ->
    meck:expect(chf_core, session_update, fun(_, _) ->
        {ok, #{1 => #{granted => 5000000, outcome => granted}}} end),

    SessionId = <<"test-session-update">>,
    MSCC = make_mscc(1, 10000000, 3000000),
    CCR  = make_ccr(SessionId, ?CCR_UPDATE, [], [MSCC]),

    Result = call_handler(CCR),

    ?assertMatch({reply, #diameter_ro_CCA{
        'Result-Code' = ?DIAMETER_SUCCESS
    }}, Result).

ccr_terminate_success(_Config) ->
    meck:expect(chf_core, session_terminate, fun(_, _) -> ok end),

    SessionId = <<"test-session-term">>,
    MSCC = make_mscc(1, 0, 5000000),
    CCR  = make_ccr(SessionId, ?CCR_TERMINATE, [], [MSCC]),

    Result = call_handler(CCR),

    ?assertMatch({reply, #diameter_ro_CCA{
        'Result-Code' = ?DIAMETER_SUCCESS
    }}, Result).

ccr_unknown_error(_Config) ->
    meck:expect(chf_core, create_session,  fun(_) -> {ok, <<"test-session">>} end),
    meck:expect(chf_core, session_initial, fun(_, _) -> {error, something_unexpected} end),
    %% The handler cleans up the orphaned session on an initial failure.
    meck:expect(chf_core, session_terminate, fun(_, _) -> ok end),

    SessionId = <<"test-session-err">>,
    SubId = make_sub_id_imsi(<<"001010123456789">>),
    MSCC  = make_mscc(1, 10000000, 0),
    CCR   = make_ccr(SessionId, ?CCR_INITIAL, [SubId], [MSCC]),

    Result = call_handler(CCR),

    ?assertMatch({reply, #diameter_ro_CCA{
        'Result-Code' = ?DIAMETER_UNABLE_TO_COMPLY
    }}, Result).

%% A credit-limited rating group (zero available balance) is no longer a
%% command-level error: chf_core returns {ok, #{... outcome => credit_limit_reached}}
%% and the CCA carries command-level SUCCESS with a zero grant. INTERIM — a
%% later task adds the per-MSCC Final-Unit-Indication verdict; until then the
%% wire is unchanged from the all-granted case.
ccr_initial_credit_limited_grants_zero(_Config) ->
    meck:expect(chf_core, create_session,  fun(_) -> {ok, <<"s">>} end),
    meck:expect(chf_core, session_initial, fun(_, _) ->
        {ok, #{1 => #{granted => 0, outcome => credit_limit_reached}}} end),
    SubId = make_sub_id_imsi(<<"001010123456789">>),
    CCR = make_ccr(<<"s">>, ?CCR_INITIAL, [SubId], [make_mscc(1, 100, 0)]),
    ?assertMatch({reply, #diameter_ro_CCA{'Result-Code' = ?DIAMETER_SUCCESS}},
                 call_handler(CCR)).

ccr_update_unknown_session(_Config) ->
    meck:expect(chf_core, session_update, fun(_, _) -> {error, not_found} end),
    CCR = make_ccr(<<"s">>, ?CCR_UPDATE, [], [make_mscc(1, 100, 0)]),
    ?assertMatch({reply, #diameter_ro_CCA{'Result-Code' = ?DIAMETER_UNKNOWN_SESSION_ID}},
                 call_handler(CCR)).

ccr_update_session_terminated(_Config) ->
    meck:expect(chf_core, session_update, fun(_, _) -> {error, session_terminated} end),
    CCR = make_ccr(<<"s">>, ?CCR_UPDATE, [], [make_mscc(1, 100, 0)]),
    ?assertMatch({reply, #diameter_ro_CCA{'Result-Code' = ?DIAMETER_UNKNOWN_SESSION_ID}},
                 call_handler(CCR)).

%% CC-Request-Type=EVENT_REQUEST (4) falls to the catch-all clause in handle_ccr/4
%% and returns UNABLE_TO_COMPLY (5012). NOTE: EVENT is not yet a real session path
%% in the Gy handler (unlike Rf which has a full event flow); the Ro/Gy interface
%% uses INITIAL/UPDATE/TERMINATE for online charging — EVENT is rare in 3GPP Gy
%% deployments. A future implementation would require a full credit-control event
%% flow. The handler returns UNABLE_TO_COMPLY as a safe fall-through.
ccr_event_request(_Config) ->
    %% No chf_core mock needed: the catch-all clause never calls chf_core.
    CCR = make_ccr(<<"event-session">>, 4, [], []),
    ?assertMatch({reply, #diameter_ro_CCA{'Result-Code' = ?DIAMETER_UNABLE_TO_COMPLY}},
                 call_handler(CCR)).

%% A CCR-INITIAL carrying two rating groups must produce a CCA with two MSCC
%% entries, one grant per group.
ccr_initial_multi_mscc(_Config) ->
    meck:expect(chf_core, create_session,  fun(_) -> {ok, <<"multi-session">>} end),
    meck:expect(chf_core, session_initial, fun(_, _) ->
        {ok, #{1 => #{granted => 5000000, outcome => granted},
               2 => #{granted => 3000000, outcome => granted}}}
    end),

    SessionId = <<"multi-mscc-session">>,
    SubId     = make_sub_id_imsi(<<"001010123456789">>),
    MSCC1     = make_mscc(1, 10000000, 0),
    MSCC2     = make_mscc(2, 6000000, 0),
    CCR       = make_ccr(SessionId, ?CCR_INITIAL, [SubId], [MSCC1, MSCC2]),

    Result = call_handler(CCR),

    ?assertMatch({reply, #diameter_ro_CCA{'Result-Code' = ?DIAMETER_SUCCESS}}, Result),
    {reply, CCA} = Result,
    ?assertEqual(2, length(CCA#diameter_ro_CCA.'Multiple-Services-Credit-Control')).

%% outcome=granted: MSCC Result-Code=2001, no Final-Unit-Indication, GSU present.
ccr_mscc_full_grant_no_fui(_Config) ->
    meck:expect(chf_core, create_session,  fun(_) -> {ok, <<"s">>} end),
    meck:expect(chf_core, session_initial, fun(_, _) ->
        {ok, #{1 => #{granted => 1000, outcome => granted}}} end),
    SubId = make_sub_id_imsi(<<"001010123456789">>),
    CCR   = make_ccr(<<"s">>, ?CCR_INITIAL, [SubId], [make_mscc(1, 1000, 0)]),
    {reply, CCA} = call_handler(CCR),
    ?assertMatch(#diameter_ro_CCA{'Result-Code' = ?DIAMETER_SUCCESS}, CCA),
    [MSCC] = CCA#diameter_ro_CCA.'Multiple-Services-Credit-Control',
    ?assertEqual([?DIAMETER_SUCCESS],              MSCC#'diameter_ro_Multiple-Services-Credit-Control'.'Result-Code'),
    ?assertEqual([],                               MSCC#'diameter_ro_Multiple-Services-Credit-Control'.'Final-Unit-Indication'),
    ?assertEqual([3600],                           MSCC#'diameter_ro_Multiple-Services-Credit-Control'.'Validity-Time'),
    [GSU]  = MSCC#'diameter_ro_Multiple-Services-Credit-Control'.'Granted-Service-Unit',
    ?assertEqual([1000], GSU#'diameter_ro_Granted-Service-Unit'.'CC-Total-Octets').

%% outcome=final_grant: MSCC Result-Code=2001, FUI(TERMINATE) present, GSU present.
ccr_mscc_final_grant_has_fui(_Config) ->
    meck:expect(chf_core, create_session,  fun(_) -> {ok, <<"s">>} end),
    meck:expect(chf_core, session_initial, fun(_, _) ->
        {ok, #{1 => #{granted => 300, outcome => final_grant}}} end),
    SubId = make_sub_id_imsi(<<"001010123456789">>),
    CCR   = make_ccr(<<"s">>, ?CCR_INITIAL, [SubId], [make_mscc(1, 1000, 0)]),
    {reply, CCA} = call_handler(CCR),
    ?assertMatch(#diameter_ro_CCA{'Result-Code' = ?DIAMETER_SUCCESS}, CCA),
    [MSCC] = CCA#diameter_ro_CCA.'Multiple-Services-Credit-Control',
    ?assertEqual([?DIAMETER_SUCCESS],              MSCC#'diameter_ro_Multiple-Services-Credit-Control'.'Result-Code'),
    ?assertEqual([3600],                           MSCC#'diameter_ro_Multiple-Services-Credit-Control'.'Validity-Time'),
    [FUI]  = MSCC#'diameter_ro_Multiple-Services-Credit-Control'.'Final-Unit-Indication',
    ?assertEqual([0], FUI#'diameter_ro_Final-Unit-Indication'.'Final-Unit-Action'),
    [GSU]  = MSCC#'diameter_ro_Multiple-Services-Credit-Control'.'Granted-Service-Unit',
    ?assertEqual([300], GSU#'diameter_ro_Granted-Service-Unit'.'CC-Total-Octets').

%% outcome=credit_limit_reached: MSCC Result-Code=4012, FUI(TERMINATE), GSU absent.
ccr_mscc_credit_limit_has_fui_4012(_Config) ->
    meck:expect(chf_core, create_session,  fun(_) -> {ok, <<"s">>} end),
    meck:expect(chf_core, session_initial, fun(_, _) ->
        {ok, #{1 => #{granted => 0, outcome => credit_limit_reached}}} end),
    SubId = make_sub_id_imsi(<<"001010123456789">>),
    CCR   = make_ccr(<<"s">>, ?CCR_INITIAL, [SubId], [make_mscc(1, 100, 0)]),
    {reply, CCA} = call_handler(CCR),
    ?assertMatch(#diameter_ro_CCA{'Result-Code' = ?DIAMETER_SUCCESS}, CCA),
    [MSCC] = CCA#diameter_ro_CCA.'Multiple-Services-Credit-Control',
    ?assertEqual([?DIAMETER_CREDIT_LIMIT_REACHED], MSCC#'diameter_ro_Multiple-Services-Credit-Control'.'Result-Code'),
    %% Validity-Time only scopes an actual grant; omitted on a 4012 MSCC.
    ?assertEqual([],  MSCC#'diameter_ro_Multiple-Services-Credit-Control'.'Validity-Time'),
    [FUI]  = MSCC#'diameter_ro_Multiple-Services-Credit-Control'.'Final-Unit-Indication',
    ?assertEqual([0], FUI#'diameter_ro_Final-Unit-Indication'.'Final-Unit-Action'),
    ?assertEqual([],  MSCC#'diameter_ro_Multiple-Services-Credit-Control'.'Granted-Service-Unit').

%% When chf_core:session_initial returns {error, no_quorum}, the CCA command-level
%% Result-Code must be 3004 (TOO_BUSY).  The handler also calls session_terminate
%% to clean up the session created before the quorum check — mock it too.
ccr_initial_no_quorum_too_busy(_Config) ->
    meck:expect(chf_core, create_session,  fun(_) -> {ok, <<"s">>} end),
    meck:expect(chf_core, session_initial, fun(_, _) -> {error, no_quorum} end),
    meck:expect(chf_core, session_terminate, fun(_, _) -> ok end),
    SubId = make_sub_id_imsi(<<"001010123456789">>),
    CCR   = make_ccr(<<"s">>, ?CCR_INITIAL, [SubId], [make_mscc(1, 1000, 0)]),
    ?assertMatch({reply, #diameter_ro_CCA{'Result-Code' = ?DIAMETER_TOO_BUSY}},
                 call_handler(CCR)).
