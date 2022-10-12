public class PurchaseOrderLineHelper {
    public Static String PURCHASE_ORDER_STATUS_CLOSED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_CLOSED) ? PURCHASE_ORDER_STATUS_CLOSED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase_Order_Status_Closed');
        }set;
    }
    public Static String PURCHASE_ORDER_LINE_STATUS_CLOSED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_LINE_STATUS_CLOSED) ? PURCHASE_ORDER_LINE_STATUS_CLOSED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POLI_Status_Closed');
        }set;
    }
    public Static String PURCHASE_ORDER_LINE_STATUS_CANCELLED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_LINE_STATUS_CANCELLED) ? PURCHASE_ORDER_LINE_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POLI_Status_Cancelled');
        }set;
    }
    public Static String POL_Record_Type_DevName_Product{
        get{
            return String.isNotBlank(POL_Record_Type_DevName_Product) ? POL_Record_Type_DevName_Product: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POL_Record_Type_DevName_Product');
        }set;
    }
    public Static String POLI_Status_Partially_Received{
        get{
            return String.isNotBlank(POLI_Status_Partially_Received) ? POLI_Status_Partially_Received: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POLI_Status_Partially_Received');
        }set;
    }
    public Static String ST_Transfer_Method_Product_Conversions{
        get{
            return String.isNotBlank(ST_Transfer_Method_Product_Conversions) ? ST_Transfer_Method_Product_Conversions: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Transfer_Method_Product_Conversions');
        }set;
    }
    Public Static String INVOICE_AR_STATUS_CANCELLED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_CANCELLED) ? INVOICE_AR_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Cancelled');
        }set;
    }
    Public Static String INVOICE_AR_STATUS_REJECTED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_REJECTED) ? INVOICE_AR_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Rejected');
        }set;
    }
    
    public static void onbeforeInsert(List<Purchase_Order_Line__c> newPOs){
        Set<Id> parentIds = new Set<Id>();
        for (Purchase_Order_Line__c newRecord : newPOs){
            if(newRecord.Product_Name__c != null) parentIds.add(newRecord.Product_Name__c);
        }
        if(parentIds.size() > 0){
            Map<Id, Product2> parents = new Map<Id, Product2>([ SELECT Id,Name,Cannabis_Category_1__c,Unit_Cannabis_Weight_1__c,Unit_Cultivation_Tax_1__c,
                                                           Cannabis_Ratio_1__c,Cannabis_Category_2__c,Unit_Cannabis_Weight_2__c,Unit_Cultivation_Tax_2__c,
                                                           Cannabis_Ratio_2__c FROM Product2 WHERE Id IN :parentIds]);
            for (Purchase_Order_Line__c newRecord : newPOs){
                if(parents.containskey(newRecord.Product_Name__c)){
                    Product2 product = parents.get(newRecord.Product_Name__c);
                    if(product.Unit_Cultivation_Tax_1__c != null && product.Cannabis_Category_1__c != null && product.Unit_Cannabis_Weight_1__c != null && product.Cannabis_Ratio_1__c != null){
                    	newRecord.Cannabis_Ratio_1__c = product.Cannabis_Ratio_1__c;
                        newRecord.Cannabis_Category_1__c = product.Cannabis_Category_1__c; 
                        newRecord.Unit_Cannabis_Weight_1__c = product.Unit_Cannabis_Weight_1__c;
                        newRecord.Unit_Cultivation_Tax_1__c = product.Unit_Cultivation_Tax_1__c;
                    }
                    if(product.Unit_Cultivation_Tax_2__c != null && product.Cannabis_Category_2__c != null && product.Unit_Cannabis_Weight_2__c != null && product.Cannabis_Ratio_2__c != null){
                    	newRecord.Cannabis_Ratio_2__c = product.Cannabis_Ratio_2__c;
                        newRecord.Cannabis_Category_2__c = product.Cannabis_Category_2__c; 
                        newRecord.Unit_Cannabis_Weight_2__c = product.Unit_Cannabis_Weight_2__c;
                        newRecord.Unit_Cultivation_Tax_2__c = product.Unit_Cultivation_Tax_2__c;
                    }
                }
            }
        }
    }
    
    public static void onBeforeUpdate(List<Purchase_Order_Line__c> newPOs, Map<Id,Purchase_Order_Line__c> oldMap){
        for(Purchase_Order_Line__c POLI: newPOs){
            System.debug('##Balance_Qty__c:'+POLI.Balance_Qty__c);
            String recDevloperName = Schema.getGlobalDescribe().get('Purchase_Order_Line__c').getDescribe().getRecordTypeInfosById().get(POLI.RecordTypeId).getDeveloperName();
            if(((POLI.POLI_Status__c  != PURCHASE_ORDER_LINE_STATUS_CLOSED && POLI.POLI_Status__c  != PURCHASE_ORDER_LINE_STATUS_CANCELLED) && recDevloperName == POL_Record_Type_DevName_Product) && (Trigger.isInsert || (Trigger.isUpdate && POLI.Balance_Qty__c  != oldMap.get(POLI.Id).Balance_Qty__c))){
                if(POLI.Balance_Qty__c != 0 && POLI.Total_Received_Qty__c > 0){
                    POLI.POLI_Status__c = POLI_Status_Partially_Received;
                }
                if(POLI.Balance_Qty__c == 0){
                    
                    POLI.POLI_Status__c = PURCHASE_ORDER_LINE_STATUS_CLOSED;
                    system.debug('###PURCHASE_ORDER_LINE_STATUS_CLOSED  :'+POLI.POLI_Status__c);
                }
            }
        }
    }
    public static void onAfterUpdate(List<Purchase_Order_Line__c> newPOs, Map<Id,Purchase_Order_Line__c> oldMap){
        System.debug('###onAfterUpdate...');
        Set<Id> POIds = new Set<Id>();
        Set<Id> closedPOIds = new Set<Id>();
        for(Purchase_Order_Line__c POLI: newPOs){
            if(Trigger.isInsert ||(Trigger.isUpdate && (POLI.POLI_Status__c  != oldMap.get(POLI.Id).POLI_Status__c  || 
                                                        POLI.Qty_Ordered__c != oldMap.get(POLI.Id).Qty_Ordered__c || 
                                                        POLI.Total_Received_Qty__c != oldMap.get(POLI.Id).Total_Received_Qty__c))){
                POIds.add(POLI.Purchase_Order__c);
            }
            if(Trigger.isUpdate && POLI.POLI_Status__c == PURCHASE_ORDER_STATUS_CLOSED && POLI.POLI_Status__c  != oldMap.get(POLI.Id).POLI_Status__c){
                closedPOIds.add(POLI.Purchase_Order__c);
            }
        }
        System.debug('##POIds:'+POIds);
        Map<Id,Service_Ticket__c> serviceTicketsMap = new Map<Id,Service_Ticket__c>();
        if(POIds.size() > 0){
            List<Purchase_Order__c> POList = [SELECT Id,Goods_Receipt_Date__c, Opportunity_Name__c ,PO_Status__c, (SELECT Id,Balance_Qty__c FROM Purchase_Order_Lines__r WHERE Balance_Qty__c > 0) FROM Purchase_Order__c WHERE Id IN :POIds];
            Set<Id> opportunityIds = new Set<Id>();
            if(POList.size() >0){
                for(Purchase_Order__c PO: POList){
                    if(PO.Purchase_Order_Lines__r.size() == 0){
                        if(PO.Goods_Receipt_Date__c == null){
                            PO.Goods_Receipt_Date__c = System.now();
                        }
                        opportunityIds.add(PO.Opportunity_Name__c);
                    }else{
                        PO.Goods_Receipt_Date__c = NULL;
                    }
                }
                update POList;
                if(opportunityIds.size() > 0){
                    List<Service_Ticket__c> serviceTickets = [SELECT Id,Opportunity__c,Status__c,Transfer_Method__c FROM Service_Ticket__c WHERE Opportunity__c IN :opportunityIds ];
                    for(Service_Ticket__c ST: serviceTickets){
                        serviceTicketsMap.put(ST.Opportunity__c,ST);
                        ST.Status__c = 'Completed';
                    }
                    update serviceTickets;
                }
            }
        }
        //Create Service Invoice Records
        if(closedPOIds.size() > 0){
            Set<String> POToCreateServiceInvoice = new Set<String>();
            List<Purchase_Order__c> POList = [SELECT Id,Goods_Receipt_Date__c,Opportunity_Name__c,Opportunity_Name__r.Order__c, Payment_Eligible__c ,PO_Status__c, (SELECT Id,Balance_Qty__c FROM Purchase_Order_Lines__r WHERE Balance_Qty__c > 0),(SELECT Id FROM Invoices__r WHERE AR_Status__c NOT IN (:INVOICE_AR_STATUS_CANCELLED,:INVOICE_AR_STATUS_REJECTED)) FROM Purchase_Order__c WHERE Id IN :closedPOIds];
            List<Purchase_Order__c> POListUpdate = new List<Purchase_Order__c>();
            if(POList.size() >0){
                for(Purchase_Order__c PO: POList){
                    if(PO.Purchase_Order_Lines__r.size() == 0){
                        if((serviceTicketsMap.containsKey(PO.Opportunity_Name__c) && serviceTicketsMap.get(PO.Opportunity_Name__c).Transfer_Method__c != ST_Transfer_Method_Product_Conversions) && PO.Payment_Eligible__c != true && PO.Invoices__r.Size() == 0){
                            POToCreateServiceInvoice.add(PO.Id);
                        }
                        if(PO.Opportunity_Name__r.Order__c != NULL && PO.Payment_Eligible__c != true && PO.Invoices__r.Size() == 0){
                            POToCreateServiceInvoice.add(PO.Id);
                        }
                        if(PO.Payment_Eligible__c != true){ 
                            POListUpdate.add(new Purchase_Order__c(Id = PO.Id, PO_Status__c = PURCHASE_ORDER_STATUS_CLOSED));
                        }
                    }
                }
                if(POListUpdate.size() > 0){
                    update POListUpdate;
                }
                if(POToCreateServiceInvoice.size() > 0){
                    Company_Custom_Settings__c Company_Settings= Company_Custom_Settings__c.getOrgDefaults();
                    if(Company_Settings.Auto_Create_Service_Invoice__c){
                    	PurchaseOrderHelper.createServiceInvoice(POToCreateServiceInvoice);    	
                    } 
                }
            }
        }
    }
    public static void onBeforeDelete(List<Purchase_Order_Line__c> oldPOs){
        List<Brand_Quote_Line__c> bqLines = new List<Brand_Quote_Line__c>();
        List<Purchase_Order_Line__c> polis = [SELECT 
                                              Brand_Quote_Line__c,Qty_Ordered__c,
                                              Brand_Quote_Line__r.Invoiced_Quantity__c
                                              FROM Purchase_Order_Line__c
                                              WHERE Id IN : oldPOs];
        
        for(Purchase_Order_Line__c poli : polis){
            if(poli.Brand_Quote_Line__c != null && poli.Brand_Quote_Line__r.Invoiced_Quantity__c != null && poli.Qty_Ordered__c != null){
                Decimal qty = poli.Brand_Quote_Line__r.Invoiced_Quantity__c - poli.Qty_Ordered__c;
                bqLines.add(new Brand_Quote_Line__c(Id=poli.Brand_Quote_Line__c,Invoiced_Quantity__c = qty));     
            }  
        }
        if(bqLines.size() > 0){
            update bqLines;
        }
    }
}