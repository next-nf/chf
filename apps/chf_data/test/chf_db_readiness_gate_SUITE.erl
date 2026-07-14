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

-module(chf_db_readiness_gate_SUITE).
-moduledoc "Asserts the database.md §6.4 readiness gate: `chf_db:ready/0` must be\n"
           "true once the `chf_data` application has started, and (by OTP dependency\n"
           "order) the collections must exist before any listener app can start.\n"
           "Runs entirely on Mnesia-ram — no external infrastructure required.".
-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").

-export([all/0, init_per_suite/1, end_per_suite/1]).
-export([ready_after_chf_data_start/1,
         await_ready_returns_ok/1,
         collections_exist_after_chf_data_start/1,
         disc_default_boots_and_is_ready/1]).

all() ->
    [ready_after_chf_data_start,
     await_ready_returns_ok,
     collections_exist_after_chf_data_start,
     disc_default_boots_and_is_ready].

%%--------------------------------------------------------------------
%% Suite lifecycle
%%--------------------------------------------------------------------

init_per_suite(Config) ->
    application:set_env(chf_db, backend, chf_db_mnesia),
    application:set_env(chf_db, backend_opts, #{storage => ram_copies}),
    %% Reset backend cache so the env above is picked up.
    catch persistent_term:erase({chf_db, backend}),
    ok = setup_mnesia_ram(),
    %% Start chf_db and chf_data (which includes the readiness gate in start/2).
    {ok, Started} = application:ensure_all_started(chf_data),
    [{started, Started} | Config].

end_per_suite(Config) ->
    [application:stop(A) || A <- lists:reverse(?config(started, Config))],
    teardown_mnesia(),
    ok.

%%--------------------------------------------------------------------
%% Test cases
%%--------------------------------------------------------------------

%% Once chf_data has started, chf_db:ready/0 must return true.
%% This verifies that the gate (ensure_collections + await_ready called in
%% chf_data_app:start/2) completed successfully before the app was declared up.
ready_after_chf_data_start(_Config) ->
    ?assert(chf_db:ready()),
    ok.

%% chf_db:await_ready/1 with a generous timeout must return ok when the
%% backend is already up (idempotent / non-blocking when ready).
await_ready_returns_ok(_Config) ->
    ?assertEqual(ok, chf_db:await_ready(5000)),
    ok.

%% All four chf_data collections must exist in Mnesia after chf_data starts.
%% mnesia:table_info/2 raises an exception if the table is unknown; the test
%% fails if any collection is missing.
collections_exist_after_chf_data_start(_Config) ->
    Collections = [subscriber, balance, charging_session, cdr],
    lists:foreach(fun(Coll) ->
        Type = mnesia:table_info(Coll, type),
        ?assertEqual(set, Type)
    end, Collections),
    ok.

%% Production boot path on the SHIPPED default (storage => disc_copies).
%% This is the gap finding the pcf lesson covers: the disc schema is NOT
%% pre-created by a test helper. We tear down the suite's ram instance, ensure
%% there is NO disc schema on this node, configure disc_copies, then start
%% chf_data and rely on chf_db_mnesia:init/1 to create the disc schema before
%% any disc table. The case asserts the collections come up on disc and
%% chf_db:ready/0 is true — i.e. a node booted with the shipped config actually
%% starts.
disc_default_boots_and_is_ready(Config) ->
    %% Tear down the ram instance the suite started so we begin from a clean
    %% node with no schema at all (not even a disc one).
    [application:stop(A) || A <- lists:reverse(?config(started, Config))],
    application:stop(mnesia),
    catch mnesia:delete_schema([node()]),
    catch persistent_term:erase({chf_db, backend}),
    %% Sanity: there must be no on-disk schema going in — otherwise we would be
    %% testing the helper's schema, not our boot fix.
    ?assertNot(mnesia:system_info(use_dir)),

    %% Shipped production default.
    application:set_env(chf_db, backend, chf_db_mnesia),
    application:set_env(chf_db, backend_opts, #{storage => disc_copies}),

    try
        %% Drive the REAL production boot path: chf_db_app -> chf_db_sup ->
        %% chf_db_mnesia:init/1 (creates disc schema) -> chf_data_app:start/2
        %% (ensure_collections + await_ready).
        {ok, _Started} = application:ensure_all_started(chf_data),

        %% A disc schema must now exist (created by the boot fix, not the helper).
        ?assert(mnesia:system_info(use_dir)),

        %% Collections are present on disc and the readiness gate is satisfied.
        lists:foreach(fun(Coll) ->
            ?assertEqual(set, mnesia:table_info(Coll, type)),
            ?assertEqual(disc_copies, mnesia:table_info(Coll, storage_type))
        end, [subscriber, balance, charging_session, cdr]),
        ?assert(chf_db:ready()),
        ?assertEqual(ok, chf_db:await_ready(5000))
    after
        %% Clean up the on-disk schema so no state is left behind and the disc
        %% files do not leak into later runs.
        application:stop(chf_data),
        application:stop(chf_db),
        application:stop(mnesia),
        catch mnesia:delete_schema([node()]),
        catch persistent_term:erase({chf_db, backend})
    end,
    ok.

%%--------------------------------------------------------------------
%% Helpers
%%--------------------------------------------------------------------

setup_mnesia_ram() ->
    application:stop(mnesia),
    ok = mnesia:delete_schema([node()]),
    ok = application:start(mnesia).

teardown_mnesia() ->
    application:stop(mnesia),
    mnesia:delete_schema([node()]),
    ok.
