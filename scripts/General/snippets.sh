# Docker commands
docker-compose up -d 
docker-compose down
docker logs -f eos_nodeosd_1
docker exec -it eos_nodeosd_1 ls /contracts/usr

# Prune
docker system prune -a
docker volume ls
docker volume rm eos_keosd-data-volume
docker volume rm eos_nodeos-data-volume

#Alt prune
docker images -a
docker rmi Image Image
docker rmi $(docker images -a -q)

# Browser docker with bash
docker exec -t -i eos_nodeosd_1 /bin/bash


# Create Account on Local Node
cleos create account eosio account_name $(cat .OwnerKeys |grep Public |cut -d" " -f3) $(cat .ActiveKeys |grep Public |cut -d" " -f3)

# Create Account on Jungle Testnet Node
tcleos create account eosio account_name $(cat .OwnerKeysJungle |grep Public |cut -d" " -f3) $(cat .ActiveKeysJungle |grep Public |cut -d" " -f3)

# Query for local accounts
cleos get accounts $(cat .OwnerKeys |grep Public |cut -d" " -f3)

# Query for Jungle Testnet accounts
tcleos get accounts $(cat .OwnerKeysJungle |grep Public |cut -d" " -f3)

# Unlock local node wallet
cleos wallet unlock -n oasis --password PW5JRiM5uo9MWGVPNP9JeYUKqPUSdAFykTnZoEGsjwaMaqn4KAyDE

# Unlock Jungle Testnet node wallet
tcleos wallet unlock -n jungle --password PW5JDwFadKRUEhBA51oVfsBQHi2zjEPUY8hqo3cA13zKoCmzDdCn5

# Get Balances
tcleos get currency balance eosio.token exchangeidex EOS
tcleos get currency balance eosio.token idexledger EOS
tcleos get currency balance eosio.token player EOS
tcleos get currency balance eosio.token reddy EOS

# Get Stats
tcleos get currency stats eosio.token EOS
tcleos get currency stats myairdrop EOS
mcleos get currency stats everipediaiq IQ  

# Query accounts tables
tcleos get table eosio.token exchangeidex accounts
tcleos get table eosio.token market accounts
tcleos get table eosio.token reddy accounts
tcleos get table eosio.token player  accounts
mcleos get table everipediaiq gi3dcnjshege accounts
mcleos get table eosio.token gi3dcnjshege accounts

# Get currency balance
tcleos get currency balance eosio.token exchangeidex EOS
tcleos get currency balance eosio.token idexledger EOS
tcleos get currency balance eosio.token player EOS
tcleos get currency balance eosio.token reddy EOS
tcleos get currency balance eosio.token market EOS

# Get actions on account
tcleos get actions exchangeidex --json
tcleos get actions reddy --json
tcleos get actions market

# Deposit from player to reddy and withdraw from reddy to player (note permissions)
tcleos transfer player reddy "16.000 EOS" deposit -p player reddy
tcleos transfer reddy player "1.7900 EOS" withdraw -p reddy

# Get account details
tcleos get account exchangeidex --json
tcleos get account market --json
tcleos get account reddy --json

# Get trx details on action
tcleos transfer reddy player "1.0000 EOS" deposit -p reddy -d -j
tcleos push action market buy '["player",1]' -p player -d -j
tcleos push action market buy '["reddy",1]' -p reddy

# If you use userA permission to call action in contract A, and in the action you use inline_action_sender to call action in contract B, the contract B does not receive the userA permission. Instead it is use contractB's owner and permission "eosio.code" to call action in contractB.
# To allow contract B to use userA's permission, you can configure userA's permission to allow contractB owner and permission eosio.code to have userA's active permission.

# set permissions on account
# All players must set permission eosio.code for this smart contract. If this contract is uploaded to account market and user wants to set the permission:
#tcleos set account permission user active \
#'{"threshold": 1,
#  "keys": [{
#    "key": "PUBKEY_OF_user",
#    "weight": 1
#  }],
#  "accounts": [{
#    "permission": {"actor": "market",
#                   "permission": "eosio.code"},
#                   "weight": 1
#  }]}' owner -p user

tcleos set account permission reddy active '{"threshold":1, "keys":[{"key":"EOS59VkgsKrkkjkKTHKoaF736NZwZq5DbVk6j5jcTtxYQ7REJzKZn", "weight":1}], "accounts": [{"permission":{"actor":"market","permission":"eosio.code"},"weight":1}]}' owner -p reddy
tcleos set account permission player active '{"threshold":1, "keys":[{"key":"EOS59VkgsKrkkjkKTHKoaF736NZwZq5DbVk6j5jcTtxYQ7REJzKZn", "weight":1}], "accounts": [{"permission":{"actor":"market","permission":"eosio.code"},"weight":1}]}' owner -p player


# exchange stitch
  "types": [{
      "new_type_name": "account_name",
      "type": "name"
    }
  ],
  "structs": [
    {
      "name": "extended_symbol",
      "base": "",
      "fields": [
        {"name":"sym",      "type":"symbol"},
        {"name":"contract", "type":"account_name"}
      ]
    },
    {
      "name": "extended_asset",
      "base": "",
      "fields": [
        {"name":"quantity", "type":"asset"},
        {"name":"contract", "type":"account_name"}
      ]
    }