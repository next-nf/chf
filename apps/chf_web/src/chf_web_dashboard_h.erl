%% chf_web_dashboard_h.erl — Dashboard API handler.
%%
%% GET /api/dashboard — returns system metrics as JSON.
-module(chf_web_dashboard_h).

-export([init/2]).

init(Req0, State) ->
    Data    = collect_metrics(),
    Body    = iolist_to_binary(json:encode(Data)),
    Req     = cowboy_req:reply(200,
                #{<<"content-type">> => <<"application/json">>},
                Body, Req0),
    {ok, Req, State}.

%%====================================================================
%% Internal helpers
%%====================================================================

collect_metrics() ->
    Mem      = erlang:memory(),
    ProcCnt  = erlang:system_info(process_count),
    ProcLim  = erlang:system_info(process_limit),
    Sessions = active_session_count(),
    DiamSvcs = diameter_services(),
    DiamPeers = diameter_peer_count(DiamSvcs),
    {WallMs, _} = erlang:statistics(wall_clock),

    #{
        <<"node">>    => atom_to_binary(node(), utf8),
        <<"uptime">>  => WallMs div 1000,
        <<"memory">>  => #{
            <<"total">>     => proplists:get_value(total,     Mem, 0),
            <<"processes">> => proplists:get_value(processes, Mem, 0),
            <<"ets">>       => proplists:get_value(ets,       Mem, 0),
            <<"binary">>    => proplists:get_value(binary,    Mem, 0)
        },
        <<"processes">> => #{
            <<"count">> => ProcCnt,
            <<"limit">> => ProcLim
        },
        <<"sessions">> => #{
            <<"active">> => Sessions
        },
        <<"diameter">> => #{
            <<"services">> => [atom_to_binary(S, utf8) || S <- DiamSvcs],
            <<"peers">>    => DiamPeers
        }
    }.

active_session_count() ->
    try
        ets:info(chf_session_by_id, size)
    catch
        _:_ -> 0
    end.

diameter_services() ->
    try
        diameter:services()
    catch
        _:_ -> []
    end.

diameter_peer_count(Services) ->
    try
        lists:foldl(fun(Svc, Acc) ->
            Transports = diameter:service_info(Svc, transport),
            Acc + length(Transports)
        end, 0, Services)
    catch
        _:_ -> 0
    end.
