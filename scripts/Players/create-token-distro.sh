# Docker alias for CLEOS
#alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

# Local testnet alias for CLEOS
alias cleos='/usr/local/eosio/bin/cleos'

cleos push action eosio.token issue '{"to":"exchange","quantity":"1.0000 SYS","memo":"Initial bonus for signup"}' -p eosio.token
cleos push action eosio.token issue '{"to":"player","quantity":"1.0000 SYS","memo":"Initial bonus for signup"}' -p eosio.token
cleos push action eosio.token issue '{"to":"market","quantity":"1.0000 SYS","memo":"Initial bonus for signup"}' -p eosio.token
cleos push action eosio.token issue '{"to":"anorak","quantity":"50001.0000 SYS","memo":"Initial bonus for signup"}' -p eosio.token
cleos push action eosio.token issue '{"to":"wade","quantity":"50002.0000 SYS","memo":"Initial"}' -p eosio.token
cleos push action eosio.token issue '{"to":"reddy","quantity":"50003.0000 SYS","memo":"Bonus for Signup"}' -p eosio.token
cleos push action eosio.token issue '{"to":"eosio.token","quantity":"50004.0000 SYS","memo":"Bonus for Signup"}' -p eosio.token

cleos push action eosio.token issue '{"to":"exchange","quantity":"1.0000 EOS","memo":"Initial bonus for signup"}' -p eosio.token
cleos push action eosio.token issue '{"to":"player","quantity":"1.0000 EOS","memo":"Initial bonus for signup"}' -p eosio.token
cleos push action eosio.token issue '{"to":"market","quantity":"1.0000 EOS","memo":"Initial bonus for signup"}' -p eosio.token
cleos push action eosio.token issue '{"to":"anorak","quantity":"50001.0000 EOS","memo":"Initial bonus for signup"}' -p eosio.token
cleos push action eosio.token issue '{"to":"wade","quantity":"50002.0000 EOS","memo":"Initial"}' -p eosio.token
cleos push action eosio.token issue '{"to":"reddy","quantity":"50003.0000 EOS","memo":"Bonus for Signup"}' -p eosio.token
cleos push action eosio.token issue '{"to":"eosio.token","quantity":"50004.0000 EOS","memo":"Bonus for Signup"}' -p eosio.token

cleos get table eosio.token exchange accounts
cleos get table eosio.token wade accounts
cleos get table eosio.token reddy accounts
cleos get table eosio.token player accounts
cleos get table eosio.token market accounts
cleos get table eosio.token anorak accounts
cleos get table eosio.token eosio.token accounts
