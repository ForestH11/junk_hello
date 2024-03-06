%%%-------------------------------------------------------------------
%% @doc junk_hello public API
%% @end
%%%-------------------------------------------------------------------

-module(junk_hello_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    io:format("Hello world!~nIt worked!~n",[]),
    junk_hello_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
