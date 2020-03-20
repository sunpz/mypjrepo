global class OpportunityBatch implements Database.Batchable<sObject>{
    private List<String> accIdList = new List<String>();
    global OpportunityBatch(List<Id> idList){      
      this.accIdList = idList;
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([select Id,name  from Opportunity where id in:accIdList and StageName != 'Closed Won']);
    }
    
    global void execute(Database.BatchableContext bc, List<sObject> scope) {
        /*
        list<Account> accList = new List<Account>();
        Account acc = new Account();
        for ( sObject s:scope) {   
            acc=(Account) s;
            acc.TorihikiFlg__c = true;
            acclist.add(acc);
        }
        update accList;
*/
        list<Opportunity> oppList = new List<Opportunity>();
        Opportunity opp = new Opportunity();
        for ( sObject s:scope) {   
            opp=(Opportunity) s;
            opp.StageName = 'Closed Won';
            oppList.add(opp);
        }
        update oppList;
        
    }
    global void finish(database.BatchableContext bc) {
        AsyncApexJob a = [select id ,Status, NumberOfErrors,JobitemsProcessed, TotalJobitems,CreatedBy.Email from asyncapexjob where id = :bc.getJobId()];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{'info@shinyoku.co.jp'};
            mail.setToAddresses(toAddresses);
            mail.setSubject('ApexSharing Recalculation' + a.Status );
        
        mail.setPlainTextBody
            ('The batch apex job processed 2222' + a.TotalJobItems+'batch with '+a.NumberOfErrors+'failures.');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});

    }

}