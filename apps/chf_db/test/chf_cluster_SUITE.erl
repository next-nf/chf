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

-module(chf_cluster_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

all() ->
    [configured_nodes_includes_self, connected_is_self_when_alone].

configured_nodes_includes_self(_) ->
    application:set_env(chf, cluster_nodes, [node()]),
    ?assertEqual([node()], chf_cluster:cluster_nodes()).

connected_is_self_when_alone(_) ->
    application:set_env(chf, cluster_nodes, [node()]),
    {ok, _} = chf_cluster:start_link(),
    ?assertEqual([node()], lists:sort(chf_cluster:connected_nodes())),
    gen_server:stop(chf_cluster).
