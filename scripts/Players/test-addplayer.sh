# 0.1 Create alias for local testnet CLEOS
alias cleos='/usr/local/eosio/bin/cleos'

# 0.2 Create alias for docker CLEOS
#alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

 #cleos push action {account} {action_name} '{data}' -p {account}@active
 cleos push action player add '["anorak","ArtEmis"]' -p anorak@active
 cleos push action player add '["wade","ParZival"]' -p wade@active
 cleos push action player add '["reddy","Goopy"]' -p reddy@active
 cleos push action player add '["eosio.token","EosTokenUser"]' -p eosio.token@active
cleos get table player player player