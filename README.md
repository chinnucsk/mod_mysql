mod_mysql
=========

Do not forget to add:
- zotonic/rebar.config:  {emysql, ".*", {git, "git://github.com/Eonblast/Emysql.git", {branch, "master"}}}
- zotonic/ebin/zotonic.app:  {applications, [ ...., mimetypes, webzmachine, z_stdlib, emysql]}
