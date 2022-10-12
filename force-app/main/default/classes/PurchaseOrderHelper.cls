/**************************************************************************************
Apex Class Name    : PurchaseOrderHelper
Test Class Name    : 
Version            : 1.0
Created Date       : 19/Feb/2020
Function           : Used for updating the BQL.Billed_Quantity__c  on cancellation of PO. 
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresha Shettigar           19/Feb/2020              Original Version
*******************************************************************************/
Public class PurchaseOrderHelper{
    private static String PAYMENT_TERMS_COD = 'COD';
    private Static String PRODUCT_NAME_MILEAGE_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_MILEAGE_FEE) ? PRODUCT_NAME_MILEAGE_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Mileage_Fee');
        }set;
    }
    public Static String PRODUCT_NAME_PICK_AND_PACK_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_PICK_AND_PACK_FEE) ? PRODUCT_NAME_PICK_AND_PACK_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Pick_And_Pack_Fee');
        }set;
    }
    public Static String PRODUCT_NAME_QA_REVIEW_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_QA_REVIEW_FEE) ? PRODUCT_NAME_QA_REVIEW_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_QA_Review');
        }set;
    }
    public Static String PRODUCT_NAME_ORDER_BOOKING{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_ORDER_BOOKING) ? PRODUCT_NAME_ORDER_BOOKING :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Order_Booking');
        }set;
    }
    public Static String PRODUCT_NAME_PACK_OUT{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_PACK_OUT) ? PRODUCT_NAME_PACK_OUT :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Pack_Out');
        }set;
    }
    private Static String PRODUCT_NAME_WEIGHT_FEE{ 
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
    public Static String PRODUCT_NAME_CHANGE_ORDER_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_CHANGE_ORDER_FEE) ? PRODUCT_NAME_CHANGE_ORDER_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Change_Order_Fee');
        }set;
    }
    public Static String STANDARD_PRICE_BOOK {
        get{
            return String.isNotBlank(STANDARD_PRICE_BOOK) ? STANDARD_PRICE_BOOK:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Pricebook','STANDARD_PRICE_BOOK');
        }set;
    }
    public static String Invoice_Ar_Status_Approved{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Approved) ? Invoice_Ar_Status_Approved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Approved');
        }set;
    }
    private static String Invoice_Ar_Status_Shipped{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Shipped) ? Invoice_Ar_Status_Shipped : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Shipped');
        }set;
    }
    private Static String INVOICE_RECORDTYPE_SERVICE { 
        get{
            return  String.isNotBlank(INVOICE_RECORDTYPE_SERVICE) ? INVOICE_RECORDTYPE_SERVICE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
    private Static String PO_Shipping_Method_Drop_Off{ 
        get{
            return  String.isNotBlank(PO_Shipping_Method_Drop_Off) ? PO_Shipping_Method_Drop_Off :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Shipping_Method_Drop_Off');
        }set;
    }
    private Static String INVOICE_LINE_RECORDTYPE_SERVICE { 
        get{
            return  String.isNotBlank(INVOICE_LINE_RECORDTYPE_SERVICE) ? INVOICE_LINE_RECORDTYPE_SERVICE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice Line','Invoice_Line_RecordType_Service');
        }set;
    }
    private static String Label_Not_For_Resale_Product{
        get{
            return String.isNotBlank(Label_Not_For_Resale_Product) ? Label_Not_For_Resale_Product : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Label_Not_For_Resale_Product');
        }set;
    }
    private static String Sample_Product_Price{
        get{
            return String.isNotBlank(Sample_Product_Price) ? Sample_Product_Price : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Sample_Product_Price');
        }set;
    }
    private static String Invoice_Ar_Type_Services{
        get{
            return String.isNotBlank(Invoice_Ar_Type_Services) ? Invoice_Ar_Type_Services : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Type_Services');
        }set;
    }
    private Static String PRODUCT_NAME_SERVICE_SCHEDULING_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_SERVICE_SCHEDULING_FEE) ? PRODUCT_NAME_SERVICE_SCHEDULING_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Service_Scheduling_Fee');
        }set;
    }
    private Static String PRODUCT_NAME_SERVICE_STAGING_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_SERVICE_STAGING_FEE) ? PRODUCT_NAME_SERVICE_STAGING_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Service_Staging_Fee');
        }set;
    }
    private Static String PRODUCT_NAME_BOOKING_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_BOOKING_FEE) ? PRODUCT_NAME_BOOKING_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Booking_Fee');
        }set;
    }
    private Static String PRODUCT_NAME_RECEIVING_FEE{ 
        get{
            return  String.isNotBlank(PRODUCT_NAME_RECEIVING_FEE) ? PRODUCT_NAME_RECEIVING_FEE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Receiving_Fee');
        }set;
    }
    private static String ACCOUNT_PLATEFORMLEVEL_ADVANCE {
        get{
            return String.isNotBlank(ACCOUNT_PLATEFORMLEVEL_ADVANCE ) ? ACCOUNT_PLATEFORMLEVEL_ADVANCE  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Plateformlevel_Advance');
        }set;
    }
    private static String ACCOUNT_PLATEFORMLEVEL_BASIC {
        get{
            return String.isNotBlank(ACCOUNT_PLATEFORMLEVEL_BASIC ) ? ACCOUNT_PLATEFORMLEVEL_BASIC  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Plateformlevel_Basic');
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
    public Static String TYPE_BUYQUOTE{ 
        get{
            return  String.isNotBlank(TYPE_BUYQUOTE) ? TYPE_BUYQUOTE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuoteType_BuyQuote');
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
    private static String STATE_LICENSE_ACTIVE{
        get{
            return String.isNotBlank(STATE_LICENSE_ACTIVE) ? STATE_LICENSE_ACTIVE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_Active');
        }set;
    }
    private static String FULFILLMENT_SERVICE_QA_REVIEW{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_QA_REVIEW) ? FULFILLMENT_SERVICE_QA_REVIEW : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_QA_Review');
        }set;
    }
    public Static String SO_SHIPPING_METHOD_PICK_UP{ 
        get{
            return  String.isNotBlank(SO_SHIPPING_METHOD_PICK_UP) ? SO_SHIPPING_METHOD_PICK_UP :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Shipping_Method_Pick_Up');
        }set;
    }
    public Static String PURCHASE_ORDER_RECORDTYPE_PRODUCT{
        get{
            return String.isNotBlank(PURCHASE_ORDER_RECORDTYPE_PRODUCT) ? PURCHASE_ORDER_RECORDTYPE_PRODUCT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Record_Type_DevName_Product');
        }set;
    }
    private Static String Account_Service_Type_Margin {		
        get{
              return String.isNotBlank(Account_Service_Type_Margin) ? Account_Service_Type_Margin : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Service_Type_Margin');
        }set;
    }
    Public static void updateBrandQuote(List<Id> bqIds){
        List<Brand_Quote__c> bqList= new List<Brand_Quote__c>();
        for(Brand_Quote__c bq : [SELECT id, PO_Created__c FROM Brand_Quote__c WHERE id IN :bqIds]){
            bq.PO_Created__c = true;
            bqList.add(bq);
        }
        if(bqList.size() > 0){
            update bqList;
        }
    }
    Public static void updateBrandQuoteLineQty(List<ID> purchaseOrderIDList){
        List<Purchase_Order__c> purchaseOrderList = [select id ,(select id,Qty_Ordered__c,Brand_Quote_Line__c,Brand_Quote_Line__r.Billed_Quantity__c from Purchase_Order_Lines__r)from Purchase_Order__c where ID =: purchaseOrderIDList];
        List<Brand_Quote_Line__c> bqLList= new List<Brand_Quote_Line__c>();
        for(Purchase_Order__c var:purchaseOrderList){
            for(Purchase_Order_Line__c polVar:var.Purchase_Order_Lines__r){
                Brand_Quote_Line__c bql = new Brand_Quote_Line__c();
                bql.Billed_Quantity__c =polVar.Brand_Quote_Line__r.Billed_Quantity__c - polVar.Qty_Ordered__c;
                bql.id = polVar.Brand_Quote_Line__c;
                bqLList.add(bql);
            }
        }
        update bqLList;
    }
    public static void createServiceInvoice(Set<String>POIdSet){ 
        String invoiceLineRecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get(INVOICE_LINE_RECORDTYPE_SERVICE).getRecordTypeId();	    
        Set<String> serviceFeeProductSet = new Set<String>{PRODUCT_NAME_MILEAGE_FEE,PRODUCT_NAME_WEIGHT_FEE,PRODUCT_NAME_BOOKING_FEE,PRODUCT_NAME_SERVICE_STAGING_FEE,PRODUCT_NAME_SERVICE_SCHEDULING_FEE,PRODUCT_NAME_RECEIVING_FEE};
        Product2[] products = [SELECT Id,Name FROM Product2 WHERE Name IN: serviceFeeProductSet]; 
        Map<String, Product2> productsMap = new Map<String,Product2>();
        for(Product2 p: products){
            productsMap.put(p.Name,p);
        }
        List<Company_Custom_Settings__c> defaultIDs = [SELECT Default_Distributor__c,Default_License__c,Default_Contact__c FROM Company_Custom_Settings__c];
    	
        Map<String,Invoice__c>invoiceMap = new Map<String,Invoice__c>();
        Map<String,List<Invoice_Line__c>>invoiceLineMap = new Map<String,List<Invoice_Line__c>>();
        List<Purchase_Order__c> POList = [select Id,name,Distributor_Name__c,Distributor_License__c,Distributor_Contact__c,Ownership__r.Type,
                                          Purchase_Order_Instructions__c,Ownership__r.Payment_Terms__c,Ownership__r.Platform_Level__c,Ownership__r.Service_Type__c,
            Receiver_Name__r.Membership_Level__c,Ship_Confirmation_Date__c,Shipping_Terms__c,Site__r.Name,Total_Weight_lbs__c,
			Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,Site__c,Shipping_Method__c,
            Brand_Quote__r.recordtype.Name,Brand_Quote__r.Order_Type__c,Receiver_Name__r.DBA__c,Payment_Eligible__c,RecordType.Name,
			Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c,Supplier_Name__c,Supplier_License__c,
			Supplier_Contact__c,Brand_Quote__r.Distributor_Name__c,Receiver_Name__c,Total_Mileage_Fee__c,Brand_Quote__c,
			Brand_Quote__r.Distributor_License__c,Brand_Quote__r.Distributor_Contact__c,Brand_Quote__r.Supplier_Name__c,
			Brand_Quote__r.Supplier_License__c,Brand_Quote__r.Supplier_Contact__c,Receiver_License__c,Receiver_Contact__c,
			Opportunity_Name__c,Planned_Ship_Transfer_Date__c,Sample_Order__c,Customer_PO_or_Quote__c,Payment_Terms__c,
			PO_Type__c,Ownership__c,Total_Weight_Fee__c,Order_Type__c,Supplier_Name__r.Membership_Level__c,Receiving_Fee__c,
			Service_Booking_Fee__c,Service_Scheduling_Fee__c,Service_Staging_Fee__c, Goods_Receipt_Date__c ,(SELECt Id,Product_Name__c,Qty_Ordered__c,
			Purchase_Order__c,Total_Weight_lbs__c,Receiving_Fee__c,Weight_to_Order_Ratio__c,Weight_to_Mileage_Fee__c,
			Unit_Cost__c FROM Purchase_Order_Lines__r) from Purchase_Order__c where id IN: POIdSet];
        
        Company_Custom_Settings__c companySettingRec = Company_Custom_Settings__c.getOrgDefaults();
        Set<Id> PO_Owner_Ids = new Set<Id>();
        //Set<String> mambershipLevel = new Set<String>();
        for(Purchase_Order__c PO : POList){ 
        	PO_Owner_Ids.add(PO.Ownership__c);
        }
        Map<id,List<State_Licenses__c>> statelicenses = new Map<id,List<State_Licenses__c>>();
        Map<Id,List<Contact>> distributorContacts =new Map<Id,List<Contact>>();
        //Set<Id> SiteIds = new Set<Id>();
        for(State_Licenses__c st :[SELECT License_Name__c,id,RecordType.Name,Default_Warehouse__c FROM State_Licenses__c WHERE License_Name__c IN : PO_Owner_Ids AND RecordType.Name =: STATE_LICENSE_NONCANNABIS_RECORDTYPE AND License_Status__c = : STATE_LICENSE_ACTIVE ORDER BY CreatedDate ASC]){
            if(statelicenses.containsKey(st.License_Name__c)) {
                List<State_Licenses__c> statelicense = statelicenses.get(st.License_Name__c);
                statelicense.add(st);
                statelicenses.put(st.License_Name__c, statelicense);
            } else {
                statelicenses.put(st.License_Name__c, new List<State_Licenses__c> { st });
            }
            //SiteIds.add(st.Default_Warehouse__c);
        }
        for(Contact con :[SELECT AccountId,Id FROM Contact WHERE AccountId IN : PO_Owner_Ids AND Active__c = true ORDER BY CreatedDate ASC]){
            if(distributorContacts.containsKey(con.AccountId)) {
                List<Contact> conList = distributorContacts.get(con.AccountId);
                conList.add(con);
                distributorContacts.put(con.AccountId, conList);
            } else {
                distributorContacts.put(con.AccountId, new List<Contact> { con });
            }
        }
        /*Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c,Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c,Membership_Level__c
                                                 FROM Fulfillment_Rates_Table__c 
                                                 WHERE Site__c IN : SiteIds
                                                 AND Active__c = true
                                                 AND Rate_Effective_From__c <= :System.today()
                                                 AND Rate_Effective_To__c >= :System.today()
                                                 AND Membership_Level__c = :membershipLevel
                                                ORDER BY Weight_lbs__c DESC, MOQ__c DESC];*/
        Map<Id,Account_Setting__c> aSettingMap = new Map<Id,Account_Setting__c>();
        
        for(Account_Setting__c aSetting : [SELECT id,Mthly_IB__c,Max_IB__c,Account__c FROM Account_Setting__c WHERE Account__c IN : PO_Owner_Ids AND Active__c = true]){
           
            aSettingMap.put(aSetting.Account__c,aSetting);
        }
            
        for(Purchase_Order__c PO : POList){    
            Boolean isValidSI = true;
            if(aSettingMap.containsKey(PO.Ownership__c) && PO.Ownership__r.Service_Type__c == Account_Service_Type_Margin   && (PURCHASE_ORDER_RECORDTYPE_PRODUCT == PO.RecordType.Name || PO.Goods_Receipt_Date__c == null)){
                Account_Setting__c aSetting = aSettingMap.get(PO.Ownership__c);
                if(aSetting != null && aSetting.Mthly_IB__c <= aSetting.Max_IB__c)
                	isValidSI= false;
            }
            system.debug('##isValidSI : '+isValidSI);
            if(isValidSI){
            
            Invoice__c newInvoice = new Invoice__c();
            newInvoice.Purchase_Order__c = PO.Id;
            newInvoice.AR_Status__c = Invoice_Ar_Status_Shipped;
            newInvoice.Opportunity_Name__c = PO.Opportunity_Name__c;
            newInvoice.Invoice_Memo__c = PO.Purchase_Order_Instructions__c;
            newInvoice.Distributor_Name__c = PO.Distributor_Name__c;
            newInvoice.Distributor_License__c = PO.Distributor_License__c;
            newInvoice.Distributor_Contact__c = PO.Distributor_Contact__c;

            if(defaultIDs.size() >0){
                if(defaultIDs[0].Default_Distributor__c != null){
                    newInvoice.Supplier_Name__c = defaultIDs[0].Default_Distributor__c;
                }    
                if(defaultIDs[0].Default_License__c != null){
                    newInvoice.Supplier_License__c = defaultIDs[0].Default_License__c;
                }    
                if(defaultIDs[0].Default_Contact__c != null){
                    newInvoice.Supplier_Contact__c = defaultIDs[0].Default_Contact__c;
                }    
            }
            newInvoice.Receiver_Name__c = PO.Supplier_Name__c;
            newInvoice.Receiver_License__c = PO.Supplier_License__c;
            newInvoice.Receiver_Contact__c = PO.Supplier_Contact__c;
            newInvoice.Site__c = PO.Site__c;
            newInvoice.Shipped_Date__c = PO.Planned_Ship_Transfer_Date__c;
            newInvoice.Sample_Order__c = PO.Sample_Order__c;
            newInvoice.AR_Type__c = Invoice_Ar_Type_Services;
            newInvoice.Customer_PO_or_Quote__c = PO.Customer_PO_or_Quote__c;
            newInvoice.Brand_Quote__c = PO.Brand_Quote__c;
            newInvoice.Shipping_Terms__c = PO.Shipping_Terms__c;
            newInvoice.Shipping_Method__c = PO.Shipping_Method__c;
            newInvoice.Payment_Terms__c = PO.Ownership__r.Payment_Terms__c;
            newInvoice.Ownership__c = PO.Ownership__c;
            newInvoice.Total_Mileage_Fee__c = PO.Total_Mileage_Fee__c;
            newInvoice.Total_Weight_Fee__c = PO.Total_Weight_Fee__c;
            newInvoice.Service_Booking_Fee__c = PO.Service_Booking_Fee__c;
            newInvoice.Service_Scheduling_Fee__c = PO.Service_Scheduling_Fee__c;
            newInvoice.Service_Staging_Fee__c = PO.Service_Staging_Fee__c;
            newInvoice.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_SERVICE).getRecordTypeId();
            newInvoice.Ship_Confirmation_Date__c = (PO.Goods_Receipt_Date__c != NULL ?PO.Goods_Receipt_Date__c.date():NULL);
            newInvoice.Invoice_Due_Date__c = InvoiceSupport.calculateInvoiceDueDate(newInvoice.Ship_Confirmation_Date__c,PO.Planned_Ship_Transfer_Date__c,newInvoice.Payment_Terms__c);			
            
            
            if(PO.Ownership__r.Type == ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER){
                newInvoice.Ownership__c = companySettingRec.Default_Distributor__c;
                
            }else{
                newInvoice.Ownership__c = companySettingRec.Default_Distributor__c;
            }
            if(PO.Ownership__r.Type == ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER){
                newInvoice.Receiver_Name__c = PO.Ownership__c;
                newInvoice.Receiver_License__c = statelicenses.get(PO.Ownership__c) != NULL ?statelicenses.get(PO.Ownership__c)[0].id:NULL;
                newInvoice.Receiver_Contact__c = distributorContacts.get(PO.Ownership__c)!=NULL?distributorContacts.get(PO.Ownership__c)[0].id:NULL;
                
            }else{
                newInvoice.Receiver_Name__c = PO.Supplier_Name__c;
                newInvoice.Receiver_License__c = PO.Supplier_License__c;
                newInvoice.Receiver_Contact__c = PO.Supplier_Contact__c;
            }
            
            Boolean skipFees = false;
            Boolean skipFeesForBasic = false;
            System.debug('##BQ Record Type:'+PO.Brand_Quote__r.recordtype.Name);
            System.debug('##Order Type :'+PO.Brand_Quote__r.Order_Type__c);
            /*
            if(PO.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE && PO.Brand_Quote__r.recordtype.Name == TYPE_BUYQUOTE && (PO.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || PO.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR) && (PO.Brand_Quote__r.Order_Type__c == 'Transfer' || String.isBlank(PO.Brand_Quote__r.Order_Type__c))){
                skipFees = true;
            }
            if(PO.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_BASIC && PO.Payment_Eligible__c != true && PO.Brand_Quote__r.Order_Type__c == 'Transfer' && (PO.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || PO.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR)){
                
                skipFeesForBasic = true;
            }*/
            System.debug('##skipFees :'+skipFees);
            List<Invoice_Line__c> invoiceLines = new List<Invoice_Line__c>();
            Boolean createWMLines = false;//PO_Shipping_Method_Drop_Off
            if(PO.Shipping_Method__c != NULL && PO.Shipping_Method__c.contains(SO_SHIPPING_METHOD_PICK_UP))
                createWMLines = true;
            if(PO.Brand_Quote__r.Order_Type__c == '' || PO.Brand_Quote__r.Order_Type__c == null){
                if(createWMLines && PO.Total_Weight_Fee__c != null && PO.Total_Weight_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_WEIGHT_FEE))
                    invoiceLines = validateProductFee(productsMap.get(PRODUCT_NAME_WEIGHT_FEE),1,PO.Total_Weight_Fee__c,productsMap,invoiceLines,invoiceLineRecordTypeId);
                if( createWMLines && PO.Total_Mileage_Fee__c != null && PO.Total_Mileage_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_MILEAGE_FEE))
                    invoiceLines = validateProductFee(productsMap.get(PRODUCT_NAME_MILEAGE_FEE),1,PO.Total_Mileage_Fee__c,productsMap,invoiceLines,invoiceLineRecordTypeId);
                if( PO.Service_Booking_Fee__c != null && PO.Service_Booking_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_BOOKING_FEE))
                    invoiceLines = validateProductFee(productsMap.get(PRODUCT_NAME_BOOKING_FEE),1,PO.Service_Booking_Fee__c,productsMap,invoiceLines,invoiceLineRecordTypeId);
                if(PO.Service_Scheduling_Fee__c != null && PO.Service_Scheduling_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_SERVICE_SCHEDULING_FEE))
                    invoiceLines = validateProductFee(productsMap.get(PRODUCT_NAME_SERVICE_SCHEDULING_FEE),1,PO.Service_Scheduling_Fee__c,productsMap,invoiceLines,invoiceLineRecordTypeId);
                if(PO.Service_Staging_Fee__c != null && PO.Service_Staging_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_SERVICE_STAGING_FEE))
                    invoiceLines = validateProductFee(productsMap.get(PRODUCT_NAME_SERVICE_STAGING_FEE),1,PO.Service_Staging_Fee__c,productsMap,invoiceLines,invoiceLineRecordTypeId);
                
            }
                
            if( PO.Receiving_Fee__c != null && PO.Receiving_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_RECEIVING_FEE))
                invoiceLines = validateProductFee(productsMap.get(PRODUCT_NAME_RECEIVING_FEE),1,PO.Receiving_Fee__c,productsMap,invoiceLines,invoiceLineRecordTypeId);
            
            
            invoiceMap.put(PO.Id,newInvoice);                        
            
            invoiceLineMap.put(PO.Id,invoiceLines);
            }
        }
        if(!invoiceLineMap.isEmpty()){
             insert invoiceMap.Values();
            List<Invoice_Line__c>invoiceLineList = new List<Invoice_Line__c>();
            for(String PoId : invoiceMap.keySet()){
                List<Invoice_Line__c>invLineList = invoiceLineMap.get(PoId);
                for(Invoice_Line__c invLine : invLineList){
                	invLine.Invoice__c = invoiceMap.get(PoId).Id;     
                }
                invoiceLineList.addAll(invLineList);
            }
            insert invoiceLineList;
        }
           
                
        
    }
    private static List<Invoice_Line__c>  validateProductFee(Product2 p,Decimal qty,Decimal fee,Map<String, Product2> productsMap, List<Invoice_Line__c> invoiceLines,String invoiceLineRecordTypeId){
        if(p != null){
            Invoice_Line__c line = createInvoiceLine(p,qty,fee,invoiceLineRecordTypeId);
            if(line != null){
                invoiceLines.add(line);
            }
        }
        return invoiceLines;
    }
    private static Invoice_Line__c createInvoiceLine(Product2 product,Decimal qty, Decimal fee,String invoiceLineRecordTypeId){
        if(product != NULL){
            Invoice_Line__c invLineItem = new Invoice_Line__c();
            invLineItem.Product_Name__c = product.Id;
            invLineItem.Invoice_Qty__c = qty;
            invLineItem.Retail_Wholesale_Price__c = fee;
            invLineItem.RecordTypeId = invoiceLineRecordTypeId;
            return invLineItem;
        }
        return NULL;
    }
    
    
     public static void updateWinStartEnd(List<Purchase_Order__c> newSOList, Map<Id, Purchase_Order__c> oldSalesOrderMap)   {
        Set<Id> poIds = new Set<Id>();
            for(Purchase_Order__c po: newSOList){
                if(po.Planned_Ship_Transfer_Date__c != oldSalesOrderMap.get(po.Id).Planned_Ship_Transfer_Date__c || po.Vehicle__c != oldSalesOrderMap.get(po.Id).Vehicle__c || po.Driver__c != oldSalesOrderMap.get(po.Id).Driver__c  || po.Window_Start__c != oldSalesOrderMap.get(po.Id).Window_Start__c || po.Window_End__c != oldSalesOrderMap.get(po.Id).Window_End__c  || po.Priority__c != oldSalesOrderMap.get(po.Id).Priority__c){
                   poIds.add(po.Id);                      
                }
            }
         List<Purchase_Order__c> poCheck = [select Id, Window_Start__c,Priority__c,Window_End__c,Driver__c,Vehicle__c,Planned_Ship_Transfer_Date__c,(SELECT Id FROM Shipping_Manifests__r)FROM Purchase_Order__c WHERE ID IN :poIds];
          List<Shipping_Manifest__c> updateList = new List<Shipping_Manifest__c>();
           if(poCheck.size()>0){
               for(Purchase_Order__c po: poCheck){
                   for(Shipping_Manifest__c sm: po.Shipping_Manifests__r){
                       sm.Window_Start__c = po.Window_Start__c;
                       sm.Window_End__c = po.Window_End__c;
                       sm.Priority__c = po.Priority__c;
                       sm.Driver__c = po.Driver__c != null ? po.Driver__c : null ;
                       sm.Vehicle__c = po.Vehicle__c != null ? po.Vehicle__c : null;
                       sm.Planned_Ship_Transfer_Date__c = po.Planned_Ship_Transfer_Date__c != null ? po.Planned_Ship_Transfer_Date__c : null;
                       updateList.add(sm);
                   }
               }
               update updateList;
           }
    }
}