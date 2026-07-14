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

-module(chf_data).
-moduledoc "Map-valued domain seam over the generic `chf_db` facade. Resources are plain\n"
           "maps with binary keys; the CAS `version` token is metadata — hidden from\n"
           "domain callers. Reads hand the raw doc to the aggregate accessor's\n"
           "`from_doc/1`; writes call `to_doc/1` before storing.\n"
           "\n"
           "The balance money operations (`balance_reserve/commit/refund`) run through\n"
           "`chf_db:update/3` with the `chf_balance` money `Fun`s, so each is an atomic\n"
           "read-modify-write inside the backend's CAS transaction. The seam translates\n"
           "the facade's `{error, {aborted, insufficient_balance}}` back to the caller-\n"
           "facing `{error, insufficient_balance}`.".

-export([ensure_collections/0,
         %% Subscriber
         subscriber_create/1, subscriber_lookup/1, subscriber_update/1,
         subscriber_delete/1,
         %% Balance
         balance_get/1, balance_reserve/5, balance_commit/5, balance_refund/3,
         %% Balance provisioning (operator-facing, distinct from the money ops)
         balance_topup/2, balance_set_total/2,
         %% Session (descriptive-only)
         session_store/1, session_lookup/1, session_delete/1, session_list_active/0,
         %% CDR
         cdr_create/1, cdr_list/1, cdr_generate_id/0]).

-define(SUBSCRIBER, subscriber).
-define(BALANCE,    balance).
-define(SESSION,    charging_session).
-define(CDR,        cdr).

-type sub_map()     :: #{binary() => term()}.
-type balance_map() :: #{binary() => term()}.
-type session_map() :: #{binary() => term()}.
-type cdr_map()     :: #{binary() => term()}.

%%====================================================================
%% Collection bootstrap
%%====================================================================

-doc "Declare all chf_data collections. Idempotent — safe to call repeatedly. Call\n"
     "at application start (before listeners open) so every collection exists.".
