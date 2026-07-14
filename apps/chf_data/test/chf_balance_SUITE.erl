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

-module(chf_balance_SUITE).
-moduledoc "Pure money-invariant tests for `chf_balance` — the safety-critical heart of\n"
           "the CHF data layer. No DB: each case exercises a `Fun` directly on a balance\n"
           "doc and asserts the money invariants (no over-deduction, correct residuals,\n"
           "idempotent replay, clamping never increases total).".
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").

all() ->
    [avail_of_empty,
     reserve_ok,
     reserve_insufficient,
     commit_clamps_and_stamps,
     commit_partial,
     refund_releases,
     commit_idempotent,
     reserve_negative_rejected,
     commit_negative_clamped,
     reserve_two_sessions_cannot_exceed_total].

%% available on an empty balance = total
avail_of_empty(_) ->
    D = chf_balance:to_doc(#{<<"account_id">> => <<"a1">>, <<"total">> => 1000}),
    ?assertEqual(1000, chf_balance:available(D)).

%% reserve within available succeeds, reduces available, records the reservation
reserve_ok(_) ->
    D0 = chf_balance:to_doc(#{<<"account_id">> => <<"a1">>, <<"total">> => 1000}),
    {ok, D1} = (chf_balance:reserve_fun(<<"s1">>, <<"rg1">>, 300, <<"t1">>))(D0),
    ?assertEqual(700, chf_balance:available(D1)),
    ?assertMatch(#{<<"reservations">> := #{<<"s1">> := #{<<"amount">> := 300}}}, D1).

%% reserve beyond available aborts insufficient_balance, no mutation
reserve_insufficient(_) ->
    D0 = chf_balance:to_doc(#{<<"account_id">> => <<"a1">>, <<"total">> => 100}),
    ?assertEqual({abort, insufficient_balance}, (chf_balance:reserve_fun(<<"s1">>, <<"rg1">>, 300, <<"t1">>))(D0)).

%% commit consumes used, clamped to the held reservation, releases the grant, stamps a pending_cdr
commit_clamps_and_stamps(_) ->
    D0 = chf_balance:to_doc(#{<<"account_id">> => <<"a1">>, <<"total">> => 1000}),
    {ok, D1} = (chf_balance:reserve_fun(<<"s1">>, <<"rg1">>, 300, <<"t1">>))(D0),
    {ok, D2} = (chf_balance:commit_fun(<<"s1">>, 500, <<"cdr1">>, <<"t2">>))(D1), %% used>reservation → clamp to 300
    ?assertEqual(700, maps:get(<<"total">>, D2)),        %% 1000 − 300
    ?assertEqual(700, chf_balance:available(D2)),          %% reservation released
    ?assertEqual(#{}, maps:get(<<"reservations">>, D2)),
    ?assertMatch([#{<<"cdr_id">> := <<"cdr1">>, <<"used">> := 300}], maps:get(<<"pending_cdrs">>, D2)).

%% partial commit keeps the residual reservation
commit_partial(_) ->
    D0 = chf_balance:to_doc(#{<<"account_id">> => <<"a1">>, <<"total">> => 1000}),
    {ok, D1} = (chf_balance:reserve_fun(<<"s1">>, <<"rg1">>, 300, <<"t1">>))(D0),
    {ok, D2} = (chf_balance:commit_fun(<<"s1">>, 100, <<"cdr1">>, <<"t2">>))(D1),
    ?assertEqual(900, maps:get(<<"total">>, D2)),
    ?assertEqual(700, chf_balance:available(D2)),          %% residual 200 reservation still held
    ?assertMatch(#{<<"s1">> := #{<<"amount">> := 200}}, maps:get(<<"reservations">>, D2)).

%% refund/release drops the reservation, returns held to available, no total change
refund_releases(_) ->
    D0 = chf_balance:to_doc(#{<<"account_id">> => <<"a1">>, <<"total">> => 1000}),
    {ok, D1} = (chf_balance:reserve_fun(<<"s1">>, <<"rg1">>, 300, <<"t1">>))(D0),
    {ok, D2} = (chf_balance:refund_fun(<<"s1">>, <<"t3">>))(D1),
    ?assertEqual(1000, maps:get(<<"total">>, D2)),
    ?assertEqual(1000, chf_balance:available(D2)),
    ?assertEqual(#{}, maps:get(<<"reservations">>, D2)).

%% idempotency: replaying the same token on commit returns the same doc, does not double-charge
commit_idempotent(_) ->
    D0 = chf_balance:to_doc(#{<<"account_id">> => <<"a1">>, <<"total">> => 1000}),
    {ok, D1} = (chf_balance:reserve_fun(<<"s1">>, <<"rg1">>, 300, <<"t1">>))(D0),
    {ok, D2} = (chf_balance:commit_fun(<<"s1">>, 300, <<"cdr1">>, <<"tok-commit-1">>))(D1),
    {ok, D3} = (chf_balance:commit_fun(<<"s1">>, 300, <<"cdr1">>, <<"tok-commit-1">>))(D2),
    ?assertEqual(D2, D3).   %% replay is a no-op

%% a negative reserve amount is rejected without inserting a reservation or token
reserve_negative_rejected(_) ->
    D0 = chf_balance:to_doc(#{<<"account_id">> => <<"a1">>, <<"total">> => 1000}),
    ?assertEqual({abort, invalid_amount},
                 (chf_balance:reserve_fun(<<"s1">>, <<"rg">>, -50, <<"tk">>))(D0)).

%% a negative commit clamps to 0: total never increases, available stays valid.
%% UsedClamped==0 → the settle path reduces the hold by 0 (reservation still 300),
%% a used=0 pending_cdr is appended, and the token is recorded.
commit_negative_clamped(_) ->
    D0 = chf_balance:to_doc(#{<<"account_id">> => <<"a1">>, <<"total">> => 1000}),
    {ok, D1} = (chf_balance:reserve_fun(<<"s1">>, <<"rg">>, 300, <<"tk1">>))(D0),
    {ok, D2} = (chf_balance:commit_fun(<<"s1">>, -100, <<"c1">>, <<"tk2">>))(D1),
    ?assertEqual(1000, maps:get(<<"total">>, D2)),         %% total never increased
    ?assertEqual(700, chf_balance:available(D2)),          %% hold of 300 unchanged
    ?assert(chf_balance:available(D2) >= 0),
    ?assertMatch(#{<<"s1">> := #{<<"amount">> := 300}}, maps:get(<<"reservations">>, D2)),
    ?assertMatch([#{<<"cdr_id">> := <<"c1">>, <<"used">> := 0}], maps:get(<<"pending_cdrs">>, D2)).

%% two sessions cannot jointly reserve more than total: the second aborts
reserve_two_sessions_cannot_exceed_total(_) ->
    D0 = chf_balance:to_doc(#{<<"account_id">> => <<"a1">>, <<"total">> => 1000}),
    {ok, D1} = (chf_balance:reserve_fun(<<"s1">>, <<"rg">>, 700, <<"tk1">>))(D0),
    ?assertEqual(300, chf_balance:available(D1)),
    ?assertEqual({abort, insufficient_balance},
                 (chf_balance:reserve_fun(<<"s2">>, <<"rg">>, 700, <<"tk2">>))(D1)).
