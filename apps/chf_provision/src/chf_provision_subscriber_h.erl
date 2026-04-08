%% chf_provision_subscriber_h.erl — Cowboy REST handler for subscriber resources.
%%
%% Routes:
%%   GET    /api/v1/subscribers/:imsi  — fetch subscriber
%%   POST   /api/v1/subscribers        — create subscriber
%%   PUT    /api/v1/subscribers/:imsi  — update subscriber
%%   DELETE /api/v1/subscribers/:imsi  — delete subscriber
-module(chf_provision_subscriber_h).

-include_lib("chf_db/include/chf_db.hrl").

-export([init/2,
         allowed_methods/2,
         content_types_provided/2,
         content_types_accepted/2,
         resource_exists/2,
         delete_resource/2,
         to_json/2,
         from_json/2]).

-record(state, {
    imsi       :: binary() | undefined,
    subscriber :: #subscriber{} | undefined
}).

%%====================================================================
%% REST callbacks
%%====================================================================

init(Req, _Opts) ->
    Imsi = cowboy_req:binding(imsi, Req, undefined),
    {cowboy_rest, Req, #state{imsi = Imsi}}.

allowed_methods(Req, #state{imsi = undefined} = State) ->
    {[<<"GET">>, <<"POST">>], Req, State};
allowed_methods(Req, State) ->
    {[<<"GET">>, <<"PUT">>, <<"DELETE">>], Req, State}.

content_types_provided(Req, State) ->
    {[{<<"application/json">>, to_json}], Req, State}.

content_types_accepted(Req, State) ->
    {[{<<"application/json">>, from_json}], Req, State}.

resource_exists(Req, #state{imsi = undefined} = State) ->
    %% Collection endpoint — POST creates, GET not meaningful without ID.
    %% Return true so POST goes through content_types_accepted.
    {true, Req, State};
resource_exists(Req, #state{imsi = Imsi} = State) ->
    case chf_db:subscriber_lookup(Imsi) of
        {ok, Sub} ->
            {true, Req, State#state{subscriber = Sub}};
        {error, not_found} ->
            {false, Req, State}
    end.

%%====================================================================
%% GET — provide JSON representation
%%====================================================================

to_json(Req, #state{subscriber = Sub} = State) when Sub =/= undefined ->
    Body = chf_provision_json:encode_subscriber(Sub),
    {Body, Req, State};
to_json(Req, State) ->
    Body = chf_provision_json:encode(#{<<"error">> => <<"not found">>}),
    {Body, Req, State}.

%%====================================================================
%% POST / PUT — accept JSON
%%====================================================================

from_json(Req, State) ->
    Method = cowboy_req:method(Req),
    {ok, RawBody, Req2} = cowboy_req:read_body(Req),
    case decode_body(RawBody) of
        {error, Reason} ->
            reply_error(400, Reason, Req2, State);
        {ok, Fields} ->
            case Method of
                <<"POST">> -> handle_create(Fields, Req2, State);
                <<"PUT">>  -> handle_update(Fields, Req2, State)
            end
    end.

%%====================================================================
%% DELETE
%%====================================================================

delete_resource(Req, #state{imsi = Imsi} = State) ->
    case chf_db:subscriber_delete(Imsi) of
        ok              -> {true, Req, State};
        {error, _}      -> {false, Req, State}
    end.

%%====================================================================
%% Create logic
%%====================================================================

handle_create(Fields, Req, State) ->
    case validate_create_fields(Fields) of
        {error, Reason} ->
            reply_error(400, Reason, Req, State);
        {ok, Imsi, Msisdn, AccountId} ->
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
                    _ = chf_db:balance_topup(AccountId, 0),
                    Body = chf_provision_json:encode_subscriber(Sub),
                    Req2 = cowboy_req:set_resp_body(Body, Req),
                    {{created, <<"/api/v1/subscribers/", Imsi/binary>>}, Req2, State};
                {error, Err} ->
                    reply_error(500, format_error(Err), Req, State)
            end
    end.

%%====================================================================
%% Update logic
%%====================================================================

handle_update(Fields, Req, #state{subscriber = Existing} = State) ->
    Now = erlang:system_time(millisecond),
    Updated = Existing#subscriber{
        msisdn        = maps:get(msisdn, Fields, Existing#subscriber.msisdn),
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
            Req2 = cowboy_req:set_resp_body(Body, Req),
            {true, Req2, State#state{subscriber = Updated}};
        {error, Err} ->
            reply_error(500, format_error(Err), Req, State)
    end.

%%====================================================================
%% Helpers
%%====================================================================

validate_create_fields(Fields) ->
    case {maps:find(imsi, Fields), maps:find(msisdn, Fields), maps:find(account_id, Fields)} of
        {{ok, Imsi}, {ok, Msisdn}, {ok, AccountId}} ->
            {ok, Imsi, Msisdn, AccountId};
        {{ok, _}, {ok, _}, error} ->
            {error, <<"missing required field: account_id">>};
        {{ok, _}, error, _} ->
            {error, <<"missing required field: msisdn">>};
        {error, _, _} ->
            {error, <<"missing required field: imsi">>}
    end.

decode_body(<<>>) ->
    {error, <<"empty request body">>};
decode_body(Bin) ->
    try
        {Map, _, _} = chf_provision_json:decode(Bin),
        {ok, Map}
    catch
        _:_ -> {error, <<"invalid JSON">>}
    end.

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

reply_error(Status, Msg, Req, State) ->
    Body = chf_provision_json:encode(#{<<"error">> => Msg}),
    Req2 = cowboy_req:set_resp_header(<<"content-type">>, <<"application/json">>, Req),
    Req3 = cowboy_req:set_resp_body(Body, Req2),
    {stop, cowboy_req:reply(Status, Req3), State}.

format_error(Err) when is_binary(Err) -> Err;
format_error(Err) -> iolist_to_binary(io_lib:format("~p", [Err])).
