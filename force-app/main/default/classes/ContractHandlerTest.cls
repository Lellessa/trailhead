@IsTest
private class ContractHandlerTest {

   @IsTest
   static void testInactiveOriginalContracts() {
       // Preparação de Dados
       Id contractId1 = Mock.generateFakeId(Contract.SObjectType);
       Id contractId2 = Mock.generateFakeId(Contract.SObjectType);
       Id originalContractId1 = Mock.generateFakeId(Contract.SObjectType);
       Id originalContractId2 = Mock.generateFakeId(Contract.SObjectType);

       Contract contract1 = (Contract) new ContractFixtureFactory().id(contractId1).object();
       Contract contract2 = (Contract) new ContractFixtureFactory().id(contractId2).object();
       Contract originalContract1 = (Contract) new ContractFixtureFactory().id(originalContractId1).object();
       Contract originalContract2 = (Contract) new ContractFixtureFactory().id(originalContractId2).object();

       Map<Id, Contract> originalContractsByContractIds = new Map<Id, Contract>{
           contractId1 => originalContract1,
           contractId2 => originalContract2
       };

       List<Contract> contracts = new List<Contract>{ contract1, contract2 };

       // Instanciação da Classe Testada
       ContractHandler contractHandler = new ContractHandler();

       // Criação de Mocks
       ContractFilter mockContractFilter = (ContractFilter) Mock.when('isContractJustSigned').thenReturn(true)
           .when('hasOriginalContract').thenReturn(true).forType(ContractFilter.class);
       contractHandler.contractFilter = mockContractFilter;

       ContractRepository mockContractRepository = (ContractRepository) Mock.when('getById').thenReturn(new List<Contract>{ originalContract1, originalContract2 })
           .forType(ContractRepository.class);
       contractHandler.contractRepository = mockContractRepository;

       // Execução do Método de Teste
       Test.startTest();
       contractHandler.inactiveOriginalContracts(contracts, originalContractsByContractIds);
       Test.stopTest();

       // Asserts
       System.assertEquals('Inativado', originalContract1.Status, 'O status do contrato original deve ser "Inativado"');
       System.assertEquals('Inativado', originalContract2.Status, 'O status do contrato original deve ser "Inativado"');
   }
}