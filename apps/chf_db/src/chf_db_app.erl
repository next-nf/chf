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

-module(chf_db_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    case application:get_env(chf_db, backend, chf_db_mnesia) of
        chf_db_mongo ->
            %% For the MongoDB backend the connection is owned by the
            %% chf_db_mongo_conn gen_server, which is a supervised child of
            %% chf_db_sup (added conditionally in chf_db_sup:init/1).  The
            %% gen_server calls mongoc:connect/3 and ensure_indexes in its own
            %% init/1, so there is no pre-sup init step needed here.
            chf_db_sup:start_link();
        _Mnesia ->
            %% For the Mnesia backend, init must run BEFORE the supervisor so
            %% that the schema and tables exist before chf_cluster (a sup child)
            %% starts and queries them.
            case chf_db:init() of
                ok ->
                    chf_db_sup:start_link();
                {error, Reason} ->
                    {error, {chf_db_init_failed, Reason}}
            end
    end.

stop(_State) ->
    ok.
