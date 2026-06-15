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

%% Subscription-Id-Type values come from the generated diameter_3gpp_ts32_299_ro
%% dictionary header (the RFC 4006 enum, inherited) — no hand-defined macros.
%% ?'DIAMETER_RO_SUBSCRIPTION-ID-TYPE_END_USER_E164' = 0 (MSISDN),
%% ?'DIAMETER_RO_SUBSCRIPTION-ID-TYPE_END_USER_IMSI' = 1.

%%====================================================================
%% Subscription-Id helpers (Ro — #diameter_ro_'Subscription-Id'{})
%%====================================================================

%% @doc Extract IMSI from a list of Subscription-Id AVPs (Ro records).
%%
%% Returns the IMSI binary or undefined if not present.
-spec extract_imsi([#'diameter_ro_Subscription-Id'{}]) -> binary() | undefined.
extract_imsi(SubIdList) ->
    find_sub_id_ro(SubIdList, ?'DIAMETER_RO_SUBSCRIPTION-ID-TYPE_END_USER_IMSI').

%% @doc Extract MSISDN from a list of Subscription-Id AVPs (Ro records).
-spec extract_msisdn([#'diameter_ro_Subscription-Id'{}]) -> binary() | undefined.
extract_msisdn(SubIdList) ->
    find_sub_id_ro(SubIdList, ?'DIAMETER_RO_SUBSCRIPTION-ID-TYPE_END_USER_E164').

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
%%      given an outcome map of #{RatingGroupId => #{granted => Octets, outcome => atom()}}.
%%
%% Outcome mapping:
%%   granted              -> Result-Code=2001, GSU present, Validity-Time, no FUI
%%   final_grant          -> Result-Code=2001, GSU present, Validity-Time, FUI(TERMINATE)
%%   credit_limit_reached -> Result-Code=4012, GSU omitted, no Validity-Time, FUI(TERMINATE)
%%
%% Validity-Time only scopes an actual grant (RFC 4006 §8.7 / TS 32.299), so it
%% is emitted only on the granting outcomes and omitted from the 4012 MSCC. It
%% is read from the chf_diameter application env ({chf_diameter, validity_time}),
%% defaulting to 3600 seconds.
%%
%% 2001 is used as a literal: the generated RO dictionary header defines no
%% SUCCESS Result-Code macro (its DIAMETER_RO_RESULT-CODE_* series is error
%% codes only, 4010+).
-spec build_mscc_response(chf_core:outcome_map()) ->
    [#'diameter_ro_Multiple-Services-Credit-Control'{}].
build_mscc_response(OutcomeMap) ->
    ValidityTime = application:get_env(chf_diameter, validity_time, 3600),
    maps:fold(fun(RGId, #{granted := Granted, outcome := Outcome}, Acc) ->
        [build_one_mscc(RGId, Granted, Outcome, ValidityTime) | Acc]
    end, [], OutcomeMap).

-spec build_one_mscc(non_neg_integer(), non_neg_integer(),
                     granted | final_grant | credit_limit_reached,
                     non_neg_integer()) ->
    #'diameter_ro_Multiple-Services-Credit-Control'{}.
build_one_mscc(RGId, _Granted, credit_limit_reached, _ValidityTime) ->
    Base = #'diameter_ro_Multiple-Services-Credit-Control'{
        'Rating-Group' = [RGId],
        'Result-Code'  = [?'DIAMETER_RO_RESULT-CODE_CREDIT_LIMIT_REACHED']},
    add_terminate_fui(Base);
build_one_mscc(RGId, Granted, Outcome, ValidityTime) ->
    GSU  = #'diameter_ro_Granted-Service-Unit'{'CC-Total-Octets' = [Granted]},
    Base = #'diameter_ro_Multiple-Services-Credit-Control'{
        'Rating-Group'         = [RGId],
        'Granted-Service-Unit' = [GSU],
        'Validity-Time'        = [ValidityTime],
        'Result-Code'          = [2001]},
    case Outcome of
        granted     -> Base;
        final_grant -> add_terminate_fui(Base)
    end.

-spec add_terminate_fui(#'diameter_ro_Multiple-Services-Credit-Control'{}) ->
    #'diameter_ro_Multiple-Services-Credit-Control'{}.
add_terminate_fui(MSCC) ->
    FUI = #'diameter_ro_Final-Unit-Indication'{
        'Final-Unit-Action' = [?'DIAMETER_RO_FINAL-UNIT-ACTION_TERMINATE']},
    MSCC#'diameter_ro_Multiple-Services-Credit-Control'{'Final-Unit-Indication' = [FUI]}.

%%====================================================================
%% Rf helper — extract used units from Service-Information
%%====================================================================

%% @doc Extract used-unit data from an Rf ACR's Service-Information list.
%%
%% PS offline charging carries volumes in
%% Service-Information -> PS-Information -> Traffic-Data-Volumes
%% (Accounting-Input-Octets + Accounting-Output-Octets). We sum those
%% into a single total under rating group 0 (the Rf ACR has no per-RG
%% MSCC).
%%
%% Returns [] when no volumes are present, or
%% [#{rating_group => 0, used_units => Total}].
-spec extract_used_units_rf(list()) -> [map()].
extract_used_units_rf([]) ->
    [];
extract_used_units_rf(ServiceInfoList) ->
    Total = lists:foldl(fun(SI, Acc) -> Acc + si_volume(SI) end, 0, ServiceInfoList),
    case Total of
        0 -> [];
        _ -> [#{rating_group => 0, used_units => Total}]
    end.

si_volume(#'diameter_rf_Service-Information'{'PS-Information' = PSList})
  when is_list(PSList) ->
    lists:foldl(fun ps_volume/2, 0, PSList);
si_volume(_) ->
    0.

ps_volume(#'diameter_rf_PS-Information'{'Traffic-Data-Volumes' = TDVList}, Acc)
  when is_list(TDVList) ->
    Acc + lists:foldl(fun tdv_volume/2, 0, TDVList);
ps_volume(_, Acc) ->
    Acc.

tdv_volume(#'diameter_rf_Traffic-Data-Volumes'{
              'Accounting-Input-Octets'  = In,
              'Accounting-Output-Octets' = Out}, Acc) ->
    Acc + first_int(In) + first_int(Out);
tdv_volume(_, Acc) ->
    Acc.

first_int([V | _]) when is_integer(V) -> V;
first_int(_)                          -> 0.
