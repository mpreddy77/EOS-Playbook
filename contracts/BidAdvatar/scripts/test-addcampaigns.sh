alias cleos='docker-compose exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'

# cleos push action {account} {action_name} '{data}' -p {account}@active
cleos push action anorak addcampaign '{"account":"anorak","newCampaign":{"campaign_id":1,"campaign_name":"Westside Pavilion Mall","impressions":400}}' -p anorak@active
cleos push action anorak addcampaign '{"account":"wade","newCampaign":{"campaign_id":2,"campaign_name":"6th Ave Shopping Mall","impressions":1235}}' -p wade@active
cleos push action anorak addcampaign '{"account":"reddy","newCampaign":{"campaign_id":3,"campaign_name":"LAX airport Terminal 3","impressions":8783}}' -p reddy@active
cleos get table anorak anorak campaign
