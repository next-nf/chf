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

-module(chf_cdr_drainer).
-moduledoc "CDR outbox drainer — supervised gen_server that drains `pending_cdrs`\n"
           "markers from balance documents into the `cdr` collection with exactly-once\n"
           "effect.\n"
           "\n"
           "## Outbox saga (database.md §6.3)\n"
           "When a balance commit is applied by `chf_balance:commit_fun/4`, a\n"
           "`pending_cdr` stub is appended to the balance document atomically with the\n"
           "money deduction. This module drains those stubs:\n"
           "  1. `chf_db:find(balance, #{})` — full scan filtered to non-empty\n"
           "     `pending_cdrs`. **Phase 1: O(n) scan — fine for bootstrap capacity.**\n"
           "     TODO: add a `has_pending` boolean index when record volume warrants it\n"
           "     (tracking epic: see `reference/issue-tracking.md`).\n"
           "  2. For each marker whose `used > 0`: `chf_db:create(cdr, CdrId, Doc)`.\n"
           "     Both `{ok, _}` and `{error, exists}` are treated as durable success —\n"
           "     at-least-once drain + idempotent create = exactly-once effect.\n"
           "     Any other `{error, _}` (infrastructure) is propagated honestly; the\n"
           "     marker is NOT cleared for a failed create.\n"
           "  3. Zero-usage markers (`used =< 0`) are inert bookkeeping produced when a\n"
           "     commit clamps to 0 (no reservation held or negative Used). They are\n"
           "     cleared WITHOUT emitting a CDR — a CDR records actual usage only.\n"
           "  4. `chf_db:update(balance, AccountId, Fun)` where `Fun` removes exactly\n"
           "     the successfully drained markers from `pending_cdrs` (matched by\n"
           "     `cdr_id`), leaving any that failed.\n"
           "\n"
           "## Periodic triggering\n"
           "The gen_server sends itself a `drain` message every `?DRAIN_INTERVAL_MS`\n"
           "milliseconds. `drain_once/0` is also exported for explicit invocation and\n"
           "tests (synchronous call).".

-behaviour(gen_server).

