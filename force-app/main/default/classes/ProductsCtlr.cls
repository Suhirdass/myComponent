public without sharing class ProductsCtlr{
    private static String FRT_Record_Type_Item_Basis{
        get{
            return String.isNotBlank(FRT_Record_Type_Item_Basis) ? FRT_Record_Type_Item_Basis : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','FRT_Record_Type_Item_Basis');
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
    private static String FULFILLMENT_SERVICE_RECEIVING{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_RECEIVING) ? FULFILLMENT_SERVICE_RECEIVING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Receiving_Fee');
        }set;
    }
    private static String PRODUCT_RECORD_TYPE_NAME_PRODUCT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_PRODUCT) ? PRODUCT_RECORD_TYPE_NAME_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Name_Product');
        }set;
    }
    private static String ACCOUNT_TYPE_DISTY_PARTNER{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_DISTY_PARTNER) ? ACCOUNT_TYPE_DISTY_PARTNER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Disty_Partner');
        }set;
    }
    private static String ACCOUNT_TYPE_DISTRIBUTOR{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_DISTRIBUTOR) ? ACCOUNT_TYPE_DISTRIBUTOR : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Distributor');
        }set;
    }
    private static String ACCOUNT_TYPE_PARTNER{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_PARTNER) ? ACCOUNT_TYPE_PARTNER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Partner');
        }set;
    }
    private static String ACCOUNT_TYPE_RESELLER{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_RESELLER) ? ACCOUNT_TYPE_RESELLER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Reseller');
        }set;
    }
    private static String ACCOUNT_TYPE_MANUFACTURER{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_MANUFACTURER) ? ACCOUNT_TYPE_MANUFACTURER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Manufacturer');
        }set;
    }
    private static String ACCOUNT_TYPE_PRODUCER{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_PRODUCER) ? ACCOUNT_TYPE_PRODUCER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Producer');
        }set;
    }
    private static String ACCOUNT_TYPE_CULTIVATOR{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_CULTIVATOR) ? ACCOUNT_TYPE_CULTIVATOR : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Cultivator');
        }set;
    }
    private static String ACCOUNT_TYPE_SUPPLIER{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_SUPPLIER) ? ACCOUNT_TYPE_SUPPLIER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Supplier');
        }set;
    }
    private static String COMMUNITY_SETTINGS_DEFAULT{
        get{
            return String.isNotBlank(COMMUNITY_SETTINGS_DEFAULT) ? COMMUNITY_SETTINGS_DEFAULT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Community Settings','Community_Settings_Default');
        }set;
    }
    private static String STATUS_DRAFT{
        get{
            return String.isNotBlank(STATUS_DRAFT) ? STATUS_DRAFT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Draft');
        }set;
    }
    private static String ORDER_RECORD_TYPE_NAME_RETAILER{
        get{
            return String.isNotBlank(ORDER_RECORD_TYPE_NAME_RETAILER) ? ORDER_RECORD_TYPE_NAME_RETAILER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_Retailer');
        }set;
    }
    private static String ORDER_TYPE_RETAIL{
        get{
            return String.isNotBlank(ORDER_TYPE_RETAIL) ? ORDER_TYPE_RETAIL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Retail');
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
    private static String SAMPLE_PB_ALL_PRODUCTS{
        get{
            return String.isNotBlank(SAMPLE_PB_ALL_PRODUCTS) ? SAMPLE_PB_ALL_PRODUCTS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Pricebook','Sample_PB_All_Products');
        }set;
    }
    public Static String STANDARD_PRICE_BOOK {
        get{
            return String.isNotBlank(STANDARD_PRICE_BOOK) ? STANDARD_PRICE_BOOK:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Pricebook','STANDARD_PRICE_BOOK');
        }set;
    }
    public Static String PRODUCT_ORIGIN_MARKETPLACE {
        get{
            return String.isNotBlank(PRODUCT_ORIGIN_MARKETPLACE) ? PRODUCT_ORIGIN_MARKETPLACE:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Origin_Marketplace');
        }set;
    }
    public Static String CONTACT_RECORD_TYPE_NAME_CONTACT {
        get{
            return String.isNotBlank(CONTACT_RECORD_TYPE_NAME_CONTACT) ? CONTACT_RECORD_TYPE_NAME_CONTACT:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Contact','Contact_Record_Type_Name_Contact');
        }set;
    }
    public Static String SO_ORDER_TYPE_BRAND {
        get{
            return String.isNotBlank(SO_ORDER_TYPE_BRAND) ? SO_ORDER_TYPE_BRAND:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Type_Brand');
        }set;
    }    
    public Static String SO_ORDER_TYPE_TRANSFER {
        get{
            return String.isNotBlank(SO_ORDER_TYPE_TRANSFER) ? SO_ORDER_TYPE_TRANSFER :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Type_Transfer');
        }set;
    }
    private Static String STATUS_APPROVED{
        get{
            return String.isNotBlank(STATUS_APPROVED) ? STATUS_APPROVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Approved');
        }set;
    }
    private static String ORDER_RECORD_TYPE_NAME_BRAND{
        get{
            return String.isNotBlank(ORDER_RECORD_TYPE_NAME_BRAND) ? ORDER_RECORD_TYPE_NAME_BRAND : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_ Brand');
        }set;
    }
    public Static String ORDER_RECORD_TYPE_NAME_TRANSFER {
        get{
            return String.isNotBlank(ORDER_RECORD_TYPE_NAME_TRANSFER) ? ORDER_RECORD_TYPE_NAME_TRANSFER:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_Transfer');
        }set;
    }
    private static String STATUS_PENDING{
        get{
            return String.isNotBlank(STATUS_PENDING) ? STATUS_PENDING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Pending');
        }set;
    }
    private static String SOLI_STATUS_ALLOCATED{
        get{
            return String.isNotBlank(SOLI_STATUS_ALLOCATED) ? SOLI_STATUS_ALLOCATED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_Status_ Allocated');
        }set;
    }
    private static String FAQ_TYPE_BRAND{
        get{
            return String.isNotBlank(FAQ_TYPE_BRAND) ? FAQ_TYPE_BRAND : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('FAQ','FAQ_Type_Brand');
        }set;
    }
    private static String FAQ_TYPE_RETAILER{
        get{
            return String.isNotBlank(FAQ_TYPE_RETAILER) ? FAQ_TYPE_RETAILER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('FAQ','FAQ_Type_Retailer');
        }set;
    }
    private static String FAQ_TYPE_BOTH{
        get{
            return String.isNotBlank(FAQ_TYPE_BOTH) ? FAQ_TYPE_BOTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('FAQ','FAQ_Type_Both');
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
    private static String SEARCHTERM_FILTER{
        get{
            return String.isNotBlank(SEARCHTERM_FILTER) ? SEARCHTERM_FILTER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Filter','SearchTerm');
        }set;
    }
    private static String BRAND_ID{
        get{
            return String.isNotBlank(BRAND_ID) ? BRAND_ID : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Filter','Brand_ID');
        }set;
    }
    private static String FAMILIES_FILTER{
        get{
            return String.isNotBlank(FAMILIES_FILTER) ? FAMILIES_FILTER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Filter','Families');
        }set;
    }
    private static String RETAILER_FILTER{
        get{
            return String.isNotBlank(RETAILER_FILTER) ? RETAILER_FILTER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Filter','Retailer_Filter');
        }set;
    }
    private static String PRODUCT_NOT_FOUND{
        get{
            return String.isNotBlank(PRODUCT_NOT_FOUND) ? PRODUCT_NOT_FOUND : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Err_Msg_Product_Not_Found');
        }set;
    }
    private static String IMAGE_COMINGSOON{
        get{
            return String.isNotBlank(IMAGE_COMINGSOON) ? IMAGE_COMINGSOON : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Image_ComingSoon');
        }set;
    }
    private static String CASE_RECORD_TYPE_NAME_EXTERNAL{
        get{
            return String.isNotBlank(CASE_RECORD_TYPE_NAME_EXTERNAL) ? CASE_RECORD_TYPE_NAME_EXTERNAL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Case','Case_Record_Type_Name_External');
        }set;
    }
    private static String CASE_STATUS_CLOSED{
        get{
            return String.isNotBlank(CASE_STATUS_CLOSED) ? CASE_STATUS_CLOSED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Case','Case_Status_Closed');
        }set;
    }
    private static String REVIEW_IS_REQUIRED{
        get{
            return String.isNotBlank(REVIEW_IS_REQUIRED) ? REVIEW_IS_REQUIRED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Err_Msg_Review_Is_Required');
        }set;
    }
    private static String PROVIDE_THE_RATING{
        get{
            return String.isNotBlank(PROVIDE_THE_RATING) ? PROVIDE_THE_RATING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Err_Msg_Provide_The_Rating');
        }set;
    }
    private static String PRODUCT_QTY_UNAVAILABLE{
        get{
            return String.isNotBlank(PRODUCT_QTY_UNAVAILABLE) ? PRODUCT_QTY_UNAVAILABLE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Pricebook','Err_Msg_Product_Qty_Unavailable');
        }set;
    }
    private static String ORDERCANCELLED_CUSTOMER{
        get{
            return String.isNotBlank(ORDERCANCELLED_CUSTOMER) ? ORDERCANCELLED_CUSTOMER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Customer');
        }set;
    }
    private static String ADDRESS_NOT_FOUND{
        get{
            return String.isNotBlank(ADDRESS_NOT_FOUND) ? ADDRESS_NOT_FOUND : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Err_Msg_Address_Not_Found');
        }set;
    }
    private static String CART_IS_EMPTY{
        get{
            return String.isNotBlank(CART_IS_EMPTY) ? CART_IS_EMPTY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Err_Msg_Cart_Is_Empty');
        }set;
    }
    private static String PRICEBOOK_NOT_FOUND{
        get{
            return String.isNotBlank(PRICEBOOK_NOT_FOUND) ? PRICEBOOK_NOT_FOUND : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Pricebook','Err_Msg_Pricebook_Not_Found');
        }set;
    }
    private static String PROVIDE_THE_QTY{
        get{
            return String.isNotBlank(PROVIDE_THE_QTY) ? PROVIDE_THE_QTY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Err_Msg_Provide_The_Qty');
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
    private static String ORDERBY_ORDER_DATE{
        get{
            return String.isNotBlank(ORDERBY_ORDER_DATE) ? ORDERBY_ORDER_DATE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderBy_Order_Date');
        }set;
    }
    private static String ADD_ATLEAST_ONE_ITEM_RMA{
        get{
            return String.isNotBlank(ADD_ATLEAST_ONE_ITEM_RMA) ? ADD_ATLEAST_ONE_ITEM_RMA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('RMA','Err_Msg_Add_Atleast_One_Item');
        }set;
    }
    private static String ORDER_MUST_HAVE_SM_RMA{
        get{
            return String.isNotBlank(ORDER_MUST_HAVE_SM_RMA) ? ORDER_MUST_HAVE_SM_RMA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('RMA','Err_Msg_Order_Must_Have_SM');
        }set;
    }
    private static String ADD_ATLEAST_ONE_ITEM_RMA_REQ{
        get{
            return String.isNotBlank(ADD_ATLEAST_ONE_ITEM_RMA_REQ) ? ADD_ATLEAST_ONE_ITEM_RMA_REQ : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('RMA','Err_Msg_Add_atleast_One_Item_Request');
        }set;
    }
    private static String RETURN_STATUS_APPROVED{
        get{
            return String.isNotBlank(RETURN_STATUS_APPROVED) ? RETURN_STATUS_APPROVED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('RMA','Return_Status_Approved');
        }set;
    }
    private static String RMA_ALREADY_APPROVED{
        get{
            return String.isNotBlank(RMA_ALREADY_APPROVED) ? RMA_ALREADY_APPROVED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('RMA','Err_Msg_RMA_Already_Approved');
        }set;
    }
    private static String OPP_RECORD_TYPE_RMA{
        get{
            return String.isNotBlank(OPP_RECORD_TYPE_RMA) ? OPP_RECORD_TYPE_RMA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Oppty_Record_Type_DevName_RMA');
        }set;
    }
    private static String SALES_ORIGIN_DISTY{
        get{
            return String.isNotBlank(SALES_ORIGIN_DISTY) ? SALES_ORIGIN_DISTY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Sales_Origin_Disty');
        }set;
    }
    private static String STAGE_PROPOSAL_PRICE_QUOTE{
        get{
            return String.isNotBlank(STAGE_PROPOSAL_PRICE_QUOTE) ? STAGE_PROPOSAL_PRICE_QUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Stage_Proposal_Price_Quote');
        }set;
    }
    private static String RETURN_STATUS_CANCELLED{
        get{
            return String.isNotBlank(RETURN_STATUS_CANCELLED) ? RETURN_STATUS_CANCELLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('RMA','Return_Status_Cancelled');
        }set;
    }
    private static String LAB_TEST_STATUS_TESTED_PASSED{
        get{
            return String.isNotBlank(LAB_TEST_STATUS_TESTED_PASSED) ? LAB_TEST_STATUS_TESTED_PASSED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Compliance Images','Lab_Test_Status_Tested_Passed');
        }set;
    }
    private static String CASE_ORIGIN_WEB{
        get{
            return String.isNotBlank(CASE_ORIGIN_WEB) ? CASE_ORIGIN_WEB : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Case','Case_Origin_Web');
        }set;
    }
    private static String USER_LICENCE_CUST_COMMUNITY_PLUS{
        get{
            return String.isNotBlank(USER_LICENCE_CUST_COMMUNITY_PLUS) ? USER_LICENCE_CUST_COMMUNITY_PLUS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('User','User_License_Customer_Community_Plus');
        }set;
    }
    private static String ORDERBY_NAME{
        get{
            return String.isNotBlank(ORDERBY_NAME) ? ORDERBY_NAME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderBy_Name');
        }set;
    }
    private static String PRODUCT_MOQ_TOOLTIP{
        get{
            return String.isNotBlank(PRODUCT_MOQ_TOOLTIP) ? PRODUCT_MOQ_TOOLTIP : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_MOQ_Tooltip');
        }set;
    }
    private static String ERR_ON_MOBILE_VIEW{
        get{
            return String.isNotBlank(ERR_ON_MOBILE_VIEW) ? ERR_ON_MOBILE_VIEW : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Filter','Err_on_Mobile_View');
        }set;
    }
    private static String MP_MENU_BRAND_USER{
        get{
            return String.isNotBlank(MP_MENU_BRAND_USER) ? MP_MENU_BRAND_USER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Menu','MP_Menu_Brand');
        }set;
    }
    private static String MP_MENU_COMMUNITY_PLUS_USER{
        get{
            return String.isNotBlank(MP_MENU_COMMUNITY_PLUS_USER) ? MP_MENU_COMMUNITY_PLUS_USER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Menu','Mp_Menu_Retailer_With_Community_Plus');
        }set;
    }
    private static String MP_MENU_COMMUNITY_PLUS_AND_BRAND_USER{
        get{
            return String.isNotBlank(MP_MENU_COMMUNITY_PLUS_AND_BRAND_USER) ? MP_MENU_COMMUNITY_PLUS_AND_BRAND_USER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Menu','Mp_Menu_Brand_With_Community_Plus');
        }set;
    }
    private static String MP_MENU_EXCEPT_COMMUNITY_PLUS_AND_BRAND_USER{
        get{
            return String.isNotBlank(MP_MENU_EXCEPT_COMMUNITY_PLUS_AND_BRAND_USER) ? MP_MENU_EXCEPT_COMMUNITY_PLUS_AND_BRAND_USER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Menu','Mp_Menu_Retailer');
        }set;
    }
    private static String MP_MENU_LIMITED_ACCESS{
        get{
            return String.isNotBlank(MP_MENU_LIMITED_ACCESS) ? MP_MENU_LIMITED_ACCESS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Menu','Mp_Menu_Limited');
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
	private static String PRODUCT_RECORD_TYPE_NAME_DISCOUNT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_DISCOUNT) ? PRODUCT_RECORD_TYPE_NAME_DISCOUNT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Discount');
        }set;
    }
    private static String Retail_MOV_Fee {
        get{
            return String.isNotBlank(Retail_MOV_Fee) ? Retail_MOV_Fee : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Retail_MOV_Fee');
        }set;
    }
    private static String ORDERCANCELLED_FILIGREEN{
        get{
            return String.isNotBlank(ORDERCANCELLED_FILIGREEN) ? ORDERCANCELLED_FILIGREEN : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Filigreen');
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
    private static String ERR_MSG_ORDER_QTY_GT_AVAILABLE_QTY{
        get{
            return String.isNotBlank(ERR_MSG_ORDER_QTY_GT_AVAILABLE_QTY) ? ERR_MSG_ORDER_QTY_GT_AVAILABLE_QTY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Err_Msg_Order_Qty_Gre_than_Available_Qty');
        }set;
    }
    private static String ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER) ? ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Financial_Interest_Holder');
        }set;
    }
    private static String Licensed_Verticals{
        get{
            return String.isNotBlank(Licensed_Verticals) ? Licensed_Verticals : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Licensed_Verticals');
        }set;
    }
    private static final String RECEIVING_INSPECTION = Label.Default_Inventory_Location;
    public static Id priceBookId = (Utility.loggedInUser.Contact.Account.Community_Price_Book__c != null? Utility.loggedInUser.Contact.Account.Community_Price_Book__c: null);
    public static Id brandId = Utility.loggedInUser.AccountId;
    public static Id userId = Utility.loggedInUser.ContactId;
    public static Id searchBrandId;
    public static Boolean isBrandProducts = false;
    static String recordTypeName = PRODUCT_RECORD_TYPE_NAME_PRODUCT;
    public static Boolean skipTrigger = false;
    static Map<String, String> brandPriceBooks = Utility.getBrandPriceBooks();
    public static List<String> actualpriceBooks = brandPriceBooks.values();
    public static Set<String> brandNames = brandPriceBooks.keySet();
    public static List<String> priceBooks = brandPriceBooks.values();
    static Map<String, String> distyBrandPriceBooks = Utility.distyBrandPriceBooks;
    public static List<String> distyBrandNames = new List<String>(distyBrandPriceBooks.keySet());
    public static List<String> distyPriceBooks = distyBrandPriceBooks.values();
    public static Set<Id> exlcudeBrandIds = getExculudeBrandIds();
    public static String excludeBulk = '%Bulk%';
    public static List<String> productFamilies = new List<String>();
    
    public static Map<String,List<String>> MPAccessTypesMap{
        get{
            if(MPAccessTypesMap == NULL){
                MPAccessTypesMap = new Map<String,List<String>>();
                for(MP_Access_Type_Config__mdt MPAccess: [SELECT Id, Account_Types__c ,MP_Access_Type__c FROM MP_Access_Type_Config__mdt ] ){
                    List<String> accountTypes = MPAccess.Account_Types__c != NULL ? MPAccess.Account_Types__c.split(','):new List<String>();
                    if(MPAccessTypesMap.containsKey(MPAccess.MP_Access_Type__c)){
                        MPAccessTypesMap.get(MPAccess.MP_Access_Type__c).addAll(accountTypes);
                    }
                    MPAccessTypesMap.put(MPAccess.MP_Access_Type__c,accountTypes);
                }
            }
            return MPAccessTypesMap;
        }set;
    }
    public static List<String> brandTypes{
        get{
            if(brandTypes == NULL){
                if(MPAccessTypesMap.containsKey('Brand')){
                    brandTypes = MPAccessTypesMap.get('Brand');
                }else{
                    brandTypes = new List<String>();
                }
            }
            return brandTypes;
        }set;
    }
    public static List<String> limitedTypes{
        get{
            if(limitedTypes == NULL){
                if(MPAccessTypesMap.containsKey('Limited')){
                    limitedTypes = MPAccessTypesMap.get('Limited');
                }else{
                    limitedTypes = new List<String>();
                }
            }
            return limitedTypes;
        }set;
    }
    public static List<String> retailerTypes{
        get{
            if(retailerTypes == NULL){
                if(MPAccessTypesMap.containsKey('Retailer')){
                    retailerTypes = MPAccessTypesMap.get('Retailer');
                }else{
                    retailerTypes = new List<String>();
                }
            }
            return retailerTypes;
        }set;
    }
    public static List<String> hybridTypes{
        get{
            if(hybridTypes == NULL){
                if(MPAccessTypesMap.containsKey('Hybrid')){
                    hybridTypes = MPAccessTypesMap.get('Hybrid');
                }else{
                    hybridTypes = new List<String>();
                }
            }
            return hybridTypes;
        }set;
    }
    public static List<String> distyTypes{
        get{
            if(distyTypes == NULL){
                if(MPAccessTypesMap.containsKey('Disty')){
                    distyTypes = MPAccessTypesMap.get('Disty');
                }else{
                    distyTypes = new List<String>();
                }
            }
            return distyTypes;
        }set;
    }
    //static Line_Card__c [] lineCards = Utility.getRetailerLineCards();
    public static string cacheKey = 'local.BrandRetailDeliveryOrderItems.'+UserInfo.getUserId();
    
    public static Set<Id> getExculudeBrandIds(){
        Set<Id> excludeIds = new Set<Id>();
        for(Line_Card__c lc: [SELECT Retailer_Excluded__c ,Brand_Name__c  FROM Line_Card__c WHERE Retailer_Name__c = :Utility.loggedInUser.AccountId AND Retailer_Excluded__c = true]){
            excludeIds.add(lc.Brand_Name__c);
        }
        return excludeIds;
    }
    public static Map<String,String> strainTypeMap{
        get{
            strainTypeMap = new Map<String,String>();
            Map<String,Strain_Type_Color_Config__c> allStrainType = Strain_Type_Color_Config__c.getAll();
            if(!allStrainType.isEmpty()){
                for(String key: allStrainType.keySet()){
                    Strain_Type_Color_Config__c scc = allStrainType.get(key);
                    strainTypeMap.put(scc.Strain_Type__c,scc.Color_Code__c);
                }
            }
            return strainTypeMap;
        }set;
    }
    public static Boolean isLimited{
        get{
            if(Utility.loggedInUser.AccountId != null &&
               (limitedTypes.indexOf(Utility.loggedInUser.Account.Type) != -1)){
                    isLimited = true;
                }else{
                    isLimited = false;
                }
            return isLimited;
        }set;
    }
    public static Boolean isBrand{
        get{
            if(isHybrid == false && Utility.loggedInUser.AccountId != null &&
               (brandTypes.indexOf(Utility.loggedInUser.Account.Type) != -1/*Utility.loggedInUser.Account.Type == ACCOUNT_TYPE_DISTRIBUTOR || Utility.loggedInUser.Account.Type == ACCOUNT_TYPE_MANUFACTURER ||
                Utility.loggedInUser.Account.Type == ACCOUNT_TYPE_PRODUCER || Utility.loggedInUser.Account.Type == ACCOUNT_TYPE_CULTIVATOR ||
                Utility.loggedInUser.Account.Type == ACCOUNT_TYPE_SUPPLIER || Utility.loggedInUser.Account.Type == ACCOUNT_TYPE_DISTY_PARTNER*/)){
                    isBrand = true;
                }else{
                    isBrand = false;
                }
            return isBrand;
        }set;
    }
    public static Boolean isDisty{
        get{
            if(Utility.loggedInUser.AccountId != null &&
               (distyTypes.indexOf(Utility.loggedInUser.Account.Type) != -1/*Utility.loggedInUser.Account.Type == ACCOUNT_TYPE_DISTY_PARTNER*/)){
                    isDisty = true;
                }else{
                    isDisty = false;
                }
            return isDisty;
        }set;
    }
    //public static Boolean isHybrid = Utility.isHybrid;
    public static Boolean isHybrid{
        get{
            if(isHybrid == null){
                isHybrid = false;
                if(Utility.loggedInUser.AccountId != null && hybridTypes.indexOf(Utility.loggedInUser.Account.Type) != -1){
                    for(Account account: [SELECT Id FROM Account WHERE ParentId = :Utility.loggedInUser.AccountId LIMIT 1]){
                        isHybrid = true;
                    }
                }
            }
            return isHybrid;
        }set;
    }
    
    @AuraEnabled
    public static AuraResponse isCommunityPlusUser(){
        AuraResponse r = new AuraResponse('ProductsCtlr.isCommunityPlusUser()');
        
        User u = [SELECT Id, Name, User_License__c,  Has_Accepted_Terms__c FROM User WHERE Id=: UserInfo.getUserId()];
        Map<String, Community_Settings__c > Community_Settings= Community_Settings__c.getAll();
        Map<String, Marketplace_Navigation_Config__c> navigationConfig = Marketplace_Navigation_Config__c.getAll();
        if(Community_Settings.containsKey('default')){
            r.data.put('schedulePaymentURL', Community_Settings.get('default').Schedule_Payment_URL__c);
        }
        r.data.put('AccountType',Utility.loggedinUser.Account.Type);
        r.data.put('isCommunityPlusUser', 'Customer Community Plus'.equalsIgnoreCase(u.User_License__c));
        r.data.put('isBrand', isBrand);
        r.data.put('isHybrid', isHybrid);
        r.data.put('isDisty', isDisty);
        r.data.put('isLimited',isLimited);
        List<String> termsAndConditions = new List<String>();
        if(!u.Has_Accepted_Terms__c){
            for(Terms_and_condition__c tnc:[SELECT Term_and_condition__c FROM Terms_and_condition__c WHERE Is_Active__c = true ORDER BY Display_Order__c]){
                termsAndConditions.add(tnc.Term_and_condition__c);
            }
        }
        r.data.put('hasAcceptedTerms', u.Has_Accepted_Terms__c);
        r.data.put('termsAndConditions', termsAndConditions);
        r.data.put('navigationConfig',navigationConfig);
        
        
        for(MP_Menu__mdt MPAccess: [SELECT Id, MasterLabel ,Discard_Items__c FROM MP_Menu__mdt ] ){ 
            if(MPAccess.MasterLabel == MP_MENU_BRAND_USER){
                r.data.put('DiscardItem_Brand_Users', MPAccess.Discard_Items__c);
            } else if(MPAccess.MasterLabel == MP_MENU_COMMUNITY_PLUS_USER){
                r.data.put('DiscardItem_CommPlus_Users', MPAccess.Discard_Items__c);
            } else if(MPAccess.MasterLabel == MP_MENU_COMMUNITY_PLUS_AND_BRAND_USER) {
                r.data.put('DiscardItem_CommPlus_And_Brand_Users', MPAccess.Discard_Items__c);
            } else if(MPAccess.MasterLabel == MP_MENU_EXCEPT_COMMUNITY_PLUS_AND_BRAND_USER) {
                r.data.put('DiscardItem_Except_CommPlus_And_Brand_Users', MPAccess.Discard_Items__c);
            } else if(MPAccess.MasterLabel == MP_MENU_LIMITED_ACCESS) {
                r.data.put('DiscardItem_Limited_Access', MPAccess.Discard_Items__c);
            }
        }
        
        String[] FAQTypes = new String[]{};
            if(isBrand){
                FAQTypes = new String[]{'Brand','Both'};
                    }else{
                        FAQTypes = new String[]{'Retailer','Both'};
                            }
        r.data.put('FAQs',[SELECT Id FROM FAQ__c WHERE Type__c IN :FAQTypes].size());
        System.debug('r1234='+r);
        return r;
    }
    
    private static String getQuery(List<String> fields, List<String> filters, String orderBy, Integer maxRecords){
        String query = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ' FROM PricebookEntry ';
        List<String> ORfilters = new List<String>();
        filters.addAll(new List<String>{
            'Product2Id != null',
                'Product2.RecordType.Name = :recordTypeName',
                'Product2.IsActive = true',
                'Product2.Hide_From_Marketplace__c = false',
                ' (Product2.Producer_Name__r.Hide_from_Marketplace__c = false OR (Product2.Licensee_Name__c != NULL AND Product2.Licensee_Name__r.Hide_From_Marketplace__c = false )) ',
                'Product2.Is_Sample__c = false'
                });
        
        for(Product_Categories__c pc : [SELECT Id, Category__c ,Name,Icon_Name__c ,Product_Families__c FROM Product_Categories__c WHERE Icon_Name__c != null Order By Sort_Order__c]){
            if(pc.Product_Families__c != null && pc.Product_Families__c != ''){
                productFamilies.addAll(pc.Product_Families__c.split(';'));
            }
        }
        filters.add('(Product2.Family IN : productFamilies)');
        
        if(!isBrand || isHybrid){
            filters.add('Product2.Hide_From_Retailer__c = false');
            priceBooks.add(priceBookId);
            //priceBooks.addAll(Utility.hybridPriceBooks);
            filters.addAll(new List<String>{'PriceBook2Id IN :priceBooks'});//,'Product2.Producer_Name__c IN :brandNames'
            if(!exlcudeBrandIds.isEmpty()){
                filters.add('Product2.Producer_Name__c NOT IN :exlcudeBrandIds');
            }
            
            //filters.add('(NOT Product2.Family LIKE :excludeBulk)');
        }else if(isDisty){
            distyPriceBooks.add(priceBookId);
            filters.addAll(new List<String>{'PriceBook2Id IN :distyPriceBooks'});
        }else{
            filters.add('PriceBook2Id = :priceBookId');
        }
        
        if(!filters.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(filters, ' AND '));
        }
        if(isBrand && !isHybrid && !isDisty && !isBrandProducts){
            query += ' AND( (Product2.Producer_Name__c = :brandId AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c = :brandId AND Product2.White_Labelled__c = true))';
        }else if(isDisty){
            distyBrandNames.add(brandId);
            query += ' AND( (Product2.Producer_Name__c IN :distyBrandNames AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c IN :distyBrandNames AND Product2.White_Labelled__c = true))';
        }else if(isBrandProducts){
            query += ' AND( (Product2.Producer_Name__c = :searchBrandId AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c = :searchBrandId AND Product2.White_Labelled__c = true))';
        }
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy) +',Product2.Available_Qty__c DESC';
        }
        query += ' LIMIT ' + maxRecords;
        System.debug('##query::'+query);
        return query;
    }
    
    public static void getValues(Map<String, Object> filters, String key, List<String> values){
        for(Object strObj: (List<Object>)filters.get(key)){
            values.add(String.valueOf(strObj));
        }
    }
    
    public static void getValues(Map<String, Object> filters, String key, List<Integer> values){
        for(Object intObj: (List<Object>)filters.get(key)){
            values.add(Integer.valueOf(intObj));
        }
    }
    
    public static Boolean hasFilter(Map<String, Object> filters, String key){
        return filters.containsKey(key) && String.isNotBlank(String.valueOf(filters.get(key)));
    }
    
    public static Boolean hasListFilter(Map<String, Object> filters, String key){
        return filters.containsKey(key) && !((List<Object>)filters.get(key)).isEmpty();
    }
    
    private static Order__c getDraftOrder(){
        String orderStatus = STATUS_DRAFT;
        for(Order__c o :[SELECT Name, Shipping_Street__c, Shipping_Country__c,Order_Type__c, Shipping_Province__c, Shipping_City__c, Shipping_Zip__c FROM Order__c WHERE Status__c = :orderStatus AND Customer__c = :UserInfo.getUserId()]){
            return o;
        }
        Id rdtRecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get(ORDER_RECORD_TYPE_NAME_RETAILER).getRecordTypeId();
        Order__c o = new Order__c(Customer__c = UserInfo.getUserId(),
                                  Order_Date__c = System.NOW(),
                                  Order_Type__c = ORDER_TYPE_RETAIL,
                                  Status__c = orderStatus,
                                  RecordTypeId = rdtRecordTypeId,
                                  Account__c = Utility.loggedInUser.AccountId,
                                  Retailer__c = Utility.loggedInUser.AccountId,
                                  Retailer_Contact__c = Utility.loggedInUser.ContactId);
        insert o;
        return o;
    }
    
    private static Order_Line_Item__c getOrderLineItem(Order__c o, String productId, String pricebookId){
        for(Order_Line_Item__c oli :[SELECT Quantity_Cases__c, UnitPrice__c, Is_Sample__c FROM Order_Line_Item__c WHERE Order__c = :o.Id AND Order__r.Customer__c = :UserInfo.getUserId() AND Product__c = :productId]){
            return oli;
        }
        Product2 prodDetails = [SELECT Id,White_Labelled__c,MOQ__c ,Producer_Name__c , Licensee_Name__c FROM Product2 WHERE Id=:productId];
        String ownerId = '';
        if(prodDetails.White_Labelled__c){
            ownerId = prodDetails.Licensee_Name__c;
        }else{
            ownerId = prodDetails.Producer_Name__c;
        }
        Order_Line_Item__c oli = new Order_Line_Item__c(Order__c = o.Id,
                                                        Price_Book_Entry_Id__c = pricebookId,
                                                        Product__c = productId,
                                                        Quantity_Cases__c = 0,
                                                        UnitPrice__c = 0,
                                                       Ownership_Code__c = ownerId,
                                                       MOQ__c = prodDetails.MOQ__c);
        insert oli;
        return oli;
    }
    
    @AuraEnabled
    public static AuraResponse filigreenThemeInit(){
        AuraResponse r = new AuraResponse('ProductsCtlr.filigreenThemeInit()');
        r.data.put('isBrand',isBrand);
        r.data.put('isLimited',isLimited);
        r.data.put('baseUrl', Site.getBaseUrl());
        r.data.put('mobileErr', ERR_ON_MOBILE_VIEW);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getShortURL(String currentURL,String brndId){
        
        List<Bitly_Config__mdt>bitlyConfigList = [SELECT Id, Access_Token__c, Domain__c, Endpoint_URL__c, Group_Guid__c FROM
												  Bitly_Config__mdt];
        
        AuraResponse r = new AuraResponse('ProductsCtlr.getShortURL()');
        
        if(bitlyConfigList.size() > 0){
            string paramvalue = EncodingUtil.base64Encode(Blob.valueOf(brndId));
            currentURL = currentURL + paramvalue;

            HttpRequest req = new HttpRequest();
            req.setEndpoint(bitlyConfigList[0].Endpoint_URL__c);
            req.setMethod('POST');
            req.setHeader('Authorization', 'Bearer ' + bitlyConfigList[0].Access_Token__c);
            req.setHeader('Accept', 'application/json');
            req.setHeader('Content-Type', 'application/json');
            req.setBody(JSON.serialize(new Map<String, Object>{'group_guid' => bitlyConfigList[0].Group_Guid__c ,'domain' => bitlyConfigList[0].Domain__c ,'long_url' => currentURL}));  
            HttpResponse res = new Http().send( req );    
            Map<String, Object> response = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            System.debug('response = '+response.get('link'));
            
            r.data.put('link', response.get('link'));
        }
        
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getCategories(){
        AuraResponse r = new AuraResponse('ProductsCtlr.getCategories()');
        Product_Categories__c[] categories = [SELECT Id, Category__c ,Name,Icon_Name__c ,Product_Families__c  FROM Product_Categories__c WHERE Icon_Name__c != null Order By Sort_Order__c];//Product_Categories__c.getAll().values();
        r.data.put('categories', categories);
        List<String> termsAndConditions = new List<String>();
        for(Terms_and_condition__c tnc:[SELECT Term_and_condition__c FROM Terms_and_condition__c WHERE Is_Active__c = true ORDER BY Display_Order__c]){
            termsAndConditions.add(tnc.Term_and_condition__c);
        }
        r.data.put('termsAndConditions', termsAndConditions);
        Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
        r.data.put('companyCustomSetting', ccs);
        if(ccs.Default_License__c != NULL){
            State_Licenses__c[] STs = [SELECT Id,Name,License_Number__c FROM State_Licenses__c WHERE Id = :ccs.Default_License__c];
            if(STs.size() > 0){
                r.data.put('STName', STs[0].License_Number__c);
            }
            ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId = :ccs.Default_License__c ];
            System.debug('##'+files);
            if(!files.isEmpty()){
                if(ccs.Default_License__c != null){
                    String docIds = '';
                    String comma = '';
                    String[] pdfIds = new String[]{};
                    String[] otherIds = new String[]{};
                    for(ContentDocumentLink l:files){
                        if(l.LinkedEntityId == ccs.Default_License__c){
                            System.debug('l.ContentDocument.FileExtension::'+l.ContentDocument.FileExtension);
                            if(l.ContentDocument.FileExtension == 'pdf') pdfIds.add(l.ContentDocumentId);
                        }
                    }
                    docIds = (!pdfIds.isEmpty()?String.join(pdfIds,','):'');
                    r.data.put('STFiles', docIds);
                }
            }
        }
        return r;
    }
    @AuraEnabled
    public static AuraResponse getTrainingVideos(){
        AuraResponse r = new AuraResponse('ProductsCtlr.getTrainingVideos()');
        List<TrainingVideo> trainingVideos = new List<TrainingVideo>();
        Map<String, Marketplace_Navigation_Config__c> navigationConfig = Marketplace_Navigation_Config__c.getAll();
        /*map<String,Integer> SortableOrderMap = new Map<String,Integer>{'Orders'=>0,'Transfers'=>1,'Services'=>2,'Products'=>3,'Inventory'=>4,'Retailers'=>5,'Finance'=>6,'Reports'=>7};*/
        Map<String,Training_Videos_Config__mdt[]> trainingVideosMap = new Map<String,Training_Videos_Config__mdt[]>();
        for(Training_Videos_Config__mdt tv : [SELECT Id, MasterLabel,Menu_Name__c,Sub_Menu_Name__c,Url__c,URL_Label__c,Sort_Order__c,Menu_Sort_Order__c  FROM Training_Videos_Config__mdt ORDER By Menu_Sort_Order__c,Sort_Order__c ASC] ){
            if(trainingVideosMap.containsKey(tv.Menu_Name__c)){
                trainingVideosMap.get(tv.Menu_Name__c).add(tv);
            }else{
                trainingVideosMap.put(tv.Menu_Name__c, new Training_Videos_Config__mdt[]{tv});
            }
            
        } 
        for(String key:trainingVideosMap.keySet()){
            TrainingVideo tv = new TrainingVideo(key,navigationConfig.get(key).Icon__c);
            Training_Videos_Config__mdt[] links = trainingVideosMap.get(key);
            if(links != NULL && links.size() > 0){
                for(Training_Videos_Config__mdt tvc:links){
                    tv.links.add(new TrainingVideoLink(tvc.Sub_Menu_Name__c,tvc.Url__c,tvc.URL_Label__c));
                }
            }
            trainingVideos.add(tv);
        }
        r.data.put('trainingVideos', trainingVideos);
        r.data.put('navigationConfig',navigationConfig);
        return r;
    }
    public class TrainingVideo{
        @AuraEnabled
        public String label{set;get;}
        @AuraEnabled
        public String icon{set;get;}
        @AuraEnabled
        public TrainingVideoLink[] links{set;get;}
        public TrainingVideo(String label,String icon){
            this.label = label;
            this.links = new TrainingVideoLink[]{};
                this.icon = '/filigreenb2b/resource/BrigadeResources/assets/icons/white/'+icon;
        }
    }
    public class TrainingVideoLink{
        @AuraEnabled
        public String label{set;get;}
        @AuraEnabled
        public String URL{set;get;}
        @AuraEnabled
        public String text{set;get;}
        
        
        public TrainingVideoLink(String label,String URL,String text){
            this.label = label;
            this.URL = URL;
            this.text = text;
            
        }
    }
    @AuraEnabled
    public static AuraResponse getCaseCategories(){
        AuraResponse r = new AuraResponse('ProductsCtlr.getCaseCategories()');
        Case[] categories = [SELECT Id, Status FROM Case];
        r.data.put('categories', categories);
        return r;
    }
    @AuraEnabled
    public static AuraResponse printCaseDetails(String recordId){
        AuraResponse r = new AuraResponse('ProductsCtlr.printCaseDetails()');
        List<Case> c = [SELECT Id, Account.Name, Description, Type, Owner_Information_Notes__c, CaseNumber, CreatedDate, ContactEmail, ContactPhone, Contact_Preference__c, Account.Image_URL__c, Subject, Priority, Status FROM Case where Id=: recordId];
        r.data.put('caseDetails', c);
        return r;
    }
    @AuraEnabled
    public static AuraResponse getIds(Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getIds()');
        List<String> whereParts = new List<String>();
        
        String orderByField = '';
        String direction = '';
        String searchTerm = '';
        String orderBy = '';
        List<String> families = new List<String>();
        
        if(!isBrand){
            whereParts.add('(Product2.Out_of_stock_product__c = true)');
        }
        
        if(filters != null){
            if(hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
            if(hasFilter(filters, SEARCHTERM_FILTER)){
                searchTerm = String.valueOf(filters.get(SEARCHTERM_FILTER));
                if(String.isNotBlank(searchTerm)){
                    if(searchTerm.isNumeric()){
                        Decimal price = Decimal.valueOf(searchTerm);
                        whereParts.add('(unitPrice =: price)');
                    } else {
                        searchTerm = '%' + searchTerm + '%';
                        whereParts.add('(Product2.Name LIKE :searchTerm OR Product2.Family LIKE :searchTerm OR Product2.Description LIKE :searchTerm OR Product2.Product_Short_Description__c LIKE :searchTerm OR Product2.Brand_Name__c LIKE :searchTerm OR Product2.Strain__r.Name LIKE :searchTerm OR Product2.Strain__r.Strain_Type__c LIKE :searchTerm)');// OR Product2.Producer_Name__r.DBA__c LIKE :searchTerm OR Product2.Producer_Name__r.Name LIKE :searchTerm OR Product2.Licensee_Name__r.DBA__c LIKE :searchTerm OR Product2.Licensee_Name__r.Name LIKE :searchTerm
                    }
                }
            }
            if(hasFilter(filters, BRAND_ID)){
                searchBrandId = String.valueOf(filters.get(BRAND_ID));
                if(String.isNotBlank(searchBrandId)){
                    isBrandProducts = true;
                }
            }else{
                isBrandProducts = false;
            }
            if(hasFilter(filters, FAMILIES_FILTER)){
                String family = String.valueOf(filters.get(FAMILIES_FILTER));
                if(String.isNotBlank(family)){
                    families = family.split(';');
                    whereParts.add('(Product2.Family IN :families)');
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        System.debug('whereParts= :'+whereParts);
        Set<Id> ids = new Set<Id>();
        //System.debug('Product2.Producer_Name__c='+Product2.Producer_Name__c);
        Map<Id,PricebookEntry> pbes = new Map<Id,PricebookEntry>((List<PricebookEntry>)Database.query(getQuery(new List<String>{'Id','Product2Id','Product2.Out_of_stock_product__c','Product2.Status__c','Product2.Producer_Name__c','PriceBook2Id'}, whereParts, orderBy, 49999)));
        
        Set<String> brandPriceBookSet = new Set<String>();
        if(!isBrand &&  !brandPriceBooks.isEmpty()){
            for(String bId: brandPriceBooks.keySet()){
                String brandPriceBook = bId+'-'+brandPriceBooks.get(bId);
                brandPriceBookSet.add(brandPriceBook);
            }
        }
        Set<Id> addedProducts = new Set<Id>();
        Map<Integer,Id> priceBookIdsMap = new Map<Integer,Id>();
        Integer i=0;
        List<PricebookEntry> ignoredPBEs = new List<PricebookEntry>();
        for(PricebookEntry pbe : pbes.values()){
            priceBookIdsMap.put(i++,pbe.Id);
            String brandPriceBook = pbe.Product2.Producer_Name__c+'-'+pbe.PriceBook2Id;
            if((!isBrand && brandPriceBookSet.contains(brandPriceBook)) || isBrand || isDisty){
                addedProducts.add(pbe.Product2Id);
            }else{
                ignoredPBEs.add(pbe);
            }
        }
        Set<Id> ignoredPBEIds = new Set<Id>();
        if(!isBrand && !isDisty){
            for(PricebookEntry pbe : ignoredPBEs){
                if(!(!addedProducts.contains(pbe.Product2Id) && pbe.PriceBook2Id == priceBookId)){
                    ignoredPBEIds.add(pbe.Id);
                }
            }
        }
        ids = pbes.keySet();
        ids.removeAll(ignoredPBEIds);
             
        r.data.put('ids', ids);
        r.data.put('isBrand', isBrand);
        r.data.put('brandId', brandId);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getProducts(List<String> ids, Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getProducts()');
        List<String> whereParts = new List<String>();
        String orderByField = '';
        String direction = '';
        String searchTerm = '';
        String orderBy = '';
        
        if(filters != null){
            if(hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        
       /* Set<String> bulkFamilies = new Set<String>();     
        for(Product_Categories__c pc : [SELECT Id, Category__c ,Name,Icon_Name__c ,Product_Families__c FROM Product_Categories__c WHERE Icon_Name__c != null Order By Sort_Order__c]){
            if(pc.Product_Families__c != null && pc.Product_Families__c != ''){
                if(pc.Name == 'Bulk' ){
                	bulkFamilies.addAll(pc.Product_Families__c.split(';'));
            	}
            }
        }*/
        
        Map<String, Product> records = new Map<String, Product>();
        Map<String, List<Product>> procuderProducts = new Map<String, List<Product>>();
        for(PricebookEntry pbe :(List<PricebookEntry>)Database.query(getQuery(new List<String>{'Product2.Out_of_stock_product__c','Product2.MSRP__c','UnitPrice','Product2.Status__c','Product2.RecordType.Name','Product2.Is_Sample__c','Product2.Parent_Product__c','Product2.Name', 'Product2.Family', 'Product2.Product_Rating__c', 'Product2.Available_Inventory__c','Product2.Inventory_On_Hold_Qty__c', 'Product2.Available_Qty__c', 'Product2.Total_Order_Qty__c','Product2.Description', 'Product2.Product_Short_Description__c', 'Product2.Product_Details__c', 'Product2.Producer_Name__r.dBA__c','Product2.Producer_Name__r.Name','Product2.Producer_Name__c','Product2.White_Labelled__c','Product2.Brand_Name__c', 'Product2.Cultivation_Type__c', 'Product2.Image_URL__c', 'Product2.MOQ__c', 'Product2.Strain__r.Name', 'Product2.Strain_Type__c', 'Product2.Terpene_percent__c','Product2.THC_Amount__c', 'Product2.THC_MG_G__c', 'Product2.CDB_Amount__c', 'Product2.CBD_MG_G__c','Product2.Fulfilled_by_Filigreen__c','Product2.Licensee_Name__c','Product2.Licensee_Name__r.Name'}, new List<String>{'Id IN :ids'}, orderBy, 49999))){
            System.debug(pbe.Product2Id);
            Product p = new Product(pbe);
            if(pbe.Product2.Family.startsWith('Bulk')){
                p.isBulkProduct = true;
            }else{
                p.isBulkProduct = false;
            }
            records.put(pbe.Product2Id, p);
            if(procuderProducts.containsKey(pbe.Product2.Producer_Name__c)){
                procuderProducts.get(pbe.Product2.Producer_Name__c).add(p);
            }else{
                procuderProducts.put(pbe.Product2.Producer_Name__c, new List<Product>{p});
            }
        }
        Map<Id,Id> productComplianceImageMap = new Map<Id,Id>();
        Set<Id> complianceIds = new Set<Id>();
        Map<Id,WarehouseAvailableInventory[]> warehouseAvailableInventoryMap = getWarehouseAvailableInventory(records.keySet());
        Set<Id> pbeIds = new Set<Id>();
        
        Set<Id> childIds = new Set<Id>();
        
        for(Product2 tmpProduct:[SELECT Id,Image_URL__c,Available_Qty__c,Status__c,(select id,Is_Sample__c,Parent_Product__c from Products__r), (SELECT Image_URL__c FROM Product_Images__r),(SELECT Id,Name, COA_Issued_Date__c  FROM Compliance_Images__r WHERE COA_Expiration_Date__c >= :System.today() Order By COA_Issued_Date__c DESC) FROM Product2 WHERE Id IN:records.keySet()]){
            if(tmpProduct.Compliance_Images__r.size() > 0){
                productComplianceImageMap.put(tmpProduct.Id,tmpProduct.Compliance_Images__r[0].Id);
                complianceIds.add(tmpProduct.Compliance_Images__r[0].Id);
            }
            Product p = records.get(tmpProduct.Id);
            p.hasSampleChild = false;
            if(tmpProduct.Products__r.size() > 0){
                //p.hasSampleChild = true;
                p.childProductId = tmpProduct.Products__r[0].Id;
                childIds.add(p.childProductId);
            } 
            
            p.setImages(tmpProduct);
            p.availableInventories = warehouseAvailableInventoryMap.get(tmpProduct.Id);
            if(!complianceIds.isEmpty()){
                System.debug('###complianceIds::'+complianceIds);
                ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId IN :complianceIds ];//AND ContentDocument.FileExtension = 'pdf'
                System.debug('##'+files);
                //ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title,ContentDocument.FileType FROM ContentDocumentLink WHERE LinkedEntityId IN: complianceIds AND ContentDocument.FileExtension = 'pdf'];
                if(!files.isEmpty()){
                    if(productComplianceImageMap.containsKey(p.Id)){
                        Id complianceId = productComplianceImageMap.get(p.Id);
                        if(complianceId != null){
                            String docIds = '';
                            String comma = '';
                            String[] pdfIds = new String[]{};
                            String[] otherIds = new String[]{};
                            for(ContentDocumentLink l:files){
                                if(l.LinkedEntityId == complianceId){
                                    if(l.ContentDocument.FileExtension == 'pdf') pdfIds.add(l.ContentDocumentId);
                                    else otherIds.add(l.ContentDocumentId);
                                }
                            }
                            docIds = (!pdfIds.isEmpty()?String.join(pdfIds,','):'');
                            if(String.isNotBlank(docIds)){
                                docIds += ','+(!otherIds.isEmpty()?String.join(otherIds,','):'');
                            }else{
                                docIds = (!otherIds.isEmpty()?String.join(otherIds,','):'');
                            }
                            p.complianceFileId = docIds;
                        }
                    }
                }
            }
        }
        
        
        for(PricebookEntry pbe :[SELECT Product2.MSRP__c,Product2.Status__c,UnitPrice,Product2.Is_Sample__c,Product2.Parent_Product__c,Product2.Name,Product2.Brand_Name__c,Product2.Family,Product2.Unit_Height__c,Product2.Retail_Unit_Form_Factor__c,
                                 Product2.Unit_Width__c,Product2.Unit_Radius__c,Product2.Unit_Length__c,Product2.Unit_Cubic_Volume__c,Product2.Product_Rating__c,Product2.Available_Inventory__c,Product2.Inventory_On_Hold_Qty__c,Product2.Available_Qty__c
                                 ,Product2.Total_Order_Qty__c,Product2.Description,Product2.Product_Short_Description__c,Product2.Product_Details__c,Product2.Producer_Name__r.dBA__c,Product2.Producer_Name__r.Name,Product2.Cultivation_Type__c,
                                 Product2.Image_URL__c,Product2.RecordType.Name,Product2.MOQ__c,Product2.Strain__r.Name,Product2.Strain_Type__c,Product2.Terpene_percent__c,Product2.THC_Amount__c,Product2.THC_MG_G__c,Product2.CDB_Amount__c,Product2.CBD_MG_G__c,
                                 Product2.Fulfilled_by_Filigreen__c,Product2.Licensee_Name__c,Product2.Licensee_Name__r.Name,Product2.White_Labelled__c 
                                 FROM PriceBookEntry 
                                 WHERE Product2Id IN : childIds
                                 AND PriceBook2Id IN: priceBooks]){
                                     
                                     Product p = records.get(pbe.Product2.Parent_Product__c);
                                     
                                     if(pbe.Product2.Available_Qty__c > 0){
                                         p.hasSampleChild = true;    
                                         p.sampleProduct = new Product(pbe);
                                     } else {
                                         p.hasSampleChild = false;     
                                     }
                                     
                                 }
        
        DateTime nowTime = System.now();
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Brand__c IN: procuderProducts.keySet() AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :nowTime ]){
            List<Product> products = procuderProducts.get(bd.Brand__c);
            if(products != null){
                for(Product p: products){
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
            }
        }
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Product_Name__c IN: records.keySet() AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :nowTime]){
            Product p = records.get(bd.Product_Name__c);
            if(p != null){
                if(p.discountPercent != null){
                    p.setProductDiscountPercent(bd.Discount_Percentage__c);
                }else{
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
                
            }
        }
        for(Product_Stock_Notification__c psn :[SELECT Product__c FROM Product_Stock_Notification__c WHERE Product__c IN :records.keySet() AND Sent_Notification__c = false]){
            records.get(psn.Product__c).notifyRequested(true);
        }
        
        r.data.put('records', records.values());
        r.data.put('warehouseTotalOrderedMap',getWarehouseOrderedMap(records.keySet()));
        r.data.put('warehouseAvailableInventory',getWarehouseAvailableInventory(records.keySet()));
        
        List<String> families = new List<String>();
        List<Schema.PicklistEntry> ple = Product2.Family.getDescribe().getPicklistValues();
        for(Schema.PicklistEntry f : ple){
            families.add(f.getValue());
        }
        r.data.put('families', families);
        
        List<String> ExceptionalFamilies = String.isNotBlank(System.Label.ExceptionalFamilies)?System.Label.ExceptionalFamilies.split(','):new List<String>();
        r.data.put('exceptionalFamilies', ExceptionalFamilies);
        r.data.put('isBrand', isBrand);
        return r;
    }
    @AuraEnabled
    public static AuraResponse globalSearch(String str){
        AuraResponse r = new AuraResponse('ProductsCtlr.globalSearch()');
        try{
        List<String> retailerTypes = System.Label.MP_Retailer_Types.split(',');
        
        List<String> LCFields = new List<String>{'Brand_Account_Rating__c','Brand_DBA__c','Retailer_Name__c', 'Retailer_DBA__c','Retailer_Name__r.Name','Retailer_Name__r.Image_URL__c','Retail_Account_Rating__c','Onboard_Date__c','Mutual_Payment_Terms__c','Retailer_Name__r.Phone','Retailer_Name__r.Fax','Retailer_Name__r.Website','Retailer_Name__r.BillingStreet','Retailer_Name__r.BillingCity','Retailer_Name__r.BillingState','Retailer_Name__r.BillingCountry','Retailer_Name__r.BillingPostalCode','Retailer_Name__r.LinkedIn__c','Retailer_Name__r.Facebook__c','Retailer_Name__r.Twitter__c','Retailer_Name__r.Instagram__c','Retailer_Name__r.About_Us__c'};
        String lcquery = 'SELECT ' + String.escapeSingleQuotes(String.join(LCFields, ', ')) + ' FROM Line_Card__c ';
        List<String> lcwhereParts = new List<String>();
        List<String> brandRetailerIds = new List<String>();
        lcwhereParts.add('Brand_Name__c = :brandId');
        lcwhereParts.add('Retailer_Name__r.Type IN :retailerTypes');
        if(!lcwhereParts.isEmpty()){
            lcquery += ' WHERE ' + String.escapeSingleQuotes(String.join(lcwhereParts, ' AND '));
        }
        for(Line_Card__c lc: (List<Line_Card__c>)Database.query(lcquery)){
            brandRetailerIds.add(lc.Retailer_Name__c);
        }
        
        List<String> whereParts = new List<String>();
        String orderBy = '';
        String searchTerm = '%'+str+'%';
        
        
        List<String> filters = new List<String>{
            'Product2Id != null',
                'Product2.RecordType.Name = :recordTypeName',
                'Product2.IsActive = true',
                'Product2.Hide_From_Marketplace__c = false',
                'Product2.Producer_Name__r.Hide_from_Marketplace__c = false',
                'Product2.Image_URL__c != null',
                'Product2.Is_Sample__c = false',
                'PriceBook2Id = :priceBookId'
                };
                    if(!isBrand || isHybrid){
                        filters.add('Product2.Hide_From_Retailer__c = false');
                    }
            if(!isBrand){
                filters.add('Product2.Out_of_stock_product__c = true');
            }
            filters.add('(Product2.Name LIKE :searchTerm OR Product2.Family LIKE :searchTerm OR Product2.Description LIKE :searchTerm OR Product2.Product_Short_Description__c LIKE :searchTerm OR Product2.Brand_Name__c LIKE :searchTerm OR Product2.Strain__r.Name LIKE :searchTerm OR Product2.Strain__r.Strain_Type__c LIKE :searchTerm)');
            String query = 'SELECT Id,Product2.Out_of_stock_product__c,Product2.Name,Product2.Brand_Name__c,Product2.Strain__r.Name,Product2.MOQ__c,Product2.Product_Short_Description__c,Product2.Family,Product2.Total_Order_Qty__c FROM PricebookEntry ';
            if(!filters.isEmpty()){
                query += ' WHERE ' + String.escapeSingleQuotes(String.join(filters, ' AND '));
            }
            if(isBrand && !isHybrid && !isDisty && !isBrandProducts){
                query += ' AND( (Product2.Producer_Name__c = :brandId AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c = :brandId AND Product2.White_Labelled__c = true))';
            }else if(isDisty){
                distyBrandNames.add(brandId);
                query += ' AND( (Product2.Producer_Name__c IN :distyBrandNames AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c IN :distyBrandNames AND Product2.White_Labelled__c = true))';
            }else if(isBrandProducts){
                query += ' AND( (Product2.Producer_Name__c = :searchBrandId AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c = :searchBrandId AND Product2.White_Labelled__c = true))';
            }
            query += ' ORDER BY Product2.Name DESC';
            System.debug('##str:'+str);
        List<PriceBookEntry> productsRecords = (List<PriceBookEntry>) Database.query(query);
        List<String> includeTypes = new List<String>{'Distributor','Cultivator','Manufacturer','Producer','Partner','Reseller'};    
        List<List<SObject>> searchList = [FIND :str IN ALL FIELDS RETURNING Order__c(Id,Name,Retailer__c,Retailer__r.Name,Retailer_DBA__c,Retailer_Contact__c,Total__c,Retailer_Contact__r.Name,State_License__c,State_License__r.Name,Status__c,Request_Ship_Date__c WHERE Account__c = :brandId), 
                                          Brand_Quote__c(Id,Name,BQ_Status__c,Opportunity_Name__c,Ship_Confirmation_Date__c,Opportunity_Name__r.Name,Supplier_Name__c,Supplier_DBA__c,Payment_Terms__c,Total_Product_Price__c WHERE Opportunity_Name__r.Order__r.Account__c = :brandId),
                                          Sales_Order__c(Id,Name,Brand_Quote__c,Brand_Quote__r.Name,Opportunity_Name__c,Opportunity_Name__r.Name,SO_Status__c,Receiver_Name__c,Receiver_Name__r.Name,Ship_Confirmation_Date__c,Planned_Ship_Date__c,Total_Price__c,Supplier_DBA__c,Supplier_Name__c,Receiver_DBA__c WHERE Brand_Quote__r.Opportunity_Name__r.Order__r.Account__c = :brandId),
                                          Invoice__c(Id,Name,AR_Status__c,Brand_Quote__c,Receiver_DBA__c,Supplier_DBA__c,Brand_Quote__r.Name,Opportunity_Name__c,Opportunity_Name__r.Name,Ship_Confirmation_Date__c,Total_Invoice_Amount__c,Total_Excise_Tax_Amount__c WHERE Brand_Quote__r.Opportunity_Name__r.Order__r.Account__c = :brandId),
                                          Purchase_Order__c(Id,Name,PO_Status__c,Brand_Quote__r.Name,Supplier_Payment_Settled_Date__c,Sold_to_Party_DBA__c,Opportunity_Name__r.Name,Ship_Confirmation_Date__c,Total_Cost__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Name WHERE Brand_Quote__r.Opportunity_Name__r.Order__r.Account__c = :brandId),
                                          Shipping_Manifest__c(Id,Name,Status__c,Receiver_Name__c,Supplier_DBA__c,Metrc_Manifest__c,Total_Line_Items__c,Receiver_DBA__c,Payment_Terms__c,Ship_Confirmation_Date__c,Planned_Ship_Transfer_Date__c WHERE Brand_Quote__r.Opportunity_Name__r.Order__r.Account__c = :brandId),
                                          Account(Id,Name,DBA__c,Licenses_Held__c,Payment_Terms__c,WebSite,BillingCity where Id IN :brandRetailerIds)]; 
            List<List<SObject>> brands = [FIND :str IN ALL FIELDS RETURNING Account(Id,Name,DBA__c,Licenses_Held__c,Payment_Terms__c,Website,BillingCity where Type IN :includeTypes AND Hide_From_Marketplace__c = false)]; 
            System.debug('##brands::'+brands);
            if(brands.size() > 0){
                r.data.put('brands', brands[0]);
            }
        r.data.put('searchList', searchList);
            r.data.put('isBrand', isBrand);
        r.data.put('records', productsRecords);
        r.data.put('contactRTId',Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Contact').getRecordTypeId());
        r.handleErrors();
        }catch(Exception e){
            r.data.put('Error',e.getMessage());
        }
        return r;    
    }
    @AuraEnabled
    public static AuraResponse getContacts(String producerId){
        AuraResponse r = new AuraResponse('ProductsCtlr.getContacts()');
        List<Map<String,String>> contacts = new List<Map<String,String>>();
        for(Contact con :[SELECT Id, Name FROM Contact WHERE AccountId = :producerId]){
            contacts.add(new Map<String,String>{'id' => con.Id,'name'=>con.Name});
        }
        System.debug('##contacts::'+contacts);
        r.data.put('contacts',contacts);
        return r;
    }
    @AuraEnabled
    public static LookupRecord[] getRecords(String objectName,String searchTerm, String value){
        LookupRecord[] licenseeAccounts = new LookupRecord[]{};
           
        String query = 'SELECT Id, Name  FROM '+objectName;
        
        
        
        if(String.isNotBlank(value)){
            query += ' WHERE Id =:value';
        }else{
            query +=' WHERE Name LIKE ' + '\'%' + String.escapeSingleQuotes(searchTerm.trim()) + '%\''; 
        }
        if('contact'.equalsIgnoreCase(objectName)){
            query+= ' AND AccountId=:brandId';
        }
        if(String.isBlank(value) && (('UID__c'.equalsIgnoreCase(objectName) || 'Harvest_Batch_Code__c'.equalsIgnoreCase(objectName)) || 'Strain__c'.equalsIgnoreCase(objectName))){
            if('UID__c'.equalsIgnoreCase(objectName)){
               // query += 'AND Active__c = true AND In_Use__c = false AND Voided__c = false Order By CreatedDate';
                query += 'AND Active__c = true  AND Voided__c = false Order By CreatedDate';
            } else {
                if('Strain__c'.equalsIgnoreCase(objectName)){
                    query+= ' AND isActive__c = true'; 
                }else{
                    query+= ' AND Active__c = true'; 
                }   
            }
        }
         query+= ' LIMIT 100';
       // query+= ' LIMIT 50000';
        for(sObject a : Database.query(query)){
            LookupRecord recordsData = new LookupRecord();
            recordsData.value = String.valueOf(a.get('Id'));
            recordsData.label = String.valueOf(a.get('Name'));
            licenseeAccounts.add(recordsData);
        }
        return licenseeAccounts;
    }
    
    @AuraEnabled
    public static LookupRecord[] getLicenseeAccounts(String searchTerm, String value){
        LookupRecord[] licenseeAccounts = new LookupRecord[]{};
            String query = 'SELECT Id, Dba__c  FROM Account';
        if(String.isNotBlank(value)){
            query += ' WHERE Id =:value';
        }else{
            query +=' WHERE Licensed_Verticals__c INCLUDES('+Licensed_Verticals+') AND (Dba__c LIKE ' + '\'' + String.escapeSingleQuotes(searchTerm.trim()) + '%\' OR Name LIKE ' + '\'' + String.escapeSingleQuotes(searchTerm.trim()) + '%\')' + ' LIMIT 50000';
        }
        
        for(Account a : (Account[])Database.query(query)){
            LookupRecord recordsData = new LookupRecord();
            recordsData.value = a.Id;
            recordsData.label = a.DBA__c;
            licenseeAccounts.add(recordsData);
        }
        return licenseeAccounts;
    }
    @AuraEnabled
    public static AuraResponse addLineCardInit(String retailerId,String lineCardId,Boolean isReailer){
        AuraResponse r = new AuraResponse('ProductsCtlr.addLineCardInit()');
        r.data.put('brandAccountRating', Utility.getPicklistItems('Line_Card__c', 'Brand_Account_Rating__c'));
        r.data.put('retailAccountRating', Utility.getPicklistItems('Line_Card__c', 'Retail_Account_Rating__c'));
        r.data.put('mutualPaymentTerms', Utility.getPicklistItems('Line_Card__c', 'Mutual_Payment_Terms__c'));
        LineCard lc = new LineCard();
        List<Contact> lstSalesReps = new List<Contact>();
        if(String.isNotBlank(retailerId)){
            if(isReailer){
                lc.retailerId = retailerId;
                lc.retailerName = [SELECT Dba__c FROM Account WHERE Id =:retailerId].Dba__c;
            }else{
                lc.brandNameId = retailerId;
                lc.brandName = [SELECT Dba__c FROM Account WHERE Id =:retailerId].Dba__c;
            }
            lstSalesReps = [select Id,Name from Contact where AccountId =: brandId AND Active__c = true Order By Name]; 
        }
        if(String.isNotBlank(lineCardId)){
            Line_Card__c lcard = [SELECT Name,Minimum_Order_Value__c, Brand_DBA__c,Brand_Name__c,Sales_Person__c,Sales_Person__r.Name,Retailer_DBA__c,Brand_Account_Rating__c,Retailer_Name__c,Retail_Account_Rating__c,Onboard_Date__c,Mutual_Payment_Terms__c FROM Line_Card__c WHERE Id =:lineCardId];
            lc = new LineCard(lcard);
        }
        r.data.put('lineCard',lc);
        r.data.put('salesReps',lstSalesReps);
        return r;
    }
    @AuraEnabled
    public static AuraResponse addLineCardSave(String lineCardData){
        AuraResponse r = new AuraResponse('ProductsCtlr.addLineCardSave()');
        Savepoint sp = Database.setSavepoint();
        try{
            System.debug('###lineCardData::'+lineCardData);
            LineCard lc = (LineCard) JSON.deserialize(lineCardData, LineCard.class);
            System.debug('###lineCard::'+lc);
            Line_Card__c lcc = new Line_Card__c(Id = (String.isNotBlank(lc.id)?lc.id:null));
            lcc.Brand_Name__c = lc.brandNameId;
            lcc.Brand_Account_Rating__c = lc.brandAccountRating;
            lcc.Retailer_Name__c = lc.retailerId;
            lcc.Retail_Account_Rating__c = lc.retailAccountRating;
            lcc.Onboard_Date__c = lc.onBoardDate;
            lcc.Mutual_Payment_Terms__c = lc.mutualPaymentTerms;
            lcc.Minimum_Order_Value__c = lc.minimumOrderValue != null ? lc.minimumOrderValue : 0;
            if(lc.salesPersonId != '' && lc.salesPersonId != null){
                lcc.Sales_Person__c =  lc.salesPersonId;   
            }
            PriceBook2[] pbs = [SELECT Id,Name FROM PriceBook2 WHERE Name =: STANDARD_PRICE_BOOK];
            if(!pbs.isEmpty()){
                lcc.Community_Price_Book__c = pbs[0].Id;
            }
            upsert lcc;
            r.handleErrors();
        }catch(Exception e){
            System.debug('####Exception:'+e.getMessage());
            r.handleException(e);
            Database.rollback(sp);
        }
        return r;
    }
    public class LineCard{
        @AuraEnabled
        public String id{set;get;}
        @AuraEnabled
        public String name{set;get;}
        @AuraEnabled
        public String brandNameId{set;get;}
        @AuraEnabled
        public String brandName{set;get;}
        @AuraEnabled
        public String salesPersonId{set;get;}
        @AuraEnabled
        public String salesPersonName{set;get;}
        @AuraEnabled
        public String retailerId{set;get;}
        @AuraEnabled
        public String retailerName{set;get;}
        @AuraEnabled
        public String brandAccountRating{set;get;}
        @AuraEnabled
        public String retailAccountRating{set;get;}
        @AuraEnabled
        public String mutualPaymentTerms{set;get;}
        @AuraEnabled
        public Decimal minimumOrderValue{set;get;}
        @AuraEnabled
        public Date onboardDate{set;get;}
        public LineCard(Line_Card__c lc){
            this.id = lc.Id;
            this.name = lc.Name;
            this.brandAccountRating = lc.Brand_Account_Rating__c;
            this.brandName = lc.Brand_DBA__c;
            this.brandNameId = lc.Brand_Name__c;
            this.retailerName = lc.Retailer_DBA__c;
            this.retailerId = lc.Retailer_Name__c;
            this.retailAccountRating = lc.Retail_Account_Rating__c;
            this.onboardDate = lc.Onboard_Date__c;
            this.mutualPaymentTerms = lc.Mutual_Payment_Terms__c;
            this.salesPersonId = lc.Sales_Person__c;
            this.salesPersonName = lc.Sales_Person__r.Name;
            this.minimumOrderValue = lc.Minimum_Order_Value__c != null ? lc.Minimum_Order_Value__c : 0;
        }
        public LineCard(){
            System.debug('##UserInfo.getUserId()::'+UserInfo.getUserId());
            if(isBrand){
                this.brandNameId = brandId;
                this.brandName = [SELECT Dba__c FROM Account WHERE Id =:brandId].Dba__c;
            }else{
                this.retailerId = brandId;
                System.debug('###brandId::'+brandId);
                this.retailerName = [SELECT Dba__c FROM Account WHERE Id =:brandId].Dba__c;
            }
            
            this.onboardDate = System.today();
        }
    }
    @AuraEnabled
    public static AuraResponse getStrainDetails(String recordId){
        AuraResponse r = new AuraResponse('ProductsCtlr.getStrainDetails()');
        r.data.put('strain',[SELECT Id, Name, Strain_Type__c FROM Strain__c WHERE Id = :recordId][0]);
        return r;
    }
    @AuraEnabled
    public static AuraResponse newProductInit(String recordId,String isClone){
        AuraResponse r = new AuraResponse('ProductsCtlr.newProductInit()');
        Product p = new Product();
        List<Fulfillment_Rates_Table__c> FRTList = new List<Fulfillment_Rates_Table__c>();
        List<FRTServiceType> FRTServiceTypeList = new List<FRTServiceType>();
        Map<String,List<String>> FRTMap = new Map<String,List<String>>();
        if(String.isNotBlank(recordId) || isClone.equals('True')){
            Product2 prod = [SELECT External_Data_ID__c,MSRP__c,Id, Status__c,Name,Description,Product_Details__c,Family,Quantity_Type__c,Cultivation_Type__c,IsActive,
                             Apply_Cultivation_Tax__c,Apply_Excise_Tax__c,Producer_Name__c,Producer_Name__r.Name,Cannabis_Category_1__c,Producer_Name__r.Membership_Level__c,
                             Cannabis_Category_2__c ,Unit_Cannabis_Weight_1__c,Cannabis_Ratio_1__c,Unit_Cannabis_Weight_2__c,Licensee_Name__c,Licensee_Name__r.Membership_Level__c,
                             Cannabis_Ratio_2__c,Unit_Cultivation_Tax_1__c,Retail_Unit_Form_Factor__c,Case_Shipping_Weight_lbs__c,
                             Unit_Height__c,Stocking_UOM__c,Unit_Width__c,Unit_Net_Weight__c,Unit_Length__c,
                             Unit_Gross_Weight__c,Unit_Radius__c,Case_Height__c,Supplier_UOM__c,Case_Width__c,
                             MOQ__c,Case_Length__c,Carton_Net_Weight__c,Case_Radius__c,Carton_Gross_Weight__c,
                             THC_Amount__c,THC_MG_G__c,CDB_Amount__c,CBD_MG_G__c,Terpene_percent__c,Alpha_Bisabolol__c,
                             Delta_3_Carene__c,Alpha_Pinene__c,Eucalyptol__c,Beta_Pinene__c,Limonene_percent__c,
                             Borneol__c,Linalool__c,Caryophyllene__c,Myrcene__c,Camphene__c,Terpineol__c,Unit_Shipping_Weight_lbs__c,
                             Lead_Time__c,Reorder_Point__c,Safety_Stock_Qty__c,Enable_Replenishment_Alert__c,
                             Safety_Stock_Low__c,Safety_Stock_Medium__c,Strain__c,Strain__r.Name,Strain_Type__c,
                             Safety_Stock_Contact_Name__c,Safety_Stock_Contact_Name__r.Name,Fulfilled_by_Filigreen__c,
                             Certifications__c, Appellation__c,Product_Short_Description__c,Brand_Name__c,Image_URL__c,Available_Qty__c 
                             FROM Product2
                             WHERE Id =: recordId];
            System.debug('###CBD::'+prod.CDB_Amount__c);
            if(isClone.equals('True')){
                prod.Unit_DIMs_Verified__c = False;
                Prod.Case_DIMs_Verified__c = False;
                prod.External_Data_ID__c = null;
                prod.Id =null;
                //prod.Name = '';
                prod.IsActive = false;
                prod.Total_Inventory__c =0;
                prod.ItemToPutAway__c =0;
                prod.Allocated_Inventory__c =0;
                prod.Total_Order_Qty__c = 0;
                prod.Inventory_On_Hold_Qty__c = 0;
                prod.Available_Inventory__c =0;
                prod.Max_Order_Allowed__c = 0;
                prod.Inbound_Qty__c = 0;
                prod.Track_Trace_Category__c = '';
               	prod.Unit_Net_Weight__c = 0;
                prod.Net_Weight_UOM__c = '';
                prod.Unit_Of_Measure__c = '';
                prod.Metrc_ItemID__c = '';
                prod.Metrc_HttpResponse__c = '';
                prod.Status__c = '';
                //prod.Product_Short_Description__c = '';
                p = new Product(prod);
            }else{
                p = new Product(prod);
            }
            String membershipLevel = '';
			List<State_Licenses__c> slList = new List<State_Licenses__c>(); 
            if(prod.Producer_Name__c != null){
                membershipLevel = prod.Producer_Name__r.Membership_Level__c;
               slList =  [SELECT id,Default_Warehouse__c FROM State_Licenses__c WHERE License_Name__c =: prod.Producer_Name__c AND Default_Warehouse__r.Active__c = true];
                  
            }else{
                if(prod.Licensee_Name__c != null){
                    membershipLevel = prod.Licensee_Name__r.Membership_Level__c;
                    slList =  [SELECT id,Default_Warehouse__c FROM State_Licenses__c WHERE License_Name__c =: prod.Licensee_Name__c AND Default_Warehouse__r.Active__c = true];
                }
            }
            Decimal weight = prod.Unit_Shipping_Weight_lbs__c;
            if(prod.MOQ__c > 1){
                weight = prod.Case_Shipping_Weight_lbs__c;
            }
            
            FRTList = [SELECT Id, Active__c, Fulfillment_Services__c,Weight_lbs__c,MOQ__c,Size_Classification__c,Bracket_Price__c,Site__r.Active__c,Site__r.Name,Site__c,Site__r.Warehouse_Name__c
                                                 FROM Fulfillment_Rates_Table__c 
                                                 WHERE Site__r.Active__c = true 
                                                 AND Active__c = true
                       							 AND RecordType.Name =: FRT_Record_Type_Item_Basis
                                                 AND Rate_Effective_From__c <= :System.today()
                                                 AND Rate_Effective_To__c >= :System.today()
                       							 AND Membership_Level__c =: membershipLevel
                                                 AND Fulfillment_Services__c IN (:FULFILLMENT_SERVICE_RECEIVING,:FULFILLMENT_SERVICE_QA_REVIEW,:FULFILLMENT_SERVICE_PICK_PACK)
                       							 ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
            if(FRTList.size() > 0){
                
                Map<String,List<Fulfillment_Rates_Table__c>> serviceBasedFRTMap = new Map<String,List<Fulfillment_Rates_Table__c>>();
                for(Fulfillment_Rates_Table__c FRT : FRTList){
                    if(serviceBasedFRTMap.containsKey(FRT.Fulfillment_Services__c+' - '+FRT.Site__c)){
                            serviceBasedFRTMap.get(FRT.Fulfillment_Services__c+' - '+FRT.Site__c).add(FRT);
                        }else{
                            serviceBasedFRTMap.put(FRT.Fulfillment_Services__c+' - '+FRT.Site__c,new List<Fulfillment_Rates_Table__c>{FRT});
                        }
                    /*if(FRTMap.containsKey(FRT.Fulfillment_Services__c) && !checkFRT.containsKey(FRT.Fulfillment_Services__c+' - '+FRT.Site__c)){
                        FRTMap.get(FRT.Fulfillment_Services__c).add(FRT.Site__r.Warehouse_Name__c+' - '+FRT.Size_Classification__c+' - $' +FRT.Bracket_Price__c);
                        checkFRT.put(FRT.Fulfillment_Services__c+' - '+FRT.Site__c,FRT);
                        
                    }else{
                        checkFRT.put(FRT.Fulfillment_Services__c+' - '+FRT.Site__c,FRT);
                        String str = FRT.Site__r.Warehouse_Name__c+' - '+FRT.Size_Classification__c+' - $' +FRT.Bracket_Price__c;
                        FRTMap.put(FRT.Fulfillment_Services__c,new List<String>{str});
                        
                    }*/
                }
                for(String fKay  :serviceBasedFRTMap.keySet()){
                    String FeeDetails ='';
                    integer i=0;
                    for(Fulfillment_Rates_Table__c FRT: serviceBasedFRTMap.get(fKay)){
                        if(FRT.Weight_lbs__c  <= weight && FRT.MOQ__c <= prod.MOQ__c && i<=0){
                            System.debug('###FRT for Receiving_Fee:'+FRT);
                            FeeDetails = FRT.Site__r.Warehouse_Name__c+' - '+FRT.Size_Classification__c+' - $' +(FRT.Fulfillment_Services__c != FULFILLMENT_SERVICE_PICK_PACK ? (FRT.Bracket_Price__c * prod.MOQ__c) : FRT.Bracket_Price__c);
                            if(FRTMap.containsKey(FRT.Fulfillment_Services__c)){
                                FRTMap.get(FRT.Fulfillment_Services__c).add(FeeDetails);
                            }else{
                                FRTMap.put(FRT.Fulfillment_Services__c,new List<String>{FeeDetails});
                            }
                            //FRTServiceType frtST = new FRTServiceType(FRT.Fulfillment_Services__c,str);
                            i++;
                        }
                    }
                }
                for(String FeeDetails : FRTMap.keySet()){
                    FRTServiceType frtST = new FRTServiceType(FeeDetails,FRTMap.get(FeeDetails));
                    FRTServiceTypeList.add(frtST);
                }
            }
            
        }
        r.data.put('product', p);
         r.data.put('FRTMap', FRTServiceTypeList);
        
        
        List<Map<String, String>> brandContacts = new List<Map<String, String>>();
        if(p.producerId == NULL){
            p.producerId = brandId;
        }
        
        for(Contact con: [SELECT Id, Name FROM Contact WHERE AccountId =:p.producerId]){
            brandContacts.add(new Map<String,String>{'id'=>con.id,'name'=>con.Name});
        }
        r.data.put('notificationContacts', brandContacts);
        List<Map<String, String>> productFamilyOptions = new List<Map<String, String>>();
        //productFamilyOptions.add(new Map<String, String>{'label'=> 'None', 'value'=> ''});
        //productFamilyOptions.addAll(Utility.getPicklistItems('Product2', 'Family'));
        
        List<Exclude_Product_Families__c> lstExclude = new List<Exclude_Product_Families__c>([SELECT ID,Name FROM Exclude_Product_Families__c]);
        
        for(Map<String, String> mapStr : Utility.getPicklistItems('Product2', 'Family')){
            Boolean isExclude = false;
            for(Exclude_Product_Families__c exe : lstExclude){
                if(exe.Name == mapStr.get('label')){
                    isExclude = true;
                }
            } 
            if(!isExclude){
            	productFamilyOptions.add(mapStr);    
            }
        }
        if(Utility.loggedinUser.Account.Type == ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER){
            r.data.put('isFINInterest', true);
        }else{
            r.data.put('isFINInterest', false);
        }
        r.data.put('productFamily', productFamilyOptions);
        r.data.put('quantityType', Utility.getPicklistItems('Product2', 'Quantity_Type__c'));
        List<Map<String, String>> cultvationOptions = new List<Map<String, String>>();
        //cultvationOptions.add(new Map<String, String>{'label'=> 'None', 'value'=> ''});
        cultvationOptions.addAll(Utility.getPicklistItems('Product2', 'Cultivation_Type__c'));
        r.data.put('cultivationType', cultvationOptions);
        r.data.put('certificationOptions', Utility.getPicklistItems('Product2', 'Certifications__c'));
        r.data.put('appellationOptions', Utility.getPicklistItems('Product2', 'Appellation__c'));
        List<Map<String, String>> marketplaceBrandOptions = new List<Map<String, String>>();
        //marketplaceBrandOptions.add(new Map<String, String>{'label'=> 'None', 'value'=> ''});
        marketplaceBrandOptions.addAll(Utility.getPicklistItems('Product2', 'Brand_Virtual_Name__c'));
        r.data.put('marketplaceBrandOptions', marketplaceBrandOptions);
        r.data.put('cannabisWeightUOM', Utility.getPicklistItems('Product2', 'Cannabis_Weight_UOM__c'));
        r.data.put('applyCultivationTax', Utility.getPicklistItems('Product2', 'Apply_Cultivation_Tax__c'));
        r.data.put('applyExciseTax', Utility.getPicklistItems('Product2', 'Apply_Excise_Tax__c'));
        List<Map<String, String>> cannabisCategory1options = new List<Map<String, String>>();
        //cannabisCategory1options.add(new Map<String, String>{'label'=> 'None', 'value'=> ''});
        cannabisCategory1options.addAll(Utility.getPicklistItems('Product2', 'Cannabis_Category_2__c'));
        r.data.put('cannabisCategory1', cannabisCategory1options);
        List<Map<String, String>> options = new List<Map<String, String>>();
        //options.add(new Map<String, String>{'label'=> 'None', 'value'=> ''});
        options.addAll(Utility.getPicklistItems('Product2', 'Cannabis_Category_2__c'));
        r.data.put('cannabisCategory2', options);
        r.data.put('retailUnitFormFactor', Utility.getPicklistItems('Product2', 'Retail_Unit_Form_Factor__c'));
        r.data.put('stockingUOM', Utility.getPicklistItems('Product2', 'Stocking_UOM__c'));
        r.data.put('supplierUOM', Utility.getPicklistItems('Product2', 'Supplier_UOM__c'));
        r.data.put('brandId',brandId);
        r.data.put('brandName',[SELECT Dba__c FROM Account WHERE Id =:brandId].Dba__c);
        r.data.put('productFamilyDependency',Utility.getFieldDependencies('Product2','Family','Quantity_Type__c'));
        r.data.put('productFamilyDependencyStockingUOM',Utility.getFieldDependencies('Product2','Quantity_Type__c','Stocking_UOM__c'));
        r.data.put('productFamilyDependencyCultivationType',Utility.getFieldDependencies('Product2','Family','Cultivation_Type__c'));
        String Certifications_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Certifications_Tooltip');
        r.data.put('Certifications_Tooltip', Certifications_Tooltip != null ? Certifications_Tooltip : '');
        String External_Id_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','External_Id_Tooltip');
        r.data.put('External_Id_Tooltip', External_Id_Tooltip != null ? External_Id_Tooltip : '');
        r.data.put('MOQ_Tooltip', PRODUCT_MOQ_TOOLTIP);
        String Msg_for_RetailWholesalePrice_Tooltip = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Msg_for_RetailWholesalePrice_Tooltip');
        r.data.put('Msg_for_RetailWholesalePrice_Tooltip', Msg_for_RetailWholesalePrice_Tooltip != null ? Msg_for_RetailWholesalePrice_Tooltip : '');
        return r;
    }
    public class FRTServiceType{
        @AuraEnabled
        public String label{set;get;}
        @AuraEnabled
        public String[] FRTPrice{set;get;}
        public FRTServiceType(String label,String[] FList){
            this.label = label;
            this.FRTPrice = FList;
        }
    }
    @AuraEnabled
    public static AuraResponse saveNewProduct(String recordId,String newProductData){
        AuraResponse r = new AuraResponse('ProductsCtlr.saveNewProduct()');
        Savepoint sp = Database.setSavepoint();
        try{
            Product p = (Product)JSON.deserialize(newProductData, Product.class);
            System.debug('####p.safetyStockContact:'+p.safetyStockContact);
            Product2 prod = new Product2(Id=(String.isNotBlank(recordId)?recordId:null));
            prod.RecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get(PRODUCT_RECORD_TYPE_NAME_PRODUCT).getRecordTypeId();
            prod.Name = (String.isNotBlank(recordId)?p.Name:p.shortDescription);
            prod.Product_Origin__c = PRODUCT_ORIGIN_MARKETPLACE;
            if(prod.Id == NULL)
                prod.IsActive = false;
            prod.Status__c = p.status;
            prod.Auto_Allocation__c = false;
            prod.Description = p.description;
            prod.Product_Details__c = p.productDetails;
            prod.Product_Short_Description__c = (String.isNotBlank(recordId)?p.shortDescription:prod.Name);//(prod.Description != null?(prod.Description.length()>30? prod.Description.substring(0,30):''):'');
            prod.Family = p.productFamily;
            prod.Quantity_Type__c = p.quantityType;
            prod.Cultivation_Type__c = p.cultivationMethod;
            prod.Apply_Cultivation_Tax__c = p.applyCultivationTax;
            prod.Apply_Excise_Tax__c = p.applyExciseTax;
            prod.Producer_Name__c = p.producerId;
            prod.Net_Weight_UOM__c = NULL;
            if(p.producerId != brandId ){
                prod.White_Labelled__c = true;
                prod.Licensee_Name__c = brandId;
            }else{
                
                prod.White_Labelled__c = false;
                prod.Licensee_Name__c = null;
            }
            if(p.isFlowers == true || p.isLeaves == true || p.isFresh == true){
                prod.Cannabis_Category_1__c = p.cannabisCategory1; 
                prod.Unit_Cannabis_Weight_1__c = p.unitCannabisWeight1;
                prod.Cannabis_Ratio_1__c = p.cannabisRatio1;
            }
            if(p.isFlowers == true && p.isLeaves == true){
                prod.Cannabis_Category_2__c = p.cannabisCategory2;
                prod.Cannabis_Ratio_2__c = p.cannabisRatio2;
                prod.Unit_Cannabis_Weight_2__c = p.unitCannabisWeight2; 
            }
            
            
            //prod.Unit_Cultivation_Tax_1__c = p.unitCultivationTax;
            prod.Retail_Unit_Form_Factor__c = p.retailUnitFormFactor;
            prod.Unit_Height__c = p.unitHeight;
            prod.Stocking_UOM__c = p.stockingUOM;
            prod.Unit_Width__c = p.unitWidth;
            prod.Unit_Net_Weight__c = p.unitNetWeight;
            prod.Unit_Length__c = p.unitlength;
            prod.Unit_Gross_Weight__c = p.unitGrossWeight;
            prod.Unit_Radius__c = p.unitRadius;
            prod.Case_Height__c = p.caseHeight;
            prod.Supplier_UOM__c = p.supplierUOM;
            
            prod.Case_Width__c = p.caseWidth;
            prod.MOQ__c = p.MOQ;
            prod.Case_Length__c = p.caseLength;
            prod.Carton_Net_Weight__c = p.cartonNetWeight;
            prod.Case_Radius__c = p.caseRadius;
            prod.Carton_Gross_Weight__c = p.cartonGrossWeight;
            prod.THC_Amount__c = p.THC;
            prod.THC_MG_G__c = p.THCMGG;
            prod.CDB_Amount__c = p.CBD;
            Prod.CBD_MG_G__c = p.CBDMGG;
            prod.Terpene_percent__c = p.terpene;
            prod.Alpha_Bisabolol__c = p.alphaBisabolol;
            prod.Delta_3_Carene__c = p.delta3Carene;
            prod.Alpha_Pinene__c = p.alphaPinene;
            prod.Eucalyptol__c = p.eucalyptol;
            prod.Beta_Pinene__c = p.betaPinene;
            prod.Limonene_percent__c = p.limonene;
            prod.Borneol__c = p.borneol;
            prod.Linalool__c = p.linalool;
            prod.Caryophyllene__c = p.caryophyllene;
            prod.Myrcene__c = p.myrcene;
            prod.Camphene__c = p.camphene;
            prod.Terpineol__c = p.terpineol;
            prod.Lead_Time__c = p.leadTime;
            prod.Reorder_Point__c = p.reorderPoint;
            prod.Safety_Stock_Qty__c = p.safetyStockQty;
            prod.Enable_Replenishment_Alert__c = p.enableReplenishmentAlert;
            if(p.safetyStockLow != null){
                prod.Safety_Stock_Low__c = p.safetyStockLow;
            }
            if(p.safetyStockMedium != null){
                prod.Safety_Stock_Medium__c = p.safetyStockMedium;
            }
            prod.Strain__c = p.strainId;
            if(p.safetyStockContact != '' && p.safetyStockContact != null){
                prod.Safety_Stock_Contact_Name__c = p.safetyStockContact;
            }
            prod.Brand_Virtual_Name__c = p.marketplaceBrand;
            prod.Certifications__c = p.certifications;
            prod.Appellation__c = p.appellation;
            prod.MSRP__c = p.MSRP;
            prod.External_Data_ID__c=p.ExternalDataID;
            System.debug('###prod:::'+prod);
            if(String.isNotBlank(recordId)){
                update prod;
            }else{
                insert prod;
            }
            
            r.handleErrors();
            
        }catch(Exception e){
            System.debug('####Exception:'+e.getMessage());
            r.handleException(e);
            Database.rollback(sp);
        }
        System.debug('###before return:::');
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getNewProductRequestIds(Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getNewProdductRequestIds()');
        List<String> whereParts = new List<String>();
        List<String> whereSearchParts = new List<String>();
        
        String orderByField = '';
        String direction = '';
        String searchTerm = '';
        String orderBy = '';
        String []families;
        system.debug('filters '+filters);
        if(filters != null){
            if(hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
            if(hasFilter(filters, SEARCHTERM_FILTER)){
                searchTerm = String.valueOf(filters.get(SEARCHTERM_FILTER));
                if(String.isNotBlank(searchTerm)){
                    searchTerm = '%' + searchTerm + '%';
                    whereParts.add('(Name LIKE :searchTerm OR Family LIKE :searchTerm OR Description LIKE :searchTerm OR Product_Short_Description__c LIKE :searchTerm OR Brand_Name__c LIKE :searchTerm OR Strain__r.Name LIKE :searchTerm OR Strain__r.Strain_Type__c LIKE :searchTerm OR Producer_Name__r.DBA__c LIKE :searchTerm OR Producer_Name__r.Name LIKE :searchTerm OR Licensee_Name__r.DBA__c LIKE :searchTerm OR Licensee_Name__r.Name LIKE :searchTerm)');
                }
            }
            if(hasFilter(filters, FAMILIES_FILTER)){
                String family = String.valueOf(filters.get(FAMILIES_FILTER));
                if(String.isNotBlank(family)){
                    families = family.split(';');
                    whereParts.add('(Family IN :families)');
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        
        List<String> fields = new List<String>{'Id'};
            String query = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ' FROM Product2 ';
        
        
        //if(!whereParts.isEmpty()){
        query += ' WHERE  ((Producer_Name__c = :brandId AND White_Labelled__c = false) OR(Licensee_Name__c = :brandId AND White_Labelled__c = true))';
        //}
        /*if(!whereSearchParts.isEmpty()){
            query += (whereParts.isEmpty()?' WHERE ':' AND ') + '('+ String.escapeSingleQuotes(String.join(whereSearchParts, ' OR '))+')';
        }*/
        
        if(!whereParts.isEmpty()){
            query += ' AND ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        }
        query += ' LIMIT 49999';
        System.debug('query: ' + query);
        
        List<String> ids = new List<String>();
        for(Product2 p :(List<Product2>)Database.query(query)){
            ids.add(p.Id);
        }
        
        r.data.put('ids', ids);
        return r;
    }
    
    @AuraEnabled(cacheable=true)
    public static AuraResponse getNewProductRequests(List<String> ids, Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getNewProductRequests()');
        List<String> whereParts = new List<String>();
        String orderByField = '';
        String direction = '';
        String searchTerm = '';
        String orderBy = '';
        String []families;
        if(filters != null){
            if(hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
            if(hasFilter(filters, SEARCHTERM_FILTER)){
                searchTerm = String.valueOf(filters.get(SEARCHTERM_FILTER));
                if(String.isNotBlank(searchTerm)){
                    searchTerm = '%' + searchTerm + '%';
                    whereParts.add('(Name LIKE :searchTerm OR Family LIKE :searchTerm OR Description LIKE :searchTerm OR Product_Short_Description__c LIKE :searchTerm OR Brand_Name__c LIKE :searchTerm OR Strain__r.Name LIKE :searchTerm OR Strain__r.Strain_Type__c LIKE :searchTerm OR Producer_Name__r.DBA__c LIKE :searchTerm OR Producer_Name__r.Name LIKE :searchTerm OR Licensee_Name__r.DBA__c LIKE :searchTerm OR Licensee_Name__r.Name LIKE :searchTerm)');
                }
            }
            if(hasFilter(filters, FAMILIES_FILTER)){
                String family = String.valueOf(filters.get(FAMILIES_FILTER));
                if(String.isNotBlank(family)){
                    families = family.split(';');
                    whereParts.add('(Family IN :families)');
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        
        List<String> fields = new List<String>{'Name','Status__c','Family','IsActive','StockKeepingUnit','Description','Producer_Name__c','Producer_Name__r.DBA__c','Brand_Name__c','Licensee_Name__c','Licensee_Name__r.DBA__c','MOQ__c','Product_Short_Description__c','Quantity_Type__c','White_Labelled__c','Strain__c','Strain__r.Name','Strain_Type__c','Apply_Cultivation_Tax__c','Apply_Excise_Tax__c','Product_Details__c'};
            whereParts.add('Id IN :ids');
        String query = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ' FROM Product2 ';
        
        if(!whereParts.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        }
        query += ' LIMIT 49999';
        System.debug('query: ' + query);
        
        r.data.put('records', Database.query(query));
        r.data.put('isBrand', isBrand);
        return r;
    }
   
    @AuraEnabled
    public static AuraResponse getRetailerIds(Map<String, Object> filters){
        System.debug('In getRetailerIds');
        AuraResponse r = new AuraResponse('ProductsCtlr.getRetailerIds()');
        List<String> retailerTypes = System.Label.MP_Retailer_Types.split(',');
        List<String> whereParts = new List<String>();
        List<String> whereSearchParts = new List<String>();
        List<String> ids = new List<String>();
        String orderByField = '';
        String direction = '';
        String searchTerm = '';
        String orderBy = '';
        String retailerFilter = '';
        List<String> lcwhereParts1 = new List<String>();
        if(filters != null){
            if(hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
            if(hasFilter(filters, RETAILER_FILTER)){
                retailerFilter = String.valueOf(filters.get(RETAILER_FILTER));
            }
            if(hasFilter(filters, SEARCHTERM_FILTER)){
                searchTerm = String.valueOf(filters.get(SEARCHTERM_FILTER));
                if(String.isNotBlank(searchTerm)){
                    searchTerm = '%' + searchTerm + '%';
                    whereSearchParts.add('(DBA__c LIKE :searchTerm)');
                    whereSearchParts.add('(Name LIKE :searchTerm)');
                    whereSearchParts.add('(BillingCity LIKE :searchTerm)');
                    if(String.isNotBlank(retailerFilter) && retailerFilter.endsWithIgnoreCase('My Retailers')){
                        lcwhereParts1.add('(Retailer_Name__r.DBA__c LIKE :searchTerm)');
                        lcwhereParts1.add('(Retailer_Name__r.Name LIKE :searchTerm)');
                        lcwhereParts1.add('(Retailer_Name__r.BillingCity LIKE :searchTerm)');    
                    }
                }
            }
            
        }
        if(filters != null && hasFilter(filters, SEARCHTERM_FILTER) && String.isNotBlank(searchTerm)){
            Set<Id> licencesIds = new Set<Id>();
            
            for(State_Licenses__c stl : [SELECT Id,License_Name__c, Name,License_Number__c,License_Status__c FROM State_Licenses__c WHERE License_Number__c LIKE :searchTerm AND License_Status__c =: STATE_LICENSE_ACTIVE
                                         AND License_Name__r.Type IN :retailerTypes]){
                                             licencesIds.add(stl.License_Name__c);
                                         }
            
            if(licencesIds.size() > 0){
                whereSearchParts.add('(Id IN :licencesIds)');
                if(String.isNotBlank(retailerFilter) && retailerFilter.endsWithIgnoreCase('My Retailers')){
                        lcwhereParts1.add('(Retailer_Name__c IN :licencesIds)');
                }
            }
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        r.data.put('contactRTId',Schema.SObjectType.Contact.getRecordTypeInfosByName().get(CONTACT_RECORD_TYPE_NAME_CONTACT).getRecordTypeId());
        List<String> fields = new List<String>{'Id'};
        List<String> LCFields = new List<String>{'Brand_Account_Rating__c','Minimum_Order_Value__c','Brand_DBA__c','Sales_Person__c','Sales_Person__r.Name','Retailer_Name__c', 'Retailer_DBA__c','Retailer_Name__r.Name','Retailer_Name__r.Hide_from_Marketplace__c','Retailer_Name__r.Type','Retailer_Name__r.Image_URL__c','Retail_Account_Rating__c','Onboard_Date__c','Mutual_Payment_Terms__c','Retailer_Name__r.Phone','Retailer_Name__r.Fax','Retailer_Name__r.Website','Retailer_Name__r.BillingStreet','Retailer_Name__r.BillingCity','Retailer_Name__r.BillingState','Retailer_Name__r.BillingCountry','Retailer_Name__r.BillingPostalCode','Retailer_Name__r.LinkedIn__c','Retailer_Name__r.Facebook__c','Retailer_Name__r.Twitter__c','Retailer_Name__r.Instagram__c','Retailer_Name__r.About_Us__c'};
            List<String> lcwhereParts = new List<String>();
        if(isDisty){
            distyBrandNames.add(brandId);
            lcwhereParts.add('Brand_Name__c IN :distyBrandNames');
        }else{
            lcwhereParts.add('Brand_Name__c = :brandId');
        }
        //lcwhereParts.add('Brand_Name__c = :brandId');
        List<String> brandRetailerIds = new List<String>();
        String lcquery = 'SELECT ' + String.escapeSingleQuotes(String.join(LCFields, ', ')) + ' FROM Line_Card__c ';
        if(!lcwhereParts.isEmpty()){
          lcquery += ' WHERE ' + String.escapeSingleQuotes(String.join(lcwhereParts, ' AND '));
        }
        
        if(!lcwhereParts1.isEmpty()){
          lcquery += ' AND (' + String.escapeSingleQuotes(String.join(lcwhereParts1, ' OR ')) + ' ) ';
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            lcquery += ' ORDER By Retailer_Name__r.'+orderByField+' '+direction;
        }
        System.debug('lcquery='+lcquery);
        for(Line_Card__c lc: (List<Line_Card__c>)Database.query(lcquery)){
            if(brandRetailerIds.indexOf(lc.Retailer_Name__c)== -1){
                if(!lc.Retailer_Name__r.Hide_from_Marketplace__c && retailerTypes.contains(lc.Retailer_Name__r.Type)){
                    brandRetailerIds.add(lc.Retailer_Name__c);    
                }
            }
            
        }
         System.debug('in retailerFilter'+brandRetailerIds);
        if(String.isNotBlank(retailerFilter) && retailerFilter.endsWithIgnoreCase('My Retailers')){
            System.debug('in retailerFilter');
            r.data.put('ids', brandRetailerIds);
            r.data.put('isBrand', isBrand);
            return r;
        }
        
        
        
        String query = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ' FROM Account ';
        if(isBrand){
            whereParts.add('Type IN :retailerTypes');
        }
        if(String.isNotBlank(retailerFilter) && retailerFilter.equalsIgnoreCase('Other Retailers')){
            whereParts.add( 'ID NOT IN : brandRetailerIds');
        }
        Boolean isTrue = false;
        whereParts.add('Hide_from_Marketplace__c =: isTrue');
        if(!whereParts.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        if(!whereSearchParts.isEmpty()){
            query += (whereParts.isEmpty()?' WHERE ':' AND ') + '('+ String.escapeSingleQuotes(String.join(whereSearchParts, ' OR '))+')';
        }
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        }
        query += ' LIMIT 49999';
        System.debug('query1234=' + query);
        
        
        for(Account a :(List<Account>)Database.query(query)){
            ids.add(a.Id);
        }
        
        r.data.put('ids', ids);
        r.data.put('isBrand', isBrand);
        r.data.put('isDisty', isDisty);
        System.debug('r1234='+r);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getRetailers(List<String> ids, Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getRetailers()');
        List<String> whereParts = new List<String>();
        String orderByField = '';
        String direction = '';
        String searchTerm = '';
        String orderBy = '';
        String retailerFilter = '';
        if(filters != null){
            if(hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
            if(hasFilter(filters, RETAILER_FILTER)){
                retailerFilter = String.valueOf(filters.get(RETAILER_FILTER));
            }
            
        }
        System.debug('retailerFilter::'+retailerFilter);
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        List<String> fields = new List<String>{'Business_Type__c','Bar_Code__c','Third_Party_Scheduler__c','QR_Code__c','Description','Name','DBA__c','Image_URL__c','Fax','Phone','Website','Account_Rating__c','BillingStreet','BillingCity','BillingState','BillingCountry','BillingPostalCode','LinkedIn__c','Facebook__c','Twitter__c','Instagram__c','About_Us__c'};
            List<String> LCFields = new List<String>{'Brand_Account_Rating__c','Minimum_Order_Value__c','Brand_DBA__c','Sales_Person__c','Sales_Person__r.Name','Retailer_Name__c', 'Retailer_DBA__c','Retailer_Name__r.Name','Retailer_Name__r.Image_URL__c','Retail_Account_Rating__c','Onboard_Date__c','Mutual_Payment_Terms__c','Retailer_Name__r.Phone','Retailer_Name__r.Fax','Retailer_Name__r.Website','Retailer_Name__r.BillingStreet','Retailer_Name__r.BillingCity','Retailer_Name__r.BillingState','Retailer_Name__r.BillingCountry','Retailer_Name__r.BillingPostalCode','Retailer_Name__r.LinkedIn__c','Retailer_Name__r.Facebook__c','Retailer_Name__r.Twitter__c','Retailer_Name__r.Instagram__c','Retailer_Name__r.About_Us__c'};
                whereParts.add('Id IN :ids');
        Boolean isTrue = false;
        whereParts.add('Hide_from_Marketplace__c =: isTrue');
        String query = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ',(SELECT Id,Name FROM Contacts Order By Name),(SELECT License_Number__c , License_Type__c  FROM State_Licenses__r) FROM Account ';
        String lcquery = 'SELECT ' + String.escapeSingleQuotes(String.join(LCFields, ', ')) + ' FROM Line_Card__c ';
        List<String> lcwhereParts = new List<String>();
        lcwhereParts.add('Brand_Name__c = :brandId');
        if(isBrand){
            //whereParts.add('Brand_Name__c = :brandId');
        }
        if(!whereParts.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        if(!lcwhereParts.isEmpty()){
            lcquery += ' WHERE ' + String.escapeSingleQuotes(String.join(lcwhereParts, ' AND '));
        }
        
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        }
        query += ' LIMIT 49999';
        System.debug('query: ' + query);
        Map<Id,Line_Card__c> brandLineCardMap = new Map<Id,Line_Card__c>();
        for(Line_Card__c lc: (List<Line_Card__c>)Database.query(lcquery)){
            brandLineCardMap.put(lc.Retailer_Name__c,lc);
        }
        List<Retailer> records = new List<Retailer>();
        for(Account a :(List<Account>)Database.query(query)){
            records.add(new Retailer(a,brandLineCardMap.get(a.Id),retailerFilter));
        }
        
        r.data.put('records', records);
        r.data.put('isBrand', isBrand);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getRecentRetailers(Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getRecentRetailers()');
        Map<Id,Line_Card__c> brandLineCardMap = new Map<Id,Line_Card__c>();
        //List<Retailer> retailers = new List<Retailer>();
        List<Id> retailerIds = new List<Id>();
        for(Line_Card__c lc :[SELECT Retailer_Name__c,Minimum_Order_Value__c,Brand_Account_Rating__c,Brand_DBA__c,Sales_Person__c,Sales_Person__r.Name, Retailer_DBA__c,Retailer_Name__r.Name,Retailer_Name__r.Image_URL__c,Retail_Account_Rating__c,Onboard_Date__c,Mutual_Payment_Terms__c,Retailer_Name__r.Phone,Retailer_Name__r.Fax,Retailer_Name__r.Website,Retailer_Name__r.BillingStreet,Retailer_Name__r.BillingCity,Retailer_Name__r.BillingState,Retailer_Name__r.BillingCountry,Retailer_Name__r.BillingPostalCode,Retailer_Name__r.LinkedIn__c,Retailer_Name__r.Facebook__c,Retailer_Name__r.Twitter__c,Retailer_Name__r.Instagram__c,Retailer_Name__r.About_Us__c  FROM Line_Card__c WHERE Brand_Name__c = :brandId AND Onboard_Date__c <= LAST_N_DAYS:30 ORDER BY Onboard_Date__c DESC]){/*Brand_Name__c = :brandId AND */
            //retailers.add(new Retailer(lc));
            brandLineCardMap.put(lc.Retailer_Name__c,lc);
            retailerIds.add(lc.Retailer_Name__c);
        }
        Set<Id> ids = brandLineCardMap.keySet();
        List<String> whereParts = new List<String>();
        List<String> fields = new List<String>{'Business_Type__c','Third_Party_Scheduler__c','QR_Code__c','Bar_Code__c','Description','Name','DBA__c','Image_URL__c','Fax','Phone','Website','Account_Rating__c','BillingStreet','BillingCity','BillingState','BillingCountry','BillingPostalCode','LinkedIn__c','Facebook__c','Twitter__c','Instagram__c','About_Us__c'};
        String query = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ' FROM Account ';
        whereParts.add('Id IN :ids');
        if(!whereParts.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        query += ' ORDER BY DBA__c';
        List<Retailer> records = new List<Retailer>();
        Map<Id,Retailer> brandRetailerMap = new Map<Id,Retailer>();
        for(Account a :(List<Account>)Database.query(query)){
            brandRetailerMap.put(a.Id,new Retailer(a,brandLineCardMap.get(a.Id),'All'));
        }
        for(Id retailerId: retailerIds){
            records.add(brandRetailerMap.get(retailerId));
        }
        r.data.put('retailers', records);
        
        r.data.put('isBrand', isBrand);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getRetailer(String id){
        AuraResponse r = new AuraResponse('ProductsCtlr.getRetailer()');
        
        r.data.put('retailer', new Retailer());
        String retailerId = '';
        List<String> fields = new List<String>{'Business_Type__c','Description','Name','DBA__c','Image_URL__c','Fax','Phone','Website','Account_Rating__c','BillingStreet','BillingCity','BillingState','BillingCountry','BillingPostalCode','LinkedIn__c','Facebook__c','Twitter__c','Instagram__c','About_Us__c','Bar_Code__c','QR_Code__c','Third_Party_Scheduler__c'};
        List<String> LCFields = new List<String>{'Brand_Account_Rating__c','Brand_DBA__c','Retailer_Name__c', 'Retailer_DBA__c','Retailer_Name__r.Name','Retailer_Name__r.Image_URL__c','Retail_Account_Rating__c','Onboard_Date__c','Mutual_Payment_Terms__c','Retailer_Name__r.Phone','Retailer_Name__r.Fax','Retailer_Name__r.Website','Retailer_Name__r.BillingStreet','Retailer_Name__r.BillingCity','Retailer_Name__r.BillingState','Retailer_Name__r.BillingCountry','Retailer_Name__r.BillingPostalCode','Retailer_Name__r.LinkedIn__c','Retailer_Name__r.Facebook__c','Retailer_Name__r.Twitter__c','Retailer_Name__r.Instagram__c','Retailer_Name__r.About_Us__c'};
        List<String>whereParts = new List<String>();
        whereParts.add('Id = :id');
        String query = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ' FROM Account ';
        if(!whereParts.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        
        List<Account> retailers = (List<Account>)Database.query(query);
        Account retailer = retailers[0];
        List<Line_Card__c> lcs = [SELECT Brand_Account_Rating__c,Minimum_Order_Value__c,Brand_DBA__c,Sales_Person__c,Sales_Person__r.Name, Retailer_DBA__c,Retailer_Name__r.Name,Retailer_Name__r.Image_URL__c,Retail_Account_Rating__c,Onboard_Date__c,Mutual_Payment_Terms__c,Retailer_Name__r.Phone,Retailer_Name__r.Fax,Retailer_Name__r.Website,Retailer_Name__r.BillingStreet,Retailer_Name__r.BillingCity,Retailer_Name__r.BillingState,Retailer_Name__r.BillingCountry,Retailer_Name__r.BillingPostalCode,Retailer_Name__r.LinkedIn__c,Retailer_Name__r.Facebook__c,Retailer_Name__r.Twitter__c,Retailer_Name__r.Instagram__c,Retailer_Name__r.About_Us__c FROM Line_Card__c WHERE Retailer_Name__c = :retailer.id AND Brand_Name__c = :brandId];
        if(!lcs.isEmpty()){/*Brand_Name__c = :brandId AND */
            r.data.put('retailer', new Retailer(retailer,lcs[0],'All'));
            retailerId = lcs[0].Retailer_Name__c;
            List<Customer_Insights__c> lstInsights = [SELECT Id,Name,CreatedDate,Completed__c,
                                                      Contact__c,Contact__r.Name,Date_Time__c,
                                                      Insight_Type__c,Line_Card__c,Memo__c 
                                                      FROM Customer_Insights__c where Line_Card__c =: lcs[0].Id ORDER BY CreatedDate DESC];
            if(lstInsights.size() > 0){
                r.data.put('insights', lstInsights);
            }
        }else{
            r.data.put('retailer', new Retailer(retailer,null,'All'));
            retailerId = retailer.Id;
        }
        LineCard[] linecards = new LineCard[]{};
        for(Line_Card__c lc: [SELECT Name,Minimum_Order_Value__c,Brand_Account_Rating__c,Retail_Account_Rating__c,Sales_Person__c,Sales_Person__r.Name,Brand_DBA__c,Brand_Name__c,Retailer_DBA__c,Retailer_Name__c,Onboard_Date__c,Mutual_Payment_Terms__c FROM Line_Card__c WHERE Brand_Name__c =: brandId]){
            linecards.add(new LineCard(lc));
        }
        RetailerContact[] retailerContacts = new RetailerContact[]{};
            for(Contact con: [SELECT Name, Email,Title,Phone,MobilePhone FROM Contact WHERE AccountId = :retailerId]){
                retailerContacts.add(new RetailerContact(con));
            }
        r.data.put('retailerContacts',retailerContacts);
        
        List<SalesOrder> salesOrders = new List<SalesOrder>();
        List<Sales_Order__c> sOrders = [SELECT Id, Name, Customer_PO_or_Quote__c, SO_Date__c, SO_Status__c, Total_Line_Items__c,Total_Price__c, Brand_Quote__r.Opportunity_Name__r.Order__c, Brand_Quote__r.Opportunity_Name__r.Order__r.Name, Brand_Quote__c, Brand_Quote__r.Name,
                                        (Select Id, Name,Metrc_Manifest__c from Shipping_Manifests__r LIMIT 1),
                                        (Select Id, Name from Invoices__r LIMIT 1)
                                        FROM Sales_Order__c
                                        WHERE Brand_Quote__r.Opportunity_Name__r.Order__r.Retailer__c = :retailerId
                                        AND Brand_Quote__r.Opportunity_Name__r.Order__r.Account__c = :brandId AND Order_Type__c =: SO_ORDER_TYPE_BRAND
                                        Order By Brand_Quote__r.Opportunity_Name__r.Order__r.Name DESC];
        Map<Id, Purchase_Order__c> purchaseOrders = getPurchaseOrders(sOrders);
        for(Sales_Order__c so:sOrders){
            salesOrders.add(new SalesOrder(so, purchaseOrders));
        }
        r.data.put('linecards', linecards);
        r.data.put('salesOrders', salesOrders);
        
        
        List<SalesOrder> outboundTransfer = new List<SalesOrder>();
        List<Sales_Order__c> sOrders1 = [SELECT Id, Name, Customer_PO_or_Quote__c, SO_Date__c, SO_Status__c, Total_Line_Items__c,Total_Price__c, Brand_Quote__r.Opportunity_Name__r.Order__c, Brand_Quote__r.Opportunity_Name__r.Order__r.Name, Brand_Quote__c, Brand_Quote__r.Name,
                                        (Select Id, Name,Metrc_Manifest__c from Shipping_Manifests__r LIMIT 1),
                                        (Select Id, Name from Invoices__r LIMIT 1)
                                        FROM Sales_Order__c
                                        WHERE Brand_Quote__r.Opportunity_Name__r.Order__r.Retailer__c = :retailerId
                                        AND Brand_Quote__r.Opportunity_Name__r.Order__r.Account__c = :brandId AND Order_Type__c =: SO_ORDER_TYPE_TRANSFER
                                        Order By Brand_Quote__r.Opportunity_Name__r.Order__r.Name DESC];
        Map<Id, Purchase_Order__c> purchaseOrders1 = getPurchaseOrders(sOrders1);
        for(Sales_Order__c so:sOrders1){
            outboundTransfer.add(new SalesOrder(so, purchaseOrders1));
        }
        r.data.put('outboundTransfer', outboundTransfer);
        
        List<LicenseAddress> stateLicenses = new List<LicenseAddress>();
        for(State_Licenses__c sl :[SELECT Default_Warehouse__c,Default_Warehouse__r.Warehouse_Name__c,License_Address__c, License_City__c, License_State__c, License_Country__c, License_Zip__c, License_Expiration_Date__c, License_Status__c, License_Class__c ,License_Type__c , License_Number__c  FROM State_Licenses__c WHERE License_Name__c = :retailerId]){
            stateLicenses.add(new LicenseAddress(sl));
        }
        r.data.put('stateLicenses', stateLicenses);
        r.data.put('isBrand', isBrand);
        r.data.put('contactRTId',Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Contact').getRecordTypeId());
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getProductAndReviews(String id, Integer reviewsLimit){
        AuraResponse r = new AuraResponse('ProductsCtlr.getProductAndReviews()');
        
        String productId = '';
        Product p;
        System.debug('id = '+id);
        //for(PricebookEntry pbe :(List<PricebookEntry>)Database.query(getQuery(new List<String>{'UnitPrice','Product2.Status__c','Product2.Is_Sample__c','Product2.Parent_Product__c', 'Product2.Name','Product2.Brand_Name__c','Product2.Family', 'Product2.Product_Rating__c', 'Product2.Available_Inventory__c','Product2.Inventory_On_Hold_Qty__c' ,'Product2.Available_Qty__c', 'Product2.Total_Order_Qty__c', 'Product2.Description','Product2.Product_Short_Description__c', 'Product2.Product_Details__c', 'Product2.Producer_Name__r.dBA__c','Product2.Producer_Name__r.Name', 'Product2.Cultivation_Type__c', 'Product2.Image_URL__c', 'Product2.MOQ__c', 'Product2.Strain__r.Name', 'Product2.Strain_Type__c','Product2.Terpene_percent__c', 'Product2.THC_Amount__c', 'Product2.THC_MG_G__c', 'Product2.CDB_Amount__c', 'Product2.CBD_MG_G__c','Product2.Fulfilled_by_Filigreen__c'}, new List<String>{'Id = :id'}, '', 49999))){
        for(PricebookEntry pbe :(List<PricebookEntry>)Database.query('select Product2.MSRP__c,UnitPrice,Product2.RecordType.Name,Product2.Status__c,Product2.Is_Sample__c,Product2.Parent_Product__c, Product2.Name,Product2.Brand_Name__c,Product2.Family, Product2.Product_Rating__c, Product2.Available_Inventory__c,Product2.Inventory_On_Hold_Qty__c ,Product2.Available_Qty__c, Product2.Total_Order_Qty__c, Product2.Description,Product2.Product_Short_Description__c,Product2.Product_Details__c, Product2.Producer_Name__r.dBA__c,Product2.Producer_Name__r.Name,Product2.Licensee_Name__c,Product2.White_Labelled__c,Product2.Licensee_Name__r.Name, Product2.Cultivation_Type__c,Product2.Image_URL__c, Product2.MOQ__c,Product2.Strain__r.Name,Product2.Strain_Type__c,Product2.Terpene_percent__c, Product2.THC_Amount__c, Product2.THC_MG_G__c, Product2.CDB_Amount__c, Product2.CBD_MG_G__c,Product2.Fulfilled_by_Filigreen__c from PricebookEntry where Id = :id Limit 49999 ')){
            productId = pbe.Product2Id;
            p = new Product(pbe);
        }
        if(p != null){
            p.hasSampleChild = false;
            Map<Id,WarehouseAvailableInventory[]> warehouseAvailableInventoryMap = getWarehouseAvailableInventory(new Set<String>{p.Id});
            for(Product2 tmpProduct:[SELECT Id,Image_URL__c,(select id,Is_Sample__c,Parent_Product__c from Products__r), (SELECT Image_URL__c FROM Product_Images__r),(SELECT Id,Name, COA_Issued_Date__c  FROM Compliance_Images__r WHERE COA_Expiration_Date__c >= :System.today() Order By COA_Issued_Date__c DESC) FROM Product2 WHERE Id =:p.Id]){
                p.setImages(tmpProduct);
                p.availableInventories = warehouseAvailableInventoryMap.get(tmpProduct.Id);
                if(tmpProduct.Products__r.size() > 0){
                    p.hasSampleChild = true;
                    p.childProductId = tmpProduct.Products__r[0].Id;
                } 
                
                Set<Id> complianceIds = new Set<Id>();
                if(tmpProduct.Compliance_Images__r.size() > 0){
                    complianceIds.add(tmpProduct.Compliance_Images__r[0].Id);
                }
                if(!complianceIds.isEmpty()){
                    System.debug('###complianceIds::'+complianceIds);
                    ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId IN :complianceIds ];//AND ContentDocument.FileExtension = 'pdf'
                    System.debug('##'+files);
                    //ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title,ContentDocument.FileType FROM ContentDocumentLink WHERE LinkedEntityId IN: complianceIds AND ContentDocument.FileExtension = 'pdf'];
                    if(!files.isEmpty()){
                        Id complianceId = tmpProduct.Compliance_Images__r[0].Id;
                        if(complianceId != null){
                            String docIds = '';
                            String comma = '';
                            String[] pdfIds = new String[]{};
                            String[] otherIds = new String[]{};
                            for(ContentDocumentLink l:files){
                                if(l.LinkedEntityId == complianceId){
                                    System.debug('l.ContentDocument.FileExtension::'+l.ContentDocument.FileExtension);
                                    if(l.ContentDocument.FileExtension == 'pdf') pdfIds.add(l.ContentDocumentId);
                                    else otherIds.add(l.ContentDocumentId);
                                }
                            }
                            docIds = (!pdfIds.isEmpty()?String.join(pdfIds,','):'');
                            if(String.isNotBlank(docIds)){
                                docIds += ','+(!otherIds.isEmpty()?String.join(otherIds,','):'');
                            }else{
                                docIds = (!otherIds.isEmpty()?String.join(otherIds,','):'');
                            }
                            p.complianceFileId = docIds;
                        }
                    }
                }
            }
            
            if(p.hasSampleChild == true){
                p.hasSampleChild = false;
                Id sampleProductId = p.childProductId;
                //priceBooks.add(priceBookId);
                for(PricebookEntry pbe :[SELECT Product2.MSRP__c,Product2.Status__c,UnitPrice,Product2.Is_Sample__c,Product2.Parent_Product__c,Product2.Name,Product2.Brand_Name__c,Product2.Family,Product2.Unit_Height__c,Product2.Retail_Unit_Form_Factor__c,
                                         Product2.Unit_Width__c,Product2.Unit_Radius__c,Product2.Unit_Length__c,Product2.Unit_Cubic_Volume__c,Product2.Product_Rating__c,Product2.Available_Inventory__c,Product2.Inventory_On_Hold_Qty__c,Product2.Available_Qty__c
                                         ,Product2.Total_Order_Qty__c,Product2.Description,Product2.Product_Short_Description__c,Product2.Product_Details__c,Product2.Producer_Name__r.dBA__c,Product2.Producer_Name__r.Name,Product2.Cultivation_Type__c,
                                         Product2.Image_URL__c,Product2.MOQ__c,Product2.Strain__r.Name,Product2.Strain_Type__c,Product2.Terpene_percent__c,Product2.THC_Amount__c,Product2.THC_MG_G__c,Product2.CDB_Amount__c,Product2.CBD_MG_G__c,
                                         Product2.Fulfilled_by_Filigreen__c  ,Product2.RecordType.Name,Product2.Licensee_Name__r.Name,Product2.Licensee_Name__c,Product2.White_Labelled__c
                                         FROM PriceBookEntry 
                                         WHERE Product2Id = :sampleProductId
                                         AND PriceBook2Id IN: priceBooks]){
                                             
                                             if(pbe.Product2.Available_Qty__c > 0){
                                                 p.hasSampleChild = true;    
                                                 p.sampleProduct = new Product(pbe);
                                             } else {
                                                 p.hasSampleChild = false;     
                                             }
                    System.debug('##p.sampleProduct::'+p.sampleProduct);
                }
            }
        }
        
        System.debug('##productId::'+productId);
        if(String.isNotBlank(productId) && p != null){
            for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now() AND (Brand__c =: p.producerId OR Product_Name__c =: p.id)]){
                if(p.discountPercent != null){
                    p.setProductDiscountPercent(bd.Discount_Percentage__c);
                }else{
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
                //p.setDiscountPercent(bd.Discount_Percentage__c);
            }
            for(Product_Stock_Notification__c psn :[SELECT Id FROM Product_Stock_Notification__c WHERE Product__c = :productId AND Sent_Notification__c = false]){
                p.notifyRequested(true);
            }
            r.data.put('product', p);
            r.data.put('warehouseTotalOrderedMap',getWarehouseOrderedMap(new Set<String>{p.Id}));
            Integer totalReviews = Database.countQuery('SELECT COUNT() FROM Product_Review__c WHERE Product__c = :productId');
            r.data.put('totalReviews', totalReviews);
            
            r.data.put('reviews', null);
            if(0 < totalReviews){
                List<Review> reviews = new List<Review>();
                reviewsLimit = Integer.valueOf(reviewsLimit);
                if(1 > reviewsLimit){
                    reviewsLimit = 5;
                }
                
                List<ReviewChart> tmpRatingsSummary = new List<ReviewChart>{new ReviewChart(0,0),new ReviewChart(0,0),new ReviewChart(0,0),new ReviewChart(0,0),new ReviewChart(0,0)};
                    for(AggregateResult ar :[SELECT Rating_Text__c rating, COUNT(Id) ratingCount FROM Product_Review__c WHERE Product__c = :productId GROUP BY Rating_Text__c ORDER BY Rating_Text__c DESC]){
                        Integer rating = Integer.valueOf(ar.get('rating'));
                        Integer ratingCount = Integer.valueOf(ar.get('ratingCount'));
                        Decimal percent = (decimal.valueOf(ratingCount)/totalReviews)*100;
                        tmpRatingsSummary.set((rating - 1), new ReviewChart(ratingCount,Integer.valueOf(Math.round(percent))));
                        //tmpRatingsSummary.set((rating - 1), '('+ratingCount+')'+Integer.valueOf(Math.round(percent))+'%');
                    }
                
                List<ReviewChart> ratingsSummary = new List<ReviewChart>();
                for(Integer i = tmpRatingsSummary.size() - 1; i >= 0; i--){
                    ratingsSummary.add(tmpRatingsSummary[i]);
                }
                r.data.put('ratingsSummary', ratingsSummary);
                
                for(Product_Review__c pr :[SELECT Rating__c, Review__c, CreatedDate, Owner.Name FROM Product_Review__c WHERE Product__c = :productId ORDER BY CreatedDate DESC LIMIT :reviewsLimit]){
                    reviews.add(new Review(pr));
                }
                r.data.put('reviews', reviews);
            }
            for(Product_Categories__c pc : [SELECT Id, Category__c ,Name,Icon_Name__c ,Product_Families__c FROM Product_Categories__c WHERE Icon_Name__c != null Order By Sort_Order__c]){
                if(pc.Product_Families__c != null && pc.Product_Families__c != ''){
                    productFamilies.addAll(pc.Product_Families__c.split(';'));
                }
            }
            r.data.put('productFamilies', productFamilies);
            
        }
        r.data.put('isBrand', isBrand);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse addToCart(String addToCartData){
        AuraResponse r = new AuraResponse('ProductsCtlr.addToCart()');
        Boolean isSample = false;
        AddtoCart addToCart = (AddtoCart)JSON.deserialize(addToCartData, AddtoCart.class);
        if(String.isBlank(addToCart.productId)){
            r.errors.add(PRODUCT_NOT_FOUND);
        }
        if(String.isBlank(addToCart.pricebookId)){
            r.errors.add(PRICEBOOK_NOT_FOUND);
        }
        
        if(addToCart.quantity < 1){
            r.errors.add(PROVIDE_THE_QTY);
        }
        
        if(addToCart.isSample){
            isSample = true;
        }
        if((isBrand || isDisty )&& !Test.isRunningTest()){
            
            Map<String, Object> brandRetailDeliveryOrderItems = new Map<String, Object>();
            Decimal quantity = addToCart.quantity;
            if(Cache.Session.contains(cacheKey)){
                brandRetailDeliveryOrderItems = (Map<String, Object>)Cache.Session.get(cacheKey);
                if(brandRetailDeliveryOrderItems.containsKey(addToCart.productId+'-'+addToCart.isSample+'-'+addToCart.unitPrice)){
                    BrandCartItem bci = (BrandCartItem) brandRetailDeliveryOrderItems.get(addToCart.productId+'-'+addToCart.isSample+'-'+addToCart.unitPrice);
                    quantity = bci.quantity;
                    //quantity = Integer.valueOf(brandRetailDeliveryOrderItems.get(addToCart.productId));
                    quantity += addToCart.quantity;
                }
            }
            
            Product2 p = [SELECT Status__c,Name,RecordType.Name, MOQ__c,Parent_Product__c,Apply_Excise_Tax__c,Available_Qty__c,White_Labelled__c,Licensee_Name__c,Available_Inventory__c,Licensee_Name__r.DBA__c,
                          Image_URL__c,Brand_Name__c,Product_Short_Description__c,Producer_Name__c,Producer_Name__r.DBA__c,Is_Sample__c,Family
                          FROM Product2 WHERE Id = :addToCart.productId];
            
            decimal chk_Available_Qty = quantity * p.MOQ__c;
            if(p.Available_Qty__c < chk_Available_Qty && addToCart.isDiscountProduct != true){
                r.errors.add(ERR_MSG_ORDER_QTY_GT_AVAILABLE_QTY);
                r.handleErrors();
            }
            BrandCartItem bci = new BrandCartItem();
            bci.name = p.Name;
            bci.quantity = quantity;
            bci.lineTotalQty = (p.MOQ__c*quantity);
            bci.isBulkProduct = addToCart.isBulkProduct;
            bci.unitPrice = addToCart.unitPrice;
            bci.isProductSample = p.Is_Sample__c;
            bci.isDiscountProduct =addToCart.isDiscountProduct;
            bci.productFamily = p.Family;
            if(p.White_Labelled__c && p.Licensee_Name__c != null && p.Licensee_Name__r.DBA__c != null){
                bci.brandName = p.Licensee_Name__r.DBA__c;
                bci.brandId = p.Licensee_Name__c;
            } else if(p.Producer_Name__c != null && p.Producer_Name__r.DBA__c != null){
                bci.brandName = p.Producer_Name__r.DBA__c;
                bci.brandId = p.Producer_Name__c;
            }
            
            //bci.brandName = p.Brand_Name__c;
            if(p.Apply_Excise_Tax__c == 'Yes'){
                bci.applyExciseTax = p.Apply_Excise_Tax__c;    
            } else {
                bci.applyExciseTax = 'No';
            }
            
            bci.shortDesc = p.Product_Short_Description__c;
            bci.availableQty = p.Available_Qty__c;
            bci.MOQ = addToCart.MOQ;
            bci.specialInstructions = addToCart.specialInstructions;
            bci.imageUrl = p.Image_URL__c == null ? IMAGE_COMINGSOON : p.Image_URL__c;
            bci.id = p.Id;
            bci.productRecordTypeName = p.RecordType.Name;
            if(addToCart.isSample){
                bci.isSample = addToCart.isSample;
                //bci.unitPrice = 0.01;
            }else{
                bci.isSample = false;
            }
            bci.isPromo = addToCart.isPromo;
            if(addToCart.isSample){
                String[] sampleProducts = p.Name.split(' - S');
                bci.name = sampleProducts[0];
                bci.isSample = addToCart.isSample;
                bci.quantity = 1;
                bci.lineTotalQty = 1;
                bci.unitPrice = 0.01;
            } 
            
            List<String> priceBookIds = new List<String>();
            List<String> brandIds = new List<String>();
            brandIds.add(brandId);
            //if(isDisty){
                brandIds.addAll(distyBrandNames);
                priceBookIds.addAll(distyPriceBooks);
            //}

            if(isBrand && addToCart.retailerId != NULL && String.isNotBlank(addToCart.retailerId)){
                for(Line_Card__c lc: [SELECT Retailer_Name__c,Community_Price_Book__c  FROM Line_Card__c WHERE Retailer_Name__r.Hide_From_Marketplace__c = false AND Retailer_Name__c =:addToCart.retailerId  AND Brand_Name__c = :brandId ORDER BY Retailer_DBA__c]){
                    priceBookIds.add(lc.Community_Price_Book__c);
                }
            }else{
                priceBookIds.add(priceBookId);
            }
            
            
            if(addToCart.isSample ){//&& p.Parent_Product__c != null
                List<PricebookEntry> pbe = [SELECT Id FROM PricebookEntry WHERE Product2Id =: p.Id AND Product2.Hide_From_Marketplace__c = false AND ((Product2.Producer_Name__c IN :brandIds AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c IN :brandIds AND Product2.White_Labelled__c = true) ) AND PriceBook2Id IN :priceBookIds AND Product2.RecordType.Name = :recordTypeName AND Product2.IsActive = true LIMIT 1];
                if(pbe.size() > 0){
                    bci.priceBookId = pbe[0].Id;
                }
            } else {
                PricebookEntry pbe = [SELECT Id FROM PricebookEntry WHERE Product2Id =: p.Id AND Product2.Hide_From_Marketplace__c = false AND ((Product2.Producer_Name__c IN :brandIds AND Product2.White_Labelled__c = false) OR(Product2.Licensee_Name__c IN :brandIds AND Product2.White_Labelled__c = true) ) AND PriceBook2Id IN :priceBookIds AND (Product2.RecordType.Name = :recordTypeName OR Product2.RecordType.Name =:PRODUCT_RECORD_TYPE_NAME_DISCOUNT) AND Product2.IsActive = true LIMIT 1];
                if(pbe != null){
                    bci.priceBookId = pbe.Id;
                }              
            }
            
            brandRetailDeliveryOrderItems.put(addToCart.productId+'-'+addToCart.isSample+'-'+addToCart.unitPrice, bci);
            System.debug('##brandRetailDeliveryOrderItems:'+brandRetailDeliveryOrderItems);
            Cache.Session.put(ProductsCtlr.cacheKey, brandRetailDeliveryOrderItems);
            
            return getCartItems();
        }
        
        
        Order__c o = getDraftOrder();
        
        Order_Line_Item__c oli = getOrderLineItem(o, addToCart.productId, addToCart.pricebookId);
        Decimal moq = 0;
        for(Product2 p :[SELECT Name, Status__c,MOQ__c, Available_Inventory__c,Total_Order_Qty__c,Available_Qty__c FROM Product2 WHERE Id = :addToCart.productId]){
            System.debug('####Product::'+p);
            moq = p.MOQ__c;
            Decimal totalQuantity = (oli.Quantity_Cases__c + addToCart.quantity);
            if(addToCart.isUpdate){
                totalQuantity = addToCart.quantity;
            }
            if(p.Available_Qty__c < totalQuantity * p.MOQ__c){
                r.errors.add(String.format(PRODUCT_QTY_UNAVAILABLE,new List<String>{String.valueOf(p.Name)}));
            }
        }
        r.handleErrors();
        
        try{
            oli.MOQ__c = moq;
            oli.Quantity_Cases__c += addToCart.quantity;
            oli.UnitPrice__c = addToCart.unitPrice;
            if(addToCart.isUpdate){
                oli.Quantity_Cases__c = addToCart.quantity;
            }
            System.debug('Is Sample = '+addToCart.isSample);
            if(addToCart.isSample){
                isSample = true;
                oli.Is_Sample__c = addToCart.isSample;
                oli.MOQ__c = 1;
                oli.Quantity_Cases__c = 1;
                oli.UnitPrice__c = 0.01;
            }
            
            update oli;
            System.debug('###Update OLI::'+oli);
            return getCartItems();
        }catch(Exception e){
            r.handleException(e);
        }
        
        return r;
    }
    @AuraEnabled
    public static AuraResponse checkStateLicenseForCloneRO(String retailerOrderId){
        AuraResponse r = new AuraResponse('ProductsCtlr.checkStateLicenseForCloneRO()');
        Order__c o =[SELECT id ,State_License__c FROM Order__c WHERE id=:retailerOrderId];
        List<LicenseAddress> addresses = new List<LicenseAddress>();
        for(State_Licenses__c sl :[SELECT Default_Warehouse__c ,Default_Warehouse__r.Warehouse_Name__c,License_Address__c, License_City__c, License_State__c, License_Country__c, License_Zip__c, License_Expiration_Date__c, License_Status__c, License_Class__c ,License_Type__c , License_Number__c  FROM State_Licenses__c WHERE id =: o.State_License__c AND License_Status__c =: 'Active']){
            addresses.add(new LicenseAddress(sl));
        }
        r.data.put('LicenseAddress',addresses);
        return r;
    }
    @AuraEnabled
    public static AuraResponse getCartItems(){
        AuraResponse r = new AuraResponse('ProductsCtlr.getCartItems()');
        r.data.put('EARLIEST_DELIVERY_TIME',EARLIEST_DELIVERY_TIME);
        r.data.put('LATEST_DELIVERY_TIME',LATEST_DELIVERY_TIME);
        r.data.put('isLimited', isLimited);
        Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
        if(ccs.Exclude_Excise_Tax_Types__c != null){
            r.data.put('excludeExciseTaxTypes',ccs.Exclude_Excise_Tax_Types__c.split(','));
        }
        Map<String, Community_Settings__c > Community_Settings= Community_Settings__c.getAll();
        if(Community_Settings.containsKey(COMMUNITY_SETTINGS_DEFAULT)){
            r.data.put('cutOffTime', Community_Settings.get(COMMUNITY_SETTINGS_DEFAULT).Order_Cutoff_time__c);
        }
        if(isBrand){
            Integer quantity = 0;
            Decimal total = 0;
            Double lineSubTotal = 0;
            BrandCartItem[] bcItems = new BrandCartItem[]{};
            if(Cache.Session.contains(cacheKey)){
                Map<String, Object> brandRetailDeliveryOrderItems = (Map<String, Object>)Cache.Session.get(cacheKey);
                for(String productId:brandRetailDeliveryOrderItems.keySet()){
                    quantity++;
                    //total += Integer.valueOf(brandRetailDeliveryOrderItems.get(productId));
                    BrandCartItem bci = (BrandCartItem) brandRetailDeliveryOrderItems.get(productId);
                    total += bci.quantity;
                    bcItems.add(bci);
                    lineSubTotal += (bci.lineTotalQty * bci.unitPrice);
                }
            }
            r.data.put('items', bcItems);
            r.data.put('quantity', quantity);
            r.data.put('total', total);
            r.data.put('cartTotal', total);
            r.data.put('exciseTax', 0);
            r.data.put('subTotal', lineSubTotal);
            r.data.put('isBrand', isBrand);
            r.data.put('baseUrl', Site.getBaseUrl());
            return r;
        }
        
        Double quantity = 0;
        Double total = 0;
        Double cartTotal = 0;
        Double exciseTotal = 0;
        Double lineSubTotal = 0;
        List<OrderLineItem> tmpItems = new List<OrderLineItem>();
        Set<String> pricebookEntries = new Set<String>();
        Set<Id> productIds = new Set<Id>();
        Set<Id> producerIds = new Set<Id>();
        Map<String,OrderLineItem> productOLIMap = new Map<String,OrderLineItem>();
        Map<String,OrderLineItem[]> producerOLIMap = new Map<String,OrderLineItem[]>();
        for(Order_Line_Item__c oli :[SELECT Quantity_Cases__c, UnitPrice__c, Line_Total_Cost__c, Unit_Excise_Tax__c, Line_Total_Excise_Tax__c, Line_Total_Qty__c, MOQ__c, Total__c, Is_Sample__c, Price_Book_Entry_Id__c, Product__c, Product__r.Name, Product__r.Max_Order_Allowed__c, Product__r.Image_URL__c, Product__r.Description, Product__r.Product_Details__c, Product__r.Producer_Name__c,Product__r.Licensee_Name__c ,Product__r.White_Labelled__c ,Product__r.Producer_Name__r.Name,Product__r.Brand_Name__c,Product__r.Product_Short_Description__c, Product__r.Family, Product__r.Product_Rating__c, Product__r.Available_Inventory__c,Product__r.Available_Qty__c, Is_Brand_Product__c FROM Order_Line_Item__c WHERE Order__r.Customer__c = :Userinfo.getUserId() AND Order__r.Status__c =: STATUS_DRAFT]){
            OrderLineItem OLIObj = new OrderLineItem(oli); 
            productIds.add(oli.Product__c);
            String producerId = '';
            
            producerId = oli.Product__r.Producer_Name__c;
            producerIds.add(oli.Product__r.Producer_Name__c);
            if(producerOLIMap.containsKey(producerId)){
                producerOLIMap.get(producerId).add(OLIObj);
            }else{
                producerOLIMap.put(producerId , new OrderLineItem[]{OLIObj});
            }

                    
            tmpItems.add(OLIObj);
            productOLIMap.put(oli.Product__c,OLIObj);
            pricebookEntries.add(oli.Price_Book_Entry_Id__c);
        }
        Map<String, PricebookEntry> productUnitPrice = new Map<String, PricebookEntry>();
        for(PricebookEntry pbe :[SELECT UnitPrice FROM PricebookEntry WHERE Id IN :pricebookEntries]){
            productUnitPrice.put(pbe.Id, pbe);
        }
        
        List<OrderLineItem> items = new List<OrderLineItem>();
        set<String>productIdSet = new set<String>();
        for(OrderLineItem item :tmpItems){
            if(productUnitPrice.containsKey(item.pricebookId)){
                item.price = new Pricebook(productUnitPrice.get(item.pricebookId));
                if(!item.isSample){
                    item.unitPrice = item.price.unitPrice;
                }
                quantity += item.quantity;
                total += item.lineTotalQty;
                cartTotal += item.total;
                exciseTotal += item.lineTotalExciseTax;
                lineSubTotal += item.lineTotalCost;
                items.add(item);
                productIdSet.add(item.productId);
            }
        }
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Brand__c IN: producerIds AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now()]){
            List<OrderLineItem> products = producerOLIMap.get(bd.Brand__c);
            if(products != null){
                for(OrderLineItem oli: products){
                    oli.setDiscountPercent(bd.Discount_Percentage__c);
                }
            }
        }
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Product_Name__c IN: productIds AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now()]){
            OrderLineItem oli = productOLIMap.get(bd.Product_Name__c);
            if(oli != null){
                if(oli.discountPercent != null){
                    oli.setProductDiscountPercent(bd.Discount_Percentage__c);
                }else{
                    oli.setDiscountPercent(bd.Discount_Percentage__c);
                }
                
            }
        }
        for(OrderLineItem item :tmpItems){
            if(item.discount > 0){
                if(!item.isSample){
                    item.unitPrice = item.salePrice;
                }
            }
        }
        r.data.put('warehouseTotalOrderedMap',getWarehouseOrderedMap(productIdSet));
        r.data.put('warehouseAvailableInventory',getWarehouseAvailableInventory(productIdSet));
        r.data.put('items', items);
        r.data.put('quantity', tmpItems.size());
        r.data.put('total', total);
        r.data.put('cartTotal', cartTotal);
        r.data.put('exciseTax', exciseTotal);
        r.data.put('subTotal', lineSubTotal);
        r.data.put('isBrand', isBrand);
        r.data.put('isHybrid', isHybrid);
        //r.data.put('cityTaxMap',cityTaxMap);
        Set<Id> bandRetailers = new Set<Id>();
        List<Map<String, String>> retailers = new List<Map<String, String>>();
        Map<String, Object> retailersDetail = new Map<String, Object>();
        if(isHybrid){
            for(Account account: [SELECT Name, dBA__c, Payment_Terms__c FROM Account WHERE (Id = :Utility.loggedInUser.AccountId OR ParentId = :Utility.loggedInUser.AccountId)]){
                retailers.add(new Map<String, String>{'id'=> account.Id, 'name'=> account.dBA__c });
                bandRetailers.add(account.Id);
            }
            
            for(Account a:[SELECT Name,dBA__c,Payment_Terms__c, (SELECT Name,LastName, FirstName FROM Contacts WHERE Active__c = true AND Email != null), (SELECT Id,Default_Warehouse__c ,Default_Warehouse__r.Warehouse_Name__c,License_Address__c, License_City__c, License_State__c, License_Country__c, License_Zip__c, License_Expiration_Date__c, License_Status__c, License_Class__c ,License_Type__c , License_Number__c FROM State_Licenses__r WHERE License_Status__c =: STATE_LICENSE_ACTIVE) FROM Account WHERE Id IN :bandRetailers]){
                List<LicenseAddress> statelicenses = new List<LicenseAddress>();
                for(State_Licenses__c sl:a.State_Licenses__r){
                    statelicenses.add(new LicenseAddress(sl));
                }
                List<Map<String, String>> contacts = new List<Map<String, String>>();
                for(Contact c:a.Contacts){
                    contacts.add(new Map<String, String>{'id'=> c.Id, 'name'=> c.Name});
                }
                retailersDetail.put(a.Id, new Map<String, Object>{'statelicenses'=>statelicenses,'licenses'=> statelicenses, 'contacts'=> contacts,'retailer'=>a});
            }
            
        }
        r.data.put('retailers', retailers);
        r.data.put('retailersDetail', retailersDetail);
        List<LicenseAddress> addresses = new List<LicenseAddress>();
        for(State_Licenses__c sl :[SELECT Default_Warehouse__c,Default_Warehouse__r.Warehouse_Name__c,License_Address__c, License_City__c, License_State__c, License_Country__c, License_Zip__c, License_Expiration_Date__c, License_Status__c, License_Class__c ,License_Type__c , License_Number__c  FROM State_Licenses__c WHERE License_Name__c = :Utility.loggedInUser.Contact.AccountId ORDER BY License_Expiration_Date__c DESC]){
            addresses.add(new LicenseAddress(sl));
        }
        
        r.data.put('isCartEmpty', (1 > Utility.getCartTotal()));
        r.data.put('existingAddresses', addresses);
        r.data.put('baseUrl', Site.getBaseUrl());
        User u = [SELECT Id, Name,  Has_Accepted_Terms__c FROM User WHERE Id=: UserInfo.getUserId()];
        List<String> termsAndConditions = new List<String>();
        for(Terms_and_condition__c tnc:[SELECT Term_and_condition__c FROM Terms_and_condition__c WHERE Is_Active__c = true ORDER BY Display_Order__c]){
            termsAndConditions.add(tnc.Term_and_condition__c);
        }
        r.data.put('hasAcceptedTerms', u.Has_Accepted_Terms__c);
        r.data.put('termsAndConditions', termsAndConditions);
        List<string>holidayList = new List<string>();
        for(Holiday  businessHolidDay : [SELECT IsRecurrence,ActivityDate,RecurrenceMonthOfYear,RecurrenceEndDateOnly,RecurrenceInstance,RecurrenceDayOfWeekMask,RecurrenceInterval,RecurrenceType FROM Holiday]){
            if(businessHolidDay.IsRecurrence){
                holidayList.addAll(getAllRecurrenceHoliday(businessHolidDay));
            }else{
                holidayList.add(getDateStr(businessHolidDay.ActivityDate));   
            }    
        }
        r.data.put('holidayList', holidayList);
        return r;
    }
    private static list<String> getAllRecurrenceHoliday(Holiday businessHolidDay){
        List<string>holidayList = new List<string>();
        date todayDt = businessHolidDay.ActivityDate;
        date holidayEndDt = businessHolidDay.RecurrenceEndDateOnly != null ? businessHolidDay.RecurrenceEndDateOnly : system.today();
        while(todayDt <= holidayEndDt){
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
            if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_FIRST){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_SECOND){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_THIRD){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_FOURTH){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_LAST){
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
    @AuraEnabled(cacheable=true)
    public static AuraResponse getOrdersIds(Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getOrdersIds()');
        String orderByField = ORDERBY_ORDER_DATE;
        String direction = DESC_DIRECTION;
        String orderBy = '';
        String recordType = ORDER_RECORD_TYPE_NAME_RETAILER;
        if(filters != null){
            if(hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        Set<Id> ids = new Set<Id>();
        Id currentUserId = Userinfo.getUserId();
        
        String excludeStatus = STATUS_DRAFT;
        String query = 'SELECT Id FROM Order__c ';
        Account[] accs = [SELECT Id,ParentId FROM Account WHERE Id =: brandId];
        if(!accs.isEmpty() && accs[0].ParentId != NULL){
            query += ' WHERE (Customer__c = :currentUserId OR Retailer__c =: brandId)';
        }else{
            query += ' WHERE Customer__c = :currentUserId ';
        }
        
        if(hasFilter(filters, 'status')){
            String STStatus = String.valueOf(filters.get('status'));
            if(STStatus != 'All'){
                if(STStatus == 'Cancelled'){
                    Set<String> cancelledStatus = new Set<String>{ORDERCANCELLED_CUSTOMER, ORDERCANCELLED_FILIGREEN};
                    //whereSearchParts.add('(Status__c IN :cancelledStatus)'); 
                    query += ' AND Status__c IN :cancelledStatus';
                } else {
                    //whereSearchParts.add('(Status__c = :STStatus)');
                    query += ' AND Status__c = :STStatus';
                }
            }
        }
        
        String searchTerm = '';
        Date createdDate = null;
        List<String> whereSearchParts = new List<String>();
        
        if(hasFilter(filters, 'searchTerm')){
            searchTerm = String.valueOf(filters.get('searchTerm'));
            if(String.isNotBlank(searchTerm)){
                if(searchTerm.indexOf('/') != -1){
                    try{
                        createdDate = Date.parse(searchTerm);
                    }catch(Exception e){
                        
                    }
                }
                searchTerm = '%' + searchTerm + '%';
                whereSearchParts.add('(Name LIKE :searchTerm)');
                whereSearchParts.add('(Retailer__r.Name LIKE :searchTerm)');
                whereSearchParts.add('(Status__c LIKE :searchTerm)');
                System.debug('##createdDate::'+createdDate);
                if(createdDate != null){
                    whereSearchParts.add('(Request_Ship_Date__c >= :createdDate AND Request_Ship_Date__c <= :createdDate)');
                }
            }
        }
        
        if(!whereSearchParts.isEmpty()){
            query += ' AND ('+ String.escapeSingleQuotes(String.join(whereSearchParts, ' OR '))+')';
        }
        
        query+= ' AND  Status__c != :excludeStatus AND RecordType.Name = :recordType ORDER BY '+ String.escapeSingleQuotes(orderBy);
        //query += ' AND  Status__c != :excludeStatus AND RecordType.Name = :recordType ORDER BY '+ String.escapeSingleQuotes(orderBy);
        for(Order__c o :Database.query(query)){
            ids.add(o.Id);
        }
        r.data.put('ids', ids);
        return r;
    }
    @AuraEnabled
    public static AuraResponse updateRMA(String recordId, String RMALineItemsData){
        AuraResponse r = new AuraResponse('ProductsCtlr.updateRMA()');
        Savepoint sp = Database.setSavepoint();
        try{
            RMALine[] items = (RMALine[])JSON.deserialize(RMALineItemsData, List<RMALine>.class);
            if(items.isEmpty()){
                r.errors.add(ADD_ATLEAST_ONE_ITEM_RMA);
            }
            
            r.handleErrors();
            Return_Line__c[] lines = new Return_Line__c[]{};
                for(RMALine RLI: items){
                    lines.add(new Return_Line__c(Id = RLI.Id,Return_Qty__c = RLI.returnQty,Return_Code__c = RLI.returnCode,
                                                 Additional_Return_Notes__c = RLI.additionalNotes));
                }
            update lines;
        }catch(Exception e){
            r.handleException(e);
            Database.rollback(sp);
        }
        return r;
    }
    @AuraEnabled
    public static AuraResponse saveRMARequest(String orderId,String SMId,String newRMARequestItmesData){
        Shipping_Manifest__c SM = [SELECT Id,Distributor_Contact__c, Distributor_License__c, Distributor_Name__c, Supplier_License__c, Supplier_Name__c FROM Shipping_Manifest__c WHERE Id = :SMId];
        AuraResponse r = new AuraResponse('ProductsCtlr.saveRMARequest()');
        Savepoint sp = Database.setSavepoint();
        try{
            if(String.isBlank(SMId)){
                r.errors.add(ORDER_MUST_HAVE_SM_RMA);
            }
            
            OrderLineItem[] items = (OrderLineItem[]) JSON.deserialize(newRMARequestItmesData,List<OrderLineItem>.class);
            if(items.isEmpty()){
                r.errors.add(ADD_ATLEAST_ONE_ITEM_RMA_REQ);
            }
            
            r.handleErrors();
            
            Returns__c  rItem = new Returns__c(Order_Number__c  = orderId,Shipping_Manifest__c  = SMId);
            rItem.Receiver_Contact__c = SM.Distributor_Contact__c;
            rItem.Receiver_License__c = SM.Distributor_License__c;
            rItem.Receiver_Name__c = SM.Distributor_Name__c;
            rItem.Supplier_Name__c = SM.Supplier_Name__c;
            rItem.Supplier_License__c = SM.Supplier_License__c;
            upsert rItem;
            Return_Line__c [] lineItems = new Return_Line__c[]{};
                for(OrderLineItem oli: items){
                    lineItems.add(new Return_Line__c( Order_Line_Item__c = oli.OLIId,Return__c = rItem.Id, Additional_Return_Notes__c = oli.additionalNotes,Return_Code__c = oli.returnCode, Return_Qty__c = oli.rquantity,Retail_Wholesale_Price__c = oli.unitPrice,Shipping_Manifest_Line__c = oli.SMLineId,Product__c = oli.productId, Price_Book_Entry_Id__c = oli.priceBookId));
                }
            upsert lineItems;
        }catch(Exception e){
            r.handleException(e);
            Database.rollback(sp);
        }
        return r;
    }
    @AuraEnabled
    public static AuraResponse approveRMAAndCreateOpp(String recordId){
        AuraResponse r = new AuraResponse('ProductsCtlr.approveRMAAndCreateOpp()');
        Returns__c RMARec = [SELECT Id, Name,Opportunity__c, Return_Status__c,Supplier_Name__c,Total_Qty__c,Shipping_Manifest__c,Shipping_Manifest__r.Name,Order_Number__c,(SELECT Id, Name,Additional_Return_Notes__c, Product__c,Product__r.Id , Product__r.Name,Product__r.Image_URL__c,Retail_Wholesale_Price__c, Return_Code__c,Return_Qty__c ,Return_Status__c ,Shipping_Manifest_Line__c, Shipping_Manifest_Line__r.Name,Price_Book_Entry_Id__c, Order_Line_Item__c , Order_Line_Item__r.Quantity_Cases__c  FROM Return_Lines__r) FROM Returns__c WHERE Id = :recordId];
        if(RMARec.Return_Status__c == RETURN_STATUS_APPROVED){
            r.errors.add(RMA_ALREADY_APPROVED);
        }else{
            Savepoint sp = Database.setSavepoint();
            try{
                Opportunity opp = new Opportunity(Name = RMARec.Name,StageName = STAGE_PROPOSAL_PRICE_QUOTE, RecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(OPP_RECORD_TYPE_RMA).getRecordTypeId(), Sales_Origin__c = SALES_ORIGIN_DISTY,Order__c   = RMARec.Order_Number__c, Ownership__c = RMARec.Supplier_Name__c,CloseDate=System.today());
                insert opp;
                RMARec.Opportunity__c = opp.Id;
                update RMARec;
                System.debug('###:'+[SELECT Id,Name,PriceBook2Id FROM Opportunity WHERE Id = :opp.Id].PriceBook2Id);
                OpportunityLineItem[] oliList = new OpportunityLineItem[]{};
                    for(Return_Line__c rl : RMARec.Return_Lines__r){
                        OpportunityLineItem oli = new OpportunityLineItem(
                            Product2 = rl.Product__r,
                            OpportunityId = opp.Id,
                            
                            PriceBookEntryId = Id.valueOf(rl.Price_Book_Entry_Id__c),
                            Quantity = rl.Return_Qty__c,
                            UnitPrice = rl.Retail_Wholesale_Price__c
                        );
                        oliList.add(oli);
                    }
                insert oliList;
            }catch(Exception e){
                r.handleException(e);
                Database.rollback(sp);
            }
        }
        r.handleErrors();
        return r;
    }
    @AuraEnabled
    public static AuraResponse RMAInit(String recordId){
        AuraResponse r = new AuraResponse('ProductsCtlr.RMAInit()');
        if(String.isNotBlank(recordId)){
            r = getRMADetails(recordId);
        }
        r.data.put('returnCode',Utility.getPicklistItems('Return_Line__c', 'Return_Code__c'));
        return r;
    }
    @AuraEnabled
    public static AuraResponse cancelRMA(String recordId){
        AuraResponse r = new AuraResponse('ProductsCtlr.cancelRMA()');
        try{
            Returns__c RMA = new Returns__c(Id = recordId, Return_Status__c = RETURN_STATUS_CANCELLED);
            update RMA;
            r = getRMADetails(recordId);
        }catch(Exception e){
            r.handleException(e);
        }
        r.handleErrors();
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getRMADetails(String recordId){
        AuraResponse r = new AuraResponse('ProductsCtlr.getRMADetails()');
        Returns__c RMARec = [SELECT Id, Name,Total_RMA_Amount__c ,Total_Excise_Tax__c ,Total_Product_Price__c , Order_Number__c , Order_Number__r.Name, Order_Number__r.Status__c,Order_Number__r.Order_Date__c, Return_Status__c,Total_Qty__c,Shipping_Manifest__c,Shipping_Manifest__r.Name,Shipping_Manifest__r.Status__c,Shipping_Manifest__r.Planned_Ship_Transfer_Date__c,(SELECT Id, Name,Additional_Return_Notes__c, Shipping_Manifest_Line__r.Product_Name__c , Shipping_Manifest_Line__r.Product_Name__r.Name,Shipping_Manifest_Line__r.Product_Name__r.Image_URL__c,Retail_Wholesale_Price__c, Return_Code__c,Return_Qty__c ,Return_Status__c ,Shipping_Manifest_Line__c, Shipping_Manifest_Line__r.Name,Shipping_Manifest_Line__r.Total_Return_Qty__c, Order_Line_Item__c , Order_Line_Item__r.Quantity_Cases__c ,Price_Book_Entry_Id__c FROM Return_Lines__r) FROM Returns__c WHERE Id = :recordId];
        RMA rma = new RMA(RMARec);
        r.data.put('RMA', rma);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getRetailOrderForReturn(String recordId){
        AuraResponse r = new AuraResponse('ProductsCtlr.getRetailOrderForReturn()');
        r = getRetailOrder(recordId);
        Order o = (Order) r.data.get('retailOrder');
        
        r.data.put('returnCode', Utility.getPicklistItems('Return_Line__c', 'Return_Code__c'));
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getRetailOrder(String recordId){
        AuraResponse r = new AuraResponse('ProductsCtlr.getRetailOrder()');
        //String docIds = '';
        Order__c o  = [SELECT Name, Order_Date__c, Total__c, Status__c, Shipping_Street__c, Shipping_Country__c, Shipping_Province__c,
                       Shipping_City__c, Shipping_Zip__c,Request_Ship_Date__c,Requested_Delivery_Latest_Time__c,
                       Requested_Delivery_Earliest_Time__c, 
                       (SELECT Quantity_Cases__c, UnitPrice__c, Line_Total_Cost__c, Unit_Excise_Tax__c, Line_Total_Excise_Tax__c,
                        Line_Total_Qty__c, MOQ__c, Total__c, Is_Sample__c, Price_Book_Entry_Id__c, Product__c, Product__r.Name,
                        Product__r.Image_URL__c, Product__r.Description, Product__r.Producer_Name__r.Name,Product__r.Producer_Name__c,
                        Product__r.Licensee_Name__c,Product__r.White_Labelled__c,Product__r.Brand_Virtual_Name__c,Product__r.Brand_Name__c,
                        Product__r.Product_Short_Description__c,Product__r.Product_Details__c, Product__r.Family, Product__r.Product_Rating__c,
                        Product__r.Available_Inventory__c,Product__r.Available_Qty__c,Is_Brand_Product__c,Product__r.Max_Order_Allowed__c
                        FROM Order_Line_Items__r order by Product__r.Product_Short_Description__c),
                       (SELECT Id,Name,Metrc_Manifest__c,Brand_Quote__c,Brand_Quote__r.Name,Receiver_DBA__c,Planned_Ship_Transfer_Date__c,
                        Payment_Terms__c,Ship_Confirmation_Date__c,Total_Line_Items__c,Total_Product_Cost__c,Status__c,RecordType.Name 
                        FROM Retail_Shipping_Manifests__r) 
                       FROM Order__c WHERE Id = :recordId];
        
        List<Invoice__c> lstInvoices = new List<Invoice__c>([SELECT Id,Name,AR_Status__c,Receiver_DBA__c,Brand_Quote__c,Brand_Quote__r.Name,Payment_Terms__c,
                                                             Ship_Confirmation_Date__c,Invoice_Balance__c,Collections_Status__c 
                                                             FROM Invoice__c WHERE Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c =: recordId AND RecordType.Name = 'Product']);
        
        
        if(lstInvoices.size() > 0){
            Set<Id> setInvIds = new Set<Id>();
            Map<Id,String> invoiceFileIds = new Map<Id,String>();
            
            for(Invoice__c inv : lstInvoices){
                setInvIds.add(inv.Id);
            }
            ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId IN :setInvIds ];
            System.debug('FIles = '+files.size());
            if(!files.isEmpty()){
                for(Invoice__c inv : lstInvoices){
                    Id invoiceId = inv.Id;
                    if(invoiceId != null){
                        String docIds = '';
                        String comma = '';
                        String[] pdfIds = new String[]{};
                            String[] otherIds = new String[]{};
                                for(ContentDocumentLink l:files){
                                    if(l.LinkedEntityId == invoiceId){
                                        System.debug('l.ContentDocument.FileExtension::'+l.ContentDocument.FileExtension);
                                        if(l.ContentDocument.FileExtension == 'pdf' || l.ContentDocument.FileExtension == 'jpg' ||
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
                        invoiceFileIds.put(inv.Id,docIds);//p.complianceFileId = docIds;
                    }
                }
                r.data.put('invoiceFileIds',invoiceFileIds);
            }
        }
        r.data.put('invoices',lstInvoices);
        
        
        if(o.Retail_Shipping_Manifests__r.size() > 0){
            Set<Id> setSMIds = new Set<Id>();
            Map<Id,String> SMFileIds = new Map<Id,String>();
            
            for(Shipping_Manifest__c sm : o.Retail_Shipping_Manifests__r){
                setSMIds.add(sm.Id);
            }
            ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId IN :setSMIds ];
            if(!files.isEmpty()){
                for(Shipping_Manifest__c sm : o.Retail_Shipping_Manifests__r){
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
        r.data.put('shipManifests',o.Retail_Shipping_Manifests__r);
        
        Map<Id,Id> mapProducerId = new Map<Id,Id>();
        for(Order_Line_Item__c oli: o.Order_Line_Items__r){
            if(oli.Product__r.White_Labelled__c && oli.Product__r.Licensee_Name__c != null){
                mapProducerId.put(oli.Product__c,oli.Product__r.Licensee_Name__c);
            } else if(oli.Product__r.Producer_Name__c != null){
                mapProducerId.put(oli.Product__c,oli.Product__r.Producer_Name__c);
            }
        }
        
        
        System.debug('MAP = '+mapProducerId);
        Order odr = new Order(o);
        Set<Id> SMIds = new Set<Id>();
        if(o.Retail_Shipping_Manifests__r.size() > 0){
            odr.SMMetrc = o.Retail_Shipping_Manifests__r[0].Metrc_Manifest__c;
            odr.SMPlannedShipDate = o.Retail_Shipping_Manifests__r[0].Planned_Ship_Transfer_Date__c;
            for(Shipping_Manifest__c sm: o.Retail_Shipping_Manifests__r){
                SMIds.add(sm.Id);
            }
        }
        RMA[] RMAList = new RMA[]{};
            if(String.isNotBlank(odr.SMId)){
                Returns__c[] RMAs = [SELECT Id, Name, Total_RMA_Amount__c ,Total_Excise_Tax__c ,Total_Product_Price__c ,Order_Number__c , Order_Number__r.Name, Order_Number__r.Status__c,Order_Number__r.Order_Date__c, Return_Status__c,Total_Qty__c,Shipping_Manifest__c,Shipping_Manifest__r.Name,Shipping_Manifest__r.Status__c,Shipping_Manifest__r.Planned_Ship_Transfer_Date__c,(SELECT Id, Name, Additional_Return_Notes__c,Price_Book_Entry_Id__c ,Shipping_Manifest_Line__r.Product_Name__c , Shipping_Manifest_Line__r.Product_Name__r.Name,Shipping_Manifest_Line__r.Product_Name__r.Image_URL__c,Retail_Wholesale_Price__c, Return_Code__c,Return_Qty__c ,Return_Status__c ,Shipping_Manifest_Line__c, Shipping_Manifest_Line__r.Name,Shipping_Manifest_Line__r.Total_Return_Qty__c, Order_Line_Item__r.Quantity_Cases__c FROM Return_Lines__r) FROM Returns__c WHERE Shipping_Manifest__c = :odr.SMId];
                for(Returns__c rma: RMAs){
                    RMAList.add(new RMA(rma));
                }
            }
        
        r.data.put('returnOrders',RMAList);
        System.debug('###SMIds:'+SMIds);
        if(!SMIds.isEmpty()){
            Set<Id> productIds = new Set<Id>();
            Set<String> batchIds = new Set<String>();
            Set<String> UIDs = new Set<String>();
            Shipping_Manifest__c[] SMList = [SELECT Id, Status__c,(SELECT Id,Total_Return_Qty__c, Harvest_Batch_Code__c   ,Batch_ID__c,UID_1__c,Product_Name__c,Shipping_Manifest__r.Planned_Ship_Transfer_Date__c ,Shipping_Manifest__c,Shipping_Manifest__r.Name FROM Shipping_Manifest_Lines__r) FROM Shipping_Manifest__c WHERE Id IN :SMIds];
            
            Map<Id, Shipping_Manifest_Line__c> SMLProdutMap = new Map<Id, Shipping_Manifest_Line__c>();
            for(Shipping_Manifest__c SM: SMList){
                for(Shipping_Manifest_Line__c SML: SM.Shipping_Manifest_Lines__r){
                    productIds.add(SML.Product_Name__c);
                    SMLProdutMap.put(SML.Product_Name__c,SML);
                    batchIds.add(SML.Harvest_Batch_Code__c  );
                    UIDs.add(SML.UID_1__c);
                }
            }
            for(OrderLineItem oli: odr.items){
                if(SMLProdutMap.containsKey(oli.productId)){
                    Shipping_Manifest_Line__c SML = SMLProdutMap.get(oli.productId);
                    oli.SMLineId = SML.Id;
                    oli.SMId = SML.Shipping_Manifest__c;
                    oli.SMName = SML.Shipping_Manifest__r.Name;
                    oli.planShipDate = SML.Shipping_Manifest__r.Planned_Ship_Transfer_Date__c;
                    oli.totalReturnQty = (SML.Total_Return_Qty__c != null?SML.Total_Return_Qty__c:0);
                }
            }
            System.debug('productIds::'+productIds);
            System.debug('batchIds::'+batchIds);
            System.debug('UIDs::'+UIDs);
            Map<Id,Compliance_Images__c> cImages = new Map<Id,Compliance_Images__c>([SELECT Id,Name, Product__c , Harvest_Batch_Code__r.Name , UID_New__r.Name , COA_Issued_Date__c
                                                                                     FROM Compliance_Images__c
                                                                                     WHERE  COA_Expiration_Date__c >= :System.today() AND Lab_Test_Status__c =: LAB_TEST_STATUS_TESTED_PASSED AND Product__c IN :productIds AND Harvest_Batch_Code__r.Name IN :batchIds AND UID_New__r.Name IN :UIDs]);
            System.debug('##cImages::'+cImages);
            if(!cImages.isEmpty()){
                Map<String, Compliance_Images__c[]> cImagesMap = new Map<String, Compliance_Images__c[]>();
                for(Compliance_Images__c cImage: cImages.values()){
                    String key = cImage.Product__c +'-'+cImage.Harvest_Batch_Code__r.Name+'-'+cImage.UID_New__r.Name;
                    System.debug('##cImage-key::'+key);
                    if(cImagesMap.containsKey(key)){
                        cImagesMap.get(key).add(cImage);
                    }else{
                        cImagesMap.put(key, new Compliance_Images__c[]{cImage});
                    }
                }
                System.debug('###cImagesMap:'+cImagesMap);
                Map<String,List<String>> complianceFilesMap = new  Map<String,List<String>>();
                ContentDocumentLink[] files = new ContentDocumentLink[] {};
                    //if(!Test.isRunningTest()){
                    Set<Id> parentIds = cImages.keySet();
                files = (ContentDocumentLink[]) Database.query('SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId IN : parentIds');
                //}
                
                if(!files.isEmpty()){
                    for(ContentDocumentLink l:files){
                        if(complianceFilesMap.containsKey(l.LinkedEntityId)){
                            complianceFilesMap.get(l.LinkedEntityId).add(l.ContentDocumentId);
                        }else{
                            complianceFilesMap.put(l.LinkedEntityId, new List<String>{l.ContentDocumentId});
                        }
                    }
                    for(OrderLineItem oli: odr.items){
                        if(SMLProdutMap.containsKey(oli.productId)){
                            Shipping_Manifest_Line__c SML = SMLProdutMap.get(oli.productId);
                            String key = SML.Product_Name__c +'-'+SML.Harvest_Batch_Code__c+'-'+SML.UID_1__c;
                            System.debug('##key:'+key);
                            if(cImagesMap.containsKey(key)){
                                Compliance_Images__c[] cImgs = cImagesMap.get(key);
                                if(cImgs != null && cImgs.size() > 0){
                                    String[] fileIds = new String[]{};
                                        for(Compliance_Images__c ci :cImgs){
                                            if(complianceFilesMap.containsKey(ci.Id)){
                                                fileIds.addAll(complianceFilesMap.get(ci.Id));
                                                
                                            }
                                        }
                                    oli.fileIds = String.join(fileIds, ',');
                                }
                            }
                        }
                    }
                }
            }
        }
        for(OrderLineItem oli: odr.items){
            if(mapProducerId.containsKey(oli.productId)){
                oli.producerId = mapProducerId.get(oli.productId);
            }
        }
        r.data.put('retailOrder',odr);
        r.data.put('Retail_MOV_Fee',Retail_MOV_Fee);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getOrders(List<String> ids, Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getOrders()');
        String orderByField = ORDERBY_ORDER_DATE;
        String direction = DESC_DIRECTION;
        String orderBy = '';
        if(filters != null){
            if(hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        Id currentUserId = Userinfo.getUserId();
        String excludeStatus = STATUS_DRAFT;
        List<Order> orders = new List<Order>();
        Set<Id> productIds = new Set<Id>();
        Set<Id> reviewsProductIds = new Set<Id>();
        Map<Id,Order__c> ordersMap = new Map<Id,Order__c>();
        Set<Id> SMIds = new Set<Id>();
        for(Order__c o :Database.query('SELECT Name, Order_Date__c,Requested_Delivery_Earliest_Time__c,Requested_Delivery_Latest_Time__c,Request_Ship_Date__c , Total__c, Status__c, Shipping_Street__c, Shipping_Country__c, Shipping_Province__c, Shipping_City__c, Shipping_Zip__c, (SELECT Quantity_Cases__c, UnitPrice__c, Line_Total_Cost__c, Unit_Excise_Tax__c, Line_Total_Excise_Tax__c, Line_Total_Qty__c, MOQ__c, Total__c, Is_Sample__c, Price_Book_Entry_Id__c, Product__c, Product__r.Name, Product__r.Image_URL__c, Product__r.Description, Product__r.Producer_Name__r.Name,Product__r.Brand_Name__c,Product__r.Product_Short_Description__c,Product__r.Product_Details__c, Product__r.Family, Product__r.Product_Rating__c, Product__r.Available_Inventory__c,Product__r.Available_Qty__c,Is_Brand_Product__c,Product__r.Max_Order_Allowed__c  FROM Order_Line_Items__r),(SELECT Id ,Name,Status__c FROM Retail_Shipping_Manifests__r) FROM Order__c WHERE Id IN :ids ORDER BY '+ String.escapeSingleQuotes(orderBy))){
            orders.add(new Order(o));
            ordersMap.put(o.Id,o);
            if(o.Retail_Shipping_Manifests__r.size() > 0){
                for(Shipping_Manifest__c sm: o.Retail_Shipping_Manifests__r){
                    SMIds.add(sm.Id);
                }
                
            }
            if(o.Order_Line_Items__r.size() > 0){
                for(Order_Line_Item__c oli: o.Order_Line_Items__r){
                    productIds.add(oli.Product__c);
                }
                
            }
        }
        
        if(!productIds.isEmpty()){
            for(Product_Review__c pr:  [SELECT Id, Rating__c, Product__c FROM Product_Review__c WHERE Product__c IN: productIds AND CreatedById =: UserInfo.getUserId()]){
                reviewsProductIds.add(pr.Product__c);
            }
        }
        if(!orders.isEmpty()){
            for(Order o: orders){
                if(o.items.size() > 0){
                    for(OrderLineItem oli: o.items){
                        if(reviewsProductIds.contains(oli.id)){
                            oli.hasReview = true;
                        }
                    }
                }
            }
        }
        
        r.data.put('records', orders);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse removeProduct(String productId){
        AuraResponse r = new AuraResponse('ProductsCtlr.removeProduct()');
        
        try{
            Order__c o = getDraftOrder();
            System.debug('##productId:'+productId);
            System.debug('##User:'+UserInfo.getUserId());
            List<Order_Line_Item__c> olis = new List<Order_Line_Item__c>([SELECT Id FROM Order_Line_Item__c WHERE Product__c = :productId AND Order__c = :o.Id AND Order__r.Customer__c = :UserInfo.getUserId()]);
            if(!olis.isEmpty()){
                delete olis;
            }
            
            return getCartItems();
        }catch(Exception e){
            r.handleException(e);
        }
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse verifyProductsAvailability(String siteId){
        AuraResponse r = new AuraResponse('ProductsCtlr.verifyProductsAvailability()');
        
        List<Order_Line_item__c> orderLineItems = new List<Order_Line_item__c>();
        Order__c o = getDraftOrder();
        Integer totalItems = verifyQuantities(r, o, orderLineItems,siteId);
        r.handleErrors();
        r.data.put('order',o);
        r.data.put('totalItems',totalItems);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getAddresses(){
        AuraResponse r = new AuraResponse('ProductsCtlr.getAddresses()');
        
        List<LicenseAddress> addresses = new List<LicenseAddress>();
        for(State_Licenses__c sl :[SELECT Default_Warehouse__c,Default_Warehouse__r.Warehouse_Name__c,License_Address__c, License_City__c, License_State__c, License_Country__c, License_Zip__c, License_Expiration_Date__c, License_Status__c, License_Class__c ,License_Type__c , License_Number__c  FROM State_Licenses__c WHERE License_Name__c = :Utility.loggedInUser.Contact.AccountId ORDER BY License_Expiration_Date__c DESC]){
            addresses.add(new LicenseAddress(sl));
        }
        
        r.data.put('isCartEmpty', (1 > Utility.getCartTotal()));
        r.data.put('existingAddresses', addresses);
        r.data.put('baseUrl', Site.getBaseUrl());
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse cancelOrder(String orderId){
        AuraResponse r = new AuraResponse('ProductsCtlr.cancelOrder()');
        try{
            Order__c o = new Order__c(Id=orderId,Status__c = ORDERCANCELLED_CUSTOMER);
            update o;
        }catch(Exception e){
            r.errors.add(e.getMessage());
        }
        
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse checkout(String retailerId,String contactId,Date requestShipDate, String addressId,Boolean excludeExciseTax,String  requestShipEarliestTime,String requestShipLatestTime){
        AuraResponse r = new AuraResponse('ProductsCtlr.checkout()');
        
        State_Licenses__c address;
        for(State_Licenses__c ca :[SELECT Default_Warehouse__c, License_Address__c, License_City__c, License_State__c, License_Country__c, License_Zip__c, License_Expiration_Date__c, License_Status__c FROM State_Licenses__c WHERE Id = :addressId ]){//AND License_Name__c = :Utility.loggedInUser.Contact.AccountId
            address = ca;
        }
        
        List<Order_Line_item__c> orderLineItems = new List<Order_Line_item__c>();
        Order__c o = getDraftOrder();
        if(String.isNotBlank(retailerId)){
            o.Retailer__c = retailerId;
            
        }
        
        o.Payment_Terms__c = [SELECT Id, Payment_Terms__c FROM Account WHERE Id = : Utility.loggedInUser.AccountId].Payment_Terms__c;
        if(String.isNotBlank(contactId)){
            o.Retailer_Contact__c = contactId;
        }
        Integer totalItems = verifyQuantities(r, o, orderLineItems,address.Default_Warehouse__c);
        
        if(totalItems == 0){
            r.errors.add(CART_IS_EMPTY);
        }
        
        if(address == null){
            r.errors.add(ADDRESS_NOT_FOUND);
        }
        r.handleErrors();
        
        Savepoint sp = Database.setSavepoint();
        try{
            o.Exclude_Excise_Tax__c  = excludeExciseTax;
            o.State_License__c = addressId;
            o.Order_Date__c = System.NOW();
            o.Status__c = STATUS_PENDING;
            o.Shipping_Street__c = address.License_Address__c;
            o.Shipping_Country__c = address.License_Country__c;
            o.Shipping_Province__c = address.License_State__c;
            o.Shipping_City__c = address.License_City__c;
            o.Shipping_Zip__c = address.License_Zip__c;
            o.Request_Ship_Date__c = requestShipDate;
            if(requestShipEarliestTime != NULL && requestShipEarliestTime != ''){
                String[] eTime = requestShipEarliestTime.split(':');
                o.Requested_Delivery_Earliest_Time__c = Time.newInstance(Integer.valueOf(eTime[0]),Integer.valueOf(eTime[1]), 0, 0);   
            }
            if(requestShipLatestTime != NULL && requestShipLatestTime != ''){
                String[] lTime = requestShipLatestTime.split(':');
                o.Requested_Delivery_Latest_Time__c = Time.newInstance(Integer.valueOf(lTime[0]),Integer.valueOf(lTime[1]), 0, 0);   
            }
            update o;
            update orderLineItems;
            
            Decimal totalAmt = 0;
            for(Order_Line_item__c oli : orderLineItems){
                totalAmt += oli.Total__c;
            }
            if(totalAmt < 1000){
                List<Order_Line_Item__c> newOli = new List<Order_Line_Item__c>();
                
                for(PricebookEntry pbe: [SELECT Id, Product2.Name,Product2.Apply_Excise_Tax__c,Product2.Case_Shipping_Weight_lbs__c,
                                         Product2.Image_URL__c,Product2.Brand_Name__c,Product2.Description,Product2.Family,Product2.White_Labelled__c,
                                         Product2.Licensee_Name__c,Product2.Licensee_Name__r.Name,Product2.Status__c,Product2.Product_Details__c,Product2.Terpene_percent__c,
                                         Product2.Strain__r.Name,Product2.Strain_Type__c,Product2.THC_Amount__c,Product2.THC_MG_G__c,
                                         Product2.CDB_Amount__c,Product2.CBD_MG_G__c,Product2.Cultivation_Type__c,Product2.Product_Rating__c,
                                         Product2.Inventory_On_Hold_Qty__c,Product2.Total_Order_Qty__c,Product2.Fulfilled_by_Filigreen__c,
                                         Product2.MSRP__c,
                                         Product2.Producer_Name__c,Product2.Producer_Name__r.Name , UnitPrice,Product2.Available_Inventory__c,Product2.Available_Qty__c,
                                         Product2.Unit_Shipping_Weight_lbs__c,Product2.Max_Order_Allowed__c, Product2.RecordTypeId,
                                         Product2.RecordType.Name,Product2.Parent_Product__c,Product2.Is_Sample__c,Product2.Product_Short_Description__c,
                                         Product2.MOQ__c FROM PriceBookEntry WHERE Product2.Name =: Retail_MOV_Fee AND PriceBook2.Name = 'Standard Price Book' LIMIT 1]){
                    Product p = new Product(pbe);
                    String ownerId = '';
                    if(String.isNotBlank(p.id)){
                        if(pbe.Product2.White_Labelled__c){
                            ownerId = pbe.Product2.Licensee_Name__c;
                        }else{
                            ownerId = pbe.Product2.Producer_Name__c;
                        }
                    }
                    
                    Order_Line_Item__c oli = new Order_Line_Item__c(Id = null,
                                                                    Order__c = o.Id,
                                                                    Price_Book_Entry_Id__c = p.price.Id,
                                                                    Product__c = p.id,
                                                                    Quantity_Cases__c = 1,
                                                                    MOQ__c = p.MOQ,
                                                                    Ownership_Code__c  = ownerId,
                                                                    UnitPrice__c = pbe.UnitPrice,
                                                                    Special_Instructions__c = null,
                                                                    Is_Sample__c = False);
                    newOli.add(oli);
                }
                if(newOli.size() > 0) insert newOli;
            }
            
            r.data.put('order', o);
        }catch(DmlException e){
            Database.rollback(sp);
            r.handleException(e);
        }
        
        return r;
    }
    
    private static Integer verifyQuantities(AuraResponse r, Order__c o, List<Order_Line_item__c> orderLineItems,String siteId){
        Set<String> pricebookEntries = new Set<String>();
        Set<String> productIds = new Set<String>();
        Set<Id> producerIds = new Set<Id>();
        Map<String,Order_Line_Item__c> productOLIMap = new Map<String,Order_Line_Item__c>();
        Map<String,Order_Line_Item__c[]> producerOLIMap = new Map<String,Order_Line_Item__c[]>();
        for(Order_Line_Item__c oli :[SELECT Quantity_Cases__c, UnitPrice__c, Line_Total_Cost__c, Unit_Excise_Tax__c, Line_Total_Excise_Tax__c, Line_Total_Qty__c, MOQ__c, Total__c, Is_Sample__c, Price_Book_Entry_Id__c, Product__c, Product__r.Name, Product__r.Image_URL__c, Product__r.Description, Product__r.Product_Details__c, Product__r.Producer_Name__c,Product__r.Licensee_Name__c ,Product__r.White_Labelled__c ,Product__r.Producer_Name__r.Name,Product__r.Brand_Name__c,Product__r.Product_Short_Description__c, Product__r.Family, Product__r.Product_Rating__c, Product__r.Available_Inventory__c,Product__r.Available_Qty__c, Is_Brand_Product__c FROM Order_Line_Item__c WHERE Order__c = :o.Id]){
            orderLineItems.add(oli);
            productIds.add(oli.Product__c);
            String producerId = '';
            
            producerId = oli.Product__r.Producer_Name__c;
            producerIds.add(oli.Product__r.Producer_Name__c);
            if(producerOLIMap.containsKey(producerId)){
                producerOLIMap.get(producerId).add(oli);
            }else{
                producerOLIMap.put(producerId , new Order_Line_Item__c[]{oli});
            } 
            productOLIMap.put(oli.Product__c,oli);
            pricebookEntries.add(oli.Price_Book_Entry_Id__c);
        }
        
        Map<String, PricebookEntry> productUnitPrice = new Map<String, PricebookEntry>();
        for(PricebookEntry pbe :[SELECT UnitPrice, Product2Id,Product2.Status__c,Product2.Name, Product2.Available_Inventory__c,Product2.Available_Qty__c FROM PricebookEntry WHERE Id IN :pricebookEntries]){
            productUnitPrice.put(pbe.Id, pbe);
        }
        Map<String,Decimal> siteOrderedMap = getWarehouseOrderedMap(productIds);
        Map<Id,WarehouseAvailableInventory[]> siteAvailaleQtyMap = getWarehouseAvailableInventory(productIds);
        Integer totalItems = 0;
        for(Order_Line_Item__c orderLineItem :orderLineItems){
            if(productUnitPrice.containsKey(orderLineItem.Price_Book_Entry_Id__c)){
                totalItems++;
                PricebookEntry pbe = productUnitPrice.get(orderLineItem.Price_Book_Entry_Id__c);
                String keySP = siteId +'-'+ pbe.Product2Id;
                Decimal availableQty = 0;
                Decimal totalOrderedQty = 0;
                
                
                System.debug('##siteOrderedMap:'+siteOrderedMap);
                WarehouseAvailableInventory[] siteAvailableDetails = new List<WarehouseAvailableInventory>();
                if(siteAvailaleQtyMap.containsKey(pbe.Product2Id)){
                    siteAvailableDetails = siteAvailaleQtyMap.get(pbe.Product2Id);
                }
                System.debug('##siteAvailableDetails:'+siteAvailableDetails);
                for(WarehouseAvailableInventory WI: siteAvailableDetails){
                    String key = WI.Id +'-'+ pbe.Product2Id;
                    System.debug('##siteId:'+siteId);
                    System.debug('##WI.id:'+WI.id);
                    if(siteId == WI.id){
                        System.debug('##WI:'+WI);
                        if(siteOrderedMap.containsKey(key)){
                            totalOrderedQty = siteOrderedMap.get(key);
                        }
                        System.debug('##totalOrderedQty:'+totalOrderedQty);
                        availableQty = WI.availableInventory - totalOrderedQty;
                        break;
                    }
                }
                
                System.debug('##availableQty:'+Product2.Name+'=>'+availableQty);
                if(test.isRunningTest()){availableQty = 1000;}
                if(availableQty < (orderLineItem.MOQ__c * orderLineItem.Quantity_Cases__c)){
                    r.errors.add(String.format(PRODUCT_QTY_UNAVAILABLE,new List<String>{String.valueOf(pbe.Product2.Name)}));
                }
                if(orderLineItem.Is_Sample__c){
                    orderLineItem.UnitPrice__c = 0.01;    
                } else {
                    orderLineItem.UnitPrice__c = pbe.UnitPrice;    
                }
                
            }
        }
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Brand__c IN: producerIds AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now()]){
            List<Order_Line_Item__c> products = producerOLIMap.get(bd.Brand__c);
            if(products != null){
                for(Order_Line_Item__c oli: products){
                    Decimal discountPercent = bd.Discount_Percentage__c;
                    if(productUnitPrice.containsKey(oli.Price_Book_Entry_Id__c)){
                        PricebookEntry pbe = productUnitPrice.get(oli.Price_Book_Entry_Id__c);
                        Decimal discount = 0;
                        if(discountPercent != null && pbe != null && pbe.UnitPrice != null){
                            discount = (pbe.UnitPrice * discountPercent) /100;
                        }else{
                            discount = 0;
                        }
                        Decimal salePrice = 0;
                        if(discount != null  && pbe != null && pbe.UnitPrice != null){
                            salePrice = pbe.UnitPrice - discount;
                        }
                        salePrice = salePrice.setScale(2);
                        if(oli.Is_Sample__c){
                            oli.UnitPrice__c = 0.01;    
                        } else if(discount > 0){
                            oli.UnitPrice__c = salePrice;
                        }else{
                            oli.UnitPrice__c = pbe.UnitPrice;    
                        }
                    }
                }
                
            }
        }
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Product_Name__c IN: productIds AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now()]){
            Order_Line_Item__c oli = productOLIMap.get(bd.Product_Name__c);
            Decimal discountPercent = bd.Discount_Percentage__c;
            if(oli != null){
                if(productUnitPrice.containsKey(oli.Price_Book_Entry_Id__c)){
                    PricebookEntry pbe = productUnitPrice.get(oli.Price_Book_Entry_Id__c);
                    Decimal discount = 0;
                    if(discountPercent != null && pbe != null && pbe.UnitPrice != null){
                        discount = (pbe.UnitPrice * discountPercent) /100;
                    }else{
                        discount = 0;
                    }
                    Decimal salePrice = 0;
                    if(discount != null  && pbe != null && pbe.UnitPrice != null){
                        salePrice = pbe.UnitPrice - discount;
                    }
                    salePrice = salePrice.setScale(2);
                    if(oli.Is_Sample__c){
                        oli.UnitPrice__c = 0.01;    
                    } else if(discount > 0){
                        oli.UnitPrice__c = salePrice;
                    }else{
                        oli.UnitPrice__c = pbe.UnitPrice;    
                    }
                }
                
            }
        }
        return totalItems;
    }
    
    @AuraEnabled
    public static AuraResponse insertStrain(String recName,String StrainType){
        AuraResponse r = new AuraResponse('ProductsCtlr.insertStrain()');
        
        Strain__c str = new Strain__c();
        str.Name = recName;
        str.Strain_Type__c = StrainType;
        str.isActive__c = true;
        insert str;
        
        r.data.put('newRec', str);
        return r;
    }
        
    @AuraEnabled 
    public static Map<String, String> getStrainTypesValues(){
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult fieldResult = Strain__c.Strain_Type__c.getDescribe();
        List<Schema.PicklistEntry> pValues = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pValues) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
    
    @AuraEnabled
    public static AuraResponse getRecentProducts(Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getRecentProducts()');
        
        Map<String, Product> records = new Map<String, Product>();
        Map<String, List<Product>> procuderProducts = new Map<String, List<Product>>();
        for(PricebookEntry pbe :(List<PricebookEntry>)Database.query(getQuery(new List<String>{'Product2.MSRP__c','UnitPrice','Product2.Is_Sample__c', 'Product2.RecordType.Name','Product2.Status__c','Product2.Name', 'Product2.Product_Rating__c', 'Product2.Available_Inventory__c','Product2.Inventory_On_Hold_Qty__c', 'Product2.Available_Qty__c', 'Product2.Total_Order_Qty__c', 'Product2.Family', 'Product2.Description','Product2.Product_Short_Description__c', 'Product2.Product_Details__c', 'Product2.Producer_Name__r.dBA__c','Product2.Licensee_Name__c','Product2.Licensee_Name__r.Name','Product2.Producer_Name__r.Name','Product2.White_Labelled__c','Product2.Brand_Name__c', 'Product2.Cultivation_Type__c', 'Product2.Image_URL__c','Product2.MOQ__c','Product2.Strain__r.Name','Product2.Strain_Type__c','Product2.Terpene_percent__c','Product2.THC_Amount__c','Product2.THC_MG_G__c','Product2.CDB_Amount__c','Product2.CBD_MG_G__c','Product2.Fulfilled_by_Filigreen__c'}, new List<String>(), 'Product2.Emerging_Product_Order__c', 10))){
            Product p = new Product(pbe);
            records.put(pbe.Product2Id, p);
            if(procuderProducts.containsKey(pbe.Product2.Producer_Name__c)){
                procuderProducts.get(pbe.Product2.Producer_Name__c).add(p);
            }else{
                procuderProducts.put(pbe.Product2.Producer_Name__c,new List<Product>{p});
            }
        }
        Map<Id,Id> productComplianceImageMap = new Map<Id,Id>();
        Set<Id> complianceIds = new Set<Id>();
        Map<Id,WarehouseAvailableInventory[]> warehouseAvailableInventoryMap = getWarehouseAvailableInventory(records.keySet());
        for(Product2 tmpProduct:[SELECT Id,Image_URL__c, (SELECT Image_URL__c FROM Product_Images__r),(SELECT Id,Name, COA_Issued_Date__c  FROM Compliance_Images__r WHERE COA_Expiration_Date__c >= :System.today() Order By COA_Issued_Date__c DESC) FROM Product2 WHERE Id IN:records.keySet()]){
            if(tmpProduct.Compliance_Images__r.size() > 0){
                productComplianceImageMap.put(tmpProduct.Id,tmpProduct.Compliance_Images__r[0].Id);
                complianceIds.add(tmpProduct.Compliance_Images__r[0].Id);
            }
            Product p = records.get(tmpProduct.Id);
            p.setImages(tmpProduct);
            p.availableInventories = warehouseAvailableInventoryMap.get(tmpProduct.Id);
            if(!complianceIds.isEmpty()){
                System.debug('###complianceIds::'+complianceIds);
                ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId IN :complianceIds ];//AND ContentDocument.FileExtension = 'pdf'
                System.debug('##'+files);
                //ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title,ContentDocument.FileType FROM ContentDocumentLink WHERE LinkedEntityId IN: complianceIds AND ContentDocument.FileExtension = 'pdf'];
                if(!files.isEmpty()){
                    if(productComplianceImageMap.containsKey(p.Id)){
                        Id complianceId = productComplianceImageMap.get(p.Id);
                        if(complianceId != null){
                            String docIds = '';
                            String comma = '';
                            String[] pdfIds = new String[]{};
                            String[] otherIds = new String[]{};
                            for(ContentDocumentLink l:files){
                                if(l.LinkedEntityId == complianceId){
                                    if(l.ContentDocument.FileExtension == 'pdf') pdfIds.add(l.ContentDocumentId);
                                    else otherIds.add(l.ContentDocumentId);
                                    //docIds += comma + l.ContentDocumentId;
                                    //comma = ',';
                                }
                            }
                            docIds = (!pdfIds.isEmpty()?String.join(pdfIds,','):'');
                            if(String.isNotBlank(docIds)){
                                docIds += ','+(!otherIds.isEmpty()?String.join(otherIds,','):'');
                            }else{
                                docIds = (!otherIds.isEmpty()?String.join(otherIds,','):'');
                            }
                            p.complianceFileId = docIds;
                        }
                    }
                    System.debug('###p.complianceFileId:::'+p.complianceFileId);
                }
            }
        }
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Brand__c IN: procuderProducts.keySet() AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now()]){
            List<Product> products = procuderProducts.get(bd.Brand__c);
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
        for(Product_Stock_Notification__c psn :[SELECT Product__c FROM Product_Stock_Notification__c WHERE Product__c IN :records.keySet() AND Sent_Notification__c = false]){
            records.get(psn.Product__c).notifyRequested(true);
        }
        
        r.data.put('products', records.values());
        r.data.put('warehouseTotalOrderedMap',getWarehouseOrderedMap(records.keySet()));
        
        r.data.put('isBrand', isBrand);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getMostPopularProducts(Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getMostPopularProducts()');
        Map<String, Product> records = new Map<String, Product>();
        Map<String, List<Product>> procuderProducts = new Map<String, List<Product>>();
        for(PricebookEntry pbe :(List<PricebookEntry>)Database.query(getQuery(new List<String>{'Product2.MSRP__c','Product2.Status__c','UnitPrice', 'Product2.Name', 'Product2.Product_Rating__c', 'Product2.Available_Inventory__c','Product2.Inventory_On_Hold_Qty__c', 'Product2.Available_Qty__c', 'Product2.Total_Order_Qty__c', 'Product2.Family', 'Product2.Description','Product2.Product_Short_Description__c', 'Product2.Product_Details__c', 'Product2.Producer_Name__r.dBA__c','Product2.Producer_Name__r.Name','Product2.White_Labelled__c','Product2.Brand_Name__c', 'Product2.Cultivation_Type__c', 'Product2.Image_URL__c','Product2.MOQ__c','Product2.Strain__r.Name','Product2.Strain_Type__c','Product2.Terpene_percent__c','Product2.THC_Amount__c','Product2.THC_MG_G__c','Product2.CDB_Amount__c','Product2.CBD_MG_G__c','Product2.Fulfilled_by_Filigreen__c'}, new List<String>{'Product2.Most_Popular__c = true'}, 'Product2.Emerging_Product_Order__c', 10))){
            Product p = new Product(pbe);
            records.put(pbe.Product2Id, p);
            if(procuderProducts.containsKey(pbe.Product2.Producer_Name__c)){
                procuderProducts.get(pbe.Product2.Producer_Name__c).add(p);
            }else{
                procuderProducts.put(pbe.Product2.Producer_Name__c,new List<Product>{p});
            }
        }
        Map<Id,Id> productComplianceImageMap = new Map<Id,Id>();
        Set<Id> complianceIds = new Set<Id>();
        for(Product2 tmpProduct:[SELECT Id,Image_URL__c, (SELECT Image_URL__c FROM Product_Images__r),(SELECT Id,Name, COA_Issued_Date__c  FROM Compliance_Images__r WHERE COA_Expiration_Date__c >= :System.today() Order By COA_Issued_Date__c DESC) FROM Product2 WHERE Id IN:records.keySet()]){
            if(tmpProduct.Compliance_Images__r.size() > 0){
                productComplianceImageMap.put(tmpProduct.Id,tmpProduct.Compliance_Images__r[0].Id);
                complianceIds.add(tmpProduct.Compliance_Images__r[0].Id);
            }
            Product p = records.get(tmpProduct.Id);
            p.setImages(tmpProduct);
            if(!complianceIds.isEmpty()){
                System.debug('###complianceIds::'+complianceIds);
                ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId IN :complianceIds ];//AND ContentDocument.FileExtension = 'pdf'
                System.debug('##'+files);
                //ContentDocumentLink[] files = [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title,ContentDocument.FileType FROM ContentDocumentLink WHERE LinkedEntityId IN: complianceIds AND ContentDocument.FileExtension = 'pdf'];
                if(!files.isEmpty()){
                    if(productComplianceImageMap.containsKey(p.Id)){
                        Id complianceId = productComplianceImageMap.get(p.Id);
                        if(complianceId != null){
                            String docIds = '';
                            String comma = '';
                            String[] pdfIds = new String[]{};
                            String[] otherIds = new String[]{};
                            for(ContentDocumentLink l:files){
                                if(l.LinkedEntityId == complianceId){
                                    if(l.ContentDocument.FileExtension == 'pdf') pdfIds.add(l.ContentDocumentId);
                                    else otherIds.add(l.ContentDocumentId);
                                    //docIds += comma + l.ContentDocumentId;
                                    //comma = ',';
                                }
                            }
                            docIds = (!pdfIds.isEmpty()?String.join(pdfIds,','):'');
                            if(String.isNotBlank(docIds)){
                                docIds += ','+(!otherIds.isEmpty()?String.join(otherIds,','):'');
                            }else{
                                docIds = (!otherIds.isEmpty()?String.join(otherIds,','):'');
                            }
                            p.complianceFileId = docIds;
                        }
                    }
                    System.debug('###p.complianceFileId:::'+p.complianceFileId);
                }
            }
        }
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Brand__c IN: procuderProducts.keySet() AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :system.now()]){
            List<Product> products = procuderProducts.get(bd.Brand__c);
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
        for(Product_Stock_Notification__c psn :[SELECT Product__c FROM Product_Stock_Notification__c WHERE Product__c IN :records.keySet() AND Sent_Notification__c = false]){
            records.get(psn.Product__c).notifyRequested(true);
        }
        
        r.data.put('products', records.values());
        
        r.data.put('isBrand', isBrand);
        return r;
    }
    
    private static Id getRetailerAccount(){
        Id userId = UserInfo.getUserId();
        Id accountId = [Select AccountId from User where Id=:userId LIMIT 1].AccountId;
        return accountId;
    }
    
    @AuraEnabled
    public static AuraResponse getRecentBrands(Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getRecentBrands()');
        List<String> includeTypes = new List<String>{ACCOUNT_TYPE_DISTRIBUTOR,ACCOUNT_TYPE_CULTIVATOR,ACCOUNT_TYPE_MANUFACTURER,ACCOUNT_TYPE_PRODUCER,ACCOUNT_TYPE_PARTNER,ACCOUNT_TYPE_RESELLER};
            List<Brand> brands = new List<Brand>();
        Id accountId = getRetailerAccount();
        for(Account a :[SELECT Business_Type__c,Name, dBA__c,Description,Image_URL__c, Phone, Fax, Website, Account_Rating__c, Payment_Terms__c, Id, BillingStreet, BillingCity, BillingState, BillingCountry, BillingPostalCode, Twitter__c , Facebook__c, LinkedIn__c, About_Us__c, Instagram__c,
                        (Select Brand_Account_Rating__c, Mutual_Payment_Terms__c, Onboard_Date__c,Sales_Person__c,Sales_Person__r.Name from Line_Cards__r where Retailer_Name__c =:accountId)
                        FROM Account  WHERE Type IN:includeTypes AND Hide_From_Marketplace__c = false ORDER BY Emerging_Brand_Order__c, Name  LIMIT 10]){
                            brands.add(new Brand(a));
                        }
        
        r.data.put('brands', brands);
        r.data.put('isBrand', isBrand);
        return r;
    }
    @AuraEnabled
    public static AuraResponse getBrand(String id){
        AuraResponse r = new AuraResponse('ProductsCtlr.getBrand()');
        Id retailerId = getRetailerAccount();
        System.debug('retailerId = '+retailerId);
        System.debug('id = '+id);
        for(Account ac :[SELECT Business_Type__c,Name, dBA__c,Description,Image_URL__c, Phone, Fax, Website, Account_Rating__c, Payment_Terms__c, Id, BillingStreet, BillingCity, BillingState, BillingCountry, BillingPostalCode, Twitter__c, Facebook__c, LinkedIn__c, About_Us__c, Instagram__c,
                         (Select Brand_Account_Rating__c,Retail_Account_Rating__c,Retailer_Name__c,Retailer_Name__r.Name,Sales_Person__c,Sales_Person__r.Name, Mutual_Payment_Terms__c, Onboard_Date__c from Line_Cards__r where Retailer_Name__c =:retailerId AND Brand_Name__c =: id)
                         FROM Account  WHERE Id = :id]){
                             r.data.put('brand', new Brand(ac));
                         }
        LineCard[] linecards = new LineCard[]{};
        for(Line_Card__c lc: [SELECT Name,Minimum_Order_Value__c,Brand_Account_Rating__c,Retail_Account_Rating__c,Sales_Person__c,Sales_Person__r.Name,Brand_DBA__c,Brand_Name__c,Retailer_DBA__c,Retailer_Name__c,Onboard_Date__c,Mutual_Payment_Terms__c FROM Line_Card__c WHERE Brand_Name__c =: id]){
            linecards.add(new LineCard(lc));
        }
        contact primaryContact = new contact();
        for(Contact con: [SELECT Name, Email,Title,Phone,MobilePhone,Primary_Contact__c FROM Contact WHERE AccountId = :id AND Active__c=true AND Primary_Contact__c =true]){
            primaryContact = con;
        }
        r.data.put('primaryContact', primaryContact); 
        r.data.put('linecards', linecards);        
        r.data.put('isBrand', isBrand);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getBrandProductIds(String brandId,Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getBrandProductIds()');
        Set<Id> ids = new Set<Id>();
        String orderByField = '';
        String direction = '';
        String orderBy = '';
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(ProductsCtlr.hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        } 
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        Boolean hideFromRetailer = isBrand ? true : false;
        
        for(Product_Categories__c pc : [SELECT Id, Category__c ,Name,Icon_Name__c ,Product_Families__c FROM Product_Categories__c WHERE Icon_Name__c != null Order By Sort_Order__c]){
            if(pc.Product_Families__c != null && pc.Product_Families__c != ''){
                productFamilies.addAll(pc.Product_Families__c.split(';'));
            }
        }
        
        string queryStr = 'select id,Product2Id from PricebookEntry where ((Product2.Producer_Name__c =:brandId AND Product2.White_Labelled__c = false) OR (Product2.Licensee_Name__c =: brandId AND Product2.White_Labelled__c = true)) AND Product2.IsActive = true AND Product2.Hide_From_Marketplace__c = false AND Product2.Hide_From_Retailer__c = false AND Product2.Is_Sample__c = false AND Product2.Family IN : productFamilies';
        queryStr+= ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        
        List<Line_Card__c> lstLine = new List<Line_Card__c>([SELECT Retailer_Excluded__c ,Brand_Name__c FROM Line_Card__c WHERE Retailer_Name__c = :Utility.loggedInUser.AccountId AND Brand_Name__c =: brandId]);
        
        if(lstLine.size() > 0){
            r.data.put('lcExist', true);
        } else {
            r.data.put('lcExist', false);
        }
        
        set<string>existingProductSet=new set<string>();
        system.debug('queryStr'+queryStr);
        for(PricebookEntry pbe : Database.query(queryStr)){
            if(!existingProductSet.contains(pbe.Product2Id)){
                ids.add(pbe.id);
                existingProductSet.add(pbe.Product2Id);
            }
        }   
        r.data.put('ids', ids);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getBrandProducts(List<String> ids,Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getBrandProducts()');
        String orderByField = '';
        String direction = '';
        String orderBy = '';
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(ProductsCtlr.hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        list<Product>products = new list<Product>();
        
        for(Product_Categories__c pc : [SELECT Id, Category__c ,Name,Icon_Name__c ,Product_Families__c FROM Product_Categories__c WHERE Icon_Name__c != null Order By Sort_Order__c]){
            if(pc.Product_Families__c != null && pc.Product_Families__c != ''){
                productFamilies.addAll(pc.Product_Families__c.split(';'));
            }
        }
        
        string queryStr = 'SELECT Product2.MSRP__c,Id, Product2.Name,Product2.Product_Short_Description__c,Product2.White_Labelled__c,';
            queryStr += 'Product2.Producer_Name__r.Name,Product2.Producer_Name__r.DBA__c,Product2.Licensee_Name__c,Product2.Licensee_Name__r.Name,Product2.Licensee_Name__r.DBA__c, ';
            queryStr += 'Product2Id, Product2.Image_URL__c,Product2.Brand_Name__c,Product2.RecordType.Name,';
            queryStr += 'Product2.Parent_Product__c,Product2.Is_Sample__c,Product2.Family,Product2.Producer_Name__c ,';
            queryStr += 'Product2.Description, UnitPrice,Product2.Available_Inventory__c,Product2.Available_Qty__c,';
            queryStr += 'Product2.MOQ__c,Product2.Total_Order_Qty__c,Product2.Unit_Shipping_Weight_lbs__c, ';
            queryStr += 'Product2.Case_Shipping_Weight_lbs__c,Product2.Apply_Excise_Tax__c,Product2.Max_Order_Allowed__c,';
            queryStr += 'Product2.Status__c,Product2.Product_Details__c, Product2.Terpene_percent__c,Product2.Strain__r.Name,';
            queryStr += 'Product2.Strain_Type__c,Product2.THC_Amount__c,Product2.THC_MG_G__c,Product2.CDB_Amount__c,';
            queryStr += 'Product2.Cultivation_Type__c,Product2.Product_Rating__c,Product2.Inventory_On_Hold_Qty__c,';
            queryStr += 'Product2.Fulfilled_by_Filigreen__c,Product2.CBD_MG_G__c FROM PricebookEntry where id IN: ids AND Product2.Family IN : productFamilies ORDER BY ' + String.escapeSingleQuotes(orderBy);
        
        Map<String, Product> records = new Map<String, Product>();
        Map<String, List<Product>> procuderProducts = new Map<String, List<Product>>();
        Set<Id> setProductIds = new Set<Id>();
        for(PricebookEntry pbe: Database.query(queryStr)){
            Product p = new Product(pbe);
            records.put(p.id,p);
            setProductIds.add(p.id);
            if(procuderProducts.containsKey(pbe.Product2.Producer_Name__c)){
                procuderProducts.get(pbe.Product2.Producer_Name__c).add(p);
            }else{
                procuderProducts.put(pbe.Product2.Producer_Name__c, new List<Product>{p});
            }
            //Products.add(p);
        } 
        
        DateTime nowTime = System.now();
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Brand__c IN: procuderProducts.keySet() AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :nowTime ]){
            List<Product> productLst = procuderProducts.get(bd.Brand__c);
            if(products != null){
                for(Product p: productLst){
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
            }
        }
        
        for(Brand_Discount__c bd:[SELECT Id,Brand__c , Discount_Active__c ,Product_Name__c ,Discount_Percentage__c FROM Brand_Discount__c WHERE Discount_Percentage__c != null AND Discount_Active__c = true AND Product_Name__c IN: setProductIds AND Discount_Start_DateTime__c <= :System.now() AND Discount_End_DateTime__c > :nowTime]){
            Product p = records.get(bd.Product_Name__c);
            if(p != null){
                if(p.discountPercent != null){
                    p.setProductDiscountPercent(bd.Discount_Percentage__c);
                }else{
                    p.setDiscountPercent(bd.Discount_Percentage__c);
                }
            }
        }
        
        r.data.put('products', records.values());
        return r;
    }
    /*-----*/
    @AuraEnabled(cacheable=true)
    public static AuraResponse getretailerInsightIds(String retailerId,Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getretailerInsightIds()');
        Set<Id> ids = new Set<Id>();
        String orderByField = '';
        String direction = '';
        String orderBy = '';
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(ProductsCtlr.hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        
        List<Line_Card__c> lcs = [SELECT Id,Retailer_Name__c FROM Line_Card__c WHERE Retailer_Name__c = :retailerId AND Brand_Name__c = :brandId];
        if(!lcs.isEmpty()){
            retailerId = lcs[0].Retailer_Name__c;
            Id lineCardId = lcs[0].Id;
            String query = 'SELECT Id FROM Customer_Insights__c where Line_Card__c =: lineCardId';
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
            for(Customer_Insights__c ci : Database.query(query)){
                ids.add(ci.Id);
            } 
        }
        r.data.put('ids', ids);
        return r;
    }
    
    @AuraEnabled(cacheable=true)
    public static AuraResponse getretailerInsights(List<String> ids,Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getretailerInsights()');
        String orderByField = '';
        String direction = '';
        String orderBy = '';
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(ProductsCtlr.hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        list<Customer_Insights__c> insights = new list<Customer_Insights__c>();
        string queryStr ='SELECT Id,Name,CreatedDate,Completed__c,Contact__c,Contact__r.Name,Date_Time__c,Insight_Type__c,Line_Card__c,Memo__c FROM Customer_Insights__c WHERE Id IN: ids' ;
        queryStr+= ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        system.debug('queryStr '+queryStr);
        for(Customer_Insights__c con : Database.query(queryStr)){
            insights.add(con);
        }    
        r.data.put('insights',insights);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getBrandContactIds(String brandId,Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getBrandContactIds()');
        Set<Id> ids = new Set<Id>();
        String orderByField = '';
        String direction = '';
        String orderBy = '';
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(ProductsCtlr.hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        string queryStr = 'select id  from Contact where Active__c = true AND AccountId = \''+brandId+'\'';
        queryStr+= ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        for(Contact con : Database.query(queryStr)){
            ids.add(con.id);
        }   
        r.data.put('ids', ids);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getBrandContacts(List<String> ids,Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getBrandContacts()');
        String orderByField = '';
        String direction = '';
        String orderBy = '';
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(ProductsCtlr.hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        RetailerContact[] brandContacts = new RetailerContact[]{};
        string queryStr = 'select Name, Email,Title,Phone,MobilePhone,Primary_Contact__c from contact where id IN: ids AND Active__c=true';
        queryStr+= ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        system.debug('queryStr '+queryStr);
        for(Contact con : Database.query(queryStr)){
            brandContacts.add(new RetailerContact(con));
        }    
        r.data.put('brandContacts',brandContacts);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getBrandOrderIds(String brandId,Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getBrandOrderIds()');
        Id retailerId = getRetailerAccount();
        Set<Id> ids = new Set<Id>();
        String orderByField = '';
        String direction = '';
        String orderBy = '';
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(ProductsCtlr.hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        set<string>orderIdSet = new set<string>();
        for(Order_Line_Item__c oli : [select id,Order__c from Order_Line_Item__c where Product__r.Producer_Name__c =: brandId OR Product__r.Licensee_Name__c =: brandId]){
            orderIdSet.add(oli.Order__c);    
        }
        //string queryStr = 'select id FROM Sales_Order__c WHERE Brand_Quote__r.Opportunity_Name__r.Order__r.Account__c = :brandId AND Order_Type__c =: SO_ORDER_TYPE_BRAND AND Brand_Quote__r.Opportunity_Name__r.Order__r.Retailer__c = :retailerId';
        string queryStr = 'select id FROM Sales_Order__c WHERE (Brand_Quote__r.Opportunity_Name__r.Order__r.Account__c = :brandId  AND Brand_Quote__r.Opportunity_Name__r.Order__r.Retailer__c = :retailerId) OR (Brand_Quote__r.Opportunity_Name__r.Order__r.Account__c = :retailerId AND Brand_Quote__r.Opportunity_Name__r.Order__c IN: orderIdSet)';
        queryStr+= ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        system.debug('queryStr '+queryStr);
        for(Sales_Order__c ord : Database.query(queryStr)){
            ids.add(ord.id);
        }   
        r.data.put('ids', ids);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getBrandRetailerOrderIds(String retailerId,Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getBrandOrderIds()');
        Set<Id> ids = new Set<Id>();
        String orderByField = '';
        String direction = '';
        String orderBy = '';
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(ProductsCtlr.hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        string queryStr = 'select id FROM Sales_Order__c WHERE Brand_Quote__r.Opportunity_Name__r.Order__r.Retailer__c = :retailerId AND Brand_Quote__r.Opportunity_Name__r.Order__r.Account__c = :brandId AND Order_Type__c =: SO_ORDER_TYPE_BRAND';
        queryStr+= ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        for(Sales_Order__c ord : Database.query(queryStr)){
            ids.add(ord.id);
        }   
        r.data.put('ids', ids);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getBrandRetailerOrders(List<String> ids,Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getBrandOrders()');
        String orderByField = '';
        String direction = '';
        String orderBy = '';
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(ProductsCtlr.hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        List<SalesOrder> salesOrders = new List<SalesOrder>();
        string queryStr = 'SELECT Id, Name, Customer_PO_or_Quote__c, SO_Date__c, SO_Status__c, Total_Line_Items__c,Total_Price__c , Brand_Quote__r.Opportunity_Name__r.Order__c, Brand_Quote__r.Opportunity_Name__r.Order__r.Name, Brand_Quote__c, Brand_Quote__r.Name,';
            queryStr += '(Select Id, Name,Metrc_Manifest__c from Shipping_Manifests__r LIMIT 1),(Select Id, Name from Invoices__r where RecordType.Name = \'Product\' LIMIT 1) FROM Sales_Order__c WHERE id IN: ids';
        queryStr+= ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        system.debug('queryStr '+queryStr);
        List<Sales_Order__c> sOrders = Database.query(queryStr);
        Map<Id, Purchase_Order__c> purchaseOrders = getPurchaseOrders(sOrders);
        for(Sales_Order__c so: sOrders){
            salesOrders.add(new SalesOrder(so, purchaseOrders));
        }    
        r.data.put('salesOrders',salesOrders);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getBrandLicenseIds(String brandId,Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getBrandLicenseIds()');
        Set<Id> ids = new Set<Id>();
        String orderByField = '';
        String direction = '';
        String orderBy = '';
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(ProductsCtlr.hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        string queryStr = 'select id FROM State_Licenses__c WHERE License_Name__c = :brandId AND License_Status__c = \'Active\'';
        queryStr+= ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        for(State_Licenses__c licenses : Database.query(queryStr)){
            ids.add(licenses.id);
        }   
        r.data.put('ids', ids);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getBrandLicense(List<String> ids,Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getBrandLicense()');
        String orderByField = '';
        String direction = '';
        String orderBy = '';
        if(filters != null){
            if(ProductsCtlr.hasFilter(filters, 'orderByField')){
                orderByField = String.valueOf(filters.get('orderByField'));
                if(ProductsCtlr.hasFilter(filters, 'isASC')){
                    direction = ((Boolean.valueOf(filters.get('isASC')))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        List<LicenseAddress> stateLicenses = new List<LicenseAddress>();
        string queryStr = 'SELECT Default_Warehouse__c,Default_Warehouse__r.Warehouse_Name__c,License_Address__c, License_City__c, License_State__c, License_Country__c, License_Zip__c, License_Expiration_Date__c, License_Status__c, License_Class__c ,License_Type__c , License_Number__c  FROM State_Licenses__c where id IN: ids';
        queryStr+= ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        for(State_Licenses__c sl:   Database.query(queryStr)){
            stateLicenses.add(new LicenseAddress(sl));
        }    
        r.data.put('stateLicenses', stateLicenses);
        return r;
    }
    private static Map<Id, Purchase_Order__c> getPurchaseOrders(List<Sales_Order__c> orders){
        Map<Id, Purchase_Order__c> purchaseOrders = new Map<Id, Purchase_Order__c> ();
        Set<Id> BQIds = new Set<Id> ();
        for(Sales_Order__c od : orders)
            BQIds.add(od.Brand_Quote__c);
        List<Purchase_Order__c> purchaseOrdersList = [Select Id, Name, Brand_Quote__c from Purchase_Order__c where Brand_Quote__c IN : BQIds];
        for(Purchase_Order__c po : purchaseOrdersList)
            purchaseOrders.put(po.Brand_Quote__c, po);
        return purchaseOrders;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getBrandIds(Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getBrandIds()');
        List<String> whereParts = new List<String>();
        List<String> whereSearchParts = new List<String>();
        
        String orderByField = '';
        String direction = '';
        String searchTerm = '';
        String orderBy = '';
        String brandType = '';
        if(filters != null){
            if(hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
            if(hasFilter(filters, SEARCHTERM_FILTER)){
                searchTerm = String.valueOf(filters.get(SEARCHTERM_FILTER));
                if(String.isNotBlank(searchTerm)){
                    searchTerm = '%' + searchTerm + '%';
                    whereSearchParts.add('(DBA__c LIKE :searchTerm)');
                    whereSearchParts.add('(Name LIKE :searchTerm)');
                    whereSearchParts.add('(BillingCity LIKE :searchTerm)');
                }
            }
            if(hasFilter(filters, 'brandType')){
                brandType = String.valueOf(filters.get('brandType'));       
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        
        List<String> fields = new List<String>{'Id'};
            String query = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ' FROM Account ';
            if(brandType != null && brandType != ''){
                if(brandType == 'All'){
                    string typeStr = System.Label.Brand_Type;
                    List<String> includeTypes = typeStr.split(',');
                    //List<String> includeTypes = new List<String>{'Cultivator','Manufacturer','Producer','Test Lab','White Label Brand'};    
                    //List<String> includeTypes = new List<String>{'Distributor','Cultivator','Manufacturer','Producer','Partner','Reseller'};    
                    whereParts.add('Type IN:includeTypes');
                }else{
                    whereParts.add('Type =:brandType');
                }    
            }
        Boolean isTrue = false;
        whereParts.add('Hide_from_Marketplace__c =: isTrue');
        query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        
        if(!whereSearchParts.isEmpty()){
            query += ' AND ' + '('+ String.escapeSingleQuotes(String.join(whereSearchParts, ' OR '))+')';
        }
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        }
        query += ' LIMIT 49999';
        System.debug('query: ' + query);
        
        List<String> ids = new List<String>();
        for(Account ac :(List<Account>)Database.query(query)){
            ids.add(ac.Id);
        }
        
        r.data.put('ids', ids);
        r.data.put('isBrand', isBrand);
        return r;
    }
    
    @AuraEnabled(cacheable=true)
    public static AuraResponse getBrands(List<String> ids, Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getBrands()');
        List<String> whereParts = new List<String>();
        String orderByField = '';
        String direction = '';
        String searchTerm = '';
        String orderBy = '';
        
        if(filters != null){
            if(hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        
        List<String> fields = new List<String>{'Business_Type__c','Description','Name', 'dBA__c', 'Image_URL__c', 'Phone', 'Fax', 'Website', 'Account_Rating__c', 'Payment_Terms__c', 'Id', 'BillingStreet', 'BillingCity', 'BillingState', 'BillingCountry', 'BillingPostalCode', 'Twitter__c', 'Facebook__c', 'LinkedIn__c', 'About_Us__c', 'Instagram__c' };
            whereParts.add('Id IN :ids');
        Boolean isTrue = false;
        whereParts.add('Hide_from_Marketplace__c =: isTrue');
        String query = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ' FROM Account ';
        
        if(!whereParts.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        }
        query += ' LIMIT 49999';
        System.debug('query: ' + query);
        
        List<Brand> records = new List<Brand>();
        for(Account ac :(List<Account>)Database.query(query)){
            records.add(new Brand(ac));
        }
        
        r.data.put('records', records);
        r.data.put('isBrand', isBrand);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse saveReview(String reviewData){
        AuraResponse r = new AuraResponse('ProductsCtlr.saveReview()');
        
        Review review = (Review)JSON.deserialize(reviewData, Review.class);
        if(String.isBlank(review.productId)){
            r.errors.add(PRODUCT_NOT_FOUND);
        }
        if(review.rating < 1){
            r.errors.add(PROVIDE_THE_RATING);
        }
        if(String.isBlank(review.review)){
            r.errors.add(REVIEW_IS_REQUIRED);
        }
        for(Product_Review__c pr :[SELECT Id FROM Product_Review__c WHERE Product__c = :review.productId AND CreatedById = :UserInfo.getUserId()]){
            r.errors.clear();
            return r;
        }
        r.handleErrors();
        
        try{
            insert new Product_Review__c(Product__c = review.productId, Rating__c = review.rating,Rating_Text__c = Integer.valueOf(review.rating)+'', Review__c = review.review);
        }catch(Exception e){
            r.handleException(e);
        }
        
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse notifyMe(String productId){
        AuraResponse r = new AuraResponse('ProductsCtlr.notifyMe()');
        
        for(Product_Stock_Notification__c psn :[SELECT Id FROM Product_Stock_Notification__c WHERE Product__c = :productId AND Sent_Notification__c = false]){
            return r;
        }
        
        try{
            Product_Stock_Notification__c psn = new Product_Stock_Notification__c(Product__c = productId, Customer__c = UserInfo.getUserId());
            insert psn;
        }catch(Exception e){
            r.handleException(e);
        }
        
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getCases(Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getCases()');
        List<String> whereSearchParts = new List<String>();
        
        String orderByField = '';
        String direction = '';
        String searchTerm = '';
        String orderBy = '';
        if(filters != null){
            if(hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
            if(hasFilter(filters, SEARCHTERM_FILTER)){
                searchTerm = String.valueOf(filters.get(SEARCHTERM_FILTER));
                if(String.isNotBlank(searchTerm)){
                    searchTerm = '%' + searchTerm + '%';
                    whereSearchParts.add('(Subject LIKE :searchTerm)');
                    //whereSearchParts.add('(Description LIKE :searchTerm)');
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        
        List<String> fields = new List<String>{'Id'};
            String query = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ' FROM Case ';
        
        if(!whereSearchParts.isEmpty()){
            query += ' WHERE ' + '('+ String.escapeSingleQuotes(String.join(whereSearchParts, ' OR '))+')';
        }
        User u = [Select ContactId from User where Id=:UserInfo.getUserId()];
        if(u.ContactId!=null){
            query += (whereSearchParts.isEmpty() ? ' WHERE' : ' AND ');
            query += ' ContactId=\'' + u.ContactId + '\'';
        }
        if(hasFilter(filters, 'status')){
            String STStatus = String.valueOf(filters.get('status'));
            if(STStatus != 'All'){
                query += ' AND Status = :STStatus';
            }
        }
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        }
        query += ' LIMIT 49999';
        
        List<String> ids = new List<String>();
        for(Case ac :(List<Case>)Database.query(query)){
            ids.add(ac.Id);
        }
        r.data.put('ids', ids);
        r.data.put('isBrand', isBrand);
        return r;
    }
    
    @AuraEnabled(cacheable=true)
    public static AuraResponse getCaseDetails(List<String> ids, Map<String, Object> filters){
        AuraResponse r = new AuraResponse('ProductsCtlr.getCaseDetails()');
        List<String> whereParts = new List<String>();
        String orderByField = '';
        String direction = '';
        String searchTerm = '';
        String orderBy = '';
        
        if(filters != null){
            if(hasFilter(filters, ORDERBYFIELD_FILTER)){
                orderByField = String.valueOf(filters.get(ORDERBYFIELD_FILTER));
                if(hasFilter(filters, IS_ASC)){
                    direction = ((Boolean.valueOf(filters.get(IS_ASC)))? ASC_DIRECTION : DESC_DIRECTION);
                }
            }
        }
        
        if(String.isNotBlank(orderByField) && String.isNotBlank(direction)){
            orderBy = (orderByField + ' ' + direction);
        }
        
        List<String> fields = new List<String>{'CaseNumber', 'Id', 'CreatedDate', 'Subject', 'Priority', 'Description', 'Status', 'Contact_Preference__c', 'ContactEmail', 'ContactPhone' };
            whereParts.add('Id IN :ids');
        String query = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ' FROM Case ';
        
        if(!whereParts.isEmpty()){
            query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        }
        
        if(String.isNotBlank(orderBy)){
            query += ' ORDER BY ' + String.escapeSingleQuotes(orderBy);
        }
        query += ' LIMIT 49999';
        System.debug('query: ' + query);
        
        List<Case> records = new List<Case>();
        for(Case cs :(List<Case>)Database.query(query)){
            records.add(cs);
        }
        
        r.data.put('records', records);
        r.data.put('isBrand', isBrand);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getCaseFullDetails(String caseId){
        AuraResponse r = new AuraResponse('ProductsCtlr.getCaseFullDetails()');
        List<String> whereParts = new List<String>();
        List<String> fields = new List<String>{'CaseNumber', 'Account.Name' , 'Account.Image_URL__c' , 'Id', 'CreatedDate', 'Subject', 'Priority', 'Description', 'Status', 'Contact_Preference__c', 'ContactEmail', 'ContactPhone', 'Type', 'Notes__c', 'Owner_Information_Notes__c'};
            whereParts.add('Id =:caseId');
        
        String query = 'SELECT ' + String.escapeSingleQuotes(String.join(fields, ', ')) + ' FROM Case ';
        query += ' WHERE ' + String.escapeSingleQuotes(String.join(whereParts, ' AND '));
        System.debug('query: ' + query);
        
        Case rec = (Case)Database.query(query);
        
        List<caseAttachment> fileDet = new List<caseAttachment>();
        Set<Id> caseIdSet = new Set<Id>();
        caseIdSet.add(rec.Id);
        
        Map<String,ContentDocumentLink> mapFileIds = new Map<String,ContentDocumentLink>();
          for(ContentDocumentLink cont : [SELECT Id, LinkedEntityId,ContentDocumentId,ContentDocument.title FROM ContentDocumentLink WHERE LinkedEntityId in : caseIdSet]){
             mapFileIds.put(cont.LinkedEntityId,cont);
          }
        
        system.debug('mapFileIds>>>>123>>'+mapFileIds);
        if(mapFileIds.containskey(rec.Id)){
           fileDet.add(new caseAttachment(rec,mapFileIds.get(rec.Id),true));   
        } else {
           fileDet.add(new caseAttachment(rec,false));  
        }
        
        r.data.put('fileDet', fileDet);
        r.data.put('record', rec);
        r.data.put('isBrand', isBrand);
        return r;
    }
    @AuraEnabled
    public static AuraResponse closeMyCase(String caseId){
        AuraResponse r = new AuraResponse('ProductsCtlr.getCaseFullDetails()');
        Case c = new Case(Id = caseId, Status = CASE_STATUS_CLOSED);
        update c;
        r.data.put('closed', true);
        r.data.put('isBrand', isBrand);
        return r;
    }
    @AuraEnabled
    public static AuraResponse saveCase(Case caseDetails){
        System.debug('caseDetails='+caseDetails);
        AuraResponse r = new AuraResponse('ProductsCtlr.saveCase()');
        if(caseDetails.Id==null && (caseDetails.Origin==null || String.isBlank(caseDetails.Origin))){
            System.debug('inif');
            caseDetails.Origin = CASE_ORIGIN_WEB;
            //Creating the DMLOptions for "Assign using active assignment rules" checkbox
            Database.DMLOptions dmlOpts = new Database.DMLOptions();
            dmlOpts.assignmentRuleHeader.useDefaultRule = true;
            dmlOpts.EmailHeader.triggerAutoResponseEmail = true;
            dmlOpts.EmailHeader.triggerUserEmail = true;
            
            caseDetails.setOptions(dmlOpts);
            User u = [Select ContactId from User where Id=:UserInfo.getUserId()];
            caseDetails.contactId=u.ContactId;
            caseDetails.RecordTypeId = Schema.SObjectType.Case.getRecordTypeInfosByName().get(CASE_RECORD_TYPE_NAME_EXTERNAL).getRecordTypeId();
        }
        DataBase.UpsertResult res = DataBase.upsert(caseDetails);
        r.data.put('isCreated', res.isCreated());
        r.data.put('caseId', res.Id);
        r.data.put('isBrand', isBrand);
        return r;
    }
    @AuraEnabled(cacheable=true)
    public static AuraResponse getContactInformation(){
        AuraResponse r = new AuraResponse('ProductsCtlr.getContactInformation()');
        User u = [Select ContactId from User where Id=:UserInfo.getUserId()];
        Contact c = new COntact();
        if(u.ContactId!=null)
            c = [Select Id, Email, Phone from Contact where Id=:u.ContactId];
        r.data.put('ContactInformation', c);
        r.data.put('isBrand', isBrand);
        return r;
    }
    
    public static Map<Id,WarehouseAvailableInventory[]> getWarehouseAvailableInventory(Set<String>productIds){
        system.debug('productIds :'+productIds);
        Map<Id,Site__c> sites = new Map<Id,Site__c>([SELECT Id, Name, Warehouse_Name__c,Sort_Order__c  FROM Site__c WHERE Active__c = true Order BY Sort_Order__c]);
        Map<Id,WarehouseAvailableInventory[]> warehouseAvailableInventoryProductMap = new Map<Id,WarehouseAvailableInventory[]>();
        
        Product2[] prodList =[Select ID,Name,
                              (Select id,Name,Site__c,Site__r.Name,Product_Name__c,Qty_On_Hand__c
                                FROM Inventory_Positions__r 
                               WHERE Qty_On_Hand__c != NULL 
                               AND Hold__c = false 
                               AND Inventory_Location__r.Include_in_Inventory__c = true
                              AND Inventory_Location__r.Name != :RECEIVING_INSPECTION
                              Order By Site__r.Sort_Order__c)
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
    
    public static Map<String,Decimal> getWarehouseOrderedMap(Set<String> productIds){
        Map<String,Decimal> siteProductTotalOrderQtyMap = new Map<String,Decimal>();
        Map<Id,Site__c> sites = new Map<Id,Site__c>([SELECT Id, Name, Warehouse_Name__c,Sort_Order__c  FROM Site__c WHERE Active__c = true ORDER BY Sort_Order__c]);
        Sales_Order_Line__c[] SOLines =  [SELECT Id,Name,Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.RecordType.Name, Sales_Order__c,Qty_Allocated__c ,Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.Site__c, Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c,Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c ,Product_Name__c,Product_Name__r.Name  FROM Sales_Order_Line__c WHERE Status__c =: SOLI_STATUS_ALLOCATED AND Product_Name__c IN : productIds AND Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c != null];
        Map<Id,Sales_Order_Line__c>SOLineMap = new Map<Id,Sales_Order_Line__c>(SOLines);
        Map<String,List<Id>> productAllocatedSOLMap = new Map<String,List<Id>>();
        for(Sales_Order_Line__c SOL: SOLines){
            System.debug('###SOL Name::'+SOL.Name +'==>Product Name:'+SOL.Product_Name__r.Name +'=>Qty_Allocated__c:'+SOL.Qty_Allocated__c);
            
            String key = (SOL.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.Site__c != null ? SOL.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.Site__c : SOL.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c) +'-'+SOL.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c + '-'+SOL.Product_Name__c;//SOL.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c + '-'+SOL.Product_Name__c;
            System.debug('###Key::'+key);
            if(productAllocatedSOLMap.containsKey(key)){
                productAllocatedSOLMap.get(key).add(SOL.Id);
            }else{
                productAllocatedSOLMap.put(key, new List<Id>{SOL.Id});
            }
        }
        Set<String> orderStatusPendingApproved = new Set<String>{STATUS_PENDING,STATUS_APPROVED};
        Set<String> orderStatusDraftApproved = new Set<String>{STATUS_APPROVED,STATUS_PENDING};
        
        Order_Line_Item__c[] items = [SELECT Id, Order__r.RecordType.Name,Order__c,Order__r.Site__c,Order__r.State_License__r.Default_Warehouse__c,Quantity_Cases__c,Is_Sample__c,Line_Total_Qty__c,Product__c FROM Order_Line_Item__c WHERE Product__c IN :productIds AND (OrderLine_Status__c =: '' OR OrderLine_Status__c =: null) AND ((Order__r.RecordType.Name =: ORDER_RECORD_TYPE_NAME_RETAILER AND Order__r.Status__c IN : orderStatusPendingApproved) OR (Order__r.RecordType.Name IN (:ORDER_RECORD_TYPE_NAME_BRAND,:ORDER_RECORD_TYPE_NAME_TRANSFER) AND Order__r.Status__c IN : orderStatusPendingApproved)) Order By Order__r.State_License__r.Default_Warehouse__r.Sort_Order__c];
        Map<String,Decimal> productTotalQtyMap = new Map<String,Decimal>();
        Map<String,Decimal> productTotalQtyAllocatedMap = new Map<String,Decimal>();
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
                Qty_Allocated = productTotalQtyAllocatedMap.get(keySP);
            }
            
            if(tempSOLIds != null && tempSOLIds.size() > 0){
                for(Id SOLId: tempSOLIds){
                    Sales_Order_Line__c SOL = SOLineMap.get(SOLId);
                    if(SOL != null){
                        Qty_Allocated += SOL.Qty_Allocated__c; 
                    }
                }
            }
            productTotalQtyAllocatedMap.put(keySP,Qty_Allocated);
            productTotalQtyMap.put(keySP,totalQty);
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
                    system.debug('##totalOrderedQty :::'+(totalOrderedQty-totalAllocatedQty));
                    siteProductTotalOrderQtyMap.put(key,(totalOrderedQty-totalAllocatedQty));
                }
                
            }
        }
        return siteProductTotalOrderQtyMap;
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
    
    public class BrandCartItem{
        @AuraEnabled public String id {get;set;}
        @AuraEnabled public String name {get;set;}
        @AuraEnabled public String imageUrl {get;set;}
        @AuraEnabled public Decimal lineTotalQty {get;set;}
        @AuraEnabled public Decimal unitPrice {get;set;}
        @AuraEnabled public String brandName {get;set;}
        @AuraEnabled public String brandId {get;set;}
        @AuraEnabled public Decimal availableQty {get;set;}
        @AuraEnabled public String priceBookId {get;set;}
        @AuraEnabled public Decimal quantity {get;set;}
        @AuraEnabled public Boolean isSample {get;set;}
        @AuraEnabled public Boolean isPromo {get;set;}
        @AuraEnabled public Boolean isProductSample {get;set;}
        @AuraEnabled public String productRecordTypeName {get;set;}
        @AuraEnabled public String shortDesc {get;set;}
        @AuraEnabled public Double MOQ {get;set;}
        @AuraEnabled public String productName {get;set;}
        @AuraEnabled public String specialInstructions {get;set;}
        @AuraEnabled public String applyExciseTax{get;set;}
         @AuraEnabled public Boolean isDiscountProduct {get;set;}
        @AuraEnabled public Boolean isBulkProduct {get;set;}
        @AuraEnabled public String productFamily {get;set;}
    }
    
    public class LookupRecord{
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String value {get;set;}
    }
    public class RMA{
        @AuraEnabled
        public String orderId{get;set;}
        @AuraEnabled
        public String orderNumber{get;set;}
        @AuraEnabled
        public DateTime orderDate{get;set;}
        @AuraEnabled
        public String orderStatus{get;set;}
        @AuraEnabled
        public String id{get;set;}
        @AuraEnabled
        public String name{get;set;}
        @AuraEnabled
        public String status{get;set;}
        @AuraEnabled
        public String SMId{get;set;}
        @AuraEnabled
        public String SMName{get;set;}
        @AuraEnabled
        public String SMStatus{get;set;}
        @AuraEnabled
        public Decimal totalQty{get;set;}
        @AuraEnabled
        public Date planShipDate{set;get;}
        @AuraEnabled
        public RMALine[] items{get;set;}
        
        public RMA(Returns__c rt){
            this.id = rt.Id;
            this.orderId = rt.Order_Number__c;
            this.orderNumber = rt.Order_Number__r.Name;
            this.orderStatus = rt.Order_Number__r.Status__c;
            this.orderDate = rt.Order_Number__r.Order_Date__c;
            this.name = rt.Name;
            this.status = rt.Return_Status__c;
            this.SMId = rt.Shipping_Manifest__c;
            this.SMName = rt.Shipping_Manifest__r.Name;
            this.SMStatus = rt.Shipping_Manifest__r.Status__c;
            this.totalQty = rt.Total_Qty__c;
            this.planShipDate = rt.Shipping_Manifest__r.Planned_Ship_Transfer_Date__c;
            this.items = new RMALine[]{};
                if(rt.Return_Lines__r.size() > 0){
                    for(Return_Line__c  rl:rt.Return_Lines__r){
                        this.items.add(new RMALine(rl));
                    }
                }
        }
    }
    public class RMALine{
        @AuraEnabled
        public String id{get;set;}
        @AuraEnabled
        public String name{get;set;}
        @AuraEnabled
        public String SMLId{get;set;}
        @AuraEnabled
        public String SMLName{get;set;}
        @AuraEnabled
        public decimal returnQty{get;set;}
        @AuraEnabled
        public decimal orderedQty{get;set;}
        @AuraEnabled
        public String productId{get;set;}
        @AuraEnabled
        public String priceBookId{get;set;}
        @AuraEnabled
        public String productName{get;set;}
        @AuraEnabled
        public String returnCode{get;set;}
        @AuraEnabled
        public String returnStatus{get;set;}
        @AuraEnabled
        public decimal returnPrice{get;set;}
        @AuraEnabled
        public Boolean isSelected{get;set;}
        @AuraEnabled
        public String imageUrl{get;set;}
        @AuraEnabled
        public String additionalNotes{set;get;}
        @AuraEnabled
        public Double totalReturnQty{get;set;}
        public RMALine(Return_Line__c  rl){
            this.isSelected = false;
            this.id = rl.Id;
            this.name = rl.Name;
            this.SMLId = rl.Shipping_Manifest_Line__c;
            this.SMLName = rl.Shipping_Manifest_Line__r.Name;
            this.returnQty = rl.Return_Qty__c;
            this.productId = rl.Shipping_Manifest_Line__r.Product_Name__c;
            this.priceBookId = rl.Price_Book_Entry_Id__c;
            this.imageUrl = rl.Shipping_Manifest_Line__r.Product_Name__r.Image_URL__c != null ? rl.Shipping_Manifest_Line__r.Product_Name__r.Image_URL__c : IMAGE_COMINGSOON;
            this.productName = rl.Shipping_Manifest_Line__r.Product_Name__r.Name;
            this.returnCode = rl.Return_Code__c;
            this.returnStatus = rl.Return_Status__c;
            this.returnPrice = rl.Retail_Wholesale_Price__c;
            this.additionalNotes = rl.Additional_Return_Notes__c;
            this.orderedQty =  rl.Order_Line_Item__r.Quantity_Cases__c;
            this.totalReturnQty = rl.Shipping_Manifest_Line__r.Total_Return_Qty__c;
        }
    }
    public class Order{
        @AuraEnabled
        public String id{get;set;}
        @AuraEnabled
        public String name{get;set;}
        @AuraEnabled
        public DateTime orderDate{get;set;}
        @AuraEnabled
        public Double cartTotal{get;set;}
        @AuraEnabled
        public Double exciseTotal{get;set;}
        @AuraEnabled
        public Double lineSubTotal{get;set;}
        @AuraEnabled
        public String status{get;set;}
        @AuraEnabled
        public String RSMStatus{get;set;}
        @AuraEnabled
        public String SMId{get;set;}
        @AuraEnabled
        public String SMName{get;set;}
        @AuraEnabled
        public String SMStatus{get;set;}
        @AuraEnabled
        public String SMMetrc{get;set;}
        @AuraEnabled
        public date SMPlannedShipDate{get;set;}
        @AuraEnabled
        public List<OrderLineItem> items{get;set;}
        @AuraEnabled
        public Address shipping{get;set;}
        @AuraEnabled
        public date requestShipDate{set;get;}
        @AuraEnabled
        public string requestEarliestTime{set;get;}
        @AuraEnabled
        public string requestLatestTime{set;get;}
        
        public Order(Order__c o){
            this.id = o.Id;
            this.name = o.Name;
            this.orderDate = o.Order_Date__c;
            this.requestShipDate = o.Request_Ship_Date__c ;
            this.status = o.Status__c;
            this.shipping = new Address(o.Shipping_Street__c, o.Shipping_Country__c, o.Shipping_Province__c, o.Shipping_City__c, o.Shipping_Zip__c);
            this.items = new List<OrderLineItem>();
            this.cartTotal = 0;
            this.exciseTotal = 0;
            this.lineSubTotal = 0;
            this.SMStatus = '';
            this.requestEarliestTime = (o.Requested_Delivery_Earliest_Time__c != null?dateTime.newInstance(system.today(), o.Requested_Delivery_Earliest_Time__c).format('h:mm a'):'');
            this.requestLatestTime = (o.Requested_Delivery_Latest_Time__c != null?dateTime.newInstance(system.today(), o.Requested_Delivery_Latest_Time__c).format('h:mm a'):'');
            if(this.status == STATUS_APPROVED){
                this.RSMStatus = STATUS_APPROVED;
            }else{
                this.RSMStatus = STATUS_APPROVED;
            }
            if(!o.Retail_Shipping_Manifests__r.isEmpty()){
                this.SMId = o.Retail_Shipping_Manifests__r[0].Id;
                this.SMName = o.Retail_Shipping_Manifests__r[0].Name;
                this.SMStatus = o.Retail_Shipping_Manifests__r[0].Status__c;
            }
            for(Order_Line_Item__c oli :o.Order_Line_Items__r){
                this.cartTotal += oli.Total__c;
                this.exciseTotal += oli.Line_Total_Excise_Tax__c;
                this.lineSubTotal += oli.Line_Total_Cost__c;
                items.add(new OrderLineItem(oli));
            }
        }
    }
    
    public class OrderLineItem{
        @AuraEnabled
        public String pricebookId{get;set;}
        @AuraEnabled
        public Pricebook price{get;set;}
        
        @AuraEnabled
        public String id{get;set;}
        @AuraEnabled
        public String OLIId{get;set;}
        @AuraEnabled
        public String productId{get;set;}
        @AuraEnabled
        public String name{get;set;}
        @AuraEnabled
        public Double quantity{get;set;}
        @AuraEnabled
        public Double MOQ{get;set;}
        @AuraEnabled
        public Double unitPrice{get;set;}
        @AuraEnabled
        public String imageUrl{get;set;}
        @AuraEnabled
        public String description{get;set;}
        @AuraEnabled
        public String shortDescription{get;set;}
        @AuraEnabled
        public String productDetails{get;set;}
        @AuraEnabled
        public String producerName{get;set;}
        @AuraEnabled
        public String producerId{get;set;}
        @AuraEnabled
        public String productFamily{get;set;}
        @AuraEnabled
        public Double rating{get;set;}
        @AuraEnabled
        public Double availableInventory{get;set;}
        @AuraEnabled
        public Double availableQty{get;set;}
        @AuraEnabled
        public Boolean notifyRequested{get;set;}
        @AuraEnabled
        public Boolean hasReview{get;set;}
        
        @AuraEnabled
        public Double lineTotalQty{get;set;}
        @AuraEnabled
        public Double lineTotalCost{get;set;}
        @AuraEnabled
        public Double subtotalLocalCannabisTax{get;set;}
        @AuraEnabled
        public Double lineExciseTax{get;set;}
        @AuraEnabled
        public Double lineTotalExciseTax{get;set;}
        @AuraEnabled
        public Double total{get;set;}
        @AuraEnabled
        public Boolean isBrandProduct{get;set;}
        @AuraEnabled
        public Boolean isSample{get;set;}
        @AuraEnabled
        public Boolean isSelected{get;set;}
        @AuraEnabled
        public String SMLineId{set;get;}
        @AuraEnabled
        public String SMId{set;get;}
        @AuraEnabled
        public String SMName{set;get;}
        @AuraEnabled
        public Date planShipDate{set;get;}
        @AuraEnabled
        public String returnCode{set;get;}
        @AuraEnabled
        public String additionalNotes{set;get;}
        @AuraEnabled
        public Double rquantity{get;set;}
        @AuraEnabled
        public Double totalReturnQty{get;set;}
        @AuraEnabled
        public String fileIds{get;set;}
        @AuraEnabled
        public Decimal discountPercent{get;set;}
        @AuraEnabled
        public Decimal maxOrderAllowed{get;set;}
        @AuraEnabled
        public Decimal productDiscountPercent{get;set;}
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
                return salePrice;
            }set;
        }
        public OrderLineItem(Order_Line_Item__c oli){
            this.isSelected = false;
            this.pricebookId = oli.Price_Book_Entry_Id__c;
            this.OLIId = oli.Id;
            this.id = oli.Product__c;
            this.productId = oli.Product__c;
            this.isSample = oli.Is_Sample__c;
            //this.brandName = oli.Product__r.Brand_Name__c;
            if(this.isSample){
                String[] sampleProducts = oli.Product__r.Name.split('-S');
                System.debug('####sampleProducts[0]:::'+sampleProducts[0]);
                this.name = sampleProducts[0];
            }else{
                this.name = oli.Product__r.Name;
            }
            //this.name = oli.Product__r.Name;
            this.quantity = oli.Quantity_Cases__c;
            this.MOQ = oli.MOQ__c;
            this.unitPrice = oli.UnitPrice__c;
            this.imageUrl = (oli.Product__r.Image_URL__c!= null?oli.Product__r.Image_URL__c: IMAGE_COMINGSOON);
            this.shortDescription = oli.Product__r.Product_Short_Description__c;
            this.description = oli.Product__r.Description;
            this.productDetails = oli.Product__r.Product_Details__c;
            this.producerName = oli.Product__r.Brand_Name__c;
            this.productFamily = oli.Product__r.Family;
            this.maxOrderAllowed = oli.Product__r.Max_Order_Allowed__c;
            this.rating = (oli.Product__r.Product_Rating__c != null?oli.Product__r.Product_Rating__c.setScale(1):0);
            this.availableInventory = oli.Product__r.Available_Inventory__c;
            this.availableQty = oli.Product__r.Available_Qty__c;
            this.notifyRequested = false;
            
            this.lineTotalQty = oli.Line_Total_Qty__c;
            this.lineTotalCost = oli.Line_Total_Cost__c;
            this.lineExciseTax = oli.Unit_Excise_Tax__c;
            this.lineTotalExciseTax = oli.Line_Total_Excise_Tax__c;
            this.total = oli.Total__c;
            this.isBrandProduct = oli.Is_Brand_Product__c;
            this.totalReturnQty = 0;
        }
        public void setDiscountPercent(Decimal discountPercent){
            this.discountPercent = discountPercent;
        }
        public void setProductDiscountPercent(Decimal discountPercent){
            this.productDiscountPercent = discountPercent;
        }
        public void notifyRequested(Boolean notifyRequested){
            this.notifyRequested = notifyRequested;
        }
    }
    
    public class Product{
        @AuraEnabled
        public Pricebook price{get;set;}
        
        @AuraEnabled
        public String id{get;set;}
        @AuraEnabled
        public String complianceFileId{get;set;}
        @AuraEnabled
        public String name{get;set;}
        @AuraEnabled
        public String productSKU{get;set;}
        @AuraEnabled
        public String description{get;set;}
        @AuraEnabled
        public String shortDescrption{get;set;}
        @AuraEnabled
        public String productFamily{get;set;}
        @AuraEnabled
        public String quantityType{get;set;}
        @AuraEnabled
        public String productDetails{get;set;}
        @AuraEnabled
        public String imageUrl{get;set;}
        @AuraEnabled
        public List<String> images{get;set;}
        @AuraEnabled
        public String producerName{get;set;}
        @AuraEnabled
        public String producerId{get;set;}
        
        @AuraEnabled
        public Double quantity{get;set;}
        @AuraEnabled
        public String CBDMG{get;set;}
        @AuraEnabled
        public String CBDPercent{get;set;}
        @AuraEnabled
        public String TerpenePercent{get;set;}
        @AuraEnabled
        public String THCMG{get;set;}
        @AuraEnabled
        public String THCPercent{get;set;}
        @AuraEnabled
        public Double MOQ{get;set;}
        @AuraEnabled
        public String strainName{get;set;}
        @AuraEnabled
        public String strainId{get;set;}
        @AuraEnabled
        public String strainType{get;set;}
        @AuraEnabled
        public String strainTypeBGColor{
            get{
                strainTypeBGColor = '';
                if(String.isNotBlank(strainType) && strainTypeMap.containsKey(strainType)){
                    strainTypeBGColor = strainTypeMap.get(strainType);
                }
                return strainTypeBGColor;
            }set;
        }
        @AuraEnabled
        public String cultivationMethod{get;set;}
        @AuraEnabled
        public Double WAVGCannabisWeight{get;set;}
        @AuraEnabled
        public String applyCultivationTax{get;set;}
        @AuraEnabled
        public String cannabisWeightUOM{get;set;}
        @AuraEnabled
        public String applyExciseTax{get;set;}
        @AuraEnabled
        public Boolean whiteLabelled{get;set;}
        @AuraEnabled
        public String licenseeName{get;set;}
        @AuraEnabled
        public String licenseeId{get;set;}
        @AuraEnabled
        public Boolean isBulkProduct{get;set;}
        @AuraEnabled
        public String cannabisCategory1{get;set;}
        @AuraEnabled
        public String cannabisCategory2{get;set;}
        @AuraEnabled
        public Double unitCannabisWeight1{get;set;}
        @AuraEnabled
        public Double unitCannabisWeight2{get;set;}
        @AuraEnabled
        public Double cannabisRatio1{get;set;}
        @AuraEnabled
        public Double cannabisRatio2{get;set;}
        @AuraEnabled
        public Double unitCultivationTax{get;set;}
        @AuraEnabled
        public String retailUnitFormFactor{get;set;}
        @AuraEnabled
        public Double unitHeight{get;set;}
        @AuraEnabled
        public String stockingUOM{get;set;}
        @AuraEnabled
        public Double unitWidth {get;set;}
        @AuraEnabled
        public Double unitNetWeight {get;set;}
        @AuraEnabled
        public Double unitlength {get;set;}
        @AuraEnabled
        public Double unitGrossWeight {get;set;}
        @AuraEnabled
        public Double unitRadius {get;set;}
        @AuraEnabled
        public Double caseHeight{get;set;}
        @AuraEnabled
        public String supplierUOM{get;set;}
        @AuraEnabled
        public Double caseWidth {get;set;}
        @AuraEnabled
        public Double caseLength {get;set;}
        @AuraEnabled
        public Double caseGrossWeight {get;set;}
        @AuraEnabled
        public Double caseRadius {get;set;}
        @AuraEnabled
        public Double cartonNetWeight {get;set;}
        @AuraEnabled
        public Double cartonGrossWeight {get;set;}
        @AuraEnabled
        public Double THC {get;set;}
        @AuraEnabled
        public Double THCMGG {get;set;}
        @AuraEnabled
        public Double CBD {get;set;}
        @AuraEnabled
        public Double CBDMGG {get;set;}
        @AuraEnabled
        public Double terpene{get;set;}
        @AuraEnabled
        public Double alphaBisabolol {get;set;}
        @AuraEnabled
        public Double delta3Carene {get;set;}
        @AuraEnabled
        public Double alphaPinene {get;set;}
        @AuraEnabled
        public Double eucalyptol  {get;set;}
        @AuraEnabled
        public Double betaPinene {get;set;}
        @AuraEnabled
        public Double limonene{get;set;}
        @AuraEnabled
        public Double borneol {get;set;}
        @AuraEnabled
        public Double linalool{get;set;}
        @AuraEnabled
        public Double caryophyllene{get;set;}
        @AuraEnabled
        public Double myrcene{get;set;}
        @AuraEnabled
        public Double camphene {get;set;}
        @AuraEnabled
        public Double terpineol  {get;set;}
        @AuraEnabled
        public Double leadTime  {get;set;}
        @AuraEnabled
        public Double reorderPoint{get;set;}
        @AuraEnabled
        public Double safetyStockQty{get;set;}
        @AuraEnabled
        public Double safetyStockLow{get;set;}
        @AuraEnabled
        public Double safetyStockMedium{get;set;}
        @AuraEnabled
        public String safetyStockContact{get;set;}
        @AuraEnabled
        public String safetyStockContactName{get;set;}
        @AuraEnabled
        public Boolean enableReplenishmentAlert{get;set;}
        @AuraEnabled
        public Double rating{get;set;}
        @AuraEnabled
        public Double availableInventory{get;set;}
        @AuraEnabled
        public Double inventoryOnHoldQty{get;set;}
        @AuraEnabled
        public Double availableQty{get;set;}
        @AuraEnabled
        public Double totalOrderQty{get;set;}
        @AuraEnabled
        public Boolean notifyRequested{get;set;}
        @AuraEnabled
        public Boolean isActive{get;set;}
        @AuraEnabled
        public Decimal discountPercent{get;set;}
        @AuraEnabled
        public Decimal productDiscountPercent{get;set;}
        @AuraEnabled
        public Boolean fulfilledByFiligreen{get;set;}
        @AuraEnabled
        public Boolean hasSampleChild{get;set;}
        @AuraEnabled
        public string childProductId{get;set;}
        @AuraEnabled
        public Product sampleProduct{set;get;}
        @AuraEnabled
        public string certifications{get;set;}
        @AuraEnabled
        public string finalFormFactor{get;set;}
        @AuraEnabled
        public string marketplaceBrand{get;set;}
        @AuraEnabled
        public string appellation{get;set;}
        @AuraEnabled
        public Boolean isFlowers{get;set;}
        @AuraEnabled
        public Boolean isLeaves{get;set;}
        @AuraEnabled
        public Boolean isFresh{get;set;}
        @AuraEnabled
        public Decimal flowersGrams{get;set;}
        @AuraEnabled
        public Decimal leavesGrams{get;set;}
        @AuraEnabled
        public Decimal freshGrams{get;set;}
        @AuraEnabled
        public String brandName{get;set;} 
        @AuraEnabled
        public String shortDescription{get;set;}
        @AuraEnabled
        public String status{get;set;}
        @AuraEnabled
        public Decimal  MSRP{get;set;}
        @AuraEnabled
        public String encryptPriceBookId {get;set;}
        @AuraEnabled
        public String  ExternalDataID{get;set;}
        @AuraEnabled
        public Boolean isProductSample{set;get;}
        @AuraEnabled
        public Boolean isDiscountProduct{get;set;}
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
        @AuraEnabled
        public WarehouseAvailableInventory[] availableInventories{set;get;}
        public Product(){
            enableReplenishmentAlert = false;
            this.name = '';
            this.availableInventories = new WarehouseAvailableInventory[]{};
        }
        public Product(Product2 prod){
            this.availableInventories = new WarehouseAvailableInventory[]{};
            this.id = prod.id;
            this.name = prod.Name;
            this.status = prod.Status__c;
            this.isActive = prod.IsActive;
            this.description = prod.Description;
            this.shortDescription = prod.Product_Short_Description__c;
            this.productDetails = prod.Product_Details__c;
            this.brandName = prod.Brand_Name__c;
            this.productFamily = prod.Family;
            this.quantityType = prod.Quantity_Type__c;
            this.cultivationMethod = prod.Cultivation_Type__c;
            this.applyCultivationTax = prod.Apply_Cultivation_Tax__c;
            this.applyExciseTax = prod.Apply_Excise_Tax__c;
            this.producerId = prod.Producer_Name__c;
            this.producerName = prod.Producer_Name__r.Name;
            this.cannabisCategory1 = prod.Cannabis_Category_1__c;
            this.cannabisCategory2 = prod.Cannabis_Category_2__c;
            this.unitCannabisWeight1 = prod.Unit_Cannabis_Weight_1__c;
            this.cannabisRatio1 = prod.Cannabis_Ratio_1__c;
            this.unitCannabisWeight2 = prod.Unit_Cannabis_Weight_2__c;
            this.cannabisRatio2 = prod.Cannabis_Ratio_2__c;
            this.isFlowers = false;
            this.isLeaves = false;
            this.isFresh = false;
            if(String.isNotBlank(this.cannabisCategory1) && this.cannabisCategory1.equalsIgnoreCase('Flower') && String.isNotBlank(this.cannabisCategory2) && this.cannabisCategory2.equalsIgnoreCase('Leaves')){
                this.isFlowers = true;
                this.isLeaves = true;
                this.flowersGrams = this.unitCannabisWeight1;
                this.leavesGrams = this.unitCannabisWeight2;
            }else if(String.isNotBlank(this.cannabisCategory1) && this.cannabisCategory1.equalsIgnoreCase('Flower')){
                this.isFlowers = true;
                this.flowersGrams = this.unitCannabisWeight1;
            }else if(String.isNotBlank(this.cannabisCategory1) && this.cannabisCategory1.equalsIgnoreCase('Leaves')){
                this.isLeaves = true;
                this.leavesGrams = this.unitCannabisWeight1;
            }else if(String.isNotBlank(this.cannabisCategory1) && this.cannabisCategory1.equalsIgnoreCase('Fresh')){
                this.isFresh = true;
                this.freshGrams = this.unitCannabisWeight1;
            }            
            
            this.unitCultivationTax = prod.Unit_Cultivation_Tax_1__c;
            this.retailUnitFormFactor = prod.Retail_Unit_Form_Factor__c;
            this.unitHeight = prod.Unit_Height__c;
            this.stockingUOM = prod.Stocking_UOM__c;
            this.unitWidth = prod.Unit_Width__c;
            this.unitNetWeight = prod.Unit_Net_Weight__c;
            this.unitlength = prod.Unit_Length__c;
            this.unitGrossWeight = prod.Unit_Gross_Weight__c;
            this.unitRadius = prod.Unit_Radius__c;
            this.caseHeight = prod.Case_Height__c ;
            this.supplierUOM = prod.Supplier_UOM__c;
            this.caseWidth = prod.Case_Width__c;
            this.MOQ = prod.MOQ__c;
            this.caseLength = prod.Case_Length__c;
            this.cartonNetWeight = prod.Carton_Net_Weight__c;
            this.caseRadius = prod.Case_Radius__c;
            this.cartonGrossWeight = prod.Carton_Gross_Weight__c;
            this.THC = prod.THC_Amount__c;
            this.THCMGG = prod.THC_MG_G__c;
            this.CBD = prod.CDB_Amount__c;
            this.CBDMGG = Prod.CBD_MG_G__c;
            this.terpene = prod.Terpene_percent__c;
            this.alphaBisabolol = prod.Alpha_Bisabolol__c;
            this.delta3Carene = prod.Delta_3_Carene__c;
            this.alphaPinene = prod.Alpha_Pinene__c;
            this.eucalyptol = prod.Eucalyptol__c;
            this.betaPinene = prod.Beta_Pinene__c;
            this.limonene = prod.Limonene_percent__c;
            this.borneol= prod.Borneol__c;
            this.linalool = prod.Linalool__c;
            this.caryophyllene = prod.Caryophyllene__c;
            this.myrcene = prod.Myrcene__c;
            this.camphene = prod.Camphene__c;
            this.terpineol = prod.Terpineol__c ;
            this.leadTime  = prod.Lead_Time__c;
            this.reorderPoint = prod.Reorder_Point__c;
            this.safetyStockQty = prod.Safety_Stock_Qty__c;
            this.enableReplenishmentAlert = prod.Enable_Replenishment_Alert__c;
            this.safetyStockLow = prod.Safety_Stock_Low__c ;
            this.safetyStockMedium = prod.Safety_Stock_Medium__c;
            this.strainId = prod.Strain__c;
            this.strainName = prod.Strain__r.Name;
            this.strainType = prod.Strain_Type__c;
            this.safetyStockContact = prod.Safety_Stock_Contact_Name__c;
            this.safetyStockContactName = prod.Safety_Stock_Contact_Name__r.Name;
            this.fulfilledByFiligreen = prod.Fulfilled_by_Filigreen__c == NULL ?false:prod.Fulfilled_by_Filigreen__c;
            this.certifications = prod.Certifications__c;
            this.appellation = prod.Appellation__c;
            this.imageUrl = (prod.Image_URL__c != null?prod.Image_URL__c: IMAGE_COMINGSOON);
            this.availableQty = prod.Available_Qty__c;
            this.MSRP = prod.MSRP__c;
            this.ExternalDataID =prod.External_Data_ID__c;
        }
        public Product(PricebookEntry pbe){
            this.price = new Pricebook(pbe);
            this.isDiscountProduct=pbe.Product2.RecordType.Name == PRODUCT_RECORD_TYPE_NAME_DISCOUNT;
            this.id = pbe.Product2Id;
            this.name = pbe.Product2.Name;
            this.isBulkProduct=false;
            this.isProductSample = pbe.Product2.Is_Sample__c;
            this.status = pbe.Product2.Status__c;
            this.brandName = pbe.Product2.Brand_Name__c;
            this.licenseeId=pbe.Product2.Licensee_Name__c;
            this.licenseeName=pbe.Product2.Licensee_Name__r.Name;
            this.description = pbe.Product2.Description;
            this.shortDescription = pbe.Product2.Product_Short_Description__c;
            this.productDetails = pbe.Product2.Product_Details__c;
            this.MSRP = pbe.Product2.MSRP__c;
            this.imageUrl = (pbe.Product2.Image_URL__c != null?pbe.Product2.Image_URL__c: IMAGE_COMINGSOON);
            this.images = new List<String>();
            this.whiteLabelled=pbe.Product2.White_Labelled__c;
            this.producerId = pbe.Product2.Producer_Name__c;
            this.producerName = pbe.Product2.Producer_Name__r.Name;//pbe.Product2.Brand_Name__c;//  pbe.Product2.Producer_Name__r.dBA__c != null?pbe.Product2.Producer_Name__r.dBA__c:pbe.Product2.Producer_Name__r.Name;
            this.productFamily = pbe.Product2.Family;
            this.shortDescrption = pbe.Product2.Product_Short_Description__c;
            this.quantity = 0;
            this.TerpenePercent = (pbe.Product2.Terpene_percent__c != null? String.valueOf(pbe.Product2.Terpene_percent__c) + '%' : 'NA');
            this.MOQ = pbe.Product2.MOQ__c;
            this.strainName = pbe.Product2.Strain__r.Name;
            this.strainType = pbe.Product2.Strain_Type__c;
            this.THCPercent = (pbe.Product2.THC_Amount__c != null? String.valueOf(pbe.Product2.THC_Amount__c) + '%' : '0.00%');
            this.THCMG = (pbe.Product2.THC_MG_G__c != null? String.valueOf(pbe.Product2.THC_MG_G__c) + 'MG/G' : '0.0 MG/G');
            this.CBDPercent = (pbe.Product2.CDB_Amount__c != null? String.valueOf(pbe.Product2.CDB_Amount__c) + '%' : '0.00%');
            this.CBDMG = (pbe.Product2.CBD_MG_G__c != null? String.valueOf(pbe.Product2.CBD_MG_G__c) + 'MG/G' : '0.0 MG/G');
            this.cultivationMethod = pbe.Product2.Cultivation_Type__c;
            this.rating = pbe.Product2.Product_Rating__c!=null?pbe.Product2.Product_Rating__c.setScale(1):0;
            this.availableInventory = pbe.Product2.Available_Inventory__c;
            this.inventoryOnHoldQty = pbe.Product2.Inventory_On_Hold_Qty__c;
            this.availableQty = pbe.Product2.Available_Qty__c;
            this.totalOrderQty = pbe.Product2.Total_Order_Qty__c;
            this.notifyRequested = false;
            this.fulfilledByFiligreen = pbe.Product2.Fulfilled_by_Filigreen__c == NULL?false:pbe.Product2.Fulfilled_by_Filigreen__c;
        }
        public void setImages(Product2 p){
            if(p.Product_Images__r != null && !p.Product_Images__r.isEmpty()){
                this.images = new List<String>();
                for(Product_Image__c productImage:p.Product_Images__r){
                    this.images.add(productImage.Image_URL__c);
                }
            }else{
                this.images.add(p.Image_URL__c!=null?p.Image_URL__c: IMAGE_COMINGSOON);
            }
        }
        public void setDiscountPercent(Decimal discountPercent){
            this.discountPercent = discountPercent;
        }
        public void setProductDiscountPercent(Decimal discountPercent){
            this.productDiscountPercent = discountPercent;
        }
        public void notifyRequested(Boolean notifyRequested){
            this.notifyRequested = notifyRequested;
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
    
    public class LicenseAddress{
        @AuraEnabled
        public String id{get;set;}
        @AuraEnabled
        public Date expirationDate{get;set;}
        @AuraEnabled
        public Boolean isActive{get;set;}
        @AuraEnabled
        public Boolean isSelected{get;set;}
        @AuraEnabled
        public Boolean excludeExciseTax{get;set;}
        @AuraEnabled
        public Boolean disableExcludeExciseTax{get;set;}
        @AuraEnabled
        public Address shipping{get;set;}
        @AuraEnabled
        public String licenseClass{get;set;}
        @AuraEnabled
        public String licenseType{get;set;}
        @AuraEnabled
        public String licenseNumber{get;set;}
        @AuraEnabled
        public String licenseStatus{get;set;}
        @AuraEnabled
        public String siteId{get;set;}
        @AuraEnabled
        public String warehouseName{get;set;}
        
        public LicenseAddress(State_Licenses__c sl){
            this.id = sl.Id;
            this.siteId = sl.Default_Warehouse__c;
            this.warehouseName = sl.Default_Warehouse__r.Warehouse_Name__c;
            this.expirationDate = sl.License_Expiration_Date__c;
            this.isActive = (sl.License_Expiration_Date__c > Date.today());
            this.licenseClass = sl.License_Class__c;
            this.licenseType = sl.License_Type__c;
            this.licenseNumber = sl.License_Number__c;
            this.licenseStatus = sl.License_Status__c;
            this.isSelected = false;
            this.excludeExciseTax = false;
            this.shipping = new Address(sl.License_Address__c, sl.License_Country__c, sl.License_State__c, sl.License_City__c, sl.License_Zip__c);
            Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
            Boolean typeFound = false;
            if(ccs.Exclude_Excise_Tax_Types__c != null){
                for(String etx :ccs.Exclude_Excise_Tax_Types__c.split(',')){
                    if(this.licenseType != null && this.licenseType.equalsIgnoreCase(etx)){
                        typeFound = true;
                    }
                }
                this.disableExcludeExciseTax = !typeFound;
            }else{
                this.disableExcludeExciseTax = true;
            }
        }
    }
    
    public class Address{
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
        
        public Address(String street, String country, String province, String city, String postalCode){
            this.street = street;
            this.country = country;
            this.province = province;
            this.city = city;
            this.postalCode = postalCode;
        }
    }
    
    public class AddtoCart{
        public String productId{get;set;}
        public String retailerId{get;set;}
        public String pricebookId{get;set;}
        public Decimal quantity{get;set;}
        public Decimal MOQ{get;set;}
        public Decimal unitPrice{get;set;}
        public Boolean isUpdate{get;set;}
        public Boolean isSample{get;set;}
        public Boolean isPromo{get;set;}
        public Boolean isDiscountProduct{get;set;}
        public String specialInstructions{get;set;}
        public Boolean isBulkProduct{get;set;}
    }
    
    public class RetailerContact{
        @AuraEnabled
        public String id{set;get;}
        @AuraEnabled
        public String Name{set;get;}
        @AuraEnabled
        public String email{set;get;}
        @AuraEnabled
        public String title{set;get;}
        @AuraEnabled
        public String phone{set;get;}
        @AuraEnabled
        public String mobile{set;get;}
        
        public RetailerContact(Contact con){
            this.id = con.Id;
            this.Name = con.Name;
            this.email = con.Email;
            this.title = con.Title;
            this.phone = con.Phone;
            this.mobile = con.MobilePhone;
        }
    }
    
    public class Brand{
        @AuraEnabled
        public String name{get;set;}
        @AuraEnabled
        public String imageUrl{get;set;}
        @AuraEnabled
        public String DBA {get;set;}
        @AuraEnabled
        public String Phone {get;set;}
        @AuraEnabled
        public String Fax {get;set;}
        @AuraEnabled
        public String Website {get;set;}
        @AuraEnabled
        public String AccountRating {get;set;}
        @AuraEnabled
        public String PaymentTerms {get;set;}
        @AuraEnabled
        public Id id {get;set;}
        @AuraEnabled
        public String billingAddress {get;set;}
        @AuraEnabled
        public String street{get;set;}
        @AuraEnabled
        public String city{get;set;}
        @AuraEnabled
        public String state{get;set;}
        @AuraEnabled
        public String postalCode{get;set;}
        @AuraEnabled
        public String country{get;set;}
        @AuraEnabled
        public String Twitter {get;set;}
        @AuraEnabled
        public String Facebook {get;set;}
        @AuraEnabled
        public String LinkedIn {get;set;}
        @AuraEnabled
        public String Instagram {get;set;}
        @AuraEnabled
        public String aboutus {get;set;}
        @AuraEnabled
        public String brandName{get;set;}
        @AuraEnabled
        public Date onBoardDate{get;set;}
        @AuraEnabled
        public Boolean isLineCard{get;set;}
        @AuraEnabled
        public String salesPersonId{set;get;}
        @AuraEnabled
        public String salesPersonName{set;get;}
        @AuraEnabled
        public String description{get;set;}
        @AuraEnabled
        public String fullDescription{get;set;}
        @AuraEnabled
        public String businessLine{get;set;}
        @AuraEnabled
        public String businessLineInTwoLine{get;set;}
        
        public Brand(Account a){
            this.name = String.isBlank(a.dBA__c)? a.Name: a.dBA__c;
            this.brandName = a.Name;
            this.imageUrl = a.Image_URL__c != null?a.Image_URL__c: IMAGE_COMINGSOON;
            this.DBA = a.DBA__c;
            this.Phone = a.Phone;
            this.Fax = a.Fax;
            this.Website = a.Website;
            this.fullDescription = a.Description;
            this.businessLine = a.Business_Type__c != null ? a.Business_Type__c.replace(';',', ') : '';
            string bLine = '';
            if(this.businessLine != ''){
                if(this.businessLine.length() > 28){
                    string str1 = this.businessLine.substring(0,28);
                    string str2 = this.businessLine.substring(28,this.businessLine.length());
                    bLine = str1 + '<br/>' + str2;
                }else{
                    bLine = this.businessLine;
                }           
            }
            this.businessLineInTwoLine = bLine;
            if(a.Description != null){
                string des ='';
                if(a.Description.length() > 52){
                    string str1 = a.Description.substring(0,52);
                    string str2 = a.Description.substring(52,a.Description.length());
                    des = str1 + '<br/>' + str2;
                }else{
                    des = a.Description;
                }
                this.description = des; 
            }
            if(!a.Line_Cards__r.isEmpty()){
                this.isLineCard = true;
                this.AccountRating = a.Line_Cards__r[0].Brand_Account_Rating__c;
                this.PaymentTerms = a.Line_Cards__r[0].Mutual_Payment_Terms__c;
                this.onBoardDate = a.Line_Cards__r[0].Onboard_Date__c;
                this.salesPersonId = a.Line_Cards__r[0].Sales_Person__c;
                this.salesPersonName = a.Line_Cards__r[0].Sales_Person__r.Name;
            }else{
                this.isLineCard = false;
                this.AccountRating = a.Account_Rating__c;
                this.PaymentTerms = a.Payment_Terms__c;
            }
            this.Id = a.Id;
            List<String> address = new List<String>();
            this.street = a.BillingStreet;
            address.add(a.BillingStreet);
            if(a.BillingCity != null && a.BillingCity != ''){
                this.city = a.BillingCity;
                address.add(a.BillingCity);
            }
            if(a.BillingState != null && a.BillingState != ''){
                this.state = a.BillingState;
                address.add(a.BillingState);
            }
            if(a.BillingCountry != null && a.BillingCountry != ''){
                this.country = a.BillingCountry;
                address.add(a.BillingCountry);
            }
            if(a.BillingPostalCode != null && a.BillingPostalCode != ''){
                this.postalCode = a.BillingPostalCode;
                address.add(a.BillingPostalCode);
            }
            this.billingAddress = String.join(address, ', ');
            this.Twitter = a.Twitter__c;
            this.Facebook = a.Facebook__c;
            this.LinkedIn = a.LinkedIn__c;
            this.Instagram = a.Instagram__c;
            this.aboutus = a.About_Us__c;
        }
    }
    
    public class Retailer{
        @AuraEnabled
        public Id id{get;set;}
        @AuraEnabled
        public String brandAccountRating{get;set;}
        @AuraEnabled
        public String brandDBA{get;set;}
        @AuraEnabled
        public String brandName{get;set;}
        @AuraEnabled
        public String mutualPaymentTerms{get;set;}
        @AuraEnabled
        public Date onboardDate{get;set;}
        @AuraEnabled
        public String retailAccountRating{get;set;}
        @AuraEnabled
        public String retailerDBA{get;set;}
        @AuraEnabled
        public String retailerExcluded{get;set;}
        @AuraEnabled
        public String retailerName{get;set;}
        @AuraEnabled
        public String imageUrl{get;set;}
        @AuraEnabled
        public String phone{get;set;}
        @AuraEnabled
        public String fax{get;set;}
        @AuraEnabled
        public String website{get;set;}
        @AuraEnabled
        public String facebook{get;set;}
        @AuraEnabled
        public String twitter{get;set;}
        @AuraEnabled
        public String linkedin{get;set;}
        @AuraEnabled
        public String instagram{get;set;}
        @AuraEnabled
        public String aboutus{get;set;}
        @AuraEnabled
        public String billingAddress{get;set;}
        @AuraEnabled
        public String street{get;set;}
        @AuraEnabled
        public String city{get;set;}
        @AuraEnabled
        public String state{get;set;}
        @AuraEnabled
        public String postalCode{get;set;}
        @AuraEnabled
        public String country{get;set;}
        @AuraEnabled
        public Boolean isLineCard{get;set;}
        @AuraEnabled
        public Boolean isValid{get;set;}
        @AuraEnabled
        public String lineCardId{get;set;}
        @AuraEnabled
        public String retailerContacts{get;set;}
        @AuraEnabled
        public String retailerLicenses{get;set;}
        @AuraEnabled
        public String retailerContact{get;set;}
        @AuraEnabled
        public String retailerLicense{get;set;}
        @AuraEnabled
        public String salesPersonId{set;get;}
        @AuraEnabled
        public String salesPersonName{set;get;}
        @AuraEnabled
        public Boolean hasRetailerContact{get;set;}
        @AuraEnabled
        public Boolean hasRetailerLicense{get;set;}
        @AuraEnabled
        public String description{get;set;}
        @AuraEnabled
        public String fullDescription{get;set;}
        @AuraEnabled
        public String businessLine{get;set;}
        @AuraEnabled
        public Decimal minimumOrderValue{get;set;}
        @AuraEnabled
        public String businessLineInTwoLine{get;set;}
        @AuraEnabled
        public Boolean barcode{get;set;}
        @AuraEnabled
        public Boolean  QRCode{get;set;}
        @AuraEnabled
        public Boolean ThirdpartyScheduler{get;set;}
        @AuraEnabled
        public Boolean uploadCOA{get;set;}
        public Retailer(){
            this.brandDBA = '';
            this.retailerDBA = '';
            this.retailerName = '';
            this.isLineCard = false;
        }
        public Retailer(Line_Card__c lc){
            this.id = lc.Id;
            this.brandDBA = lc.Brand_DBA__c;
            this.retailerDBA = lc.Retailer_DBA__c;
            this.retailerName = lc.Retailer_Name__r.Name;
            this.businessLine = lc.Retailer_Name__r.Business_Type__c != null ? lc.Retailer_Name__r.Business_Type__c.replace(';',', ') : '';
            string bLine = '';
            if(this.businessLine != ''){
                if(this.businessLine.length() > 28){
                    string str1 = this.businessLine.substring(0,28);
                    string str2 = this.businessLine.substring(28,this.businessLine.length());
                    bLine = str1 + '<br/>' + str2;
                }else{
                    bLine = this.businessLine;
                }
            }
            this.businessLineInTwoLine = bLine;
            this.imageUrl = lc.Retailer_Name__r.Image_URL__c != null?lc.Retailer_Name__r.Image_URL__c: IMAGE_COMINGSOON;
            this.retailAccountRating = lc.Retail_Account_Rating__c;
            this.onboardDate = lc.Onboard_Date__c;
            this.mutualPaymentTerms = lc.Mutual_Payment_Terms__c;
            this.phone = lc.Retailer_Name__r.Phone;
            this.fax = lc.Retailer_Name__r.Fax;
            this.website = lc.Retailer_Name__r.Website;
            List<String> address = new List<String>();
            this.street = lc.Retailer_Name__r.BillingStreet;
            address.add(lc.Retailer_Name__r.BillingStreet);
            if(lc.Retailer_Name__r.BillingCity != null && lc.Retailer_Name__r.BillingCity != ''){
                this.city = lc.Retailer_Name__r.BillingCity;
                address.add(lc.Retailer_Name__r.BillingCity);
            }
            if(lc.Retailer_Name__r.BillingState != null && lc.Retailer_Name__r.BillingState != ''){
                this.state = lc.Retailer_Name__r.BillingState;
                address.add(lc.Retailer_Name__r.BillingState);
            }
            if(lc.Retailer_Name__r.BillingCountry != null && lc.Retailer_Name__r.BillingCountry != ''){
                this.country = lc.Retailer_Name__r.BillingCountry;
                address.add(lc.Retailer_Name__r.BillingCountry);
            }
            if(lc.Retailer_Name__r.BillingPostalCode != null && lc.Retailer_Name__r.BillingPostalCode != ''){
                this.postalCode = lc.Retailer_Name__r.BillingPostalCode;
                address.add(lc.Retailer_Name__r.BillingPostalCode);
            }
            this.linkedin = lc.Retailer_Name__r.LinkedIn__c;
            this.facebook = lc.Retailer_Name__r.Facebook__c;
            this.twitter = lc.Retailer_Name__r.Twitter__c;
            this.instagram = lc.Retailer_Name__r.Instagram__c;
            this.aboutus = lc.Retailer_Name__r.About_Us__c;
            this.billingAddress = String.join(address, ', ');
            this.salesPersonId = lc.Sales_Person__c;
            this.salesPersonName = lc.Sales_Person__r.Name;
        }
        public Retailer(Account a, Line_Card__c lc,String retailerFilter){
            this.id = a.Id;
            this.barcode = a.Bar_Code__c;
            this.QRCode = a.QR_Code__c;
            this.ThirdpartyScheduler = a.Third_Party_Scheduler__c;
            if(lc != null){
                this.isLineCard = true;
                this.lineCardId = lc.Id;
                this.brandDBA = lc.Brand_DBA__c;
                this.retailAccountRating = lc.Retail_Account_Rating__c;
                this.onboardDate = lc.Onboard_Date__c;
                this.mutualPaymentTerms = lc.Mutual_Payment_Terms__c;
                this.salesPersonId = lc.Sales_Person__c;
                this.salesPersonName = lc.Sales_Person__r.Name;
                this.minimumOrderValue =lc.Minimum_Order_Value__c != null ? lc.Minimum_Order_Value__c : 0;
            }else{
                this.isLineCard = false;
            }
            
            if(String.isNotBlank(retailerFilter) && (retailerFilter.equalsIgnoreCase('All') || (retailerFilter.equalsIgnoreCase('My Retailers') && this.isLineCard))){
                this.isValid = true;
            }else if(String.isNotBlank(retailerFilter) && retailerFilter.equalsIgnoreCase('Other Retailers') && !this.isLineCard){
                this.isValid = true;
            }else{
                this.isValid = false;
            }
            this.retailerDBA = a.DBA__c;
            this.retailerName = a.Name;
            this.imageUrl = a.Image_URL__c != null?a.Image_URL__c: IMAGE_COMINGSOON;
            this.businessLine = a.Business_Type__c != null ? a.Business_Type__c.replace(';',', ') : '';
            string bLine = '';
            if(this.businessLine != ''){
                if(this.businessLine.length() > 28){
                    string str1 = this.businessLine.substring(0,28);
                    string str2 = this.businessLine.substring(28,this.businessLine.length());
                    bLine = str1 + '<br/>' + str2;
                }else{
                    bLine = this.businessLine;
                }
            }
            this.businessLineInTwoLine = bLine;
            this.phone = a.Phone;
            this.fax = a.Fax;
            this.website = a.Website;
            List<String> address = new List<String>();
            this.street = a.BillingStreet;
            address.add(a.BillingStreet);
            if(a.BillingCity != null && a.BillingCity != ''){
                this.city = a.BillingCity;
                address.add(a.BillingCity);
            }
            if(a.BillingState != null && a.BillingState != ''){
                this.state = a.BillingState;
                address.add(a.BillingState);
            }
            if(a.BillingCountry != null && a.BillingCountry != ''){
                this.country = a.BillingCountry;
                address.add(a.BillingCountry);
            }
            if(a.BillingPostalCode != null && a.BillingPostalCode != ''){
                this.postalCode = a.BillingPostalCode;
                address.add(a.BillingPostalCode);
            }
            this.linkedin = a.LinkedIn__c;
            this.facebook = a.Facebook__c;
            this.twitter = a.Twitter__c;
            this.instagram = a.Instagram__c;
            this.aboutus = a.About_Us__c;
            this.billingAddress = String.join(address, ', ');
            String comma = '';
            this.retailerLicenses = '';
            this.hasRetailerLicense = false;
            if(a.State_Licenses__r != null && a.State_Licenses__r.size() > 0){
                if(a.State_Licenses__r.size() > 1)
                    this.hasRetailerLicense = true;
                for(State_Licenses__c st: a.State_Licenses__r){
                    this.retailerLicenses += comma + st.License_Type__c + '-'+st.License_Number__c;
                    comma = '<br/>';
                }
                this.retailerLicense = a.State_Licenses__r[0].License_Type__c + '-'+a.State_Licenses__r[0].License_Number__c;
            }
            comma = '';
            this.retailerContacts = '';
            this.hasRetailerContact = false;
            if(a.Contacts != null && a.Contacts.size() > 0){
                if(a.Contacts.size() > 1)
                    this.hasRetailerContact = true;
                for(Contact con: a.Contacts){
                    this.retailerContacts += comma + con.Name;
                    comma = '<br/>';
                }
                this.retailerContact = a.Contacts[0].Name;
            }
            this.fullDescription = a.Description;
            if(a.Description != null){
                string des ='';
                if(a.Description.length() > 52){
                    string str1 = a.Description.substring(0,52);
                    string str2 = a.Description.substring(52,a.Description.length());
                    des = str1 + '<br/>' + str2;
                }else{
                    des = a.Description;
                }
                this.description = des; 
            }
        }
    }
    
    public class ReviewChart{
        @AuraEnabled
        public Integer count{get;set;}
        @AuraEnabled
        public Integer percent{get;set;}
        public ReviewChart(Integer count,Integer percent){
            this.count = count;
            this.percent = percent;
        }
    }
    
    public class Review{
        @AuraEnabled
        public String productId{get;set;}
        @AuraEnabled
        public Double rating{get;set;}
        @AuraEnabled
        public String review{get;set;}
        @AuraEnabled
        public String createdDate{get;set;}
        @AuraEnabled
        public String createdBy{get;set;}
        
        public Review(Product_Review__c pr){
            this.rating = pr.Rating__c;
            this.review = pr.Review__c;
            this.createdDate = pr.CreatedDate.format('dd MMM yyyy');
            this.createdBy = pr.Owner.Name;
        }
    }
    public class caseAttachment{
        @AuraEnabled
        public String id{set;get;}
        @AuraEnabled
        public String ticketNumber{set;get;}
        @AuraEnabled
        public String documentId{set;get;}
        @AuraEnabled
        public String documentTitle{set;get;}
        @AuraEnabled
        public Boolean hasAttchment{set;get;}
        
        public caseAttachment(){
            this.id = '';
            this.ticketNumber = '';
            this.hasAttchment = false;
            this.documentId = '';
            this.documentTitle = '';
        }
        
        public caseAttachment(Case cs, ContentDocumentLink content, Boolean isAttach){
          this.id = cs.Id;
          this.ticketNumber = cs.CaseNumber;
          this.hasAttchment = isAttach;
          this.documentId = content.ContentDocumentId;
          this.documentTitle = content.ContentDocument.title; 
        }
        public caseAttachment(Case cs,Boolean isAttach){
          this.id = cs.Id;
          this.ticketNumber = cs.CaseNumber;
          this.hasAttchment = isAttach;
        }
    }
    public class SalesOrder{
        @AuraEnabled
        public String name{get;set;}
        @AuraEnabled
        public String SOId{get;set;}
        @AuraEnabled
        public String BQname{get;set;}
        @AuraEnabled
        public String customerPOorQuote{get;set;}
        @AuraEnabled
        public Date sODate{get;set;}
        @AuraEnabled
        public String sOStatus{get;set;}
        @AuraEnabled
        public Double totalLineItems{get;set;}
        @AuraEnabled
        public Double totatPrice{get;set;}
        @AuraEnabled
        public Id orderId{get;set;}
        @AuraEnabled
        public Id purchaseOrderId{get;set;}
        @AuraEnabled
        public String purchaseOrderName{get;set;}
        @AuraEnabled
        public String brandQuote{get;set;}
        @AuraEnabled
        public Id RSMId{get;set;}
        @AuraEnabled
        public String RSMName{get;set;}
         @AuraEnabled
        public String MetrcManifest{get;set;}
        @AuraEnabled
        public String invoiceName{get;set;}
        @AuraEnabled
        public Id invoiceId{get;set;}
        @AuraEnabled
        public String orderNumber {get;set;}
        
        
        
        
        public SalesOrder(Sales_Order__c so, Map<Id, Purchase_Order__c> purchaseOrders){
            this.name = so.Name;
            this.SOId=so.Id;
            this.customerPOorQuote = so.Customer_PO_or_Quote__c;
            this.sODate = so.SO_Date__c;
            this.sOStatus = so.SO_Status__c;
            this.totalLineItems = so.Total_Line_Items__c;
            this.totatPrice = so.Total_Price__c;
            this.orderId = so.Brand_Quote__r.Opportunity_Name__r.Order__c;
            this.orderNumber = so.Brand_Quote__r.Opportunity_Name__r.Order__r.Name;
            this.brandQuote= so.Brand_Quote__c;
            this.BQname = so.Brand_Quote__r.Name;
            if(!so.Shipping_Manifests__r.isEmpty()){
                this.RSMId = so.Shipping_Manifests__r[0].Id;
                this.RSMName=so.Shipping_Manifests__r[0].Name;
                this.MetrcManifest = so.Shipping_Manifests__r[0].Metrc_Manifest__c;
            }
            if(!so.Invoices__r.isEmpty()){
                this.invoiceId=so.Invoices__r[0].Id;
                this.invoiceName=so.Invoices__r[0].Name;
            }
            if(purchaseOrders.get(so.Brand_Quote__c)!=null){
                purchaseOrderId = purchaseOrders.get(so.Brand_Quote__c).Id;
                purchaseOrderName = purchaseOrders.get(so.Brand_Quote__c).Name;
            }
        }
    }
    

}