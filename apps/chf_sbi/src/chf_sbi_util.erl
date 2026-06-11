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

%% chf_sbi_util.erl — Shared utilities for CHF REST API handlers.
-module(chf_sbi_util).

-export([read_body/1, generate_ref/0]).

-define(MAX_BODY, 1048576).   %% 1 MiB cap for charging request bodies

%% @doc Read a full request body, accumulating cowboy {more, ...} chunks and
%% enforcing a size cap. Returns {ok, Bin, Req} | {error, too_large, Req}.
-spec read_body(cowboy_req:req()) ->
    {ok, binary(), cowboy_req:req()} | {error, too_large, cowboy_req:req()}.
read_body(Req) ->
    read_body(Req, <<>>).

read_body(Req, Acc) ->
    case cowboy_req:read_body(Req, #{length => ?MAX_BODY}) of
        {ok, Data, Req2} ->
            Acc2 = <<Acc/binary, Data/binary>>,
            case byte_size(Acc2) > ?MAX_BODY of
                true  -> {error, too_large, Req2};
                false -> {ok, Acc2, Req2}
            end;
        {more, Data, Req2} ->
            Acc2 = <<Acc/binary, Data/binary>>,
            case byte_size(Acc2) > ?MAX_BODY of
                true  -> {error, too_large, Req2};
                false -> read_body(Req2, Acc2)
            end
    end.

%% @doc Generate a chargingDataRef that does not collide across node
%% restarts: time-prefixed (microseconds) plus a per-VM unique integer.
-spec generate_ref() -> binary().
generate_ref() ->
    Time   = erlang:system_time(microsecond),
    Unique = erlang:unique_integer([positive, monotonic]),
    iolist_to_binary([integer_to_binary(Time), "-", integer_to_binary(Unique)]).
