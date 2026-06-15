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

-module(chf_web_app).
-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Port = application:get_env(chf_web, port, 8081),
    Ip   = application:get_env(chf_web, ip, {127,0,0,1}),

    Dispatch = cowboy_router:compile([
        {'_', [
            %% Static files
            {"/",             cowboy_static, {priv_file, chf_web, "static/index.html"}},
            {"/static/[...]", cowboy_static, {priv_dir,  chf_web, "static"}},

            %% API endpoints for the dashboard
            {"/api/dashboard",                  chf_web_dashboard_h,   []},
            {"/api/sessions",                   chf_web_sessions_h,    []},
            {"/api/sessions/:session_id",        chf_web_sessions_h,    []},
            {"/api/cdrs",                        chf_web_cdr_h,         []},
            {"/api/subscribers",                 chf_web_subscriber_h,  []},
            {"/api/subscribers/:imsi",           chf_web_subscriber_h,  []},

            %% OTEL-sourced Prometheus metrics (pull reader -> text exposition)
            {"/metrics", chf_web_metrics_h, []}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(chf_web_listener,
        [{port, Port}, {ip, Ip}],
        #{env => #{dispatch => Dispatch},
          otel_opts => #{metrics_cb => fun opentelemetry_cowboy_experimental_h:metrics_cb/5},
          stream_handlers => [opentelemetry_cowboy_h, cowboy_stream_h]}),
    chf_web_sup:start_link().

stop(_State) ->
    cowboy:stop_listener(chf_web_listener),
    ok.
