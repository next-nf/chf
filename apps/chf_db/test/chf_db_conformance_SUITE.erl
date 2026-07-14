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
-module(chf_db_conformance_SUITE).
-moduledoc "Common Test suite: runs the full conformance scenario set against\n"
           "`chf_db_mnesia` with both `ram_copies` and `disc_copies` storage tiers\n"
           "(database.md §3.3, §8.1).".
-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").

-export([all/0, groups/0,
         init_per_suite/1, end_per_suite/1,
         init_per_group/2, end_per_group/2,
         init_per_testcase/2, end_per_testcase/2]).
-export([run_conformance/1,
         facade_update_abort/1,
         facade_update_retry/1,
         facade_create/1,
         facade_ready/1]).

%% Collection atoms used per group — different names avoid cross-group interference.
-define(RAM_COLL,      conf_chf_ram).
-define(RAM_IDX_COLL,  conf_chf_ram_idx).
-define(DISC_COLL,     conf_chf_disc).
-define(DISC_IDX_COLL, conf_chf_disc_idx).

all() ->
    [{group, ram}, {group, disc}, {group, facade}].

groups() ->
    [
     {ram,    [sequence], [run_conformance]},
     {disc,   [sequence], [run_conformance]},
     {facade, [sequence], [facade_update_abort,
                           facade_update_retry,
                           facade_create,
                           facade_ready]}
    ].

%%--------------------------------------------------------------------
%% Suite-level init/end: start the gen_server once for the whole suite.
%% Schema lifecycle is per-group because ram and disc need different setups.
%%--------------------------------------------------------------------

