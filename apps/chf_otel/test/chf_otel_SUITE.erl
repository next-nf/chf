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

-module(chf_otel_SUITE).
-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").
-export([all/0, init_per_suite/1, end_per_suite/1]).
-export([record_safe_before_setup/1, record_after_setup/1]).

all() -> [record_safe_before_setup, record_after_setup].

init_per_suite(Config) ->
    application:set_env(opentelemetry, span_processor, simple),
    application:set_env(opentelemetry, traces_exporter, none),
    application:set_env(opentelemetry, resource, #{service => #{name => <<"test">>}}),
    application:set_env(opentelemetry_experimental, readers,
                        [#{module => otel_metric_reader, config => #{}}]),
    Config.

end_per_suite(_Config) -> ok.

%% record_* must no-op (not crash) when setup_metrics/0 has not run
record_safe_before_setup(_Config) ->
    chf_otel:clear_metrics(),
    ?assertEqual(ok, chf_otel:record_charging_outcome(gy, success)),
    ?assertEqual(ok, chf_otel:record_balance_op(reserve, ok)),
    ok.

%% after setup, recording succeeds
record_after_setup(_Config) ->
    {ok, Started} = application:ensure_all_started(chf_otel),
    try
        ?assertEqual(ok, chf_otel:record_charging_outcome(gy, insufficient_balance)),
        ?assertEqual(ok, chf_otel:record_balance_op(commit, ok))
    after
        [application:stop(A) || A <- lists:reverse(Started)]
    end,
    ok.
