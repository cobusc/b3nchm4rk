%% @author author <author@example.com>
%% @copyright YYYY author.

%% @doc Callbacks for the b3nchm4rk application.

-module(b3nchm4rk_app).
-author('author <author@example.com>').

-behaviour(application).
-export([start/2,stop/1]).


%% @spec start(_Type, _StartArgs) -> ServerRet
%% @doc application start callback for b3nchm4rk.
start(_Type, _StartArgs) ->
    b3nchm4rk_sup:start_link().

%% @spec stop(_State) -> ServerRet
%% @doc application stop callback for b3nchm4rk.
stop(_State) ->
    ok.
