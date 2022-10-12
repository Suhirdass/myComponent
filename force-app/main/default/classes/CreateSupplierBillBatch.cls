public class CreateSupplierBillBatch implements Database.Batchable<sObject>{
    public String recordTypeId = '';
    public CreateSupplierBillBatch(){
        recordTypeId = Schema.SObjectType.Supplier_Bill__c.getRecordTypeInfosByDeveloperName().get('PO_Bill').getRecordTypeId();   
    }
    public Database.QueryLocator start(Database.BatchableContext BC){
        //Collection_Status__c
        return Database.getQueryLocator([SELECT Id,Bill_Created__c,Total_Cost__c,Next_Payable_Date__c,
                                         Brand_Quote__c,Chart_of_Account__c,Customer_PO_or_Quote__c,Payment_Terms__c,Shipping_Terms__c,
                                         Site__c,Supplier_Name__c, Retailer_Collection_Status__c
                                         FROM Purchase_Order__c 
                                         WHERE Retailer_Collection_Status__c = 'Paid in Full' 
                                         AND Bill_Created__c = FALSE 
                                         AND PO_Status__c='Approved']); 
    }
    
    public void execute(Database.BatchableContext BC, List<Purchase_Order__c> purchaseOrders){
        List<Supplier_Bill__c> supplierBills = new List<Supplier_Bill__c>();
        Map<Id,Supplier_Bill__c> supplierBillsMap = new Map<Id,Supplier_Bill__c>();
        List<Purchase_Order__c> purchaseOrderList = new List<Purchase_Order__c>();
        for(Purchase_Order__c purchaseOrder : purchaseOrders){
            Supplier_Bill__c sb = new Supplier_Bill__c(Bill_Amount__c = purchaseOrder.Total_Cost__c,
                                                   Bill_Due_Date__c = purchaseOrder.Next_Payable_Date__c,
                                                   Brand_Quote__c = purchaseOrder.Brand_Quote__c,
                                                   Chart_of_Account__c = purchaseOrder.Chart_of_Account__c,
                                                   Order_or_Service__c = purchaseOrder.Customer_PO_or_Quote__c,
                                                   Payment_Terms__c = purchaseOrder.Payment_Terms__c,
                                                   Purchase_Order__c = purchaseOrder.Id,
                                                   RecordTypeId = recordTypeId,
                                                   Shipping_Terms__c = purchaseOrder.Shipping_Terms__c,
                                                   Site__c = purchaseOrder.Site__c,
                                                   Status__c = 'Draft',
                                                   Supplier_Name__c = purchaseOrder.Supplier_Name__c);
            //supplierBills.add();
            supplierBillsMap.put(purchaseOrder.Id,sb);
            purchaseOrder.Bill_Created__c = true;
            purchaseOrder.Create_Supplier_Bill__c = true;
            purchaseOrderList.add(purchaseOrder);
        }
        if(!supplierBillsMap.isEmpty()){
            supplierBills = supplierBillsMap.values();
            insert supplierBills;
        }
        
        System.debug('supplierBills='+supplierBills.size());
        update purchaseOrderList;
        for(Purchase_Order__c purchaseOrder : purchaseOrderList){
            System.debug('purchaseOrder.Bill_Created__c='+purchaseOrder.Bill_Created__c);
        }
    }  
    public void finish(Database.BatchableContext BC){ }
}