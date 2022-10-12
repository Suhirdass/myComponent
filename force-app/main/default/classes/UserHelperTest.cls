@isTest
public class UserHelperTest {
	@isTest
    public static void testRun(){
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hold__c=true;
        objAccount.DBA__c='Test Account1';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Membership_Level__c = 'Boutique';
        objAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
        insert objAccount;
        
        Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
        objContact.AccountId = objAccount.Id;
        objContact.Email = 'Testcontactat1@filigreencustomer.com';
        objContact.Primary_Contact__c = true;
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
    }
}