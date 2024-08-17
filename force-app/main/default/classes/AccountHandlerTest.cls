@IsTest
private class AccountHandlerTest {
    
    @IsTest
    static void testAssignNewOwner() {
        // 1. Preparação de Dados
        Id fakeAccountId1 = Mock.generateFakeId(Account.getSObjectType());
        Id fakeAccountId2 = Mock.generateFakeId(Account.getSObjectType());
        Id newOwnerId = Mock.generateFakeId(User.getSObjectType());
        
        Account account1 = (Account) new AccountFixtureFactory().id(fakeAccountId1).ownerId(null).object();
        Account account2 = (Account) new AccountFixtureFactory().id(fakeAccountId2).ownerId(null).object();
        
        List<Account> accountsWithoutOwner = new List<Account>{ account1, account2 };
        
        // 2. Instanciação da Classe Testada
        AccountHandler accountHandler = new AccountHandler();
        
        // 3. Criação de Mocks
        AccountRepository mockAccountRepository = (AccountRepository) Mock.when('getAccountsWithoutOwner')
            .thenReturn(accountsWithoutOwner)
            .when('updateAccounts')
            .thenDoNothing()
            .forType(AccountRepository.class);
        
        accountHandler.accountRepository = mockAccountRepository;
        
        // 4. Execução do Método de Teste
        Test.startTest();
        accountHandler.assignNewOwner(newOwnerId);
        Test.stopTest();
        
        // 5. Asserts
        for (Account account : accountsWithoutOwner) {
            System.assertEquals(newOwnerId, account.OwnerId, 'O OwnerId da conta deve ser atualizado para o novo OwnerId');
        }
    }
}