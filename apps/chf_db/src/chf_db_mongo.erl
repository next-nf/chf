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

%% chf_db_mongo.erl — MongoDB backend for chf_db, implementing the
%% chf_db_backend behaviour (all 23 callbacks).
%%
%% NOTE: The -behaviour(chf_db_backend) declaration was removed in Task 1
%% of the data-layer migration (branch e3-chf-data-layer-mnesia).  The
%% chf_db_backend behaviour was replaced with the 11-callback generic contract;
%% chf_db_mongo will be ported to the new contract in a later task.
%%
%% Connection ownership and supervision
%% -------------------------------------
%% mongoc:connect/3 calls mc_topology:start_link internally, which links the
%% topology gen_server to the calling process.  To prevent the topology from
%% dying when the short-lived init/1 caller exits, the connection is owned by
%% chf_db_mongo_conn (a gen_server registered as chf_db_mongo_conn).
%%
%% In a production node chf_db_mongo_conn is a supervised child of chf_db_sup
%% (added only when the configured backend is chf_db_mongo).  If the topology
%% gen_server crashes, chf_db_mongo_conn receives the EXIT signal (it traps
%% exits), returns {stop, topology_down, ...} and the supervisor restarts it;
%% the new instance calls mongoc:connect/3 to re-establish the connection.
%%
%% init/1 delegates to chf_db_mongo_conn:ensure_started/0, which is idempotent:
%%   • In production (gen_server already alive from the supervisor): a no-op
%%     re-run of ensure_indexes so per-testcase collection drops get fresh indexes.
%%   • In tests (no supervisor): starts the gen_server as a standalone process.
-module(chf_db_mongo).

-include_lib("chf_db/include/chf_db.hrl").

-export([
    init/1,
    topology/0,
    ensure_indexes/1,
    %% Subscriber
    subscriber_create/1,
    subscriber_lookup/1,
    subscriber_update/1,
    subscriber_delete/1,
    %% Balance — standalone (no transaction context)
    balance_get/1,
    balance_topup/2,
    balance_reserve/2,
    balance_reserve_up_to/2,
    balance_commit/2,
    balance_refund/2,
    balance_set_total/2,
    %% Balance — Ctx-aware (inside a session_transaction)
    balance_reserve_up_to/3,
    balance_commit/3,
    balance_refund/3,
    %% Session
    session_store/1,
    session_lookup/1,
    session_delete/1,
    session_list_active/0,
    session_transaction/2,
    %% CDR — standalone
    cdr_write/1,
    cdr_list/1,
    %% CDR — Ctx-aware
    cdr_write/2
]).

%%====================================================================
%% Collection names
%%====================================================================

-define(SUBSCRIBERS,       <<"subscribers">>).
-define(BALANCES,          <<"balances">>).
-define(CDRS,              <<"cdrs">>).
-define(CHARGING_SESSIONS, <<"charging_sessions">>).

%%====================================================================
%% Public API — init / topology
%%====================================================================

%% init/1 — Ensure the supervised MongoDB connection gen_server is running
%% and indexes exist.
%%
%% In a production node chf_db_mongo_conn is already alive (started by
%% chf_db_sup before init/1 is called), so this is an idempotent no-op
%% that re-runs ensure_indexes (useful after per-test-case collection drops).
%%
%% In CT suites that call init/1 directly (without starting the chf_db
%% application), chf_db_mongo_conn:ensure_started/0 starts the gen_server
%% as a standalone process.
-spec init(map()) -> ok | {error, term()}.
init(_Opts) ->
    chf_db_mongo_conn:ensure_started().

%% topology/0 — Return the stored topology handle (pid or registered name).
-spec topology() -> pid() | atom().
topology() ->
    persistent_term:get({chf_db_mongo, topology}).

%%====================================================================
%% Public API — Subscriber CRUD
%%====================================================================