init_per_suite(Config) ->
    {ok, _Pid} = chf_db_mnesia:start_link(#{}),
    Config.

end_per_suite(_Config) ->
    catch gen_server:stop(chf_db_mnesia),
    ok.

%%--------------------------------------------------------------------
%% Group-level init/end: set up the right Mnesia schema and collections.
%%--------------------------------------------------------------------

init_per_group(ram, Config) ->
    ok = setup_mnesia_ram(),
    ok = chf_db_mnesia:ensure_collection(?RAM_COLL,     #{storage => ram_copies}),
    ok = chf_db_mnesia:ensure_collection(?RAM_IDX_COLL, #{indexes => [<<"idx">>],
                                                          storage => ram_copies}),
    ok = chf_db_mnesia:wait_ready([?RAM_COLL, ?RAM_IDX_COLL]),
    [{coll, ?RAM_COLL}, {idx_coll, ?RAM_IDX_COLL} | Config];

init_per_group(disc, Config) ->
    ok = setup_mnesia_disc(),
    ok = chf_db_mnesia:ensure_collection(?DISC_COLL,     #{storage => disc_copies}),
    ok = chf_db_mnesia:ensure_collection(?DISC_IDX_COLL, #{indexes => [<<"idx">>],
                                                           storage => disc_copies}),
    ok = chf_db_mnesia:wait_ready([?DISC_COLL, ?DISC_IDX_COLL]),
    [{coll, ?DISC_COLL}, {idx_coll, ?DISC_IDX_COLL} | Config];

init_per_group(facade, Config) ->
    %% Facade tests run via chf_db (the generic facade), not the backend directly.
    %% Set up a fresh in-memory Mnesia and wire the backend via persistent_term.
    ok = setup_mnesia_ram(),
    %% The facade reads the backend from persistent_term; ensure it is set to mnesia.
    persistent_term:put({chf_db, backend}, chf_db_mnesia),
    ok = chf_db:ensure_collection(facade_coll, #{storage => ram_copies}),
    ok = chf_db_mnesia:wait_ready([facade_coll]),
    [{coll, facade_coll} | Config].

end_per_group(_Group, _Config) ->
    teardown_mnesia(),
    ok.

%%--------------------------------------------------------------------
%% Per-testcase: clear rows between cases (keeps scenarios isolated).
%%--------------------------------------------------------------------

init_per_testcase(_TestCase, Config) ->
    Coll = proplists:get_value(coll, Config),
    mnesia:clear_table(Coll),
    case proplists:get_value(idx_coll, Config) of
        undefined -> ok;
        IdxColl   -> mnesia:clear_table(IdxColl)
    end,
    Config.

end_per_testcase(_TestCase, _Config) ->
    ok.

%%--------------------------------------------------------------------
%% Test cases
%%--------------------------------------------------------------------

%% Facade: update/3 abort path — Fun returns {abort, over} → {error, {aborted, over}}.
%% Assert no retry via invocation counter: Fun must be called exactly once.
facade_update_abort(Config) ->
    Coll = proplists:get_value(coll, Config),
    {ok, _} = chf_db:put(Coll, <<"upd_abort">>, #{<<"v">> => 0}),
    Self = self(),
    Fun = fun(_Doc) ->
        Self ! invoked,
        {abort, over}
    end,
    ?assertEqual({error, {aborted, over}}, chf_db:update(Coll, <<"upd_abort">>, Fun)),
    %% Collect all 'invoked' messages; there must be exactly one.
    Invocations = drain_invocations(0),
    ?assertEqual(1, Invocations).

%% Facade: update/3 retry path — inject a concurrent cas_put to force one
%% version_conflict on the first attempt, then let it succeed.
facade_update_retry(Config) ->
    Coll = proplists:get_value(coll, Config),
    {ok, _} = chf_db:put(Coll, <<"upd_retry">>, #{<<"v">> => 0}),
    Self = self(),
    Fun = fun(Doc) ->
        %% On the first invocation, do a concurrent cas_put to bump the version
        %% so that chf_db:update/3 sees a version_conflict and retries.
        case maps:get(<<"attempt">>, Doc, first) of
            first ->
                %% Read current version and bump it from outside the update loop.
                {ok, _, Vsn} = chf_db:get(Coll, <<"upd_retry">>),
                {ok, _} = chf_db:cas_put(Coll, <<"upd_retry">>, Vsn,
                                         #{<<"v">> => 1, <<"attempt">> => second}),
                Self ! first_attempt,
                {ok, Doc#{<<"v">> => 99}};
            second ->
                Self ! second_attempt,
                {ok, Doc#{<<"v">> => 42}}
        end
    end,
    {ok, FinalDoc, _Vsn} = chf_db:update(Coll, <<"upd_retry">>, Fun),
    ?assertEqual(42, maps:get(<<"v">>, FinalDoc)),
    First  = drain_invocations(0),
    ?assert(First >= 1).

%% Facade: create/3 — {ok, V} first call, {error, exists} on repeat.
facade_create(Config) ->
    Coll = proplists:get_value(coll, Config),
    {ok, V} = chf_db:create(Coll, <<"create_key">>, #{<<"n">> => 1}),
    ?assertEqual(1, V),
    ?assertEqual({error, exists}, chf_db:create(Coll, <<"create_key">>, #{<<"n">> => 2})).

%% Facade: ready/0 returns true after ensure_collection.
facade_ready(_Config) ->
    ?assertEqual(true, chf_db:ready()).

%% Drain all 'invoked' messages from the mailbox, returning count.
drain_invocations(N) ->
    receive
        invoked         -> drain_invocations(N + 1);
        first_attempt   -> drain_invocations(N + 1);
        second_attempt  -> drain_invocations(N + 1)
    after 0 ->
        N
    end.

run_conformance(Config) ->
    Coll    = proplists:get_value(coll,     Config),
    IdxColl = proplists:get_value(idx_coll, Config),
    Scenarios = scenarios(chf_db_mnesia, Coll, IdxColl),
    lists:foreach(
        fun({Name, Fun}) ->
            ct:log("scenario: ~s", [Name]),
            Fun()
        end,
        Scenarios).

%%--------------------------------------------------------------------
%% Mnesia setup / teardown helpers (inlined; no shared ct helper yet)
%%--------------------------------------------------------------------

setup_mnesia_ram() ->
    application:stop(mnesia),
    ok = mnesia:delete_schema([node()]),
    %% Do NOT call create_schema — the default in-memory schema is sufficient
    %% for ram_copies tables and avoids any disc dependency.
    ok = application:start(mnesia).

setup_mnesia_disc() ->
    application:stop(mnesia),
    ok = mnesia:delete_schema([node()]),
    ok = mnesia:create_schema([node()]),
    ok = application:start(mnesia).

teardown_mnesia() ->
    application:stop(mnesia),
    mnesia:delete_schema([node()]),
    ok.

%%--------------------------------------------------------------------
%% Conformance scenarios — backend-agnostic, called with B = chf_db_mnesia
%%--------------------------------------------------------------------

-spec scenarios(module(), atom(), atom()) -> [{string(), fun(() -> any())}].
scenarios(B, Coll, IdxColl) ->
    [
     %% ---- CRUD ----
     {"put returns {ok, 1} for a new key",
      fun() ->
          {ok, V} = B:put(Coll, <<"crud_put_new">>, #{<<"a">> => 1}),
          ?assertEqual(1, V)
      end},

     {"put upserts and bumps version",
      fun() ->
          {ok, V1} = B:put(Coll, <<"crud_put_upsert">>, #{<<"a">> => 1}),
          ?assertEqual(1, V1),
          {ok, V2} = B:put(Coll, <<"crud_put_upsert">>, #{<<"a">> => 2}),
          ?assertEqual(2, V2)
      end},

     {"get round-trips doc without version in doc body",
      fun() ->
          {ok, _} = B:put(Coll, <<"crud_get">>, #{<<"x">> => 42}),
          {ok, Doc, Vsn} = B:get(Coll, <<"crud_get">>),
          ?assertEqual(42, maps:get(<<"x">>, Doc)),
          ?assertEqual(1, Vsn),
          %% version is metadata, never a doc field
          ?assertEqual(error, maps:find(<<"version">>, Doc)),
          %% _id is storage metadata, must be stripped from returned doc
          ?assertEqual(error, maps:find(<<"_id">>, Doc))
      end},

     {"get missing key returns {error, not_found}",
      fun() ->
          ?assertEqual({error, not_found}, B:get(Coll, <<"crud_get_missing">>))
      end},

     {"delete removes doc",
      fun() ->
          {ok, _} = B:put(Coll, <<"crud_del">>, #{<<"a">> => 1}),
          ok = B:delete(Coll, <<"crud_del">>),
          ?assertEqual({error, not_found}, B:get(Coll, <<"crud_del">>))
      end},

     {"delete is idempotent on absent key",
      fun() ->
          ok = B:delete(Coll, <<"crud_del_absent">>),
          ok = B:delete(Coll, <<"crud_del_absent">>)
      end},

     {"delete is idempotent on already-deleted key",
      fun() ->
          {ok, _} = B:put(Coll, <<"crud_del_idem">>, #{<<"a">> => 1}),
          ok = B:delete(Coll, <<"crud_del_idem">>),
          ok = B:delete(Coll, <<"crud_del_idem">>)
      end},

     {"find returns matching docs by selector equality",
      fun() ->
          {ok, _} = B:put(Coll, <<"find_k1">>, #{<<"m">> => <<"x">>}),
          {ok, _} = B:put(Coll, <<"find_k2">>, #{<<"m">> => <<"y">>}),
          {ok, _} = B:put(Coll, <<"find_k3">>, #{<<"m">> => <<"x">>}),
          {ok, Docs} = B:find(Coll, #{<<"m">> => <<"x">>}),
          Vals = [maps:get(<<"m">>, D) || D <- Docs,
                  maps:get(<<"m">>, D, undefined) =:= <<"x">>],
          ?assertEqual(2, length(Vals))
      end},

     {"find returns empty list when no match",
      fun() ->
          {ok, Docs} = B:find(Coll, #{<<"find_none_sentinel">> => <<"z99">>}),
          ?assertEqual([], Docs)
      end},

     %% ---- cas_put ----
     {"cas_put succeeds when version matches and bumps version",
      fun() ->
          {ok, 1} = B:put(Coll, <<"cas_match">>, #{<<"v">> => 1}),
          {ok, Doc0, 1} = B:get(Coll, <<"cas_match">>),
          {ok, V2} = B:cas_put(Coll, <<"cas_match">>, 1, Doc0#{<<"v">> => 2}),
          ?assertEqual(2, V2),
          {ok, Doc1, V3} = B:get(Coll, <<"cas_match">>),
          ?assertEqual(2, V3),
          ?assertEqual(2, maps:get(<<"v">>, Doc1))
      end},

     {"cas_put returns {error, version_conflict} on stale version",
      fun() ->
          {ok, _} = B:put(Coll, <<"cas_stale">>, #{<<"v">> => 1}),
          ?assertEqual({error, version_conflict},
                       B:cas_put(Coll, <<"cas_stale">>, 99, #{<<"v">> => 2})),
          %% doc must be unchanged
          {ok, Doc, 1} = B:get(Coll, <<"cas_stale">>),
          ?assertEqual(1, maps:get(<<"v">>, Doc))
      end},

     {"cas_put returns {error, not_found} for absent key",
      fun() ->
          ?assertEqual({error, not_found},
                       B:cas_put(Coll, <<"cas_absent">>, 1, #{<<"v">> => 1}))
      end},

     %% ---- take ----
     {"take returns {ok, Doc, Vsn} and removes the doc",
      fun() ->
          {ok, _} = B:put(Coll, <<"take_k">>, #{<<"t">> => 1}),
          {ok, Doc, Vsn} = B:take(Coll, <<"take_k">>),
          ?assertEqual(1, maps:get(<<"t">>, Doc)),
          ?assertEqual(1, Vsn),
          ?assertEqual({error, not_found}, B:get(Coll, <<"take_k">>)),
          %% _id is storage metadata, must be stripped from returned doc
          ?assertEqual(error, maps:find(<<"_id">>, Doc))
      end},

     {"take on absent key returns {error, not_found}",
      fun() ->
          ?assertEqual({error, not_found}, B:take(Coll, <<"take_absent">>))
      end},

     {"take is atomic: second take returns not_found",
      fun() ->
          {ok, _} = B:put(Coll, <<"take_double">>, #{<<"t">> => 2}),
          {ok, _, _} = B:take(Coll, <<"take_double">>),
          ?assertEqual({error, not_found}, B:take(Coll, <<"take_double">>))
      end},

     %% ---- find_by (indexed collection) ----
     {"find_by returns docs matching the declared index value",
      fun() ->
          {ok, _} = B:put(IdxColl, <<"fb_k1">>, #{<<"idx">> => <<"v1">>, <<"d">> => 1}),
          {ok, _} = B:put(IdxColl, <<"fb_k2">>, #{<<"idx">> => <<"v2">>, <<"d">> => 2}),
          {ok, _} = B:put(IdxColl, <<"fb_k3">>, #{<<"idx">> => <<"v1">>, <<"d">> => 3}),
          {ok, Docs} = B:find_by(IdxColl, <<"idx">>, <<"v1">>),
          ?assertEqual(2, length(Docs)),
          ?assert(lists:all(fun(D) -> maps:get(<<"idx">>, D) =:= <<"v1">> end, Docs))
      end},

     {"find_by returns empty list when no match",
      fun() ->
          {ok, Docs} = B:find_by(IdxColl, <<"idx">>, <<"no_such_value">>),
          ?assertEqual([], Docs)
      end},

     {"find_by returns error for undeclared index",
      fun() ->
          ?assertEqual({error, undeclared_index},
                       B:find_by(IdxColl, <<"not_declared">>, <<"x">>))
      end},

     %% ---- fold ----
     {"fold iterates all matching docs",
      fun() ->
          {ok, _} = B:put(Coll, <<"fold_k1">>, #{<<"grp">> => <<"g1">>, <<"n">> => 1}),
          {ok, _} = B:put(Coll, <<"fold_k2">>, #{<<"grp">> => <<"g1">>, <<"n">> => 2}),
          {ok, _} = B:put(Coll, <<"fold_k3">>, #{<<"grp">> => <<"g2">>, <<"n">> => 3}),
          {ok, Sum} = B:fold(Coll, #{<<"grp">> => <<"g1">>},
                             fun(Doc, Acc) -> Acc + maps:get(<<"n">>, Doc) end, 0),
          ?assertEqual(3, Sum)
      end},

     {"fold over empty match returns initial accumulator",
      fun() ->
          {ok, Acc} = B:fold(Coll, #{<<"fold_none_sentinel">> => <<"zzz">>},
                             fun(_Doc, A) -> A + 1 end, 0),
          ?assertEqual(0, Acc)
      end},

     %% ---- count ----
     {"count returns number of matching docs",
      fun() ->
          {ok, _} = B:put(Coll, <<"cnt_k1">>, #{<<"cg">> => <<"c1">>}),
          {ok, _} = B:put(Coll, <<"cnt_k2">>, #{<<"cg">> => <<"c1">>}),
          {ok, _} = B:put(Coll, <<"cnt_k3">>, #{<<"cg">> => <<"c2">>}),
          {ok, N1} = B:count(Coll, #{<<"cg">> => <<"c1">>}),
          ?assertEqual(2, N1),
          {ok, N2} = B:count(Coll, #{<<"cg">> => <<"c2">>}),
          ?assertEqual(1, N2)
      end},

     {"count returns 0 for empty result",
      fun() ->
          {ok, N} = B:count(Coll, #{<<"count_none_sentinel">> => <<"zzz">>}),
          ?assertEqual(0, N)
      end}
    ].
