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

%% chf_api_json.erl — JSON encode/decode helpers for the provisioning API.
%%
%% Uses Erlang/OTP 27+ built-in `json` module.
-module(chf_api_json).

-export([decode/1, encode/1]).
-export([encode_subscriber/1, encode_balance/1]).

%%====================================================================
%% Decode
%%====================================================================

%% @doc Decode a JSON binary to an Erlang term with binary object keys.
%%
%% Keys are never atomised: provisioning payloads and 3GPP map structures may
%% carry arbitrary identifiers, and atomising them risks mixed atom/binary key
%% maps and atom-table growth. The native json:decode/1 builds the map in a
%% single pass. Internal vocabularies (e.g. rating-group quota/priority) are
%% converted explicitly and in one pass below.
-spec decode(binary()) -> term().
decode(Bin) ->
    json:decode(Bin).

%%====================================================================
%% Encode
%%====================================================================

%% @doc Encode an Erlang term to a JSON binary.
-spec encode(term()) -> binary().
encode(Term) ->
    iolist_to_binary(json:encode(Term)).

%%====================================================================
%% Domain-map → JSON helpers
%%====================================================================

%% @doc Encode a subscriber map (binary keys) to a JSON binary.
-spec encode_subscriber(map()) -> binary().
encode_subscriber(Sub) ->
    Map = #{
        <<"imsi">>          => maps:get(<<"imsi">>, Sub, <<>>),
        <<"msisdn">>        => maps:get(<<"msisdn">>, Sub, <<>>),
        <<"account_id">>    => maps:get(<<"account_id">>, Sub, <<>>),
        <<"status">>        => maps:get(<<"status">>, Sub, <<"active">>),
        <<"rating_groups">> => encode_rating_groups(maps:get(<<"rating_groups">>, Sub, #{})),
        <<"created_at">>    => maps:get(<<"created_at">>, Sub, 0),
        <<"updated_at">>    => maps:get(<<"updated_at">>, Sub, 0)
    },
    encode(Map).

%% @doc Encode a balance map (binary keys) to a JSON binary. `available` is the
%% derived total − Σ reservations (chf_balance:available/1); `reserved` is that
%% derived hold total, exposed for API compatibility.
-spec encode_balance(map()) -> binary().
encode_balance(Bal) ->
    Total     = maps:get(<<"total">>, Bal, 0),
    Available = chf_balance:available(Bal),
    Map = #{
        <<"account_id">> => maps:get(<<"account_id">>, Bal, <<>>),
        <<"total">>      => Total,
        <<"reserved">>   => Total - Available,
        <<"available">>  => Available
    },
    encode(Map).

%%====================================================================
%% Internal helpers
%%====================================================================

%% Convert #{integer() => rating_group_config()} to #{binary() => map()}
%% so that json:encode/1 can handle it (map keys must be binaries/atoms/integers).
%% The subscriber record's rating_groups field is always a map, so no
%% non-map fallback clause is needed (it would be unreachable).
encode_rating_groups(RatingGroups) when is_map(RatingGroups) ->
    maps:fold(fun(RgId, Config, Acc) ->
        Key = integer_to_binary(RgId),
        Acc#{Key => encode_rg_config(Config)}
    end, #{}, RatingGroups).

encode_rg_config(Config) when is_map(Config) ->
    %% Config may contain quota and/or priority — both integers.
    maps:fold(fun(K, V, Acc) ->
        BinKey = if is_atom(K) -> atom_to_binary(K, utf8);
                    is_binary(K) -> K;
                    true -> term_to_binary(K)
                 end,
        Acc#{BinKey => V}
    end, #{}, Config);
encode_rg_config(_) ->
    #{}.
