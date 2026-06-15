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

%% chf_otel.erl — OpenTelemetry instruments for the charging business path.
%%
%% The protocol/HTTP/VM layers are instrumented by the OTEL libraries
%% (opentelemetry_diameter, opentelemetry_cowboy_*, opentelemetry_beam). The two
%% instruments here capture chf-specific charging *decisions* the libraries
%% cannot know about. Handles are cached in persistent_term; the record_*
%% helpers no-op silently if setup_metrics/0 has not run, so a missing metrics
%% subsystem never fails a charging request.
%%
%% API note: this build's otel_counter:add/5 takes (Ctx, Meter, Name, N, Attrs)
%% so we cache {Meter, Name} pairs rather than the instrument handle directly.
-module(chf_otel).
-export([setup_metrics/0, clear_metrics/0,
         record_charging_outcome/2, record_balance_op/2]).

-define(OUTCOME, {?MODULE, charging_outcome}).
-define(BALANCE, {?MODULE, balance_operation}).

%% opentelemetry_experimental:get_meter/1 has an over-narrow success typing in
%% this (experimental) build, which makes dialyzer believe setup_metrics/0 never
%% returns and cascades into chf_otel_app. The code is correct; suppress here.
-dialyzer({nowarn_function, [setup_metrics/0]}).

-spec setup_metrics() -> ok.
setup_metrics() ->
    Meter = opentelemetry_experimental:get_meter(?MODULE),
    _Outcome = otel_meter:create_counter(Meter, 'gy.charging.outcome',
                #{description => <<"Charging decisions by outcome and interface">>, unit => '1'}),
    _Balance = otel_meter:create_counter(Meter, 'chf.balance.operation',
                #{description => <<"Balance operations by op and result">>, unit => '1'}),
    persistent_term:put(?OUTCOME, {Meter, 'gy.charging.outcome'}),
    persistent_term:put(?BALANCE, {Meter, 'chf.balance.operation'}),
    ok.

-spec clear_metrics() -> ok.
clear_metrics() ->
    _ = persistent_term:erase(?OUTCOME),
    _ = persistent_term:erase(?BALANCE),
    ok.

-spec record_charging_outcome(Interface :: atom(), Outcome :: atom()) -> ok.
record_charging_outcome(Interface, Outcome) ->
    case persistent_term:get(?OUTCOME, undefined) of
        undefined -> ok;
        {Meter, Name} ->
            _ = otel_counter:add(otel_ctx:get_current(), Meter, Name, 1,
                                 #{'charging.interface' => Interface, 'charging.outcome' => Outcome}),
            ok
    end.

-spec record_balance_op(Op :: atom(), Result :: atom()) -> ok.
record_balance_op(Op, Result) ->
    case persistent_term:get(?BALANCE, undefined) of
        undefined -> ok;
        {Meter, Name} ->
            _ = otel_counter:add(otel_ctx:get_current(), Meter, Name, 1,
                                 #{'balance.op' => Op, 'balance.result' => Result}),
            ok
    end.
