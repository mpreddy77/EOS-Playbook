#!/bin/bash
alias cleos='/usr/local/eosio/bin/cleos'
thisScriptDir="$( cd "$( echo "${BASH_SOURCE[0]%/*}/" )"; pwd )"
eos_working_directory='/tmp/eosio'

echo "Current cwd -> " $thisScriptDir

cd $eos_working_directory/eos

# Deploy eosio.token contract to create and issue tokens
echo "Deployin eosio.token contract..."
cleos set contract eosio.token contracts/eosio.token/ build/contracts/eosio.token/eosio.token.wast contracts/eosio.token/eosio.token.abi

# Create SYS,ABC and EOS tokens for testing
cleos push action eosio.token create '{"issuer":"eosio.token","maximum_supply":"1000000.0000 EOS","can_freeze":"0","can_recall":"0","can_whitelist":"0"}' -p eosio.token
cleos push action eosio.token create '{"issuer":"eosio.token","maximum_supply":"1000000.0000 SYS","can_freeze":"0","can_recall":"0","can_whitelist":"0"}' -p eosio.token
cleos push action eosio.token create '{"issuer":"eosio.token","maximum_supply":"1000000.0000 ABC","can_freeze":"0","can_recall":"0","can_whitelist":"0"}' -p eosio.token

# Check accounts
cleos get table eosio.token eosio.token accounts

# Distro tokens - EOS
cleos push action eosio.token issue '{"to":"exchange","quantity":"1.0000 EOS","memo":"Init.."}' -p eosio.token
cleos push action eosio.token issue '{"to":"taker1","quantity":"100000.0000 EOS","memo":"Init.."}' -p eosio.token
cleos push action eosio.token issue '{"to":"maker1","quantity":"100000.0000 EOS","memo":"Init.."}' -p eosio.token
cleos push action eosio.token issue '{"to":"reddy","quantity":"100000.0000 EOS","memo":"Init.."}' -p eosio.token

# Distro tokens - SYS
cleos push action eosio.token issue '{"to":"exchange","quantity":"1.0000 SYS","memo":"Init.."}' -p eosio.token
cleos push action eosio.token issue '{"to":"maker1","quantity":"100000.0000 SYS","memo":"Init.."}' -p eosio.token
cleos push action eosio.token issue '{"to":"taker1","quantity":"100000.0000 SYS","memo":"Init.."}' -p eosio.token
cleos push action eosio.token issue '{"to":"reddy","quantity":"100000.0000 SYS","memo":"Init.."}' -p eosio.token

# Distro tokens - ABC
cleos push action eosio.token issue '{"to":"exchange","quantity":"1.0000 ABC","memo":"Init.."}' -p eosio.token
cleos push action eosio.token issue '{"to":"maker1","quantity":"100000.0000 ABC","memo":"Init.."}' -p eosio.token
cleos push action eosio.token issue '{"to":"taker1","quantity":"100000.0000 ABC","memo":"Init.."}' -p eosio.token
cleos push action eosio.token issue '{"to":"reddy","quantity":"100000.0000 ABC","memo":"Init.."}' -p eosio.token

# Validate quantity and symbol type for each account
cleos get table eosio.token exchange accounts
cleos get table eosio.token maker1 accounts
cleos get table eosio.token taker1 accounts
cleos get table eosio.token reddy accounts
