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

%% chf_core_charging_SUITE — charging lifecycle over the chf_data map seam.
%%
%% Post-cutover model:
%%  - Money is authoritative on the BALANCE document (chf_data:balance_get/1);
%%    the descriptive charging_session carries reporting-only granted/used maps.
%%  - The balance holds ONE reservation per session, keyed by session id; a
%%    session's grant across rating groups is summed into that single hold.
%%  - `available = total − Σ reservations` is DERIVED (chf_balance:available/1);
%%    `reserved` is that derived hold total.
%% All money assertions therefore read the balance, never the session.
-module(chf_core_charging_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

all() ->
    [no_double_commit_on_terminate,
     sweeper_refunds_untouched_grant,
     reservation_returns_to_zero_after_lifecycle,
     duplicate_create_does_not_clobber,
     terminate_idempotent_no_double_refund,
     online_initial_rejected_for_terminated_subscriber,
     converged_lifecycle_charges_and_stamps_pending_cdrs,
     sweeper_survives_stray_message,
     partial_grant_marks_final,
     zero_available_credit_limit_reached,
     multi_rg_drain_leaves_trailing_credit_limited,
     sweeper_registers_globally,
     commit_persists_reservation,
     insufficient_reserve_is_credit_limited,
     update_retransmit_charges_once].

init_per_suite(Config) ->
    persistent_term:put({chf_db, backend}, chf_db_mnesia),
    application:set_env(chf_db, backend_opts, #{storage => ram_copies}),
    ok = setup_mnesia(),
    Config.

end_per_suite(_Config) ->
    catch gen_server:stop(chf_db_mnesia),
    mnesia:stop(),
    ok.

init_per_testcase(_TC, Config) ->
    lists:foreach(fun mnesia:clear_table/1,
                  [subscriber, balance, charging_session, cdr]),
    Config.

end_per_testcase(_TC, _Config) ->
    application:set_env(chf_core, session_idle_timeout, 300000),
    application:set_env(chf_core, sweep_interval, 60000),
    ok.

setup_mnesia() ->
    application:set_env(chf_db, backend, chf_db_mnesia),
    mnesia:stop(),
    ok = mnesia:start(),
    {ok, _Pid} = chf_db_mnesia:start_link(#{}),
    ok = chf_data:ensure_collections(),
    ok = chf_db_mnesia:wait_ready([subscriber, balance, charging_session, cdr]),
    ok.

%%--------------------------------------------------------------------
%% Helpers
%%--------------------------------------------------------------------

seed_subscriber(Imsi, AccountId, Total) ->
    Sub = #{<<"imsi">> => Imsi, <<"msisdn">> => <<"49", Imsi/binary>>,
            <<"account_id">> => AccountId, <<"status">> => <<"active">>,
            <<"rating_groups">> => #{}, <<"created_at">> => 0, <<"updated_at">> => 0},
    ok = chf_data:subscriber_create(Sub),
    {ok, _} = chf_data:balance_topup(AccountId, Total),
    ok.

balance(AccountId) ->
    {ok, B} = chf_data:balance_get(AccountId),
    B.

total(AccountId)     -> maps:get(<<"total">>, balance(AccountId), 0).
reserved(AccountId)  -> chf_balance:reserved_total(balance(AccountId)).
available(AccountId) -> chf_balance:available(balance(AccountId)).

assert_invariant(AccountId) ->
    ?assertEqual(available(AccountId), total(AccountId) - reserved(AccountId)),
    ?assert(reserved(AccountId) >= 0),
    ?assert(available(AccountId) >= 0).

rg(Id, Requested, Used) ->
    #{rating_group => Id, requested_units => Requested, used_units => Used}.

%%--------------------------------------------------------------------
%% Testcases
%%--------------------------------------------------------------------

no_double_commit_on_terminate(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 1000, 0)]}),
    {ok, _} = chf_core:session_update(<<"s">>, #{rating_groups => [rg(1, 1000, 400)]}),
    ok = chf_core:session_terminate(<<"s">>, #{rating_groups => [rg(1, 0, 0)]}),
    ?assertEqual(1000000 - 400, total(<<"a">>)),
    ?assertEqual(0, reserved(<<"a">>)),
    assert_invariant(<<"a">>).

sweeper_refunds_untouched_grant(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 5000, 0)]}),
    ok = chf_core:session_terminate(<<"s">>, #{rating_groups => []}),
    ?assertEqual(1000000, total(<<"a">>)),
    ?assertEqual(0, reserved(<<"a">>)),
    ?assertEqual(1000000, available(<<"a">>)).

reservation_returns_to_zero_after_lifecycle(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 2000, 0)]}),
    {ok, _} = chf_core:session_update(<<"s">>, #{rating_groups => [rg(1, 2000, 1500)]}),
    ok = chf_core:session_terminate(<<"s">>, #{rating_groups => [rg(1, 0, 500)]}),
    ?assertEqual(1000000 - 2000, total(<<"a">>)),
    ?assertEqual(0, reserved(<<"a">>)),
    assert_invariant(<<"a">>).

duplicate_create_does_not_clobber(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 5000, 0)]}),
    ?assertEqual({error, session_exists},
                 chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online})),
    %% The descriptive session still records the (reporting-only) grant, and the
    %% authoritative reservation is intact.
    {ok, S} = chf_data:session_lookup(<<"s">>),
    ?assertEqual(#{1 => 5000}, maps:get(<<"granted_units">>, S)),
    ?assertEqual(5000, reserved(<<"a">>)).

terminate_idempotent_no_double_refund(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 5000, 0)]}),
    ok = chf_core:session_terminate(<<"s">>, #{rating_groups => []}),
    ok = chf_core:session_terminate(<<"s">>, #{rating_groups => []}),
    ?assertEqual(1000000, total(<<"a">>)),
    ?assertEqual(0, reserved(<<"a">>)),
    ?assertEqual(1000000, available(<<"a">>)).

%% A terminated subscriber must be rejected with the distinct
%% subscriber_terminated reason (not subscriber_suspended).
online_initial_rejected_for_terminated_subscriber(_) ->
    Sub = #{<<"imsi">> => <<"001">>, <<"msisdn">> => <<"49001">>,
            <<"account_id">> => <<"a">>, <<"status">> => <<"terminated">>,
            <<"rating_groups">> => #{}, <<"created_at">> => 0, <<"updated_at">> => 0},
    ok = chf_data:subscriber_create(Sub),
    {ok, _} = chf_data:balance_topup(<<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    ?assertEqual({error, subscriber_terminated},
                 chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 1000, 0)]})).

