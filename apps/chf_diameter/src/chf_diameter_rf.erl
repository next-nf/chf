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

%% chf_diameter_rf.erl — DIAMETER Rf application callback (offline charging).
%%
%% Implements the diameter application callback behaviour for the Rf
%% application (Accounting Application-Id 3).  The CHF acts as a server:
%% it receives Accounting-Requests (ACR) from network elements and replies
%% with Accounting-Answers (ACA).
%%
%% Session lifecycle mapping:
%%   ACR START   -> chf_core:create_session/1 + chf_core:session_initial/2
%%   ACR INTERIM -> chf_core:session_update/2
%%   ACR STOP    -> chf_core:session_terminate/2
%%   ACR EVENT   -> chf_core:create_session/1 + session_initial + session_terminate
-module(chf_diameter_rf).

-include_lib("diameter/include/diameter.hrl").
-include_lib("diameter/include/diameter_gen_base_rfc6733.hrl").
-include_lib("chf_diameter/include/diameter_3gpp_ts32_299_rf.hrl").
%% The Rf dictionary does not itself surface the RFC 4006 USER_UNKNOWN (5030)
%% Result-Code, so we include the inherited diameter_rfc4006_cc dictionary header
%% for ?'RESULT-CODE_USER_UNKNOWN'. SUCCESS/UNABLE_TO_COMPLY/UNKNOWN_SESSION_ID
%% come from the RFC 6733 base header; the Accounting-Record-Type enum from rf.
-include_lib("chf_diameter/include/diameter_rfc4006_cc.hrl").
-include_lib("kernel/include/logger.hrl").

%% diameter application callback exports
-export([peer_up/3,
         peer_down/3,
         pick_peer/4,
         prepare_request/3,
         prepare_retransmit/3,
         handle_answer/4,
         handle_error/4,
         handle_request/3]).

%% Result-Code and Accounting-Record-Type constants come from the generated
%% dictionary headers included above — no hand-defined macros.

%%====================================================================
%% diameter application callbacks — server-side stubs
%%====================================================================

peer_up(_SvcName, {PeerRef, _Caps}, State) ->
    ?LOG_INFO("Rf peer up: ~p", [PeerRef]),
    State.

peer_down(_SvcName, {PeerRef, _Caps}, State) ->
    ?LOG_INFO("Rf peer down: ~p", [PeerRef]),
    State.

%% We never originate requests, so these are stubs.
pick_peer([], _, _SvcName, _State) ->
    false.

prepare_request(_, _SvcName, _Peer) ->
    {discard, not_a_client}.

prepare_retransmit(_, _SvcName, _Peer) ->
    {discard, not_a_client}.

handle_answer(_, _, _SvcName, _Peer) ->
    ok.

handle_error(Reason, _Req, _SvcName, _Peer) ->
    ?LOG_WARNING("Rf diameter error: ~p", [Reason]),
    ok.

%%====================================================================
%% handle_request/3 — main server entry point
%%====================================================================

handle_request(#diameter_packet{msg = #diameter_rf_ACR{} = ACR},
               _SvcName,
               {_, Caps}) ->
    #diameter_caps{origin_host  = {OH, _},
                   origin_realm = {OR, _}} = Caps,
    SessionId   = ACR#diameter_rf_ACR.'Session-Id',
    RecordType  = ACR#diameter_rf_ACR.'Accounting-Record-Type',
    RecordNum   = ACR#diameter_rf_ACR.'Accounting-Record-Number',
    UserName    = ACR#diameter_rf_ACR.'User-Name',
    ServiceInfo = ACR#diameter_rf_ACR.'Service-Information',

    ?LOG_INFO("Rf ACR: session=~s type=~w number=~w",
              [SessionId, RecordType, RecordNum]),

    %% For Rf, IMSI may arrive as User-Name (a common practice) or be
    %% embedded inside Service-Information.  We try User-Name first.
    Imsi = extract_imsi_username(UserName),
    UsedRGs = chf_diameter_avp:extract_used_units_rf(ServiceInfo),

    Result = handle_acr(RecordType, SessionId, Imsi, UsedRGs),

    ACA = build_aca(SessionId, OH, OR, RecordType, RecordNum, Result),
    {reply, ACA};

