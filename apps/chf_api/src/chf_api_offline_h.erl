%% chf_api_offline_h.erl — Cowboy handler for Nchf_OfflineOnlyCharging.
%%
%% Routes (per TS 32.291 §6.2):
%%
%%   POST /nchf-offlineonlycharging/v1/offlinechargingdata
%%        — Create (Initial) offline charging data, returns 201 + Location
%%
%%   POST /nchf-offlineonlycharging/v1/offlinechargingdata/:offlineChargingDataRef/update
%%        — Update (interim), returns 200
%%
%%   POST /nchf-offlineonlycharging/v1/offlinechargingdata/:offlineChargingDataRef/release
%%        — Release (final), returns 204
%%
%% The offlineChargingDataRef doubles as our internal session_id.
-module(chf_api_offline_h).
-behaviour(cowboy_handler).

-export([init/2]).

%%====================================================================
%% Cowboy callback
%%====================================================================

init(Req, State) ->
    Method = cowboy_req:method(Req),
    handle(Method, Req, State).

%%====================================================================
%% Method + route dispatch
%%====================================================================

%% POST to the collection URI — Create (Initial) charging data.
handle(<<"POST">>, Req, [] = State) ->
    case read_json_body(Req) of
        {error, Title, Detail, Req2} ->
            Req3 = chf_api_error:reply_error(400, Title, Detail, Req2),
            {ok, Req3, State};
        {ok, Body, Req2} ->
            handle_create(Body, Req2, State)
    end;

%% POST to .../update — Update (interim) charging data.
handle(<<"POST">>, Req, [update] = State) ->
    Ref = cowboy_req:binding(offlineChargingDataRef, Req),
    case read_json_body(Req) of
        {error, Title, Detail, Req2} ->
            Req3 = chf_api_error:reply_error(400, Title, Detail, Req2),
            {ok, Req3, State};
        {ok, Body, Req2} ->
            handle_update(Ref, Body, Req2, State)
    end;

%% POST to .../release — Release (final) charging data.
handle(<<"POST">>, Req, [release] = State) ->
    Ref = cowboy_req:binding(offlineChargingDataRef, Req),
    case read_json_body(Req) of
        {error, Title, Detail, Req2} ->
            Req3 = chf_api_error:reply_error(400, Title, Detail, Req2),
            {ok, Req3, State};
        {ok, Body, Req2} ->
            handle_release(Ref, Body, Req2, State)
    end;

%% Wrong method.
handle(_Method, Req, State) ->
    Req2 = chf_api_error:reply_error(405,
        <<"Method Not Allowed">>,
        <<"Only POST is supported on this resource">>,
        Req),
    {ok, Req2, State}.

%%====================================================================
%% Create (Initial) — POST /nchf-offlineonlycharging/v1/offlinechargingdata
%%====================================================================

handle_create(Body, Req, State) ->
    case extract_imsi(Body) of
        {error, Reason} ->
            Req2 = chf_api_error:reply_error(400,
                <<"Bad Request">>, Reason, Req),
            {ok, Req2, State};
        {ok, Imsi} ->
            RatingGroups = extract_rating_groups(Body),
            Ref = generate_ref(),
            case chf_core:create_session(#{
                    session_id => Ref,
                    imsi       => Imsi,
                    type       => offline}) of
                {error, Reason} ->
                    Req2 = chf_api_error:reply_error(503,
                        <<"Service Unavailable">>,
                        format_error(Reason), Req),
                    {ok, Req2, State};
                {ok, _Pid} ->
                    case chf_core:session_initial(Ref, #{rating_groups => RatingGroups}) of
                        {error, Reason} ->
                            Req2 = chf_api_error:reply_error(503,
                                <<"Service Unavailable">>,
                                format_error(Reason), Req),
                            {ok, Req2, State};
                        {ok, GrantedMap} ->
                            Location = <<"/nchf-offlineonlycharging/v1/offlinechargingdata/", Ref/binary>>,
                            ResponseBody = build_response(GrantedMap, RatingGroups),
                            Req2 = cowboy_req:reply(201,
                                #{<<"content-type">> => <<"application/json">>,
                                  <<"location">>      => Location},
                                ResponseBody, Req),
                            {ok, Req2, State}
                    end
            end
    end.

%%====================================================================
%% Update (Interim) — POST .../update
%%====================================================================

