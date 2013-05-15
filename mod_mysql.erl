-module(mod_mysql).
-author("Kirill Sysoev <iam@onnet.su>").

-behaviour(gen_server).

-mod_title("MySQL connection").
-mod_description("Provides connection to MySQL database.").
-mod_prio(500).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/1]).

-include_lib("zotonic.hrl").
-record(state, {context}).

%% Module API

start_link(Args) when is_list(Args) ->
    gen_server:start_link(?MODULE, Args, []).

%% gen_server callbacks

init(Args) ->
    {context, Context} = proplists:lookup(context, Args),
    EMySQLPool = binary_to_list(m_config:get_value(mod_mysql, pool_name, Context)),
    MySQLHost = binary_to_list(m_config:get_value(mod_mysql, host, Context)),
    MySQLDB = binary_to_list(m_config:get_value(mod_mysql, db_name, Context)),
    MySQLUser = binary_to_list(m_config:get_value(mod_mysql, user, Context)),
    MySQLPwd = binary_to_list(m_config:get_value(mod_mysql, password, Context)),
    emysql:add_pool(EMySQLPool, 1, MySQLUser, MySQLPwd, MySQLHost, 3306, MySQLDB, utf8),
    {ok, #state{context=z_context:new(Context)}}.

handle_call(Message, _From, State) ->
    {stop, {unknown_call, Message}, State}.

handle_cast(Message, State) ->
    {stop, {unknown_cast, Message}, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
