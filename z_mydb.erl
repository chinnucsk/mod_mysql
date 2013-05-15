-module(z_mydb).
-author("Kirill Sysoev <kirill.sysoev@gmail.com>").

%% interface functions
-export([
        q/2,
        q/3
]).

-include_lib("zotonic.hrl").

q(Query,Context) ->
    q(Query,[],Context).
q(Query,Parameters,Context) ->
    EMySQLPool = binary_to_list(m_config:get_value(mod_mysql, pool_name, Context)),
    emysql:prepare(zmydb_query,Query),
    {_,_,_,Result,_} = emysql:execute(EMySQLPool, zmydb_query, Parameters),
    Result.
