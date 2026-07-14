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

-module(chf_subscriber).
-moduledoc "Accessor module for the `subscriber` aggregate.\n"
           "\n"
           "Owns the document shape (`from_doc/1`, `to_doc/1`), binary field-name\n"
           "literals, defaults for optional fields, and upgrade-on-read for older\n"
           "`schema_version` values.\n"
           "\n"
           "Aggregate fields (current schema_version = 1):\n"
           "- `<<\"imsi\">>` — subscriber key (binary); passed separately to chf_db ops\n"
           "- `<<\"msisdn\">>` — MSISDN (binary, default `<<>>`)\n"
           "- `<<\"account_id\">>` — billing-account key (binary, default `<<>>`)\n"
           "- `<<\"status\">>` — subscription status (binary, default `<<\"active\">>`)\n"
           "- `<<\"rating_groups\">>` — per-RG config (map, default `#{}`)\n"
           "- `<<\"created_at\">>` — creation timestamp (non_neg_integer, default 0)\n"
           "- `<<\"updated_at\">>` — last-update timestamp (non_neg_integer, default 0)\n"
           "- `<<\"schema_version\">>` — document schema version (pos_integer, always 1)".

-export([from_doc/1, to_doc/1]).

-define(SCHEMA_VERSION, 1).

%% Binary field-name literals — all field names centralised here.
-define(F_SCHEMA_VERSION, <<"schema_version">>).
-define(F_MSISDN,         <<"msisdn">>).
-define(F_ACCOUNT_ID,     <<"account_id">>).
-define(F_STATUS,         <<"status">>).
-define(F_RATING_GROUPS,  <<"rating_groups">>).
-define(F_CREATED_AT,     <<"created_at">>).
-define(F_UPDATED_AT,     <<"updated_at">>).

-type doc()            :: #{binary() => term()}.
-type subscriber_map() :: #{binary() => term()}.

-export_type([doc/0, subscriber_map/0]).

%%------------------------------------------------------------------------------
%% Public API
%%------------------------------------------------------------------------------

-doc "Convert a stored document to a typed subscriber map with defaults.\n"
     "Older (or absent) `schema_version` values are upgraded in-memory; the next\n"
     "write persists the new shape. Present fields — known or unknown — are\n"
     "preserved; only absent known fields fall back to their default.".
-spec from_doc(doc()) -> subscriber_map().
from_doc(Doc0) ->
    Doc = upgrade(Doc0),
    Defaults = #{?F_SCHEMA_VERSION => ?SCHEMA_VERSION,
                 ?F_MSISDN         => <<>>,
                 ?F_ACCOUNT_ID     => <<>>,
                 ?F_STATUS         => <<"active">>,
                 ?F_RATING_GROUPS  => #{},
                 ?F_CREATED_AT     => 0,
                 ?F_UPDATED_AT     => 0},
    maps:merge(Defaults, Doc).

-doc "Convert a typed subscriber map to a stored document, stamping `schema_version => 1`.".
-spec to_doc(subscriber_map()) -> doc().
to_doc(Map) ->
    Map#{?F_SCHEMA_VERSION => ?SCHEMA_VERSION}.

%%------------------------------------------------------------------------------
%% Internal helpers
%%------------------------------------------------------------------------------

%% upgrade/1 — upgrade-on-read for older or absent schema_version values.
%% Current version is 1; add migration clauses here when the schema advances.
-spec upgrade(doc()) -> doc().
upgrade(#{?F_SCHEMA_VERSION := ?SCHEMA_VERSION} = Doc) ->
    Doc;
upgrade(Doc) ->
    Doc#{?F_SCHEMA_VERSION => ?SCHEMA_VERSION}.
