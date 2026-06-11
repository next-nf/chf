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

%% chf_sbi_json_SUITE.erl — Codec regression tests: JSON decodes to binary keys.
-module(chf_sbi_json_SUITE).

-include_lib("common_test/include/ct.hrl").
-include_lib("stdlib/include/assert.hrl").

-export([all/0]).
-export([decode_object_keys_are_binary/1,
         decode_atom_colliding_key_stays_binary/1,
         decode_nested_keys_are_binary/1,
         encode_decode_roundtrip/1]).

all() ->
    [decode_object_keys_are_binary,
     decode_atom_colliding_key_stays_binary,
     decode_nested_keys_are_binary,
     encode_decode_roundtrip].

decode_object_keys_are_binary(_Config) ->
    Decoded = chf_sbi_json:decode(<<"{\"ratingGroup\":5,\"totalVolume\":100}">>),
    ?assertEqual(#{<<"ratingGroup">> => 5, <<"totalVolume">> => 100}, Decoded).

%% The crux regression: keys that DO match an existing atom ("error", "status"
%% exist in every running VM) must still decode to binaries, never atoms, so a
%% map can never end up with mixed atom/binary keys.
decode_atom_colliding_key_stays_binary(_Config) ->
    Decoded = chf_sbi_json:decode(<<"{\"error\":1,\"status\":2}">>),
    ?assert(is_map(Decoded)),
    ?assert(lists:all(fun is_binary/1, maps:keys(Decoded))),
    ?assertEqual(#{<<"error">> => 1, <<"status">> => 2}, Decoded).

decode_nested_keys_are_binary(_Config) ->
    Decoded = chf_sbi_json:decode(
        <<"{\"subscriberIdentifier\":{\"sUPI\":\"imsi-001\"}}">>),
    ?assertEqual(#{<<"subscriberIdentifier">> =>
                      #{<<"sUPI">> => <<"imsi-001">>}}, Decoded).

encode_decode_roundtrip(_Config) ->
    Term = #{<<"a">> => 1, <<"b">> => [#{<<"c">> => 2}]},
    ?assertEqual(Term, chf_sbi_json:decode(chf_sbi_json:encode(Term))).