-export([start_link/0, start/0, drain_once/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

%% Drain interval in milliseconds. Modest default — configurable via app env
%% `{chf_cdr_drainer, drain_interval_ms}`.
-define(DEFAULT_DRAIN_INTERVAL_MS, 30_000).

-define(BALANCE, balance).
-define(CDR,     cdr).

-define(F_ACCOUNT_ID,   <<"account_id">>).
-define(F_PENDING_CDRS, <<"pending_cdrs">>).
-define(F_CDR_ID,       <<"cdr_id">>).
-define(F_USED,         <<"used">>).

-type marker() :: #{binary() => term()}.
-type drain_result() :: ok | {error, term()}.

%%------------------------------------------------------------------------------
%% Public API
%%------------------------------------------------------------------------------

-doc "Start and register the drainer gen_server locally, linked to the caller.\n"
     "Used by `chf_data_sup` in production. Tests that need to avoid linking use\n"
     "`start/0` instead.".
-spec start_link() -> {ok, pid()} | {error, term()}.
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

-doc "Start and register the drainer gen_server locally WITHOUT linking to the caller.\n"
     "Intended for test harnesses where `start_link` would tie the drainer's lifetime\n"
     "to the CT init process rather than the intended supervisor.".
-spec start() -> {ok, pid()} | {error, term()}.
start() ->
    gen_server:start({local, ?MODULE}, ?MODULE, [], []).

-doc "Synchronously drain all pending CDR markers from every balance document.\n"
     "Returns `ok` when all drainable markers have been processed (either freshly\n"
     "created or found already-present). Returns `{error, Reason}` if an\n"
     "infrastructure error is encountered during the drain.".
-spec drain_once() -> drain_result().
drain_once() ->
    gen_server:call(?MODULE, drain_once, infinity).

%%------------------------------------------------------------------------------
%% gen_server callbacks
%%------------------------------------------------------------------------------

-spec init([]) -> {ok, map()}.
init([]) ->
    IntervalMs = application:get_env(chf_cdr_drainer, drain_interval_ms,
                                     ?DEFAULT_DRAIN_INTERVAL_MS),
    schedule_drain(IntervalMs),
    {ok, #{interval_ms => IntervalMs}}.

-spec handle_call(drain_once, {pid(), term()}, map()) ->
    {reply, drain_result(), map()}.
handle_call(drain_once, _From, State) ->
    Result = do_drain(),
    {reply, Result, State}.

-spec handle_cast(term(), map()) -> {noreply, map()}.
handle_cast(_Msg, State) ->
    {noreply, State}.

-spec handle_info(drain | term(), map()) -> {noreply, map()}.
handle_info(drain, #{interval_ms := IntervalMs} = State) ->
    _ = do_drain(),
    schedule_drain(IntervalMs),
    {noreply, State};
handle_info(_Info, State) ->
    {noreply, State}.

-spec terminate(term(), map()) -> ok.
terminate(_Reason, _State) ->
    ok.

-spec code_change(term(), map(), term()) -> {ok, map()}.
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%------------------------------------------------------------------------------
%% Core drain logic
%%------------------------------------------------------------------------------

%% do_drain/0 — scan all balance documents, drain each one with pending markers.
%% Returns ok on full success, {error, Reason} on the first infrastructure error.
-spec do_drain() -> drain_result().
%% chf_db:find/2 is a dirty read whose contract is {ok, [doc()]} — it never
%% returns {error, _} (an infra failure exits the process, and the supervisor
%% restarts the drainer). So the bare match is correct; do not add an
%% {error, _} clause (it is unreachable and dialyzer rejects it).
do_drain() ->
    {ok, Balances} = chf_db:find(?BALANCE, #{}),
    drain_balances(Balances).

-spec drain_balances([chf_balance:doc()]) -> drain_result().
drain_balances([]) ->
    ok;
drain_balances([Balance | Rest]) ->
    Pending = maps:get(?F_PENDING_CDRS, Balance, []),
    case Pending of
        [] ->
            drain_balances(Rest);
        _ ->
            AccountId = maps:get(?F_ACCOUNT_ID, Balance),
            case drain_balance(AccountId, Pending) of
                ok              -> drain_balances(Rest);
                {error, _} = E  -> E
            end
    end.

%% drain_balance/2 — for a single balance, drain all its markers.
%% Returns ok if all CDRs were created (or already existed) and the
%% balance markers were cleared. Returns {error, Reason} on the first
%% infrastructure failure (the marker for that CDR is left pending).
-spec drain_balance(binary(), [marker()]) -> drain_result().
drain_balance(AccountId, Markers) ->
    case drain_markers(Markers, []) of
        {ok, DrainedIds} ->
            clear_markers(AccountId, DrainedIds);
        {error, DrainedIds, Reason} ->
            %% Clear the markers we successfully drained, then propagate the error.
            case clear_markers(AccountId, DrainedIds) of
                ok             -> {error, Reason};
                {error, _} = E -> E
            end
    end.

%% drain_markers/2 — iterate over markers, create CDRs, accumulate drained cdr_ids.
%% On zero-usage markers: treat as successfully "drained" (no CDR created) so they
%% get cleared. On infrastructure errors: stop and report partial success.
-spec drain_markers([marker()], [binary()]) ->
    {ok, [binary()]} | {error, [binary()], term()}.
drain_markers([], DrainedAcc) ->
    {ok, DrainedAcc};
drain_markers([Marker | Rest], DrainedAcc) ->
    CdrId = maps:get(?F_CDR_ID, Marker),
    Used  = maps:get(?F_USED, Marker, 0),
    case drain_marker(CdrId, Used, Marker) of
        ok              -> drain_markers(Rest, [CdrId | DrainedAcc]);
        {error, Reason} -> {error, DrainedAcc, Reason}
    end.

%% drain_marker/3 — drain a single marker.
%% Zero-usage: skip CDR creation, treat as drained (clear the inert stub).
%% Non-zero usage: create the CDR; both ok and exists count as success.
-spec drain_marker(binary(), integer(), marker()) -> ok | {error, term()}.
drain_marker(_CdrId, Used, _Marker) when Used =< 0 ->
    %% Zero-usage stub — produced when a commit clamped to 0.
    %% No real usage occurred; do NOT emit a CDR. Clear the marker so
    %% pending_cdrs does not grow unbounded.
    ok;
drain_marker(CdrId, _Used, Marker) ->
    CdrDoc = chf_cdr:to_doc(Marker),
    case chf_db:create(?CDR, CdrId, CdrDoc) of
        {ok, _V}        -> ok;
        {error, exists} -> ok;   %% idempotent: CDR already durable, treat as success
        {error, Reason} -> {error, Reason}
    end.

%% clear_markers/2 — atomic CAS update that removes the given cdr_ids from
%% pending_cdrs. Matches by cdr_id so only the drained markers are removed;
%% any that failed (infra error) remain pending for the next drain cycle.
-spec clear_markers(binary(), [binary()]) -> ok | {error, term()}.
clear_markers(_AccountId, []) ->
    ok;
clear_markers(AccountId, DrainedIds) ->
    DrainedSet = sets:from_list(DrainedIds),
    Fun = fun(Doc) ->
              Pending  = maps:get(?F_PENDING_CDRS, Doc, []),
              Pending1 = [M || M <- Pending,
                               not sets:is_element(maps:get(?F_CDR_ID, M), DrainedSet)],
              {ok, Doc#{?F_PENDING_CDRS => Pending1}}
          end,
    case chf_db:update(?BALANCE, AccountId, Fun) of
        {ok, _Doc, _V} -> ok;
        {error, _} = E -> E
    end.

%%------------------------------------------------------------------------------
%% Internal helpers
%%------------------------------------------------------------------------------

-spec schedule_drain(pos_integer()) -> reference().
schedule_drain(IntervalMs) ->
    erlang:send_after(IntervalMs, self(), drain).
