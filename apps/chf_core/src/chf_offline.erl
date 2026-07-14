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

%% chf_offline.erl — Offline charging logic (CDR generation).
%%
%% Phase 1 (data-layer cutover): CDRs are NO LONGER written inline here. The
%% authoritative money path stamps `pending_cdrs` onto the balance document at
%% commit time (chf_data:balance_commit/5), and the Task 5 drainer materialises
%% durable CDRs from those stubs. The descriptive charging_session (written by
%% chf_core) carries the reporting-only usage.
%%
%% For a PURE offline session (no online grant/commit, hence no balance mutation
%% and no pending_cdr stub) there is nothing to charge; usage is captured on the
%% descriptive session and the offline-CDR reconstruction is a Task 5 concern.
%% These entry points are therefore Phase-1 no-ops that keep the chf_core
%% dispatch shape stable; they will be re-fleshed when the offline CDR pipeline
%% lands. They deliberately take only descriptive inputs (no Ctx, no records).
-module(chf_offline).

-export([initial_request/2, update_request/2, terminate_request/2]).

%%====================================================================
%% API — Phase 1 no-ops (see moduledoc)
%%====================================================================

%% @doc Session-open marker for an offline/converged session. No inline CDR.
-spec initial_request(Imsi :: binary(), SessionId :: binary()) -> ok.
initial_request(_Imsi, _SessionId) ->
    ok.

%% @doc Interim usage marker. No inline CDR (commit stamps pending_cdrs).
%%
%% Data :: #{session_id => binary(),
%%           rating_groups => [#{rating_group => non_neg_integer(),
%%                               used_units => integer()}]}
-spec update_request(Imsi :: binary(), Data :: map()) -> ok.
update_request(_Imsi, _Data) ->
    ok.

%% @doc Final usage marker at session stop. No inline CDR.
-spec terminate_request(Imsi :: binary(), Data :: map()) -> ok.
terminate_request(_Imsi, _Data) ->
    ok.
