@isTest
public class ContentDocumentLinkTriggerTest {
    public static testmethod void runTest(){
        TestUtilData.createTestData();
        Account acc = [SELECT Id, Name,dBA__c,Community_Price_Book__c, Type FROM Account WHERE Name = 'Test Account1' LIMIT 1];
        Contact[] cons = [SELECT Id,AccountId, Name,Primary_Contact__c, Email FROM Contact WHERE Name IN ('Test Contact1','Test Contact2')];
        string before = 'Testing base 64 encode';            
         Blob beforeblob = Blob.valueOf(before);
         //Insert contentdocument data
         ContentVersion cv = new ContentVersion();
         cv.title = 'test content trigger';      
         cv.PathOnClient ='test';           
         cv.VersionData =beforeblob;          
         insert cv;         
                                                
         ContentVersion testContent = [SELECT id, ContentDocumentId FROM ContentVersion where Id = :cv.Id];

        ContentDocumentLink newFileShare = new ContentDocumentLink();
        newFileShare.contentdocumentid = testcontent.contentdocumentid;
        newFileShare.LinkedEntityId = cons[0].Id;
        newFileShare.ShareType= 'V';
        insert newFileShare;
    }
}