%%%-------------------------------------------------------------------
%%% @author alxrt
%%% @copyright (C) 2014, alxrt@icloud.com
%%% @doc
%%%
%%% @end
%%% Created : 04. ноя 2014 17:02
%%%-------------------------------------------------------------------
-module(gen_config).
-author("alxrt").
-include("gen_config.hrl").
%% API
-export([load/1,g/1,get_value/1]).

-spec load/1 :: (Filename :: list()) -> ok|{error,Error :: term()}.
load(Filename) when is_list(Filename) ->
  gen_server:call(?SERVER,{load,Filename}).

-spec g/1 :: (Key :: list()|term()) -> {ok,Value::term()}|{error,Error:: term()}.
g(Key) ->
  gen_server:call(?SERVER,{get,Key}).

-spec get_value/1 :: (Key :: list()|term()) -> Value :: term().
get_value(Key) ->
  {ok,Value} = g(Key),
  Value.