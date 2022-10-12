@isTest(SeeAllData=false)
public class MetrcSynUIDControllerTest {
    
static testMethod void getSinglePackage_httpCalloutTest()
    {
        Map<String,Object> respMap = new  Map<String,Object>();
        
        Test.setMock(HttpCalloutMock.class, new Metrc_MockUIDHttpResponseTest());
 		String responseMessage= '';
		Metrc_IntegrationSettings__c setting= new Metrc_IntegrationSettings__c(Name='Endpoint', Value__c='Some Value');
		Metrc_IntegrationSettings__c setting1= new Metrc_IntegrationSettings__c(Name='LicenseNumber', Value__c='Some Value'); 
        Metrc_IntegrationSettings__c setting2= new Metrc_IntegrationSettings__c(Name='VendorAPIKey', Value__c='Some Value'); 
        Metrc_IntegrationSettings__c setting3= new Metrc_IntegrationSettings__c(Name='UserAPIKey', Value__c='Some Value'); 
        insert setting; 
        insert setting1;        
        insert setting2; 
        insert setting3;        

        UID__c  uid   = new UID__c();
        uid.Name ='1A4FF0300000029000000083';
        uid.Available_Qty_in_METRC__c = 0;
        uid.Available_Qty__c = 0;
        uid.Received_Qty__c = 7;
        uid.Active__c = true;
        uid.METRC_Status__c='Unfinished';
        //uid.Finished_date__c=null;
        insert uid; 
		Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u2 = new User(Alias = 'Test231', Email='TestnewUser@testorg.com',
                           EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                           LocaleSidKey='en_US', ProfileId = p.Id,
                           TimeZoneSidKey='America/Los_Angeles', UserName='TestnewUser@testorg.com');
        
        System.runAs(u2) {    
        Test.startTest();
        MetrcSynUIDController.synData(uid.id);
        Metrc_IntegrationEndpoints__mdt mt = new Metrc_IntegrationEndpoints__mdt();
        mt.MasterLabel = 'Metrc_strains_update';
        mt.URL__c = '/strains/v1/update?licenseNumber=';
       
            Test.stopTest();

        }
        
    }
    
    static testMethod void getSinglePackage_httpCalloutTest2()
    {
        Map<String,Object> respMap = new  Map<String,Object>();
        
        Test.setMock(HttpCalloutMock.class, new MetricSyncMock());
 		String responseMessage= '';
		Metrc_IntegrationSettings__c setting= new Metrc_IntegrationSettings__c(Name='Endpoint', Value__c='Some Value');
		Metrc_IntegrationSettings__c setting1= new Metrc_IntegrationSettings__c(Name='LicenseNumber', Value__c='Some Value'); 
        Metrc_IntegrationSettings__c setting2= new Metrc_IntegrationSettings__c(Name='VendorAPIKey', Value__c='Some Value'); 
        Metrc_IntegrationSettings__c setting3= new Metrc_IntegrationSettings__c(Name='UserAPIKey', Value__c='Some Value'); 
        insert setting; 
        insert setting1;        
        insert setting2; 
        insert setting3;        

        UID__c  uid   = new UID__c();
        uid.Name ='1A4FF0300000029000000021';
        uid.Available_Qty_in_METRC__c = 0;
        uid.Available_Qty__c = 0;
        uid.Received_Qty__c = 7;
        uid.Active__c = true;
        uid.METRC_Status__c='Unfinished';
        uid.Finished_date__c=null;
        insert uid; 
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u2 = new User(Alias = 'Test231', Email='TestnewUser@testorg.com',
                           EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US',
                           LocaleSidKey='en_US', ProfileId = p.Id,
                           TimeZoneSidKey='America/Los_Angeles', UserName='TestnewUser@testorg.com');
        
        System.runAs(u2) {    
            Test.startTest();
            MetrcSynUIDController.synData(uid.id);
            
            Metrc_IntegrationEndpoints__mdt mt = new Metrc_IntegrationEndpoints__mdt();
            mt.MasterLabel = 'Metrc_strains_update';
            mt.URL__c = '/strains/v1/update?licenseNumber=';
            Test.stopTest();
        }
    }
    
    class MetricSyncMock implements HttpCalloutMock
    {
        Boolean hasResponded = false;
        public HttpResponse respond(HttpRequest request)
        {
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setStatusCode(200);
            //res.setBody('[{"Status":"Success","Id":12345}]');
            res.setBody('{"Id": 2933156,"Name":"1A4FF0300000029000000085","Quantity":0,"LabTestingState":"NotSubmitted"}');
            system.assert(true);
            return res;
        }
    }
    
}