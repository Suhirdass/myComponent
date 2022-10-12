/**
* Copyright (c) 2021 WOVN
* All rights reserved.
* RSMTSMShipConfirmCotroller
*/
public class RSMTSMShipConfirmCotroller{
    
    @testVisible
    public List<Shipping_Manifest__c> shipLine {get; set;}
    private Integer rsmLineCount;
    public List<RSMTSMWrapper> selectedList {get; set;}
    public String selectedAddresses {get;set;}
    public Boolean displayMapResult {get; set;}
    public String selectedRSMTSMId {get; set;}
    public Boolean isRSM {get; set;}
    public Boolean displayRSMLines {get; set;}
    public Boolean showRSMLineInfoErrorMessage {get; set;}
    public Boolean showRSMInfoErrorMessage {get; set;}
    public Boolean displayDepartConfirm {get; set;}
  
    public static boolean IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED = True;
    public static boolean IS_FULL_REJECT = False;
    
    public Shipping_Manifest__c rsmSO {get; set;}
    public Shipping_Manifest__c tsmSO {get; set;}
    public Map<Id, Shipping_Manifest__c> rsmSOById {get; set;}
    public Map<Id, Shipping_Manifest__c> tsmSOById {get; set;}
    
    public Map<Id, List<PendingInvoiceWrapper>> pendingInvoiceByAccountId {get; set;}
    public Map<Id, List<PendingInvoiceWrapper>> currentInvoiceForRSMTSM {get; set;}
    public Id accountIdOfSelectedRSMTSM {get; set;}
    public Id SOorPOIdOfSelectedRSMTSM {get; set;}
    
    public List<RSMLineWrapper> rsmLines {get; set;}
    public Shipping_Manifest__c rsmObj {get; set;}
     public List<Invoice__c> invoiceDt {get; set;}
    
    public Boolean hasValidationError {get; set;}
    public String errorMessage {get; set;}
    public String selectedDay {get; set;}
    
    private Id rsmRecordTypeId;
    private Id tsmRecordTypeId;
    private Set<Id> recordTypeIds;
    

    /** For Lightning declaration Start **/
    public class ShipLineWrapper{
        @AuraEnabled
        public Shipping_Manifest__c shipLine {get; set;}
        @AuraEnabled
        public Integer pendingInvoice {get; set;}
        public ShipLineWrapper(Shipping_Manifest__c shipLine){
            this.shipLine = shipLine;
            this.pendingInvoice = 0;
        }
        public ShipLineWrapper(){
            this.shipLine = shipLine;
            this.pendingInvoice = 0;
        }
    }

    @AuraEnabled public List<ShipLineWrapper> setShipLines {get; set;}
    @AuraEnabled public List<accountLocationWrapper> setgeolocation {get; set;}

    public List<InvoiceLineWrapper> setInvoiceLines {get; set;}
    public List<InvoiceLineWrapper> setOpenInvoiceLines {get; set;}
    public List<InvoiceLineWrapper> setPendingInvoiceLines {get; set;}
    public Shipping_Manifest__c setSM {get; set;}
    public List<rsmlinesWrapper> setRsmLines {get; set;}
    public static List<rsmlinesWrapper> setRsmLines {get; set;}
    @AuraEnabled public Shipping_Manifest__c rsmSOLines {get; set;}
    @AuraEnabled Public datetime NOW  = system.now();
    @AuraEnabled Public List<Contact> getReceiverContacts{get; set;} 
    public static String smErrorMessage;
    public Map<String, String> getPaymentStatusData { get; set; }
    
