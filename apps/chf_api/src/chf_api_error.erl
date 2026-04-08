%% chf_api_error.erl — RFC 7807 Problem Details helper for the 5G CHF REST API.
%%
%% Builds and sends application/problem+json responses as required by
%% 3GPP TS 32.291 and RFC 7807.
-module(chf_api_error).

-export([problem_details/3, reply_error/4]).

%%====================================================================
%% API
%%====================================================================

%% @doc Build an RFC 7807 Problem Details JSON body.
%%
%% problem_details(Status, Title, Detail) -> binary()
-spec problem_details(non_neg_integer(), binary(), binary()) -> binary().
problem_details(Status, Title, Detail) ->
    chf_api_json:encode(#{
        <<"type">>   => <<"about:blank">>,
        <<"title">>  => Title,
        <<"status">> => Status,
        <<"detail">> => Detail
    }).

%% @doc Send an RFC 7807 Problem Details HTTP response.
%%
%% reply_error(Status, Title, Detail, Req) -> Req2
-spec reply_error(non_neg_integer(), binary(), binary(), cowboy_req:req()) ->
    cowboy_req:req().
reply_error(Status, Title, Detail, Req) ->
    Body = problem_details(Status, Title, Detail),
    cowboy_req:reply(Status,
        #{<<"content-type">> => <<"application/problem+json">>},
        Body, Req).
