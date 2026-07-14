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

-module(chf_balance).
-moduledoc "Accessor + money-invariant module for the `balance` aggregate — the\n"
           "safety-critical heart of the CHF data layer.\n"
           "\n"
           "Money is **integer micro-units**. No floats appear anywhere in this module.\n"
           "\n"
           "## Document shape (schema_version = 1)\n"
           "- `<<\"account_id\">>` — billing-account key (binary); the chf_db key\n"
           "- `<<\"total\">>` — funded balance in micro-units (integer, default 0)\n"
           "- `<<\"reservations\">>` — in-flight holds, keyed by session id (map, default\n"
           "  `#{}`). Each value is `#{<<\"rating_group\">>, <<\"amount\">>, <<\"granted_at\">>}`.\n"
           "- `<<\"pending_cdrs\">>` — committed-but-not-yet-flushed CDR stubs (list,\n"
           "  default `[]`).\n"
           "- `<<\"applied_tokens\">>` — bounded ring of the last `?TOKEN_RING_SIZE`\n"
           "  idempotency tokens (list, default `[]`).\n"
           "- `<<\"created_at\">>`, `<<\"updated_at\">>` — timestamps (integer, default 0).\n"
           "\n"
           "## The available invariant (DERIVED — never stored)\n"
           "`available(Doc) = total − Σ reservation amounts`. It is computed on demand\n"
           "so it can never drift from `total` and the reservation set. `reserve`\n"
           "checks it against the requested amount; a hold reduces `available` without\n"
           "touching `total`.\n"
           "\n"
           "## Money `Fun`s (for `chf_db:update/3`)\n"
           "Each builder returns `fun((doc()) -> {ok, doc()} | {abort, term()})`. They\n"
           "run inside the backend's CAS transaction, so read-modify-write is atomic.\n"
           "- `reserve_fun/4` — hold `Amt` for a session if `available >= Amt`, else\n"
           "  `{abort, insufficient_balance}`. No `total` change.\n"
           "- `commit_fun/4` — consume `Used` (clamped to the held amount, so a commit\n"
           "  can never charge more than was reserved and `total` can only go DOWN):\n"
           "  `total := total − UsedClamped`; the reservation is removed on a full\n"
           "  commit or reduced by the committed grant on a partial commit; a\n"
           "  `pending_cdr` stub is appended.\n"
           "- `refund_fun/2` (a.k.a. release) — drop the session's reservation,\n"
           "  returning the held amount to `available`. No `total` change.\n"
           "\n"
           "## Idempotency (at-most-once money effects, database.md §6.2)\n"
           "Each `Fun` carries an `IdemToken`. `applied_tokens` is a **bounded ring** of\n"
           "the last `?TOKEN_RING_SIZE` (= 64) tokens. Each `Fun` checks membership at\n"
           "the top; on a hit it returns `{ok, Doc}` unchanged — a replayed token never\n"
           "re-charges. The bound of 64 comfortably exceeds the number of distinct\n"
           "in-flight operations against a single account at any instant; older tokens\n"
           "age out, which is safe because a settled operation will not be legitimately\n"
           "replayed after 64 subsequent operations on the same account.".

-export([from_doc/1, to_doc/1,
         available/1,
         reserve_fun/4, commit_fun/4, refund_fun/2]).

-define(SCHEMA_VERSION, 1).

%% Bound of the idempotency-token ring. See the moduledoc for the rationale.
-define(TOKEN_RING_SIZE, 64).

%% Binary field-name literals — all field names centralised here.
-define(F_SCHEMA_VERSION, <<"schema_version">>).
-define(F_ACCOUNT_ID,     <<"account_id">>).
-define(F_TOTAL,          <<"total">>).
-define(F_RESERVATIONS,   <<"reservations">>).
-define(F_PENDING_CDRS,   <<"pending_cdrs">>).
-define(F_APPLIED_TOKENS, <<"applied_tokens">>).
-define(F_CREATED_AT,     <<"created_at">>).
-define(F_UPDATED_AT,     <<"updated_at">>).

%% Reservation / pending-cdr sub-fields.
-define(F_RATING_GROUP, <<"rating_group">>).
-define(F_AMOUNT,       <<"amount">>).
-define(F_GRANTED_AT,   <<"granted_at">>).
-define(F_CDR_ID,       <<"cdr_id">>).
-define(F_SESSION_ID,   <<"session_id">>).
-define(F_USED,         <<"used">>).
-define(F_TS,           <<"ts">>).

-type doc()         :: #{binary() => term()}.
-type balance_map() :: #{binary() => term()}.
-type reservation() :: #{binary() => term()}.

-export_type([doc/0, balance_map/0]).

%%------------------------------------------------------------------------------
%% Accessors
%%------------------------------------------------------------------------------

-doc "Convert a stored document to a typed balance map with defaults (upgrade-on-read).".
-spec from_doc(doc()) -> balance_map().
from_doc(Doc0) ->
    Doc = upgrade(Doc0),
    maps:merge(defaults(), Doc).

