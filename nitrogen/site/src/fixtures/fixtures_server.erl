-module(fixtures_server).

-behaviour(gen_server).

-export([start_link/0, init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-export([get_fixtures/0,reload/0]).

%%
%% @doc Category-related information 
%%
-record(category, {key :: non_neg_integer(),
                   display_value :: binary(),
                   description :: binary()
                  }).
-type category() :: #category{}.

%%
%% @doc List of categories
%%
-type category_list() :: list(#category{}).

%%
%% @doc A collection of fixtures
%%
-record(all_fixtures, {asset_categories = [] :: category_list(),
                       liability_categories = [] :: category_list()
                      }).
-type all_fixtures() :: #all_fixtures{}.

-export_type([category/0, category_list/0, all_fixtures/0]).

-define(POOL, default_pool). % @todo Define in header file

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

%%
%% @doc Get all the fixtures
%%
-spec get_fixtures() -> {ok, all_fixtures()}.

get_fixtures() ->
    gen_server:call(?MODULE, get_fixtures).

%%
%% @doc Reload the fixtures from the database
%%
-spec reload() -> ok.

reload() ->
    {ok, AllFixtures} = load_all_fixtures(),
    gen_server:call(?MODULE, {reload, AllFixtures}).


%%
%% @doc Bootstrap the gen_server
%%
-spec init(_::any()) -> {ok, all_fixtures()}.

init(_) ->
    load_all_fixtures().

%%
%% gen-server behaviour implementation
%%

handle_call(get_fixtures, _From, State) ->
    {reply, {ok, State}, State};

handle_call({reload, AllFixtures}, _From, _State) ->
    {reply, ok, AllFixtures}.

handle_cast(_, State) ->
    {noreply, State}.

handle_info(_, State) ->
    {noreply, State}.

terminate(normal, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {noreply, State}.


%%
%% @doc Load all fixtures from the database
%%
%% This function calls the individual queries to build up a complete fixture representation
%%
-spec load_all_fixtures() -> {ok, all_fixtures()} | error.

load_all_fixtures() ->
    {ok, AssetCategories} = load_asset_categories(),
    {ok, LiabilityCategories} = load_liability_categories(),
    AllFixtures = #all_fixtures{asset_categories=AssetCategories,
                                liability_categories=LiabilityCategories},
    {ok, AllFixtures}.

%%
%% @doc Load the asset categories
%%
-spec load_asset_categories() -> {ok, category_list()}.

load_asset_categories() ->
    load_categories(<<"asset_category">>).

%%
%% @doc Load the liability categories
%%
-spec load_liability_categories() -> {ok, category_list()}.

load_liability_categories() ->
    load_categories(<<"liability_category">>).

%%
%% @doc Helper function to load category tables
%%
-spec load_categories(TableName::binary()|string()) -> {ok, category_list()}.

load_categories(TableName) ->
    {ok, Con} = pgsql_pool:get_connection(?POOL, 1000),
    Sql = [<<"SELECT id, name, description FROM ">>, TableName],
    {ok, _Cols, AssetCategories} = pgsql:equery(Con, Sql, []),
    ok = pgsql_pool:return_connection(?POOL, Con),
    {ok, AssetCategories}.



