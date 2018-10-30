# 0. Create alias for docker CLEOS
alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

# Ensure an open wallet
cd ~/f42/eos
echo "Enter wallet to use::"
read wallet

echo $wallet " :: pk=" $(cat .Pass) 
echo "Enter pk"
read pk

# Open Wallet
cleos wallet unlock -n $wallet --password $pk

#ask for account_name
echo "Enter account name::"
read account_name

# Create account using the public keys
#cleos create account eosio {account_name} {public_OwnerKey} {public_ActiveKey}
# "eosio" is the name of the account that creates the new account_name
cleos create account eosio $account_name $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)

# Display all accounts
cleos get accounts $(cat .OwnerKeys |grep Public |cut -d" " -f3)

cleos get account $account_name --json