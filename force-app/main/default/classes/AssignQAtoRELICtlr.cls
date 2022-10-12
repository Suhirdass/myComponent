public class AssignQAtoRELICtlr {
    public AssignQAtoRELICtlr(){
        
    }
	@AuraEnabled
    public static AuraResponse getPOandRELIsDeatils(String poId){
        AuraResponse r = new AuraResponse('AssignQAtoRELICtlr.AssignQAtoRELICtlr()');
        Purchase_Order__c poData = [select id, Name, PO_Status__c, Supplier_Name__r.Name, Ownership__c, Site__c, Site__r.Name,Site__r.Warehouse_Name__c,Brand_Quote__r.Name,Brand_Quote__r.Id,Opportunity_Name__r.Order__c,
                         Customer_PO_or_Quote__c,Purchase_Order_Instructions__c,PO_Date__c,Ownership__r.Name,Supplier_Name__c, Supplier_DBA__c, RecordType.developername,
                         RecordType.name,Distributor_Name__r.DBA__c,Supplier_Contact__r.Name,Supplier_Contact__c,Distributor_Name__c,Receiver_DBA__c,Receiver_Name__c, Opportunity_Name__c from Purchase_Order__c where id =: poId];
        
        List<Receiving_Line__c> RELIs = [SELECT id,Name,Receiving_ID__c,Receiving_ID__r.Name,Product_Name__r.Name,Qty_to_Receive__c,Unit_Cost__c
                                         ,Harvest_Batch_Code__r.Name,UID_New__r.Name,Producer_Name__c,(SELECT id,Name FROM Quality_Assurances__r LIMIT 1)  FROM Receiving_Line__c WHERE Purchase_Order_Line__r.Purchase_Order__c =:poId];
        
        
        r.data.put('poData', poData);
        r.data.put('receivingLines',RELIs);
        return r;
    }
    
}