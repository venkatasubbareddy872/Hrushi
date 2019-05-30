@isTest
private class ContactTriggerHandler_Test {
    @TestSetup
    private static void TestDataSetup() {
        
        
        RecordType accType = [Select id, Name from RecordType where sObjectType = 'Account' AND IsActive = true Limit 1];
        
        Account acc = new Account();
        acc.Name = 'Test Account Contact Rollup';
        acc.AccountNumber = '12345';
        acc.BillingStreet = '01730 street';
        acc.BillingCity = 'Boston';
        acc.BillingState = 'MA';
        acc.BillingCountry = 'USA';
        acc.BillingPostalCode = '01730';
        acc.ShippingStreet = '01730 street';
        acc.ShippingCity = 'Boston';
        acc.ShippingState = 'MA';
        acc.ShippingCountry = 'USA';
        acc.ShippingPostalCode = '01730';
        acc.RecordTypeId = accType.ID;
        insert acc;
        
        List<Contact> contactList = new List<Contact>();
        Set<Id> contactrTypeIds = PostSandboxRefreshActivities.getContactRecordTypes();
        Integer I = 0;
        
        for(Id rId: contactrTypeIds) {
            Contact con = new Contact();
            con.FirstName = 'Test';
            con.LastName = 'Test LastName '+i;
            con.Email = 'testemail' + i + '@test.com';
            con.AccountId = acc.Id;
            con.RecordTypeId = rId;
            con.Client_Engagement__c = true;
            contactList.add(con);
            I++;
        }
        
        
        if(contactList.size() > 0)
            insert contactList;
        
    }
    
    @isTest static void ContactTriggerTest() {
    
        TEST.StartTest();
            Account acc = [Select ID,Client_Engagement_Contacts__c from Account where Name = 'Test Account Contact Rollup' Limit 1];
            Integer Count = [ Select count() from Contact where AccountID = : acc.Id AND Client_Engagement__c = true];
            System.Debug('Contact Count: '+Count);
            System.Debug('Account Count: '+acc.Client_Engagement_Contacts__c);
            System.assertEquals( Count, acc.Client_Engagement_Contacts__c);
            
            Contact con = [Select id, AccountId, Client_Engagement__c from Contact Limit 1 ];
            con.Client_Engagement__c = false;
            update con;
            
            Delete con;
            
             
        Test.StopTest();
        
    }
}