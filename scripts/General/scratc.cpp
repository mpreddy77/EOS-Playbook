case DOBALS :
        {
            //**************************************************************
            // RQID470 - tpa - When enabled to skip AcctListInqRq in ACTSUM,
            //                 also skip getting updated balances for TX
            //**************************************************************
            if (  (b_IB_ACTSUM_SKIP_ACCT_LIST_INQ && (atoi(Host.getService()) == 0))  ||
                  (b_BB_ACTSUM_SKIP_ACCT_LIST_INQ && (atoi(Host.getService()) == 1))     )
            {
                cerr << "D2H_TX() - Balance retrieval using AcctInqRq for ->" << total_added
                                  << "<- accounts" << endl;
 
 
Proposed code:
        case DOBALS :
        {
            //**************************************************************
            // RQID470 - tpa - When enabled to skip AcctListInqRq in ACTSUM,
            //                 also skip getting updated balances for TX
            //**************************************************************
            // INT-318 – 7/22/2018 - M. Reddy
            // DGB switched from USRSUM to ACTSUM to improve performance.
            // DGB requires AABAL in ACTSUM response.
            // Setting BB_ACTSUM_SKIP_ACCT_LIST_INQ = 1 suppresses AABAL,
            // so it must remain 0.
            // Setting BB_ACTSUM_SKIP_ACCT_LIST_INQ = 0 prevents TX from
            // handling cross-PIN (aka multi-user) transfers.
            // Solution:  Bifurcate TX from ACTSUM by introducing (optional)new tag:
            // ENABLE_BB_TX_SKIP_ACCT_LIST_INQ.
            // Default to current behavior, unless new tag present, then it controls.
           
            bool skip_list = false;
            if (  (b_IB_ACTSUM_SKIP_ACCT_LIST_INQ && (atoi(Host.getService()) == 0))  ||
                  (b_BB_ACTSUM_SKIP_ACCT_LIST_INQ && (atoi(Host.getService()) == 1))     )
            {
                skip_list = true;
            }
 
            // was the BB TX-specific tag specified?
            if( atoi(Host.getService()) == 1 ) {
                const char* q = Opts.getOpt("ENABLE_BB_TX_SKIP_ACCT_LIST_INQ");
                // check for existance before checking value
                if ( q != NULL ) {
                    if ( (*q != '\0')  &&  (atoi(q) == 1) )
                    {
                        skip_list = true;
                    }
                    else
                    {
                        skip_list = false;
                    }
                }
            }
 
            if( skip_list )
            {
                cerr << "D2H_TX() - Balance retrieval using AcctInqRq for ->" << total_added
                                  << "<- accounts" << endl;
 
 
 
 
 
 
 