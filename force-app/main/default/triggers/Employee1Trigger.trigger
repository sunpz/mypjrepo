trigger Employee1Trigger on Employee1__c (before insert, before delete,before update,after insert,after update ) {
 System.debug('Hello World!');
 TriggerDispatcher.executeHandler(new EmployeeTriggerHandler());
}