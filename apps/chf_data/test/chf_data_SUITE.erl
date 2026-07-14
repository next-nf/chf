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

-module(chf_data_SUITE).
-moduledoc "Accessor round-trips + the `chf_data` seam against a `ram_copies` Mnesia\n"
           "backend via the generic `chf_db` facade. Covers store/lookup fidelity,\n"
           "upgrade-on-read (a doc with no `schema_version` loads with defaults and is\n"
           "stamped `schema_version => 1`), the active-session filter, CDR indexed\n"
           "lookup, and the balance money seam end to end (reserve/commit/refund,\n"
           "insufficient-balance translation, idempotent replay).".
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

all() ->
    [subscriber_roundtrip,
     subscriber_upgrade_on_read,
     session_roundtrip_and_list_active,
     cdr_roundtrip_and_list,
     balance_roundtrip_and_available,
     balance_reserve_commit_refund_seam,
     balance_reserve_insufficient_seam,
     balance_commit_idempotent_seam].

%%--------------------------------------------------------------------
%% Suite / testcase lifecycle
%%--------------------------------------------------------------------

init_per_suite(Config) ->
    ok = setup_mnesia_ram(),
    persistent_term:put({chf_db, backend}, chf_db_mnesia),
    %% Force ram_copies for the CT run (the app default is disc_copies).
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
%% Subscriber
%%--------------------------------------------------------------------

subscriber_roundtrip(_) ->
    Sub = #{<<"imsi">> => <<"001010000000001">>,
            <<"msisdn">> => <<"15550001">>,
            <<"account_id">> => <<"acc1">>,
            <<"status">> => <<"active">>},
    ok = chf_data:subscriber_create(Sub),
    ?assertEqual({error, exists}, chf_data:subscriber_create(Sub)),
    {ok, Got} = chf_data:subscriber_lookup(<<"001010000000001">>),
    ?assertEqual(<<"15550001">>, maps:get(<<"msisdn">>, Got)),
    ?assertEqual(<<"acc1">>, maps:get(<<"account_id">>, Got)),
    %% defaults present
    ?assertEqual(#{}, maps:get(<<"rating_groups">>, Got)),
    ?assertEqual(1, maps:get(<<"schema_version">>, Got)),
    ok = chf_data:subscriber_delete(<<"001010000000001">>),
    ?assertEqual({error, not_found}, chf_data:subscriber_lookup(<<"001010000000001">>)).

%% Upgrade-on-read: a raw doc with NO schema_version loads with defaults and is
%% stamped schema_version => 1. We write the bare doc through the facade directly
%% (bypassing to_doc) to simulate a pre-versioned stored document.
subscriber_upgrade_on_read(_) ->
    Bare = #{<<"imsi">> => <<"001010000000002">>, <<"msisdn">> => <<"15550002">>},
    {ok, _V} = chf_db:put(subscriber, <<"001010000000002">>, Bare),
    {ok, Got} = chf_data:subscriber_lookup(<<"001010000000002">>),
    ?assertEqual(1, maps:get(<<"schema_version">>, Got)),
    ?assertEqual(<<"active">>, maps:get(<<"status">>, Got)),  %% default applied
    ?assertEqual(<<>>, maps:get(<<"account_id">>, Got)),
    ?assertEqual(<<"15550002">>, maps:get(<<"msisdn">>, Got)). %% present field preserved

%%--------------------------------------------------------------------
%% Session
%%--------------------------------------------------------------------

session_roundtrip_and_list_active(_) ->
    S1 = #{<<"session_id">> => <<"sess1">>, <<"imsi">> => <<"i1">>,
           <<"account_id">> => <<"acc1">>, <<"rating_group">> => <<"rg1">>,
           <<"state">> => <<"active">>},
    S2 = #{<<"session_id">> => <<"sess2">>, <<"state">> => <<"terminated">>},
    ok = chf_data:session_store(S1),
    ok = chf_data:session_store(S2),
    {ok, Got1} = chf_data:session_lookup(<<"sess1">>),
    ?assertEqual(<<"acc1">>, maps:get(<<"account_id">>, Got1)),
    ?assertEqual(0, maps:get(<<"reported_used">>, Got1)),  %% default
    {ok, Active} = chf_data:session_list_active(),
    ActiveIds = [maps:get(<<"session_id">>, S) || S <- Active],
    ?assertEqual([<<"sess1">>], ActiveIds),
    ok = chf_data:session_delete(<<"sess1">>),
    ?assertEqual({error, not_found}, chf_data:session_lookup(<<"sess1">>)).

%%--------------------------------------------------------------------
%% CDR
%%--------------------------------------------------------------------

