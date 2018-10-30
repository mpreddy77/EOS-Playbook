# 0. Create alias for docker CLEOS
alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

# Create the account using the public keys
#cleos create account eosio anorak {public_OwnerKey} {public_ActiveKey}
cleos create account eosio hello.codes $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos get info
cleos get accounts $(cat .OwnerKeys |grep Public |cut -d" " -f3)