-doc "Convert a typed balance map to a stored document, stamping `schema_version => 1`.".
-spec to_doc(balance_map()) -> doc().
to_doc(Map) ->
    %% Merge defaults so the money `Fun`s can rely on every structural field
    %% (reservations, pending_cdrs, applied_tokens) being present, even when the
    %% caller supplies only account_id + total.
    maps:merge(defaults(), Map#{?F_SCHEMA_VERSION => ?SCHEMA_VERSION}).

-spec defaults() -> doc().
defaults() ->
    #{?F_SCHEMA_VERSION => ?SCHEMA_VERSION,
      ?F_TOTAL          => 0,
      ?F_RESERVATIONS   => #{},
      ?F_PENDING_CDRS   => [],
      ?F_APPLIED_TOKENS => [],
      ?F_CREATED_AT     => 0,
      ?F_UPDATED_AT     => 0}.

%%------------------------------------------------------------------------------
%% Derived quantity
%%------------------------------------------------------------------------------

-doc "Spendable balance: `total − Σ reservation amounts`. DERIVED, never stored, so\n"
     "it cannot drift from `total` and the reservation set.".
-spec available(doc()) -> integer().
available(Doc) ->
    Total = maps:get(?F_TOTAL, Doc, 0),
    Total - reserved_total(Doc).

-spec reserved_total(doc()) -> non_neg_integer().
reserved_total(Doc) ->
    Reservations = maps:get(?F_RESERVATIONS, Doc, #{}),
    maps:fold(fun(_SessionId, R, Acc) -> Acc + maps:get(?F_AMOUNT, R, 0) end,
              0, Reservations).

%%------------------------------------------------------------------------------
%% Money Funs
%%------------------------------------------------------------------------------

-doc "Build a `reserve` Fun that holds `Amt` micro-units for `SessionId` under `RG`.\n"
     "Idempotent on `IdemToken`. `{abort, insufficient_balance}` if `available < Amt`.".
-spec reserve_fun(SessionId :: binary(), RG :: binary(), Amt :: integer(),
                  IdemToken :: binary()) ->
    fun((doc()) -> {ok, doc()} | {abort, insufficient_balance | invalid_amount}).
reserve_fun(SessionId, RG, Amt, IdemToken) ->
    fun(Doc) ->
        case token_applied(IdemToken, Doc) of
            true  -> {ok, Doc};
            false when Amt < 0 ->
                %% Invalid request: reject WITHOUT inserting a reservation or
                %% recording the token. An invalid amount is not an at-most-once
                %% money effect, so a replay must be free to re-evaluate.
                {abort, invalid_amount};
            false -> do_reserve(SessionId, RG, Amt, IdemToken, Doc)
        end
    end.

-spec do_reserve(binary(), binary(), non_neg_integer(), binary(), doc()) ->
    {ok, doc()} | {abort, insufficient_balance}.
do_reserve(SessionId, RG, Amt, IdemToken, Doc) ->
    case available(Doc) < Amt of
        true ->
            {abort, insufficient_balance};
        false ->
            Reservations = maps:get(?F_RESERVATIONS, Doc, #{}),
            Reservation = #{?F_RATING_GROUP => RG,
                            ?F_AMOUNT       => Amt,
                            ?F_GRANTED_AT   => now_ms()},
            Doc1 = Doc#{?F_RESERVATIONS := Reservations#{SessionId => Reservation}},
            {ok, record_token(IdemToken, touch(Doc1))}
    end.

-doc "Build a `commit` Fun for `SessionId`. `Used` is CLAMPED to the held reservation\n"
     "amount (0 if none) so a commit can never charge more than was reserved.\n"
     "`total := total − UsedClamped`. Full commit removes the reservation; a partial\n"
     "commit (`Used < held`) leaves the residual held. Appends a `pending_cdr` stub\n"
     "tagged `CdrId`. Idempotent on `IdemToken`.".
-spec commit_fun(SessionId :: binary(), Used :: integer(),
                 CdrId :: binary(), IdemToken :: binary()) ->
    fun((doc()) -> {ok, doc()}).
commit_fun(SessionId, Used, CdrId, IdemToken) ->
    fun(Doc) ->
        case token_applied(IdemToken, Doc) of
            true  -> {ok, Doc};
            false -> do_commit(SessionId, Used, CdrId, IdemToken, Doc)
        end
    end.

-spec do_commit(binary(), integer(), binary(), binary(), doc()) -> {ok, doc()}.
do_commit(SessionId, Used, CdrId, IdemToken, Doc) ->
    Reservations = maps:get(?F_RESERVATIONS, Doc, #{}),
    Reservation  = maps:get(SessionId, Reservations, undefined),
    Held         = held_amount(Reservation),
    %% Clamp to the non-negative held range: charge at most what was reserved,
    %% and never a negative amount. This is the money guarantee — total can only
    %% decrease, never below (total − Held), and a negative Used is a no-op on
    %% total (UsedClamped = 0) rather than inflating it.
    UsedClamped  = max(0, min(Used, Held)),
    RG           = reservation_rg(Reservation),
    Total        = maps:get(?F_TOTAL, Doc, 0),
    Reservations1 = settle_reservation(SessionId, Reservation, Held, UsedClamped,
                                       Reservations),
    Cdr = #{?F_CDR_ID       => CdrId,
            ?F_SESSION_ID   => SessionId,
            ?F_RATING_GROUP => RG,
            ?F_USED         => UsedClamped,
            ?F_TS           => now_ms()},
    Pending = maps:get(?F_PENDING_CDRS, Doc, []),
    Doc1 = Doc#{?F_TOTAL        := Total - UsedClamped,
                ?F_RESERVATIONS := Reservations1,
                ?F_PENDING_CDRS := Pending ++ [Cdr]},
    {ok, record_token(IdemToken, touch(Doc1))}.

