require 'pg'
require 'pg_ext'

con = PG.connect("
	host=rc1a-hmyn7mdjd7w9jtoa.mdb.yandexcloud.net
	port=6432
	dbname=mydb
	user=mydb
	password=$db_password
	target_session_attrs=read-write
")

con.prepare('statement1', 'SELECT count FROM restaurants WHERE name =  $1')
res = con.exec_prepared('statement1', ["ihop"])
restaurantcount = res.getvalue(0,0)
con.close
print restaurantcount.to_s