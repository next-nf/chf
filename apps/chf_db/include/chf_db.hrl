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

%% chf_db.hrl — Record definitions for Next-CHF database layer

-ifndef(CHF_DB_HRL).
-define(CHF_DB_HRL, true).

%% rating_group_config() type
-type rating_group_config() :: #{
    quota    => integer(),   %% default quota grant per request (micro-units)
    priority => integer()    %% priority level
}.

%% Subscriber record — keyed by IMSI, with secondary index on MSISDN
-record(subscriber, {
    imsi          :: binary(),                                        %% e.g. <<"001010000000001">>
    msisdn        :: binary(),                                        %% e.g. <<"491234567890">>
    account_id    :: binary(),                                        %% unique account identifier
    status        :: active | suspended | terminated,
    rating_groups :: #{non_neg_integer() => rating_group_config()},  %% RatingGroup => config
    created_at    :: integer(),                                       %% erlang:system_time(millisecond)
    updated_at    :: integer()
}).

%% Balance record — amounts in micro-units to avoid floating-point
-record(balance, {
    account_id :: binary(),
    total      :: integer(),   %% total balance in micro-units
    reserved   :: integer(),   %% currently reserved
    available  :: integer()    %% total - reserved
}).

%% Charging Data Record
-record(cdr, {
    id           :: binary(),   %% unique CDR ID
    session_id   :: binary(),
    imsi         :: binary(),
    type         :: online | offline | converged,
    rating_group :: non_neg_integer(),
    used_units   :: #{input => integer(), output => integer(), total => integer()},
    timestamp    :: integer(),
    metadata     :: map()
}).

%% Charging session — tracks granted/used units per RatingGroup
-record(charging_session, {
    session_id    :: binary(),
    imsi          :: binary(),
    type          :: online | offline | converged,
    state         :: initial | active | terminated,
    granted_units :: #{non_neg_integer() => integer()},   %% RatingGroup => granted
    used_units    :: #{non_neg_integer() => integer()},   %% RatingGroup => used
    created_at    :: integer(),
    updated_at    :: integer()
}).

-endif.
