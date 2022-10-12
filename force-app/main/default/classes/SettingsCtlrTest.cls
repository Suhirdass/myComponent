@isTest
public class SettingsCtlrTest {
    private static testmethod void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.createTestData();
        Account acc = [SELECT Id, Name, Type FROM Account WHERE Name = 'Test Account1' LIMIT 1];

        acc.Type = 'Distributor';
        update acc;
        Contact con = [SELECT Id, Name,Primary_Contact__c, Email FROM Contact WHERE Name = 'Test Contact1' LIMIT 1];
        con.Email = 'Testcontactat1@filigreencustomer.com';
        con.Primary_Contact__c = true;
        update con;
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
        System.runAs(u){
            AuraResponse r = SettingsCtlr.getProfile();
            SettingsCtlr.UserProfile up = new SettingsCtlr.UserProfile();
            up.firstName = 'testcustomer';
            up.lastName = 'filigreen112';
            up.email = 'testcustomer@filigreen112.com';
            up.title = 'Accountant';
            up.phone = '7978979988';
            up.mobilePhone = '2232234343';
            up.profileType = 'Community Plus User';
            r = SettingsCtlr.createProfile(JSON.serialize(up));
            User u2 = [SELECT Id,IsActive FROM User WHERE Email = :up.email];
            r = SettingsCtlr.updateUserDetails('{"Id":"'+u2.Id+'", "IsActive":false}');
            up.firstName = 'testcontact1';
            up.lastName = 'customeruser';
            up.Email = 'Testcontactat1@filigreencustomer.com';
            up.phone = '7978979988';
            up.mobilePhone = '2232234343';
            r = SettingsCtlr.updateProfile(JSON.serialize(up));
            r = SettingsCtlr.updatePassword('{"newPassword":"1234567","verifyNewPassword":"1234567","oldPassword":"abc1234"}');
        }
    }
}