handle_request(#diameter_packet{msg = Msg}, _SvcName, _Peer) ->
    ?LOG_WARNING("Rf: unexpected message type: ~p", [element(1, Msg)]),
    discard.

%%====================================================================
%% Per record-type dispatch
%%====================================================================

handle_acr(?'DIAMETER_RF_ACCOUNTING-RECORD-TYPE_START_RECORD', SessionId, Imsi, _UsedRGs) ->
    case ensure_imsi(Imsi, SessionId) of
        {error, _} = Err -> Err;
        ok ->
            Info = #{session_id => SessionId,
                     imsi       => Imsi,
                     type       => offline},
            case chf_core:create_session(Info) of
                {ok, _SessionId} ->
                    case chf_core:session_initial(SessionId, #{imsi => Imsi}) of
                        {ok, _} -> ok;
                        {error, IErr} ->
                            %% The initial CDR write failed: surface it rather
                            %% than answer 2001 SUCCESS on a lost billing record.
                            ?LOG_WARNING("Rf START session_initial failed session=~s reason=~p",
                                         [SessionId, IErr]),
                            {error, error_code(IErr)}
                    end;
                {error, Reason} ->
                    ?LOG_WARNING("Rf START create_session failed session=~s reason=~p",
                                 [SessionId, Reason]),
                    {error, error_code(Reason)}
            end
    end;

handle_acr(?'DIAMETER_RF_ACCOUNTING-RECORD-TYPE_INTERIM_RECORD', SessionId, _Imsi, UsedRGs) ->
    ReqData = #{rating_groups => UsedRGs},
    case chf_core:session_update(SessionId, ReqData) of
        {ok, _} -> ok;
        {error, Reason} ->
            ?LOG_WARNING("Rf INTERIM failed session=~s reason=~p",
                         [SessionId, Reason]),
            {error, error_code(Reason)}
    end;

handle_acr(?'DIAMETER_RF_ACCOUNTING-RECORD-TYPE_STOP_RECORD', SessionId, _Imsi, UsedRGs) ->
    ReqData = #{rating_groups => UsedRGs},
    case chf_core:session_terminate(SessionId, ReqData) of
        ok ->
            ok;
        {error, Reason} ->
            ?LOG_WARNING("Rf STOP failed session=~s reason=~p",
                         [SessionId, Reason]),
            {error, error_code(Reason)}
    end;

handle_acr(?'DIAMETER_RF_ACCOUNTING-RECORD-TYPE_EVENT_RECORD', SessionId, Imsi, UsedRGs) ->
    %% Event record: single shot — create, record, terminate.
    case ensure_imsi(Imsi, SessionId) of
        {error, _} = Err -> Err;
        ok ->
            Info = #{session_id => SessionId,
                     imsi       => Imsi,
                     type       => offline},
            case chf_core:create_session(Info) of
                {ok, _SessionId} ->
                    InitRes = chf_core:session_initial(SessionId, #{imsi => Imsi}),
                    %% Always terminate to settle and clean up the short-lived
                    %% event session, even if the initial write reported an error.
                    TermRes = chf_core:session_terminate(SessionId,
                                                          #{rating_groups => UsedRGs}),
                    case first_error([InitRes, TermRes]) of
                        ok -> ok;
                        {error, EErr} ->
                            ?LOG_WARNING("Rf EVENT failed session=~s reason=~p",
                                         [SessionId, EErr]),
                            {error, error_code(EErr)}
                    end;
                {error, Reason} ->
                    ?LOG_WARNING("Rf EVENT create_session failed session=~s reason=~p",
                                 [SessionId, Reason]),
                    {error, error_code(Reason)}
            end
    end;

handle_acr(RecordType, SessionId, _Imsi, _UsedRGs) ->
    ?LOG_WARNING("Rf: unknown Accounting-Record-Type=~w session=~s",
                 [RecordType, SessionId]),
    {error, ?'DIAMETER_BASE_RESULT-CODE_UNABLE_TO_COMPLY'}.

%%====================================================================
%% ACA builder
%%====================================================================

build_aca(SessionId, OriginHost, OriginRealm, RecordType, RecordNum, Result) ->
    %% handle_acr/4 returns ok | {error, Code}.
    ResultCode =
        case Result of
            ok            -> ?'DIAMETER_BASE_RESULT-CODE_SUCCESS';
            {error, Code} -> Code
        end,
    chf_otel:record_charging_outcome(rf, rf_outcome_atom(Result)),
    #diameter_rf_ACA{
        'Session-Id'              = SessionId,
        'Result-Code'             = ResultCode,
        'Origin-Host'             = OriginHost,
        'Origin-Realm'            = OriginRealm,
        'Accounting-Record-Type'  = RecordType,
        'Accounting-Record-Number' = RecordNum
    }.

%% map the charging result (ok | {error, Code}) to a metric-friendly outcome atom
rf_outcome_atom(ok)                                                        -> success;
rf_outcome_atom({error, ?'RESULT-CODE_USER_UNKNOWN'})                      -> user_unknown;
rf_outcome_atom({error, ?'DIAMETER_BASE_RESULT-CODE_UNKNOWN_SESSION_ID'})  -> unknown_session;
rf_outcome_atom({error, _})                                                -> unable_to_comply.

%%====================================================================
%% IMSI helpers (Rf)
%%====================================================================

%% For Rf, the IMSI is commonly carried in User-Name (NAI format or raw).
%% User-Name is a list of 0 or 1 binary values in OTP diameter records.
extract_imsi_username([]) ->
    undefined;
extract_imsi_username([Bin | _]) when is_binary(Bin) ->
    Bin;
extract_imsi_username(_) ->
    undefined.

ensure_imsi(undefined, SessionId) ->
    ?LOG_WARNING("Rf: no IMSI in ACR session=~s", [SessionId]),
    {error, ?'RESULT-CODE_USER_UNKNOWN'};
ensure_imsi(_, _) ->
    ok.

%%====================================================================
%% Error code mapping
%%====================================================================

%% NOTE (Phase 1 data-layer cutover): the `no_quorum` reason is retired with the
%% quorum gate (reintroduced deliberately in Phase 2); the `_` catch-all maps any
%% unexpected reason to UNABLE_TO_COMPLY.
error_code(subscriber_not_found) -> ?'RESULT-CODE_USER_UNKNOWN';
%% TS 32.299: a suspended/terminated end-user maps to END_USER_SERVICE_DENIED
%% (4010), not the generic UNABLE_TO_COMPLY (5012).
error_code(subscriber_suspended) -> ?'RESULT-CODE_END_USER_SERVICE_DENIED';
error_code(subscriber_terminated) -> ?'RESULT-CODE_END_USER_SERVICE_DENIED';
error_code(not_found)            -> ?'DIAMETER_BASE_RESULT-CODE_UNKNOWN_SESSION_ID';
error_code(session_terminated)   -> ?'DIAMETER_BASE_RESULT-CODE_UNKNOWN_SESSION_ID';
error_code(_)                    -> ?'DIAMETER_BASE_RESULT-CODE_UNABLE_TO_COMPLY'.

%% Return the first {error, _} in a list of charging-op results, else ok.
first_error([])               -> ok;
first_error([ok | T])         -> first_error(T);
first_error([{ok, _} | T])    -> first_error(T);
first_error([{error, _} = E | _]) -> E.
