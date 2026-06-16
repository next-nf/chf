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
    balance_reserve_up_to/2,
    balance_commit/2,
    balance_refund/2,
    balance_set_total/2,
    cdr_write/1,
    cdr_list/1,
    session_store/1,
    session_lookup/1,
    session_delete/1,
    session_list_active/0,
    session_transaction/2
]).

%% cdr_list/1 and session_list_active/0 build Mnesia match-object patterns by
%% assigning the wildcard atom '_' to typed record fields (e.g. used_units,
%% timestamp, state). That is the idiomatic Mnesia query form and is correct at
%% runtime, but it violates the records' static field types, which dialyzer
%% (rightly, for ordinary construction) flags — and the resulting none() return
%% then cascades into a spurious "no local return". Suppress these two.
-dialyzer({nowarn_function, [cdr_list/1, session_list_active/0]}).

%%====================================================================
%% Backend API — init/1
%%====================================================================

-spec init(Opts :: map()) -> ok | {error, term()}.
init(_Opts) ->
    %% Find reachable cluster peers.  We ping here so that a node that is
    %% configured but not yet up is simply skipped (it will join later via its
    %% own init call or a Mnesia reconnect).
    %%
    %% KNOWN LIMITATION — split-brain on simultaneous cold start: the seed/join
    %% decision below gates on Erlang VM reachability (net_adm:ping), not on
    %% whether the peer's Mnesia is already running.  If every node in a fresh
    %% cluster cold-starts at the same instant, two nodes can each see the
    %% other's VM yet reach change_config/2 before the other's Mnesia exists,
    %% and each then seeds its own disjoint single-node schema (permanently
    %% diverged data).  Production boot MUST therefore be ordered: bring up one
    %% seed node and wait for its Mnesia to be healthy before starting the
    %% rest.  Automatic seed election / quorum is a later (Phase 2) task.
    Others = [N || N <- chf_cluster:cluster_nodes(),
                   N =/= node(),
                   pong =:= net_adm:ping(N)],
    %% Mnesia schema must be created before mnesia:start().
    %% Stop mnesia if it is running, then:
    %%   * No reachable peers → create a single-node schema (seed node).
    %%   * Reachable peers   → skip local schema creation; we will merge via
    %%                         change_config(extra_db_nodes, …) after start.
    _ = application:stop(mnesia),
    case Others of
        [] ->
            case mnesia:create_schema([node()]) of
                ok                            -> ok;
                {error, {_, {already_exists, _}}} -> ok;
                {error, SchemaErr}            -> error({schema, SchemaErr})
            end;
        _ ->
            ok
    end,
    ok = application:ensure_started(mnesia),
    %% If we found peers, merge their schema into this node and switch the
    %% local schema copy to disc so that table definitions survive restarts.
    case Others of
        [] -> ok;
        _  ->
            {ok, _MergedFrom} = mnesia:change_config(extra_db_nodes, Others),
            %% Make the local schema disc-resident.  On a fresh join this is a
            %% ram→disc conversion ({atomic, ok}); on restart with a pre-existing
            %% disc schema it is already disc_copies ({aborted, already_exists}).
            %% Anything else (e.g. disc full, permission denied) is a real fault
            %% that must not be swallowed — fail loudly so we never build tables
            %% on top of an inconsistent schema.
            case mnesia:change_table_copy_type(schema, node(), disc_copies) of
                {atomic, ok}                                       -> ok;
                {aborted, {already_exists, schema, _, disc_copies}} -> ok;
                {aborted, TypeErr} -> error({schema_copy_type, TypeErr})
            end
    end,
    ok = ensure_table(subscriber, record_info(fields, subscriber),
                      [{index, [#subscriber.msisdn]}]),
    ok = ensure_table(balance,    record_info(fields, balance),    []),
    ok = ensure_table(cdr,        record_info(fields, cdr),        []),
    ok = ensure_table(charging_session, record_info(fields, charging_session), []),
    ok = mnesia:wait_for_tables([subscriber, balance, cdr, charging_session], 30000).

%%--------------------------------------------------------------------
%% Internal helper — create table on first node or add local disc_copies
%% replica when the table was already created by another cluster member.
%%--------------------------------------------------------------------
-spec ensure_table(atom(), [atom()], list()) -> ok.
ensure_table(Name, Fields, ExtraOpts) ->
    BaseOpts = [{attributes, Fields}, {disc_copies, [node()]} | ExtraOpts],
    case mnesia:create_table(Name, BaseOpts) of
        {atomic, ok} ->
            ok;
        {aborted, {already_exists, Name}} ->
            %% Table exists (created by another node).  Add this node as a
            %% disc_copies replica so transactions are distributed here too.
            case mnesia:add_table_copy(Name, node(), disc_copies) of
                {atomic, ok}                         -> ok;
                {aborted, {already_exists, Name, _}} -> ok;
                {aborted, AddErr}                    -> error({add_table_copy, Name, AddErr})
            end;
        {aborted, Reason} ->
            error({create_table_failed, Name, Reason})
    end.

%%====================================================================
%% Subscriber CRUD
%%====================================================================

-spec subscriber_create(#subscriber{}) -> ok | {error, term()}.
subscriber_create(#subscriber{imsi = Imsi} = Sub) ->
    F = fun() ->
        case mnesia:read(subscriber, Imsi, write) of
            [_] -> mnesia:abort(already_exists);
            []  -> mnesia:write(Sub)
        end
    end,
    case activity(F) of
        ok               -> ok;
        {error, _} = Err -> Err
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
%% A negative top-up would silently destroy balance (reduce total/available with
%% no compensating operation). Reject it. Zero is allowed: subscriber creation
%% calls balance_topup(_, 0) to materialise an empty balance row.
balance_topup(_AccountId, Amount) when Amount < 0 ->
    {error, invalid_amount};
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
%% A negative reservation would pass the `Avail < Amount` check and *decrease*
%% reserved (a stealth refund that raises available). Reject it.
balance_reserve(_AccountId, Amount) when Amount < 0 ->
    {error, invalid_amount};
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

-spec balance_reserve_up_to(AccountId :: binary(), Amount :: integer()) ->
    {ok, non_neg_integer(), #balance{}} | {error, term()}.
%% A negative amount is invalid — reject it immediately.
balance_reserve_up_to(_AccountId, Amount) when Amount < 0 ->
    {error, invalid_amount};
balance_reserve_up_to(AccountId, Amount) ->
    F = fun() ->
        case mnesia:read(balance, AccountId, write) of
            [] ->
                mnesia:abort(not_found);
            [#balance{available = Avail} = B0] ->
                Granted     = min(Amount, max(0, Avail)),
                NewReserved = B0#balance.reserved + Granted,
                B1 = B0#balance{reserved  = NewReserved,
                                available = B0#balance.total - NewReserved},
                ok = mnesia:write(B1),
                {Granted, B1}
        end
    end,
    case activity(F) of
        {Granted, #balance{} = B1} -> {ok, Granted, B1};
        {error, _} = Err           -> Err
    end.

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

-spec cdr_list(Filters :: map()) -> {ok, [#cdr{}]} | {error, term()}.
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

-spec session_transaction(SessionId :: binary(), Fun :: fun()) ->
    term() | {error, term()}.
session_transaction(SessionId, Fun) ->
    F = fun() ->
        Current = case mnesia:read(charging_session, SessionId, write) of
            [#charging_session{} = S] -> S;
            []                        -> undefined
        end,
        case Fun(Current) of
            {commit, #charging_session{} = New, Result} ->
                ok = mnesia:write(New),
                Result;
            {result, Result} ->
                Result;
            {abort, Reason} ->
                mnesia:abort({chf_session_abort, Reason})
        end
    end,
    activity(F).
