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

-module(chf_core_charging_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").
-include_lib("chf_db/include/chf_db.hrl").

all() ->
    [no_double_commit_on_terminate,
     sweeper_refunds_untouched_grant,
     reservation_returns_to_zero_after_lifecycle,
     duplicate_create_does_not_clobber,
     terminate_idempotent_no_double_refund,
     concurrent_updates_no_lost_usage,
     online_initial_rejected_for_terminated_subscriber,
     converged_lifecycle_charges_and_writes_cdrs,
     sweeper_survives_stray_message,
     partial_grant_marks_final,
     zero_available_credit_limit_reached,
     multi_rg_drain_leaves_trailing_credit_limited].

init_per_testcase(_TC, Config) -> setup_mnesia(), Config.
end_per_testcase(_TC, _Config) -> mnesia:stop(), ok.

setup_mnesia() ->
    application:set_env(chf_db, backend, chf_db_mnesia),
    persistent_term:erase({chf_db, backend}),
    mnesia:stop(),
    ok = mnesia:start(),
    {atomic, ok} = mnesia:create_table(subscriber,
        [{attributes, record_info(fields, subscriber)}, {index, [#subscriber.msisdn]}]),
    {atomic, ok} = mnesia:create_table(balance,
        [{attributes, record_info(fields, balance)}]),
    {atomic, ok} = mnesia:create_table(cdr,
        [{attributes, record_info(fields, cdr)}]),
    {atomic, ok} = mnesia:create_table(charging_session,
        [{attributes, record_info(fields, charging_session)}]),
    ok.

seed_subscriber(Imsi, AccountId, Total) ->
    Sub = #subscriber{imsi = Imsi, msisdn = <<"49", Imsi/binary>>,
                      account_id = AccountId, status = active,
                      rating_groups = #{}, created_at = 0, updated_at = 0},
    ok = chf_db:subscriber_create(Sub),
    {ok, _} = chf_db:balance_topup(AccountId, Total),
    ok.

balance(AccountId) ->
    {ok, B} = chf_db:balance_get(AccountId),
    B.

assert_invariant(AccountId) ->
    B = balance(AccountId),
    ?assertEqual(B#balance.available, B#balance.total - B#balance.reserved),
    ?assert(B#balance.reserved >= 0),
    ?assert(B#balance.available >= 0).

rg(Id, Requested, Used) ->
    #{rating_group => Id, requested_units => Requested, used_units => Used}.

no_double_commit_on_terminate(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 1000, 0)]}),
    {ok, _} = chf_core:session_update(<<"s">>, #{rating_groups => [rg(1, 1000, 400)]}),
    ok = chf_core:session_terminate(<<"s">>, #{rating_groups => [rg(1, 0, 0)]}),
    B = balance(<<"a">>),
    ?assertEqual(1000000 - 400, B#balance.total),
    ?assertEqual(0, B#balance.reserved),
    assert_invariant(<<"a">>).

sweeper_refunds_untouched_grant(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 5000, 0)]}),
    ok = chf_core:session_terminate(<<"s">>, #{rating_groups => []}),
    B = balance(<<"a">>),
    ?assertEqual(1000000, B#balance.total),
    ?assertEqual(0, B#balance.reserved),
    ?assertEqual(1000000, B#balance.available).

reservation_returns_to_zero_after_lifecycle(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 2000, 0)]}),
    {ok, _} = chf_core:session_update(<<"s">>, #{rating_groups => [rg(1, 2000, 1500)]}),
    ok = chf_core:session_terminate(<<"s">>, #{rating_groups => [rg(1, 0, 500)]}),
    B = balance(<<"a">>),
    ?assertEqual(1000000 - 2000, B#balance.total),
    ?assertEqual(0, B#balance.reserved),
    assert_invariant(<<"a">>).

duplicate_create_does_not_clobber(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 5000, 0)]}),
    ?assertEqual({error, session_exists},
                 chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online})),
    {ok, S} = chf_db:session_lookup(<<"s">>),
    ?assertEqual(#{1 => 5000}, S#charging_session.granted_units).

terminate_idempotent_no_double_refund(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 5000, 0)]}),
    ok = chf_core:session_terminate(<<"s">>, #{rating_groups => []}),
    ok = chf_core:session_terminate(<<"s">>, #{rating_groups => []}),
    B = balance(<<"a">>),
    ?assertEqual(1000000, B#balance.total),
    ?assertEqual(0, B#balance.reserved),
    ?assertEqual(1000000, B#balance.available).

concurrent_updates_no_lost_usage(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 100000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 1000, 0)]}),
    Parent = self(),
    N = 20,
    [spawn(fun() ->
        R = chf_core:session_update(<<"s">>, #{rating_groups => [rg(1, 1000, 100)]}),
        Parent ! {done, R}
     end) || _ <- lists:seq(1, N)],
    [receive {done, _} -> ok end || _ <- lists:seq(1, N)],
    {ok, S} = chf_db:session_lookup(<<"s">>),
    ?assertEqual(N * 100, maps:get(1, S#charging_session.used_units)),
    B = balance(<<"a">>),
    ?assertEqual(100000000 - (N * 100), B#balance.total),
    ?assertEqual(1000 + (N * 900), B#balance.reserved),
    assert_invariant(<<"a">>).

%% A terminated subscriber must be rejected with the distinct
%% subscriber_terminated reason (not subscriber_suspended).
online_initial_rejected_for_terminated_subscriber(_) ->
    Sub = #subscriber{imsi = <<"001">>, msisdn = <<"49001">>, account_id = <<"a">>,
                      status = terminated, rating_groups = #{},
                      created_at = 0, updated_at = 0},
    ok = chf_db:subscriber_create(Sub),
    {ok, _} = chf_db:balance_topup(<<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    ?assertEqual({error, subscriber_terminated},
                 chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 1000, 0)]})).

%% A converged session charges the balance like an online session AND writes
%% offline CDRs across its lifecycle (session_start, interim, session_stop).
converged_lifecycle_charges_and_writes_cdrs(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => converged}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 2000, 0)]}),
    {ok, _} = chf_core:session_update(<<"s">>, #{rating_groups => [rg(1, 2000, 1500)]}),
    ok = chf_core:session_terminate(<<"s">>, #{rating_groups => [rg(1, 0, 500)]}),
    B = balance(<<"a">>),
    ?assertEqual(1000000 - 2000, B#balance.total),
    ?assertEqual(0, B#balance.reserved),
    assert_invariant(<<"a">>),
    {ok, Cdrs} = chf_db:cdr_list(#{session_id => <<"s">>}),
    ?assert(length(Cdrs) >= 3).

partial_grant_marks_final(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 300),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, Out} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 1000, 0)]}),
    #{1 := #{granted := G, outcome := Outcome}} = Out,
    ?assertEqual(300, G), ?assertEqual(final_grant, Outcome),
    ?assertEqual(300, (balance(<<"a">>))#balance.reserved).

zero_available_credit_limit_reached(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 0),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, Out} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 1000, 0)]}),
    #{1 := #{granted := G, outcome := Outcome}} = Out,
    ?assertEqual(0, G), ?assertEqual(credit_limit_reached, Outcome).

multi_rg_drain_leaves_trailing_credit_limited(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, Out} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 1000, 0), rg(2, 1000, 0)]}),
    #{1 := #{granted := G1, outcome := O1}, 2 := #{granted := G2, outcome := O2}} = Out,
    ?assertEqual(1000, G1), ?assertEqual(granted, O1),
    ?assertEqual(0, G2), ?assertEqual(credit_limit_reached, O2).

sweeper_survives_stray_message(_) ->
    application:set_env(chf_core, sweep_interval, 100),
    application:set_env(chf_core, session_idle_timeout, 0),
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, Pid} = chf_session_sweeper:start_link(),
    %% Send a stray message and a stray call; neither must stop scheduling.
    Pid ! random_noise,
    try gen_server:call(Pid, status, 100) catch _:_ -> ok end,
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 5000, 0)]}),
    %% Wait for a couple of sweep intervals; the stale session must be swept.
    timer:sleep(400),
    {ok, S} = chf_db:session_lookup(<<"s">>),
    ?assertEqual(terminated, S#charging_session.state),
    gen_server:stop(Pid).
