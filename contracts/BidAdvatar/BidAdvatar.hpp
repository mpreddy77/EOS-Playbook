#include <eosiolib/eosio.hpp>
#include <string>

namespace bidooh
{
using namespace eosio;
using std::string;

class BidAdvatar : public contract 
{

    using contract::contract;

    //@abi table bidcampaign i64
    struct bidcampaign
    {
        uint64_t campaign_id;
        string campaign_name;
        uint64_t impressions;

        uint64_t primary_key() const { return campaign_id; }

        EOSLIB_SERIALIZE(bidcampaign, (campaign_id)(campaign_name)(impressions))
    };
    typedef multi_index<N(bidcampaign), bidcampaign> campaignIndex;

    //@abi table bidpublisher i64
    struct bidpublisher
    {
        uint64_t account_name;
        string publisher_name;
        vector<bidcampaign> inventory;
        //string created_timestamp;

        uint64_t primary_key() const { return account_name; }

        EOSLIB_SERIALIZE(bidpublisher, (account_name)(publisher_name)(inventory))
    };
    typedef multi_index<N(bidpublisher), bidpublisher> publisherIndex;

  public:
    BidAdvatar(account_name self) : contract(self) {}

    //@abi action
    void addcampaign(account_name account, bidcampaign newCampaign);

    //@abi action
    void addpublisher(account_name account, string &publishername);

    //@abi action
    void ucampaign(account_name account);

    //@abi action
    void upublisher(account_name account, string &name);

    //@abi action
    void getcampaign(const account_name account);

    //@abi action
    void getpublisher(const account_name account);

    //@abi action
    void sigtest(const account_name account);
};
//EOSIO_ABI(BidAdvatar, (addcampaign)(addpublisher)(getcampaign)(getpublisher)(updatecampaign)(updatepublisher));
EOSIO_ABI(BidAdvatar, (addcampaign)(addpublisher)(getpublisher)(upublisher)(sigtest));
} // namespace bidooh
