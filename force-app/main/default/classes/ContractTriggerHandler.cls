public with sharing class ContractTriggerHandler {
    List<Contract> newContracts;
    Map<Id, Contract> oldContracts;

    ContractHandler contractHandler = new ContractHandler();
    
    public ContractTriggerHandler(List<Contract> triggerNew,  Map<Id, Contract> triggerOld) {
        this.newContracts = triggerNew;
        this.oldContracts = triggerOld;
    }
    
    public void onAfterUpdate() {
        contractHandler.inactivateOriginalContracts(newContracts, oldContracts);               
    }
}