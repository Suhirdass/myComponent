@isTest
public class MarketplaceUserSetupControllerTest {
    static testMethod void runTest(){
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        Contact con = new Contact();
        con.FirstName='Test';
        con.LastName='Contact1';
        con.AccountId=objAccount.id;
        con.Email = 'Testcontactat1@filigreencustomer.com';
        con.Primary_Contact__c = true;
        insert con;
        List<Profile> profiles = [SELECT Id, Name FROM Profile WHERE Name = 'Customer Community Plus User Custom'];
        User u = new User();
        u.ProfileId = profiles[0].Id;
        u.firstName = 'testcontact1';
        u.lastName = 'customeruser';
        u.Username = 'Testcontactat1@filigreencustomer.com.testaccount1';
        u.Email = 'Testcontactat1@filigreencustomer.com';
        u.ContactId = con.Id;
        u.Title = 'Customer';
        u.CommunityNickname = 'ruser';
        u.Alias = 'testser';
        u.TimeZoneSidKey = 'America/Los_Angeles'; // Required
        u.LocaleSidKey = 'en_US'; // Required
        u.EmailEncodingKey = 'ISO-8859-1'; // Required
        u.LanguageLocaleKey = 'en_US'; // Required
        insert u;
        Test.startTest();
        Map<String, Object> filters = new Map<String, Object> {'orderByField' =>'Name', 'isASC' => true, 'searchTerm' => 'test'};
        AuraResponse r = MarketplaceUserSetupController.getIds(filters);
        Set<Id> ids = (Set<Id>)r.data.get('ids');
            List<String> idsList = new List<String>();
            for(Id idStr : ids){
                idsList.add(idStr);
            }
            
         MarketplaceUserSetupController.getUsers(idsList,filters);
        list<string> selectedUsr=new List<string>();
        selectedUsr.add(u.id);
        MarketplaceUserSetupController.resetUsers(false,selectedUsr);
        Test.stopTest();
    }
}