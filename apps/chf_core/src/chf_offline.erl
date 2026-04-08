%% chf_offline.erl — Stateless offline charging logic (CDR generation).
%%
%% Called by chf_session for offline/converged sessions.
%% CDRs are written via chf_db:cdr_write/1.
-module(chf_offline).

-include_lib("chf_db/include/chf_db.hrl").

-export([initial_request/2, update_request/2, terminate_request/2]).

%%====================================================================
%% API
%%====================================================================

%% @doc Create initial CDR metadata for a session.
%%
%% For offline charging the initial request simply records that the
%% session has started.  A CDR with zero usage is written per
%% RatingGroup so that downstream mediation can correlate records.
-spec initial_request(Imsi :: binary(), SessionId :: binary()) -> ok.
initial_request(Imsi, SessionId) ->
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
    _ = chf_db:cdr_write(Cdr),
    ok.

%% @doc Write a partial (interim) CDR for each RatingGroup.
%%
%% Data :: #{session_id => binary(),
%%           rating_groups => [#{rating_group  => non_neg_integer(),
%%                               used_units    => integer()}]}
-spec update_request(Imsi :: binary(), Data :: map()) -> ok.
update_request(Imsi, Data) ->
    SessionId    = maps:get(session_id, Data),
    RatingGroups = maps:get(rating_groups, Data, []),
    Now = erlang:system_time(millisecond),
    lists:foreach(fun(RG) ->
        RGId  = maps:get(rating_group, RG),
        Used  = maps:get(used_units, RG, 0),
        Cdr = #cdr{
            id           = chf_db:cdr_generate_id(),
            session_id   = SessionId,
            imsi         = Imsi,
            type         = offline,
            rating_group = RGId,
            used_units   = #{input => 0, output => 0, total => Used},
            timestamp    = Now,
            metadata     = #{event => interim}
        },
        _ = chf_db:cdr_write(Cdr)
    end, RatingGroups),
    ok.

%% @doc Write final CDRs with all usage at session termination.
%%
%% Data :: #{session_id => binary(),
%%           rating_groups => [#{rating_group  => non_neg_integer(),
%%                               used_units    => integer()}]}
-spec terminate_request(Imsi :: binary(), Data :: map()) -> ok.
terminate_request(Imsi, Data) ->
    SessionId    = maps:get(session_id, Data),
    RatingGroups = maps:get(rating_groups, Data, []),
    Now = erlang:system_time(millisecond),
    lists:foreach(fun(RG) ->
        RGId  = maps:get(rating_group, RG),
        Used  = maps:get(used_units, RG, 0),
        Cdr = #cdr{
            id           = chf_db:cdr_generate_id(),
            session_id   = SessionId,
            imsi         = Imsi,
            type         = offline,
            rating_group = RGId,
            used_units   = #{input => 0, output => 0, total => Used},
            timestamp    = Now,
            metadata     = #{event => session_stop}
        },
        _ = chf_db:cdr_write(Cdr)
    end, RatingGroups),
    ok.
