@IsTest
private class SelfRegisterTest {
    static testMethod void testCommunityUser() {
        SelfRegisterCtlr src = new SelfRegisterCtlr();

        //User_Self_Registration__c userData = new User_Self_Registration__c();
        src.firstName = 'Test First Name';
        src.lastName = 'Test Last Name';
        src.companyName = 'Test Company';
        src.title = 'Title';
        src.email = 'test@test.com';
        src.phone = '1234567890';
        src.licenseNumber = 'LC-0090089';
        src.response = true;
        Attachment atc = new Attachment(body=Blob.valueOf('abc'),name='Test');
        src.fileData = atc;
        src.saveRegistrationDetails();
        SelfRegisterCtlr.registerNewUser('firstName','lastName',
                                 'dbaName','123-234-3455','testemail@email.com',
                                 'title','stateLicense',true);
        SelfRegisterCtlr.saveTheFile('firstName','lastName',
                                 'dbaName','123-234-3455','testemail@email.com',
                                 'title','stateLicense',true,'test.txt','this is test contents','plain/text');
        User_Self_Registration__c userData = [SELECT Id FROM User_Self_Registration__c LIMIT 1];
        SelfRegisterCtlr.saveTheFile(userData.Id,'test.txt','this is test contents','plain/text');
        ApproveSelfRegisterUser.getInit(userData.Id);
        ApproveSelfRegisterUser.fetchRecords('T');        
        String contactId = ApproveSelfRegisterUser.approveUser(userData.Id, 'Customer Community User Custom','');
        System.assertNotEquals(null,contactId);
    }
}