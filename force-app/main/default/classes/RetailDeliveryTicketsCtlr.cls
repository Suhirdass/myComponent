public without sharing class RetailDeliveryTicketsCtlr {
     private static String Account_Plateformlevel_ZASP {
        get{
            return String.isNotBlank(Account_Plateformlevel_ZASP ) ? Account_Plateformlevel_ZASP  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_DBA_ZASP');
        }set;
    }
    private static String Account_Plateformlevel_IRR {
        get{
            return String.isNotBlank(Account_Plateformlevel_IRR ) ? Account_Plateformlevel_IRR  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_DBA_IRR');
        }set;
    }
    private static String FULFILLMENT_SERVICE_ORDER_BOOKING{
        get{ 
            return String.isNotBlank(FULFILLMENT_SERVICE_ORDER_BOOKING) ? FULFILLMENT_SERVICE_ORDER_BOOKING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Order_Booking');
        }set;
    }
    private static String FULFILLMENT_SERVICE_BOOKING{
        get{ 
            return String.isNotBlank(FULFILLMENT_SERVICE_BOOKING) ? FULFILLMENT_SERVICE_BOOKING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Booking');
        }set;
    }
    private static String FULFILLMENT_SERVICE_SCHEDULING{
        get{ 
            return String.isNotBlank(FULFILLMENT_SERVICE_SCHEDULING) ? FULFILLMENT_SERVICE_SCHEDULING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Scheduling');
        }set;
    }
    private static String FULFILLMENT_SERVICE_STAGING{
        get{ 
            return String.isNotBlank(FULFILLMENT_SERVICE_STAGING) ? FULFILLMENT_SERVICE_STAGING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Staging');
        }set;
    }
    private static String FULFILLMENT_SERVICE_QA_REVIEW{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_QA_REVIEW) ? FULFILLMENT_SERVICE_QA_REVIEW : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_QA_Review');
        }set;
    }
    private static String FULFILLMENT_SERVICE_PICK_PACK{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_PICK_PACK) ? FULFILLMENT_SERVICE_PICK_PACK : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Pick_Pack');
        }set;
    }
    private static String FULFILLMENT_SERVICE_STAGE_MANIFEST{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_STAGE_MANIFEST) ? FULFILLMENT_SERVICE_STAGE_MANIFEST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Stage_Manifest');
        }set;
    }
    private static String FULFILLMENT_SERVICE_SCHEDULE_DISPATCH{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_SCHEDULE_DISPATCH) ? FULFILLMENT_SERVICE_SCHEDULE_DISPATCH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Schedule_Dispatch');
        }set;
    }
    private static String FULFILLMENT_SERVICE_PACKOUT{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_PACKOUT) ? FULFILLMENT_SERVICE_PACKOUT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_PackOut');
        }set;
    }    
    private static String ACCOUNT_TYPE_DISTY_PARTNER{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_DISTY_PARTNER) ? ACCOUNT_TYPE_DISTY_PARTNER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Disty_Partner');
        }set;
    }
    private static String PRODUCT_RECORD_TYPE_NAME_PRODUCT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_PRODUCT) ? PRODUCT_RECORD_TYPE_NAME_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Name_Product');
        }set;
    }
    private static String PRODUCT_RECORD_TYPE_NAME_DISCOUNT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_DISCOUNT) ? PRODUCT_RECORD_TYPE_NAME_DISCOUNT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Discount');
        }set;
    }
    private static String COMMUNITY_SETTINGS_DEFAULT{
        get{
            return String.isNotBlank(COMMUNITY_SETTINGS_DEFAULT) ? COMMUNITY_SETTINGS_DEFAULT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Community Settings','Community_Settings_Default');
        }set;
    }
    private static String ERR_MSG_REGULARPRODUCTWITHSAMPLEPRICE{
        get{
            return String.isNotBlank(ERR_MSG_REGULARPRODUCTWITHSAMPLEPRICE) ? ERR_MSG_REGULARPRODUCTWITHSAMPLEPRICE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Err_Msg_RegularProductWithSamplePrice');
        }set;
    }
    private static String STATE_LICENSE_ACTIVE{
        get{
            return String.isNotBlank(STATE_LICENSE_ACTIVE) ? STATE_LICENSE_ACTIVE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_Active');
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
    private static String HOLIDAY_RECURSMONTHLY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSMONTHLY) ? HOLIDAY_RECURSMONTHLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursMonthly');
        }set;
    }
    private static String HOLIDAY_RECURSMONTHLYNTH{
        get{
            return String.isNotBlank(HOLIDAY_RECURSMONTHLYNTH) ? HOLIDAY_RECURSMONTHLYNTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursMonthlyNth');
        }set;
    }
    private static String HOLIDAY_RECURSWEEKLY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSWEEKLY) ? HOLIDAY_RECURSWEEKLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursWeekly');
        }set;
    }
    private static String HOLIDAY_RECURSDAILY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSDAILY) ? HOLIDAY_RECURSDAILY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursDaily');
        }set;
    }
    private static String HOLIDAY_RECURSEVERYWEEKDAY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSEVERYWEEKDAY) ? HOLIDAY_RECURSEVERYWEEKDAY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursEveryWeekday');
        }set;
    }
    private static String JANUARY_MONTH{
        get{
            return String.isNotBlank(JANUARY_MONTH) ? JANUARY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','January_Month');
        }set;
    }
    private static String FEBRUARY_MONTH{
        get{
            return String.isNotBlank(FEBRUARY_MONTH) ? FEBRUARY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','February_Month');
        }set;
    }
    private static String MARCH_MONTH{
        get{
            return String.isNotBlank(MARCH_MONTH) ? MARCH_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','March_Month');
        }set;
    }
    private static String APRIL_MONTH{
        get{
            return String.isNotBlank(APRIL_MONTH) ? APRIL_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','April_Month');
        }set;
    }
    private static String MAY_MONTH{
        get{
            return String.isNotBlank(MAY_MONTH) ? MAY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','May_Month');
        }set;
    }
    private static String JUNE_MONTH{
        get{
            return String.isNotBlank(JUNE_MONTH) ? JUNE_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','June_Month');
        }set;
    }
    private static String JULY_MONTH{
        get{
            return String.isNotBlank(JULY_MONTH) ? JULY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','July_Month');
        }set;
    }
    private static String AUGUST_MONTH{
        get{
            return String.isNotBlank(AUGUST_MONTH) ? AUGUST_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','August_Month');
        }set;
    }
    private static String SEPTEMBER_MONTH{
        get{
            return String.isNotBlank(SEPTEMBER_MONTH) ? SEPTEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','September_Month');
        }set;
    }
    private static String OCTOBER_MONTH{
        get{
            return String.isNotBlank(OCTOBER_MONTH) ? OCTOBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','October_Month');
        }set;
    }
    private static String NOVEMBER_MONTH{
        get{
            return String.isNotBlank(NOVEMBER_MONTH) ? NOVEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','November_Month');
        }set;
    }
    private static String DECEMBER_MONTH{
        get{
            return String.isNotBlank(DECEMBER_MONTH) ? DECEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','December_Month');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_FIRST{
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
    private static String HOLIDAY_RECURRENCE_LAST{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_LAST) ? HOLIDAY_RECURRENCE_LAST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Last');
        }set;
    }
    private static String SOLI_STATUS_ALLOCATED{
        get{
            return String.isNotBlank(SOLI_STATUS_ALLOCATED) ? SOLI_STATUS_ALLOCATED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_Status_ Allocated');
        }set;
    }
    private Static String STATUS_APPROVED{
        get{
            return String.isNotBlank(STATUS_APPROVED) ? STATUS_APPROVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Approved');
        }set;
    }
    private static String STATUS_PENDING{
        get{
            return String.isNotBlank(STATUS_PENDING) ? STATUS_PENDING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Pending');
        }set;
    }
    private static String STATUS_DRAFT{
        get{
            return String.isNotBlank(STATUS_DRAFT) ? STATUS_DRAFT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Draft');
        }set;
    }
    private static String ORDER_RECORD_TYPE_NAME_TRANSFER{
        get{
            return String.isNotBlank(ORDER_RECORD_TYPE_NAME_TRANSFER) ? ORDER_RECORD_TYPE_NAME_TRANSFER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_Transfer');
        }set;
    }
    private static String OLI_RECORD_TYPE_NAME_TRANSFER{
        get{
            return String.isNotBlank(OLI_RECORD_TYPE_NAME_TRANSFER) ? OLI_RECORD_TYPE_NAME_TRANSFER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Line Item','OLI_Record_Type_Name_Transfer');
        }set;
    }
    private static String ORDER_RECORD_TYPE_NAME_BRAND{
        get{
            return String.isNotBlank(ORDER_RECORD_TYPE_NAME_BRAND) ? ORDER_RECORD_TYPE_NAME_BRAND : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_ Brand');
        }set;
    }
    private static String ORDER_RECORD_TYPE_NAME_RETAILER{
        get{
            return String.isNotBlank(ORDER_RECORD_TYPE_NAME_RETAILER) ? ORDER_RECORD_TYPE_NAME_RETAILER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_Retailer');
        }set;
    }
    private static String ORDERBY_NAME{
        get{
            return String.isNotBlank(ORDERBY_NAME) ? ORDERBY_NAME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderBy_Name');
        }set;
    }
    private static String ASC_DIRECTION{
        get{
            return String.isNotBlank(ASC_DIRECTION) ? ASC_DIRECTION : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','ASC_Direction');
        }set;
    }
    private static String DESC_DIRECTION{
        get{
            return String.isNotBlank(DESC_DIRECTION) ? DESC_DIRECTION : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','DESC_Direction');
        }set;
    }
    private static String IMAGE_COMINGSOON{
        get{
            return String.isNotBlank(IMAGE_COMINGSOON) ? IMAGE_COMINGSOON : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Image_ComingSoon');
        }set;
    }
    private static String ERR_MSG_ADD_ONE_OLI{
        get{
            return String.isNotBlank(ERR_MSG_ADD_ONE_OLI) ? ERR_MSG_ADD_ONE_OLI : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Err_Msg_Add_Atleast_One_OLI');
        }set;
    }
    private static String ERR_MSG_ADD_ONE_OTS{
        get{
            return String.isNotBlank(ERR_MSG_ADD_ONE_OTS) ? ERR_MSG_ADD_ONE_OTS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Err_Msg_Add_Atleast_One_OTS');
        }set;
    }
    private static String TYPE_ADD_RETAIL_CONTACT{
        get{
            return String.isNotBlank(TYPE_ADD_RETAIL_CONTACT) ? TYPE_ADD_RETAIL_CONTACT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Retailer_Related_Contact__c','Type_Add_Retail_Contact');
        }set;
    }
    private static String TYPE_SALES_REP{
        get{
            return String.isNotBlank(TYPE_SALES_REP) ? TYPE_SALES_REP : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Retailer_Related_Contact__c','Type_Sales_Rep');
        }set;
    }
    private static String TYPE_ADD_BRAND_CONTACT{
        get{
            return String.isNotBlank(TYPE_ADD_BRAND_CONTACT) ? TYPE_ADD_BRAND_CONTACT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Retailer_Related_Contact__c','Type_Add_Brand_Contact');
        }set;
    }
    private static String ERR_MSG_ORDER_QTY_GT_AVAILABLE_QTY{
        get{
            return String.isNotBlank(ERR_MSG_ORDER_QTY_GT_AVAILABLE_QTY) ? ERR_MSG_ORDER_QTY_GT_AVAILABLE_QTY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Err_Msg_Order_Qty_Gre_than_Available_Qty');
        }set;
    }
    private static String ORDERCANCELLED_CUSTOMER{
        get{
            return String.isNotBlank(ORDERCANCELLED_CUSTOMER) ? ORDERCANCELLED_CUSTOMER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Customer');
        }set;
    }
    private static String ORDER_CANCELLED{
        get{
            return String.isNotBlank(ORDER_CANCELLED) ? ORDER_CANCELLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Cancelled');
        }set;
    }
    private static String ORDER_ALL{
        get{
            return String.isNotBlank(ORDER_ALL) ? ORDER_ALL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_All');
        }set;
    }
    private static String ORDERCANCELLED_FILIGREEN{
        get{
            return String.isNotBlank(ORDERCANCELLED_FILIGREEN) ? ORDERCANCELLED_FILIGREEN : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Filigreen');
        }set;
    }
    private Static String STATUS_IN_PROGRESS{
        get{
            return String.isNotBlank(STATUS_IN_PROGRESS) ? STATUS_IN_PROGRESS: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_In_Progress');
        }set;
    }
    private Static String STATUS_COMPLETED{
        get{
            return String.isNotBlank(STATUS_COMPLETED) ? STATUS_COMPLETED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Completed');
        }set;
    }
    private Static String STATUS_IN_PROCESSING{
        get{
            return String.isNotBlank(STATUS_IN_PROCESSING) ? STATUS_IN_PROCESSING: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Processing');
        }set;
    }
    private static String SEARCHTERM_FILTER{
        get{
            return String.isNotBlank(SEARCHTERM_FILTER) ? SEARCHTERM_FILTER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Filter','SearchTerm');
        }set;
    }
    private static String STATUS_FILTER{
        get{
            return String.isNotBlank(STATUS_FILTER) ? STATUS_FILTER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Filter','Status');
        }set;
    }
    
    private static String Order_Status_Delivered{
        get{
            return String.isNotBlank(Order_Status_Delivered) ? Order_Status_Delivered : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Delivered');
        }set;
    }
    private static String ORDERBYFIELD_FILTER{
        get{
            return String.isNotBlank(ORDERBYFIELD_FILTER) ? ORDERBYFIELD_FILTER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Filter','OrderBy_Field');
        }set;
    }
    private static String IS_ASC{
        get{
            return String.isNotBlank(IS_ASC) ? IS_ASC : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Filter','Is_ASC');
        }set;
    }
    private static String Order_Delete_Confirm_Message{
        get{
            return String.isNotBlank(Order_Delete_Confirm_Message) ? Order_Delete_Confirm_Message : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Delete_Confirm_Message');
        }set;
    }
    private static String Order_Recall_Confirm_Message{
        get{
            return String.isNotBlank(Order_Recall_Confirm_Message) ? Order_Recall_Confirm_Message : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Recall_Confirm_Message');
        }set;
    }
    private static String Transfer_Order_Recall_Confirm_Message{
        get{
            return String.isNotBlank(Transfer_Order_Recall_Confirm_Message) ? Transfer_Order_Recall_Confirm_Message : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Transfer_Order_Recall_Confirm_Message');
        }set;
    }
    
    private static String Order_Deleted_Message {
        get{
            return String.isNotBlank(Order_Deleted_Message ) ? Order_Deleted_Message  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Deleted_Message');
        }set;
    }
    private static String Transfer_Order_Deleted_Message {
        get{
            return String.isNotBlank(Transfer_Order_Deleted_Message ) ? Transfer_Order_Deleted_Message  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Transfer_Order_Deleted_Message');
        }set;
    }
    private static String Transfer_Order_Delete_Confirm_Message {
        get{
            return String.isNotBlank(Transfer_Order_Delete_Confirm_Message ) ? Transfer_Order_Delete_Confirm_Message  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Transfer_Order_Delete_Confirm_Message');
        }set;
    }
    private static String Product_Family_Marketing_Materials {
        get{
            return String.isNotBlank(Product_Family_Marketing_Materials ) ? Product_Family_Marketing_Materials  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Family_Marketing_Materials');
        }set;
    }
    
    private static String Orders_Requiring_QR_Codes {
        get{
            return String.isNotBlank(Orders_Requiring_QR_Codes ) ? Orders_Requiring_QR_Codes  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Orders_Requiring_QR_Codes');
        }set;
    }
    private static String Orders_Requiring_Bar_Codes {
        get{
            return String.isNotBlank(Orders_Requiring_Bar_Codes ) ? Orders_Requiring_Bar_Codes  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Orders_Requiring_Bar_Codes');
        }set;
    }
    private static String Orders_Requiring_BarCodes_and_or_QR_Code {
        get{
            return String.isNotBlank(Orders_Requiring_BarCodes_and_or_QR_Code ) ? Orders_Requiring_BarCodes_and_or_QR_Code  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Orders_Requiring_BarCodes_and_or_QR_Code');
        }set;
    }
    
    private static String Factoring_Contact_Required_For_Order {
        get{
            return String.isNotBlank(Factoring_Contact_Required_For_Order ) ? Factoring_Contact_Required_For_Order  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Factoring_Contact_Required_For_Order');
        }set;
    }
    private static String Factoring_Terms_Required_For_Order {
        get{
            return String.isNotBlank(Factoring_Terms_Required_For_Order ) ? Factoring_Terms_Required_For_Order  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Factoring_Terms_Required_For_Order');
        }set;
    }
    private static String ACCOUNT_PLATEFORMLEVEL_ADVANCE {
        get{
            return String.isNotBlank(ACCOUNT_PLATEFORMLEVEL_ADVANCE ) ? ACCOUNT_PLATEFORMLEVEL_ADVANCE  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Plateformlevel_Advance');
        }set;
    }
    private static String Order_Line_Status_Cancelled{
        get{
            return String.isNotBlank(Order_Line_Status_Cancelled) ? Order_Line_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Line Item','Order_Line_Status_Cancelled');
        }set;
    }
    private static String Order_Line_Status_Rejected{
        get{
            return String.isNotBlank(Order_Line_Status_Rejected) ? Order_Line_Status_Rejected : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Line Item','Order_Line_Status_Rejected');
        }set;
    }
    private static String Orders_Requiring_Third_Party_Scheduler {
        get{
            return String.isNotBlank(Orders_Requiring_Third_Party_Scheduler ) ? Orders_Requiring_Third_Party_Scheduler  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Orders_Requiring_Third_Party_Scheduler');
        }set;
    }
    private static String Orders_Requiring_TPS_and_or_QR_Code {
        get{
            return String.isNotBlank(Orders_Requiring_TPS_and_or_QR_Code ) ? Orders_Requiring_TPS_and_or_QR_Code  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Orders_Requiring_TPS_and_or_QR_Code');
        }set;
    }
    private static String Orders_Requiring_TPS_and_or_Bar_Code {
        get{
            return String.isNotBlank(Orders_Requiring_TPS_and_or_Bar_Code ) ? Orders_Requiring_TPS_and_or_Bar_Code  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Orders_Requiring_TPS_and_or_Bar_Code');
        }set;
    }
    private static String Orders_Requiring_TPS_and_Bar_Code_and_QR {
        get{
            return String.isNotBlank(Orders_Requiring_TPS_and_Bar_Code_and_QR ) ? Orders_Requiring_TPS_and_Bar_Code_and_QR  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Orders_Requiring_TPS_and_Bar_Code_and_QR');
        }set;
    }
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
    private static String ACCOUNT_PLATEFORMLEVEL_BASIC {
        get{
            return String.isNotBlank(ACCOUNT_PLATEFORMLEVEL_BASIC ) ? ACCOUNT_PLATEFORMLEVEL_BASIC  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Plateformlevel_Basic');
        }set;
    }
    private static String OT_TRANSPORT_LICENSE_TYPES {
        get{
            return String.isNotBlank(OT_TRANSPORT_LICENSE_TYPES ) ? OT_TRANSPORT_LICENSE_TYPES  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','OT_Transport_License_Types');
        }set;
    }
	private static String Sample_Limitation_Error_Msg {
        get{
            return String.isNotBlank(Sample_Limitation_Error_Msg ) ? Sample_Limitation_Error_Msg  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Sample_Limitation_Error_Msg');
        }set;
    }
    private static final String RECEIVING_INSPECTION = Label.Default_Inventory_Location;
    public static Id priceBookId = (Utility.loggedInUser.Contact.Account.Community_Price_Book__c != null? Utility.loggedInUser.Contact.Account.Community_Price_Book__c: null);
    public static Id brandId = Utility.loggedInUser.AccountId;
    public static String brandPlatformLevel = Utility.loggedInUser.Account.Platform_Level__c != null ? Utility.loggedInUser.Account.Platform_Level__c : '';
    public static String loggedContactId = Utility.loggedInUser.ContactId;
    static String recordTypeName = PRODUCT_RECORD_TYPE_NAME_PRODUCT;
    static Map<String, String> distyBrandPriceBooks = Utility.distyBrandPriceBooks;
    public static List<String> distyBrandNames = new List<String>(distyBrandPriceBooks.keySet());
    public static List<String> distyPriceBooks = distyBrandPriceBooks.values();
    public static String membershipLevel{
        get{
            if(membershipLevel == NULL){
            	membershipLevel = [SELECT Id, Membership_Level__c FROM Account WHERE Id = : Utility.loggedInUser.AccountId].Membership_Level__c;
            }
            return membershipLevel;
        }set;
    }
    public static Factoring_Relationship__c [] factoringRelationships{
        get{
            if(factoringRelationships == NULL){
                factoringRelationships = [SELECT Id, Name, Master_Assignment_Date__c ,Factoring_Assignee__c , Factoring_Assignee__r.DBA__c, Buyer_Account__c , Buyer_Account__r.DBA__c,
                                          (SELECT Id,Name, Effective_From__c ,Effective_To__c  ,Factoring_Rate__c, Payment_Terms__c , Factoring_Relationship__c 
                                           FROM Factoring_Rates__r
                                           WHERE Effective_From__c <= :System.today()
                                           AND Effective_To__c >= :System.today()) 
                                          FROM Factoring_Relationship__c WHERE Seller_Account__c = :brandId];
            }
            return factoringRelationships;
        }set;
    }
    public static Boolean isDisty{
        get{
            if(Utility.loggedInUser.AccountId != null &&
               (Utility.loggedInUser.Account.Type == ACCOUNT_TYPE_DISTY_PARTNER)){
                    isDisty = true;
                }else{
                    isDisty = false;
                }
            return isDisty;
        }set;
    }
    public static Set<String> bulkFamilies{
        get{
        bulkFamilies = new Set<String>();     
        for(Product_Categories__c pc : [SELECT Id, Category__c ,Name,Icon_Name__c ,Product_Families__c FROM Product_Categories__c WHERE Name = 'Bulk' AND Product_Families__c != null  Order By Sort_Order__c]){
            bulkFamilies.addAll(pc.Product_Families__c.split(';'));
        }
        return bulkFamilies;
        }set;
    }
    public static Map<String,Decimal> 	SampleOrderParentFamilyMap{
        get{
            if(SampleOrderParentFamilyMap == NULL){
                SampleOrderParentFamilyMap = new Map<String,Decimal>();
                for(Sample_Order_Parent_Family_Config__mdt soPFConfig: [SELECT Id,Name__c,Max_Line_Items_Per_Order__c FROM Sample_Order_Parent_Family_Config__mdt ] ){
                    SampleOrderParentFamilyMap.put(soPFConfig.Name__c,soPFConfig.Max_Line_Items_Per_Order__c);
                }
            }
            return SampleOrderParentFamilyMap;
        }set;
    }
    public static Map<String,Sample_Order_Family_Config__mdt> SampleOrderFamilyMap{
        get{
            if(SampleOrderFamilyMap == NULL){
                SampleOrderFamilyMap = new Map<String,Sample_Order_Family_Config__mdt>();
                for(Sample_Order_Family_Config__mdt soFConfig: [SELECT Id,Name__c,Parent_Family__c,Qty_Limit_Per_Order_Line__c FROM Sample_Order_Family_Config__mdt ] ){
                    SampleOrderFamilyMap.put(soFConfig.Name__c,soFConfig);
                }
            }
            return SampleOrderFamilyMap;
        }set;
    }
    /*private static String Product_Families_to_Skip_QA_Review {
        get{
            return String.isNotBlank(Product_Families_to_Skip_QA_Review ) ? Product_Families_to_Skip_QA_Review  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Families_to_Skip_QA_Review');
        }set;
    }*/
    public static Set<String> Product_Families_to_Skip_QA_Review_Set{
        get{
            Product_Families_to_Skip_QA_Review_Set = new Set<String>();
            String Product_Families_to_Skip_QA_Review = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Families_to_Skip_QA_Review');
            for(String pftsqr : Product_Families_to_Skip_QA_Review.split(';')){
                Product_Families_to_Skip_QA_Review_Set.add(pftsqr);
            }
            return Product_Families_to_Skip_QA_Review_Set;
        }set;
    }
    @AuraEnabled
    public static AuraResponse addToCart(String addToCartData){
        AuraResponse r = new AuraResponse('RetailDeliveryTicketsCtlr.addToCart()');
        ProductsCtlr.addToCart(addToCartData);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse recallOrder(String recordId){
    	AuraResponse r = new AuraResponse('RetailDeliveryTicketsCtlr.deleteOrder()');
        Order__c odr =[SELECT Id,Name,Status__c FROM Order__c WHERE Id =:recordId];
        try {
        	odr.Status__c = STATUS_DRAFT;
            update odr;
        }
        catch(Exception e) {
            r.handleErrors();
        }
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse deleteOrder(String recordId){
        AuraResponse r = new AuraResponse('RetailDeliveryTicketsCtlr.deleteOrder()');
        Order__c odr =[SELECT Id,Name FROM Order__c WHERE Id =:recordId];
        String odrName =odr.Name;
        try {
            delete odr;
            
        }
        catch(Exception e) {
            r.handleErrors();
            //resultMap.put('message',e.getMessage());
        }
        return r;     
    }
    @AuraEnabled
    public static AuraResponse init(String recordId,Boolean fromTransferOrders,String retailDeliveryTicketData ,String retailDeliveryTicketLineItemsData,String isClone){
        AuraResponse r = new AuraResponse('RetailDeliveryTicketsCtlr.init()');
        Community_Settings__c csObj = Community_Settings__c.getValues(COMMUNITY_SETTINGS_DEFAULT);
        r.data.put('commSetting', csObj);
        Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
        r.data.put('companySetting', ccs);
        r.data.put('brandPlatformLevel', brandPlatformLevel);
        if(ccs.Exclude_Excise_Tax_Types__c != null){
            r.data.put('excludeExciseTaxTypes',ccs.Exclude_Excise_Tax_Types__c.split(','));
        }        
        r.data.put('paymentTerms', Utility.getPicklistItems('Order__c', 'Payment_Terms__c'));
        r.data.put('Additional_Brand_Contact_Help_Text',System.Label.Additional_Brand_Contact_Help_Text);
        r.data.put('factoringRelationships',factoringRelationships);
       	r.data.put('EARLIEST_DELIVERY_TIME',EARLIEST_DELIVERY_TIME);
        r.data.put('LATEST_DELIVERY_TIME',LATEST_DELIVERY_TIME);
        
        r.data.put('cliRegularProductWithSamplePrice',ERR_MSG_REGULARPRODUCTWITHSAMPLEPRICE);
        if(fromTransferOrders)
        	r.data.put('ERR_MSG_ADD_ONE_OTS',ERR_MSG_ADD_ONE_OTS);
        else
        r.data.put('ERR_MSG_ADD_ONE_OLI',ERR_MSG_ADD_ONE_OLI);
        r.data.put('ERR_MSG_ORDER_QTY_GT_AVAILABLE_QTY',ERR_MSG_ORDER_QTY_GT_AVAILABLE_QTY);
        List<Map<String,String>> siteOptions = new List<Map<String,String>>();
        Map<Id,Site__c> activeSiteMap = new Map<Id,Site__c>();
        for(Site__c s: [SELECT Id,Name,Warehouse_Name__c,License_ID__c,License_ID__r.License_DBA__c,License_ID__r.License_Number__c,License_ID__r.License_Type__c,License_ID__r.License_Address__c,
                            License_ID__r.License_Zip__c, License_ID__r.License_Country__c, License_ID__r.License_State__c, 
                            License_ID__r.License_City__c FROM Site__c WHERE Active__c = true]){
            siteOptions.add(new Map<String,String>{'id'=>s.Id,'name'=>s.Warehouse_Name__c});
            activeSiteMap.put(s.Id,s);
        }
        r.data.put('activeSiteMap', activeSiteMap);
        r.data.put('siteOptions',siteOptions);
        
        List<String> lcTypes = OT_TRANSPORT_LICENSE_TYPES.split(',');//new List<String>{'Type 11','Type 12','Type 13'};
            
		List<Map<String, String>> transporterLicenses = new List<Map<String, String>>();
        for(State_Licenses__c sl: [SELECT License_Number__c,Id,License_Name__r.DBA__c,License_Status__c,License_Name__r.Hide_from_Marketplace__c,License_Type__c
                                   FROM State_Licenses__c WHERE License_Status__c = :'Active' /*AND License_Name__r.Hide_from_Marketplace__c = false */
                                   AND Default_Warehouse__r.Active__c = true AND License_Type__c IN :lcTypes ORDER BY License_Name__r.DBA__c]){
        	transporterLicenses.add(new Map<String, String>{'value'=> sl.Id, 'label'=>sl.License_Number__c+' | '+sl.License_Name__r.DBA__c});	                               
        }
        r.data.put('transporterLicenses',transporterLicenses);
        
        if(factoringRelationships.size () > 0){
            Set<Id> assigneeIds = new Set<Id>();
            for(Factoring_Relationship__c FR: factoringRelationships){
                assigneeIds.add(FR.Factoring_Assignee__c);
            }
            if(assigneeIds.size() > 0){
                Account[] factoringAccountWithContacts = [SELECT Id,(SELECT Id, Name, Email FROM Contacts WHERE Active__c = true ) FROM Account WHERE Id IN :assigneeIds ];
                Map<Id,Contact[]> factoringContactsMap = new Map<Id,Contact[]>();
                for(Account acc: factoringAccountWithContacts){
                    factoringContactsMap.put(acc.Id,acc.Contacts);
                }
                r.data.put('factoringRelationshipContactsMap',factoringContactsMap);
            }
        }
        List<Map<String, String>> retailers = new List<Map<String, String>>();
        Map<String, String> retailerPaymentTerms = new Map<String, String>();
        Map<String, Line_Card__c> retailerSelesRep = new Map<String, Line_Card__c>();
        Map<String, String> retailersMap = new Map<String, String>();
        Set<Id> bandRetailers = new Set<Id>();
        List<String> priceBookIds = new List<String>();
        List<String> brandIds = new List<String>();
		brandIds.add(brandId);
        //if(isDisty){
            brandIds.addAll(distyBrandNames);
            priceBookIds.addAll(distyPriceBooks);
        //}
        priceBookIds.add(priceBookId);
        for(Line_Card__c lc: [SELECT Retailer_Name__c,Community_Price_Book__c,Mutual_Payment_Terms__c,Sales_Person__c,Sales_Person__r.Name,Brand_Name__c, Retailer_Name__r.Name, Retailer_DBA__c  FROM Line_Card__c WHERE Brand_Name__c = :brandIds AND (Retailer_Name__c = :brandId OR Retailer_Name__r.Hide_From_Marketplace__c = false) ORDER BY Retailer_DBA__c]){
            retailersMap.put(lc.Retailer_Name__c,lc.Retailer_DBA__c);
            //priceBookIds.add(lc.Community_Price_Book__c);
            //retailers.add(new Map<String, String>{'id'=> lc.Retailer_Name__c, 'name'=> lc.Retailer_DBA__c });
            bandRetailers.add(lc.Retailer_Name__c);
            retailerSelesRep.put(lc.Retailer_Name__c,lc);
            /*if(isDisty){
                if(lc.Brand_Name__c == brandId){
                    retailerPaymentTerms.put(lc.Retailer_Name__c,lc.Mutual_Payment_Terms__c);
                }
            }else{*/
				retailerPaymentTerms.put(lc.Retailer_Name__c,lc.Mutual_Payment_Terms__c);                
            //}
            
        }
        /*for(String rId: retailersMap.keySet()){
            retailers.add(new Map<String, String>{'id'=> rId, 'name'=> retailersMap.get(rId) });
        }*/
        
        
        Map<String, Object> retailersDetail = new Map<String, Object>();
        for(Account a:[SELECT Name,dBA__c,Payment_Terms__c,QR_Code__c,Bar_Code__c,Third_Party_Scheduler__c, (SELECT Name,LastName, FirstName,Email FROM Contacts WHERE Active__c = true AND Email != null Order By Name), (SELECT Id,License_Number__c, License_Address__c, License_City__c, License_State__c,License_Type__c, License_Country__c, License_Zip__c, Default_Warehouse__c,Default_Warehouse__r.License_ID__r.License_Address__c, Default_Warehouse__r.License_ID__r.License_City__c, Default_Warehouse__r.License_ID__r.License_State__c,Default_Warehouse__r.License_ID__r.License_Country__c,Default_Warehouse__r.License_ID__r.License_Zip__c FROM State_Licenses__r WHERE License_Status__c =: STATE_LICENSE_ACTIVE) FROM Account WHERE Id IN :bandRetailers ORDER BY DBA__c]){
            List<Map<String, String>> licenses = new List<Map<String, String>>();
            List<Map<String, String>> addresses = new List<Map<String, String>>();
            List<Map<String, String>> wAddresses = new List<Map<String, String>>();
            map<String,State_Licenses__c> statelicenses = new map<String,State_Licenses__c>();
            
            
            List<Map<String, String>> typeMap = new List<Map<String, String>>();
            for(State_Licenses__c sl:a.State_Licenses__r){
                List<String> address = new List<String>();
                List<String> wAddress = new List<String>();
                
                address.add(sl.License_Address__c);
                if(String.isNotBlank(sl.License_City__c)){
                    address.add(sl.License_City__c);
                }
                if(String.isNotBlank(sl.License_State__c)){
                    address.add(sl.License_State__c);
                }
                if(String.isNotBlank(sl.License_Country__c)){
                    address.add(sl.License_Country__c);
                }
                if(String.isNotBlank(sl.License_Zip__c)){
                    address.add(sl.License_Zip__c);
                }
                
                wAddress.add(sl.Default_Warehouse__r.License_ID__r.License_Address__c);
                if(String.isNotBlank(sl.Default_Warehouse__r.License_ID__r.License_City__c)){
                    wAddress.add(sl.Default_Warehouse__r.License_ID__r.License_City__c);
                }
                if(String.isNotBlank(sl.Default_Warehouse__r.License_ID__r.License_State__c)){
                    wAddress.add(sl.Default_Warehouse__r.License_ID__r.License_State__c);
                }
                if(String.isNotBlank(sl.Default_Warehouse__r.License_ID__r.License_Country__c)){
                    wAddress.add(sl.Default_Warehouse__r.License_ID__r.License_Country__c);
                }
                if(String.isNotBlank(sl.Default_Warehouse__r.License_ID__r.License_Zip__c)){
                    wAddress.add(sl.Default_Warehouse__r.License_ID__r.License_Zip__c);
                }
                
                wAddresses.add(new Map<String, String>{'id'=> sl.Id, 'address'=> String.join(wAddress, ', ')});
                if(fromTransferOrders){
                    List<String> excludeD2DTypes = ccs.Exclude_D2D_License_Types__c != null?ccs.Exclude_D2D_License_Types__c.split(','):new List<String>();
                    if(!(ccs.Exclude_D2D_License_Types__c != null && excludeD2DTypes.indexOf(sl.License_Type__c) != -1)){
                    	licenses.add(new Map<String, String>{'id'=> sl.Id, 'address'=> sl.License_Number__c+' | '+String.join(address, ', ')});   
                    }
                }else{
                	licenses.add(new Map<String, String>{'id'=> sl.Id, 'address'=> sl.License_Number__c+' | '+String.join(address, ', ')});    
                }
                addresses.add(new Map<String, String>{'id'=> sl.Id, 'address'=> String.join(address, ', ')});
                statelicenses.put(sl.Id,sl);
                
                // added this map for retailer type
                //fg 420
                typeMap.add(new Map<String, String>{'id'=> sl.Id, 'type'=> sl.License_Type__c});
            }
            if(licenses.size() > 0){
            	retailers.add(new Map<String, String>{'id'=> a.Id, 'name'=> retailersMap.get(a.Id) });    
            }
            List<Map<String, String>> contacts = new List<Map<String, String>>();
            Map<String,String> lineCard = new Map<String,String>();
            for(Contact c:a.Contacts){
                contacts.add(new Map<String, String>{'id'=> c.Id, 'name'=> c.Name +' - '+c.Email});//Name
            }
            System.debug('salesRep###  '+ retailerSelesRep.get(a.Id));
            retailersDetail.put(a.Id, new Map<String, Object>{'statelicenses'=>statelicenses,'licenses'=> licenses,'warehouseAddress'=>wAddresses, 'contacts'=> contacts,'retailer'=>a,'addresses'=> addresses,'lineCard'=> lineCard,'paymentTerm'=>retailerPaymentTerms.get(a.Id),'salesRep' => retailerSelesRep.get(a.Id),'typeMap' => typeMap});
        }
        r.data.put('retailers', retailers);
        r.data.put('retailersDetail', retailersDetail);
        r.data.put('brandId', brandId);
        Contact conForMaxDiscountAmt = [SELECT id,Max_Order_Discount__c FROM Contact WHERE Id =: loggedContactId];
        if(conForMaxDiscountAmt != null)
            r.data.put('MaxDiscountAmt', conForMaxDiscountAmt.Max_Order_Discount__c);
        List<Map<String, String>> brandContacts = new List<Map<String, String>>();
        List<Map<String, String>> salesReps = new List<Map<String, String>>();
        for(Contact c:[SELECT Name,LastName, FirstName FROM Contact WHERE Id != :loggedContactId AND Active__c = true AND Email != null AND AccountId =:brandId Order By Name]){
            brandContacts.add(new Map<String, String>{'id'=> c.Id, 'name'=> c.Name});
        }
        
        for(Contact c: [select Id,Name from Contact where AccountId =: brandId AND Active__c = true Order By Name]){
            salesReps.add(new Map<String, String>{'id'=> c.Id, 'name'=> c.Name});
        }
        
        r.data.put('salesReps', salesReps);
        r.data.put('brandContacts', brandContacts);
        //add to cart/get product
        Product[] bProducts = new Product[]{};
            //BrandProduct[] products = new BrandProduct[]{};
            List<String>priceBooks = new List<String>();
        priceBooks.add(priceBookId);
        
        Map<String, Product> records = new Map<String, Product>();
        Map<String, Decimal> productOrderedQtyMap = new Map<String, Decimal>();
        Map<String, String> pbeProductMap = new Map<String, String>();
        Map<String, String> pbeProductAllMap = new Map<String, String>();
        Map<String, Product[]> procuderProducts = new Map<String, Product[]>();
        
        List<PricebookEntry> lstPBE = new List<PricebookEntry>();
        List<PricebookEntry> lstPBEBulk = new List<PricebookEntry>();
        
        List<String> productFamilies = new List<String>();     
        Set<String> bulkFamilies = new Set<String>();     
        for(Product_Categories__c pc : [SELECT Id, Category__c ,Name,Icon_Name__c ,Product_Families__c FROM Product_Categories__c WHERE  Icon_Name__c != null Order By Sort_Order__c]){
            if(pc.Product_Families__c != null && pc.Product_Families__c != ''){
                productFamilies.addAll(pc.Product_Families__c.split(';'));
                if(pc.Name == 'Bulk' ){
                	bulkFamilies.addAll(pc.Product_Families__c.split(';'));
            	}
            }
        }
        system.debug('brandIds :'+brandIds.size()+'-priceBookIds :'+priceBookIds.size()+'-recordTypeName :'+recordTypeName);
        if(fromTransferOrders){
            lstPBE = [SELECT Id, Product2.Name,Product2.Product_Short_Description__c,Product2.White_Labelled__c,Product2.Producer_Name__r.DBA__c,Product2.Producer_Name__r.Name,Product2.Licensee_Name__c,Product2.Licensee_Name__r.Name,Product2.Licensee_Name__r.DBA__c, Product2Id, Product2.Image_URL__c,Product2.Brand_Name__c,Product2.RecordType.Name,Product2.Parent_Product__c,Product2.Is_Sample__c,Product2.Family,Product2.Producer_Name__c ,Product2.Description, UnitPrice,Product2.Available_Inventory__c,Product2.Available_Qty__c,Product2.MOQ__c,Product2.Total_Order_Qty__c,Product2.Unit_Shipping_Weight_lbs__c, Product2.Case_Shipping_Weight_lbs__c,Product2.Apply_Excise_Tax__c,Product2.Max_Order_Allowed__c FROM PricebookEntry WHERE (Product2.Hide_From_Marketplace__c = false  OR Product2.Family LIKE 'Bulk%') AND ((Product2.Producer_Name__c IN :brandIds AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c IN :brandIds AND Product2.White_Labelled__c = true) ) AND PriceBook2Id IN :priceBookIds AND Product2.RecordType.Name = :recordTypeName AND Product2.IsActive = true Order By Product2.Name];
        } else {
            productFamilies.add(Product_Family_Marketing_Materials);
            productFamilies.add(PRODUCT_RECORD_TYPE_NAME_DISCOUNT);
            lstPBE = [SELECT Id, Product2.Name,Product2.Product_Short_Description__c,Product2.White_Labelled__c,Product2.Producer_Name__r.DBA__c,Product2.Producer_Name__r.Name,Product2.Licensee_Name__c,Product2.Licensee_Name__r.DBA__c,Product2.Licensee_Name__r.Name, Product2Id, Product2.Image_URL__c,Product2.Brand_Name__c,Product2.RecordType.Name,Product2.Parent_Product__c,Product2.Is_Sample__c,Product2.Family,Product2.Producer_Name__c ,Product2.Description, UnitPrice,Product2.Available_Inventory__c,Product2.Available_Qty__c,Product2.MOQ__c,Product2.Total_Order_Qty__c,Product2.Unit_Shipping_Weight_lbs__c, Product2.Case_Shipping_Weight_lbs__c,Product2.Apply_Excise_Tax__c,Product2.Max_Order_Allowed__c FROM PricebookEntry WHERE UnitPrice !=:0   AND (Product2.Hide_From_Marketplace__c = false  OR Product2.Family LIKE 'Bulk%') AND ((Product2.Producer_Name__c IN :brandIds AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c IN :brandIds AND Product2.White_Labelled__c = true) ) AND PriceBook2Id IN :priceBookIds AND( Product2.RecordType.Name = :recordTypeName OR Product2.RecordType.Name =:PRODUCT_RECORD_TYPE_NAME_DISCOUNT) AND Product2.IsActive = true AND (Product2.Family IN : productFamilies OR Product2.Family LIKE 'Bulk%') Order By Product2.Name];
        }
        
        //lstPBEBulk = [SELECT Id, Product2.Name,Product2.Product_Short_Description__c,Product2.White_Labelled__c,Product2.Producer_Name__r.DBA__c,Product2.Producer_Name__r.Name,Product2.Licensee_Name__c,Product2.Licensee_Name__r.Name,Product2.Licensee_Name__r.DBA__c, Product2Id, Product2.Image_URL__c,Product2.Brand_Name__c,Product2.RecordType.Name,Product2.Parent_Product__c,Product2.Is_Sample__c,Product2.Family,Product2.Producer_Name__c ,Product2.Description, UnitPrice,Product2.Available_Inventory__c,Product2.Available_Qty__c,Product2.MOQ__c,Product2.Total_Order_Qty__c,Product2.Unit_Shipping_Weight_lbs__c, Product2.Case_Shipping_Weight_lbs__c,Product2.Apply_Excise_Tax__c,Product2.Max_Order_Allowed__c FROM PricebookEntry WHERE ((Product2.Producer_Name__c IN :brandIds AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c IN :brandIds AND Product2.White_Labelled__c = true) ) AND PriceBook2Id IN :priceBookIds AND Product2.RecordType.Name = :recordTypeName AND Product2.IsActive = true AND Product2.Family LIKE 'Bulk%' Order By Product2.Name];
        
        //lstPBE.addAll(lstPBEBulk);
        for(PricebookEntry pbe: lstPBE){
            Product p = new Product(pbe);
            
            if(pbe.Product2.Family.startsWith('Bulk')){
                p.isBulkProduct = true;
            }else{
                p.isBulkProduct = false;
            }
            /*if(pbe.Product2.White_Labelled__c && pbe.Product2.Licensee_Name__c != null && pbe.Product2.Licensee_Name__r.DBA__c != null){
                p.brandName = pbe.Product2.Licensee_Name__r.DBA__c;
                p.brandId = pbe.Product2.Licensee_Name__c;
            } else if(pbe.Product2.Producer_Name__c != null && pbe.Product2.Producer_Name__r.DBA__c != null){
                p.brandName = pbe.Product2.Producer_Name__r.DBA__c;
                p.brandId = pbe.Product2.Producer_Name__c;
            }*/
            
            p.brandName = pbe.Product2.Brand_Name__c;
            p.brandId = brandId;
            /*if(pbe.Product2.Is_Sample__c){
            	p.isSample = true;   
            } else {
                pbeProductMap.put(pbe.Product2Id,pbe.Id);
            }*/
            pbeProductMap.put(pbe.Product2Id,pbe.Id);
            decimal availableQty = p.availableQty / p.MOQ;
            if(availableQty > 0 || p.isDiscountProduct == true)
            	records.put(pbe.Product2Id, p);
            productOrderedQtyMap.put(pbe.Product2Id,pbe.Product2.Total_Order_Qty__c);
            if(procuderProducts.containsKey(pbe.Product2.Producer_Name__c)){
                procuderProducts.get(pbe.Product2.Producer_Name__c).add(p);
            }else{
                procuderProducts.put(pbe.Product2.Producer_Name__c,new Product[]{p});
            }
        }
       
        System.debug('pbeProductMap = '+pbeProductMap.size());
        /*for(Product pro : records.values()){
            if(pro.isSample && pro.parentProductId != null){
                if(pbeProductMap.containsKey(pro.parentProductId)){
                    pro.price.id = pbeProductMap.get(pro.parentProductId);
                    System.debug('pbeProductMap1 = '+pro.price.id);
                }
            }
        }*/
        
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Brand__c IN: procuderProducts.keySet() AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now()]){
            Product[] products = procuderProducts.get(bd.Brand__c);
            if(products != null){
                for(Product p: products){
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
            }
        }
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Product_Name__c IN: records.keySet() AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now()]){
            Product p = records.get(bd.Product_Name__c);
            if(p != null){
                if(p.discountPercent != null){
                    p.setProductDiscountPercent(bd.Discount_Percentage__c);
                }else{
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
                
            }
        }
        /*for(Product2 p: [SELECT Name FROM Product2 WHERE Producer_Name__c = :brandId AND IsActive = true ORDER BY Name]){
products.add(new BrandProduct(p));
}*/
        r.data.put('products', records.values());
        r.data.put('productOrderedQtyMap',productOrderedQtyMap);
        r.data.put('warehouseAvailableInventoryMap',getWarehouseAvailableInventory(records.keySet()));
        r.data.put('warehouseTotalOrderedMap',getWarehouseOrderedMap(records.keySet()));
        
        RetailDeliveryTicket rdt = new RetailDeliveryTicket();
        List<String> relatedContacts = new List<String>();
        List<RetailDeliveryTicketLineItem> retailDeliveryTicketLineItems = new List<RetailDeliveryTicketLineItem>();
        
        if(String.isNotBlank(recordId) || isClone.equals('True')){
            String RetailerId = '';
            if(String.isNotBlank(recordId)){
                
                
                for(Order__c o :[SELECT Name,Account__c,Account__r.Name,Site__c,Site__r.Warehouse_Name__c, Order_Date__c, Total__c, Status__c,Payment_Terms__c,Route_Miles__c,Retailer__c,Sales_Person__c,Sales_Person__r.Name,
                                 Retailer__r.Name,Retailer__r.dBA__c,Retailer_Contact__c,Additional_Brand_Contact__c,Additional_Brand_Contact__r.Name,
                                 Retailer_Contact__r.Name,Factoring_Terms__c,Request_Ship_Date__c,Retailer_PO__c,Special_Instructions__c,State_License__c,isPreapproved__c,Requested_Delivery_Latest_Time__c,Requested_Delivery_Earliest_Time__c,
                                 State_License__r.Name,State_License__r.License_Number__c,Total_Line_Items__c, Shipping_Street__c, 
                                 Shipping_Country__c,Sample_Order__c, Shipping_Province__c, Shipping_City__c, Shipping_Zip__c,Exclude_Excise_Tax__c,
                                 Transporter__r.License_Number__c,Transporter__r.License_Name__r.DBA__c,Total_Excise_Tax_Amount__c ,
                                 Total_Local_Tax__c, Order_Booking_Fee__c,Service_Booking_Fee__c,Service_Scheduling_Fee__c,Service_Staging_Fee__c,Pack_Out_Fee__c,Stage_Manifest_Fee__c,Schedule_Dispatch_Fee__c,
                                 Total_Milage_Fee__c,Total_Weight_Fee__c,Invoice_Memo__c,Factoring_Assignee__c,Factoring_Assignee__r.DBA__c,Factoring_Contact__c,Factoring_Contact__r.Name,Factoring_Rate__c,Factoring_Discount__c, Piggyback_sample__c ,
                                 (SELECT Name,Quantity_Cases__c, UnitPrice__c, Line_Total_Cost__c, Unit_Excise_Tax__c, Line_Total_Excise_Tax__c,
                                  Line_Total_Qty__c, MOQ__c, Total__c, Is_Sample__c, Price_Book_Entry_Id__c, Product__c, Product__r.Name, 
                                  Product__r.Image_URL__c,Product__r.RecordType.Name,Product__r.Parent_Product__c, Product__r.Max_Order_Allowed__c,Product__r.Description, Product__r.Producer_Name__r.Name,Product__r.Product_Details__c, 
                                  Product__r.Is_Sample__c,Product__r.Product_Short_Description__c,Product__r.Family,Product__r.Brand_Name__c, Product__r.Product_Rating__c, Product__r.Available_Inventory__c,Product__r.Available_Qty__c,Is_Brand_Product__c,
                                  Special_Instructions__c,IsPromo__c, Subtotal_Local_Cannabis_Tax__c,Product__r.Apply_Excise_Tax__c,Pick_Pack_Fee__c,QA_Review_Fee__c,Total_Weight_lbs__c   
                                  FROM Order_Line_Items__r),
                                 (SELECT Id,Contact__c,Contact__r.Name,Type__c FROM Retailer_Related_Contacts__r) 
                                 FROM Order__c WHERE Id = :recordId]){
                                     rdt = new RetailDeliveryTicket(o);   
                                     rdt.transportLicenseName = o.Transporter__r.License_Number__c+' | '+o.Transporter__r.License_Name__r.DBA__c;
                                     RetailerId = o.Retailer__c;
                                     if(String.isNotBlank(rdt.id)){
                                         for(Order_Line_Item__c tmpRDTLI: o.Order_Line_Items__r){
                                             RetailDeliveryTicketLineItem rdi = new RetailDeliveryTicketLineItem(tmpRDTLI);
                                             Product p = records.get(rdi.Product);
                                             System.debug('###price::'+p);
                                             
                                             if(p != null){
                                                 rdi.listPrice = p.price.unitPrice;
                                                 rdi.ProductBookEntryId = p.price.Id;
                                             }
                                             retailDeliveryTicketLineItems.add(rdi);
                                         }
                                         if(o.Retailer_Related_Contacts__r.size() > 0){
                                             for(Retailer_Related_Contact__c rrc: o.Retailer_Related_Contacts__r)
                                                 relatedContacts.add(rrc.Contact__c);
                                         }
                                     }
                                 }
                decimal Minimum_Order_Value = 0;
                for(Line_Card__c lc: [SELECT Minimum_Order_Value__c,Retailer_Name__c,Brand_Name__c, Retailer_Name__r.Name, Retailer_DBA__c  FROM Line_Card__c WHERE Retailer_Name__r.Hide_From_Marketplace__c = false AND Brand_Name__c = :brandIds AND Retailer_Name__c = :RetailerId  ORDER BY Retailer_DBA__c]){
                   Minimum_Order_Value = lc.Minimum_Order_Value__c != null ? lc.Minimum_Order_Value__c : 0;
                }
                r.data.put('Minimum_Order_Value',Minimum_Order_Value);
                
            }
            if(isClone.equals('True')){
                rdt = (RetailDeliveryTicket)JSON.deserialize(retailDeliveryTicketData, RetailDeliveryTicket.class);
                retailDeliveryTicketLineItems = (List<RetailDeliveryTicketLineItem>)JSON.deserialize(retailDeliveryTicketLineItemsData, List<RetailDeliveryTicketLineItem>.class);
                RetailerId =rdt.retailer;
                system.debug('##rdt.retailerContact ::'+rdt.retailerContact);
                if(rdt.stateLicense != '' || rdt.retailerContact != '' ){
                    Boolean isStateLicenses =False;
                    For(State_Licenses__c sl : [SELECT Id,License_Expiration_Date__c,License_Status__c  FROM State_Licenses__c WHERE License_Name__c =:RetailerId ]){
                        if(sl.License_Status__c != 'Active' && sl.id == (rdt.stateLicense !='' ? rdt.stateLicense : null)){
                            rdt.stateLicense='';
                            rdt.stateLicenseName='';
                            rdt.stateLicenseNumber='';
                            rdt.stateLicenseAddress='';
                        }else{
                            isStateLicenses=true;
                        }
                    }
                    if(!isStateLicenses){
                        rdt.retailer='';
                        RetailerId='';
                        rdt.retailerContact='';
                        rdt.retailerContactName='';
                        rdt.retailerDBA='';
                        rdt.retailerName='';
                    }else{
                        string [] conIds = rdt.retailerContact.split(', ');
                        rdt.retailerContact='';
                        rdt.retailerContactName='';
                        for(Contact c :[SELECT id ,name,Active__c FROM Contact WHERE id IN : conIds ]){
                            if(c.Active__c){
                                rdt.retailerContact += c.Id+' ,';
                                rdt.retailerContactName += c.Name+' ,';
                            }
                        }
                        rdt.retailerContact = rdt.retailerContact != null ? rdt.retailerContact.removeEnd(' ,') : '';
                        rdt.retailerContactName = rdt.retailerContactName != null ? rdt.retailerContactName.removeEnd(' ,') : '';
                    }
                    
                }
                decimal Minimum_Order_Value = 0;
                for(Line_Card__c lc: [SELECT Minimum_Order_Value__c,Retailer_Name__c,Brand_Name__c, Retailer_Name__r.Name, Retailer_DBA__c  FROM Line_Card__c WHERE Retailer_Name__r.Hide_From_Marketplace__c = false AND Brand_Name__c = :brandIds AND Retailer_Name__c = :RetailerId  ORDER BY Retailer_DBA__c]){
                   Minimum_Order_Value = lc.Minimum_Order_Value__c != null ? lc.Minimum_Order_Value__c : 0;
                }
                r.data.put('Minimum_Order_Value',Minimum_Order_Value);
                
            }
            
            List<Account> acc = [SELECT id,Third_Party_Scheduler__c FROM Account WHERE id =: RetailerId ];
                if(acc.size() > 0)
        			r.data.put('isThird_Party_Scheduler',acc[0].Third_Party_Scheduler__c);
            
            BrandContact[] contacts = new BrandContact[]{};
                for(Contact p: [SELECT Name FROM Contact WHERE AccountId = :RetailerId AND Active__c = true AND Email != null Order By Name]){
                    contacts.add(new BrandContact(p));
                }
            r.data.put('contacts', contacts);
            List<Map<String, String>> slicenses = new List<Map<String, String>>();
            List<Map<String, String>> saddress = new List<Map<String, String>>();
            List<Map<String, String>> wareAddress = new List<Map<String, String>>();
            map<String,State_Licenses__c> statelicenses = new map<String,State_Licenses__c>();
            for(State_Licenses__c sl:[SELECT Id,License_Number__c, License_Address__c, License_City__c, License_State__c,License_Type__c, License_Country__c, License_Zip__c,Default_Warehouse__c,Default_Warehouse__r.License_ID__r.License_Address__c, Default_Warehouse__r.License_ID__r.License_City__c, Default_Warehouse__r.License_ID__r.License_State__c,Default_Warehouse__r.License_ID__r.License_Country__c,Default_Warehouse__r.License_ID__r.License_Zip__c FROM State_Licenses__c WHERE License_Name__c =:RetailerId AND License_Status__c =: STATE_LICENSE_ACTIVE]){
                List<String> address = new List<String>();
                List<String> wAddress = new List<String>();
                
                address.add(sl.License_Address__c);
                if(String.isNotBlank(sl.License_City__c)){
                    address.add(sl.License_City__c);
                }
                if(String.isNotBlank(sl.License_State__c)){
                    address.add(sl.License_State__c);
                }
                if(String.isNotBlank(sl.License_Country__c)){
                    address.add(sl.License_Country__c);
                }
                if(String.isNotBlank(sl.License_Zip__c)){
                    address.add(sl.License_Zip__c);
                }
                
                wAddress.add(sl.Default_Warehouse__r.License_ID__r.License_Address__c);
                if(String.isNotBlank(sl.Default_Warehouse__r.License_ID__r.License_City__c)){
                    wAddress.add(sl.Default_Warehouse__r.License_ID__r.License_City__c);
                }
                if(String.isNotBlank(sl.Default_Warehouse__r.License_ID__r.License_State__c)){
                    wAddress.add(sl.Default_Warehouse__r.License_ID__r.License_State__c);
                }
                if(String.isNotBlank(sl.Default_Warehouse__r.License_ID__r.License_Country__c)){
                    wAddress.add(sl.Default_Warehouse__r.License_ID__r.License_Country__c);
                }
                if(String.isNotBlank(sl.Default_Warehouse__r.License_ID__r.License_Zip__c)){
                    wAddress.add(sl.Default_Warehouse__r.License_ID__r.License_Zip__c);
                }
                
                saddress.add(new Map<String, String>{'id'=> sl.Id, 'address'=> String.join(address, ', ')});
                wareAddress.add(new Map<String, String>{'id'=> sl.Id, 'address'=> String.join(wAddress, ', ')});
                slicenses.add(new Map<String, String>{'id'=> sl.Id, 'address'=> sl.License_Number__c+' | '+String.join(address, ', ')});
                statelicenses.put(sl.Id,sl);
            }
            r.data.put('licenses',slicenses);
            r.data.put('addresses',saddress);
            r.data.put('wAddresses',wareAddress);
            r.data.put('statelicenses',statelicenses);
            /*for(Retail_Delivery_Ticket__c tmpRDT: [SELECT Name, Payment_Terms__c, Request_Ship_Date__c, Retailer__c, Retailer_Contact__c, Retailer_PO__c, Special_Delivery_Instructions__c, State_License__c, Total_Line_Items__c FROM Retail_Delivery_Ticket__c WHERE Id = :recordId]){
rdt = new RetailDeliveryTicket(tmpRDT);
}*/
            
            
        }
        if(fromTransferOrders)
        	rdt.excludeExciseTax = true; 
        r.data.put('brandRetailDeliveryOrderItems', new Map<String, Integer>());
        if(retailDeliveryTicketLineItems.isEmpty()){
            //if(!contacts.isEmpty()){
            //rdt.retailerContact = contacts[0].id;
            //}
            //retailDeliveryTicketLineItems.add(new RetailDeliveryTicketLineItem());
            if(Cache.Session.contains(ProductsCtlr.cacheKey)){
                r.data.put('brandRetailDeliveryOrderItems', (Map<String, Object>)Cache.Session.get(ProductsCtlr.cacheKey));
                //Cache.Session.remove(ProductsCtlr.cacheKey);
            }
        }
        
        Map<String, Community_Settings__c > Community_Settings= Community_Settings__c.getAll();
        if(Community_Settings.containsKey(COMMUNITY_SETTINGS_DEFAULT)){
            r.data.put('cutOffTime', Community_Settings.get(COMMUNITY_SETTINGS_DEFAULT).Order_Cutoff_time__c);
        }

        for(RetailDeliveryTicketLineItem rdtLine : retailDeliveryTicketLineItems){
            if(rdtLine.isSample && rdtLine.parentProduct != null){
                if(pbeProductMap.containsKey(rdtLine.parentProduct)){
                    rdtLine.priceBookid = pbeProductMap.get(rdtLine.parentProduct);
                }
            } else {
                if(pbeProductMap.containsKey(rdtLine.Product)){
                    rdtLine.priceBookid = pbeProductMap.get(rdtLine.Product);
                }
            }
        }
        
        r.data.put('isBrand', ProductsCtlr.isBrand);
        r.data.put('retailDeliveryTicket', rdt);
        r.data.put('retailDeliveryTicketLineItems', retailDeliveryTicketLineItems);
        r.data.put('tmpRetailDeliveryTicketLineItem', new RetailDeliveryTicketLineItem());
        r.data.put('relatedContacts', relatedContacts);
        
        List<string>holidayList = new List<string>();
        for(Holiday  businessHolidDay : [SELECT IsRecurrence,ActivityDate,RecurrenceMonthOfYear,RecurrenceEndDateOnly,RecurrenceInstance,RecurrenceDayOfWeekMask,RecurrenceInterval,RecurrenceType FROM Holiday]){
            if(businessHolidDay.IsRecurrence){
            	holidayList.addAll(getAllRecurrenceHoliday(businessHolidDay));
            }else{
            	holidayList.add(getDateStr(businessHolidDay.ActivityDate));   
            }    
        }
        r.data.put('holidayList', holidayList);
        
        string learnMoreUrl = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Learn_More_URL');
        string shippingToolTip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Shipping_Tool_Tip');
        string distributionToolTip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Distribution_Tool_Tip');
        string factoringDiscountToolTip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Factoring_Discount_Tool_Tip');
        string bulkProductErrorToolTip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Bulk_Product_Error_Tool_Tip');
        string Total_product_amount_tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Total_product_amount_tooltip');
        string Warning_Message_Of_Minimum_Order_Value = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Warning_Message_Of_Minimum_Order_Value');
		string Err_Msg_all_line_items_as_isSample = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Err_Msg_all_line_items_as_isSample');
        string Err_Msg_of_OLI_is_Promo = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Line Item','Err_Msg_of_OLI_is_Promo');
        string Err_Msg_of_Ship_To_and_Origin_Site = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Err_Msg_of_Ship_To_and_Origin_Site');
        string Msg_for_isPromo_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Msg_for_isPromo_Tooltip');
        string Msg_for_isSample_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Msg_for_isSample_Tooltip');
        string Msg_Exclude_Excise_Tax_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Msg_Exclude_Excise_Tax_Tooltip');
        string Msg_for_Preapproved_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Msg_for_Preapproved_Tooltip');
        string Sample_Products_tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Sample_Products_tooltip');
        
        r.data.put('Sample_Products_tooltip', Sample_Products_tooltip != null ? Sample_Products_tooltip : '');        
        r.data.put('Msg_for_Preapproved_Tooltip', Msg_for_Preapproved_Tooltip != null ? Msg_for_Preapproved_Tooltip : '');        
        r.data.put('Msg_Exclude_Excise_Tax_Tooltip', Msg_Exclude_Excise_Tax_Tooltip != null ? Msg_Exclude_Excise_Tax_Tooltip : '');        
        r.data.put('Msg_for_isSample_Tooltip', Msg_for_isSample_Tooltip != null ? Msg_for_isSample_Tooltip : '');        
        r.data.put('Msg_for_isPromo_Tooltip', Msg_for_isPromo_Tooltip != null ? Msg_for_isPromo_Tooltip : '');        
        r.data.put('Err_Msg_of_Ship_To_and_Origin_Site', Err_Msg_of_Ship_To_and_Origin_Site != null ? Err_Msg_of_Ship_To_and_Origin_Site : '');        
        r.data.put('Err_Msg_of_OLI_is_Promo', Err_Msg_of_OLI_is_Promo != null ? Err_Msg_of_OLI_is_Promo : '');        
        r.data.put('Err_Msg_all_line_items_as_isSample', Err_Msg_all_line_items_as_isSample != null ? Err_Msg_all_line_items_as_isSample : '');        
        r.data.put('Total_product_amount_tooltip', Total_product_amount_tooltip != null ? Total_product_amount_tooltip : '');
        r.data.put('bulkProductErrorToolTip', bulkProductErrorToolTip != null ? bulkProductErrorToolTip : '');
        r.data.put('learnMoreUrl', learnMoreUrl != null ? learnMoreUrl : '');
        r.data.put('shippingToolTip', shippingToolTip != null ? shippingToolTip : '');
        r.data.put('distributionToolTip', distributionToolTip != null ? distributionToolTip : '');
        r.data.put('factoringDiscountToolTip', factoringDiscountToolTip != null ? factoringDiscountToolTip : '');
        r.data.put('Warning_Message_Of_Minimum_Order_Value', Warning_Message_Of_Minimum_Order_Value != null ? Warning_Message_Of_Minimum_Order_Value : '');
        
        
            r.data.put('Orders_Requiring_Third_Party_Scheduler', Orders_Requiring_Third_Party_Scheduler);
        //r.data.put('Orders_Requiring_TPS_and_or_QR_Code', Orders_Requiring_TPS_and_or_QR_Code);
        //r.data.put('Orders_Requiring_TPS_and_or_Bar_Code', Orders_Requiring_TPS_and_or_Bar_Code);
        //r.data.put('Orders_Requiring_TPS_and_Bar_Code_and_QR', Orders_Requiring_TPS_and_Bar_Code_and_QR);
        r.data.put('Orders_Requiring_QR_Codes', Orders_Requiring_QR_Codes);
        r.data.put('Orders_Requiring_Bar_Codes', Orders_Requiring_Bar_Codes);
        r.data.put('Orders_Requiring_BarCodes_and_or_QR_Code', Orders_Requiring_BarCodes_and_or_QR_Code);
        
        r.data.put('Factoring_Contact_Required_For_Order', Factoring_Contact_Required_For_Order);
        r.data.put('Factoring_Terms_Required_For_Order', Factoring_Terms_Required_For_Order);
        
        r.data.put('SampleOrderFamilyMap',SampleOrderFamilyMap);
        r.data.put('Sample_Limitation_Error_Msg',Sample_Limitation_Error_Msg);
        r.data.put('SampleOrderParentFamilyMap',SampleOrderParentFamilyMap);
        return r;
    }
    @AuraEnabled
    public static AuraResponse getProductsByRetailerId(String recordId ,boolean fromTransferOrders){
        AuraResponse r = new AuraResponse('RetailDeliveryTicketsCtlr.getProductsByRetailerId()');
        List<String> brandIds = new List<String>();
		brandIds.add(brandId);
        List<String> priceBookIds = new List<String>();
        //if(isDisty){
            brandIds.addAll(distyBrandNames);
            if(recordId == '')
         		priceBookIds.addAll(distyPriceBooks);
        //}
        if(recordId == '')
        	priceBookIds.add(priceBookId);
        decimal Minimum_Order_Value = 0;
        for(Line_Card__c lc: [SELECT Minimum_Order_Value__c,Retailer_Name__c,Community_Price_Book__c,Mutual_Payment_Terms__c,Sales_Person__c,Sales_Person__r.Name,Brand_Name__c, Retailer_Name__r.Name, Retailer_DBA__c  FROM Line_Card__c WHERE Brand_Name__c = :brandIds AND (Retailer_Name__c = :brandId OR Retailer_Name__r.Hide_From_Marketplace__c = false) AND Retailer_Name__c = :recordId ORDER BY Retailer_DBA__c]){
            priceBookIds.add(lc.Community_Price_Book__c);
            Minimum_Order_Value = lc.Minimum_Order_Value__c != null ? lc.Minimum_Order_Value__c : 0;
        }
        Map<String, Product> records = new Map<String, Product>();
        Map<String, Decimal> productOrderedQtyMap = new Map<String, Decimal>();
        Map<String, String> pbeProductMap = new Map<String, String>();
        Map<String, String> pbeProductAllMap = new Map<String, String>();
        Map<String, Product[]> procuderProducts = new Map<String, Product[]>();
        List<PricebookEntry> lstPBE = new List<PricebookEntry>();
        List<PricebookEntry> lstPBEBulk = new List<PricebookEntry>();
        
        List<String> productFamilies = new List<String>();     
        Set<String> bulkFamilies = new Set<String>();     
        for(Product_Categories__c pc : [SELECT Id, Category__c ,Name,Icon_Name__c ,Product_Families__c FROM Product_Categories__c WHERE Icon_Name__c != null Order By Sort_Order__c]){
            if(pc.Product_Families__c != null && pc.Product_Families__c != ''){
                productFamilies.addAll(pc.Product_Families__c.split(';'));
                if(pc.Name == 'Bulk' ){
                	bulkFamilies.addAll(pc.Product_Families__c.split(';'));
            	}
            }
        }
        if(fromTransferOrders){
            lstPBE = [SELECT Id, Product2.Name,Product2.Product_Short_Description__c,Product2.White_Labelled__c,Product2.Producer_Name__r.DBA__c,Product2.Producer_Name__r.Name,Product2.Licensee_Name__c,Product2.Licensee_Name__r.Name,Product2.Licensee_Name__r.DBA__c, Product2Id, Product2.Image_URL__c,Product2.Brand_Name__c,Product2.RecordType.Name,Product2.Parent_Product__c,Product2.Is_Sample__c,Product2.Family,Product2.Producer_Name__c ,Product2.Description, UnitPrice,Product2.Available_Inventory__c,Product2.Available_Qty__c,Product2.MOQ__c,Product2.Total_Order_Qty__c,Product2.Unit_Shipping_Weight_lbs__c, Product2.Case_Shipping_Weight_lbs__c,Product2.Apply_Excise_Tax__c,Product2.Max_Order_Allowed__c FROM PricebookEntry WHERE  (Product2.Hide_From_Marketplace__c = false  OR Product2.Family LIKE 'Bulk%') AND ((Product2.Producer_Name__c IN :brandIds AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c IN :brandIds AND Product2.White_Labelled__c = true) ) AND PriceBook2Id IN :priceBookIds AND Product2.RecordType.Name = :recordTypeName AND Product2.IsActive = true Order By Product2.Name];
        } else {
            productFamilies.add(Product_Family_Marketing_Materials);
            productFamilies.add(PRODUCT_RECORD_TYPE_NAME_DISCOUNT);
            lstPBE = [SELECT Id, Product2.Name,Product2.Product_Short_Description__c,Product2.White_Labelled__c,Product2.Producer_Name__r.DBA__c,Product2.Producer_Name__r.Name,Product2.Licensee_Name__c,Product2.Licensee_Name__r.DBA__c,Product2.Licensee_Name__r.Name, Product2Id, Product2.Image_URL__c,Product2.Brand_Name__c,Product2.RecordType.Name,Product2.Parent_Product__c,Product2.Is_Sample__c,Product2.Family,Product2.Producer_Name__c ,Product2.Description, UnitPrice,Product2.Available_Inventory__c,Product2.Available_Qty__c,Product2.MOQ__c,Product2.Total_Order_Qty__c,Product2.Unit_Shipping_Weight_lbs__c, Product2.Case_Shipping_Weight_lbs__c,Product2.Apply_Excise_Tax__c,Product2.Max_Order_Allowed__c FROM PricebookEntry WHERE UnitPrice !=:0 AND  (Product2.Hide_From_Marketplace__c = false  OR Product2.Family LIKE 'Bulk%') AND ((Product2.Producer_Name__c IN :brandIds AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c IN :brandIds AND Product2.White_Labelled__c = true) ) AND PriceBook2Id IN :priceBookIds AND( Product2.RecordType.Name = :recordTypeName OR Product2.RecordType.Name =:PRODUCT_RECORD_TYPE_NAME_DISCOUNT) AND Product2.IsActive = true AND (Product2.Family IN : productFamilies OR Product2.Family LIKE 'Bulk%') Order By Product2.Name];
        }
        for(PricebookEntry pbe: lstPBE){
            Product p = new Product(pbe);
            
            if(pbe.Product2.Family.startsWith('Bulk')){
                p.isBulkProduct = true;
            }else{
                p.isBulkProduct = false;
            }
            p.brandName = pbe.Product2.Brand_Name__c;
            p.brandId = brandId;
            pbeProductMap.put(pbe.Product2Id,pbe.Id);
            decimal availableQty = p.availableQty / p.MOQ;
            if(availableQty > 0 || p.isDiscountProduct == true)
            	records.put(pbe.Product2Id, p);
            productOrderedQtyMap.put(pbe.Product2Id,pbe.Product2.Total_Order_Qty__c);
            if(procuderProducts.containsKey(pbe.Product2.Producer_Name__c)){
                procuderProducts.get(pbe.Product2.Producer_Name__c).add(p);
            }else{
                procuderProducts.put(pbe.Product2.Producer_Name__c,new Product[]{p});
            }
        }
		
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Brand__c IN: procuderProducts.keySet() AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now()]){
            Product[] products = procuderProducts.get(bd.Brand__c);
            if(products != null){
                for(Product p: products){
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
            }
        }
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Product_Name__c IN: records.keySet() AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now()]){
            Product p = records.get(bd.Product_Name__c);
            if(p != null){
                if(p.discountPercent != null){
                    p.setProductDiscountPercent(bd.Discount_Percentage__c);
                }else{
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
                
            }
        }
        List<Account> acc = [SELECT id,Third_Party_Scheduler__c FROM Account WHERE id =: recordId ];
        r.data.put('isThird_Party_Scheduler',acc[0].Third_Party_Scheduler__c);
        r.data.put('Minimum_Order_Value',Minimum_Order_Value);
        r.data.put('products', records.values());
        r.data.put('productOrderedQtyMap',productOrderedQtyMap);
        r.data.put('warehouseAvailableInventoryMap',getWarehouseAvailableInventory(records.keySet()));
        r.data.put('warehouseTotalOrderedMap',getWarehouseOrderedMap(records.keySet()));
        return r;
    }
    private static list<String> getAllRecurrenceHoliday(Holiday businessHolidDay){
    	List<string>holidayList = new List<string>();
        date todayDt = businessHolidDay.ActivityDate;
        date holidayEndDt = businessHolidDay.RecurrenceEndDateOnly != null ? businessHolidDay.RecurrenceEndDateOnly : system.today();
        System.debug('todayDt = '+todayDt);
        System.debug('holidayEndDt = '+holidayEndDt);
        while(todayDt <= holidayEndDt){
            System.debug('businessHolidDay.RecurrenceType = '+businessHolidDay.RecurrenceType);
        	if(businessHolidDay.RecurrenceType == RECURSYEARLY){
                todayDt = todayDt.addYears(1);
            }else if(businessHolidDay.RecurrenceType == RECURSYEARLYNTH){
                todayDt = todayDt.addYears(1);
                todayDt = getHolidayDate(todayDt,businessHolidDay);        
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSMONTHLY){
            	todayDt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);
                todayDt = getHolidayDate(todayDt,businessHolidDay);        
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSMONTHLYNTH){
            	date dt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);      
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSWEEKLY){
            	todayDt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);        
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSDAILY){
                todayDt = todayDt.addDays(businessHolidDay.RecurrenceInterval);
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSEVERYWEEKDAY){
            	todayDt = todayDt.addDays(1);
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
        if(monthName == JANUARY_MONTH){
            return 1;
        }else if(monthName == FEBRUARY_MONTH){
            return 2;
        }else if(monthName == MARCH_MONTH){
            return 3;
        }else if(monthName == APRIL_MONTH){
            return 4;
        }else if(monthName == MAY_MONTH){
            return 5;
        }else if(monthName == JUNE_MONTH){
            return 6;
        }else if(monthName == JULY_MONTH){
            return 7;
        }else if(monthName == AUGUST_MONTH){
            return 8;
        }else if(monthName == SEPTEMBER_MONTH){
            return 9;
        }else if(monthName == OCTOBER_MONTH){
            return 10;
        }else if(monthName == NOVEMBER_MONTH){
            return 11;
        }else if(monthName == DECEMBER_MONTH){
            return 12;
        }return 1;
    }
    Public  static Date getHolidayDate(Date todayDt,Holiday businessHolidDay){
        if(businessHolidDay.RecurrenceDayOfWeekMask == 127){
            integer year = todayDt.year();
            integer month = getMonthNumber(businessHolidDay.RecurrenceMonthOfYear);
            integer day = 0;
            if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_FIRST){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_SECOND){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_THIRD){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_FOURTH){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_LAST){
                day = Date.daysInMonth(year, month);  
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
            
            if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_SECOND){
                weekDay = weekDay.addDays(7);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_THIRD){
                weekDay = weekDay.addDays(14);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_FOURTH){
                weekDay = weekDay.addDays(21);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_LAST){
                weekDay = weekDay.addDays(28);        
            }
            
            if((todayDt.month() < 12 && weekDay.month() > todayDt.month()) || (todayDt.month() == 12 && weekDay.month() == 1))
                weekDay = weekDay.addDays(-7);
            return weekDay;
        }
    }
    public static Map<String,Decimal> getWarehouseOrderedMap(Set<String> productIds){
        Map<String,Decimal> siteProductTotalOrderQtyMap = new Map<String,Decimal>();
        Map<Id,Site__c> sites = new Map<Id,Site__c>([SELECT Id, Name, Warehouse_Name__c,Sort_Order__c  FROM Site__c WHERE Active__c = true ORDER BY Sort_Order__c]);
        Sales_Order_Line__c[] SOLines =  [SELECT Id,Name, Sales_Order__c,Qty_Allocated__c ,Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.Site__c, Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c,Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c ,Product_Name__c,Product_Name__r.Name  FROM Sales_Order_Line__c WHERE Status__c =: SOLI_STATUS_ALLOCATED AND Product_Name__c IN : productIds AND Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c != null];
        Map<Id,Sales_Order_Line__c>SOLineMap = new Map<Id,Sales_Order_Line__c>(SOLines);
        Map<String,List<Id>> productAllocatedSOLMap = new Map<String,List<Id>>();
        for(Sales_Order_Line__c SOL: SOLines){
            System.debug('###SOL Name::'+SOL.Name +'==>Product Name:'+SOL.Product_Name__r.Name +'=>Qty_Allocated__c:'+SOL.Qty_Allocated__c);
            String key = (SOL.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.Site__c != null ? SOL.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.Site__c : SOL.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c) +'-'+SOL.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c + '-'+SOL.Product_Name__c;//SOL.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c-SOL.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c + '-'+SOL.Product_Name__c;
            System.debug('###Key::'+key);
            if(productAllocatedSOLMap.containsKey(key)){
                productAllocatedSOLMap.get(key).add(SOL.Id);
            }else{
                productAllocatedSOLMap.put(key, new List<Id>{SOL.Id});
            }
        }
        System.debug('#productAllocatedSOLMap::'+productAllocatedSOLMap);
        
        Set<String> orderStatusPendingApproved = new Set<String>{STATUS_PENDING,STATUS_APPROVED};
        Set<String> orderStatusDraftApproved = new Set<String>{STATUS_APPROVED,STATUS_PENDING};
        
        Order_Line_Item__c[] items = [SELECT Id, Order__r.RecordType.Name,Order__c,Order__r.Site__c,Order__r.State_License__r.Default_Warehouse__c,Quantity_Cases__c,Is_Sample__c,Line_Total_Qty__c,Product__c FROM Order_Line_Item__c WHERE Product__c IN :productIds AND (OrderLine_Status__c =: '' OR OrderLine_Status__c =: null) AND  ((Order__r.RecordType.Name =: ORDER_RECORD_TYPE_NAME_RETAILER AND Order__r.Status__c IN : orderStatusPendingApproved) OR (Order__r.RecordType.Name IN (:ORDER_RECORD_TYPE_NAME_BRAND,:ORDER_RECORD_TYPE_NAME_TRANSFER) AND Order__r.Status__c IN : orderStatusPendingApproved)) Order By Order__r.State_License__r.Default_Warehouse__r.Sort_Order__c];
        Map<String,Decimal> productTotalQtyMap = new Map<String,Decimal>();
        Map<String,Decimal> productTotalQtyAllocatedMap = new Map<String,Decimal>();
        Set<String> processAllocatedKeys = new Set<String>();
        for(Order_Line_Item__c oli: items){
            Decimal totalQty = 0;
            String key = (oli.Order__r.Site__c != null ? oli.Order__r.Site__c : oli.Order__r.State_License__r.Default_Warehouse__c )+ '-'+oli.Order__c+ '-'+ oli.Product__c;//oli.Order__c + '-'+ oli.Product__c;
            String keySP = (oli.Order__r.Site__c != null ? oli.Order__r.Site__c: oli.Order__r.State_License__r.Default_Warehouse__c )+'-'+ oli.Product__c;
            Id [] tempSOLIds = productAllocatedSOLMap.get(key);
            if(productTotalQtyMap.containsKey(keySP)){
                totalQty = productTotalQtyMap.get(keySP);
            }
            totalQty += oli.Line_Total_Qty__c;
            Decimal Qty_Allocated = 0;
            if(productTotalQtyAllocatedMap.containsKey(keySP)){
                Qty_Allocated = productTotalQtyAllocatedMap.get(keySP) != null ? productTotalQtyAllocatedMap.get(keySP) : 0;
            }
            
            if(tempSOLIds != null && tempSOLIds.size() > 0 && processAllocatedKeys.contains(key) == false){
                for(Id SOLId: tempSOLIds){
                    Sales_Order_Line__c SOL = SOLineMap.get(SOLId);
                    if(SOL != null){
                        Qty_Allocated += SOL.Qty_Allocated__c != null ? SOL.Qty_Allocated__c : 0; 
                    }
                }
            }
            System.debug('##Qty_Allocated::'+Qty_Allocated);
            productTotalQtyAllocatedMap.put(keySP,Qty_Allocated);
            productTotalQtyMap.put(keySP,totalQty);
            processAllocatedKeys.add(key);
        }
        if(productTotalQtyMap.size() > 0){
            for(Id siteId: sites.keySet()){
                System.debug('Site Name'+sites.get(siteId).Name);
                for(String productId:productIds){
                    String key =siteId+'-'+productId;
                    Decimal totalOrderedQty = 0;
                    Decimal totalAllocatedQty = 0;
                    if(productTotalQtyMap.containsKey(key)){
                        totalOrderedQty = productTotalQtyMap.get(key);
                    }
                    if(productTotalQtyAllocatedMap.containsKey(key)){
                        totalAllocatedQty = productTotalQtyAllocatedMap.get(key);
                    }
                    System.debug('#totalOrderedQty::'+totalOrderedQty);
                    System.debug('#totalAllocatedQty::'+totalAllocatedQty);
                    system.debug('key :'+key);
					system.debug('totalOrderedQty-totalAllocatedQty : '+(totalOrderedQty-totalAllocatedQty));
                    siteProductTotalOrderQtyMap.put(key,(totalOrderedQty-totalAllocatedQty));
                }
                
            }
        }
        system.debug('siteProductTotalOrderQtyMap :'+siteProductTotalOrderQtyMap);
        return siteProductTotalOrderQtyMap;
    }
    public static Map<Id,WarehouseAvailableInventory[]> getWarehouseAvailableInventory(Set<String>productIds){
        Map<Id,Site__c> sites = new Map<Id,Site__c>([SELECT Id, Name, Warehouse_Name__c,Sort_Order__c  FROM Site__c WHERE Active__c = true Order BY Sort_Order__c]);
        Map<Id,WarehouseAvailableInventory[]> warehouseAvailableInventoryProductMap = new Map<Id,WarehouseAvailableInventory[]>();
        
        Product2[] prodList =[Select ID,Name,
                              (Select id,Name,Site__c,Site__r.Name,Product_Name__c,Qty_On_Hand__c  
                            	FROM Inventory_Positions__r 
                               WHERE Qty_On_Hand__c != NULL 
                               AND Hold__c = false 
                               AND Inventory_Location__r.Include_in_Inventory__c = true
                              AND Inventory_Location__r.Name != :RECEIVING_INSPECTION Order By Site__r.Sort_Order__c)
                   FROM Product2 WHERE ID=:productIds];
        for(Product2 p: prodList){
            Map<String,Decimal> warehouseAvailableInventoryMap = new Map<String,Decimal>();
            if(!p.Inventory_Positions__r.isEmpty()){
                for(Inventory_Position__c IP: p.Inventory_Positions__r){
                    System.debug('###IP:'+IP);
                    Decimal availableInventory = 0;
                    if(warehouseAvailableInventoryMap.containsKey(IP.Site__c)){
                        availableInventory = warehouseAvailableInventoryMap.get(IP.Site__c);
                    }
                    availableInventory += IP.Qty_On_Hand__c;
                    warehouseAvailableInventoryMap.put(IP.Site__c,availableInventory);
                }
            }
            System.debug('###warehouseAvailableInventoryMap::'+warehouseAvailableInventoryMap);
            WarehouseAvailableInventory[] wAIs = new WarehouseAvailableInventory[]{};
            for(String key: warehouseAvailableInventoryMap.keySet()){
                WarehouseAvailableInventory wAI = new WarehouseAvailableInventory();
                wAI.id = key;
                if(sites.containsKey(key)){	
                    wAI.sortOrder = sites.get(key).Sort_Order__c != null?sites.get(key).Sort_Order__c:99;//sites.get(key).Name;	
                    wAI.name = sites.get(key).Warehouse_Name__c != null?sites.get(key).Warehouse_Name__c:sites.get(key).Name;//sites.get(key).Name;	
                }
                wAI.name = sites.get(key).Warehouse_Name__c != null?sites.get(key).Warehouse_Name__c:sites.get(key).Name;//sites.get(key).Name;
                wAI.availableInventory = warehouseAvailableInventoryMap.get(key) != null?warehouseAvailableInventoryMap.get(key):0;
                wAIs.add(wAI); 
            }
            for(Site__c s: sites.values()){
                if(!warehouseAvailableInventoryMap.containsKey(s.Id)){
                    WarehouseAvailableInventory wAI = new WarehouseAvailableInventory();
                    wAI.id = s.Id;
                    wAI.sortOrder = s.Sort_Order__c;
                    wAI.name = s.Warehouse_Name__c != null?s.Warehouse_Name__c:s.Name;
                    wAI.availableInventory = 0;
                    wAIs.add(wAI);
                }
                
            }         
            wAIs.sort();
            System.debug('###wAIs::'+p.Name+'--->'+wAIs);
            warehouseAvailableInventoryProductMap.put(p.Id,wAIs);
        }
        return warehouseAvailableInventoryProductMap;
    }
    
    @AuraEnabled
    public static AuraResponse calculateOrderProcessingFee(String satateLicenseId,String siteId,String itemsJSON,String orderJSON, String productJSON, Boolean fromTransfer){
		return calculateOrderFee(satateLicenseId,siteId, itemsJSON, orderJSON, productJSON,fromTransfer);	    
    }
    
    private static AuraResponse calculateOrderFee(String satateLicenseId,String siteId,String itemsJSON,String orderJSON, String productJSON, Boolean fromTransfer){
        system.debug('satateLicenseId'+satateLicenseId);
        system.debug('siteId'+siteId);
        system.debug('itemsJSON '+itemsJSON);
        system.debug('orderJSON '+orderJSON);
        system.debug('productJSON '+productJSON);
        AuraResponse r = new AuraResponse('RetailDeliveryTicketsCtlr.calculateOrderProcessingFee()');
        List<RetailDeliveryTicketLineItem> rdtlis = (List<RetailDeliveryTicketLineItem>)JSON.deserialize(itemsJSON, List<RetailDeliveryTicketLineItem>.class);
        System.debug('##rdtlis ::'+rdtlis);
        List<Product> products  = new List<Product>();
        if(productJSON != null)
        	products = (List<Product>)JSON.deserialize(productJSON, List<Product>.class);
        
        system.debug('orderJSON '+orderJSON);
        RetailDeliveryTicket  rdt = (RetailDeliveryTicket)JSON.deserialize(orderJSON, RetailDeliveryTicket.class);
        Boolean hasMOQ1Item = false;
        Map<String,Product> productsMap = new Map<String,Product>();
        system.debug('products.size()'+products.size());
        for(Product p: products){
            productsMap.put(p.id,p);
            System.debug('##Product:'+p.name+'==>'+p.id);
        }
        
        Map<Id,Account> accMap = new Map<Id,Account>();
        List<Account> accOfTransportLicense = new List<Account>();
        if(rdt.retailer != null && rdt.retailer != ''){
            for(Account acc : [SELECT Id,Platform_Level__c,DBA__c FROM Account WHERE Id IN (:rdt.retailer,:brandId)]){
                accMap.put(acc.id,acc);
            }
        
        }  
        if(rdt.transportLicenseId != null && rdt.transportLicenseId != ''){
        	State_Licenses__c sl =[SELECT id ,License_Name__c FROM State_Licenses__c WHERE id =:rdt.transportLicenseId];
            accOfTransportLicense = [SELECT Id,Platform_Level__c,DBA__c FROM Account WHERE Id =:sl.License_Name__c];
        }
        
        Set<Id> selectedProductIds = new Set<Id>(); 
        for(RetailDeliveryTicketLineItem rdtli: rdtlis){
            if(String.isNotBlank(rdtli.Product)){
                selectedProductIds.add(rdtli.Product);
            }
            
        }
        State_Licenses__c stateLicense= [SELECT Id, Default_Warehouse__c,Total_Miles__c FROM State_Licenses__c where Id =: satateLicenseId];
        if(String.isBlank(siteId)){
            siteId = stateLicense.Default_Warehouse__c;
        }
        Decimal totalMiles = getTotalMiles(siteId,satateLicenseId);
        system.debug('stateLicense.Default_Warehouse__c '+stateLicense.Default_Warehouse__c);
        system.debug('membershipLevel  '+membershipLevel );
        Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c,Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c,Membership_Level__c
                                                 FROM Fulfillment_Rates_Table__c 
                                                 WHERE Site__c = :siteId
                                                 AND Active__c = true
                                                 AND Rate_Effective_From__c <= :System.today()
                                                 AND Rate_Effective_To__c >= :System.today()
                                                 AND Membership_Level__c = :membershipLevel
                                                ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
        Shipping_Rates_Table__c [] mileageSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                              	Weight_Bracket__c, Weight_Bracket_Price__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                 FROM Shipping_Rates_Table__c 
                                                 WHERE Site__c = :siteId
                                                 AND Active__c = true
                                                 AND Rate_Effective_From__c <= :System.today()
                                                 AND Rate_Effective_To__c >= :System.today()
                                                 AND Membership_Level__c = :membershipLevel
                                             Order By Mileage_Bracket__c];
        Shipping_Rates_Table__c [] weightSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                              	Weight_Bracket__c, Weight_Bracket_Price__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                 FROM Shipping_Rates_Table__c 
                                                 WHERE Site__c = :siteId
                                                 AND Active__c = true
                                                 AND Rate_Effective_From__c <= :System.today()
                                                 AND Rate_Effective_To__c >= :System.today()
                                                 AND Membership_Level__c = :membershipLevel
                                             Order By Weight_Bracket__c];
        system.debug('FRTList '+FRTList);
        system.debug('mileageSRTList '+mileageSRTList);
        system.debug('weightSRTList '+weightSRTList);
        Map<String,Fulfillment_Rates_Table__c []> serviceBasedFRTMap = new Map<String,Fulfillment_Rates_Table__c []>();
        if(!FRTList.isEmpty()){
            for(Fulfillment_Rates_Table__c FRT:FRTList){
                if(serviceBasedFRTMap.containsKey(FRT.Fulfillment_Services__c)){
                    serviceBasedFRTMap.get(FRT.Fulfillment_Services__c).add(FRT);
                }else{
                    serviceBasedFRTMap.put(FRT.Fulfillment_Services__c,new Fulfillment_Rates_Table__c[]{FRT});
                }
            }
        }
        Decimal orderBookingFee = 0;
        Decimal serviceBookingFee = 0;
        Decimal serviceSchedulingFee = 0;
        Decimal serviceStagingFee = 0;
        Decimal packOutFee = 0;
        Decimal stageManifestFee = 0;
        Decimal scheduleDispatchFee = 0; 
        Decimal totalMileageFee = 0;
        Decimal totalWeightFee = 0;
        Decimal totalOrderWeight = 0;
        
        Decimal totalPickPack = 0;
        Decimal totalQAReview = 0;
        Decimal totalWeightLbs = 0;
        Boolean isAllSample = true;
        
        boolean skipFees = false;
      if( fromTransfer == true && ((accMap.containsKey(brandId) && accMap.get(brandId).DBA__c != Account_Plateformlevel_ZASP && accMap.get(brandId).DBA__c != Account_Plateformlevel_IRR )
                                     || (accMap.containsKey(rdt.retailer) && accMap.get(rdt.retailer).DBA__c != Account_Plateformlevel_ZASP && accMap.get(rdt.retailer).DBA__c != Account_Plateformlevel_IRR))
           && accOfTransportLicense.size() > 0 && 
           (accOfTransportLicense[0].DBA__c != Account_Plateformlevel_ZASP && accOfTransportLicense[0].DBA__c != Account_Plateformlevel_IRR) ){
              skipFees = true;
           }
        if(brandPlatformLevel == ACCOUNT_PLATEFORMLEVEL_ADVANCE  && 
                       ((accMap.containsKey(brandId) && accMap.get(brandId).DBA__c == Account_Plateformlevel_ZASP || accMap.get(brandId).DBA__c == Account_Plateformlevel_IRR )
                                     || (accMap.containsKey(rdt.retailer) && accMap.get(rdt.retailer).DBA__c == Account_Plateformlevel_ZASP || accMap.get(rdt.retailer).DBA__c == Account_Plateformlevel_IRR))
            
                       && fromTransfer == true){
                        skipFees = true;
                    }
        
        for(RetailDeliveryTicketLineItem rdtli: rdtlis){
            if(String.isNotBlank(rdtli.Product)){
                Product p = productsMap.get(rdtli.Product);
                if(p == null)continue;
                System.debug('##ProductId:'+rdtli.Product);
                System.debug('@@Product:'+p);
                if(!rdtli.isSample){
                    isAllSample =false;
                }  
                Decimal pickPackFee = 0;
                Decimal QAReviewFee = 0;
                Decimal totalWeight = 0;
                if(rdtli.Product != null){
                    decimal weight = 0;
                    decimal unitweight = 0;
                    decimal pickPackPrice = 0;
                    decimal QAReviewPrice = 0;
                    if(p.MOQ > 1){
                        weight = p.caseShippingWeight;
                    }else{
                        weight = p.unitShippingWeight;
                        hasMOQ1Item = true;
                    }
                    unitweight = p.unitShippingWeight;
                    //Calulate Pick Pack Fee
                    if(weight > 0 && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_PICK_PACK)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_PICK_PACK);
                        if(!FRTs.isEmpty()){
                            for(Fulfillment_Rates_Table__c FRT: FRTs){
                                system.debug('weight '+weight);
                                if(FRT.Weight_lbs__c <= weight){
                                    System.debug('###FRT for Pick Pack:'+FRT);
                                    pickPackPrice = FRT.Bracket_Price__c;
                                    break;
                                }
                            }
                        }
                    }
                    system.debug('pickPackPrice '+pickPackPrice);
                    if(p.MOQ > 1){
                        pickPackFee = pickPackPrice * rdtli.orderQty;
                    }else{
                        pickPackFee = pickPackPrice * rdtli.orderQty * p.MOQ;
                    }
                    system.debug('pickPackFee '+pickPackFee);
                   
                    //Calulate QA Review Fee
                    //String [] Product_Families_to_Skip_QA_Review
                    if(serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_QA_REVIEW) && !Product_Families_to_Skip_QA_Review_Set.contains(p.productFamily)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_QA_REVIEW);
                        if(!FRTs.isEmpty()){
                            for(Fulfillment_Rates_Table__c FRT: FRTs){
                                if(FRT.Weight_lbs__c  <= weight && FRT.MOQ__c <= p.MOQ){
                                    System.debug('###FRT for QA Review:'+FRT);
                                    QAReviewPrice = FRT.Bracket_Price__c;
                                    break;
                                }
                            }
                        }
                        QAReviewFee = QAReviewPrice * rdtli.orderQty * p.MOQ;
                        /*if(!FRTs.isEmpty()){
                            QAReviewFee = FRTs[0].Bracket_Price__c * rdtli.orderQty * p.MOQ;
                        }*/
                    }
                    
                    //Calulate Total Weight
                    if(p.MOQ > 1){
                        totalWeight = weight * rdtli.orderQty;
                    }else{
                        totalWeight = weight * rdtli.orderQty * p.MOQ;
                    }
                }
                
                 if(fromTransfer == true  && (brandPlatformLevel == ACCOUNT_PLATEFORMLEVEL_BASIC || brandPlatformLevel == ACCOUNT_PLATEFORMLEVEL_ADVANCE)
                  && 
                       ((accMap.containsKey(brandId) && accMap.get(brandId).DBA__c == Account_Plateformlevel_ZASP || accMap.get(brandId).DBA__c == Account_Plateformlevel_IRR )
                                     || (accMap.containsKey(rdt.retailer) && accMap.get(rdt.retailer).DBA__c == Account_Plateformlevel_ZASP || accMap.get(rdt.retailer).DBA__c == Account_Plateformlevel_IRR))){
                    
                    QAReviewFee  = 0;
                }
                rdtLi.pickPackFee = pickPackFee;
                rdtLi.QAReviewFee = QAReviewFee;
                rdtLi.totalWeight = totalWeight;
                
                totalPickPack += pickPackFee;
                totalQAReview += QAReviewFee;
                totalOrderWeight += totalWeight;
            }
        }
        
        system.debug('serviceBasedFRTMap.size()'+serviceBasedFRTMap.size());
            system.debug('FULFILLMENT_SERVICE_ORDER_BOOKING '+FULFILLMENT_SERVICE_ORDER_BOOKING);
        //calculate OrderBooking Fee
        if(serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_ORDER_BOOKING)){
            Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_ORDER_BOOKING);
            system.debug('FRTs '+FRTs);
            if(!FRTs.isEmpty()){
                System.debug('###FRT for Order Booking:'+FRTs[0]);
                orderBookingFee = FRTs[0].Bracket_Price__c;
            }
        }
        if(serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_BOOKING)){
            Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_BOOKING);
            system.debug('FRTs '+FRTs);
            if(!FRTs.isEmpty()){
                System.debug('###FRT for Order Booking:'+FRTs[0]);
                serviceBookingFee = FRTs[0].Bracket_Price__c;
            }
        }
        if(serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_SCHEDULING)){
            Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_SCHEDULING);
            system.debug('FRTs '+FRTs);
            if(!FRTs.isEmpty()){
                System.debug('###FRT for Order Booking:'+FRTs[0]);
                serviceSchedulingFee = FRTs[0].Bracket_Price__c;
            }
        }
        if(serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_STAGING)){
            Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_STAGING);
            system.debug('FRTs '+FRTs);
            if(!FRTs.isEmpty()){
                System.debug('###FRT for Order Booking:'+FRTs[0]);
                serviceStagingFee = FRTs[0].Bracket_Price__c;
            }
        }
        //calculate Stage & Manifest
        if(serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_STAGE_MANIFEST)){
            Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_STAGE_MANIFEST);
            if(!FRTs.isEmpty()){
                System.debug('###FRT for Stage and Manifest:'+FRTs[0]);
                stageManifestFee = FRTs[0].Bracket_Price__c; 
            }
        }
        //calculate Schedule & Dispatch
        system.debug('serviceBasedFRTMap '+serviceBasedFRTMap);
        system.debug('FULFILLMENT_SERVICE_SCHEDULE_DISPATCH '+FULFILLMENT_SERVICE_SCHEDULE_DISPATCH);
        if(serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_SCHEDULE_DISPATCH)){
            Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_SCHEDULE_DISPATCH);
            if(!FRTs.isEmpty()){
                System.debug('###FRT for Schedule Dispatch:'+FRTs[0]);
                scheduleDispatchFee = FRTs[0].Bracket_Price__c;
            }
        }
        //calculate PackOut Fee
        if(hasMOQ1Item && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_PACKOUT)){
            Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_PACKOUT);
            if(!FRTs.isEmpty()){
                System.debug('###FRT for Pack Out:'+FRTs[0]);
                packOutFee = FRTs[0].Bracket_Price__c;
            }
        }
        
        //calculate Total Mileage Fee
        System.debug('###stateLicense.Total_Miles__c'+stateLicense.Total_Miles__c);
        System.debug('###totalMiles'+totalMiles);
        if(!mileageSRTList.isEmpty() && stateLicense.Total_Miles__c != null){
            for(Shipping_Rates_Table__c SRT: mileageSRTList){
                if(totalMiles <= SRT.Mileage_Bracket__c){
                    System.debug('###SRT for Mileage Fee:'+SRT);
                    if(SRT.Fixed_Mileage_Fee__c){
                        totalMileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                    }else{
                        totalMileageFee = SRT.Mileage_Bracket_Price__c * totalMiles; 
                    }
                    
                    break;
                }
            }  
            System.debug('###Mileage Fee11:'+totalMileageFee);
            /*if(fromTransfer == true && brandPlatformLevel == ACCOUNT_PLATEFORMLEVEL_ADVANCE){
            	totalMileageFee = 0;    
            }*/
            if(rdt.isSample ){
                totalMileageFee = 0;  	        
            } 
            //System.debug('###Mileage Fee22:'+totalMileageFee);
        }
        
        //calculate Total Weight Fee
        if(!weightSRTList.isEmpty()){
            for(Shipping_Rates_Table__c SRT: weightSRTList){
                if(totalOrderWeight <= SRT.Weight_Bracket__c){
                    System.debug('###SRT for Weight:'+SRT);
                    if(SRT.Fixed_Weight_Fee__c){
                        totalWeightFee = SRT.Fixed_Weight_Amount__c != null ? SRT.Fixed_Weight_Amount__c : 0;
                    }else{
                        totalWeightFee = SRT.Weight_Bracket_Price__c * totalOrderWeight; 
                    }
                    break;
                }
            }   
        }
       
        system.debug('##skipFees : '+skipFees);
        if(skipFees && fromTransfer == true ){
            
            totalMileageFee = 0;
         	totalWeightFee = 0;
            totalQAReview  = 0;
        }
        if(fromTransfer == true  && (brandPlatformLevel == ACCOUNT_PLATEFORMLEVEL_BASIC || brandPlatformLevel == ACCOUNT_PLATEFORMLEVEL_ADVANCE)
                  && 
                       ((accMap.containsKey(brandId) && accMap.get(brandId).DBA__c == Account_Plateformlevel_ZASP || accMap.get(brandId).DBA__c == Account_Plateformlevel_IRR )
                                     || (accMap.containsKey(rdt.retailer) && accMap.get(rdt.retailer).DBA__c == Account_Plateformlevel_ZASP || accMap.get(rdt.retailer).DBA__c == Account_Plateformlevel_IRR))){
                     
            totalQAReview  = 0;
        } 
        
        //System.debug('###Mileage Fee33:'+totalMileageFee);
        rdt.orderBookingFee = orderBookingFee;
        rdt.serviceBookingFee = serviceBookingFee;
        rdt.serviceSchedulingFee = serviceSchedulingFee;
        rdt.serviceStagingFee = serviceStagingFee;
        rdt.packOutFee = packOutFee;
        rdt.stageManifestFee = stageManifestFee;
        rdt.scheduleDispatchFee = scheduleDispatchFee; 
        rdt.totalMileageFee = totalMileageFee;
        rdt.totalWeightFee = totalWeightFee;
        rdt.totalOrderWeight = totalOrderWeight;
        
        r.data.put('totalPickPack',totalPickPack);
        r.data.put('totalQAReview',totalQAReview);
        r.data.put('totalOrderWeight',totalOrderWeight);
        r.data.put('retailDeliveryTicket', rdt);
        r.data.put('retailDeliveryTicketLineItems', rdtlis);
        r.data.put('items', JSON.serialize(rdtlis));
        System.debug('##rdtlis:'+rdtlis);
        system.debug('scheduleDispatchFee '+scheduleDispatchFee);
        system.debug('totalMileageFee '+totalMileageFee);
        system.debug('totalWeightFee '+totalWeightFee);
        system.debug('totalPickPack '+totalPickPack);
        system.debug('orderBookingFee '+orderBookingFee);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse calculateOrderProcessingFee(String satateLicenseId,String siteId,String itemsJSON,String orderJSON, String productJSON){
        return calculateOrderFee(satateLicenseId,siteId, itemsJSON, orderJSON, productJSON,false);
    }
    /*@AuraEnabled
    public static AuraResponse getDistance(String sAddress,String dAddress){
        System.debug('sAddress:'+sAddress);
        System.debug('dAddress:'+dAddress);
    	AuraResponse r = new AuraResponse('RetailDeliveryTicketsCtlr.getDistance()');
        	Decimal miles = 0;
        Http h = new Http();
		HttpRequest req = new HttpRequest();
		String endpoint = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins='+EncodingUtil.urlEncode(sAddress,'UTF-8')+'&destinations='+EncodingUtil.urlEncode(dAddress,'UTF-8')+'&mode=driving&language=en&key='+System.Label.Google_Map_API_Key;        
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setTimeout(5000);
        
        try{
            
			HttpResponse res = h.send(req);
            DistanceResponse reponse = (DistanceResponse) JSON.deserialize(res.getBody(), DistanceResponse.class); 
            System.debug('##reponse:'+reponse);
            if(reponse != null && reponse.rows != null){
                if(reponse.rows[0].elements != null){
                    System.debug('Distance: '+reponse.rows[0].elements[0].distance.value);
                    miles = (reponse.rows[0].elements[0].distance.value)/1000; // Distance in KM
                    miles = (miles * 0.6214); // Distance in miles
                }
            }
            
        }catch(Exception e){
            System.debug('##Exception:'+e.getMessage());
        }
        r.data.put('miles',miles);
        return r;
    }*/
    public static Decimal getTotalMiles(String siteId, String stateLicenseId){
        Site__c s = [SELECT Id,License_ID__r.License_Address__c ,License_ID__r.License_City__c ,License_ID__r.License_Country__c ,License_ID__r.License_State__c,License_ID__r.License_Zip__c FROM Site__c WHERE Id = :siteId];
        State_Licenses__c st = [SELECT Id,License_Address__c ,License_City__c , License_Country__c,License_State__c,License_Zip__c FROM State_Licenses__c WHERE Id =:stateLicenseId];
        String url = Google_Distance_Matrix_API__c.getValues('GMaps_Endpoint').Value__c;
        String apiKey = Google_Distance_Matrix_API__c.getValues('Gmaps_APIKey').Value__c;
        String parameters = 'origins=' + s.License_ID__r.License_Address__c +','+ s.License_ID__r.License_City__c+ ','+s.License_ID__r.License_State__c +' '+ s.License_ID__r.License_Zip__c+','+ s.License_ID__r.License_Country__c + '&destinations=' + st.License_Address__c +','+ st.License_City__c +','+st.License_State__c +' '+ st.License_Zip__c+','+ st.License_Country__c;
        String param2 =  '&language=en&key=';
        parameters = parameters.replace(' ','%20');
        url = url+parameters+param2+apiKey;
        url = url.replaceAll('#', '%20');
        System.debug('After... '+url);
        
        HTTP http = new HTTP();
        HTTPRequest request = new HTTPRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        if(!Test.isRunningTest()){
            HTTPResponse response = http.send(request);
            system.debug('response.getStatusCode()'+response.getStatusCode());
            System.debug('Respons..'+response.getBody());
            if(response.getStatusCode() == 200) {
                double distVal = 0;
                StateLicenseTotalMilesTriggerHelper.DistanceResponse reponse = (StateLicenseTotalMilesTriggerHelper.DistanceResponse) JSON.deserialize(response.getBody(), StateLicenseTotalMilesTriggerHelper.DistanceResponse.class); 
                if(reponse != null && reponse.rows != null){
                    if(reponse.rows[0].elements != null){
                        distVal = reponse.rows[0].elements[0].distance.value;
                        distVal = distVal * 0.00062137;
                    }
                }
                return distVal;
                //lstState.add(new State_Licenses__c(Id = st.Id,Total_Miles__c =  distVal));
            }
        }else{
            return 50;
        }
        return 0;
    }
    
    @AuraEnabled
    public static AuraResponse getSortedRDTLineItems(String recordId,Map<String, Object> filters){
        AuraResponse r = new AuraResponse('RetailDeliveryTicketsCtlr.getSortedRDTLineItems()');
        
        Map<String, Product> records = new Map<String, Product>();
        Map<String, Product[]> procuderProducts = new Map<String, Product[]>();
        Map<String, String> pbeProductMap = new Map<String, String>();
        
        for(PricebookEntry pbe: [SELECT Id,Product2.White_Labelled__c,Product2.Product_Short_Description__c,Product2.Producer_Name__r.DBA__c,Product2.Licensee_Name__c,Product2.Licensee_Name__r.Name,Product2.Licensee_Name__r.DBA__c, Product2.Name,Product2.Is_Sample__c,Product2.Image_URL__c,Product2.Parent_Product__c,Product2.Brand_Name__c, Product2.RecordType.Name,Product2.Family,Product2.Producer_Name__c ,Product2.Producer_Name__r.Name, UnitPrice,Product2.Description,Product2.Available_Inventory__c,Product2.Available_Qty__c,Product2.MOQ__c,Product2.Unit_Shipping_Weight_lbs__c, Product2.Case_Shipping_Weight_lbs__c,Product2.Apply_Excise_Tax__c,Product2.Max_Order_Allowed__c FROM PricebookEntry WHERE Product2.Hide_From_Marketplace__c = false AND ((Product2.Producer_Name__c = :brandId AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c = :brandId AND Product2.White_Labelled__c = true) ) AND PriceBook2Id = :priceBookId AND Product2.RecordType.Name = :recordTypeName AND Product2.IsActive = true Order By Product2.Name]){
            Product p = new Product(pbe);
            
            if(pbe.Product2.White_Labelled__c && pbe.Product2.Licensee_Name__c != null && pbe.Product2.Licensee_Name__r.DBA__c != null){
                p.brandName = pbe.Product2.Licensee_Name__r.DBA__c;
                p.brandId = pbe.Product2.Licensee_Name__c;
            } else if(pbe.Product2.Producer_Name__c != null && pbe.Product2.Producer_Name__r.DBA__c != null){
                p.brandName = pbe.Product2.Producer_Name__r.DBA__c;
                p.brandId = pbe.Product2.Producer_Name__c;
            }
            
            if(!pbe.Product2.Is_Sample__c){
                pbeProductMap.put(pbe.Product2Id,pbe.Id);
            }
            
            records.put(pbe.Product2Id, p);
            if(procuderProducts.containsKey(pbe.Product2.Producer_Name__c)){
                procuderProducts.get(pbe.Product2.Producer_Name__c).add(p);
            }else{
                procuderProducts.put(pbe.Product2.Producer_Name__c,new Product[]{p});
            }
        }
        
        for(Product pro : records.values()){
            if(pro.isSample && pro.parentProductId != null){
                if(pbeProductMap.containsKey(pro.parentProductId)){
                    pro.price.id = pbeProductMap.get(pro.parentProductId);
                    System.debug('pbeProductMap1 = '+pro.price.id);
                }
            }
        }
        
        List<RetailDeliveryTicketLineItem> retailDeliveryTicketLineItems = new List<RetailDeliveryTicketLineItem>();
        String orderByField = ORDERBY_NAME;
        String direction = DESC_DIRECTION;
        String orderBy = '';
        
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(ProductsCtlr.hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        
        string queryStr = 'SELECT Name,Account__c,Sample_Order__c,Account__r.Name,Site__c,Site__r.Warehouse_Name__c,Account__r.Image_URL__c, Order_Date__c, Total__c, Status__c,Payment_Terms__c,Route_Miles__c,Retailer__c,Retailer__r.Name,Retailer__r.dBA__c,Retailer__r.Image_URL__c,Retailer_Contact__c,Sales_Person__c,Sales_Person__r.Name,';
        queryStr += 'Additional_Brand_Contact__c,Additional_Brand_Contact__r.Name,Retailer_Contact__r.Name,Request_Ship_Date__c,Retailer_PO__c,Special_Instructions__c,isPreapproved__c,Requested_Delivery_Latest_Time__c,Requested_Delivery_Earliest_Time__c,';
        queryStr += 'State_License__c,Invoice_Memo__c,State_License__r.Name,Factoring_Terms__c,State_License__r.License_Number__c,State_License__r.License_Address__c,State_License__r.License_City__c,';
        queryStr += 'State_License__r.License_State__c,State_License__r.License_Country__c,State_License__r.License_Zip__c,Total_Line_Items__c, Shipping_Street__c, Shipping_Country__c,';
        queryStr += 'Shipping_Province__c, Shipping_City__c,Piggyback_sample__c, Shipping_Zip__c,Exclude_Excise_Tax__c,Total_Local_Tax__c ,Order_Booking_Fee__c,Pack_Out_Fee__c,';
        queryStr += 'Stage_Manifest_Fee__c,Schedule_Dispatch_Fee__c,Total_Milage_Fee__c,Total_Weight_Fee__c, Total_Excise_Tax_Amount__c ,Service_Booking_Fee__c,Service_Scheduling_Fee__c,Service_Staging_Fee__c,Factoring_Assignee__c,Factoring_Assignee__r.DBA__c,Factoring_Contact__c,Factoring_Contact__r.Name,Factoring_Rate__c,Factoring_Discount__c ,';
        queryStr += '(SELECT Name,Quantity_Cases__c, UnitPrice__c, Line_Total_Cost__c, Unit_Excise_Tax__c, Line_Total_Excise_Tax__c, Line_Total_Qty__c, MOQ__c, Total__c,';
        queryStr += 'Is_Sample__c, Price_Book_Entry_Id__c,Product__r.RecordType.Name,Product__r.Parent_Product__c, Product__c, Product__r.Name, Product__r.Image_URL__c,Product__r.Description, Product__r.Producer_Name__r.Name,';
        queryStr += 'Product__r.Is_Sample__c,Product__r.Product_Short_Description__c,Product__r.Product_Details__c, Product__r.Brand_Name__c, Product__r.Family, Product__r.Product_Rating__c, Product__r.Available_Inventory__c,Product__r.Available_Qty__c,';
        queryStr += 'Is_Brand_Product__c,IsPromo__c,Special_Instructions__c, Subtotal_Local_Cannabis_Tax__c,Product__r.Apply_Excise_Tax__c,Pick_Pack_Fee__c,QA_Review_Fee__c,Total_Weight_lbs__c,Product__r.Max_Order_Allowed__c ';
        queryStr += 'FROM Order_Line_Items__r';
		queryStr += ' ORDER BY ' + String.escapeSingleQuotes(orderBy);                         
        queryStr += ' ) FROM Order__c WHERE Id = :recordId';                
         
        for(Order__c o :Database.query(queryStr)){
            for(Order_Line_Item__c tmpRDTLI: o.Order_Line_Items__r){
                RetailDeliveryTicketLineItem rdi = new RetailDeliveryTicketLineItem(tmpRDTLI);
                Product p = records.get(rdi.Product);
                if(p != null){
                    rdi.listPrice = p.price.unitPrice;
                    rdi.ProductBookEntryId = p.price.Id;
                    rdi.brandName = p.brandName;
                    rdi.brandId = p.brandId;
                }
                
                retailDeliveryTicketLineItems.add(rdi);
            }
        }
        r.data.put('retailDeliveryTicketLineItems', retailDeliveryTicketLineItems); 
        r.data.put('warehouseAvailableInventoryMap',getWarehouseAvailableInventory(records.keySet()));
        r.data.put('warehouseTotalOrderedMap',getWarehouseOrderedMap(records.keySet()));
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getRetailDeliveryTicket(String recordId){
        AuraResponse r = new AuraResponse('RetailDeliveryTicketsCtlr.getRetailDeliveryTicket()');
        Map<String, Product> records = new Map<String, Product>();
        Map<String, Product[]> procuderProducts = new Map<String, Product[]>();
        Map<String, String> pbeProductMap = new Map<String, String>();
        r.data.put('Order_Delete_Confirm_Message',Order_Delete_Confirm_Message);
        r.data.put('Order_Recall_Confirm_Message',Order_Recall_Confirm_Message);
        r.data.put('Transfer_Order_Recall_Confirm_Message',Transfer_Order_Recall_Confirm_Message);
        r.data.put('Order_Deleted_Message',Order_Deleted_Message);
        r.data.put('Transfer_Order_Delete_Confirm_Message',Transfer_Order_Delete_Confirm_Message);
        r.data.put('Transfer_Order_Deleted_Message',Transfer_Order_Deleted_Message);
        string Msg_for_isSample_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Msg_for_isSample_Tooltip');
        r.data.put('Msg_for_isSample_Tooltip', Msg_for_isSample_Tooltip != null ? Msg_for_isSample_Tooltip : '');        
        
        for(PricebookEntry pbe: [SELECT Id,Product2.White_Labelled__c,Product2.Product_Short_Description__c,Product2.Producer_Name__r.DBA__c,Product2.Licensee_Name__c,Product2.Licensee_Name__r.Name,Product2.Licensee_Name__r.DBA__c, Product2.Name,Product2.Is_Sample__c,Product2.Image_URL__c,Product2.Parent_Product__c,Product2.Brand_Name__c, Product2.RecordType.Name,Product2.Family,Product2.Producer_Name__c ,Product2.Producer_Name__r.Name, UnitPrice,Product2.Description,Product2.Available_Inventory__c,Product2.Available_Qty__c,Product2.MOQ__c,Product2.Unit_Shipping_Weight_lbs__c, Product2.Case_Shipping_Weight_lbs__c,Product2.Apply_Excise_Tax__c,Product2.Max_Order_Allowed__c FROM PricebookEntry WHERE Product2.Hide_From_Marketplace__c = false AND ((Product2.Producer_Name__c = :brandId AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c = :brandId AND Product2.White_Labelled__c = true) ) AND PriceBook2Id = :priceBookId AND Product2.RecordType.Name = :recordTypeName AND Product2.IsActive = true Order By Product2.Name]){
            Product p = new Product(pbe);
            
            /*if(pbe.Product2.White_Labelled__c && pbe.Product2.Licensee_Name__c != null && pbe.Product2.Licensee_Name__r.DBA__c != null){
                p.brandName = pbe.Product2.Licensee_Name__r.DBA__c;
                p.brandId = pbe.Product2.Licensee_Name__c;
            } else if(pbe.Product2.Producer_Name__c != null && pbe.Product2.Producer_Name__r.DBA__c != null){
                p.brandName = pbe.Product2.Producer_Name__r.DBA__c;
                p.brandId = pbe.Product2.Producer_Name__c;
            }*/
            
            p.brandName = pbe.Product2.Brand_Name__c;
            p.brandId = brandId;
            if(!pbe.Product2.Is_Sample__c){
                pbeProductMap.put(pbe.Product2Id,pbe.Id);
            }
            
            records.put(pbe.Product2Id, p);
            if(procuderProducts.containsKey(pbe.Product2.Producer_Name__c)){
                procuderProducts.get(pbe.Product2.Producer_Name__c).add(p);
            }else{
                procuderProducts.put(pbe.Product2.Producer_Name__c,new Product[]{p});
            }
        }
        
        for(Product pro : records.values()){
            if(pro.isSample && pro.parentProductId != null){
                if(pbeProductMap.containsKey(pro.parentProductId)){
                    pro.price.id = pbeProductMap.get(pro.parentProductId);
                    System.debug('pbeProductMap1 = '+pro.price.id);
                }
            }
        }
        
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Brand__c IN: procuderProducts.keySet() AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now()]){
            Product[] products = procuderProducts.get(bd.Brand__c);
            if(products != null){
                for(Product p: products){
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
            }
        }
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Product_Name__c IN: records.keySet() AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now()]){
            Product p = records.get(bd.Product_Name__c);
            if(p != null){
                if(p.discountPercent != null){
                    p.setProductDiscountPercent(bd.Discount_Percentage__c);
                }else{
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
                
            }
        }
        /*for(Product2 p: [SELECT Name FROM Product2 WHERE Producer_Name__c = :brandId AND IsActive = true ORDER BY Name]){
products.add(new BrandProduct(p));
}*/
        r.data.put('products', records.values());
        RetailDeliveryTicket rdt = new RetailDeliveryTicket();
        List<RetailDeliveryTicketLineItem> retailDeliveryTicketLineItems = new List<RetailDeliveryTicketLineItem>();
        System.debug('###recordId:'+recordId);
        List<String> relatedContacts = new List<String>();
        if(String.isNotBlank(recordId)){
            String RetailerId = '';
            
            Id stateLicenceId;
            Order__c ord = [SELECT Id,State_License__c FROM Order__c WHERE Id =: recordId];
            if(ord != null){
                stateLicenceId = ord.State_License__c;
            }
            
            State_Licenses__c stateLicense= [SELECT Id, Default_Warehouse__c,Total_Miles__c FROM State_Licenses__c where Id =: stateLicenceId];
            system.debug('stateLicense.Default_Warehouse__c '+stateLicense.Default_Warehouse__c);
            //system.debug('membershipLevel  '+membershipLevel );
            Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c,Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c,Membership_Level__c
                                                     FROM Fulfillment_Rates_Table__c 
                                                     WHERE Site__c = :stateLicense.Default_Warehouse__c
                                                     AND Active__c = true
                                                     AND Rate_Effective_From__c <= :System.today()
                                                     AND Rate_Effective_To__c >= :System.today()
                                                     AND Membership_Level__c = :membershipLevel
                                                     ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
            Shipping_Rates_Table__c [] mileageSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                                         Weight_Bracket__c, Weight_Bracket_Price__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                         FROM Shipping_Rates_Table__c 
                                                         WHERE Site__c = :stateLicense.Default_Warehouse__c
                                                         AND Active__c = true
                                                         AND Rate_Effective_From__c <= :System.today()
                                                         AND Rate_Effective_To__c >= :System.today()
                                                         AND Membership_Level__c = :membershipLevel
                                                         Order By Mileage_Bracket__c];
            Shipping_Rates_Table__c [] weightSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                                        Weight_Bracket__c, Weight_Bracket_Price__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                        FROM Shipping_Rates_Table__c 
                                                        WHERE Site__c = :stateLicense.Default_Warehouse__c
                                                        AND Active__c = true
                                                        AND Rate_Effective_From__c <= :System.today()
                                                        AND Rate_Effective_To__c >= :System.today()
                                                        AND Membership_Level__c = :membershipLevel
                                                        Order By Weight_Bracket__c];
            system.debug('FRTList '+FRTList);
            system.debug('mileageSRTList '+mileageSRTList);
            system.debug('weightSRTList '+weightSRTList);
            Map<String,Fulfillment_Rates_Table__c []> serviceBasedFRTMap = new Map<String,Fulfillment_Rates_Table__c []>();
            if(!FRTList.isEmpty()){
                for(Fulfillment_Rates_Table__c FRT:FRTList){
                    if(serviceBasedFRTMap.containsKey(FRT.Fulfillment_Services__c)){
                        serviceBasedFRTMap.get(FRT.Fulfillment_Services__c).add(FRT);
                    }else{
                        serviceBasedFRTMap.put(FRT.Fulfillment_Services__c,new Fulfillment_Rates_Table__c[]{FRT});
                    }
                }
            }
            
           
            Map<String,Decimal> smQtyReceivedMap = new Map<String,Decimal>();
            
            for(Shipping_Manifest_Line__c sml : [select id, Product_Name__c, Qty_Received__c from Shipping_Manifest_Line__c WHERE Shipping_Manifest__r.Order_Number__c =: recordId AND Qty_Received__c > 0]){
                if(smQtyReceivedMap.containsKey(sml.Product_Name__c)){
                    Decimal totalReceivedQty = smQtyReceivedMap.get(sml.Product_Name__c) +sml.Qty_Received__c;
                    smQtyReceivedMap.put(sml.Product_Name__c,totalReceivedQty);
                }else{
                    smQtyReceivedMap.put(sml.Product_Name__c,sml.Qty_Received__c);
                }
                
            }
            
            for(Order__c o :[SELECT Name,Account__c,Account__r.Name,Site__c,Site__r.Warehouse_Name__c,Account__r.Image_URL__c, Order_Date__c, Total__c, Status__c,Payment_Terms__c,Route_Miles__c,Retailer__c,Retailer__r.Name,Retailer__r.dBA__c,Retailer__r.Image_URL__c,Retailer__r.Third_Party_Scheduler__c,Retailer__r.QR_Code__c,Retailer__r.Bar_Code__c,Retailer_Contact__c,Sales_Person__c,Sales_Person__r.Name,
                             Additional_Brand_Contact__c,Sample_Order__c,Additional_Brand_Contact__r.Name,Retailer_Contact__r.Name,Request_Ship_Date__c,Retailer_PO__c,Special_Instructions__c,
                             State_License__c,Invoice_Memo__c,State_License__r.Name,State_License__r.License_Number__c,State_License__r.License_Address__c,State_License__r.License_City__c,
                             State_License__r.License_State__c,State_License__r.License_Type__c,Site__r.License_Number__c,isPreapproved__c,Requested_Delivery_Latest_Time__c,Requested_Delivery_Earliest_Time__c,
                             Transporter__r.License_Number__c,Transporter__r.License_Name__r.DBA__c,
                             Site__r.License_ID__r.License_Address__c,Site__r.License_ID__r.License_City__c,Site__r.License_ID__r.License_State__c,
                             Site__r.License_ID__r.License_Country__c,Site__r.License_ID__r.License_Zip__c,Total_Excise_Tax_Amount__c ,
                             State_License__r.License_Country__c,State_License__r.License_Zip__c,Total_Line_Items__c,Piggyback_sample__c, Shipping_Street__c, Shipping_Country__c, 
                             Shipping_Province__c,Factoring_Terms__c, Shipping_City__c, Shipping_Zip__c,Exclude_Excise_Tax__c,Total_Local_Tax__c ,Order_Booking_Fee__c,Pack_Out_Fee__c,
                             Stage_Manifest_Fee__c,Schedule_Dispatch_Fee__c,Total_Milage_Fee__c,Total_Weight_Fee__c,Service_Booking_Fee__c,Service_Scheduling_Fee__c,Service_Staging_Fee__c,Factoring_Assignee__c,Factoring_Assignee__r.DBA__c,Factoring_Contact__c,Factoring_Contact__r.Name,Factoring_Rate__c,Factoring_Discount__c , 
                             (SELECT Name,Quantity_Cases__c,IsPromo__c, UnitPrice__c, Line_Total_Cost__c, Unit_Excise_Tax__c, Line_Total_Excise_Tax__c, Line_Total_Qty__c, MOQ__c, Total__c,
                              Is_Sample__c, Price_Book_Entry_Id__c,Product__r.RecordType.Name,Product__r.Parent_Product__c, Product__c, Product__r.Name, Product__r.Image_URL__c,Product__r.Description, Product__r.Producer_Name__r.Name,
                              Product__r.Is_Sample__c,Product__r.Product_Short_Description__c,Product__r.Product_Details__c, Product__r.Brand_Name__c, Product__r.Family, Product__r.Product_Rating__c, Product__r.Available_Inventory__c,Product__r.Available_Qty__c,
                              Is_Brand_Product__c,Special_Instructions__c, Subtotal_Local_Cannabis_Tax__c,Product__r.Apply_Excise_Tax__c,Pick_Pack_Fee__c,QA_Review_Fee__c,Total_Weight_lbs__c,Product__r.Max_Order_Allowed__c   
                              FROM Order_Line_Items__r order by Product__r.Brand_Name__c ASC),
                             (SELECT Id,Contact__c,Contact__r.Name,Type__c FROM Retailer_Related_Contacts__r) 
                             FROM Order__c WHERE Id = :recordId]){
                                 rdt = new RetailDeliveryTicket(o);
                                 rdt.siteWarehouseAddress = '';
                                 if(o.Site__c != null){
                                     rdt.siteWarehouseAddress = o.Site__r.License_Number__c+' | ';
                                     List<String> siteAddress = new List<String>();
                                     if(String.isNotBlank(o.Site__r.License_ID__r.License_Address__c)){
                                         siteAddress.add(o.Site__r.License_ID__r.License_Address__c);
                                     }
                                     if(String.isNotBlank(o.Site__r.License_ID__r.License_City__c)){
                                         siteAddress.add(o.Site__r.License_ID__r.License_City__c);
                                     }
                                     if(String.isNotBlank(o.Site__r.License_ID__r.License_State__c)){
                                         siteAddress.add(o.Site__r.License_ID__r.License_State__c);
                                     }
                                     if(String.isNotBlank(o.Site__r.License_ID__r.License_Country__c)){
                                         siteAddress.add(o.Site__r.License_ID__r.License_Country__c);
                                     }
                                     if(String.isNotBlank(o.Site__r.License_ID__r.License_Zip__c)){
                                         siteAddress.add(o.Site__r.License_ID__r.License_Zip__c);
                                     }
                                     rdt.siteWarehouseAddress += String.join(siteAddress, ', '); 
                                 }
                                 rdt.transportLicenseName = (o.Transporter__r.License_Number__c != null ? o.Transporter__r.License_Number__c +' | ' : '' )+ (o.Transporter__r.License_Name__r.DBA__c != null ? o.Transporter__r.License_Name__r.DBA__c : '');
                                 if(o.Account__r.Image_URL__c != '' && o.Account__r.Image_URL__c != NULL){
                                     rdt.retailerLogoURL = o.Account__r.Image_URL__c;
                                 } else {
                                     rdt.retailerLogoURL = IMAGE_COMINGSOON;
                                 }                
                                 List<String> address = new List<String>();
                                 address.add(o.State_License__r.License_Address__c);
                                 if(String.isNotBlank(o.State_License__r.License_City__c)){
                                     address.add(o.State_License__r.License_City__c);
                                 }
                                 if(String.isNotBlank(o.State_License__r.License_State__c)){
                                     address.add(o.State_License__r.License_State__c);
                                 }
                                 if(String.isNotBlank(o.State_License__r.License_Country__c)){
                                     address.add(o.State_License__r.License_Country__c);
                                 }
                                 if(String.isNotBlank(o.State_License__r.License_Zip__c)){
                                     address.add(o.State_License__r.License_Zip__c);
                                 }
                                 rdt.stateLicenseName = o.State_License__r.License_Number__c+' | '+String.join(address, ', '); 
                                 rdt.stateLicenseAddress = String.join(address, ', ');              
                                 if(o.State_License__r.License_Number__c != null){
                                     rdt.stateLicenseNumber = o.State_License__r.License_Number__c+'-'+o.State_License__r.License_Type__c;
                                 }                 
                                 RetailerId = o.Retailer__c;
                                 if(String.isNotBlank(rdt.id)){
                                     List<RetailDeliveryTicketLineItem> discountProdList = new List<RetailDeliveryTicketLineItem>();
                                     for(Order_Line_Item__c tmpRDTLI: o.Order_Line_Items__r){
                                         system.debug('tmpRDTLI.Pick_Pack_Fee__c'+tmpRDTLI.Pick_Pack_Fee__c);
                                         RetailDeliveryTicketLineItem rdi = new RetailDeliveryTicketLineItem(tmpRDTLI);
                                         system.debug('rdi.pickPackFee'+rdi.pickPackFee);
                                         if(smQtyReceivedMap.size() > 0 && smQtyReceivedMap.containsKey(tmpRDTLI.Product__c)){
                                             rdi.totalReceivedQty =smQtyReceivedMap.get(tmpRDTLI.Product__c) / tmpRDTLI.MOQ__c;
                                         }
                                          
                                         Decimal QAReviewFee = 0;
                                         Product p = records.get(rdi.Product);
                                         if(p != null){
                                             //rdi.listPrice = p.price.unitPrice;
                                             rdi.ProductBookEntryId = p.price.Id;
                                             rdi.brandName = p.brandName;
                                             rdi.brandId = p.brandId;
                                             
                                             decimal QAReviewPrice = 0;
                                             //Calulate QA Review Fee
                                             if(serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_QA_REVIEW)){
                                                 Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_QA_REVIEW);
                                                 if(!FRTs.isEmpty()){
                                                     for(Fulfillment_Rates_Table__c FRT: FRTs){
                                                         if(FRT.Weight_lbs__c  <= p.unitShippingWeight && FRT.MOQ__c <= p.MOQ){
                                                             QAReviewPrice = FRT.Bracket_Price__c;
                                                             break;
                                                         }
                                                     }
                                                 }
                                                 QAReviewFee = QAReviewPrice * rdi.orderQty * p.MOQ;
                                             }
                                         }
                                         //rdi.QAReviewFee = QAReviewFee;
                                         if(rdi.isDiscountProduct == true)
                                             discountProdList.add(rdi);
                                         else
                                         	retailDeliveryTicketLineItems.add(rdi);
                                     }
                                     retailDeliveryTicketLineItems.addAll(discountProdList);
                                 }
                                 if(o.Retailer_Related_Contacts__r.size() > 0){
                                     for(Retailer_Related_Contact__c rrc: o.Retailer_Related_Contacts__r){
                                         if(rrc.Type__c == TYPE_ADD_RETAIL_CONTACT)
                                             relatedContacts.add(rrc.Contact__c);   
                                     }
                                 }
                                 
                                 if(o.Retailer__r.QR_Code__c && !o.Retailer__r.Bar_Code__c )
                                 	r.data.put('BarCodeORQRCodeMSG', Orders_Requiring_QR_Codes );
                                 else if(!o.Retailer__r.QR_Code__c && o.Retailer__r.Bar_Code__c )
                                 	r.data.put('BarCodeORQRCodeMSG', Orders_Requiring_Bar_Codes);
                                 else if(o.Retailer__r.QR_Code__c && o.Retailer__r.Bar_Code__c )
                                    r.data.put('BarCodeORQRCodeMSG', Orders_Requiring_BarCodes_and_or_QR_Code);
                                 /*else if(!o.Retailer__r.QR_Code__c && !o.Retailer__r.Bar_Code__c && o.Retailer__r.Third_Party_Scheduler__c)
                                    r.data.put('BarCodeORQRCodeMSG', Orders_Requiring_Third_Party_Scheduler);
                                 else if(o.Retailer__r.QR_Code__c && !o.Retailer__r.Bar_Code__c && o.Retailer__r.Third_Party_Scheduler__c)
                                    r.data.put('BarCodeORQRCodeMSG', Orders_Requiring_TPS_and_or_QR_Code);
                                 else if(!o.Retailer__r.QR_Code__c && o.Retailer__r.Bar_Code__c && o.Retailer__r.Third_Party_Scheduler__c)
                                    r.data.put('BarCodeORQRCodeMSG', Orders_Requiring_TPS_and_or_Bar_Code);
                                 else if(o.Retailer__r.QR_Code__c && o.Retailer__r.Bar_Code__c && o.Retailer__r.Third_Party_Scheduler__c)
                                    r.data.put('BarCodeORQRCodeMSG', Orders_Requiring_TPS_and_Bar_Code_and_QR);*/
                                 else
                                     r.data.put('BarCodeORQRCodeMSG','');
                                 
                                 if(o.Retailer__r.Third_Party_Scheduler__c){
                                     r.data.put('ThirdPartySchedulerMSG',Orders_Requiring_Third_Party_Scheduler);
                                 }else{
                                      r.data.put('ThirdPartySchedulerMSG','');
                                 }
                                 
                             }
            
            BrandContact[] contacts = new BrandContact[]{};
                for(Contact p: [SELECT Name FROM Contact WHERE AccountId = :RetailerId AND Active__c = true AND Email != null Order By Name]){
                    contacts.add(new BrandContact(p));
                }
            r.data.put('contacts', contacts);
            
            list<Opportunity>oppList = [select id,(select id,Ship_Confirmation_Date__c from Quotes__r order by createddate desc) from Opportunity where Order__c =: recordId order by createddate desc];
            if(oppList.size() > 0 && oppList[0].Quotes__r.size() > 0){
                rdt.deliveredDate = oppList[0].Quotes__r[0].Ship_Confirmation_Date__c;
            }
        }
        string shippingToolTip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Shipping_Tool_Tip');
        string distributionToolTip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Distribution_Tool_Tip');
        string factoringDiscountToolTip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Factoring_Discount_Tool_Tip');
        
        System.debug('###rdt::'+rdt);
        
        r.data.put('shippingToolTip', shippingToolTip != null ? shippingToolTip : '');
        r.data.put('distributionToolTip', distributionToolTip != null ? distributionToolTip : '');
        r.data.put('factoringDiscountToolTip', factoringDiscountToolTip != null ? factoringDiscountToolTip : '');
        r.data.put('retailDeliveryTicket', rdt);
        r.data.put('retailDeliveryTicketLineItems', retailDeliveryTicketLineItems);
        r.data.put('relatedContacts', relatedContacts);
        system.debug('getWarehouseAvailableInventory(records.keySet()) '+getWarehouseAvailableInventory(records.keySet()));
        r.data.put('warehouseAvailableInventoryMap',getWarehouseAvailableInventory(records.keySet()));
        r.data.put('warehouseTotalOrderedMap',getWarehouseOrderedMap(records.keySet()));
        
        List<Invoice__c> lstInvoices = new List<Invoice__c>([SELECT Id,Name,AR_Status__c,Brand_Quote__c,Brand_Quote__r.Name,Receiver_DBA__c,Payment_Terms__c,
                                                             Ship_Confirmation_Date__c,Invoice_Balance__c,Collections_Status__c 
                                                             FROM Invoice__c WHERE Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c =: recordId]);
        
        r.data.put('invoiceList',lstInvoices);
        
        if(lstInvoices.size() > 0){
            Set<Id> setInvIds = new Set<Id>();
            Map<Id,String> invoiceFileIds = new Map<Id,String>();
            
            for(Invoice__c inv : lstInvoices){
                setInvIds.add(inv.Id);
            }
            System.debug('##invoiceFile :'+setInvIds);
            ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId IN :setInvIds ];
            Attachment [] attachmentFiles =[SELECT Id, Name,ParentId From Attachment WHERE ParentId IN :setInvIds];
            if(!files.isEmpty() || !attachmentFiles.isEmpty()){
                for(Invoice__c inv : lstInvoices){
                    Id invoiceId = inv.Id;
                    if(invoiceId != null){
                        String docIds = '';
                        String comma = '';
                        String[] pdfIds = new String[]{};
                            String[] otherIds = new String[]{};
                                if(!files.isEmpty()){
                                    for(ContentDocumentLink l:files){
                                        if(l.LinkedEntityId == invoiceId){
                                            System.debug('l.ContentDocument.FileExtension::'+l.ContentDocument.FileExtension);
                                            if(l.ContentDocument.FileExtension == 'pdf' || l.ContentDocument.FileExtension == 'jpg' ||
                                               l.ContentDocument.FileExtension == 'csv'  || l.ContentDocument.FileExtension == 'docx' ||
                                               l.ContentDocument.FileExtension == 'jpeg' || l.ContentDocument.FileExtension == 'png') pdfIds.add(l.ContentDocumentId);
                                            else otherIds.add(l.ContentDocumentId);
                                        }
                                    }
                                }
                        if(!attachmentFiles.isEmpty()){
                            for(Attachment att : attachmentFiles){
                                if( att.ParentId == invoiceId){
                                    pdfIds.add(att.id);
                                }
                            }
                        }
                        docIds = (!pdfIds.isEmpty()?String.join(pdfIds,','):'');
                        if(String.isNotBlank(docIds)){
                            docIds += ','+(!otherIds.isEmpty()?String.join(otherIds,','):'');
                        }else{
                            docIds = (!otherIds.isEmpty()?String.join(otherIds,','):'');
                        }
                        invoiceFileIds.put(inv.Id,docIds);//p.complianceFileId = docIds;
                    }
                }
                r.data.put('invoiceFileIds',invoiceFileIds);
            }
        }
        
        List<Shipping_Manifest__c>shipmenifestList = new List<Shipping_Manifest__c>([select Id,Name,Status__c,Metrc_Manifest__c,Brand_Quote__c,Brand_Quote__r.Name,Receiver_DBA__c,Payment_Terms__c,Ship_Confirmation_Date__c,Total_Line_Items__c,Total_Price__c,(select id,Qty_Received__c from Shipping_Manifest_Lines__r) from Shipping_Manifest__c where Order_Number__c =: recordId]);
        r.data.put('shipmenifestList',shipmenifestList);
        
        if(shipmenifestList.size() > 0){
            Set<Id> setSMIds = new Set<Id>();
            Map<Id,String> SMFileIds = new Map<Id,String>();
            
            for(Shipping_Manifest__c sm : shipmenifestList){
                setSMIds.add(sm.Id);
                
            }
            ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId IN :setSMIds ];
            
            if(!files.isEmpty()){
                for(Shipping_Manifest__c sm : shipmenifestList){
                    Id smId = sm.Id;
                    if(smId != null){
                        String docIds = '';
                        String comma = '';
                        String[] pdfIds = new String[]{};
                            String[] otherIds = new String[]{};
                                for(ContentDocumentLink l:files){
                                    if(l.LinkedEntityId == smId){
                                        System.debug('l.ContentDocument.FileExtension::'+l.ContentDocument.FileExtension);
                                        if(l.ContentDocument.FileExtension == 'pdf'  || l.ContentDocument.FileExtension == 'jpg' ||
                                           l.ContentDocument.FileExtension == 'csv'  || l.ContentDocument.FileExtension == 'docx' ||
                                           l.ContentDocument.FileExtension == 'jpeg' || l.ContentDocument.FileExtension == 'png') pdfIds.add(l.ContentDocumentId);
                                        else otherIds.add(l.ContentDocumentId);
                                    }
                                }
                        docIds = (!pdfIds.isEmpty()?String.join(pdfIds,','):'');
                        if(String.isNotBlank(docIds)){
                            docIds += ','+(!otherIds.isEmpty()?String.join(otherIds,','):'');
                        }else{
                            docIds = (!otherIds.isEmpty()?String.join(otherIds,','):'');
                        }
                        SMFileIds.put(sm.Id,docIds);//p.complianceFileId = docIds;
                    }
                }
                r.data.put('SMFileIds',SMFileIds);
            }
        }
        
        r.handleErrors();
        
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getIds(Map<String, Object> filters,Boolean showTransferOrders){
        system.debug('showTransferOrders '+showTransferOrders);
        system.debug('filters '+filters);
        AuraResponse r = new AuraResponse('RetailDeliveryTicketsCtlr.getIds()');
        
        String orderByField = ORDERBY_NAME;
        String direction = DESC_DIRECTION;
        String orderBy = '';
        List<String> families = new List<String>();
        List<String> whereSearchParts = new List<String>();
        
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(ProductsCtlr.hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        system.debug('##direction : '+direction);
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        
        Set<Id> ids = new Set<Id>();
        string queryStr = 'SELECT Id,Name,Retailer__r.Name,Piggyback_sample__c,Site__c,Site__r.Warehouse_Name__c,Retailer__r.DBA__c,Status__c,Request_Ship_Date__c FROM Order__c WHERE Retailer__c != null AND Account__c = :brandId';
        if(showTransferOrders){
            queryStr += ' AND Order_Type__c =: ORDER_RECORD_TYPE_NAME_TRANSFER AND Total__c != 0 '; 
        } else{
            queryStr += ' AND ( Order_Type__c =: ORDER_RECORD_TYPE_NAME_BRAND OR (Order_Type__c =: ORDER_RECORD_TYPE_NAME_TRANSFER AND Total__c = 0))'; 
        }
            
        
        if(hasFilter(filters, STATUS_FILTER)){
            String STStatus = String.valueOf(filters.get(STATUS_FILTER));
            if(STStatus != ORDER_ALL){
                if(STStatus == ORDER_CANCELLED){
                    Set<String> cancelledStatus = new Set<String>{ORDERCANCELLED_CUSTOMER,ORDERCANCELLED_FILIGREEN};
                    //whereSearchParts.add('(Status__c IN :cancelledStatus)'); 
                    queryStr += ' AND Status__c IN :cancelledStatus';
                } else {
                    //whereSearchParts.add('(Status__c = :STStatus)');
                    queryStr += ' AND Status__c = :STStatus';
                }
            }
        }
        
        String searchTerm = '';
        Date createdDate = null;
        
        if(hasFilter(filters, SEARCHTERM_FILTER)){
            searchTerm = String.valueOf(filters.get(SEARCHTERM_FILTER));
            if(String.isNotBlank(searchTerm)){
                if(searchTerm.indexOf('/') != -1){
                    try{
                        createdDate = Date.parse(searchTerm);
                    }catch(Exception e){
                        
                    }
                }
                searchTerm = '%' + searchTerm + '%';
                whereSearchParts.add('(Name LIKE :searchTerm)');
                whereSearchParts.add('(Retailer__r.DBA__c LIKE :searchTerm)');
                whereSearchParts.add('(Retailer__r.Name LIKE :searchTerm)');
                whereSearchParts.add('(Status__c LIKE :searchTerm)');
                System.debug('##createdDate::'+createdDate);
                if(createdDate != null){
                    whereSearchParts.add('(Request_Ship_Date__c >= :createdDate AND Request_Ship_Date__c <= :createdDate)');
                }
            }
        }
        
        if(!whereSearchParts.isEmpty()){
            queryStr += ' AND ('+ String.escapeSingleQuotes(String.join(whereSearchParts, ' OR '))+')';
        }
        system.debug('##orderBy : '+orderBy);
        if(orderByField != 'Request_Ship_Date__c'){
            queryStr+= ' ORDER BY ' + String.escapeSingleQuotes(orderBy) +' NULLS LAST';
        }
        system.debug('getIdsQuery '+queryStr);
        for(Order__c o :Database.query(queryStr)){
            ids.add(o.Id);
        }
        r.data.put('ids', ids);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getRetailDeliveryTickets(List<String> ids, Map<String, Object> filters){
        AuraResponse r = new AuraResponse('RetailDeliveryTicketsCtlr.getRetailDeliveryTickets()');
        
        String orderByField = ORDERBY_NAME;
        String direction = ASC_DIRECTION;
        String orderBy = '';
        List<String> families = new List<String>();
        List<String> whereSearchParts = new List<String>();
        
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(ProductsCtlr.hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        
        string queryStr = 'SELECT Id,Name,isPreapproved__c,Requested_Delivery_Earliest_Time__c,Requested_Delivery_Latest_Time__c,Account__c,Invoice_Memo__c,Account__r.Name,Sample_Order__c, Order_Date__c,Piggyback_sample__c,Site__c,Site__r.Warehouse_Name__c,Transporter__r.License_Number__c,Transporter__r.License_Name__r.DBA__c, Total__c,Sales_Person__c,Sales_Person__r.Name, Status__c,Route_Miles__c,Payment_Terms__c,Retailer__c,Retailer__r.Name,Retailer__r.dBA__c,Retailer_Contact__c,Additional_Brand_Contact__c,Additional_Brand_Contact__r.Name,Retailer_Contact__r.Name,Request_Ship_Date__c,Retailer_PO__c,Special_Instructions__c,State_License__c,State_License__r.Name,State_License__r.License_Number__c,Total_Line_Items__c, Shipping_Street__c, Shipping_Country__c, Shipping_Province__c, Shipping_City__c, Shipping_Zip__c,Exclude_Excise_Tax__c,Total_Local_Tax__c,Order_Booking_Fee__c,Service_Booking_Fee__c,Service_Scheduling_Fee__c,Service_Staging_Fee__c,Pack_Out_Fee__c,Stage_Manifest_Fee__c,Schedule_Dispatch_Fee__c,Total_Milage_Fee__c,Total_Weight_Fee__c,Factoring_Assignee__c,Factoring_Assignee__r.DBA__c,Factoring_Contact__c,Factoring_Contact__r.Name,Factoring_Terms__c, Total_Excise_Tax_Amount__c ,Factoring_Rate__c,Factoring_Discount__c , (SELECT Quantity_Cases__c, UnitPrice__c, Line_Total_Cost__c, Unit_Excise_Tax__c, Line_Total_Excise_Tax__c, Line_Total_Qty__c, MOQ__c, Total__c, Is_Sample__c, Price_Book_Entry_Id__c, Product__c, Product__r.Name, Product__r.Image_URL__c,Product__r.Description, Product__r.Producer_Name__r.Name,Product__r.Product_Details__c, Product__r.Family, Product__r.Product_Rating__c, Product__r.Available_Inventory__c,Product__r.Available_Qty__c,Is_Brand_Product__c,Special_Instructions__c, Subtotal_Local_Cannabis_Tax__c,Product__r.Apply_Excise_Tax__c,Pick_Pack_Fee__c,QA_Review_Fee__c,Total_Weight_lbs__c,Product__r.Is_Sample__c,Product__r.Product_Short_Description__c,Product__r.Max_Order_Allowed__c,Product__r.RecordType.Name,Product__r.Parent_Product__c,IsPromo__c FROM Order_Line_Items__r),(SELECT Id,Contact__c,Contact__r.Name,Type__c FROM Retailer_Related_Contacts__r) FROM Order__c WHERE Retailer__c != null AND Account__c = :brandId AND Id IN :ids';
        r.data.put('Order_Delete_Confirm_Message',Order_Delete_Confirm_Message);
        r.data.put('Order_Recall_Confirm_Message',Order_Recall_Confirm_Message);
        r.data.put('Transfer_Order_Recall_Confirm_Message',Transfer_Order_Recall_Confirm_Message);
        r.data.put('Order_Deleted_Message',Order_Deleted_Message);
        r.data.put('Transfer_Order_Delete_Confirm_Message',Transfer_Order_Delete_Confirm_Message);
        r.data.put('Transfer_Order_Deleted_Message',Transfer_Order_Deleted_Message);
        if(hasFilter(filters, STATUS_FILTER)){
            String STStatus = String.valueOf(filters.get(STATUS_FILTER));
            if(STStatus != ORDER_ALL){
                if(STStatus == ORDER_CANCELLED){
                    Set<String> cancelledStatus = new Set<String>{ORDERCANCELLED_CUSTOMER,ORDERCANCELLED_FILIGREEN};
                    queryStr += ' AND Status__c IN :cancelledStatus';
                } else if(STStatus == STATUS_IN_PROGRESS){
                    STStatus = STATUS_IN_PROCESSING;
                    queryStr += ' AND Status__c = :STStatus';
                } else if(STStatus == STATUS_COMPLETED){
                    STStatus = Order_Status_Delivered;
                    queryStr += ' AND Status__c = :STStatus';
                } else {
                    queryStr += ' AND Status__c = :STStatus';
                }
            }
        }
        
        String searchTerm = '';
        Date createdDate = null;
        
        if(hasFilter(filters, SEARCHTERM_FILTER)){
            searchTerm = String.valueOf(filters.get(SEARCHTERM_FILTER));
            if(String.isNotBlank(searchTerm)){
                if(searchTerm.indexOf('/') != -1){
                    try{
                        createdDate = Date.parse(searchTerm);
                    }catch(Exception e){
                        
                    }
                }
                searchTerm = '%' + searchTerm + '%';
                whereSearchParts.add('(Name LIKE :searchTerm)');
                whereSearchParts.add('(Retailer__r.dBA__c LIKE :searchTerm)');
                whereSearchParts.add('(Retailer__r.Name LIKE :searchTerm)');
                whereSearchParts.add('(Status__c LIKE :searchTerm)');
                System.debug('##createdDate::'+createdDate);
                if(createdDate != null){
                    whereSearchParts.add('(Request_Ship_Date__c >= :createdDate AND Request_Ship_Date__c <= :createdDate)');
                }
            }
        }
        
        if(!whereSearchParts.isEmpty()){
            queryStr += ' AND ('+ String.escapeSingleQuotes(String.join(whereSearchParts, ' OR '))+')';
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        if(orderByField != 'Request_Ship_Date__c'){
            queryStr+= ' ORDER BY ' + String.escapeSingleQuotes(orderBy) +' NULLS LAST';
        }
        List<RetailDeliveryTicket> retailDeliveryTickets = new List<RetailDeliveryTicket>();
        system.debug('queryStr '+queryStr);
        Set<Id> ordersId = new Set<Id>();
        for(Order__c o :Database.query(queryStr)){
            ordersId.add(o.Id);
            retailDeliveryTickets.add(new RetailDeliveryTicket(o));
        }
            
        Map<Id,Date> mapDeliveryDate = new Map<Id,Date>();
        for(Opportunity opt : [select id,Order__c,(select id,Ship_Confirmation_Date__c from Quotes__r order by createddate desc) from Opportunity where Order__c IN :ordersId order by createddate desc]){
            if(opt.Quotes__r.size() > 0){
                mapDeliveryDate.put(opt.Order__c,opt.Quotes__r[0].Ship_Confirmation_Date__c);
            } 
        }
        
        for(RetailDeliveryTicket rdt : retailDeliveryTickets){
            if(mapDeliveryDate.containsKey(rdt.id)){
               rdt.deliveredDate = mapDeliveryDate.get(rdt.id); 
            }
        }
        system.debug('##orderByField 11 : '+orderByField);
        if(orderByField == 'Request_Ship_Date__c'){
            if(direction == ASC_DIRECTION){
                retailDeliveryTickets.sort();
                r.data.put('retailDeliveryTickets', retailDeliveryTickets);
            }else{
                List<RetailDeliveryTicket> rdtList = new List<RetailDeliveryTicket>();
                for(integer i=retailDeliveryTickets.size()-1; i>=0;i--){
                    rdtList.add(retailDeliveryTickets[i]);
                }
                r.data.put('retailDeliveryTickets', rdtList);
            }
        }else{
            r.data.put('retailDeliveryTickets', retailDeliveryTickets);
        }
        
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse saveRetailDeliveryTicket(String recordId, String retailDeliveryTicketData, String retailDeliveryTicketLineItemsData,String salesRep,String addBrandContact,String addRetailContact,Boolean fromTransferOrders,String draftStatus/*,Boolean brandMov,Boolean retailerMov*/){
        system.debug('retailDeliveryTicketData '+retailDeliveryTicketData);
        AuraResponse r = new AuraResponse('RetailDeliveryTicketsCtlr.saveRetailDeliveryTicket()');
        String[] addRetailContactIds = addRetailContact.split(',');
        String[] addBrandContactIds = addBrandContact.split(',');
        //String[] salesRepIds = salesRep.split(',');
        RetailDeliveryTicket rdt = (RetailDeliveryTicket)JSON.deserialize(retailDeliveryTicketData, RetailDeliveryTicket.class);
        List<RetailDeliveryTicketLineItem> rdtlis = (List<RetailDeliveryTicketLineItem>)JSON.deserialize(retailDeliveryTicketLineItemsData, List<RetailDeliveryTicketLineItem>.class);
        system.debug('rdtlis '+rdtlis);
        System.debug('RetailDeliveryTicket = '+retailDeliveryTicketData);
        System.debug('RetailDeliveryTicketLineItem = '+retailDeliveryTicketLineItemsData);
        
         Boolean isError = false;
        String Sample_Limitation_Error = '';
        Map<String,Decimal> countOdrByFamilyMap = new Map<String,Decimal>();
        
        Set<Id> selectedProductIds = new Set<Id>(); 
        for(RetailDeliveryTicketLineItem rdtli: rdtlis){
            if(String.isNotBlank(rdtli.Product)){
                selectedProductIds.add(rdtli.Product);
            }
            
            if(rdtli.isSample && SampleOrderFamilyMap != NULL && SampleOrderFamilyMap.containsKey(rdtli.productFamily)){
                Sample_Order_Family_Config__mdt SampleOrderFamilyDetail = SampleOrderFamilyMap.get(rdtli.productFamily);
                if(countOdrByFamilyMap.containsKey(SampleOrderFamilyDetail.Parent_Family__c)){
                    Decimal countOdrFamily = countOdrByFamilyMap.get(SampleOrderFamilyDetail.Parent_Family__c) + 1;
                    countOdrByFamilyMap.put(SampleOrderFamilyDetail.Parent_Family__c , countOdrFamily);
                }else{
                    countOdrByFamilyMap.put(SampleOrderFamilyDetail.Parent_Family__c,1);
                }
                system.debug('###SampleOrderFamilyDetail : '+countOdrByFamilyMap.get(SampleOrderFamilyDetail.Parent_Family__c) +' > '+ SampleOrderParentFamilyMap.get(SampleOrderFamilyDetail.Parent_Family__c));
                if(countOdrByFamilyMap.get(SampleOrderFamilyDetail.Parent_Family__c) > SampleOrderParentFamilyMap.get(SampleOrderFamilyDetail.Parent_Family__c)){
                    Sample_Limitation_Error = Sample_Limitation_Error_Msg.replace('{0}', SampleOrderFamilyDetail.Parent_Family__c);
                    Sample_Limitation_Error = Sample_Limitation_Error.replace('{1}',''+SampleOrderParentFamilyMap.get(SampleOrderFamilyDetail.Parent_Family__c));
                    isError = true;
                }
            }
            
        }
        
         if(isError){
            r.data.put('isError',isError);
            r.errors.add(Sample_Limitation_Error);
        }
        Line_Card__c[] lcs = [SELECT Community_Price_Book__c FROM Line_Card__c WHERE Brand_Name__c = :brandId AND Retailer_Name__c =: rdt.retailer];
        if(!lcs.isEmpty()){
            Map<String, Product> records = new Map<String, Product>();
            Map<String, Product[]> procuderProducts = new Map<String, Product[]>();
            for(PricebookEntry pbe: [SELECT Id, Product2.White_Labelled__c,Product2.Licensee_Name__c,Product2.Licensee_Name__r.Name, Product2.Product_Short_Description__c,Product2.Image_URL__c,Product2.Is_Sample__c,Product2.Brand_Name__c,Product2.Apply_Excise_Tax__c,Product2.Parent_Product__c,Product2.RecordType.Name,Product2.Case_Shipping_Weight_lbs__c,Product2.Unit_Shipping_Weight_lbs__c,Product2.Name,Product2.Description,Product2.Family,Product2.Producer_Name__c ,Product2.Producer_Name__r.Name , UnitPrice,Product2.Available_Inventory__c,Product2.Available_Qty__c,Product2.MOQ__c,Product2.Max_Order_Allowed__c FROM PricebookEntry WHERE Product2.Hide_From_Marketplace__c = false AND ((Product2.Producer_Name__c = :brandId AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c = :brandId AND Product2.White_Labelled__c = true) ) AND PriceBook2Id = :lcs[0].Community_Price_Book__c AND Product2Id IN : selectedProductIds]){
                Product p = new Product(pbe);
                records.put(pbe.Product2Id, p);
                if(procuderProducts.containsKey(pbe.Product2.Producer_Name__c)){
                    procuderProducts.get(pbe.Product2.Producer_Name__c).add(p);
                }else{
                    procuderProducts.put(pbe.Product2.Producer_Name__c,new Product[]{p});
                }
            }
            for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Brand__c IN: procuderProducts.keySet() AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now()]){
                Product[] products = procuderProducts.get(bd.Brand__c);
                if(products != null){
                    for(Product p: products){
                        p.setDiscountPercent(bd.Discount_Percentage__c);
                    }
                }
            }
            for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Product_Name__c IN: records.keySet() AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now()]){
                Product p = records.get(bd.Product_Name__c);
                if(p != null){
                    if(p.discountPercent != null){
                        p.setProductDiscountPercent(bd.Discount_Percentage__c);
                    }else{
                        p.setDiscountPercent(bd.Discount_Percentage__c);
                    }
                    
                }
            }
            /*for(RetailDeliveryTicketLineItem rdtli: rdtlis){
                if(String.isNotBlank(rdtli.Product)){
                    Product p = records.get(rdtli.Product);
                    if(p != null){
                        if(rdtli.isSample == true){
                        	rdtli.salesPrice = 0.01;    
                        } else if(rdtli.originalSalesPrice == rdtli.salesPrice){
                            
                            rdtli.salesPrice = p.discount >0?p.salePrice: p.price.unitPrice;
                        }
                        rdtli.ProductBookEntryId = p.price.id;
                    }
                    
                }
            }*/
        }
        if(rdtlis.isEmpty()){
            if(fromTransferOrders)
            	r.errors.add(ERR_MSG_ADD_ONE_OTS);
            else
            	r.errors.add(ERR_MSG_ADD_ONE_OLI);
        }
        
        Map<String, Product> recordProductMap = new Map<String, Product>();
        for(PricebookEntry pbe: [SELECT Id,Product2.White_Labelled__c,Product2.Licensee_Name__c,Product2.Licensee_Name__r.Name,  Product2.Product_Short_Description__c,Product2.Image_URL__c,Product2.Is_Sample__c,Product2.Brand_Name__c,Product2.Apply_Excise_Tax__c,Product2.Parent_Product__c,Product2.RecordType.Name,Product2.Case_Shipping_Weight_lbs__c,Product2.Unit_Shipping_Weight_lbs__c,Product2.Name,Product2.Description,Product2.Family,Product2.Producer_Name__c ,Product2.Producer_Name__r.Name, UnitPrice,Product2.Available_Inventory__c,Product2.Available_Qty__c,Product2.MOQ__c,Product2.Max_Order_Allowed__c FROM PricebookEntry WHERE Product2Id IN : selectedProductIds ]){
        	Product p = new Product(pbe);
            recordProductMap.put(pbe.Product2Id, p);
        }
        
        for(RetailDeliveryTicketLineItem rdtli: rdtlis){
            if(String.isNotBlank(rdtli.Product)){
                Product p = recordProductMap.get(rdtli.Product);
                Decimal availableQty = p.availableQty != null ? p.availableQty : 0;
                Decimal totalInventory = (p.availableQty / p.MOQ);
                if(rdtli.orderQty > totalInventory.setScale(4, System.roundingMode.HALF_UP) && rdtli.isDiscountProduct == false){
                    r.errors.add(ERR_MSG_ORDER_QTY_GT_AVAILABLE_QTY);
                    break;
                }
         	}
        }
        
        r.handleErrors();
        
        Savepoint sp = Database.setSavepoint();
        try{
            Retailer_Related_Contact__c  [] relatedContacts = new Retailer_Related_Contact__c []{};

            Id rdtRecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get(ORDER_RECORD_TYPE_NAME_BRAND).getRecordTypeId();
            Id transferRecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get(ORDER_RECORD_TYPE_NAME_TRANSFER).getRecordTypeId();
            Order__c  odr = new Order__c(Id = (String.isBlank(recordId)? null: recordId));
            if(fromTransferOrders){
                odr.Order_Type__c = ORDER_RECORD_TYPE_NAME_TRANSFER;
            	odr.RecordTypeId = transferRecordTypeId; 
                odr.Exclude_Excise_Tax__c = true;
            }else{
                odr.Order_Type__c = ORDER_RECORD_TYPE_NAME_BRAND;
            	odr.RecordTypeId = rdtRecordTypeId; 
                odr.Exclude_Excise_Tax__c = rdt.excludeExciseTax;
            }      
            
            odr.Retailer__c = rdt.retailer;
            odr.Customer__c = UserInfo.getUserId();
            odr.Retailer_Contact__c = rdt.retailerContact.trim().split(',')[0];
            odr.Payment_Terms__c = rdt.paymentTerms;
            odr.Retailer_PO__c = rdt.retailerPO;
            odr.Request_Ship_Date__c = rdt.requestShipDate;
            odr.Special_Instructions__c = rdt.specialDeliveryInstructions;
            odr.State_License__c = rdt.stateLicense;
            odr.Order_Date__c = System.now();
            odr.Account__c = brandId;
            odr.Additional_Brand_Contact__c = rdt.Additional_Brand_Contact;
            odr.Route_Miles__c = rdt.Route_Miles;
            system.debug('rdt.orderBookingFee'+rdt.orderBookingFee);
            odr.Order_Booking_Fee__c = rdt.orderBookingFee;
            odr.Pack_Out_Fee__c = rdt.packOutFee;
            odr.Transporter__c = String.isBlank(rdt.transportLicenseId)? null : rdt.transportLicenseId;                                                      
            odr.Stage_Manifest_Fee__c = rdt.stageManifestFee;
            odr.Schedule_Dispatch_Fee__c = rdt.scheduleDispatchFee;
            odr.Total_Milage_Fee__c = rdt.totalMileageFee;
            odr.Total_Weight_Fee__c = rdt.totalWeightFee;
            odr.Status__c =  draftStatus; //(rdt.isPreapproved && draftStatus == STATUS_PENDING ) ? STATUS_APPROVED:
            odr.Service_Booking_Fee__c = rdt.serviceBookingFee;
            odr.Service_Scheduling_Fee__c = rdt.serviceSchedulingFee;
            odr.Service_Staging_Fee__c  = rdt.serviceStagingFee;
            odr.Sample_Order__c = rdt.isSample;
            odr.isPreapproved__c = rdt.isPreapproved;
            if(rdt.EarTime != NULL && rdt.EarTime != '' && rdt.isPreapproved ){
                	String[] eTimeWithSpace = rdt.EarTime.split(' ');
                    String[] eTime = eTimeWithSpace[0].split(':');
               		odr.Requested_Delivery_Earliest_Time__c = Time.newInstance((eTimeWithSpace[1].equalsIgnoreCase('pm') && Integer.valueOf(eTime[0]) != 12 ?(Integer.valueOf(eTime[0])+12):Integer.valueOf(eTime[0])),Integer.valueOf(eTime[1]), 0, 0); 
                    
            }else{
                odr.Requested_Delivery_Earliest_Time__c = null;
            }
            if(rdt.LatTime != NULL && rdt.LatTime != '' && rdt.isPreapproved ){
                String[] lTimeWithSpace = rdt.LatTime.split(' ');
                    String[] lTime = lTimeWithSpace[0].split(':');
                odr.Requested_Delivery_Latest_Time__c = Time.newInstance((lTimeWithSpace[1].equalsIgnoreCase('pm') && Integer.valueOf(lTime[0]) != 12?(Integer.valueOf(lTime[0])+12):Integer.valueOf(lTime[0])),Integer.valueOf(lTime[1]), 0, 0); 
                    //odr.Requested_Delivery_Latest_Time__c = Time.newInstance(Integer.valueOf(lTime[0]), Integer.valueOf(lTime[1]), 0, 0);
            }else{
                odr.Requested_Delivery_Latest_Time__c = null;
            }
            odr.Invoice_Memo__c = rdt.invoiceMemo;
            if(String.isNotBlank(rdt.factoringAssigneeId)){
            	odr.Factoring_Assignee__c = rdt.factoringAssigneeId;
            	odr.Factoring_Contact__c = rdt.factoringContactId;
                odr.Factoring_Terms__c = rdt.factoringTerms;
                odr.Factoring_Rate__c = rdt.factoringRate;
                odr.Factoring_Discount__c = rdt.factoringDiscount;
            }else{
                odr.Factoring_Contact__c = NULL;
                odr.Factoring_Assignee__c = NULL;
                odr.Factoring_Rate__c = 0;
                odr.Factoring_Terms__c = NULL;
                odr.Factoring_Discount__c = 0;
            }
            if(rdt.siteId != '' && rdt.siteId != null){
                odr.Site__c = rdt.siteId;
            }
            
           
            if(!fromTransferOrders && String.isNotBlank(rdt.factoringAssigneeId) && factoringRelationships.size() > 0){
                Map<Id,Factoring_Relationship__c> factoringRelationshipsMap = new Map<Id,Factoring_Relationship__c>();
                for(Factoring_Relationship__c FR: factoringRelationships){
                    if(rdt.retailer == FR.Buyer_Account__c)
                    	factoringRelationshipsMap.put(FR.Factoring_Assignee__c,FR);
                }
                System.debug('###Factoring AssigneeId::'+rdt.factoringAssigneeId);
                System.debug('###FA Keys :'+factoringRelationshipsMap.keySet());
                System.debug('###Contains FA:'+factoringRelationshipsMap.containsKey(rdt.factoringAssigneeId));
                System.debug('@@@Order Payment Terms:'+odr.Payment_Terms__c);
                if(factoringRelationshipsMap.containsKey(rdt.factoringAssigneeId)){
                    Factoring_Relationship__c FR = factoringRelationshipsMap.get(rdt.factoringAssigneeId);
                    System.debug('$$$FR Rates:'+FR.Factoring_Rates__r);
                    if(FR != NULL && FR.Factoring_Rates__r.size() > 0){
                        for(Factoring_Rate__c rate: FR.Factoring_Rates__r){
                            System.debug('@@@FR Payment Terms:'+rate.Payment_Terms__c);
                            if(odr.Payment_Terms__c == rate.Payment_Terms__c){
                                //odr.Factoring_Rate__c = rate.Factoring_Rate__c;
                            }
                        }
                    }
                }
            }

            if(salesRep != null && salesRep != ''){
                System.debug('##Sales Rep::'+salesRep.removeEnd(','));
            	odr.Sales_Person__c = salesRep.removeEnd(',');    
            }
            if(odr.State_License__c != null){
                State_Licenses__c  address = [SELECT Id, License_Address__c, License_City__c, License_State__c, License_Country__c, License_Zip__c FROM State_Licenses__c  WHERE Id =: odr.State_License__c];
                odr.Shipping_Street__c = address.License_Address__c;
                odr.Shipping_City__c = address.License_City__c;
                odr.Shipping_Province__c = address.License_State__c;
                odr.Shipping_Country__c = address.License_Country__c;
                odr.Shipping_Zip__c = address.License_Zip__c;
                
            }
            System.debug('##odr.Id:'+odr.Id);
            system.debug('odr.Order_Booking_Fee__c '+odr.Order_Booking_Fee__c);
            upsert odr;
            
            Integer count = 0;
            /*for(String conId: salesRepIds){
                if(conId != null && conId.trim() != ''){
                    if(count == 0){
                        odr.Sales_Person__c = conId.trim();
                        count++;
                    } else {
                        relatedContacts.add(new Retailer_Related_Contact__c(Contact__c = conId.trim(),Order__c = odr.Id,Type__c = TYPE_ADD_BRAND_CONTACT));
                    }
                }   
            }*/
            if(count > 0){
                update odr;
            }
            
            system.debug('odr.Order_Booking_Fee__c ll '+[select id,Order_Booking_Fee__c from order__c where id=:odr.id].Order_Booking_Fee__c);
            delete [SELECT Id FROM Retailer_Related_Contact__c WHERE Order__c = :odr.Id];
            
            for(String conId: addRetailContactIds){
                system.debug('conId '+conId.trim());
                if(conId != null && conId.trim() != '' && rdt.retailerContact.trim().split(',')[0] != conId )
            		relatedContacts.add(new Retailer_Related_Contact__c(Contact__c = conId.trim(),Order__c = odr.Id,Type__c = TYPE_ADD_RETAIL_CONTACT));
            }
            for(String conId: addBrandContactIds){
                if(conId != null && conId.trim() != '')
                    relatedContacts.add(new Retailer_Related_Contact__c(Contact__c = conId.trim(),Order__c = odr.Id,Type__c = TYPE_ADD_BRAND_CONTACT));
            }
            
            insert relatedContacts;
            Set<Id> productIds = new Set<Id>();
            for(RetailDeliveryTicketLineItem rdtli: rdtlis){
                if(String.isNotBlank(rdtli.Product)){
                    productIds.add(rdtli.Product);
                }
            }
            Map<Id,Product2> productsMap = new Map<Id,Product2>([SELECT Name, MOQ__c, Available_Inventory__c,White_Labelled__c ,Producer_Name__c , Licensee_Name__c FROM Product2 WHERE Id IN :productIds]);
            
            List<Order_Line_Item__c> orderLineItems = new List<Order_Line_Item__c>();
            
            /*if(brandMov){
                for(PricebookEntry pbe: [SELECT Id, Product2.Name,Product2.Description,Product2.Family,Product2.Producer_Name__c , UnitPrice,Product2.Available_Inventory__c,Product2.Available_Qty__c,Product2.MOQ__c FROM PricebookEntry WHERE Product2.Producer_Name__c =: rdt.retailer and Product2.recordType.developerName = 'Discount' and Product2.Name = 'Brand MOV Fee']){
                    Product p = new Product(pbe);
                    String ownerId = '';
                    if(String.isNotBlank(p.id)){
                        Product2 pro = productsMap.get(p.id);
                        if(pro.White_Labelled__c){
                            ownerId = pro.Licensee_Name__c;
                        }else{
                            ownerId = pro.Producer_Name__c;
                        }
                    }
                    
                    Order_Line_Item__c oli = new Order_Line_Item__c(Id = null,
                                                                    Order__c = odr.Id,
                                                                    Price_Book_Entry_Id__c = p.price.Id,
                                                                    Product__c = p.id,
                                                                    Quantity_Cases__c = p.quantity,
                                                                    MOQ__c = p.MOQ,
                                                                    Ownership_Code__c  = ownerId,
                                                                    UnitPrice__c = pbe.UnitPrice,
                                                                    Special_Instructions__c = null,
                                                                    Is_Sample__c = False);
                    orderLineItems.add(oli);
                }
            }
            if(retailerMov){
                for(PricebookEntry pbe: [SELECT Id, Product2.Name,Product2.Description,Product2.Family,Product2.Producer_Name__c , UnitPrice,Product2.Available_Inventory__c,Product2.Available_Qty__c,Product2.MOQ__c FROM PricebookEntry WHERE Product2.Producer_Name__c =: rdt.retailer and Product2.recordType.developerName = 'Discount' and Product2.Name = 'Retailer MOV Fee']){
                    Product p = new Product(pbe);
                    String ownerId = '';
                    if(String.isNotBlank(p.id)){
                        Product2 pro = productsMap.get(p.id);
                        if(pro.White_Labelled__c){
                            ownerId = pro.Licensee_Name__c;
                        }else{
                            ownerId = pro.Producer_Name__c;
                        }
                    }
                    
                    Order_Line_Item__c oli = new Order_Line_Item__c(Id = null,
                                                                    Order__c = odr.Id,
                                                                    Price_Book_Entry_Id__c = p.price.Id,
                                                                    Product__c = p.id,
                                                                    Quantity_Cases__c = p.quantity,
                                                                    MOQ__c = p.MOQ,
                                                                    Ownership_Code__c  = ownerId,
                                                                    UnitPrice__c = pbe.UnitPrice,
                                                                    Special_Instructions__c = null,
                                                                    Is_Sample__c = False);
                    orderLineItems.add(oli);
                }
            }*/
            String retailerPBId = priceBookId;
            for(Line_Card__c lc: [SELECT Retailer_Name__c,Community_Price_Book__c  FROM Line_Card__c WHERE Retailer_Name__r.Hide_From_Marketplace__c = false AND Retailer_Name__c =: odr.Retailer__c  AND Brand_Name__c = :brandId ORDER BY Retailer_DBA__c]){
                retailerPBId = lc.Community_Price_Book__c;
            }
            Map<String,String> productPBMap = new Map<String,String>();
            for(PriceBookEntry pbe: [SELECT Id, Product2Id FROM PriceBookEntry WHERE PriceBook2Id = :retailerPBId ]){
                productPBMap.put(pbe.Product2Id,pbe.Id);
            }
            Map<String,String> productStandardPBMap = new Map<String,String>();
            for(PriceBookEntry pbe: [SELECT Id, Product2Id FROM PriceBookEntry WHERE PriceBook2Id = :priceBookId ]){
                productStandardPBMap.put(pbe.Product2Id,pbe.Id);
            }
            for(RetailDeliveryTicketLineItem rdtli: rdtlis){
                String ownerId = '';
                if(String.isNotBlank(rdtli.Product)){
                    Product2 p = productsMap.get(rdtli.Product);
                    decimal moq = p.MOQ__c;
                    Decimal totalQuantity = rdtli.orderQty;
                    if(p.White_Labelled__c){
                        ownerId = p.Licensee_Name__c;
                    }else{
                        ownerId = p.Producer_Name__c;
                    }
                }
                system.debug('rdtli.orderQty '+rdtli.orderQty);
                system.debug('rdtli.isPromo '+rdtli.isPromo);
                
                Order_Line_Item__c oli = new Order_Line_Item__c(Id = (String.isBlank(rdtli.id)? null: rdtli.id),
                                                                Order__c = odr.Id,
                                                                Price_Book_Entry_Id__c = (productPBMap.get(rdtli.Product) != NULL?productPBMap.get(rdtli.Product):productStandardPBMap.get(rdtli.Product)),//rdtli.ProductBookEntryId,
                                                                Product__c = rdtli.Product,
                                                                Quantity_Cases__c = rdtli.orderQty,
                                                                MOQ__c = rdtli.MOQ,
                                                                Pick_Pack_Fee__c = rdtli.pickPackFee,
                                                                QA_Review_Fee__c = rdtli.QAReviewFee,
                                                                Total_Weight_lbs__c = rdtli.totalWeight,
                                                                Ownership_Code__c  = ownerId,
                                                                Special_Instructions__c = rdtli.specialInstructions,
                                                                IsPromo__c = rdtli.isPromo == null ? false : rdtli.isPromo,
                                                                Is_Sample__c = rdtli.isSample == null ? False : rdtli.isSample);
                if(rdtli.isDiscountProduct == true)
                    oli.UnitPrice__c = rdtli.salesPrice * -1;
                else
                    oli.UnitPrice__c = rdtli.salesPrice;
                if(fromTransferOrders){
                    Id transferOrderLineRecordTypeId = Schema.SObjectType.Order_Line_Item__c.getRecordTypeInfosByName().get(OLI_RECORD_TYPE_NAME_TRANSFER).getRecordTypeId();
                	oli.RecordTypeId = transferOrderLineRecordTypeId;    
                }
               
                orderLineItems.add(oli);
                
            }
            r.handleErrors();
            try{
                upsert orderLineItems;
                List<Order_Line_Item__c> deleteROTs = new List<Order_Line_Item__c>([SELECT Id FROM Order_Line_Item__c WHERE Order__c = :odr.Id AND Id NOT IN :orderLineItems]);
                if(!deleteROTs.isEmpty()){
                    delete deleteROTs;
                }
                /*//Send Order details in Email
Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
// Who you are sending the email to

mail.setTargetObjectId(odr.Retailer_Contact__c);
// The email template ID used for the email
EmailTemplate template = [Select id from EmailTemplate where Name = 'SendRetailerOrderDetailsToRetailerContact' LIMIT 1];
mail.setTemplateId(template.Id);
System.debug('###odr.Id::'+odr.Id);
mail.setWhatId(odr.Id);
mail.setSaveAsActivity(false);
Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });*/
                if(Cache.Session.contains(ProductsCtlr.cacheKey))
                    Cache.Session.remove(ProductsCtlr.cacheKey);
            }catch(Exception e){
                r.handleException(e);
            }
            /*Retail_Delivery_Ticket__c retailDeliveryTicket = new Retail_Delivery_Ticket__c(Id = (String.isBlank(recordId)? null: recordId));
upsert retailDeliveryTicket;*/
            
            /*List<Retail_Delivery_Ticket_Line_Item__c> retailDeliveryTicketLineItems = new List<Retail_Delivery_Ticket_Line_Item__c>();
for(RetailDeliveryTicketLineItem rdtli: rdtlis){
retailDeliveryTicketLineItems.add(new Retail_Delivery_Ticket_Line_Item__c(Id = (String.isBlank(rdtli.id)? null: rdtli.id)));
}
upsert retailDeliveryTicketLineItems;

List<Retail_Delivery_Ticket_Line_Item__c> deleteRDTLIs = new List<Retail_Delivery_Ticket_Line_Item__c>([SELECT Id FROM Retail_Delivery_Ticket_Line_Item__c WHERE Retail_Delivery_Ticket__c = :retailDeliveryTicket.Id AND Id NOT IN :retailDeliveryTicketLineItems]);
if(!deleteRDTLIs.isEmpty()){
delete deleteRDTLIs;
}*/
        }catch(DmlException e){
            Database.rollback(sp);
            r.handleException(e);
        }
        
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse removeProduct(String productId){
        AuraResponse r = new AuraResponse('RetailDeliveryTicketsCtlr.removeProduct()');
        
        Map<String, Object> brandRetailDeliveryOrderItems = new Map<String, Object>();
        if(Cache.Session.contains(ProductsCtlr.cacheKey)){
            brandRetailDeliveryOrderItems = (Map<String, Object>)Cache.Session.get(ProductsCtlr.cacheKey);
           
            if(brandRetailDeliveryOrderItems.containsKey(productId)){
                brandRetailDeliveryOrderItems.remove(productId);
            }
        }
        Cache.Session.put(ProductsCtlr.cacheKey, brandRetailDeliveryOrderItems);
        
        return ProductsCtlr.getCartItems();
    }
    
    private static Boolean hasFilter(Map<String, Object> filters, String key){
        return filters.containsKey(key) && String.isNotBlank(String.valueOf(filters.get(key)));
    }
    
    @AuraEnabled
    public static AuraResponse removeProducts(){
        AuraResponse r = new AuraResponse('RetailDeliveryTicketsCtlr.removeProducts()');
        
        if(Cache.Session.contains(ProductsCtlr.cacheKey)){
            Cache.Session.remove(ProductsCtlr.cacheKey);
        }
        return r;
    }
    
    public class WarehouseAvailableInventory implements Comparable{
        @AuraEnabled
        public String id{get;set;}
        @AuraEnabled
        public String name{get;set;}
        @AuraEnabled
        public Decimal availableInventory{get;set;}
        @AuraEnabled
        public Decimal sortOrder{get;set;}
        public Integer compareTo(Object compareTo) {
            // Cast argument to OpportunityWrapper
            WarehouseAvailableInventory compareToOppy = (WarehouseAvailableInventory)compareTo;
            
            // The return value of 0 indicates that both elements are equal.
            Integer returnValue = 0;
            if (sortOrder > compareToOppy.sortOrder) {
                // Set return value to a positive value.
                returnValue = 1;
            } else if (sortOrder < compareToOppy.sortOrder) {
                // Set return value to a negative value.
                returnValue = -1;
            } else if ((sortOrder == null) && (compareToOppy.sortOrder != null)){
                // nulls-first implementation
                returnValue = -1;
            } else if ((sortOrder != null) && (compareToOppy.sortOrder == null)){
                // nulls-first implementation
                returnValue = 1;
            }        
            return returnValue;     
        }
    }
    public class BrandProduct{
        @AuraEnabled
        public String id{get;set;}
        @AuraEnabled
        public String name{get;set;}
        
        public BrandProduct(Product2 p){
            id = p.Id;
            name = p.Name;
        }
    }
    
    public class BrandContact{
        @AuraEnabled
        public String id{get;set;}
        @AuraEnabled
        public String name{get;set;}
        
        public BrandContact(Contact c){
            id = c.Id;
            name = c.Name;
        }
    }
    
    public class RetailDeliveryTicket implements Comparable{
        @AuraEnabled
        public String id{set;get;}
        @AuraEnabled
        public String name{set;get;}
        @AuraEnabled
        public String paymentTerms{set;get;}
        @AuraEnabled
        public Date requestShipDate{set;get;}
        @AuraEnabled
        public String retailer{set;get;}
        @AuraEnabled
        public String retailerName{set;get;}
        @AuraEnabled
        public String retailerDBA{set;get;}
        @AuraEnabled
        public String retailerLogoURL{get;set;}
        @AuraEnabled
        public String retailerContact{set;get;}
        @AuraEnabled
        public String retailerContactName{set;get;}
        @AuraEnabled
        public String retailerPO{set;get;}
        @AuraEnabled
        public String specialDeliveryInstructions{set;get;}
        @AuraEnabled
        public String stateLicense{set;get;}
        @AuraEnabled
        public String stateLicenseName{set;get;}
        @AuraEnabled
        public String stateLicenseNumber{set;get;}
        @AuraEnabled
        public String stateLicenseAddress{set;get;}
        @AuraEnabled
        public Double totalLineItems{get;set;}
        @AuraEnabled
        public Double totalLocalTax{get;set;}
        @AuraEnabled
        public String street{get;set;}
        @AuraEnabled
        public String country{get;set;}
        @AuraEnabled
        public String province{get;set;}
        @AuraEnabled
        public String city{get;set;}
        @AuraEnabled
        public String postalCode{get;set;}
        @AuraEnabled
        public Decimal total{get;set;}
        @AuraEnabled
        public String status{get;set;}
        @AuraEnabled
        public String state{get;set;}
        @AuraEnabled
        public Date submittedDate{get;set;}
        @AuraEnabled
        public Boolean excludeExciseTax{get;set;}
        @AuraEnabled
        public string Additional_Brand_Contact{set;get;}
        @AuraEnabled
        public string Additional_Brand_ContactName{set;get;}
        @AuraEnabled
        public Decimal Route_Miles{get;set;}
        @AuraEnabled
        public Decimal orderBookingFee{get;set;}
        @AuraEnabled
        public Decimal packOutFee{get;set;}
        @AuraEnabled
        public Decimal stageManifestFee{get;set;}
        @AuraEnabled
        public Decimal scheduleDispatchFee{get;set;} 
        @AuraEnabled
        public Decimal totalMileageFee{get;set;}
        @AuraEnabled
        public Decimal totalWeightFee{get;set;}
        @AuraEnabled
        public Decimal totalOrderWeight{get;set;}
        @AuraEnabled
        public Decimal serviceBookingFee{get;set;}
        @AuraEnabled
        public Decimal serviceSchedulingFee{get;set;}
        @AuraEnabled
        public Decimal serviceStagingFee{get;set;}
        @AuraEnabled
        public String salesPersonName{get;set;}
        @AuraEnabled
        public String salesPersonIds{get;set;} 
        @AuraEnabled
        public String brandContactName{get;set;}
        @AuraEnabled
        public String brandContactIds{get;set;} 
        @AuraEnabled
        public String factoringAssigneeId{get;set;}
        @AuraEnabled
        public String factoringContactId{get;set;}
        @AuraEnabled
        public String factoringAssigneeName{get;set;}
        @AuraEnabled
        public String factoringContactName{get;set;}
        @AuraEnabled
        public Decimal factoringRate{get;set;}
        @AuraEnabled
        public Decimal factoringDiscount{get;set;}
        @AuraEnabled
        public String factoringTerms{get;set;}
        @AuraEnabled
        public String accountName{get;set;}
        @AuraEnabled
        public Date deliveredDate{get;set;}
        @AuraEnabled
        public String siteId{get;set;}
        @AuraEnabled
        public String siteWarehouseName{get;set;}
        @AuraEnabled
        public String siteWarehouseAddress{get;set;}
        @AuraEnabled
        public String transportLicenseId{set;get;}
        @AuraEnabled
        public String transportLicenseName{set;get;}
        @AuraEnabled
        public Boolean isSample{set;get;}
        @AuraEnabled
        public Boolean piggybackSample{set;get;}
        @AuraEnabled
        public Boolean isPreapproved{set;get;}
        @AuraEnabled
        public String EarTime{set;get;}
        @AuraEnabled
        public String LatTime{set;get;}
        @AuraEnabled
        public String invoiceMemo{set;get;}
        
        @AuraEnabled
        public Decimal Total_Excise_Tax_Amount{get;set;}
        
        public integer compareTo(Object recordTocompare){
            /*RetailDeliveryTicket compareToRDT = (RetailDeliveryTicket)recordTocompare;
            Integer returnValue = 0;
            if (deliveredDate < compareToRDT.deliveredDate) {
                returnValue = 1;
            } else if (deliveredDate > compareToRDT.deliveredDate) {
                returnValue = -1;
            } else if ((deliveredDate == null) && (compareToRDT.deliveredDate != null)){
                returnValue = -1;
            } else if ((deliveredDate != null) && (compareToRDT.deliveredDate == null)){
                returnValue = 1;
            }        
        	return returnValue;*/
            
            RetailDeliveryTicket that = (RetailDeliveryTicket)recordTocompare;
            if (this.deliveredDate > that.deliveredDate) return 1;
            if (this.deliveredDate < that.deliveredDate) return -1;
            return 0;
		}
        
        public RetailDeliveryTicket(){
            this.id = '';
            this.name = '';
            this.paymentTerms = '';
            this.requestShipDate =NULL; //System.today();
            this.retailer = '';
            this.retailerLogoURL = '';
            this.retailerContact = '';
            this.retailerPO = '';
            this.salesPersonName = '';
            this.specialDeliveryInstructions = '';
            this.stateLicense = '';
            this.totalLineItems = 0;
            this.retailerDBA = '';
            this.excludeExciseTax = false;
            this.Route_Miles = 0;
            this.orderBookingFee = 0;
            this.packOutFee = 0;
            this.stageManifestFee = 0;
            this.scheduleDispatchFee = 0;
            this.totalMileageFee = 0;
            this.totalWeightFee = 0;
            this.totalOrderWeight = 0;
            this.serviceBookingFee = 0;
            this.serviceSchedulingFee = 0;
            this.serviceStagingFee = 0 ;
            this.salesPersonIds ='';
            this.factoringAssigneeId = '';
            this.factoringContactId = '';
            this.factoringRate = 0;
            this.factoringDiscount = 0;
            this.factoringTerms = '';
            this.accountName = '';
            this.brandContactIds = '';
            this.brandContactName = '';
            this.retailerContactName = '';
            this.stateLicenseNumber = '';
            this.stateLicenseAddress = '';
            this.siteId = '';
            this.siteWarehouseName = '';
            this.transportLicenseId = '';
            this.transportLicenseName = '';
            this.isSample = false;
            this.piggybackSample = false;
            this.isPreapproved = false;
            this.EarTime = '';
            this.LatTime = '';
            this.invoiceMemo = '';
            this.deliveredDate = NULL;
            this.Total_Excise_Tax_Amount = 0;
        }
        
        public RetailDeliveryTicket(Order__c rdt){
            this.id = rdt.Id;
            this.name = rdt.Name;
            this.paymentTerms = rdt.Payment_Terms__c;
            this.requestShipDate = rdt.Request_Ship_Date__c;
            this.retailer = rdt.Retailer__c;
            this.retailerDBA = (rdt.Retailer__r.dBA__c != null? rdt.Retailer__r.dBA__c: '');
            this.retailerName =rdt.Retailer__r.Name;
            this.retailerContact = rdt.Retailer_Contact__c;
            this.retailerContactName = rdt.Retailer_Contact__r.Name;
            this.salesPersonName = '';
            this.salesPersonIds = '';
            this.brandContactName = '';
            this.brandContactIds = '';
            this.accountName = rdt.Account__c != null ? rdt.Account__r.Name : '';
            this.salesPersonName = rdt.Sales_Person__c != NULL ?rdt.Sales_Person__r.Name:'';
            this.salesPersonIds = rdt.Sales_Person__c != NULL ?rdt.Sales_Person__c:NULL;
            if(!rdt.Retailer_Related_Contacts__r.isEmpty()){
                for(Retailer_Related_Contact__c rrc: rdt.Retailer_Related_Contacts__r){
                    if(rrc.Type__c == TYPE_ADD_RETAIL_CONTACT){
                    	this.retailerContactName += ', '+rrc.Contact__r.Name;
                        this.retailerContact += ', '+rrc.Contact__c;
                    }
                    /*if(rrc.Type__c == TYPE_SALES_REP){
                    	this.salesPersonName +=  rrc.Contact__r.Name + ', ';
                        this.salesPersonIds +=rrc.Contact__c + ', '; 
                    }*/
                    if(rrc.Type__c == TYPE_ADD_BRAND_CONTACT){
                    	this.brandContactName += rrc.Contact__r.Name + ', ';
                        this.brandContactIds += rrc.Contact__c + ', ';
                    }
                }
            }
            /*this.salesPersonName = this.retailerContactName != null ? this.retailerContactName this.retailerContactName.removeEnd(', ') : '';
            this.salesPersonIds = this.salesPersonIds != null ? this.salesPersonIds.removeEnd(', ') : '';*/
            this.retailerContactName = this.retailerContactName != null ? this.retailerContactName.removeEnd(', ') : '';
            this.retailerContact = this.retailerContact != null ? this.retailerContact.removeEnd(', ') : '';
            this.brandContactName = this.brandContactName != null ? this.brandContactName.removeEnd(', ') : '';
            this.brandContactIds = this.brandContactIds != null ? this.brandContactIds.removeEnd(', ') : '';
            this.retailerPO = rdt.Retailer_PO__c;
            this.specialDeliveryInstructions = rdt.Special_Instructions__c;
            this.stateLicense = rdt.State_License__c;
            this.stateLicenseName = rdt.State_License__r.License_Number__c;
            this.totalLineItems = rdt.Total_Line_Items__c;
            this.street = rdt.Shipping_Street__c;
            this.country = rdt.Shipping_Country__c;
            this.province = rdt.Shipping_Province__c;
            this.city = rdt.Shipping_City__c;
            this.transportLicenseId = rdt.Transporter__c;
            this.postalCode = rdt.Shipping_Zip__c;
            this.total = rdt.Total__c;
            this.status = rdt.Status__c;
            this.submittedDate = rdt.Order_Date__c.date();
            this.excludeExciseTax = rdt.Exclude_Excise_Tax__c;
            this.totalLocalTax = rdt.Total_Local_Tax__c;
            this.Additional_Brand_Contact = rdt.Additional_Brand_Contact__c;
            this.Additional_Brand_ContactName = rdt.Additional_Brand_Contact__r.Name;
            this.Route_Miles = rdt.Route_Miles__c;
            this.orderBookingFee = rdt.Order_Booking_Fee__c;
            this.packOutFee = rdt.Pack_Out_Fee__c;
            this.stageManifestFee = rdt.Stage_Manifest_Fee__c;
            this.scheduleDispatchFee = rdt.Schedule_Dispatch_Fee__c;
            this.totalMileageFee = rdt.Total_Milage_Fee__c ;
            this.totalWeightFee = rdt.Total_Weight_Fee__c;
            this.serviceBookingFee = rdt.Service_Booking_Fee__c;
            this.serviceSchedulingFee = rdt.Service_Scheduling_Fee__c;
            this.serviceStagingFee = rdt.Service_Staging_Fee__c ;
            //this.salesPerson = rdt.Sales_Person__r.Name;
            //this.salesPersonId = rdt.Sales_Person__c;
            this.factoringAssigneeId = rdt.Factoring_Assignee__c;
            this.factoringContactId = rdt.Factoring_Contact__c;
            this.factoringAssigneeName = rdt.Factoring_Assignee__r.DBA__c;
            this.factoringContactName = rdt.Factoring_Contact__r.Name;
            this.factoringRate = rdt.Factoring_Rate__c;
            this.factoringDiscount = rdt.Factoring_Discount__c;
            this.factoringTerms = rdt.Factoring_Terms__c;
            this.siteId = rdt.Site__c;
            this.siteWarehouseName = rdt.Site__r.Warehouse_Name__c;
            this.isSample = rdt.Sample_Order__c;
            this.piggybackSample = rdt.Piggyback_sample__c;
            this.isPreapproved = rdt.isPreapproved__c;
            if(rdt.Requested_Delivery_Earliest_Time__c != null ){
                String[] strTimeSplit = String.valueOf(rdt.Requested_Delivery_Earliest_Time__c).split(':');
                system.debug('##strTimeSplit : '+strTimeSplit);
             	this.EarTime = Integer.valueOf(strTimeSplit[0]) > 12 ? String.valueOf(Integer.valueOf(strTimeSplit[0]) - 12)+':'+strTimeSplit[1]+' PM' : (Integer.valueOf(strTimeSplit[0]) == 0 ? '12' : strTimeSplit[0])+':'+strTimeSplit[1]+(Integer.valueOf(strTimeSplit[0]) == 12 ?' PM': ' AM');
            }else{
                this.EarTime = '';
            }
            if(rdt.Requested_Delivery_Latest_Time__c != null ){
                String[] strTimeSplit = String.valueOf(rdt.Requested_Delivery_Latest_Time__c).split(':');
             	this.LatTime = Integer.valueOf(strTimeSplit[0]) > 12 ? String.valueOf(Integer.valueOf(strTimeSplit[0]) - 12)+':'+strTimeSplit[1]+' PM' : (Integer.valueOf(strTimeSplit[0]) == 0 ? '12' : strTimeSplit[0])+':'+strTimeSplit[1]+(Integer.valueOf(strTimeSplit[0]) == 12 ?' PM': ' AM');
            }else{
                this.LatTime = '';
            }
            this.invoiceMemo = rdt.Invoice_Memo__c;
            this.Total_Excise_Tax_Amount  = rdt.Total_Excise_Tax_Amount__c;
            
        }
    }
    
    public class RetailDeliveryTicketLineItem{
        @AuraEnabled
        public String id{set;get;}
        @AuraEnabled
        public String name{set;get;}
        @AuraEnabled
        public Double orderQty{set;get;}
        @AuraEnabled
        public String Product{set;get;}
        @AuraEnabled
        public String productName{set;get;}
        @AuraEnabled
        public String parentProduct{set;get;}
        @AuraEnabled
        public String productRecordTypeName{set;get;}
        @AuraEnabled
        public String productFamily{set;get;}
        @AuraEnabled
        public String brandId{set;get;}
        @AuraEnabled
        public String brandName{set;get;}
        @AuraEnabled
        public String ProductBookEntryId{set;get;}
        @AuraEnabled
        public String retailDeliveryTicket{set;get;}
        @AuraEnabled
        public Double originalSalesPrice{set;get;}
        @AuraEnabled
        public Double salesPrice{set;get;}
        @AuraEnabled
        public Double actualSalesPrice{set;get;}
        
        @AuraEnabled
        public Double listPrice{set;get;}
        @AuraEnabled
        public String specialInstructions{set;get;}
        @AuraEnabled
        public Double totalOrderQty{set;get;}
        @AuraEnabled
        public Double totalPrice{set;get;}
        @AuraEnabled
        public Double availableInventory{set;get;}
        @AuraEnabled
        public Double availableQty{set;get;}
        @AuraEnabled
        public Decimal cases{set;get;}
        @AuraEnabled
        public Double MOQ{set;get;}
        @AuraEnabled
        public Boolean isSample{set;get;}
        @AuraEnabled
        public Boolean isPromo{set;get;}
        @AuraEnabled
        public boolean isLIPromo{set;get;}
        @AuraEnabled
        public Boolean isDiscountProduct{get;set;}
        @AuraEnabled
        public Boolean isProductSample{set;get;}
        @AuraEnabled
        public Decimal localTax{get;set;}
        @AuraEnabled
        public string description{set;get;}
        @AuraEnabled
        public string shortDescription{set;get;}
        @AuraEnabled
        public Decimal pickPackFee{get;set;}
        @AuraEnabled
        public Decimal QAReviewFee{get;set;}
        @AuraEnabled
        public Decimal totalWeight{get;set;}
        @AuraEnabled
        public String applyExciseTax{get;set;}
        @AuraEnabled
        public string warehouseInventoryDetails{get;set;}
        @AuraEnabled
        public string imageUrl{set;get;}
        @AuraEnabled
        public string priceBookid{set;get;}
        @AuraEnabled
        public Boolean isBulkProduct{get;set;}
        @AuraEnabled
        public Decimal unitExciseTax{get;set;}
        @AuraEnabled
        public Decimal totalReceivedQty{get;set;}
        
        public RetailDeliveryTicketLineItem(){
            this.id = '';
            this.name = '';
            this.orderQty = 0;
            this.product = '';
            this.retailDeliveryTicket = '';
            this.salesPrice = 0;
            this.actualSalesPrice = 0;
            this.listPrice = 0;
            this.specialInstructions = '';
            this.totalOrderQty = 0;
            this.totalPrice = 0;
            this.MOQ = 0;
            this.availableInventory = 0;
            this.availableQty = 0;
            this.cases = 0;
            this.isSample = false;
            this.isPromo = false;
            this.isLIPromo = false;
            this.isDiscountProduct =false;
            this.isProductSample = false;
            this.description = '';
            this.applyExciseTax = '';
            this.pickPackFee = 0;
            this.QAReviewFee = 0;
            this.totalWeight = 0;
            this.parentProduct = '';
            this.productRecordTypeName = '';
            this.productFamily = '';
            this.brandName = '';
            this.warehouseInventoryDetails = '';
            this.shortDescription='';
            this.isBulkProduct=false;
            this.unitExciseTax = 0;
            this.totalReceivedQty =0;
        }
        
        public RetailDeliveryTicketLineItem(Order_Line_Item__c rdtli){
            this.id = rdtli.Id;
            this.name = rdtli.Name;
            this.orderQty = rdtli.Quantity_Cases__c;
            this.product = rdtli.Product__c;
            this.productName = rdtli.Product__r.Name;
            this.parentProduct = rdtli.Product__r.Parent_Product__c;
            this.imageUrl = (rdtli.Product__r.Image_URL__c != null ? rdtli.Product__r.Image_URL__c: IMAGE_COMINGSOON);
            this.productRecordTypeName = rdtli.Product__r.RecordType.Name;
            this.productFamily = rdtli.Product__r.Family;
            this.isBulkProduct = this.productFamily.startsWith('Bulk');
            this.listPrice = rdtli.UnitPrice__c;
            this.specialInstructions = rdtli.Special_Instructions__c;
            this.totalOrderQty = rdtli.Line_Total_Qty__c;
            this.totalPrice = rdtli.Line_Total_Cost__c;
            this.MOQ = rdtli.MOQ__c;
            this.availableInventory = rdtli.Product__r.Available_Inventory__c;
            this.availableQty = rdtli.Product__r.Available_Qty__c;
            this.isSample = rdtli.Is_Sample__c;
            this.isPromo =rdtli.IsPromo__c;
            this.isLIPromo = false;
            this.isDiscountProduct=rdtli.Product__r.RecordType.Name == PRODUCT_RECORD_TYPE_NAME_DISCOUNT;
            this.isProductSample = rdtli.Product__r.Is_Sample__c;
            this.salesPrice = this.isDiscountProduct == true ? -1 * rdtli.UnitPrice__c: rdtli.UnitPrice__c;
            this.actualSalesPrice = rdtli.UnitPrice__c;
            this.cases = Integer.valueOf(this.availableQty/this.MOQ);
            this.localTax = rdtli.Subtotal_Local_Cannabis_Tax__c != null?rdtli.Subtotal_Local_Cannabis_Tax__c:0;
            this.description = rdtli.Product__r.Description;
            this.shortDescription = rdtli.Product__r.Product_Short_Description__c;
            this.applyExciseTax = rdtli.Product__r.Apply_Excise_Tax__c;
            this.brandName = rdtli.Product__r.Brand_Name__c;
            this.warehouseInventoryDetails = '';
            this.pickPackFee = rdtli.Pick_Pack_Fee__c;
            this.QAReviewFee =rdtli.QA_Review_Fee__c;
            this.unitExciseTax = rdtli.Line_Total_Excise_Tax__c;
            this.totalReceivedQty = 0;
        }
    }
    public class Product{
        @AuraEnabled
        public string warehouseInventoryDetails{get;set;}
        @AuraEnabled
        public Pricebook price{get;set;}
        @AuraEnabled
        public String productRecordTypeName{set;get;}
        @AuraEnabled
        public String id{get;set;}
        @AuraEnabled
        public String name{get;set;}
        @AuraEnabled
        public String productFamily{get;set;}
        @AuraEnabled
        public String brandId{set;get;}
        @AuraEnabled
        public String brandName{get;set;}
        @AuraEnabled
        public Boolean whiteLabelled{get;set;}
        @AuraEnabled
        public String producerName{get;set;}
        @AuraEnabled
        public String producerId{get;set;}
        @AuraEnabled
        public String licenseeName{get;set;}
        @AuraEnabled
        public String licenseeId{get;set;}
        @AuraEnabled
        public string description{set;get;}
        @AuraEnabled
        public string shortDescription{set;get;}
        @AuraEnabled
        public Double quantity{get;set;}
        @AuraEnabled
        public Double MOQ{get;set;}
        @AuraEnabled
        public Double availableInventory{get;set;}
        @AuraEnabled
        public Double availableQty{get;set;}  
        @AuraEnabled
        public Decimal discountPercent{get;set;}
        @AuraEnabled
        public Decimal productDiscountPercent{get;set;}
        @AuraEnabled
        public String applyExciseTax{get;set;}
        @AuraEnabled
        public Decimal caseShippingWeight{get;set;}
        @AuraEnabled
        public Decimal unitShippingWeight{get;set;}
        @AuraEnabled
        public Boolean isSample{get;set;}
        @AuraEnabled
        public Boolean isPromo{set;get;}
        @AuraEnabled
        public boolean isLIPromo{set;get;}
        @AuraEnabled
        public Boolean isBulkProduct{get;set;}
        @AuraEnabled
        public Boolean isDiscountProduct{get;set;}
        @AuraEnabled
        public Boolean isProductSample{get;set;}
        @AuraEnabled
        public Decimal maxOrderAllowed{get;set;}
        @AuraEnabled
        public string recordTypeName{set;get;}
        @AuraEnabled
        public string parentProductId{set;get;}
        @AuraEnabled
        public string imageUrl{set;get;}
         @AuraEnabled
        public String THCPercent{get;set;}
        @AuraEnabled
        public Decimal discount{
            get{
                if(discountPercent != null && price != null && price.unitPrice != null){
                    discount = (price.unitPrice * discountPercent) /100;
                }else{
                    discount = 0;
                }
                return discount;
            }set;
        }
        @AuraEnabled
        public Decimal productDiscount{
            get{
                if(productDiscountPercent != null && price != null && price.unitPrice != null){
                    productDiscount = (price.unitPrice * productDiscountPercent) /100;
                }else{
                    productDiscount = 0;
                }
                return productDiscount;
            }set;
        }
        @AuraEnabled
        public Decimal salePrice{
            get{
                salePrice = 0;
                if(discount != null && price != null && price.unitPrice != null){
                    salePrice = price.unitPrice - discount;
                }
                if(productDiscount != null && price != null && price.unitPrice != null){
                    salePrice = salePrice - productDiscount;
                }
                return salePrice.setScale(2);
            }set;
        }
        @AuraEnabled
        public Decimal actualSalesPrice{
            get{
                actualSalesPrice = 0;
                if(discount != null && price != null && price.unitPrice != null){
                    actualSalesPrice = price.unitPrice - discount;
                }
                if(productDiscount != null && price != null && price.unitPrice != null){
                    actualSalesPrice = actualSalesPrice - productDiscount;
                }
                return actualSalesPrice.setScale(2);
            }set;
        }
        @AuraEnabled
        public Decimal addistionalDiscount{
            get{
                if(discountPercent != null && price != null && price.unitPrice != null){
                    addistionalDiscount = (price.unitPrice * discountPercent) /100;
                }else{
                    addistionalDiscount = 0;
                }
                return addistionalDiscount;
            }set;
        }
        public Product(PricebookEntry pbe){
            this.price = new Pricebook(pbe);
            
            this.id = pbe.Product2Id;
            this.name = pbe.Product2.Name;
            this.productFamily = pbe.Product2.Family;
            this.brandName = pbe.Product2.Brand_Name__c;
            this.productRecordTypeName = pbe.Product2.RecordType.Name;
            this.isBulkProduct=false;
            this.licenseeId=pbe.Product2.Licensee_Name__c;
            this.licenseeName=pbe.Product2.Licensee_Name__r.Name;
            this.whiteLabelled=pbe.Product2.White_Labelled__c;
            this.producerId = pbe.Product2.Producer_Name__c;
            this.producerName = pbe.Product2.Producer_Name__r.Name;
            this.isDiscountProduct =pbe.Product2.RecordType.Name == PRODUCT_RECORD_TYPE_NAME_DISCOUNT ;
            this.quantity = 1;
            this.MOQ = pbe.Product2.MOQ__c;
            this.availableInventory = pbe.Product2.Available_Inventory__c;
            this.imageUrl = (pbe.Product2.Image_URL__c != null?pbe.Product2.Image_URL__c: IMAGE_COMINGSOON);
            this.availableQty = pbe.Product2.Available_Qty__c;
            this.description = pbe.Product2.Description;
            this.applyExciseTax = pbe.Product2.Apply_Excise_Tax__c;
            this.caseShippingWeight = pbe.Product2.Case_Shipping_Weight_lbs__c;
            this.unitShippingWeight = pbe.Product2.Unit_Shipping_Weight_lbs__c;
            this.maxOrderAllowed = pbe.Product2.Max_Order_Allowed__c;
            this.recordTypeName = pbe.Product2.RecordType.Name;
            this.parentProductId = pbe.Product2.Parent_Product__c;
            this.warehouseInventoryDetails = '';
            this.isSample = pbe.Product2.Is_Sample__c;
            this.isPromo = false;
            this.isLIPromo = false;
            this.isProductSample = pbe.Product2.Is_Sample__c;
            this.shortDescription = pbe.Product2.Product_Short_Description__c;
            
        }
        public void setDiscountPercent(Decimal discountPercent){
            this.discountPercent = discountPercent;
        }
        public void setProductDiscountPercent(Decimal discountPercent){
            this.productDiscountPercent = discountPercent;
        }
    }
    
    public class Pricebook{
        @AuraEnabled
        public String id{get;set;}
        @AuraEnabled
        public Double unitPrice{get;set;}
        
        public Pricebook(PricebookEntry pbe){
            this.id = pbe.Id;
            this.unitPrice = pbe.UnitPrice;
        }
    }
    public class DistanceResponse{
        public DistanceRow[] rows{set;get;}
    }
    public class DistanceRow{
        public DistanceElement[] elements{set;get;}
    }
    public class DistanceElement{
        public Distance distance{set;get;}
    }
    public class Distance{
        public String text{set;get;}
        public Decimal value{set;get;}
    }
}