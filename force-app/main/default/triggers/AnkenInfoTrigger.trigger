trigger AnkenInfoTrigger on AnkenInfo__c (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
 System.debug('Hello 123456 AnkenInfoTrigger!');
 TriggerDispatcher.executeHandler(new EmployeeTriggerHandler());
}