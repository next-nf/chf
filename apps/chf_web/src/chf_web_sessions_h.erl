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
