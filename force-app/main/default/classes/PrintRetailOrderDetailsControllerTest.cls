@IsTest 
private class PrintRetailOrderDetailsControllerTest {
    @isTest
    private static void runTest(){
        Account acc = new Account(Name = 'Irrational Raccoon, LLC');
        insert acc;
        
        Contact objContact = new Contact();
        objContact.LastName = 'Test Contact1';
        objContact.AccountId = acc.Id;
        objContact.EMail = 'test1@gmail.com';
        objContact.firstname = 'test';
        insert objContact;
        
        List<Profile> profiles = [SELECT Id, Name FROM Profile WHERE Name = 'Customer Community Plus User Custom'];
        User u = new User();
        u.ProfileId = profiles[0].Id;
        u.firstName = 'testcontact1';
        u.lastName = 'customeruser';
        u.Username = 'Testcontactat1@filigreencustomer.com.testaccount1';
        u.Email = 'Testcontactat1@filigreencustomer.com';
        u.ContactId = objContact.Id;
        u.Title = 'Customer';
        u.CommunityNickname = 'ruser';
        u.Alias = 'testser';
        u.TimeZoneSidKey = 'America/Los_Angeles'; // Required
        u.LocaleSidKey = 'en_US'; // Required
        u.EmailEncodingKey = 'ISO-8859-1'; // Required
        u.LanguageLocaleKey = 'en_US'; // Required
        insert u;
        
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.Retailer_Contact__c = objContact.Id;
        ord.Customer__c = u.Id;
        insert ord; 
        
        ApexPages.currentPage().getParameters().put('recordId', ord.Id);
        PrintRetailOrderDetailsController print = new PrintRetailOrderDetailsController();
    }
}