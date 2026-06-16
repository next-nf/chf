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

%% chf_db_backend.erl — Behaviour definition for pluggable CHF database backends
-module(chf_db_backend).

-include_lib("chf_db/include/chf_db.hrl").

%%--------------------------------------------------------------------
%% Behaviour callbacks
%%--------------------------------------------------------------------

%% Initialise the backend with an options map drawn from application env.
-callback init(Opts :: map()) -> ok | {error, term()}.

%% ------------------------------------------------------------------
%% Subscriber operations
%% ------------------------------------------------------------------

%% Create a new subscriber record.
-callback subscriber_create(#subscriber{}) -> ok | {error, term()}.

%% Look up a subscriber by IMSI.
-callback subscriber_lookup(Imsi :: binary()) -> {ok, #subscriber{}} | {error, not_found}.

%% Overwrite an existing subscriber record.
-callback subscriber_update(#subscriber{}) -> ok | {error, term()}.

%% Delete a subscriber by IMSI.
-callback subscriber_delete(Imsi :: binary()) -> ok | {error, term()}.

%% ------------------------------------------------------------------
%% Balance operations (all amounts in micro-units)
%%
%% Atomicity and serialization contract
%% ------------------------------------
%% The callbacks balance_reserve, balance_reserve_up_to, balance_commit, and
%% balance_refund, together with session_transaction, MUST be atomic and
%% serialized per-subscriber under concurrent multi-node access.  Concurrent
%% calls for the same AccountId or SessionId must never interleave in a way
%% that violates the balance invariant (available = total - reserved) or
%% produces double-spending.
%%
%% The Mnesia backend (chf_db_mnesia) satisfies this contract via:
%%   - Distributed Mnesia transactions:  each balance/session operation runs
%%     inside mnesia:activity(transaction, …) which acquires a distributed
%%     write lock on the record before reading it.  Mnesia serializes
%%     conflicting transactions cluster-wide, so no two nodes can commit
%%     overlapping changes to the same record simultaneously.
%%   - disc_copies replicas on every cluster node:  every committed
%%     transaction is synchronously written to all replicas before returning,
%%     so there is no stale-read window between nodes.
%%
%% A future backend (e.g. MongoDB) must satisfy the same contract via an
%% equivalent mechanism — atomic document-level operations (findAndModify /
%% update with $inc + optimistic-concurrency retry) or multi-document
%% transactions with appropriate write concern.
%% ------------------------------------------------------------------

%% Retrieve the current balance for an account.
-callback balance_get(AccountId :: binary()) -> {ok, #balance{}} | {error, not_found}.

%% Add Amount to total and available.
-callback balance_topup(AccountId :: binary(), Amount :: integer()) -> {ok, #balance{}} | {error, term()}.

%% Reserve Amount: available must be >= Amount; decrement available, increment reserved.
%% MUST be atomic and serialized per AccountId (see contract above).
-callback balance_reserve(AccountId :: binary(), Amount :: integer()) -> {ok, #balance{}} | {error, term()}.

%% Reserve up to Amount: grants min(Amount, available); never fails due to insufficient balance.
%% MUST be atomic and serialized per AccountId (see contract above).
-callback balance_reserve_up_to(AccountId :: binary(), Amount :: integer()) ->
    {ok, Granted :: non_neg_integer(), Balance :: term()} | {error, term()}.

%% Commit actual spend of Amount against reserved funds; decrement reserved.
%% MUST be atomic and serialized per AccountId (see contract above).
-callback balance_commit(AccountId :: binary(), Amount :: integer()) -> {ok, #balance{}} | {error, term()}.

%% Return Amount from reserved back to available (e.g. over-estimated grant).
%% MUST be atomic and serialized per AccountId (see contract above).
-callback balance_refund(AccountId :: binary(), Amount :: integer()) -> {ok, #balance{}} | {error, term()}.

%% Set the absolute total balance; available is re-derived as total - reserved.
%% Must abort with total_below_reserved if NewTotal < current reserved.
-callback balance_set_total(AccountId :: binary(), NewTotal :: integer()) -> {ok, #balance{}} | {error, term()}.

%% ------------------------------------------------------------------
%% CDR operations
%% ------------------------------------------------------------------

%% Persist a single CDR.
-callback cdr_write(#cdr{}) -> ok | {error, term()}.

%% List CDRs, optionally filtered by a map of field => value constraints.
-callback cdr_list(Filters :: map()) -> {ok, [#cdr{}]}.

%% ------------------------------------------------------------------
%% Session persistence
%% ------------------------------------------------------------------

%% Store (insert or overwrite) a charging session.
-callback session_store(#charging_session{}) -> ok | {error, term()}.

%% Retrieve a charging session by SessionId.
-callback session_lookup(SessionId :: binary()) -> {ok, #charging_session{}} | {error, not_found}.

%% Delete a charging session by SessionId.
-callback session_delete(SessionId :: binary()) -> ok | {error, term()}.

%% List all active charging sessions.
-callback session_list_active() -> {ok, [#charging_session{}]} | {error, term()}.

%% Run Fun against the current session record (or undefined) inside a single
%% backend transaction holding a write lock on the session id. Fun returns:
%%   {commit, NewSession, Result} — write NewSession, return Result
%%   {result, Result}             — write nothing, return Result
%%   {abort, Reason}              — roll back, return {error, Reason}
%% MUST be atomic and serialized per SessionId (see balance contract above).
-callback session_transaction(SessionId :: binary(), Fun :: fun()) -> term() | {error, term()}.