    /* metadata Type values for lightning */
    public Static String SHIPPING_MANIFEST_STATUS_RECEIVED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_RECEIVED) ? SHIPPING_MANIFEST_STATUS_RECEIVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Received');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_CANCELLED) ? SHIPPING_MANIFEST_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Cancelled');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_DRAFT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_DRAFT) ? SHIPPING_MANIFEST_STATUS_DRAFT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Draft');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_COMPLETE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_COMPLETE) ? SHIPPING_MANIFEST_STATUS_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Complete');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_REJECTED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_REJECTED) ? SHIPPING_MANIFEST_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Rejected');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_STATUS_PENDING{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_PENDING) ? SHIPPING_MANIFEST_STATUS_PENDING: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_ShipmentPending');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_STATUS_INTRANSIT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_INTRANSIT) ? SHIPPING_MANIFEST_STATUS_INTRANSIT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_InTransit');
        }set;
    } 
    
    public Static String PICKLIST_STATUS_QACONFIRM{
        get{
            return String.isNotBlank(PICKLIST_STATUS_QACONFIRM) ? PICKLIST_STATUS_QACONFIRM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','PickList_Status_QaConfirm');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM) ? SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_ProductTSM');
        }set;
    }
    public Static String SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION) ? SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_CashCollect');
        }set;
    }
    
    public Static String ORDER_STATUS_SHIPPED{
        get{
            return String.isNotBlank(ORDER_STATUS_SHIPPED) ? ORDER_STATUS_SHIPPED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Shipped');
        }set;
    }
    
    public Static String BRAND_QUOTE_STATUS_REJECTED{
        get{
            return String.isNotBlank(BRAND_QUOTE_STATUS_REJECTED) ? BRAND_QUOTE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Status_Rejected');
        }set;
    }    
    
    public Static String INVOICE_AR_STATUS_SHIPPED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_SHIPPED) ? INVOICE_AR_STATUS_SHIPPED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Shipped');
        }set;
    }
    public Static String INVOICE_AR_STATUS_APPROVED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_APPROVED) ? INVOICE_AR_STATUS_APPROVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Approved');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_LINE_STATUS_REJECTED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_STATUS_REJECTED) ? SHIPPING_MANIFEST_LINE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Rejected');
        }set;
    }
    
    public Static String INVOICE_COLLECTION_STATUS_PAIDFULL{
        get{
            return String.isNotBlank(INVOICE_COLLECTION_STATUS_PAIDFULL) ? INVOICE_COLLECTION_STATUS_PAIDFULL: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Collection_Status_Paid_in_full');
        }set;
    }
    public Static String SHIPPING_MANIFEST_ESIGN_UNICODE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_ESIGN_UNICODE) ? SHIPPING_MANIFEST_ESIGN_UNICODE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Esign_UTF8');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_LINE_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_STATUS_CANCELLED) ? SHIPPING_MANIFEST_LINE_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Cancelled');
        }set;
    }
    
    
    public Static String SHIPPING_MANIFEST_RECORDTYPE_TRANSFER{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER) ? SHIPPING_MANIFEST_RECORDTYPE_TRANSFER: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Transfer');
        }set;
    }
    public Static String SHIPPING_MANIFEST_RECORDTYPE_LAB{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_LAB) ? SHIPPING_MANIFEST_RECORDTYPE_LAB: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Lab');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_RECORDTYPE_TRANSFFERED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_TRANSFFERED) ? SHIPPING_MANIFEST_RECORDTYPE_TRANSFFERED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Transferred');
        }set;
    }
    public Static String SHIPPING_MANIFEST_RECORDTYPE_TEST_SAMPLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_TEST_SAMPLED) ? SHIPPING_MANIFEST_RECORDTYPE_TEST_SAMPLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_TestSampled');
        }set;
    }
    public Static String SHIPPING_MANIFEST_RECORDTYPE_DELIVERED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_DELIVERED) ? SHIPPING_MANIFEST_RECORDTYPE_DELIVERED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Delivered');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_RECEIVE_PAYMENT_RECORDTYPE_EXCISE_TAX{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECEIVE_PAYMENT_RECORDTYPE_EXCISE_TAX) ? SHIPPING_MANIFEST_RECEIVE_PAYMENT_RECORDTYPE_EXCISE_TAX: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_ReceivePayment_RecordType_Excise');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_ESIGN_FORMAT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_ESIGN_FORMAT) ? SHIPPING_MANIFEST_ESIGN_FORMAT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Esign_Format');
        }set;
    }
    public Static String SHIPPING_MANIFEST_ESIGN_UNDERSCORE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_ESIGN_UNDERSCORE) ? SHIPPING_MANIFEST_ESIGN_UNDERSCORE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Underscore');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_LINE_ERROR_QUANTITY_POSITIVE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_ERROR_QUANTITY_POSITIVE) ? SHIPPING_MANIFEST_LINE_ERROR_QUANTITY_POSITIVE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_Line_Error_Qty_Positive');
        }set;
    }
    public Static String SHIPPING_MANIFEST_LINE_ERROR_QUANTITY_NOT_GREATER_VALUE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_ERROR_QUANTITY_NOT_GREATER_VALUE) ? SHIPPING_MANIFEST_LINE_ERROR_QUANTITY_NOT_GREATER_VALUE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_Error_Not_Greater_Val');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_LINE_ERROR_PAYMENT_FORM_REQUIRED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_ERROR_PAYMENT_FORM_REQUIRED) ? SHIPPING_MANIFEST_LINE_ERROR_PAYMENT_FORM_REQUIRED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','InvoiceError_Payment_From_Required');
        }set;
    }
    
    public Static String INVOICE_EXCISE_PRODUCT_AMOUNT_VALIDATION{
        get{
            return String.isNotBlank(INVOICE_EXCISE_PRODUCT_AMOUNT_VALIDATION) ? INVOICE_EXCISE_PRODUCT_AMOUNT_VALIDATION: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Excise_product_amount_validation');
        }set;
    }
    
    public Static String INVOICE_EXCISE_PRODUCT_TAX_AMOUNT_VALIDATION{
        get{
            return String.isNotBlank(INVOICE_EXCISE_PRODUCT_TAX_AMOUNT_VALIDATION) ? INVOICE_EXCISE_PRODUCT_TAX_AMOUNT_VALIDATION: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Excise_Product_Tax_Amount_Validation');
        }set;
    }
    public Static String INVOICE_EXCISE_PRODUCT_DUPLICATE_AMOUNT_PAYMENT{
        get{
            return String.isNotBlank(INVOICE_EXCISE_PRODUCT_DUPLICATE_AMOUNT_PAYMENT) ? INVOICE_EXCISE_PRODUCT_DUPLICATE_AMOUNT_PAYMENT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Duplicate_Product_Amount_Payment');
        }set;
    }
    
    public Static String INVOICE_ERROR_DUPLICATE_TAX_AMOUNT{
        get{
            return String.isNotBlank(INVOICE_ERROR_DUPLICATE_TAX_AMOUNT) ? INVOICE_ERROR_DUPLICATE_TAX_AMOUNT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Duplicate_Tax_Amount');
        }set;
    }
    
    public Static String INVOICE_ERROR_ACCOUNT_HOLD{
        get{
            return String.isNotBlank(INVOICE_ERROR_ACCOUNT_HOLD) ? INVOICE_ERROR_ACCOUNT_HOLD: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Hold');
        }set;
    }
    
    public Static String INVOICE_ACCOUNT_HOLD_FINANACE_TEAM{
        get{
            return String.isNotBlank(INVOICE_ACCOUNT_HOLD_FINANACE_TEAM) ? INVOICE_ACCOUNT_HOLD_FINANACE_TEAM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Hold_Finance_Team');
        }set;
    }
    public Static String SHIPPING_MANIFEST_THEME_TWO{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_THEME_TWO) ? SHIPPING_MANIFEST_THEME_TWO: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Theme_Two');
        }set;
    }
    public Static String SHIPPING_MANIFEST_THEME_THREE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_THEME_THREE) ? SHIPPING_MANIFEST_THEME_THREE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Theme_Three');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_SEPERATOR_FOR_MAP_LOCATION{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_SEPERATOR_FOR_MAP_LOCATION) ? SHIPPING_MANIFEST_SEPERATOR_FOR_MAP_LOCATION: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Seperator_For_Location');
        }set;
    }
    
    public Static String INVOICE_RECEIVE_PAYMENT_MAP_RP{
        get{
            return String.isNotBlank(INVOICE_RECEIVE_PAYMENT_MAP_RP) ? INVOICE_RECEIVE_PAYMENT_MAP_RP: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Receive_Payment_Map_RP');
        }set;
    }
    public Static String INVOICE_RECEIVE_PAYMENT_MAP_TAX{
        get{
            return String.isNotBlank(INVOICE_RECEIVE_PAYMENT_MAP_TAX) ? INVOICE_RECEIVE_PAYMENT_MAP_TAX: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Receive_Payment_Map_Tax');
        }set;
    }
    public Static String SHIPPING_MANIFEST_EXCEPTION_ERROR_UPDATING_RSM_TSM{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_EXCEPTION_ERROR_UPDATING_RSM_TSM) ? SHIPPING_MANIFEST_EXCEPTION_ERROR_UPDATING_RSM_TSM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Exception_Error');
        }set;
    }
    
    public Static String SALES_ORDER_STATUS_APPROVED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_APPROVED) ? SALES_ORDER_STATUS_APPROVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Approved');
        }set;
    }
    
    public Static String SALES_ORDER_STATUS_SHIPPED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_SHIPPED) ? SALES_ORDER_STATUS_SHIPPED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Shipped');
        }set;
    }
    
    public Static String BRAND_QUOTE_STATUS_SHIPPED {
        get{
            return String.isNotBlank(BRAND_QUOTE_STATUS_SHIPPED) ? BRAND_QUOTE_STATUS_SHIPPED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Status_Shipped');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_LINE_NO_RSM_LINES{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_NO_RSM_LINES) ? SHIPPING_MANIFEST_LINE_NO_RSM_LINES: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_No_Rsm_Lines');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_DATE_SELECTION_TODAY{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_DATE_SELECTION_TODAY) ? SHIPPING_MANIFEST_DATE_SELECTION_TODAY: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Date_Selection_Today');
        }set;
    }
    public Static String SHIPPING_MANIFEST_DATE_SELECTION_TODAY_MINUS_ONE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_DATE_SELECTION_TODAY_MINUS_ONE) ? SHIPPING_MANIFEST_DATE_SELECTION_TODAY_MINUS_ONE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Date_Selection_Today-1');
        }set;
    }
    public Static String SHIPPING_MANIFEST_DATE_SELECTION_TODAY_MINUS_TWO{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_DATE_SELECTION_TODAY_MINUS_TWO) ? SHIPPING_MANIFEST_DATE_SELECTION_TODAY_MINUS_TWO: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Date_Selection_Today-2');
        }set;
    }
    public Static String SHIPPING_MANIFEST_DATE_SELECTION_TODAY_MINUS_THREE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_DATE_SELECTION_TODAY_MINUS_THREE) ? SHIPPING_MANIFEST_DATE_SELECTION_TODAY_MINUS_THREE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Date_Selection_Today-3');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_DATE_SELECTION_TODAY_PLUS_ONE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_DATE_SELECTION_TODAY_PLUS_ONE) ? SHIPPING_MANIFEST_DATE_SELECTION_TODAY_PLUS_ONE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Date_Selection_Today1');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_DATE_SELECTION_TODAY_PLUS_TWO{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_DATE_SELECTION_TODAY_PLUS_TWO) ? SHIPPING_MANIFEST_DATE_SELECTION_TODAY_PLUS_TWO: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Date_Selection_Today2');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_DATE_SELECTION_TODAY_PLUS_THREE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_DATE_SELECTION_TODAY_PLUS_THREE) ? SHIPPING_MANIFEST_DATE_SELECTION_TODAY_PLUS_THREE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Date_Selection_Today3');
        }set;
    }
    
    public Static String PRODUCT_RECORD_TYPE_PRODUCT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_PRODUCT) ? PRODUCT_RECORD_TYPE_PRODUCT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Name_Product');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_STRING_SELECTEDDAY{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STRING_SELECTEDDAY) ? SHIPPING_MANIFEST_STRING_SELECTEDDAY: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_String_SelectedDay');
        }set;
    }

    public static String ORDERCANCELLED_CUSTOMER{
        get{
            return String.isNotBlank(ORDERCANCELLED_CUSTOMER) ? ORDERCANCELLED_CUSTOMER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Customer');
        }set;
    }
    
  public String SEPERATOR {
        get {
            return SHIPPING_MANIFEST_SEPERATOR_FOR_MAP_LOCATION;
        }private set;
    }
    public Static String INVOICE_RECORDTYPE_SERVICE{
        get{
            return String.isNotBlank(INVOICE_RECORDTYPE_SERVICE) ? INVOICE_RECORDTYPE_SERVICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    } 
    public Static String INVOICE_RECORDTYPE_FACTORING{
        get{
            return String.isNotBlank(INVOICE_RECORDTYPE_FACTORING) ? INVOICE_RECORDTYPE_FACTORING: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Factoring');
        }set;
    } 
    public Static String INVOICE_RECORDTYPE_TAX{
        get{
            return String.isNotBlank(INVOICE_RECORDTYPE_TAX) ? INVOICE_RECORDTYPE_TAX: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Tax Protected');
        }set;
    } 

    public Static String SO_STATUS_DRAFT {		
        get{
            return String.isNotBlank(SO_STATUS_DRAFT) ? SO_STATUS_DRAFT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Draft');
        }set;
    }
    public Static String PURCHASE_ORDER_STATUS_REJECTED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_REJECTED) ? PURCHASE_ORDER_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase Order Status Rejected');
        }set;
    } 
    
    public Static String RECEIVE_PAYMENT_OPTION_SHIPCONFIRM_CONSOLE{
        get{
            return String.isNotBlank(RECEIVE_PAYMENT_OPTION_SHIPCONFIRM_CONSOLE) ? RECEIVE_PAYMENT_OPTION_SHIPCONFIRM_CONSOLE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','Receive_Payment_Option_Ship_Console');
        }set;
    }
    
   /** For Lightning declaration End **/
    
    //  Default constructor
    public RSMTSMShipConfirmCotroller() {
        selectedList = new list<RSMTSMWrapper>();
        recordTypeIds = new Set<Id>();
        displayMapResult = false;
        rsmSO = new Shipping_Manifest__c();
        tsmSO = new Shipping_Manifest__c();
        rsmSOById = new Map<Id, Shipping_Manifest__c>();
        tsmSOById = new Map<Id, Shipping_Manifest__c>();
        pendingInvoiceByAccountId = new Map<Id, List<PendingInvoiceWrapper>>();
        currentInvoiceForRSMTSM = new Map<Id, List<PendingInvoiceWrapper>>();
        isRSM = false;
        hasValidationError = false;
        errorMessage ='';
        rsmRecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        tsmRecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        recordTypeIds.add(rsmRecordTypeId);
        recordTypeIds.add(ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER));
        recordTypeIds.add(ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_LAB));
        String themeDisplayedType = UserInfo.getUIThemeDisplayed();
        if( themeDisplayedType == SHIPPING_MANIFEST_THEME_TWO || themeDisplayedType == SHIPPING_MANIFEST_THEME_THREE){
            // Get selected day - By default it is today
            selectedDay = ApexPages.currentPage().getParameters().get(SHIPPING_MANIFEST_STRING_SELECTEDDAY);
            if(String.isBlank(selectedDay)){
                selectedDay = SHIPPING_MANIFEST_DATE_SELECTION_TODAY;
            }
        }
    }
    
    public class UserException extends Exception{ }
    
    // Add all selected addresses into string
    public pageReference addAddress(){
        
        displayMapResult = true;
        selectedRSMTSMId = null;
        
        if(selectedList != null){
            
            // Set origin address as company address
            Company_Custom_Settings__c companySettings = Company_Custom_Settings__c.getOrgDefaults();
            selectedAddresses = companySettings != null ? companySettings.Route_Origin_Address__c : ''; 
            selectedAddresses += SEPERATOR;
            
            for(RSMTSMWrapper rsmtsmObj : selectedList){
                selectedAddresses += rsmtsmObj.deliveryAddress;
                selectedAddresses += SEPERATOR;
            }
            
            // Set destination address as company address
            selectedAddresses += companySettings != null ? companySettings.Route_Destination_Address__c : ''; 
            selectedAddresses += SEPERATOR;
        }
        return null;
    }
    
    // Update selected RSM/TSM
    public pageReference shipCofirmForRSMTSM(){
        if(checkValidation()){
            return null;
        }
        
        Savepoint savePoint;
        
        try{
            
            // Define Savepoint for rollback
            savePoint = Database.setSavepoint();
            
            if(selectedRSMTSMId != null){
                // Ship confirm for RSM
                if(isRSM){
                    
                    List<Shipping_Manifest_Line__c> rsmLinesToUpdate = new List<Shipping_Manifest_Line__c>();
                    List<Shipping_Manifest_Line__c> rejectedRSMLines = new List<Shipping_Manifest_Line__c>();
                    List<Shipping_Manifest_Line__c> allRSMLines = new List<Shipping_Manifest_Line__c>();
                    Boolean allSMLinesCancelled = true;
                    // Update Qty Received of SM Lines
                    for(RSMLineWrapper smLineWrapper : rsmLines){
                        smLineWrapper.rsmLineSO.Qty_Received__c = smLineWrapper.qtyToReceive;
                        smLineWrapper.rsmLineSO.Shipment_Qty__c = smLineWrapper.qtyToReceive;
                        smLineWrapper.rsmLineSO.Rejection_Reason__c = smLineWrapper.rsmLineSO.Rejection_Reason__c;
                        smLineWrapper.rsmLineSO.SMLine_Status__c = SHIPPING_MANIFEST_STATUS_COMPLETE;
                        if(smLineWrapper.qtyToReceive == 0.0 || smLineWrapper.qtyToReceive == null){
                            smLineWrapper.rsmLineSO.SMLine_Status__c = SHIPPING_MANIFEST_LINE_STATUS_REJECTED;
                        }else{
                            allSMLinesCancelled = false;
                        }
                        allRSMLines.add(smLineWrapper.rsmLineSO);
                    }
                    
                    if(allRSMLines.size() > 0){
                        
                        update allRSMLines;
                        rsmSO.Ship_Confirmation_Date__c = System.Today();
                        update rsmSO;
                        
                        // Update RSM Lines for ship confirm - Line Items having non zero qty to receive
                        for(Shipping_Manifest_Line__c rsmLineSO : allRSMLines){
                            if(rsmLineSO.Shipment_Qty__c != 0.0 && rsmLineSO.SMLine_Status__c != SHIPPING_MANIFEST_STATUS_CANCELLED){ rsmLinesToUpdate.add(rsmLineSO);
                               }
                        }
                        
                        List<Inventory_Position__c> invPositions = new List<Inventory_Position__c>();
                        
                        if(rsmSO.RecordTypeId == ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER)){ invPositions = ShipConfirmController.setInvPositionToDelivered(rsmLinesToUpdate,SHIPPING_MANIFEST_RECORDTYPE_TRANSFFERED);
                            // Update inventory position to update with Transfer
                            
                        }else if(rsmSO.RecordTypeId == ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_LAB)){  invPositions = ShipConfirmController.setInvPositionToDelivered(rsmLinesToUpdate,SHIPPING_MANIFEST_RECORDTYPE_TEST_SAMPLED);
                            // Update inventory position to update with Transfer
                            
                        }else{
                            // Update inventory position to update with Delivered
                            invPositions = 
                                ShipConfirmController.setInvPositionToDelivered(rsmLinesToUpdate, SHIPPING_MANIFEST_RECORDTYPE_DELIVERED);
                        }
                        upsert invPositions;
                        
                        // Update inventory positions and SO lines related to RSM lines
                        RSMSupport.updateInvPositionsAndSOLines(allRSMLines, allSMLinesCancelled);
                    }
                    
                    // Remove ship confirmed RSM
                    if(selectedList != null){
                        for(Integer i=0; i<selectedList.size(); i++){
                            if(selectedList[i].isRSM && selectedList[i].Id == rsmSO.Id){
                                selectedList.remove(i);
                            }
                        }
                    }
                    // Ship confirm for TSM
                }else{
                    tsmSO.Status__c = SHIPPING_MANIFEST_STATUS_RECEIVED;
                    update tsmSO;  if(selectedList != null){for(Integer i=0; i<selectedList.size(); i++){ if(!selectedList[i].isRSM && selectedList[i].Id == tsmSO.Id){   selectedList.remove(i);
                            }
                        }
                    }
                   
                }
                
                // Create receive payment record related to pending invoices
                List<PendingInvoiceWrapper> allInvoices = new List<PendingInvoiceWrapper>();
                List<PendingInvoiceWrapper> pendingInvoices;
                List<PendingInvoiceWrapper> currentInvoices;
                
                // Get all pending invoices related to RSM/TSM
                if(accountIdOfSelectedRSMTSM != null) {
                    pendingInvoices = pendingInvoiceByAccountId.get(accountIdOfSelectedRSMTSM);
                }
                
                // Get all current invoices related to RSM/TSM
                if(SOorPOIdOfSelectedRSMTSM != null) { currentInvoices = currentInvoiceForRSMTSM.get(SOorPOIdOfSelectedRSMTSM);
                }
                
                // Add all pending invoices to validate
                if(pendingInvoices != null){
                    allInvoices.addAll(pendingInvoices);
                }
                
                // Add all current invoices to validate
                if(currentInvoices != null){ allInvoices.addAll(currentInvoices);
                }
                
                if(!allInvoices.isEmpty()){
                    
                    List<Receive_Payment__c> receivePayments = new List<Receive_Payment__c>();
                    Map<String,Receive_Payment__c> invoiceRPMap = new Map<String,Receive_Payment__c>();
                    for(PendingInvoiceWrapper invoiceObj : allInvoices){
                        if(invoiceObj.receivePaymentSO.Payment_Form__c != null){
                            
                            // Make entry for product record type
                            if(invoiceObj.productAmount != null && invoiceObj.productAmount != 0.0){
                                invoiceObj.receivePaymentSO.Payment_Amount__c = invoiceObj.productAmount;
                                invoiceObj.receivePaymentSO.RecordTypeId = 
                                    Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get(PRODUCT_RECORD_TYPE_PRODUCT).getRecordTypeId();
                                receivePayments.add(invoiceObj.receivePaymentSO);
                                invoiceRPMap.put(invoiceObj.invoiceSO.Id+INVOICE_RECEIVE_PAYMENT_MAP_RP,invoiceObj.receivePaymentSO);
                            }
                            
                            // Make entry for excise tax record type
                            if(invoiceObj.taxAmount != null && invoiceObj.taxAmount != 0.0){
                                Receive_Payment__c clonedReceivePaymentSO = invoiceObj.receivePaymentSO.clone(false, true);
                                clonedReceivePaymentSO.Payment_Amount__c = invoiceObj.taxAmount;
                                clonedReceivePaymentSO.RecordTypeId = 
                                    Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECEIVE_PAYMENT_RECORDTYPE_EXCISE_TAX).getRecordTypeId();
                                receivePayments.add(clonedReceivePaymentSO);
                                invoiceRPMap.put(invoiceObj.invoiceSO.Id+INVOICE_RECEIVE_PAYMENT_MAP_TAX,clonedReceivePaymentSO);
                            }
                        }
                    }
                    if(invoiceRPMap.size() > 0){
                        insert invoiceRPMap.values();
                    }
                    
                }
                selectedRSMTSMId = null;
            }
        }catch(Exception ex){
            
            Database.rollback(savePoint);
            
            ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.ERROR, SHIPPING_MANIFEST_EXCEPTION_ERROR_UPDATING_RSM_TSM + ex.getMessage());
            ApexPages.addMessage(message);
            showRSMInfoErrorMessage = true;
        }
        resetRSMLines();
        return null;
    }
    
    /**
    * Depart confirm action for selected RSM/TSMs
    */
    public void departConfirmAction() {
        List<Shipping_Manifest__c> rsmsToDepart = new List<Shipping_Manifest__c>();
        List<Shipping_Manifest__c> tsmsToDepart = new List<Shipping_Manifest__c>();
        
        // Store initial value of arrival time and receiver acceptance date of RSM and TSM
        // They should not be updated on depart confirm action
        Map<Id, DateTime> rsmArrivalTime = new Map<Id, DateTime>();
        Map<Id, DateTime> rsmReceiverAcceptance = new Map<Id, DateTime>();
        Map<Id, DateTime> tsmArrivalTime = new Map<Id, DateTime>();
        Map<Id, DateTime> tsmReceiverAcceptance = new Map<Id, DateTime>();
        
        for(RSMTSMWrapper rsmtsmObj : selectedList){
            if(rsmtsmObj.departConfirmSelection){
                
                rsmtsmObj.actualDepartureDateTime = System.now();
                
                // Add selected RSMs into RSM list
                if(rsmtsmObj.isRSM && rsmSOById.containsKey(rsmtsmObj.Id)){
                    
                    // Store initial value of RSM arrival time and receiver acceptance date
                    Shipping_Manifest__c tempRSM = rsmSOById.get(rsmtsmObj.Id);
                    Shipping_Manifest__c sm = [select id,Purchase_Order__c,Purchase_Order__r.Supplier_Name__r.Hold__c ,Purchase_Order__r.Receiver_Name__r.Hold__c,Purchase_Order__r.Distributor_Name__r.Hold__c,Purchase_Order__r.Supplier_Name__r.DBA__c ,Purchase_Order__r.Receiver_Name__r.DBA__c,Purchase_Order__r.Distributor_Name__r.DBA__c ,Picklist__c,Invoice__c,Payment_Terms__c from  Shipping_Manifest__c where id  =: tempRSM.Id];
                    if(sm.Picklist__c != null){
                        
                        picklist__c pick = [select id ,Sales_Order__c from  picklist__c where id  =: sm.Picklist__c];
                        Sales_Order__c SOHold = [select id,Supplier_Name__c ,Receiver_Name__c,Distributor_Name__c,Account_Hold_Exception__c, (select id, Sales_Order__c from picklists__r)  from Sales_Order__c where id =: pick.Sales_Order__c];  
                        
                        Account  supAcc = [SELECT  id , Hold__c,DBA__c  from Account  where id =:SOHold.Supplier_Name__c];
                        Account  recAcc = [SELECT  id , Hold__c,DBA__c  from Account  where id =:SOHold.Receiver_Name__c];
                        Account  disAcc = [SELECT  id , Hold__c,DBA__c  from Account  where id =:SOHold.Distributor_Name__c];
                        
                        String accountName = '';
                        Set<String> my_list = new Set<String>();
                        if((supAcc.Hold__c == true || recAcc.Hold__c == true || disAcc.Hold__c == true) && SOHold.Account_Hold_Exception__c == false)
                        {
                            if(supAcc.Hold__c == true){
                                my_list.add(supAcc.DBA__c);
                            }
                            if(disAcc.Hold__c == true){
                                my_list.add(disAcc.DBA__c);
                            }
                            if(recAcc.Hold__c == true){
                                my_list.add(recAcc.DBA__c);
                            }
                            accountName = String.join(new List<String>(my_list), ', ');    
                            errorMessage = INVOICE_ERROR_ACCOUNT_HOLD + accountName + INVOICE_ACCOUNT_HOLD_FINANACE_TEAM;
                            hasValidationError = true;
                        } 
                    }else if(sm.Purchase_Order__c != null){
                        List<String> holdAccounts = new List<String>();
                        if(sm.Purchase_Order__r.Supplier_Name__r.Hold__c == true || sm.Purchase_Order__r.Receiver_Name__r.Hold__c == true || sm.Purchase_Order__r.Distributor_Name__r.Hold__c == true){
                            if(sm.Purchase_Order__r.Supplier_Name__r.Hold__c == true){
                                holdAccounts.add(sm.Purchase_Order__r.Supplier_Name__r.DBA__c);
                            }
                            if(sm.Purchase_Order__r.Receiver_Name__r.Hold__c == true){
                                holdAccounts.add(sm.Purchase_Order__r.Receiver_Name__r.DBA__c);
                            }
                            if(sm.Purchase_Order__r.Distributor_Name__r.Hold__c == true){
                                holdAccounts.add(sm.Purchase_Order__r.Distributor_Name__r.DBA__c);
                            }
                            String accountNames = String.join(new List<String>(holdAccounts), ', '); 
                            errorMessage =INVOICE_ERROR_ACCOUNT_HOLD + accountNames + INVOICE_ACCOUNT_HOLD_FINANACE_TEAM;
                            hasValidationError = true;    
                        }
                    }
                    if(!hasValidationError){
                        rsmArrivalTime.put(tempRSM.Id, tempRSM.Actual_Arrival_Date_Time__c);
                        rsmReceiverAcceptance.put(tempRSM.Id, tempRSM.Receiver_Acceptance_Date__c);
                        
                        // Reset it to null so that they won't be updated in depart confirm
                        tempRSM.Actual_Arrival_Date_Time__c = null;
                        tempRSM.Receiver_Acceptance_Date__c = null;
                        rsmsToDepart.add(tempRSM);
                    }
                    // Add selected TSMs into TSM list
                }else if(!rsmtsmObj.isRSM && tsmSOById.containsKey(rsmtsmObj.Id)){
                    
                    // Store initial value of TSM arrival time and receiver acceptance date
                    Shipping_Manifest__c tempTSM = tsmSOById.get(rsmtsmObj.Id);
                    Shipping_Manifest__c sm = [select id,Purchase_Order__c,Purchase_Order__r.Supplier_Name__r.Hold__c ,Purchase_Order__r.Receiver_Name__r.Hold__c,Purchase_Order__r.Distributor_Name__r.Hold__c,Purchase_Order__r.Supplier_Name__r.DBA__c ,Purchase_Order__r.Receiver_Name__r.DBA__c,Purchase_Order__r.Distributor_Name__r.DBA__c ,Picklist__c,Invoice__c,Payment_Terms__c from  Shipping_Manifest__c where id  =: tempTSM.Id];
                    
                    if(sm.Picklist__c != null){  picklist__c pick = [select id ,Sales_Order__c from  picklist__c where id  =: sm.Picklist__c];
                        Sales_Order__c SOHold = [select id,Supplier_Name__c ,Receiver_Name__c,Distributor_Name__c,Account_Hold_Exception__c, (select id, Sales_Order__c from picklists__r)  from Sales_Order__c where id =: pick.Sales_Order__c];  
                        
                        Account  supAcc = [SELECT  id , Hold__c  from Account  where id =:SOHold.Supplier_Name__c];
                        Account  recAcc = [SELECT  id , Hold__c  from Account  where id =:SOHold.Receiver_Name__c];
                        Account  disAcc = [SELECT  id , Hold__c  from Account  where id =:SOHold.Distributor_Name__c];
                        
                        String accountName = '';
                        Set<String> my_list = new Set<String>();
                        if((supAcc.Hold__c == true || recAcc.Hold__c == true || disAcc.Hold__c == true) && SOHold.Account_Hold_Exception__c == false)
                        { 
                            if(supAcc.Hold__c == true){ my_list.add(supAcc.DBA__c);}
                            if(disAcc.Hold__c == true){ my_list.add(disAcc.DBA__c);  }
                            if(recAcc.Hold__c == true){  my_list.add(recAcc.DBA__c); }
                            accountName = String.join(new List<String>(my_list), ', ');   
                            errorMessage = INVOICE_ERROR_ACCOUNT_HOLD + accountName + INVOICE_ACCOUNT_HOLD_FINANACE_TEAM;
                            hasValidationError = true;
                            
                        } 
                    }else if(sm.Purchase_Order__c != null){  List<String> holdAccounts = new List<String>();
                        if(sm.Purchase_Order__r.Supplier_Name__r.Hold__c == true || sm.Purchase_Order__r.Receiver_Name__r.Hold__c == true || sm.Purchase_Order__r.Distributor_Name__r.Hold__c == true){
                            if(sm.Purchase_Order__r.Supplier_Name__r.Hold__c == true){  holdAccounts.add(sm.Purchase_Order__r.Supplier_Name__r.DBA__c);
                            }
                            if(sm.Purchase_Order__r.Receiver_Name__r.Hold__c == true){ holdAccounts.add(sm.Purchase_Order__r.Receiver_Name__r.DBA__c); }
                            if(sm.Purchase_Order__r.Distributor_Name__r.Hold__c == true){  holdAccounts.add(sm.Purchase_Order__r.Distributor_Name__r.DBA__c);
                            }
                            String accountNames = String.join(new List<String>(holdAccounts), ', '); 
                            errorMessage =INVOICE_ERROR_ACCOUNT_HOLD + accountNames + INVOICE_ACCOUNT_HOLD_FINANACE_TEAM;
                            hasValidationError = true;    
                        }
                    }
                    if(!hasValidationError){ tsmArrivalTime.put(tempTSM.Id, tempTSM.Actual_Arrival_Date_Time__c);
                        tsmReceiverAcceptance.put(tempTSM.Id, tempTSM.Receiver_Acceptance_Date__c);
                        
                        // Reset it to null so that they won't be updated in depart confirm
                        tempTSM.Actual_Arrival_Date_Time__c = null;
                        tempTSM.Receiver_Acceptance_Date__c = null;
                        tsmsToDepart.add(tempTSM);
                    }
                }
                
            }
        }
        
        // Depart confirm of TSMs
        if(tsmsToDepart.size() > 0){ tsmsToDepart = TSMSupport.departConfirmTSMs(tsmsToDepart); update tsmsToDepart;
                                   }  
        
        // Depart confirm of RSMs
        if(rsmsToDepart.size() > 0){
            RSMSupport.departConfirmRSMs(rsmsToDepart);
        }
        displayDepartConfirm = false;
        // Restore arrival time and receiver acceptance date value of RSMs and TSMs
        for(RSMTSMWrapper rsmtsmObj : selectedList){
            
            Shipping_Manifest__c tempRSMNew = rsmSOById.get(rsmtsmObj.Id);
            
            if(tempRSMNew != null){
                rsmtsmObj.cannotShipConfirm = tempRSMNew.Status__c == SHIPPING_MANIFEST_STATUS_INTRANSIT? false : true; 
            }
            Shipping_Manifest__c tempTSMNew = tsmSOById.get(rsmtsmObj.Id);
            
            if(tempTSMNew != null){rsmtsmObj.cannotShipConfirm = tempTSMNew.Status__c == SHIPPING_MANIFEST_STATUS_INTRANSIT ? false : true; 
                                  }
            // Restore RSM value
            if(rsmArrivalTime.containsKey(rsmtsmObj.Id)){
                
                Shipping_Manifest__c tempRSM = rsmSOById.get(rsmtsmObj.Id);
                tempRSM.Actual_Arrival_Date_Time__c = rsmArrivalTime.get(rsmtsmObj.Id);
                tempRSM.Receiver_Acceptance_Date__c = rsmReceiverAcceptance.get(rsmtsmObj.Id);
                
                // Restore TSM value
            }else if(tsmArrivalTime.containsKey(rsmtsmObj.Id)){ Shipping_Manifest__c tempTSM = tsmSOById.get(rsmtsmObj.Id);  tempTSM.Actual_Arrival_Date_Time__c = tsmArrivalTime.get(rsmtsmObj.Id); tempTSM.Receiver_Acceptance_Date__c = tsmReceiverAcceptance.get(rsmtsmObj.Id);
                                                              }
        }
    }
    
    /**
    * Display Depart confirm button if any RSM/TSM selected for depart Confirm checkbox
    */
    public void displayDepartConfirmButton() {
        displayDepartConfirm = false;
        for(Integer i=0; i<selectedList.size(); i++){
            if(selectedList[i].departConfirmSelection){
                displayDepartConfirm = true;
                break;
            }
        }
    }
    
    /**
    * Retrieve all RSM/TSMs
    */
    public PageReference retrieveRSMTSMs() {
        String STATUS_CANCELLED = SHIPPING_MANIFEST_STATUS_CANCELLED;
        String STATUS_SHIPMENT_COMPLETE = SHIPPING_MANIFEST_STATUS_COMPLETE;
        String STATUS_REJECTED = SHIPPING_MANIFEST_STATUS_REJECTED;
        try{
            selectedList = new List<RSMTSMWrapper>();
            Map<Id, Integer> pendingInvoiceCountByAccountId = new Map<Id, Integer>();
            Map<Id, Boolean> isRSMByAccountId = new Map<Id, Boolean>();
            displayMapResult = false;
            Boolean isMasterGroupMember = false;
            Date selectedDate = getSelectedDate(selectedDay);
            Company_Custom_Settings__c companySettings = Company_Custom_Settings__c.getOrgDefaults();
            if(companySettings != null && String.isNotBlank(companySettings.Ship_Confirm_Master_User_Group__c)){
                for(Group g: [SELECT Id, Name,(SELECT Id, UserOrGroupId FROM GroupMembers) FROM Group WHERE Name = :companySettings.Ship_Confirm_Master_User_Group__c]){
                    if(!g.GroupMembers.isEmpty()){
                        for(GroupMember GM: g.GroupMembers){
                            if(UserInfo.getUserId() == GM.UserOrGroupId){ isMasterGroupMember = true;
                                break;
                            }
                        }
                    }
                }
            }
            
            
            // Add TSMs
            String driverName = UserInfo.getName();
            String query = 'Select Name,Payment_Terms__c,'
                +'Supplier_Name__r.Name,Supplier_Name__r.dBA__c,Supplier_Phone__c,Order_Number__c, Order_Number__r.Name, '
                +'Supplier_Email__c,Supplier_Address__c,Supplier_City_State_Zip__c,'
                +'Driver__c,Driver__r.Name,Priority__c,Window_Start_End__c,Vehicle__c,Metrc_Manifest__c,'
                +'Vehicle__r.Name,Box_Count__c,Supplier_Contact__c,Supplier_Contact__r.Name,'
                +'Planned_Ship_Transfer_Date__c,Actual_Arrival_Date_Time__c,Actual_Departure_Date_Time__c,'
                +'Supplier_License__r.License_City__c,Purchase_Order__r.Name,Status__c,Total_Price__c,'
                +'Receiver_Acceptance_Date__c,Sales_Order__c,Sales_Order__r.Name,Purchase_Order__c,'
                +'(Select Picklist_Line__r.Inventory_Position__c,Unit_Cost__c ,'
                +'Picklist_Line__r.Inventory_Position__r.Site__c,Qty_Ordered__c ,'
                +'Name,SMLine_Status__c,Rejection_Reason__c,Product_Name__c,'
                +'Producer_Name__c,Product_Description__c,Retail_Wholesale_Price__c,'
                +'Shipment_Qty__c,Qty_Received__c,Line_Total_Price__c,'
                +'Picklist_Line__c,Picklist_Line__r.Sales_Order_Line__r.Sales_Order__c,'
                +'Picklist_Line__r.Sales_Order_Line__c,Sales_Order_Line__c,'
                +'Picklist_Line__r.Pack_out_UID__c'
                +' From Shipping_Manifest_Lines__r'
                +' Where SMLine_Status__c NOT IN (:SHIPPING_MANIFEST_LINE_STATUS_CANCELLED,:SHIPPING_MANIFEST_LINE_STATUS_REJECTED)'
                +' ORDER By Name)'
                +' From Shipping_Manifest__c '
                +' Where Planned_Ship_Transfer_Date__c =: selectedDate '
                +' AND RecordTypeId =: tsmRecordTypeId '
                +(!isMasterGroupMember?' AND Driver__r.Name =: driverName ':'')
                +' AND Actual_Arrival_Date_Time__c = null '
                +' AND Receiver_Acceptance_Date__c = null'
                +' AND (Picklist__c = NULL OR Picklist__r.Status__c = :PICKLIST_STATUS_QACONFIRM)'
                +' ORDER By Id';
            
            for(Shipping_Manifest__c tsmObj : (Shipping_Manifest__c[])Database.query(query)){
                
                RSMTSMWrapper rsmtsmObj = new RSMTSMWrapper();
                rsmtsmObj.Id = tsmObj.Id;
                rsmtsmObj.Name = tsmObj.Name;
                rsmtsmObj.receiverPhone = tsmObj.Supplier_Phone__c;
                rsmtsmObj.receiverEmail = tsmObj.Supplier_Email__c;
                rsmtsmObj.deliveryAddress = tsmObj.Supplier_Address__c + ' ' + tsmObj.Supplier_City_State_Zip__c;
                rsmtsmObj.deliveryCity = tsmObj.Supplier_License__r.License_City__c != null ? tsmObj.Supplier_License__r.License_City__c : '';
                rsmtsmObj.accountName = tsmObj.Supplier_Name__r.dBA__c;
                rsmtsmObj.accountId = tsmObj.Supplier_Name__c;
                rsmtsmObj.driverId = tsmObj.Driver__c;
                rsmtsmObj.driverName = tsmObj.Driver__r.Name;
                rsmtsmObj.vehicleId = tsmObj.Vehicle__c;
                rsmtsmObj.priority = tsmObj.Priority__c;
                rsmtsmObj.windowStartEnd = tsmObj.Window_Start_End__c;
                rsmtsmObj.manifest = tsmObj.Metrc_Manifest__c;
                rsmtsmObj.boxCount = tsmObj.Box_Count__c;
                rsmtsmObj.vehicleName = tsmObj.Vehicle__r.Name;
                rsmtsmObj.receiverContactId = tsmObj.Supplier_Contact__c;
                rsmtsmObj.receiverContactName = tsmObj.Supplier_Contact__r.Name;
                rsmtsmObj.totalLineItems = tsmObj.Shipping_Manifest_Lines__r.size();
                rsmtsmObj.plannedShipTransferDate = tsmObj.Planned_Ship_Transfer_Date__c;
                rsmtsmObj.actualArrivalDateTime = tsmObj.Actual_Arrival_Date_Time__c;
                rsmtsmObj.actualDepartureDateTime = tsmObj.Actual_Departure_Date_Time__c;
                rsmtsmObj.receiverAcceptanceDate = tsmObj.Receiver_Acceptance_Date__c;
                rsmtsmObj.isRSM = false;
                rsmtsmObj.poNumber = tsmObj.Purchase_Order__r.Name;
                rsmtsmObj.paymentTerms = tsmObj.Payment_Terms__c;
                rsmtsmObj.cannotShipConfirm = tsmObj.Status__c == SHIPPING_MANIFEST_STATUS_INTRANSIT ? false : true;
                selectedList.add(rsmtsmObj);
                tsmSOById.put(tsmObj.Id, tsmObj);
                pendingInvoiceCountByAccountId.put(tsmObj.Supplier_Name__c, 0);
                isRSMByAccountId.put(tsmObj.Supplier_Name__c, false);
                
                if(tsmObj.Purchase_Order__c != null){currentInvoiceForRSMTSM.put(tsmObj.Purchase_Order__c, new List<PendingInvoiceWrapper>());
                    
                }
            }
            
            // Add RSMs 
            String query2 = 'Select Name,Payment_Terms__c,'
                +'Receiver_Name__r.Name,Receiver_Name__r.dBA__c,Receiver_Name__c,Order_Number__c, Order_Number__r.Name,'
                +'Receiver_Phone__c,Receiver_Email__c,Receiver_Address__c,'
                +'Receiver_City_State_Zip__c,Priority__c,Driver__c,Driver__r.Name,Window_Start_End__c,'
                +'Vehicle__c,Metrc_Manifest__c,Vehicle__r.Name,Receiver_Contact__c,'
                +'Receiver_Contact__r.Name,Planned_Ship_Transfer_Date__c,'
                +'Actual_Arrival_Date_Time__c,Actual_Departure_Date_Time__c,Receiver_Acceptance_Date__c,'
                +'Receiver_License__r.License_City__c,Customer_PO_or_Quote__c,'
                +'Status__c,Box_Count__c,Ship_Confirmation_Date__c,Picklist__c,Sales_Order__r.Name,'
                +'Sales_Order__c,Total_Price__c,'
                +'(Select Picklist_Line__r.Inventory_Position__c,'
                +'Picklist_Line__r.Inventory_Position__r.Site__c,'
                +'Name,SMLine_Status__c,Rejection_Reason__c,Product_Name__c,'
                +'Producer_Name__c,Product_Description__c,Retail_Wholesale_Price__c,'
                +'Shipment_Qty__c,Qty_Received__c,Line_Total_Price__c,'
                +'Picklist_Line__c,Picklist_Line__r.Sales_Order_Line__r.Sales_Order__c,'
                +'Picklist_Line__r.Sales_Order_Line__c,Sales_Order_Line__c,'
                +'Picklist_Line__r.Pack_out_UID__c'
                +' From Shipping_Manifest_Lines__r'
                +' Where SMLine_Status__c NOT IN (:SHIPPING_MANIFEST_LINE_STATUS_CANCELLED,:SHIPPING_MANIFEST_LINE_STATUS_REJECTED)'
                +' ORDER By Name)'
                +' From Shipping_Manifest__c '
                +' Where Status__c NOT IN (:SHIPPING_MANIFEST_STATUS_CANCELLED,:SHIPPING_MANIFEST_STATUS_COMPLETE)'
                +' AND RecordTypeId IN :recordTypeIds'
                +' AND Planned_Ship_Transfer_Date__c =: selectedDate'
                +(!isMasterGroupMember?' AND Driver__r.Name =: driverName ':'')
                +' AND Actual_Arrival_Date_Time__c = null '
                +' AND Receiver_Acceptance_Date__c = null'
                +' AND Picklist__r.Status__c =:PICKLIST_STATUS_QACONFIRM'
                +' ORDER By Id';
            
            for(Shipping_Manifest__c rsmObj : (Shipping_Manifest__c[]) Database.query(query2)){
                
                RSMTSMWrapper rsmtsmObj = new RSMTSMWrapper();
                rsmtsmObj.Id = rsmObj.Id;
                rsmtsmObj.Name = rsmObj.Name;
                rsmtsmObj.receiverPhone = rsmObj.Receiver_Phone__c;
                rsmtsmObj.receiverEmail = rsmObj.Receiver_Email__c;
                rsmtsmObj.deliveryAddress = rsmObj.Receiver_Address__c + ' ' + rsmObj.Receiver_City_State_Zip__c;
                rsmtsmObj.deliveryCity = rsmObj.Receiver_License__r.License_City__c != null ? rsmObj.Receiver_License__r.License_City__c : '';
                rsmtsmObj.accountName = rsmObj.Receiver_Name__r.dBA__c;
                rsmtsmObj.accountId = rsmObj.Receiver_Name__c;
                rsmtsmObj.driverId = rsmObj.Driver__c;
                rsmtsmObj.driverName = rsmObj.Driver__r.Name;
                rsmtsmObj.vehicleId = rsmObj.Vehicle__c;
                rsmtsmObj.priority = rsmObj.Priority__c;
                rsmtsmObj.windowStartEnd = rsmObj.Window_Start_End__c;
                rsmtsmObj.boxCount = rsmObj.Box_Count__c;
                rsmtsmObj.manifest = rsmObj.Metrc_Manifest__c;
                rsmtsmObj.vehicleName = rsmObj.Vehicle__r.Name;
                rsmtsmObj.receiverContactId = rsmObj.Receiver_Contact__c;
                rsmtsmObj.receiverContactName = rsmObj.Receiver_Contact__r.Name;
                rsmtsmObj.totalLineItems = rsmObj.Shipping_Manifest_Lines__r.size();
                rsmtsmObj.plannedShipTransferDate = rsmObj.Planned_Ship_Transfer_Date__c;
                rsmtsmObj.actualArrivalDateTime = rsmObj.Actual_Arrival_Date_Time__c;
                rsmtsmObj.actualDepartureDateTime = rsmObj.Actual_Departure_Date_Time__c;
                rsmtsmObj.receiverAcceptanceDate = rsmObj.Receiver_Acceptance_Date__c;
                rsmtsmObj.isRSM = true;
                rsmtsmObj.poNumber = rsmObj.Customer_PO_or_Quote__c;
                rsmtsmObj.paymentTerms = rsmObj.Payment_Terms__c;
                rsmtsmObj.soId = rsmObj.Sales_Order__c;
                rsmtsmObj.soName = rsmObj.Sales_Order__r.Name;
                rsmtsmObj.orderid = rsmObj.Order_Number__c;
                rsmtsmObj.ordername = (rsmObj.Order_Number__c != null ?rsmObj.Order_Number__r.Name:'');
                rsmtsmObj.cannotShipConfirm = rsmObj.Status__c == SHIPPING_MANIFEST_STATUS_INTRANSIT ? false : true;
                selectedList.add(rsmtsmObj);
                rsmSOById.put(rsmObj.Id, rsmObj);
                pendingInvoiceCountByAccountId.put(rsmObj.Receiver_Name__c, 0);
                isRSMByAccountId.put(rsmObj.Receiver_Name__c, true);
                
                if(rsmObj.Sales_Order__c != null){
                    currentInvoiceForRSMTSM.put(rsmObj.Sales_Order__c, new List<PendingInvoiceWrapper>());
                }
            }
            
            // Add current invoice for RSM/TSM
            List<PendingInvoiceWrapper> currentInvoiceList;
            for(Invoice__c invoice : [Select Id, Name, Purchase_Order__c, Excise_Tax_Balance__c,Invoice_Due_Date__c,
                                      Sales_Order__c, Invoice_Balance__c, Product_Balance__c From Invoice__c
                                      Where (Sales_Order__c IN: currentInvoiceForRSMTSM.keySet()
                                             OR Purchase_Order__c IN: currentInvoiceForRSMTSM.keySet())
                                      AND AR_Status__c IN (:SALES_ORDER_STATUS_APPROVED,:SALES_ORDER_STATUS_SHIPPED)
                                      AND Invoice_Balance__c > 0.0 ORDER BY Name]){
                                          
                                          PendingInvoiceWrapper pendingInvoiceObj = new PendingInvoiceWrapper();
                                          pendingInvoiceObj.invoiceSO = invoice;
                                          pendingInvoiceObj.receivePaymentSO = new Receive_Payment__c();
                                          pendingInvoiceObj.receivePaymentSO.Payment_Received_Date__c = System.Today();
                                          pendingInvoiceObj.invoiceSO.Invoice_Due_Date__c = System.Today();
                                          pendingInvoiceObj.receivePaymentSO.Invoice__c = invoice.Id;
                                          pendingInvoiceObj.isCurrentRSMTSM = true;
                                          
                                          currentInvoiceList = null;
                                          
                                          // Set invoice related to current TSM
                                          if(invoice.Purchase_Order__c != null){ currentInvoiceList = currentInvoiceForRSMTSM.get(invoice.Purchase_Order__c);
                                                                                if(currentInvoiceList == null) { currentInvoiceList = new List<PendingInvoiceWrapper>(); currentInvoiceForRSMTSM.put(invoice.Purchase_Order__c, currentInvoiceList);
                                                                                } currentInvoiceList.add(pendingInvoiceObj);
                                                                               
                                                                                
                                                                                // Set invoice related to current RSM
                                                                               }else if(invoice.Sales_Order__c != null){ 
                                                                                   currentInvoiceList = currentInvoiceForRSMTSM.get(invoice.Sales_Order__c);
                                                                                   
                                                                                   if(currentInvoiceList == null) { currentInvoiceList = new List<PendingInvoiceWrapper>(); currentInvoiceForRSMTSM.put(invoice.Sales_Order__c, currentInvoiceList);
                                                                                                                   
                                                                                                                  }
                                                                                   currentInvoiceList.add(pendingInvoiceObj);
                                                                               }
                                      }
          
            // Get pending invoices from account
            for(Account acc : [Select Id, (Select Id, Name, Invoice_Balance__c, Excise_Tax_Balance__c,Invoice_Due_Date__c, 
                                           Purchase_Order__c, Sales_Order__c, Product_Balance__c From Invoices1__r
                                           Where AR_Status__c IN (:SALES_ORDER_STATUS_APPROVED, :SALES_ORDER_STATUS_SHIPPED) AND
                                           Invoice_Balance__c > 0.0 ORDER BY Name),
                               (Select Id, Name, Invoice_Balance__c, Excise_Tax_Balance__c,
                                Purchase_Order__c, Sales_Order__c, Product_Balance__c,Invoice_Due_Date__c From Invoices2__r
                                Where AR_Status__c IN (:SALES_ORDER_STATUS_APPROVED, :SALES_ORDER_STATUS_SHIPPED) AND
                                Invoice_Balance__c > 0.0 ORDER BY Name)
                               From Account 
                               Where Id IN: pendingInvoiceCountByAccountId.keySet()]){
                                   
                                   List<PendingInvoiceWrapper> pendingInvoiceList = new List<PendingInvoiceWrapper>();
                                   
                                   // If account id is associated with RSM (Receiver name) then get related invoices from Invoices2__r list
                                   // child relationship name of receiver name of invoice
                                   if(isRSMByAccountId.get(acc.Id)){
                                       Integer invoices2Count = 0;
                                       for(Invoice__c inv:acc.Invoices2__r){
                                           invoices2Count++;
                                       }
                                       pendingInvoiceCountByAccountId.put(acc.Id, invoices2Count);
                                       
                                       for(Invoice__c invoice : acc.Invoices2__r){ 
                                           // Child records of Receiver name account of invoice 
                                           // Make sure current invoice should not be a part of pending invoice list
                                           if(!currentInvoiceForRSMTSM.containsKey(invoice.Sales_Order__c)){
                                               PendingInvoiceWrapper pendingInvoiceObj = new PendingInvoiceWrapper();
                                               pendingInvoiceObj.invoiceSO = invoice;
                                               pendingInvoiceObj.receivePaymentSO = new Receive_Payment__c();
                                               pendingInvoiceObj.receivePaymentSO.Payment_Received_Date__c = System.Today();
                                               pendingInvoiceObj.receivePaymentSO.Invoice__c = invoice.Id;
                                               pendingInvoiceList.add(pendingInvoiceObj);
                                           }
                                       }
                                       pendingInvoiceByAccountId.put(acc.Id, pendingInvoiceList);
                                       
                                       // If account id is associated with TSM (Supplier name) then get related invoices from Invoices1__r list
                                       // child relationship name of supplier name of invoice
                                   }else{
                                       pendingInvoiceCountByAccountId.put(acc.Id, acc.Invoices1__r.size());
                                         // Child records of Supplier name account of invoice
                                           // Make sure current invoice should not be a part of pending invoice list
                                       for(Invoice__c invoice : acc.Invoices1__r){ if(!currentInvoiceForRSMTSM.containsKey(invoice.Purchase_Order__c)){PendingInvoiceWrapper pendingInvoiceObj = new PendingInvoiceWrapper(); pendingInvoiceObj.invoiceSO = invoice; pendingInvoiceObj.receivePaymentSO = new Receive_Payment__c(); pendingInvoiceObj.receivePaymentSO.Payment_Received_Date__c = System.Today();
                                               pendingInvoiceObj.receivePaymentSO.Invoice__c = invoice.Id;   pendingInvoiceList.add(pendingInvoiceObj);
                                             
                                           }
                                       }
                                       pendingInvoiceByAccountId.put(acc.Id, pendingInvoiceList);
                                   }
                               }
            
            // Set pending invoice count for RSM/TSM
            for(RSMTSMWrapper rsmtsm : selectedList){
                if(pendingInvoiceCountByAccountId.containsKey(rsmtsm.accountId)){
                    rsmtsm.pendingInvoices = pendingInvoiceCountByAccountId.get(rsmtsm.accountId);
                }
            }
            
            addAddress(); } catch(Exception e){
        
            System.debug('##Exeption::'+e.getCause());
            System.debug('##Exeption::'+e.getLineNumber());
            System.debug('##Exeption::'+e.getMessage());
        }
        return null;
    }
    
    /**
    * Reset RSM lines variables
    */
    public void resetRSMLines(){
        displayRSMLines = false;
        rsmLines = new List<RSMLineWrapper>();
        rsmLineCount = 0;
        showRSMLineInfoErrorMessage = false;
        showRSMInfoErrorMessage = false;
    }
    
    /**
    * Get selected RSM TSM to edit the record
    */
    public void getSelectedRSMTSM(){
        if(selectedRSMTSMId != null){
            
            resetRSMLines();
            // Get selected RSM
            if(rsmSOById.containsKey(selectedRSMTSMId)){
                rsmSO = rsmSOById.get(selectedRSMTSMId);
                rsmSO.Actual_Arrival_Date_Time__c = System.now();
                rsmSO.Receiver_Acceptance_Date__c = System.now();
                accountIdOfSelectedRSMTSM = rsmSO.Receiver_Name__c;
                SOorPOIdOfSelectedRSMTSM = rsmSO.Sales_Order__c;
                
                // Get selected TSM
            } else if(tsmSOById.containsKey(selectedRSMTSMId)){  tsmSO = tsmSOById.get(selectedRSMTSMId);
               
                tsmSO.Actual_Arrival_Date_Time__c = System.now();
                tsmSO.Receiver_Acceptance_Date__c = System.now();
                accountIdOfSelectedRSMTSM = tsmSO.Supplier_Name__c; SOorPOIdOfSelectedRSMTSM = tsmSO.Purchase_Order__c;
                
            }
            
            // Display RSM Lines
            retrieveRSMLinesToCancel();
        }
    }
    
    /** 
* Retrieve RSM lines to cancel on Cancel RSM button
*/
    public void retrieveRSMLinesToCancel(){
        
        rsmLines = new List<RSMLineWrapper>();
        Shipping_Manifest_Line__c[] RSMTSMLines = new Shipping_Manifest_Line__c[] {};
            if(rsmSOById.containsKey(selectedRSMTSMId)){
                RSMTSMLines = rsmSO.Shipping_Manifest_Lines__r;
            }else if(tsmSOById.containsKey(selectedRSMTSMId)){  RSMTSMLines = tsmSO.Shipping_Manifest_Lines__r;
                                                              
                                                             }
        // Retrieve RSM lines
        for(Shipping_Manifest_Line__c rsmLineSO : RSMTSMLines){
            RSMLineWrapper rsmLineWrapperObj = new RSMLineWrapper();
            rsmLineWrapperObj.rsmLineSO = rsmLineSO;
            rsmLineWrapperObj.qtyToReceive = rsmLineSO.Shipment_Qty__c;
            
            // Cancelled RSM line should be disabled
            if(rsmLineSO.SMLine_Status__c == SHIPPING_MANIFEST_STATUS_CANCELLED){  rsmLineWrapperObj.disabled = true;
                                                                          
                                                                         }else{
                                                                             rsmLineCount++;
                                                                         }
            rsmLines.add(rsmLineWrapperObj);
        }
        
        if(rsmLines.size() > 0){
            displayRSMLines = true;
        }else{
            showRSMLineInfoErrorMessage = true;
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING, SHIPPING_MANIFEST_LINE_NO_RSM_LINES);
            ApexPages.addMessage(msg);
        }
    } 
    
    // Wrapper class of pending invoices
    public class PendingInvoiceWrapper{
        public Invoice__c invoiceSO {get; set;}
        public Receive_Payment__c receivePaymentSO {get; set;}
        public Decimal productAmount {get; set;}
        public Decimal taxAmount {get; set;}
        public Boolean isCurrentRSMTSM {get; set;}
        
        public PendingInvoiceWrapper(){
            productAmount = 0.0;
            taxAmount = 0.0;
            isCurrentRSMTSM = false;
        }
    }
    
    /**
* Perform validation on RSM Lines and Invoice data
* 
* @return Boolean flag to indicate if any validation fails before ship confirm action
*/
    public Boolean checkValidation(){
        
        ApexPages.Message message;
        hasValidationError = false;
        
        // Validate RSM Lines "Qty To Receive" input
        for(RSMLineWrapper rsmLineWrapperObj : rsmLines){
            // Qty to receive cannot be null and negative value
            if( rsmLineWrapperObj.qtyToReceive < 0){message = new ApexPages.Message(ApexPages.Severity.ERROR, Label.Provide_Valid_Qty_To_Receive); ApexPages.addMessage(message);
                hasValidationError = true;break;
                
            }
            
            // Qty to receive cannot be greater than shipment qty
            if(rsmLineWrapperObj.qtyToReceive > rsmLineWrapperObj.rsmLineSO.Shipment_Qty__c){ message = new ApexPages.Message(ApexPages.Severity.ERROR, Label.Qty_To_Receive_Cannot_Be_Greater_Than_Shipment_Qty); ApexPages.addMessage(message);hasValidationError = true;break;
                
            }
        }
        
        // If RSM line input are valid then check for invoice data
        if(!hasValidationError){
            List<PendingInvoiceWrapper> allInvoices = new List<PendingInvoiceWrapper>();
            List<PendingInvoiceWrapper> pendingInvoices;
            List<PendingInvoiceWrapper> currentInvoices;
            
            // Get all pending invoices related to RSM/TSM
            if(accountIdOfSelectedRSMTSM != null) {
                pendingInvoices = pendingInvoiceByAccountId.get(accountIdOfSelectedRSMTSM);
            }
            
            // Get all current invoices related to RSM/TSM
            if(SOorPOIdOfSelectedRSMTSM != null) {
                currentInvoices = currentInvoiceForRSMTSM.get(SOorPOIdOfSelectedRSMTSM);
            }
            
            // Add all pending invoices to validate
            if(pendingInvoices != null){
                allInvoices.addAll(pendingInvoices);
            }
            
            // Add all current invoices to validate
            if(currentInvoices != null){
                allInvoices.addAll(currentInvoices);
            }
            
            if(!allInvoices.isEmpty()){
                
                Set<Id> invoiceIds = new Set<Id>();
                Set<String> uniqueRPString = new Set<String>();
                
                // Get all existing invoice ids
                for(PendingInvoiceWrapper invoiceWrapper : allInvoices){
                    invoiceIds.add(invoiceWrapper.invoiceSO.Id);
                }
                
                // Get all existing related receive payments
                for(Receive_Payment__c rpObj : [Select Invoice__c,
                                                Payment_Amount__c,
                                                Payment_Form__c,
                                                Payment_Memo__c,
                                                Payment_Received_Date__c,
                                                RecordTypeId
                                                From Receive_Payment__c
                                                Where Invoice__c IN: invoiceIds]){ uniqueRPString.add(generateRPParametersString(rpObj.Invoice__c, rpObj.Payment_Amount__c.stripTrailingZeros(), rpObj.Payment_Form__c,rpObj.Payment_Memo__c, rpObj.Payment_Received_Date__c, rpObj.RecordTypeId));
                                                }
                
                for(PendingInvoiceWrapper invoiceWrapper : allInvoices){
                    Receive_Payment__c receivePaymentSO = invoiceWrapper.receivePaymentSO;
                    
                    // Payment form value should not be blank if payment or tax amount is > 0
                    if(receivePaymentSO != null && 
                       (invoiceWrapper.productAmount != null && invoiceWrapper.productAmount > 0 ||
                        invoiceWrapper.taxAmount != null && invoiceWrapper.taxAmount > 0) &&
                       receivePaymentSO.Payment_Form__c == null){
                           
                           message = new ApexPages.Message(ApexPages.Severity.ERROR, SHIPPING_MANIFEST_LINE_ERROR_PAYMENT_FORM_REQUIRED);
                           ApexPages.addMessage(message);
                           hasValidationError = true;
                           break;
                       }else{
                           if(receivePaymentSO != null){ 
                               
                               // Check for product amount validation - cannot be greater than invoice balance
                               if(invoiceWrapper.productAmount != null && invoiceWrapper.productAmount > 0 &&
                                  invoiceWrapper.productAmount > invoiceWrapper.invoiceSO.Product_Balance__c){
                                      
                                      message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                                      String.format(INVOICE_EXCISE_PRODUCT_TAX_AMOUNT_VALIDATION, 
                                                                                    new List<String>{String.valueOf(invoiceWrapper.productAmount),
                                                                                        String.valueOf(invoiceWrapper.invoiceSO.Product_Balance__c)}));
                                      ApexPages.addMessage(message);
                                      hasValidationError = true;
                                  }
                               
                               // Check for excise tax amount validation - cannot be greater than excise tax balance
                               if(invoiceWrapper.taxAmount != null && invoiceWrapper.taxAmount > 0 &&
                                  invoiceWrapper.taxAmount > invoiceWrapper.invoiceSO.Excise_Tax_Balance__c){
                                      
                                      message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                                      String.format(INVOICE_EXCISE_PRODUCT_TAX_AMOUNT_VALIDATION, 
                                                                                    new List<String>{String.valueOf(invoiceWrapper.taxAmount),
                                                                                        String.valueOf(invoiceWrapper.invoiceSO.Excise_Tax_Balance__c)}));
                                      ApexPages.addMessage(message);
                                      hasValidationError = true;
                                      
                                      // Check if existing RP entry is already created - BE-2019-05-0000000209
                                  }else{
                                      String rpString = '';
                                      Id recordTypeId = null;
                                      
                                      // Check product amount entry
                                      if(invoiceWrapper.productAmount != null){
                                          recordTypeId = Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get(PRODUCT_RECORD_TYPE_PRODUCT).getRecordTypeId();
                                          
                                          rpString = generateRPParametersString(invoiceWrapper.invoiceSO.Id,
                                                                                invoiceWrapper.productAmount.stripTrailingZeros(),
                                                                                invoiceWrapper.receivePaymentSO.Payment_Form__c,
                                                                                invoiceWrapper.receivePaymentSO.Payment_Memo__c,
                                                                                invoiceWrapper.receivePaymentSO.Payment_Received_Date__c,
                                                                                recordTypeId);
                                          
                                          if(uniqueRPString.contains(rpString)){  message = new ApexPages.Message(ApexPages.Severity.ERROR,String.format(INVOICE_EXCISE_PRODUCT_DUPLICATE_AMOUNT_PAYMENT, new List<String>{String.valueOf(invoiceWrapper.productAmount)})); ApexPages.addMessage(message);hasValidationError = true;
                                              
                                          }
                                      }
                                      
                                      // Check Tax Amount entry
                                      if(invoiceWrapper.taxAmount != null){
                                          recordTypeId = Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECEIVE_PAYMENT_RECORDTYPE_EXCISE_TAX).getRecordTypeId();
                                          
                                          rpString = generateRPParametersString(invoiceWrapper.invoiceSO.Id,
                                                                                invoiceWrapper.taxAmount.stripTrailingZeros(),
                                                                                invoiceWrapper.receivePaymentSO.Payment_Form__c,
                                                                                invoiceWrapper.receivePaymentSO.Payment_Memo__c,
                                                                                invoiceWrapper.receivePaymentSO.Payment_Received_Date__c,
                                                                                recordTypeId);
                                          
                                          if(uniqueRPString.contains(rpString)){message = new ApexPages.Message(ApexPages.Severity.ERROR, String.format(INVOICE_ERROR_DUPLICATE_TAX_AMOUNT, new List<String>{String.valueOf(invoiceWrapper.taxAmount)}));ApexPages.addMessage(message);hasValidationError = true;
                                              
                                          }
                                      }
                                  }
                           }
                       }
                }
            }
        }
        //check validation for hold issue
        //Shipping_Manifest__c sm = [select id ,Picklist__c,Invoice__c,Payment_Terms__c from  Shipping_Manifest__c where id  =: selectedRSMTSMId];
        Shipping_Manifest__c sm = [select id ,Purchase_Order__c,Purchase_Order__r.Supplier_Name__r.Hold__c ,Purchase_Order__r.Receiver_Name__r.Hold__c,Purchase_Order__r.Distributor_Name__r.Hold__c,Purchase_Order__r.Supplier_Name__r.DBA__c ,Purchase_Order__r.Receiver_Name__r.DBA__c,Purchase_Order__r.Distributor_Name__r.DBA__c ,Picklist__c,Invoice__c, Sales_Order__c, Payment_Terms__c from  Shipping_Manifest__c where id  =: selectedRSMTSMId];
        
        if(sm.Picklist__c != null){
            picklist__c pick = [select id ,Sales_Order__c from  picklist__c where id  =: sm.Picklist__c];
           
            
            Sales_Order__c SOHold = [select id,Supplier_Name__c ,Receiver_Name__c,Distributor_Name__c,Account_Hold_Exception__c, (select id, Sales_Order__c from picklists__r)  from Sales_Order__c where id =: pick.Sales_Order__c];  
           
            Account  supAcc = [SELECT  id , Hold__c, DBA__c  from Account  where id =:SOHold.Supplier_Name__c];
            Account  recAcc = [SELECT  id , Hold__c, DBA__c  from Account  where id =:SOHold.Receiver_Name__c];
            Account  disAcc = [SELECT  id , Hold__c, DBA__c  from Account  where id =:SOHold.Distributor_Name__c];
            String accountName = '';
            Set<String> my_list = new Set<String>();
            if((supAcc.Hold__c == true || recAcc.Hold__c == true || disAcc.Hold__c == true) && SOHold.Account_Hold_Exception__c == false)
            {
                if(supAcc.Hold__c == true){  my_list.add(supAcc.DBA__c);
                }
                if(disAcc.Hold__c == true){  my_list.add(disAcc.DBA__c);
                }
                if(recAcc.Hold__c == true){  my_list.add(recAcc.DBA__c);
                }
                accountName = String.join(new List<String>(my_list), ', ');  
                errorMessage = INVOICE_ERROR_ACCOUNT_HOLD + accountName + INVOICE_ACCOUNT_HOLD_FINANACE_TEAM;
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage);
                ApexPages.addMessage(msg); hasValidationError = true;
                
            }
        }else if(sm.Purchase_Order__c != null){
            List<String> holdAccounts = new List<String>();
            if(sm.Purchase_Order__r.Supplier_Name__r.Hold__c == true || sm.Purchase_Order__r.Receiver_Name__r.Hold__c == true || sm.Purchase_Order__r.Distributor_Name__r.Hold__c == true){
                if(sm.Purchase_Order__r.Supplier_Name__r.Hold__c == true){ holdAccounts.add(sm.Purchase_Order__r.Supplier_Name__r.DBA__c);
                }
                if(sm.Purchase_Order__r.Receiver_Name__r.Hold__c == true){ holdAccounts.add(sm.Purchase_Order__r.Receiver_Name__r.DBA__c);
                }
                if(sm.Purchase_Order__r.Distributor_Name__r.Hold__c == true){  holdAccounts.add(sm.Purchase_Order__r.Distributor_Name__r.DBA__c);
                }
                String accountNames = String.join(new List<String>(holdAccounts), ', '); 
                errorMessage = INVOICE_ERROR_ACCOUNT_HOLD + accountNames + INVOICE_ACCOUNT_HOLD_FINANACE_TEAM;
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, errorMessage); ApexPages.addMessage(msg);  hasValidationError = true; 
            }
        }
        return hasValidationError;
    } 
    
    /**
* Contact all receive payments parameters in one string
*/
    private String generateRPParametersString(Id invoiceId,
                                              Decimal paymentAmount,
                                              String paymentForm,
                                              String paymentMemo,
                                              Date paymentReceivedDate,
                                              Id recordTypeId){
                                                  String rpString = '';
                                                  rpString += invoiceId;
                                                  rpString += paymentAmount != null && paymentAmount > 0 ? String.valueOf(paymentAmount) : '';
                                                  rpString += paymentForm;
                                                  rpString += paymentMemo;
                                                  rpString += paymentReceivedDate != null ? paymentReceivedDate.format() : '';
                                                  rpString += recordTypeId;
                                                  
                                                  return rpString;
                                              }
    
    /**
* Get date selection options
*/
    public List<SelectOption> getDateSelectionOptions() {
        List<SelectOption> options = new List<SelectOption>();
        Date todayDate = System.Today();
        options.add(new SelectOption(SHIPPING_MANIFEST_DATE_SELECTION_TODAY_MINUS_THREE, (todayDate - 3).format()));
        options.add(new SelectOption(SHIPPING_MANIFEST_DATE_SELECTION_TODAY_MINUS_TWO, (todayDate - 2).format()));
        options.add(new SelectOption(SHIPPING_MANIFEST_DATE_SELECTION_TODAY_MINUS_ONE, (todayDate - 1).format()));
        options.add(new SelectOption(SHIPPING_MANIFEST_DATE_SELECTION_TODAY,  todayDate.format()));
        options.add(new SelectOption(SHIPPING_MANIFEST_DATE_SELECTION_TODAY_PLUS_ONE,  (todayDate + 1).format()));
        options.add(new SelectOption(SHIPPING_MANIFEST_DATE_SELECTION_TODAY_PLUS_TWO,  (todayDate + 2).format()));
        options.add(new SelectOption(SHIPPING_MANIFEST_DATE_SELECTION_TODAY_PLUS_THREE,  (todayDate + 3).format()));
        
        return options; 
    }
    
    /**
* Get date from selected day
* @param selectedDay The selected day 
* @return The selected date
*/
    public Date getSelectedDate(String selectedDay) {
        Date selectDate = System.Today();
        switch on selectedDay {
            when 'Today' {      
                return selectDate;
            }
            when 'Today minus 1' {      
                return selectDate - 1;
            }   
            when 'Today minus 2' {      
                return selectDate - 2;
            }
            when 'Today minus 3' {      
                return selectDate - 3;
            }
            when 'Today plus 1' {       
                return selectDate + 1;
            }   
            when 'Today plus 2' {       
                return selectDate + 2;
            }
            when 'Today plus 3' {       
                return selectDate + 3;
            }
            when else {       
                return selectDate;
            }
        }
    }
    
    /**
* Reload page on changing selection of day
*/
    public PageReference reloadPage() {
        PageReference pageRef = new PageReference('/apex/RSMTSMShipConfirm?selectedDay='+selectedDay);
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    /*** 
    Shipmainfest  Lightning conversion code
    Ship Mainfest List With Pending Invoice Count & Google Map Distance Calcuation
    **/ 
     
    /** Method to return data to component **/
    @AuraEnabled
    public static AuraResponse shipConfirmLight(String selectedDays){
        AuraResponse r = new AuraResponse('RSMTSMShipConfirmCotroller.shipConfirmLight()');
        RSMTSMShipConfirmCotroller assign = new RSMTSMShipConfirmCotroller();
        assign.selectedDay = selectedDays;
        Date newDate = Date.valueOf(selectedDays); 
        DateTime dt = (DateTime)Cache.Session.get('datetime');
        r.data.put('dt',dt);
        assign.setShipLines = getShipManLines(newDate);
        assign.setgeolocation = getLocation(newDate);
        r.data.put('setShipLines', assign.setShipLines);
        r.data.put('getLocation', assign.setgeolocation);
        return r;
    }  
 
    // get record types rsm, tsm, tranfer, lab
    public static Set<Id> smRecordTypeIds(){ 
        
        Set<Id> smRecordTypeIds = new Set<Id>();
        smRecordTypeIds.add(ShippinManifestSupport.getRSMRecordTypeId()) ;
        smRecordTypeIds.add(ShippinManifestSupport.getTSMRecordTypeId()) ;
        smRecordTypeIds.add(ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER));
        smRecordTypeIds.add(ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_LAB));
        smRecordTypeIds.add(ShippinManifestSupport.getTransferRecordTypeId('Cash_Collection'));
        return smRecordTypeIds;
        
    }
    
    
     /** Method to get Shipmainfest List with Pending invoice mehtod binding **/
    @AuraEnabled
    public static List<ShipLineWrapper>  getShipManLines(Date selDay){
        
      
        
        String driverName = UserInfo.getName();
        Date newDate = Date.valueOf(selDay); 
        Boolean isMasterGroupMember = false;
        Company_Custom_Settings__c companySettings = Company_Custom_Settings__c.getOrgDefaults();
        if(companySettings != null && String.isNotBlank(companySettings.Ship_Confirm_Master_User_Group__c)){
            for(Group g: [SELECT Id, Name,(SELECT Id, UserOrGroupId FROM GroupMembers) FROM Group WHERE Name = :companySettings.Ship_Confirm_Master_User_Group__c]){
                if(!g.GroupMembers.isEmpty()){
                    for(GroupMember GM: g.GroupMembers){
                        if(UserInfo.getUserId() == GM.UserOrGroupId){ 
                            isMasterGroupMember = true; break;
                        }
                    }
                }
            }
        }
        
        // Get recordTypeIds from Method
        Set<Id> smRecordTypeIds= new Set<Id>();
        smRecordTypeIds = smRecordTypeIds();
        String smListQuery= '';
        List<ShipLineWrapper> slWrapper = new List<ShipLineWrapper>();
        Id rsmRecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        List <Shipping_Manifest__c> smList = new List <Shipping_Manifest__c>();
        
        smListQuery= 'Select Sales_Order__r.Name,Sales_Order__r.Id,Name,Box_Count__c,Payment_Terms__c,Window_Start_End__c,Receiver_Contact__r.Name,'
            +'Receiver_Contact__r.Id,Metrc_Manifest__c,Priority__c,Sales_Order__c,Receiver_Name__c,Receiver_Name__r.name, Receiver_License__c,Receiver_Name__r.Id,RecordType.Name,'
            +'Receiver_Name__r.dBA__c,Receiver_Address__c,Receiver_Phone__c,Receiver_Name__r.phone,Receiver_City_State_Zip__c,Status__c,Supplier_Name__r.Name,Supplier_Contact__r.Name,Order_Number__c,Order_Number__r.Name,'
            +'Supplier_Name__r.dBA__c From Shipping_Manifest__c where Status__c NOT IN (:SHIPPING_MANIFEST_STATUS_CANCELLED,:SHIPPING_MANIFEST_STATUS_COMPLETE,:SHIPPING_MANIFEST_STATUS_RECEIVED,:SHIPPING_MANIFEST_STATUS_DRAFT) AND Planned_Ship_Transfer_Date__c=:newDate '
            + (!isMasterGroupMember?' AND Driver__r.Name =: driverName ':'')
            +' AND Actual_Arrival_Date_Time__c = null AND Receiver_Acceptance_Date__c = null '
            +' AND (Picklist__c = NULL OR Picklist__r.Status__c = :PICKLIST_STATUS_QACONFIRM)'
            +' AND RecordTypeId IN :smRecordTypeIds  ORDER By Id';
        smList = Database.query(smListQuery);
        for(Shipping_Manifest__c shipLine : smList){
            ShipLineWrapper sLineWrapper = new ShipLineWrapper(shipLine);
            sLineWrapper.pendingInvoice = getPendingInvoiceCount(shipLine.Receiver_Name__c,shipLine.Supplier_Name__r.Id, shipLine.RecordType.Name);
            slWrapper.add(sLineWrapper);
        }
        return slWrapper;
    }
    
    /** Method to get  Pending invoice count and return to Shipmainfest List getShipManLines **/
    public static Integer getPendingInvoiceCount(Id shipLine, Id suplierId, String RecordTypeName){
        
         if(RecordTypeName== SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM)
        {
            List<Invoice__c> finInvoice = [Select Id, Name, Purchase_Order__c, Excise_Tax_Balance__c,Invoice_Due_Date__c,Sales_Order__c,Receiver_Name__c,
                                           AR_Status__c,Invoice_Balance__c,Receiver_Contact__c, Product_Balance__c From Invoice__c 
                                           Where Supplier_Name__c  =: suplierId AND  (AR_Status__c =: INVOICE_AR_STATUS_SHIPPED OR AR_Status__c =: INVOICE_AR_STATUS_APPROVED)
                                           AND Invoice_Balance__c > 0.0 ORDER BY Name]; 
            Integer penInvoice = finInvoice.size();
            return penInvoice;
        }else{
            List<Invoice__c> finInvoice = [Select Id, Name, Purchase_Order__c, Excise_Tax_Balance__c,Invoice_Due_Date__c,Sales_Order__c,Receiver_Name__c,AR_Status__c,Invoice_Balance__c,Receiver_Contact__c, Product_Balance__c From Invoice__c   Where Receiver_Name__c  =: shipLine AND  (AR_Status__c =: INVOICE_AR_STATUS_SHIPPED OR AR_Status__c =: INVOICE_AR_STATUS_APPROVED) AND Invoice_Balance__c > 0.0 ORDER BY Name];   
            Integer penInvoice = finInvoice.size(); return penInvoice;
            
        }
        
    } 
    
    /** Method to change shipmainfest status to Depart Confirm **/
    @AuraEnabled
    public static AuraResponse updateManifest(List<Id> lstRecordId) { 
        
        AuraResponse r = new AuraResponse('updateManifest()'); 
        RSMTSMShipConfirmCotroller assign = new RSMTSMShipConfirmCotroller();
        
        List<Shipping_Manifest_Line__c> rsmLines = new List<Shipping_Manifest_Line__c>();
        Set<Id> invPositionIds = new Set<Id>();
        List<Inventory_Position__c> invPositions = new List<Inventory_Position__c>();
        Set<Id> siteIds = new Set<Id>();
        Map<Id, Id> invLocationIdBySiteId = new Map<Id, Id>();
        Map<Id, Id> rackIdByInvLocationId = new Map<Id, Id>();
        Map<Id, Id> rackLevelIdByRackId = new Map<Id, Id>();
        Map<Id, Id> binLocationIdByRackLevelId = new Map<Id, Id>();
        Set<String> vehicleNames = new Set<String>();
        
        List<Shipping_Manifest__c> shippingManifestList = [SELECT Id, Name, Status__c,Actual_Departure_Date_Time__c,Vehicle__r.Name FROM Shipping_Manifest__c WHERE Id= : lstRecordId ];
        for(Shipping_Manifest__c updateSM : shippingManifestList){
            updateSM.Status__c = SHIPPING_MANIFEST_STATUS_INTRANSIT;
            updateSM.Actual_Departure_Date_Time__c =Datetime.now();
            rsmLines.addAll(updateSM.Shipping_Manifest_Lines__r);
            if(updateSM.Vehicle__c != null){ vehicleNames.add(updateSM.Vehicle__r.Name);
            } 
        }
        update shippingManifestList;
        
        for(Shipping_Manifest_Line__c rsmLineObj : [ SELECT ID, Name, Picklist_Line__r.Inventory_Position__c,Picklist_Line__r.Inventory_Position__r.Site__c FROM Shipping_Manifest_Line__c WHERE SMLine_Status__c!=:SHIPPING_MANIFEST_LINE_STATUS_CANCELLED AND   
                                                                     Shipping_Manifest__c IN: lstRecordId ]){ invPositionIds.add(rsmLineObj.Picklist_Line__r.Inventory_Position__c); siteIds.add(rsmLineObj.Picklist_Line__r.Inventory_Position__r.Site__c);
        }
        
        invPositions = [SELECT Site__c, 
                               Inventory_Location__c, 
                               Rack__c, 
                               Rack_Level__c, 
                               Bin_Location__c 
                               FROM Inventory_Position__c 
                               WHERE Id IN: invPositionIds];
        
        // Create map of Inventory location Id by Site Id
        for(Inventory_Location__c invLocation : [SELECT Site_Name__c FROM Inventory_Location__c WHERE Site_Name__c IN: siteIds  AND Name IN: vehicleNames]){ invLocationIdBySiteId.put(invLocation.Site_Name__c, invLocation.Id);
        }
        
        // Create map of rack Id by Inventory location Id
        for(Rack__c rackSO : [Select Inventory_Location__c from Rack__c Where Inventory_Location__c IN: invLocationIdBySiteId.values() AND Name =: vehicleNames]){  rackIdByInvLocationId.put(rackSO.Inventory_Location__c, rackSO.Id);
        }
        
        // Create map of rack level Id by rack Id
        for(Rack_Level__c rackLevelSO : [Select Rack__c from Rack_Level__c Where Rack__c IN: rackIdByInvLocationId.values() AND Name IN: vehicleNames]){
            rackLevelIdByRackId.put(rackLevelSO.Rack__c, rackLevelSO.Id);
        }
        
        // Create map of bin location Id by rack level Id
        for(Bin_Location__c binLocationSO : [Select Rack_Level__c from Bin_Location__c Where Rack_Level__c IN: rackLevelIdByRackId.values() AND Name IN: vehicleNames]){ binLocationIdByRackLevelId.put(binLocationSO.Rack_Level__c, binLocationSO.Id);
        }
        
        // Update inventory positions attributes as vehicle name
        for(Inventory_Position__c invPosition : invPositions){ invPosition.Inventory_Location__c = invLocationIdBySiteId.get(invPosition.Site__c);
            invPosition.Rack__c = rackIdByInvLocationId.get(invPosition.Inventory_Location__c);
            invPosition.Rack_Level__c = rackLevelIdByRackId.get(invPosition.Rack__c);
            invPosition.Bin_Location__c = binLocationIdByRackLevelId.get(invPosition.Rack_Level__c);
        }
        update invPositions;
        return r; 
    }
    
    
    
     /** Method to get receiver address for googlemap distance calculation **/
    @AuraEnabled
    public static list<accountLocationWrapper> getLocation(Date selectedDay){

        list<accountLocationWrapper> lstALW = new list<accountLocationWrapper>();
        Date newDate = Date.valueOf(selectedDay); 
        String driverName = UserInfo.getName();
        Id rsmRecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        List <Shipping_Manifest__c> smLocationList = new List <Shipping_Manifest__c>();
        Boolean isMasterGroupMember = false;
        Company_Custom_Settings__c companySettings = Company_Custom_Settings__c.getOrgDefaults();
        
        if(companySettings != null && String.isNotBlank(companySettings.Ship_Confirm_Master_User_Group__c)){
            for(Group g: [SELECT Id, Name,(SELECT Id, UserOrGroupId FROM GroupMembers) FROM Group WHERE Name = :companySettings.Ship_Confirm_Master_User_Group__c]){
                if(!g.GroupMembers.isEmpty()){
                    for(GroupMember GM: g.GroupMembers){
                        if(UserInfo.getUserId() == GM.UserOrGroupId){  
                            isMasterGroupMember = true;   break;
                           
                        }
                    }
                }
            }
        }
        
        // Get recordTypeIds from Method
        Set<Id> smRecordTypeIds= new Set<Id>();
        smRecordTypeIds = smRecordTypeIds();
        String smListQuery= '';
        smListQuery = 'Select  RecordType.Name,Supplier_Address__c,Supplier_City_State_Zip__c,Receiver_Contact__r.Name,Receiver_Address__c,Receiver_City_State_Zip__c,Site__c,Site__r.Name,Site__r.License_ID__r.License_Address__c,Site__r.License_ID__r.License_City__c,Site__r.License_ID__r.License_Country__c,Site__r.License_ID__r.License_State__c,Site__r.License_ID__r.License_Zip__c From Shipping_Manifest__c where Status__c NOT IN (:SHIPPING_MANIFEST_STATUS_CANCELLED,:SHIPPING_MANIFEST_STATUS_COMPLETE,:SHIPPING_MANIFEST_STATUS_RECEIVED,:SHIPPING_MANIFEST_STATUS_DRAFT) AND Planned_Ship_Transfer_Date__c=:newDate '
            +(!isMasterGroupMember?' AND Driver__r.Name =: driverName ':'')
            +' AND Actual_Arrival_Date_Time__c = null AND Receiver_Acceptance_Date__c = null '
            +' AND (Picklist__c = NULL OR Picklist__r.Status__c =: PICKLIST_STATUS_QACONFIRM)'
            +' AND  RecordTypeId IN :smRecordTypeIds ORDER By Id';
        smLocationList = Database.query(smListQuery);
        
        
        for (Shipping_Manifest__c    acc: smLocationList)
        {
            locationDetailWrapper oLocationWrap = new locationDetailWrapper();
            accountLocationWrapper oWrapper = new accountLocationWrapper();
            oWrapper.icon = 'utility:location'; 
            oWrapper.description = acc.Site__r.License_ID__r.License_Address__c+','+acc.Site__r.License_ID__r.License_City__c+', '+acc.Site__r.License_ID__r.License_Country__c+','+acc.Site__r.License_ID__r.License_State__c+' '+acc.Site__r.License_ID__r.License_Zip__c;
           if(acc.RecordType.Name== SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM) {  oWrapper.rsAddress  = acc.Supplier_Address__c+' '+acc.Supplier_City_State_Zip__c; 
          
             
           }else{
               
                oWrapper.rsAddress  = acc.Receiver_Address__c+' '+acc.Receiver_City_State_Zip__c; 
           }
            oWrapper.location = oLocationWrap;
            lstALW.add(oWrapper);
        }
        return lstALW;
    } 
     
    /* wrapper class to store required properties for "lightning:map" component' */ 
    public class accountLocationWrapper{
        @AuraEnabled public string icon{get;set;} 
        @AuraEnabled public string title{get;set;} 
        @AuraEnabled public string description{get;set;} 
        @AuraEnabled public string rsAddress{get;set;} 
        @AuraEnabled public string SourceAddress{get;set;} 
        @AuraEnabled public locationDetailWrapper location{get;set;} 
    }
    
    /* sub wrapper class to store location details for "accountLocationWrapper" location property.*/ 
    public class locationDetailWrapper{
        @AuraEnabled public string Street{get;set;}
        @AuraEnabled public string PostalCode{get;set;}
    }
    
    @AuraEnabled  
    public static List<Shipping_Manifest__c> getData(String selectedDay) { 
        Date newDate = Date.valueOf(selectedDay); 
        List<Shipping_Manifest__c> res = new LIST<Shipping_Manifest__c>();  
        res = [Select Sales_Order__r.Name,Sales_Order__r.Id,Name,Payment_Terms__c,Window_Start_End__c,Priority__c,Receiver_Contact__r.Name,Receiver_Contact__r.Id,Metrc_Manifest__c,Sales_Order__c,Receiver_Name__c,Receiver_Name__r.name,
               Receiver_Name__r.Id,Receiver_Name__r.dBA__c,Receiver_Address__c,Receiver_Phone__c,Receiver_City_State_Zip__c,Status__c From Shipping_Manifest__c where Planned_Ship_Transfer_Date__c=:newDate  AND (Status__c =: SHIPPING_MANIFEST_STATUS_PENDING OR Status__c =: SHIPPING_MANIFEST_STATUS_INTRANSIT  OR Status__c =: SHIPPING_MANIFEST_STATUS_DRAFT)
               AND Actual_Departure_Date_Time__c=null AND Receiver_Acceptance_Date__c = null ORDER By Id];
        return res;
    }
  
    
    /*** 
    Shipmainfest  Lightning conversion code
    Ship Mainfest detailview, Rsmline list, current & Opend & pending invoice, e-signature
    **/ 
    
    @AuraEnabled
    public static AuraResponse getDataLight(String recordId){
        
        AuraResponse r = new AuraResponse('RSMTSMShipConfirmCotroller.getDataLight()');
        RSMTSMShipConfirmCotroller assign = new RSMTSMShipConfirmCotroller();
        assign.setSM = getShipMan(recordId);
        assign.setOpenInvoiceLines = getCurrentInvoice(assign.setSM.Sales_Order__c, assign.setSM.RecordType.Name);
        assign.setPendingInvoiceLines = getPendingInvoice(assign.setSM);
        assign.setRsmLines = getRsmLines(recordId);
        assign.getReceiverContacts = getReceiverContacts(assign.setSM);
        assign.getPaymentStatusData = getPaymentStatusData();
        Shipping_Manifest__c getRecordType = [SELECT RecordType.Name FROM Shipping_Manifest__c where  Id =: recordId];
        if(getRecordType.RecordType.Name!= SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION && getRecordType.RecordType.Name!= SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM ){
            assign.invoiceDt = getinvoiceDetail(recordId); 
        }else{
            assign.invoiceDt =null;
        }
        DateTime crDate = assign.NOW;
        r.data.put('setInvoiceLines', assign.setInvoiceLines);
        r.data.put('setOpenInvoiceLines', assign.setOpenInvoiceLines);
        r.data.put('setPendingInvoiceLines', assign.setPendingInvoiceLines);
        r.data.put('setSM', assign.setSM);
        r.data.put('setRsmLines', assign.setRsmLines); 
        r.data.put('curDatetime', crDate.format('MM-dd-yyyy HH:mm a'));
        r.data.put('getReceiverContacts', assign.getReceiverContacts); 
        r.data.put('getPaymentStatusData', assign.getPaymentStatusData);
          r.data.put('invoiceDt', assign.invoiceDt);
        string SMLI_Rejection_Reason_Validation_Config = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SMLI_Rejection_Reason_Validation_Config');
        
        r.data.put('SMLI_Rejection_Reason_Validation_Config', SMLI_Rejection_Reason_Validation_Config != null ? SMLI_Rejection_Reason_Validation_Config : '');        
        return r;
    }
    
    public static Shipping_Manifest__c getShipMan(String recordId){
        
        Shipping_Manifest__c shipManLines = [Select Receiver_Name__c,Sales_Order__c,Sales_Order__r.Name, Name, Payment_Terms__c, Window_Start_End__c,Priority__c, Receiver_Contact__r.Name,Receiver_Name__r.Name, 
                                             Metrc_Manifest__c, Receiver_Name__r.dBA__c, Receiver_Address__c, Receiver_City_State_Zip__c, Driver__r.Name, Vehicle__r.Name, 
                                             Planned_Ship_Transfer_Date__c,RecordTypeId,RecordType.Name,Supplier_Name__r.DBA__c,Purchase_Order__r.Name,Actual_Departure_Date_Time__c,Actual_Arrival_Date_Time__c,Receiver_Acceptance_Date__c,Actual_Receiver_Name__c,Order_Number__c,Order_Number__r.Name From Shipping_Manifest__c where Id =: recordId  Limit 1];
        return shipManLines;
    }
    
    
    // Retrieve Invoice Detail
	public static List<Invoice__c> getinvoiceDetail(String recordId){
        
    	Shipping_Manifest__c shipManLines = [Select Sales_Order__c From Shipping_Manifest__c where  Id =: recordId];
        Id salesorderId = shipManLines.Sales_Order__c;
        List<Invoice__c> invoiceDetail = [Select Id,Name From Invoice__c where  Sales_Order__c =: salesorderId];
        if(invoiceDetail.size() > 0){
            return invoiceDetail;
        }else{
            return null;
        }
        
    }
    
    
    //payment form status picklist
    @AuraEnabled
    public static Map<String, String> getPaymentStatusData(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Receive_Payment__c.Payment_Form__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        String[] paymentform = RECEIVE_PAYMENT_OPTION_SHIPCONFIRM_CONSOLE.split(',');
        for (Schema.PicklistEntry p: pList) { 
            if(paymentform.contains(p.getValue())){
                options.put(p.getValue(), p.getLabel());
            }
        }
        return options;
    }
    
    @AuraEnabled
    public static AuraResponse updateShipmentConfirm(List<InvoiceLineWrapper> setInvoiceLines, List<InvoiceLineWrapper> setOpInvoiceLines, List<rsmlinesWrapper> setRsmLines, String setReceiverName, String smRtypeName,Date rsmShiptrDate,String base64Data, String contentType, String recordId, Shipping_Manifest__c setSlackNotesSM){
        AuraResponse r = new AuraResponse('RSMTSMShipConfirmCotroller.updateShipmentConfirm()');
        RSMTSMShipConfirmCotroller assigns = new RSMTSMShipConfirmCotroller(); IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED = False;
        
        if(assigns.checkSmValidation(setInvoiceLines, setOpInvoiceLines, setRsmLines, recordId )){  
            r.data.put('message', smErrorMessage);   return r;
        }
        
        SavePoint savePoint;
        
        try{
            // Define Savepoint for rollback
            savePoint = Database.setSavepoint();
            RSMTSMShipConfirmCotroller assign = new RSMTSMShipConfirmCotroller();
            Set<Id> shipManifest =new Set<Id>();
            List<String> balanceValues =  new List<String>();
            Map<Id, Decimal> invoiceProductAmtValues = new Map<Id, Decimal>();
            Map<Id, Decimal> invoiceExciseTaxValues = new Map<Id, Decimal>();
            List<Invoice__c> upadteinvoice = new List<Invoice__c>();
            List<Receive_Payment__c> receivedpay = new List<Receive_Payment__c>();
            List<Invoice__c> opupadteinvoice = new List<Invoice__c>();
            List<Receive_Payment__c> opreceivedpay = new List<Receive_Payment__c>();
            List<Shipping_Manifest_Line__c> allRSMLines = new List<Shipping_Manifest_Line__c>();  
            List<Shipping_Manifest_Line__c> rsmLinesToUpdates = new List<Shipping_Manifest_Line__c>();
            Id extaxRecordTypeId = Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get('Excise Tax').getRecordTypeId();
            Id smRecordtypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(smRtypeName).getRecordTypeId();
            Shipping_Manifest_Line__c  rsmSOLines = new Shipping_Manifest_Line__c();
            String RSM_STATUS_SHIPMENT_COMPLETE =SHIPPING_MANIFEST_STATUS_COMPLETE; 
            Cache.Session.remove('datetime');
            DateTime dt = DateTime.now();
            Cache.Session.put('datetime', dt);
        
            
            Set<ID> opCId = new Set<ID>();
            Boolean allSMLinesCancelled = true;
            Integer fullRejectCount = 0; Boolean fullReject = false;
            

            List<Shipping_Manifest_Line__c> shippingMLineList = new List<Shipping_Manifest_Line__c>();
            for (rsmlinesWrapper res :setRsmLines){  Shipping_Manifest_Line__c invObj=res.rsmlinesIL;invObj.SMLine_Status__c = RSM_STATUS_SHIPMENT_COMPLETE;  invObj.Actual_Shipment_Qty__c  =  invObj.Shipment_Qty__c;       
                                                  
                if((invObj.Qty_Received__c == 0.0 || invObj.Qty_Received__c == null ) && (smRtypeName!=SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM || smRtypeName!=SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION)) {   
                    invObj.SMLine_Status__c = SHIPPING_MANIFEST_LINE_STATUS_REJECTED;
                    
                } else{
                    /* New line for 101 issue fix - Process Builder - Map SML Qty Received to POLI Qty Ordered */
                   
                   invObj.SMLine_Status__c = SHIPPING_MANIFEST_STATUS_COMPLETE; 
                   // allSMLinesCancelled = false;
                }
                
                if(smRtypeName ==SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM){  invObj.Qty_Received__c =  invObj.Qty_Ordered__c;
                                                                          invObj.SMLine_Status__c = RSM_STATUS_SHIPMENT_COMPLETE;
                }
                if(smRtypeName == SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION){   invObj.Qty_Received__c =  invObj.Qty_Received__c;
                   
                    
                }                
                if(invObj.Qty_Received__c == 0.0){  fullRejectCount++;
                
                   
                }
                
                shipManifest.add(invObj.Shipping_Manifest__c); shippingMLineList.add(invObj);
            }
            
            if(shippingMLineList.size() > 0){ update shippingMLineList; 
                if(shippingMLineList.size() == fullRejectCount){fullReject = true;
                }
            }
             
            if(smRtypeName== SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM) {  RSM_STATUS_SHIPMENT_COMPLETE = SHIPPING_MANIFEST_STATUS_RECEIVED;
            } 
            
            if(shipManifest.size() > 0){  List<Shipping_Manifest__c> updateShippingManifest = [SELECT RecordTypeId,Id, Name, Status__c,Actual_Receiver_Name__c,Ship_Confirmation_Date__c,Actual_Arrival_Date_Time__c,Actual_Departure_Date_Time__c,Receiver_Acceptance_Date__c,Receiver_Contact__r.Name,Brand_Quote__c,Order_Number__c,Sales_Order__c, Slack_Notes__c FROM Shipping_Manifest__c WHERE Id =: shipManifest];
                
                for(Shipping_Manifest__c newshipManifest : updateShippingManifest){  if(fullReject){  newshipManifest.Status__c = SHIPPING_MANIFEST_STATUS_REJECTED;
                    }else{
                         newshipManifest.Status__c = RSM_STATUS_SHIPMENT_COMPLETE;
                    }
                    newshipManifest.Actual_Receiver_Name__c = setReceiverName; newshipManifest.Ship_Confirmation_Date__c = System.Today();
                    newshipManifest.Actual_Arrival_Date_Time__c = Datetime.now();   newshipManifest.Receiver_Acceptance_Date__c = Datetime.now();
                    if(newshipManifest.Id == setSlackNotesSM.Id){ newshipManifest.Slack_Notes__c = setSlackNotesSM.Slack_Notes__c;
                       
                    }
                }
                if(updateShippingManifest.size() > 0)  update updateShippingManifest;
               		
     
                                        if(smRtypeName != SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION && smRtypeName != SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM){ 
                                            
                                            List<Invoice__c> InvList = [select id, Name, Shipping_Manifest__c from Invoice__c where Sales_Order__c =: updateShippingManifest[0].Sales_Order__c];
                                            
                                            for(Invoice__c inv : InvList){ inv.Shipping_Manifest__c = updateShippingManifest[0].Id;
                                                                         }
                                            // update InvList;
                                        }
                
			if(smRtypeName != SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION){ 
                
                // new code for 101 Update - PB -> SM Ship Confirmation Date to Related Objects V1.2  - Start
                if(updateShippingManifest[0].Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE )
                {
                    if(updateShippingManifest[0].Brand_Quote__c != NULL){
                        Brand_Quote__c brandQuoteData = new Brand_Quote__c(); brandQuoteData.Id = updateShippingManifest[0].Brand_Quote__c;   
                        brandQuoteData.BQ_Status__c = BRAND_QUOTE_STATUS_SHIPPED;brandQuoteData.Ship_Confirmation_Date__c = System.Today();
                        Update brandQuoteData;
                    }
                    
                    if(updateShippingManifest[0].Order_Number__c != NULL){ Order__c orderData = new Order__c();
                        orderData.Id = updateShippingManifest[0].Order_Number__c; orderData.Status__c = ORDER_STATUS_SHIPPED;
                        Update orderData;
                    }
                    
                    if(updateShippingManifest[0].Sales_Order__c != NULL){ Sales_Order__c soData = new Sales_Order__c();
                        soData.Id = updateShippingManifest[0].Sales_Order__c;soData.SO_Status__c = SALES_ORDER_STATUS_SHIPPED;
                        soData.Ship_Confirmation_Date__c = System.Today(); Update soData;
                        
                    }
                    


            }if(updateShippingManifest[0].Status__c == SHIPPING_MANIFEST_STATUS_REJECTED)
            {
                IS_FULL_REJECT = True;
                fullRejectStatusUpdate(updateShippingManifest[0].Brand_Quote__c,updateShippingManifest[0].Order_Number__c);
            }
                
                  // new code for 101 Update SM Ship Confirmation Date to Related Objects V1.2  - End

                // Save e-Sign
                saveSign(base64Data,contentType, recordId);
            
         
                if(shippingMLineList.size() > 0 && smRtypeName!= SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM){String STATUS_CANCELLED = SHIPPING_MANIFEST_STATUS_CANCELLED;
                    
                    
                    // Update RSM Lines for ship confirm - Line Items having non zero qty to receive
                    for(Shipping_Manifest_Line__c rsmLineSO : shippingMLineList){  if(rsmLineSO.Shipment_Qty__c != 0.0 && rsmLineSO.SMLine_Status__c != SHIPPING_MANIFEST_STATUS_CANCELLED ){ rsmLinesToUpdates.add(rsmLineSO);
                        }
                    }
                    
                    updateInventoryPosition(JSOn.serialize(rsmLinesToUpdates),smRecordtypeId);
                    // Update inventory positions and SO lines related to RSM lines
                    RSMSupport.updateInvPositionsAndSOLines(shippingMLineList, allSMLinesCancelled);
                }
                 
              }         
                // Current Invoice For Loop
                
                if(setInvoiceLines.size() > 0)
                {
                    for(InvoiceLineWrapper invLineWrapper : setInvoiceLines){Invoice__c newinvoice = new Invoice__c();
                        newinvoice.Id = invLineWrapper.allInvoices.Id; newinvoice.Total_Product_Payments_Received__c = invLineWrapper.productAmount;
                        newinvoice.Total_Excise_Tax_Payments_Received__c = invLineWrapper.exciseTax;
                        upadteinvoice.add(newinvoice);
                        
                        if(invLineWrapper.productAmount!=0 ){ Receive_Payment__c receivepay = new Receive_Payment__c();
                            receivepay.Invoice__c = invLineWrapper.allInvoices.Id; receivepay.Payment_Received_Date__c  = System.Today();
                            receivepay.Payment_Form__c = invLineWrapper.paymentForm;receivepay.Payment_Amount__c = invLineWrapper.productAmount;
                            receivepay.Payment_Memo__c	= invLineWrapper.payMemo; receivedpay.add(receivepay);
                        }
                        
                        if(invLineWrapper.exciseTax!=0 ) { Receive_Payment__c exTaxreceivepay = new Receive_Payment__c();exTaxreceivepay.RecordTypeId =extaxRecordTypeId;
                            exTaxreceivepay.Invoice__c = invLineWrapper.allInvoices.Id;
                            exTaxreceivepay.Payment_Received_Date__c  = System.Today();  exTaxreceivepay.Payment_Form__c = invLineWrapper.paymentForm;
                            exTaxreceivepay.Payment_Amount__c = invLineWrapper.exciseTax;
                            exTaxreceivepay.Payment_Memo__c	= invLineWrapper.payMemo; receivedpay.add(exTaxreceivepay);
                        }
                        opCId.add(invLineWrapper.allInvoices.Id);
                    }
                  
                  //  if(upadteinvoice.size() > 0){ update upadteinvoice; insert receivedpay;
                   if(upadteinvoice.size() > 0){ updateCurretInvoiceStatus(JSOn.serialize(upadteinvoice));  createCurretreceivePayment(JSOn.serialize(receivedpay));  //insert receivedpay;
                       
                        List<Invoice__c> cuClStatus = new List<Invoice__c>(); for(Invoice__c  cltres:[Select Id,Invoice_Balance__c,Collections_Status__c From Invoice__c where ID IN :opCId]){
                            if(cltres.Invoice_Balance__c==0 || cltres.Invoice_Balance__c < 0) { cltres.Collections_Status__c = INVOICE_COLLECTION_STATUS_PAIDFULL;
                           
                                
                            }
                            cuClStatus.add(cltres);
                        }
                        
                        if(cuClStatus.size() > 0)  update cuClStatus;
                        
                    }
                }
                
                
                // Pending Invoice
                if(setOpInvoiceLines.size() > 0){ Set<ID> opId = new Set<ID>();
                    for(InvoiceLineWrapper invLineOpWrapper : setOpInvoiceLines){  Invoice__c newinvoice = new Invoice__c();
                        newinvoice.Id = invLineOpWrapper.allInvoices.Id;newinvoice.Total_Product_Payments_Received__c = invLineOpWrapper.productAmount;
                        newinvoice.Total_Excise_Tax_Payments_Received__c = invLineOpWrapper.exciseTax;
                        opupadteinvoice.add(newinvoice);
                        
                        if(invLineOpWrapper.productAmount!=0 ) 
                        {
                            Receive_Payment__c receivepay = new Receive_Payment__c();   receivepay.Invoice__c = invLineOpWrapper.allInvoices.Id;
                            receivepay.Payment_Received_Date__c  = System.Today();receivepay.Payment_Form__c = invLineOpWrapper.paymentForm;
                            receivepay.Payment_Amount__c = invLineOpWrapper.productAmount;
                            receivepay.Payment_Memo__c	= invLineOpWrapper.payMemo;  opreceivedpay.add(receivepay);
                            
                        }
                        if(invLineOpWrapper.exciseTax!=0 )
                        {
                            Receive_Payment__c extaxpay = new Receive_Payment__c();
                            extaxpay.RecordTypeId =extaxRecordTypeId;  extaxpay.Invoice__c = invLineOpWrapper.allInvoices.Id;
                            extaxpay.Payment_Received_Date__c  = System.Today();
                            extaxpay.Payment_Form__c = invLineOpWrapper.paymentForm;extaxpay.Payment_Amount__c = invLineOpWrapper.exciseTax;
                            extaxpay.Payment_Memo__c	= invLineOpWrapper.payMemo;
                            opreceivedpay.add(extaxpay); opId.add(invLineOpWrapper.allInvoices.Id);
                        }
                        
                    }
                    
                    if(opupadteinvoice.size() > 0){ updateInvoiceStatus(JSOn.serialize(opupadteinvoice)); insertRecPaymentandInvoice(JSOn.serialize(opreceivedpay),opId);  }
                } 
     
  			
		}           
        }catch(Exception ex){ Database.rollback(savePoint); r.errors.add( SHIPPING_MANIFEST_EXCEPTION_ERROR_UPDATING_RSM_TSM + ex.getMessage());
        }
        return r;
    }
    @future
    public static void fullRejectStatusUpdate(Id bqId, Id orderId){
       
                Brand_Quote__c brandQuoteData = new Brand_Quote__c();
                brandQuoteData.Id = bqId;brandQuoteData.BQ_Status__c = BRAND_QUOTE_STATUS_REJECTED;
                brandQuoteData.Ship_Confirmation_Date__c = System.Today();  Update brandQuoteData; 
                Purchase_Order__c pores = [Select Id,PO_Status__c,Brand_Quote__c From Purchase_Order__c where Brand_Quote__c=:bqId]; 
                if(pores!=NULL){ 
                pores.PO_Status__c = PURCHASE_ORDER_STATUS_REJECTED; 
                                Update pores;}
                  if(orderId!=NULL){ 
                Order__c orderData = new Order__c();orderData.Id = orderId;
                      orderData.Status__c = ORDERCANCELLED_CUSTOMER; Update orderData;  }
    }
    
    //eSign 
    @AuraEnabled 
    public static void saveSign(String base64Data, String contentType, String recordId) { 
        
        List<Shipping_Manifest__c> updateShippingManifest = [SELECT Id, Name, Status__c,Receiver_Contact__r.Name,Receiver_Acceptance_Date__c FROM Shipping_Manifest__c WHERE Id =: recordId];
        base64Data = EncodingUtil.urlDecode(base64Data, SHIPPING_MANIFEST_ESIGN_UNICODE);        
        Attachment a = new Attachment();
        a.parentId = updateShippingManifest[0].Id;
        a.Body = EncodingUtil.base64Decode(base64Data);   
        string rcname = updateShippingManifest[0].Receiver_Contact__r.Name;
        string smName = updateShippingManifest[0].Name;
        Datetime rADate = updateShippingManifest[0].Receiver_Acceptance_Date__c;
        a.Name =smName+SHIPPING_MANIFEST_ESIGN_UNDERSCORE+rcname+SHIPPING_MANIFEST_ESIGN_UNDERSCORE+rADate.format('MM-dd-yyyy HH:mm a')+SHIPPING_MANIFEST_ESIGN_FORMAT;
        a.ContentType = contentType;        
        insert a;    
        
    }
    
     @testVisible
    @future
    public static void updateInventoryPosition(String rsmLinesDataToUpdates, Id rTypeId){
        
        List<Shipping_Manifest_Line__c> rsmLinesToUpdates = (List<Shipping_Manifest_Line__c>)JSON.deserialize(rsmLinesDataToUpdates, List<Shipping_Manifest_Line__c>.class);
        List<Inventory_Position__c> invPositionsObj = new List<Inventory_Position__c>();
        
        if(rTypeId == ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER)){ invPositionsObj = ShipConfirmController.setInvPositionToDelivered(rsmLinesToUpdates,SHIPPING_MANIFEST_RECORDTYPE_TRANSFFERED);
            
        }else if(rTypeId == ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_LAB)){ invPositionsObj = ShipConfirmController.setInvPositionToDelivered(rsmLinesToUpdates,SHIPPING_MANIFEST_RECORDTYPE_TEST_SAMPLED);
        }else{
            
            // Update inventory position to update with Delivered
            invPositionsObj = ShipConfirmController.setInvPositionToDelivered(rsmLinesToUpdates,SHIPPING_MANIFEST_RECORDTYPE_DELIVERED);
        }
      
        upsert invPositionsObj;
        
    }
        
  
    @future
    public static void updateCurretInvoiceStatus(String upadteinvoice){
        List<Invoice__c> invoiceStatus = (List<Invoice__c>)JSON.deserialize(upadteinvoice, List<Invoice__c>.class); update invoiceStatus;
    }
    
    @future
    public static void createCurretreceivePayment(String receivedpay){
        List<Receive_Payment__c> rc = (List<Receive_Payment__c>)JSON.deserialize(receivedpay, List<Receive_Payment__c>.class); insert rc;
    }
    
    
    @future
    public static void updateInvoiceStatus(String opUpadteInvoiceStatus){List<Invoice__c> invoiceStatus = (List<Invoice__c>)JSON.deserialize(opUpadteInvoiceStatus, List<Invoice__c>.class); update invoiceStatus;
                                                                         
                                                                        }
 
    
    @future
    public static void insertRecPaymentandInvoice(String currentreceivedpayJson, Set<ID> currentInvoiceIds){
        List<Receive_Payment__c> currentReceivePayData = (List<Receive_Payment__c>)JSON.deserialize(currentreceivedpayJson, List<Receive_Payment__c>.class);
        insert currentReceivePayData;
        
        List<Invoice__c> currentClStatus = new List<Invoice__c>();
        for(Invoice__c  currentRcData:[Select Id,Invoice_Balance__c,Collections_Status__c From Invoice__c where ID IN :currentInvoiceIds]){
            if(currentRcData.Invoice_Balance__c==0 || currentRcData.Invoice_Balance__c<0){ currentRcData.Collections_Status__c = INVOICE_COLLECTION_STATUS_PAIDFULL;
                                                                                         }
            currentClStatus.add(currentRcData);
        }
        if(currentClStatus.size() > 0) update currentClStatus;
    }
    
   
    
    // get Current Invoice
    public static List<InvoiceLineWrapper> getCurrentInvoice(String recordId, String RecordTypeName){
        
     
        if(RecordTypeName!= SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM && RecordTypeName!= SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION)
        {
            Id serviceRecordTypeId = Schema.SObjectType.Invoice__c .getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_SERVICE).getRecordTypeId();
            Id taxRecordTypeId = Schema.SObjectType.Invoice__c .getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_TAX).getRecordTypeId();
            Id factoringRecordTypeId = Schema.SObjectType.Invoice__c .getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_FACTORING).getRecordTypeId();
            
             List<InvoiceLineWrapper> inWrapper = new List<InvoiceLineWrapper>();
        List <Invoice__c> currentInvoice =  [Select Id, Name, Purchase_Order__c, Excise_Tax_Balance__c,Invoice_Due_Date__c,Sales_Order__c, Invoice_Balance__c, Product_Balance__c From Invoice__c Where Sales_Order__c =:recordId  AND AR_Status__c =:INVOICE_AR_STATUS_APPROVED   AND Invoice_Balance__c > 0.0 AND RecordTypeId!=:serviceRecordTypeId AND RecordTypeId!=:taxRecordTypeId AND RecordTypeId!=:factoringRecordTypeId ORDER BY Name];
        for(Invoice__c currentInvoiceLines : currentInvoice){   InvoiceLineWrapper inLineWrapper = new InvoiceLineWrapper(currentInvoiceLines);  inWrapper.add(inLineWrapper);
        } 
        
        return inWrapper;   
        }else{
            List<InvoiceLineWrapper> inWrapper = new List<InvoiceLineWrapper>(); return inWrapper;
        }
       
    }
    
    // get Pending Invoice
    public static List<InvoiceLineWrapper> getPendingInvoice(Shipping_Manifest__c res){
        List<InvoiceLineWrapper> inWrapper = new List<InvoiceLineWrapper>();
        String receiverName =res.Receiver_Name__c;
        String recordTypeName =res.RecordType.Name ;
        String supplierName =res.Supplier_Name__c ;
        String SalesOrderId =res.Sales_Order__c;
        
        if(recordTypeName== SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM){ List <Invoice__c> pendingInvoice =  [Select Id, Name, Purchase_Order__c, Excise_Tax_Balance__c,Invoice_Due_Date__c,Sales_Order__c,Receiver_Name__c, AR_Status__c,Invoice_Balance__c,Receiver_Contact__c, Product_Balance__c From Invoice__c  Where Supplier_Name__c  =:supplierName AND (AR_Status__c =:INVOICE_AR_STATUS_APPROVED OR AR_Status__c =:INVOICE_AR_STATUS_SHIPPED) AND Invoice_Balance__c > 0.0 ORDER BY Name Limit 2];
             for(Invoice__c pendingInvoiceLines : pendingInvoice){ InvoiceLineWrapper inLineWrapper = new InvoiceLineWrapper(pendingInvoiceLines);  inWrapper.add(inLineWrapper);
           
        }
        
        return inWrapper;  
            
        }else{
            Id serviceRecordTypeId = Schema.SObjectType.Invoice__c .getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_SERVICE).getRecordTypeId();
            Id taxRecordTypeId = Schema.SObjectType.Invoice__c .getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_TAX).getRecordTypeId();
            Id factoringRecordTypeId = Schema.SObjectType.Invoice__c .getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_FACTORING).getRecordTypeId();
            
            List <Invoice__c> pendingInvoice =  [Select Id, Name, Purchase_Order__c, Excise_Tax_Balance__c,Invoice_Due_Date__c,Sales_Order__c,Receiver_Name__c,
                                             AR_Status__c,Invoice_Balance__c,Receiver_Contact__c, Product_Balance__c From Invoice__c 
                                             Where Receiver_Name__c  =: receiverName AND (AR_Status__c =:INVOICE_AR_STATUS_APPROVED OR AR_Status__c =:INVOICE_AR_STATUS_SHIPPED)  AND Sales_Order__c != :SalesOrderId
                                             AND Invoice_Balance__c > 0.0 AND RecordTypeId!=:serviceRecordTypeId AND RecordTypeId!=:taxRecordTypeId AND RecordTypeId!=:factoringRecordTypeId ORDER BY Name limit 2];
          for(Invoice__c pendingInvoiceLines : pendingInvoice){
            InvoiceLineWrapper inLineWrapper = new InvoiceLineWrapper(pendingInvoiceLines); 
            inWrapper.add(inLineWrapper);
        }
        
        return inWrapper;     
        }
       
        
        
    }
    
    
    // Current & Pending Invoice Wrapper Class
    public class InvoiceLineWrapper{
        @AuraEnabled public Invoice__c allInvoices {get; set;}
        @AuraEnabled public Decimal productAmount {get; set;}
        @AuraEnabled public Decimal exciseTax {get; set;}
        @AuraEnabled public Date paymentDueDate {get; set;}
        @AuraEnabled public String paymentForm {get; set;}
        @AuraEnabled public String payMemo {get; set;}
        public Receive_Payment__c receivePaymentSO {get; set;}
        public InvoiceLineWrapper(Invoice__c allInvoices){
            this.allInvoices = allInvoices; 
            this.productAmount = 0; 
            this.exciseTax = 0;
            this.paymentForm ='';
            this.payMemo = '';
            this.paymentDueDate =System.Today();
        }
        public InvoiceLineWrapper(){
            this.allInvoices = allInvoices;
            this.productAmount = 0; 
            this.exciseTax = 0;
            this.paymentForm ='';
            this.payMemo = '';
            this.paymentDueDate =System.Today();
        }
    }
    
    // receiver contact list 
    public static List<Contact> getReceiverContacts(Shipping_Manifest__c res){
        String receiverName =res.Receiver_Name__c;
        List <Contact> conList =[Select Id, Name From Contact where Active__c=TRUE AND Orders_Email_Opt_In__c=TRUE AND Email!=NULL AND accountid =: receiverName order by Name asc ];
        return conList; 
    }
    
    //  rsmline  Wrapper Class
    public class rsmlinesWrapper{
        @AuraEnabled public Shipping_Manifest_Line__c rsmlinesIL {get; set;}  public rsmlinesWrapper(Shipping_Manifest_Line__c rsmlinesIL){this.rsmlinesIL = rsmlinesIL;
        }
        public rsmlinesWrapper(){
            this.rsmlinesIL = rsmlinesIL;
        }
    }
    
    
    // rsm lines instance  Wrapper Class
    public static List<rsmlinesWrapper>  getRsmLines(Id recordID){ 
        // RSM Lines
        List<rsmlinesWrapper> rsmLnWrapper = new List<rsmlinesWrapper>();
        List<Shipping_Manifest_Line__c> ShippingManifestLineValue = [ SELECT ID, Name, Product_Name__r.Name, Shipping_Manifest__r.Name,Purchase_Order_Line__c,
                                                                     Product_Description__c,Producer_Name__c,Retail_Wholesale_Price__c,Actual_Shipment_Qty__c,
                                                                     Shipment_Qty__c,Rejection_Reason__c, Qty_Received__c,
                                                                     Picklist_Line__r.Inventory_Position__c,Picklist_Line__r.Inventory_Position__r.Site__c,
                                                                     SMLine_Status__c,Product_Name__c,Picklist_Line__c,Picklist_Line__r.Sales_Order_Line__r.Sales_Order__c,
                                                                     Picklist_Line__r.Sales_Order_Line__c,Sales_Order_Line__c,Picklist_Line__r.Pack_out_UID__c,Qty_Ordered__c,
                                                                     Unit_Cost__c FROM Shipping_Manifest_Line__c WHERE SMLine_Status__c NOT IN (:SHIPPING_MANIFEST_LINE_STATUS_CANCELLED,:SHIPPING_MANIFEST_LINE_STATUS_REJECTED) AND  
                                                                     Shipping_Manifest__c =:recordID ];
        for(Shipping_Manifest_Line__c rsmres : ShippingManifestLineValue){   rsmlinesWrapper inLinersmlineWrapper = new rsmlinesWrapper(rsmres);  rsmLnWrapper.add(inLinersmlineWrapper);
        }
        return rsmLnWrapper;
    }
    
    // Ship confirm server side validation
    public   Boolean checkSmValidation( List<InvoiceLineWrapper> currentInvoicesData, List<InvoiceLineWrapper> pendingInvoicesData, List<rsmlinesWrapper> validateRsmLines, String rcId){
        
        Boolean hasValidationError = false;
        
        for (rsmlinesWrapper res :validateRsmLines){
            
            Shipping_Manifest_Line__c invObj=res.rsmlinesIL;
            // Qty to receive cannot be null and negative value
            if(invObj!=null && invObj.Qty_Received__c < 0){  smErrorMessage = SHIPPING_MANIFEST_LINE_ERROR_QUANTITY_POSITIVE; hasValidationError = true; break;
               
            }
            // Qty to receive cannot be greater than shipment qty
            if(invObj!=null &&  (invObj.Qty_Received__c > invObj.Shipment_Qty__c)){ smErrorMessage = SHIPPING_MANIFEST_LINE_ERROR_QUANTITY_NOT_GREATER_VALUE; hasValidationError = true;  break;
            }
            
        }
        
        
        // If RSM line input are valid then check for invoice data
        if(!hasValidationError){
            
            List<InvoiceLineWrapper> allInvoices = new List<InvoiceLineWrapper>();
            List<InvoiceLineWrapper> pendingInvoices = pendingInvoicesData;
            List<InvoiceLineWrapper> currentInvoices = currentInvoicesData;
            
            // Add all pending invoices to validate
            if(pendingInvoices != null){
                allInvoices.addAll(pendingInvoices);
            }
            
            // Add all current invoices to validate
            if(currentInvoices != null){
                allInvoices.addAll(currentInvoices);
            }
            
            if(!allInvoices.isEmpty()){
                
                Set<Id> invoiceIds = new Set<Id>();
                Set<String> uniqueRPString = new Set<String>();
                
                // Get all existing invoice ids
                for(InvoiceLineWrapper invoiceWrapper : allInvoices){
                    invoiceIds.add(invoiceWrapper.allInvoices.Id);
                }
                
                // Get all existing related receive payments
                for(Receive_Payment__c rpObj : [Select Invoice__c,
                                                Payment_Amount__c,
                                                Payment_Form__c,
                                                Payment_Memo__c,
                                                Payment_Received_Date__c,
                                                RecordTypeId
                                                From Receive_Payment__c
                                                Where Invoice__c IN: invoiceIds]){  uniqueRPString.add(generateRPParametersString(rpObj.Invoice__c, rpObj.Payment_Amount__c.stripTrailingZeros(), rpObj.Payment_Form__c,rpObj.Payment_Memo__c, rpObj.Payment_Received_Date__c, rpObj.RecordTypeId));
                                                                                 }
                
                for(InvoiceLineWrapper invoiceWrapper : allInvoices){
                    Receive_Payment__c receivePaymentSO = invoiceWrapper.receivePaymentSO;
                    
                    // Payment form value should not be blank if payment or tax amount is > 0
                    if(receivePaymentSO != null &&  (invoiceWrapper.productAmount != null && invoiceWrapper.productAmount > 0 || invoiceWrapper.exciseTax != null && invoiceWrapper.exciseTax > 0) && receivePaymentSO.Payment_Form__c == null){ smErrorMessage =  SHIPPING_MANIFEST_LINE_ERROR_PAYMENT_FORM_REQUIRED;  hasValidationError = true;  break;
                          
                       }else{
                           if(receivePaymentSO != null){  
                               
                               // Check for product amount validation - cannot be greater than invoice balance
                               if(invoiceWrapper.productAmount != null && invoiceWrapper.productAmount > 0 && invoiceWrapper.productAmount > invoiceWrapper.allInvoices.Product_Balance__c){  smErrorMessage = String.format(INVOICE_EXCISE_PRODUCT_AMOUNT_VALIDATION, new List<String>{String.valueOf(invoiceWrapper.productAmount), String.valueOf(invoiceWrapper.allInvoices.Product_Balance__c)});hasValidationError = true;
                                  }
                               
                               // Check for excise tax amount validation - cannot be greater than excise tax balance
                               if(invoiceWrapper.exciseTax != null && invoiceWrapper.exciseTax > 0 && invoiceWrapper.exciseTax > invoiceWrapper.allInvoices.Excise_Tax_Balance__c){
                                      
                                      smErrorMessage = String.format(INVOICE_EXCISE_PRODUCT_TAX_AMOUNT_VALIDATION, new List<String>{String.valueOf(invoiceWrapper.exciseTax), String.valueOf(invoiceWrapper.allInvoices.Excise_Tax_Balance__c)});
                                      hasValidationError = true;
                                      
                                      // Check if existing RP entry is already created - BE-2019-05-0000000209
                                  }else{
                                      String rpString = '';Id recordTypeId = null;
                                      
                                      // Check product amount entry
                                      if(invoiceWrapper.productAmount != null){ recordTypeId = Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get(PRODUCT_RECORD_TYPE_PRODUCT).getRecordTypeId(); rpString = generateRPParametersString(invoiceWrapper.allInvoices.Id, invoiceWrapper.productAmount.stripTrailingZeros(), invoiceWrapper.receivePaymentSO.Payment_Form__c, invoiceWrapper.receivePaymentSO.Payment_Memo__c,invoiceWrapper.receivePaymentSO.Payment_Received_Date__c,recordTypeId);
                                          
                                          if(uniqueRPString.contains(rpString)){ smErrorMessage = String.format(INVOICE_EXCISE_PRODUCT_DUPLICATE_AMOUNT_PAYMENT, new List<String>{String.valueOf(invoiceWrapper.productAmount)});
                                              
                                              hasValidationError = true;
                                          }
                                      }
                                      
                                      // Check Tax Amount entry
                                      if(invoiceWrapper.exciseTax != null){ recordTypeId = Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECEIVE_PAYMENT_RECORDTYPE_EXCISE_TAX).getRecordTypeId(); rpString = generateRPParametersString(invoiceWrapper.allInvoices.Id,invoiceWrapper.exciseTax.stripTrailingZeros(), invoiceWrapper.receivePaymentSO.Payment_Form__c, invoiceWrapper.receivePaymentSO.Payment_Memo__c,invoiceWrapper.receivePaymentSO.Payment_Received_Date__c, recordTypeId);
                                          
                                          if(uniqueRPString.contains(rpString)){  smErrorMessage =  String.format(INVOICE_ERROR_DUPLICATE_TAX_AMOUNT, new List<String>{String.valueOf(invoiceWrapper.exciseTax)});  hasValidationError = true;
                                          }
                                      }
                                  }
                           }
                       }
                }
            }
        }
        
        //check validation for hold issue
        Shipping_Manifest__c sm = [select id ,Purchase_Order__c,Purchase_Order__r.Supplier_Name__r.Hold__c ,Purchase_Order__r.Receiver_Name__r.Hold__c,Purchase_Order__r.Distributor_Name__r.Hold__c,Purchase_Order__r.Supplier_Name__r.DBA__c ,Purchase_Order__r.Receiver_Name__r.DBA__c,Purchase_Order__r.Distributor_Name__r.DBA__c ,Picklist__c,Invoice__c, Sales_Order__c, Payment_Terms__c from  Shipping_Manifest__c where id  =: rcId];
        if(sm.Picklist__c != null){
            picklist__c pick = [select id ,Sales_Order__c from  picklist__c where id  =: sm.Picklist__c];
            Sales_Order__c SOHold = [select id,Supplier_Name__c ,Receiver_Name__c,Distributor_Name__c,Account_Hold_Exception__c, (select id, Sales_Order__c from picklists__r)  from Sales_Order__c where id =: pick.Sales_Order__c];  
            Account  supAcc = [SELECT  id , Hold__c, DBA__c  from Account  where id =:SOHold.Supplier_Name__c];
            Account  recAcc = [SELECT  id , Hold__c, DBA__c  from Account  where id =:SOHold.Receiver_Name__c];
            Account  disAcc = [SELECT  id , Hold__c, DBA__c  from Account  where id =:SOHold.Distributor_Name__c];
            String accountName = '';
            Set<String> my_list = new Set<String>();
            if((supAcc.Hold__c == true || recAcc.Hold__c == true || disAcc.Hold__c == true) && SOHold.Account_Hold_Exception__c == false)
            {
                if(supAcc.Hold__c == true){my_list.add(supAcc.DBA__c);  }
                if(disAcc.Hold__c == true){ my_list.add(disAcc.DBA__c); }
                if(recAcc.Hold__c == true){ my_list.add(recAcc.DBA__c); }
                accountName = String.join(new List<String>(my_list), ', ');  errorMessage = INVOICE_ERROR_ACCOUNT_HOLD + accountName + INVOICE_ACCOUNT_HOLD_FINANACE_TEAM;
                smErrorMessage = errorMessage; hasValidationError = true;
                
            }
        }else if(sm.Purchase_Order__c != null){ List<String> holdAccounts = new List<String>();
            if(sm.Purchase_Order__r.Supplier_Name__r.Hold__c == true || sm.Purchase_Order__r.Receiver_Name__r.Hold__c == true || sm.Purchase_Order__r.Distributor_Name__r.Hold__c == true){
                if(sm.Purchase_Order__r.Supplier_Name__r.Hold__c == true){ holdAccounts.add(sm.Purchase_Order__r.Supplier_Name__r.DBA__c);}
                if(sm.Purchase_Order__r.Receiver_Name__r.Hold__c == true){ holdAccounts.add(sm.Purchase_Order__r.Receiver_Name__r.DBA__c); }
                if(sm.Purchase_Order__r.Distributor_Name__r.Hold__c == true){ holdAccounts.add(sm.Purchase_Order__r.Distributor_Name__r.DBA__c);}
                String accountNames = String.join(new List<String>(holdAccounts), ', ');   errorMessage = INVOICE_ERROR_ACCOUNT_HOLD + accountNames + INVOICE_ACCOUNT_HOLD_FINANACE_TEAM;
                smErrorMessage = errorMessage;  hasValidationError = true; 
            }
        }
        
        return hasValidationError;
        
    } 

    @AuraEnabled
    public static AuraResponse updateBqAndOrderLineItems(Id soId) { 
        
        AuraResponse r = new AuraResponse('updateBqAndOrderLineItems()'); 
        RSMTSMShipConfirmCotroller assign = new RSMTSMShipConfirmCotroller();
        
        List<Sales_Order__c> soRes = new List<Sales_Order__c>();
        List<Sales_Order_Line__c> items = new List<Sales_Order_Line__c>(); Map<Id,Brand_Quote_Line__c> BQLineMap = new Map<Id,Brand_Quote_Line__c>();
        Set<Id> SOLIds = new Set<Id>();
        Set<Id> bqId = new Set<Id>();Set<Id> bqLineIds = new Set<Id>();
        soRes = [SELECT Id, Name,Brand_Quote__c,(SELECT Id, Name,Brand_Quote_Line__c, Status__c,Qty_Ordered__c,MOQ__c FROM Sales_Order_Lines__r)  FROM Sales_Order__c WHERE Id=: soId ];
        
        for(Sales_Order__c sRes : soRes){ bqId.add(sRes.Brand_Quote__c);  for(Sales_Order_Line__c sli : sRes.Sales_Order_Lines__r){ BQLineMap.put(sli.Brand_Quote_Line__c,new Brand_Quote_Line__c(Id = sli.Brand_Quote_Line__c,Status__c = sli.Status__c,Quantity_Cases__c = sli.Qty_Ordered__c/sli.MOQ__c));  
                                                                                                                                   SOLIds.add(sli.Id);  bqLineIds.add(sli.Brand_Quote_Line__c);
                                                                                                                                  }
                                        }
        
        if(SOLIds.size() > 0){items = [SElECT Status__c,Qty_Ordered__c,MOQ__c,Qty_Allocated__c, Balance_Qty_to_Allocate__c ,Brand_Quote_Line__c, Sales_Order__c  FROM Sales_Order_Line__c WHERE Id IN: SOLIds AND Sales_Order__r.SO_Status__c =: SO_STATUS_DRAFT];
                              List<Brand_Quote_Line__c> BQLToUpdate = new List<Brand_Quote_Line__c>();
                              for(Sales_Order_Line__c sli: items){Brand_Quote_Line__c bql = new Brand_Quote_Line__c();
                                                                  if(sli.Brand_Quote_Line__c != null){  bql = new Brand_Quote_Line__c(Id = sli.Brand_Quote_Line__c,Status__c = sli.Status__c,Quantity_Cases__c=sli.Qty_Ordered__c/sli.MOQ__c);  
                                                                                                     }
                                                                  if(bql != null && bql.Id != null){BQLineMap.put(sli.Brand_Quote_Line__c,bql);    
                                                                                                   }
                                                                  
                                                                 }
                              if(BQLineMap.size() > 0){update BQLineMap.values();
                                                      }
                              
                              List<Purchase_Order_Line__c> polineList = new List<Purchase_Order_Line__c>();
                              List<Purchase_Order_Line__c> polineToUpdate = new List<Purchase_Order_Line__c>();
                              
                              polineList= [select Id,Brand_Quote_Line__c,Brand_Quote_Line__r.Line_Total_Qty__c  from Purchase_Order_Line__c where Brand_Quote_Line__c IN:bqLineIds];
                              if(polineList.size()>0 ){for(Purchase_Order_Line__c po: polineList){ 
                                  Purchase_Order_Line__c poIoood = new Purchase_Order_Line__c();
                                  poIoood.Id = po.Id;  poIoood.Qty_Ordered__c =  po.Brand_Quote_Line__r.Line_Total_Qty__c; 
                                  polineToUpdate.add(poIoood);
                              }
                                                       if(polineToUpdate.size() >0) {update polineToUpdate;  
                                                                                    }
                                                      }
                              
                             }
        
        return r; 
    }


    
}