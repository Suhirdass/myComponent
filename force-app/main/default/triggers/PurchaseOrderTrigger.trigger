/**************************************************************************************
Apex Class Name    : PurchaseOrderTrigger 
Test Class Name    : 
Version            : 1.0
Created Date       : 19/Feb/2020
Function           : after update - Used for updating the BQL.Billed_Quantity__c  on cancellation of PO. 
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresha Shettigar           19/Feb/2020              Original Version
*******************************************************************************/

trigger PurchaseOrderTrigger on Purchase_Order__c (before delete,after update,after insert) {
    public Static String PURCHASE_ORDER_STATUS_CANCELLED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_CANCELLED) ? PURCHASE_ORDER_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase_Order_Status_Cancelled');
        }set;
    }
    
    if(Trigger.isdelete){
        Decimal qty=0;
        Set<Id> poIds = new Set<Id>();
        for(Purchase_Order__c po : Trigger.Old){
            poIds.add(po.Id);
        }
        List<Brand_Quote_Line__c> bqLines = new List<Brand_Quote_Line__c>();
        for(Purchase_Order_Line__c poli : [select Id, Total_Received_Qty__c, Qty_Ordered__c ,Brand_Quote_Line__c, Brand_Quote_Line__r.Invoiced_Quantity__c FROM Purchase_Order_Line__c where Purchase_Order__c IN :poIds]){
            

            if(poli !=null && poli.Brand_Quote_Line__r != null && poli.Brand_Quote_Line__r.Invoiced_Quantity__c !=null ) {
            qty = poli.Brand_Quote_Line__r.Invoiced_Quantity__c - poli.Qty_Ordered__c;
            }
            if(qty > 0)
                bqLines.add(new Brand_Quote_Line__c(Id=poli.Brand_Quote_Line__c,Invoiced_Quantity__c = qty));
        }
        if(!bqLines.isEmpty()){
            update bqLines;
        }
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        List<Id> poIds = new List<Id>();
        for(integer i =0;i< Trigger.Old.size() ;i++){
            if(Trigger.Old[i].PO_Status__c != PURCHASE_ORDER_STATUS_CANCELLED && Trigger.new[i].PO_Status__c == PURCHASE_ORDER_STATUS_CANCELLED){
                poIds.add(Trigger.Old[i].Id);
            }
        }
        if(poIds.size() > 0 ){
            PurchaseOrderHelper.updateBrandQuoteLineQty(poIds); 
        }
    
    PurchaseOrderHelper.updateWinStartEnd(trigger.new, trigger.oldMap);
    }   
    if(Trigger.isAfter && Trigger.isInsert){
        List<Id> BQIds = new List<Id>();
        for(Purchase_Order__c PO : Trigger.new){
            if(PO.Brand_Quote__c != null){
                BQIds.add(PO.Brand_Quote__c);
            }
        }
        if(BQIds.size()>0){
            PurchaseOrderHelper.updateBrandQuote(BQIds);
        }
    }
    
    /*if(Trigger.isAfter && (Trigger.isUpdate || Trigger.isInsert)){
        Set<String>POIdSet = new Set<String>();
        for(Purchase_Order__c PO : Trigger.new){
            if(PO.PO_Status__c == PURCHASE_ORDER_STATUS_CLOSED && (Trigger.isInsert || (Trigger.isUpdate && PO.PO_Status__c != Trigger.oldMap.get(PO.Id).PO_Status__c))){
            	POIdSet.add(PO.Id);
            }
        }
        if(POIdSet.size() > 0)
            PurchaseOrderHelper.createServiceInvoice(POIdSet);
    }*/
}