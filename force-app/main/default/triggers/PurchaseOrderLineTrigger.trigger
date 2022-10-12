trigger PurchaseOrderLineTrigger on Purchase_Order_Line__c (after insert,after update,before insert,before update,before delete) {
    
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        
        if( ShippingManifestLineTriggerHandler.isSmlinePartialFromSmComple == False)
        {
            PurchaseOrderLineHelper.onAfterUpdate(Trigger.new,Trigger.oldMap);
        }
        
    }
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        if(Trigger.isInsert){
            PurchaseOrderLineHelper.onbeforeInsert(Trigger.new);
        }
        PurchaseOrderLineHelper.onBeforeUpdate(Trigger.new,Trigger.oldMap);
    }
    if(Trigger.isBefore && Trigger.isDelete){
        PurchaseOrderLineHelper.onBeforeDelete(Trigger.old);
    }
	/*List<Brand_Quote_Line__c> bqLines = new List<Brand_Quote_Line__c>();
    List<Purchase_Order_Line__c> polis = [SELECT 
                                          Brand_Quote_Line__c,Qty_Ordered__c,
                                          Brand_Quote_Line__r.Invoiced_Quantity__c
                                          FROM Purchase_Order_Line__c
                                          WHERE Id IN : Trigger.Old];
    
    for(Purchase_Order_Line__c poli : polis){
        if(poli.Brand_Quote_Line__c != null && poli.Brand_Quote_Line__r.Invoiced_Quantity__c != null && poli.Qty_Ordered__c != null){
            Decimal qty = poli.Brand_Quote_Line__r.Invoiced_Quantity__c - poli.Qty_Ordered__c;
            bqLines.add(new Brand_Quote_Line__c(Id=poli.Brand_Quote_Line__c,Invoiced_Quantity__c = qty));     
        }  
    }
    if(bqLines.size() > 0){
        update bqLines;
    }*/
}