public class PurchaseOrderCreateInvoiceController {
    
    private static String PAYMENT_TERMS_COD = 'COD';
    public Static String PURCHASE_ORDER_STATUS_APPROVED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_APPROVED) ? PURCHASE_ORDER_STATUS_APPROVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase_Order_Status_Approved');
        }set;
    }
    private static String Invoice_Ar_Status_Shipped{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Shipped) ? Invoice_Ar_Status_Shipped : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Shipped');
        }set;
    }
    private Static String INVOICE_RECORDTYPE_SERVICE{
        get{
            return String.isNotBlank(INVOICE_RECORDTYPE_SERVICE) ? INVOICE_RECORDTYPE_SERVICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
    public Static String SITE_NAME_7027{ 
        get{
            return  String.isNotBlank(SITE_NAME_7027) ? SITE_NAME_7027 :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Site','Site_Name_7027');
        }set;
    }
    public Static String SITE_NAME_2089{ 
        get{
            return  String.isNotBlank(SITE_NAME_2089) ? SITE_NAME_2089 :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Site','Site_Name_2089');
        }set;
    }
    public Static String PURCHASE_ORDER_RECORDTYPE_PRODUCT{
        get{
            return String.isNotBlank(PURCHASE_ORDER_RECORDTYPE_PRODUCT) ? PURCHASE_ORDER_RECORDTYPE_PRODUCT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Record_Type_DevName_Product');
        }set;
    }
    public Static String PURCHASE_ORDER_STATUS_CLOSED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_CLOSED) ? PURCHASE_ORDER_STATUS_CLOSED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase_Order_Status_Closed');
        }set;
    }
    
    public Static String Err_Msg_PO_Create_Service_Invoice{
        get{
            return String.isNotBlank(Err_Msg_PO_Create_Service_Invoice) ? Err_Msg_PO_Create_Service_Invoice: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Err_Msg_PO_Create_Service_Invoice');
        }set;
    }
    
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
    private Static String INVOICE_LINE_RECORDTYPE_SERVICE { 
        get{
            return  String.isNotBlank(INVOICE_LINE_RECORDTYPE_SERVICE) ? INVOICE_LINE_RECORDTYPE_SERVICE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice Line','Invoice_Line_RecordType_Service');
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
    private static String Invoice_Ar_Type_Services{
        get{
            return String.isNotBlank(Invoice_Ar_Type_Services) ? Invoice_Ar_Type_Services : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Type_Services');
        }set;
    }
    public static String Invoice_Ar_Status_Approved{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Approved) ? Invoice_Ar_Status_Approved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Approved');
        }set;
    }
    public Static String PO_Shipping_Method_Drop_Off{ 
        get{
            return  String.isNotBlank(PO_Shipping_Method_Drop_Off) ? PO_Shipping_Method_Drop_Off :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Shipping_Method_Drop_Off');
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
    public Static String SO_SHIPPING_METHOD_PICK_UP{ 
        get{
            return  String.isNotBlank(SO_SHIPPING_METHOD_PICK_UP) ? SO_SHIPPING_METHOD_PICK_UP :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Shipping_Method_Pick_Up');
        }set;
    }
     private Static String Account_Service_Type_Margin {		
        get{
              return String.isNotBlank(Account_Service_Type_Margin) ? Account_Service_Type_Margin : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Service_Type_Margin');
        }set;
    }
    private Static String Err_Msg_PO_Not_Created_Service_Invoice {		
        get{
              return String.isNotBlank(Err_Msg_PO_Not_Created_Service_Invoice) ? Err_Msg_PO_Not_Created_Service_Invoice : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Err_Msg_PO_Not_Created_Service_Invoice');
        }set;
    }
	@Auraenabled
    public static AuraResponse getRecordName(Id recordId){
        AuraResponse r = new AuraResponse('PurchaseOrderCreateInvoiceController.getRecordName()');
        String objName = recordId.getSObjectType().getDescribe().getName();
        System.debug(objName);
        String q = 'SELECT Name FROM ' + objName + ' WHERE Id=\'' + recordId + '\'';
        List<SObject> records = Database.query(q);
        if(records.size()>0){
            r.data.put('name', (String) (records[0].get('Name')));
        }
        return r;
    }
    
    @Auraenabled
    public static AuraResponse createCTI(Id recordId){
        AuraResponse r = new AuraResponse('CreateCTIfromPO.createCTILight()');
        r = CreateCTIfromPO.createCTILight(recordId);
        return r;
    }
    
    @Auraenabled
    public static AuraResponse createInvoice(Id recordId,Boolean isOBCreated){
        AuraResponse r = new AuraResponse('PurchaseOrderCreateInvoiceController.createInvoice()');
        
        String invoiceLineRecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get(INVOICE_LINE_RECORDTYPE_SERVICE).getRecordTypeId();	    
        Set<String> serviceFeeProductSet = new Set<String>{PRODUCT_NAME_MILEAGE_FEE,PRODUCT_NAME_WEIGHT_FEE,PRODUCT_NAME_BOOKING_FEE,PRODUCT_NAME_SERVICE_STAGING_FEE,PRODUCT_NAME_SERVICE_SCHEDULING_FEE,PRODUCT_NAME_RECEIVING_FEE};
        Product2[] products = [SELECT Id,Name FROM Product2 WHERE Name IN: serviceFeeProductSet]; 
        Map<String, Product2> productsMap = new Map<String,Product2>();
        for(Product2 p: products){
            productsMap.put(p.Name,p);
        }
        
        Map<String,Invoice__c>invoiceMap = new Map<String,Invoice__c>();
        Map<String,List<Invoice_Line__c>>invoiceLineMap = new Map<String,List<Invoice_Line__c>>();
        List<Company_Custom_Settings__c> defaultIDs = [SELECT Default_Distributor__c,Default_License__c,Default_Contact__c FROM Company_Custom_Settings__c];
        Purchase_Order__c PO = [select Id,name,Distributor_Name__c,Distributor_License__c,Distributor_Contact__c,Goods_Receipt_Date__c,PO_Status__c,RecordType.Name,
                                    Receiver_Name__r.Membership_Level__c,Supplier_Name__r.Payment_Terms__c,Purchase_Order_Instructions__c,Ship_Confirmation_Date__c,Shipping_Terms__c,Site__r.Name,Total_Weight_lbs__c,
                                    Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,Site__c,Shipping_Method__c,Ownership__r.Service_Type__c,
                                	Brand_Quote__r.recordtype.Name,Brand_Quote__r.Order_Type__c,Brand_Quote__r.Opportunity_Name__r.Order__c,Brand_Quote__r.Opportunity_Name__c,
                                    Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c,Supplier_Name__c,Supplier_License__c,Payment_Eligible__c,
                                    Supplier_Contact__c,Brand_Quote__r.Distributor_Name__c,Receiver_Name__c,Total_Mileage_Fee__c,Brand_Quote__c,
                                    Brand_Quote__r.Distributor_License__c,Brand_Quote__r.Distributor_Contact__c,Brand_Quote__r.Supplier_Name__c,
                                    Brand_Quote__r.Supplier_License__c,Brand_Quote__r.Supplier_Contact__c,Receiver_License__c,Receiver_Contact__c,
                                    Opportunity_Name__c,Planned_Ship_Transfer_Date__c,Sample_Order__c,Customer_PO_or_Quote__c,Payment_Terms__c,Receiver_Name__r.DBA__c,Ownership__r.Platform_Level__c,
                                    PO_Type__c,Ownership__c,Ownership__r.Type,Total_Weight_Fee__c,Order_Type__c,Supplier_Name__r.Membership_Level__c,Receiving_Fee__c,
                                    Service_Booking_Fee__c,Service_Scheduling_Fee__c,Service_Staging_Fee__c,
                                    (SELECt Id,Product_Name__c,Qty_Ordered__c, Purchase_Order__c,Total_Weight_lbs__c,Receiving_Fee__c,
                                     Weight_to_Order_Ratio__c,Weight_to_Mileage_Fee__c, Unit_Cost__c FROM Purchase_Order_Lines__r) from Purchase_Order__c where id  =: recordId];
        
        if(!isOBCreated && PO.Ownership__r.Service_Type__c == Account_Service_Type_Margin  && (PURCHASE_ORDER_RECORDTYPE_PRODUCT == PO.RecordType.Name || PO.Goods_Receipt_Date__c == null)){
            List<Account_Setting__c> accSettingList = [SELECT id,Mthly_IB__c,Max_IB__c,Account__c FROM Account_Setting__c WHERE Account__c = :po.Ownership__c AND Active__c = true];
            if(accSettingList.size() > 0 && accSettingList[0].Mthly_IB__c <= accSettingList[0].Max_IB__c){
                r.data.put('ErrorMsg', Err_Msg_PO_Not_Created_Service_Invoice);
                r.data.put('isOBCreated', true);
                return r;
            }
        }
        
        if(PURCHASE_ORDER_RECORDTYPE_PRODUCT != PO.RecordType.Name || PO.Goods_Receipt_Date__c == null ||
           (PO.PO_Status__c != PURCHASE_ORDER_STATUS_APPROVED && PO.PO_Status__c != PURCHASE_ORDER_STATUS_CLOSED)){
               r.data.put('error', Err_Msg_PO_Create_Service_Invoice);
                
               return r;
           }
        
        
        
        Invoice__c newInvoice = new Invoice__c();
        newInvoice.Purchase_Order__c = PO.Id;
        newInvoice.AR_Status__c = Invoice_Ar_Status_Shipped;
        newInvoice.Opportunity_Name__c = PO.Opportunity_Name__c;
        newInvoice.Distributor_Name__c = PO.Distributor_Name__c;
        newInvoice.Invoice_Memo__c 	   = PO.Purchase_Order_Instructions__c;
        newInvoice.Distributor_License__c = PO.Distributor_License__c;
        newInvoice.Distributor_Contact__c = PO.Distributor_Contact__c;
        /*newInvoice.Supplier_Name__c = PO.Supplier_Name__c;
newInvoice.Supplier_License__c = PO.Supplier_License__c;
newInvoice.Supplier_Contact__c = PO.Supplier_Contact__c;*/
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
        
        newInvoice.Ownership__c = defaultIDs[0].Default_Distributor__c;//sOrder.Ownership__c;
        
        Account invoiceOwnership = [SELECT Id, Type FROM Account WHERE Id =:newInvoice.Ownership__c];
        
        if(PO.Ownership__r.Type == ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER){
            newInvoice.Receiver_Name__c = PO.Ownership__c;
            List<State_Licenses__c> statelicenses = new List<State_Licenses__c>();
            List<Contact> distributorContacts =new List<Contact>();
            for(State_Licenses__c st :[SELECT License_Name__c,id,RecordType.Name FROM State_Licenses__c WHERE License_Name__c =: PO.Ownership__c AND RecordType.Name =: STATE_LICENSE_NONCANNABIS_RECORDTYPE AND License_Status__c = : STATE_LICENSE_ACTIVE ORDER BY CreatedDate ASC]){
                statelicenses.add(st);
            }
            for(Contact con :[SELECT AccountId,Id FROM Contact WHERE AccountId =: PO.Ownership__c AND Active__c = true ORDER BY CreatedDate ASC]){
                distributorContacts.add(con);
            }
            newInvoice.Receiver_License__c = statelicenses[0].id;
            newInvoice.Receiver_Contact__c = distributorContacts[0].id;
            
        }else{
            List<Service_Ticket__c> serviceTicketList = [SELECT Id,Licensed_Premise__c,Brand_Contact__c,Brand_Name__c,
                                                         Brand_Contact__r.AccountId,Licensed_Premise__r.License_Name__c from Service_Ticket__c where Opportunity__c =: 
                                                         PO.Brand_Quote__r.Opportunity_Name__c Limit 1];
            if(PO.Brand_Quote__r.Opportunity_Name__r.Order__c == null && serviceTicketList.size() == 0){
                
                newInvoice.Receiver_Name__c = PO.Receiver_Name__c;
                newInvoice.Receiver_License__c = PO.Receiver_License__c;
                newInvoice.Receiver_Contact__c = PO.Receiver_Contact__c;
            }else{
                newInvoice.Receiver_Name__c = PO.Ownership__c;
                List<State_Licenses__c> statelicenses = new List<State_Licenses__c>();
                List<Contact> distributorContacts =new List<Contact>();
                for(State_Licenses__c st :[SELECT License_Name__c,id,RecordType.Name FROM State_Licenses__c WHERE License_Name__c =: PO.Ownership__c AND RecordType.Name =: STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE AND License_Status__c = : STATE_LICENSE_ACTIVE ORDER BY CreatedDate ASC]){
                    statelicenses.add(st);
                }
                for(Contact con :[SELECT AccountId,Id FROM Contact WHERE AccountId =: PO.Ownership__c AND Active__c = true ORDER BY CreatedDate ASC]){
                    distributorContacts.add(con);
                }
                newInvoice.Receiver_License__c = statelicenses[0].id;
                newInvoice.Receiver_Contact__c = distributorContacts[0].id;
                
            }
        }
            
            /*newInvoice.Receiver_Name__c = PO.Supplier_Name__c;
            newInvoice.Receiver_License__c = PO.Supplier_License__c;
            newInvoice.Receiver_Contact__c = PO.Supplier_Contact__c;*/
        newInvoice.Site__c = PO.Site__c;
        newInvoice.Shipped_Date__c = PO.Planned_Ship_Transfer_Date__c;
        newInvoice.Sample_Order__c = PO.Sample_Order__c;
        newInvoice.AR_Type__c = Invoice_Ar_Type_Services;
        newInvoice.Customer_PO_or_Quote__c = PO.Customer_PO_or_Quote__c;
        newInvoice.Brand_Quote__c = PO.Brand_Quote__c;
        newInvoice.Shipping_Terms__c = PO.Shipping_Terms__c;
        newInvoice.Shipping_Method__c = PO.Shipping_Method__c;
        newInvoice.Payment_Terms__c = PO.Supplier_Name__r.Payment_Terms__c;
        //newInvoice.Ownership__c = PO.Ownership__c;
        newInvoice.Total_Mileage_Fee__c = PO.Total_Mileage_Fee__c;
        newInvoice.Total_Weight_Fee__c = PO.Total_Weight_Fee__c;
        newInvoice.Service_Booking_Fee__c = PO.Service_Booking_Fee__c;
        newInvoice.Service_Scheduling_Fee__c = PO.Service_Scheduling_Fee__c;
        newInvoice.Service_Staging_Fee__c = PO.Service_Staging_Fee__c;
        newInvoice.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_SERVICE).getRecordTypeId();
        newInvoice.Ship_Confirmation_Date__c = (PO.Goods_Receipt_Date__c != NULL ?PO.Goods_Receipt_Date__c.date():NULL);
        newInvoice.Invoice_Due_Date__c = InvoiceSupport.calculateInvoiceDueDate(newInvoice.Ship_Confirmation_Date__c,PO.Planned_Ship_Transfer_Date__c,newInvoice.Payment_Terms__c);			
        
        Boolean skipFees = false;
        Boolean skipFeesForBasic = false;
        System.debug('##BQ Record Type:'+PO.Brand_Quote__r.recordtype.Name);
        System.debug('##Order Type :'+PO.Brand_Quote__r.Order_Type__c);
            
        /*if(PO.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE && PO.Brand_Quote__r.recordtype.Name == TYPE_BUYQUOTE && 
           (PO.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || PO.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR) 
           && (PO.Brand_Quote__r.Order_Type__c == 'Transfer' || String.isBlank(PO.Brand_Quote__r.Order_Type__c))){
               skipFees = true;
               //skipFeesForBasic = true;
           }
        if(PO.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_BASIC && PO.Payment_Eligible__c != true && PO.Brand_Quote__r.Order_Type__c == 'Transfer' && (PO.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || PO.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR)){
            skipFeesForBasic = true;
        }*/
        List<Invoice_Line__c> invoiceLines = new List<Invoice_Line__c>();
        Boolean createWMLines = false;
        
        
        if(PO.Shipping_Method__c != NULL && PO.Shipping_Method__c.contains(SO_SHIPPING_METHOD_PICK_UP))
            createWMLines = true;
        if(PO.Brand_Quote__r.Order_Type__c == '' || PO.Brand_Quote__r.Order_Type__c == null){
            if( createWMLines && PO.Total_Weight_Fee__c != null && PO.Total_Weight_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_WEIGHT_FEE))
                invoiceLines = validateProductFee(productsMap.get(PRODUCT_NAME_WEIGHT_FEE),1,PO.Total_Weight_Fee__c,productsMap,invoiceLines,invoiceLineRecordTypeId);
            if( createWMLines && PO.Total_Mileage_Fee__c != null && PO.Total_Mileage_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_MILEAGE_FEE))
                invoiceLines = validateProductFee(productsMap.get(PRODUCT_NAME_MILEAGE_FEE),1,PO.Total_Mileage_Fee__c,productsMap,invoiceLines,invoiceLineRecordTypeId);
            if( PO.Service_Booking_Fee__c != null && PO.Service_Booking_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_BOOKING_FEE))
                invoiceLines = validateProductFee(productsMap.get(PRODUCT_NAME_BOOKING_FEE),1,PO.Service_Booking_Fee__c,productsMap,invoiceLines,invoiceLineRecordTypeId);
            if( PO.Service_Scheduling_Fee__c != null && PO.Service_Scheduling_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_SERVICE_SCHEDULING_FEE))
                invoiceLines = validateProductFee(productsMap.get(PRODUCT_NAME_SERVICE_SCHEDULING_FEE),1,PO.Service_Scheduling_Fee__c,productsMap,invoiceLines,invoiceLineRecordTypeId);
            if( PO.Service_Staging_Fee__c != null && PO.Service_Staging_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_SERVICE_STAGING_FEE))
                invoiceLines = validateProductFee(productsMap.get(PRODUCT_NAME_SERVICE_STAGING_FEE),1,PO.Service_Staging_Fee__c,productsMap,invoiceLines,invoiceLineRecordTypeId);
        }
        if(PO.Receiving_Fee__c != null && PO.Receiving_Fee__c > 0 && productsMap.containsKey(PRODUCT_NAME_RECEIVING_FEE))
            invoiceLines = validateProductFee(productsMap.get(PRODUCT_NAME_RECEIVING_FEE),1,PO.Receiving_Fee__c,productsMap,invoiceLines,invoiceLineRecordTypeId);
        
        try{
            insert newInvoice;
            
            if(invoiceLines.size() > 0){
            	for(Invoice_Line__c invLine : invoiceLines){
                    invLine.Invoice__c = newInvoice.Id;     
                }
                insert invoiceLines;    	
            }
            r.data.put('invoiceId', newInvoice.Id);
        }
        catch(Exception ex) {
            r.data.put('error', 'Please submit Purchase Order for Approval and try again to Create Invoice.');
            ErrorLogs.log('createInvoiceOrder',ex.getStackTraceString(), ex.getMessage());
        }
        return r;
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
}