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

-module(chf_reconciliation_SUITE).
-moduledoc "Integration tests for `chf_reconciler`. Exercises orphan reclamation:\n"
           "(a) reconcile_releases_orphans — s-dead reservation reclaimed, s-live untouched;\n"
           "(b) reconcile_idempotent — two reconcile passes, available stable;\n"
           "(c) reconcile_leaves_live_untouched — balance with only live reservations;\n"
           "(d) sweeper_releases_on_terminate — sweeper terminates stale session, releases hold.".
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

all() ->
    [reconcile_releases_orphans,
     reconcile_idempotent,
     reconcile_leaves_live_untouched,
     sweeper_releases_on_terminate].

%%--------------------------------------------------------------------
%% Suite / testcase lifecycle
%%--------------------------------------------------------------------

init_per_suite(Config) ->
    ok = setup_mnesia_ram(),
    persistent_term:put({chf_db, backend}, chf_db_mnesia),
    application:set_env(chf_db, backend_opts, #{storage => ram_copies}),
    {ok, _Pid} = chf_db_mnesia:start_link(#{}),
    ok = chf_data:ensure_collections(),
    ok = chf_db_mnesia:wait_ready([subscriber, balance, charging_session, cdr]),
    Config.

end_per_suite(_Config) ->
    catch gen_server:stop(chf_db_mnesia),
    teardown_mnesia(),
    ok.

init_per_testcase(_TC, Config) ->
    lists:foreach(fun mnesia:clear_table/1,
                  [subscriber, balance, charging_session, cdr]),
    Config.

end_per_testcase(_TC, _Config) ->
    ok.

%%--------------------------------------------------------------------
%% (a) reconcile_releases_orphans
%%     Reserve for both s-live (session present+active) and s-dead (session deleted).
%%     After reconcile_once/0: s-dead's 300 reclaimed, s-live's 200 still held.
%%--------------------------------------------------------------------

reconcile_releases_orphans(_) ->
    ok = chf_data:subscriber_create(#{<<"imsi">>       => <<"i1">>,
                                      <<"account_id">> => <<"a1">>}),
    {ok, _} = chf_data:balance_topup_or_set(<<"a1">>, 1000),
    ok = chf_data:session_store(#{<<"session_id">> => <<"s-live">>,
                                  <<"account_id">> => <<"a1">>,
                                  <<"state">>      => <<"active">>}),
    ok = chf_data:balance_reserve(<<"a1">>, <<"s-live">>, <<"rg">>, 200, <<"tk1">>),
    ok = chf_data:balance_reserve(<<"a1">>, <<"s-dead">>, <<"rg">>, 300, <<"tk2">>),
    ok = chf_data:session_delete(<<"s-dead">>),
    ok = chf_reconciler:reconcile_once(),
    {ok, B} = chf_data:balance_get(<<"a1">>),
    ?assertEqual(800, chf_balance:available(B)),
    ?assertMatch(#{<<"reservations">> := R} when not is_map_key(<<"s-dead">>, R), B).

%%--------------------------------------------------------------------
%% (b) reconcile_idempotent
%%     Running reconcile_once/0 twice does not double-refund or error.
%%     Available must be stable after the second run.
%%--------------------------------------------------------------------

reconcile_idempotent(_) ->
    ok = chf_data:subscriber_create(#{<<"imsi">>       => <<"i2">>,
                                      <<"account_id">> => <<"a2">>}),
    {ok, _} = chf_data:balance_topup_or_set(<<"a2">>, 500),
    %% Reserve for an orphan only (no session stored).
    ok = chf_data:balance_reserve(<<"a2">>, <<"s-orphan">>, <<"rg">>, 150, <<"tk3">>),
    ok = chf_reconciler:reconcile_once(),
    {ok, B1} = chf_data:balance_get(<<"a2">>),
    Avail1 = chf_balance:available(B1),
    ?assertEqual(500, Avail1),
    %% Second pass: idempotent — must not error or change available.
    ok = chf_reconciler:reconcile_once(),
    {ok, B2} = chf_data:balance_get(<<"a2">>),
    ?assertEqual(Avail1, chf_balance:available(B2)).

%%--------------------------------------------------------------------
%% (c) reconcile_leaves_live_untouched
%%     A balance with only live-session reservations is left unchanged.
%%--------------------------------------------------------------------

reconcile_leaves_live_untouched(_) ->
    ok = chf_data:subscriber_create(#{<<"imsi">>       => <<"i3">>,
                                      <<"account_id">> => <<"a3">>}),
    {ok, _} = chf_data:balance_topup_or_set(<<"a3">>, 1000),
    ok = chf_data:session_store(#{<<"session_id">> => <<"s-only-live">>,
                                  <<"account_id">> => <<"a3">>,
                                  <<"state">>      => <<"active">>}),
    ok = chf_data:balance_reserve(<<"a3">>, <<"s-only-live">>, <<"rg">>, 400, <<"tk4">>),
    ok = chf_reconciler:reconcile_once(),
    {ok, B} = chf_data:balance_get(<<"a3">>),
    %% Still held: 1000 - 400 = 600 available.
    ?assertEqual(600, chf_balance:available(B)),
    ?assertMatch(#{<<"reservations">> := #{<<"s-only-live">> := _}}, B).

%%--------------------------------------------------------------------
%% (d) sweeper_releases_on_terminate
%%     A stale session whose sweeper terminates it has its balance reservation
%%     released.  We drive chf_core:session_terminate_if_stale/2 directly
%%     (it is what the sweeper calls) with MaxAge=0 so any session is stale.
%%--------------------------------------------------------------------

sweeper_releases_on_terminate(_) ->
    ok = chf_data:subscriber_create(#{<<"imsi">>       => <<"i4">>,
                                      <<"account_id">> => <<"a4">>,
                                      <<"status">>     => <<"active">>}),
    {ok, _} = chf_data:balance_topup_or_set(<<"a4">>, 1000),
    %% Store a session with an account_id so do_terminate can refund.
    ok = chf_data:session_store(#{<<"session_id">> => <<"s-stale">>,
                                  <<"account_id">> => <<"a4">>,
                                  <<"state">>      => <<"active">>,
                                  <<"type">>       => <<"offline">>}),
    ok = chf_data:balance_reserve(<<"a4">>, <<"s-stale">>, <<"rg">>, 250, <<"tk5">>),
    %% Before: 750 available (1000 - 250).
    {ok, B0} = chf_data:balance_get(<<"a4">>),
    ?assertEqual(750, chf_balance:available(B0)),
    %% Terminate with MaxAge=0 (every session qualifies as stale immediately).
    %% Sleep 1 ms to ensure updated_at < now - 0 doesn't equal; MaxAge = -1 always fires.
    timer:sleep(1),
    ok = chf_core:session_terminate_if_stale(<<"s-stale">>, 0),
    %% After: reservation must be released → 1000 available.
    {ok, B1} = chf_data:balance_get(<<"a4">>),
    ?assertEqual(1000, chf_balance:available(B1)),
    ?assertMatch(#{<<"reservations">> := R} when not is_map_key(<<"s-stale">>, R), B1).

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
