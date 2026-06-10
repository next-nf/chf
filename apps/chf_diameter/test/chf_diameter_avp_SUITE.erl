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

%% chf_diameter_avp_SUITE.erl — CT tests for chf_diameter_avp pure functions.
-module(chf_diameter_avp_SUITE).

-compile(export_all).

-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").
-include_lib("chf_diameter/include/diameter_3gpp_ts32_299_ro.hrl").
-include_lib("chf_diameter/include/diameter_3gpp_ts32_299_rf.hrl").

-define(END_USER_E164, 0).
-define(END_USER_IMSI, 1).

%%====================================================================
%% CT callbacks
%%====================================================================

all() ->
    [extract_imsi_found,
     extract_imsi_missing,
     extract_msisdn_found,
     extract_msisdn_missing,
     extract_mscc_ro_single,
     extract_mscc_ro_empty,
     build_mscc_response_single,
     build_mscc_response_empty,
     extract_used_units_rf_from_ps_information].

init_per_suite(Config) ->
    Config.

end_per_suite(_Config) ->
    ok.

init_per_testcase(_TestCase, Config) ->
    Config.

end_per_testcase(_TestCase, _Config) ->
    ok.

%%====================================================================
%% Test cases: extract_imsi/1
%%====================================================================

extract_imsi_found(_Config) ->
    SubId = #'diameter_ro_Subscription-Id'{
        'Subscription-Id-Type' = ?END_USER_IMSI,
        'Subscription-Id-Data' = <<"001010123456789">>
    },
    ?assertEqual(<<"001010123456789">>, chf_diameter_avp:extract_imsi([SubId])).

extract_imsi_missing(_Config) ->
    %% Empty list
    ?assertEqual(undefined, chf_diameter_avp:extract_imsi([])),
    %% List with only MSISDN type
    MsisdnId = #'diameter_ro_Subscription-Id'{
        'Subscription-Id-Type' = ?END_USER_E164,
        'Subscription-Id-Data' = <<"447700900000">>
    },
    ?assertEqual(undefined, chf_diameter_avp:extract_imsi([MsisdnId])).

%%====================================================================
%% Test cases: extract_msisdn/1
%%====================================================================

extract_msisdn_found(_Config) ->
    SubId = #'diameter_ro_Subscription-Id'{
        'Subscription-Id-Type' = ?END_USER_E164,
        'Subscription-Id-Data' = <<"447700900000">>
    },
    ?assertEqual(<<"447700900000">>, chf_diameter_avp:extract_msisdn([SubId])).

extract_msisdn_missing(_Config) ->
    %% Empty list
    ?assertEqual(undefined, chf_diameter_avp:extract_msisdn([])),
    %% List with only IMSI type
    ImsiId = #'diameter_ro_Subscription-Id'{
        'Subscription-Id-Type' = ?END_USER_IMSI,
        'Subscription-Id-Data' = <<"001010123456789">>
    },
    ?assertEqual(undefined, chf_diameter_avp:extract_msisdn([ImsiId])).

%%====================================================================
%% Test cases: extract_mscc_ro/1
%%====================================================================

extract_mscc_ro_single(_Config) ->
    RSU = #'diameter_ro_Requested-Service-Unit'{
        'CC-Total-Octets' = [10000000]
    },
    USU = #'diameter_ro_Used-Service-Unit'{
        'CC-Total-Octets' = [3000000]
    },
    MSCC = #'diameter_ro_Multiple-Services-Credit-Control'{
        'Rating-Group'           = [1],
        'Requested-Service-Unit' = [RSU],
        'Used-Service-Unit'      = [USU]
    },
    Result = chf_diameter_avp:extract_mscc_ro([MSCC]),
    ?assertMatch([#{rating_group := 1,
                    requested_units := 10000000,
                    used_units := 3000000}], Result).

extract_mscc_ro_empty(_Config) ->
    ?assertEqual([], chf_diameter_avp:extract_mscc_ro([])).

%%====================================================================
%% Test cases: build_mscc_response/1
%%====================================================================

build_mscc_response_single(_Config) ->
    GrantedMap = #{1 => 5000000},
    Result = chf_diameter_avp:build_mscc_response(GrantedMap),
    ?assertMatch([#'diameter_ro_Multiple-Services-Credit-Control'{
        'Rating-Group'         = [1],
        'Granted-Service-Unit' = [#'diameter_ro_Granted-Service-Unit'{
            'CC-Total-Octets' = [5000000]
        }]
    }], Result).

build_mscc_response_empty(_Config) ->
    ?assertEqual([], chf_diameter_avp:build_mscc_response(#{})).

%%====================================================================
%% Test cases: extract_used_units_rf/1
%%====================================================================

extract_used_units_rf_from_ps_information(_Config) ->
    TDV = #'diameter_rf_Traffic-Data-Volumes'{
        'Accounting-Input-Octets'  = [1000],
        'Accounting-Output-Octets' = [500]
    },
    PS = #'diameter_rf_PS-Information'{'Traffic-Data-Volumes' = [TDV]},
    SI = #'diameter_rf_Service-Information'{'PS-Information' = [PS]},
    Result = chf_diameter_avp:extract_used_units_rf([SI]),
    ?assertEqual([#{rating_group => 0, used_units => 1500}], Result).
