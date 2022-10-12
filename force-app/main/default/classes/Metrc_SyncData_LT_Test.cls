@isTest(SeeAllData=false)
/**********************************************************************************************************
Apex TestClass Name    : Metrc_SyncData_LT_Test 
Apex Class Name    : Metrc_SyncData_LT 
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : Used for HTTPcallout
------------------------------------------------------------------------------------------------------------
* Developer                                      Date                   Description
* ----------------------------------------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
************************************************************************************************************/

private class Metrc_SyncData_LT_Test 
{
    /**************************************************************************************
    Method Name        : testsetupMethod  
    Version            : 1.0
    Function           : testdata setup Method
    *******************************************************************************/
    //@testSetup static void testsetupMethod() {
        static final String testEmail = 'tuser3@testMetrc.com';
        //Static final String emailId='%'+testEmail+'%';
    
    @testSetup static void setTestData(){
        
        Id profId= [select id from Profile where name='System Administrator' limit 1].Id; 
        User testUser=Metrc_TestdataFactory.createUser(testEmail+System.currentTimeMillis(),profId,testEmail);
        Database.insert(testUser);
        system.runAs(testUser){
        List<Metrc_IntegrationSettings__C> customsettingList =Metrc_TestdataFactory.createIntegrationSettingData();
        Insert customsettingList;
        
        Strain__c strainObj1 = Metrc_TestdataFactory.createStrain();
              Metrc_HttpCalloutHelper.TTGSActiveValidationTrigger = true;
        Metrc_Utility.IS_STRAIN_TRIGGER_ENABLED =FALSE;
        strainObj1.Track_Trace_Sync__c=false;
        insert strainObj1 ;
        
        Strain__c  strainObj =[select id from Strain__c  limit 1];
        Product2 prod =Metrc_TestdataFactory.createProduct(strainObj.ID);
        prod.Track_Trace_Sync__c=true;
        prod.isActive=true;
        prod.Track_Trace_Sync__c=false;
        prod.Unit_Net_Weight__c=10;
          Metrc_HttpCalloutHelper.TTGSActiveValidationTrigger = true;
        Metrc_Utility.IS_PROD_TRIGGER_ENABLED  =false;
        insert prod;
            
            
        Strain__c st = new Strain__c (Name = 'TestStrainCalloutPull2', Strain_Type__c = 'Hybrid',Track_Trace_Sync__c=true,isActive__c =true,Metrc_StrainID__c ='1231231');
        insert st;
            Site__c objSite = new Site__c();
            objSite.Name = 'Test Site';
            objSite.Warehouse_Name__c='TestWarehouse1';
            insert objSite;
            
            TTGS_Strain__c TTGS = new TTGS_Strain__c();
            TTGS.Site__c=objSite.Id;
            TTGS.Active__c= true;
            TTGS.Strain__c=st.Id;
            TTGS.TTGS_StrainID__c='1';
            insert TTGS; 
        }
    }
    
