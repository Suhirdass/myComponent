@isTest
public class DropboxUploadControllerTest {
    
    @TestSetUp
    static void testDataSetUp(){
        DropBox_Access__c dropbox = new DropBox_Access__c(Name = 'Dropbox');
        dropbox.Get_Metadata_Endpoint__c = 'https://api.dropboxapi.com/2/files/get_metadata';
        dropbox.Access_Token__c = 'LM13wnTiT_gAAAAAAAAAAfMgOftL8XKZiNWWk0wB0yayFwzi1ngS7Do2eSJFRHnk';
        dropbox.Logo_Path__c = 'Account';
        dropbox.Product_Photo_Path__c = 'Product';
        dropbox.Upload_Session_Endpoint__c = 'https://content.dropboxapi.com/2/files/upload_session/start';
        dropbox.Upload_Session_Append_Endpoint__c = 'https://content.dropboxapi.com/2/files/upload_session/append_v2';
        dropbox.Upload_Session_Finish__c = 'https://content.dropboxapi.com/2/files/upload_session/finish';
        dropbox.Create_Shared_Link_Endpoint__c = 'https://api.dropboxapi.com/2/sharing/create_shared_link';
        dropbox.Dropbox_OAuth_token__c = 'https://api.dropboxapi.com/oauth2/token';
        dropbox.Get_Current_Account__c = 'https://api.dropboxapi.com/2/users/get_current_account';
        dropbox.Api_Key__c = 'bihb2grmxb0i';
        dropbox.Secret_Key__c = 'dsafsdgefewfew';
        insert dropbox;
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hold__c=true;
        objAccount.DBA__c='Test Account1';
        objAccount.Hide_from_Marketplace__c = false;
        insert objAccount;
        
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        //Create Product1
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.RecordTypeId = productRecordTypeId;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        insert objProduct1;
    }
    
    private static testmethod void checkFile(){
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new CheckFileMock());	
        
        DropboxUploadController.checkFile('Text.jpeg','',true);
        String base64Data = EncodingUtil.urlEncode('Textjpeg','UTF-8');
        DropboxUploadController.getSessionId(base64Data);
        DropboxUploadController.appendFile('base64Data','testr',1);
        Account acc = [SELECT Id,Name FROM Account LIMIT 1];
        Product2 pro = [SELECT Id,Name FROM Product2 LIMIT 1];
        DropboxUploadController.getAccount(acc.Id);
        DropboxUploadController.getProduct(pro.Id);
        DropboxUploadController.saveChunk(acc.Id,'fileName.jpeg',base64Data,'',true,'testr',10);
        DropBox_Access__c dropBoxRecord = [SELECT Id,Create_Shared_Link_Endpoint__c,Access_Token__c FROM DropBox_Access__c LIMIT 1];
        DropboxUploadController.createPublicURL('/test.jpg',dropBoxRecord,acc.Id,true);
        DropboxUploadController.createPublicURL('/test.jpg',dropBoxRecord,pro.Id,false);
        
        
        Test.setCurrentPageReference(new PageReference('Page.DropboxUpload')); 
        System.currentPageReference().getParameters().put('code', 'dasdasdasdASDWddxX');
        DropboxUploadController dropB = new DropboxUploadController();
        
        
        dropBoxRecord.Redirect_URI__c = 'https://api.dropboxapi.com';
        update dropBoxRecord;
        
        DropboxUploadController dropB2 = new DropboxUploadController();
        dropB2.getAuthorizationCode();
        System.assertEquals(dropBoxRecord.Redirect_URI__c,'https://api.dropboxapi.com');
        Test.stopTest();
    }
    
    private class CheckFileMock implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            String fullJson = '{"path":"/Account","include_deleted": false,"include_media_info": false,"include_has_explicit_shared_members": false}';
            HTTPResponse res = new HTTPResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody(fullJson);
            res.setStatusCode(200);
            return res;
        }
    }
}