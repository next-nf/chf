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

-module(chf_session).
-moduledoc "Accessor module for the `charging_session` aggregate.\n"
           "\n"
           "**Descriptive-only**: the session document is metadata about an in-flight\n"
           "charging session (which subscriber/account/rating-group, its lifecycle\n"
           "state, and the last-reported usage). It carries NO money — all money\n"
           "invariants live on the `balance` aggregate (`chf_balance`). The\n"
           "authoritative reservation is `reservations[SessionId]` on the balance doc.\n"
           "\n"
           "Aggregate fields (current schema_version = 1):\n"
           "- `<<\"session_id\">>` — session key (binary); passed separately to chf_db ops\n"
           "- `<<\"imsi\">>` — subscriber IMSI (binary, default `<<>>`)\n"
           "- `<<\"account_id\">>` — billing-account key (binary, default `<<>>`)\n"
           "- `<<\"rating_group\">>` — rating group (binary, default `<<>>`)\n"
           "- `<<\"state\">>` — lifecycle state (binary, default `<<\"active\">>`)\n"
           "- `<<\"reported_used\">>` — last-reported usage (non_neg_integer, default 0)\n"
           "- `<<\"created_at\">>` — creation timestamp (non_neg_integer, default 0)\n"
           "- `<<\"updated_at\">>` — last-update timestamp (non_neg_integer, default 0)\n"
           "- `<<\"schema_version\">>` — document schema version (pos_integer, always 1)".

-export([from_doc/1, to_doc/1]).

-define(SCHEMA_VERSION, 1).

-define(F_SCHEMA_VERSION, <<"schema_version">>).
-define(F_IMSI,           <<"imsi">>).
-define(F_ACCOUNT_ID,     <<"account_id">>).
-define(F_RATING_GROUP,   <<"rating_group">>).
-define(F_STATE,          <<"state">>).
-define(F_REPORTED_USED,  <<"reported_used">>).
-define(F_CREATED_AT,     <<"created_at">>).
-define(F_UPDATED_AT,     <<"updated_at">>).

-type doc()         :: #{binary() => term()}.
-type session_map() :: #{binary() => term()}.

-export_type([doc/0, session_map/0]).

%%------------------------------------------------------------------------------
%% Public API
%%------------------------------------------------------------------------------

-doc "Convert a stored document to a typed session map with defaults (upgrade-on-read).".
-spec from_doc(doc()) -> session_map().
from_doc(Doc0) ->
    Doc = upgrade(Doc0),
    Defaults = #{?F_SCHEMA_VERSION => ?SCHEMA_VERSION,
                 ?F_IMSI           => <<>>,
                 ?F_ACCOUNT_ID     => <<>>,
                 ?F_RATING_GROUP   => <<>>,
                 ?F_STATE          => <<"active">>,
                 ?F_REPORTED_USED  => 0,
                 ?F_CREATED_AT     => 0,
                 ?F_UPDATED_AT     => 0},
    maps:merge(Defaults, Doc).

-doc "Convert a typed session map to a stored document, stamping `schema_version => 1`.".
-spec to_doc(session_map()) -> doc().
to_doc(Map) ->
    Map#{?F_SCHEMA_VERSION => ?SCHEMA_VERSION}.

%%------------------------------------------------------------------------------
%% Internal helpers
%%------------------------------------------------------------------------------

-spec upgrade(doc()) -> doc().
upgrade(#{?F_SCHEMA_VERSION := ?SCHEMA_VERSION} = Doc) ->
    Doc;
upgrade(Doc) ->
    Doc#{?F_SCHEMA_VERSION => ?SCHEMA_VERSION}.
