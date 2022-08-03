require 'pg'
require 'pg_ext'

$yelbdbhost => "yelb-db"
$yelbdbport => 5432
$dbname => ENV['YELB_DB_NAME']
$db_user=> ENV['YELB_DB_USER']
$db_password => ENV['YELB_DB_PASSWORD']

con = PG.connect  :host => $yelbdbhost,
                      :port => $yelbdbport,
                      :dbname => $db_name,
                      :user => $db_user,
                      :password => $db_password
        con.prepare('statement1', 'SELECT count FROM restaurants WHERE name =  $1')
        res = con.exec_prepared('statement1', ["ihop"])
restaurantcount = res.getvalue(0,0)
con.close
print restaurantcount.to_s