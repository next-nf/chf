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

%% DIAMETER result codes
-define(DIAMETER_SUCCESS,         2001).
-define(DIAMETER_UNABLE_TO_COMPLY, 5012).
-define(DIAMETER_USER_UNKNOWN,    5030).

%% Accounting-Record-Type values
-define(ART_EVENT,   1).
-define(ART_START,   2).
-define(ART_INTERIM, 3).
-define(ART_STOP,    4).

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

handle_acr(?ART_START, SessionId, Imsi, _UsedRGs) ->
    case ensure_imsi(Imsi, SessionId) of
        {error, _} = Err -> Err;
        ok ->
            Info = #{session_id => SessionId,
                     imsi       => Imsi,
                     type       => offline},
            case chf_core:create_session(Info) of
                {ok, _Pid} ->
                    ReqData = #{imsi => Imsi},
                    _ = chf_core:session_initial(SessionId, ReqData),
                    ok;
                {error, Reason} ->
                    ?LOG_WARNING("Rf START create_session failed session=~s reason=~p",
                                 [SessionId, Reason]),
                    {error, error_code(Reason)}
            end
    end;

handle_acr(?ART_INTERIM, SessionId, _Imsi, UsedRGs) ->
    ReqData = #{rating_groups => UsedRGs},
    case chf_core:session_update(SessionId, ReqData) of
        {ok, _} -> ok;
        ok      -> ok;
        {error, Reason} ->
            ?LOG_WARNING("Rf INTERIM failed session=~s reason=~p",
                         [SessionId, Reason]),
            {error, error_code(Reason)}
    end;

handle_acr(?ART_STOP, SessionId, _Imsi, UsedRGs) ->
    ReqData = #{rating_groups => UsedRGs},
    case chf_core:session_terminate(SessionId, ReqData) of
        ok ->
            ok;
        {error, Reason} ->
            ?LOG_WARNING("Rf STOP failed session=~s reason=~p",
                         [SessionId, Reason]),
            {error, error_code(Reason)}
    end;

handle_acr(?ART_EVENT, SessionId, Imsi, UsedRGs) ->
    %% Event record: single shot — create, record, terminate.
    case ensure_imsi(Imsi, SessionId) of
        {error, _} = Err -> Err;
        ok ->
            Info = #{session_id => SessionId,
                     imsi       => Imsi,
                     type       => offline},
            case chf_core:create_session(Info) of
                {ok, _Pid} ->
                    _ = chf_core:session_initial(SessionId, #{imsi => Imsi}),
                    TermData = #{rating_groups => UsedRGs},
                    _ = chf_core:session_terminate(SessionId, TermData),
                    ok;
                {error, Reason} ->
                    ?LOG_WARNING("Rf EVENT failed session=~s reason=~p",
                                 [SessionId, Reason]),
                    {error, error_code(Reason)}
            end
    end;

handle_acr(RecordType, SessionId, _Imsi, _UsedRGs) ->
    ?LOG_WARNING("Rf: unknown Accounting-Record-Type=~w session=~s",
                 [RecordType, SessionId]),
    {error, ?DIAMETER_UNABLE_TO_COMPLY}.

%%====================================================================
%% ACA builder
%%====================================================================

build_aca(SessionId, OriginHost, OriginRealm, RecordType, RecordNum, Result) ->
    ResultCode =
        case Result of
            ok              -> ?DIAMETER_SUCCESS;
            {ok, _}         -> ?DIAMETER_SUCCESS;
            {error, Code}   -> Code
        end,
    #diameter_rf_ACA{
        'Session-Id'              = SessionId,
        'Result-Code'             = ResultCode,
        'Origin-Host'             = OriginHost,
        'Origin-Realm'            = OriginRealm,
        'Accounting-Record-Type'  = RecordType,
        'Accounting-Record-Number' = RecordNum
    }.

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
    {error, ?DIAMETER_USER_UNKNOWN};
ensure_imsi(_, _) ->
    ok.

%%====================================================================
%% Error code mapping
%%====================================================================

error_code(subscriber_not_found)  -> ?DIAMETER_USER_UNKNOWN;
error_code(subscriber_suspended)  -> ?DIAMETER_UNABLE_TO_COMPLY;
error_code(not_found)             -> ?DIAMETER_USER_UNKNOWN;
error_code(_)                     -> ?DIAMETER_UNABLE_TO_COMPLY.
