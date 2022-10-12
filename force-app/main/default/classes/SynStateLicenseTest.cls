@isTest(SeeAllData=false)
/**********************************************************************************************************
Apex TestClass Name    : SyncStateLicenseTest 
Apex Class Name    : SyncStateLicense 
Version            : 1.0
Created Date       : 24/Feb/2021
Function           : Used for Testing the Sync BccLicense Test
------------------------------------------------------------------------------------------------------------
* Developer                                      Date                   Description
* ----------------------------------------------------------------------------------------------------------
* Kumaravendan                            24/Feb/2021              Original Version
************************************************************************************************************/
public class SynStateLicenseTest {
    static final String testEmail = 'tuser3@testMetrc.com';
    @testSetup static void setTestData(){
        
        Id profId= [select id from Profile where name='System Administrator' limit 1].Id; 
        User testUser=Metrc_TestdataFactory.createUser(testEmail+System.currentTimeMillis(),profId,testEmail);
        Database.insert(testUser);
        system.runAs(testUser){
            List<State_License_Settings__c> customsettingList =createIntegrationSettingData();
            Insert customsettingList;
            
            Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
            Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
                insert GDMIs;     
            Account objAccount = new Account();
            objAccount.Name = 'Test Account1';
            objAccount.Payment_Terms__c = 'COD';
            objAccount.Hide_from_Marketplace__c = false;
            insert objAccount;
            Site__c objSite = new Site__c();
            objSite.Name = 'Test Site';
            objSite.Warehouse_Name__c='TestWarehouse1';
            objSite.Active__c = true;
            insert objSite;
            List<State_Licenses__c> licenses = new List<State_Licenses__c>();
            State_Licenses__c objStateLicenses = new State_Licenses__c();
            objStateLicenses.License_Name__c = objAccount.id;
            objStateLicenses.License_Number__c = 'AbcTest12345';
            objStateLicenses.License_Status__c ='Active';
            objStateLicenses.License_Type__c ='Type 1';
            objStateLicenses.Default_Warehouse__c = objSite.Id;
            objStateLicenses.License_Class__c='A-License';
            objStateLicenses.License_State__c = 'California';
            objStateLicenses.License_City__c = 'San Francisco';
            objStateLicenses.License_Address__c = '2089 Ingalls St. Unit 3';
            objStateLicenses.License_Zip__c = '94124';
            objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
            insert objStateLicenses;
            objSite.License_ID__c = objStateLicenses.Id;
            update objSite;
            State_Licenses__c objStateLicenses1 = new State_Licenses__c();
            objStateLicenses1.License_Name__c = objAccount.id;
            objStateLicenses1.License_Number__c = 'AbcTest123456';
            objStateLicenses1.License_Status__c ='Cancelled';
            objStateLicenses1.License_Type__c ='Type 1';
            objStateLicenses1.Default_Warehouse__c = objSite.Id;
            objStateLicenses1.License_Class__c='A-License';
            objStateLicenses1.License_State__c = 'California';
            objStateLicenses1.License_City__c = 'San Francisco';
            objStateLicenses1.License_Address__c = '375 Potrero Avenue, #5B';
            objStateLicenses1.License_Zip__c = '94103';
            objStateLicenses1.License_Expiration_Date__c = date.valueof(system.now()) + 10;
            insert objStateLicenses1;
            objStateLicenses1.License_Address__c = '375 Potrero Avenue, #5C';
            objStateLicenses1.Business_Structure__c = '';
            objStateLicenses1.Phone__c = '5525278678';
            objStateLicenses1.Website__c = 'www.teststatelicense.com';
            objStateLicenses1.Premise_City__c = 'Oakland';
            objStateLicenses1.Premise_State__c = 'CA';
            update objStateLicenses1;
            
        }
    }
    
    public static List<State_License_Settings__c> createIntegrationSettingData(){
        List<State_License_Settings__c> customsettingList = new List<State_License_Settings__c>();
        State_License_Settings__c obj1 = new State_License_Settings__c();
        obj1.Name='StateLicense_EndPoint';
        obj1.Value__c='https://iservices.dca.ca.gov';
        
        State_License_Settings__c obj2 = new State_License_Settings__c();
        obj2.Name='StateLicense_APP_ID';
        obj2.Value__c='DASEQWEQWDASDAS';
        
        State_License_Settings__c obj3 = new State_License_Settings__c();
        obj3.Name='StateLicense_APP_KEY';
        obj3.Value__c='sDwqeqwedQWDD';
        
        
        customsettingList.add(obj1);
        customsettingList.add(obj2);
        customsettingList.add(obj3);
        return customsettingList;
    }
    static testMethod void syncStateLicenseDCA_Test()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        system.runAs(user1){
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new StateLicenseBccMockHttpTest());
            State_Licenses__c stl = [select id, License_Number__c from State_Licenses__c limit 1];
           StateLicense_HttpCalloutHelper.isTestClass= true;
            SyncStateLicense.SyncStateLicenseDCA(stl.id);
            SyncStateLicense.getRecordName(stl.id);
            StateLicense_HttpCalloutHelper.toTitleCase('NEWYORK');
            StateLicense_HttpCalloutHelper.getDate('02/02/2020');
            StateLicense_HttpCalloutHelper.getAllLicenseByNumberBatch();
            TestUtilData.skipTrigger = true;
            StateLicense_HttpCalloutHelper.IS_STATELICENSETOTALMILES_TRIGGER_ENABLED = FALSE;
            Test.stopTest();
        }
    }  
    static testMethod void syncStateLicenseDCA_Test1()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        system.runAs(user1){
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new StateLicenseBccMockHttpTestNull());
            State_Licenses__c stl = [select id, License_Number__c from State_Licenses__c limit 1];
            List<State_Licenses__c>  slObj = [select License_Number__c from State_Licenses__c where id = :stl.id];
            StateLicense_HttpCalloutHelper.isTestClass= true;
            SyncStateLicense.getRecordName(stl.id);
            StateLicense_HttpCalloutHelper.toTitleCase('NEWYORK');
            StateLicense_HttpCalloutHelper.getDate('02/02/2020');
            StateLicense_HttpCalloutHelper.getAllLicenseByNumberBatch();
             TestUtilData.skipTrigger = true;
            
            StateLicense_HttpCalloutHelper.getAllLicenseByNumber(slObj);
            Test.stopTest();
        }
    }  
    static testmethod void statelicensebcc_SyncBatchSchedulerTest() 
    {
        String CRON_EXP = '0 0 0 15 3 ? *';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new StateLicenseBccMockHttpTest());
        Test.setMock(HttpCalloutMock.class, new StateLicenseBccMockHttpTestNull());
        String jobId = System.schedule('ScheduleStateLicenseDaily',  CRON_EXP, new ScheduleStateLicenseDaily());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        Test.stopTest();
    }
}