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

%% chf_db_mongo_codec.erl — Pure record <-> BSON-map conversion for the
%% MongoDB backend.  No Mongo connection is required; all functions are
%% stateless data transforms.
%%
%% Encoding rules:
%%   • The record's KEY field maps to BSON <<"_id">> on encode;
%%     <<"_id">> maps back to the key field on decode.
%%   • Balance amounts and timestamps stay Erlang integers.  The mongoc
%%     driver encodes integers > 2^31-1 as BSON int64 automatically.
%%   • Rating-group integer map keys are stringified (integer_to_binary /
%%     binary_to_integer) in subscriber.rating_groups, session.granted_units,
%%     and session.used_units.  BSON map keys must be strings.
%%   • Status / type / state atoms are mapped via closed helper functions —
%%     binary_to_atom is never called on inbound data.
%%   • cdr.used_units atom keys (input/output/total) ↔ binaries.
%%   • cdr.metadata is kept as-is (already binary-keyed from JSON decode).
%%     Atom keys, if present, are stringified with atom_to_binary/1 in a
%%     single shallow pass.
%%   • All conversions are single-pass (no repeated traversals).
-module(chf_db_mongo_codec).

-include_lib("chf_db/include/chf_db.hrl").

-export([
    from_subscriber/1,
    to_subscriber/1,
    from_balance/1,
    to_balance/1,
    from_cdr/1,
    to_cdr/1,
    from_session/1,
    to_session/1
]).

%%====================================================================
%% Subscriber
%%====================================================================

-spec from_subscriber(#subscriber{}) -> map().
from_subscriber(#subscriber{imsi          = Imsi,
                             msisdn        = Msisdn,
                             account_id    = AccountId,
                             status        = Status,
                             rating_groups = RatingGroups,
                             created_at    = CreatedAt,
                             updated_at    = UpdatedAt}) ->
    #{<<"_id">>          => Imsi,
      <<"msisdn">>       => Msisdn,
      <<"account_id">>   => AccountId,
      <<"status">>       => status_to_bin(Status),
      <<"rating_groups">> => rg_config_map_to_doc(RatingGroups),
      <<"created_at">>   => CreatedAt,
      <<"updated_at">>   => UpdatedAt}.

-spec to_subscriber(map()) -> #subscriber{}.
to_subscriber(#{<<"_id">>           := Imsi,
                <<"msisdn">>        := Msisdn,
                <<"account_id">>    := AccountId,
                <<"status">>        := StatusBin,
                <<"rating_groups">> := RgDoc,
                <<"created_at">>    := CreatedAt,
                <<"updated_at">>    := UpdatedAt}) ->
    #subscriber{imsi          = Imsi,
                msisdn        = Msisdn,
                account_id    = AccountId,
                status        = bin_to_status(StatusBin),
                rating_groups = doc_to_rg_config_map(RgDoc),
                created_at    = CreatedAt,
                updated_at    = UpdatedAt}.

%%====================================================================
%% Balance
%%====================================================================

-spec from_balance(#balance{}) -> map().
from_balance(#balance{account_id = AccountId,
                      total      = Total,
                      reserved   = Reserved,
                      available  = Available}) ->
    #{<<"_id">>       => AccountId,
      <<"total">>     => Total,
      <<"reserved">>  => Reserved,
      <<"available">> => Available}.

-spec to_balance(map()) -> #balance{}.
to_balance(#{<<"_id">>       := AccountId,
             <<"total">>     := Total,
             <<"reserved">>  := Reserved,
             <<"available">> := Available}) ->
    #balance{account_id = AccountId,
             total      = Total,
             reserved   = Reserved,
             available  = Available}.

%%====================================================================
%% CDR
%%====================================================================

-spec from_cdr(#cdr{}) -> map().
from_cdr(#cdr{id           = Id,
              session_id   = SessionId,
              imsi         = Imsi,
              type         = Type,
              rating_group = RatingGroup,
              used_units   = UsedUnits,
              timestamp    = Timestamp,
              metadata     = Metadata}) ->
    #{<<"_id">>          => Id,
      <<"session_id">>   => SessionId,
      <<"imsi">>         => Imsi,
      <<"type">>         => type_to_bin(Type),
      <<"rating_group">> => RatingGroup,
      <<"used_units">>   => used_units_to_doc(UsedUnits),
      <<"timestamp">>    => Timestamp,
      <<"metadata">>     => metadata_to_doc(Metadata)}.

