trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
    
    List<Task> tasklistToinsert = new List<Task>();
    
    for (Opportunity opp : Trigger.New){
        if (opp.StageName == 'Closed Won'){
            Task tk = new Task();
            tk.Subject ='Follow Up Test Task';
            tk.WhatId =opp.Id;
            tasklistToinsert.add(tk);
        }    
    }
    
    if(tasklistToinsert.size() > 0)
    {
        insert tasklistToinsert;
    }

}