handle_update(Ref, Body, Req, State) ->
    RatingGroups = extract_rating_groups(Body),
    case chf_core:session_update(Ref, #{rating_groups => RatingGroups}) of
        {error, not_found} ->
            Req2 = chf_api_error:reply_error(404,
                <<"Not Found">>,
                <<"No active charging session with the given offlineChargingDataRef">>,
                Req),
            {ok, Req2, State};
        {error, Reason} ->
            Req2 = chf_api_error:reply_error(503,
                <<"Service Unavailable">>,
                format_error(Reason), Req),
            {ok, Req2, State};
        {ok, GrantedMap} ->
            ResponseBody = build_response(GrantedMap, RatingGroups),
            Req2 = cowboy_req:reply(200,
                #{<<"content-type">> => <<"application/json">>},
                ResponseBody, Req),
            {ok, Req2, State}
    end.

%%====================================================================
%% Release (Terminate) — POST .../release
%%====================================================================

handle_release(Ref, Body, Req, State) ->
    RatingGroups = extract_rating_groups(Body),
    case chf_core:session_terminate(Ref, #{rating_groups => RatingGroups}) of
        {error, not_found} ->
            Req2 = chf_api_error:reply_error(404,
                <<"Not Found">>,
                <<"No active charging session with the given offlineChargingDataRef">>,
                Req),
            {ok, Req2, State};
        {error, Reason} ->
            Req2 = chf_api_error:reply_error(503,
                <<"Service Unavailable">>,
                format_error(Reason), Req),
            {ok, Req2, State};
        ok ->
            Req2 = cowboy_req:reply(204, #{}, <<>>, Req),
            {ok, Req2, State}
    end.

%%====================================================================
%% Internal helpers
%%====================================================================

%% Read the request body and JSON-decode it.
%% Returns {ok, Map, Req} | {error, Title, Detail, Req}.
read_json_body(Req) ->
    case cowboy_req:read_body(Req) of
        {ok, <<>>, Req2} ->
            {error, <<"Bad Request">>, <<"Empty request body">>, Req2};
        {ok, Bin, Req2} ->
            try
                {Map, _, _} = chf_api_json:decode(Bin),
                {ok, Map, Req2}
            catch
                _:_ ->
                    {error, <<"Bad Request">>, <<"Invalid JSON">>, Req2}
            end;
        {error, Reason} ->
            {error, <<"Bad Request">>, format_error(Reason), Req}
    end.

%% Extract IMSI from subscriberIdentifier.sUPI ("imsi-<digits>").
%% Returns {ok, binary()} | {error, binary()}.
extract_imsi(Body) ->
    case maps:find(subscriberIdentifier, Body) of
        error ->
            {error, <<"Missing required field: subscriberIdentifier">>};
        {ok, SubId} when is_map(SubId) ->
            case maps:find(sUPI, SubId) of
                error ->
                    {error, <<"Missing sUPI in subscriberIdentifier">>};
                {ok, Supi} ->
                    {ok, strip_imsi_prefix(Supi)}
            end;
        {ok, Supi} when is_binary(Supi) ->
            {ok, strip_imsi_prefix(Supi)};
        {ok, _Other} ->
            {error, <<"Invalid subscriberIdentifier format">>}
    end.

%% Strip the "imsi-" prefix if present; otherwise return as-is.
strip_imsi_prefix(<<"imsi-", Rest/binary>>) -> Rest;
strip_imsi_prefix(Other)                     -> Other.

%% Parse multipleUnitUsage into internal rating_groups list.
extract_rating_groups(Body) ->
    MUUs = maps:get(multipleUnitUsage, Body, []),
    lists:map(fun parse_muu/1, MUUs).

parse_muu(MUU) when is_map(MUU) ->
    RG       = maps:get(ratingGroup, MUU, 0),
    ReqUnit  = maps:get(requestedUnit, MUU, #{}),
    UsedList = maps:get(usedUnitContainer, MUU, []),
    Requested = case ReqUnit of
        RU when is_map(RU) -> maps:get(totalVolume, RU, 0);
        _ -> 0
    end,
    Used = sum_used_units(UsedList),
    #{rating_group    => to_integer(RG),
      requested_units => to_integer(Requested),
      used_units      => Used};
parse_muu(_) ->
    #{rating_group => 0, requested_units => 0, used_units => 0}.

sum_used_units(List) when is_list(List) ->
    lists:foldl(fun(UUC, Acc) when is_map(UUC) ->
        Acc + to_integer(maps:get(totalVolume, UUC, 0));
                   (_, Acc) -> Acc
                end, 0, List);
sum_used_units(_) -> 0.

%% Build the OfflineChargingDataResponse body.
build_response(GrantedMap, RatingGroups) ->
    MUI = lists:map(fun(RG) ->
        RGId    = maps:get(rating_group, RG, 0),
        Granted = maps:get(RGId, GrantedMap, 0),
        #{<<"ratingGroup">>  => RGId,
          <<"grantedUnit">>  => #{<<"totalVolume">> => Granted},
          <<"resultCode">>   => 2001,
          <<"validityTime">> => 3600}
    end, RatingGroups),
    chf_api_json:encode(#{<<"multipleUnitInformation">> => MUI}).

%% Generate a unique offlineChargingDataRef.
generate_ref() ->
    integer_to_binary(erlang:unique_integer([positive, monotonic])).

to_integer(V) when is_integer(V) -> V;
to_integer(V) when is_float(V)   -> round(V);
to_integer(V) when is_binary(V)  ->
    try binary_to_integer(V)
    catch _:_ -> 0
    end;
to_integer(_) -> 0.

format_error(Err) when is_binary(Err) -> Err;
format_error(Err) -> iolist_to_binary(io_lib:format("~p", [Err])).
