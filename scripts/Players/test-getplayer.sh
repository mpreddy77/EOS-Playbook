# 0.1 Create alias for local testnet CLEOS
alias cleos='/usr/local/eosio/bin/cleos'

# 0.2 docker alias
#alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

# cleos push action {account} {action} {data}
# account - The account providing the contract to execute
# action - The action to execute on the contract
# data - The arguments to the contract
# use -d -j option to inspect transaction data

# cleos push action xavier getplayer '["xavier"]' -p xavier@active -d -j
cleos push action player getplayer '["anorak"]' -p anorak@active
cleos push action player getplayer '["wade"]' -p wade@active
cleos push action player getplayer '["reddy"]' -p reddy@active

#For good measure query the table
cleos get table player player player