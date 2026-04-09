%% chf_web_sessions_h.erl — Session browser handler.
%%
%% GET /api/sessions              — list all active session IDs
%% GET /api/sessions/:session_id  — session detail via chf_db:session_lookup/1
-module(chf_web_sessions_h).

-include_lib("chf_db/include/chf_db.hrl").

-export([init/2]).

init(Req0, State) ->
    case cowboy_req:method(Req0) of
        <<"GET">> -> handle_get(Req0, State);
        _         -> reply(405, #{<<"error">> => <<"method not allowed">>}, Req0, State)
    end.

%%====================================================================
%% GET dispatch
%%====================================================================

handle_get(Req0, State) ->
    case cowboy_req:binding(session_id, Req0) of
        undefined  -> list_sessions(Req0, State);
        SessionId  -> get_session(SessionId, Req0, State)
    end.

list_sessions(Req0, State) ->
    Ids = case chf_db:session_list_active() of
        {ok, Sessions} ->
            [S#charging_session.session_id || S <- Sessions];
        _ ->
            []
    end,
    reply(200, #{<<"session_ids">> => Ids, <<"count">> => length(Ids)}, Req0, State).

get_session(SessionId, Req0, State) ->
    case chf_db:session_lookup(SessionId) of
        {ok, Session} ->
            reply(200, session_to_map(Session), Req0, State);
        {error, not_found} ->
            reply(404, #{<<"error">> => <<"not_found">>}, Req0, State)
    end.

%%====================================================================
%% Serialisation
%%====================================================================

session_to_map(#charging_session{
        session_id    = SId,
        imsi          = Imsi,
        type          = Type,
        state         = StState,
        granted_units = Granted,
        used_units    = Used,
        created_at    = CreatedAt,
        updated_at    = UpdatedAt}) ->
    #{
        <<"session_id">>    => SId,
        <<"imsi">>          => Imsi,
        <<"type">>          => atom_to_binary(Type, utf8),
        <<"state">>         => atom_to_binary(StState, utf8),
        <<"granted_units">> => maps:fold(fun(K, V, A) ->
                                    A#{integer_to_binary(K) => V}
                               end, #{}, Granted),
        <<"used_units">>    => maps:fold(fun(K, V, A) ->
                                    A#{integer_to_binary(K) => V}
                               end, #{}, Used),
        <<"created_at">>    => CreatedAt,
        <<"updated_at">>    => UpdatedAt
    }.

%%====================================================================
%% Helpers
%%====================================================================

reply(Status, Data, Req0, State) ->
    Body = iolist_to_binary(json:encode(Data)),
    Req  = cowboy_req:reply(Status,
             #{<<"content-type">> => <<"application/json">>},
             Body, Req0),
    {ok, Req, State}.
