/**
* Copyright (c) 2018 WOVN
* All rights reserved.
* SMRescheduleController
*/
public class SMRescheduleController{
    private static String EARLIEST_DELIVERY_TIME {
        get{
            return String.isNotBlank(EARLIEST_DELIVERY_TIME) ? EARLIEST_DELIVERY_TIME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Earliest_Delivery_Time');
        }set;
    }
    private static String LATEST_DELIVERY_TIME { 
        get{
            return String.isNotBlank(LATEST_DELIVERY_TIME) ? LATEST_DELIVERY_TIME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Latest_Delivery_Time');
        }set;
    }
    private static String RECURSYEARLY{
        get{
            return String.isNotBlank(RECURSYEARLY) ? RECURSYEARLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursYearly');
        }set;
    }
    private static String RECURSYEARLYNTH{
        get{
            return String.isNotBlank(RECURSYEARLYNTH) ? RECURSYEARLYNTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursYearlyNth');
        }set;
    }
    public static String HOLIDAY_RECURSMONTHLY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSMONTHLY) ? HOLIDAY_RECURSMONTHLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursMonthly');
        }set;
    }
    public static String HOLIDAY_RECURSMONTHLYNTH{
        get{
            return String.isNotBlank(HOLIDAY_RECURSMONTHLYNTH) ? HOLIDAY_RECURSMONTHLYNTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursMonthlyNth');
        }set;
    }
    public static String HOLIDAY_RECURSWEEKLY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSWEEKLY) ? HOLIDAY_RECURSWEEKLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursWeekly');
        }set;
    }
    public static String HOLIDAY_RECURSDAILY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSDAILY) ? HOLIDAY_RECURSDAILY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursDaily');
        }set;
    }
    public static String HOLIDAY_RECURSEVERYWEEKDAY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSEVERYWEEKDAY) ? HOLIDAY_RECURSEVERYWEEKDAY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursEveryWeekday');
        }set;
    }
    public static String JANUARY_MONTH{
        get{
            return String.isNotBlank(JANUARY_MONTH) ? JANUARY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','January_Month');
        }set;
    }
    public static String FEBRUARY_MONTH{
        get{
            return String.isNotBlank(FEBRUARY_MONTH) ? FEBRUARY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','February_Month');
        }set;
    }
    public static String MARCH_MONTH{
        get{
            return String.isNotBlank(MARCH_MONTH) ? MARCH_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','March_Month');
        }set;
    }
    public static String APRIL_MONTH{
        get{
            return String.isNotBlank(APRIL_MONTH) ? APRIL_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','April_Month');
        }set;
    }
    public static String MAY_MONTH{
        get{
            return String.isNotBlank(MAY_MONTH) ? MAY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','May_Month');
        }set;
    }
    public static String JUNE_MONTH{
        get{
            return String.isNotBlank(JUNE_MONTH) ? JUNE_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','June_Month');
        }set;
    }
    public static String JULY_MONTH{
        get{
            return String.isNotBlank(JULY_MONTH) ? JULY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','July_Month');
        }set;
    }
    public static String AUGUST_MONTH{
        get{
            return String.isNotBlank(AUGUST_MONTH) ? AUGUST_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','August_Month');
        }set;
    }
    public static String SEPTEMBER_MONTH{
        get{
            return String.isNotBlank(SEPTEMBER_MONTH) ? SEPTEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','September_Month');
        }set;
    }
    public static String OCTOBER_MONTH{
        get{
            return String.isNotBlank(OCTOBER_MONTH) ? OCTOBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','October_Month');
        }set;
    }
    public static String NOVEMBER_MONTH{
        get{
            return String.isNotBlank(NOVEMBER_MONTH) ? NOVEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','November_Month');
        }set;
    }
    public static String DECEMBER_MONTH{
        get{
            return String.isNotBlank(DECEMBER_MONTH) ? DECEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','December_Month');
        }set;
    }
    public static String HOLIDAY_RECURRENCE_FIRST{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_FIRST) ? HOLIDAY_RECURRENCE_FIRST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_First');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_SECOND{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_SECOND) ? HOLIDAY_RECURRENCE_SECOND : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Second');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_THIRD{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_THIRD) ? HOLIDAY_RECURRENCE_THIRD : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Third');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_FOURTH{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_FOURTH) ? HOLIDAY_RECURRENCE_FOURTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Fourth');
        }set;
    }
    public static String HOLIDAY_RECURRENCE_LAST{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_LAST) ? HOLIDAY_RECURRENCE_LAST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Last');
        }set;
    }
    
    
    public static String PRODUCT_RECORD_TYPE_NAME_DISCOUNT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_DISCOUNT) ? PRODUCT_RECORD_TYPE_NAME_DISCOUNT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Discount');
        }set;
    }
    public Static String PRODUCT_NAME_MILEAGE_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_MILEAGE_FEE) ? PRODUCT_NAME_MILEAGE_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Mileage_Fee');
        }set;
    }
    public static String TYPE_ADD_RETAIL_CONTACT{
        get{
            return String.isNotBlank(TYPE_ADD_RETAIL_CONTACT) ? TYPE_ADD_RETAIL_CONTACT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Retailer_Related_Contact__c','Type_Add_Retail_Contact');
        }set;
    }
    public static String TYPE_ADD_BRAND_CONTACT{
        get{
            return String.isNotBlank(TYPE_ADD_BRAND_CONTACT) ? TYPE_ADD_BRAND_CONTACT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Retailer_Related_Contact__c','Type_Add_Brand_Contact');
        }set;
    }
    public static String DL_ASR{
        get{
            return String.isNotBlank(DL_ASR) ? DL_ASR : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','DL_ASR');
        }set;
    }
    public Static String PRODUCT_NAME_WEIGHT_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_WEIGHT_FEE) ? PRODUCT_NAME_WEIGHT_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Weight_Fee');
        }set;
    }
    
    public Static String PRODUCT_NAME_SCHEDULE_AND_DISPATCH{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_SCHEDULE_AND_DISPATCH) ? PRODUCT_NAME_SCHEDULE_AND_DISPATCH :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Schedule_And_Dispatch');
        }set;
    }
    public Static String PRODUCT_NAME_STAGE_AND_MANIFEST{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_STAGE_AND_MANIFEST) ? PRODUCT_NAME_STAGE_AND_MANIFEST :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Stage_And_Manifest');
        }set;
    }
    
    public Static String SO_ORDER_TYPE_BRAND {
        get{
            return String.isNotBlank(SO_ORDER_TYPE_BRAND) ? SO_ORDER_TYPE_BRAND:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Type_Brand');
        }set;
    }
    
    
    public static String SO_Status_Draft{
        get{
            return String.isNotBlank(SO_Status_Draft) ? SO_Status_Draft : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Draft');
        }set;
    }
    public static String SO_Status_Cancelled{
        get{
            return String.isNotBlank(SO_Status_Cancelled) ? SO_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Cancelled');
        }set;
    }
    public static String SO_Status_Rejected{
        get{
            return String.isNotBlank(SO_Status_Rejected) ? SO_Status_Rejected : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Rejected');
        }set;
    }
    private Static String INVOICE_LINE_RECORDTYPE_SERVICE { 
        get{
            return  String.isNotBlank(INVOICE_LINE_RECORDTYPE_SERVICE) ? INVOICE_LINE_RECORDTYPE_SERVICE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice Line','Invoice_Line_RecordType_Service');
        }set;
    }
    public static String Sales_Order_Status_Approved{
        get{
            return String.isNotBlank(Sales_Order_Status_Approved) ? Sales_Order_Status_Approved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Approved');
        }set;
    }
    public static String Sales_Order_Line_Status_Cancelled{
        get{
            return String.isNotBlank(Sales_Order_Line_Status_Cancelled) ? Sales_Order_Line_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Cancelled');
        }set;
    }
    public static String Sales_Order_Line_Status_Open{
        get{
            return String.isNotBlank(Sales_Order_Line_Status_Open) ? Sales_Order_Line_Status_Open : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Open');
        }set;
    }
    
    private Static String ORDER_TYPE_TRANSFER {
        get{
            return String.isNotBlank(ORDER_TYPE_TRANSFER) ? ORDER_TYPE_TRANSFER :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Transfer');
        }set;
    } 
    public static String ACCOUNT_PLATEFORMLEVEL_ADVANCE {
        get{
            return String.isNotBlank(ACCOUNT_PLATEFORMLEVEL_ADVANCE ) ? ACCOUNT_PLATEFORMLEVEL_ADVANCE  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Plateformlevel_Advance');
        }set;
    }
    public static String Account_Plateformlevel_ZASP {
        get{
            return String.isNotBlank(Account_Plateformlevel_ZASP ) ? Account_Plateformlevel_ZASP  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_DBA_ZASP');
        }set;
    }
    public static String Account_Plateformlevel_IRR {
        get{
            return String.isNotBlank(Account_Plateformlevel_IRR ) ? Account_Plateformlevel_IRR  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_DBA_IRR');
        }set;
    }
    public static String STATE_LICENSE_ACTIVE{
        get{
            return String.isNotBlank(STATE_LICENSE_ACTIVE) ? STATE_LICENSE_ACTIVE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_Active');
        }set;
    }
    public static String STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE{
        get{
            return String.isNotBlank(STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE) ? STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_License_Holder_RecordType');
        }set;
    }
    public static String STATE_LICENSE_NONCANNABIS_RECORDTYPE{
        get{
            return String.isNotBlank(STATE_LICENSE_NONCANNABIS_RECORDTYPE) ? STATE_LICENSE_NONCANNABIS_RECORDTYPE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_NonCannabis_RecordType');
        }set;
    }
    public static String ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER) ? ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Financial_Interest_Holder');
        }set;
    }
    
    
    private static String FULFILLMENT_SERVICE_CHANGE_FEE{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_CHANGE_FEE) ? FULFILLMENT_SERVICE_CHANGE_FEE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Change');
        }set;
    }
    public static String Insufficient_Funds_Revision_Code{
        get{
            return String.isNotBlank(Insufficient_Funds_Revision_Code) ? Insufficient_Funds_Revision_Code : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Revision','Insufficient_Funds_Revision_Code');
        }set;
    }
    public static String Retailer_Request_Revision_Code{
        get{
            return String.isNotBlank(Retailer_Request_Revision_Code) ? Retailer_Request_Revision_Code : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Revision','Retailer_Request_Revision_Code');
        }set;
    }
    public Static String INVOICE_RECORDTYPE_SERVICE{
        get{
            return String.isNotBlank(INVOICE_RECORDTYPE_SERVICE) ? INVOICE_RECORDTYPE_SERVICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
    public Static String INVOICE_AR_STATUS_REJECTED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_REJECTED) ? INVOICE_AR_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Rejected');
        }set;
    }
    public Static String INVOICE_AR_STATUS_CANCELLED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_CANCELLED) ? INVOICE_AR_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Cancelled');
        }set;
    }
    public Static String Clerical_Error_Reason_Code{
        get{
            return String.isNotBlank(Clerical_Error_Reason_Code) ? Clerical_Error_Reason_Code: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Revision','Clerical_Error_Reason_Code');
        }set;
    }
    public static boolean isRescheduled = false;
    private ApexPages.StandardController stdController;
    private Shipping_Manifest__c rsmObj = null;
    public static String messagelightning;
    public static Shipping_Manifest__c rsmObj;
    public static Boolean byCustomer;
    public static Boolean byFiligreen;
    public static String notes;
    public static String ReasonCodes;
    public static Date newShipDate;
    public static Date oldOdrDate;
    public static String startTime;
    public static String endTime;
    @AuraEnabled public String recordName {get; set;}
    
    public SMRescheduleController()
    {
        byCustomer = byFiligreen = false;
    }
    // Constructor
    public SMRescheduleController(ApexPages.StandardController controller) {
        this.stdController = controller;
        rsmObj = (Shipping_Manifest__c)stdController.getRecord();
    }
    
    public class UserException extends Exception{ }
    
    
    
    /**
* Perform actions related to SM Reschedule 
*
* @return PageReference of RSM detail page
*/
    public PageReference smReschedule() {
        PageReference pageRef = null;
        Savepoint savePoint;
        
        try {
            
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            rsmObj = retrieveRSMAndLines();
            
            // Check validation 
            if(checkValidation()){
                return null;
            }
            
            // If all validation pass then update RSM and Picklist
            updateRSMAndPicklist();
        }catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('SMRescheduleController:smReschedule()', ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(msg);
            return null;
        }
        return redirectToRSM();
    }
    @AuraEnabled
    public static AuraResponse rescheduleByCustomer (String recordId ,String schedule,String ReasonCodeStr, String NotesStr,Date shipDate,String startTimeStr ,String endTimeStr) {
        
        AuraResponse r = new AuraResponse('SMRescheduleController.rescheduleByCustomer()');
        SMRescheduleController assign = new SMRescheduleController();
        Savepoint savePoint;
        try {
            if(schedule == 'customer'){
                byCustomer = true;
            }else if(schedule == 'filigreen'){
                byFiligreen = true; 
            }
            notes = NotesStr == null ? '' : NotesStr;
            startTime =startTimeStr;
            endTime = endTimeStr;
            if(ReasonCodeStr != '' && ReasonCodeStr != null){
                ReasonCodes = ReasonCodeStr;
            }
                
            if(shipDate != null ){ newShipDate = shipDate;
                                 }
            savePoint = Database.setSavepoint();
            assign.rsmObj= assign.retrieveRSMAndLineslight(recordId) ;
            if(assign.checkValidationlight()){
                r.data.put('messagelightning', messagelightning);
                return r;
            }
            
            assign.updateRSMAndPicklist(); 
        }catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('SMRescheduleController:smReschedule()', ex.getStackTraceString(), ex.getMessage());
            return r;
        }
        return r;
    }
    @AuraEnabled
    public static AuraResponse smRescheduleLight (String recordId ,String schedule) {
        
        AuraResponse r = new AuraResponse('SMRescheduleController.smRescheduleLight()');
        SMRescheduleController assign = new SMRescheduleController();
        Savepoint savePoint;
        try {
            if(schedule == 'filigreen'){  byFiligreen = true; 
                                       } else if(schedule == 'customer'){  byCustomer = true;
                                                                        }
            savePoint = Database.setSavepoint();
            assign.rsmObj= assign.retrieveRSMAndLineslight(recordId) ;
            if(assign.checkValidationlight()){
                r.data.put('messagelightning', messagelightning);
                return r;
            }
            
            assign.updateRSMAndPicklist(); 
        }catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('SMRescheduleController:smReschedule()', ex.getStackTraceString(), ex.getMessage());
            return r;
        }
        return r;
    }
    
    public   Shipping_Manifest__c retrieveRSMAndLineslight(string  recordId) {
        
        return  [Select Ship_Confirmation_Date__c,
                 Actual_Arrival_Date_Time__c,
                 Actual_Departure_Date_Time__c,
                 Receiver_Acceptance_Date__c,Order_Number__c,Planned_Ship_Transfer_Date__c,Ownership__r.Service_Type__c,
                 PickList__c,Sales_Order__c,Sales_Order__r.Total_Manifest_Revision__c,Sales_Order__r.Total_Revision__c,
                 Sales_Order__r.Supplier_Name__r.Membership_Level__c,Sales_Order__r.Site__c,Sales_Order__r.Opportunity_Name__r.Order__c,
                 Sales_Order__r.Total_Manifest_Change_Fee__c,Sales_Order__r.Total_Weight_Fee__c,Rescheduled_Approved__c,
                 Sales_Order__r.Brand_Quote__c,Sales_Order__r.Opportunity_Name__c,Opportunity_Name__r.Order__c,
                 Sales_Order__r.Total_Mileage_Fee__c,Sales_Order__r.Stage_Manifest_Fee__c,Status__c,Ownership__c,
                 Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,
                 Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c,
                 (Select Picklist_Line__r.Inventory_Position__c,RecordTypeId,
                  Picklist_Line__r.Inventory_Position__r.Site__c, SMLine_Status__c,Product_Name__r.Name
                  From Shipping_Manifest_Lines__r 
                  WHERE SMLine_Status__c NOT IN (:RSMSupport.STATUS_CANCELLED, 
                                                 :RSMSupport.STATUS_REJECTED)
                  ORDER By Name)
                 From Shipping_Manifest__c
                 Where Id =: recordId];
        
    }
    
    /**
* Retrieve RSM with lines record
*
* @return The RSM with lines record
*/         
    public Shipping_Manifest__c retrieveRSMAndLines() {
        
        return  [Select Ship_Confirmation_Date__c,Driver__c,Vehicle__c,Window_End__c,Window_Start__c,Route_Start_Time__c,
                 Actual_Arrival_Date_Time__c,Planned_Ship_Transfer_Date__c,Route_End_Time__c,
                 Actual_Departure_Date_Time__c,Sales_Order__r.Brand_Quote__c,Rescheduled_Approved__c,
                 Receiver_Acceptance_Date__c,Order_Number__c,Ownership__c,Ownership__r.Service_Type__c,
                 PickList__c,Sales_Order__c,Sales_Order__r.Total_Manifest_Revision__c,
                 Sales_Order__r.Total_Manifest_Change_Fee__c,Sales_Order__r.Total_Weight_Fee__c,Sales_Order__r.Total_Revision__c,
                 Sales_Order__r.Supplier_Name__r.Membership_Level__c,Sales_Order__r.Site__c,Sales_Order__r.Opportunity_Name__r.Order__c,
                 Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,
                 Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c,
                 Sales_Order__r.Total_Mileage_Fee__c,Sales_Order__r.Stage_Manifest_Fee__c,Status__c,
                 (Select Picklist_Line__r.Inventory_Position__c,RecordTypeId,
                  Picklist_Line__r.Inventory_Position__r.Site__c, SMLine_Status__c,Product_Name__r.Name
                  From Shipping_Manifest_Lines__r 
                  WHERE SMLine_Status__c NOT IN (:RSMSupport.STATUS_CANCELLED, 
                                                 :RSMSupport.STATUS_REJECTED)
                  ORDER By Name)
                 From Shipping_Manifest__c
                 Where Id =: rsmObj.Id];
        
    }
    
    /**
* Perform validation of to reschedule RSM
*
* @return Boolean flag to indicate if any validation fails
*/
    public Boolean checkValidation(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        String missingFieldError = '';
        if(rsmObj.Status__c != RSMSupport.STATUS_IN_TRANSIT &&
           rsmObj.Status__c != RSMSupport.STATUS_SHIPMENT_PENDING){
               hasValidationError = true;
               missingFieldError = Label.SM_Reschedule_Status_Validation;
           }
        
        if(hasValidationError){
            message = new ApexPages.Message(ApexPages.Severity.ERROR, missingFieldError);
            ApexPages.addMessage(message);
        }
        return hasValidationError;
    }
    public  Boolean checkValidationlight(){
        
        Boolean hasValidationError = false;
        // Check for Driver value
        if(rsmObj.Status__c != RSMSupport.STATUS_IN_TRANSIT &&
           rsmObj.Status__c != RSMSupport.STATUS_SHIPMENT_PENDING) {
               hasValidationError = true;
               messagelightning = Label.SM_Reschedule_Status_Validation;
           }
        
        
        return hasValidationError;
    }  
    /**
* Update RSM and Picklist
*/         
    public void updateRSMAndPicklist() {
        rsmObj.Status__c = RSMSupport.STATUS_DRAFT;
        rsmObj.Actual_Departure_Date_Time__c = null;
        
        rsmObj.Driver__c =null;
        rsmObj.Vehicle__c =null;
        if(startTime != NULL && startTime != ''){
            String[] eTimeWithSpace = startTime.split(' ');
            String[] eTime = eTimeWithSpace[0].split(':');
            rsmObj.Window_Start__c = Time.newInstance((eTimeWithSpace[1].equalsIgnoreCase('pm') && Integer.valueOf(eTime[0]) != 12 ?(Integer.valueOf(eTime[0])+12):Integer.valueOf(eTime[0])),Integer.valueOf(eTime[1]), 0, 0); 
            
            /*String[] eTime = startTime.split(':');
            rsmObj.Window_Start__c = Time.newInstance(Integer.valueOf(eTime[0]),Integer.valueOf(eTime[1]), 0, 0);   */
        }else{
            rsmObj.Window_Start__c=null;
        }
        if(endTime != NULL && endTime != ''){
            String[] lTimeWithSpace = endTime.split(' ');
            String[] lTime = lTimeWithSpace[0].split(':');
            rsmObj.Window_End__c  = Time.newInstance((lTimeWithSpace[1].equalsIgnoreCase('pm') && Integer.valueOf(lTime[0]) != 12 ?(Integer.valueOf(lTime[0])+12):Integer.valueOf(lTime[0])),Integer.valueOf(lTime[1]), 0, 0); 
            
            /*String[] lTime = endTime.split(':');    
            rsmObj.Window_End__c = Time.newInstance(Integer.valueOf(lTime[0]), Integer.valueOf(lTime[1]), 0, 0);*/
        }else{
            rsmObj.Window_End__c=null;
        }
        
        
        rsmObj.Route_Start_Time__c =null;
        rsmObj.Route_End_Time__c =null;
         isRescheduled = true;
        
        if(newShipDate != null){
        
            List<Order__c> ord = [SELECT id,Request_Ship_Date__c,IsRescheduled__c FROM Order__c WHERE id =: rsmObj.Opportunity_Name__r.Order__c];
            if(ord.size() >0 ){
                
                ord[0].Request_Ship_Date__c = newShipDate; 
                update ord[0];
            }
        
            oldOdrDate = rsmObj.Planned_Ship_Transfer_Date__c;
        }else{
            rsmObj.Rescheduled_Approved__c  =false;
        }
        
        	rsmObj.Planned_Ship_Transfer_Date__c = newShipDate;
       
        update rsmObj;
        
        
        
        Set<Id> invPositionIds = new Set<Id>();
        List<Inventory_Position__c> invPositions = new List<Inventory_Position__c>();
        Set<Id> siteIds = new Set<Id>();
        List<Shipping_Manifest_Line__c> rsmLines = rsmObj.Shipping_Manifest_Lines__r;
        
        if(rsmLines == null || rsmLines.size() == 0){  return;
                                                    }
        
        for(Shipping_Manifest_Line__c rsmLineObj : rsmLines){
            invPositionIds.add(rsmLineObj.Picklist_Line__r.Inventory_Position__c);
            siteIds.add(rsmLineObj.Picklist_Line__r.Inventory_Position__r.Site__c);
            
        }
        update rsmLines;
        
        invPositions = [Select Site__c, 
                        Inventory_Location__c,
                        Rack__c, 
                        Rack_Level__c, 
                        Bin_Location__c
                        From Inventory_Position__c 
                        Where Id IN: invPositionIds];
        if(byCustomer == true || byFiligreen == true){
            
            if( (byCustomer ||  byFiligreen == true) && rsmObj.Sales_Order__c != null ){//&& (ReasonCodes == Insufficient_Funds_Revision_Code || ReasonCodes == Retailer_Request_Revision_Code)) 
                Sales_Order__c so = new Sales_Order__c();
                so.Id = rsmObj.Sales_Order__c;
                Decimal totalRevision = rsmObj.Sales_Order__r.Total_Manifest_Revision__c != null ? rsmObj.Sales_Order__r.Total_Manifest_Revision__c + 1 : 1;
                so.Total_Manifest_Revision__c = totalRevision ;
                
                
                Decimal changeFee = 0;
                Decimal totalMileageFee = 0;
                if(rsmObj.Sales_Order__r.Supplier_Name__r.Membership_Level__c != NULL){
                    Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c, Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c ,Membership_Level__c
                                                             FROM Fulfillment_Rates_Table__c 
                                                             WHERE Site__c = :rsmObj.Sales_Order__r.Site__c
                                                             AND Active__c = true
                                                             AND Rate_Effective_From__c <= :System.today()
                                                             AND Rate_Effective_To__c >= :System.today()
                                                             AND Membership_Level__c = :rsmObj.Sales_Order__r.Supplier_Name__r.Membership_Level__c
                                                             AND Fulfillment_Services__c = :FULFILLMENT_SERVICE_CHANGE_FEE
                                                             ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
                    if(FRTList.size() > 0){  changeFee = FRTList[0].Bracket_Price__c;
                                          }
                    Shipping_Rates_Table__c [] mileageSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, 
                                                                 Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Membership_Level__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c
                                                                 FROM Shipping_Rates_Table__c 
                                                                 WHERE Site__c =: rsmObj.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c
                                                                 AND Active__c = true
                                                                 AND Rate_Effective_From__c <= :System.today()
                                                                 AND Rate_Effective_To__c >= :System.today()
                                                                 AND Membership_Level__c = :rsmObj.Sales_Order__r.Supplier_Name__r.Membership_Level__c
                                                                 Order By Mileage_Bracket__c];
                    //calculate Total Mileage Fee
                    if(!mileageSRTList.isEmpty() && rsmObj.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c != null){
                        for(Shipping_Rates_Table__c SRT: mileageSRTList){
                            if(rsmObj.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c <= SRT.Mileage_Bracket__c && rsmObj.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c == SRT.Site__c  && rsmObj.Sales_Order__r.Supplier_Name__r.Membership_Level__c == SRT.Membership_Level__c){
                                if(SRT.Fixed_Mileage_Fee__c){
                                    totalMileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                                }else{
                                    totalMileageFee = SRT.Mileage_Bracket_Price__c * rsmObj.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c;
                                }
                                break;
                            }
                        } 
                    }
                }
                
                Decimal version = 1;
                List<Order_Revision__c> revisions = [SELECT Id, Change_Fee__c, Membership_Level__c, Revision_Reason__c,Sales_Order__c, Sales_Order_Line__c , Version__c FROM Order_Revision__c  WHERE Sales_Order__c = :so.Id ORDER BY Sales_Order__c, Version__c DESC];
                if(revisions.size() > 0){
                    version = (revisions[0].Version__c != NULL ?revisions[0].Version__c+1:1);
                }
               
                
                Order_Revision__c ordRev = new Order_Revision__c();
                ordRev.Sales_Order__c = so.Id;
                ordRev.Version__c = version;
                ordRev.Order__c = rsmObj.Order_Number__c;
                ordRev.Revision_Reason__c = byCustomer ? 'Reschedule By Customer' : 'Reschedule By WOVN';
                
                ordRev.Shipping_Manifest__c = rsmObj.Id;
                if(byCustomer) ordRev.Change_Fee__c = changeFee;
                else
                    ordRev.Change_Fee__c = 0;
                ordRev.Reason_code__c = ReasonCodes;
                ordRev.Notes__c = notes;
                ordRev.Membership_Level__c  = rsmObj.Sales_Order__r.Supplier_Name__r.Membership_Level__c;
                ordRev.Order__c = rsmObj.Sales_Order__r.Opportunity_Name__r.Order__c;
                ordRev.Opportunity__c = rsmObj.Sales_Order__r.Opportunity_Name__c;
                ordRev.Brand_Quote__c = rsmObj.Sales_Order__r.Brand_Quote__c;
                insert ordRev;
                
                
                Decimal totalWeightFee = rsmObj.Sales_Order__r.Total_Weight_Fee__c != null ? rsmObj.Sales_Order__r.Total_Weight_Fee__c : 0;
                
                Decimal totalStageManifestFee = rsmObj.Sales_Order__r.Stage_Manifest_Fee__c != null ? rsmObj.Sales_Order__r.Stage_Manifest_Fee__c : 0;
                Decimal totalFee = ((totalRevision + 1) * totalWeightFee ) + ((totalRevision + 1) * totalMileageFee) + ((totalRevision + 1) * totalStageManifestFee);
                so.Total_Manifest_Change_Fee__c =  totalFee ;//+DeliveryReschedulingFee
                if(byCustomer ){
                    update so;
                    List<Invoice__c> invObj = new List<Invoice__c>();
                    invObj = [SELECT Id,AR_Status__c,(Select id,Invoice_Qty__c,Sales_Order_Line__c,Product_Name__r.Name From Invoice_Lines__r) FROM Invoice__c WHERE Sales_Order__c =: rsmObj.Sales_Order__c AND RecordType.Name =:INVOICE_RECORDTYPE_SERVICE AND AR_Status__c NOT IN (:INVOICE_AR_STATUS_REJECTED,:INVOICE_AR_STATUS_CANCELLED) LIMIT 1];
                    if(invObj.size() >0){
                        
                        updateServiceInvoice(rsmObj.Sales_Order__c,invObj[0]);
                    }
                    
                    
                    
                }
                if(rsmObj.Opportunity_Name__r.Order__c != null && ReasonCodes != Clerical_Error_Reason_Code ){
                    
                    sendEmailByWovn(rsmObj.Opportunity_Name__r.Order__c,newShipDate,ReasonCodes);
                    isRescheduled = true;
                }
                
            }else{
                /*if(rsmObj.Opportunity_Name__r.Order__c != null){
                    //Sales_Order__c so = [SELECT id,Opportunity_Name__r.Order__c FROM Sales_Order__c WHERE id =: rsmObj.Sales_Order__c];
                    //if(so.Opportunity_Name__r.Order__c != null)
                    sendEmailByWovn(rsmObj.Opportunity_Name__r.Order__c);
                }*/
            }
            InventoryPositionSupport.updateInvPositions(invPositions, siteIds, PicklistSupport.STATUS_QA_CONFIRM); 
        } else {
            InventoryPositionSupport.updateInvPositions(invPositions, siteIds, PicklistSupport.STATUS_QA_REVIEW);
        }
        //InventoryPositionSupport.updateInvPositions(invPositions, siteIds, PicklistSupport.STATUS_QA_REVIEW);
    }
    @future
    public static void sendEmailByWovn(string odrId ,Date ShipDate,String reasonCode){
        newShipDate = ShipDate;
        ReasonCodes = reasonCode;
        system.debug('##odrId :'+odrId );
        orgwideemailaddress orgWide = [select Id,Address, displayName from orgwideemailaddress where displayName =: 'DL-Orders' limit 1];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        //Get your document from document Object
        List<Document> doc = new List<Document>();
        doc = [SELECT Id, Name, Body, ContentType, DeveloperName, Type FROM Document WHERE DeveloperName =: 'X8300'];
        Order__c ord = [SELECT Id,Name,Request_Ship_Date__c,Account__c,Customer__c,Customer__r.Email,Requested_Delivery_Earliest_Time__c,Retailer_DBA__c,Account_DBA__c,Account__r.DBA__c,Retailer__r.Third_Party_Scheduler__c,
                        Requested_Delivery_Latest_Time__c,Retailer__r.DBA__c,Retailer__r.ShippingAddress,Retailer_PO__c,Total_Product_Price__c,Sample_Order__c,Planned_Ship_Date__c,
                        Total__c,Payment_Terms__c,Total_Excise_Tax_Amount__c,State_License__r.License_Number__c,IsRescheduled__c,Additional_Brand_Contact__c,Additional_Brand_Contact__r.Email,Previous_Planned_Ship_Date__c,
                        Retailer_Contact__c,Retailer_Contact__r.email,Retailer_Contact__r.FirstName,Sales_Person__c,Sales_Person__r.Email,Sales_Person__r.Orders_Email_Opt_In__c,Sales_Person__r.Active__c,
                        State_License__r.License_Address__c,State_License__r.License_City__c,State_License__r.License_Country__c,State_License__r.License_State__c,State_License__r.License_Zip__c,
                        (SELECT Id, Name, Product__r.Name,Product__r.Product_Short_Description__c,Product__r.Family,Product__r.Description,UnitPrice__c,Quantity_Cases__c,
                         MOQ__c,Line_Total_Qty__c,Product__r.Brand_Name__c,Product__r.RecordType.Name,
                         Unit_Excise_Tax__c,Line_Total_Excise_Tax__c,Total__c ,Line_Total_Cost__c,IsPromo__c,Is_Sample__c
                         FROM  Order_Line_Items__r),
                        (SELECT id,Contact__c,Contact__r.Email,Type__c FROM Retailer_Related_Contacts__r WHERE Contact__r.Active__c = true AND Type__c IN (:TYPE_ADD_BRAND_CONTACT,:TYPE_ADD_RETAIL_CONTACT) AND Contact__r.Email != null)
                        FROM Order__c WHERE Id =: odrId];
        List<Order_Line_Item__c> discountOLIList = new List<Order_Line_Item__c>();
        List<Order_Line_Item__c> oliList = new List<Order_Line_Item__c>();
        for(Order_Line_Item__c oli : ord.Order_Line_Items__r){
            if(oli.Product__r.RecordType.Name == PRODUCT_RECORD_TYPE_NAME_DISCOUNT) {  discountOLIList.add(oli);
                                                                                    }else{
                                                                                        oliList.add(oli);
                                                                                    } 
        }
        if(discountOLIList.size() > 0){  oliList.addAll(discountOLIList);
                                      }
        String earTime='';
        String latTime = '';
        String dayOfWeek = '';
        Datetime dt;
        if( ord.Requested_Delivery_Earliest_Time__c != null && ord.Requested_Delivery_Latest_Time__c != null){
            
            String[] strTimeSplit = String.valueOf(ord.Requested_Delivery_Earliest_Time__c).split(':');
            earTime = Integer.valueOf(strTimeSplit[0]) > 12 ? String.valueOf(Integer.valueOf(strTimeSplit[0]) - 12)+':'+strTimeSplit[1]+' pm' : strTimeSplit[0]+':'+strTimeSplit[1]+(Integer.valueOf(strTimeSplit[0]) == 12 ?' PM': ' AM');
            
            String[] strTimelateSplit = String.valueOf(ord.Requested_Delivery_Latest_Time__c).split(':');
            latTime = Integer.valueOf(strTimelateSplit[0]) > 12 ? String.valueOf(Integer.valueOf(strTimelateSplit[0]) - 12)+':'+strTimelateSplit[1]+' pm' : strTimelateSplit[0]+':'+strTimelateSplit[1]+(Integer.valueOf(strTimeSplit[0]) == 12 ?' PM': ' AM');
        }
        if(ord.Request_Ship_Date__c != null){   dt = DateTime.newInstance(ord.Request_Ship_Date__c, Time.newInstance(0, 0, 0, 0));
                                             dayOfWeek=dt.format('EEEE');
                                            }
        
        Datetime spdt;
        String dayOfSPWeek;
        if(newShipDate != null){  spdt = DateTime.newInstance(newShipDate,Time.newInstance(0, 0, 0, 0));
                                dayOfSPWeek=spdt.format('EEEE');
                               }
        
        if(oldOdrDate != null){ 
            dt = DateTime.newInstance(oldOdrDate, Time.newInstance(0, 0, 0, 0));
            dayOfWeek=dt.format('EEEE');
        }
        Datetime prePlanneddt = null;
        String dayOfprePlanneWeek;
        if(ord.Previous_Planned_Ship_Date__c != null){
            prePlanneddt = DateTime.newInstance(ord.Previous_Planned_Ship_Date__c, Time.newInstance(0, 0, 0, 0));
            dayOfprePlanneWeek=prePlanneddt.format('EEEE');
        }
        Datetime Planneddt = null;
        String dayOfPlanneWeek;
        if(ord.Planned_Ship_Date__c != null){
            Planneddt = DateTime.newInstance(ord.Planned_Ship_Date__c, Time.newInstance(0, 0, 0, 0));
            dayOfPlanneWeek=Planneddt.format('EEEE');
        }
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String subject='' ;
        if(newShipDate != null){ 
            if(ord.Sample_Order__c || ord.Retailer__r.Third_Party_Scheduler__c){
                if(ord.Previous_Planned_Ship_Date__c == null || String.isNotBlank(ReasonCodes))
                	subject = 'Delivery Date for Order '+ord.Name+' from '+ord.Account_DBA__c+' by WOVN';
                else
                     subject ='New Delivery Date for Order '+ord.Name+' from '+ord.Account_DBA__c+' by WOVN';
            }else{
                subject = 'Delivery Date Confirmed for Order '+ord.Name+' from '+ord.Account_DBA__c+' by WOVN';
            }
            
        }else{
            if(ord.Sample_Order__c || ord.Retailer__r.Third_Party_Scheduler__c){
                subject = ' Delivery Delay for Order '+ord.Name+' from '+ord.Account_DBA__c+' by WOVN';
            }else{
                subject = 'Reschedule Needed: Order '+ord.Name+' from '+ord.Account_DBA__c+' by WOVN';
            }
            
        }
        
        mail.setSubject(subject);
        
        
        String htmlBody = 'Hello '+ord.Retailer_Contact__r.FirstName+', <br/><br/>';
        if((ord.Sample_Order__c || ord.Retailer__r.Third_Party_Scheduler__c) && newShipDate != null){
            if(ord.Previous_Planned_Ship_Date__c == null || String.isNotBlank(ReasonCodes)){
            	htmlBody +='Thank you for approving your order '+ord.Name+' via the WOVN portal.<br/><br/>';
            }else{
                htmlBody +='There has been an update to your delivery date and time.  Your delivery was planned to ship on<br/>';
                htmlBody += prePlanneddt.format('EEEE, MM/dd/YYYY') +' @ '+earTime.toUppercase()+'-'+latTime.toUppercase()+'<br/><br/>';
            }
        }else{
            if(ord.Previous_Planned_Ship_Date__c != null && String.isNotBlank(ReasonCodes)){
                htmlBody += 'Order '+ord.Name+' was scheduled for delivery on -<br/><br/>';
                htmlBody += prePlanneddt.format('EEEE, MM/dd/YYYY') +'<br/><br/>';//+' @ '+earTime.toUppercase()+'-'+latTime.toUppercase()+'<br/><br/>';
               
                system.debug('##ReasonCodes : '+String.isNotBlank(ReasonCodes));
                if(!ord.Sample_Order__c && !ord.Retailer__r.Third_Party_Scheduler__c && String.isNotBlank(ReasonCodes)){
                    htmlBody +='We are sorry that we were not able to make this delivery window due to:<br/>';
                    htmlBody +='<br/><b>'+(String.isNotBlank(ReasonCodes)? ReasonCodes : '')+'</b><br/><br/>';
                }else{
                    htmlBody +='We will reach out with a new delivery date soon.<br/><br/>';
                }
            }
        }
        
        if(newShipDate != null){
            if(ord.Sample_Order__c || ord.Retailer__r.Third_Party_Scheduler__c){
                if(ord.Previous_Planned_Ship_Date__c == null || String.isNotBlank(ReasonCodes))
                	htmlBody +='We will deliver this order on:<br/><br/>';
                else
                    htmlBody +='Your delivery day and time has been updated to:<br/><br/>';
            }else{
                
                htmlBody +='We will be shipping your order on your requested delivery date:<br/><br/>';
            }
             htmlBody += '<b>'+Planneddt.format('EEEE, MM/dd/YYYY') ;
             if((ord.Sample_Order__c || ord.Retailer__r.Third_Party_Scheduler__c) && String.isNotBlank(ReasonCodes) ){
                htmlBody +='</b><br/><br/>';
            }else{
                htmlBody += ' @ '+earTime.toUppercase()+'-'+latTime.toUppercase()+'</b><br/><br/>';
            }
            
            
            //htmlBody += 'IF THIS IS STILL YOUR PREFERRED DATE AND TIME,  <b> <a href="'+Label.WOVN_Community_URL+'acceptorder?id='+ord.Id+'&reschedule=true-a">CLICK HERE.</a>  </b><br/><br/>';
            //htmlBody += 'IF YOU’D LIKE TO CHANGE YOUR PREVIOUSLY REQUESTED DATE AND TIME,  <b> <a href="'+Label.WOVN_Community_URL+'acceptorder?id='+ord.Id+'&reschedule=true">CLICK HERE.</a>  </b><br/><br/>';
        }else{
            if(!ord.Sample_Order__c && !ord.Retailer__r.Third_Party_Scheduler__c && String.isNotBlank(ReasonCodes)){
                htmlBody += /*If you would like us to reattempt delivery,*/'<b> <a href="'+Label.WOVN_Community_URL+'acceptorder?id='+ord.Id+'&reschedule=true">PLEASE CLICK HERE TO RESCHEDULE DELIVERY.</a>  </b><br/><br/>';
                //htmlBody +='Or if you would like us to cancel the order, please <b> <a href="'+Label.WOVN_Community_URL+'acceptorder?id='+ord.Id+'&reschedule=true-c">CLICK HERE TO CANCEL ORDER.</a>  </b><br/><br/>';
            }
        }
        if((ord.Sample_Order__c || ord.Retailer__r.Third_Party_Scheduler__c) && newShipDate != null){
            htmlBody +='If you have any questions or concerns regarding your confirmed time and date, please feel free to reach out to us via email.<br/><br/>';
        }
        htmlBody +='<br/><b>ORDER DETAILS</b><br/>';
        htmlBody +='Retailer Name:&nbsp;'+ord.Retailer_DBA__c+'<br/>';
        //htmlBody +='License Number:&nbsp;<b>'+ord.State_License__r.License_Number__c+'</b><br/>';
        String Retailer_PO =ord.Retailer_PO__c==null?'':ord.Retailer_PO__c;
        htmlBody +='Retailer PO:&nbsp;'+Retailer_PO+'<br/>';
        
        /*if(ord.Retailer__r.shippingaddress != null){
        Address shAddress = ord.Retailer__r.shippingaddress;
        String add = '';
        if(shAddress.getStreet() != null) add += shAddress.getStreet() + ' ';
        if(shAddress.getCity() != null) add += shAddress.getCity()+ ', ';
        if(shAddress.getState() != null) add += shAddress.getState()+ ' ';
        if(shAddress.getPostalCode() != null) add += shAddress.getPostalCode()+ ' ';
        if(shAddress.getCountry() != null) add += shAddress.getCountry();
        
        htmlBody += 'Address:&nbsp;<b>'+add+'</b><br/>';     
        } else htmlBody += 'Address:</br>';*/
        
        
        htmlBody +='Total Product Price:&nbsp;$'+ord.Total_Product_Price__c+'<br/>';
        htmlBody +='Total Excise Tax Amount:&nbsp;$'+ord.Total_Excise_Tax_Amount__c+ ' (Excise Tax is due COD at time of delivery.)<br/>';//((ord.Sample_Order__c || ord.Retailer__r.Third_Party_Scheduler__c) && newShipDate != null ?
        htmlBody +='Total Order Price:&nbsp;$'+ord.Total__c+'<br/>';
        String add = '';
        add += ord.State_License__r.License_Address__c != null ? ord.State_License__r.License_Address__c +' ':'';
        add += ord.State_License__r.License_City__c != null ? ord.State_License__r.License_City__c +', ':'';
        add += ord.State_License__r.License_State__c != null ? ord.State_License__r.License_State__c +' ':'';
        add += ord.State_License__r.License_Zip__c != null ? ord.State_License__r.License_Zip__c +' ':'';
        //add += ord.State_License__r.License_Country__c != null ? ord.State_License__r.License_Country__c +' ':'';
        htmlBody += '<b>Address:&nbsp;</b>'+add+'<br/>';
        htmlBody +='<b>License Number:&nbsp;</b>'+ord.State_License__r.License_Number__c+'<br/>';
        htmlBody +='<b>Payment Terms:&nbsp;</b>'+ord.Payment_Terms__c+'<br/><br/>';
        
        htmlBody += '<table cellspacing="0" style="border:1px solid #000">';
        htmlBody += '<tr style="border:1px solid #000">';
        htmlBody += '<th style="border:1px solid #000">Order Line ';
        htmlBody += '</th><th style="border:1px solid #000">Product Name';
        htmlBody += '</th><th style="border:1px solid #000">Product Description</th>';
        htmlBody += '<th style="border:1px solid #000">Brand</th>';
        htmlBody += '<th style="border:1px solid #000">Total Qty</th>';
        if((ord.Sample_Order__c || ord.Retailer__r.Third_Party_Scheduler__c) || newShipDate != null   ){
        	htmlBody += '<th style="border:1px solid #000">Type</th>';
        }
        htmlBody += '<th style="border:1px solid #000">Unit Price</th>';
        htmlBody += '<th style="border:1px solid #000">Unit Excise Tax</th>';
        htmlBody += '<th style="border:1px solid #000">Product Price</th>';
        htmlBody += '<th style="border:1px solid #000">Total Excise Tax</th>';
        htmlBody += '<th style="border:1px solid #000">Total Quoted Price</th>';
        htmlBody += '</tr> ';
        if(oliList.size()>0){
            for(Order_Line_Item__c oli : oliList){
                htmlBody += '<tr style="border:1px solid #000">';
                htmlBody += '<td style="border:1px solid #000;font-size: 11px;">'+oli.Name+'</td>';
                htmlBody += '<td style="border:1px solid #000;font-size: 11px;">'+oli.Product__r.Product_Short_Description__c+'</td>';
                htmlBody += '<td style="border:1px solid #000;font-size: 11px;">'+oli.Product__r.Description+'</td>';    
                htmlBody += '<td style="border:1px solid #000;font-size: 11px;">'+oli.Product__r.Brand_Name__c+'</td>';    
                htmlBody += '<td style="border:1px solid #000;font-size: 11px;">'+oli.Line_Total_Qty__c.setScale(2)+'</td>';  
                if((ord.Sample_Order__c || ord.Retailer__r.Third_Party_Scheduler__c) || newShipDate != null){
                    htmlBody += '<td style="border:1px solid #000;text-align: center;font-size: 11px;">';
                    if(oli.IsPromo__c)
                        htmlBody += 'Promo';
                    if(oli.Is_Sample__c)
                        htmlBody += 'Sample';
                    if(oli.Product__r.RecordType.Name == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                        htmlBody += 'Discount';
                    htmlBody += '</td>';
                }
                htmlBody += '<td style="border:1px solid #000;text-align: left;font-size: 11px;">';
                
                if(oli.Product__r.Family == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                    htmlBody += '($'+oli.UnitPrice__c.setScale(2)+')';
                else
                    htmlBody += '$'+oli.UnitPrice__c.setScale(2);
                
                htmlBody += '</td>';    
                htmlBody += '<td style="border: 1px solid #000; text-align: left;font-size: 11px;">$'+oli.Unit_Excise_Tax__c.setScale(2)+'</td>';
                htmlBody += '<td style="border: 1px solid #000; text-align: left;font-size: 11px;">';
                if(oli.Product__r.Family == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                    htmlBody += '($'+oli.Line_Total_Cost__c.setScale(2)+')';
                else
                    htmlBody += '$'+oli.Line_Total_Cost__c.setScale(2);
                htmlBody += '</td>';
                htmlBody += '<td style="border: 1px solid #000; text-align: left;font-size: 11px;">$'+oli.Line_Total_Excise_Tax__c.setScale(2)+'</td>';
                htmlBody += '<td style="border: 1px solid #000; text-align: left;font-size: 11px;">';
                if(oli.Product__r.Family == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                    htmlBody += '($'+oli.Total__c.setScale(2)+')';
                else
                    htmlBody += '$'+oli.Total__c.setScale(2);
                htmlBody += '</td></tr>'; 
            }
        }
        htmlBody += '</table><br/><br/>';
        if(((ord.Sample_Order__c || ord.Retailer__r.Third_Party_Scheduler__c ) && newShipDate != null && ord.Previous_Planned_Ship_Date__c == null) || (String.isBlank(ReasonCodes) && ord.Planned_Ship_Date__c == ord.Request_Ship_Date__c)){
            htmlBody +='Please note, as required by the Internal Revenue Service (IRS) we must report all transactions involving more than $10,000 in cash or cash equivalents (cumulative in each calendar year) as defined in 26 U.S.C. § 6050I. If applicable and pursuant to this requirement, please complete Part I and Part II of the attached Form 8300, and/or provide the identity of the individual from whom cash is received. This includes the individual’s name, address, and contact information.<br/><br/>';
            if(doc.size() >0 ){
                //Create Email file attachment from document
                Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
                attach.setContentType(doc[0].ContentType);
                attach.setFileName(doc[0].DeveloperName+'.'+doc[0].Type);
                attach.setInline(false);
                attach.Body = doc[0].Body;
                
                mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });//Set File Attachment                                                                                     
            }
        }
        
        htmlBody += ' Thank you, <br/><br/>';
        htmlBody += 'The WOVN Scheduling Team';
        
        
        
        List<String> listOfToAddresses = new List<String>();
        listOfToAddresses.add(ord.Retailer_Contact__r.email);
        
        
        //  mail.setToAddresses(lstEmail);
        
        if(orgWide != null) mail.setOrgWideEmailAddressId(orgWide.Id);   mail.setHtmlBody(htmlBody);
        List<String> ccEmails = DL_ASR.split(',');//label.DL_ASR
        for(Retailer_Related_Contact__c rrc: ord.Retailer_Related_Contacts__r){
            listOfToAddresses.add(rrc.Contact__r.Email);   
            
            
        }
        //  string allstring = string.join(listOfToAddresses,',');
        // List<String> lstEmail = allstring.split(',');
        //  String toEmailIds = SUPPLIER_SNAPSHOT_TO_ADDRESS;
        
        if( ord.Customer__c != null && ord.Customer__r.Email != null){   ccEmails.add(ord.Customer__r.Email);
                                                                     }
        if(ord.Additional_Brand_Contact__c != null){   if(ord.Additional_Brand_Contact__r.Email != null) 
            ccEmails.add(ord.Additional_Brand_Contact__r.Email);
                                                   }
        if(ord.Sales_Person__c  != null && ord.Sales_Person__r.Email != null && ord.Sales_Person__r.Orders_Email_Opt_In__c == true  && ord.Sales_Person__r.Active__c == true){
            ccEmails.add(ord.Sales_Person__r.Email);
        }
        ccEmails.addAll(Label.Orders_Filigreen_Email.split(','));
        List<String> listOfBCCAddresses = Label.Brand_BCC_Addresses.split(',');
      
        //mail.setBccAddresses(listOfBCCAddresses);
        mail.setCcAddresses(ccEmails); 
        mail.setSaveAsActivity(false);
        mail.setToAddresses(listOfToAddresses); 
        
        mails.add(mail);
        
        
        system.debug('## mails'+mails);
        if(mails.size() > 0){
            Messaging.sendEmail(mails);
        }
    }
    
    public static void updateServiceInvoice(String recordId,Invoice__c inv){
        
        
        if(String.isNotBlank(recordId)){
            
            Sales_Order__c sOrder = [select id ,name
                                     ,Distributor_Name__c
                                     ,Distributor_License__c
                                     ,Distributor_Contact__c
                                     ,Supplier_Name__c
                                     ,Supplier_License__c
                                     ,Supplier_Contact__c
                                     ,Sales_Order_Instructions__c
                                     ,Brand_Quote__r.Distributor_Name__c
                                     ,Brand_Quote__r.Distributor_License__c
                                     ,Brand_Quote__r.Distributor_Contact__c
                                     ,Brand_Quote__r.Supplier_Name__c
                                     ,Brand_Quote__r.Supplier_License__c
                                     ,Brand_Quote__r.Supplier_Contact__c
                                     ,Receiver_Name__c
                                     ,Receiver_License__c
                                     ,Receiver_Contact__c
                                     ,Site__c,Supplier_Name__r.Payment_Terms__c,Supplier_Name__r.DBA__c
                                     ,Site__r.Name
                                     ,Opportunity_Name__c
                                     ,Planned_Ship_Date__c
                                     ,Sample_Order__c
                                     ,Customer_PO_or_Quote__c
                                     ,Brand_Quote__c
                                     ,Shipping_Terms__c
                                     ,Shipping_Method__c
                                     ,Payment_Terms__c
                                     ,SO_Type__c
                                     ,Ownership__c,Ownership__r.Type
                                     ,Total_Weight_Fee__c , 
                                     Total_Mileage_Fee__c  ,Ownership__r.DBA__c, 
                                     Stage_Manifest_Fee__c , Schedule_Dispatch_Fee__c , 
                                     Pack_Out_Fee__c , Order_Booking_Fee__c,Total_Pick_Pack_Fee__c,
                                     Total_QA_Review_Fee__c,Change_Order_Fee__c,
                                     Total_Weight_lbs__c, Brand_Quote__r.Opportunity_Name__r.Order__r.Piggyback_sample__c,
                                     Supplier_Name__r.Membership_Level__c, 
                                     Receiver_Name__r.Membership_Level__c, Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__c,
                                     Order_Type__c,Brand_Quote__r.Opportunity_Name__c,Receiver_Name__r.DBA__c,
                                     Ship_Confirmation_Date__c,Brand_Quote__r.Opportunity_Name__r.Order__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c,
                                     Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.Customer__r.ContactId,Total_Manifest_Revision__c,Total_Change_Fee__c
                                     from Sales_Order__c where id =: recordId];
            String membershipLevel;
            if(sOrder.Order_Type__c == SO_ORDER_TYPE_BRAND){ membershipLevel = sOrder.Supplier_Name__r.Membership_Level__c;
                                                           }else{
                                                               membershipLevel = sOrder.Receiver_Name__r.Membership_Level__c;    
                                                           }
            List<Shipping_Rates_Table__c> mileageSRTList = new List<Shipping_Rates_Table__c>();
            List<Shipping_Rates_Table__c> weightSRTList = new List<Shipping_Rates_Table__c>();
            if(sOrder.Brand_Quote__r.Opportunity_Name__r.Order__c != null){
                mileageSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, 
                                  Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Membership_Level__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c
                                  FROM Shipping_Rates_Table__c 
                                  WHERE Site__c =: sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c
                                  AND Active__c = true
                                  AND Rate_Effective_From__c <= :System.today()
                                  AND Rate_Effective_To__c >= :System.today()
                                  AND Membership_Level__c = :membershipLevel
                                  Order By Mileage_Bracket__c];
                weightSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, 
                                 Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Membership_Level__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c
                                 FROM Shipping_Rates_Table__c 
                                 WHERE Site__c =: sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c
                                 AND Active__c = true
                                 AND Rate_Effective_From__c <= :System.today()
                                 AND Rate_Effective_To__c >= :System.today()
                                 AND Membership_Level__c = :membershipLevel
                                 Order By Weight_Bracket__c];
            }
            Company_Custom_Settings__c companySettingRec = Company_Custom_Settings__c.getOrgDefaults();
            Invoice__c newInvoice = new Invoice__c();
            newInvoice.id=inv.id;
            
            
            Decimal totalStorageFee = 0;
            Decimal mileageFee = 0;
            Decimal weightFee = 0;
            decimal qAReviewFee =0;
            Boolean isFixedMileage = false;
            Boolean isFixedWeight = false;
            //calculate Total Mileage Fee
            if(!mileageSRTList.isEmpty() && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c != null){
                for(Shipping_Rates_Table__c SRT: mileageSRTList){
                    if(sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c <= SRT.Mileage_Bracket__c && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c == SRT.Site__c  && sOrder.Supplier_Name__r.Membership_Level__c == SRT.Membership_Level__c){
                        if(SRT.Fixed_Mileage_Fee__c){ isFixedMileage = true;
                                                     mileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                                                    }else{
                                                        mileageFee = SRT.Mileage_Bracket_Price__c;
                                                    }
                        break;
                    }
                }
                /*if(sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER && sOrder.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE ){
                    mileageFee = 0;
                }*/
                
            }
            //calculate QA Review Fee
            qAReviewFee =sOrder.Total_QA_Review_Fee__c;
            
            //calculate Total Weight Fee
            weightFee =sOrder.Total_Weight_Fee__c;
               if(sOrder.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE  && 
                       (
                           (sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR) 
                           || (sOrder.Supplier_Name__r.DBA__c == Account_Plateformlevel_ZASP || sOrder.Supplier_Name__r.DBA__c == Account_Plateformlevel_IRR)
                       ) 
                       && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER ){
                       mileageFee = 0;
                    }  
                    if(
                        (
                            (sOrder.Supplier_Name__r.DBA__c != Account_Plateformlevel_ZASP && sOrder.Supplier_Name__r.DBA__c != Account_Plateformlevel_IRR) 
                            || (sOrder.Receiver_Name__r.DBA__c != Account_Plateformlevel_ZASP && sOrder.Receiver_Name__r.DBA__c != Account_Plateformlevel_IRR)
                        ) && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__c != null && (sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_ZASP && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_IRR)
                        && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER){
                         mileageFee = 0;
                    }          
            if(sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Piggyback_sample__c == true && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER){
                mileageFee = 0;
            }
            List<Sales_Order_Line__c> lstSOLine = [SELECT Id,Name,(SELECT Id,Name,Aged_Bucket__c,Days_in_Inventory__c,Total_Product_Volume__c
                                                                   FROM Inventory_Positions__r)
                                                   FROM Sales_Order_Line__c WHERE Sales_Order__c =: sOrder.Id];
            
            List<Inventory_Storage_Config__mdt> iStorage = [SELECT Id,MasterLabel,DeveloperName,Charge__c,Lower_Limit__c,Upper_Limit__c FROM Inventory_Storage_Config__mdt];
            
            for(Sales_Order_Line__c soLine : lstSOLine){   
                for(Inventory_Position__c ip : soLine.Inventory_Positions__r){
                    for(Inventory_Storage_Config__mdt mdt : iStorage){
                        if(ip.Days_in_Inventory__c >= mdt.Lower_Limit__c && ip.Days_in_Inventory__c <= mdt.Upper_Limit__c){
                            if(ip.Total_Product_Volume__c != null && mdt.Charge__c != null){  totalStorageFee = totalStorageFee + (ip.Total_Product_Volume__c * mdt.Charge__c);
                                                                                           }
                        } else if(ip.Days_in_Inventory__c >= mdt.Lower_Limit__c && mdt.Upper_Limit__c == null){
                            if(ip.Total_Product_Volume__c != null && mdt.Charge__c != null){totalStorageFee = totalStorageFee + (ip.Total_Product_Volume__c * mdt.Charge__c);
                                                                                           }
                        }
                    }
                }
            }
            
            
            List<Invoice_Line__c> invoiceLines = new List<Invoice_Line__c>();
            Map<String, Invoice_Line__c> invoiceLinesMap = new Map<String,Invoice_Line__c>();
            for(Invoice_Line__c il : inv.Invoice_Lines__r){invoiceLinesMap.put(il.Product_Name__r.Name,il);
                                                          }
            
            if(sOrder.Total_Weight_Fee__c != null && sOrder.Total_Weight_Fee__c > 0 && invoiceLinesMap.containsKey(PRODUCT_NAME_WEIGHT_FEE)){ Decimal qty= sOrder.Total_Manifest_Revision__c != null ? (sOrder.Total_Manifest_Revision__c + 1) :1;
                                                                                                                                             invoiceLines = validateProductFee(invoiceLinesMap.get(PRODUCT_NAME_WEIGHT_FEE).id,qty,weightFee,invoiceLines);
                                                                                                                                            }
            if(!sOrder.Sample_Order__c  &&  mileageFee > 0 && invoiceLinesMap.containsKey(PRODUCT_NAME_MILEAGE_FEE)){
                Decimal FixedQty = sOrder.Total_Manifest_Revision__c != null ? (sOrder.Total_Manifest_Revision__c + 1) :1;
                Decimal qty= sOrder.Total_Manifest_Revision__c != null ? (sOrder.Total_Manifest_Revision__c + 1) * sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c : sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c;
                invoiceLines = validateProductFee(invoiceLinesMap.get(PRODUCT_NAME_MILEAGE_FEE).id,(isFixedMileage?FixedQty:qty),mileageFee,invoiceLines);
            }
            if(sOrder.Stage_Manifest_Fee__c != null && sOrder.Stage_Manifest_Fee__c > 0 && invoiceLinesMap.containsKey(PRODUCT_NAME_STAGE_AND_MANIFEST)){  Decimal qty= sOrder.Total_Manifest_Revision__c != null ? (sOrder.Total_Manifest_Revision__c + 1) :1;
                                                                                                                                                         invoiceLines = validateProductFee(invoiceLinesMap.get(PRODUCT_NAME_STAGE_AND_MANIFEST).id,qty,sOrder.Stage_Manifest_Fee__c,invoiceLines);
                                                                                                                                                        }
            if(sOrder.Schedule_Dispatch_Fee__c != null && sOrder.Schedule_Dispatch_Fee__c > 0 && invoiceLinesMap.containsKey(PRODUCT_NAME_SCHEDULE_AND_DISPATCH)){ Decimal qty= sOrder.Total_Manifest_Revision__c != null ? (sOrder.Total_Manifest_Revision__c + 1) :1;
                                                                                                                                                                  invoiceLines = validateProductFee(invoiceLinesMap.get(PRODUCT_NAME_SCHEDULE_AND_DISPATCH).id,qty,sOrder.Schedule_Dispatch_Fee__c,invoiceLines);
                                                                                                                                                                 }
            
            if(!invoiceLines.isEmpty()){  update newInvoice;update invoiceLines;
                                       }
        }
    }
    public static List<Invoice_Line__c>  validateProductFee(String INLI_Id,Decimal qty,Decimal fee, List<Invoice_Line__c> invoiceLines){
        Invoice_Line__c line = updateInvoiceLine(qty,fee,INLI_Id);
        if(line != null){ invoiceLines.add(line);
                        }
        return invoiceLines;
    }
    public static Invoice_Line__c updateInvoiceLine(Decimal qty, Decimal fee,String INLI_Id){
        Invoice_Line__c invLineItem = new Invoice_Line__c();
        invLineItem.id = INLI_Id;
        invLineItem.Invoice_Qty__c = qty;
        invLineItem.Retail_Wholesale_Price__c = fee;
        return invLineItem;
    }
    /**
* Approved Reschedule Delivery Email

Public void RescheduleDeliveryEmail(String odrId,String smId){
//Shipping_Manifest_Line__c sm =
for(Order__c ord : [SELECT Id,Name,Request_Ship_Date__c,Account__c,Requested_Delivery_Earliest_Time__c,Retailer_DBA__c,Account_DBA__c,Requested_Delivery_Latest_Time__c,
Retailer__r.DBA__c,Retailer__r.ShippingAddress,Retailer_PO__c,Total_Product_Price__c,Total__c,Payment_Terms__c,Total_Excise_Tax_Amount__c,
Retailer_Contact__c,Retailer_Contact__r.email,Retailer_Contact__r.FirstName,
(SELECT Id, Name, Product__r.Name,Product__r.Product_Short_Description__c,Product__r.Family,Product__r.Description,UnitPrice__c,Quantity_Cases__c,
MOQ__c,Line_Total_Qty__c,Product__r.Brand_Name__c,
Unit_Excise_Tax__c,Line_Total_Excise_Tax__c,Total__c ,Line_Total_Cost__c FROM Order_Line_Items__r)
FROM Order__c WHERE Id  =: odrId]){

}
} */
    /*
* Redirect to RSM detail page
*
* @return PageReference
*/         
    public PageReference redirectToRSM() { PageReference pageRef = stdController.view().setRedirect(true);
                                          return pageRef;
                                         }
    
    // get smRecordName
    @Auraenabled
    public static AuraResponse getRecordName(Id recordId){
        AuraResponse r = new AuraResponse('SMRescheduleController.smRescheduleLight()');
        String objName = recordId.getSObjectType().getDescribe().getName();
        String q = 'SELECT Name,Status__c FROM ' + objName + ' WHERE Id=\'' + recordId + '\'';
        List<SObject> records = Database.query(q);
        if(records.size()>0){
            r.data.put('recordName', (String) (records[0].get('Name')));
            r.data.put('status', (String) (records[0].get('Status__c')));
            List<String> options =new List<String>();
            SObjectType objectType = Schema.getGlobalDescribe().get('Order_Revision__c');
            for (Schema.PicklistEntry pickListValue : objectType.getDescribe().fields.getMap().get('Reason_code__c').getDescribe().getPickListValues()) {
                options.add(pickListValue.getValue());
            }
            options.sort();
            r.data.put('ReasonCode', options);
            
        }
        Map<String, Community_Settings__c > Community_Settings= Community_Settings__c.getAll();
        if(Community_Settings.containsKey('default')){   r.data.put('cutOffTime', Community_Settings.get('default').Order_Cutoff_time__c);
                                                     }
        List<string>holidayList = new List<string>();
        for(Holiday  businessHolidDay : [SELECT IsRecurrence,ActivityDate,RecurrenceMonthOfYear,RecurrenceEndDateOnly,RecurrenceInstance,RecurrenceDayOfWeekMask,RecurrenceInterval,RecurrenceType FROM Holiday]){
            if(businessHolidDay.IsRecurrence){
                holidayList.addAll(getAllRecurrenceHoliday(businessHolidDay));
            }else{
                holidayList.add(getDateStr(businessHolidDay.ActivityDate));   
            }    
        }
        r.data.put('holidayList', holidayList);
        r.data.put('EARLIEST_DELIVERY_TIME',EARLIEST_DELIVERY_TIME);
        r.data.put('LATEST_DELIVERY_TIME',LATEST_DELIVERY_TIME);
        string Missed_Delivery_Window_Reason_Code = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Revision','Missed_Delivery_Window_Reason_Code');
        string Requires_METRC_Adjustments_Reason_Code = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Revision','Requires_METRC_Adjustments_Reason_Code');
        string Route_Compromised_Reason_Code = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Revision','Route_Compromised_Reason_Code');
        string Clerical_Error_Reason_Code = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Revision','Clerical_Error_Reason_Code');
        string Err_Msg_For_Past_Date = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_For_Past_Date');
        string Incorrectly_Entered_Order_config = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Revision','Incorrectly_Entered_Order_config');
        string Incorrectly_Packed_Order_config = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Revision','Incorrectly_Packed_Order_config');
        
        r.data.put('Incorrectly_Packed_Order_config', Incorrectly_Packed_Order_config != null ? Incorrectly_Packed_Order_config : '');        
        r.data.put('Incorrectly_Entered_Order_config', Incorrectly_Entered_Order_config != null ? Incorrectly_Entered_Order_config : '');        
        r.data.put('Err_Msg_For_Past_Date', Err_Msg_For_Past_Date != null ? Err_Msg_For_Past_Date : '');        
        r.data.put('Clerical_Error_Reason_Code', Clerical_Error_Reason_Code != null ? Clerical_Error_Reason_Code : '');        
        r.data.put('Route_Compromised_Reason_Code', Route_Compromised_Reason_Code != null ? Route_Compromised_Reason_Code : '');        
        r.data.put('Requires_METRC_Adjustments_Reason_Code', Requires_METRC_Adjustments_Reason_Code != null ? Requires_METRC_Adjustments_Reason_Code : '');        
        r.data.put('Missed_Delivery_Window_Reason_Code', Missed_Delivery_Window_Reason_Code != null ? Missed_Delivery_Window_Reason_Code : '');        
        
        return r;
        /*SMRescheduleController assign = new SMRescheduleController();
assign.recordName = DataCRUDUtility.getRecordName(recordId);
r.data.put('recordName', assign.recordName);
return r;*/
    }
    private static list<String> getAllRecurrenceHoliday(Holiday businessHolidDay){
        List<string>holidayList = new List<string>();
        date todayDt = businessHolidDay.ActivityDate;
        date holidayEndDt = businessHolidDay.RecurrenceEndDateOnly != null ? businessHolidDay.RecurrenceEndDateOnly : system.today();
        
        while(todayDt <= holidayEndDt){
            if(businessHolidDay.RecurrenceType == RECURSYEARLY){  todayDt = todayDt.addYears(1);
                                                               }else if(businessHolidDay.RecurrenceType == RECURSYEARLYNTH){
                                                                   todayDt = todayDt.addYears(1);
                                                                   todayDt = getHolidayDate(todayDt,businessHolidDay);        
                                                               }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSMONTHLY){todayDt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);
                                                                                                                                  todayDt = getHolidayDate(todayDt,businessHolidDay);        
                                                                                                                                 }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSMONTHLYNTH){date dt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);      
                                                                                                                                                                                                      }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSWEEKLY){todayDt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);        
                                                                                                                                                                                                                                                                       }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSDAILY){ todayDt = todayDt.addDays(businessHolidDay.RecurrenceInterval);
                                                                                                                                                                                                                                                                                                                                       }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSEVERYWEEKDAY){	todayDt = todayDt.addDays(1);
                                                                                                                                                                                                                                                                                                                                                                                                              }    
            holidayList.add(getDateStr(todayDt));       
        }
        return holidayList;
    }
    Public  static string getDateStr(Date holidayDate){
        string dtStr = holidayDate.month()+'-'+holidayDate.Day()+'-'+holidayDate.year();  
        return dtStr;
    }
    Public  static integer getMonthNumber(string monthName){
        if(monthName == JANUARY_MONTH){  return 1;
                                      }else if(monthName == FEBRUARY_MONTH){return 2;
                                                                           }else if(monthName == MARCH_MONTH){ return 3;
                                                                                                             }else if(monthName == APRIL_MONTH){ return 4;
                                                                                                                                               }else if(monthName == MAY_MONTH){  return 5;
                                                                                                                                                                               }else if(monthName == JUNE_MONTH){ return 6;
                                                                                                                                                                                                                }else if(monthName == JULY_MONTH){ return 7;
                                                                                                                                                                                                                                                 }else if(monthName == AUGUST_MONTH){ return 8;
                                                                                                                                                                                                                                                                                    }else if(monthName == SEPTEMBER_MONTH){ return 9;
                                                                                                                                                                                                                                                                                                                          }else if(monthName == OCTOBER_MONTH){ return 10;
                                                                                                                                                                                                                                                                                                                                                              }else if(monthName == NOVEMBER_MONTH){return 11;
                                                                                                                                                                                                                                                                                                                                                                                                   }else if(monthName == DECEMBER_MONTH){ return 12;
                                                                                                                                                                                                                                                                                                                                                                                                                                        }return 1;
    }
    Public  static Date getHolidayDate(Date todayDt,Holiday businessHolidDay){
        if(businessHolidDay.RecurrenceDayOfWeekMask == 127){
            integer year = todayDt.year();
            integer month = getMonthNumber(businessHolidDay.RecurrenceMonthOfYear);
            integer day = 0;
            if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_FIRST){  day = 1;    
                                                                              }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_SECOND){day = 1;    
                                                                                                                                                       }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_THIRD){ day = 1;    
                                                                                                                                                                                                                               }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_FOURTH){  day = 1;    
                                                                                                                                                                                                                                                                                                        }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_LAST){day = Date.daysInMonth(year, month);  
                                                                                                                                                                                                                                                                                                                                                                               } 
            return Date.newInstance(year,month,day);
        }else{
            date dt = todayDt;            
            Date weekDay = todayDt.toStartOfMonth().toStartOfWeek(); 
            
            if(businessHolidDay.RecurrenceDayOfWeekMask == 2)
                weekDay = weekDay.addDays(1);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 4)
                weekDay = weekDay.addDays(2);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 8)
                weekDay = weekDay.addDays(3);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 16)
                weekDay = weekDay.addDays(4);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 32)
                weekDay = weekDay.addDays(5);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 64)
                weekDay = weekDay.addDays(6);  
            
            if((todayDt.month() > 1 && weekDay.month() < todayDt.month()) || (todayDt.month() == 1 && weekDay.month() == 12))
                weekDay = weekDay.addDays(7);
            
            if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_SECOND){  weekDay = weekDay.addDays(7);        
                                                                                }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_THIRD){ weekDay = weekDay.addDays(14);        
                                                                                                                                                         }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_FOURTH){
                                                                                                                                                             weekDay = weekDay.addDays(21);      }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_LAST){ weekDay = weekDay.addDays(28);        
                                                                                                                                                                                                                                                                         }
            
            if((todayDt.month() < 12 && weekDay.month() > todayDt.month()) || (todayDt.month() == 12 && weekDay.month() == 1))
                weekDay = weekDay.addDays(-7);
            return weekDay;
        }
    }
    
}