public class ReceivingServiceInvoiceCtlr { 
    
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
    private Static String INVOICE_LINE_RECORDTYPE_SERVICE { 
        get{
            return  String.isNotBlank(INVOICE_LINE_RECORDTYPE_SERVICE) ? INVOICE_LINE_RECORDTYPE_SERVICE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice Line','Invoice_Line_RecordType_Service');
        }set;
    }
    public Static String SO_SHIPPING_METHOD_PICK_UP{ 
        get{
            return  String.isNotBlank(SO_SHIPPING_METHOD_PICK_UP) ? SO_SHIPPING_METHOD_PICK_UP :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Shipping_Method_Pick_Up');
        }set;
    }
    private Static String PRODUCT_NAME_MILEAGE_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_MILEAGE_FEE) ? PRODUCT_NAME_MILEAGE_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Mileage_Fee');
        }set;
    }
    private Static String PRODUCT_NAME_INVENTORY_STORAGE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_INVENTORY_STORAGE) ? PRODUCT_NAME_INVENTORY_STORAGE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Inventory_Storage');
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
    private Static String PRODUCT_NAME_LISTING_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_LISTING_FEE) ? PRODUCT_NAME_LISTING_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Listing_Fee');
        }set;
    }
    private Static String SALES_ORDER_LINE_STATUS_REJECTED{
        get{
            return String.isNotBlank(SALES_ORDER_LINE_STATUS_REJECTED) ? SALES_ORDER_LINE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Rejected');
        }set;
    }
    private Static String STATUS_SALESORDERLINECANCELLED{
        get{
            return String.isNotBlank(STATUS_SALESORDERLINECANCELLED) ? STATUS_SALESORDERLINECANCELLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SalesOrderLines_Cancelled');
        }set;
    }
    private static String PRODUCT_RECORD_TYPE_NAME_PRODUCT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_PRODUCT) ? PRODUCT_RECORD_TYPE_NAME_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Name_Product');
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
    public Static String SO_ORDER_TYPE_TRANSFER {
        get{
            return String.isNotBlank(SO_ORDER_TYPE_TRANSFER) ? SO_ORDER_TYPE_TRANSFER:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Type_Transfer');
        }set;
    }
    public Static String ERR_SELECT_SOLINE_TO_CREATE_SERVICE_INVOICE {
        get{
            return String.isNotBlank(ERR_SELECT_SOLINE_TO_CREATE_SERVICE_INVOICE) ? ERR_SELECT_SOLINE_TO_CREATE_SERVICE_INVOICE:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Err_Select_SOLine_to_create_Ser_Invoice');
        }set;
    }
    private static String Invoice_Ar_Status_Approved{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Approved) ? Invoice_Ar_Status_Approved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Approved');
        }set;
    }
    
    private Static String PRODUCT_NAME_AGENT_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_AGENT_FEE) ? PRODUCT_NAME_AGENT_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Agent_Fee');
        }set;
    }
    private Static String PRODUCT_NAME_DISTRIBUTION_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_DISTRIBUTION_FEE) ? PRODUCT_NAME_DISTRIBUTION_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Distribution_Fee');
        }set;
    }
    private Static String PURCHASE_ORDER_STATUS_DRAFT{
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_DRAFT) ? PURCHASE_ORDER_STATUS_DRAFT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PurchaseOrder_Status_Draft');
        }set;
    }
    private Static String PURCHASE_ORDER_RECORDTYPE_INVOICE_ONLY{
        get{
            return String.isNotBlank(PURCHASE_ORDER_RECORDTYPE_INVOICE_ONLY) ? PURCHASE_ORDER_RECORDTYPE_INVOICE_ONLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Record_Type_Invoice_Only');
        }set;
    }
    public Static String PURCHASE_ORDER_LINE_RECORDTYPE_INVOICE_ONLY{
        get{
            return String.isNotBlank(PURCHASE_ORDER_LINE_RECORDTYPE_INVOICE_ONLY) ? PURCHASE_ORDER_LINE_RECORDTYPE_INVOICE_ONLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POL_Record_Type_Invoice_Only');
        }set;
    }
    private static String STATE_LICENSE_ACTIVE{
        get{
            return String.isNotBlank(STATE_LICENSE_ACTIVE) ? STATE_LICENSE_ACTIVE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_Active');
        }set;
    }
    private Static String ORDER_TYPE_TRANSFER {
        get{
            return String.isNotBlank(ORDER_TYPE_TRANSFER) ? ORDER_TYPE_TRANSFER :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Transfer');
        }set;
    } 
    private static String ACCOUNT_PLATEFORMLEVEL_ADVANCE {
        get{
            return String.isNotBlank(ACCOUNT_PLATEFORMLEVEL_ADVANCE ) ? ACCOUNT_PLATEFORMLEVEL_ADVANCE  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Plateformlevel_Advance');
        }set;
    }
    public Static String TYPE_BUYQUOTE{ 
        get{
            return  String.isNotBlank(TYPE_BUYQUOTE) ? TYPE_BUYQUOTE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuoteType_BuyQuote');
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
    public Static String PO_Shipping_Method_Drop_Off{ 
        get{
            return  String.isNotBlank(PO_Shipping_Method_Drop_Off) ? PO_Shipping_Method_Drop_Off :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Shipping_Method_Drop_Off');
        }set;
    }
    public Static String SO_RecordType_Product {
        get{
            return String.isNotBlank(SO_RecordType_Product) ? SO_RecordType_Product:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_Product');
        }set;
    }
    public Static String SO_RecordType_Service {
        get{
            return String.isNotBlank(SO_RecordType_Service) ? SO_RecordType_Service:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_Service');
        }set;
    }
    public Static String Product_Record_Type_Services {
        get{
            return String.isNotBlank(Product_Record_Type_Services) ? Product_Record_Type_Services:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Services');
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
    private Static String Product_Name_Manifest_Change_Fee{ 
        get{
            return  String.isNotBlank(Product_Name_Manifest_Change_Fee) ? Product_Name_Manifest_Change_Fee :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Manifest_Change_Fee');
        }set;
    }
    private Static String Receiving_Invoice_Not_Create{ 
        get{
            return  String.isNotBlank(Receiving_Invoice_Not_Create) ? Receiving_Invoice_Not_Create :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Receiving_Invoice_Not_Create');
        }set;
    }
    public static Map<String,List<String>> MPAccessTypesMap{
        get{
            if(MPAccessTypesMap == NULL){
                MPAccessTypesMap = new Map<String,List<String>>();
                for(MP_Access_Type_Config__mdt MPAccess: [SELECT Id, Account_Types__c ,MP_Access_Type__c FROM MP_Access_Type_Config__mdt ] ){
                    List<String> accountTypes = MPAccess.Account_Types__c != NULL ? MPAccess.Account_Types__c.split(','):new List<String>();
                    if(MPAccessTypesMap.containsKey(MPAccess.MP_Access_Type__c)){MPAccessTypesMap.get(MPAccess.MP_Access_Type__c).addAll(accountTypes);
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
    public static AuraResponse getSalesOrderDetails(String recordId){
        AuraResponse r = new AuraResponse('ReceivingServiceInvoiceCtlr.getSalesOrderDetails()');
        try{
            system.debug('recordId '+recordId);
            Sales_Order__c salesOrder = getSalesOrder(recordId);
            
            Map<String,List<Sales_Order_Line__c>>ProducerDetailsMap = new Map<String,List<Sales_Order_Line__c>>();
            List<ProducerDetails>ProducerDetailsList = new List<ProducerDetails>();
            if(salesOrder.Sales_Order_Lines__r.size() > 0){
                for(Sales_Order_Line__c SOL: salesOrder.Sales_Order_Lines__r){
                    list<Sales_Order_Line__c> sList = new List<Sales_Order_Line__c>();
                    
                    if(SOL.Product_Name__r.White_Labelled__c && SOL.Product_Name__r.Licensee_Name__c != null){
                        if(ProducerDetailsMap.containsKey(SOL.Product_Name__r.Licensee_Name__c))
                            sList = ProducerDetailsMap.get(SOL.Product_Name__r.Licensee_Name__c);
                    } else {
                        if(SOL.Product_Name__r.Producer_Name__c != null && ProducerDetailsMap.containsKey(SOL.Product_Name__r.Producer_Name__c))
                            sList = ProducerDetailsMap.get(SOL.Product_Name__r.Producer_Name__c);
                    }
                    sList.add(SOL);
                    if(SOL.Product_Name__r.White_Labelled__c){ProducerDetailsMap.put(SOL.Product_Name__r.Licensee_Name__c,sList);
                    } else {
                        ProducerDetailsMap.put(SOL.Product_Name__r.Producer_Name__c,sList);
                    }
                }
                for(string str : ProducerDetailsMap.keySet()){
                    list<Sales_Order_Line__c>sList = ProducerDetailsMap.get(str);
                    SOLineDetails SD = new SOLineDetails(sList[0]);
                    ProducerDetails PD;
                    if(sList[0].Product_Name__r.White_Labelled__c){
                        PD = new ProducerDetails(str,sList[0].Product_Name__r.Licensee_Name__r.Name,sList.size(),SD); 
                    } else {
                        PD = new ProducerDetails(str,sList[0].Product_Name__r.Producer_Name__r.Name,sList.size(),SD); 
                    }
                    
                    ProducerDetailsList.add(PD);
                    for(Integer i=1;i<sList.size();i++){
                        SOLineDetails SD1 = new SOLineDetails(sList[i]);  
                        ProducerDetails PD1 = new ProducerDetails(str,'',0,SD1); 
                        ProducerDetailsList.add(PD1);
                    }
                }
            }
            r.data.put('salesOrder',salesOrder);
            r.data.put('producerSOLines',ProducerDetailsList);
        }catch(Exception e){
            r.data.put('Error',e.getMessage());
        }
        return r;
    }
    public static Sales_Order__c getSalesOrder(String recordId){
        return [SELECT Name,Brand_Quote__c,Brand_Quote__r.Order_Type__c,Distributor_Contact__c,Distributor_License__c,SO_Status__c, Brand_Quote__r.Opportunity_Name__c,Brand_Quote__r.Site__c,
                Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c, Brand_Quote__r.Opportunity_Name__r.Order__r.Customer__r.ContactId,Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c,
                Brand_Quote__r.Planned_Transfer_Date__c,Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Sample_Order__c,
                Brand_Quote__r.Payment_Terms__c,Brand_Quote__r.Ownership__c,Brand_Quote__r.RecordTypeId,Brand_Quote__r.RecordType.Name,Distributor_Name__c,Distributor_DBA__c,Customer_PO_or_Quote__c,Payment_Terms__c,SO_Type__c,
                Opportunity_Name__r.Name,Retailer_PO__c,Factoring_Contact__c, Planned_Ship_Date__c,Receiver_Name__r.Payment_Terms__c, Brand_Quote__r.Opportunity_Name__r.Order__r.Piggyback_sample__c,
                Receiver_Contact__c,Receiver_License__c,Receiver_Name__c,Receiver_DBA__c,SO_Date__c,Receiver_Name__r.Name,Receiver_Name__r.DBA__c,
                Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c,Ownership__r.Platform_Level__c,
                Sales_Order_Instructions__c,Ship_Confirmation_Date__c,Factoring_Assignee__c,Total_Manifest_Revision__c,
                Total_Price__c,Factoring_Rate__c,Sample_Order__c,Shipping_Method__c,Shipping_Terms__c,Ownership__r.DBA__c,Total_Manifest_Change_Fee__c,
                Site__r.Name,Site__r.Warehouse_Name__c,Total_Line_Items__c,Supplier_Contact__c,Supplier_Name__r.DBA__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c,
                Supplier_License__c,Supplier_Name__c,Supplier_DBA__c,Allocated__c,RecordTypeId,Supplier_Name__r.Service_Type__c,Supplier_Name__r.Distribution_Fee__c,
                Ownership__c,Ownership__r.Type,RecordType.Name,Opportunity_Name__c,Id,Site__c,Order_Booking_Fee__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__c,
                Pack_Out_Fee__c,Schedule_Dispatch_Fee__c,Stage_Manifest_Fee__c,Total_Mileage_Fee__c,Total_Weight_Fee__c,Ownership__r.Service_Type__c,
                Supplier_Name__r.Membership_Level__c,Ownership__r.Membership_Level__c,Order_Type__c,Receiver_Name__r.Membership_Level__c,Change_Order_Fee__c,
                (SELECT Name,Arrival_Date__c,Brand_Quote_Line__c,Product_Name__c,Qty_To_Invoiced__c,Brand_Quote_Line__r.Retail_Wholesale_Price__c,
                 Brand_Quote_Line__r.Product_Name__c,Brand_Quote_Line__r.Product_Title__c,Brand_Quote_Line__r.Line_Total_Qty__c,Brand_Quote_Line__r.Is_Sample__c,
                 Product_Name__r.Producer_Name__c,Product_Name__r.Producer_Name__r.Type,Product_Name__r.Producer_Name__r.Name,Is_Sample__c,Product_Name__r.Licensee_Name__c,Product_Name__r.Licensee_Name__r.Type, 
                 Product_Name__r.Name,Product_Name__r.White_Labelled__c,Product_Title__c,Product_Description__c,Promised_Date__c,
                 Producer_Name__c, MOQ__c,Qty_Ordered__c,Qty_Invoiced__c,Quantity_Cases__c,Product_Name__r.Licensee_Name__r.Name,
                 Request_Date__c,Retail_Wholesale_Price__c,Line_Total_Price__c,Sales_Order__c,Ownership_Code__r.Payment_Terms__c,Ownership_Code__r.Membership_Level__c,Ownership_Code__r.Type,
                 Ownership_Code__c,Status__c,RecordType.Name,Id,Pick_Pack_Fee__c,QA_Review_Fee__c,Weight_to_Order_Fee__c,Weight_to_Stage_Manifest_Fee__c,Weight_to_Schedule_Dispatch_Fee__c,Weight_to_Order_Booking_Fee__c,
                 Total_Weight_lbs__c, Pack_Out_Fee__c ,Total_QA_Change_fee__c, Weight_to_Mileage_Fee__c , Listing_Fee__c  
                 FROM Sales_Order_Lines__r WHERE Status__c NOT IN (:SALES_ORDER_LINE_STATUS_REJECTED,:STATUS_SALESORDERLINECANCELLED) AND (((Sales_Order__r.RecordType.Name =: SO_RecordType_Product OR Sales_Order__r.RecordType.Name =: SO_ORDER_TYPE_TRANSFER) AND Product_Name__r.RecordType.Name =: PRODUCT_RECORD_TYPE_NAME_PRODUCT ) OR (Sales_Order__r.RecordType.Name =: SO_RecordType_Service AND Product_Name__r.RecordType.Name =: Product_Record_Type_Services)) ORDER BY Name)
                FROM Sales_Order__c 
                WHERE Id =: recordId];
    }
    
    @AuraEnabled
    public static AuraResponse createInvoices(String recordId, String salesOrderLineData,Boolean isOBCreated){
        system.debug('##isOBCreated : ' + isOBCreated);
        AuraResponse r = new AuraResponse('ReceivingServiceInvoiceCtlr.createInvoices()');
        Set<String> serviceFeeProductSet = new Set<String>{PRODUCT_NAME_INVENTORY_STORAGE,PRODUCT_NAME_MILEAGE_FEE,PRODUCT_NAME_PICK_AND_PACK_FEE,PRODUCT_NAME_QA_REVIEW_FEE,PRODUCT_NAME_ORDER_BOOKING,PRODUCT_NAME_PACK_OUT,PRODUCT_NAME_WEIGHT_FEE,PRODUCT_NAME_SCHEDULE_AND_DISPATCH,PRODUCT_NAME_STAGE_AND_MANIFEST,PRODUCT_NAME_CHANGE_ORDER_FEE,PRODUCT_NAME_LISTING_FEE,PRODUCT_NAME_AGENT_FEE,PRODUCT_NAME_DISTRIBUTION_FEE,Delivery_Rescheduling_Fee_Config,Product_Name_Manifest_Change_Fee};
            Savepoint sp;        
        try{
            sp = Database.setSavepoint();
            Product2[] products = [SELECT Id,Name FROM Product2 WHERE Name IN: serviceFeeProductSet];
            Map<String, Product2> productsMap = new Map<String,Product2>();
            Set<Id> productIds = new Set<Id>();
            for(Product2 p: products){
                productsMap.put(p.Name,p);
                productIds.add(p.Id);
            }
            PriceBookEntry[] PBEs = [SELECT Id, Product2Id,UnitPrice FROM PriceBookEntry WHERE Product2Id IN :productIds AND PriceBook2.Name =: STANDARD_PRICE_BOOK];
            Map<Id,PriceBookEntry> productPBEMap = new Map<Id,PriceBookEntry>();
            for(PriceBookEntry pbe: PBEs){ productPBEMap.put(pbe.Product2Id,pbe);
            }
            Sales_Order__c sOrder = getSalesOrder(recordId);
            
            Id agentId = sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Customer__r.ContactId;
            String membershipLevel;
            if(sOrder.Order_Type__c == SO_ORDER_TYPE_BRAND){
                membershipLevel = sOrder.Ownership__r.Membership_Level__c;//Supplier_Name__r.Membership_Level__c;
            }else{
                membershipLevel = sOrder.Receiver_Name__r.Membership_Level__c;
            }
            
            
            Map<Id,Sales_Order_Line__c> mapSOLine = new Map<Id,Sales_Order_Line__c>([SELECT Id,Name,(SELECT Id,Name,Aged_Bucket__c,Days_in_Inventory__c,Total_Product_Volume__c
                                                                   FROM Inventory_Positions__r)
                                                   FROM Sales_Order_Line__c WHERE Sales_Order__c =: sOrder.Id]);
            
            List<Inventory_Storage_Config__mdt> iStorage = [SELECT Id,MasterLabel,DeveloperName,Charge__c,Lower_Limit__c,Upper_Limit__c FROM Inventory_Storage_Config__mdt];
            
            /*for(Sales_Order_Line__c soLine : lstSOLine){   
                for(Inventory_Position__c ip : soLine.Inventory_Positions__r){
                    for(Inventory_Storage_Config__mdt mdt : iStorage){
                        if(ip.Days_in_Inventory__c >= mdt.Lower_Limit__c && ip.Days_in_Inventory__c <= mdt.Upper_Limit__c){
                           totalStorageFee = totalStorageFee + (ip.Total_Product_Volume__c * mdt.Charge__c);
                        } else if(ip.Days_in_Inventory__c >= mdt.Lower_Limit__c && mdt.Upper_Limit__c == null){
                            totalStorageFee = totalStorageFee + (ip.Total_Product_Volume__c * mdt.Charge__c);
                        }
                    }
                }
            }*/
            
            Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c, Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c,Membership_Level__c
                                                     FROM Fulfillment_Rates_Table__c 
                                                     WHERE Site__c = :sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c
                                                     AND Active__c = true
                                                     AND Rate_Effective_From__c <= :System.today()
                                                     AND Rate_Effective_To__c >= :System.today()
                                                     AND Membership_Level__c = :membershipLevel
                                                     AND Fulfillment_Services__c = :PRODUCT_NAME_PACK_OUT
                                                     ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
            Shipping_Rates_Table__c [] mileageSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, 
                                                         Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Membership_Level__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c
                                                         FROM Shipping_Rates_Table__c 
                                                         WHERE Site__c =: sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c
                                                         AND Active__c = true
                                                         AND Rate_Effective_From__c <= :System.today()
                                                         AND Rate_Effective_To__c >= :System.today()
                                                         AND Membership_Level__c = :membershipLevel
                                                         Order By Mileage_Bracket__c];
            Shipping_Rates_Table__c [] weightSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, 
                                                        Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Membership_Level__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c
                                                        FROM Shipping_Rates_Table__c 
                                                        WHERE Site__c =: sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c
                                                        AND Active__c = true
                                                        AND Rate_Effective_From__c <= :System.today()
                                                        AND Rate_Effective_To__c >= :System.today()
                                                        AND Membership_Level__c = :membershipLevel
                                                        Order By Weight_Bracket__c];            
            List<ProducerDetails> ProducerDetailsList = (List<ProducerDetails>)JSON.deserialize(salesOrderLineData, List<ProducerDetails>.class);  
            //Map<Invoice__c,List<Invoice_Line__c>>invoiceList = new Map<Invoice__c,List<Invoice_Line__c>>();
            Map<String,Invoice__c>newInvoiceMap = new Map<String,Invoice__c>();
            Map<String,List<Invoice_Line__c>>invoiceLineMap = new Map<String,List<Invoice_Line__c>>();
            Map<String,Purchase_Order__c>newPOMap = new Map<String,Purchase_Order__c>();
            Map<String,List<Purchase_Order_Line__c>>POLineMap = new Map<String,List<Purchase_Order_Line__c>>();
            integer i=0;
            Map<String,ProducerDetails[]> ProducerDetailsMap = new Map<String,ProducerDetails[]>();
            for(ProducerDetails PD : ProducerDetailsList){
                if(ProducerDetailsMap.containsKey(PD.producerId)){ ProducerDetailsMap.get(PD.producerId).add(PD);
                }else{
                    ProducerDetailsMap.put(PD.producerId,new ProducerDetails[]{PD});
                }
            }
            for(Id producerId : ProducerDetailsMap.keySet()){
                ProducerDetails[] lines = ProducerDetailsMap.get(producerId);
                Boolean isProducerSelected = false;
                for(ProducerDetails line: lines){ 
                    if(line.isSelected){
                        isProducerSelected = true;
                        break;
                    }
                }
                if(isProducerSelected){
                    for(ProducerDetails line: lines){
                        line.isSelected = true;
                    }
                }
                
            }
            Map<String,Sales_Order_Line__c[]> producerSOLinesMap = new Map<String,Sales_Order_Line__c[]>();
            for(ProducerDetails PD : ProducerDetailsList){
                System.debug('##PD::'+PD.producerId);
                System.debug('##PD Selected::'+PD.isSelected);
                if(PD.isSelected){
                    if(producerSOLinesMap.containsKey(PD.producerId)){ producerSOLinesMap.get(PD.producerId).add(PD.SOLine.SOLine);
                    }else{
                        producerSOLinesMap.put(PD.producerId , new List<Sales_Order_Line__c>{PD.SOLine.SOLine});
                    }
                }
            }
            Set<String> producerIds = producerSOLinesMap.keySet();
            List<Disty_Brand_Relationship__c> distyBrandRelationships = [SELECT Id, Brand__c,Brand__r.Distribution_Fee__c, Agent_Fee__c  FROM Disty_Brand_Relationship__c WHERE Agent_Fee__c != NULL AND Brand__c IN :producerIds AND Active__c = true AND Contact__c =: agentId];
            Map<Id,Disty_Brand_Relationship__c> brandAgentFeeMap = new Map<Id,Disty_Brand_Relationship__c>();
            if(distyBrandRelationships.size() > 0){
                for(Disty_Brand_Relationship__c DBR: distyBrandRelationships){
                    brandAgentFeeMap.put(DBR.Brand__c, DBR);
                }
            }
            List<Line_Card__c> LCList = [SELECT id,Minimum_Service_Fee__c FROM Line_Card__c WHERE Retailer_Name__c =: sOrder.Receiver_Name__c AND Brand_Name__c =: sOrder.Supplier_Name__c LIMIT 1];
            Map<Id,Account> producerMap = new Map<Id,Account>([SELECT Id, Name, (SELECT Id FROM State_Licenses__r WHERE License_Status__c  = :STATE_LICENSE_ACTIVE),(SELECT Id FROM Contacts WHERE Active__c = true Order By Name) FROM Account WHERE Id IN :producerIds]);
            for(String producerId : producerSOLinesMap.keySet()){
                List<Invoice_Line__c> invoiceLines = new List<Invoice_Line__c>();
                List<Purchase_Order_Line__c> POLines = new List<Purchase_Order_Line__c>();
                Sales_Order_Line__c[] SOLines = producerSOLinesMap.get(producerId);
                Decimal totalInvoiceAmount = 0;
                System.debug('###SOLines:'+SOLines.size());
                if(SOLines != null && SOLines.size() > 0){
                    Decimal totalWieght = 0;
                    //Decimal totalPackOutFee = 0;
                    Decimal totalPickPackFee = 0;
                    Decimal totalQAReviewFee = 0;
                    Decimal mileageFee = 0;
                    Decimal weightFee = 0;
                    Decimal totalStorageFee = 0;
                    Decimal totalListingFee = 0;
                    Decimal orderBookingFee = 0;
                    Decimal schedulingFee = 0;
                    Decimal stagingFee = 0;
                    Boolean isFixedMileage = false;
                    Boolean isFixedWeight = false;
                    Boolean has1MOQItem = false;
                    Decimal totalSOAmount = 0;
                    for(Sales_Order_Line__c SOL: SOLines){
                        if(SOL.MOQ__c == 1){  has1MOQItem = true;
                        }
                        totalWieght += (SOL.Total_Weight_lbs__c != NULL ?SOL.Total_Weight_lbs__c:0);
                        weightFee += (SOL.Weight_to_Order_Fee__c != NULL ?SOL.Weight_to_Order_Fee__c:0);
                        mileageFee += (SOL.Weight_to_Mileage_Fee__c != NULL ?SOL.Weight_to_Mileage_Fee__c:0);
                        totalPickPackFee += (SOL.Pick_Pack_Fee__c != NULL ?SOL.Pick_Pack_Fee__c:0);
                        totalQAReviewFee += (SOL.QA_Review_Fee__c != NULL ?SOL.QA_Review_Fee__c:0);
                        totalListingFee += (SOL.Listing_Fee__c != NULL ?SOL.Listing_Fee__c:0);
                        totalSOAmount += (SOL.Line_Total_Price__c != NULL?SOL.Line_Total_Price__c :0);
                        orderBookingFee += (SOL.Weight_to_Order_Booking_Fee__c != NULL?SOL.Weight_to_Order_Booking_Fee__c :0);
                        schedulingFee += (SOL.Weight_to_Schedule_Dispatch_Fee__c != NULL?SOL.Weight_to_Schedule_Dispatch_Fee__c :0);
                        stagingFee += (SOL.Weight_to_Stage_Manifest_Fee__c != NULL?SOL.Weight_to_Stage_Manifest_Fee__c :0);
                    }
                    
                    //if(sOrder.Brand_Quote__r.Order_Type__c == ORDER_TYPE_TRANSFER && sOrder.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE && (sOrder.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == Account_Plateformlevel_ZASP || sOrder.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == Account_Plateformlevel_IRR)){
                    System.debug(sOrder.Brand_Quote__r.Order_Type__c);
                    System.debug(sOrder.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c);
                    System.debug(sOrder.Receiver_Name__r.DBA__c);
                    /*if(sOrder.Brand_Quote__r.Order_Type__c == ORDER_TYPE_TRANSFER && sOrder.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE && (sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR)){    
                        mileageFee = 0;
                        weightFee =0;
                        totalQAReviewFee = 0;
                        
                    }*/
                    
                    Company_Custom_Settings__c companySettingRec = Company_Custom_Settings__c.getOrgDefaults();
                    Invoice__c newInvoice = createProducerInvoice(sOrder,producerId);
                    Purchase_Order__c newPO = new Purchase_Order__c();
                    Decimal agentFee = 0;
                    Decimal distributionFee = 0;
                    
                    if(sOrder.Ownership__r.Type == ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER){
                        newInvoice.Ownership__c = companySettingRec.Default_Distributor__c;
                        
                    }else{
                        newInvoice.Ownership__c = companySettingRec.Default_Distributor__c;//sOrder.Ownership__c;
                    }
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
                    
                    if(distyTypes.indexOf(sOrder.Ownership__r.Type) != -1){
                        
                        newPO =createPO(sOrder,companySettingRec);
                        newPO.Ownership__c = producerId;
                        newPO.Receiver_Name__c = companySettingRec.Default_Distributor__c;
                        newPO.Receiver_License__c = companySettingRec.Default_License__c;
                        newPO.Receiver_Contact__c = companySettingRec.Default_Contact__c;
                        newPO.Distributor_Name__c = companySettingRec.Default_Distributor__c;
                        newPO.Distributor_License__c = companySettingRec.Default_License__c;
                        newPO.Distributor_Contact__c = companySettingRec.Default_Contact__c;
                        newPO.Supplier_Name__c = producerId;
                        if(producerMap.containsKey(producerId) && producerMap.get(producerId).State_Licenses__r != NULL && producerMap.get(producerId).State_Licenses__r.size() > 0){
                            newPO.Supplier_License__c = producerMap.get(producerId).State_Licenses__r[0].Id;
                        }
                        if(producerMap.containsKey(producerId) && producerMap.get(producerId).Contacts != NULL && producerMap.get(producerId).Contacts.size() > 0){
                            newPO.Supplier_Contact__c = producerMap.get(producerId).Contacts[0].Id;
                        }
                        POLines = createPOLine(producerSOLinesMap.get(producerId),sOrder);
                        
                        if(totalSOAmount > 0 && brandAgentFeeMap.containsKey(producerId)){
                            Disty_Brand_Relationship__c DBR = brandAgentFeeMap.get(producerId);
                            if(DBR != NULL){
                                AgentFee = totalSOAmount * (DBR.Agent_Fee__c/100);
                                if(DBR.Brand__r.Distribution_Fee__c != NULL){
                                    distributionFee = totalSOAmount * (DBR.Brand__r.Distribution_Fee__c/100);
                                }
                            }
                            
                        }
                    }
                    system.debug('newInvoice.Receiver_Name__c'+producerId);
                    for(Sales_Order_Line__c SOL: SOLines){
                        system.debug('newInvoice.SOL.Ownership_Code__c'+SOL.Ownership_Code__c);
                        system.debug('newInvoice.SOL.Payment_Terms__c'+SOL.Ownership_Code__r.Payment_Terms__c);
                        if(SOL.Ownership_Code__c == producerId && SOL.Ownership_Code__r.Payment_Terms__c!=null)   
                        {
                            newInvoice.Payment_Terms__c = SOL.Ownership_Code__r.Payment_Terms__c;     
                        }   else{
                            
                             newInvoice.Payment_Terms__c = PAYMENT_TERMS_COD; 
                        }
                        
                        for(Inventory_Position__c ip : mapSoLine.get(SOL.Id).Inventory_Positions__r){
                            for(Inventory_Storage_Config__mdt mdt : iStorage){
                                if(ip.Days_in_Inventory__c >= mdt.Lower_Limit__c && ip.Days_in_Inventory__c <= mdt.Upper_Limit__c){
                                    totalStorageFee = totalStorageFee + (ip.Total_Product_Volume__c * mdt.Charge__c);
                                } else if(ip.Days_in_Inventory__c >= mdt.Lower_Limit__c && mdt.Upper_Limit__c == null){
                                    totalStorageFee = totalStorageFee + (ip.Total_Product_Volume__c * mdt.Charge__c);
                                }
                            }
                        }
                    }
                     
                    newInvoice.Ownership__c = companySettingRec.Default_Distributor__c;
                    newInvoice.Supplier_Name__c = companySettingRec.Default_Distributor__c;
                    newInvoice.Supplier_License__c = companySettingRec.Default_License__c;
                    
                   Boolean skipFees = false;
                    Boolean skipFeesForBasic = false;
                    if(sOrder.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE  && 
                       (
                           (sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR) 
                           || (sOrder.Supplier_Name__r.DBA__c == Account_Plateformlevel_ZASP || sOrder.Supplier_Name__r.DBA__c == Account_Plateformlevel_IRR)
                       ) 
                       && (sOrder.Order_Type__c == SO_ORDER_TYPE_TRANSFER || String.isBlank(sOrder.Brand_Quote__r.Order_Type__c))){//&& sOrder.Brand_Quote__r.recordtype.Name == TYPE_BUYQUOTE
                        skipFees = true;
                    }  
                    if(
                        (
                            (sOrder.Supplier_Name__r.DBA__c != Account_Plateformlevel_ZASP && sOrder.Supplier_Name__r.DBA__c != Account_Plateformlevel_IRR) 
                            || (sOrder.Receiver_Name__r.DBA__c != Account_Plateformlevel_ZASP && sOrder.Receiver_Name__r.DBA__c != Account_Plateformlevel_IRR)
                        ) && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__c != null &&(sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_ZASP && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_IRR) && sOrder.Order_Type__c == SO_ORDER_TYPE_TRANSFER){
                        skipFees = true;
                    }
                     if((sOrder.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_BASIC || sOrder.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE)  && ((sOrder.Order_Type__c == SO_ORDER_TYPE_TRANSFER && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Sample_Order__c == false) || String.isBlank(sOrder.Brand_Quote__r.Order_Type__c)) && ((sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR) || (sOrder.Supplier_Name__r.DBA__c == Account_Plateformlevel_ZASP || sOrder.Supplier_Name__r.DBA__c == Account_Plateformlevel_IRR))){
                        
                        skipFeesForBasic = true;
                    }
                     if(sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Piggyback_sample__c == true && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == SO_ORDER_TYPE_TRANSFER){
                        mileageFee = 0;
                    }
                    if(sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Piggyback_sample__c != true && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == SO_ORDER_TYPE_TRANSFER && sOrder.Brand_Quote__r.Opportunity_Name__r.Order__r.Sample_Order__c == true){
                        totalQAReviewFee = 0;
                    }
                    Decimal distributionServiceFee = 0;
                    Boolean isDistributionService = false;
                    if(sOrder.Supplier_Name__r.Service_Type__c == Account_Service_Type_Margin || sOrder.Supplier_Name__r.Service_Type__c == Account_Service_Type_Buy_Sell ){
                        isDistributionService = true;
                        distributionServiceFee = (sOrder.Supplier_Name__r.Distribution_Fee__c != null ? sOrder.Supplier_Name__r.Distribution_Fee__c : 0 ) / 100 * totalSOAmount;
                       Decimal msFee = 0;
                            if(LCList.size() > 0)msFee = LCList[0].Minimum_Service_Fee__c != null ? LCList[0].Minimum_Service_Fee__c : 0;
                        if(distributionServiceFee > msFee){
                            distributionServiceFee =  distributionServiceFee;
                        }else{
                            distributionServiceFee = msFee;
                        }
                    }
                    Boolean createWMLines = true;
                    System.debug('##Shipping Method:'+sOrder.Shipping_Method__c);
                    //Service Type = Service
                if(!isDistributionService){
                    if( totalStorageFee > 0 && productsMap.containsKey(PRODUCT_NAME_INVENTORY_STORAGE)){
                		invoiceLines = validateProductFee(PRODUCT_NAME_INVENTORY_STORAGE,1,totalStorageFee,productsMap,invoiceLines);
            		}
                    
                    //System.debug('##Shipping Method Contains:'+sOrder.Shipping_Method__c.contains(SO_SHIPPING_METHOD_PICK_UP));
                    if( sOrder.Shipping_Method__c != NULL && sOrder.Shipping_Method__c.contains(SO_SHIPPING_METHOD_PICK_UP)){
                        //createWMLines = true;
                    }
                    if( productsMap.containsKey(PRODUCT_NAME_AGENT_FEE) && agentFee > 0){
                        invoiceLines = validateProductFee(PRODUCT_NAME_AGENT_FEE,1,agentFee,productsMap,invoiceLines);
                    }
                    /*if( sOrder.Total_Manifest_Revision__c > 0 && productsMap.containsKey(Delivery_Rescheduling_Fee_Config) && sOrder.Supplier_Name__r.Service_Type__c == 'Margin'){
                        Decimal deliveryReschedulingFee = 150;
                        invoiceLines = validateProductFee(Delivery_Rescheduling_Fee_Config,sOrder.Total_Manifest_Revision__c,deliveryReschedulingFee,productsMap,invoiceLines);
                    }*/
                    if( productsMap.containsKey(PRODUCT_NAME_DISTRIBUTION_FEE) && distributionFee > 0){
                        invoiceLines = validateProductFee(PRODUCT_NAME_DISTRIBUTION_FEE,1,distributionFee,productsMap,invoiceLines);
                    }
                    System.debug('##weightFee:'+weightFee);
                    if( !skipFees && createWMLines && weightFee > 0 && productsMap.containsKey(PRODUCT_NAME_WEIGHT_FEE)){
                        totalInvoiceAmount += weightFee;
                        invoiceLines = validateProductFee(PRODUCT_NAME_WEIGHT_FEE,1,weightFee,productsMap,invoiceLines);
                    }
                    if( !skipFees && createWMLines && mileageFee > 0 && productsMap.containsKey(PRODUCT_NAME_MILEAGE_FEE)){
                        totalInvoiceAmount += mileageFee;
                        invoiceLines = validateProductFee(PRODUCT_NAME_MILEAGE_FEE,1,mileageFee,productsMap,invoiceLines);
                    }
                    if(  sOrder.Order_Type__c != Order_Record_Type_Name_Retailer && stagingFee > 0 && productsMap.containsKey(PRODUCT_NAME_STAGE_AND_MANIFEST)){//!sOrder.Sample_Order__c &&
                        totalInvoiceAmount += stagingFee;
                        invoiceLines = validateProductFee(PRODUCT_NAME_STAGE_AND_MANIFEST,1,stagingFee,productsMap,invoiceLines);
                    }
                    if( schedulingFee > 0 && sOrder.Order_Type__c != Order_Record_Type_Name_Retailer && productsMap.containsKey(PRODUCT_NAME_SCHEDULE_AND_DISPATCH)){
                        totalInvoiceAmount += schedulingFee;
                        invoiceLines = validateProductFee(PRODUCT_NAME_SCHEDULE_AND_DISPATCH,1,schedulingFee,productsMap,invoiceLines);
                    }
                    if( has1MOQItem == true && FRTList.size() > 0 && productsMap.containsKey(PRODUCT_NAME_PACK_OUT)){
                        totalInvoiceAmount += FRTList[0].Bracket_Price__c;
                        invoiceLines = validateProductFee(PRODUCT_NAME_PACK_OUT,1,FRTList[0].Bracket_Price__c,productsMap,invoiceLines);
                    }
                    if( orderBookingFee > 0 && productsMap.containsKey(PRODUCT_NAME_ORDER_BOOKING)){
                        totalInvoiceAmount += orderBookingFee;
                        invoiceLines = validateProductFee(PRODUCT_NAME_ORDER_BOOKING,1,orderBookingFee,productsMap,invoiceLines);
                    }
                    System.debug('##totalPickPackFee:'+totalPickPackFee);
                    if( totalPickPackFee != null && totalPickPackFee > 0 && productsMap.containsKey(PRODUCT_NAME_PICK_AND_PACK_FEE)){
                        totalInvoiceAmount += totalPickPackFee;
                        invoiceLines = validateProductFee(PRODUCT_NAME_PICK_AND_PACK_FEE,1,totalPickPackFee,productsMap,invoiceLines);
                    }
                    System.debug('##totalQAReviewFee:'+totalQAReviewFee);
                    if( !skipFeesForBasic  && totalQAReviewFee != null && totalQAReviewFee > 0 && productsMap.containsKey(PRODUCT_NAME_QA_REVIEW_FEE)){
                        totalInvoiceAmount += totalQAReviewFee;
                        invoiceLines = validateProductFee(PRODUCT_NAME_QA_REVIEW_FEE,1,totalQAReviewFee,productsMap,invoiceLines);
                    }
                    if( sOrder.Change_Order_Fee__c == TRUE && productsMap.containsKey(PRODUCT_NAME_CHANGE_ORDER_FEE)){
                        Product2 p = productsMap.get(PRODUCT_NAME_CHANGE_ORDER_FEE);
                        PriceBookEntry pbe = productPBEMap.get(p.Id);
                        if(pbe != NULL){
                            totalInvoiceAmount += pbe.UnitPrice;
                            invoiceLines = validateProductFee(PRODUCT_NAME_CHANGE_ORDER_FEE,1,pbe.UnitPrice,productsMap,invoiceLines);
                        }
                    }
                    System.debug('##totalListingFee:'+totalListingFee);
                    //Listing Fee as per FG-826
                    if( sOrder.Order_Type__c == Order_Record_Type_Name_Retailer && totalListingFee != null && totalListingFee > 0 && productsMap.containsKey(PRODUCT_NAME_LISTING_FEE)){
                        invoiceLines = validateProductFee(PRODUCT_NAME_LISTING_FEE,1,totalListingFee,productsMap,invoiceLines);
                    }
                    //Apply Listing fee if Lines are more than equals to 5
                    if( totalInvoiceAmount > 0 && producerSOLinesMap.keySet().size() >= 5 && productsMap.containsKey(PRODUCT_NAME_LISTING_FEE)){
                        Product2 lateFeeProduct = productsMap.get(PRODUCT_NAME_LISTING_FEE);
                        invoiceLines = validateProductFee(PRODUCT_NAME_LISTING_FEE,1,((totalInvoiceAmount*5)/100),productsMap,invoiceLines);
                    }
                }
                    if(sOrder.Supplier_Name__r.Service_Type__c == Account_Service_Type_Service && sOrder.Total_Manifest_Change_Fee__c > 0){
                            invoiceLines = validateProductFee(Product_Name_Manifest_Change_Fee,1,sOrder.Total_Manifest_Change_Fee__c,productsMap,invoiceLines);
                        }
                    if(isDistributionService && productsMap.containsKey(PRODUCT_NAME_DISTRIBUTION_FEE) && distributionServiceFee > 0){
                            invoiceLines = validateProductFee(PRODUCT_NAME_DISTRIBUTION_FEE,1,distributionServiceFee,productsMap,invoiceLines);
                        }
                    system.debug('##invoiceLines : '+invoiceLines.size());
                    
                    if(invoiceLines.size() > 0){
                        newInvoiceMap.put(producerId,newInvoice);
                        invoiceLineMap.put(producerId,invoiceLines);
                        //i++;
                    }
                    if(POLines.size() > 0) {
                        newPOMap.put(producerId,newPO);
                        POLineMap.put(producerId,POLines);
                    }
                }
                  
            }
            system.debug('##newInvoiceMap : '+newInvoiceMap.size());
            if(newInvoiceMap.size()>0){ 
                if(!isOBCreated && sOrder.Ownership__r.Service_Type__c == Account_Service_Type_Margin && sOrder.RecordType.Name == SO_RECORDTYPE_TRANSFER && (sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || sOrder.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR)){
                    List<Account_Setting__c> accSettingList = [SELECT id,Mthly_IB__c,Max_IB__c,Account__c,Mthly_OB__c,Max_OB__c FROM Account_Setting__c WHERE Account__c = :sOrder.Ownership__c AND Active__c = true];
                    if(accSettingList.size() > 0 && accSettingList[0].Mthly_OB__c <= accSettingList[0].Max_OB__c){
                        /*String errStr = Receiving_Invoice_Not_Create.replace('{0}',''+ accSettingList[0].Mthly_OB__c );
							errStr = errStr.replace('{1}',''+ accSettingList[0].Max_OB__c );*/
                        r.data.put('ErrorMsg', Receiving_Invoice_Not_Create);
                        r.data.put('isOBCreated', true);
                        return r;
                    }
                }
                insert newInvoiceMap.values();
                List<Invoice_Line__c> linesToInsert = new List<Invoice_Line__c>();
                for(String producerId : invoiceLineMap.keyset()){
                    for(Invoice_Line__c line: invoiceLineMap.get(producerId)){
                        line.Invoice__c = newInvoiceMap.get(producerId).Id;
                        linesToInsert.add(line);
                    }
                }      
                if(linesToInsert.size() > 0){
                    insert linesToInsert;
                }
            }else{
                r.data.put('Error',ERR_SELECT_SOLINE_TO_CREATE_SERVICE_INVOICE);
            } 
            if(newPOMap.size()>0){                
                insert newPOMap.values();
                List<Purchase_Order_Line__c> POLinesToInsert = new List<Purchase_Order_Line__c>();
                for(String producerId : POLineMap.keyset()){
                    for(Purchase_Order_Line__c line: POLineMap.get(producerId)){
                        line.Purchase_Order__c = newPOMap.get(producerId).Id;
                        POLinesToInsert.add(line);
                    }
                }      
                if(POLinesToInsert.size() > 0){
                    insert POLinesToInsert;
                }
            }
            r.data.put('recordId',recordId);
        }catch(Exception e){
            System.debug('Exception:'+e.getMessage()+'==>Line:'+e.getStackTraceString());
            r.handleException(e);
            if(!Test.isRunningTest()){
                Database.rollback(sp);
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
    
    public static Invoice__c createProducerInvoice(Sales_Order__c sOrder,String producerId){
        system.debug('createProducerInvoice'+sOrder);
                system.debug('createProducerInvoice>>>>>>>>>>>>'+sOrder.Receiver_Name__r.Payment_Terms__c);
                system.debug('createProducerInvoice>>>>>>>>>>>>'+sOrder.Receiver_Name__r.Name);

        Invoice__c newInvoice = new Invoice__c();
        newInvoice.Sales_Order__c = sOrder.Id;
        newInvoice.AR_Status__c = Invoice_Ar_Status_Approved;
        newInvoice.Opportunity_Name__c = sOrder.Opportunity_Name__c;
        newInvoice.Distributor_Name__c = sOrder.Distributor_Name__c;
        newInvoice.Distributor_License__c = sOrder.Distributor_License__c;
        newInvoice.Distributor_Contact__c = sOrder.Distributor_Contact__c;
        newInvoice.Invoice_Memo__c = sOrder.Sales_Order_Instructions__c;
        newInvoice.Supplier_Name__c = sOrder.Supplier_Name__c;
        newInvoice.Supplier_License__c = sOrder.Supplier_License__c;
        newInvoice.Supplier_Contact__c = sOrder.Supplier_Contact__c;
        newInvoice.Receiver_Name__c = producerId;
        //newInvoice.Receiver_License__c = sOrder.Supplier_License__c;
        //newInvoice.Receiver_Contact__c = sOrder.Supplier_Contact__c;
        newInvoice.Site__c = sOrder.Site__c;
        newInvoice.Shipped_Date__c = sOrder.Planned_Ship_Date__c;
        newInvoice.Sample_Order__c = sOrder.Sample_Order__c;
        newInvoice.AR_Type__c = sOrder.SO_Type__c;
        newInvoice.Customer_PO_or_Quote__c = sOrder.Customer_PO_or_Quote__c;
        newInvoice.Brand_Quote__c = sOrder.Brand_Quote__c;
        newInvoice.Shipping_Terms__c = sOrder.Shipping_Terms__c;
        newInvoice.Shipping_Method__c = sOrder.Shipping_Method__c;
        newInvoice.Ownership__c = sOrder.Ownership__c;
        newInvoice.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_SERVICE).getRecordTypeId();
        newInvoice.Invoice_Due_Date__c     = InvoiceSupport.calculateInvoiceDueDate(sOrder.Ship_Confirmation_Date__c,sOrder.Planned_Ship_Date__c,
                                                                                    newInvoice.Payment_Terms__c);
        newInvoice.Retailer_PO__c = sOrder.Retailer_PO__c;
           system.debug('sOrder.Receiver_Name__c'+sOrder.Receiver_Name__c);
          system.debug('producerId'+producerId);
      
        
        Company_Custom_Settings__c companySettingRec = Company_Custom_Settings__c.getOrgDefaults();
        system.debug('## companySettingRec :'+companySettingRec);
        if(sOrder.Site__r.Name.equals(SITE_NAME_7027)){
            //newInvoice.Receiver_Name__c = companySettingRec.Default_Distributor__c;
            //newInvoice.Receiver_License__c = companySettingRec.Default_License__c;
            
            newInvoice.Distributor_Name__c = companySettingRec.Second_Warehouse_Id__c;
            newInvoice.Distributor_License__c = companySettingRec.Second_Warehouse_License__c;
        }
        
        if(sOrder.Site__r.Name.equals(SITE_NAME_2089)){
            newInvoice.Distributor_Name__c = companySettingRec.Default_Distributor__c;
            newInvoice.Distributor_License__c = companySettingRec.Default_License__c;
        }
        
        return newInvoice;
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
    public Static Purchase_Order__c createPO(Sales_Order__c sOrder,Company_Custom_Settings__c companySettingRec){
        Purchase_Order__c newPO = new Purchase_Order__c();
        newPO.Brand_Quote__c = sOrder.Brand_Quote__c;
        newPO.PO_Status__c = PURCHASE_ORDER_STATUS_DRAFT;
        newPO.PO_Type__c = sOrder.Brand_Quote__r.RecordType.Name;
        newPO.PO_Date__c = Date.today();
        newPO.Opportunity_Name__c = sOrder.Brand_Quote__r.Opportunity_Name__c;
        newPO.Payment_Terms__c = sOrder.Brand_Quote__r.Payment_Terms__c;
        newPO.Distributor_Contact__c = companySettingRec.Default_Contact__c;
        newPO.Distributor_Name__c = companySettingRec.Default_Distributor__c;
        newPO.Distributor_License__c = companySettingRec.Default_License__c;
        newPO.Receiver_Name__c = companySettingRec.Default_Distributor__c;
        newPO.Receiver_License__c =companySettingRec.Default_License__c;
        newPO.Receiver_Contact__c = companySettingRec.Default_Contact__c;
        newPO.RecordTypeId = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_RECORDTYPE_INVOICE_ONLY).getRecordTypeId();//sOrder.Brand_Quote__r.RecordTypeId;
        newPO.Site__c = sOrder.Brand_Quote__r.Site__c;
        newPO.Planned_Ship_Transfer_Date__c = sOrder.Brand_Quote__r.Planned_Transfer_Date__c;
        return newPO;    
    }
    public static Purchase_Order_Line__c[] createPOLine(Sales_Order_Line__c[] SOLIs,Sales_Order__c sOrder){
        if(SOLIs.size() > 0){
            List<Purchase_Order_Line__c> POLIs = new List<Purchase_Order_Line__c>();
            For(Sales_Order_Line__c sol : SOLIs){
                Purchase_Order_Line__c newPOLI = new Purchase_Order_Line__c();
                newPOLI.Brand_Quote_Line__c = sol.Brand_Quote_Line__c;
                newPOLI.Product_Name__c =  sol.Brand_Quote_Line__r.Product_Name__c;
                newPOLI.Product_Title__c =  sol.Brand_Quote_Line__r.Product_Title__c; 
                newPOLI.Qty_Ordered__c = sol.Brand_Quote_Line__r.Line_Total_Qty__c;
                newPOLI.Unit_Cost__c = sol.Brand_Quote_Line__r.Retail_Wholesale_Price__c ;
                newPOLI.Is_Sample__c = sol.Brand_Quote_Line__r.Is_Sample__c;
                newPOLI.RecordTypeId = Schema.SObjectType.Purchase_Order_Line__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_LINE_RECORDTYPE_INVOICE_ONLY).getRecordTypeId();
                if(! Test.isRunningTest()) 
                    newPOLI.Ownership_Code__c = sol.Brand_Quote_Line__r.Ownership_Code__c == null ? sOrder.Brand_Quote__r.Ownership__c : sol.Brand_Quote_Line__r.Ownership_Code__c;            
                POLIs.add(newPOLI);
            }
            return POLIs;
        }
        return NULL;
    }
    public class ProducerDetails{
        @AuraEnabled
        public Boolean isSelected {get; set;}
        @AuraEnabled
        public String producerName {get; set;}
        @AuraEnabled
        public String producerId {get; set;}
        @Auraenabled 
        public Integer rowSpan{get;set;}
        @Auraenabled 
        public SOLineDetails SOLine{get;set;}        
        public ProducerDetails(String producerId,String producerName,Integer rowSpan,SOLineDetails SOLine){
            this.isSelected = false;
            this.producerId = producerId;
            this.producerName = producerName;
            this.rowSpan = rowSpan;
            this.SOLine = SOLine;
        }
    }
    public class SOLineDetails{
        @AuraEnabled
        public Boolean isSelected {get; set;}
        @AuraEnabled 
        public Sales_Order_Line__c SOLine {get; set;}        
        public SOLineDetails(Sales_Order_Line__c SOLine){
            this.isSelected = false;         
            this.SOLine = SOLine;
        }
    }
}