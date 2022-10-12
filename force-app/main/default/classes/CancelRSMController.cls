/**
* Copyright (c) 2018 WOVN
* All rights reserved.
* CancelRSMController
*/
public class CancelRSMController{
    private Static String INVOICE_RECORDTYPE_SERVICE{
        get{
            return String.isNotBlank(INVOICE_RECORDTYPE_SERVICE) ? INVOICE_RECORDTYPE_SERVICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
    private Static String PRODUCT_NAME_MILEAGE_FEE{
        get{
            return String.isNotBlank(PRODUCT_NAME_MILEAGE_FEE) ? PRODUCT_NAME_MILEAGE_FEE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Mileage_Fee');
        }set;
    } 
    private Static String PRODUCT_NAME_WEIGHT_FEE{
        get{
            return String.isNotBlank(PRODUCT_NAME_WEIGHT_FEE) ? PRODUCT_NAME_WEIGHT_FEE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Weight_Fee');
        }set;
    }
    private Static String ORDER_CANCELLED_BY_WOVN{
        get{
            return String.isNotBlank(ORDER_CANCELLED_BY_WOVN) ? ORDER_CANCELLED_BY_WOVN: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Filigreen');
        }set;
    }
        
    public Static String SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM) ? SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_ProductTSM');
        }set;
    }
    
    public Static String PURCHASE_ORDER_STATUS_REJECTED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_REJECTED) ? PURCHASE_ORDER_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase Order Status Rejected');
        }set;
    } 
    
    public Static String SHIPPING_MANIFEST_LINE_STATUS_REJECTED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_STATUS_REJECTED) ? SHIPPING_MANIFEST_LINE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Rejected');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE) ? SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SM_Line_Status_Shipment_Complete');
        }set;
    }

    
    
    
    public Map<String, String> getRejectionReason { get; set; }
    private ApexPages.StandardController stdController;
    private static final String STATUS_CANCELLED = RSMSupport.STATUS_CANCELLED; 
    private static final String STATUS_SHIPMENT_COMPLETE = RSMSupport.STATUS_SHIPMENT_COMPLETE; 
    private Integer rsmLineCount;
    public static Boolean isTSMCancelled = false;
    
    public List<RSMLineWrapper> rsmLines {get; set;}
    public Shipping_Manifest__c rsmObj {get; set;}
    
    public boolean isError {get; set;}
    
    @AuraEnabled public String accID {get; set;}
    public Shipping_Manifest__c setSM {get; set;}
    public List<rsmlinesWrapper> setRsmLines {get; set;}
    public static boolean IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED = True;
     public static boolean CANCELFROM_CANCELRSMCONTROLLER = False;
    
    // Constructor
    public CancelRSMController(ApexPages.StandardController controller) {
        this.stdController = controller;
        rsmObj = (Shipping_Manifest__c)stdController.getRecord();
        rsmLines = new List<RSMLineWrapper>();
        isError = false;
        rsmLineCount = 0;
    }
    
    public CancelRSMController(){
        rsmLines = new List<RSMLineWrapper>();
        isError = false;
    }
    
    public class UserException extends Exception{ }
    
    /**
* Retrieve RSM lines
*
*/
    public PageReference retrieveRSMLines() {
        rsmObj = RSMSupport.retrieveRSM(rsmObj.Id);
        
        // Check validation if RSM status is not Received
        if(rsmObj.Status__c == STATUS_CANCELLED){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,
                                                          Label.Already_RSM_Cancelled);
            ApexPages.addMessage(msg);
            isError = true;
        } else if(rsmObj.Status__c == STATUS_SHIPMENT_COMPLETE){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,
                                                          Label.Cannot_Cancel_RSM);
            ApexPages.addMessage(msg);
            isError = true;
            
            // if all validation passed then display RSM lines
        }else{
            
            // Retrieve RSM lines
            for(Shipping_Manifest_Line__c rsmLineSO : rsmObj.Shipping_Manifest_Lines__r){
                RSMLineWrapper rsmLineWrapperObj = new RSMLineWrapper();
                rsmLineWrapperObj.rsmLineSO = rsmLineSO;
                
                // Cancelled RSM line should be disabled
                if(rsmLineSO.SMLine_Status__c == RSMSupport.STATUS_CANCELLED){
                    rsmLineWrapperObj.disabled = true;
                }else{
                    rsmLineCount++;
                }
                rsmLines.add(rsmLineWrapperObj);
            }
        }
        return null;
    }
    
    /**
* Change Status to RSM status and Update inventory positions and SO lines related to RSM lines
*/         
    public PageReference cancelRSMAction() {
        
        //validate if any RSM line is selected or not to cancel
        if(!isRSMLineSelected()) {            
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.INFO, Label.Select_RSM_Line_To_Cancel);
            ApexPages.addMessage(msg);
            return null;
        }
        
        Savepoint savePoint;
        
        try {
            
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            
            
            // Update selected RSM line status as cancelled
            List<Shipping_Manifest_Line__c> selectedRSMLines = new List<Shipping_Manifest_Line__c>();
            Boolean allSMLinesCancelled = true;
            
            for(RSMLineWrapper rsmLineWrapperObj : rsmLines){
                if(rsmLineWrapperObj.selected){
                    rsmLineWrapperObj.rsmLineSO.SMLine_Status__c = STATUS_CANCELLED;                    
                    selectedRSMLines.add(rsmLineWrapperObj.rsmLineSO);
                }else{
                    allSMLinesCancelled = false;
                }
            }
            
            update selectedRSMLines;
            
            
            // Update RSM status as cancelled if all RSM lines got selected
            if(selectedRSMLines.size() > 0){
                if(rsmLineCount == selectedRSMLines.size()){
                    rsmObj.Status__c = STATUS_CANCELLED;
                    update rsmObj;
                    
                    // Cancel related picklist record
                    if(rsmObj.Picklist__c != null){
                        Picklist__c picklistObj = new Picklist__c();
                        picklistObj.Id = rsmObj.Picklist__c;
                        picklistObj.Status__c = STATUS_CANCELLED;
                        update picklistObj;
                    }
                }
                
                // Update inventory positions and SO lines related to RSM lines
                RSMSupport.updateInvPositionsAndSOLines(selectedRSMLines, allSMLinesCancelled, true);
            }
            
        }catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('CancelRSMController:cancelRSMAction()',  ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(msg);
            return null;
        }
        return redirectToRSM();
    }
    
    /**
* Redirect to RSM detail page
*
* @return PageReference
*/         
    public PageReference redirectToRSM() {
        PageReference pageRef = stdController.view().setRedirect(true);
        return pageRef;
    }
    
    /** 
* Verify if any RSM line are selected or not
*
* @return Flag to determine if RSM line is selected or not
*/
    public Boolean isRSMLineSelected(){
        Boolean rsmLineSelected = false;
        for(RSMLineWrapper rsmLineWrapperObj : rsmLines){
            if(rsmLineWrapperObj.selected){
                rsmLineSelected = true;
                break;
            }
        }
        return rsmLineSelected;
    }
    
    /** 
* Lighting Method Start 
* 
* 
*/
    // Constructor
    @AuraEnabled
    public static AuraResponse getSmLines(String recordId, String smId, String invoiceId){ 
        
        AuraResponse r = new AuraResponse('CancelRsm.getSmLines()'); 
        CancelRSMController assign = new CancelRSMController();
        assign.setSM = getShipMan(recordId);
        assign.setRsmLines = getRsmLines(recordId); 
        assign.getRejectionReason = getRejectionReason();
        r.data.put('setSM', assign.setSM);
        r.data.put('setRsmLines', assign.setRsmLines);
        r.data.put('setRejectionReason', assign.getRejectionReason);
        list<Invoice__c>serviceInvoiceList=[select id from invoice__c where sales_Order__c =: assign.setSM.Sales_Order__c AND recordType.Name =: INVOICE_RECORDTYPE_SERVICE];
        r.data.put('hasServiceInvoice', serviceInvoiceList.size()>0);
       
        return r; 
    } 
    
    // Retrieve Shipmainfest Detail
    public static Shipping_Manifest__c getShipMan(String recordId){
        
        Shipping_Manifest__c shipManLines = [Select Sales_Order__c,Sales_Order__r.Name, Site__r.Name, Name, Payment_Terms__c, Window_Start_End__c, Priority__c, Receiver_Contact__r.Name,Receiver_Name__r.Name, Supplier_Name__c,Receiver_Name__c,Distributor_Name__r.Name,Distributor_Name__c,
                                             Metrc_Manifest__c, Status__c,Customer_PO_or_Quote__c,Site__r.Id,Planned_Ship_Transfer_Date__c,Sales_Order__r.Id,RecordType.Name,Supplier_Name__r.Name,Supplier_Name__r.Id,Picklist__r.Name,Picklist__r.Id,Order_Number__r.Id,Supplier_Name__r.DBA__c,Receiver_Name__r.DBA__c,
                                             Distributor_Name__r.DBA__c,Purchase_Order__r.Name,Purchase_Order__c,Brand_Quote__c,Brand_Quote__r.Name From Shipping_Manifest__c where  Id =: recordId];
        return shipManLines;
    }
    
    //RSM Line Wrapper 
    public class rsmlinesWrapper{
        
        @AuraEnabled 
        public Shipping_Manifest_Line__c rsmlinesIL {get; set;}
        public rsmlinesWrapper(Shipping_Manifest_Line__c rsmlinesIL){
            this.rsmlinesIL = rsmlinesIL;
        }
        public rsmlinesWrapper(){
            this.rsmlinesIL = rsmlinesIL;
        }
    }
    
    //RSM Line Instance Wrapper Class
    
    public static List<rsmlinesWrapper>  getRsmLines(Id recordID){ 
        List<rsmlinesWrapper> rsmLnWrapper = new List<rsmlinesWrapper>();
        List<Shipping_Manifest_Line__c> ShippingManifestLineValue = [SELECT Id, Name, Product_Name__r.Name, Shipping_Manifest__r.Name,Product_Description__c,Producer_Name__c,Product_Name__c,
                                                                     Retail_Wholesale_Price__c,Shipment_Qty__c,Rejection_Reason__c,Shipping_Manifest__r.Customer_PO_or_Quote__c,Shipping_Manifest__r.Status__c, Shipping_Manifest__r.Picklist__c,Shipping_Manifest__r.Site__c,
                                                                     Qty_Received__c,Picklist_Line__r.Name,Picklist_Line__r.Inventory_Position__c,Picklist_Line__r.Sales_Order_Line__c
                                                                     ,Picklist_Line__r.Id,Picklist_Line__r.Inventory_Position__r.Site__c,Picklist_Line__r.Inventory_Position__r.Id,Sales_Order_Line__r.Name,Sales_Order_Line__r.Id,Picklist_Line__r.Sales_Order_Line__r.Sales_Order__c,
                                                                     Sales_Order_Line__r.Sales_Order__c,Sales_Order_Line__r.RecordTypeId,Picklist_Line__c,Sales_Order_Line__c,Line_Total_Price__c,SMLine_Status__c,RecordTypeId,Qty_Ordered__c,Line_Total_Cost__c,Purchase_Order_Line__c,Purchase_Order_Line__r.Name
                                                                     FROM Shipping_Manifest_Line__c WHERE (SMLine_Status__c!=:SHIPPING_MANIFEST_LINE_STATUS_REJECTED AND SMLine_Status__c!=:SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE ) AND Shipping_Manifest__c =:recordID];
        for(Shipping_Manifest_Line__c rsmres : ShippingManifestLineValue){
            rsmlinesWrapper inLinersmlineWrapper = new rsmlinesWrapper(rsmres);
            rsmLnWrapper.add(inLinersmlineWrapper);
        }
        return rsmLnWrapper;
    }

    //payment form status picklist
    @AuraEnabled
    public static Map<String, String> getRejectionReason(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Shipping_Manifest_Line__c.Rejection_Reason__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) { 
                options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
    
    //Change Status to RSM status and Update inventory positions and SO lines related to RSM lines
    
    @AuraEnabled
    public static AuraResponse updateSmLines(List<Id> lstRecordId,String recordId,Boolean isIncludeServiceInvoices, List<rsmlinesWrapper> setRsmLines) {
       
        
        AuraResponse r = new AuraResponse('CancelRsm.updateSmLines()'); 
        IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED = false;
        CANCELFROM_CANCELRSMCONTROLLER = true;
        CancelRSMController assign = new CancelRSMController();
        set<id>solids = new set<id>();
        List<Shipping_Manifest_Line__c> shippingMLineList = new List<Shipping_Manifest_Line__c>();
        for (rsmlinesWrapper res :setRsmLines){  
            Shipping_Manifest_Line__c smObj=res.rsmlinesIL;
            if(res.rsmlinesIL!=NULL)
                if(lstRecordId.contains(smObj.Id)){
                    smObj.SMLine_Status__c = STATUS_CANCELLED;
                    shippingMLineList.add(smObj);
                    solids.add(smObj.Sales_Order_Line__c);
                }
            
        }
        if(shippingMLineList.size()  > 0)
        {
             update shippingMLineList;  
        }
        
        Boolean allCancelledRSMLine = true;
        // Check whether all RSM lines are Cancelled or Not
        Boolean cancelStatus = false;
        List<Shipping_Manifest_Line__c> shippingManifestLinecancelcount =[SELECT Id, Name,SMLine_Status__c FROM Shipping_Manifest_Line__c WHERE Shipping_Manifest__c =:recordID ];
        if(shippingManifestLinecancelcount != null && shippingManifestLinecancelcount.size() > 0){
            for(Shipping_Manifest_Line__c getCancel : shippingManifestLinecancelcount){
                if(getCancel.SMLine_Status__c != STATUS_CANCELLED){
                    cancelStatus = true;
                    allCancelledRSMLine = false;
                    break;
                }    
            }    
        } 
        
        Shipping_Manifest__c res = [Select Id,Status__c,Sales_Order__c,Customer_PO_or_Quote__c,Site__r.Id,Picklist__c,RecordTypeId,RecordType.name,Order_Number__c,Brand_Quote__c From Shipping_Manifest__c where Id=:recordId]; 
        string recordtypename =Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosById().get(res.RecordTypeId).getname();
        if(recordtypename==SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM && allCancelledRSMLine){
            isTSMCancelled = true;
            res.Status__c = STATUS_CANCELLED;
            update res;
        }
        
        if(cancelStatus==false && recordtypename!=SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM)
        {
            res.Status__c = STATUS_CANCELLED;
            update res;
            if(res.Order_Number__c != NULL){
                Order__c orderRes =  [SELECT Id,Status__c FROM Order__c WHERE Id=: res.Order_Number__c];
                orderRes.Status__c = ORDER_CANCELLED_BY_WOVN;
                update orderRes;
            }
            if(res.Brand_Quote__c != NULL){
                Brand_Quote__c brandQuoteData = new Brand_Quote__c();
                brandQuoteData.Id = res.Brand_Quote__c;   
                brandQuoteData.BQ_Status__c = STATUS_CANCELLED;
                brandQuoteData.Ship_Confirmation_Date__c = System.Today();
                Update brandQuoteData;
                
                List<Purchase_Order__c> lstPores = new List<Purchase_Order__c>();
                for(Purchase_Order__c pros : [Select Id,PO_Status__c,Brand_Quote__c From Purchase_Order__c where Brand_Quote__c=:res.Brand_Quote__c]){
                    pros.PO_Status__c = STATUS_CANCELLED;
                    lstPores.add(pros);
                }
                if(lstPores.size() > 0){
                    update lstPores;
                }
           
            }
                
            if(res.Sales_Order__c != NULL){
                Sales_Order__c soData = new Sales_Order__c();
                soData.Id = res.Sales_Order__c;
                soData.SO_Status__c = STATUS_CANCELLED;
                soData.Ship_Confirmation_Date__c = System.Today(); Update soData;
            }
            
            
        }
        
        
        if(recordtypename!=Label.RecordType_Product_Tsm){
            
            RSMSupport.updateInvPositionsAndSOLines(shippingMLineList, allCancelledRSMLine,true);
        }
        
        if(recordtypename!= Label.RecordType_Product_Tsm && cancelStatus==false && res.Picklist__c != NULL){
            Picklist__c picklistObj = new Picklist__c();
            picklistObj.Id = res.Picklist__c;
            picklistObj.Status__c = STATUS_CANCELLED;
           update picklistObj;
        }
        
        if(isIncludeServiceInvoices == true && cancelStatus == false && res.Sales_Order__c != NULL){
            Set<Id> invoiceIds = new Set<Id>();
            List<Invoice__c> invoices = new List<Invoice__c>();
            List<Invoice_Line__c> lines = new List<Invoice_Line__c>();
            for(Invoice__c  invoiceObj : [SELECT Id FROM Invoice__c WHERE Sales_Order__c = :res.Sales_Order__c AND AR_Status__c !=:STATUS_CANCELLED]){
                invoices.add(new Invoice__c(
                    Id = invoiceObj.Id,
                    AR_Status__c = STATUS_CANCELLED
                ));
                invoiceIds.add(invoiceObj.Id);
            }
            for(Invoice_Line__c lineObj : [SELECT Id FROM Invoice_Line__c WHERE Invoice__c IN :invoiceIds AND InvoiceLine_Status__c != :STATUS_CANCELLED]){
                lines.add(new Invoice_Line__c(
                    Id = lineObj.Id,
                    InvoiceLine_Status__c  = STATUS_CANCELLED
                ));
            }
            if(invoices.size() > 0) update invoices;
            if(lines.size() > 0) update lines;
        }
        return r;
        
    }
    
    @AuraEnabled
    public static AuraResponse updateOnlyServiceLine(String recordId) {
        AuraResponse r = new AuraResponse('updateOnlyServiceLine'); 
        list<Shipping_Manifest__c>SMList = [select id,Sales_Order__c from Shipping_Manifest__c  where id =: recordId];
        if(SMList.size() > 0){
            list<Invoice_Line__c>invoiceLineList = new list<Invoice_Line__c>();
            list<Invoice_Line__c>serviceInvoiceLineList=[SELECT Id,InvoiceLine_Status__c,Invoice_Qty__c FROM Invoice_Line__c WHERE Product_Name__r.NAME IN (:PRODUCT_NAME_MILEAGE_FEE ,:PRODUCT_NAME_WEIGHT_FEE) AND Invoice__r.Sales_Order__c =: SMList[0].Sales_Order__c AND Invoice__r.RecordType.Name = :INVOICE_RECORDTYPE_SERVICE];       
            for(Invoice_Line__c invLine : serviceInvoiceLineList){
                invLine.InvoiceLine_Status__c = STATUS_CANCELLED;
                invLine.Invoice_Qty__c = 0;
            }
            update serviceInvoiceLineList;
        }
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static List<Shipping_Manifest_Line__c> retriveShippingManifestLine() {
        List<Shipping_Manifest_Line__c> shippingList = [SELECT ID, Name, Product_Name__c, Product_Description__c,  Shipment_Qty__c, Qty_Received__c,Line_Total_Price__c, Picklist_Line__c, Rejection_Reason__c FROM Shipping_Manifest_Line__c]; 
        return shippingList;
    }    
    
}