%% subscriber_create/1 — Insert a new subscriber document.
%% Returns {error, already_exists} if the IMSI (_id) is already present.
-spec subscriber_create(#subscriber{}) -> ok | {error, already_exists | term()}.
subscriber_create(Sub) ->
    Doc = chf_db_mongo_codec:from_subscriber(Sub),
    try with_worker(fun(W) ->
        {{_Ok, Res}, _} = mc_worker_api:insert(W, ?SUBSCRIBERS, Doc),
        case maps:get(<<"writeErrors">>, Res, []) of
            [] ->
                ok;
            [#{<<"code">> := 11000} | _] ->
                {error, already_exists};
            [#{<<"code">> := Code} | _] ->
                {error, {write_error, Code}}
        end
    end) of
        {error, _} = Err -> Err;
        ok               -> ok
    catch
        error:{bad_query, #{<<"writeErrors">> := [#{<<"code">> := 11000} | _]}} ->
            {error, already_exists};
        error:{bad_query, Doc2} ->
            {error, {bad_query, Doc2}}
    end.

%% subscriber_lookup/1 — Find a subscriber by IMSI.
-spec subscriber_lookup(binary()) -> {ok, #subscriber{}} | {error, not_found}.
subscriber_lookup(Imsi) ->
    case with_worker(fun(W) ->
        mc_worker_api:find_one(W, ?SUBSCRIBERS, #{<<"_id">> => Imsi})
    end) of
        undefined ->
            {error, not_found};
        Doc when is_map(Doc) ->
            {ok, chf_db_mongo_codec:to_subscriber(Doc)}
    end.

%% subscriber_update/1 — Replace an existing subscriber document entirely.
-spec subscriber_update(#subscriber{}) -> ok | {error, term()}.
subscriber_update(Sub) ->
    Doc = chf_db_mongo_codec:from_subscriber(Sub),
    Imsi = Sub#subscriber.imsi,
    with_worker(fun(W) ->
        {true, _} = mc_worker_api:update(W, ?SUBSCRIBERS,
                                         #{<<"_id">> => Imsi}, Doc,
                                         false, false),
        ok
    end).

%% subscriber_delete/1 — Delete a subscriber by IMSI.
%% Returns ok regardless of whether a document was found (mirrors Mnesia semantics).
-spec subscriber_delete(binary()) -> ok.
subscriber_delete(Imsi) ->
    with_worker(fun(W) ->
        mc_worker_api:delete_one(W, ?SUBSCRIBERS, #{<<"_id">> => Imsi}),
        ok
    end).

%%====================================================================
%% Public API — Balance operations
%%====================================================================

%% balance_get/1 — Return the current balance for an account.
-spec balance_get(binary()) -> {ok, #balance{}} | {error, not_found}.
balance_get(AccountId) ->
    case with_worker(fun(W) ->
        mc_worker_api:find_one(W, ?BALANCES, #{<<"_id">> => AccountId})
    end) of
        undefined -> {error, not_found};
        Doc       -> {ok, chf_db_mongo_codec:to_balance(Doc)}
    end.

%% balance_topup/2 — Add Amount to total; upsert the document if absent.
%% Amount < 0 → {error, invalid_amount}. Amount = 0 on a missing account creates
%% a zero row (mirrors Mnesia). Uses aggregation pipeline so that ifNull handles
%% missing fields on upsert; int64 arithmetic throughout.
-spec balance_topup(binary(), integer()) -> {ok, #balance{}} | {error, invalid_amount}.
balance_topup(_AccountId, Amount) when Amount < 0 ->
    {error, invalid_amount};
balance_topup(AccountId, Amount) ->
    %% Pipeline:
    %%   total     = {$toLong: {$add: [{$ifNull: ["$total",    0]}, Amount]}}
    %%   reserved  = {$toLong: {$ifNull: ["$reserved", 0]}}
    %%   available = {$toLong: {$subtract: ["$total", "$reserved"]}}
    %%
    %% Note: $add / $subtract on int64 fields stays int64 in MongoDB.
    %% $toLong is a belt-and-suspenders guard in case the driver or Mongo
    %% ever coerces small values to int32 — it forces BSON int64 on the way out.
    Pipeline = [
        #{<<"$set">> => #{
            <<"total">>     => #{<<"$toLong">> => #{<<"$add">> => [
                                    #{<<"$ifNull">> => [<<"$total">>, 0]},
                                    Amount]}},
            <<"reserved">>  => #{<<"$toLong">> => #{<<"$ifNull">> => [<<"$reserved">>,  0]}},
            <<"available">> => <<"$$REMOVE">>   %% placeholder; recomputed below
        }},
        #{<<"$set">> => #{
            <<"available">> => #{<<"$toLong">> => #{<<"$subtract">> => [<<"$total">>, <<"$reserved">>]}}
        }}
    ],
    Cmd = {<<"findAndModify">>, ?BALANCES,
           <<"query">>,  #{<<"_id">> => AccountId},
           <<"update">>, Pipeline,
           <<"upsert">>, true,
           <<"new">>,    true},
    {true, Reply} = with_worker(fun(W) -> mc_worker_api:command(W, Cmd) end),
    case fam_value(Reply) of
        no_doc ->
            %% Some MongoDB versions return null for value even on a successful upsert
            %% with new:true (observed with the Erlang driver). Fall back to find_one.
            ExistDoc = with_worker(fun(W) ->
                mc_worker_api:find_one(W, ?BALANCES, #{<<"_id">> => AccountId})
            end),
            {ok, chf_db_mongo_codec:to_balance(ExistDoc)};
        Doc ->
            {ok, chf_db_mongo_codec:to_balance(Doc)}
    end.

%% balance_reserve/2 — All-or-nothing reserve: deduct Amount from available.
%% Amount < 0 → {error, invalid_amount}. Missing doc → {error, not_found}.
%% available < Amount → {error, insufficient_balance}.
-spec balance_reserve(binary(), integer()) ->
    {ok, #balance{}} | {error, not_found | insufficient_balance | invalid_amount}.
balance_reserve(_AccountId, Amount) when Amount < 0 ->
    {error, invalid_amount};
balance_reserve(AccountId, Amount) ->
    %% Query includes "available >= Amount" so the findAndModify only fires
    %% when there is enough balance. On null reply, distinguish not_found vs
    %% insufficient_balance with a follow-up find_one.
    Pipeline = [
        #{<<"$set">> => #{
            <<"reserved">>  => #{<<"$toLong">> => #{<<"$add">>      => [<<"$reserved">>, Amount]}},
            <<"available">> => #{<<"$toLong">> => #{<<"$subtract">> => [<<"$available">>, Amount]}}
        }}
    ],
    Cmd = {<<"findAndModify">>, ?BALANCES,
           <<"query">>,  #{<<"_id">> => AccountId, <<"available">> => #{<<"$gte">> => Amount}},
           <<"update">>, Pipeline,
           <<"new">>,    true},
    {true, Reply} = with_worker(fun(W) -> mc_worker_api:command(W, Cmd) end),
    case fam_value(Reply) of
        no_doc ->
            %% Query didn't match — either doc absent or available < Amount.
            case with_worker(fun(W) ->
                mc_worker_api:find_one(W, ?BALANCES, #{<<"_id">> => AccountId})
            end) of
                undefined -> {error, not_found};
                _Doc      -> {error, insufficient_balance}
            end;
        Doc ->
            {ok, chf_db_mongo_codec:to_balance(Doc)}
    end.

%% balance_reserve_up_to/2 — Best-effort reserve: grant min(Amount, max(0, available)).
%% Amount < 0 → {error, invalid_amount}. Missing doc → {error, not_found}.
-spec balance_reserve_up_to(binary(), integer()) ->
    {ok, non_neg_integer(), #balance{}} | {error, not_found | invalid_amount}.
balance_reserve_up_to(_AccountId, Amount) when Amount < 0 ->
    {error, invalid_amount};
balance_reserve_up_to(AccountId, Amount) ->
    %% Strategy: fetch the BEFORE image (new:false), compute Granted on the
    %% Erlang side, then apply the update. This avoids a second round-trip
    %% while keeping the arithmetic simple and verifiable.
    %%
    %% The pipeline adds $min[Amount, $max[0, $available]] to reserved and
    %% recomputes available = total - reserved. We still need the before-doc
    %% to know the Granted value. We fetch the before image (new:false) and
    %% compute Granted = min(Amount, max(0, Before.available)).
    Pipeline = [
        #{<<"$set">> => #{
            <<"reserved">>  => #{<<"$toLong">> => #{<<"$add">> => [
                                    <<"$reserved">>,
                                    #{<<"$min">> => [Amount,
                                                     #{<<"$max">> => [0, <<"$available">>]}]}
                                    ]}},
            <<"available">> => <<"$$REMOVE">>
        }},
        #{<<"$set">> => #{
            <<"available">> => #{<<"$toLong">> => #{<<"$subtract">> => [<<"$total">>, <<"$reserved">>]}}
        }}
    ],
    Cmd = {<<"findAndModify">>, ?BALANCES,
           <<"query">>,  #{<<"_id">> => AccountId},
           <<"update">>, Pipeline,
           <<"new">>,    false},   %% BEFORE image
    {true, Reply} = with_worker(fun(W) -> mc_worker_api:command(W, Cmd) end),
    case fam_value(Reply) of
        no_doc ->
            {error, not_found};
        BeforeDoc ->
            Before = chf_db_mongo_codec:to_balance(BeforeDoc),
            Granted = min(Amount, max(0, Before#balance.available)),
            NewReserved  = Before#balance.reserved + Granted,
            NewAvailable = Before#balance.total - NewReserved,
            Post = Before#balance{reserved  = NewReserved,
                                  available = NewAvailable},
            {ok, Granted, Post}
    end.

%% balance_commit/2 — Commit up to Amount (clamped to reserved); deduct from
%% both reserved and total. Mirrors Mnesia: never commits more than is reserved.
-spec balance_commit(binary(), integer()) -> {ok, #balance{}} | {error, not_found}.
balance_commit(AccountId, Amount) ->
    %% Commit = min(max(0, Amount), reserved)
    %% new_reserved = reserved - Commit
    %% new_total    = total    - Commit
    %% available    = new_total - new_reserved
    Pipeline = [
        #{<<"$set">> => #{
            <<"_commit">> => #{<<"$min">> => [#{<<"$max">> => [0, Amount]}, <<"$reserved">>]}
        }},
        #{<<"$set">> => #{
            <<"reserved">>  => #{<<"$toLong">> => #{<<"$subtract">> => [<<"$reserved">>, <<"$_commit">>]}},
            <<"total">>     => #{<<"$toLong">> => #{<<"$subtract">> => [<<"$total">>,    <<"$_commit">>]}},
            <<"available">> => <<"$$REMOVE">>
        }},
        #{<<"$set">> => #{
            <<"available">> => #{<<"$toLong">> => #{<<"$subtract">> => [<<"$total">>, <<"$reserved">>]}}
        }},
        #{<<"$unset">> => <<"_commit">>}
    ],
    Cmd = {<<"findAndModify">>, ?BALANCES,
           <<"query">>,  #{<<"_id">> => AccountId},
           <<"update">>, Pipeline,
           <<"new">>,    true},
    {true, Reply} = with_worker(fun(W) -> mc_worker_api:command(W, Cmd) end),
    case fam_value(Reply) of
        no_doc -> {error, not_found};
        Doc    -> {ok, chf_db_mongo_codec:to_balance(Doc)}
    end.

