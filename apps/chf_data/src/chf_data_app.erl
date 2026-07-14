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
-moduledoc "Application callback for `chf_data`. Declares all collections at startup\n"
           "and blocks on the DB-readiness gate before returning, so listener apps that\n"
           "depend on `chf_data` are never started until the backend has completed its\n"
           "initialisation (`wait_for_tables` returned).".
-behaviour(application).

-export([start/2, stop/1]).

-define(AWAIT_TIMEOUT_MS, 30000).

-spec start(application:start_type(), term()) -> {ok, pid()}.
start(_StartType, _StartArgs) ->
    ok = chf_data:ensure_collections(),
    %% Readiness gate: block until the backend reports ready. For the Mnesia
    %% backend this calls mnesia:wait_for_tables/2 for all local tables. Apps
    %% that list chf_data in their .app.src `applications` will not start until
    %% this returns, so no listener can bind before the DB is ready.
    ok = chf_db:await_ready(?AWAIT_TIMEOUT_MS),
    chf_data_sup:start_link().

-spec stop(term()) -> ok.
stop(_State) ->
    ok.
