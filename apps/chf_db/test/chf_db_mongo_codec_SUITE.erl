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

%% chf_db_mongo_codec_SUITE.erl — Pure unit tests for chf_db_mongo_codec.
%% No Mongo connection required; runs in every environment.
-module(chf_db_mongo_codec_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").
-include_lib("chf_db/include/chf_db.hrl").

all() ->
    [subscriber_roundtrip,
     balance_int64_roundtrip,
     rating_group_keys_stringified,
     cdr_roundtrip,
     session_roundtrip,
     status_type_atoms].

%%--------------------------------------------------------------------
%% Test cases
%%--------------------------------------------------------------------

subscriber_roundtrip(_) ->
    Sub = #subscriber{
        imsi          = <<"001010000000001">>,
        msisdn        = <<"491234567890">>,
        account_id    = <<"acc-1">>,
        status        = suspended,
        rating_groups = #{100 => #{quota => 5000, priority => 1},
                          200 => #{quota => 0,    priority => 2}},
        created_at    = 1718400000000,
        updated_at    = 1718400001000
    },
    Doc = chf_db_mongo_codec:from_subscriber(Sub),
    %% _id must be the IMSI
    ?assertEqual(<<"001010000000001">>, maps:get(<<"_id">>, Doc)),
    %% Round-trip
    ?assertEqual(Sub, chf_db_mongo_codec:to_subscriber(Doc)).

balance_int64_roundtrip(_) ->
    %% 9007199254740993 > 2^31-1 and > 2^53 (JavaScript safe integer boundary).
    %% The driver encodes Erlang integers as BSON int64 automatically when needed;
    %% we just verify no float conversion occurs on our side.
    B = #balance{
        account_id = <<"acc-large">>,
        total      = 9007199254740993,
        reserved   = 0,
        available  = 9007199254740993
    },
    Doc = chf_db_mongo_codec:from_balance(B),
    ?assertEqual(<<"acc-large">>, maps:get(<<"_id">>, Doc)),
    ?assert(is_integer(maps:get(<<"total">>, Doc))),
    ?assert(is_integer(maps:get(<<"reserved">>, Doc))),
    ?assert(is_integer(maps:get(<<"available">>, Doc))),
    ?assertEqual(9007199254740993, maps:get(<<"total">>, Doc)),
    ?assertEqual(B, chf_db_mongo_codec:to_balance(Doc)).

rating_group_keys_stringified(_) ->
    S = #charging_session{
        session_id    = <<"sess-1">>,
        imsi          = <<"001010000000001">>,
        type          = converged,
        state         = active,
        granted_units = #{100 => 500, 200 => 0},
        used_units    = #{100 => 10},
        created_at    = 1,
        updated_at    = 2
    },
    Doc = chf_db_mongo_codec:from_session(S),
    GU = maps:get(<<"granted_units">>, Doc),
    UU = maps:get(<<"used_units">>, Doc),
    %% Keys must be strings (binaries), not integers
    ?assert(maps:is_key(<<"100">>, GU)),
    ?assert(maps:is_key(<<"200">>, GU)),
    ?assert(maps:is_key(<<"100">>, UU)),
    ?assertNot(maps:is_key(100, GU)),
    ?assertNot(maps:is_key(100, UU)),
    %% Values must be preserved
    ?assertEqual(500, maps:get(<<"100">>, GU)),
    ?assertEqual(0,   maps:get(<<"200">>, GU)),
    ?assertEqual(10,  maps:get(<<"100">>, UU)),
    %% Full round-trip
    ?assertEqual(S, chf_db_mongo_codec:to_session(Doc)).

cdr_roundtrip(_) ->
    Cdr = #cdr{
        id           = <<"cdr-001">>,
        session_id   = <<"sess-1">>,
        imsi         = <<"001010000000001">>,
        type         = offline,
        rating_group = 100,
        used_units   = #{input => 1024, output => 2048, total => 3072},
        timestamp    = 1718400000000,
        metadata     = #{<<"charging_id">> => <<"ch-42">>, <<"rat_type">> => <<"NR">>}
    },
    Doc = chf_db_mongo_codec:from_cdr(Cdr),
    %% _id must be the CDR id
    ?assertEqual(<<"cdr-001">>, maps:get(<<"_id">>, Doc)),
    %% used_units keys must be binaries
    UU = maps:get(<<"used_units">>, Doc),
    ?assert(maps:is_key(<<"input">>, UU)),
    ?assert(maps:is_key(<<"output">>, UU)),
    ?assert(maps:is_key(<<"total">>, UU)),
    %% Round-trip
    ?assertEqual(Cdr, chf_db_mongo_codec:to_cdr(Doc)).

session_roundtrip(_) ->
    S = #charging_session{
        session_id    = <<"sess-42">>,
        imsi          = <<"001010000000099">>,
        type          = online,
        state         = initial,
        granted_units = #{1 => 1000000, 2 => 500000},
        used_units    = #{1 => 0, 2 => 0},
        created_at    = 1718400000000,
        updated_at    = 1718400000001
    },
    Doc = chf_db_mongo_codec:from_session(S),
    ?assertEqual(<<"sess-42">>, maps:get(<<"_id">>, Doc)),
    ?assertEqual(S, chf_db_mongo_codec:to_session(Doc)).

status_type_atoms(_) ->
    %% status atoms <-> binary mapping (spot-check the encoded value directly)
    ActiveDoc = chf_db_mongo_codec:from_subscriber(
        #subscriber{imsi = <<"i">>, msisdn = <<"m">>, account_id = <<"a">>,
                    status = active, rating_groups = #{}, created_at = 0, updated_at = 0}),
    ?assertEqual(<<"active">>, maps:get(<<"status">>, ActiveDoc)),
    %% Test all statuses via round-trip on subscribers
    lists:foreach(fun(Status) ->
        Sub = #subscriber{imsi = <<"i">>, msisdn = <<"m">>, account_id = <<"a">>,
                          status = Status, rating_groups = #{},
                          created_at = 0, updated_at = 0},
        ?assertEqual(Sub, chf_db_mongo_codec:to_subscriber(
            chf_db_mongo_codec:from_subscriber(Sub)))
    end, [active, suspended, terminated]),
    %% Test all types via round-trip on CDRs
    lists:foreach(fun(Type) ->
        Cdr = #cdr{id = <<"x">>, session_id = <<"s">>, imsi = <<"i">>,
                   type = Type, rating_group = 0,
                   used_units = #{input => 0, output => 0, total => 0},
                   timestamp = 0, metadata = #{}},
        ?assertEqual(Cdr, chf_db_mongo_codec:to_cdr(
            chf_db_mongo_codec:from_cdr(Cdr)))
    end, [online, offline, converged]),
    %% Test all session states via round-trip
    lists:foreach(fun(State) ->
        Sess = #charging_session{session_id = <<"s">>, imsi = <<"i">>,
                                 type = online, state = State,
                                 granted_units = #{}, used_units = #{},
                                 created_at = 0, updated_at = 0},
        ?assertEqual(Sess, chf_db_mongo_codec:to_session(
            chf_db_mongo_codec:from_session(Sess)))
    end, [initial, active, terminated]).
