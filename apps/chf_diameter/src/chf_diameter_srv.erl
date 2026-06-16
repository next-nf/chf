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

%% chf_diameter_srv.erl — gen_server that owns the OTP diameter service.
%%
%% Reads configuration from the `chf_diameter` application environment,
%% starts the named diameter service, and attaches TCP listener transports.
%%
%% Expected application env:
%%   {origin_host,  "chf.example.net"}
%%   {origin_realm, "example.net"}
%%   {listen, [{tcp, {0,0,0,0}, 3868}]}
-module(chf_diameter_srv).
-behaviour(gen_server).

-include_lib("kernel/include/logger.hrl").

-export([start_link/0, effective_origin_host/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

-define(SERVICE, 'next-chf').

%%====================================================================
%% API
%%====================================================================

-spec start_link() -> {ok, pid()} | {error, term()}.
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%% effective_origin_host/0 — returns the Origin-Host this node advertises.
%%
%% When cluster_unique_origin_host is true (the default) the node's short name
%% is prepended to the configured base hostname so that every cluster node
%% presents a unique DiameterIdentity to peers (RFC 6733 §3.3).  Operators who
%% manage uniqueness themselves (e.g. via per-node sys.config) may set
%% cluster_unique_origin_host to false to use the bare configured value.
-spec effective_origin_host() -> string().
effective_origin_host() ->
    Base = application:get_env(chf_diameter, origin_host, "chf.local"),
    [Short | _] = string:split(atom_to_list(node()), "@"),
    case application:get_env(chf_diameter, cluster_unique_origin_host, true) of
        true  -> Short ++ "." ++ Base;   %% e.g. "chf1.chf.epc.example.org"
        false -> Base
    end.

%%====================================================================
%% gen_server callbacks
%%====================================================================

init([]) ->
    OriginHost  = effective_origin_host(),
    OriginRealm = application:get_env(chf_diameter, origin_realm, "local"),
    Listen      = application:get_env(chf_diameter, listen,
                                      [{tcp, {0,0,0,0}, 3868}]),

    ?LOG_INFO("Starting DIAMETER service ~p  host=~s realm=~s",
              [?SERVICE, OriginHost, OriginRealm]),

    SvcOpts = [
        {'Origin-Host',    OriginHost},
        {'Origin-Realm',   OriginRealm},
        {'Vendor-Id',      diameter_3gpp_ts32_299_ro:vendor_id()},   %% 10415 (3GPP)
        {'Product-Name',   "Next-CHF"},
        %% Application-Ids come from the generated dictionaries rather than literals.
        {'Auth-Application-Id', [diameter_3gpp_ts32_299_ro:id()]},   %% Ro / Gy (4)
        {'Acct-Application-Id', [diameter_3gpp_ts32_299_rf:id()]},   %% Rf (3)
        {restrict_connections, false},
        {string_decode, false},
        %% RFC 6733 base as the common application (App-Id 0): use the RFC 6733
        %% base rather than OTP's RFC 3588 default so the stack may emit 5xxx
        %% answers (nf-architecture diameter.md §1).
        {application, [{alias,      common},
                       {dictionary, diameter_gen_base_rfc6733},
                       {module,     chf_diameter_base}]},
        %% request_errors=answer: the stack answers decode/protocol errors
        %% itself, so handle_request/3 only ever sees cleanly decoded requests
        %% (nf-architecture diameter.md §2).
        {application, [{alias,         ro},
                       {dictionary,    diameter_3gpp_ts32_299_ro},
                       {module,        chf_diameter_gy},
                       {request_errors, answer}]},
        {application, [{alias,         rf},
                       {dictionary,    diameter_3gpp_ts32_299_rf},
                       {module,        chf_diameter_rf},
                       {request_errors, answer}]}
    ],

    ok = diameter:start_service(?SERVICE, SvcOpts),
    ?LOG_INFO("DIAMETER service ~p started", [?SERVICE]),

    ok = add_listeners(Listen),

    {ok, #{service => ?SERVICE,
           listen  => Listen}}.

handle_call(_Req, _From, State) ->
    {reply, {error, unknown_call}, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ?LOG_INFO("Stopping DIAMETER service ~p", [?SERVICE]),
    _ = diameter:stop_service(?SERVICE),
    ok.

%%====================================================================
%% Internal helpers
%%====================================================================

add_listeners(Listen) ->
    lists:foreach(fun add_one_listener/1, Listen).

add_one_listener({tcp, IP, Port}) ->
    TransportOpts = [
        {transport_module, diameter_tcp},
        {transport_config, [
            {reuseaddr, true},
            {ip,        IP},
            {port,      Port}
        ]}
    ],
    case diameter:add_transport(?SERVICE, {listen, TransportOpts}) of
        {ok, _Ref} ->
            ?LOG_INFO("DIAMETER listener added: ~p:~w", [IP, Port]);
        {error, Reason} ->
            ?LOG_ERROR("DIAMETER add_transport failed ~p:~w reason=~p",
                       [IP, Port, Reason]),
            error({add_transport_failed, IP, Port, Reason})
    end;
add_one_listener(Other) ->
    ?LOG_WARNING("DIAMETER: ignoring unknown listener spec: ~p", [Other]).
