# Create alias for local testnet CLEOS
alias cleos='/usr/local/eosio/bin/cleos'

# alias for docker local testnet
# alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

# you'd see the following error on trying to buy -- requires appropriate permissioning of buyer to contract
#Ensure that you have the related authority inside your transaction!;
#If you are currently using 'cleos push action' command, try to add the relevant authority using -p option.
#All players must set permission eosio.code for this smart contract. If this contract is uploaded to account market and user wants to set the permission:
#tcleos set account permission user active \
#'{"threshold": 1,
#  "keys": [{
#    "key": "PUBKEY_OF_user",
#    "weight": 1
#  }],
#  "accounts": [{
#    "permission": {"actor": "market",
#                   "permission": "eosio.code"},
#                   "weight": 1
#  }]}' owner -p user

#cleos set account permission reddy active '{"threshold":1, "keys":[{"key":"EOS819Z3ri1g7NUyZEnA5jyrFXw4joabtwcGWVqp41GLFLTtdE6p7", "weight":1}], "accounts": [{"permission":{"actor":"eosio.token","permission":"eosio.code"},"weight":1}]}' owner -p reddy
cleos set account permission anorak active '{"threshold":1, "keys":[{"key":"EOS819Z3ri1g7NUyZEnA5jyrFXw4joabtwcGWVqp41GLFLTtdE6p7", "weight":1}], "accounts": [{"permission":{"actor":"market","permission":"eosio.code"},"weight":1}]}' owner -p anorak
cleos set account permission wade active '{"threshold":1, "keys":[{"key":"EOS819Z3ri1g7NUyZEnA5jyrFXw4joabtwcGWVqp41GLFLTtdE6p7", "weight":1}], "accounts": [{"permission":{"actor":"market","permission":"eosio.code"},"weight":1}]}' owner -p wade
cleos set account permission reddy active '{"threshold":1, "keys":[{"key":"EOS819Z3ri1g7NUyZEnA5jyrFXw4joabtwcGWVqp41GLFLTtdE6p7", "weight":1}], "accounts": [{"permission":{"actor":"market","permission":"eosio.code"},"weight":1}]}' owner -p reddy
cleos set account permission player active '{"threshold":1, "keys":[{"key":"EOS819Z3ri1g7NUyZEnA5jyrFXw4joabtwcGWVqp41GLFLTtdE6p7", "weight":1}], "accounts": [{"permission":{"actor":"market","permission":"eosio.code"},"weight":1}]}' owner -p player



# Buy product from Marketplace {username} {productid}
cleos push action market buy '["anorak",1]' -p anorak
cleos push action market buy '["wade",2]' -p wade
cleos push action market buy '["reddy",3]' -p reddy
cleos push action market buy '["player",3]' -p player

# For good measure query the market table
cleos get table market market product

# Query user table
cleos get table player player player

# show balances
cleos get table eosio.token player accounts
cleos get table eosio.token market accounts
cleos get table eosio.token anorak accounts
cleos get table eosio.token wade accounts
cleos get table eosio.token reddy accounts
cleos get table eosio.token eosio.token accounts
