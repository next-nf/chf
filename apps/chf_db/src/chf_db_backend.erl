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
%% ------------------------------------------------------------------

%% Retrieve the current balance for an account.
-callback balance_get(AccountId :: binary()) -> {ok, #balance{}} | {error, not_found}.

%% Add Amount to total and available.
-callback balance_topup(AccountId :: binary(), Amount :: integer()) -> {ok, #balance{}} | {error, term()}.

%% Reserve Amount: available must be >= Amount; decrement available, increment reserved.
-callback balance_reserve(AccountId :: binary(), Amount :: integer()) -> {ok, #balance{}} | {error, term()}.

%% Commit actual spend of Amount against reserved funds; decrement reserved.
-callback balance_commit(AccountId :: binary(), Amount :: integer()) -> {ok, #balance{}} | {error, term()}.

%% Return Amount from reserved back to available (e.g. over-estimated grant).
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
-callback session_transaction(SessionId :: binary(), Fun :: fun()) -> term() | {error, term()}.
