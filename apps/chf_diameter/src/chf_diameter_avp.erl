%% chf_diameter_avp.erl — AVP extraction and construction helpers.
%%
%% Shared utilities used by both the Gy (Ro) and Rf callback modules
%% to decode incoming AVPs and encode outgoing AVPs.
-module(chf_diameter_avp).

-include_lib("chf_diameter/include/diameter_3gpp_ts32_299_ro.hrl").
-include_lib("chf_diameter/include/diameter_3gpp_ts32_299_rf.hrl").

-export([
    extract_imsi/1,
    extract_msisdn/1,
    extract_mscc_ro/1,
    build_mscc_response/1,
    extract_used_units_rf/1
]).

%% Subscription-Id-Type values (RFC 4006)
-define(END_USER_E164,  0).   %% MSISDN
-define(END_USER_IMSI,  1).

%%====================================================================
%% Subscription-Id helpers (Ro — #diameter_ro_'Subscription-Id'{})
%%====================================================================

%% @doc Extract IMSI from a list of Subscription-Id AVPs (Ro records).
%%
%% Returns the IMSI binary or undefined if not present.
-spec extract_imsi([#'diameter_ro_Subscription-Id'{}]) -> binary() | undefined.
extract_imsi(SubIdList) ->
    find_sub_id_ro(SubIdList, ?END_USER_IMSI).

%% @doc Extract MSISDN from a list of Subscription-Id AVPs (Ro records).
-spec extract_msisdn([#'diameter_ro_Subscription-Id'{}]) -> binary() | undefined.
extract_msisdn(SubIdList) ->
    find_sub_id_ro(SubIdList, ?END_USER_E164).

find_sub_id_ro([], _Type) ->
    undefined;
find_sub_id_ro([#'diameter_ro_Subscription-Id'{'Subscription-Id-Type' = Type,
                                                'Subscription-Id-Data' = Data} | _], Type) ->
    Data;
find_sub_id_ro([_ | Rest], Type) ->
    find_sub_id_ro(Rest, Type).

%%====================================================================
%% MSCC extraction (Ro — online charging)
%%====================================================================

%% @doc Convert a list of Multiple-Services-Credit-Control AVP records
%%      from an incoming CCR into our internal format.
%%
%% Returns a list of maps:
%%   #{rating_group => RGId,
%%     requested_units => integer(),
%%     used_units => integer()}
-spec extract_mscc_ro([#'diameter_ro_Multiple-Services-Credit-Control'{}]) -> [map()].
extract_mscc_ro(MSCCList) ->
    lists:filtermap(fun extract_one_mscc/1, MSCCList).

extract_one_mscc(#'diameter_ro_Multiple-Services-Credit-Control'{
        'Rating-Group'           = RGList,
        'Requested-Service-Unit' = RSUList,
        'Used-Service-Unit'      = USUList}) ->
    case RGList of
        [RGId | _] ->
            RequestedTotal = extract_rsu_total(RSUList),
            UsedTotal      = extract_usu_total(USUList),
            {true, #{rating_group    => RGId,
                     requested_units => RequestedTotal,
                     used_units      => UsedTotal}};
        [] ->
            false
    end.

%% Extract CC-Total-Octets from the first Requested-Service-Unit, default 0.
extract_rsu_total([]) ->
    0;
extract_rsu_total([#'diameter_ro_Requested-Service-Unit'{'CC-Total-Octets' = [V | _]} | _]) ->
    V;
extract_rsu_total([#'diameter_ro_Requested-Service-Unit'{'CC-Total-Octets' = []} | _]) ->
    0;
extract_rsu_total([_ | Rest]) ->
    extract_rsu_total(Rest).

%% Extract CC-Total-Octets summed over all Used-Service-Unit AVPs.
extract_usu_total([]) ->
    0;
extract_usu_total(USUList) ->
    lists:foldl(fun(#'diameter_ro_Used-Service-Unit'{'CC-Total-Octets' = [V | _]}, Acc) ->
                        Acc + V;
                   (#'diameter_ro_Used-Service-Unit'{'CC-Total-Octets' = []}, Acc) ->
                        Acc;
                   (_, Acc) ->
                        Acc
                end, 0, USUList).

%%====================================================================
%% CCA MSCC construction (Ro — online charging)
%%====================================================================

%% @doc Build a list of Multiple-Services-Credit-Control records for a CCA,
%%      given a map of #{RatingGroupId => GrantedOctets}.
-spec build_mscc_response(#{non_neg_integer() => integer()}) ->
    [#'diameter_ro_Multiple-Services-Credit-Control'{}].
build_mscc_response(GrantedMap) ->
    maps:fold(fun(RGId, GrantedAmount, Acc) ->
        GSU = #'diameter_ro_Granted-Service-Unit'{
            'CC-Total-Octets' = [GrantedAmount]
        },
        MSCC = #'diameter_ro_Multiple-Services-Credit-Control'{
            'Rating-Group'         = [RGId],
            'Granted-Service-Unit' = [GSU],
            'Validity-Time'        = [3600]   %% 1 hour validity
        },
        [MSCC | Acc]
    end, [], GrantedMap).

%%====================================================================
%% Rf helper — extract used units from Service-Information
%%====================================================================

%% @doc Extract used-unit data from an Rf ACR's Service-Information list.
%%
%% This is a best-effort extraction; we look for Used-Service-Unit in
%% the MSCC embedded within Service-Information.  Returns a list of maps
%% #{rating_group => RGId, used_units => Total}.
-spec extract_used_units_rf(list()) -> [map()].
extract_used_units_rf([]) ->
    [];
extract_used_units_rf(ServiceInfoList) ->
    %% Service-Information is a grouped AVP; its structure varies by
    %% service type.  We attempt to pull MSCC out of it when present.
    lists:flatmap(fun extract_si_rf/1, ServiceInfoList).

extract_si_rf(SI) when is_tuple(SI) ->
    %% The Service-Information grouped AVP record may contain a
    %% 'Multiple-Services-Credit-Control' field for Rf.
    case catch element(1, SI) of
        'diameter_rf_Service-Information' ->
            MSCCList = get_record_field(SI, 'Multiple-Services-Credit-Control', []),
            extract_mscc_rf(MSCCList);
        _ ->
            []
    end;
extract_si_rf(_) ->
    [].

extract_mscc_rf([]) ->
    [];
extract_mscc_rf(MSCCList) ->
    lists:filtermap(fun extract_one_mscc_rf/1, MSCCList).

extract_one_mscc_rf(#'diameter_rf_Multiple-Services-Credit-Control'{
        'Rating-Group'      = RGList,
        'Used-Service-Unit' = USUList}) ->
    case RGList of
        [RGId | _] ->
            UsedTotal = extract_usu_total_rf(USUList),
            {true, #{rating_group => RGId, used_units => UsedTotal}};
        [] ->
            false
    end;
extract_one_mscc_rf(_) ->
    false.

extract_usu_total_rf([]) ->
    0;
extract_usu_total_rf(USUList) ->
    lists:foldl(fun(#'diameter_rf_Used-Service-Unit'{'CC-Total-Octets' = [V | _]}, Acc) ->
                        Acc + V;
                   (#'diameter_rf_Used-Service-Unit'{'CC-Total-Octets' = []}, Acc) ->
                        Acc;
                   (_, Acc) ->
                        Acc
                end, 0, USUList).

%% Safe record field accessor (avoids crashes on unexpected record shapes).
get_record_field(Rec, Field, Default) ->
    try
        Fields = element(1, Rec),
        RecInfo = erlang:get(Fields),
        case RecInfo of
            undefined -> Default;
            _ ->
                Index = lists:keyfind(Field, 1, RecInfo),
                case Index of
                    {Field, Pos} -> element(Pos, Rec);
                    false        -> Default
                end
        end
    catch _:_ -> Default
    end.
