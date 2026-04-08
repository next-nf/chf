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

            %% Prometheus metrics
            {"/metrics", prometheus_cowboy_handler, []}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(chf_web_listener,
        [{port, Port}, {ip, Ip}],
        #{env => #{dispatch => Dispatch}}),
    chf_web_sup:start_link().

stop(_State) ->
    cowboy:stop_listener(chf_web_listener),
    ok.
