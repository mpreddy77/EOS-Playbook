#!/bin/bash
alias cleos='/usr/local/eosio/bin/cleos'
thisScriptDir="$( cd "$( echo "${BASH_SOURCE[0]%/*}/" )"; pwd )"
eos_working_directory='/tmp/eosio'

echo "Current cwd -> " $thisScriptDir

cd $eos_working_directory/eos
echo "Creating Test Wallet -> test and keys in "$eos_working_directory/eos


# Create new wallet with the name "extest"
cleos wallet create -n f42 > .Pass

# Generate two pair of keys,one for Owner key and other for Active key (use the command twice)
cleos create key > .OwnerKeys
cleos create key > .ActiveKeys

# Import the generated private keys into "test" wallet
cleos wallet import -n f42 --private-key=$(cat .OwnerKeys |grep Private |cut -d" " -f3)
cleos wallet import -n f42 --private-key=$(cat .ActiveKeys |grep Private |cut -d" " -f3)
# import eosio private key
cleos wallet import -n f42 --private-key=5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3

# Display wallet, account, keys
echo 'Wallet list is:'
cleos wallet list

#echo 'key list is:'
cleos wallet keys

#open wallet if locked
#cleos wallet unlock -n f42 --password $(cat .Pass |grep Private |cut -d" " -f3)

# Create exchange,ledger and maker1, taker1, reddy test "accounts"
cleos create account eosio eosio.bios $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio eosio.token $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio exchange $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio ledger $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio maker1 $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio taker1 $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)
cleos create account eosio reddy $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)

# List accounts
cleos get accounts $(cat .OwnerKeys |grep Public |cut -d" " -f3)
