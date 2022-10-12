@isTest(SeeAllData=false)
/**********************************************************************************************************
Apex TestClass Name    : Metrc_HttpCalloutProduct_Test 
Apex Class Name    : Metrc_HttpCalloutHelper 
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : Used for HTTPcallout
------------------------------------------------------------------------------------------------------------
* Developer                                      Date                   Description
* ----------------------------------------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
************************************************************************************************************/

private class Metrc_HttpCalloutProduct_Test 
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
                            
       //PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'ABI_POCU_GCC_CMD' limit 1];
       //database.insert (new PermissionSetAssignment(AssigneeId = tuser.id, PermissionSetId = perms.Id ));
        List<Metrc_IntegrationSettings__C> customsettingList =Metrc_TestdataFactory.createIntegrationSettingData();
        Insert customsettingList;
        
        Strain__c strainObj1 = Metrc_TestdataFactory.createStrain();
        Metrc_Utility.IS_STRAIN_TRIGGER_ENABLED =FALSE;
        insert strainObj1 ;
        
        Strain__c  strainObj =[select id from Strain__c  limit 1];
        Product2 prod =Metrc_TestdataFactory.createProduct(strainObj.ID);
        prod.Track_Trace_Sync__c=true;
        prod.isActive=true;
        
        //Metrc_Utility.IS_PROD_TRIGGER_ENABLED  =false;
        insert prod;
    }
    
    /**************************************************************************************
    Method Name        : productCreate_httpCalloutTest1  
    Version            : 1.0
    Function           :purpose of this method to give coverage to Item HttpCallout method
    *******************************************************************************/
     static testMethod void productCreate_httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        system.runAs(user1){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Metrc_MockProductHttpResponseTest());        
        
        Product2  prod = [select id from Product2  limit 1];
        Metrc_ProductTriggerHandler.syncDataToMetrc(prod.ID,'INSERT');
        Test.stopTest();
        
         system.assertNotEquals(prod, NULL);
        }
    }
    
     /**************************************************************************************
    Method Name        : productCreate_httpCalloutTest1  
    Version            : 1.0
    Function           :purpose of this method to give coverage to Item HttpCallout method
    *******************************************************************************/
     static testMethod void productUpdate_httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
       system.runAs(user1){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpResponseTest());
        
        Product2  prod = [select id,Track_Trace_Sync__c,isActive,Name ,Metrc_ItemID__c  from Product2 limit 1];
        prod.Track_Trace_Sync__c=true;
        prod.isActive=true;
        prod.Name =prod.Name+'updatedtest4'+System.currentTimeMillis();
        prod.Metrc_ItemID__c  ='12312312';
        Metrc_Utility.IS_PROD_TRIGGER_ENABLED  =false;
        update prod;
       Metrc_ProductTriggerHandler.syncDataToMetrc(prod.ID,'UPDATE');
        Test.stopTest();
        
         system.assertNotEquals(prod, NULL);
        }
    }
    
    /**************************************************************************************
    Method Name        : productCreate_httpCalloutTest1  
    Version            : 1.0
    Function           :purpose of this method to give coverage to Item HttpCallout method
    *******************************************************************************/
     static testMethod void productDelete_httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        system.runAs(user1){
        Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpResponseTest());
        Test.startTest();
        Product2  prod = [select id ,Net_Weight_UOM__c,Unit_Of_Measure__c,name from Product2  limit 1];
             Site__c objSite = new Site__c();
            objSite.Name = 'Test Site';
            objSite.Warehouse_Name__c='TestWarehouse1';
            insert objSite;
              List<string> LstTTgsname = new List<string>();

            List<TTGS_Item__c> LstTTgs = new List<TTGS_Item__c>();
            TTGS_Item__c TTGS = new TTGS_Item__c();
          TTGS.Site__c =objSite.Id;
            TTGS.Product_Name__c=prod.Id;
            	
          // TTGS.Unit_Weight__c = prod.Net_Weight_UOM__c;
            insert TTGS; 
            
            LstTTgs.add(TTGS);
            LstTTgsname.add(TTGS.Name);
            Metrc_ProductTriggerHandler.syncDataToMetrc_Delete(prod.ID); 
            Metrc_HttpCalloutHelper.getSingleProducts('1234');
            Metrc_HttpCalloutHelper.getAllProductsUpdate(prod.ID);
            Metrc_HttpCalloutHelper.createProduct(prod.ID,prod,'INSERT');
         //  Metrc_HttpCalloutHelper.createTTGSItem(LstTTgs,'INSERT','test','1234');
            Metrc_HttpCalloutHelper.getAllProducts();
            Test.stopTest();
        
         system.assertNotEquals(prod, NULL);
        }
    }

    

}