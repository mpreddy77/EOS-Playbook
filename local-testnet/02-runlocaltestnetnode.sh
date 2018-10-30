
#!/bin/bash
thisScriptDir="$( cd "$( echo "${BASH_SOURCE[0]%/*}/" )"; pwd )"
echo "Current cwd -> " $thisScriptDir
echo "Starting local testnet node ..."

# To print http-verbose errors & contract's output to console by default 
# add eosio::history_api_plugin --contracts-console --verbose-http-errors
/usr/local/eosio/bin/nodeos -e -p eosio --plugin eosio::wallet_api_plugin --plugin eosio::chain_api_plugin --plugin eosio::history_api_plugin --contracts-console