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

%% chf_web_cdr_h.erl — CDR viewer handler.
%%
%% GET /api/cdrs — list CDRs with optional query params:
%%   imsi, session_id, type, limit (default 100)
-module(chf_web_cdr_h).

-export([init/2]).

init(Req0, State) ->
    case cowboy_req:method(Req0) of
        <<"GET">> -> handle_get(Req0, State);
        _         -> reply(405, #{<<"error">> => <<"method not allowed">>}, Req0, State)
    end.

handle_get(Req0, State) ->
    QS      = cowboy_req:parse_qs(Req0),
    Selector = build_selector(QS),
    Limit   = get_limit(QS, 100),
    {ok, Docs} = chf_db:find(cdr, Selector),
    Cdrs = [chf_cdr:from_doc(D) || D <- Docs],
    Trimmed = lists:sublist(Cdrs, Limit),
    reply(200, [cdr_to_map(C) || C <- Trimmed], Req0, State).

%%====================================================================
%% Helpers
%%====================================================================

%% Build a binary-keyed field-equality selector for chf_db:find/2 from the query
%% string. Only fields present on the CDR document are filtered (imsi,
%% session_id); the retired `type` field no longer exists.
build_selector(QS) ->
    F1 = case lists:keyfind(<<"imsi">>, 1, QS) of
             {_, V} -> #{<<"imsi">> => V};
             false  -> #{}
         end,
    case lists:keyfind(<<"session_id">>, 1, QS) of
        {_, V2} -> F1#{<<"session_id">> => V2};
        false   -> F1
    end.

get_limit(QS, Default) ->
    case lists:keyfind(<<"limit">>, 1, QS) of
        {_, Bin} ->
            try binary_to_integer(Bin) of
                N when N > 0 -> N;
                _             -> Default
            catch _:_ -> Default end;
        false -> Default
    end.

cdr_to_map(Cdr) ->
    #{
        <<"id">>           => maps:get(<<"cdr_id">>, Cdr, <<>>),
        <<"session_id">>   => maps:get(<<"session_id">>, Cdr, <<>>),
        <<"imsi">>         => maps:get(<<"imsi">>, Cdr, <<>>),
        <<"rating_group">> => maps:get(<<"rating_group">>, Cdr, <<>>),
        <<"used">>         => maps:get(<<"used">>, Cdr, 0),
        <<"timestamp">>    => maps:get(<<"ts">>, Cdr, 0),
        <<"metadata">>     => meta_to_map(maps:get(<<"metadata">>, Cdr, #{}))
    }.

meta_to_map(Meta) when is_map(Meta) ->
    maps:fold(fun(K, V, A) ->
        Key = if is_atom(K) -> atom_to_binary(K, utf8);
                 true       -> K
              end,
        Val = if is_atom(V) -> atom_to_binary(V, utf8);
                 is_binary(V) -> V;
                 is_integer(V) -> V;
                 true -> iolist_to_binary(io_lib:format("~p", [V]))
              end,
        A#{Key => Val}
    end, #{}, Meta).

reply(Status, Data, Req0, State) ->
    Body = iolist_to_binary(json:encode(Data)),
    Req  = cowboy_req:reply(Status,
             #{<<"content-type">> => <<"application/json">>},
             Body, Req0),
    {ok, Req, State}.
