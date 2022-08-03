require 'pg'
require 'pg_ext'
require 'aws-sdk-dynamodb'

def restaurantsdbread(restaurant)
    if ($yelbddbrestaurants != nil && $yelbddbrestaurants != "") then
        dynamodb = Aws::DynamoDB::Client.new(region: $awsregion)
        params = {
            table_name: $yelbddbrestaurants,
            key: {
                name: restaurant
            }
        }
        restaurantrecord = dynamodb.get_item(params)
        restaurantcount = restaurantrecord.item['restaurantcount']
    else
    $log = $yelbdbhost.to_s + " " + $yelbdbport.to_s + " " + $db_name.to_s + " " + $db_user.to_s + " " + $db_password.to_s;
    File.write('/app/error.log', $log)
        con = PG.connect  :host => $yelbdbhost,
                        :port => $yelbdbport,
                        :dbname => $db_name,
                        :user => $db_user,
                        :password => $db_password
        con.prepare('statement1', 'SELECT count FROM restaurants WHERE name =  $1')
        res = con.exec_prepared('statement1', [ restaurant ])
        restaurantcount = res.getvalue(0,0)
        con.close
    end
    return restaurantcount.to_s
end 
