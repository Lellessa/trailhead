trigger ContractTrigger on Contract (after update) {
  ContractTriggerHandler contractTriggerHandler = new ContractTriggerHandler(Trigger.new, Trigger.oldMap);  

  if (Trigger.isUpdate && Trigger.isAfter) {
    contractTriggerHandler.onAfterUpdate();
  }
  
}