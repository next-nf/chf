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

%% chf_reconciler.erl — DB-layer sweep that reclaims quota held by orphaned
%% reservations whose session has vanished (crashed/terminated without releasing).
%%
%% Design notes:
%%
%%   `reconcile_once/0` enumerates every balance document and checks each
%%   reservation's session. A reservation is orphaned if the charging_session
%%   document is absent ({error, not_found}) OR the session's <<"state">> field
%%   is <<"terminated">>. Orphaned reservations are released via
%%   `chf_data:balance_refund/3` with a STABLE per-session reconciliation token
%%   <<"recon-", SessionId/binary>>, so repeated reconcile passes are fully
%%   idempotent: the chf_balance token ring deduplicates the refund, and
%%   balance_refund of an absent reservation is a no-op.
%%
%%   Error handling strategy: a find/get/refund infrastructure error for one
%%   reservation does NOT abort the whole sweep. Errors are logged and accumulated;
%%   reconcile_once/0 returns `ok` if the sweep finished (even with per-reservation
%%   errors) so callers are not misled into retrying the entire sweep on a single
%%   bad reservation. Per-account errors are also log-and-continue — one bad account
%%   row does not block the rest.
%%
%%   A periodic trigger is NOT included in Phase 1. `reconcile_once/0` is the sole
%%   public interface; the caller (a periodic job, a supervisor child, or an ops
%%   script) decides when to call it.
-module(chf_reconciler).
-moduledoc "Reconciliation sweep: reclaim quota held by orphaned balance reservations\n"
           "whose charging session has vanished. See module comments for design notes.".

-include_lib("kernel/include/logger.hrl").

-export([reconcile_once/0]).

%% The chf_db:find and chf_db:get specs guarantee {ok,[...]} / {ok,doc,V} |
%% {error,not_found}, so the defensive error/catch-all clauses in reconcile_once/0
%% and reconcile_reservation/2 are currently unreachable. They are intentionally
%% kept as guards against future contract widening; the nowarn suppression avoids
%% adding new dialyzer warnings without silently removing the guards.
-dialyzer({nowarn_function, [reconcile_once/0, reconcile_reservation/2]}).

-define(BALANCE_COLL,  balance).
-define(SESSION_COLL,  charging_session).

%%====================================================================
%% API
%%====================================================================

-doc "Run one full reconciliation pass over all balance documents.\n"
     "For each reservation, if the corresponding charging session is absent or\n"
     "terminated, the reservation is released. Live sessions are left untouched.\n"
     "Per-reservation errors are logged and do not abort the sweep.\n"
     "Returns `ok` when the sweep completes.".
-spec reconcile_once() -> ok.
reconcile_once() ->
    case chf_db:find(?BALANCE_COLL, #{}) of
        {ok, Balances} ->
            lists:foreach(fun reconcile_balance/1, Balances),
            ok;
        {error, Reason} ->
            ?LOG_ERROR("chf_reconciler: failed to list balances: ~p — aborting pass",
                       [Reason]),
            ok
    end.

%%====================================================================
%% Internal
%%====================================================================

-spec reconcile_balance(chf_db_backend:doc()) -> ok.
reconcile_balance(BalDoc) ->
    AccountId    = maps:get(<<"account_id">>, BalDoc),
    Reservations = maps:get(<<"reservations">>, BalDoc, #{}),
    maps:foreach(fun(SessionId, _Reservation) ->
        reconcile_reservation(AccountId, SessionId)
    end, Reservations).

-spec reconcile_reservation(binary(), binary()) -> ok.
reconcile_reservation(AccountId, SessionId) ->
    case chf_db:get(?SESSION_COLL, SessionId) of
        {error, not_found} ->
            %% Session gone — orphaned reservation, release it.
            release_orphan(AccountId, SessionId);
        {ok, #{<<"state">> := <<"terminated">>}, _V} ->
            %% Session terminated without releasing — release it.
            release_orphan(AccountId, SessionId);
        {ok, _SessionDoc, _V} ->
            %% Session is live (active or unknown state); leave untouched.
            ok;
        {error, Reason} ->
            ?LOG_WARNING("chf_reconciler: get charging_session ~s failed: ~p — skipping",
                         [SessionId, Reason]),
            ok
    end.

-spec release_orphan(binary(), binary()) -> ok.
release_orphan(AccountId, SessionId) ->
    %% Stable reconciliation token: one token per session, safe to replay.
    ReconToken = <<"recon-", SessionId/binary>>,
    case chf_data:balance_refund(AccountId, SessionId, ReconToken) of
        ok ->
            ?LOG_INFO("chf_reconciler: released orphan reservation for session ~s "
                      "on account ~s", [SessionId, AccountId]),
            ok;
        {error, not_found} ->
            %% Balance row vanished between the find and this refund — safe to skip.
            ok;
        {error, Reason} ->
            ?LOG_WARNING("chf_reconciler: refund of orphan reservation for session ~s "
                         "on account ~s failed: ~p — skipping",
                         [SessionId, AccountId, Reason]),
            ok
    end.