-spec ensure_collections() -> ok.
ensure_collections() ->
    %% Thread the configured storage tier (e.g. disc_copies in prod, ram_copies
    %% under CT) from the backend_opts app env into each collection's opts. The
    %% Mnesia backend reads `storage` from the per-collection opts; backends that
    %% do not use it ignore it.
    Common = case application:get_env(chf_db, backend_opts, #{}) of
                 #{storage := Storage} -> #{storage => Storage};
                 _                     -> #{}
             end,
    ok = chf_db:ensure_collection(?SUBSCRIBER, Common#{indexes => [<<"msisdn">>]}),
    ok = chf_db:ensure_collection(?BALANCE,    Common#{indexes => []}),
    ok = chf_db:ensure_collection(?SESSION,    Common#{indexes => [<<"state">>]}),
    ok = chf_db:ensure_collection(?CDR,        Common#{indexes => [<<"session_id">>]}).

%%====================================================================
%% Subscriber
%%====================================================================

-doc "Insert a subscriber, failing with `{error, exists}` if the IMSI is taken.".
-spec subscriber_create(sub_map()) -> ok | {error, exists} | {error, term()}.
subscriber_create(Sub) ->
    Imsi = maps:get(<<"imsi">>, Sub),
    case chf_db:create(?SUBSCRIBER, Imsi, chf_subscriber:to_doc(Sub)) of
        {ok, _V}       -> ok;
        {error, _} = E -> E
    end.

-doc "Fetch a subscriber by IMSI.".
-spec subscriber_lookup(Imsi :: binary()) -> {ok, sub_map()} | {error, not_found}.
subscriber_lookup(Imsi) ->
    case chf_db:get(?SUBSCRIBER, Imsi) of
        {ok, Doc, _V}          -> {ok, chf_subscriber:from_doc(Doc)};
        {error, not_found} = E -> E
    end.

-doc "Unconditional upsert of a subscriber (create-or-replace).".
-spec subscriber_update(sub_map()) -> ok | {error, term()}.
subscriber_update(Sub) ->
    Imsi = maps:get(<<"imsi">>, Sub),
    case chf_db:put(?SUBSCRIBER, Imsi, chf_subscriber:to_doc(Sub)) of
        {ok, _V}       -> ok;
        {error, _} = E -> E
    end.

-doc "Delete a subscriber by IMSI. Idempotent.".
-spec subscriber_delete(Imsi :: binary()) -> ok.
subscriber_delete(Imsi) ->
    chf_db:delete(?SUBSCRIBER, Imsi).

%%====================================================================
%% Balance
%%====================================================================

-doc "Fetch a balance by account id.".
-spec balance_get(AccountId :: binary()) -> {ok, balance_map()} | {error, not_found}.
balance_get(AccountId) ->
    case chf_db:get(?BALANCE, AccountId) of
        {ok, Doc, _V}          -> {ok, chf_balance:from_doc(Doc)};
        {error, not_found} = E -> E
    end.

-doc "Reserve `Amt` micro-units against `AccountId` for `SessionId` under rating group\n"
     "`RG`, guarded by `IdemToken`. Atomic CAS update. Returns `{error,\n"
     "insufficient_balance}` if the available balance is too low, `{error, not_found}`\n"
     "if the account has no balance row.".
-spec balance_reserve(AccountId :: binary(), SessionId :: binary(), RG :: binary(),
                      Amt :: non_neg_integer(), IdemToken :: binary()) ->
    ok | {error, insufficient_balance} | {error, not_found} | {error, term()}.
balance_reserve(AccountId, SessionId, RG, Amt, IdemToken) ->
    Fun = chf_balance:reserve_fun(SessionId, RG, Amt, IdemToken),
    apply_balance_update(AccountId, Fun).

-doc "Commit `Used` micro-units for `SessionId` on `AccountId`, clamped to the held\n"
     "reservation, tagging a `pending_cdr` with `CdrId`. Atomic CAS update.\n"
     "Idempotent on `IdemToken`.".
-spec balance_commit(AccountId :: binary(), SessionId :: binary(),
                     Used :: non_neg_integer(), CdrId :: binary(),
                     IdemToken :: binary()) ->
    ok | {error, not_found} | {error, term()}.
balance_commit(AccountId, SessionId, Used, CdrId, IdemToken) ->
    Fun = chf_balance:commit_fun(SessionId, Used, CdrId, IdemToken),
    apply_balance_update(AccountId, Fun).

-doc "Release (refund) `SessionId`'s reservation on `AccountId`, returning the held\n"
     "amount to available. No `total` change. Atomic CAS update. Idempotent on\n"
     "`IdemToken`.".
-spec balance_refund(AccountId :: binary(), SessionId :: binary(),
                     IdemToken :: binary()) ->
    ok | {error, not_found} | {error, term()}.
balance_refund(AccountId, SessionId, IdemToken) ->
    Fun = chf_balance:refund_fun(SessionId, IdemToken),
    apply_balance_update(AccountId, Fun).

-doc "Operator provisioning: add `Amt` funded micro-units to `AccountId`'s balance,\n"
     "creating an empty row first if none exists. `Amt` must be non-negative. A zero\n"
     "top-up just materialises the row. Returns the resulting balance map.".
-spec balance_topup(AccountId :: binary(), Amt :: non_neg_integer()) ->
    {ok, balance_map()} | {error, invalid_amount} | {error, term()}.
balance_topup(_AccountId, Amt) when not is_integer(Amt); Amt < 0 ->
    {error, invalid_amount};
balance_topup(AccountId, Amt) ->
    ok = ensure_balance_row(AccountId),
    Fun = fun(Doc) ->
              Total = maps:get(<<"total">>, Doc, 0),
              {ok, Doc#{<<"total">> => Total + Amt}}
          end,
    case chf_db:update(?BALANCE, AccountId, Fun) of
        {ok, Doc, _V}  -> {ok, chf_balance:from_doc(Doc)};
        {error, _} = E -> E
    end.

-doc "Operator provisioning: set the absolute funded total for `AccountId`, creating\n"
     "the row if absent. Fails with `{error, total_below_reserved}` if the new total\n"
     "would be below the currently-held reservations (which would break the available\n"
     "invariant). Returns the resulting balance map.".
-spec balance_set_total(AccountId :: binary(), NewTotal :: non_neg_integer()) ->
    {ok, balance_map()} | {error, total_below_reserved} | {error, term()}.
balance_set_total(AccountId, NewTotal) ->
    ok = ensure_balance_row(AccountId),
    Fun = fun(Doc) ->
              case NewTotal < chf_balance:reserved_total(Doc) of
                  true  -> {abort, total_below_reserved};
                  false -> {ok, Doc#{<<"total">> => NewTotal}}
              end
          end,
    case chf_db:update(?BALANCE, AccountId, Fun) of
        {ok, Doc, _V}                           -> {ok, chf_balance:from_doc(Doc)};
        {error, {aborted, total_below_reserved}} -> {error, total_below_reserved};
        {error, _} = E                          -> E
    end.

%% Insert an empty balance row for AccountId if none exists. Idempotent.
-spec ensure_balance_row(binary()) -> ok.
ensure_balance_row(AccountId) ->
    Doc = chf_balance:to_doc(#{<<"account_id">> => AccountId, <<"total">> => 0}),
    case chf_db:create(?BALANCE, AccountId, Doc) of
        {ok, _V}        -> ok;
        {error, exists} -> ok;
        {error, _} = E  -> E
    end.

%% Run a money Fun through the CAS-updating facade and normalise the result to the
%% caller-facing shape. `{error, {aborted, insufficient_balance}}` — the only abort
%% a money Fun raises — is translated to `{error, insufficient_balance}`; every
%% other facade error (not_found, max_retries, infrastructure) is propagated
%% honestly.
-spec apply_balance_update(binary(),
        fun((chf_balance:doc()) -> {ok, chf_balance:doc()} | {abort, term()})) ->
    ok | {error, insufficient_balance} | {error, not_found} | {error, term()}.
apply_balance_update(AccountId, Fun) ->
    case chf_db:update(?BALANCE, AccountId, Fun) of
        {ok, _Doc, _V}                            -> ok;
        {error, {aborted, insufficient_balance}}  -> {error, insufficient_balance};
        {error, _} = E                            -> E
    end.

%%====================================================================
%% Session (descriptive-only)
%%====================================================================

-doc "Unconditional upsert of a charging session (create-or-replace).".
-spec session_store(session_map()) -> ok | {error, term()}.
session_store(Session) ->
    Id = maps:get(<<"session_id">>, Session),
    case chf_db:put(?SESSION, Id, chf_session:to_doc(Session)) of
        {ok, _V}       -> ok;
        {error, _} = E -> E
    end.

-doc "Fetch a charging session by id.".
-spec session_lookup(SessionId :: binary()) -> {ok, session_map()} | {error, not_found}.
session_lookup(SessionId) ->
    case chf_db:get(?SESSION, SessionId) of
        {ok, Doc, _V}          -> {ok, chf_session:from_doc(Doc)};
        {error, not_found} = E -> E
    end.

-doc "Delete a charging session by id. Idempotent.".
-spec session_delete(SessionId :: binary()) -> ok.
session_delete(SessionId) ->
    chf_db:delete(?SESSION, SessionId).

-doc "List all ACTIVE charging sessions.".
-spec session_list_active() -> {ok, [session_map()]}.
session_list_active() ->
    {ok, Docs} = chf_db:find(?SESSION, #{<<"state">> => <<"active">>}),
    {ok, [chf_session:from_doc(D) || D <- Docs]}.

%%====================================================================
%% CDR
%%====================================================================

-doc "Insert a CDR, failing with `{error, exists}` if the id is taken.".
-spec cdr_create(cdr_map()) -> ok | {error, exists} | {error, term()}.
cdr_create(Cdr) ->
    CdrId = maps:get(<<"cdr_id">>, Cdr),
    case chf_db:create(?CDR, CdrId, chf_cdr:to_doc(Cdr)) of
        {ok, _V}       -> ok;
        {error, _} = E -> E
    end.

-doc "List CDRs for a session id (indexed lookup on `session_id`).".
-spec cdr_list(SessionId :: binary()) -> {ok, [cdr_map()]}.
cdr_list(SessionId) ->
    {ok, Docs} = chf_db:find(?CDR, #{<<"session_id">> => SessionId}),
    {ok, [chf_cdr:from_doc(D) || D <- Docs]}.

-doc "Generate a cluster-unique, monotonically-increasing CDR identifier. Tagged with\n"
     "`node()` so ids from different cluster nodes never collide.".
-spec cdr_generate_id() -> binary().
cdr_generate_id() ->
    iolist_to_binary([atom_to_binary(node(), utf8), $-,
                      integer_to_binary(erlang:unique_integer([positive, monotonic]))]).
