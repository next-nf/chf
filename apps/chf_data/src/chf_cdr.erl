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

-module(chf_cdr).
-moduledoc "Accessor module for the `cdr` (Charging Data Record) aggregate.\n"
           "\n"
           "A CDR is the durable record of a committed charge. `used` is in micro-units\n"
           "(integer money); never floats.\n"
           "\n"
           "Aggregate fields (current schema_version = 1):\n"
           "- `<<\"cdr_id\">>` — CDR key (binary); passed separately to chf_db ops\n"
           "- `<<\"session_id\">>` — originating session (binary, default `<<>>`)\n"
           "- `<<\"imsi\">>` — subscriber IMSI (binary, default `<<>>`)\n"
           "- `<<\"rating_group\">>` — rating group (binary, default `<<>>`)\n"
           "- `<<\"used\">>` — usage charged, micro-units (non_neg_integer, default 0)\n"
           "- `<<\"ts\">>` — commit timestamp, ms (non_neg_integer, default 0)\n"
           "- `<<\"metadata\">>` — free-form metadata (map, default `#{}`)\n"
           "- `<<\"schema_version\">>` — document schema version (pos_integer, always 1)".

-export([from_doc/1, to_doc/1]).

-define(SCHEMA_VERSION, 1).

-define(F_SCHEMA_VERSION, <<"schema_version">>).
-define(F_SESSION_ID,     <<"session_id">>).
-define(F_IMSI,           <<"imsi">>).
-define(F_RATING_GROUP,   <<"rating_group">>).
-define(F_USED,           <<"used">>).
-define(F_TS,             <<"ts">>).
-define(F_METADATA,       <<"metadata">>).

-type doc()     :: #{binary() => term()}.
-type cdr_map() :: #{binary() => term()}.

-export_type([doc/0, cdr_map/0]).

%%------------------------------------------------------------------------------
%% Public API
%%------------------------------------------------------------------------------

-doc "Convert a stored document to a typed CDR map with defaults (upgrade-on-read).".
-spec from_doc(doc()) -> cdr_map().
from_doc(Doc0) ->
    Doc = upgrade(Doc0),
    Defaults = #{?F_SCHEMA_VERSION => ?SCHEMA_VERSION,
                 ?F_SESSION_ID     => <<>>,
                 ?F_IMSI           => <<>>,
                 ?F_RATING_GROUP   => <<>>,
                 ?F_USED           => 0,
                 ?F_TS             => 0,
                 ?F_METADATA       => #{}},
    maps:merge(Defaults, Doc).

-doc "Convert a typed CDR map to a stored document, stamping `schema_version => 1`.".
-spec to_doc(cdr_map()) -> doc().
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
