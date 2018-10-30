# 0. Create alias for docker CLEOS
#alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

# 0.1 Create alias for local testnet CLEOS
alias cleos='/usr/local/eosio/bin/cleos'

# 1. Create new wallet with the name "f42"
cleos wallet create -n f42 > .Pass

# 2. Generate two pair of keys (use the command twice)
cleos create key > .OwnerKeys
cleos create key > .ActiveKeys

# 3. Import the generated private keys in the wallet(you need to specify the wallet at the end)
# {private_key_1} - This will be the OwnerKey
# {private_key_2} - This will be the ActiveKey
#cleos wallet import {private_key_1} -n f42 
#cleos wallet import {private_key_2} -n f42 

cleos wallet import -n f42 --private-key=$(cat .OwnerKeys |grep Private |cut -d" " -f3)
cleos wallet import -n f42 --private-key=$(cat .ActiveKeys |grep Private |cut -d" " -f3)


# 4. Add the private key of the "eosio" account into your wallet
# Note: With the latest version of EOSIO the private key is automatically added to your wallet
echo 'Importing the default eosio account key'
cleos wallet import -n f42 --private-key=5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3

# 5. Display wallet, account, keys
echo 'Wallet list is:'
cleos wallet list

echo 'key list is:'
cleos wallet keys