%% settle_reservation/5 — remove on full commit, reduce on partial, no-op if none.
-spec settle_reservation(binary(), reservation() | undefined,
                         non_neg_integer(), non_neg_integer(), map()) -> map().
settle_reservation(_SessionId, undefined, _Held, _UsedClamped, Reservations) ->
    %% No reservation for this session — nothing to settle (UsedClamped is 0).
    Reservations;
settle_reservation(SessionId, _Reservation, Held, UsedClamped, Reservations)
  when UsedClamped >= Held ->
    %% Full commit: the whole grant is consumed — drop the reservation.
    maps:remove(SessionId, Reservations);
settle_reservation(SessionId, Reservation, Held, UsedClamped, Reservations) ->
    %% Partial commit: reduce the held amount by what was committed; residual stays.
    Residual = Held - UsedClamped,
    Reservations#{SessionId := Reservation#{?F_AMOUNT := Residual}}.

-doc "Build a `refund`/`release` Fun that drops `SessionId`'s reservation, returning\n"
     "the held amount to `available`. No `total` change. Idempotent on `IdemToken`.".
-spec refund_fun(SessionId :: binary(), IdemToken :: binary()) ->
    fun((doc()) -> {ok, doc()}).
refund_fun(SessionId, IdemToken) ->
    fun(Doc) ->
        case token_applied(IdemToken, Doc) of
            true  -> {ok, Doc};
            false -> do_refund(SessionId, IdemToken, Doc)
        end
    end.

-spec do_refund(binary(), binary(), doc()) -> {ok, doc()}.
do_refund(SessionId, IdemToken, Doc) ->
    Reservations = maps:get(?F_RESERVATIONS, Doc, #{}),
    Doc1 = Doc#{?F_RESERVATIONS := maps:remove(SessionId, Reservations)},
    {ok, record_token(IdemToken, touch(Doc1))}.

%%------------------------------------------------------------------------------
%% Reservation helpers (clause-head matching over the presence/shape)
%%------------------------------------------------------------------------------

-spec held_amount(reservation() | undefined) -> non_neg_integer().
held_amount(undefined)                     -> 0;
held_amount(#{?F_AMOUNT := Amt})           -> Amt.

-spec reservation_rg(reservation() | undefined) -> binary().
reservation_rg(undefined)                  -> <<>>;
reservation_rg(#{?F_RATING_GROUP := RG})   -> RG.

%%------------------------------------------------------------------------------
%% Idempotency ring
%%------------------------------------------------------------------------------

-spec token_applied(binary(), doc()) -> boolean().
token_applied(Token, Doc) ->
    lists:member(Token, maps:get(?F_APPLIED_TOKENS, Doc, [])).

%% record_token/2 — prepend the token, keeping only the last ?TOKEN_RING_SIZE.
-spec record_token(binary(), doc()) -> doc().
record_token(Token, Doc) ->
    Tokens = maps:get(?F_APPLIED_TOKENS, Doc, []),
    Bounded = lists:sublist([Token | Tokens], ?TOKEN_RING_SIZE),
    Doc#{?F_APPLIED_TOKENS => Bounded}.

%%------------------------------------------------------------------------------
%% Misc helpers
%%------------------------------------------------------------------------------

-spec touch(doc()) -> doc().
touch(Doc) ->
    Doc#{?F_UPDATED_AT => now_ms()}.

-spec now_ms() -> non_neg_integer().
now_ms() ->
    erlang:system_time(millisecond).

%%------------------------------------------------------------------------------
%% Internal: upgrade-on-read
%%------------------------------------------------------------------------------

-spec upgrade(doc()) -> doc().
upgrade(#{?F_SCHEMA_VERSION := ?SCHEMA_VERSION} = Doc) ->
    Doc;
upgrade(Doc) ->
    Doc#{?F_SCHEMA_VERSION => ?SCHEMA_VERSION}.
