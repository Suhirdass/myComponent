@isTest
public class PurchaseOrderLineTriggerTest {
	static testMethod void  runTest (){
        TestUtilData.skipTrigger = true;
        OrderHelper.runningTrigger= true;
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
            insert GDMIs;
         TestUtilData.createTestData();
        Purchase_Order__c  po = [Select Id,PO_Status__c,Site__c,Ownership__c  from Purchase_Order__c LIMIT 1];
        po.PO_Status__c ='Cancelled';
        po.Total_Weight_Fee__c =1;
        update po;
        po.PO_Status__c ='Closed';
        po.Total_Mileage_Fee__c =1;
        update po;
        Purchase_Order_Line__c[] lines = [SELECT Id,Qty_Ordered__c,Product_Name__c FROM Purchase_Order_Line__c];
        
        
        // Create 3 receiving lines which will create inventory positions automatically
        List<Receiving_Line__c> receivingLines = [SELECT Purchase_Order_Line__c,Purchase_Order_Line__r.Qty_Ordered__c FROM Receiving_Line__c];
        for(Receiving_Line__c RL: receivingLines){
            RL.Qty_to_Receive__c = RL.Purchase_Order_Line__r.Qty_Ordered__c;
        }
        Test.startTest();
        update receivingLines;
    }
    static testMethod void  runDeletePOLineTest (){
        TestUtilData.skipTrigger = true;
        OrderHelper.runningTrigger= true;
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
            insert GDMIs;
         TestUtilData.createTestData();
        Purchase_Order__c  po = [Select Id,PO_Status__c,Site__c,Ownership__c  from Purchase_Order__c LIMIT 1];
        Purchase_Order_Line__c[] lines = [SELECT Id,Qty_Ordered__c,Product_Name__c FROM Purchase_Order_Line__c LIMIT 1];
        delete lines;
        delete po;
    }
}