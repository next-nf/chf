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
