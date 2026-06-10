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

-module(chf_db_balance_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").
-include_lib("chf_db/include/chf_db.hrl").

all() ->
    [reserve_insufficient_returns_error,
     reserve_missing_account_returns_error,
     commit_never_exceeds_reserved,
     refund_never_exceeds_reserved,
     invariant_holds_after_ops].

init_per_testcase(_TC, Config) ->
    setup_mnesia(),
    Config.

end_per_testcase(_TC, _Config) ->
    mnesia:stop(),
    ok.

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

seed_balance(AccountId, Total, Reserved) ->
    B = #balance{account_id = AccountId, total = Total,
                 reserved = Reserved, available = Total - Reserved},
    {atomic, ok} = mnesia:transaction(fun() -> mnesia:write(B) end),
    ok.

reserve_insufficient_returns_error(_) ->
    ok = seed_balance(<<"acc">>, 100, 0),
    ?assertEqual({error, insufficient_balance},
                 chf_db:balance_reserve(<<"acc">>, 500)).

reserve_missing_account_returns_error(_) ->
    ?assertEqual({error, not_found},
                 chf_db:balance_reserve(<<"missing">>, 1)).

commit_never_exceeds_reserved(_) ->
    ok = seed_balance(<<"acc">>, 100, 50),
    {ok, B} = chf_db:balance_commit(<<"acc">>, 80),
    ?assertEqual(50, B#balance.total),
    ?assertEqual(0, B#balance.reserved),
    ?assertEqual(50, B#balance.available).

refund_never_exceeds_reserved(_) ->
    ok = seed_balance(<<"acc">>, 100, 10),
    {ok, B} = chf_db:balance_refund(<<"acc">>, 50),
    ?assertEqual(100, B#balance.total),
    ?assertEqual(0, B#balance.reserved),
    ?assertEqual(100, B#balance.available).

invariant_holds_after_ops(_) ->
    ok = seed_balance(<<"acc">>, 1000, 0),
    {ok, _} = chf_db:balance_reserve(<<"acc">>, 400),
    {ok, _} = chf_db:balance_commit(<<"acc">>, 100),
    {ok, B} = chf_db:balance_refund(<<"acc">>, 300),
    ?assertEqual(B#balance.available, B#balance.total - B#balance.reserved),
    true = B#balance.total >= 0,
    true = B#balance.reserved >= 0,
    true = B#balance.available >= 0.
