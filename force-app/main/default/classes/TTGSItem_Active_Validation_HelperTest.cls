@isTest
public class TTGSItem_Active_Validation_HelperTest {

    /*
    @isTest
    Public static void beforeInsertMethod(){
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hold__c=true;
        objAccount.DBA__c='Test Account1';
        objAccount.Hide_from_Marketplace__c = false;
       // objAccount.Membership_Level__c = 'Enterprise';
       // objAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
        insert objAccount;
       
        Product2 pTest = new Product2();
        pTest.Name = 'Test Product';
      // pTest.Name = 'LOB-LemonCookies-H-C-PAX-0.5';
        pTest.Description = 'Cartridge, PAX - Lemon Cookies, .5g, Hybrid';
        pTest.Product_Short_Description__c = 'Lemon Cookies, .5g, PAX Pod';
        pTest.Family = 'Accessories';
        pTest.Apply_Cultivation_Tax__c = 'Yes';
        pTest.Apply_Excise_Tax__c = 'Yes';
        pTest.Producer_Name__c = objAccount.Id;
        pTest.Retail_Unit_Form_Factor__c = 'Bag';
        pTest.MOQ__c = 3;
        insert pTest;
        
        site__c siteId = new site__c();
        siteId.Name = '2089-3';
        siteId.Warehouse_Name__c = 'San Francisco, CA';
        insert siteId;
        
        TTGS_Item__c ttgsITest = new TTGS_Item__c();
        ttgsITest.Product_Name__c = pTest.Id;
        ttgsITest.Site__c = siteId.Id;
        insert ttgsITest;
        
    } */
    
    @isTest
    Public static void beforeInsertMethod(){
        
       
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hold__c=true;
        objAccount.DBA__c='Test Account1';
        objAccount.Hide_from_Marketplace__c = false;
        insert objAccount;
        
        Product2 pTest = new Product2();
        pTest.Name = 'Test Product';
        pTest.Description = 'Cartridge, PAX - Lemon Cookies, .5g, Hybrid';
        pTest.Product_Short_Description__c = 'Lemon Cookies, .5g, PAX Pod';
        pTest.Family = 'Accessories';
        pTest.Apply_Cultivation_Tax__c = 'Yes';
        pTest.Apply_Excise_Tax__c = 'Yes';
        pTest.Producer_Name__c = objAccount.Id;
        pTest.Retail_Unit_Form_Factor__c = 'Bag';
        pTest.MOQ__c = 3;
        insert pTest;
        
        site__c siteId = new site__c();
        siteId.Name = '2089-3';
        siteId.Warehouse_Name__c = 'San Francisco, CA';
        insert siteId;
        
        
        TTGS_Item__c ttgsITest = new TTGS_Item__c();
        ttgsITest.Product_Name__c = pTest.Id;
        ttgsITest.Site__c = siteId.Id;
        insert ttgsITest;
        
    }
    
    @isTest
    Public static void beforeUpdateMethod(){
        
     
     Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
     TestUtilData.skipTrigger = true;
        
        Account objAccount1 = new Account();
        objAccount1.Name = 'Test Account1';
        objAccount1.Payment_Terms__c = 'COD';
        objAccount1.Hold__c=true;
        objAccount1.DBA__c='Test Account1';
        objAccount1.Hide_from_Marketplace__c = false;
        insert objAccount1;
        
        Product2 pTest1 = new Product2();
        pTest1.Name = 'Test Product';
        pTest1.Description = 'Cartridge, PAX - Lemon Cookies, .5g, Hybrid';
        pTest1.Product_Short_Description__c = 'Lemon Cookies, .5g, PAX Pod';
        pTest1.Family = 'Accessories';
        pTest1.Apply_Cultivation_Tax__c = 'Yes';
        pTest1.Apply_Excise_Tax__c = 'Yes';
        pTest1.Producer_Name__c = objAccount1.Id;
        pTest1.Retail_Unit_Form_Factor__c = 'Bag';
        pTest1.MOQ__c = 3;
        insert pTest1;
        
        site__c siteId1 = new site__c();
        siteId1.Name = '2089-3';
        siteId1.Warehouse_Name__c = 'San Francisco, CA';
        insert siteId1;
        
        List<TTGS_Item__c>lstttg = new List<TTGS_Item__c>();
        TTGS_Item__c ttgsSTest = new TTGS_Item__c();
        ttgsSTest.Product_Name__c = pTest1.Id;
        ttgsSTest.Site__c = siteId1.Id;
        Metrc_HttpCalloutHelper.TTGSActiveValidationTrigger = true;
       
        lstttg.add(ttgsSTest);
          insert lstttg;   
               Map<id,TTGS_Item__c> mapupdated = new Map<id,TTGS_Item__c>();

        TTGS_Item__c ttgsSTest2 = new TTGS_Item__c();
        ttgsSTest2.Id = ttgsSTest.Id;
        ttgsSTest2.Product_Name__c = pTest1.Id;
        ttgsSTest2.Site__c = siteId1.Id;
        Metrc_HttpCalloutHelper.TTGSActiveValidationTrigger = true;
        update ttgsSTest2;
        mapupdated.put(ttgsSTest2.id, ttgsSTest2);
        TTGSItem_Active_Validation_Helper.beforeUpdate(lstttg, mapupdated);
  
    }
    
}