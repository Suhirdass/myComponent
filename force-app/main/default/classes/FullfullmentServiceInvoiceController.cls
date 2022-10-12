/**
* Copyright (c) 2021 WOVN
* All rights reserved.
* FullfullmentServiceInvoiceController
*/
public class FullfullmentServiceInvoiceController {
    public static String PAYMENT_TERMS_COD = 'COD';
    private Static String SITE_NAME_7027{ 
        get{
            return  String.isNotBlank(SITE_NAME_7027) ? SITE_NAME_7027 :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Site','Site_Name_7027');
        }set;
    }
    private Static String SITE_NAME_2089{ 
        get{
            return  String.isNotBlank(SITE_NAME_2089) ? SITE_NAME_2089 :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Site','Site_Name_2089');
        }set;
    }    
    private Static String INVOICE_RECORDTYPE_SERVICE { 
        get{
            return  String.isNotBlank(INVOICE_RECORDTYPE_SERVICE) ? INVOICE_RECORDTYPE_SERVICE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
    public Static String ERR_MSG_NO_INVOICE_LINE_AVAILABLE { 
        get{
            return  String.isNotBlank(ERR_MSG_NO_INVOICE_LINE_AVAILABLE) ? ERR_MSG_NO_INVOICE_LINE_AVAILABLE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Err_Msg_No_Invoive_Line_Available');
        }set;
    }
    private Static String INVOICE_LINE_RECORDTYPE_SERVICE { 
        get{
            return  String.isNotBlank(INVOICE_LINE_RECORDTYPE_SERVICE) ? INVOICE_LINE_RECORDTYPE_SERVICE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice Line','Invoice_Line_RecordType_Service');
        }set;
    }
    private Static String SO_SHIPPING_METHOD_PICK_UP{ 
        get{
            return  String.isNotBlank(SO_SHIPPING_METHOD_PICK_UP) ? SO_SHIPPING_METHOD_PICK_UP :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Shipping_Method_Pick_Up');
        }set;
    }
    private Static String PRODUCT_NAME_MILEAGE_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_MILEAGE_FEE) ? PRODUCT_NAME_MILEAGE_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Mileage_Fee');
        }set;
    }
    private Static String PRODUCT_NAME_PICK_AND_PACK_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_PICK_AND_PACK_FEE) ? PRODUCT_NAME_PICK_AND_PACK_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Pick_And_Pack_Fee');
        }set;
    }
    private Static String PRODUCT_NAME_WEIGHT_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_WEIGHT_FEE) ? PRODUCT_NAME_WEIGHT_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Weight_Fee');
        }set;
    }
    private Static String PRODUCT_NAME_QA_REVIEW_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_QA_REVIEW_FEE) ? PRODUCT_NAME_QA_REVIEW_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_QA_Review');
        }set;
    }
    private Static String PRODUCT_NAME_ORDER_BOOKING{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_ORDER_BOOKING) ? PRODUCT_NAME_ORDER_BOOKING :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Order_Booking');
        }set;
    }
    private Static String PRODUCT_NAME_INVENTORY_STORAGE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_INVENTORY_STORAGE) ? PRODUCT_NAME_INVENTORY_STORAGE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Inventory_Storage');
        }set;
    }
    private Static String PRODUCT_NAME_PACK_OUT{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_PACK_OUT) ? PRODUCT_NAME_PACK_OUT :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Pack_Out');
        }set;
    }
    private Static String PRODUCT_NAME_SCHEDULE_AND_DISPATCH{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_SCHEDULE_AND_DISPATCH) ? PRODUCT_NAME_SCHEDULE_AND_DISPATCH :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Schedule_And_Dispatch');
        }set;
    }
    private Static String PRODUCT_NAME_STAGE_AND_MANIFEST{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_STAGE_AND_MANIFEST) ? PRODUCT_NAME_STAGE_AND_MANIFEST :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Stage_And_Manifest');
        }set;
    }
    private Static String PRODUCT_NAME_CHANGE_ORDER_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_CHANGE_ORDER_FEE) ? PRODUCT_NAME_CHANGE_ORDER_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Change_Order_Fee');
        }set;
    }
    public Static String PRODUCT_NAME_LISTING_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_LISTING_FEE) ? PRODUCT_NAME_LISTING_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Listing_Fee');
        }set;
    }
    public Static String STANDARD_PRICE_BOOK {
        get{
            return String.isNotBlank(STANDARD_PRICE_BOOK) ? STANDARD_PRICE_BOOK:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Pricebook','STANDARD_PRICE_BOOK');
        }set;
    }
    public Static String SO_ORDER_TYPE_BRAND {
        get{
            return String.isNotBlank(SO_ORDER_TYPE_BRAND) ? SO_ORDER_TYPE_BRAND:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Type_Brand');
        }set;
    }
    private static String Invoice_Ar_Status_Approved{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Approved) ? Invoice_Ar_Status_Approved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Approved');
        }set;
    }
    private static String Invoice_Ar_Status_Shipped{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Shipped) ? Invoice_Ar_Status_Shipped : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Shipped');
        }set;
    }
    private static String Invoice_Record_Type_Tax{
        get{
            return String.isNotBlank(Invoice_Record_Type_Tax) ? Invoice_Record_Type_Tax : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Tax Protected');
        }set;
    }
    private static String ErrMsgSubmitSOForApprovalToCreateCTI{
        get{
            return String.isNotBlank(ErrMsgSubmitSOForApprovalToCreateCTI) ? ErrMsgSubmitSOForApprovalToCreateCTI : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','ErrMsgSubmitSOForApprovalToCreateCTI');
        }set;
    }
    private static String ErrMsgCan_tCreateCTIForCancelledSO{
        get{
            return String.isNotBlank(ErrMsgCan_tCreateCTIForCancelledSO) ? ErrMsgCan_tCreateCTIForCancelledSO : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','ErrMsgCan_tCreateCTIForCancelledSO');
        }set;
    }
    private static String ErrMsgCan_tCreateCTIForRejectedSO{
        get{
            return String.isNotBlank(ErrMsgCan_tCreateCTIForRejectedSO) ? ErrMsgCan_tCreateCTIForRejectedSO : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','ErrMsgCan_tCreateCTIForRejectedSO');
        }set;
    }
    private static String ErrMsgCTIAlreadyCreated{
        get{
            return String.isNotBlank(ErrMsgCTIAlreadyCreated) ? ErrMsgCTIAlreadyCreated : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','ErrMsgCTIAlreadyCreated');
        }set;
    }
    private static String ErrMsgCan_tCreateCTIForNonApproved{
        get{
            return String.isNotBlank(ErrMsgCan_tCreateCTIForNonApproved) ? ErrMsgCan_tCreateCTIForNonApproved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','ErrMsgCan_tCreateCTIForNonApproved');
        }set;
    }
    private static String ErrMsgBillableCultivationTaxIP{
        get{
            return String.isNotBlank(ErrMsgBillableCultivationTaxIP) ? ErrMsgBillableCultivationTaxIP : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','ErrMsgBillableCultivationTaxIP');
        }set;
    }
    private static String Success_Msg_CTI_Created{
        get{
            return String.isNotBlank(Success_Msg_CTI_Created) ? Success_Msg_CTI_Created : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Success_Msg_CTI_Created');
        }set;
    }
    private static String SO_Status_Draft{
        get{
            return String.isNotBlank(SO_Status_Draft) ? SO_Status_Draft : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Draft');
        }set;
    }
    private static String SO_Status_Cancelled{
        get{
            return String.isNotBlank(SO_Status_Cancelled) ? SO_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Cancelled');
        }set;
    }
    private static String SO_Status_Rejected{
        get{
            return String.isNotBlank(SO_Status_Rejected) ? SO_Status_Rejected : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Rejected');
        }set;
    }
    private static String Sales_Order_Status_Approved{
        get{
            return String.isNotBlank(Sales_Order_Status_Approved) ? Sales_Order_Status_Approved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Approved');
        }set;
    }
    private static String Sales_Order_Line_Status_Cancelled{
        get{
            return String.isNotBlank(Sales_Order_Line_Status_Cancelled) ? Sales_Order_Line_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Cancelled');
        }set;
    }
    private static String Sales_Order_Line_Status_Open{
        get{
            return String.isNotBlank(Sales_Order_Line_Status_Open) ? Sales_Order_Line_Status_Open : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Open');
        }set;
    }
    public static String Label_Not_For_Resale_Product{
        get{
            return String.isNotBlank(Label_Not_For_Resale_Product) ? Label_Not_For_Resale_Product : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Label_Not_For_Resale_Product');
        }set;
    }
    public static String Sample_Product_Price{
        get{
            return String.isNotBlank(Sample_Product_Price) ? Sample_Product_Price : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Sample_Product_Price');
        }set;
    }
    private Static String PRODUCT_NAME_AGENT_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_AGENT_FEE) ? PRODUCT_NAME_AGENT_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Agent_Fee');
        }set;
    }
    private Static String Product_Name_Manifest_Change_Fee{ 
        get{
            return  String.isNotBlank(Product_Name_Manifest_Change_Fee) ? Product_Name_Manifest_Change_Fee :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Manifest_Change_Fee');
        }set;
    }
    private Static String PRODUCT_NAME_DISTRIBUTION_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_DISTRIBUTION_FEE) ? PRODUCT_NAME_DISTRIBUTION_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Distribution_Fee');
        }set;
    }
    private Static String ORDER_TYPE_TRANSFER {
        get{
            return String.isNotBlank(ORDER_TYPE_TRANSFER) ? ORDER_TYPE_TRANSFER :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Transfer');
        }set;
    } 
        public Static String TYPE_BUYQUOTE{ 
        get{
            return  String.isNotBlank(TYPE_BUYQUOTE) ? TYPE_BUYQUOTE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuoteType_BuyQuote');
        }set;
    }
    private static String ACCOUNT_PLATEFORMLEVEL_ADVANCE {
        get{
            return String.isNotBlank(ACCOUNT_PLATEFORMLEVEL_ADVANCE ) ? ACCOUNT_PLATEFORMLEVEL_ADVANCE  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Plateformlevel_Advance');
        }set;
    }
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
    private static String STATE_LICENSE_ACTIVE{
        get{
            return String.isNotBlank(STATE_LICENSE_ACTIVE) ? STATE_LICENSE_ACTIVE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_Active');
        }set;
    }
    private static String STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE{
        get{
            return String.isNotBlank(STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE) ? STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_License_Holder_RecordType');
        }set;
    }
    private static String STATE_LICENSE_NONCANNABIS_RECORDTYPE{
        get{
            return String.isNotBlank(STATE_LICENSE_NONCANNABIS_RECORDTYPE) ? STATE_LICENSE_NONCANNABIS_RECORDTYPE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_NonCannabis_RecordType');
        }set;
    }
    private static String ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER) ? ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Financial_Interest_Holder');
        }set;
    }
    private static String ACCOUNT_PLATEFORMLEVEL_BASIC {
        get{
            return String.isNotBlank(ACCOUNT_PLATEFORMLEVEL_BASIC ) ? ACCOUNT_PLATEFORMLEVEL_BASIC  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Plateformlevel_Basic');
        }set;
    }
    private static String Order_Record_Type_Name_Retailer {
        get{
            return String.isNotBlank(Order_Record_Type_Name_Retailer ) ? Order_Record_Type_Name_Retailer  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_Retailer');
        }set;
    }
    public Static String Delivery_Rescheduling_Fee_Config{
        get{
            return String.isNotBlank(Delivery_Rescheduling_Fee_Config) ? Delivery_Rescheduling_Fee_Config: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Delivery_Rescheduling_Fee_Config');
        }set;
    }
    private Static String SO_RECORDTYPE_TRANSFER {		
        get{
              return String.isNotBlank(SO_RECORDTYPE_TRANSFER) ? SO_RECORDTYPE_TRANSFER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_Transfer');
        }set;
    }
    private Static String Account_Service_Type_Service {		
        get{
              return String.isNotBlank(Account_Service_Type_Service) ? Account_Service_Type_Service : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Service_Type_Service');
        }set;
    }
    private Static String Account_Service_Type_Margin {		
        get{
              return String.isNotBlank(Account_Service_Type_Margin) ? Account_Service_Type_Margin : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Service_Type_Margin');
        }set;
    }
    private Static String Account_Service_Type_Buy_Sell {		
        get{
              return String.isNotBlank(Account_Service_Type_Buy_Sell) ? Account_Service_Type_Buy_Sell : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Service_Type_Buy_Sell');
        }set;
    }
    private Static String Fulfillment_Invoice_Not_Create {		
        get{
              return String.isNotBlank(Fulfillment_Invoice_Not_Create) ? Fulfillment_Invoice_Not_Create : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Fulfillment_Invoice_Not_Create');
        }set;
    }
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
    @AuraEnabled
    public static AuraResponse createServiceInvoice(String recordId,Boolean isOBCreated){
        Set<String> serviceFeeProductSet = new Set<String>{PRODUCT_NAME_INVENTORY_STORAGE,PRODUCT_NAME_MILEAGE_FEE,PRODUCT_NAME_PICK_AND_PACK_FEE,PRODUCT_NAME_QA_REVIEW_FEE,PRODUCT_NAME_ORDER_BOOKING,PRODUCT_NAME_PACK_OUT,PRODUCT_NAME_WEIGHT_FEE,PRODUCT_NAME_SCHEDULE_AND_DISPATCH,PRODUCT_NAME_STAGE_AND_MANIFEST,PRODUCT_NAME_CHANGE_ORDER_FEE,PRODUCT_NAME_AGENT_FEE,PRODUCT_NAME_DISTRIBUTION_FEE,Delivery_Rescheduling_Fee_Config,Product_Name_Manifest_Change_Fee};
            AuraResponse r = new AuraResponse('FullfullmentServiceInvoiceController.createServiceInvoice()');
        if(String.isNotBlank(recordId)){
            Product2[] products = [SELECT Id,Name,Is_Sample__c,Parent_Product__c FROM Product2 WHERE Name IN: serviceFeeProductSet];
            Map<String, Product2> productsMap = new Map<String,Product2>();
            Set<Id> productIds = new Set<Id>();
            for(Product2 p: products){
                if(!p.Is_Sample__c && p.Parent_Product__c == null && !p.Name.endsWithIgnoreCase('-Sample')){
                    productsMap.put(p.Name,p);
               	 	productIds.add(p.Id);
                }
            }
            PriceBookEntry[] PBEs = [SELECT Id, Product2Id,UnitPrice FROM PriceBookEntry WHERE Product2Id IN :productIds AND PriceBook2.Name =: STANDARD_PRICE_BOOK];
            Map<Id,PriceBookEntry> productPBEMap = new Map<Id,PriceBookEntry>();
            for(PriceBookEntry pbe: PBEs){
                productPBEMap.put(pbe.Product2Id,pbe);
            }
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
                                     ,Site__c,Supplier_Name__r.Payment_Terms__c
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
                                     ,Ownership__c,Ownership__r.Type,Ownership__r.Service_Type__c
                                     ,Total_Weight_Fee__c , 
                                     Total_Mileage_Fee__c  , Brand_Quote__r.Opportunity_Name__r.Order__r.Sample_Order__c,
                                     RecordType.Name,Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__c,
                                     Stage_Manifest_Fee__c , Schedule_Dispatch_Fee__c ,Total_Manifest_Change_Fee__c, 
                                     Pack_Out_Fee__c , Order_Booking_Fee__c,Total_Pick_Pack_Fee__c,
                                     Total_QA_Review_Fee__c,Change_Order_Fee__c,
                                     Total_Weight_lbs__c,Brand_Quote__r.Order_Type__c,Listing_Fee__c,
                                     Supplier_Name__r.Membership_Level__c, Brand_Quote__r.recordtype.Name,
                                     Receiver_Name__r.Platform_Level__c,Ownership__r.DBA__c,
                                     Receiver_Name__r.Membership_Level__c, Supplier_Name__r.Service_Type__c,Supplier_Name__r.Distribution_Fee__c,Total_Distribution_Fees__c,Total_Price__c,Distribution__c,
                                     Order_Type__c,Brand_Quote__r.Opportunity_Name__c,Receiver_Name__r.DBA__c,Supplier_Name__r.DBA__c,Piggyback_sample__c,
                                     Ship_Confirmation_Date__c,Brand_Quote__r.Opportunity_Name__r.Order__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.Invoice_Memo__c,Ownership__r.Platform_Level__c,
                                     Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.Customer__r.ContactId,Total_Manifest_Revision__c,Total_Change_Fee__c,
                                     (SELECT id,Ownership_Code__c,Ownership_Code__r.Membership_Level__c,Ownership_Code__r.Type,Product_Name__c,Status__c,Weight_to_Mileage_Fee__c,
                                      Pick_Pack_Fee__c,Total_QA_Change_fee__c,QA_Review_Fee__c,Weight_to_Order_Fee__c,Weight_to_Stage_Manifest_Fee__c,Weight_to_Schedule_Dispatch_Fee__c,Weight_to_Order_Booking_Fee__c,Line_Total_Price__c,
                                      Pack_Out_Fee__c,Quantity_Cases__c,Is_Sample__c,Product_Name__r.Parent_Product__c,Product_Name__r.Is_Sample__c,Qty_Ordered__c,Retail_Wholesale_Price__c FROM Sales_Order_Lines__r)
                                     from Sales_Order__c where id =: recordId];
            
            
            if(!isOBCreated && sOrder.Ownership__r.Service_Type__c == Account_Service_Type_Margin && sOrder.RecordType.Name == SO_RECORDTYPE_TRANSFER && (sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR)){
                List<Account_Setting__c> accSettingList = [SELECT id,Mthly_IB__c,Max_IB__c,Account__c,Mthly_OB__c,Max_OB__c FROM Account_Setting__c WHERE Account__c = :sOrder.Ownership__c AND Active__c = true];
                if(accSettingList.size() > 0 && accSettingList[0].Mthly_OB__c <= accSettingList[0].Max_OB__c){
                    /*String errStr = Fulfillment_Invoice_Not_Create.replace('{0}',''+ accSettingList[0].Mthly_OB__c );
                    errStr = errStr.replace('{1}',''+ accSettingList[0].Max_OB__c );*/
                    r.data.put('ErrorMsg', Fulfillment_Invoice_Not_Create);
                    r.data.put('isOBCreated', true);
                    return r;
                }
            }
            
            Set<String> membershipLevel = new Set<String>();
            Map<String,List<Sales_Order_Line__c>> ownerShipCodeSOLIMap = new Map<String,List<Sales_Order_Line__c>>();
            if(sOrder.Order_Type__c == SO_ORDER_TYPE_BRAND){
                if(sOrder.Sales_Order_Lines__r.size() > 0){
                    
                    for(Sales_Order_Line__c soli  : sOrder.Sales_Order_Lines__r){
                        if(ownerShipCodeSOLIMap.containsKey(soli.Ownership_Code__c)){
                            ownerShipCodeSOLIMap.get(soli.Ownership_Code__c).add(soli);
                        }else{
                            ownerShipCodeSOLIMap.put(soli.Ownership_Code__c, new List<Sales_Order_Line__c>{soli});
                        }
                         membershipLevel.add(soli.Ownership_Code__r.Membership_Level__c);
                    }
                }
               
            }else{
                membershipLevel.add(sOrder.Receiver_Name__r.Membership_Level__c); 
            }
            List<Shipping_Rates_Table__c> mileageSRTList = new List<Shipping_Rates_Table__c>();
            List<Shipping_Rates_Table__c> weightSRTList = new List<Shipping_Rates_Table__c>();
            
            Map<String,List<Shipping_Rates_Table__c>> mileageSRTMap = new Map<String,List<Shipping_Rates_Table__c>>();
            Map<String,List<Shipping_Rates_Table__c>> weightSRTMap = new Map<String,List<Shipping_Rates_Table__c>>();
            if(sOrder.Brand_Quote__r.Opportunity_Name__r.Order__c != null){
                mileageSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, 
                                                         Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Membership_Level__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c
                                                         FROM Shipping_Rates_Table__c 
                                                         WHERE Site__c =: sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c
                                                         AND Active__c = true
                                                         AND Rate_Effective_From__c <= :System.today()
                                                         AND Rate_Effective_To__c >= :System.today()
                                                         AND Membership_Level__c IN :membershipLevel
                                                         Order By Mileage_Bracket__c];
                if(mileageSRTList.size() > 0 ){
                    for(Shipping_Rates_Table__c srt : mileageSRTList){
                        if(mileageSRTMap.containsKey(srt.Membership_Level__c)){
                            mileageSRTMap.get(srt.Membership_Level__c).add(srt);
                        }else{
                            mileageSRTMap.put(srt.Membership_Level__c,new List<Shipping_Rates_Table__c>{srt});
                        }
                    }
                }
                
             weightSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, 
                                                        Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Membership_Level__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c
                                                        FROM Shipping_Rates_Table__c 
                                                        WHERE Site__c =: sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c
                                                        AND Active__c = true
                                                        AND Rate_Effective_From__c <= :System.today()
                                                        AND Rate_Effective_To__c >= :System.today()
                                                        AND Membership_Level__c IN :membershipLevel
                                                        Order By Weight_Bracket__c];
                if(weightSRTList.size() > 0 ){
                    for(Shipping_Rates_Table__c srt : weightSRTList){
                        if(weightSRTMap.containsKey(srt.Membership_Level__c)){
                            weightSRTMap.get(srt.Membership_Level__c).add(srt);
                        }else{
                            weightSRTMap.put(srt.Membership_Level__c,new List<Shipping_Rates_Table__c>{srt});
                        }
                    }
                }
            }
            List<Sales_Order_Line__c> lstSOLine = [SELECT Id,Name,(SELECT Id,Name,Aged_Bucket__c,Days_in_Inventory__c,Total_Product_Volume__c
                                                                   FROM Inventory_Positions__r)
                                                   FROM Sales_Order_Line__c WHERE Sales_Order__c =: sOrder.Id];
            Map<Id,Sales_Order_Line__c> SOLIMap = new Map<Id,Sales_Order_Line__c>(lstSOLine);
            List<Inventory_Storage_Config__mdt> iStorage = [SELECT Id,MasterLabel,DeveloperName,Charge__c,Lower_Limit__c,Upper_Limit__c FROM Inventory_Storage_Config__mdt];
            Company_Custom_Settings__c companySettingRec = Company_Custom_Settings__c.getOrgDefaults();
            List<Service_Ticket__c> serviceTicketList = [SELECT Id,Licensed_Premise__c,Brand_Contact__c,Brand_Name__c,
                                                                         Brand_Contact__r.AccountId,Licensed_Premise__r.License_Name__c from Service_Ticket__c where Opportunity__c =: 
                                                                         sOrder.Brand_Quote__r.Opportunity_Name__c Limit 1];
            List<Product2>productList = [SeLECT Id FROM Product2 WHERE Name =: Label_Not_For_Resale_Product Limit 1];
            List<Line_Card__c> LCList = [SELECT id,Minimum_Service_Fee__c FROM Line_Card__c WHERE Retailer_Name__c =: sOrder.Receiver_Name__c AND Brand_Name__c =: sOrder.Supplier_Name__c LIMIT 1];
            Boolean isSTLAndOrderNull = false;
            Map<String,Invoice__c> newInvMap = new Map<String,Invoice__c>(); 
            Map<String,List<Invoice_Line__c>> newInvoiceLinesMap = new Map<String,List<Invoice_Line__c>>();
            List<Invoice_Line__c> invoiceLines = new List<Invoice_Line__c>();
            if(sOrder.Order_Type__c == SO_ORDER_TYPE_BRAND){
               	Map<Id,Account> ownerShipMap = new Map<Id,Account>([SELECT Id, Name, Type,Service_Type__c,(SELECT License_Name__c,id,RecordType.Name FROM State_Licenses__r WHERE RecordType.Name IN (:STATE_LICENSE_NONCANNABIS_RECORDTYPE,:STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE) AND License_Status__c = : STATE_LICENSE_ACTIVE ORDER BY CreatedDate ASC),(SELECT AccountId,Id FROM Contacts WHERE Active__c = true ORDER BY CreatedDate ASC) FROM Account WHERE Id IN:ownerShipCodeSOLIMap.keySet()]);//,(SELECT id,Minimum_Service_Fee__c FROM Line_Cards__r WHERE Retailer_Name__c =: sOrder.Receiver_Name__c )
                for(String ownershipId : ownerShipCodeSOLIMap.keySet()){
                    List<Sales_Order_Line__c> SOLIs = ownerShipCodeSOLIMap.get(ownershipId);
                    if(SOLIs != NULL && SOLIs.size() > 0){
                        String mLevel = SOLIs[0].Ownership_Code__r.Membership_Level__c;
                        Invoice__c newInvoice = new Invoice__c();
                        invoiceLines = new List<Invoice_Line__c>();
                        newInvoice.Sales_Order__c = recordId;
                        newInvoice.AR_Status__c = Invoice_Ar_Status_Approved;
                        newInvoice.Opportunity_Name__c = sOrder.Opportunity_Name__c;
                        //newInvoice.Invoice_Memo__c = sOrder.Sales_Order_Instructions__c;
                        newInvoice.Invoice_Memo__c = sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Invoice_Memo__c;
                        if(sOrder.Order_Type__c == SO_ORDER_TYPE_BRAND){
                            newInvoice.Distributor_Name__c = sOrder.Brand_Quote__r.Distributor_Name__c;
                            newInvoice.Distributor_License__c = sOrder.Brand_Quote__r.Distributor_License__c;
                            newInvoice.Distributor_Contact__c = sOrder.Brand_Quote__r.Distributor_Contact__c;
                            newInvoice.Supplier_Name__c = sOrder.Brand_Quote__r.Distributor_Name__c;
                            newInvoice.Supplier_License__c = sOrder.Brand_Quote__r.Distributor_License__c;
                            newInvoice.Supplier_Contact__c = sOrder.Brand_Quote__r.Distributor_Contact__c;
                            
                        }
                        newInvoice.Ownership__c = companySettingRec.Default_Distributor__c;
                        if(SOLIs[0].Ownership_Code__r.Type == ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER){
                            newInvoice.Receiver_Name__c = SOLIs[0].Ownership_Code__c;
                            List<State_Licenses__c> statelicenses = ownerShipMap.get(SOLIs[0].Ownership_Code__c).State_Licenses__r;
                            List<Contact> distributorContacts = ownerShipMap.get(SOLIs[0].Ownership_Code__c).Contacts;
                            if(statelicenses != NULL && statelicenses.size() > 0){
                                for(State_Licenses__c sl : statelicenses){
                                    if(sl.RecordType.Name == STATE_LICENSE_NONCANNABIS_RECORDTYPE){
                                        newInvoice.Receiver_License__c = sl.id;
                                        break;
                                    }
                                }
                                    
                                
                            }
                            if(distributorContacts != NULL && distributorContacts.size() > 0){
                                newInvoice.Receiver_Contact__c = distributorContacts[0].id;
                            }
                        }else{
                            
                            if(sOrder.Brand_Quote__r.Opportunity_Name__r.Order__c == null && serviceTicketList.size() == 0){
                                isSTLAndOrderNull = true;
                                newInvoice.Receiver_Name__c = sOrder.Receiver_Name__c;
                                newInvoice.Receiver_License__c = sOrder.Receiver_License__c;
                                newInvoice.Receiver_Contact__c = sOrder.Receiver_Contact__c;
                            }else{
                                newInvoice.Receiver_Name__c = SOLIs[0].Ownership_Code__c;
                                List<State_Licenses__c> statelicenses = ownerShipMap.get(SOLIs[0].Ownership_Code__c).State_Licenses__r;
                                List<Contact> distributorContacts = ownerShipMap.get(SOLIs[0].Ownership_Code__c).Contacts;
                                if(statelicenses != NULL && statelicenses.size() > 0){
                                   for(State_Licenses__c sl : statelicenses){
                                    if(sl.RecordType.Name == STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE){
                                        newInvoice.Receiver_License__c = sl.id;
                                        break;
                                    }
                                }
                                }
                                if(distributorContacts != NULL && distributorContacts.size() > 0){
                                    newInvoice.Receiver_Contact__c = distributorContacts[0].id;
                                }
                                
                            }
                        }
                        
                        newInvoice.Site__c = sOrder.Site__c;
                        newInvoice.Shipped_Date__c = sOrder.Planned_Ship_Date__c;
                        newInvoice.Sample_Order__c = sOrder.Sample_Order__c;
                        newInvoice.AR_Type__c = sOrder.SO_Type__c;
                        newInvoice.Customer_PO_or_Quote__c = sOrder.Customer_PO_or_Quote__c;
                        newInvoice.Brand_Quote__c = sOrder.Brand_Quote__c;
                        newInvoice.Shipping_Terms__c = sOrder.Shipping_Terms__c;
                        newInvoice.Shipping_Method__c = sOrder.Shipping_Method__c;
                        if(sOrder.Supplier_Name__r.Payment_Terms__c !=null){
                            newInvoice.Payment_Terms__c =sOrder.Supplier_Name__r.Payment_Terms__c;   
                        }else{
                            newInvoice.Payment_Terms__c =PAYMENT_TERMS_COD; 
                        }
                        
                        newInvoice.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_SERVICE).getRecordTypeId();
                        newInvoice.Invoice_Due_Date__c = InvoiceSupport.calculateInvoiceDueDate(sOrder.Ship_Confirmation_Date__c,sOrder.Planned_Ship_Date__c,
                                                                                                newInvoice.Payment_Terms__c);
                        
                        
                        
                        if(sOrder.Site__r.Name.equals(SITE_NAME_7027)){
                            newInvoice.Distributor_Name__c = companySettingRec.Second_Warehouse_Id__c;
                            newInvoice.Distributor_License__c = companySettingRec.Second_Warehouse_License__c;
                        }
                        
                        if(sOrder.Site__r.Name.equals(SITE_NAME_2089)){
                            newInvoice.Distributor_Name__c = companySettingRec.Default_Distributor__c;
                            newInvoice.Distributor_License__c = companySettingRec.Default_License__c;
                        }
                        newInvoice.Supplier_Name__c = companySettingRec.Default_Distributor__c;
                        newInvoice.Supplier_License__c = companySettingRec.Default_License__c;
                        
                        Decimal totalStorageFee = 0;
                        Decimal mileageFee = 0;
                        Decimal packOutFee = 0;
                        Decimal pickAndPackFee = 0;
                        Decimal weightFee = 0;
                        decimal qAReviewFee =0;
                        Decimal totalChangeFee = 0;
                        Decimal orderBookingFee = 0;
                         Decimal ScheduleDispatchFee = 0;
                         Decimal StageManifestFee = 0;
                        
                        Boolean isFixedMileage = false;
                        Boolean isFixedWeight = false;
                        //calculate Total Mileage Fee
                           /* if(!mileageSRTMap.values().isEmpty() && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c != null){
                                for(Shipping_Rates_Table__c SRT: mileageSRTMap.get(mLevel)){
                                    if(sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c <= SRT.Mileage_Bracket__c && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c == SRT.Site__c  && mLevel == SRT.Membership_Level__c){
                                        if(SRT.Fixed_Mileage_Fee__c){
                                            isFixedMileage = true;
                                            mileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                                        }else{
                                            mileageFee = SRT.Mileage_Bracket_Price__c;
                                        }
                                        break;
                                    }
                                }
                                if(sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER && sOrder.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE ){
                                    mileageFee = 0;
                                }
                                
                            }*/
                        packOutFee = (sOrder.Pack_Out_Fee__c != null ? sOrder.Pack_Out_Fee__c : 0 );
                        system.debug('##SOLIs : '+SOLIs);
                        decimal lineTotalPrice = 0;
                        for(Sales_Order_Line__c soli : SOLIs){
                            ScheduleDispatchFee += (soli.Weight_to_Schedule_Dispatch_Fee__c != null ? soli.Weight_to_Schedule_Dispatch_Fee__c : 0 );
                                StageManifestFee += (soli.Weight_to_Stage_Manifest_Fee__c != null ? soli.Weight_to_Stage_Manifest_Fee__c : 0 );
                            //packOutFee += (soli.Pack_Out_Fee__c != null ? soli.Pack_Out_Fee__c : 0 );
                            pickAndPackFee += (soli.Pick_Pack_Fee__c != null ? soli.Pick_Pack_Fee__c : 0 );
                            totalChangeFee += (soli.Total_QA_Change_fee__c != null ? soli.Total_QA_Change_fee__c : 0 );
                            lineTotalPrice += soli.Line_Total_Price__c;
                            //calculate QA Review Fee
                            qAReviewFee += (soli.QA_Review_Fee__c != null ? soli.QA_Review_Fee__c : 0 );
                            orderBookingFee += (soli.Weight_to_Order_Booking_Fee__c != null ? soli.Weight_to_Order_Booking_Fee__c : 0 );
                            //calculate Total Weight Fee
                            weightFee += (soli.Weight_to_Order_Fee__c != null ? soli.Weight_to_Order_Fee__c : 0 );
                            mileageFee += (soli.Weight_to_Mileage_Fee__c != null ? soli.Weight_to_Mileage_Fee__c : 0 );
                            /*if(sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER && sOrder.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE && (sOrder.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == Account_Plateformlevel_ZASP || sOrder.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == Account_Plateformlevel_IRR) ){
                                mileageFee = 0;
                                weightFee =0;
                                qAReviewFee =0;
                            }  */
                                for(Inventory_Position__c ip : SOLIMap.get(soli.id).Inventory_Positions__r){
                                    for(Inventory_Storage_Config__mdt mdt : iStorage){
                                        if(ip.Days_in_Inventory__c >= mdt.Lower_Limit__c && ip.Days_in_Inventory__c <= mdt.Upper_Limit__c){
                                            if(ip.Total_Product_Volume__c != null && mdt.Charge__c != null){
                                                totalStorageFee = totalStorageFee + (ip.Total_Product_Volume__c * mdt.Charge__c);
                                            }
                                        } else if(ip.Days_in_Inventory__c >= mdt.Lower_Limit__c && mdt.Upper_Limit__c == null){
                                            if(ip.Total_Product_Volume__c != null && mdt.Charge__c != null){
                                                totalStorageFee = totalStorageFee + (ip.Total_Product_Volume__c * mdt.Charge__c);
                                            }
                                        }
                                    }
                                }
                        }
                        Decimal distributionServiceFee = 0;
                        Boolean isDistributionService = false;
                        if(sOrder.Supplier_Name__r.Service_Type__c == Account_Service_Type_Margin || sOrder.Supplier_Name__r.Service_Type__c == Account_Service_Type_Buy_Sell  ){
                            isDistributionService = true;
                            distributionServiceFee = sOrder.Supplier_Name__r.Distribution_Fee__c / 100 * lineTotalPrice;
                            
                            Decimal msFee = 0;
                            if(LCList.size() > 0)msFee = LCList[0].Minimum_Service_Fee__c != null ? LCList[0].Minimum_Service_Fee__c : 0;
                            if(distributionServiceFee > msFee){
                                distributionServiceFee =  distributionServiceFee;
                            }else{
                                distributionServiceFee = msFee;
                            }
                        }
                        
                        Boolean createWMLines = true;
                        
                        if(sOrder.Shipping_Method__c != NULL && sOrder.Shipping_Method__c.contains(SO_SHIPPING_METHOD_PICK_UP)){
                            //createWMLines = false;
                        }
                        //Service Type = Service
                        if(!isDistributionService){
                            if(totalStorageFee > 0 && productsMap.containsKey(PRODUCT_NAME_INVENTORY_STORAGE)){
                                invoiceLines = validateProductFee(PRODUCT_NAME_INVENTORY_STORAGE,1,totalStorageFee,productsMap,invoiceLines);
                            }
                            
                            if(createWMLines && weightFee > 0 && productsMap.containsKey(PRODUCT_NAME_WEIGHT_FEE)){
                                Decimal qty= sOrder.Total_Manifest_Revision__c != null ? (sOrder.Total_Manifest_Revision__c + 1) :1;
                                invoiceLines = validateProductFee(PRODUCT_NAME_WEIGHT_FEE,qty,weightFee,productsMap,invoiceLines);//(isFixedWeight?1:sOrder.Total_Weight_lbs__c)
                            }
                            if(!sOrder.Sample_Order__c && !isSTLAndOrderNull && createWMLines && mileageFee > 0 && productsMap.containsKey(PRODUCT_NAME_MILEAGE_FEE)){
                                Decimal FixedQty = sOrder.Total_Manifest_Revision__c != null ? (sOrder.Total_Manifest_Revision__c + 1) :1;
                                Decimal qty= sOrder.Total_Manifest_Revision__c != null ? (sOrder.Total_Manifest_Revision__c + 1) * sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c : sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c;
                                //(isFixedMileage?FixedQty:qty)
                                invoiceLines = validateProductFee(PRODUCT_NAME_MILEAGE_FEE,FixedQty,mileageFee,productsMap,invoiceLines);
                            }
                            if(StageManifestFee > 0 && productsMap.containsKey(PRODUCT_NAME_STAGE_AND_MANIFEST)){
                                Decimal qty= sOrder.Total_Manifest_Revision__c != null ? (sOrder.Total_Manifest_Revision__c + 1) :1;
                                invoiceLines = validateProductFee(PRODUCT_NAME_STAGE_AND_MANIFEST,qty,StageManifestFee,productsMap,invoiceLines);
                            }
                            if(ScheduleDispatchFee > 0 && productsMap.containsKey(PRODUCT_NAME_SCHEDULE_AND_DISPATCH)){
                                Decimal qty= sOrder.Total_Manifest_Revision__c != null ? (sOrder.Total_Manifest_Revision__c + 1) :1;
                                invoiceLines = validateProductFee(PRODUCT_NAME_SCHEDULE_AND_DISPATCH,qty,ScheduleDispatchFee,productsMap,invoiceLines);
                            }
                            if(packOutFee > 0 && productsMap.containsKey(PRODUCT_NAME_PACK_OUT)){
                                invoiceLines = validateProductFee(PRODUCT_NAME_PACK_OUT,1,packOutFee,productsMap,invoiceLines);
                            }
                            if(orderBookingFee > 0 && productsMap.containsKey(PRODUCT_NAME_ORDER_BOOKING)){
                                invoiceLines = validateProductFee(PRODUCT_NAME_ORDER_BOOKING,1,orderBookingFee,productsMap,invoiceLines);
                            }
                            if(pickAndPackFee > 0 && productsMap.containsKey(PRODUCT_NAME_PICK_AND_PACK_FEE)){
                                invoiceLines = validateProductFee(PRODUCT_NAME_PICK_AND_PACK_FEE,1,pickAndPackFee,productsMap,invoiceLines);
                            }
                            if(qAReviewFee > 0 && productsMap.containsKey(PRODUCT_NAME_QA_REVIEW_FEE)){
                                invoiceLines = validateProductFee(PRODUCT_NAME_QA_REVIEW_FEE,1,qAReviewFee,productsMap,invoiceLines);
                            }
                            if(totalChangeFee > 0 && productsMap.containsKey(PRODUCT_NAME_CHANGE_ORDER_FEE)){
                                invoiceLines = validateProductFee(PRODUCT_NAME_CHANGE_ORDER_FEE,1,totalChangeFee,productsMap,invoiceLines);
                            }
                            if(sOrder.Change_Order_Fee__c == TRUE && productsMap.containsKey(PRODUCT_NAME_CHANGE_ORDER_FEE)){
                                Product2 p = productsMap.get(PRODUCT_NAME_CHANGE_ORDER_FEE);
                                PriceBookEntry pbe = productPBEMap.get(p.Id);
                                if(pbe != NULL){
                                    invoiceLines = validateProductFee(PRODUCT_NAME_CHANGE_ORDER_FEE,1,pbe.UnitPrice,productsMap,invoiceLines);
                                }
                            }
                        }
                        /*if( sOrder.Total_Manifest_Revision__c > 0 && productsMap.containsKey(Delivery_Rescheduling_Fee_Config) && sOrder.Supplier_Name__r.Service_Type__c == 'Margin'){
                            Decimal deliveryReschedulingFee = 150;
                            invoiceLines = validateProductFee(Delivery_Rescheduling_Fee_Config,sOrder.Total_Manifest_Revision__c ,deliveryReschedulingFee,productsMap,invoiceLines);
                        }*/
                        //Service Type = Margin
                        if(sOrder.Supplier_Name__r.Service_Type__c == Account_Service_Type_Service && sOrder.Total_Manifest_Change_Fee__c > 0){
                            invoiceLines = validateProductFee(Product_Name_Manifest_Change_Fee,1,sOrder.Total_Manifest_Change_Fee__c,productsMap,invoiceLines);
                        }
                        if(isDistributionService && productsMap.containsKey(PRODUCT_NAME_DISTRIBUTION_FEE) && distributionServiceFee > 0){
                            invoiceLines = validateProductFee(PRODUCT_NAME_DISTRIBUTION_FEE,1,distributionServiceFee,productsMap,invoiceLines);
                        }
                        if(isSTLAndOrderNull){
                            for(Sales_Order_Line__c sol : SOLIs){
                                Invoice_Line__c invLineItem = new Invoice_Line__c();
                                invLineItem.Product_Name__c = sol.Product_Name__c;
                                invLineItem.Invoice_Qty__c = sol.Qty_Ordered__c;
                                invLineItem.Sales_Order_Line__c = sol.Id;
                                invLineItem.InvoiceLine_Status__c = sol.Status__c != 'open' ? sol.Status__c : 'Draft';
                                invLineItem.Retail_Wholesale_Price__c = sol.Retail_Wholesale_Price__c;//qty * Decimal.valueof(Sample_Product_Price);
                                invLineItem.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get(INVOICE_LINE_RECORDTYPE_SERVICE).getRecordTypeId();	    
                                invoiceLines.add(invLineItem);
                            }
                        }
                        //list<Sales_Order_Line__c>soLineList = [SELECt Id,Quantity_Cases__c FROM Sales_Order_Line__c WHERE Sales_Order__c =: recordId AND Is_Sample__c = true AND Product_Name__r.Parent_Product__c = null AND Product_Name__r.Is_Sample__c = false];
                    
                        Decimal qty = 0;
                        Boolean isSample = false;
                        for(Sales_Order_Line__c sol : SOLIs){
                            if(sol.Is_Sample__c == true && sol.Product_Name__r.Parent_Product__c == null && sol.Product_Name__r.Is_Sample__c == false){
                        		qty += sol.Quantity_Cases__c;
                                isSample= true;
                            }
                        }
                        if(isSample){
                            Invoice_Line__c invLineItem = new Invoice_Line__c();
                            invLineItem.Product_Name__c = productList.size() > 0 ? productList[0].Id : NULL;
                            invLineItem.Invoice_Qty__c = qty;
                            invLineItem.Retail_Wholesale_Price__c = companySettingRec.Retail_Wholesale_Price__c;//qty * Decimal.valueof(Sample_Product_Price);
                            invLineItem.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get(INVOICE_LINE_RECORDTYPE_SERVICE).getRecordTypeId();	    
                            
                            invoiceLines.add(invLineItem);
                        }
                    	system.debug('##ownershipId : '+ownershipId);
                        system.debug('##invoiceLines : '+invoiceLines.size());
                        newInvMap.put(ownershipId,newInvoice);
                    	newInvoiceLinesMap.put(ownershipId,invoiceLines);
                    }
                    
                }
            }else{
            /*
             * CODE TO use to create Invoices for Producers
             * Set<String> producerIds = producerSOLinesMap.keySet();
            List<Disty_Brand_Relationship__c> distyBrandRelationships = [SELECT Id, Brand__c,Brand__r.Distribution_Fee__c, Agent_Fee__c  FROM Disty_Brand_Relationship__c WHERE Agent_Fee__c != NULL AND Brand__c IN :producerIds AND Active__c = true AND Contact__c =: agentId];
            Map<Id,Disty_Brand_Relationship__c> brandAgentFeeMap = new Map<Id,Disty_Brand_Relationship__c>();
            if(distyBrandRelationships.size() > 0){
                for(Disty_Brand_Relationship__c DBR: distyBrandRelationships){
                    brandAgentFeeMap.put(DBR.Brand__c, DBR);
                }
            }
            Decimal agentFee = 0;
            Decimal distributionFee = 0;
            if(distyTypes.indexOf(sOrder.Ownership__r.Type) != -1){
                if(totalSOAmount > 0 && brandAgentFeeMap.containsKey(producerId)){
                    Disty_Brand_Relationship__c DBR = brandAgentFeeMap.get(producerId);
                    if(DBR != NULL){
                        AgentFee = totalSOAmount * (DBR.Agent_Fee__c/100);
                        if(DBR.Brand__r.Distribution_Fee__c != NULL){
                            distributionFee = totalSOAmount * (DBR.Brand__r.Distribution_Fee__c/100);
                        }
                    }
                    
                }
            }*/
            
            Invoice__c newInvoice = new Invoice__c();
            newInvoice.Sales_Order__c = recordId;
            newInvoice.AR_Status__c = Invoice_Ar_Status_Approved;
            newInvoice.Opportunity_Name__c = sOrder.Opportunity_Name__c;
            //newInvoice.Invoice_Memo__c = sOrder.Sales_Order_Instructions__c;
            newInvoice.Invoice_Memo__c = sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Invoice_Memo__c;
            /*if(sOrder.Order_Type__c == SO_ORDER_TYPE_BRAND){
                newInvoice.Distributor_Name__c = sOrder.Brand_Quote__r.Distributor_Name__c;
                newInvoice.Distributor_License__c = sOrder.Brand_Quote__r.Distributor_License__c;
                newInvoice.Distributor_Contact__c = sOrder.Brand_Quote__r.Distributor_Contact__c;
                newInvoice.Supplier_Name__c = sOrder.Brand_Quote__r.Distributor_Name__c;
                newInvoice.Supplier_License__c = sOrder.Brand_Quote__r.Distributor_License__c;
                newInvoice.Supplier_Contact__c = sOrder.Brand_Quote__r.Distributor_Contact__c;
                
            }else{*/
                newInvoice.Distributor_Name__c = sOrder.Distributor_Name__c;
                newInvoice.Distributor_License__c = sOrder.Distributor_License__c;
                newInvoice.Distributor_Contact__c = sOrder.Distributor_Contact__c;
                newInvoice.Supplier_Name__c = sOrder.Supplier_Name__c;
                newInvoice.Supplier_License__c = sOrder.Supplier_License__c;
                newInvoice.Supplier_Contact__c = sOrder.Supplier_Contact__c;
            //}
            
            if(sOrder.Ownership__r.Type == ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER){
                newInvoice.Ownership__c = companySettingRec.Default_Distributor__c;
                
            }else{
                newInvoice.Ownership__c = companySettingRec.Default_Distributor__c;//sOrder.Ownership__c;
            }
            Account invoiceOwnership = [SELECT Id, Type FROM Account WHERE Id =:newInvoice.Ownership__c];
            
            
            if(sOrder.Ownership__r.Type == ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER){
                newInvoice.Receiver_Name__c = sOrder.Ownership__c;
                List<State_Licenses__c> statelicenses = new List<State_Licenses__c>();
                List<Contact> distributorContacts =new List<Contact>();
                for(State_Licenses__c st :[SELECT License_Name__c,id,RecordType.Name FROM State_Licenses__c WHERE License_Name__c =: sOrder.Ownership__c AND RecordType.Name =: STATE_LICENSE_NONCANNABIS_RECORDTYPE AND License_Status__c = : STATE_LICENSE_ACTIVE ORDER BY CreatedDate ASC]){
                    statelicenses.add(st);
                }
                for(Contact con :[SELECT AccountId,Id FROM Contact WHERE AccountId =: sOrder.Ownership__c AND Active__c = true ORDER BY CreatedDate ASC]){
                    distributorContacts.add(con);
                }
                newInvoice.Receiver_License__c = statelicenses[0].id;
                newInvoice.Receiver_Contact__c = distributorContacts[0].id;
                
            }else{
                /*List<Service_Ticket__c> serviceTicketList = [SELECT Id,Licensed_Premise__c,Brand_Contact__c,Brand_Name__c,
                                                             Brand_Contact__r.AccountId,Licensed_Premise__r.License_Name__c from Service_Ticket__c where Opportunity__c =: 
                                                             sOrder.Brand_Quote__r.Opportunity_Name__c Limit 1];*/
                if(sOrder.Brand_Quote__r.Opportunity_Name__r.Order__c == null && serviceTicketList.size() == 0){
                    isSTLAndOrderNull = true;
                    newInvoice.Receiver_Name__c = sOrder.Receiver_Name__c;
                    newInvoice.Receiver_License__c = sOrder.Receiver_License__c;
                    newInvoice.Receiver_Contact__c = sOrder.Receiver_Contact__c;
                }else{
                    /*newInvoice.Receiver_Name__c = sOrder.Supplier_Name__c;
                    newInvoice.Receiver_License__c = sOrder.Supplier_License__c;
                    newInvoice.Receiver_Contact__c = sOrder.Supplier_Contact__c;*/
                    newInvoice.Receiver_Name__c = sOrder.Ownership__c;
                    List<State_Licenses__c> statelicenses = new List<State_Licenses__c>();
                    List<Contact> distributorContacts =new List<Contact>();
                    for(State_Licenses__c st :[SELECT License_Name__c,id,RecordType.Name FROM State_Licenses__c WHERE License_Name__c =: sOrder.Ownership__c AND RecordType.Name =: STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE AND License_Status__c = : STATE_LICENSE_ACTIVE ORDER BY CreatedDate ASC]){
                        statelicenses.add(st);
                    }
                    for(Contact con :[SELECT AccountId,Id FROM Contact WHERE AccountId =: sOrder.Ownership__c AND Active__c = true ORDER BY CreatedDate ASC]){
                        distributorContacts.add(con);
                    }
                    newInvoice.Receiver_License__c = statelicenses[0].id;
                    newInvoice.Receiver_Contact__c = distributorContacts[0].id;
                    
                }
            }
            
            
            newInvoice.Site__c = sOrder.Site__c;
            newInvoice.Shipped_Date__c = sOrder.Planned_Ship_Date__c;
            newInvoice.Sample_Order__c = sOrder.Sample_Order__c;
            newInvoice.AR_Type__c = sOrder.SO_Type__c;
            newInvoice.Customer_PO_or_Quote__c = sOrder.Customer_PO_or_Quote__c;
            newInvoice.Brand_Quote__c = sOrder.Brand_Quote__c;
            newInvoice.Shipping_Terms__c = sOrder.Shipping_Terms__c;
            newInvoice.Shipping_Method__c = sOrder.Shipping_Method__c;
                
          
			if(sOrder.Supplier_Name__r.Payment_Terms__c !=null)
            {
               newInvoice.Payment_Terms__c =sOrder.Supplier_Name__r.Payment_Terms__c;   
            }else
            {
               newInvoice.Payment_Terms__c =PAYMENT_TERMS_COD; 
            }
            
            newInvoice.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_SERVICE).getRecordTypeId();
            newInvoice.Invoice_Due_Date__c = InvoiceSupport.calculateInvoiceDueDate(sOrder.Ship_Confirmation_Date__c,sOrder.Planned_Ship_Date__c,
                                                                                        newInvoice.Payment_Terms__c);
            
            
            
            if(sOrder.Site__r.Name.equals(SITE_NAME_7027)){
               // newInvoice.Receiver_Name__c = companySettingRec.Default_Distributor__c;
               // newInvoice.Receiver_License__c = companySettingRec.Default_License__c;
                
                newInvoice.Distributor_Name__c = companySettingRec.Second_Warehouse_Id__c;
                newInvoice.Distributor_License__c = companySettingRec.Second_Warehouse_License__c;
            }
            
            if(sOrder.Site__r.Name.equals(SITE_NAME_2089)){
                newInvoice.Distributor_Name__c = companySettingRec.Default_Distributor__c;
                newInvoice.Distributor_License__c = companySettingRec.Default_License__c;
            }
            
            newInvoice.Supplier_Name__c = companySettingRec.Default_Distributor__c;
            newInvoice.Supplier_License__c = companySettingRec.Default_License__c;
            
            Decimal totalStorageFee = 0;
            Decimal mileageFee = 0;
            Decimal weightFee = 0;
            decimal qAReviewFee =0;
            Boolean isFixedMileage = false;
            Boolean isFixedWeight = false;
            //calculate Total Mileage Fee
            if(!mileageSRTMap.values().isEmpty() && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c != null){
                for(Shipping_Rates_Table__c SRT: mileageSRTMap.get(sOrder.Receiver_Name__r.Membership_Level__c)){
                    if(sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c <= SRT.Mileage_Bracket__c && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c == SRT.Site__c  && sOrder.Supplier_Name__r.Membership_Level__c == SRT.Membership_Level__c){
                        if(SRT.Fixed_Mileage_Fee__c){
                            isFixedMileage = true;
                            mileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                        }else{
                            mileageFee = SRT.Mileage_Bracket_Price__c * sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c;
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
            
            
            /*if(sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER && sOrder.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE && (sOrder.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == Account_Plateformlevel_ZASP || sOrder.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == Account_Plateformlevel_IRR) ){
                mileageFee = 0;
                weightFee =0;
                qAReviewFee =0;
            }*/
            for(Sales_Order_Line__c soLine : lstSOLine){   
                for(Inventory_Position__c ip : soLine.Inventory_Positions__r){
                    for(Inventory_Storage_Config__mdt mdt : iStorage){
                        if(ip.Days_in_Inventory__c >= mdt.Lower_Limit__c && ip.Days_in_Inventory__c <= mdt.Upper_Limit__c){
                            if(ip.Total_Product_Volume__c != null && mdt.Charge__c != null){
                                totalStorageFee = totalStorageFee + (ip.Total_Product_Volume__c * mdt.Charge__c);
                            }
                        } else if(ip.Days_in_Inventory__c >= mdt.Lower_Limit__c && mdt.Upper_Limit__c == null){
                            if(ip.Total_Product_Volume__c != null && mdt.Charge__c != null){
                            	totalStorageFee = totalStorageFee + (ip.Total_Product_Volume__c * mdt.Charge__c);
                            }
                        }
                    }
                }
            }
            
                boolean skipFees = false;
                
                 boolean skipFeesForBasic = false;
                
               if(sOrder.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE  &&
                   ((sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR)
                    || (sOrder.Supplier_Name__r.DBA__c == Account_Plateformlevel_ZASP || sOrder.Supplier_Name__r.DBA__c == Account_Plateformlevel_IRR)) 
                   && (sOrder.Order_Type__c == ORDER_TYPE_TRANSFER || String.isBlank(sOrder.Brand_Quote__r.Order_Type__c))
                  ){
                    skipFees = true;
                }
                if(
                    ((sOrder.Supplier_Name__r.DBA__c != Account_Plateformlevel_ZASP && sOrder.Supplier_Name__r.DBA__c != Account_Plateformlevel_IRR) 
                     || (sOrder.Receiver_Name__r.DBA__c != Account_Plateformlevel_ZASP && sOrder.Receiver_Name__r.DBA__c != Account_Plateformlevel_IRR)) 
                    && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__c != null  && (sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_ZASP 
                        && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_IRR) 
                    && sOrder.Order_Type__c == ORDER_TYPE_TRANSFER){
                    skipFees = true;
                }    
            if((sOrder.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_BASIC || sOrder.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE)  && ((sOrder.Order_Type__c == ORDER_TYPE_TRANSFER && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Sample_Order__c == false ) || String.isBlank(sOrder.Brand_Quote__r.Order_Type__c)) && ((sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR) || (sOrder.Supplier_Name__r.DBA__c == Account_Plateformlevel_ZASP || sOrder.Supplier_Name__r.DBA__c == Account_Plateformlevel_IRR))){// && (sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_ZASP && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_IRR)
                
                skipFeesForBasic = true;
            }
                   boolean isPiggybackSample = false;
                 if(sOrder.Piggyback_sample__c == true && sOrder.Order_Type__c == ORDER_TYPE_TRANSFER){
                       isPiggybackSample  = true;
                    }
            invoiceLines = new List<Invoice_Line__c>();
                
                Decimal distributionServiceFee = 0;
                        Boolean isDistributionService = false;
                        if(sOrder.Supplier_Name__r.Service_Type__c == Account_Service_Type_Margin || sOrder.Supplier_Name__r.Service_Type__c == Account_Service_Type_Buy_Sell  ){
                            isDistributionService = true;
                            distributionServiceFee = sOrder.Supplier_Name__r.Distribution_Fee__c / 100 * sOrder.Total_Price__c;
                            
                            Decimal msFee = 0;
                            if(LCList.size() > 0)msFee = LCList[0].Minimum_Service_Fee__c != null ? LCList[0].Minimum_Service_Fee__c : 0;
                            if(distributionServiceFee > msFee){
                                distributionServiceFee =  distributionServiceFee;
                            }else{
                                distributionServiceFee = msFee;
                            }
                        }
                
                
            Boolean createWMLines = true;
            
            if(sOrder.Shipping_Method__c != NULL && sOrder.Shipping_Method__c.contains(SO_SHIPPING_METHOD_PICK_UP)){
                createWMLines = false;
            }
                //Service Type = Service
                if(!isDistributionService){
                    if(totalStorageFee > 0 && productsMap.containsKey(PRODUCT_NAME_INVENTORY_STORAGE)){
                        invoiceLines = validateProductFee(PRODUCT_NAME_INVENTORY_STORAGE,1,totalStorageFee,productsMap,invoiceLines);
                    }
                    
                    if(!skipFees && createWMLines && sOrder.Total_Weight_Fee__c != null && sOrder.Total_Weight_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_WEIGHT_FEE)){
                        Decimal qty= sOrder.Total_Manifest_Revision__c != null ? (sOrder.Total_Manifest_Revision__c + 1) :1;
                        invoiceLines = validateProductFee(PRODUCT_NAME_WEIGHT_FEE,qty,weightFee,productsMap,invoiceLines);//(isFixedWeight?1:sOrder.Total_Weight_lbs__c)
                    }
                    if(!isPiggybackSample && !skipFees && !sOrder.Sample_Order__c && !isSTLAndOrderNull && createWMLines && sOrder.Total_Mileage_Fee__c != null && sOrder.Total_Mileage_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_MILEAGE_FEE)){
                        Decimal FixedQty = sOrder.Total_Manifest_Revision__c != null ? (sOrder.Total_Manifest_Revision__c + 1) :1;
                        Decimal qty= sOrder.Total_Manifest_Revision__c != null ? (sOrder.Total_Manifest_Revision__c + 1) * sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c : sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c;
                        invoiceLines = validateProductFee(PRODUCT_NAME_MILEAGE_FEE,(isFixedMileage?FixedQty:qty),mileageFee,productsMap,invoiceLines);
                    }
                    if(sOrder.Stage_Manifest_Fee__c != null && sOrder.Order_Type__c != Order_Record_Type_Name_Retailer && sOrder.Stage_Manifest_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_STAGE_AND_MANIFEST)){
                        Decimal qty= sOrder.Total_Manifest_Revision__c != null ? (sOrder.Total_Manifest_Revision__c + 1) :1;
                        invoiceLines = validateProductFee(PRODUCT_NAME_STAGE_AND_MANIFEST,qty,sOrder.Stage_Manifest_Fee__c,productsMap,invoiceLines);
                    }
                    if(sOrder.Schedule_Dispatch_Fee__c != null && sOrder.Order_Type__c != Order_Record_Type_Name_Retailer && sOrder.Schedule_Dispatch_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_SCHEDULE_AND_DISPATCH)){
                        Decimal qty= sOrder.Total_Manifest_Revision__c != null ? (sOrder.Total_Manifest_Revision__c + 1) :1;
                        invoiceLines = validateProductFee(PRODUCT_NAME_SCHEDULE_AND_DISPATCH,qty,sOrder.Schedule_Dispatch_Fee__c,productsMap,invoiceLines);
                    }
                    if(sOrder.Pack_Out_Fee__c != null && sOrder.Pack_Out_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_PACK_OUT)){
                        invoiceLines = validateProductFee(PRODUCT_NAME_PACK_OUT,1,sOrder.Pack_Out_Fee__c,productsMap,invoiceLines);
                    }
                    if(sOrder.Order_Booking_Fee__c != null && sOrder.Order_Booking_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_ORDER_BOOKING)){
                        invoiceLines = validateProductFee(PRODUCT_NAME_ORDER_BOOKING,1,sOrder.Order_Booking_Fee__c,productsMap,invoiceLines);
                    }
                    if(sOrder.Total_Pick_Pack_Fee__c != null && sOrder.Total_Pick_Pack_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_PICK_AND_PACK_FEE)){
                        invoiceLines = validateProductFee(PRODUCT_NAME_PICK_AND_PACK_FEE,1,sOrder.Total_Pick_Pack_Fee__c,productsMap,invoiceLines);
                    }
                    if( (sOrder.Piggyback_sample__c != true && sOrder.Order_Type__c == ORDER_TYPE_TRANSFER) && !skipFeesForBasic  && sOrder.Total_QA_Review_Fee__c != null && sOrder.Total_QA_Review_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_QA_REVIEW_FEE)){
                        invoiceLines = validateProductFee(PRODUCT_NAME_QA_REVIEW_FEE,1,qAReviewFee,productsMap,invoiceLines);
                    }
                    if(sOrder.Total_Change_Fee__c != null && sOrder.Total_Change_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_CHANGE_ORDER_FEE)){
                        invoiceLines = validateProductFee(PRODUCT_NAME_CHANGE_ORDER_FEE,1,sOrder.Total_Change_Fee__c,productsMap,invoiceLines);
                    }
                    if(sOrder.Change_Order_Fee__c == TRUE && productsMap.containsKey(PRODUCT_NAME_CHANGE_ORDER_FEE)){
                        Product2 p = productsMap.get(PRODUCT_NAME_CHANGE_ORDER_FEE);
                        PriceBookEntry pbe = productPBEMap.get(p.Id);
                        if(pbe != NULL){
                            invoiceLines = validateProductFee(PRODUCT_NAME_CHANGE_ORDER_FEE,1,pbe.UnitPrice,productsMap,invoiceLines);
                        }
                    }
                    //Listing Fee 
                    if( sOrder.Order_Type__c == Order_Record_Type_Name_Retailer  && sOrder.Listing_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_LISTING_FEE)){
                        invoiceLines = validateProductFee(PRODUCT_NAME_LISTING_FEE,1,sOrder.Listing_Fee__c,productsMap,invoiceLines);
                    }
                }
                //Service Type = Margin
                if(isDistributionService && productsMap.containsKey(PRODUCT_NAME_DISTRIBUTION_FEE) && distributionServiceFee > 0){
                    invoiceLines = validateProductFee(PRODUCT_NAME_DISTRIBUTION_FEE,1,distributionServiceFee,productsMap,invoiceLines);
                }
                if(sOrder.Supplier_Name__r.Service_Type__c == Account_Service_Type_Service && sOrder.Total_Manifest_Change_Fee__c > 0){
                    invoiceLines = validateProductFee(Product_Name_Manifest_Change_Fee,1,sOrder.Total_Manifest_Change_Fee__c,productsMap,invoiceLines);
                }
            if(isSTLAndOrderNull){
                list<Sales_Order_Line__c> soLineLst = [SELECt Id,Product_Name__c,Status__c,Quantity_Cases__c FROM Sales_Order_Line__c WHERE Sales_Order__c =: recordId];
                for(Sales_Order_Line__c sol : soLineLst){
                    Invoice_Line__c invLineItem = new Invoice_Line__c();
                    invLineItem.Product_Name__c = sol.Product_Name__c;
                    invLineItem.Invoice_Qty__c = sol.Qty_Ordered__c;
                    invLineItem.Sales_Order_Line__c = sol.Id;
                    invLineItem.InvoiceLine_Status__c = sol.Status__c != 'open' ? sol.Status__c : 'Draft';
                    invLineItem.Retail_Wholesale_Price__c = sol.Retail_Wholesale_Price__c;//qty * Decimal.valueof(Sample_Product_Price);
                    invLineItem.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get(INVOICE_LINE_RECORDTYPE_SERVICE).getRecordTypeId();	    
                    invoiceLines.add(invLineItem);
                }
            }
            list<Sales_Order_Line__c>soLineList = [SELECt Id,Quantity_Cases__c FROM Sales_Order_Line__c WHERE Sales_Order__c =: recordId AND Is_Sample__c = true AND Product_Name__r.Parent_Product__c = null AND Product_Name__r.Is_Sample__c = false];
            if(soLineList.size() > 0){
                Decimal qty = 0;
                for(Sales_Order_Line__c sol : soLineList){
                    qty += sol.Quantity_Cases__c;    
                }
                //List<Product2>productList = [SeLECT Id FROM Product2 WHERE Name =: Label_Not_For_Resale_Product Limit 1];
                Invoice_Line__c invLineItem = new Invoice_Line__c();
                invLineItem.Product_Name__c = productList.size() > 0 ? productList[0].Id : NULL;
                invLineItem.Invoice_Qty__c = qty;
                invLineItem.Retail_Wholesale_Price__c = companySettingRec.Retail_Wholesale_Price__c;//qty * Decimal.valueof(Sample_Product_Price);
                invLineItem.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get(INVOICE_LINE_RECORDTYPE_SERVICE).getRecordTypeId();	    
                
                invoiceLines.add(invLineItem);
            }
                    
            newInvMap.put(sOrder.Ownership__c,newInvoice);
            newInvoiceLinesMap.put(sOrder.Ownership__c,invoiceLines);
            }
            /*if(productsMap.containsKey(PRODUCT_NAME_AGENT_FEE) && agentFee > 0){
                invoiceLines = validateProductFee(PRODUCT_NAME_AGENT_FEE,1,agentFee,productsMap,invoiceLines);
            }
            if(productsMap.containsKey(PRODUCT_NAME_DISTRIBUTION_FEE) && distributionFee > 0){
                invoiceLines = validateProductFee(PRODUCT_NAME_DISTRIBUTION_FEE,1,distributionFee,productsMap,invoiceLines);
            }*/
            Savepoint sp;
            if(!Test.isRunningTest()){
                sp = Database.setSavepoint();   
            }
            try{
                /*if(!invoiceLines.isEmpty()){
                    insert newInvoice;
                    for(Invoice_Line__c line: invoiceLines){
                        line.Invoice__c = newInvoice.Id;
                    }*/
                if(!newInvoiceLinesMap.values().isEmpty()){
                    String invId='';
                    insert newInvMap.values();
                    List<Invoice_Line__c> newInvoiceLines = new List<Invoice_Line__c>();
                    for(String  oCode :newInvMap.keySet()){
                        Invoice__c inv = newInvMap.get(oCode);
                        invId = inv.Id;
                        system.debug('## newInvoiceMap : '+inv);
                        for(Invoice_Line__c line: newInvoiceLinesMap.get(oCode)){
                                line.Invoice__c = inv.Id;
                            newInvoiceLines.add(line);
                        }
                    }
                    /*list<Sales_Order_Line__c>soLineList = [SELECt Id,Quantity_Cases__c FROM Sales_Order_Line__c WHERE Sales_Order__c =: recordId AND Is_Sample__c = true AND Product_Name__r.Parent_Product__c = null AND Product_Name__r.Is_Sample__c = false];
                    if(soLineList.size() > 0){
                        Decimal qty = 0;
                        for(Sales_Order_Line__c sol : soLineList){
                        	qty += sol.Quantity_Cases__c;    
                        }
                        List<Product2>productList = [SeLECT Id FROM Product2 WHERE Name =: Label_Not_For_Resale_Product Limit 1];
                    	Invoice_Line__c invLineItem = new Invoice_Line__c();
                        invLineItem.Product_Name__c = productList.size() > 0 ? productList[0].Id : NULL;
                        invLineItem.Invoice_Qty__c = qty;
                        invLineItem.Retail_Wholesale_Price__c = companySettingRec.Retail_Wholesale_Price__c;//qty * Decimal.valueof(Sample_Product_Price);
                        invLineItem.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get(INVOICE_LINE_RECORDTYPE_SERVICE).getRecordTypeId();	    
                        invLineItem.Invoice__c = newInvoice.Id;
                        invoiceLines.add(invLineItem);
                    }
                    */
                    
                    insert newInvoiceLines;
                    r.data.put('invoiceId',invId);
                } else {
                    r.data.put('error', ERR_MSG_NO_INVOICE_LINE_AVAILABLE);
                }
            }catch(Exception e){
                r.handleException(e);
                if(!Test.isRunningTest()){
                    Database.rollback(sp);
                }
            }
        }
        return r;
    }
    public static List<Invoice_Line__c>  validateProductFee(String productName,Decimal qty,Decimal fee,Map<String, Product2> productsMap, List<Invoice_Line__c> invoiceLines){
        Product2 p = productsMap.get(productName);
        if(p != null){
            Invoice_Line__c line = createInvoiceLine(p,qty,fee);
            if(line != null){
                invoiceLines.add(line);
            }
        }
        return invoiceLines;
    }
    public static Invoice_Line__c createInvoiceLine(Product2 product,Decimal qty, Decimal fee){
        if(product != NULL){
            Invoice_Line__c invLineItem = new Invoice_Line__c();
            invLineItem.Product_Name__c = product.Id;
            invLineItem.Invoice_Qty__c = qty;
            invLineItem.Retail_Wholesale_Price__c = fee;
            invLineItem.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get(INVOICE_LINE_RECORDTYPE_SERVICE).getRecordTypeId();
            return invLineItem;
        }
        return NULL;
    }
    @AuraEnabled
    public static AuraResponse getRecordName(Id recordId){
        AuraResponse r = new AuraResponse('FullfullmentServiceInvoiceController.getRecordName()');
        String objName = recordId.getSObjectType().getDescribe().getName();
        String q = 'SELECT Name,RecordType.Name,Order_Type__c,Supplier_Name__r.Service_Type__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Account__r.Type FROM ' + objName + ' WHERE Id=\'' + recordId + '\'';
        List<SObject> records = Database.query(q);
        if(records.size()>0){
            r.data.put('recordName',(String) (records[0].get('Name')));
            r.data.put('RecordType',(String) (records[0].getSObject('RecordType').get('Name')));
            r.data.put('orderType',(String) (records[0].get('Order_Type__c')));
            String recType = (String) (records[0].getSObject('RecordType').get('Name'));
            
            String ServiceType = (String)(records[0].getSObject('Supplier_Name__r').get('Service_Type__c'));
            r.data.put('ServiceType',ServiceType);
            if(records[0].getSObject('Supplier_Name__r') != NULL && ServiceType == 'Buy/Sell'){
                string Buy_Sell_Service_Type_Err = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Buy_Sell_Service_Type_Err');
        		r.data.put('ServiceTypeErr', Buy_Sell_Service_Type_Err != null ? Buy_Sell_Service_Type_Err : '');  
            }
            if(records[0].getSObject('Brand_Quote__r') != NULL && records[0].getSObject('Brand_Quote__r').getSObject('Opportunity_Name__r') != NULL && records[0].getSObject('Brand_Quote__r').getSObject('Opportunity_Name__r').getSObject('Order__r') != NULL && records[0].getSObject('Brand_Quote__r').getSObject('Opportunity_Name__r').getSObject('Order__r').getSObject('Account__r') != NULL)
            	r.data.put('brandAccountType',(String)(records[0].getSObject('Brand_Quote__r').getSObject('Opportunity_Name__r').getSObject('Order__r').getSObject('Account__r').get('Type')));
        }
        return r;
    }
    @AuraEnabled
    public static AuraResponse createCultivationTaxInvoice(String recordId){
        AuraResponse r = new AuraResponse('CreateCTIfromSO.createCTILight()');        
        string setInvoice;        
        Sales_Order__c statusSO = [select id,Name, SO_Status__c, (Select id from Sales_Order_Lines__r where Status__c =: 
			Sales_Order_Line_Status_Open), (Select id from Invoices__r where Recordtype.Name =: 
			Invoice_Record_Type_Tax AND (AR_Status__c =: Invoice_Ar_Status_Approved or AR_Status__c =: 
			Invoice_Ar_Status_Shipped)) from Sales_Order__c where Id  =: recordId];   
        Boolean hasBillableCultivationTax = true;
        for(Sales_Order_Line__c sol : [select id, (Select Id From Inventory_Positions__r where Billable_Cultivation_Tax__c = 'Yes') 
				from Sales_Order_Line__c where Sales_Order__c =: recordId and Status__c !=: Sales_Order_Line_Status_Cancelled AND  
				(Product_Name__r.Auto_Allocation__c = FALSE OR (Product_Name__r.Auto_Allocation__c = TRUE AND 
				Product_Name__r.Apply_Cultivation_Tax__c = 'Yes' ))]){
			if(sol.Inventory_Positions__r.size() > 0)	
                hasBillableCultivationTax = false;
		}
        r.data.put('ErrMsgSubmitSOForApprovalToCreateCTI',ErrMsgSubmitSOForApprovalToCreateCTI);
        r.data.put('ErrMsgCan_tCreateCTIForCancelledSO',ErrMsgCan_tCreateCTIForCancelledSO);
        r.data.put('ErrMsgCan_tCreateCTIForRejectedSO',ErrMsgCan_tCreateCTIForRejectedSO);
        r.data.put('ErrMsgCTIAlreadyCreated',ErrMsgCTIAlreadyCreated);
        r.data.put('ErrMsgCan_tCreateCTIForNonApproved',ErrMsgCan_tCreateCTIForNonApproved);
        r.data.put('ErrMsgBillableCultivationTaxIP',ErrMsgBillableCultivationTaxIP.replace('{0}', statusSO.Name));
        r.data.put('Success_Msg_CTI_Created',Success_Msg_CTI_Created);
        
        if(statusSO.SO_Status__c == SO_Status_Draft){
            r.data.put('statusSOerror','Error1');
            return r;
        }else if(statusSO.SO_Status__c == SO_Status_Cancelled){
            r.data.put('statusSOerror','Error2');
            return r;
        }else if(statusSO.SO_Status__c == SO_Status_Rejected){
            r.data.put('statusSOerror','Error3');
            return r;
        }else if(statusSO.SO_Status__c == Sales_Order_Status_Approved && statusSO.Sales_Order_Lines__r.size() > 0){
            r.data.put('statusSOerror','Error4');
            return r;
        }else if (hasBillableCultivationTax){
        	r.data.put('statusSOerror','Error6');
            return r;    
        }else{
            setInvoice = createCTInvoice(recordId);
            r.data.put('setInvoice',setInvoice);
        }   
        return r;
    }    
    public static string createCTInvoice(Id sooldId){
        ID soID = sooldId;
        Sales_Order__c objSO= [select id ,name,Sample_Order__c,Ownership__c,Opportunity_Name__c,Distributor_Name__c,
                               Sales_Order_Instructions__c,Receiver_Name__r.Payment_Terms__c,
				Distributor_License__c,Distributor_Contact__c,Receiver_Name__c,Receiver_License__c,Receiver_Contact__c,
				Supplier_Name__c,Supplier_License__c,Supplier_Contact__c,Brand_Quote__c,Payment_Terms__c,Site__c,
				Shipping_Method__c,Shipping_Terms__c,Ship_Confirmation_Date__c from Sales_Order__c where id =: soID ];
        
        List<Sales_Order_Line__c> soLines= [select id,name,Sales_Order__c,Product_Name__c,Sales_Order__r.Ownership__c,
				Product_Title__c,Qty_Ordered__c,Promised_Date__c,Ownership_Code__c, (Select Id, Unit_Cultivation_Tax_1__c,Unit_Cultivation_Tax__c,Unit_Cannabis_Weight__c,
				Unit_Cannabis_Weight_1__c,Receiving_Line__r.Purchase_Order_Line__c,Harvest_Batch_Code__c,Inventory_Qty__c,Product_Name__c
				From Inventory_Positions__r where Billable_Cultivation_Tax__c = 'Yes') from Sales_Order_Line__c where 
				Sales_Order__c =: soID and Status__c !=: Sales_Order_Line_Status_Cancelled AND  
				(Product_Name__r.Auto_Allocation__c = FALSE OR (Product_Name__r.Auto_Allocation__c = TRUE AND 
				Product_Name__r.Apply_Cultivation_Tax__c = 'Yes' ))];
        /*default reciever Name to iRR for CTI--reciver, contact & license*/
        Company_Custom_Settings__c cs = [select Default_Distributor__c, Default_License__c,Default_Contact__c from Company_Custom_Settings__c];
        
        Invoice__c newInvoice = new Invoice__c();
        newInvoice.Sales_Order__c= soID;
        newInvoice.AR_Status__c = Invoice_Ar_Status_Approved;
        newInvoice.Site__c = objSO.Site__c;
        newInvoice.Shipping_Method__c = objSO.Shipping_Method__c;
        newInvoice.Shipping_Terms__c = objSO.Shipping_Terms__c;
      
        newInvoice.Invoice_Memo__c = objSO.Sales_Order_Instructions__c;
        newInvoice.Sample_Order__c = objSO.Sample_Order__c;
        newInvoice.Brand_Quote__c = objSO.Brand_Quote__c;
        newInvoice.Opportunity_Name__c = objSO.Opportunity_Name__c;
        newInvoice.Distributor_Name__c = objSO.Distributor_Name__c;
        newInvoice.Distributor_License__c = objSO.Distributor_License__c;
        newInvoice.Distributor_Contact__c = objSO.Distributor_Contact__c;
        newInvoice.Supplier_Name__c = objSO.Supplier_Name__c;
        newInvoice.Supplier_License__c = objSO.Supplier_License__c;
        newInvoice.Supplier_Contact__c = objSO.Supplier_Contact__c;
        newInvoice.Receiver_Name__c = cs.Default_Distributor__c;
        newInvoice.Receiver_License__c = cs.Default_License__c;
        newInvoice.Receiver_Contact__c = cs.Default_Contact__c;
        newInvoice.Ownership__c = objSO.Ownership__c;
        newInvoice.Ship_Confirmation_Date__c = objSO.Ship_Confirmation_Date__c;
        newInvoice.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get(Invoice_Record_Type_Tax).getRecordTypeId();
        newInvoice.Invoice_Due_Date__c = date.valueof(system.now());
        newInvoice.Payment_Terms__c = objSO.Receiver_Name__r.Payment_Terms__c;
        insert newInvoice;        
        List<Invoice_Line__c> invLineItems = new List<Invoice_Line__c>();
        for (Sales_Order_Line__c objSOlines: soLines){
            Map<String,Invoice_Line__c>batchInvoiceLineMap = new Map<String,Invoice_Line__c>();
            for(Inventory_Position__c IP : objSOlines.Inventory_Positions__r){
                if(batchInvoiceLineMap.containsKey(IP.Product_Name__c)){//Ip.Product_Name__c
                	Invoice_Line__c invLineItem =  batchInvoiceLineMap.get(IP.Product_Name__c);
                    invLineItem.Invoice_Qty__c = invLineItem.Invoice_Qty__c + IP.Inventory_Qty__c;
                    batchInvoiceLineMap.put(IP.Product_Name__c,invLineItem);
                    system.debug('batchInvoiceLineMap>>'+batchInvoiceLineMap);
                }else{
                	Invoice_Line__c invLineItem = new Invoice_Line__c();
                    invLineItem.Invoice__c = newInvoice.Id;
                    invLineItem.Sales_Order_Line__c = objSOlines.Id;
                    invLineItem.Product_Name__c = objSOlines.Product_Name__c;
                    invLineItem.Product_Title__c = objSOlines.Product_Title__c;
                    invLineItem.Purchased_Date__c = objSOlines.Promised_Date__c;
                    invLineItem.Unit_Cultivation_Tax__c = IP.Unit_Cultivation_Tax__c;
                    invLineItem.Unit_Cannabis_Weight__c = IP.Unit_Cannabis_Weight__c;
                    invLineItem.PO_Line__c = IP.Receiving_Line__r.Purchase_Order_Line__c;
                    invLineItem.Invoice_Qty__c = IP.Inventory_Qty__c; //objSOlines.Qty_Ordered__c;
                    if(objSOlines.Ownership_Code__c != null){
                        
                        invLineItem.OwnershipCode__c = objSOlines.Ownership_Code__c;    
                    } else{
                        invLineItem.OwnershipCode__c = objSOlines.Sales_Order__r.Ownership__c;
                    }
                    invLineItem.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get(Invoice_Record_Type_Tax).getRecordTypeId(); 
                    batchInvoiceLineMap.put(IP.Product_Name__c,invLineItem);
                     system.debug('batchInvoiceLineMap>>'+batchInvoiceLineMap);
                }    
            }
            invLineItems.addAll(batchInvoiceLineMap.values());
             system.debug('invLineItems>>'+invLineItems);
        }
        insert invLineItems;
        String retPage = newInvoice.Id;
        return retPage;
    }   
}