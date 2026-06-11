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

-include_lib("chf_db/include/chf_db.hrl").

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
%% Record → map helpers
%%====================================================================

%% @doc Encode a #subscriber{} record to a JSON binary.
-spec encode_subscriber(#subscriber{}) -> binary().
encode_subscriber(#subscriber{
        imsi          = Imsi,
        msisdn        = Msisdn,
        account_id    = AccountId,
        status        = Status,
        rating_groups = RatingGroups,
        created_at    = CreatedAt,
        updated_at    = UpdatedAt}) ->
    Map = #{
        <<"imsi">>          => Imsi,
        <<"msisdn">>        => Msisdn,
        <<"account_id">>    => AccountId,
        <<"status">>        => atom_to_binary(Status, utf8),
        <<"rating_groups">> => encode_rating_groups(RatingGroups),
        <<"created_at">>    => CreatedAt,
        <<"updated_at">>    => UpdatedAt
    },
    encode(Map).

%% @doc Encode a #balance{} record to a JSON binary.
-spec encode_balance(#balance{}) -> binary().
encode_balance(#balance{
        account_id = AccountId,
        total      = Total,
        reserved   = Reserved,
        available  = Available}) ->
    Map = #{
        <<"account_id">> => AccountId,
        <<"total">>      => Total,
        <<"reserved">>   => Reserved,
        <<"available">>  => Available
    },
    encode(Map).

%%====================================================================
%% Internal helpers
%%====================================================================

%% Convert #{integer() => rating_group_config()} to #{binary() => map()}
%% so that json:encode/1 can handle it (map keys must be binaries/atoms/integers).
encode_rating_groups(RatingGroups) when is_map(RatingGroups) ->
    maps:fold(fun(RgId, Config, Acc) ->
        Key = integer_to_binary(RgId),
        Acc#{Key => encode_rg_config(Config)}
    end, #{}, RatingGroups);
encode_rating_groups(_) ->
    #{}.

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
