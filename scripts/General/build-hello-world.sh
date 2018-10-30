# Setup functions needed
alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'
eosiocpp() { d="/contracts/usr"; docker exec eos_nodeosd_1 /opt/eosio/bin/eosiocpp $1 $d/$2 $d/$3; }
eosbuild() { d="/contracts/usr"; eosiocpp -o $1.wast $1.cpp; eosiocpp -g $1.abi $1.cpp; cleos set contract hello.codes $d/${1%/*} $d/$1.wast $d/$1.abi; }
eosbuild $1;