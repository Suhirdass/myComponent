public class PurchaseOrderCancelPO {
    
	@AuraEnabled
    public Static Boolean cancelPurchaseOrder (id recordId){
        List<Purchase_Order_Line__c> pols =[select Id, Total_Received_Qty__c, Qty_Ordered__c ,Brand_Quote_Line__c, Brand_Quote_Line__r.Invoiced_Quantity__c FROM Purchase_Order_Line__c where Purchase_Order__c=:recordId];
        List<Brand_Quote_Line__c> bqLines = new List<Brand_Quote_Line__c>();
        for(Integer i=0;i<pols.size();i++){
            if(pols[i].Total_Received_Qty__c>0){
             	return false;   
            }else if(pols[i].Brand_Quote_Line__r != null && pols[i].Brand_Quote_Line__r.Invoiced_Quantity__c != null && pols[i].Qty_Ordered__c!=null){
                pols[i].POLI_Status__c = 'Cancelled'; 
                Decimal qty = pols[i].Brand_Quote_Line__r.Invoiced_Quantity__c >0 ? pols[i].Brand_Quote_Line__r.Invoiced_Quantity__c - pols[i].Qty_Ordered__c : 0;
                bqLines.add(new Brand_Quote_Line__c(Id=pols[i].Brand_Quote_Line__c,Invoiced_Quantity__c = qty));
            } 
        }
        Purchase_Order__c po = new Purchase_Order__c(Id=recordId, PO_Status__c = 'Cancelled'); 
        update po;
        update pols;
        update bqLines;
        return true;
    }
    @Auraenabled
    public static String getRecordName(Id recordId){
        return DataCRUDUtility.getRecordName(recordId);
    }
}