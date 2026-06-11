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

%% chf_api_converged_h.erl — Cowboy handler for Nchf_ConvergedCharging.
%%
%% Routes (per TS 32.291 §6.1):
%%
%%   POST /nchf-convergedcharging/v3/chargingdata
%%        — Initial charging request (creates session, returns 201 + Location)
%%
%%   POST /nchf-convergedcharging/v3/chargingdata/:chargingDataRef/update
%%        — Update (interim) charging request, returns 200
%%
%%   POST /nchf-convergedcharging/v3/chargingdata/:chargingDataRef/release
%%        — Final / release charging request, returns 204
%%
%% The chargingDataRef doubles as our internal session_id.
-module(chf_api_converged_h).
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

%% POST to the collection URI — Initial charging request.
handle(<<"POST">>, Req, [] = State) ->
    case read_json_body(Req) of
        {error, Status, Title, Detail, Req2} ->
            Req3 = chf_api_error:reply_error(Status, Title, Detail, Req2),
            {ok, Req3, State};
        {ok, Body, Req2} ->
            handle_create(Body, Req2, State)
    end;

%% POST to .../update — Update (interim) charging request.
handle(<<"POST">>, Req, [update] = State) ->
    Ref = cowboy_req:binding(chargingDataRef, Req),
    case read_json_body(Req) of
        {error, Status, Title, Detail, Req2} ->
            Req3 = chf_api_error:reply_error(Status, Title, Detail, Req2),
            {ok, Req3, State};
        {ok, Body, Req2} ->
            handle_update(Ref, Body, Req2, State)
    end;

%% POST to .../release — Final (terminate) charging request.
handle(<<"POST">>, Req, [release] = State) ->
    Ref = cowboy_req:binding(chargingDataRef, Req),
    case read_json_body(Req) of
        {error, Status, Title, Detail, Req2} ->
            Req3 = chf_api_error:reply_error(Status, Title, Detail, Req2),
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
%% Create (Initial) — POST /nchf-convergedcharging/v3/chargingdata
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
                    type       => converged}) of
                {error, Reason} ->
                    {Status, Title, Detail} = chf_api_error:reason_to_problem(Reason),
                    Req2 = chf_api_error:reply_error(Status, Title, Detail, Req),
                    {ok, Req2, State};
                {ok, _Pid} ->
                    case chf_core:session_initial(Ref, #{rating_groups => RatingGroups}) of
                        {error, Reason} ->
                            {Status, Title, Detail} = chf_api_error:reason_to_problem(Reason),
                            Req2 = chf_api_error:reply_error(Status, Title, Detail, Req),
                            {ok, Req2, State};
                        {ok, GrantedMap} ->
                            Location = <<"/nchf-convergedcharging/v3/chargingdata/", Ref/binary>>,
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
        {error, Reason} ->
            {Status, Title, Detail} = chf_api_error:reason_to_problem(Reason),
            Req2 = chf_api_error:reply_error(Status, Title, Detail, Req),
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
        {error, Reason} ->
            {Status, Title, Detail} = chf_api_error:reason_to_problem(Reason),
            Req2 = chf_api_error:reply_error(Status, Title, Detail, Req),
            {ok, Req2, State};
        ok ->
            Req2 = cowboy_req:reply(204, #{}, <<>>, Req),
            {ok, Req2, State}
    end.

%%====================================================================
%% Internal helpers
%%====================================================================

%% Read the request body and JSON-decode it.
%% Returns {ok, Map, Req} | {error, Status, Title, Detail, Req}.
read_json_body(Req) ->
    case chf_api_util:read_body(Req) of
        {error, too_large, Req2} ->
            {error, 413, <<"Payload Too Large">>, <<"Request body exceeds limit">>, Req2};
        {ok, <<>>, Req2} ->
            {error, 400, <<"Bad Request">>, <<"Empty request body">>, Req2};
        {ok, Bin, Req2} ->
            try
                Map = chf_api_json:decode(Bin),
                {ok, Map, Req2}
            catch
                _:_ ->
                    {error, 400, <<"Bad Request">>, <<"Invalid JSON">>, Req2}
            end
    end.

%% Extract IMSI from subscriberIdentifier.sUPI ("imsi-<digits>").
%% Returns {ok, binary()} | {error, binary()}.
extract_imsi(Body) ->
    case maps:find(<<"subscriberIdentifier">>, Body) of
        error ->
            {error, <<"Missing required field: subscriberIdentifier">>};
        {ok, SubId} when is_map(SubId) ->
            case maps:find(<<"sUPI">>, SubId) of
                error ->
                    {error, <<"Missing sUPI in subscriberIdentifier">>};
                {ok, Supi} ->
                    {ok, strip_imsi_prefix(Supi)}
            end;
        {ok, Supi} when is_binary(Supi) ->
            %% subscriberIdentifier supplied directly as a string
            {ok, strip_imsi_prefix(Supi)};
        {ok, _Other} ->
            {error, <<"Invalid subscriberIdentifier format">>}
    end.

%% Strip the "imsi-" prefix if present; otherwise return as-is.
strip_imsi_prefix(<<"imsi-", Rest/binary>>) -> Rest;
strip_imsi_prefix(Other)                     -> Other.

%% Parse multipleUnitUsage into internal rating_groups list:
%%   [#{rating_group => integer(), requested_units => integer(), used_units => integer()}]
extract_rating_groups(Body) ->
    MUUs = maps:get(<<"multipleUnitUsage">>, Body, []),
    lists:map(fun parse_muu/1, MUUs).

parse_muu(MUU) when is_map(MUU) ->
    RG       = maps:get(<<"ratingGroup">>, MUU, 0),
    ReqUnit  = maps:get(<<"requestedUnit">>, MUU, #{}),
    UsedList = maps:get(<<"usedUnitContainer">>, MUU, []),
    Requested = case ReqUnit of
        RU when is_map(RU) -> maps:get(<<"totalVolume">>, RU, 0);
        _ -> 0
    end,
    Used = sum_used_units(UsedList),
    #{rating_group    => to_integer(RG),
      requested_units => to_integer(Requested),
      used_units      => Used};
parse_muu(_) ->
    #{rating_group => 0, requested_units => 0, used_units => 0}.

%% Sum totalVolume across all usedUnitContainer entries.
sum_used_units(List) when is_list(List) ->
    lists:foldl(fun(UUC, Acc) when is_map(UUC) ->
        Acc + to_integer(maps:get(<<"totalVolume">>, UUC, 0));
                   (_, Acc) -> Acc
                end, 0, List);
sum_used_units(_) -> 0.

%% Build the ChargingDataResponse body.
%%
%% GrantedMap :: #{RatingGroupId => GrantedUnits} from chf_online.
%% RatingGroups :: [#{rating_group => id(), ...}] — the parsed request groups.
%%
%% We produce multipleUnitInformation for every requested rating group,
%% falling back to 0 if the session did not grant anything for that group.
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

%% Generate a unique chargingDataRef.
generate_ref() -> chf_api_util:generate_ref().

to_integer(V) when is_integer(V) -> V;
to_integer(V) when is_float(V)   -> round(V);
to_integer(V) when is_binary(V)  ->
    try binary_to_integer(V)
    catch _:_ -> 0
    end;
to_integer(_) -> 0.

