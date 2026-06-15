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

-module(chf_web_metrics_h).
-export([init/2]).

init(Req0, State) ->
    Body = otel_metric_reader:collect(otel_prometheus_reader,
               fun(Metrics, Resource) ->
                   iolist_to_binary(
                       otel_metric_serializer_prometheus:serialize(Metrics, Resource, #{}))
               end),
    Req = cowboy_req:reply(200,
            #{<<"content-type">> => <<"text/plain; version=0.0.4">>},
            Body, Req0),
    {ok, Req, State}.
