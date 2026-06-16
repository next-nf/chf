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

%% chf_diameter_srv_SUITE.erl — Diameter service configuration guards.
%%
%% Asserts, via diameter:service_info/2, that the running service registers the
%% RFC 6733 base as the common application (App-Id 0) and that the Ro/Rf
%% applications are configured with {request_errors, answer}. These are the
%% org-wide conventions (nf-architecture diameter.md §1–2): use the RFC 6733
%% base so the stack may emit 5xxx answers, and let the stack answer
%% decode/protocol errors itself rather than passing them to handle_request/3.
-module(chf_diameter_srv_SUITE).

-compile(export_all).

-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").

-define(SERVER_SVC, 'next-chf').
-define(PORT, 13869).

all() ->
    [common_app_is_rfc6733_at_appid0,
     ro_and_rf_use_request_errors_answer,
     origin_host_is_node_unique].

init_per_suite(Config) ->
    {ok, _} = application:ensure_all_started(diameter),
    Config.

end_per_suite(_Config) ->
    application:stop(diameter),
    ok.

init_per_testcase(_TC, Config) ->
    application:set_env(chf_diameter, listen, [{tcp, {127,0,0,1}, ?PORT}]),
    {ok, SrvPid} = chf_diameter_srv:start_link(),
    [{srv_pid, SrvPid} | Config].

end_per_testcase(_TC, Config) ->
    SrvPid = ?config(srv_pid, Config),
    stop_quietly(fun() -> gen_server:stop(SrvPid) end),
    stop_quietly(fun() -> diameter:stop_service(?SERVER_SVC) end),
    ok.

stop_quietly(Fun) ->
    try Fun() of _ -> ok
    catch _:_ -> ok
    end.

%% The common application must be the RFC 6733 base at Application-Id 0.
common_app_is_rfc6733_at_appid0(_Config) ->
    Apps   = diameter:service_info(?SERVER_SVC, applications),
    Common = find_app(common, Apps),
    ?assertEqual(diameter_gen_base_rfc6733,
                 proplists:get_value(dictionary, Common)),
    ?assertEqual(0, proplists:get_value(id, Common)).

%% Both charging applications must run with {request_errors, answer}.
ro_and_rf_use_request_errors_answer(_Config) ->
    Apps = diameter:service_info(?SERVER_SVC, applications),
    lists:foreach(fun(Alias) ->
        App  = find_app(Alias, Apps),
        Opts = proplists:get_value(options, App, []),
        ?assertEqual(answer, proplists:get_value(request_errors, Opts))
    end, [ro, rf]).

%% effective_origin_host/0 must embed the node's short name so every cluster
%% node presents a unique DiameterIdentity to peers.
origin_host_is_node_unique(_) ->
    application:set_env(chf_diameter, origin_host, "chf.epc.example.org"),
    H = chf_diameter_srv:effective_origin_host(),
    [Short | _] = string:split(atom_to_list(node()), "@"),
    ?assert(string:find(H, Short) =/= nomatch).

%%--- helpers ---------------------------------------------------------

find_app(Alias, Apps) ->
    case [A || A <- Apps, proplists:get_value(alias, A) =:= Alias] of
        [App | _] -> App;
        []        -> ct:fail({app_not_registered, Alias})
    end.
