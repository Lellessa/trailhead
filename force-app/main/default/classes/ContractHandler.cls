public with sharing class ContractHandler {

    @TestVisible
    ContractFilter contractFilter = new ContractFilter();
    @TestVisible
    ContractRepository contractRepository = new ContractRepository();
    
    public void inactivateOriginalContracts(List<Contract> contracts, Map<Id, Contract> oldContracts) {
        List<Contract> amendmentContracts = contractFilter.byChangedSignedStatus(contracts, oldContracts);

        if (!amendmentContracts.isEmpty())	{
            List<String> originalContractIds = contractFilter.extractOriginalContractIds(amendmentContracts);

            List<Contract> originalContracts = contractRepository.findByIds(originalContractIds);

            if	(!originalContracts.isEmpty())	{
                Map<Id, Contract> originalContractById = contractFilter.indexById(amendmentContracts);
                updateOriginalContracts(amendmentContracts, originalContractById);
            }
        }
    }

    void updateOriginalContracts(List<Contract> amendmentContracts, Map<Id, Contract> originalContractById) {
        for	(Contract contract	: amendmentContracts) {
            Contract originalContract = originalContractById.get(contract.OriginalContract__c);
            originalContract.Status	=	'Inativado';
        }
        
        contractRepository.save(originalContractById.values());
    }

}