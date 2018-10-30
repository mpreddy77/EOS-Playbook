cd ~/f42/eos/build/contracts
# 0.1 Create alias for local testnet CLEOS
#alias cleos='/usr/local/eosio/bin/cleos'

# 0.2 Create alias for docker CLEOS
alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

eosdeploy() { d="/contracts/usr"; cleos set contract anorak $d/${1%/*} $d/$1.wast $d/$1.abi; }
eosdeploy $1;