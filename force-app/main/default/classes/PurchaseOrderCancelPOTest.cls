@isTest(OnInstall=false SeeAllData=false)
public class PurchaseOrderCancelPOTest {
    
    static testMethod void  testCancelPurchaseOrder (){
        Purchase_Order__c  po = [Select Id from Purchase_Order__c LIMIT 1];
        PurchaseOrderCancelPO.getRecordName(po.Id);
        PurchaseOrderCancelPO.cancelPurchaseOrder(po.Id);
        List<Purchase_Order_Line__c> pols =[select Id, Total_Received_Qty__c, (Select Id from Receiving_Lines__r) from Purchase_Order_Line__c where Purchase_Order__c=:po.Id];
        for(Purchase_Order_Line__c pol : pols)
            delete pol.Receiving_Lines__r;

        PurchaseOrderCancelPO.cancelPurchaseOrder(po.Id);
    }
    static testMethod void  testDeletePurchaseOrder (){
        Purchase_Order__c  po = [Select Id from Purchase_Order__c LIMIT 1];
        PurchaseOrderCancelPO.getRecordName(po.Id);
        PurchaseOrderCancelPO.cancelPurchaseOrder(po.Id);
        List<Purchase_Order_Line__c> pols =[select Id, Total_Received_Qty__c, (Select Id from Receiving_Lines__r) from Purchase_Order_Line__c where Purchase_Order__c=:po.Id];
        for(Purchase_Order_Line__c pol : pols)
            delete pol.Receiving_Lines__r;
		Delete po;
        //PurchaseOrderCancelPO.cancelPurchaseOrder(po.Id);
    }
    static testMethod void  testDeletePurchaseOrderLines (){
        Purchase_Order__c  po = [Select Id from Purchase_Order__c LIMIT 1];
        PurchaseOrderCancelPO.getRecordName(po.Id);
        PurchaseOrderCancelPO.cancelPurchaseOrder(po.Id);
        List<Purchase_Order_Line__c> pols =[select Id, Total_Received_Qty__c, (Select Id from Receiving_Lines__r) from Purchase_Order_Line__c where Purchase_Order__c=:po.Id];
        for(Purchase_Order_Line__c pol : pols)
            delete pol.Receiving_Lines__r;
		Delete pols;
        //PurchaseOrderCancelPO.cancelPurchaseOrder(po.Id);
    }
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
    }
}