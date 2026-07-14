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

%% chf_web_sessions_h.erl — Session browser handler.
%%
%% GET /api/sessions              — list all active session IDs
%% GET /api/sessions/:session_id  — session detail via chf_data:session_lookup/1
-module(chf_web_sessions_h).

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
    {ok, Sessions} = chf_data:session_list_active(),
    Ids = [maps:get(<<"session_id">>, S) || S <- Sessions],
    reply(200, #{<<"session_ids">> => Ids, <<"count">> => length(Ids)}, Req0, State).

get_session(SessionId, Req0, State) ->
    case chf_data:session_lookup(SessionId) of
        {ok, Session} ->
            reply(200, session_to_map(Session), Req0, State);
        {error, not_found} ->
            reply(404, #{<<"error">> => <<"not_found">>}, Req0, State)
    end.

%%====================================================================
%% Serialisation
%%====================================================================

session_to_map(Session) ->
    Granted = maps:get(<<"granted_units">>, Session, #{}),
    Used    = maps:get(<<"used_units">>, Session, #{}),
    #{
        <<"session_id">>    => maps:get(<<"session_id">>, Session, <<>>),
        <<"imsi">>          => maps:get(<<"imsi">>, Session, <<>>),
        <<"type">>          => maps:get(<<"type">>, Session, <<>>),
        <<"state">>         => maps:get(<<"state">>, Session, <<"active">>),
        <<"granted_units">> => stringify_int_keys(Granted),
        <<"used_units">>    => stringify_int_keys(Used),
        <<"created_at">>    => maps:get(<<"created_at">>, Session, 0),
        <<"updated_at">>    => maps:get(<<"updated_at">>, Session, 0)
    }.

%% JSON object keys must be binaries; the granted/used maps are keyed by integer
%% rating-group id.
stringify_int_keys(M) ->
    maps:fold(fun(K, V, A) when is_integer(K) -> A#{integer_to_binary(K) => V};
                 (K, V, A)                    -> A#{K => V}
              end, #{}, M).

%%====================================================================
%% Helpers
%%====================================================================

reply(Status, Data, Req0, State) ->
    Body = iolist_to_binary(json:encode(Data)),
    Req  = cowboy_req:reply(Status,
             #{<<"content-type">> => <<"application/json">>},
             Body, Req0),
    {ok, Req, State}.
