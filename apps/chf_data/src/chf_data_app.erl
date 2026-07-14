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

-module(chf_data_app).
-moduledoc "Application callback for `chf_data`.\n"
           "\n"
           "Minimal skeleton for Phase 1: starts the supervisor. The collection\n"
           "bootstrap and the DB-readiness gate (`chf_data:ensure_collections/0` +\n"
           "`chf_db:await_ready/1`) are wired here in Task 7; for now the app just\n"
           "brings up a bare supervisor so the accessors and the `chf_data` seam are\n"
           "available to callers that manage collection setup themselves.".
-behaviour(application).

-export([start/2, stop/1]).

-spec start(application:start_type(), term()) -> {ok, pid()}.
start(_StartType, _StartArgs) ->
    chf_data_sup:start_link().

-spec stop(term()) -> ok.
stop(_State) ->
    ok.