%% A converged session charges the balance like online AND, on commit, stamps a
%% pending_cdr stub inside the balance doc (the Task 5 drainer materialises the
%% durable CDR later — no inline CDR write in Phase 1).
converged_lifecycle_charges_and_stamps_pending_cdrs(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => converged}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 2000, 0)]}),
    {ok, _} = chf_core:session_update(<<"s">>, #{rating_groups => [rg(1, 2000, 1500)]}),
    ok = chf_core:session_terminate(<<"s">>, #{rating_groups => [rg(1, 0, 500)]}),
    ?assertEqual(1000000 - 2000, total(<<"a">>)),
    ?assertEqual(0, reserved(<<"a">>)),
    assert_invariant(<<"a">>),
    Pending = maps:get(<<"pending_cdrs">>, balance(<<"a">>), []),
    ?assert(length(Pending) >= 1).

partial_grant_marks_final(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 300),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, Out} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 1000, 0)]}),
    #{1 := #{granted := G, outcome := Outcome}} = Out,
    ?assertEqual(300, G), ?assertEqual(final_grant, Outcome),
    ?assertEqual(300, reserved(<<"a">>)).

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
    ?assertEqual(0, G2), ?assertEqual(credit_limit_reached, O2),
    ?assertEqual(1000, reserved(<<"a">>)).

sweeper_survives_stray_message(_) ->
    application:set_env(chf_core, sweep_interval, 100),
    application:set_env(chf_core, session_idle_timeout, 0),
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, Pid} = chf_session_sweeper:start_link(),
    Pid ! random_noise,
    try gen_server:call(Pid, status, 100) catch _:_ -> ok end,
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 5000, 0)]}),
    timer:sleep(400),
    {ok, S} = chf_data:session_lookup(<<"s">>),
    ?assertEqual(<<"terminated">>, maps:get(<<"state">>, S)),
    %% Sweeping the stale session released its reservation.
    ?assertEqual(0, reserved(<<"a">>)),
    gen_server:stop(Pid).

sweeper_registers_globally(_) ->
    global:unregister_name(chf_session_sweeper),
    {ok, Pid} = chf_session_sweeper:start_link(),
    ?assertEqual(Pid, global:whereis_name(chf_session_sweeper)),
    gen_server:stop(Pid).

%% A successful initial grant persists the reservation on the balance.
commit_persists_reservation(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 2000, 0)]}),
    ?assertEqual(2000, reserved(<<"a">>)).

%% When the account cannot fund the request the outcome is credit_limit_reached
%% and no money moves (reservation stays whatever was affordable).
insufficient_reserve_is_credit_limited(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 100),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, Out} = chf_core:session_initial(<<"s">>, #{rating_groups => [rg(1, 1000, 0)]}),
    #{1 := #{granted := G, outcome := Outcome}} = Out,
    ?assertEqual(100, G),
    ?assertEqual(final_grant, Outcome),
    ?assertEqual(100, reserved(<<"a">>)),
    ?assertEqual(0, available(<<"a">>)).

%% A lost CCA causes the client to retransmit the identical CCR-Update (same
%% Session-Id, same CC-Request-Number, same reported usage). The money must be
%% charged EXACTLY ONCE: the idempotency token is keyed on the CCR request
%% identity, so the retransmit re-derives the same token and chf_balance's
%% idempotency ring returns the prior result without re-committing.
%%
%% Under the OLD request_seq-based token this FAILED: the first update advanced the
%% persisted session's request_seq, so the retransmit derived a DIFFERENT token and
%% re-charged the reported delta (bounded by the reservation clamp, but a real
%% double-charge). Passing cc_request_number pins the token per logical request.
update_retransmit_charges_once(_) ->
    ok = seed_subscriber(<<"001">>, <<"a">>, 1000000),
    {ok, _} = chf_core:create_session(#{session_id => <<"s">>, imsi => <<"001">>, type => online}),
    {ok, _} = chf_core:session_initial(<<"s">>,
                  #{cc_request_number => 0, rating_groups => [rg(1, 5000, 0)]}),
    %% CCR-Update at CC-Request-Number = 1 reporting 400 used.
    Update = #{cc_request_number => 1, rating_groups => [rg(1, 5000, 400)]},
    {ok, _} = chf_core:session_update(<<"s">>, Update),
    TotalAfterFirst = total(<<"a">>),
    ?assertEqual(1000000 - 400, TotalAfterFirst),
    %% Client retransmits the IDENTICAL update (lost-CCA scenario).
    {ok, _} = chf_core:session_update(<<"s">>, Update),
    %% Balance total is UNCHANGED — the 400 was committed exactly once.
    ?assertEqual(TotalAfterFirst, total(<<"a">>)),
    assert_invariant(<<"a">>).
