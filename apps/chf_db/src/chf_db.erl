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

%% chf_db.erl — Public API facade for the CHF database layer.
%%
%% The concrete backend is configured via:
%%   {chf_db, backend, chf_db_mnesia}   (default)
%%
%% The resolved backend module is cached in persistent_term for fast
%% subsequent lookups without hitting the application env on every call.
-module(chf_db).

-include_lib("chf_db/include/chf_db.hrl").

-export([
    init/0,
    %% Subscriber
    subscriber_create/1,
    subscriber_lookup/1,
    subscriber_update/1,
    subscriber_delete/1,
    %% Balance
    balance_get/1,
    balance_topup/2,
    balance_reserve/2,
    balance_commit/2,
    balance_refund/2,
    balance_set_total/2,
    %% CDR
    cdr_write/1,
    cdr_list/1,
    cdr_generate_id/0,
    %% Session
    session_store/1,
    session_lookup/1,
    session_delete/1,
    session_list_active/0,
    session_transaction/2
]).

-define(PT_KEY, {chf_db, backend}).

%%====================================================================
%% Init
%%====================================================================

%% @doc Initialise the configured backend.  Called from chf_db_app:start/2.
-spec init() -> ok | {error, term()}.
init() ->
    Mod  = resolve_backend(),
    Opts = application:get_env(chf_db, backend_opts, #{}),
    Mod:init(Opts).

%%====================================================================
%% Subscriber operations
%%====================================================================

-spec subscriber_create(#subscriber{}) -> ok | {error, term()}.
subscriber_create(Sub) ->
    (backend()):subscriber_create(Sub).

-spec subscriber_lookup(Imsi :: binary()) -> {ok, #subscriber{}} | {error, not_found}.
subscriber_lookup(Imsi) ->
    (backend()):subscriber_lookup(Imsi).

-spec subscriber_update(#subscriber{}) -> ok | {error, term()}.
subscriber_update(Sub) ->
    (backend()):subscriber_update(Sub).

-spec subscriber_delete(Imsi :: binary()) -> ok | {error, term()}.
subscriber_delete(Imsi) ->
    (backend()):subscriber_delete(Imsi).

%%====================================================================
%% Balance operations
%%====================================================================

-spec balance_get(AccountId :: binary()) -> {ok, #balance{}} | {error, not_found}.
balance_get(AccountId) ->
    (backend()):balance_get(AccountId).

-spec balance_topup(AccountId :: binary(), Amount :: integer()) ->
    {ok, #balance{}} | {error, term()}.
balance_topup(AccountId, Amount) ->
    (backend()):balance_topup(AccountId, Amount).

-spec balance_reserve(AccountId :: binary(), Amount :: integer()) ->
    {ok, #balance{}} | {error, term()}.
balance_reserve(AccountId, Amount) ->
    (backend()):balance_reserve(AccountId, Amount).

-spec balance_commit(AccountId :: binary(), Amount :: integer()) ->
    {ok, #balance{}} | {error, term()}.
balance_commit(AccountId, Amount) ->
    (backend()):balance_commit(AccountId, Amount).

-spec balance_refund(AccountId :: binary(), Amount :: integer()) ->
    {ok, #balance{}} | {error, term()}.
balance_refund(AccountId, Amount) ->
    (backend()):balance_refund(AccountId, Amount).

-spec balance_set_total(AccountId :: binary(), NewTotal :: integer()) ->
    {ok, #balance{}} | {error, term()}.
balance_set_total(AccountId, NewTotal) ->
    (backend()):balance_set_total(AccountId, NewTotal).

%%====================================================================
%% CDR operations
%%====================================================================

-spec cdr_write(#cdr{}) -> ok | {error, term()}.
cdr_write(Cdr) ->
    (backend()):cdr_write(Cdr).

-spec cdr_list(Filters :: map()) -> {ok, [#cdr{}]}.
cdr_list(Filters) ->
    (backend()):cdr_list(Filters).

%% @doc Generate a unique, monotonically-increasing CDR identifier.
-spec cdr_generate_id() -> binary().
cdr_generate_id() ->
    integer_to_binary(erlang:unique_integer([positive, monotonic])).

%%====================================================================
%% Session operations
%%====================================================================

-spec session_store(#charging_session{}) -> ok | {error, term()}.
session_store(Session) ->
    (backend()):session_store(Session).

-spec session_lookup(SessionId :: binary()) ->
    {ok, #charging_session{}} | {error, not_found}.
session_lookup(SessionId) ->
    (backend()):session_lookup(SessionId).

-spec session_delete(SessionId :: binary()) -> ok | {error, term()}.
session_delete(SessionId) ->
    (backend()):session_delete(SessionId).

-spec session_list_active() -> {ok, [#charging_session{}]} | {error, term()}.
session_list_active() ->
    (backend()):session_list_active().

-spec session_transaction(SessionId :: binary(), Fun :: fun()) ->
    term() | {error, term()}.
session_transaction(SessionId, Fun) ->
    (backend()):session_transaction(SessionId, Fun).

%%====================================================================
%% Internal helpers
%%====================================================================

%% Return the cached backend module, resolving and caching on first call.
-spec backend() -> module().
backend() ->
    case persistent_term:get(?PT_KEY, undefined) of
        undefined -> resolve_backend();
        Mod       -> Mod
    end.

%% Resolve backend from application env and store in persistent_term.
-spec resolve_backend() -> module().
resolve_backend() ->
    Mod = application:get_env(chf_db, backend, chf_db_mnesia),
    persistent_term:put(?PT_KEY, Mod),
    Mod.
