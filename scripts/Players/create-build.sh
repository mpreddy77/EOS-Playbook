# Setup eosiocpp alias
alias eosiocpp='/usr/local/eosio/bin/eosiocpp'
contracts='/Users/manjunanth.reddy/f42/eos/contracts'
build='/Users/manjunanth.reddy/f42/eos/build/contracts'

# Setup functions needed for docker compilation
#alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'
#eosiodockercpp() { d="/contracts/usr"; docker exec eos_nodeosd_1 /opt/eosio/bin/eosiocpp $1 $d/$2 $d/$3; }
#eosdockerbuild() { d="/contracts/usr"; eosiocpp -o $1.wast $1.cpp; eosiocpp -g $1.abi $1.cpp; cleos set contract anorak $d/${1%/*} $d/$1.wast $d/$1.abi; }
#eosdockerbuild $1;

# Setup functions for local testnet compilation
alias cleos='/usr/local/eosio/bin/cleos'
eosiolocalcpp() { eosiocpp $1 $contracts/$2 $contracts/$3; }
eoslocalbuild() { eosiocpp -o $build/$1.wast $contracts/$1.cpp; eosiocpp -g $contracts/$1.abi $contracts/$1.cpp; cleos set contract player $contracts/${1%/*} $contracts/$1.wast $contracts/$1.abi; }
eoslocalbuild $1;

#should result in...
#Generated /contracts/usr/Players/Players.abi ...
#Reading WAST/WASM from /contracts/usr/Players/Players.wast...
#Assembling WASM...
#Publishing contract...
#executed transaction: ba690daef9e12ce76a3f8eb068d6c91bf4050bf4519a9a4a5304f42a2a28ca96  2936 bytes  553 us
#         eosio <= eosio::setcode               {"account":"player","vmtype":0,"vmversion":0,"code":"0061736d01000000013e0c60047f7e7f7e0060027f7e006...
#         eosio <= eosio::setabi                {"account":"player","abi":"0e656f73696f3a3a6162692f312e30000406706c6179657200050c6163636f756e745f6e6...