%% balance_refund/2 — Return Amount back from reserved to available (clamped to
%% reserved). Total is unchanged.
-spec balance_refund(binary(), integer()) -> {ok, #balance{}} | {error, not_found}.
balance_refund(AccountId, Amount) ->
    %% Refund = min(max(0, Amount), reserved)
    %% new_reserved = reserved - Refund
    %% available    = total    - new_reserved
    Pipeline = [
        #{<<"$set">> => #{
            <<"_refund">> => #{<<"$min">> => [#{<<"$max">> => [0, Amount]}, <<"$reserved">>]}
        }},
        #{<<"$set">> => #{
            <<"reserved">>  => #{<<"$toLong">> => #{<<"$subtract">> => [<<"$reserved">>, <<"$_refund">>]}},
            <<"available">> => <<"$$REMOVE">>
        }},
        #{<<"$set">> => #{
            <<"available">> => #{<<"$toLong">> => #{<<"$subtract">> => [<<"$total">>, <<"$reserved">>]}}
        }},
        #{<<"$unset">> => <<"_refund">>}
    ],
    Cmd = {<<"findAndModify">>, ?BALANCES,
           <<"query">>,  #{<<"_id">> => AccountId},
           <<"update">>, Pipeline,
           <<"new">>,    true},
    {true, Reply} = with_worker(fun(W) -> mc_worker_api:command(W, Cmd) end),
    case fam_value(Reply) of
        no_doc -> {error, not_found};
        Doc    -> {ok, chf_db_mongo_codec:to_balance(Doc)}
    end.

