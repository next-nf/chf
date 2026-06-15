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

-module(chf_otel_app).
-moduledoc "`application` behaviour for `chf_otel`: sets up metric instruments on start.".

-behaviour(application).

-include_lib("kernel/include/logger.hrl").

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    ok = chf_otel:setup_metrics(),
    %% Best-effort one-time setup of the library instruments. These must never
    %% fail the node's boot (the metrics subsystem is not load-bearing), but a
    %% swallowed failure means silent metric loss — so log it rather than
    %% discard it blindly. (chf_otel:setup_metrics/0 above is our own code and is
    %% intentionally NOT guarded: it should always succeed, and a failure there
    %% is a real bug worth crashing on.)
    %% HTTP server metrics are opt-in (spans are automatic via the stream handler).
    safe_setup("cowboy HTTP metrics", fun opentelemetry_cowboy_experimental_h:init/0),
    safe_setup("BEAM/VM metrics",     fun opentelemetry_beam_metrics:setup/0),
    safe_setup("diameter metrics",    fun opentelemetry_diameter_metrics:setup/0),
    chf_otel_sup:start_link().

stop(_State) ->
    chf_otel:clear_metrics().

%% Run a library setup call, logging (not raising) on failure so silent metric
%% loss is observable in the logs.
safe_setup(What, Fun) ->
    try Fun() of
        _ -> ok
    catch
        Class:Reason:Stack ->
            ?LOG_WARNING("chf_otel: ~s setup failed (~p:~p); metrics for this "
                         "subsystem will be absent. ~p", [What, Class, Reason, Stack]),
            ok
    end.
