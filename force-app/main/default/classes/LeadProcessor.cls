global class LeadProcessor implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator([SELECT Id,LeadSource FROM Lead]);

    }
    global void execute(Database.BatchableContext bc, List<Lead> scope){
        // process each batch of records
        for(Lead l: scope){
            l.LeadSource='DreamForce';
        }
          update scope;
    }    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        Id job= bc.getJobId();
        System.debug(job);
    }    
}