%% balance_set_total/2 — Set total to an absolute NewTotal, preserving reserved.
%% NewTotal < reserved → {error, total_below_reserved}.
%% Upserts (creates) a fresh account if absent (reserved defaults to 0).
%%
%% Implementation note: we cannot use upsert:true with a query that includes a
%% reserved constraint, because when the doc EXISTS but reserved > NewTotal
%% (query miss), MongoDB will try to INSERT a new doc with the same _id and
%% produce a DuplicateKey error. We therefore use a two-step approach:
%%
%%   Step 1: findAndModify with upsert:false, query _id + reserved<=NewTotal.
%%           Handles the "existing doc, constraint satisfied" fast path.
%%   Step 2 (only on null reply): check whether the doc exists at all.
%%           • Absent → upsert a fresh doc with reserved=0 (always ok if NewTotal>=0).
%%           • Present → reserved > NewTotal → {error, total_below_reserved}.
-spec balance_set_total(binary(), integer()) ->
    {ok, #balance{}} | {error, total_below_reserved}.
balance_set_total(AccountId, NewTotal) ->
    Pipeline = [
        #{<<"$set">> => #{
            %% $toLong so the persisted total is BSON int64 (uniform with the
            %% reserved/available fields below and every other write path),
            %% not int32 for small NewTotal values.
            <<"total">>     => #{<<"$toLong">> => NewTotal},
            <<"reserved">>  => #{<<"$toLong">> => #{<<"$ifNull">> => [<<"$reserved">>, 0]}},
            <<"available">> => <<"$$REMOVE">>
        }},
        #{<<"$set">> => #{
            <<"available">> => #{<<"$toLong">> => #{<<"$subtract">> => [NewTotal, <<"$reserved">>]}}
        }}
    ],
    %% Step 1: Update existing doc if reserved <= NewTotal.
    Cmd1 = {<<"findAndModify">>, ?BALANCES,
            <<"query">>,  #{<<"_id">>      => AccountId,
                            <<"reserved">> => #{<<"$lte">> => NewTotal}},
            <<"update">>, Pipeline,
            <<"new">>,    true},
    {true, Reply1} = with_worker(fun(W) -> mc_worker_api:command(W, Cmd1) end),
    case fam_value(Reply1) of
        no_doc ->
            %% Step 2: Doc not found OR reserved > NewTotal.
            %% Distinguish by checking existence.
            case with_worker(fun(W) ->
                mc_worker_api:find_one(W, ?BALANCES, #{<<"_id">> => AccountId})
            end) of
                undefined ->
                    %% Fresh account: upsert with reserved defaulting to 0.
                    %% Wrap literals in $toLong so the persisted fields are BSON
                    %% int64 from creation (uniform with every other write path),
                    %% rather than int32 for small values.
                    UpsertPipeline = [
                        #{<<"$set">> => #{
                            <<"total">>     => #{<<"$toLong">> => NewTotal},
                            <<"reserved">>  => #{<<"$toLong">> => 0},
                            <<"available">> => #{<<"$toLong">> => NewTotal}
                        }}
                    ],
                    Cmd2 = {<<"findAndModify">>, ?BALANCES,
                            <<"query">>,  #{<<"_id">> => AccountId},
                            <<"update">>, UpsertPipeline,
                            <<"upsert">>, true,
                            <<"new">>,    true},
                    {true, Reply2} = with_worker(fun(W) -> mc_worker_api:command(W, Cmd2) end),
                    case fam_value(Reply2) of
                        no_doc ->
                            %% Upsert with new:true returned null — retrieve via find_one.
                            ExistDoc = with_worker(fun(W) ->
                                mc_worker_api:find_one(W, ?BALANCES, #{<<"_id">> => AccountId})
                            end),
                            {ok, chf_db_mongo_codec:to_balance(ExistDoc)};
                        Doc2 ->
                            {ok, chf_db_mongo_codec:to_balance(Doc2)}
                    end;
                _ExistingDoc ->
                    %% Doc exists but reserved > NewTotal.
                    {error, total_below_reserved}
            end;
        Doc ->
            {ok, chf_db_mongo_codec:to_balance(Doc)}
    end.

%%====================================================================
%% Public API — Session persistence
%%====================================================================

%% session_store/1 — Upsert a charging session (insert or full replace by _id).
-spec session_store(#charging_session{}) -> ok | {error, term()}.
session_store(Session) ->
    Doc = chf_db_mongo_codec:from_session(Session),
    SessionId = Session#charging_session.session_id,
    with_worker(fun(W) ->
        {true, _} = mc_worker_api:update(W, ?CHARGING_SESSIONS,
                                         #{<<"_id">> => SessionId}, Doc,
                                         true, false),
        ok
    end).

%% session_lookup/1 — Find a charging session by SessionId.
-spec session_lookup(binary()) -> {ok, #charging_session{}} | {error, not_found}.
session_lookup(SessionId) ->
    case with_worker(fun(W) ->
        mc_worker_api:find_one(W, ?CHARGING_SESSIONS, #{<<"_id">> => SessionId})
    end) of
        undefined ->
            {error, not_found};
        Doc when is_map(Doc) ->
            {ok, chf_db_mongo_codec:to_session(Doc)}
    end.

%% session_delete/1 — Delete a charging session by SessionId.
%% Returns ok regardless of whether the document existed.
-spec session_delete(binary()) -> ok.
session_delete(SessionId) ->
    with_worker(fun(W) ->
        mc_worker_api:delete_one(W, ?CHARGING_SESSIONS, #{<<"_id">> => SessionId}),
        ok
    end).

%% session_list_active/0 — Return all sessions with state == active.
-spec session_list_active() -> {ok, [#charging_session{}]} | {error, term()}.
session_list_active() ->
    Docs = with_worker(fun(W) ->
        case mc_worker_api:find(W, ?CHARGING_SESSIONS, #{<<"state">> => <<"active">>}) of
            {ok, Cursor} ->
                Res = mc_cursor:rest(Cursor),
                mc_cursor:close(Cursor),
                Res;
            [] ->
                []
        end
    end),
    Sessions = [chf_db_mongo_codec:to_session(D) || D <- Docs],
    {ok, Sessions}.

%%====================================================================
%% Public API — CDR operations
%%====================================================================

%% cdr_write/1 — Insert a CDR document.
-spec cdr_write(#cdr{}) -> ok | {error, term()}.
cdr_write(Cdr) ->
    Doc = chf_db_mongo_codec:from_cdr(Cdr),
    with_worker(fun(W) ->
        {{_Ok, _Res}, _} = mc_worker_api:insert(W, ?CDRS, Doc),
        ok
    end).

%% cdr_list/1 — List CDRs matching the given filter map.
%% Supported filter keys: session_id, imsi, type, rating_group.
%% Unknown keys are silently ignored.
-spec cdr_list(map()) -> {ok, [#cdr{}]}.
cdr_list(Filters) ->
    Selector = build_cdr_selector(Filters),
    Docs = with_worker(fun(W) ->
        case mc_worker_api:find(W, ?CDRS, Selector) of
            {ok, Cursor} ->
                Res = mc_cursor:rest(Cursor),
                mc_cursor:close(Cursor),
                Res;
            [] ->
                []
        end
    end),
    Cdrs = [chf_db_mongo_codec:to_cdr(D) || D <- Docs],
    {ok, Cdrs}.

%%====================================================================
%% Public API — MongoDB multi-document transactions
%%====================================================================

%% session_transaction/2 — Execute Fun inside a MongoDB multi-document
%% transaction, holding a single poolboy worker (same TCP connection) for the
%% entire duration so all commands share the same session.
%%
%% Protocol:
%%   1. Check out ONE poolboy worker via mc_topology:get_pool + poolboy:transaction.
%%   2. startSession → Lsid; TxnNumber = 2147483648 (int64 territory).
%%   3. Read the charging_session document for SessionId WITH startTransaction:true
%%      (this opens the transaction; the read is the first op in the txn).
%%   4. Build Ctx = #{worker, lsid, txn} and call Fun(Ctx, Session).
%%   5. On {commit, NewSession, Result}: write NewSession doc with the txn, then
%%      commitTransaction → return Result.
%%      On {result, Result}: commit without a session write → return Result.
%%      On {abort, Reason}: abortTransaction → return {error, Reason}.
%%   6. Bounded retry (up to 3 attempts) on transient transaction errors
%%      (<<"TransientTransactionError">> or <<"UnknownTransactionCommitResult">>
%%      in the errorLabels of a failed command reply).
%%
%% Ctx threading model: the Ctx map carries the worker pid, lsid, and
%% txnNumber. Ctx-aware ops (balance_reserve_up_to/3, balance_commit/3,
%% balance_refund/3, cdr_write/2) attach the session fields to each command
%% WITHOUT startTransaction (the first session read already started it).
-define(TXN_NUMBER, 2147483648).   %% > 2^31-1 → BSON int64
-define(TXN_RETRIES, 3).

-type session_ctx() :: #{worker   => pid(),
                         lsid     => map(),
                         txn      => integer()}.

-spec session_transaction(binary(), fun((session_ctx(), #charging_session{} | undefined) ->
    {commit, #charging_session{}, term()} |
    {result, term()} |
    {abort, term()})) ->
    term() | {error, term()}.
session_transaction(SessionId, Fun) ->
    do_session_transaction(SessionId, Fun, ?TXN_RETRIES).

do_session_transaction(_SessionId, _Fun, 0) ->
    {error, transaction_retries_exhausted};
do_session_transaction(SessionId, Fun, RetriesLeft) ->
    {ok, #{pool := PoolPid}} = mc_topology:get_pool(topology(), []),
    try poolboy:transaction(PoolPid, fun(W) ->
        %% Step 1: Start a Mongo server session. Session-management commands
        %% target the admin database (uniform with commit/abort below).
        {true, SessReply} = mc_worker_api:command(<<"admin">>, W, {<<"startSession">>, 1}),
        IdVal = maps:get(<<"id">>, SessReply),
        Lsid  = #{<<"id">> => extract_lsid(IdVal)},
        TxnNumber = ?TXN_NUMBER,

        %% Step 2: Open the transaction by reading the session doc with
        %% startTransaction:true on this first command.
        Session = txn_find_session(W, Lsid, TxnNumber, SessionId),

        %% Step 3: Build the Ctx for Ctx-aware ops (subsequent ops, no startTransaction).
        Ctx = #{worker => W, lsid => Lsid, txn => TxnNumber},

        %% Step 4: Call the user-supplied Fun.
        FunResult = case Fun(Ctx, Session) of
            {commit, NewSession, Result} ->
                %% Write the session doc inside the transaction.
                Doc = chf_db_mongo_codec:from_session(NewSession),
                SessionIdKey = NewSession#charging_session.session_id,
                txn_upsert_session(W, Lsid, TxnNumber, SessionIdKey, Doc),
                commit_txn(W, Lsid, TxnNumber),
                Result;
            {result, R} ->
                commit_txn(W, Lsid, TxnNumber),
                R;
            {abort, Reason} ->
                abort_txn(W, Lsid, TxnNumber),
                {error, Reason}
        end,
        %% Step 5: Best-effort endSessions so the server session is released
        %% immediately rather than accumulating until the 30-minute timeout.
        _ = (catch mc_worker_api:command(<<"admin">>, W, {<<"endSessions">>, [Lsid]})),
        FunResult
    end, 30000)
    catch
        error:ExcReason ->
            %% The mongodb-erlang driver may surface transient transaction errors
            %% in several wrapping forms:
            %%   error:{bad_query, #{<<"errorLabels">> := Labels}}
            %%   error:{error, {op_msg_response, #{<<"errorLabels">> := Labels}}}
            %%   error:{op_msg_response, #{<<"errorLabels">> := Labels}}
            %% Rather than pattern-matching on the exact wrapping, extract
            %% errorLabels from any map found anywhere in the exception reason and
            %% decide based on the label values.
            case extract_error_labels(ExcReason) of
                Labels when is_list(Labels) ->
                    case lists:member(<<"TransientTransactionError">>, Labels)
                        orelse lists:member(<<"UnknownTransactionCommitResult">>, Labels) of
                        true  -> do_session_transaction(SessionId, Fun, RetriesLeft - 1);
                        false -> {error, {mongo_error, Labels}}
                    end;
                not_found ->
                    {error, ExcReason}
            end
    end.

%%====================================================================
%% Public API — Ctx-aware balance operations (inside a transaction)
%%====================================================================

%% balance_reserve_up_to/3 — Best-effort reserve inside a running transaction.
%% Reads the balance doc with the txn, computes Granted in Erlang, writes back.
%% Returns {ok, Granted, #balance{}} | {error, not_found | invalid_amount}.
%% Does NOT abort the transaction — caller decides on error.
-spec balance_reserve_up_to(session_ctx(), binary(), integer()) ->
    {ok, non_neg_integer(), #balance{}} | {error, not_found | invalid_amount}.
balance_reserve_up_to(_Ctx, _AccountId, Amount) when Amount < 0 ->
    {error, invalid_amount};
balance_reserve_up_to(#{worker := W, lsid := Lsid, txn := TxnNumber},
                       AccountId, Amount) ->
    %% Read current balance doc inside the transaction.
    case txn_find_one(W, Lsid, TxnNumber, ?BALANCES, #{<<"_id">> => AccountId}) of
        undefined ->
            {error, not_found};
        Doc ->
            Before = chf_db_mongo_codec:to_balance(Doc),
            {Granted, NewReserved, NewAvailable} =
                compute_reserve_up_to(Before, Amount),
            NewDoc = Doc#{
                <<"reserved">>  => NewReserved,
                <<"available">> => NewAvailable
            },
            txn_replace(W, Lsid, TxnNumber, ?BALANCES, AccountId, NewDoc),
            Post = Before#balance{reserved  = NewReserved,
                                  available = NewAvailable},
            {ok, Granted, Post}
    end.

%% balance_commit/3 — Commit up to Amount inside a running transaction.
%% Reads, computes in Erlang, writes back.
%% Returns {ok, #balance{}} | {error, not_found}.
-spec balance_commit(session_ctx(), binary(), integer()) ->
    {ok, #balance{}} | {error, not_found}.
balance_commit(#{worker := W, lsid := Lsid, txn := TxnNumber},
               AccountId, Amount) ->
    case txn_find_one(W, Lsid, TxnNumber, ?BALANCES, #{<<"_id">> => AccountId}) of
        undefined ->
            {error, not_found};
        Doc ->
            Before = chf_db_mongo_codec:to_balance(Doc),
            {NewTotal, NewReserved, NewAvailable} =
                compute_commit(Before, Amount),
            NewDoc = Doc#{
                <<"total">>     => NewTotal,
                <<"reserved">>  => NewReserved,
                <<"available">> => NewAvailable
            },
            txn_replace(W, Lsid, TxnNumber, ?BALANCES, AccountId, NewDoc),
            Post = Before#balance{total     = NewTotal,
                                  reserved  = NewReserved,
                                  available = NewAvailable},
            {ok, Post}
    end.

%% balance_refund/3 — Refund up to Amount inside a running transaction.
%% Returns {ok, #balance{}} | {error, not_found}.
-spec balance_refund(session_ctx(), binary(), integer()) ->
    {ok, #balance{}} | {error, not_found}.
balance_refund(#{worker := W, lsid := Lsid, txn := TxnNumber},
               AccountId, Amount) ->
    case txn_find_one(W, Lsid, TxnNumber, ?BALANCES, #{<<"_id">> => AccountId}) of
        undefined ->
            {error, not_found};
        Doc ->
            Before = chf_db_mongo_codec:to_balance(Doc),
            {NewReserved, NewAvailable} = compute_refund(Before, Amount),
            NewDoc = Doc#{
                <<"reserved">>  => NewReserved,
                <<"available">> => NewAvailable
            },
            txn_replace(W, Lsid, TxnNumber, ?BALANCES, AccountId, NewDoc),
            Post = Before#balance{reserved  = NewReserved,
                                  available = NewAvailable},
            {ok, Post}
    end.

%%====================================================================
%% Public API — Ctx-aware CDR operations (inside a transaction)
%%====================================================================

%% cdr_write/2 — Insert a CDR document inside a running transaction.
-spec cdr_write(session_ctx(), #cdr{}) -> ok | {error, term()}.
cdr_write(#{worker := W, lsid := Lsid, txn := TxnNumber}, Cdr) ->
    Doc = chf_db_mongo_codec:from_cdr(Cdr),
    Cmd = {<<"insert">>,    ?CDRS,
           <<"documents">>, [Doc],
           <<"lsid">>,      Lsid,
           <<"txnNumber">>, TxnNumber,
           <<"autocommit">>, false},
    case mc_worker_api:command(W, Cmd) of
        {true, _}  -> ok;
        {false, R} -> {error, R}
    end.

%%====================================================================
%% Internal: worker checkout helper
%%====================================================================

%% with_worker/1 — Check out a poolboy worker from the topology and run Fun(W).
%% This is a thin wrapper around mongoc:transaction/3 that makes it easy to
%% write ops without repeating the boilerplate.
-spec with_worker(fun((pid()) -> term())) -> term().
with_worker(Fun) ->
    mongoc:transaction(topology(), fun(#{pool := W}) ->
        Fun(W)
    end, #{}).

%%====================================================================
%% Internal: transaction helper functions
%%====================================================================

%% extract_lsid/1 — Pull the UUID binary out of startSession's nested reply.
%% startSession returns #{<<"id">> => #{<<"id">> => {bin, uuid, <<16-bytes>>}}}.
-spec extract_lsid(term()) -> {bin, uuid, binary()}.
extract_lsid(#{<<"id">> := {bin, uuid, Bin}}) when is_binary(Bin) ->
    {bin, uuid, Bin};
extract_lsid(#{<<"id">> := Bin}) when is_binary(Bin) ->
    {bin, uuid, Bin};
extract_lsid({bin, uuid, Bin}) when is_binary(Bin) ->
    {bin, uuid, Bin}.

%% txn_find_session/4 — Read a charging_session doc as the FIRST op in a
%% transaction (includes startTransaction:true + autocommit:false).
%% Returns #charging_session{} | undefined.
-spec txn_find_session(pid(), map(), integer(), binary()) ->
    #charging_session{} | undefined.
txn_find_session(W, Lsid, TxnNumber, SessionId) ->
    Cmd = {<<"find">>,            ?CHARGING_SESSIONS,
           <<"filter">>,          #{<<"_id">> => SessionId},
           <<"limit">>,           1,
           <<"singleBatch">>,     true,
           <<"lsid">>,            Lsid,
           <<"txnNumber">>,       TxnNumber,
           <<"startTransaction">>, true,
           <<"autocommit">>,      false},
    case mc_worker_api:command(W, Cmd) of
        {true, #{<<"cursor">> := #{<<"firstBatch">> := [Doc | _]}}} ->
            chf_db_mongo_codec:to_session(Doc);
        {true, #{<<"cursor">> := #{<<"firstBatch">> := []}}} ->
            undefined;
        {true, _} ->
            undefined
    end.

%% txn_find_one/5 — Read a single document inside a running transaction
%% (subsequent op: no startTransaction, has autocommit:false).
-spec txn_find_one(pid(), map(), integer(), binary(), map()) ->
    map() | undefined.
txn_find_one(W, Lsid, TxnNumber, Collection, Filter) ->
    Cmd = {<<"find">>,        Collection,
           <<"filter">>,      Filter,
           <<"limit">>,       1,
           <<"singleBatch">>, true,
           <<"lsid">>,        Lsid,
           <<"txnNumber">>,   TxnNumber,
           <<"autocommit">>,  false},
    case mc_worker_api:command(W, Cmd) of
        {true, #{<<"cursor">> := #{<<"firstBatch">> := [Doc | _]}}} ->
            Doc;
        {true, #{<<"cursor">> := #{<<"firstBatch">> := []}}} ->
            undefined;
        {true, _} ->
            undefined
    end.

%% txn_replace/6 — Replace a document by _id inside a running transaction.
%% Uses findAndModify with upsert:false (doc already exists from prior read;
%% caller must handle the not_found case before calling this).
-spec txn_replace(pid(), map(), integer(), binary(), binary(), map()) -> ok.
txn_replace(W, Lsid, TxnNumber, Collection, Id, NewDoc) ->
    Cmd = {<<"findAndModify">>, Collection,
           <<"query">>,  #{<<"_id">> => Id},
           <<"update">>, NewDoc,
           <<"new">>,    false,
           <<"lsid">>,   Lsid,
           <<"txnNumber">>, TxnNumber,
           <<"autocommit">>, false},
    {true, _} = mc_worker_api:command(W, Cmd),
    ok.

%% txn_upsert_session/5 — Upsert a charging_session doc inside the transaction.
%% Uses findAndModify with upsert:true to handle both insert and replace.
-spec txn_upsert_session(pid(), map(), integer(), binary(), map()) -> ok.
txn_upsert_session(W, Lsid, TxnNumber, SessionId, Doc) ->
    Cmd = {<<"findAndModify">>, ?CHARGING_SESSIONS,
           <<"query">>,  #{<<"_id">> => SessionId},
           <<"update">>, Doc,
           <<"upsert">>, true,
           <<"new">>,    false,
           <<"lsid">>,   Lsid,
           <<"txnNumber">>, TxnNumber,
           <<"autocommit">>, false},
    {true, _} = mc_worker_api:command(W, Cmd),
    ok.

%% commit_txn/3 — Issue commitTransaction targeting the admin database.
-spec commit_txn(pid(), map(), integer()) -> ok.
commit_txn(W, Lsid, TxnNumber) ->
    Cmd = {<<"commitTransaction">>, 1,
           <<"lsid">>,              Lsid,
           <<"txnNumber">>,         TxnNumber,
           <<"autocommit">>,        false},
    {true, _} = mc_worker_api:command(<<"admin">>, W, Cmd),
    ok.

%% abort_txn/3 — Issue abortTransaction targeting the admin database.
-spec abort_txn(pid(), map(), integer()) -> ok.
abort_txn(W, Lsid, TxnNumber) ->
    Cmd = {<<"abortTransaction">>, 1,
           <<"lsid">>,             Lsid,
           <<"txnNumber">>,        TxnNumber,
           <<"autocommit">>,       false},
    %% Abort may return false on a no-op (e.g. if txn already expired).
    %% Ignore the result — we're rolling back regardless.
    _ = mc_worker_api:command(<<"admin">>, W, Cmd),
    ok.

%%====================================================================
%% Internal: shared balance compute helpers (used by /2 and /3 variants)
%%====================================================================

%% compute_reserve_up_to/2 — Pure arithmetic: grant = min(Amount, max(0, avail)).
%% Returns {Granted, NewReserved, NewAvailable}.
-spec compute_reserve_up_to(#balance{}, non_neg_integer()) ->
    {non_neg_integer(), integer(), integer()}.
compute_reserve_up_to(#balance{total    = Total,
                               reserved = Reserved,
                               available = Available}, Amount) ->
    Granted      = min(Amount, max(0, Available)),
    NewReserved  = Reserved + Granted,
    NewAvailable = Total - NewReserved,
    {Granted, NewReserved, NewAvailable}.

%% compute_commit/2 — Pure arithmetic: commit = min(max(0, Amount), reserved).
%% Returns {NewTotal, NewReserved, NewAvailable}.
-spec compute_commit(#balance{}, integer()) ->
    {integer(), integer(), integer()}.
compute_commit(#balance{total    = Total,
                        reserved = Reserved}, Amount) ->
    Commit       = min(max(0, Amount), Reserved),
    NewReserved  = Reserved - Commit,
    NewTotal     = Total    - Commit,
    NewAvailable = NewTotal - NewReserved,
    {NewTotal, NewReserved, NewAvailable}.

%% compute_refund/2 — Pure arithmetic: refund = min(max(0, Amount), reserved).
%% Returns {NewReserved, NewAvailable}.
-spec compute_refund(#balance{}, integer()) ->
    {integer(), integer()}.
compute_refund(#balance{total    = Total,
                        reserved = Reserved}, Amount) ->
    Refund       = min(max(0, Amount), Reserved),
    NewReserved  = Reserved - Refund,
    NewAvailable = Total    - NewReserved,
    {NewReserved, NewAvailable}.

%%====================================================================
%% Internal: transaction error label extractor
%%====================================================================

%% extract_error_labels/1 — Walk an exception reason (possibly nested tuples or
%% maps) looking for a BSON reply map that contains an <<"errorLabels">> field.
%% Returns the label list if found, or not_found otherwise.
%%
%% The mongodb-erlang driver surfaces transaction errors in at least two forms:
%%   {bad_query,      #{<<"errorLabels">> := [...]}}   (older code paths)
%%   {op_msg_response, #{<<"errorLabels">> := [...]}}  (newer write paths)
%% and both may be further wrapped in {error, ...} tuples.
-spec extract_error_labels(term()) -> [binary()] | not_found.
extract_error_labels({_Tag, Inner}) when is_map(Inner) ->
    case maps:get(<<"errorLabels">>, Inner, not_found) of
        not_found -> not_found;
        Labels    -> Labels
    end;
extract_error_labels({_Tag, Inner}) ->
    extract_error_labels(Inner);
extract_error_labels(Map) when is_map(Map) ->
    case maps:get(<<"errorLabels">>, Map, not_found) of
        not_found -> not_found;
        Labels    -> Labels
    end;
extract_error_labels(_) ->
    not_found.

%%====================================================================
%% Internal: findAndModify value extractor
%%====================================================================

%% fam_value/1 — Extract the document from a findAndModify reply map.
%%
%% The MongoDB driver encodes a missing/null document in the "value" field
%% using the atom `null` (standard BSON null) or, in some reply paths, the
%% atom `undefined`. Both are treated as "no document matched/returned".
%% Any other term is the BSON document map.
-spec fam_value(map()) -> map() | no_doc.
fam_value(Reply) ->
    case maps:get(<<"value">>, Reply, undefined) of
        null      -> no_doc;
        undefined -> no_doc;
        Doc       -> Doc
    end.

%%====================================================================
%% Internal: CDR selector builder
%%====================================================================

%% build_cdr_selector/1 — Convert a filter map with Erlang-typed values to a
%% BSON selector map.  Only recognised keys are included; unknown keys are
%% dropped.  Type and state atoms are stringified via the codec's encoding rules.
-spec build_cdr_selector(map()) -> map().
build_cdr_selector(Filters) ->
    maps:fold(fun
        (session_id,   V, Acc) -> Acc#{<<"session_id">>   => V};
        (imsi,         V, Acc) -> Acc#{<<"imsi">>          => V};
        (type,         V, Acc) -> Acc#{<<"type">>          => type_to_bin(V)};
        (rating_group, V, Acc) -> Acc#{<<"rating_group">>  => V};
        (_,            _, Acc) -> Acc
    end, #{}, Filters).

%% type_to_bin/1 — Encode a type atom for use in a CDR selector.
-spec type_to_bin(online | offline | converged) -> binary().
type_to_bin(online)    -> <<"online">>;
type_to_bin(offline)   -> <<"offline">>;
type_to_bin(converged) -> <<"converged">>.

%%====================================================================
%% Internal: index management
%%====================================================================

%% ensure_indexes/1 — Create required indexes on all collections.
%% MongoDB ignores createIndexes for indexes that already exist (idempotent).
-spec ensure_indexes(pid() | atom()) -> ok | {error, term()}.
ensure_indexes(Topology) ->
    case create_index(Topology, <<"subscribers">>,
                      #{<<"msisdn">> => 1}, #{<<"unique">> => true}) of
        ok ->
            case create_index(Topology, <<"cdrs">>,
                              #{<<"session_id">> => 1}, #{}) of
                ok ->
                    create_index(Topology, <<"charging_sessions">>,
                                 #{<<"state">> => 1}, #{});
                {error, _} = Err ->
                    Err
            end;
        {error, _} = Err ->
            Err
    end.

%% create_index/4 — Issue a createIndexes command for a single index.
-spec create_index(pid() | atom(), binary(), map(), map()) -> ok | {error, term()}.
create_index(Topology, Collection, KeySpec, ExtraOpts) ->
    IndexDoc = maps:merge(#{<<"key">> => KeySpec, <<"name">> => index_name(KeySpec)},
                          ExtraOpts),
    Cmd = #{
        <<"createIndexes">> => Collection,
        <<"indexes">>       => [IndexDoc]
    },
    case mongoc:transaction(Topology, fun(#{pool := W}) ->
        mc_worker_api:command(W, Cmd)
    end, #{}) of
        {true, _} ->
            ok;
        {false, Reply} ->
            {error, Reply}
    end.

%% index_name/1 — Derive a canonical index name from its key spec map,
%% e.g. #{<<"msisdn">> => 1} -> <<"msisdn_1">>.
-spec index_name(map()) -> binary().
index_name(KeySpec) ->
    Parts = lists:sort(maps:to_list(KeySpec)),
    iolist_to_binary(
        lists:join(<<"_">>, [[K, <<"_">>, integer_to_binary(D)] || {K, D} <- Parts])
    ).
