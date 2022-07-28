@isTest
private class CallListQueryActionTest {
    @isTest
    static void testGetLastOrderNumbers() {
        // create test Leads
        List<Lead> testLeads = new List<Lead>();
        testLeads.add(New Lead(FirstName = 'test1', LastName = 'test1', Company = 'Company1', Phone = '0290453311', MobilePhone = '0411111111'));
        testLeads.add(New Lead(FirstName = 'test2', LastName = 'test2', Company = 'Company2', Phone = '0290453312', MobilePhone = '0411111122'));
    	insert testLeads;
        
    	// create test Call List
    	CallList__c testCallList = new CallList__c(Name = 'Test Call List');
        insert testCallList;
        
        // create test Call List Member
        Lead lead1 = [SELECT Id FROM Lead WHERE FirstName = 'test1'];
        Lead lead2 = [SELECT Id FROM Lead WHERE FirstName = 'test2'];
        
        List<CallListMember__c> clms = new List<CallListMember__c>();
        clms.add(new CallListMember__c(CallList__c = testCallList.Id, Lead__c = lead1.Id, Status__c = 'Not Called', Order__c = 1));
        clms.add(new CallListMember__c(CallList__c = testCallList.Id, Lead__c = lead1.Id, Status__c = 'Not Called', Order__c = 12));
        insert clms;
        
        Test.startTest();
        List<Id> ids = new List<Id>{testCallList.Id};
        List<Integer> orderNumbers = CallListQueryAction.getNextOrderNumbers(ids);
        Test.stopTest();
        
        System.assertEquals(13, orderNumbers[0], 'Next order number should be 13'); 
    }
}