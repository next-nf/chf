%% chf_provision_subscriber_h.erl — Cowboy HTTP handler for subscriber resources.
%%
%% Routes:
%%   GET    /api/v1/subscribers/:imsi        — fetch subscriber
%%   POST   /api/v1/subscribers              — create subscriber
%%   PUT    /api/v1/subscribers/:imsi        — update subscriber
%%   DELETE /api/v1/subscribers/:imsi        — delete subscriber
-module(chf_provision_subscriber_h).
-behaviour(cowboy_handler).

-include_lib("chf_db/include/chf_db.hrl").

-export([init/2]).

%%====================================================================
%% Cowboy callback
%%====================================================================

init(Req, State) ->
    Method = cowboy_req:method(Req),
    handle(Method, Req, State).

%%====================================================================
%% Method dispatch
%%====================================================================

handle(<<"GET">>, Req, State) ->
    Imsi = cowboy_req:binding(imsi, Req),
    case chf_db:subscriber_lookup(Imsi) of
        {ok, Sub} ->
            Body = chf_provision_json:encode_subscriber(Sub),
            Req2 = reply(200, Body, Req),
            {ok, Req2, State};
        {error, not_found} ->
            Req2 = reply_error(404, <<"subscriber not found">>, Req),
            {ok, Req2, State}
    end;

handle(<<"POST">>, Req, State) ->
    case read_json_body(Req) of
        {error, Reason, Req2} ->
            Req3 = reply_error(400, Reason, Req2),
            {ok, Req3, State};
        {ok, Body, Req2} ->
            create_subscriber(Body, Req2, State)
    end;

handle(<<"PUT">>, Req, State) ->
    Imsi = cowboy_req:binding(imsi, Req),
    case chf_db:subscriber_lookup(Imsi) of
        {error, not_found} ->
            Req2 = reply_error(404, <<"subscriber not found">>, Req),
            {ok, Req2, State};
        {ok, Existing} ->
            case read_json_body(Req) of
                {error, Reason, Req2} ->
                    Req3 = reply_error(400, Reason, Req2),
                    {ok, Req3, State};
                {ok, Fields, Req2} ->
                    update_subscriber(Existing, Fields, Req2, State)
            end
    end;

