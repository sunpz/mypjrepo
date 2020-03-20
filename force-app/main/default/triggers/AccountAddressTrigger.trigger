trigger AccountAddressTrigger on Account (before insert,before update) {
 for(Account acc : Trigger.New) {

        // Check if the account already has a related opportunity.
        if (acc.Match_Billing_Address__c == True ) {
            // If it doesn't, add a default opportunity
           acc.ShippingPostalCode = acc.BillingPostalCode;
        }           
    }
}