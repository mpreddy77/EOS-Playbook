# 0. Create alias for local testnet CLEOS
alias cleos='/usr/local/eosio/bin/cleos'

# alias for docker
# alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

# add ability to username identified by the account
cleos push action player addability '["anorak","shapeshifting"]' -p anorak@active
cleos push action player addability '["wade","transmogrifying"]' -p wade@active
cleos push action player addability '["reddy","cloakofinvincibility"]' -p reddy@active

#For good measure query the table
cleos get table player player player