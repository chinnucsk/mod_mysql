-module(z_mydb).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

%% interface functions
-export([
        q/2,
        q/3,
        q_raw/2,
        q_raw/3
]).

-include_lib("zotonic.hrl").

q(Query,Context) ->
    q(Query,[],Context).
q(Query,Parameters,Context) ->
    EMySQLPool = list_to_atom(binary_to_list(m_config:get_value(mod_mysql, pool_name, Context))),
    emysql:prepare(zmydb_query,Query),
    {_,_,_,Result,_} = emysql:execute(EMySQLPool, zmydb_query, Parameters),
    Result.

q_raw(Query,Context) ->
    q_raw(Query,[],Context).
q_raw(Query,Parameters,Context) ->
    EMySQLPool = list_to_atom(binary_to_list(m_config:get_value(mod_mysql, pool_name, Context))),
    emysql:prepare(zmydb_query,Query),
    emysql:execute(EMySQLPool, zmydb_query, Parameters).

