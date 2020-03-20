public with sharing class AccountTriggerHandler {
    private boolean m_isExcuting = false;
    private integer BatchSize = 0;
    public AccountTriggerHandler(boolean isExcuting ,integer size){
        m_isExcuting = isExcuting;
    } 
    //登録前
    public void onBeforeInsert(List<Account> newObjs){  
        for(Account acc: newObjs) {
            if (acc.Industry == 'Engineering'){
               acc.Rating = 'Hot';
               System.debug('**◆◆◆◆ は: ' + Trigger.newMap);
           }
        }
          System.debug('**◆◆◆◆ accList.sizeは: ' + newObjs.size());
        

    } 
    public void onAfterInsert(List<Account> newObjs,Map<ID,Account> newObjMap){
	     List<Opportunity> Listopp = new List <Opportunity>();
         for(Account acc: newObjs) {
             Opportunity opp = new Opportunity();          
             opp.Name =acc.Name + '商談';
             opp.CloseDate = system.Date.today().addDays(7);
             opp.StageName ='Value Proposition';
             opp.AccountId =acc.id;
             Listopp.add(opp);
         }
        
         insert Listopp;
    } 
    //変更変更前

    public void onBeforeUpdate(List<Account> oldObjs,Map<ID,Account> oldObjMap,List<Account> newObjs,Map<ID,Account> newObjMap){
    } 
   //変更後
    public void onAfterInsert(List<Account> oldObjs,Map<ID,Account> oldObjMap,List<Account> newObjs,Map<ID,Account> newObjMap){
    } 
    //削除登録前
    public void onBeforeDelete(List<Account> oldObjs,Map<ID,Account> oldObjMap){
    } 
    //削除後
    public void onAfterDelete(List<Account> oldObjs,Map<ID,Account> oldObjMap){
    }   
    //削除後
    public void onUnDelete(List<Account> oldObjs,Map<ID,Account> oldObjMap){
    }   
}