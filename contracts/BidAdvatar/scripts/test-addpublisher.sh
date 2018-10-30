alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

# cleos push action {account} {action_name} '{data}' -p {account}@active
cleos push action bidadvatar addpublisher '["anorak","Madison Ave Media"]' -p anorak@active
cleos push action bidadvatar addpublisher '["wade","Wade Publishers"]' -p wade@active
cleos push action bidadvatar addpublisher '["reddy","Epsilon Media buys"]' -p reddy@active
cleos get table bidadvatar bidadvatar bidpublisher