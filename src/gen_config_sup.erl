%%%-------------------------------------------------------------------
%%% @author alxrt
%%% @copyright (C) 2014, alxrt@icloud.com
%%% @doc
%%%
%%% @end
%%% Created : 04. ноя 2014 17:02
%%%-------------------------------------------------------------------

-module(gen_config_sup).
-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    C = ?CHILD(gen_config_gs,worker),
    {ok, { {one_for_one, 5, 10}, [C]} }.

