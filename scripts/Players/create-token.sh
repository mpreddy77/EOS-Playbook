# setup alias for docker CLEOS
#alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

# setup alias for local testnet CLEOS
alias cleos='/usr/local/eosio/bin/cleos'

#create 1M SYS/EOS tokens for testing
cleos push action eosio.token create '{"issuer":"eosio.token","maximum_supply":"1000000.0000 EOS","can_freeze":"0","can_recall":"0","can_whitelist":"0"}' -p eosio.token
cleos push action eosio.token create '{"issuer":"eosio.token","maximum_supply":"1000000.0000 SYS","can_freeze":"0","can_recall":"0","can_whitelist":"0"}' -p eosio.token
cleos get table eosio.token eosio.token accounts
