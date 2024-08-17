public with sharing class AccountRepository {
    
    public List<Account> getAccountsWithoutOwner() {
        List<Account> accountsWithoutOwner = [SELECT Id, Name, OwnerId FROM Account WHERE OwnerId = NULL WITH SECURITY_ENFORCED];

        return accountsWithoutOwner;
    }

    public void updateAccounts(List<Account> accountsToUpdate) {
        update accountsToUpdate;
    }

}