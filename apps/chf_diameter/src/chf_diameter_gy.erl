%% chf_diameter_gy.erl — DIAMETER Gy/Ro application callback (online charging).
%%
%% Implements the diameter application callback behaviour for the Ro
%% application (Application-Id 4).  The CHF acts as a server: it receives
%% Credit-Control-Requests (CCR) from PGW/SGW nodes and replies with
%% Credit-Control-Answers (CCA).
%%
%% Session lifecycle mapping:
%%   CCR INITIAL   -> chf_core:create_session/1 + chf_core:session_initial/2
%%   CCR UPDATE    -> chf_core:session_update/2
%%   CCR TERMINATE -> chf_core:session_terminate/2
-module(chf_diameter_gy).

-include_lib("diameter/include/diameter.hrl").
-include_lib("diameter/include/diameter_gen_base_rfc6733.hrl").
-include_lib("chf_diameter/include/diameter_3gpp_ts32_299_ro.hrl").
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
-define(DIAMETER_SUCCESS,              2001).
-define(DIAMETER_UNABLE_TO_COMPLY,     5012).
-define(DIAMETER_USER_UNKNOWN,         5030).

%% CC-Request-Type values
-define(CCR_INITIAL,    1).
-define(CCR_UPDATE,     2).
-define(CCR_TERMINATE,  3).

%%====================================================================
%% diameter application callbacks — server-side stubs
%%====================================================================

peer_up(_SvcName, {PeerRef, _Caps}, State) ->
    ?LOG_INFO("Gy peer up: ~p", [PeerRef]),
    State.

peer_down(_SvcName, {PeerRef, _Caps}, State) ->
    ?LOG_INFO("Gy peer down: ~p", [PeerRef]),
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
    ?LOG_WARNING("Gy diameter error: ~p", [Reason]),
    ok.

%%====================================================================
%% handle_request/3 — main server entry point
%%====================================================================

handle_request(#diameter_packet{msg = #diameter_ro_CCR{} = CCR},
               _SvcName,
               {_, Caps}) ->
    #diameter_caps{origin_host  = {OH, _},
                   origin_realm = {OR, _}} = Caps,
    SessionId = CCR#diameter_ro_CCR.'Session-Id',
    ReqType   = CCR#diameter_ro_CCR.'CC-Request-Type',
    ReqNumber = CCR#diameter_ro_CCR.'CC-Request-Number',
    SubIdList = CCR#diameter_ro_CCR.'Subscription-Id',
    MSCCList  = CCR#diameter_ro_CCR.'Multiple-Services-Credit-Control',

    ?LOG_INFO("Gy CCR: session=~s type=~w number=~w",
              [SessionId, ReqType, ReqNumber]),

    Imsi = chf_diameter_avp:extract_imsi(SubIdList),
    RatingGroups = chf_diameter_avp:extract_mscc_ro(MSCCList),

    Result = handle_ccr(ReqType, SessionId, Imsi, RatingGroups),

    CCA = build_cca(SessionId, OH, OR, ReqType, ReqNumber, Result),
    {reply, CCA};

handle_request(#diameter_packet{msg = Msg}, _SvcName, _Peer) ->
    ?LOG_WARNING("Gy: unexpected message type: ~p", [element(1, Msg)]),
    discard.

%%====================================================================
%% Per request-type dispatch
%%====================================================================

handle_ccr(?CCR_INITIAL, SessionId, Imsi, RatingGroups) ->
    case Imsi of
        undefined ->
            ?LOG_WARNING("Gy INITIAL: no IMSI in CCR session=~s", [SessionId]),
            {error, ?DIAMETER_USER_UNKNOWN};
        _ ->
            Info = #{session_id => SessionId,
                     imsi       => Imsi,
                     type       => online},
            case chf_core:create_session(Info) of
                {ok, _Pid} ->
                    ReqData = #{imsi          => Imsi,
                                rating_groups => RatingGroups},
                    case chf_core:session_initial(SessionId, ReqData) of
                        {ok, GrantedMap} ->
                            {ok, GrantedMap};
                        {error, Reason} ->
                            ?LOG_WARNING("Gy INITIAL failed session=~s reason=~p",
                                         [SessionId, Reason]),
                            {error, error_code(Reason)}
                    end;
                {error, Reason} ->
                    ?LOG_WARNING("Gy create_session failed session=~s reason=~p",
                                 [SessionId, Reason]),
                    {error, error_code(Reason)}
            end
    end;

handle_ccr(?CCR_UPDATE, SessionId, _Imsi, RatingGroups) ->
    ReqData = #{rating_groups => RatingGroups},
    case chf_core:session_update(SessionId, ReqData) of
        {ok, GrantedMap} ->
            {ok, GrantedMap};
        {error, Reason} ->
            ?LOG_WARNING("Gy UPDATE failed session=~s reason=~p",
                         [SessionId, Reason]),
            {error, error_code(Reason)}
    end;

handle_ccr(?CCR_TERMINATE, SessionId, _Imsi, RatingGroups) ->
    ReqData = #{rating_groups => RatingGroups},
    case chf_core:session_terminate(SessionId, ReqData) of
        ok ->
            {ok, #{}};
        {error, Reason} ->
            ?LOG_WARNING("Gy TERMINATE failed session=~s reason=~p",
                         [SessionId, Reason]),
            {error, error_code(Reason)}
    end;

handle_ccr(ReqType, SessionId, _Imsi, _RatingGroups) ->
    ?LOG_WARNING("Gy: unknown CC-Request-Type=~w session=~s",
                 [ReqType, SessionId]),
    {error, ?DIAMETER_UNABLE_TO_COMPLY}.

%%====================================================================
%% CCA builder
%%====================================================================

build_cca(SessionId, OriginHost, OriginRealm, ReqType, ReqNumber, Result) ->
    {ResultCode, MSCCList} =
        case Result of
            {ok, GrantedMap} ->
                {?DIAMETER_SUCCESS,
                 chf_diameter_avp:build_mscc_response(GrantedMap)};
            {error, Code} ->
                {Code, []}
        end,
    #diameter_ro_CCA{
        'Session-Id'                     = SessionId,
        'Result-Code'                    = ResultCode,
        'Origin-Host'                    = OriginHost,
        'Origin-Realm'                   = OriginRealm,
        'Auth-Application-Id'            = 4,
        'CC-Request-Type'                = ReqType,
        'CC-Request-Number'              = ReqNumber,
        'Multiple-Services-Credit-Control' = MSCCList
    }.

%%====================================================================
%% Error code mapping
%%====================================================================

error_code(subscriber_not_found)  -> ?DIAMETER_USER_UNKNOWN;
error_code(subscriber_suspended)  -> ?DIAMETER_UNABLE_TO_COMPLY;
error_code(not_found)             -> ?DIAMETER_USER_UNKNOWN;
error_code(_)                     -> ?DIAMETER_UNABLE_TO_COMPLY.
