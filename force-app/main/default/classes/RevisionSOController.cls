public without sharing class RevisionSOController {
	private Static String SALES_ORDER_STATUS_REJECTED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_REJECTED) ? SALES_ORDER_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Rejected');
        }set;
    }
    private Static String SO_NO_LINES_MODIFIED_FOR_REVISION{
        get{
            return String.isNotBlank(SO_NO_LINES_MODIFIED_FOR_REVISION) ? SO_NO_LINES_MODIFIED_FOR_REVISION: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_NO_Lines_Modified_For_Revision');
        }set;
    }
    private Static String SO_ORDER_REVISION_PRICE_MESSAGE{
        get{
            return String.isNotBlank(SO_ORDER_REVISION_PRICE_MESSAGE) ? SO_ORDER_REVISION_PRICE_MESSAGE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Revision_Price_Message');
        }set;
    }
    private Static String SO_ORDER_REVISION_SAVED_MESSAGE {
        get{
            return String.isNotBlank(SO_ORDER_REVISION_SAVED_MESSAGE ) ? SO_ORDER_REVISION_SAVED_MESSAGE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Revision_Saved_Message');
        }set;
    }
    private Static String SALES_ORDER_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_CANCELLED) ? SALES_ORDER_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SalesOrder_Cancelled');
        }set;
    }
    private Static String SALES_ORDER_STATUS_APPROVED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_APPROVED) ? SALES_ORDER_STATUS_APPROVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Approved');
        }set;
    }
    private Static String SALES_ORDER_STATUS_DRAFT{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_DRAFT) ? SALES_ORDER_STATUS_DRAFT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Draft');
        }set;
    }
    private Static String SALES_ORDER_STATUS_SHIPPED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_SHIPPED) ? SALES_ORDER_STATUS_SHIPPED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Shipped');
        }set;
    }
    private Static String SHIPPING_MANIFEST_STATUS_IN_TRANSIT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_IN_TRANSIT) ? SHIPPING_MANIFEST_STATUS_IN_TRANSIT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_InTransit');
        }set;
    }
    private Static String SHIPPING_MANIFEST_STATUS_COMPLETE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_COMPLETE) ? SHIPPING_MANIFEST_STATUS_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Complete');
        }set;
    }
    private Static String SALES_ORDER_STATUS_ALLOCATED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_ALLOCATED) ? SALES_ORDER_STATUS_ALLOCATED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Allocated');
        }set;
    }
    private Static String SO_RECORDTYPE_PRODUCT {		
        get{
              return String.isNotBlank(SO_RECORDTYPE_PRODUCT) ? SO_RECORDTYPE_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_Product');
        }set;
    }
    private static String SO_RECORDTYPE_PRODUCT_ID{
        get{
              return Schema.SObjectType.Sales_Order__c.getRecordTypeInfosByDeveloperName().get(SO_RECORDTYPE_PRODUCT).getRecordTypeId();
        }set;
    }
    private Static String ERR_MSG_REVISION_STATUS_NOT_ALLOWED {		
        get{
              return String.isNotBlank(ERR_MSG_REVISION_STATUS_NOT_ALLOWED) ? ERR_MSG_REVISION_STATUS_NOT_ALLOWED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Err_Msg_Revision_Status_Not_Allowed');
        }set;
    }
    private Static String ERR_MSG_REVISION_RECORDTYPE_NOT_ALLOWED {		
        get{
              return String.isNotBlank(ERR_MSG_REVISION_RECORDTYPE_NOT_ALLOWED) ? ERR_MSG_REVISION_RECORDTYPE_NOT_ALLOWED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Err_Msg_Revision_RecordType_Not_Allowed');
        }set;
    }
    private Static String ERR_MSG_REVISION_PICKLIST_NO_SM {		
        get{
              return String.isNotBlank(ERR_MSG_REVISION_PICKLIST_NO_SM) ? ERR_MSG_REVISION_PICKLIST_NO_SM : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Err_Msg_Revision_Picklist_No_SM');
        }set;
    }
    private Static String ERR_MSG_REVISION_NOT_DELIVERED_TRANSIT {		
        get{
              return String.isNotBlank(ERR_MSG_REVISION_NOT_DELIVERED_TRANSIT) ? ERR_MSG_REVISION_NOT_DELIVERED_TRANSIT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Err_Msg_Revision_Not_Delivered_Transit');
        }set;
    }
    private Static String ERR_MSG_REVISION_DELIVERED_TRANSIT {		
        get{
              return String.isNotBlank(ERR_MSG_REVISION_DELIVERED_TRANSIT) ? ERR_MSG_REVISION_DELIVERED_TRANSIT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Err_Msg_Revision_Delivered_Transit');
        }set;
    }
    private static String FULFILLMENT_SERVICE_CHANGE_FEE{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_CHANGE_FEE) ? FULFILLMENT_SERVICE_CHANGE_FEE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Change');
        }set;
    }
    private Static String INVOICE_RECORDTYPE_SERVICE{
        get{
            return String.isNotBlank(INVOICE_RECORDTYPE_SERVICE) ? INVOICE_RECORDTYPE_SERVICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
    private Static String INVOICE_AR_STATUS_REJECTED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_REJECTED) ? INVOICE_AR_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Rejected');
        }set;
    }
    private Static String INVOICE_AR_STATUS_CANCELLED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_CANCELLED) ? INVOICE_AR_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Cancelled');
        }set;
    }
    @AuraEnabled
    public static AuraResponse checkSOStatus(String recordId){
        AuraResponse r = new AuraResponse('RevisionSOController.checkSOStatus()');
        Sales_Order__c SO = [SELECT Id,Site__c,Total_Change_Fee__c, Brand_Quote__c,Opportunity_Name__c,Total_Revision__c ,RecordTypeId,RecordType.Name, Name, SO_Status__c, Supplier_Name__c,Supplier_Name__r.Membership_Level__c ,Supplier_DBA__c, Supplier_License__c,Supplier_Contact__c,Supplier_Contact__r.Name,Supplier_License_Number__c,Receiver_Name__c ,Receiver_DBA__c ,Receiver_License__c ,Receiver_License_Number__c ,Receiver_Contact__c ,Receiver_Contact__r.Name ,(SELECT Id, Sales_Order__c FROM picklists__r),(SELECT Id,Status__c, Sales_Order__c FROM Shipping_Manifests__r),(SELECT Id, Name,Is_Sample__c, Product_Name__c,Product_Name__r.Is_Sample__c,Product_Name__r.Name, MOQ__c, Quantity_Cases__c  , Qty_Ordered__c , Retail_Wholesale_Price__c ,Status__c, Product_Name__r.Producer_Name__c,Product_Name__r.Producer_Name__r.DBA__c FROM Sales_Order_Lines__r WHERE Status__c NOT IN(:SALES_ORDER_STATUS_REJECTED,:SALES_ORDER_STATUS_CANCELLED))  FROM Sales_Order__c WHERE Id =:recordId];
        r.data.put('SO',SO);
        
        if(SO.SO_Status__c == SALES_ORDER_STATUS_SHIPPED || SO.SO_Status__c == SALES_ORDER_STATUS_REJECTED  || SO.SO_Status__c == SALES_ORDER_STATUS_CANCELLED){
            List<String> filters = new List<String>{SO.SO_Status__c};
            r.data.put('error',String.format(ERR_MSG_REVISION_STATUS_NOT_ALLOWED,filters));
        }else if(SO.RecordType.Name != SO_RECORDTYPE_PRODUCT){
            List<String> filters = new List<String>{SO.RecordType.Name};
            r.data.put('error',String.format(ERR_MSG_REVISION_RECORDTYPE_NOT_ALLOWED,filters));
        }else if(SO.RecordType.Name == SO_RECORDTYPE_PRODUCT && SO.SO_Status__c == SALES_ORDER_STATUS_APPROVED && SO.picklists__r.size() > 0 && SO.Shipping_Manifests__r.size() == 0){
            r.data.put('error',ERR_MSG_REVISION_PICKLIST_NO_SM);
        }else if(SO.RecordType.Name == SO_RECORDTYPE_PRODUCT && SO.SO_Status__c == SALES_ORDER_STATUS_APPROVED && SO.picklists__r.size() > 0 && SO.Shipping_Manifests__r.size() > 0 && SO.Shipping_Manifests__r[0].Status__c != SHIPPING_MANIFEST_STATUS_IN_TRANSIT && SO.Shipping_Manifests__r[0].Status__c != SHIPPING_MANIFEST_STATUS_COMPLETE){
            r.data.put('error',ERR_MSG_REVISION_NOT_DELIVERED_TRANSIT);
        }else if(SO.RecordType.Name == SO_RECORDTYPE_PRODUCT && SO.SO_Status__c == SALES_ORDER_STATUS_APPROVED && SO.picklists__r.size() > 0 && SO.Shipping_Manifests__r.size() > 0 && (SO.Shipping_Manifests__r[0].Status__c == SHIPPING_MANIFEST_STATUS_IN_TRANSIT || SO.Shipping_Manifests__r[0].Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE)){
            r.data.put('error',ERR_MSG_REVISION_DELIVERED_TRANSIT);
            List<String> filters = new List<String>{SO.Shipping_Manifests__r[0].Status__c};
            r.data.put('error',String.format(ERR_MSG_REVISION_DELIVERED_TRANSIT,filters));
        }else if(SO.RecordType.Name == SO_RECORDTYPE_PRODUCT && (SO.SO_Status__c == SALES_ORDER_STATUS_DRAFT || SO.SO_Status__c == SALES_ORDER_STATUS_APPROVED)){
            r.data.put('success','success');
            Decimal version = 1;
            List<Order_Revision__c> revisions = [SELECT Id, Change_Fee__c, Membership_Level__c, Revision_Reason__c,Sales_Order__c, Sales_Order_Line__c , Version__c FROM Order_Revision__c  WHERE Sales_Order__c = :SO.Id ORDER BY Sales_Order__c,Sales_Order_Line__c, Version__c DESC];
            Map<Id,Decimal> SOLIVersionMap = new Map<Id,Decimal>();
            if(revisions.size() > 0){
                version = (revisions[0].Version__c != NULL ?revisions[0].Version__c+1:1);
                for(Order_Revision__c rev: revisions){
                    if(!SOLIVersionMap.containsKey(rev.Sales_Order_Line__c)){
                        SOLIVersionMap.put(rev.Sales_Order_Line__c, (rev.Version__c != NULL ?rev.Version__c+1:1));
                    }
                }
            }
            r.data.put('version',version);
            r.data.put('SOLIVersionMap',SOLIVersionMap);
            r.data.put('SO_NO_LINES_MODIFIED_FOR_REVISION',SO_NO_LINES_MODIFIED_FOR_REVISION);
            r.data.put('SO_ORDER_REVISION_PRICE_MESSAGE',SO_ORDER_REVISION_PRICE_MESSAGE);
            if(SO.Supplier_Name__r.Membership_Level__c != NULL){
                Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c, Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c ,Membership_Level__c
                                                     FROM Fulfillment_Rates_Table__c 
                                                     WHERE Site__c = :SO.Site__c
                                                     AND Active__c = true
                                                     AND Rate_Effective_From__c <= :System.today()
                                                     AND Rate_Effective_To__c >= :System.today()
                                                     AND Membership_Level__c = :SO.Supplier_Name__r.Membership_Level__c
                                                         AND Fulfillment_Services__c = :FULFILLMENT_SERVICE_CHANGE_FEE
                                                     ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
                if(FRTList.size() > 0){
                    r.data.put('changeFee',FRTList[0].Bracket_Price__c);
                }
            }
        }
        string isAllocatedLineItemsToolTip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','isAllocated_line_items_tooltip');
        System.debug('####isAllocatedLineItemsToolTip ::'+isAllocatedLineItemsToolTip);
        r.data.put('isAllocatedLineItemsToolTip', isAllocatedLineItemsToolTip != null ? isAllocatedLineItemsToolTip : '');
            return r;
    }
    
    @AuraEnabled
    public static AuraResponse createOrderRevisions(String SOLineJSON, String SOId, String revisionReason,boolean chkCancelAllStatusOfSOLI){
        AuraResponse r = new AuraResponse('RevisionSOController.createOrderRevisions()');
        try{
            Sales_Order__c SO = [SELECT Id,Total_Weight_lbs__c, Allocated__c  ,Brand_Quote__c,Brand_Quote__r.Id, Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c,Total_Revision__c,Total_Change_Fee__c ,Opportunity_Name__c,Opportunity_Name__r.Order__c,Site__c,RecordTypeId,RecordType.Name, Name, SO_Status__c, Supplier_Name__c,Supplier_Name__r.Membership_Level__c ,Supplier_DBA__c, Supplier_License__c,Supplier_Contact__c,Supplier_Contact__r.Name,Supplier_License_Number__c,Receiver_Name__c ,Receiver_DBA__c ,Receiver_License__c ,Receiver_License_Number__c ,Receiver_Contact__c ,Receiver_Contact__r.Name,Receiver_Name__r.Membership_Level__c FROM Sales_Order__c WHERE Id =:SOId];
            List<Sales_Order_Line__c> SOLines = (List<Sales_Order_Line__c>) JSON.deserialize(SOLineJSON, List<Sales_Order_Line__c>.class);
            
            update SOLines;
            Set<Id> SOLIIds = new Set<Id>();
            for(Sales_Order_Line__c SOLI: SOLines){
                SOLIIds.add(SOLI.Id);
            }
            List<Sales_Order_Line__c> SOLinesUpdated = [SELECT Id, Retail_Wholesale_Price__c,Status__c, Brand_Quote_Line__c,Brand_Quote_Line__r.Opportunity_Line_Item_Id__c FROM Sales_Order_Line__c WHERE Id IN: SOLIIds AND Brand_Quote_Line__c != NULL];
            List<Brand_Quote_Line__c> BQLIs = new List<Brand_Quote_Line__c>();
            Map<Id,Id> BQLIOLIMap = new Map<Id,Id>();
            for(Sales_Order_Line__c SOLI: SOLinesUpdated){
                BQLIOLIMap.put(SOLI.Brand_Quote_Line__c,SOLI.Brand_Quote_Line__r.Opportunity_Line_Item_Id__c);
                BQLIs.add(new Brand_Quote_Line__c(Id = SOLI.Brand_Quote_Line__c,Retail_Wholesale_Price__c = SOLI.Retail_Wholesale_Price__c));
            }
            update BQLIs;
            Map<Id,Brand_Quote_Line__c> BQLIMap = new Map<Id,Brand_Quote_Line__c>(BQLIs);
            List<Id> OLIIds = BQLIOLIMap.values();
            if(OLIIds != NULL && OLIIds.size() > 0){
                Map<Id,OpportunityLineItem> OLIMap = new Map<Id,OpportunityLineItem>([SELECT Id,Order_Line_Item__c FROM OpportunityLineItem WHERE Id IN :OLIIds AND Order_Line_Item__c != NULL]);
                List<Order_Line_Item__c> OLIsToUpdates = new List<Order_Line_Item__c>();
                for(Brand_Quote_Line__c BQLI :BQLIs){
                    if(BQLIOLIMap.containsKey(BQLI.Id)){
                        Id OLIId  = BQLIOLIMap.get(BQLI.Id);
                        if(OLIId != NULL && OLIMap.containsKey(OLIId)){
                            OpportunityLineItem OLI = OLIMap.get(OLIId);
                            OLIsToUpdates.add(new Order_Line_Item__c(Id = OLI.Order_Line_Item__c, UnitPrice__c = BQLI.Retail_Wholesale_Price__c));
                        }
                    }
                }
                if(OLIsToUpdates.size() > 0){
                    update OLIsToUpdates;
                }
            }
            Decimal changeFee = 0;
            if(SO.Supplier_Name__r.Membership_Level__c != NULL){
                Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c, Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c ,Membership_Level__c
                                                         FROM Fulfillment_Rates_Table__c 
                                                         WHERE Site__c = :SO.Site__c
                                                         AND Active__c = true
                                                         AND Rate_Effective_From__c <= :System.today()
                                                         AND Rate_Effective_To__c >= :System.today()
                                                         AND Membership_Level__c = :SO.Supplier_Name__r.Membership_Level__c
                                                         AND Fulfillment_Services__c = :FULFILLMENT_SERVICE_CHANGE_FEE
                                                         ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
                system.debug('##FRTList :'+FRTList);
                if(FRTList.size() > 0){
                    changeFee = FRTList[0].Bracket_Price__c;
                }
            }
            List<Order_Revision__c> revisions = new List<Order_Revision__c>();
            for(Sales_Order_Line__c SOLI : SOLines){
                revisions.add(new Order_Revision__c(Sales_Order__c = SOId,Sales_Order_Line__c = SOLI.Id,Change_Fee__c = changeFee, Membership_Level__c  = SO.Supplier_Name__r.Membership_Level__c, Order__c = SO.Opportunity_Name__r.Order__c, Revision_Reason__c = revisionReason, Version__c = SOLI.Total_SOLI_Revision__c,Brand_Quote__c=SO.Brand_Quote__c,Opportunity__c=SO.Opportunity_Name__c));
            }
            if(revisions.size() > 0){
                insert revisions;
            }
            Decimal totalRevision = (SO.Total_Revision__c != NULL ? (SO.Total_Revision__c+1):1);
            Sales_Order__c updateSO = new Sales_Order__c(Id = SO.Id,Total_Revision__c = totalRevision);
            Shipping_Rates_Table__c [] mileageSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                              	Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                 FROM Shipping_Rates_Table__c 
                                                 WHERE Site__c = :SO.Site__c
                                                 AND Active__c = true
                                                 AND Rate_Effective_From__c <= :System.today()
                                                 AND Rate_Effective_To__c >= :System.today()
                                                 AND Membership_Level__c = : SO.Receiver_Name__r.Membership_Level__c
                                                     Order By Mileage_Bracket__c];
            Shipping_Rates_Table__c [] weightSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                                        Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                        FROM Shipping_Rates_Table__c 
                                                        WHERE Site__c = :SO.Site__c
                                                        AND Active__c = true
                                                        AND Rate_Effective_From__c <= :System.today()
                                                        AND Rate_Effective_To__c >= :System.today()
                                                        AND Membership_Level__c  = :SO.Receiver_Name__r.Membership_Level__c
                                                        Order By Weight_Bracket__c];
            Decimal totalMileageFee = 0;
            Decimal totalWeightFee = 0;
            if(!mileageSRTList.isEmpty() && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c != null){
                for(Shipping_Rates_Table__c SRT: mileageSRTList){
                    if(SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c <= SRT.Mileage_Bracket__c){
                        if(SRT.Fixed_Mileage_Fee__c){
                            totalMileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                        }else{
                            totalMileageFee = SRT.Mileage_Bracket_Price__c * SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c; 
                        }
                        break;
                    }
                }    
            }
            //calculate Total Weight Fee
            if(!weightSRTList.isEmpty()){
                for(Shipping_Rates_Table__c SRT: weightSRTList){
                    if(SO.Total_Weight_lbs__c <= SRT.Weight_Bracket__c){
                        if(SRT.Fixed_Weight_Fee__c){
                            totalWeightFee = SRT.Fixed_Weight_Amount__c != null ? SRT.Fixed_Weight_Amount__c : 0;
                        }else{
                            totalWeightFee = SRT.Weight_Bracket_Price__c * SO.Total_Weight_lbs__c; 
                        }
                        break;
                    }
                }   
            }
            updateSO.Total_Mileage_Fee__c = totalMileageFee ;//* totalRevision;
            updateSO.Total_Weight_Fee__c = totalWeightFee ;//* totalRevision;
            if(chkCancelAllStatusOfSOLI)
             	updateSO.SO_Status__c ='Cancelled';
            update updateSO;
            List<Invoice__c> invList = [SELECT Id,AR_Status__c,(Select Invoice_Qty__c,
                                                                        Sales_Order_Line__c
                                                                        From Invoice_Lines__r) FROM Invoice__c WHERE Sales_Order__c =: SO.id AND RecordType.Name =:INVOICE_RECORDTYPE_SERVICE AND AR_Status__c NOT IN (:INVOICE_AR_STATUS_REJECTED,:INVOICE_AR_STATUS_CANCELLED)];
            if(invList.size() > 0){
                        List<Invoice__c> invUpdateList = new List<Invoice__c>();
                        Map<Id, Sales_Order_Line__c> soLineById = new Map<Id, Sales_Order_Line__c>();
                        Map<Id, Invoice_Line__c> invLineById = new Map<Id, Invoice_Line__c>();
                        for(Invoice__c inv :invList){
                            // Change status of Invoice as Cancelled
                            inv.AR_Status__c = InvoiceSupport.INVOICE_STATUS_CANCELLED;
                            
                            // Change Qty Invoiced of SO line as Invoice Qty of invoice line
                            for(Invoice_Line__c invoiceLineSO : inv.Invoice_Lines__r){
                                
                                if(invoiceLineSO.Sales_Order_Line__c != null)
                                {
                                    Sales_Order_Line__c soLineSO = new Sales_Order_Line__c();                    
                                    soLineSO.Id = invoiceLineSO.Sales_Order_Line__c;
                                    soLineSO.Qty_Invoiced__c = invoiceLineSO.Invoice_Qty__c;                    
                                    soLineById.put(soLineSO.Id, soLineSO);
                                }
                                
                                Invoice_Line__c invLine = new Invoice_Line__c();                    
                                invLine.Id = invoiceLineSO.Id;
                                invLine.InvoiceLine_Status__c =  InvoiceSupport.INVOICE_STATUS_CANCELLED;                    
                                invLineById.put(invLine.Id, invLine);
                            }
                            invUpdateList.add(inv);
                        }
                        // Get existing SO lines and update Qty Invoiced value
                        if(!soLineById.isEmpty())
                        {
                            
                            for(Sales_Order_Line__c soLineSO : [Select Qty_Invoiced__c From Sales_Order_Line__c Where Id IN: soLineById.keySet()]){
                                
                                Decimal qtyInvoiced = soLineById.get(soLineSO.Id).Qty_Invoiced__c;
                                if(qtyInvoiced == null){
                                    qtyInvoiced = 0.0;
                                }
                                
                                // Add qty to existing SO line
                                soLineSO.Qty_Invoiced__c -= qtyInvoiced;
                                
                                soLineById.put(soLineSO.Id, soLineSO);
                            }
                        }
                        update invLineById.values();
                        update invUpdateList;
                        
                        if(!soLineById.isEmpty())
                            update soLineById.values();
                        FullfullmentServiceInvoiceController.createServiceInvoice(SO.id,false);
                    }
            Order__c odr = new Order__c(Id = SO.Opportunity_Name__r.Order__c,Total_Milage_Fee__c = updateSO.Total_Mileage_Fee__c,Total_Weight_Fee__c = updateSO.Total_Weight_Fee__c);
            if(chkCancelAllStatusOfSOLI)
                odr.Status__c='Cancelled by Customer';
            update odr;
            if(chkCancelAllStatusOfSOLI){
            	Brand_Quote__c bq = new Brand_Quote__c(Id = SO.Brand_Quote__r.Id,BQ_Status__c = 'Cancelled');
                update bq;
            }
            r.data.put('success',SO_ORDER_REVISION_SAVED_MESSAGE);
        }catch(Exception e){
            r.data.put('error',e.getMessage());
        } 
        
        return r;
    }
}