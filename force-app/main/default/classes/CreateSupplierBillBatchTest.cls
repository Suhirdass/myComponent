@isTest
public class CreateSupplierBillBatchTest {
    @isTest
    static void testCreateSupplierBillMethods(){
        TestUtilData.createTestData();
        
        Brand_Quote__c brandQuote = [SELECT Id, Collection_Status__c , BQ_Status__c FROM Brand_Quote__c LIMIT 1];
        brandQuote.BQ_Status__c = 'Approved';  
        brandQuote.Collection_Status__c = 'Paid in Full';
        update brandQuote;
        
        List<Purchase_Order__c> purchaseOrders = new List<Purchase_Order__c>();    
        for(Purchase_Order__c purchaseOrderObj : [SELECT Id,Bill_Created__c,Payment_Terms__c,Shipping_Terms__c,PO_Status__c,
                                                  Brand_Quote__c,Retailer_Collection_Status__c 
                                                  FROM Purchase_Order__c]){
                                                      purchaseOrderObj.Brand_Quote__c =  brandQuote.Id;
                                                      purchaseOrderObj.PO_Status__c = 'Approved';                                          
                                                      purchaseOrders.add(purchaseOrderObj);
                                                  }
        
        update purchaseOrders;
        update brandQuote; 
         
        Test.startTest();
        CreateSupplierBillBatchSchedule createSupplierBillBatchSchedule = new CreateSupplierBillBatchSchedule(); 
        String cronExpr = '0 0 2 * * ?'; 
        system.schedule('TestCreateSupplierBillBatch', cronExpr, createSupplierBillBatchSchedule);
        Database.executeBatch(new CreateSupplierBillBatch());
        Test.stopTest();
        List<Supplier_Bill__c> supplierBills = [SELECT Id FROM Supplier_Bill__c];
        System.assertEquals(1, supplierBills.size()); 
        Purchase_Order__c purchaseOrder = [SELECT Id, Bill_Created__c FROM Purchase_Order__c LIMIT 1];
        System.assertEquals(true, purchaseOrder.Bill_Created__c);
    } 
}