# 0.0 Docker alias for CLEOS
#alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

# 0.1 Create alias for local testnet CLEOS
alias cleos='/usr/local/eosio/bin/cleos'

# add product # Magic ball
 cleos push action market add '{"account":"market","newProduct":{"product_id":1,"name":"magic ball","power":120,"health":10,"ability":"see the future","level_up":3,"quantity":999,"price":150}}' -p market@active

# test getbyid
cleos push action market getbyid '[1]' -p market

# Elf's potion
cleos push action market add '{"account":"market","newProduct":{"product_id":2,"name":"elf’s potion","power":50,"health":300,"ability":"heal fast","level_up":0,"quantity":999,"price":350}}' -p market@active

# Update potion quantity to 5000
cleos push action market update '["market",1,5000]' -p market
cleos push action market update '["market",2,5000]' -p market
cleos push action market update '["market",3,5000]' -p market

cleos push action market getbyid '[2]' -p market

# Orb of Osuvox
cleos push action market add '{"account":"market","newProduct":{"product_id":3,"name":"Orb of Osuvox","power":5000,"health":300,"ability":"","level_up":0,"quantity":999,"price":3250}}' -p market@active

# For good measure query the table
cleos get table market market product