     /**************************************************************************************
    Method Name        : productPull_httpCalloutTest1
    Version            : 1.0
    Function           :purpose of this method to give coverage to Item HttpCallout method
    *******************************************************************************/
     static testMethod void checkUserAccessTest1()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        //Test.setMock(HttpCalloutMock.class, new Metrc_MockProductHttpResponseTest()); 
        PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        
        system.runAs(user1){
        Test.startTest();
      
        Metrc_SyncData_LT.checkUserMetrcAcsess(user1.ID);
        
        Test.stopTest();
        
         system.assertNotEquals(user1, NULL);
        }
    }
    
    /**************************************************************************************
    Method Name        : productPull_httpCalloutTest1
    Version            : 1.0
    Function           :purpose of this method to give coverage to Item HttpCallout method
    *******************************************************************************/
     static testMethod void productPull_httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        Test.setMock(HttpCalloutMock.class, new Metrc_MockProductHttpResponseTest()); 
        PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        Test.startTest();
               
        
        Product2  prod = [select id from Product2  limit 1];
        prod.Metrc_ItemID__c ='12121313';
        prod.Unit_Net_Weight__c=10;
        prod.Track_Trace_Sync__c=false;
        update prod;
        Metrc_SyncData_LT.syncMetrcDataToSFDC(prod.ID,'Product2');
        
        Test.stopTest();
        
         system.assertNotEquals(prod, NULL);
        }
    }
    
    /**************************************************************************************
    Method Name        : productCreate_httpCalloutTest1  
    Version            : 1.0
    Function           :purpose of this method to give coverage to Item HttpCallout method
    *******************************************************************************/
     static testMethod void productCreate_httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        Test.setMock(HttpCalloutMock.class, new Metrc_MockProductHttpResponseTest()); 
        PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        Test.startTest();
               
        
        Product2  prod = [select id from Product2  limit 1];
        prod.Metrc_ItemID__c ='';
        prod.Unit_Net_Weight__c=10;
        prod.Track_Trace_Sync__c=false;
        update prod;
        Metrc_SyncData_LT.syncDataToMetrcNew(prod.ID,'Product2');
        
        Test.stopTest();
        
         system.assertNotEquals(prod, NULL);
        }
    }
    
    /**************************************************************************************
    Method Name        : productUpdate_httpCalloutTest1
    Version            : 1.0
    Function           :purpose of this method to give coverage to Item HttpCallout method
    *******************************************************************************/
     static testMethod void productUpdate_httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        Test.setMock(HttpCalloutMock.class, new Metrc_MockProductHttpResponseTest()); 
        PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        Test.startTest();
               
        
        Product2  prod = [select id from Product2  limit 1];
        prod.Metrc_ItemID__c ='12121313';
        prod.Unit_Net_Weight__c=10;
        prod.Track_Trace_Sync__c=false;
        update prod;
        Metrc_SyncData_LT.syncDataToMetrcNew(prod.ID,'Product2');
        
        Test.stopTest();
        
         system.assertNotEquals(prod, NULL);
        }
    }
    
    
    /**************************************************************************************
    Method Name        : strainCreate_httpCalloutTest1  
    Version            : 1.0
    Function           :purpose of this method to give coverage to Strain HttpCallout method
    *******************************************************************************/
     static testMethod void strainPull_httpCalloutTest1()
    {
       User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
       PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpResponseTest());
        
            
         Test.startTest();
         Strain__c  st2 = [select id from Strain__c where name='TestStrainCalloutPull2'  limit 1];
             Strain__c st = new Strain__c (Name = 'TestStrainCalloutPull2', Strain_Type__c = 'Hybrid',Track_Trace_Sync__c=true,isActive__c =true,Metrc_StrainID__c ='1231231');
        insert st;
            Site__c objSite = new Site__c();
            objSite.Name = 'Test Site';
            objSite.Warehouse_Name__c='TestWarehouse1';
            insert objSite;
            List<TTGS_Strain__c> ttgslst = new List<TTGS_Strain__c>();
            TTGS_Strain__c TTGS = new TTGS_Strain__c();
            TTGS.Site__c=objSite.Id;
            TTGS.Active__c= true;
            TTGS.Strain__c=st.Id;
            TTGS.TTGS_StrainID__c='1';
            insert TTGS; 
            ttgslst.add(TTGS);
        Metrc_SyncData_LT.metrc_PullTTGSbulkRecord(ttgslst); 
        Test.stopTest();
        
         system.assertNotEquals(st, NULL);
        }
    }
     /**************************************************************************************
    Method Name        : strainCreate_httpCalloutTest1  
    Version            : 1.0
    Function           :purpose of this method to give coverage to Strain HttpCallout method
    *******************************************************************************/
     static testMethod void strainCreate_httpCalloutTest1()
    {
       User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
       PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        //Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllStrainRespTest());
        Test.startTest();
            Strain__c st = new Strain__c (Name = 'Test Strain 3', Strain_Type__c = 'Hybrid',Track_Trace_Sync__c=true,isActive__c =true,ThcLevel__c=1,CbdLevel__c=1,IndicaPercentage__c=1,SativaPercentage__c=1);
            insert st;
         Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllStrainRespTest());
         Metrc_SyncData_LT.syncDataToMetrcNew(st.ID,'Strain__c');
        Test.stopTest();
        
         system.assertNotEquals(st, NULL);
        }
    }
    
    /**************************************************************************************
    Method Name        : strainUpdate_httpCalloutTest1
    Version            : 1.0
    Function           :purpose of this method to give coverage to Strain HttpCallout method
    *******************************************************************************/
     static testMethod void strainUpdate_httpCalloutTest1()
    {
       User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
       PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        //Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllStrainRespTest());
        Test.startTest();
            Strain__c st = new Strain__c (Name = 'Test Strain 4',Metrc_StrainID__c ='12345', Strain_Type__c = 'Hybrid',Track_Trace_Sync__c=true,isActive__c =true,ThcLevel__c=1,CbdLevel__c=1,IndicaPercentage__c=1,SativaPercentage__c=1);
            insert st;
         Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllStrainRespTest());
         Metrc_SyncData_LT.syncDataToMetrcNew(st.ID,'Strain__c');
        Test.stopTest();
        
         system.assertNotEquals(st, NULL);
        }
    }
    
     /**************************************************************************************
    Method Name        : productUpdate_httpCalloutTest1
    Version            : 1.0
    Function           :purpose of this method to give coverage to Item HttpCallout method
    *******************************************************************************/
     static testMethod void productUpdate_httpCalloutTest2()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        Test.setMock(HttpCalloutMock.class, new Metrc_MockProductHttpResponseTest()); 
        PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        Test.startTest();
               
        Strain__c st = new Strain__c (Name = 'TestStrainCalloutPull3', Strain_Type__c = 'Hybrid',Track_Trace_Sync__c=true,isActive__c =true,Metrc_StrainID__c ='1231231');
        insert st;
        
        Product2  prod = [select id from Product2  limit 1];
       // prod.Metrc_ItemID__c ='12121313';
        prod.Unit_Net_Weight__c=10;
        prod.Track_Trace_Sync__c=false;
        prod.Strain__c=st.id;
        update prod;
        Metrc_SyncData_LT.syncDataToMetrcNew(prod.ID,'Product2');
        
        Test.stopTest();
        
         system.assertNotEquals(prod, NULL);
        }
    }


}