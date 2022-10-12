/**
* Copyright (c) 2021 Filigreen Distro
* All rights reserved.
* RSMSupport
*/
public class RSMSupport{
    
    Public Static String SHIPPING_MANIFEST_STATUS_RECEIVED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_RECEIVED) ? SHIPPING_MANIFEST_STATUS_RECEIVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Received');
        }set;
    }
    Public Static String SHIPPING_MANIFEST_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_CANCELLED) ? SHIPPING_MANIFEST_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Cancelled');
        }set;
    }
    Public Static String SHIPPING_MANIFEST_STATUS_DRAFT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_DRAFT) ? SHIPPING_MANIFEST_STATUS_DRAFT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Draft');
        }set;
    }
    Public Static String SHIPPING_MANIFEST_STATUS_COMPLETE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_COMPLETE) ? SHIPPING_MANIFEST_STATUS_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Complete');
        }set;
    }
    Public Static String SHIPPING_MANIFEST_LINE_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_STATUS_CANCELLED) ? SHIPPING_MANIFEST_LINE_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Cancelled');
        }set;
    }
    
    Public Static String PICKLIST_LINE_STATUS_SHIPMENT_COMPLETE{
        get{
            return String.isNotBlank(PICKLIST_LINE_STATUS_SHIPMENT_COMPLETE) ? PICKLIST_LINE_STATUS_SHIPMENT_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist Line','Picklist_Line_Status_Shipment_Complete');
        }set;
    }
    Public Static String SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE{
        get{
            return String.isNotBlank(SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE) ? SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Shipment_Complet');
        }set;
    }
    
    Public Static String SHIPPING_MANIFEST_STATUS_INTRANSIT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_INTRANSIT) ? SHIPPING_MANIFEST_STATUS_INTRANSIT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_InTransit');
        }set;
    }
    
    Public Static String SALES_ORDER_STATUS_REJECTED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_REJECTED) ? SALES_ORDER_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Rejected');
        }set;
    }
    
    Public Static String SALES_ORDER_STATUS_ALLOCATED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_ALLOCATED) ? SALES_ORDER_STATUS_ALLOCATED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Allocated');
        }set;
    }
    
    Public Static String SALES_ORDER_RECORDTYPE_PRODUCT{
        get{
            return String.isNotBlank(SALES_ORDER_RECORDTYPE_PRODUCT) ? SALES_ORDER_RECORDTYPE_PRODUCT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_Product');
        }set;
    }
    
    Public Static String SALES_ORDER_STATUS_OPEN{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_OPEN) ? SALES_ORDER_STATUS_OPEN: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Open');
        }set;
    }
    
    Public Static String SALES_ORDER_LINE_STATUS_REJECTED{
        get{
            return String.isNotBlank(SALES_ORDER_LINE_STATUS_REJECTED) ? SALES_ORDER_LINE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Rejected');
        }set;
    }
    
    Public Static String SHIPPING_MANIFEST_LINE_STATUS_REJECTED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_STATUS_REJECTED) ? SHIPPING_MANIFEST_LINE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Rejected');
        }set;
    }
    
    Public Static String INVOICE_AR_STATUS_REJECTED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_REJECTED) ? INVOICE_AR_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Rejected');
        }set;
    }
    
      Public Static String INVOICE_AR_STATUS_SHIPPED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_SHIPPED) ? INVOICE_AR_STATUS_SHIPPED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Shipped');
        }set;
    }
    
    public Static String INVOICE_LINE_STATUS_REJECTED{
        get{
            return String.isNotBlank(INVOICE_LINE_STATUS_REJECTED) ? INVOICE_LINE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice Line','Invoice_Line_Status_Rejected');
        }set;
    }
    
    Public Static String PRODUCT_RECORD_TYPE_SERVICES{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_SERVICES) ? PRODUCT_RECORD_TYPE_SERVICES: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Services');
        }set;
    }
    public Static String INVOICE_RECORDTYPE_SERVICE{
        get{
            return String.isNotBlank(INVOICE_RECORDTYPE_SERVICE) ? INVOICE_RECORDTYPE_SERVICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_PENDING{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_PENDING) ? SHIPPING_MANIFEST_STATUS_PENDING: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_ShipmentPending');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_REJECTED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_REJECTED) ? SHIPPING_MANIFEST_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Rejected');
        }set;
    }
    public Static String SHIPPING_MANIFEST_RECEIVE_PAYMENT_RECORDTYPE_EXCISE_TAX{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECEIVE_PAYMENT_RECORDTYPE_EXCISE_TAX) ? SHIPPING_MANIFEST_RECEIVE_PAYMENT_RECORDTYPE_EXCISE_TAX: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_ReceivePayment_RecordType_Excise');
        }set;
    }
    public Static String PRODUCT_RECORD_TYPE_PRODUCT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_PRODUCT) ? PRODUCT_RECORD_TYPE_PRODUCT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Name_Product');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_STATUS_PENDING_DELIVERY{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_PENDING_DELIVERY) ? SHIPPING_MANIFEST_STATUS_PENDING_DELIVERY: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Pending_Deliver');
        }set;
    }
    
    public Static String SALES_ORDER_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_CANCELLED) ? SALES_ORDER_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Cancelled');
        }set;
    }
    
     public Static String PRODUCT_RECORDTYPE_DISCOUNT{
        get{
            return String.isNotBlank(PRODUCT_RECORDTYPE_DISCOUNT) ? PRODUCT_RECORDTYPE_DISCOUNT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Discount');
        }set;
    }
    public Static String PRODUCT_RECORDTYPE_MOV_FEE{
        get{
            return String.isNotBlank(PRODUCT_RECORDTYPE_MOV_FEE) ? PRODUCT_RECORDTYPE_MOV_FEE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_MOV_Fee');
        }set;
    }

      public Static String PURCHASE_ORDER_LINE_STATUS_REJECTED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_LINE_STATUS_REJECTED) ? PURCHASE_ORDER_LINE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POLI_Status_Cancelled');
        }set;
    }
    
    
    
    public static final string STATUS_CANCELLED = SHIPPING_MANIFEST_STATUS_CANCELLED;
    public static final string STATUS_SHIPMENT_COMPLETE = SHIPPING_MANIFEST_STATUS_COMPLETE;
    public static final string STATUS_DRAFT = SHIPPING_MANIFEST_STATUS_DRAFT;
    public static final string STATUS_PENDING_DELIVERY = SHIPPING_MANIFEST_STATUS_PENDING_DELIVERY;
    public static final string STATUS_IN_TRANSIT = SHIPPING_MANIFEST_STATUS_INTRANSIT;
    public static final string STATUS_SHIPMENT_PENDING = SHIPPING_MANIFEST_STATUS_PENDING;
    public static final string STATUS_REJECTED = SHIPPING_MANIFEST_STATUS_REJECTED;
    
    public static final string SO_STATUS_REJECTED = SALES_ORDER_STATUS_REJECTED;
    public static final string SO_STATUS_OPEN = SALES_ORDER_STATUS_OPEN;
    
    public static final string RECEIVE_PAYMENT_RECORD_TYPE_EXCISE_TAX = SHIPPING_MANIFEST_RECEIVE_PAYMENT_RECORDTYPE_EXCISE_TAX;
    public static final string RECEIVE_PAYMENT_RECORD_TYPE_PRODUCT = PRODUCT_RECORD_TYPE_PRODUCT;
    
    public static Boolean isCancel = false;
    
    /**
* Retrieve RSMLine record
* @param rsmLineId The RSM Line Id
*
* @return The rsm line record
*/         
    public static Shipping_Manifest_Line__c retrieveRSMLine(Id rsmLineId) {
        return retrieveRSMLines(new Set<Id>{rsmLineId});
    }
    
    /**
* Retrieve RSMLine records
* @param rsmLineId The set of RSM Line Id
*
* @return The rsm line records
*/         
    public static Shipping_Manifest_Line__c retrieveRSMLines(Set<Id> rsmLineIds) {
        return  [Select SMLine_Status__c,
                 Shipping_Manifest__r.Status__c,
                 Picklist_Line__r.Inventory_Position__c,
                 Picklist_Line__r.Inventory_Position__r.Site__c,
                 Picklist_Line__r.Sales_Order_Line__c,
                 Picklist_Line__r.Pack_out_UID__c,
                 Picklist_Line__r.Sales_Order_Line__r.Sales_Order__c,
                 Picklist_Line__c
                 From Shipping_Manifest_Line__c
                 Where Id IN: rsmLineIds];
    }
    
    /**
* Retrieve RSM with RSM Lines
* @param rsmId The RSM Id
*
* @return The rsm with rsm line records
*/         
    public static Shipping_Manifest__c retrieveRSM(Id rsmId) {
        return  [Select Status__c,
                 Name,
                 Site__c,
                 Customer_PO_or_Quote__c,
                 Picklist__c,
                 (Select SMLine_Status__c,
                  Name,
                  Product_Name__c,
                  Producer_Name__c,
                  Product_Description__c,
                  Retail_Wholesale_Price__c,
                  Shipment_Qty__c,
                  Qty_Received__c,
                  Line_Total_Price__c,
                  Picklist_Line__c,
                  Picklist_Line__r.Inventory_Position__c,
                  Picklist_Line__r.Inventory_Position__r.Site__c,
                  Picklist_Line__r.Sales_Order_Line__r.Sales_Order__c,
                  Picklist_Line__r.Pack_out_UID__c,
                  Picklist_Line__r.Sales_Order_Line__c
                  From Shipping_Manifest_Lines__r)
                 From Shipping_Manifest__c
                 Where Id =: rsmId];
        
    }
    
    /**
* Cancel RSM logic
* Update inventory position - inventory location to receiving inspections related to RSM lines
* Update SO and SO lines status as Rejected
* Update Invoice and Invoice lines status as Rejected
* Update ETR and ETR lines status as Rejected
* Traverse path - RSM line --> Picklist line --> SO line --> Invoice Line --> Invoice --> ETR/Line
* Cancel related picklist line record
* @param rsmLines The list of RSM line records
*
*/         
    public static void updateInvPositionsAndSOLines(List<Shipping_Manifest_Line__c> rsmLines) {
        updateInvPositionsAndSOLines(rsmLines, false);
    }
    
     
    public static void updateInvPositionsAndSOLines(List<Shipping_Manifest_Line__c> rsmLines, 
                                                    Boolean allSMLinesCancelled, Boolean isCan) {
                                                        isCancel = isCan; 
                                                        updateInvPositionsAndSOLines(rsmLines, allSMLinesCancelled);
                                                    }
    /**
* Cancel RSM logic
* Update inventory position - inventory location to receiving inspections related to RSM lines
* Update SO and SO lines status as Rejected
* Update Invoice and Invoice lines status as Rejected
* Update ETR and ETR lines status as Rejected
* Traverse path - RSM line --> Picklist line --> SO line --> Invoice Line --> Invoice --> ETR/Line
* Cancel related picklist line record
* @param rsmLines The list of RSM line records
* @param allSMLinesCancelled The flag to determine if all SM lines are cancelled or not
*
*/         
    public static void updateInvPositionsAndSOLines(List<Shipping_Manifest_Line__c> rsmLines, 
                                                    Boolean allSMLinesCancelled) {
  system.debug('rsmLines>>'+rsmLines); 
                                                        // Define collections
                                                        Set<Id> invPositionIds = new Set<Id>();
                                                        Set<Id> siteIds = new Set<Id>();
                                                        Map<Id, Id> invLocationIdBySiteId = new Map<Id, Id>();
                                                        List<Inventory_Position__c> invPositions = new List<Inventory_Position__c>();
                                                        Set<Id> soLineIds = new Set<Id>();
                                                        Set<Id> poLIds = new Set<Id>();
                                                        Set<Id> soIds = new Set<Id>();
                                                        List<Sales_Order_Line__c> soLines = new List<Sales_Order_Line__c>();
                                                       
                                                        
                                                        Set<Id> invoiceLineIds = new Set<Id>();
                                                        Set<Id> invoiceIds = new Set<Id>();
                                                        List<Invoice_Line__c> invoiceLines = new List<Invoice_Line__c>();
                                                        List<Invoice__c> invoices = new List<Invoice__c>();
                                                        String smStatus;
                                                        
                                                        
                                                        
                                                        String defaultInvLocationName = Label.Default_Inventory_Location;
                                                        Map<String,String> mapUid = new Map<String,String>();
                                                        Map<Id,String> mapIps = new Map<Id,String>();
                                                        for(Shipping_Manifest_Line__c rsmLineObj : rsmLines){
                                                            // update inventory positions for only SM lines having status as cancelled
                                                            if(rsmLineObj.SMLine_Status__c == SHIPPING_MANIFEST_LINE_STATUS_CANCELLED || rsmLineObj.SMLine_Status__c == SHIPPING_MANIFEST_LINE_STATUS_REJECTED){
                                                                invPositionIds.add(rsmLineObj.Picklist_Line__r.Inventory_Position__c);
                                                                mapIps.put(rsmLineObj.Picklist_Line__r.Inventory_Position__c,rsmLineObj.SMLine_Status__c);
                                                                siteIds.add(rsmLineObj.Picklist_Line__r.Inventory_Position__r.Site__c); 
                                                                if(rsmLineObj.SMLine_Status__c == SHIPPING_MANIFEST_LINE_STATUS_CANCELLED){
                                                                    if(rsmLineObj.Picklist_Line__r.Pack_out_UID__c != null && !mapUid.containsKey(rsmLineObj.Picklist_Line__r.Inventory_Position__c)){ mapUid.put(rsmLineObj.Picklist_Line__r.Inventory_Position__c, rsmLineObj.Picklist_Line__r.Pack_out_UID__c);
                                                                    }
                                                                    
                                                                }
                                                            }
                                                            
                                                            if(rsmLineObj.Picklist_Line__r.Sales_Order_Line__c != null){
                                                                soIds.add(rsmLineObj.Picklist_Line__r.Sales_Order_Line__r.Sales_Order__c); 
                                                            }
                                                            smStatus = rsmLineObj.SMLine_Status__c;
                                                        }
                                                        

                                                        if(invPositionIds.size() > 0){
                                                            invPositions = [Select Inventory_Location__c,
                                                                            Site__c,
                                                                            Rack__c,
                                                                            Rack_Level__c,
                                                                            Bin_Location__c,
                                                                            Sales_Order_Line__c,
                                                                            Qty_On_Hand__c,
                                                                            Qty_Allocated__c,
                                                                            UID_New__c
                                                                            From Inventory_Position__c 
                                                                            Where Id IN: invPositionIds];
                                                            // Create map of Inventory location Id by Site Id
                                                            for(Inventory_Location__c invLocation : [Select Site_Name__c from Inventory_Location__c Where Site_Name__c IN: siteIds AND Name =: defaultInvLocationName]){
                                                                invLocationIdBySiteId.put(invLocation.Site_Name__c, invLocation.Id);
                                                            }
                                                            
                                                            // Update inventory positions attributes as default inventory location name
                                                            if(invPositions.size() > 0){
                                                                for(Inventory_Position__c invPosition : invPositions){
                                                                    
                                                                    invPosition.Inventory_Location__c = invLocationIdBySiteId.get(invPosition.Site__c);
                                                                    invPosition.Sales_Order_Line__c = null; 
                                                                    invPosition.Rack__c = null;
                                                                    invPosition.Rack_Level__c = null;
                                                                    invPosition.Bin_Location__c = null;
                                                                    invPosition.Qty_On_Hand__c = invPosition.Qty_Allocated__c;
                                                                    invPosition.Qty_Allocated__c = 0;
                                                                    if(mapUid.containsKey(invPosition.Id)){ invPosition.UID_New__c = mapUid.get(invPosition.Id);    
                                                                    }
                                                                }
                                                                
                                                                update invPositions;
                                                            }
                                                        }
                                                        
                                                        // Cancel related picklist line record
                                                        List<Picklist_Line__c> picklistLines = new List<Picklist_Line__c>();
                                                        for(Shipping_Manifest_Line__c rsmLineObj : rsmLines){
                                                            if(rsmLineObj.Picklist_Line__c != null){
                                                                Picklist_Line__c picklistLineObj = new Picklist_Line__c();
                                                                picklistLineObj.Id = rsmLineObj.Picklist_Line__c;
                                                                picklistLineObj.Status__c = rsmLineObj.SMLine_Status__c;
                                                                picklistLines.add(picklistLineObj);
                                                            }
                                                        }
                                                        if(picklistLines.size() > 0){
                                                            update picklistLines;
                                                        }       
                                                        

                                                        
                                                        
                                                        // Update SO line as rejected
                                                        if(soIds.size() > 0){
                                                            // Retrieve SO related to updated SO lines
                                                            // If all SO lines rejected then update parent SO as rejected
                                                            // To mark SO line as rejected, find all SM lines related to SO line. If all SM lines are cancelled then
                                                            // only mark SO line as Rejected
                                                            // Also update "Qty Ordered" and "Qty Allocated" on SO line - Group all SM lines related to SO line and
                                                            // sum the "Shipment Qty" and update it on these two fields of SO line
                                                            // Retrieve all SO lines and related SM lines
                                                            Decimal qtyOrdered;
                                                            Decimal qtyPartialOrdered;
                                                            Decimal qtyFullCancelReject;
                                                            Boolean isNotCancelledSMLine;
                                                            Decimal cloneproductCount;
                                                            String smMainStatus;
                                                            
                                                        
                                                         if(ShippingManifestHandler.internShipmentComplete == false)
                                                            {
                                                                soLines = [Select Status__c,Product_Name__r.Name,
                                                                       Qty_Ordered__c,
                                                                       Qty_Allocated__c,MOQ__c,
                                                                       Product_Name__r.RecordType.Name,Product_Name__c,
                                                                       Product_Name__r.Auto_Allocation__c,Brand_Quote_Line__c,
                                                                       (Select Id,Status__c From Picklist_Lines__r),
                                                                       (Select SMLine_Status__c, Shipment_Qty__c,Actual_Shipment_Qty__c,Qty_Received__c,Product_Name__r.Name,Product_Name__c,Shipping_Manifest__r.Status__c From Shipping_Manifest_Lines__r)
                                                                           From Sales_Order_Line__c Where  Status__c!= :SHIPPING_MANIFEST_LINE_STATUS_CANCELLED AND  Sales_Order__c IN: soIds and  (Product_Name__r.RecordType.Name =: SALES_ORDER_RECORDTYPE_PRODUCT OR Product_Name__r.RecordType.Name =:PRODUCT_RECORD_TYPE_SERVICES OR Product_Name__r.RecordType.Name =: PRODUCT_RECORDTYPE_DISCOUNT OR Product_Name__r.Name =: PRODUCT_RECORDTYPE_MOV_FEE ) ];
                                                                         
                                                            }else{
                                                                 soLines = [Select Status__c,Product_Name__r.Name,
                                                                       Qty_Ordered__c,
                                                                       Qty_Allocated__c,MOQ__c,
                                                                       Product_Name__r.RecordType.Name,Product_Name__c,
                                                                       Product_Name__r.Auto_Allocation__c,Brand_Quote_Line__c,
                                                                       (Select Id,Status__c From Picklist_Lines__r),
                                                                       (Select SMLine_Status__c, Shipment_Qty__c,Actual_Shipment_Qty__c,Qty_Received__c,Product_Name__r.Name,Product_Name__c,Shipping_Manifest__r.Status__c From Shipping_Manifest_Lines__r)
                                                                           From Sales_Order_Line__c Where   Sales_Order__c IN: soIds  ];
                                                                         
                                                            }
                                                            for(Sales_Order_Line__c soLine : soLines){ 
                                                                qtyOrdered = 0.0;
                                                                qtyPartialOrdered = 0.0;
                                                                qtyFullCancelReject =0.0;
                                                                isNotCancelledSMLine = false;
                                                                cloneproductCount=0.0;
                                                              
                                                                
                                                                for(Shipping_Manifest_Line__c smLineSO : soLine.Shipping_Manifest_Lines__r){ 
                                                                     smMainStatus = smLineSO.Shipping_Manifest__r.Status__c;
                                                                    if(smLineSO.SMLine_Status__c!=null &&  allSMLinesCancelled == false)
                                                                    {
                                                                        
                                                                        if(soLine.Product_Name__c == smLineSO.Product_Name__c && smLineSO.SMLine_Status__c== SHIPPING_MANIFEST_LINE_STATUS_CANCELLED )
                                                                        {
                                                                            qtyOrdered += smLineSO.Shipment_Qty__c;
                                                                        }
                                                                        
                                                                    }else if(smLineSO.SMLine_Status__c!=null &&  allSMLinesCancelled)
                                                                    {
                                                                        if(smLineSO.SMLine_Status__c != SHIPPING_MANIFEST_LINE_STATUS_CANCELLED){  
                                                                            isNotCancelledSMLine = true;
                                                                            if(smLineSO.SMLine_Status__c != SALES_ORDER_LINE_STATUS_REJECTED)
                                                                            {
                                                                                if(smLineSO.Qty_Received__c!=null) {  qtyPartialOrdered += smLineSO.Qty_Received__c; 
                                                                               
                                                                                   
                                                                                }
                                                                                qtyOrdered += smLineSO.Shipment_Qty__c;
                                                                            }else{
                                                                                qtyFullCancelReject += smLineSO.Actual_Shipment_Qty__c;}soLine.Status__c = smLineSO.SMLine_Status__c; 
                                                                        } 
                                                                        
                                                                        
                                                                        if(((smLineSO.SMLine_Status__c== SHIPPING_MANIFEST_LINE_STATUS_CANCELLED || smLineSO.SMLine_Status__c==SHIPPING_MANIFEST_LINE_STATUS_REJECTED ) && smLineSO.SMLine_Status__c != NULL)){
                                                                            
                                                                            if(smLineSO.Qty_Received__c!=NUll && smLineSO.SMLine_Status__c==SHIPPING_MANIFEST_LINE_STATUS_REJECTED  ){qtyFullCancelReject += smLineSO.Qty_Received__c;
                                                                            }
                                                                            if(smLineSO.SMLine_Status__c==SHIPPING_MANIFEST_LINE_STATUS_CANCELLED && allSMLinesCancelled== true ){  qtyFullCancelReject += smLineSO.Shipment_Qty__c;
                                                                            }
                                                                        }
                                                                    }
                                                                    
                                                                } 
                                                                
                                                                 if(soLine.Product_Name__r.RecordType.Name != PRODUCT_RECORDTYPE_DISCOUNT &&  soLine.Product_Name__r.Name != PRODUCT_RECORDTYPE_MOV_FEE ) 
                                                                {
                                                                   
                                                                    
                                                                if(allSMLinesCancelled)
                                                                {
                                                                    // Soline Qty_Ordered__c calculation update 
                                                                    if(qtyPartialOrdered > 0) {   soLine.Qty_Ordered__c = qtyPartialOrdered;
                                                                    }else{
                                                                        soLine.Qty_Ordered__c = qtyFullCancelReject;
                                                                    }
                                                                    soLine.Qty_Allocated__c = qtyPartialOrdered;
                                                                }else{
                                                                    if(soLine.Qty_Ordered__c > 0){  cloneproductCount = (soLine.Qty_Ordered__c - qtyOrdered);  
                                                                        if(cloneproductCount > 0)  { soLine.Qty_Ordered__c= cloneproductCount;
                                                                        }else{
                                                                            soLine.Qty_Ordered__c= soLine.MOQ__c;
                                                                        }
                                                                        
                                                                    }
                                                                    
                                                                }
                                                                }
                                                                
                                                                
                                                                List<Picklist_Line__c> lstPickLine = soLine.Picklist_Lines__r;
                                                                if(lstPickLine != null && lstPickLine.size() > 0){
                                                                    for(Picklist_Line__c pickLine : lstPickLine){
                                                                        if(pickLine.Status__c == PICKLIST_LINE_STATUS_SHIPMENT_COMPLETE){ soLine.Status__c = SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE; break;
                                                                        }    
                                                                    }    
                                                                } 
                                                                
                                                                
                                                                // if all SM line status is cancelled and
                                                                // if all SM lines cancelled and product of SO is of Service record type and
                                                                // Auto Allocation of product must be false or
                                                                // SO is not of Service record type
                                                                // then mark related SO line status as Rejected
                                                                // false && !c && (!service && !auto) || false )
                                                                 if(soLine.Product_Name__r.RecordType.Name != PRODUCT_RECORDTYPE_DISCOUNT &&  soLine.Product_Name__r.Name != PRODUCT_RECORDTYPE_MOV_FEE ) 
                                                                {
                                                                if(!isNotCancelledSMLine && soLine.Status__c != SHIPPING_MANIFEST_STATUS_CANCELLED && ((soLine.Product_Name__r.RecordType.Name != PRODUCT_RECORD_TYPE_SERVICES && !soLine.Product_Name__r.Auto_Allocation__c) || allSMLinesCancelled)){
                                                                        if(isCancel){ soLine.Status__c = SHIPPING_MANIFEST_STATUS_CANCELLED;
                                                                            
                                                                        } else {
                                                                           soLine.Status__c = SALES_ORDER_STATUS_REJECTED; 
                                                                        }  
                                                                    }
                                                              
                                                                
                                                                if( allSMLinesCancelled==false)
                                                                {
                                                                    if(cloneproductCount > 0){  soLine.Status__c = SALES_ORDER_STATUS_ALLOCATED;
                                                                    
                                                                        
                                                                    }else{
                                                                        soLine.Status__c = SHIPPING_MANIFEST_STATUS_CANCELLED; soLine.Qty_Allocated__c = 0;
                                                                    }
                                                                }
                                                                     }
                                                                
                                                             
                                                                
                                                                // Discount & Retail mov fee -- status update
                                                                if( (soLine.Product_Name__r.RecordType.Name == PRODUCT_RECORDTYPE_DISCOUNT || soLine.Product_Name__r.Name==PRODUCT_RECORDTYPE_MOV_FEE)  && smMainStatus==SHIPPING_MANIFEST_LINE_STATUS_CANCELLED){
                                                                    soLine.Status__c = SHIPPING_MANIFEST_STATUS_CANCELLED;
                                                                }  else if((soLine.Product_Name__r.RecordType.Name == PRODUCT_RECORDTYPE_DISCOUNT || soLine.Product_Name__r.Name==PRODUCT_RECORDTYPE_MOV_FEE)  && smMainStatus==SHIPPING_MANIFEST_LINE_STATUS_REJECTED){
                                                                    soLine.Status__c = SALES_ORDER_STATUS_REJECTED;
                                                                }  else if((soLine.Product_Name__r.RecordType.Name == PRODUCT_RECORDTYPE_DISCOUNT || soLine.Product_Name__r.Name==PRODUCT_RECORDTYPE_MOV_FEE)  && smMainStatus==SHIPPING_MANIFEST_STATUS_COMPLETE){
                                                                    soLine.Status__c = SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE;
                                                                } 
                                                                
                                                                soLineIds.add(soLine.Id); poLIds.add(soLine.Brand_Quote_Line__c);
                                                            }
                                                          
                                                         // if(ShippingManifestLineTriggerHandler.isSmlineRejectFromSmComple == False)
                                                         // {
                                                              update soLines; updateETReceipts(soIds,soLineIds);
                                                           // updatesoLines(JSON.serialize(soLines));
                                                           // updateETReceipts(soIds,soLineIds);
                                                         // }
                                                           
                                                           
                                                            // Shipconfirm Partial reject update
                                                          //  updateBqPoLineQty(soLineIds, poLIds);
                                                            
                                                            
                                                        }
                                                    }
    

    @future
    public static void updateETReceipts(Set<Id> soIds,Set<Id> soLineIds){
        Set<Id> invoiceIds = new Set<Id>();
        Set<Id>invoiceLineIds = new Set<Id>();
        List<Invoice__c> invoices = new LIst<Invoice__c>();
        List<Invoice_Line__c> invoiceLines = new List<Invoice_Line__c>();
        List<Excise_Tax_Receipt_Line__c> etrLines = new List<Excise_Tax_Receipt_Line__c>();
        List<Excise_Tax_Receipt__c> etrs = new List<Excise_Tax_Receipt__c>();
        List<Sales_Order__c> soListToUpdate = new List<Sales_Order__c>();
        Boolean soMainStatus=false;
        
        for(Sales_Order__c soObj : [Select SO_Status__c, (Select Status__c From Sales_Order_Lines__r)   From Sales_Order__c  Where Id IN: soIds]){  Boolean isRejectedLines = true;
                                        for(Sales_Order_Line__c soLineObj : soObj.Sales_Order_Lines__r){ if(soLineObj.Status__c != SALES_ORDER_LINE_STATUS_REJECTED){ isRejectedLines = false; 
                                                break;
                                            } 
                                        }
                                        if(isRejectedLines){soObj.SO_Status__c = SALES_ORDER_STATUS_REJECTED; soMainStatus = true;soListToUpdate.add(soObj);
                                        }
                                    }
        
        if(soListToUpdate.size() > 0){           update soListToUpdate;
        }
        // Retrieve ETR and ETR Lines related to Invoice and Invoice lines respectively
        // If Invoice is rejected then ETR and all ETR lines will be rejected
        // If Invoice is not rejected (partial rejection) then only partial ETR lines gets rejected 
        // which is related with rejected Invoice lines
        
        
        // Retrieve invoice and invoice Lines related to SO and SO lines respectively
        // If SO is rejected then invoice and all invoice lines will be rejected
        // If SO is not rejected (partial rejection) then only partial invoice lines gets rejected 
        // which is related with rejected SO lines
        
         List<Invoice__c> getInvoiceData = new  List<Invoice__c>();
         
        if(ShippingManifestHandler.internShipmentComplete == false)
        {
            getInvoiceData = [Select Sales_Order__r.SO_Status__c, AR_Status__c from Invoice__c Where Sales_Order__c IN: soIds AND recordType.Name != :INVOICE_RECORDTYPE_SERVICE];
        }else{ getInvoiceData = [Select Sales_Order__r.SO_Status__c, AR_Status__c from Invoice__c Where Sales_Order__c IN: soIds ];
            
        }
        for(Invoice__c invoiceSO : getInvoiceData ){if(invoiceSO.Sales_Order__r.SO_Status__c == SALES_ORDER_STATUS_REJECTED){
                                            invoiceSO.AR_Status__c = INVOICE_AR_STATUS_REJECTED;
                                            invoices.add(invoiceSO);invoiceIds.add(invoiceSO.Id);
                                        }
                                          if(ShippingManifestHandler.internShipmentComplete == true){
                                            invoiceSO.AR_Status__c = INVOICE_AR_STATUS_SHIPPED;  invoices.add(invoiceSO);
                                            invoiceIds.add(invoiceSO.Id);
                                     
                                            
                                        }
                                    }
        
        
        if(invoices.size() > 0){

            update invoices;
        }


       
        for(Invoice_Line__c invoiceLineSO :  [Select Sales_Order_Line__r.Status__c,
                                             Sales_Order_Line__r.Qty_Ordered__c,
                                             InvoiceLine_Status__c,
                                             Invoice_Qty__c
                                              from Invoice_Line__c Where Sales_Order_Line__c IN: soLineIds  ]){ 
                                      
        if(invoiceLineSO.Sales_Order_Line__r.Status__c == SALES_ORDER_LINE_STATUS_REJECTED){ invoiceLineSO.InvoiceLine_Status__c = INVOICE_LINE_STATUS_REJECTED; invoiceLineIds.add(invoiceLineSO.Id);
                                                 }
                                                 if(invoiceLineSO.Sales_Order_Line__r.Status__c== SALES_ORDER_STATUS_CANCELLED){ invoiceLineSO.InvoiceLine_Status__c = SALES_ORDER_STATUS_CANCELLED;
                                                 }
                                                   if(invoiceLineSO.Sales_Order_Line__r.Status__c== SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE) {invoiceLineSO.InvoiceLine_Status__c =SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE;
                                                 }
                                                 
                                                 
                                                 invoiceLineSO.Invoice_Qty__c = invoiceLineSO.Sales_Order_Line__r.Qty_Ordered__c;
                                                 invoiceLines.add(invoiceLineSO);
                                             }

        // Update invoice Lines
        if(invoiceLines.size() > 0){
            update invoiceLines;
        }
        
        if(invoiceIds.size() > 0){ for(Excise_Tax_Receipt__c etrSO : [Select Invoice__r.AR_Status__c,ETR_Status__c from Excise_Tax_Receipt__c Where Invoice__c IN: invoiceIds]){
                                                   if(etrSO.Invoice__r.AR_Status__c == INVOICE_AR_STATUS_REJECTED){  etrSO.ETR_Status__c = INVOICE_AR_STATUS_REJECTED;  etrs.add(etrSO);
                                                   }
                                               }
            
            // Update ETRs
            if(etrs.size() > 0){update etrs;
            }
        }
        if(invoiceLineIds.size() > 0){  for(Excise_Tax_Receipt_Line__c etrLineSO : [Select Invoice_Line__r.InvoiceLine_Status__c, ETRLine_Status__c from Excise_Tax_Receipt_Line__c  Where Invoice_Line__c IN: invoiceLineIds]){
                                                            if(etrLineSO.Invoice_Line__r.InvoiceLine_Status__c == INVOICE_LINE_STATUS_REJECTED){ etrLineSO.ETRLine_Status__c = INVOICE_LINE_STATUS_REJECTED;
                                                                etrLines.add(etrLineSO);
                                                            }
                                                        }
            
            // Update ETR Lines
            if(etrLines.size() > 0){  update etrLines;
            }
        }
        
      
        
        List<Sales_Order_Line__c> soLineItems = new List<Sales_Order_Line__c>();
        Map<Id,Brand_Quote_Line__c> BQLineMapData = new Map<Id,Brand_Quote_Line__c>();
        Set<Id> porderLIds = new Set<Id>();
         Set<Id> bqLineIds = new Set<Id>();  set<String> mySet = new Set<String>();
        Map<Id,Brand_Quote_Line__c> BQLineMap = new Map<Id,Brand_Quote_Line__c>();
        if(soLineIds.size() > 0){soLineItems = [SElECT Status__c,Qty_Ordered__c,Qty_Allocated__c ,Brand_Quote_Line__c, Sales_Order__c,Actual_Qty_Ordered__c,MOQ__c  FROM Sales_Order_Line__c WHERE Id IN:soLineIds];
                                 List<Brand_Quote_Line__c> BQLToUpdate = new List<Brand_Quote_Line__c>();
                                 for(Sales_Order_Line__c sli: soLineItems){ Brand_Quote_Line__c bql = new Brand_Quote_Line__c();
                                     if(sli.Brand_Quote_Line__c != null){  bqLineIds.add(sli.Brand_Quote_Line__c); 
                                                                        }
                                     if(sli.Status__c == SALES_ORDER_LINE_STATUS_REJECTED) { mySet.add(sli.Brand_Quote_Line__c); 
                                                                                            if(sli.Brand_Quote_Line__c != null){  bql = new Brand_Quote_Line__c(Id = sli.Brand_Quote_Line__c,Status__c = sli.Status__c,Quantity_Cases__c=sli.Qty_Ordered__c/sli.MOQ__c);  
                }
                if(bql != null && bql.Id != null){BQLineMap.put(sli.Brand_Quote_Line__c,bql);    
                }}
                                 }
                              
                                 if(bqLineIds.size() > 0 ) {
                                     
                                     List<Purchase_Order_Line__c> polineList = new List<Purchase_Order_Line__c>();
                                     List<Purchase_Order_Line__c> polineToUpdate = new List<Purchase_Order_Line__c>();
                                     polineList= [select Id,Brand_Quote_Line__c,Brand_Quote_Line__r.Line_Total_Qty__c,Brand_Quote_Line__r.Status__c,POLI_Status__c  from Purchase_Order_Line__c where Brand_Quote_Line__c IN:bqLineIds];
                                     if(polineList.size()>0 ){for(Purchase_Order_Line__c po: polineList){ 
                                         Purchase_Order_Line__c poIds = new Purchase_Order_Line__c();
                                         poIds.Id = po.Id;
                                         if(po.Brand_Quote_Line__r.Status__c ==STATUS_CANCELLED ){  
                                             poIds.POLI_Status__c = po.Brand_Quote_Line__r.Status__c; 
                                         } else if(po.Brand_Quote_Line__r.Status__c == STATUS_REJECTED){
                                              poIds.POLI_Status__c = po.Brand_Quote_Line__r.Status__c;  
                                         }
                                      
                                         if(soMainStatus){
                                             poIds.POLI_Status__c = PURCHASE_ORDER_LINE_STATUS_REJECTED;
                                         }
                                         if(mySet.contains(po.Brand_Quote_Line__c)){
                                              poIds.POLI_Status__c = PURCHASE_ORDER_LINE_STATUS_REJECTED;
                                         }
                                         poIds.Qty_Ordered__c =  po.Brand_Quote_Line__r.Line_Total_Qty__c;
                                         polineToUpdate.add(poIds);
                                     }
                                                              if(polineToUpdate.size() >0){
                                                                   update polineToUpdate;  
                                                              }
                                                              
                                                             }
                                      
                                 }
                                 
                                 
                                }
    }
    

    
    
    /**
* Depart Confirm RSM
* Change Status to RSM status, Actual Departure time of RSM
* Change Inv Location, Rack, Rack Level and Bin Location of Inv Position as vehicle name
*
* @param rsmsToDepart The list of RSMs to depart
*/         
    public static void departConfirmRSMs(List<Shipping_Manifest__c> rsmsToDepart) {
        
        List<Shipping_Manifest_Line__c> rsmLines = new List<Shipping_Manifest_Line__c>();
        Set<Id> invPositionIds = new Set<Id>();
        List<Inventory_Position__c> invPositions = new List<Inventory_Position__c>();
        Set<Id> siteIds = new Set<Id>();
        Map<Id, Id> invLocationIdBySiteId = new Map<Id, Id>();
        Map<Id, Id> rackIdByInvLocationId = new Map<Id, Id>();
        Map<Id, Id> rackLevelIdByRackId = new Map<Id, Id>();
        Map<Id, Id> binLocationIdByRackLevelId = new Map<Id, Id>();
        Set<String> vehicleNames = new Set<String>();
        
        for(Shipping_Manifest__c rsmObj : rsmsToDepart){
            
            rsmObj.Status__c = SHIPPING_MANIFEST_STATUS_INTRANSIT;
            rsmObj.Actual_Departure_Date_Time__c = System.now();
            rsmLines.addAll(rsmObj.Shipping_Manifest_Lines__r);
            
            if(rsmObj.Vehicle__c != null){
                vehicleNames.add(rsmObj.Vehicle__r.Name);
            }
        }
        update rsmsToDepart;
        
        for(Shipping_Manifest_Line__c rsmLineObj : rsmLines){
            invPositionIds.add(rsmLineObj.Picklist_Line__r.Inventory_Position__c);
            siteIds.add(rsmLineObj.Picklist_Line__r.Inventory_Position__r.Site__c);
        }
        
        invPositions = [SELECT Site__c, 
                        Inventory_Location__c, 
                        Rack__c, 
                        Rack_Level__c, 
                        Bin_Location__c 
                        FROM Inventory_Position__c 
                        WHERE Id IN: invPositionIds];
        
        // Create map of Inventory location Id by Site Id
        for(Inventory_Location__c invLocation : [SELECT Site_Name__c FROM Inventory_Location__c WHERE Site_Name__c IN: siteIds  AND Name IN: vehicleNames]){
            invLocationIdBySiteId.put(invLocation.Site_Name__c, invLocation.Id);
        }
        
        // Create map of rack Id by Inventory location Id
        for(Rack__c rackSO : [Select Inventory_Location__c from Rack__c Where Inventory_Location__c IN: invLocationIdBySiteId.values() AND Name =: vehicleNames]){
            rackIdByInvLocationId.put(rackSO.Inventory_Location__c, rackSO.Id);
        }
        
        // Create map of rack level Id by rack Id
        for(Rack_Level__c rackLevelSO : [Select Rack__c from Rack_Level__c Where Rack__c IN: rackIdByInvLocationId.values() AND Name IN: vehicleNames]){
            rackLevelIdByRackId.put(rackLevelSO.Rack__c, rackLevelSO.Id);
        }
        
        // Create map of bin location Id by rack level Id
        for(Bin_Location__c binLocationSO : [Select Rack_Level__c from Bin_Location__c Where Rack_Level__c IN: rackLevelIdByRackId.values() AND Name IN: vehicleNames]){
            binLocationIdByRackLevelId.put(binLocationSO.Rack_Level__c, binLocationSO.Id);
        }
        
        // Update inventory positions attributes as vehicle name
        for(Inventory_Position__c invPosition : invPositions){
            invPosition.Inventory_Location__c = invLocationIdBySiteId.get(invPosition.Site__c);
            invPosition.Rack__c = rackIdByInvLocationId.get(invPosition.Inventory_Location__c);
            invPosition.Rack_Level__c = rackLevelIdByRackId.get(invPosition.Rack__c);
            invPosition.Bin_Location__c = binLocationIdByRackLevelId.get(invPosition.Rack_Level__c);
        }
        updateInventoryPosition(JSOn.serialize(invPositions));
       
    }
    
    @future
    public static void updateInventoryPosition(String invPositionList){
        List<Inventory_Position__c> invPositionsData = (List<Inventory_Position__c>)JSON.deserialize(invPositionList, List<Inventory_Position__c>.class);
        update invPositionsData;
    }
    
    
}