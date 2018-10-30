# docker alias
#alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

# local testnet alias
alias cleos='/usr/local/eosio/bin/cleos'

cleos push action player update '["anorak",4,75,200]' -p anorak@active

#For good measure query the table
cleos get table player player player