handle(<<"DELETE">>, Req, State) ->
    Imsi = cowboy_req:binding(imsi, Req),
    case chf_db:subscriber_delete(Imsi) of
        ok ->
            Req2 = cowboy_req:reply(204, #{}, <<>>, Req),
            {ok, Req2, State};
        {error, not_found} ->
            Req2 = reply_error(404, <<"subscriber not found">>, Req),
            {ok, Req2, State};
        {error, Err} ->
            Req2 = reply_error(500, format_error(Err), Req),
            {ok, Req2, State}
    end;

handle(_Method, Req, State) ->
    Req2 = reply_error(405, <<"method not allowed">>, Req),
    {ok, Req2, State}.

%%====================================================================
%% Create logic
%%====================================================================

create_subscriber(Fields, Req, State) ->
    case maps:find(imsi, Fields) of
        error ->
            Req2 = reply_error(400, <<"missing required field: imsi">>, Req),
            {ok, Req2, State};
        {ok, Imsi} ->
            case maps:find(msisdn, Fields) of
                error ->
                    Req2 = reply_error(400, <<"missing required field: msisdn">>, Req),
                    {ok, Req2, State};
                {ok, Msisdn} ->
                    case maps:find(account_id, Fields) of
                        error ->
                            Req2 = reply_error(400, <<"missing required field: account_id">>, Req),
                            {ok, Req2, State};
                        {ok, AccountId} ->
                            RatingGroups = parse_rating_groups(maps:get(rating_groups, Fields, #{})),
                            Now = erlang:system_time(millisecond),
                            Sub = #subscriber{
                                imsi          = Imsi,
                                msisdn        = Msisdn,
                                account_id    = AccountId,
                                status        = active,
                                rating_groups = RatingGroups,
                                created_at    = Now,
                                updated_at    = Now
                            },
                            case chf_db:subscriber_create(Sub) of
                                ok ->
                                    %% Create initial balance record with 0 amount.
                                    _ = chf_db:balance_topup(AccountId, 0),
                                    Body = chf_provision_json:encode_subscriber(Sub),
                                    Req2 = reply(201, Body, Req),
                                    {ok, Req2, State};
                                {error, Err} ->
                                    Req2 = reply_error(500, format_error(Err), Req),
                                    {ok, Req2, State}
                            end
                    end
            end
    end.

%%====================================================================
%% Update logic
%%====================================================================

update_subscriber(Existing, Fields, Req, State) ->
    Now = erlang:system_time(millisecond),
    Updated = Existing#subscriber{
        msisdn        = maps:get(msisdn,        Fields, Existing#subscriber.msisdn),
        status        = parse_status(maps:get(status, Fields, Existing#subscriber.status)),
        rating_groups = case maps:find(rating_groups, Fields) of
                            {ok, RG} -> parse_rating_groups(RG);
                            error    -> Existing#subscriber.rating_groups
                        end,
        updated_at    = Now
    },
    case chf_db:subscriber_update(Updated) of
        ok ->
            Body = chf_provision_json:encode_subscriber(Updated),
            Req2 = reply(200, Body, Req),
            {ok, Req2, State};
        {error, Err} ->
            Req2 = reply_error(500, format_error(Err), Req),
            {ok, Req2, State}
    end.

%%====================================================================
%% Helpers
%%====================================================================

%% Read body and decode JSON; return {ok, Map, Req} | {error, Reason, Req}.
read_json_body(Req) ->
    case cowboy_req:read_body(Req) of
        {ok, <<>>, Req2} ->
            {error, <<"empty request body">>, Req2};
        {ok, Bin, Req2} ->
            try
                {Map, _, _} = chf_provision_json:decode(Bin),
                {ok, Map, Req2}
            catch
                _:_ ->
                    {error, <<"invalid JSON">>, Req2}
            end;
        {error, _} = Err ->
            {error, format_error(Err), Req}
    end.

%% Convert rating_groups from JSON form (binary or integer keys) to
%% #{non_neg_integer() => rating_group_config()}.
parse_rating_groups(RG) when is_map(RG) ->
    maps:fold(fun(K, V, Acc) ->
        IntKey = to_integer_key(K),
        Config = parse_rg_config(V),
        Acc#{IntKey => Config}
    end, #{}, RG);
parse_rating_groups(_) ->
    #{}.

to_integer_key(K) when is_integer(K) -> K;
to_integer_key(K) when is_binary(K)  ->
    try binary_to_integer(K)
    catch _:_ -> 0
    end;
to_integer_key(_) -> 0.

parse_rg_config(Config) when is_map(Config) ->
    maps:fold(fun(K, V, Acc) ->
        AtomKey = if is_atom(K) -> K;
                     is_binary(K) ->
                         try binary_to_existing_atom(K, utf8)
                         catch error:badarg -> K
                         end;
                     true -> K
                  end,
        Acc#{AtomKey => V}
    end, #{}, Config);
parse_rg_config(_) ->
    #{}.

parse_status(<<"active">>)     -> active;
parse_status(<<"suspended">>)  -> suspended;
parse_status(<<"terminated">>) -> terminated;
parse_status(active)           -> active;
parse_status(suspended)        -> suspended;
parse_status(terminated)       -> terminated;
parse_status(_)                -> active.

reply(Status, Body, Req) ->
    cowboy_req:reply(Status,
        #{<<"content-type">> => <<"application/json">>},
        Body, Req).

reply_error(Status, Msg, Req) when is_binary(Msg) ->
    Body = chf_provision_json:encode(#{<<"error">> => Msg}),
    reply(Status, Body, Req);
reply_error(Status, Msg, Req) ->
    reply_error(Status, iolist_to_binary(io_lib:format("~p", [Msg])), Req).

format_error(Err) when is_binary(Err) -> Err;
format_error(Err) -> iolist_to_binary(io_lib:format("~p", [Err])).