cdr_roundtrip_and_list(_) ->
    Id1 = chf_data:cdr_generate_id(),
    Id2 = chf_data:cdr_generate_id(),
    ?assertNotEqual(Id1, Id2),
    ?assertMatch([_ | _], binary_to_list(Id1)),  %% node-tagged, non-empty
    C1 = #{<<"cdr_id">> => Id1, <<"session_id">> => <<"sess1">>,
           <<"imsi">> => <<"i1">>, <<"rating_group">> => <<"rg1">>, <<"used">> => 300},
    C2 = #{<<"cdr_id">> => Id2, <<"session_id">> => <<"sess2">>, <<"used">> => 100},
    ok = chf_data:cdr_create(C1),
    ok = chf_data:cdr_create(C2),
    ?assertEqual({error, exists}, chf_data:cdr_create(C1)),
    {ok, Listed} = chf_data:cdr_list(<<"sess1">>),
    ?assertEqual(1, length(Listed)),
    [Got] = Listed,
    ?assertEqual(300, maps:get(<<"used">>, Got)),
    ?assertEqual(#{}, maps:get(<<"metadata">>, Got)).  %% default

%%--------------------------------------------------------------------
%% Balance seam (end to end via chf_db:update/3)
%%--------------------------------------------------------------------

balance_roundtrip_and_available(_) ->
    seed_balance(<<"acc1">>, 1000),
    {ok, B} = chf_data:balance_get(<<"acc1">>),
    ?assertEqual(1000, maps:get(<<"total">>, B)),
    ?assertEqual(#{}, maps:get(<<"reservations">>, B)),
    ?assertEqual(1, maps:get(<<"schema_version">>, B)).

balance_reserve_commit_refund_seam(_) ->
    seed_balance(<<"acc1">>, 1000),
    ok = chf_data:balance_reserve(<<"acc1">>, <<"s1">>, <<"rg1">>, 300, <<"r1">>),
    {ok, B1} = chf_data:balance_get(<<"acc1">>),
    ?assertEqual(700, chf_balance:available(B1)),
    %% commit clamps to reservation, removes it, drops total
    ok = chf_data:balance_commit(<<"acc1">>, <<"s1">>, 500, <<"cdr1">>, <<"c1">>),
    {ok, B2} = chf_data:balance_get(<<"acc1">>),
    ?assertEqual(700, maps:get(<<"total">>, B2)),
    ?assertEqual(#{}, maps:get(<<"reservations">>, B2)),
    %% a second reservation then refund releases without touching total
    ok = chf_data:balance_reserve(<<"acc1">>, <<"s2">>, <<"rg1">>, 200, <<"r2">>),
    ok = chf_data:balance_refund(<<"acc1">>, <<"s2">>, <<"f2">>),
    {ok, B3} = chf_data:balance_get(<<"acc1">>),
    ?assertEqual(700, maps:get(<<"total">>, B3)),
    ?assertEqual(700, chf_balance:available(B3)),
    ?assertEqual(#{}, maps:get(<<"reservations">>, B3)).

balance_reserve_insufficient_seam(_) ->
    seed_balance(<<"acc1">>, 100),
    ?assertEqual({error, insufficient_balance},
                 chf_data:balance_reserve(<<"acc1">>, <<"s1">>, <<"rg1">>, 300, <<"r1">>)),
    %% unknown account → not_found propagates honestly
    ?assertEqual({error, not_found},
                 chf_data:balance_reserve(<<"nope">>, <<"s1">>, <<"rg1">>, 10, <<"rx">>)).

balance_commit_idempotent_seam(_) ->
    seed_balance(<<"acc1">>, 1000),
    ok = chf_data:balance_reserve(<<"acc1">>, <<"s1">>, <<"rg1">>, 300, <<"r1">>),
    ok = chf_data:balance_commit(<<"acc1">>, <<"s1">>, 300, <<"cdr1">>, <<"c1">>),
    {ok, B1} = chf_data:balance_get(<<"acc1">>),
    %% replay same commit token — must not double-charge
    ok = chf_data:balance_commit(<<"acc1">>, <<"s1">>, 300, <<"cdr1">>, <<"c1">>),
    {ok, B2} = chf_data:balance_get(<<"acc1">>),
    ?assertEqual(maps:get(<<"total">>, B1), maps:get(<<"total">>, B2)),
    ?assertEqual(700, maps:get(<<"total">>, B2)).

%%--------------------------------------------------------------------
%% Helpers
%%--------------------------------------------------------------------

seed_balance(AccountId, Total) ->
    Doc = chf_balance:to_doc(#{<<"account_id">> => AccountId, <<"total">> => Total}),
    {ok, _V} = chf_db:put(balance, AccountId, Doc),
    ok.

setup_mnesia_ram() ->
    application:stop(mnesia),
    ok = mnesia:delete_schema([node()]),
    ok = application:start(mnesia).

teardown_mnesia() ->
    application:stop(mnesia),
    mnesia:delete_schema([node()]),
    ok.
