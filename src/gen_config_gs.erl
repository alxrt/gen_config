%%%-------------------------------------------------------------------
%%% @author alxrt
%%% @copyright (C) 2014, alxrt@icloud.com
%%% @doc
%%%
%%% @end
%%% Created : 04. ноя 2014 17:17
%%%-------------------------------------------------------------------
-module(gen_config_gs).
-author("alxrt").
-include("gen_config.hrl").
-behaviour(gen_server).

%% API
-export([start_link/0]).

%% gen_server callbacks
-export([init/1,
  handle_call/3,
  handle_cast/2,
  handle_info/2,
  terminate/2,
  code_change/3]).


-record(state, {
  filename = ?DEFAULT_CONFIG :: string(),
  config = [] :: list(),
  ready = false :: boolean() % Отметка о готовности
}).

%%%===================================================================
%%% API
%%%===================================================================

start_link() ->
  gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([]) ->
  case file:consult(?DEFAULT_CONFIG) of
    {ok,Config} ->
      {ok,#state{config = Config, ready = true}};
    _ -> {ok,#state{}}
  end.

handle_call({get,_}, _From, #state{ready = false}) ->
  {reply,{error,not_ready},#state{}};

handle_call({get,Path}, _From, State) when is_list(Path) ->
  case deepprops:get(Path,State#state.config) of
    undefined -> {reply,undefined,State};
    Value -> {reply,{ok,Value},State}
  end;

handle_call({get,Key}, _From, State) ->
  case proplists:get_value(Key,State#state.config) of
    undefined -> {reply,undefined,State};
    Value -> {reply,{ok,Value},State}
  end;


handle_call({load,Filename}, _From, State) when is_list(Filename) ->
  case file:consult(Filename) of
    {ok,Config} ->
      {reply,ok,#state{config = Config, filename = Filename, ready = true}};
    Error ->
      {reply,{error,Error},State}
  end;

handle_call(_Request, _From, State) ->
  {reply, {error,invalid_command}, State}.

handle_cast(_Request, State) ->
  {noreply, State}.

handle_info(_Info, State) ->
  {noreply, State}.

terminate(_Reason, _State) ->
  ok.

code_change(_OldVsn, State, _Extra) ->
  {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
