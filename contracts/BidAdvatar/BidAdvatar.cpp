#include "BidAdvatar.hpp"

namespace bidooh
{
void BidAdvatar::addpublisher(account_name account, string &name)
{
    /**
     * We require that only the owner of an account can use this action
     * or somebody with the account authorization
    */
    require_auth(account);

    /**
     * We access the "publisher" table as creating an object of type "publisherIndex"
     * As parameters we pass code & scope - _self from the parent contract
    */
    publisherIndex bidpublisher(_self, _self);

    /**
     * We must verify that the account doesn't exist yet
     * If the account is not found the iterator variable should be publishers.end()
    */
    auto iterator = bidpublisher.find(account);
    eosio_assert(iterator == bidpublisher.end(), "Address for account already exists");

    /**
     * We add the new publisher in the table
     * The first argument is the payer of the storage which will store the data
    */
    bidpublisher.emplace(account, [&](auto &bidpublisher) {
        bidpublisher.account_name = account;
        bidpublisher.publisher_name = name;
    });
}

void BidAdvatar::upublisher(account_name account, string &name)
{
    require_auth(account);

    publisherIndex bidpublisher(_self, _self);

    auto iterator = bidpublisher.find(account);
    eosio_assert(iterator != bidpublisher.end(), "Address for account not found");

    /**
     * We update the publisher in the table
     * The first argument is the payer of the storage which will store the data
    */
    bidpublisher.modify(iterator, account, [&](auto &bidpublisher) {
        bidpublisher.publisher_name = name;
    });
}
void BidAdvatar::sigtest(const account_name account){}
void BidAdvatar::getpublisher(const account_name account)
{
    publisherIndex bidpublisher(_self, _self);

    auto iterator = bidpublisher.find(account);
    eosio_assert(iterator != bidpublisher.end(), "Address for account not found");

    /**
     * The "get" function returns a constant reference to the publisher
     * containing the specified secondary key
    */
    auto currentPublisher = bidpublisher.get(account);
    print("Name: ", currentPublisher.publisher_name.c_str());

    if (currentPublisher.inventory.size() > 0)
    {
        print(" Inventory of Ad-Campaigns: ");

        for (uint32_t i = 0; i < currentPublisher.inventory.size(); i++)
        {
            bidcampaign currentCampaign = currentPublisher.inventory.at(i);
            print(currentCampaign.campaign_name.c_str(), " == ");
        }
    }
    else
    {
        print(" No inventory for the publisher!!!");
    }
}

void BidAdvatar::addcampaign(const account_name account, bidcampaign newCampaign)
{
    publisherIndex publisher(_self, _self);

    auto iterator = publisher.find(account);
    eosio_assert(iterator != publisher.end(), "Address for account not found");

    publisher.modify(iterator, account, [&](auto &publisher) {
        publisher.inventory.push_back(bidcampaign{
            newCampaign.campaign_id,
            newCampaign.campaign_name,
            newCampaign.impressions});
    });

    print("Campaign Id: ", newCampaign.campaign_id);
    print(" | Name: ", newCampaign.campaign_name.c_str());
    print(" | Impressions: ", newCampaign.impressions);
}
} // namespace bidooh