-spec to_cdr(map()) -> #cdr{}.
to_cdr(#{<<"_id">>          := Id,
         <<"session_id">>   := SessionId,
         <<"imsi">>         := Imsi,
         <<"type">>         := TypeBin,
         <<"rating_group">> := RatingGroup,
         <<"used_units">>   := UsedUnitsDoc,
         <<"timestamp">>    := Timestamp,
         <<"metadata">>     := Metadata}) ->
    #cdr{id           = Id,
         session_id   = SessionId,
         imsi         = Imsi,
         type         = bin_to_type(TypeBin),
         rating_group = RatingGroup,
         used_units   = doc_to_used_units(UsedUnitsDoc),
         timestamp    = Timestamp,
         metadata     = Metadata}.

%%====================================================================
%% Charging session
%%====================================================================

-spec from_session(#charging_session{}) -> map().
from_session(#charging_session{session_id    = SessionId,
                               imsi          = Imsi,
                               type          = Type,
                               state         = State,
                               granted_units = GrantedUnits,
                               used_units    = UsedUnits,
                               created_at    = CreatedAt,
                               updated_at    = UpdatedAt}) ->
    #{<<"_id">>           => SessionId,
      <<"imsi">>          => Imsi,
      <<"type">>          => type_to_bin(Type),
      <<"state">>         => state_to_bin(State),
      <<"granted_units">> => rg_int_map_to_doc(GrantedUnits),
      <<"used_units">>    => rg_int_map_to_doc(UsedUnits),
      <<"created_at">>    => CreatedAt,
      <<"updated_at">>    => UpdatedAt}.

-spec to_session(map()) -> #charging_session{}.
to_session(#{<<"_id">>           := SessionId,
             <<"imsi">>          := Imsi,
             <<"type">>          := TypeBin,
             <<"state">>         := StateBin,
             <<"granted_units">> := GrantedUnitsDoc,
             <<"used_units">>    := UsedUnitsDoc,
             <<"created_at">>    := CreatedAt,
             <<"updated_at">>    := UpdatedAt}) ->
    #charging_session{session_id    = SessionId,
                      imsi          = Imsi,
                      type          = bin_to_type(TypeBin),
                      state         = bin_to_state(StateBin),
                      granted_units = doc_to_rg_int_map(GrantedUnitsDoc),
                      used_units    = doc_to_rg_int_map(UsedUnitsDoc),
                      created_at    = CreatedAt,
                      updated_at    = UpdatedAt}.

%%====================================================================
%% Internal helpers — atom <-> binary (closed mappings)
%%====================================================================

-spec status_to_bin(active | suspended | terminated) -> binary().
status_to_bin(active)     -> <<"active">>;
status_to_bin(suspended)  -> <<"suspended">>;
status_to_bin(terminated) -> <<"terminated">>.

-spec bin_to_status(binary()) -> active | suspended | terminated.
bin_to_status(<<"active">>)     -> active;
bin_to_status(<<"suspended">>)  -> suspended;
bin_to_status(<<"terminated">>) -> terminated.

-spec type_to_bin(online | offline | converged) -> binary().
type_to_bin(online)    -> <<"online">>;
type_to_bin(offline)   -> <<"offline">>;
type_to_bin(converged) -> <<"converged">>.

-spec bin_to_type(binary()) -> online | offline | converged.
bin_to_type(<<"online">>)    -> online;
bin_to_type(<<"offline">>)   -> offline;
bin_to_type(<<"converged">>) -> converged.

-spec state_to_bin(initial | active | terminated) -> binary().
state_to_bin(initial)    -> <<"initial">>;
state_to_bin(active)     -> <<"active">>;
state_to_bin(terminated) -> <<"terminated">>.

-spec bin_to_state(binary()) -> initial | active | terminated.
bin_to_state(<<"initial">>)    -> initial;
bin_to_state(<<"active">>)     -> active;
bin_to_state(<<"terminated">>) -> terminated.

%%====================================================================
%% Internal helpers — rating-group integer key maps
%%====================================================================

