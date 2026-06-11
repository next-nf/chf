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

-module(chf_db_session_SUITE).
-compile(export_all).

-include_lib("eunit/include/eunit.hrl").
-include_lib("common_test/include/ct.hrl").
-include_lib("chf_db/include/chf_db.hrl").

all() ->
    [txn_commit_persists,
     txn_abort_does_not_persist,
     txn_sees_current_record,
     subscriber_create_rejects_duplicate].

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

mk_session(Id) ->
    #charging_session{session_id = Id, imsi = <<"001">>, type = online,
                      state = active, granted_units = #{}, used_units = #{},
                      created_at = 0, updated_at = 0}.

txn_commit_persists(_) ->
    S = mk_session(<<"s1">>),
    Res = chf_db:session_transaction(<<"s1">>,
            fun(undefined) -> {commit, S, created} end),
    ?assertEqual(created, Res),
    ?assertMatch({ok, #charging_session{session_id = <<"s1">>}},
                 chf_db:session_lookup(<<"s1">>)).

txn_abort_does_not_persist(_) ->
    Res = chf_db:session_transaction(<<"s2">>,
            fun(undefined) -> {abort, nope} end),
    ?assertEqual({error, nope}, Res),
    ?assertEqual({error, not_found}, chf_db:session_lookup(<<"s2">>)).

txn_sees_current_record(_) ->
    ok = chf_db:session_store(mk_session(<<"s3">>)),
    Res = chf_db:session_transaction(<<"s3">>,
            fun(#charging_session{state = active}) -> {result, was_active};
               (_) -> {result, other}
            end),
    ?assertEqual(was_active, Res).

subscriber_create_rejects_duplicate(_) ->
    Sub = #subscriber{imsi = <<"001">>, msisdn = <<"49">>, account_id = <<"a">>,
                      status = active, rating_groups = #{},
                      created_at = 0, updated_at = 0},
    ?assertEqual(ok, chf_db:subscriber_create(Sub)),
    ?assertEqual({error, already_exists}, chf_db:subscriber_create(Sub)).
