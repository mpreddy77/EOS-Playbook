#!/bin/bash
alias cleos='/usr/local/eosio/bin/cleos'
thisScriptDir="$( cd "$( echo "${BASH_SOURCE[0]%/*}/" )"; pwd )"
eos_working_directory='/tmp/eosio'

echo "Current cwd -> " $thisScriptDir

cd $eos_working_directory/eos

# Deploy exchange contract
echo "Deployin exchange contract..."
cleos set contract exchange contracts/exchange/ build/contracts/exchange/exchange.wast contracts/exchange/exchange.abi

# Verify if deploy was successfull
cleos get code exchange

# Action Tests
# Check balances on taker1 and maker1 accounts
cleos get table eosio.token maker1 accounts
cleos get table eosio.token taker1 accounts
cleos get table eosio.token reddy accounts

# Deposit
cleos transfer maker1 exchange "1.1234 EOS" deposit -p maker1
cleos transfer taker1 exchange "1.1234 EOS" deposit -p taker1

# Set permissions on exchange account to grant "eosio.code" permissioning@active
cleos set account permission exchange active '{"threshold":1, "keys":[{"key":"EOS819Z3ri1g7NUyZEnA5jyrFXw4joabtwcGWVqp41GLFLTtdE6p7", "weight":1}], "accounts": [{"permission":{"actor":"exchange","permission":"eosio.code"},"weight":1}]}' owner -p exchange

# Withdraw
cleos push action exchange withdraw '{"from":"maker1","quantity": {"quantity": "0.0001 EOS", "contract": "eosio.token"}}' -p maker1 exchange
cleos push action exchange withdraw '{"from":"taker1","quantity": {"quantity": "0.0001 EOS", "contract": "eosio.token"}}' -p taker1 exchange

# Register User (need ecc.sign() and capturing scatter arb sig or priv-key sig?)  --> Moveover to functional-tests
cleos push action exchange registeruser '{"user":"maker1","publickey": "00029221a9f9ba347649af61686877b13b6d07490305f5a68b47096423d5a14b841a"}' -p maker1 
cleos push action exchange registeruser '{"user":"taker1","publickey": "00029221a9f9ba347649af61686877b13b6d07490305f5a68b47096423d5a14b841a"}' -p taker1 

# Trade (need ecc.sign and hash for order and trade) --> Moveover to functional-tests
cleos push action exchange trade '{"amountbuy":"10","amountsell":"10","nonce":"1","amount":"10","tradenonce":"1","tokenbuy":{"quantity":"1.0000 SYS","contract":"eosio.token"},"tokensell":{"quantity":"1.0000 EOS","contract":"eosio.token"},"makerfee":"16","takerfee":"26","maker":"maker1","taker":"taker1","feeaccount":"ledger","makersig":"001f66fbfb863848a07719cc7c45d21345b357e8275069b56ba974cf164a574c98c96bfcb9ab2b1724742e0414185aed9a6bd93c031cd65261da7b21f3670c54e9e7", "takersig":"001f66fbfb863848a07719cc7c45d21345b357e8275069b56ba974cf164a574c98c96bfcb9ab2b1724742e0414185aed9a6bd93c031cd65261da7b21f3670c54e9e7"}' -p  exchange ledger