%% rg_int_map_to_doc/1 — #{non_neg_integer() => integer()} ->
%%                        #{binary() => integer()}
%% Used for session.granted_units and session.used_units.
-spec rg_int_map_to_doc(#{non_neg_integer() => integer()}) ->
    #{binary() => integer()}.
rg_int_map_to_doc(Map) ->
    maps:fold(fun(K, V, Acc) ->
        Acc#{integer_to_binary(K) => V}
    end, #{}, Map).

%% doc_to_rg_int_map/1 — inverse of rg_int_map_to_doc/1.
-spec doc_to_rg_int_map(#{binary() => integer()}) ->
    #{non_neg_integer() => integer()}.
doc_to_rg_int_map(Doc) ->
    maps:fold(fun(K, V, Acc) ->
        Acc#{binary_to_integer(K) => V}
    end, #{}, Doc).

%% rg_config_map_to_doc/1 — #{non_neg_integer() => rating_group_config()} ->
%%                           #{binary() => map()}
%% Used for subscriber.rating_groups.
-spec rg_config_map_to_doc(#{non_neg_integer() => rating_group_config()}) ->
    #{binary() => map()}.
rg_config_map_to_doc(Map) ->
    maps:fold(fun(K, V, Acc) ->
        Acc#{integer_to_binary(K) => rg_config_to_doc(V)}
    end, #{}, Map).

%% doc_to_rg_config_map/1 — inverse of rg_config_map_to_doc/1.
-spec doc_to_rg_config_map(#{binary() => map()}) ->
    #{non_neg_integer() => rating_group_config()}.
doc_to_rg_config_map(Doc) ->
    maps:fold(fun(K, V, Acc) ->
        Acc#{binary_to_integer(K) => doc_to_rg_config(V)}
    end, #{}, Doc).

%% rg_config_to_doc/1 — #{quota => integer(), priority => integer()} ->
%%                       #{<<"quota">> => integer(), <<"priority">> => integer()}
-spec rg_config_to_doc(rating_group_config()) -> #{binary() => integer()}.
rg_config_to_doc(Config) ->
    maps:fold(fun(quota,    V, Acc) -> Acc#{<<"quota">>    => V};
                 (priority, V, Acc) -> Acc#{<<"priority">> => V}
              end, #{}, Config).

%% doc_to_rg_config/1 — inverse of rg_config_to_doc/1.
-spec doc_to_rg_config(#{binary() => integer()}) -> rating_group_config().
doc_to_rg_config(Doc) ->
    maps:fold(fun(<<"quota">>,    V, Acc) -> Acc#{quota    => V};
                 (<<"priority">>, V, Acc) -> Acc#{priority => V}
              end, #{}, Doc).

%%====================================================================
%% Internal helpers — CDR used_units
%%====================================================================

%% used_units_to_doc/1 — #{input => integer(), ...} ->
%%                        #{<<"input">> => integer(), ...}
-spec used_units_to_doc(#{input => integer(), output => integer(),
                           total => integer()}) ->
    #{binary() => integer()}.
used_units_to_doc(Map) ->
    maps:fold(fun(input,  V, Acc) -> Acc#{<<"input">>  => V};
                 (output, V, Acc) -> Acc#{<<"output">> => V};
                 (total,  V, Acc) -> Acc#{<<"total">>  => V}
              end, #{}, Map).

%% doc_to_used_units/1 — inverse of used_units_to_doc/1.
-spec doc_to_used_units(#{binary() => integer()}) ->
    #{input => integer(), output => integer(), total => integer()}.
doc_to_used_units(Doc) ->
    maps:fold(fun(<<"input">>,  V, Acc) -> Acc#{input  => V};
                 (<<"output">>, V, Acc) -> Acc#{output => V};
                 (<<"total">>,  V, Acc) -> Acc#{total  => V}
              end, #{}, Doc).

%%====================================================================
%% Internal helpers — CDR metadata
%%====================================================================

%% metadata_to_doc/1 — Shallow pass: atom keys -> binary keys.
%% Metadata is opaque and already binary-keyed when it arrives from JSON
%% decode.  If atom keys are present (e.g. internal construction), stringify
%% them so the BSON driver doesn't see atoms as map keys.
-spec metadata_to_doc(map()) -> map().
metadata_to_doc(Meta) ->
    maps:fold(fun(K, V, Acc) when is_atom(K) ->
                    Acc#{atom_to_binary(K) => V};
                 (K, V, Acc) ->
                    Acc#{K => V}
              end, #{}, Meta).
