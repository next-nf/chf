%% chf_session_reg.erl — Session registry gen_server.
%%
%% Owns two ETS tables:
%%   chf_session_by_id   : session_id  -> pid
%%   chf_session_by_imsi : {imsi, ctx} -> session_id
%%
%% register/unregister are casts (fire-and-forget).
%% lookup/lookup_by_imsi are direct ETS reads — no gen_server round-trip.
-module(chf_session_reg).
-behaviour(gen_server).

-export([start_link/0,
         register/2,
         unregister/1,
         lookup/1,
         lookup_by_imsi/1]).

-export([init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2]).

-define(BY_ID,   chf_session_by_id).
-define(BY_IMSI, chf_session_by_imsi).

%%====================================================================
%% API
%%====================================================================

-spec start_link() -> {ok, pid()} | {error, term()}.
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%% @doc Register a session pid under its session_id (and optionally imsi/ctx).
%%      Info must contain at least: #{session_id => binary(), imsi => binary()}.
%%      Optional key: session_context (any term).
-spec register(SessionId :: binary(), Pid :: pid()) -> ok.
register(SessionId, Pid) ->
    gen_server:cast(?MODULE, {register, SessionId, Pid}).

-spec unregister(SessionId :: binary()) -> ok.
unregister(SessionId) ->
    gen_server:cast(?MODULE, {unregister, SessionId}).

%% Direct ETS read — no gen_server round-trip.
-spec lookup(SessionId :: binary()) -> {ok, pid()} | {error, not_found}.
lookup(SessionId) ->
    case ets:lookup(?BY_ID, SessionId) of
        [{_, Pid}] -> {ok, Pid};
        []         -> {error, not_found}
    end.

-spec lookup_by_imsi(Imsi :: binary()) -> {ok, [binary()]} | {ok, []}.
lookup_by_imsi(Imsi) ->
    Ids = [SId || [SId] <- ets:match(?BY_IMSI, {{Imsi, '_'}, '$1'})],
    {ok, Ids}.

%%====================================================================
%% gen_server callbacks
%%====================================================================

init([]) ->
    ets:new(?BY_ID,   [named_table, public, set, {read_concurrency, true}]),
    ets:new(?BY_IMSI, [named_table, public, bag, {read_concurrency, true}]),
    {ok, #{}}.

handle_call(_Request, _From, State) ->
    {reply, {error, unknown_call}, State}.

handle_cast({register, SessionId, Pid}, State) ->
    ets:insert(?BY_ID, {SessionId, Pid}),
    %% Monitor so we can auto-clean on crash.
    erlang:monitor(process, Pid),
    {noreply, State#{Pid => SessionId}};

handle_cast({unregister, SessionId}, State) ->
    do_unregister_by_id(SessionId),
    NewState = maps:filter(fun(_Pid, SId) -> SId =/= SessionId end, State),
    {noreply, NewState};

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info({'DOWN', _Ref, process, Pid, _Reason}, State) ->
    case maps:find(Pid, State) of
        {ok, SessionId} ->
            do_unregister_by_id(SessionId),
            {noreply, maps:remove(Pid, State)};
        error ->
            {noreply, State}
    end;

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

%%====================================================================
%% Internal helpers
%%====================================================================

do_unregister_by_id(SessionId) ->
    ets:delete(?BY_ID, SessionId),
    %% Remove all BY_IMSI entries whose value is this session_id.
    ets:match_delete(?BY_IMSI, {'_', SessionId}).
