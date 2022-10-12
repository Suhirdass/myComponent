@isTest
public class PublishShippingManifestToSlackTest {
	
    @isTest
    private static void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
       
        Sales_Order__c salesObj = [SELECT Id,Brand_Quote__c,Planned_Ship_Date__c ,Distributor_Contact__c,Distributor_License__c,Distributor_Name__c,
                                   Opportunity_Name__c,Payment_Terms__c,Receiver_Contact__c,Receiver_License__c,Receiver_Name__c,Sample_Order__c,
                                   Shipping_Method__c ,Shipping_Terms__c  ,Site__c,Supplier_Contact__c,Supplier_License__c,Supplier_Name__c 
                                   FROM Sales_Order__c LIMIT 1];
        
        Shipping_Manifest__c sm = TestUtilData.createTSM(salesObj,false);
        sm.Slack_Notes__c = 'Test Note';
        insert sm;
       string status ;
        status = PublishShippingManifestToSlack.Shipping_Manifest_LineStatus_Rejected;
        PublishShippingManifestToSlack.publishToSlack(new List<Id>{sm.Id});
        
    }
}