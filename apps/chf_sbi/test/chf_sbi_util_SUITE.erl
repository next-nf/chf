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

%% chf_sbi_util_SUITE.erl — Unit tests for chf_sbi_util helpers.
-module(chf_sbi_util_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

all() -> [ref_is_node_tagged_and_unique].

ref_is_node_tagged_and_unique(_) ->
    R = chf_sbi_util:generate_ref(),
    NodeBin = atom_to_binary(node(), utf8),
    ?assertMatch({0, _}, binary:match(R, NodeBin)),
    ?assertNotEqual(R, chf_sbi_util:generate_ref()).
