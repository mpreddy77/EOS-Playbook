# 0. Create alias for docker CLEOS
#alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

# 0. Create alias for local testnet CLEOS
alias cleos='/usr/local/eosio/bin/cleos'

# Create the account using the public keys
#cleos create account eosio anorak {public_OwnerKey} {public_ActiveKey}

# Get private key for opening wallet
echo "Private key ->" $(cat .Pass) 

#open wallet if locked
cleos wallet unlock -n f42 --password $(cat .Pass |grep Private |cut -d" " -f3)

# create anorak(for deploying players contract) and other accounts for players
cleos create account eosio exchange $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio player $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio anorak $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio wade $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio reddy $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio eosio.token $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio market $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio bidadvatar $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)

cleos get info
cleos get accounts $(cat .OwnerKeys |grep Public |cut -d" " -f3)
# "eosio" is the name of the account who will create the new account
# "player" is the name of the new account and deployer of Players contract
