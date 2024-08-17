public with sharing class AccountHandler {
    
    @TestVisible
    AccountRepository accountRepository;
    
    public AccountHandler() {
        this.accountRepository = new AccountRepository();
    }

    public void assignNewOwner(Id newOwnerId) {
        List<Account> accountsWithoutOwner = this.accountRepository.getAccountsWithoutOwner();

        for (Account accountWithoutOwner : accountsWithoutOwner) {
            accountWithoutOwner.OwnerId = newOwnerId;
        }

        this.accountRepository.updateAccounts(accountsWithoutOwner);
    }
}