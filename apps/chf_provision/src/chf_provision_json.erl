%% chf_provision_json.erl — JSON encode/decode helpers for the provisioning API.
%%
%% Uses Erlang/OTP 27+ built-in `json` module.
-module(chf_provision_json).

-include_lib("chf_db/include/chf_db.hrl").

-export([decode/1, encode/1]).
-export([ensure_atoms/0]).
-export([encode_subscriber/1, encode_balance/1]).

%%====================================================================
%% Atom seeding — must exist before binary_to_existing_atom is called.
%%====================================================================

%% @doc Force atom creation so binary_to_existing_atom/2 works for known keys.
-spec ensure_atoms() -> ok.
ensure_atoms() ->
    _ = [imsi, msisdn, account_id, status, rating_groups, quota, priority,
         total, reserved, available, amount, error, message, active,
         suspended, terminated, created_at, updated_at],
    ok.

%%====================================================================
%% Decode
%%====================================================================

%% @doc Decode a JSON binary, converting known keys to atoms.
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

%%====================================================================
%% Record → map helpers
%%====================================================================

%% @doc Encode a #subscriber{} record to a JSON binary.
-spec encode_subscriber(#subscriber{}) -> binary().
encode_subscriber(#subscriber{
        imsi          = Imsi,
        msisdn        = Msisdn,
        account_id    = AccountId,
        status        = Status,
        rating_groups = RatingGroups,
        created_at    = CreatedAt,
        updated_at    = UpdatedAt}) ->
    Map = #{
        <<"imsi">>          => Imsi,
        <<"msisdn">>        => Msisdn,
        <<"account_id">>    => AccountId,
        <<"status">>        => atom_to_binary(Status, utf8),
        <<"rating_groups">> => encode_rating_groups(RatingGroups),
        <<"created_at">>    => CreatedAt,
        <<"updated_at">>    => UpdatedAt
    },
    encode(Map).

%% @doc Encode a #balance{} record to a JSON binary.
-spec encode_balance(#balance{}) -> binary().
encode_balance(#balance{
        account_id = AccountId,
        total      = Total,
        reserved   = Reserved,
        available  = Available}) ->
    Map = #{
        <<"account_id">> => AccountId,
        <<"total">>      => Total,
        <<"reserved">>   => Reserved,
        <<"available">>  => Available
    },
    encode(Map).

%%====================================================================
%% Internal helpers
%%====================================================================

%% Convert #{integer() => rating_group_config()} to #{binary() => map()}
%% so that json:encode/1 can handle it (map keys must be binaries/atoms/integers).
encode_rating_groups(RatingGroups) when is_map(RatingGroups) ->
    maps:fold(fun(RgId, Config, Acc) ->
        Key = integer_to_binary(RgId),
        Acc#{Key => encode_rg_config(Config)}
    end, #{}, RatingGroups);
encode_rating_groups(_) ->
    #{}.

encode_rg_config(Config) when is_map(Config) ->
    %% Config may contain quota and/or priority — both integers.
    maps:fold(fun(K, V, Acc) ->
        BinKey = if is_atom(K) -> atom_to_binary(K, utf8);
                    is_binary(K) -> K;
                    true -> term_to_binary(K)
                 end,
        Acc#{BinKey => V}
    end, #{}, Config);
encode_rg_config(_) ->
    #{}.
