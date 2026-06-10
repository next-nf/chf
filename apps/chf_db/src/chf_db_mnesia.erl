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

%% chf_db_mnesia.erl — Mnesia backend implementation for chf_db
-module(chf_db_mnesia).
-behaviour(chf_db_backend).

-include_lib("chf_db/include/chf_db.hrl").

-export([
    init/1,
    subscriber_create/1,
    subscriber_lookup/1,
    subscriber_update/1,
    subscriber_delete/1,
    balance_get/1,
    balance_topup/2,
    balance_reserve/2,
    balance_commit/2,
    balance_refund/2,
    balance_set_total/2,
    cdr_write/1,
    cdr_list/1,
    session_store/1,
    session_lookup/1,
    session_delete/1,
    session_list_active/0
]).

%%====================================================================
%% Backend API — init/1
%%====================================================================

-spec init(Opts :: map()) -> ok | {error, term()}.
init(_Opts) ->
    %% Mnesia schema must be created before mnesia:start().
    %% Stop mnesia if it happens to be running, create schema, then start.
    _ = application:stop(mnesia),
    case mnesia:create_schema([node()]) of
        ok               -> ok;
        {error, {_, {already_exists, _}}} -> ok;
        {error, SchemaErr} -> error({schema, SchemaErr})
    end,
    ok = application:ensure_started(mnesia),
    ok = ensure_table(subscriber, record_info(fields, subscriber), disc_copies,
                      [{index, [#subscriber.msisdn]}]),
    ok = ensure_table(balance,    record_info(fields, balance),    disc_copies, []),
    ok = ensure_table(cdr,        record_info(fields, cdr),        disc_copies, []),
    ok = ensure_table(charging_session, record_info(fields, charging_session), disc_copies, []),
    ok = mnesia:wait_for_tables([subscriber, balance, cdr, charging_session], 30000).

%%--------------------------------------------------------------------
%% Internal helper — create table if it does not already exist.
%%--------------------------------------------------------------------
-spec ensure_table(atom(), [atom()], disc_copies | ram_copies, list()) -> ok.
ensure_table(Name, Fields, StorageType, ExtraOpts) ->
    BaseOpts = [
        {attributes, Fields},
        {StorageType, [node()]}
        | ExtraOpts
    ],
    case mnesia:create_table(Name, BaseOpts) of
        {atomic, ok}                        -> ok;
        {aborted, {already_exists, Name}}   -> ok;
        {aborted, Reason}                   -> error({create_table_failed, Name, Reason})
    end.

%%====================================================================
%% Subscriber CRUD
%%====================================================================

-spec subscriber_create(#subscriber{}) -> ok | {error, term()}.
subscriber_create(#subscriber{} = Sub) ->
    F = fun() -> mnesia:write(Sub) end,
    case mnesia:activity(transaction, F) of
        ok -> ok;
        {error, _} = Err -> Err;
        Aborted -> {error, Aborted}
    end.

-spec subscriber_lookup(Imsi :: binary()) -> {ok, #subscriber{}} | {error, not_found}.
subscriber_lookup(Imsi) ->
    case activity(fun() -> mnesia:read(subscriber, Imsi) end) of
        [#subscriber{} = Sub] -> {ok, Sub};
        []                    -> {error, not_found};
        {error, _} = Err      -> Err
    end.

-spec subscriber_update(#subscriber{}) -> ok | {error, term()}.
subscriber_update(#subscriber{} = Sub) ->
    case activity(fun() -> mnesia:write(Sub) end) of
        ok               -> ok;
        {error, _} = Err -> Err
    end.

-spec subscriber_delete(Imsi :: binary()) -> ok | {error, term()}.
subscriber_delete(Imsi) ->
    case activity(fun() -> mnesia:delete({subscriber, Imsi}) end) of
        ok               -> ok;
        {error, _} = Err -> Err
    end.

%%====================================================================
%% Balance operations
%%====================================================================

-spec balance_get(AccountId :: binary()) -> {ok, #balance{}} | {error, not_found}.
balance_get(AccountId) ->
    case activity(fun() -> mnesia:read(balance, AccountId) end) of
        [#balance{} = B] -> {ok, B};
        []               -> {error, not_found};
        {error, _} = Err -> Err
    end.

-spec balance_topup(AccountId :: binary(), Amount :: integer()) ->
    {ok, #balance{}} | {error, term()}.
balance_topup(AccountId, Amount) ->
    F = fun() ->
        B0 = case mnesia:read(balance, AccountId, write) of
            [Existing] -> Existing;
            []         -> #balance{account_id = AccountId,
                                   total = 0, reserved = 0, available = 0}
        end,
        NewTotal = B0#balance.total + Amount,
        B1 = B0#balance{total     = NewTotal,
                        available = NewTotal - B0#balance.reserved},
        ok = mnesia:write(B1),
        B1
    end,
    run_balance_txn(F).

-spec balance_reserve(AccountId :: binary(), Amount :: integer()) ->
    {ok, #balance{}} | {error, term()}.
balance_reserve(AccountId, Amount) ->
    F = fun() ->
        case mnesia:read(balance, AccountId, write) of
            [] ->
                mnesia:abort(not_found);
            [#balance{available = Avail}] when Avail < Amount ->
                mnesia:abort(insufficient_balance);
            [#balance{} = B0] ->
                NewReserved = B0#balance.reserved + Amount,
                B1 = B0#balance{reserved  = NewReserved,
                                available = B0#balance.total - NewReserved},
                ok = mnesia:write(B1),
                B1
        end
    end,
    run_balance_txn(F).

-spec balance_commit(AccountId :: binary(), Amount :: integer()) ->
    {ok, #balance{}} | {error, term()}.
balance_commit(AccountId, Amount) ->
    F = fun() ->
        case mnesia:read(balance, AccountId, write) of
            [] ->
                mnesia:abort(not_found);
            [#balance{} = B0] ->
                %% Never commit more than is reserved.
                Commit      = min(max(0, Amount), B0#balance.reserved),
                NewReserved = B0#balance.reserved - Commit,
                NewTotal    = B0#balance.total    - Commit,
                B1 = B0#balance{total     = NewTotal,
                                reserved  = NewReserved,
                                available = NewTotal - NewReserved},
                ok = mnesia:write(B1),
                B1
        end
    end,
    run_balance_txn(F).

-spec balance_refund(AccountId :: binary(), Amount :: integer()) ->
    {ok, #balance{}} | {error, term()}.
balance_refund(AccountId, Amount) ->
    F = fun() ->
        case mnesia:read(balance, AccountId, write) of
            [] ->
                mnesia:abort(not_found);
            [#balance{} = B0] ->
                %% Never refund more than is reserved.
                Refund      = min(max(0, Amount), B0#balance.reserved),
                NewReserved = B0#balance.reserved - Refund,
                B1 = B0#balance{reserved  = NewReserved,
                                available = B0#balance.total - NewReserved},
                ok = mnesia:write(B1),
                B1
        end
    end,
    run_balance_txn(F).

-spec balance_set_total(AccountId :: binary(), NewTotal :: integer()) ->
    {ok, #balance{}} | {error, term()}.
balance_set_total(AccountId, NewTotal) ->
    F = fun() ->
        Reserved = case mnesia:read(balance, AccountId, write) of
            [#balance{reserved = R}] -> R;
            []                       -> 0
        end,
        case NewTotal < Reserved of
            true ->
                mnesia:abort(total_below_reserved);
            false ->
                B1 = #balance{account_id = AccountId,
                              total      = NewTotal,
                              reserved   = Reserved,
                              available  = NewTotal - Reserved},
                ok = mnesia:write(B1),
                B1
        end
    end,
    run_balance_txn(F).

%%--------------------------------------------------------------------
%% Internal — run a balance transaction, normalising the result.
%%--------------------------------------------------------------------
-spec run_balance_txn(fun()) -> {ok, #balance{}} | {error, term()}.
run_balance_txn(F) ->
    case activity(F) of
        #balance{} = B   -> {ok, B};
        {error, _} = Err -> Err
    end.

%% Run a Mnesia activity, converting an abort exit into {error, Reason}.
%% mnesia:activity/2 returns the fun's value on success and EXITS with
%% {aborted, Reason} on abort, so callers must catch the exit here.
-spec activity(fun()) -> term() | {error, term()}.
activity(F) ->
    try mnesia:activity(transaction, F)
    catch
        exit:{aborted, {chf_session_abort, Reason}} -> {error, Reason};
        exit:{aborted, Reason}                      -> {error, Reason}
    end.

%%====================================================================
%% CDR operations
%%====================================================================

-spec cdr_write(#cdr{}) -> ok | {error, term()}.
cdr_write(#cdr{} = Cdr) ->
    case activity(fun() -> mnesia:write(Cdr) end) of
        ok               -> ok;
        {error, _} = Err -> Err
    end.

-spec cdr_list(Filters :: map()) -> {ok, [#cdr{}]}.
cdr_list(Filters) ->
    %% Build a match-spec pattern from the Filters map.
    %% Supported filter keys: session_id, imsi, type, rating_group.
    Pattern = #cdr{
        id           = maps:get(id,           Filters, '_'),
        session_id   = maps:get(session_id,   Filters, '_'),
        imsi         = maps:get(imsi,         Filters, '_'),
        type         = maps:get(type,         Filters, '_'),
        rating_group = maps:get(rating_group, Filters, '_'),
        used_units   = '_',
        timestamp    = '_',
        metadata     = '_'
    },
    case activity(fun() -> mnesia:match_object(Pattern) end) of
        Cdrs when is_list(Cdrs) -> {ok, Cdrs};
        {error, _} = Err        -> Err
    end.

%%====================================================================
%% Session persistence
%%====================================================================

-spec session_store(#charging_session{}) -> ok | {error, term()}.
session_store(#charging_session{} = Session) ->
    case activity(fun() -> mnesia:write(Session) end) of
        ok               -> ok;
        {error, _} = Err -> Err
    end.

-spec session_lookup(SessionId :: binary()) ->
    {ok, #charging_session{}} | {error, not_found}.
session_lookup(SessionId) ->
    case activity(fun() -> mnesia:read(charging_session, SessionId) end) of
        [#charging_session{} = S] -> {ok, S};
        []                        -> {error, not_found};
        {error, _} = Err          -> Err
    end.

-spec session_delete(SessionId :: binary()) -> ok | {error, term()}.
session_delete(SessionId) ->
    case activity(fun() -> mnesia:delete({charging_session, SessionId}) end) of
        ok               -> ok;
        {error, _} = Err -> Err
    end.

-spec session_list_active() -> {ok, [#charging_session{}]} | {error, term()}.
session_list_active() ->
    Pattern = #charging_session{state = active, _ = '_'},
    case activity(fun() -> mnesia:match_object(Pattern) end) of
        L when is_list(L)  -> {ok, L};
        {error, _} = Err   -> Err
    end.
