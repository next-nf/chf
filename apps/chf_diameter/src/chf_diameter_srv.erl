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

-export([start_link/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

-define(SERVICE, 'next-chf').

%%====================================================================
%% API
%%====================================================================

-spec start_link() -> {ok, pid()} | {error, term()}.
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%%====================================================================
%% gen_server callbacks
%%====================================================================

init([]) ->
    OriginHost  = application:get_env(chf_diameter, origin_host,  "chf.local"),
    OriginRealm = application:get_env(chf_diameter, origin_realm, "local"),
    Listen      = application:get_env(chf_diameter, listen,
                                      [{tcp, {0,0,0,0}, 3868}]),

    ?LOG_INFO("Starting DIAMETER service ~p  host=~s realm=~s",
              [?SERVICE, OriginHost, OriginRealm]),

    SvcOpts = [
        {'Origin-Host',    OriginHost},
        {'Origin-Realm',   OriginRealm},
        {'Vendor-Id',      10415},
        {'Product-Name',   "Next-CHF"},
        {'Auth-Application-Id', [4]},   %% Ro / Gy
        {'Acct-Application-Id', [3]},   %% Rf
        {restrict_connections, false},
        {string_decode, false},
        {application, [{alias,      ro},
                       {dictionary, diameter_3gpp_ts32_299_ro},
                       {module,     chf_diameter_gy}]},
        {application, [{alias,      rf},
                       {dictionary, diameter_3gpp_ts32_299_rf},
                       {module,     chf_diameter_rf}]}
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
