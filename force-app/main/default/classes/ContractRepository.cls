public with sharing class ContractRepository {
    
    public List<Contract> findByIds(List<Id> contractsId) {
        List<Contract> contracts = [SELECT Id, Status FROM Contract WHERE Id IN: contractsId];
        return contracts;
    }

    public List<Contract> save(List<Contract> contracts) {
        upsert contracts;
        return contracts;
    }
    
}