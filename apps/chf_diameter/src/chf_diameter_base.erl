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

%% chf_diameter_base.erl — Callback for the RFC 6733 base (common) Diameter
%% application (App-Id 0).
%%
%% Registering RFC 6733 as the `common` application is the org convention
%% (see nf-architecture diameter.md §1): it makes the service use the RFC 6733
%% base rather than OTP's RFC 3588 default, so the stack may emit 5xxx
%% permanent-failure Result-Codes in answers.
%%
%% Base-protocol housekeeping (CER/CEA, DWR/DWA, DPR/DPA) is handled by the OTP
%% diameter stack itself; these callbacks are stubs. The CHF never originates
%% base requests, and any base request reaching the callback is discarded.
-module(chf_diameter_base).

-include_lib("kernel/include/logger.hrl").

-export([peer_up/3, peer_down/3, pick_peer/4,
         prepare_request/3, prepare_retransmit/3,
         handle_answer/4, handle_error/4, handle_request/3]).

peer_up(_SvcName, _Peer, State)   -> State.
peer_down(_SvcName, _Peer, State) -> State.

pick_peer([], _, _SvcName, _State) -> false.

prepare_request(_, _SvcName, _Peer)    -> {discard, not_a_client}.
prepare_retransmit(_, _SvcName, _Peer) -> {discard, not_a_client}.

handle_answer(_, _, _SvcName, _Peer) -> ok.

handle_error(Reason, _Req, _SvcName, _Peer) ->
    ?LOG_WARNING("Base diameter error: ~p", [Reason]),
    ok.

handle_request(_Packet, _SvcName, _Peer) -> discard.
