%% chf_api_json.erl — JSON encode/decode helpers for the 5G CHF REST API.
%%
%% Implements the TS 32.291 atom vocabulary using Erlang/OTP 27+ built-in
%% `json` module, following the same pattern as chf_provision_json.
-module(chf_api_json).

-export([decode/1, encode/1, ensure_atoms/0]).

%%====================================================================
%% Atom seeding — must exist before binary_to_existing_atom is called.
%%====================================================================

%% @doc Force atom creation so binary_to_existing_atom/2 works for known keys.
-spec ensure_atoms() -> ok.
ensure_atoms() ->
    _ = [
        %% ChargingDataRequest/Response fields
        subscriberIdentifier, nfConsumerIdentification,
        invocationTimeStamp, invocationSequenceNumber,
        retransmissionIndicator, oneTimeEvent,
        multipleUnitUsage, triggers, chargingId,

        %% MultipleUnitUsage
        ratingGroup, requestedUnit, usedUnitContainer,

        %% RequestedUnit / UsedUnitContainer
        totalVolume, uplinkVolume, downlinkVolume,
        serviceSpecificUnits, time,

        %% Response fields
        invocationResult, sessionFailover,
        multipleUnitInformation,

        %% MultipleUnitInformation
        grantedUnit, resultCode, finalUnitIndication,
        validityTime,

        %% SubscriberIdentifier
        sUPI, gPSI,

        %% NfConsumerIdentification
        nFName, nFIPv4Address, nFIPv6Address, nFPLMNID,
        nodeFunctionality,

        %% Error/Problem details
        type, title, status, detail, cause, instance,
        invalidParams, param, reason
    ],
    ok.

%%====================================================================
%% Decode
%%====================================================================

%% @doc Decode a JSON binary, converting known keys to atoms.
%%
%% Returns {DecodedTerm, RestBinary, Acc} as returned by json:decode/3.
-spec decode(binary()) -> {term(), binary(), term()}.
decode(Bin) ->
    json:decode(Bin, [], #{
        object_start  => fun(_Acc) -> [] end,
        object_push   => fun(Key, Value, Acc) ->
            AtomKey = try binary_to_existing_atom(Key, utf8)
                      catch error:badarg -> Key
                      end,
            [{AtomKey, Value} | Acc]
        end,
        object_finish => fun(Acc, OldAcc) ->
            {maps:from_list(Acc), OldAcc}
        end
    }).

%%====================================================================
%% Encode
%%====================================================================

%% @doc Encode an Erlang term to a JSON binary.
-spec encode(term()) -> binary().
encode(Term) ->
    iolist_to_binary(json:encode(Term)).
