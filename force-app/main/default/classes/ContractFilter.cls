public with sharing class ContractFilter {

    public List<Contract> byChangedSignedStatus(List<Contract> newContracts, Map<Id, Contract> oldContractsById) {
        List<Contract> amendmentContracts = new List<Contract>();

        for (Contract contract : newContracts) {
            Contract oldContract = oldContractsById.get(contract.Id);

            if (contract.Status ==	'Assinado' && oldContract.Status !=	'Assinado' && contract.OriginalContract__c != null) {
                amendmentContracts.add(contract);
            }
        }

        return amendmentContracts;
    }

    public List<String> extractOriginalContractIds(List<Contract> contracts) {
        List<String> originalContractIds = new List<String>();

        for (Contract contract : contracts) {
            originalContractIds.add(contract.OriginalContract__c);
        }

        return originalContractIds;
    }

    public Map<Id, Contract> indexById(List<Contract> contracts) {
        return new Map<Id, Contract>(contracts);
    }

}