global class testbatch001 implements 
    Database.Batchable<sObject>, Database.Stateful {
    
    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator( 'SELECT ID FROM Account limit 10');
    }
    global void execute(Database.BatchableContext bc, List<Account> scope){
        // process each batch of records[
        List<Contact> contacts = new List<Contact>();
        for (Account account : scope) {
             for (Integer i=0;i<10;i++) {
                Contact contact = new Contact(
                FirstName='MYTEST'+i,
                LastName='Smith'+i,
                Phone='415.555.1212',
                AccountId=account.ID);
                contacts.add(contact);
        	}
        }
        upsert contacts;
    }    
    global void finish(Database.BatchableContext bc){
        System.debug(recordsProcessed + ' records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        // call some utility to send email
        //EmailUtils.sendMessage(a, recordsProcessed);
    }    
}