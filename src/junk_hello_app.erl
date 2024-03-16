%%%-------------------------------------------------------------------
%% @doc junk_hello public API
%% @end
%%%-------------------------------------------------------------------

-module(junk_hello_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
	    {'_', [
		%{"/", cowboy_static, {priv_file, junk_hello, "static/index.html"}},
	        {"/", default_page_h, []}

	    ]}
	]),

	PrivDir = code:priv_dir(junk_hello),
	%tls stands for transport layer security
        {ok,_} = cowboy:start_tls(https_listener, [
                  		{port, 443},
				{certfile, PrivDir ++ "/ssl/fullchain.pem"},
				{keyfile, PrivDir ++ "/ssl/privkey.pem"}
              		], #{env => #{dispatch => Dispatch}}),
    junk_hello_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
