trigger testAccountTrigger on Account  (before update, after update, before insert, after insert) {
     AccountTriggerHandler handle = new AccountTriggerHandler(Trigger.isExecuting,Trigger.size);
      if (Trigger.isBefore) {
          handle.onBeforeInsert(trigger.new);
      }
      else if (Trigger.isInsert && Trigger.isAfter) {
          handle.onAfterInsert(trigger.new,trigger.newMap);
      }    
}