# 0. Create alias for docker CLEOS
#alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

# 0. Create alias for local testnet CLEOS
alias cleos='/usr/local/eosio/bin/cleos'

# Create the account using the public keys
#cleos create account eosio exchange {public_OwnerKey} {public_ActiveKey}

#open wallet if locked
#cleos wallet unlock -n f42 --password $(cat .Pass |grep Private |cut -d" " -f3)

#1 Local Testnet
# Create Test Accounts
# exchange account for contract owner, ledger account for the ledger, maker/taker 3 accounts each
cleos create account eosio exchange $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio ledger $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio maker1 $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio maker2 $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio maker3 $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio taker1 $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio taker2 $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio taker3 $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)

# Check Accounts
cleos get accounts $(cat .OwnerKeys |grep Public |cut -d" " -f3)


# Use the deployed eosio.token account to distribute 100000 EOS to makers and takers
cleos push action eosio.token issue '{"to":"maker1","quantity":"100000.0000 EOS","memo":"Initial Bonus for Signup"}' -p eosio.token
cleos push action eosio.token issue '{"to":"maker2","quantity":"100000.0000 EOS","memo":"Initial Bonus for Signup"}' -p eosio.token
cleos push action eosio.token issue '{"to":"maker3","quantity":"100000.0000 EOS","memo":"Initial Bonus for Signup"}' -p eosio.token
cleos push action eosio.token issue '{"to":"taker1","quantity":"100000.0000 EOS","memo":"Initial Bonus for Signup"}' -p eosio.token
cleos push action eosio.token issue '{"to":"taker2","quantity":"100000.0000 EOS","memo":"Initial Bonus for Signup"}' -p eosio.token
cleos push action eosio.token issue '{"to":"taker3","quantity":"100000.0000 EOS","memo":"Initial Bonus for Signup"}' -p eosio.token

# Check balances
cleos get table eosio.token exchange accounts
cleos get table eosio.token ledger accounts
cleos get table eosio.token maker1 accounts
cleos get table eosio.token taker1 accounts

# Get Currency Stats
cleos get currency stats eosio.token EOS
mcleos get currency stats everipediaiq IQ

# Get Currency Balance
cleos get currency balance eosio.token exchange EOS
cleos get currency balance eosio.token ledger EOS
cleos get currency balance eosio.token maker1 EOS
cleos get currency balance eosio.token taker1 EOS


# Use account exchange to deploy contract
# CMD-D
# Validate deploy was successfull
cleos get code exchange
# code hash: d1fa5beb47952dfcaa01a472b39db1074e1d6cff3bb7f4e51128e317d6581170


# Exchange Contract Tests
# Deposit/Withdraw
cleos transfer reddy exchange "1.1234 EOS" deposit -p reddy
cleos transfer exchange reddy "1.0000 EOS" withdraw -p exchange

# add some EOS derivative tokens
cleos transfer maker1 exchange "10.0000 SYS" deposit -p maker1
cleos transfer taker1 exchange "10.0000 SYS" deposit -p taker1

# Test balances for Deposit/Withdraw
cleos get table eosio.token exchange  accounts
cleos get table eosio.token reddy  accounts

# Using explicit exchange function for deposit/withdraw
# Need to enable permissioning from user to contract
# To use this function, all EOS account holders must set permission eosio.code for exchange contract. If this contract is uploaded to account exchange and user wants to set the permission:
cleos set account permission user active \
'{"threshold": 1,
  "keys": [{
    "key": "PUBKEY_OF_user",
    "weight": 1
  }],
  "accounts": [{
    "permission": {"actor": "exchange",
                   "permission": "eosio.code"},
                   "weight": 1
  }]}' owner -p user

# Set permissions@active
cleos set account permission reddy active '{"threshold":1, "keys":[{"key":"EOS819Z3ri1g7NUyZEnA5jyrFXw4joabtwcGWVqp41GLFLTtdE6p7", "weight":1}], "accounts": [{"permission":{"actor":"exchange","permission":"eosio.code"},"weight":1}]}' owner -p reddy

cleos set account permission exchange active '{"threshold":1, "keys":[{"key":"EOS819Z3ri1g7NUyZEnA5jyrFXw4joabtwcGWVqp41GLFLTtdE6p7", "weight":1}], "accounts": [{"permission":{"actor":"exchange","permission":"eosio.code"},"weight":1}]}' owner -p exchange

# Deposit
cleos push action exchange deposit '{"from":"reddy","quantity": {"quantity": "0.0001 EOS", "contract": "eosio.token"}}' -p reddy exchange
cleos get table eosio.token exchange accounts
cleos get table eosio.token reddy accounts


# Withdraw
cleos push action exchange withdraw '{"from":"reddy","quantity": {"quantity": "0.0001 EOS", "contract": "eosio.token"}}' -p reddy exchange
cleos get table eosio.token exchange accounts
cleos get table eosio.token reddy accounts


# Getbalances
cleos push action exchange getbalances '{"owner":"reddy"}' -p reddy

# Trade

#{
#  "amountbuy": "1000",
#  "amountsell": "1000",
#  "nonce": "1234",
#  "amount": 1000,
#  "tradenonce": "1234",
#  "tokenbuy": {
#    "quantity": "1.0000 AURA",
#    "contract": "eosio.token"
#  },
#  "tokensell": {
#    "quantity": "1.0000 EOS",
#    "contract": "eosio.token"
#  },
#  "makerfee": "1.0",
#  "takerfee": "3.0",
#  "maker": "maker1",
#  "taker": "taker1",
#  "feeaccount": "ledger"
#}

# Deposit some tokens -- testmaker and testtaker -- EOS and SYS
cleos transfer maker1 exchange "10.0000 EOS" deposit -p maker1
cleos transfer taker1 exchange "10.0000 EOS" deposit -p taker1

cleos transfer maker1 exchange "10.0000 SYS" deposit -p maker1
cleos transfer taker1 exchange "10.0000 SYS" deposit -p taker1

cleos push action exchange trade '{"amountbuy":"10","amountsell":"10","nonce":"1","amount":"10","tradenonce":"1","tokenbuy":{"quantity":"1.0000 SYS","contract":"eosio.token"},"tokensell":{"quantity":"1.0000 EOS","contract":"eosio.token"},"makerfee":"16","takerfee":"26","maker":"maker1","taker":"taker1","feeaccount":"ledger"}' -p  exchange ledger

#New fees account balance for ledger, symbol 4,SYS@eosio.token = 26, symbol 4,EOS@eosio.token = 16

# get balances of taker1,maker1,exchange,ledger
cleos push action exchange getbalances '{"owner":"reddy"}' -p reddy --json
cleos push action exchange getbalances '{"owner":"reddy"}' -p reddy

cleos push action exchange getbalances '{"owner":"maker1"}' -p maker1

cleos push action exchange getbalances '{"owner":"taker1"}' -p taker1

cleos push action exchange getbalances '{"owner":"exchange"}' -p exchange

cleos push action exchange getbalances '{"owner":"ledger"}' -p ledger



