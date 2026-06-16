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

%% chf_db_mongo.erl — MongoDB backend for chf_db.
%%
%% This module implements subscriber CRUD, session store/lookup/delete/list_active,
%% cdr_write/1, and cdr_list/1.  Balance ops and transactions are delivered in
%% subsequent tasks.
%%
%% NOTE: -behaviour(chf_db_backend) is intentionally NOT declared here.
%% chf_db_backend declares 23 callbacks; this file implements only a subset.
%% Declaring the behaviour now would emit "callback missing" warnings for the
%% unimplemented ones, which fails the build under warnings_as_errors.
%% The attribute is added when the final callback is delivered.
%%
%% Supervision note: mongoc:connect/3 uses mc_topology:start_link internally,
%% which links the topology gen_server to the calling process. If the caller
%% exits, the topology dies too. To prevent this, init/1 spawns a dedicated
%% keeper process (registered as chf_db_mongo_keeper) that owns the link. The
%% keeper traps exits so a topology crash does not kill it.
%%
%% LIMITATION (skeleton phase): the keeper is NOT yet under chf_db_sup, so it is
%% not restarted if it crashes, and a topology crash leaves a stale Pid in
%% persistent_term. The next task moves the keeper to a supervised gen_server
%% child of chf_db_sup so the supervisor owns the link and can heal the
%% connection (disconnect + reconnect) on restart. For the current ops-free
%% skeleton this is adequate: init/1 runs once at app/CT start in a clean node.
%% To bound the latent leak, init/1 tears down any pre-existing keeper before
%% spawning a fresh one (see do_connect/4), so repeated init/1 calls do not
%% accumulate orphan keepers.
%%
%% In production the keeper is started by chf_db_mongo:init/1, called from
%% chf_db_app:start/2 (the long-lived application master process).
-module(chf_db_mongo).

-include_lib("chf_db/include/chf_db.hrl").

-export([
    init/1,
    topology/0,
    %% Subscriber
    subscriber_create/1,
    subscriber_lookup/1,
    subscriber_update/1,
    subscriber_delete/1,
    %% Balance
    balance_get/1,
    balance_topup/2,
    balance_reserve/2,
    balance_reserve_up_to/2,
    balance_commit/2,
    balance_refund/2,
    balance_set_total/2,
    %% Session
    session_store/1,
    session_lookup/1,
    session_delete/1,
    session_list_active/0,
    %% CDR
    cdr_write/1,
    cdr_list/1
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

%% init/1 — Connect to the MongoDB replica set, store the topology in
%% persistent_term, and ensure all required indexes exist.
%%
%% Reads configuration from the {chf_db, mongo, Cfg} application env.
%% Defaults: host "127.0.0.1", port 27017, replset <<"rs0">>,
%%           database <<"chf">>, pool_size 5.
-spec init(map()) -> ok | {error, term()}.
init(_Opts) ->
    Cfg      = application:get_env(chf_db, mongo, #{}),
    Host     = maps:get(host,      Cfg, "127.0.0.1"),
    Port     = maps:get(port,      Cfg, 27017),
    ReplSet  = maps:get(replset,   Cfg, <<"rs0">>),
    Database = maps:get(database,  Cfg, <<"chf">>),
    PoolSize = maps:get(pool_size, Cfg, 5),

    HostStr = Host ++ ":" ++ integer_to_list(Port),

    %% If a topology is already registered (e.g. re-init in the same node),
    %% reuse it rather than spawning a second supervisor under the same name.
    case whereis(chf_db_mongo_pool) of
        Existing when is_pid(Existing), node(Existing) =:= node() ->
            case is_process_alive(Existing) of
                true ->
                    persistent_term:put({chf_db_mongo, topology}, Existing),
                    ensure_indexes(Existing);
                false ->
                    do_connect(ReplSet, HostStr, PoolSize, Database)
            end;
        _ ->
            do_connect(ReplSet, HostStr, PoolSize, Database)
    end.

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
            <<"total">>     => NewTotal,
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
%% Internal: keeper process
%%====================================================================

%% do_connect/4 — Tear down any prior keeper, spawn a fresh keeper, connect from
%% the keeper's context (so mc_topology:start_link's link is owned by the keeper,
%% not by the short-lived init/1 caller), then store the topology.
-spec do_connect(binary(), string(), pos_integer(), binary()) -> ok | {error, term()}.
do_connect(ReplSet, HostStr, PoolSize, Database) ->
    %% Kill any pre-existing keeper so re-init does not leak orphan keepers.
    %% The keeper owns the link to the old topology, so killing it also brings
    %% the old topology down, freeing the chf_db_mongo_pool name for re-use.
    stop_keeper(),
    Caller = self(),
    Keeper = spawn(fun() ->
        process_flag(trap_exit, true),
        catch register(chf_db_mongo_keeper, self()),
        ConnResult = mongoc:connect(
            {rs, ReplSet, [HostStr]},
            [{name, chf_db_mongo_pool}, {register, chf_db_mongo_pool}, {pool_size, PoolSize}],
            [{database, Database}]
        ),
        Caller ! {connect_result, self(), ConnResult},
        keeper_loop()
    end),
    receive
        {connect_result, Keeper, {ok, Topology}} ->
            persistent_term:put({chf_db_mongo, topology}, Topology),
            case ensure_indexes(Topology) of
                ok ->
                    ok;
                {error, _} = Err ->
                    %% Index setup failed — do not leave the keeper/topology
                    %% dangling when the app start is going to fail.
                    persistent_term:erase({chf_db_mongo, topology}),
                    stop_keeper(),
                    Err
            end;
        {connect_result, Keeper, {error, Reason}} ->
            stop_keeper(Keeper),
            {error, Reason}
    after 30000 ->
        stop_keeper(Keeper),
        {error, connect_timeout}
    end.

%% keeper_loop/0 — Long-lived process that owns the link to the mc_topology
%% gen_server. Trapping exits means a topology crash does not kill the keeper.
keeper_loop() ->
    receive
        {'EXIT', _Pid, _Reason} ->
            %% Topology died; stay alive (see module-level LIMITATION note).
            keeper_loop();
        stop ->
            ok;
        _ ->
            keeper_loop()
    end.

%% stop_keeper/0 — Synchronously tear down the registered keeper (if any),
%% waiting for it to actually exit so its registered names are released before
%% the caller re-registers them.
-spec stop_keeper() -> ok.
stop_keeper() ->
    case whereis(chf_db_mongo_keeper) of
        undefined -> ok;
        Pid       -> stop_keeper(Pid)
    end.

-spec stop_keeper(pid()) -> ok.
stop_keeper(Pid) when is_pid(Pid) ->
    Ref = monitor(process, Pid),
    exit(Pid, shutdown),
    receive
        {'DOWN', Ref, process, Pid, _} -> ok
    after 5000 ->
        demonitor(Ref, [flush]),
        ok
    end.

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
