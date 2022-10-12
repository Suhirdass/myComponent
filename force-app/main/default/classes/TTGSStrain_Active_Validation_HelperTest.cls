@isTest
public class TTGSStrain_Active_Validation_HelperTest {
 
    @isTest
    Public static void beforeInsertMethod(){
        
       
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        
        Strain__c sTest = new Strain__c();
        sTest.Name = 'Test Strain';
        sTest.isActive__c = true;
        sTest.Strain_Type__c = 'CBD';
        insert sTest;
        
        site__c siteId = new site__c();
        siteId.Name = '2089-3';
        siteId.Warehouse_Name__c = 'San Francisco, CA';
        insert siteId;
        
        
        
        
        TTGS_Strain__c ttgsSTest = new TTGS_Strain__c();
        ttgsSTest.Strain__c = sTest.Id;
        ttgsSTest.Active__c = true;
        ttgsSTest.Site__c = siteId.Id;
        insert ttgsSTest;
        
    }
    
    @isTest
    Public static void beforeUpdateMethod(){
        
     
     Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
     TestUtilData.skipTrigger = true;
        
        Strain__c sTest1 = new Strain__c();
        sTest1.Name = 'Test Strain';
        sTest1.isActive__c = true;
        sTest1.Strain_Type__c = 'CBD';
       // Metrc_HttpCalloutHelper.TTGSActiveValidationTrigger = true;
        insert sTest1;
        
        site__c siteId1 = new site__c();
        siteId1.Name = '2089-3';
        siteId1.Warehouse_Name__c = 'San Francisco, CA';
        insert siteId1;
        
        List<TTGS_Strain__c>lstttg = new List<TTGS_Strain__c>();
         List<TTGS_Strain__c>lstttgupdate = new List<TTGS_Strain__c>();
        TTGS_Strain__c ttgsSTest = new TTGS_Strain__c();
        ttgsSTest.Strain__c = sTest1.Id;
        ttgsSTest.Active__c = false;
        ttgsSTest.Site__c = siteId1.Id;
        Metrc_HttpCalloutHelper.TTGSActiveValidationTrigger = true;
       
        lstttg.add(ttgsSTest);
          insert lstttg;   
               Map<id,TTGS_Strain__c> mapupdated = new Map<id,TTGS_Strain__c>();

        TTGS_Strain__c ttgsSTest2 = new TTGS_Strain__c();
        ttgsSTest2.Id = ttgsSTest.Id;
        ttgsSTest2.Strain__c = sTest1.Id;
        ttgsSTest.Active__c = true;
        ttgsSTest2.Site__c = siteId1.Id;
        Metrc_HttpCalloutHelper.TTGSActiveValidationTrigger = true;
        update ttgsSTest2;
        mapupdated.put(ttgsSTest2.id, ttgsSTest2);
        TTGS_DuplicateSIte_Validation_Helper.beforeUpdate(lstttg, mapupdated);
        
    }
    
    @isTest
    Public static void GetVlaueFromParentInsertMethod(){
        
       
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        
        Strain__c newTest = new Strain__c();
        newTest.Name = 'Test Strain';
        newTest.SativaPercentage__c = 5.00;
        newTest.IndicaPercentage__c = 3.00;
        newTest.CbdLevel__c = 7.0000;
        newTest.ThcLevel__c = 3.0000;
        insert newTest;
        
        List<TTGS_Strain__c>lstttgupdate1 = new List<TTGS_Strain__c>();
        TTGS_Strain__c ttgsSnewTest = new TTGS_Strain__c();
        ttgsSnewTest.Strain__c = newTest.Id;
        ttgsSnewTest.Sativa_Percentage__c = newTest.SativaPercentage__c;
        ttgsSnewTest.Indica_Percentage__c = newTest.IndicaPercentage__c;
        ttgsSnewTest.THC_Level__c = newTest.ThcLevel__c;
        ttgsSnewTest.CBD_Level__c = newTest.CbdLevel__c;
        lstttgupdate1.add(ttgsSnewTest);
    }
}