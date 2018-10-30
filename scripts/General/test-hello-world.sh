alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

cleos push action hello.codes hi '["user"]' -p hello.codes@active