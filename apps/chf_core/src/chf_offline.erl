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

%% chf_offline.erl — Stateless offline charging logic (CDR generation).
%%
%% Called by chf_session for offline/converged sessions.
%% CDRs are written via chf_db:cdr_write/1.
-module(chf_offline).

-include_lib("chf_db/include/chf_db.hrl").

-export([initial_request/3, update_request/3, terminate_request/3]).

%%====================================================================
%% API
%%====================================================================

%% @doc Create initial CDR metadata for a session.
%%
%% For offline charging the initial request simply records that the
%% session has started.  A CDR with zero usage is written per
%% RatingGroup so that downstream mediation can correlate records.
-spec initial_request(Ctx :: term(), Imsi :: binary(), SessionId :: binary()) -> ok.
initial_request(Ctx, Imsi, SessionId) ->
    %% Write a single "session-open" CDR with no usage details.
    Cdr = #cdr{
        id           = chf_db:cdr_generate_id(),
        session_id   = SessionId,
        imsi         = Imsi,
        type         = offline,
        rating_group = 0,
        used_units   = #{input => 0, output => 0, total => 0},
        timestamp    = erlang:system_time(millisecond),
        metadata     = #{event => session_start}
    },
    chf_db:cdr_write(Ctx, Cdr).

%% @doc Write a partial (interim) CDR for each RatingGroup.
%%
%% Data :: #{session_id => binary(),
%%           rating_groups => [#{rating_group  => non_neg_integer(),
%%                               used_units    => integer()}]}
%% Returns ok; inside a session_transaction a cdr_write failure aborts the
%% enclosing transaction (atomic charge+CDR) rather than returning an error.
-spec update_request(Ctx :: term(), Imsi :: binary(), Data :: map()) -> ok.
update_request(Ctx, Imsi, Data) ->
    SessionId    = maps:get(session_id, Data),
    RatingGroups = maps:get(rating_groups, Data, []),
    write_usage_cdrs(Ctx, Imsi, SessionId, RatingGroups, interim).

%% @doc Write final CDRs with all usage at session termination.
%%
%% Data :: #{session_id => binary(),
%%           rating_groups => [#{rating_group  => non_neg_integer(),
%%                               used_units    => integer()}]}
-spec terminate_request(Ctx :: term(), Imsi :: binary(), Data :: map()) -> ok.
terminate_request(Ctx, Imsi, Data) ->
    SessionId    = maps:get(session_id, Data),
    RatingGroups = maps:get(rating_groups, Data, []),
    write_usage_cdrs(Ctx, Imsi, SessionId, RatingGroups, session_stop).

%%====================================================================
%% Internal helpers
%%====================================================================

%% Write one usage CDR per RatingGroup.  The Ctx-aware cdr_write/2 runs inside
%% the parent Mnesia activity and returns ok unconditionally; any storage failure
%% manifests as a transaction abort rather than an {error, _} return, so no
%% error accumulation is needed here.
-spec write_usage_cdrs(term(), binary(), binary(), [map()], atom()) -> ok.
write_usage_cdrs(Ctx, Imsi, SessionId, RatingGroups, Event) ->
    Now = erlang:system_time(millisecond),
    lists:foreach(fun(RG) ->
        RGId = maps:get(rating_group, RG),
        Used = maps:get(used_units, RG, 0),
        Cdr = #cdr{
            id           = chf_db:cdr_generate_id(),
            session_id   = SessionId,
            imsi         = Imsi,
            type         = offline,
            rating_group = RGId,
            used_units   = #{input => 0, output => 0, total => Used},
            timestamp    = Now,
            metadata     = #{event => Event}
        },
        ok = chf_db:cdr_write(Ctx, Cdr)
    end, RatingGroups).
