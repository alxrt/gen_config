%%%-------------------------------------------------------------------
%%% @author alxrt
%%% @copyright (C) 2014, alxrt@icloud.com
%%% @doc
%%%
%%% @end
%%% Created : 04. ноя 2014 17:02
%%%-------------------------------------------------------------------

-module(gen_config_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    gen_config_sup:start_link().

stop(_State) ->
    ok.
