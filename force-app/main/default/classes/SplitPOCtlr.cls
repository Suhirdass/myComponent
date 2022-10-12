public class SplitPOCtlr {
    
    public static Brand_Quote__c bq{get;set;}
    public static List<splitPoWrpr> items{get;set;}
    public static List<BrandQuoteLineWrapper> lines {get;set;}
    public static Boolean isValid; 
    public transient ApexPages.Message message;
    public static String selectedProducerId{get;set;}
    public static Boolean isMulti{get;set;}
    public static Boolean isFactoringPO{get;set;}
    static Brand_Quote__c quote;
    static List<Brand_Quote_Line__c> quoteLines;
    public static Map<String,Brand_Quote_Line__c[]> producerBQLis;
    public static String message;
    public static Boolean hasLines{get;set;}
    public Static String PURCHASE_ORDER_LINE_RECORDTYPE_FACTORING{
        get{
            return String.isNotBlank(PURCHASE_ORDER_LINE_RECORDTYPE_FACTORING) ? PURCHASE_ORDER_LINE_RECORDTYPE_FACTORING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POL_Record_Type_Factoring');
        }set;
    }
    public Static String PURCHASE_ORDER_RECORDTYPE_FACTORING{
        get{
            return String.isNotBlank(PURCHASE_ORDER_RECORDTYPE_FACTORING) ? PURCHASE_ORDER_RECORDTYPE_FACTORING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Record_Type_Factoring');
        }set;
    }
     public Static String PRODUCT_RECORDTYPE_DISCOUNT{
        get{
            return String.isNotBlank(PRODUCT_RECORDTYPE_DISCOUNT) ? PRODUCT_RECORDTYPE_DISCOUNT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Discount');
        }set;
    }
    public Static String ERR_MSG_PRODUCT_NO_DISCOUNT{
        get{
            return String.isNotBlank(ERR_MSG_PRODUCT_NO_DISCOUNT) ? ERR_MSG_PRODUCT_NO_DISCOUNT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_No_Discount_Error');
        }set;
    }
    public Static String ERR_MSG_FACTORING_PO_NOT_BLANK{
        get{
            return  String.isNotBlank(ERR_MSG_FACTORING_PO_NOT_BLANK) ? ERR_MSG_FACTORING_PO_NOT_BLANK :FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Factoring_Cant_Blank_Error');
        }set;
    }
    private Static String BRAND_QUOTE_LINE_STATUS_CANCEL{
        get{
            return String.isNotBlank(BRAND_QUOTE_LINE_STATUS_CANCEL) ? BRAND_QUOTE_LINE_STATUS_CANCEL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote_Line__c','BrandQuote_Line_Cancel');
        }set;
    }
    private Static String BRAND_QUOTE_LINE_STATUS_REJECT {
        get{
            return  String.isNotBlank(BRAND_QUOTE_LINE_STATUS_REJECT) ? BRAND_QUOTE_LINE_STATUS_REJECT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote_Line__c','BrandQuote_Line_Reject');
        }set;
    }
    public Static String PURCHASE_ORDER_LINE_PRODUCT_TITLE{
        get{
            return String.isNotBlank(PURCHASE_ORDER_LINE_PRODUCT_TITLE) ? PURCHASE_ORDER_LINE_PRODUCT_TITLE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','FiledName_Product_Title');
        }set;
    }
     private Static String BRAND_QUOTE_STATUS_APPROVED{
        get{
            return String.isNotBlank(BRAND_QUOTE_STATUS_APPROVED) ? BRAND_QUOTE_STATUS_APPROVED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Status_Approved');
        }set;
    }
     private Static String BRAND_QUOTE_STATUS_SHIPPED {
        get{
            return String.isNotBlank(BRAND_QUOTE_STATUS_SHIPPED) ? BRAND_QUOTE_STATUS_SHIPPED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Status_Shipped');
        }set;
    }
     public Static String BRAND_QUOTE_RECORDTYPE_SELL_QUOTE{
        get{
            return String.isNotBlank(BRAND_QUOTE_RECORDTYPE_SELL_QUOTE) ? BRAND_QUOTE_RECORDTYPE_SELL_QUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuoteType_SellQuote');
        }set;
    }
     private Static String BRAND_QUOTE_RECORDTYPE_SERVICE_QUOTE{
        get{
            return String.isNotBlank(BRAND_QUOTE_RECORDTYPE_SERVICE_QUOTE) ? BRAND_QUOTE_RECORDTYPE_SERVICE_QUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_Service');
        }set;
    }
     public Static String BRAND_QUOTE_RECORDTYPE_RMA{
        get{
            return String.isNotBlank(BRAND_QUOTE_RECORDTYPE_RMA) ? BRAND_QUOTE_RECORDTYPE_RMA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_DevName_RMA');
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
     public Static String PURCHASE_ORDER_RECORDTYPE_RMA{
        get{
            return String.isNotBlank(PURCHASE_ORDER_RECORDTYPE_RMA) ? PURCHASE_ORDER_RECORDTYPE_RMA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Record_Type_DevName_RMA');
        }set;
    }
     public Static String PURCHASE_ORDER_LINE_RECORDTYPE_RMA{
        get{
            return String.isNotBlank(PURCHASE_ORDER_LINE_RECORDTYPE_RMA) ? PURCHASE_ORDER_LINE_RECORDTYPE_RMA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POL_Record_Type_DevName_RMA');
        }set;
    }
     private Static String PURCHASE_ORDER_RECORDTYPE_PRODUCT{
        get{
            return String.isNotBlank(PURCHASE_ORDER_RECORDTYPE_PRODUCT) ? PURCHASE_ORDER_RECORDTYPE_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_Record_Type_DevName_Product');
        }set;
    }
     private Static String PURCHASE_ORDER_LINE_RECORDTYPE_PRODUCT{
        get{
            return String.isNotBlank(PURCHASE_ORDER_LINE_RECORDTYPE_PRODUCT) ? PURCHASE_ORDER_LINE_RECORDTYPE_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POL_Record_Type_DevName_Product');
        }set;
    }
    public Static String ERR_MSG_NO_PURCHASE_ORDER_LINES{
        get{
            return String.isNotBlank(ERR_MSG_NO_PURCHASE_ORDER_LINES) ? ERR_MSG_NO_PURCHASE_ORDER_LINES : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Err_Msg_No_POLines');
        }set;
    }
    private Static String PURCHASE_ORDER_STATUS_DRAFT{
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_DRAFT) ? PURCHASE_ORDER_STATUS_DRAFT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PurchaseOrder_Status_Draft');
        }set;
    }
    public Static String ERR_MSG_POSITIVE_VALUES{
        get{
            return String.isNotBlank(ERR_MSG_POSITIVE_VALUES) ? ERR_MSG_POSITIVE_VALUES : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','Err_Msg_Positive_Values');
        }set;
    }
    public Static String ERR_MSG_QTYBILL_GREATER_VALUES{
        get{
            return String.isNotBlank(ERR_MSG_QTYBILL_GREATER_VALUES) ? ERR_MSG_QTYBILL_GREATER_VALUES : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','Err_Msg_QtyBill_Greater_AvailableQty');
        }set;
    }
     private Static String ERR_MSG_RPRODUCT_GREATER_VALUES{ 
        get{ 
            return String.isNotBlank(ERR_MSG_RPRODUCT_GREATER_VALUES) ? ERR_MSG_RPRODUCT_GREATER_VALUES : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','Err_Msg_QtyBill_Greater_Product');
        }set;
    }
     private Static String ERR_MSG_APPROVED_BRAND_QUOTE{ 
        get{ 
            return String.isNotBlank(ERR_MSG_APPROVED_BRAND_QUOTE) ? ERR_MSG_APPROVED_BRAND_QUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','Err_Msg_Approved_BQ');
        }set;
    }
    public Static String ERR_MSG_PRODUCT_PREPAID_VALIDATION{ 
        get{ 
            return String.isNotBlank(ERR_MSG_PRODUCT_PREPAID_VALIDATION) ? ERR_MSG_PRODUCT_PREPAID_VALIDATION : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Err_Msg_Product_Prepaid_validation');
        }set;
    }
    public Static String ERR_MSG_PURCHASE_ORDER_ALREADY_CREATED{ 
        get{ 
            return String.isNotBlank(ERR_MSG_PURCHASE_ORDER_ALREADY_CREATED) ? ERR_MSG_PURCHASE_ORDER_ALREADY_CREATED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Err_Msg_Purchase_Order_Already_Created');
        }set;
    }
    public Static String ERR_MSG_QTY_BILL_NOT_GREAT_THAN_AVAILABLE_QTY{
        get{ 
            return String.isNotBlank(ERR_MSG_QTY_BILL_NOT_GREAT_THAN_AVAILABLE_QTY) ? ERR_MSG_QTY_BILL_NOT_GREAT_THAN_AVAILABLE_QTY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Err_Msg_Qty_Bill_Not_Great_Than_AvailQty');
        }set;
    }
    private Static String SITE_NAME_7027{ 
        get{
            return  String.isNotBlank(SITE_NAME_7027) ? SITE_NAME_7027 :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Site','Site_Name_7027');
        }set;
    }
    private static String FULFILLMENT_SERVICE_Receiving_Fee{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_Receiving_Fee) ? FULFILLMENT_SERVICE_Receiving_Fee : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Receiving_Fee');
        }set;
    }
    private static String POLI_Status_Cancelled{
        get{
            return String.isNotBlank(POLI_Status_Cancelled) ? POLI_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POLI_Status_Cancelled');
        }set;
    }
    private static String POLI_Status_Closed{
        get{
            return String.isNotBlank(POLI_Status_Closed) ? POLI_Status_Closed : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POLI_Status_Closed');
        }set;
    }
    private static String POLI_Status_Rejected{
        get{
            return String.isNotBlank(POLI_Status_Rejected) ? POLI_Status_Rejected : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POLI_Status_Rejected');
        }set;
    }
    private static String Account_DBA_IRR {
        get{
            return String.isNotBlank(Account_DBA_IRR ) ? Account_DBA_IRR  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_DBA_IRR');
        }set;
    }
    public SplitPOCtlr(ApexPages.StandardController controller) {
        bq = ((Brand_Quote__c)controller.getRecord());
        Id bqId = bq.Id; 
        isValid = true;
        isMulti = false;
        isFactoringPO = false;
        bq = [SELECT Id, Name,Ownership__c FROM Brand_Quote__c WHERE Id =:bqId];
        items = new List<splitPoWrpr>();
        processBrandQuote(bqId);
        
    }
    @Auraenabled
    public static AuraResponse getRecordName(Id recordId){
        AuraResponse r = new AuraResponse('BrandQuoteCreatePOCtrl.getRecordName()');
        String objName = recordId.getSObjectType().getDescribe().getName();
        String recName;
        String q = 'SELECT Name FROM ' + objName + ' WHERE Id=\'' + recordId + '\'';
        List<SObject> records = Database.query(q);
        if(records.size()>0){
            recName = (String) (records[0].get('Name'));
            
            quote = [SELECT id ,name,RecordTypeId,Ownership__r.Membership_Level__c,RecordType.Name,BQ_Status__c,Opportunity_Name__c,Payment_Terms__c,Site__c, 
                     Opportunity_Name__r.AccountId,Sample_Order__c,Order_Type__c,Ownership__c,Shipping_Method__c,
                     Shipping_Terms__c,Receiver_Name__c,Receiver_License__c,Receiver_Contact__c,Supplier_Name__c,Opportunity_Name__r.Order__c,
                     Supplier_License__c,Supplier_Contact__c,Distributor_Name__c,Distributor_License__c,Distributor_Contact__c,
                     Factoring_Discount__c,Planned_Transfer_Date__c,Factoring_Assignee__c,Factoring_Contact__c,Factoring_Rate__c,
                     Total_Weight_lbs__c,Total_Weight_Fee__c,Total_Mileage_Fee__c,Service_Booking_Fee__c,Service_Staging_Fee__c,
                     Service_Scheduling_Fee__c FROM Brand_Quote__c WHERE Id =: recordId];
            
            r.data.put('recordName', recName);
            r.data.put('status', quote.BQ_Status__c);
            r.data.put('recordTypeName', quote.RecordType.Name);
            r.data.put('hasFactoringDetails', (quote.Factoring_Assignee__c != NULL && quote.Factoring_Contact__c != NULL && quote.Factoring_Rate__c > 0));
            return r;} r.data.put('recordName', ''); return r;
        
    }
    /**
* Update all BQ lines Qty to bill with Qty to PO value on selecting all BQ lines
* If all BQ lines unchecked then reset Qty to bill as 0
*/
    public void updateQtyToBillForAllBQLines(){
        
        for(splitPoWrpr spw : items){
            for(BrandQuoteLineWrapper bqLineWrapper: spw.lines){
                bqLineWrapper.qtyToBill = spw.isSelected?(bqLineWrapper.quoteLine.Billed_Quantity__c != null ?(bqLineWrapper.quoteLine.Line_Total_Qty__c - bqLineWrapper.quoteLine.Billed_Quantity__c):bqLineWrapper.quoteLine.Line_Total_Qty__c):0;
            }   
        }
    }
    
    public void updateQtyToBillForSelectedProducerBQLines(){
        for(splitPoWrpr spw : items){
            if(spw.producerId == selectedProducerId){for(BrandQuoteLineWrapper bqLineWrapper: spw.lines){bqLineWrapper.qtyToBill = spw.isSelected?(bqLineWrapper.quoteLine.Billed_Quantity__c != null ?(bqLineWrapper.quoteLine.Line_Total_Qty__c - bqLineWrapper.quoteLine.Billed_Quantity__c):bqLineWrapper.quoteLine.Line_Total_Qty__c):0;
                                                                                                         
                                                                                                        }  
                                                    }     
        }
    }
    
    @Auraenabled
    public static AuraResponse createInvoicePO(String recordId){ 
        Savepoint savePoint;
        String redirecId;
        Id poRecordTypeID;
        Id poliRecordTypeID;
        AuraResponse r = new AuraResponse('SplitPOCtlr.createInvoicePO()');
        try{
            savePoint = Database.setSavepoint();
            items = new List<splitPoWrpr>();    
            quote = [SELECT id ,name,Notes__c,Ownership__r.Membership_Level__c,RecordTypeId,BQ_Status__c,Opportunity_Name__c,Opportunity_Name__r.Name,Shipping_Terms__c, 
                     Opportunity_Name__r.AccountId,Payment_Terms__c,Sample_Order__c,Site__c,Ownership__c,Shipping_Method__c,
                     Ownership__r.Name,Customer_PO_or_Quote__c,Receiver_Name__c,Receiver_License__c,Receiver_Contact__c,Opportunity_Name__r.Order__c,
                     Opportunity_Number__c,Site__r.Name,Site__r.Warehouse_Name__c,Supplier_Name__c,Supplier_License__c,Order_Type__c,
                     Supplier_Contact__c,Distributor_Name__c,Distributor_License__c,Distributor_Contact__c,Factoring_Rate__c,
                     Planned_Transfer_Date__c,Factoring_Assignee__c,Factoring_Discount__c,Factoring_Contact__c,
                     Total_Weight_lbs__c,Total_Weight_Fee__c,Total_Mileage_Fee__c,Service_Booking_Fee__c,Service_Staging_Fee__c,
                     Service_Scheduling_Fee__c,(SELECT id,name,Brand_Quote_Number__c,Disty_Margin__c,MOQ__c,Product_Name__r.Unit_Shipping_Weight_lbs__c,Product_Name__r.Case_Shipping_Weight_lbs__c,Product_Title__c,
					 Price_Book__c,Line_Total_Qty__c,Product_Name__c,Product_Name__r.Name, Product_Description__c,Quantity_Cases__c,
					 Invoiced_Quantity__c,Billed_Quantity__c,Product_Name__r.Producer_Name__c,Product_Name__r.Prepaid__c,
                     Harvest_Batch_Code__c,Order_Type__c,Ownership_Code__r.Membership_Level__c,Weight_to_Order_Fee__c,Weight_to_Order_Booking_Fee__c,Weight_to_Schedule_Dispatch_Fee__c,Weight_to_Stage_Manifest_Fee__c,                           
					 Product_Name__r.Producer_Name__r.Name,Disty_Cost__c,Is_Sample__c,Ownership_Code__c,Total_Weight_lbs__c,
					 Weight_to_Order_Ratio__c,Weight_to_Mileage_Fee__c FROM Brand_Quote_Lines__r WHERE Status__c !=:
					 BRAND_QUOTE_LINE_STATUS_CANCEL AND Status__c !=: BRAND_QUOTE_LINE_STATUS_REJECT) FROM Brand_Quote__c 
                     WHERE Id =: recordId];
            bq = [SELECT Id, Ownership__c,Factoring_Assignee__c,Order_Type__c, Name FROM Brand_Quote__c WHERE Id =:recordId];
            String recordtypename = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosById().get(quote.RecordTypeId).getname();
            poRecordTypeID   = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_RECORDTYPE_INVOICE_ONLY).getRecordTypeId();
            poliRecordTypeID = Schema.SObjectType.Purchase_Order_Line__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_LINE_RECORDTYPE_INVOICE_ONLY).getRecordTypeId();
            Product2[] discountProducts = [SELECT Id, Name, Product_Short_Description__c FROM Product2 WHERE Family =: PRODUCT_RECORDTYPE_DISCOUNT AND RecordType.Name =: PRODUCT_RECORDTYPE_DISCOUNT];
            
            Set<String> membershipLevel = new Set<String>();
            Map<String,List<Brand_Quote_Line__c>> ownerShipCodePOLIMap = new Map<String,List<Brand_Quote_Line__c>>();
            if(quote.Brand_Quote_Lines__r.size() > 0 ){
                for(Brand_Quote_Line__c poli  : quote.Brand_Quote_Lines__r){
                        if(ownerShipCodePOLIMap.containsKey(poli.Ownership_Code__c)){
                            ownerShipCodePOLIMap.get(poli.Ownership_Code__c).add(poli);
                        }else{
                            ownerShipCodePOLIMap.put(poli.Ownership_Code__c, new List<Brand_Quote_Line__c>{poli});
                        }
                         membershipLevel.add(poli.Ownership_Code__r.Membership_Level__c);
                    }
            }
            
            Service_Ticket__c[] STs= [select Name from Service_Ticket__c where  Opportunity__c =: quote.Opportunity_Name__c Limit 1];
            List<Service_Ticket_Line__c>  STL = new List<Service_Ticket_Line__c>();
            if(STs.size() > 0){
                STL= [select id ,Name,New_Packaged_Product__c,Harvest_Batch_Code__r.Name,UID_New__c from Service_Ticket_Line__c where Service_Ticket__c =:STs[0].Id];
            }
            
            Map<String,List<Fulfillment_Rates_Table__c>> FRTMap = new Map<String,List<Fulfillment_Rates_Table__c>>();
            Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c,Bracket_Price__c ,
			Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c,Membership_Level__c FROM 
			Fulfillment_Rates_Table__c WHERE Site__c = :quote.Site__c AND Active__c = true AND Rate_Effective_From__c <= :System.today() 
			AND Rate_Effective_To__c >= :System.today() AND Membership_Level__c IN : membershipLevel AND Fulfillment_Services__c =: FULFILLMENT_SERVICE_Receiving_Fee ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
            
            
            if(FRTList.size() > 0 ){
                    for(Fulfillment_Rates_Table__c frt : FRTList){
                        if(FRTMap.containsKey(frt.Membership_Level__c)){
                            FRTMap.get(frt.Membership_Level__c).add(frt);
                        }else{
                            FRTMap.put(frt.Membership_Level__c,new List<Fulfillment_Rates_Table__c>{frt});
                        }
                    }
                }
            
            Map<String,Purchase_Order__c> newPOMap = new Map<String,Purchase_Order__c>(); 
            Map<String,List<Purchase_Order_Line__c>> newPOLIMap = new Map<String,List<Purchase_Order_Line__c>>();
            
            for(String ownershipId : ownerShipCodePOLIMap.keySet()){
                List<Brand_Quote_Line__c> BQLIs = ownerShipCodePOLIMap.get(ownershipId);
                system.debug('## BQLIs 1 : '+BQLIs.size());
                if(BQLIs != NULL && BQLIs.size() > 0){
                    String mLevel = BQLIs[0].Ownership_Code__r.Membership_Level__c;
                    
                    Purchase_Order__c newPO = getPO(bq.Id, recordtypename, poRecordTypeID);
                    Company_Custom_Settings__c companySettingRec = Company_Custom_Settings__c.getOrgDefaults();
                    //newPO.Ownership__c = companySettingRec.Default_Distributor__c;
                    newPO.Supplier_Name__c = companySettingRec.Default_Distributor__c;
                    newPO.Supplier_License__c = companySettingRec.Default_License__c;
                    newPO.Ownership__c = ownershipId;//BQLIs[0].Ownership_Code__c;
                 
                    Decimal mileageFee = 0;
                    Decimal weightFee = 0;
                    Decimal orderBookingFee = 0;
                    Decimal ScheduleDispatchFee = 0;
                    Decimal StageManifestFee = 0;   
                    
            		List<Purchase_Order_Line__c> lstPoli = new List<Purchase_Order_Line__c>();
                    system.debug('## BQLIs 2 : '+BQLIs.size());
                    for(Brand_Quote_Line__c bqli : BQLIs){
                        Decimal qtyToBill = bqli.Billed_Quantity__c != null ?(bqli.Line_Total_Qty__c - bqli.Billed_Quantity__c):bqli.Line_Total_Qty__c;
                        Purchase_Order_Line__c newPOLI = getPOLI(bqli, newPO,poliRecordTypeID,qtyToBill,STL,mLevel,(FRTMap.containsKey(mLevel) ? FRTMap.get(mLevel) : new List<Fulfillment_Rates_Table__c>()));
                        lstPoli.add(newPOLI);
                        system.debug('## lstPoli : '+lstPoli.size());
                        mileageFee += (bqli.Weight_to_Mileage_Fee__c != null ? bqli.Weight_to_Mileage_Fee__c : 0 );
                        weightFee += (bqli.Weight_to_Order_Fee__c != null ? bqli.Weight_to_Order_Fee__c : 0 );
                        orderBookingFee += (bqli.Weight_to_Order_Booking_Fee__c != null ? bqli.Weight_to_Order_Booking_Fee__c : 0 );
                        ScheduleDispatchFee += (bqli.Weight_to_Schedule_Dispatch_Fee__c != null ? bqli.Weight_to_Schedule_Dispatch_Fee__c : 0 );
                        StageManifestFee += (bqli.Weight_to_Stage_Manifest_Fee__c != null ? bqli.Weight_to_Stage_Manifest_Fee__c : 0 );
                    }
                    newPO.Total_Weight_Fee__c = weightFee;
                    newPO.Total_Mileage_Fee__c = mileageFee;
                    newPO.Service_Booking_Fee__c = orderBookingFee;
                    newPO.Service_Scheduling_Fee__c = ScheduleDispatchFee;
                    newPO.Service_Staging_Fee__c  = StageManifestFee ;
                    
                    newPOMap.put(ownershipId,newPO);
                    newPOLIMap.put(ownershipId,lstPoli);
                }
            }
            
            if(!newPOLIMap.values().isEmpty()){
                String POId='';
                insert newPOMap.values();
                List<Purchase_Order_Line__c> newPOLIs = new List<Purchase_Order_Line__c>();
                for(String  oCode :newPOMap.keySet()){
                    Purchase_Order__c PO = newPOMap.get(oCode);
                    POId = PO.Id;
                    for(Purchase_Order_Line__c line: newPOLIMap.get(oCode)){
                        line.Purchase_Order__c = PO.Id;
                        newPOLIs.add(line);
                    }
                }
                redirecId = POId;
                insert newPOLIs;
            }
           
            
        }catch(Exception ex){
            Database.rollback(savePoint);
            redirecId = bq.Id; r.data.put('Error',ex.getMessage());
        }
        r.data.put('recordIds', redirecId);
        return r;
    }
    
    @Auraenabled
    public static AuraResponse createFactoringPO(String recordId){ 
        Savepoint savePoint;
        String redirecId;
        Id poRecordTypeID;
        Id poliRecordTypeID;
        AuraResponse r = new AuraResponse('SplitPOCtlr.createFactoringPO()');
        try{
            savePoint = Database.setSavepoint();
            isFactoringPO = true;
            items = new List<splitPoWrpr>();    
            quote = [SELECT id ,name,Notes__c,RecordTypeId,Ownership__r.Membership_Level__c,BQ_Status__c,Opportunity_Name__c,Opportunity_Name__r.Name,Ownership__r.Name, 
                     Opportunity_Name__r.AccountId,Payment_Terms__c,Sample_Order__c,Order_Type__c,Site__c,Ownership__c,
                     Shipping_Method__c,Shipping_Terms__c,Customer_PO_or_Quote__c,Receiver_Name__c,Receiver_License__c,
                     Receiver_Contact__c,Opportunity_Number__c,Site__r.Name,Site__r.Warehouse_Name__c,Supplier_Name__c,
                     Supplier_License__c,Supplier_Contact__c,Distributor_Name__c,Distributor_License__c,Distributor_Contact__c,
                     Total_Weight_lbs__c,Total_Weight_Fee__c,Total_Mileage_Fee__c,Service_Booking_Fee__c,Service_Staging_Fee__c,
                     Service_Scheduling_Fee__c,Planned_Transfer_Date__c,Factoring_Assignee__c,Factoring_Rate__c,
                     Factoring_Discount__c,Factoring_Contact__c FROM Brand_Quote__c WHERE Id =: recordId];
            bq = [SELECT Id, Ownership__c,Factoring_Assignee__c, Name FROM Brand_Quote__c WHERE Id =:recordId];
            String recordtypename = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosById().get(quote.RecordTypeId).getname();
            poRecordTypeID   = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_LINE_RECORDTYPE_FACTORING).getRecordTypeId();
            poliRecordTypeID = Schema.SObjectType.Purchase_Order_Line__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_RECORDTYPE_FACTORING).getRecordTypeId();
           Product2[] discountProducts = [SELECT Id, Name, Product_Short_Description__c FROM Product2 WHERE Family =: PRODUCT_RECORDTYPE_DISCOUNT AND RecordType.Name =: PRODUCT_RECORDTYPE_DISCOUNT AND Producer_Name__c = :quote.Factoring_Assignee__c];
            if(quote.Factoring_Assignee__c != NULL && quote.Factoring_Contact__c != NULL && quote.Factoring_Rate__c > 0){ 
                Purchase_Order__c newPO = getPO(bq.Id, recordtypename, poRecordTypeID);
                Company_Custom_Settings__c companySettingRec = Company_Custom_Settings__c.getOrgDefaults();
                newPO.Ownership__c = companySettingRec.Default_Distributor__c;
                newPO.Supplier_Name__c = companySettingRec.Default_Distributor__c;
                newPO.Supplier_License__c = companySettingRec.Default_License__c;
                if(discountProducts.size() > 0){ insert newPO;
                                                Purchase_Order_Line__c newPOLI = new Purchase_Order_Line__c();
                                                newPOLI.Product_Name__c = discountProducts[0].Id;
                                                newPOLI.Product_Title__c = PURCHASE_ORDER_LINE_PRODUCT_TITLE;
                                                newPOLI.Qty_Ordered__c = 1;
                                                newPOLI.Purchase_Order__c = newPO.Id;
                                                newPOLI.Unit_Cost__c = quote.Factoring_Discount__c;
                                                newPOLI.Is_Sample__c = false;
                                                newPOLI.RecordTypeId = poliRecordTypeID;                                                    
                                                insert newPOLI; redirecId = newPO.Id;
                                                
                                               }else{
                                                   r.data.put('Error',ERR_MSG_PRODUCT_NO_DISCOUNT); redirecId = bq.Id;
                                                   
                                               }
            }else{
                r.data.put('Error',ERR_MSG_FACTORING_PO_NOT_BLANK);
                redirecId = bq.Id;
            }
        }catch(Exception ex){
            Database.rollback(savePoint);
            redirecId = bq.Id; r.data.put('Error',ex.getMessage());
            
        }
        r.data.put('recordIds', redirecId);
        return r;
    }
    
    
    @Auraenabled
    public static AuraResponse initCreatePO(String recordId){   
        AuraResponse r = new AuraResponse('BrandQuoteCreatePOCtrl.SplitPOCtlr()');
        isValid = true;
        isMulti = false;
        hasLines = false; 
        items = new List<splitPoWrpr>();
        lines= new List<BrandQuoteLineWrapper>();
        processBrandQuote(recordId);
        if(lines.size() > 0){
            hasLines = true;
        }
        AllProductDetails allRec= new AllProductDetails();
        allRec.items = items;
        allRec.isValid = isValid;
        allRec.quote = quote;
        allRec.isMulti = isMulti;
        r.data.put('records', allRec);
        r.data.put('Error', message);
        r.data.put('items', items);
        r.data.put('hasLines', hasLines);
        r.data.put('lines', lines);
        return r;
    }
    
    public static void processBrandQuote(String bqId){
        
        try{ 
            
            quote = [SELECT id ,name,Notes__c,RecordTypeId,Ownership__r.Membership_Level__c,BQ_Status__c,Opportunity_Name__c,Opportunity_Name__r.Name,Ownership__r.Name, 
                     Opportunity_Name__r.AccountId,Payment_Terms__c,Sample_Order__c,Order_Type__c,Site__c,Ownership__c,
                     Shipping_Method__c,Shipping_Terms__c,Customer_PO_or_Quote__c,Receiver_Name__c,Receiver_License__c,Opportunity_Name__r.Order__c,
                     Receiver_Contact__c,Opportunity_Number__c,Site__r.Name,Site__r.Warehouse_Name__c,Supplier_Name__c,Ownership__r.DBA__c,
                     Supplier_License__c,Supplier_Contact__c,Distributor_Name__c,Distributor_License__c,Distributor_Contact__c,
                     Planned_Transfer_Date__c,Factoring_Assignee__c,Factoring_Rate__c,Factoring_Discount__c,Factoring_Contact__c,
                     Total_Weight_lbs__c,Total_Weight_Fee__c,Total_Mileage_Fee__c,Service_Booking_Fee__c,Service_Staging_Fee__c,
                     Service_Scheduling_Fee__c FROM Brand_Quote__c WHERE Id =: bqid];
            quoteLines = [SELECT id,name,Brand_Quote_Number__c,Harvest_Batch_Code__c,Disty_Margin__c,MOQ__c,Product_Title__c,Price_Book__c,Quantity_Cases__c,Product_Name__r.White_Labelled__c,
                          Line_Total_Qty__c,Product_Name__c,Product_Name__r.Unit_Shipping_Weight_lbs__c,Product_Name__r.Case_Shipping_Weight_lbs__c,Product_Name__r.Name,Product_Description__c,Invoiced_Quantity__c,
                          Billed_Quantity__c,Product_Name__r.Producer_Name__c,Product_Name__r.Prepaid__c,Ownership_Code__c,Ownership_Code__r.Membership_Level__c,Weight_to_Order_Fee__c,Weight_to_Order_Booking_Fee__c,Weight_to_Schedule_Dispatch_Fee__c,Weight_to_Stage_Manifest_Fee__c,                           
                          Product_Name__r.Producer_Name__r.Name,Disty_Cost__c,Is_Sample__c,Total_Weight_lbs__c,Product_Name__r.Licensee_Name__c,Product_Name__r.Licensee_Name__r.Name,
                          Weight_to_Order_Ratio__c,Weight_to_Mileage_Fee__c FROM Brand_Quote_Line__c WHERE Brand_Quote_Number__c  
                          =: bqID AND Status__c !=:BRAND_QUOTE_LINE_STATUS_CANCEL AND Status__c !=: BRAND_QUOTE_LINE_STATUS_REJECT];
            if(quote.BQ_Status__c != BRAND_QUOTE_STATUS_APPROVED && quote.BQ_Status__c != BRAND_QUOTE_STATUS_SHIPPED){
                isValid = false;
                
                message = ERR_MSG_APPROVED_BRAND_QUOTE;
            }
            system.debug('##quoteLines :'+quoteLines.size());
            producerBQLis = new Map<String,Brand_Quote_Line__c[]>();
            for(Brand_Quote_Line__c BQL: quoteLines){
                Id BrandId = BQL.Product_Name__r.Producer_Name__c;
                if(BQL.Product_Name__r.White_Labelled__c == true){
                    BrandId = BQL.Product_Name__r.Licensee_Name__c;
                }
                if(producerBQLis.containsKey(BrandId)){
                    producerBQLis.get(BrandId).add(BQL);
                }else{
                    producerBQLis.put(BrandId,new Brand_Quote_Line__c[]{BQL});
                }
            }
            Map<Id,Account> producerMap = new Map<Id,Account>([SELECT Id,Name FROM Account WHERE Id IN: producerBQLis.keySet()]);
            Integer size = 0;
            BrandQuoteLineWrapper c ;
            system.debug('##producerBQLis :'+producerBQLis.size());
            for(String producerId : producerBQLis.keySet()){
                system.debug('##producerMap :'+producerMap.size());
                String producerName= producerMap.containsKey(producerId) ? producerMap.get(producerId).Name : '';
                splitPoWrpr obj  = new splitPoWrpr();
                size = producerBQLis.get(producerId).size();
                obj.Name = producerName;
                size = producerBQLis.get(producerId).size();
                obj.producerId = producerId;
                List<BrandQuoteLineWrapper> lineWrpr = new List<BrandQuoteLineWrapper>();
                List<BrandQuoteLineWrapper> lineWrprLines = new List<BrandQuoteLineWrapper>();
                Integer counter = 0;
                for(Brand_Quote_Line__c line : producerBQLis.get(producerId)){
                    if(producerBQLis.containsKey(producerId)) {
                        lineWrpr.add(new BrandQuoteLineWrapper(line,false)); 
                        if(size >= 2) {
                            if(counter==0) {
                                c  = new BrandQuoteLineWrapper(line,1,false);
                                counter++;
                            }
                            else c  = new BrandQuoteLineWrapper(line,false); } else c  = new BrandQuoteLineWrapper(line,1,false);
                        c.Name = producerName;
                        c.producerId = producerId;
                        c.size= size;
                        if(lines != null)
                            lines.add(c);
                    }else { lineWrpr.add(new BrandQuoteLineWrapper(line,1,false));
                          }
                }
                system.debug('##lineWrpr :'+lineWrpr.size());
                obj.lines = lineWrpr ;
                obj.size= size;
                items.add(obj);
            }

        }catch(Exception e){
        }
    }
    @Auraenabled
    public static AuraResponse createOrderOne(Brand_Quote__c qt,String json1,Boolean multi,String recordId){
        
        AuraResponse r = new AuraResponse('BrandQuoteCreatePOCtrl.createOrderOne()');
        
        items = (List<splitPoWrpr>) System.JSON.deserialize(json1, List<splitPoWrpr>.class);
        lines = (List<BrandQuoteLineWrapper>) System.JSON.deserialize(json1, List<BrandQuoteLineWrapper>.class);
        isMulti = multi;
       
        bq = [SELECT Id,Opportunity_Name__c, Ownership__c,Notes__c, Name FROM Brand_Quote__c WHERE Id =:recordId];
        
        quote = qt;
        String recordtypename = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosById().get(quote.RecordTypeId).getname();
        PageReference retPage;
        Id poRecordTypeID;
        
        String redirecId;
        String messages = '';
        Id poliRecordTypeID; 
        if(recordtypename == BRAND_QUOTE_RECORDTYPE_SELL_QUOTE || recordtypename == BRAND_QUOTE_RECORDTYPE_SERVICE_QUOTE){
            poRecordTypeID   = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_RECORDTYPE_INVOICE_ONLY).getRecordTypeId();
            poliRecordTypeID = Schema.SObjectType.Purchase_Order_Line__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_LINE_RECORDTYPE_INVOICE_ONLY).getRecordTypeId();
        }else if(recordtypename == BRAND_QUOTE_RECORDTYPE_RMA){
            poRecordTypeID = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_RECORDTYPE_RMA).getRecordTypeId();
            poliRecordTypeID = Schema.SObjectType.Purchase_Order_Line__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_LINE_RECORDTYPE_RMA).getRecordTypeId();
        }else{
            poRecordTypeID = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_RECORDTYPE_PRODUCT).getRecordTypeId();
            poliRecordTypeID = Schema.SObjectType.Purchase_Order_Line__c.getRecordTypeInfosByName().get(PURCHASE_ORDER_LINE_RECORDTYPE_PRODUCT).getRecordTypeId();
        }
        Map<String,List<Brand_Quote_Line__c>> poToCreate = validateLineItems(messages);
        List<Brand_Quote_Line__c> quoteLines = new List<Brand_Quote_Line__c>();
        Map<String,Purchase_Order__c> producerPOMap = new Map<String,Purchase_Order__c>();
        Map<String,Boolean> PPOLineMap = new Map<String,Boolean>();
        Purchase_Order__c[] POList = new Purchase_Order__c[]{};
            if(poToCreate!=null && !poToCreate.isEmpty()){ 
                if(isMulti){
                    Map<String,List<BrandQuoteLineWrapper>> ownerShipCodePOLIMap = new Map<String,List<BrandQuoteLineWrapper>>();
                    for(BrandQuoteLineWrapper line : lines){
                        Decimal qtyToBill = line.qtyToBill;
                        if(qtyToBill != null && qtyToBill > 0 && line.quoteLine.Product_Name__r.Prepaid__c == false){ 
                            PPOLineMap.put(line.name,true);
                            if(line.isSelected){ 
                                if(ownerShipCodePOLIMap.containsKey(line.name)){
                                    ownerShipCodePOLIMap.get(line.name).add(line);
                                }else{
                                    ownerShipCodePOLIMap.put(line.name, new List<BrandQuoteLineWrapper>{line});
                                }
                            }                                                                                            
                        }
                    }
                    Set<Id> POOpportunityIds = new Set<Id>();
                    for(String producerId: poToCreate.keySet()){
                        if(PPOLineMap.containsKey(producerId) && PPOLineMap.get(producerId) == true){
                            Purchase_Order__c newPO = getPO(bq.Id, recordtypename, poRecordTypeID);
                            newPO.Ownership__c = ownerShipCodePOLIMap.get(producerId)[0].quoteLine.Ownership_Code__c;
                            if(newPO.Opportunity_Name__c != NULL)
                            	POOpportunityIds.add(newPO.Opportunity_Name__c);
                            POList.add(newPO);producerPOMap.put(producerId,newPO);
                            system.debug('POList-----'+POList);
                            system.debug('producerPOMap-----'+producerPOMap);
                        }
                    }
                    Service_Ticket__c[] STs= new List<Service_Ticket__c>();
                    if(POOpportunityIds.size() > 0){
                    	STs = [SELECT Id,Opportunity__c, Name,(select id ,Name,New_Packaged_Product__c,Harvest_Batch_Code__r.Name,UID_New__c FROM Service_Ticket_Lines__r) FROM Service_Ticket__c WHERE Opportunity__c IN :POOpportunityIds];
                    }
                    Map<Id,Service_Ticket__c> opportunitySTMap = new Map<Id,Service_Ticket__c>();
                    for(Service_Ticket__c ST: STs){
                        opportunitySTMap.put(ST.Opportunity__c,ST);
                    }
                    if(!POList.isEmpty()){
                        upsert POList;
                        system.debug('upsertPOList-----'+POList);
                        List<Purchase_Order_Line__c> poLineItems = new List<Purchase_Order_Line__c>(); Boolean isError = false;
                        string membershipLevel = qt.Ownership__r.Membership_Level__c;
                        
                        Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c,Bracket_Price__c ,
                                                                 Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c,Membership_Level__c FROM 
                                                                 Fulfillment_Rates_Table__c WHERE  Active__c = true AND Rate_Effective_From__c <= :System.today() 
                                                                 AND Rate_Effective_To__c >= :System.today() AND Membership_Level__c = :membershipLevel AND Fulfillment_Services__c =: FULFILLMENT_SERVICE_Receiving_Fee ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
                        Map<string,List<Fulfillment_Rates_Table__c>> FRTMap = new Map<string,List<Fulfillment_Rates_Table__c>>();
                        for(Fulfillment_Rates_Table__c FRT :FRTList){
                            if (!FRTMap.containsKey(FRT.Site__c)) {
                                FRTMap.put(FRT.Site__c, new List<Fulfillment_Rates_Table__c>());
                            }
                            FRTMap.get(FRT.Site__c).add(FRT);
                        }
                        for(BrandQuoteLineWrapper line : lines){ 
                            Decimal qtyToBill = line.qtyToBill;
                            if(qtyToBill != null && qtyToBill > 0 && line.quoteLine.Product_Name__r.Prepaid__c == false){
                                Purchase_Order__c newPO = producerPOMap.get(line.name);
                                 system.debug('newPO-----'+newPO);
                                Service_Ticket__c ST = newPO.Opportunity_Name__c != NULL ?opportunitySTMap.get(newPO.Opportunity_Name__c):NULL;
                                Purchase_Order_Line__c newPOLI = getPOLI(line.quoteLine, newPO,poliRecordTypeID,qtyToBill,(ST != NULL?ST.Service_Ticket_Lines__r:NULL),membershipLevel,FRTMap.get(newPO.Site__c));
                                Decimal invQty = line.quoteLine.Billed_Quantity__c != null?line.quoteLine.Billed_Quantity__c : 0;
                                invQty += qtyToBill;
                                quoteLines.add(new Brand_Quote_Line__c(Id = line.quoteLine.Id,Billed_Quantity__c = invQty)); poLineItems.add(newPOLI);
                           system.debug('poLineItems-----'+poLineItems);
                            }
                        }
                        insert poLineItems;
                    }else{ r.data.put('Warning', ERR_MSG_NO_PURCHASE_ORDER_LINES);
                          
                         }
                    
                    redirecId = bq.Id;
                }else{
                    Boolean hasPOLines = false;
                    List<Purchase_Order_Line__c> poLineItems = new List<Purchase_Order_Line__c>();
                    Map<String, Decimal> qtyMap = new Map<String, Decimal>();
                    for(BrandQuoteLineWrapper line : lines){  Decimal qtyToBill = line.qtyToBill;
                                                            if(qtyToBill != null && qtyToBill > 0 && line.quoteLine.Product_Name__r.Prepaid__c == false){ 
                                                                hasPOLines = true;
                                                            }
                                                           }
                    if(hasPOLines){
                        try{
                            set<id> bqlIds = new set<id>();
                            Map<String,List<BrandQuoteLineWrapper>> ownerShipCodePOLIMap = new Map<String,List<BrandQuoteLineWrapper>>();
							Set<String> membershipLevel = new Set<String>();
                            for(BrandQuoteLineWrapper bqlWrapper : lines){    
                                if(bqlWrapper.isSelected){
                                    bqlIds.add(bqlWrapper.quoteLine.Id); 
                                    if(ownerShipCodePOLIMap.containsKey(bqlWrapper.quoteLine.Ownership_Code__c)){
                                        ownerShipCodePOLIMap.get(bqlWrapper.quoteLine.Ownership_Code__c).add(bqlWrapper);
                                    }else{
                                        ownerShipCodePOLIMap.put(bqlWrapper.quoteLine.Ownership_Code__c, new List<BrandQuoteLineWrapper>{bqlWrapper});
                                    }
                                    membershipLevel.add(bqlWrapper.quoteLine.Ownership_Code__r.Membership_Level__c);
                                }
                            }
                            List<AggregateResult> aggResult = [select Ownership_Code__r.Membership_Level__c ,Brand_Quote_Line__c, sum(Qty_Ordered__c) from Purchase_Order_Line__c 
                                                               where Brand_Quote_Line__c  =:bqlIds AND POLI_Status__c NOT IN (:POLI_Status_Cancelled,:POLI_Status_Closed,:POLI_Status_Rejected) GROUP BY Ownership_Code__r.Membership_Level__c,Brand_Quote_Line__c ];
                            String productName = '';
                            Set<String> my_list = new Set<String>();
                            
                            for(String ownershipId : ownerShipCodePOLIMap.keySet()){
                                List<BrandQuoteLineWrapper> BQLIs = ownerShipCodePOLIMap.get(ownershipId);
                                system.debug('## BQLIs 1 : '+BQLIs.size());
                                if(BQLIs != NULL && BQLIs.size() > 0){
                                    String mLevel = BQLIs[0].quoteLine.Ownership_Code__r.Membership_Level__c;
                                    for (AggregateResult aggRes : aggResult){
                                        for( BrandQuoteLineWrapper line : BQLIs){
                                            Decimal qtyOrdered =0; 
                                            Decimal checkQty = 0;
                                            if(line.isSelected && line.quoteLine.Id == aggRes.get('Brand_Quote_Line__c')) {
                                                qtyOrdered = (Decimal) aggRes.get('expr0');
                                                qtyMap.put(line.quoteLine.Id, qtyOrdered);
                                                checkQty = line.qtyToBill + qtyOrdered ;
                                                my_list.add(line.quoteLine.Product_Name__r.Name);
                                                productName = String.join(new List<String>(my_list), ', ');
                                                
                                            }                               
                                            if(line.isSelected && line.quoteLine.Id == aggRes.get('Brand_Quote_Line__c') && line.quoteLine.Line_Total_Qty__c == aggRes.get('expr0')  )
                                            {
                                                message = String.format(ERR_MSG_PURCHASE_ORDER_ALREADY_CREATED,new List<String>{String.valueOf(productName)});
                                                redirecId = bq.Id;                                    
                                            }
                                            else if(line.quoteLine.Line_Total_Qty__c < checkQty){
                                                message= String.format(ERR_MSG_QTY_BILL_NOT_GREAT_THAN_AVAILABLE_QTY,new List<String>{String.valueOf(productName)});
                                                redirecId = bq.Id;
                                            }
                                        }
                                    }
                                }
                            }
                            
                            if(message == null)
                            {
                                Service_Ticket__c[] STs= [select Name from Service_Ticket__c where  Opportunity__c =: bq.Opportunity_Name__c Limit 1];
                                List<Service_Ticket_Line__c>  STL = new List<Service_Ticket_Line__c>();
                                if(STs.size() > 0){
                                    STL= [select id ,Name,New_Packaged_Product__c,Harvest_Batch_Code__r.Name,UID_New__c from Service_Ticket_Line__c where Service_Ticket__c =:STs[0].Id];
                                }
                                
                                Map<String,List<Fulfillment_Rates_Table__c>> FRTMap = new Map<String,List<Fulfillment_Rates_Table__c>>();
                                Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c,Bracket_Price__c ,
                                                                         Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c,Membership_Level__c FROM 
                                                                         Fulfillment_Rates_Table__c WHERE Site__c = :quote.Site__c AND Active__c = true AND Rate_Effective_From__c <= :System.today() 
                                                                         AND Rate_Effective_To__c >= :System.today() AND Membership_Level__c IN : membershipLevel AND Fulfillment_Services__c =: FULFILLMENT_SERVICE_Receiving_Fee ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
                                
                                
                                if(FRTList.size() > 0 ){
                                    for(Fulfillment_Rates_Table__c frt : FRTList){
                                        if(FRTMap.containsKey(frt.Membership_Level__c)){
                                            FRTMap.get(frt.Membership_Level__c).add(frt);
                                        }else{
                                            FRTMap.put(frt.Membership_Level__c,new List<Fulfillment_Rates_Table__c>{frt});
                                        }
                                    }
                                }
                                Map<String,Purchase_Order__c> newPOMap = new Map<String,Purchase_Order__c>(); 
                                Map<String,List<Purchase_Order_Line__c>> newPOLIMap = new Map<String,List<Purchase_Order_Line__c>>();
                                
                                for(String ownershipId : ownerShipCodePOLIMap.keySet()){
                                    List<BrandQuoteLineWrapper> BQLIs = ownerShipCodePOLIMap.get(ownershipId);
                                    system.debug('## BQLIs 1 : '+BQLIs.size());
                                    if(BQLIs != NULL && BQLIs.size() > 0){
                                        String mLevel = BQLIs[0].quoteLine.Ownership_Code__r.Membership_Level__c;
                                        Purchase_Order__c newPO = getPO(bq.Id, recordtypename, poRecordTypeID);
                                        newPO.Ownership__c = ownershipId;
                                        //BQLIs[0].quoteLine.Ownership_Code__c;
                                        List<Purchase_Order_Line__c> lstPoli = new List<Purchase_Order_Line__c>();
                                        for(BrandQuoteLineWrapper line : BQLIs){ 
                                            Decimal qtyToBill = line.qtyToBill;                               
                                            if(qtyToBill != null && qtyToBill > 0 && line.quoteLine.Product_Name__r.Prepaid__c == false){
                                                Decimal invQty = line.quoteLine.Billed_Quantity__c != null?line.quoteLine.Billed_Quantity__c : 0;
                                                invQty += qtyToBill;
                                                Decimal aggQty = qtyMap.get(line.quoteLine.Id) != null? qtyMap.get(line.quoteLine.Id):0;
                                                aggQty += qtyToBill;
                                                Purchase_Order_Line__c newPOLI = getPOLI(line.quoteLine, newPO,poliRecordTypeID,qtyToBill,STL,mLevel,(FRTMap.containsKey(mLevel) ? FRTMap.get(mLevel) : new List<Fulfillment_Rates_Table__c>()));
                                                quoteLines.add(new Brand_Quote_Line__c(Id = line.quoteLine.Id,Billed_Quantity__c = aggQty));
                                                aggQty = 0;
                                                //poLineItems.add(newPOLI);
                                                lstPoli.add(newPOLI);
                                            } 
                                            
                                        }
                                        newPOMap.put(ownershipId,newPO);
                                        newPOLIMap.put(ownershipId,lstPoli);
                                    }
                                }
                                
                                //Purchase_Order__c newPO = getPO(bq.Id, recordtypename, poRecordTypeID);
                                //insert newPO;
                                
                                if(!newPOLIMap.values().isEmpty()){
                                    String POId='';
                                    insert newPOMap.values();
                                    List<Purchase_Order_Line__c> newPOLIs = new List<Purchase_Order_Line__c>();
                                    for(String  oCode :newPOMap.keySet()){
                                        Purchase_Order__c PO = newPOMap.get(oCode);
                                        POId = PO.Id;
                                        for(Purchase_Order_Line__c line: newPOLIMap.get(oCode)){
                                            line.Purchase_Order__c = PO.Id;
                                            newPOLIs.add(line);
                                        }
                                    }
                                    redirecId = POId;
                                    insert newPOLIs;
                                }
                                
                            }
                        }catch(Exception ex){message = ex.getMessage();
                                             system.debug('##error : '+ex.getLineNumber());
                                            }
                    }else{
                        r.data.put('Warning', ERR_MSG_NO_PURCHASE_ORDER_LINES);  redirecId = bq.Id;
                        
                    }
                    
                }
                
                
                if(quoteLines.size() > 0) update quoteLines;
                
            }
        
        r.data.put('recordIds', redirecId);
        r.data.put('Error', message);
        return r;
    }
    
    @Auraenabled
    public static AuraResponse updateQtyToBillForProducerBQLines(String json1){
        AuraResponse r = new AuraResponse('BrandQuoteCreatePOCtrl.updateQtyToBillForProducerBQLines()');
        lines = (List<BrandQuoteLineWrapper>) System.JSON.deserialize(json1, List<BrandQuoteLineWrapper>.class);
        for(BrandQuoteLineWrapper bqLineWrapper: lines){
            if(bqLineWrapper.isSelected && (bqLineWrapper.qtyToBill == 0 || bqLineWrapper.qtyToBill == null))bqLineWrapper.qtyToBill = bqLineWrapper.isSelected?(bqLineWrapper.quoteLine.Billed_Quantity__c != null ?(bqLineWrapper.quoteLine.Line_Total_Qty__c - bqLineWrapper.quoteLine.Billed_Quantity__c):bqLineWrapper.quoteLine.Line_Total_Qty__c):0;
            else if(!bqLineWrapper.isSelected) {
                bqLineWrapper.qtyToBill = 0;
            }
        } 
        r.data.put('records',lines);
        return r;
    }
    
    @Auraenabled
    public static AuraResponse updateQtyToBillForSelectedProducerBQLines(String json1,String selectedProducerId){
        AuraResponse r = new AuraResponse('BrandQuoteCreatePOCtrl.updateQtyToBillForSelectedProducerBQLines()');
        lines = (List<BrandQuoteLineWrapper>) System.JSON.deserialize(json1, List<BrandQuoteLineWrapper>.class);
        for(BrandQuoteLineWrapper spw : lines){    
            if(spw.producerId == selectedProducerId){spw.qtyToBill = spw.isSelected?(spw.quoteLine.Billed_Quantity__c != null ?(spw.quoteLine.Line_Total_Qty__c - spw.quoteLine.Billed_Quantity__c):spw.quoteLine.Line_Total_Qty__c):0;                    
                                                    }     
        }
        r.data.put('records', lines);
        return r;
    }
    
    public static Purchase_Order__c getPO(String bqId, String recordtypename, String poRecordTypeID){
        Purchase_Order__c newPO = new Purchase_Order__c();
        newPO.Brand_Quote__c = bqID;
        newPO.PO_Status__c = PURCHASE_ORDER_STATUS_DRAFT;
        newPO.PO_Type__c = recordtypename;
        newPO.PO_Date__c = Date.today();
        newPO.Purchase_Order_Instructions__c = quote.Notes__c;
        newPO.Ownership__c = quote.Ownership__c;
        newPO.Opportunity_Name__c = quote.Opportunity_Name__c;
        newPO.Distributor_Name__c = quote.Distributor_Name__c;
        newPO.Distributor_License__c = quote.Distributor_License__c;
        newPO.Distributor_Contact__c = quote.Distributor_Contact__c;
        if(isFactoringPO == true){
            newPO.Supplier_Name__c = quote.Factoring_Assignee__c;
            newPO.Supplier_Contact__c = quote.Factoring_Contact__c;
        }else{
            newPO.Supplier_Name__c = quote.Supplier_Name__c;
            newPO.Supplier_License__c = quote.Supplier_License__c;
            newPO.Supplier_Contact__c = quote.Supplier_Contact__c;  
        }
        newPO.Factoring_Assignee__c = quote.Factoring_Assignee__c;
        newPO.Factoring_Contact__c = quote.Factoring_Contact__c;
        newPO.Factoring_Rate__c = quote.Factoring_Rate__c; 
        newPO.Factoring_Discount__c = quote.Factoring_Discount__c;
        if(String.isNotBlank(quote.Order_Type__c)){
            newPO.Receiver_Name__c = quote.Distributor_Name__c;
            newPO.Receiver_License__c = quote.Distributor_License__c;
            newPO.Receiver_Contact__c = quote.Distributor_Contact__c;
        } else {
            newPO.Receiver_Name__c = quote.Receiver_Name__c;
            newPO.Receiver_License__c = quote.Receiver_License__c;
            newPO.Receiver_Contact__c = quote.Receiver_Contact__c;
        }
        newPO.Shipping_Terms__c = quote.Shipping_Terms__c;
        newPO.Shipping_Method__c = quote.Shipping_Method__c;
        newPO.Payment_Terms__c = quote.Payment_Terms__c;
        newPO.Sample_Order__c = quote.Sample_Order__c;
        newPO.RecordTypeId = poRecordTypeID;
        newPO.Site__c = quote.Site__c;
        newPO.Planned_Ship_Transfer_Date__c = quote.Planned_Transfer_Date__c;
        newPO.Total_Weight_Fee__c = quote.Total_Weight_Fee__c;
        newPO.Total_Mileage_Fee__c = quote.Total_Mileage_Fee__c;
        newPO.Service_Booking_Fee__c = quote.Service_Booking_Fee__c;
        newPO.Service_Scheduling_Fee__c = quote.Service_Scheduling_Fee__c;
        newPO.Service_Staging_Fee__c  = quote.Service_Staging_Fee__c ;
        
        if(quote.Site__r.Name.equals(SITE_NAME_7027) && String.isNotBlank(quote.Order_Type__c)){
            Company_Custom_Settings__c companySettingRec = Company_Custom_Settings__c.getOrgDefaults();
            newPO.Receiver_Name__c = companySettingRec.Default_Distributor__c;
            newPO.Receiver_License__c = companySettingRec.Default_License__c;
        }
         newPO.Create_Supplier_Bill__c = true;
        //newPO.Payment_Eligible__c = True;
        newPO.Bill_Created__c = true;
        
        return newPO;
    }
    
    public static Purchase_Order_Line__c getPOLI(Brand_Quote_Line__c qline, Purchase_Order__c newPO,String poliRecordTypeID, Decimal newQty,List<Service_Ticket_Line__c>  STL,String membershipLevel,List<Fulfillment_Rates_Table__c> FRTList){
        //select Name,(select id ,Name,Harvest_Batch_Code__r.Name,UID_New__c from Service_Ticket_Lines__r) from Service_Ticket__c where  Opportunity__c = '0067b00000Fu8hiAAB'
		//Service_Ticket__c ST= [select Name,(select id ,Name,Harvest_Batch_Code__r.Name,UID_New__c from Service_Ticket_Lines__r)  from Service_Ticket__c where  Opportunity__c =: quote.Opportunity_Name__c];
 		Purchase_Order_Line__c newPOLI = new Purchase_Order_Line__c();
        newPOLI.Brand_Quote_Line__c = qline.Id;
        newPOLI.Product_Name__c =  qline.Product_Name__c;
        newPOLI.Product_Title__c =  qline.Product_Title__c; 
        newPOLI.Qty_Ordered__c = newQty;
        newPOLI.Purchase_Order__c = newPO.Id != null ? newPO.Id : null;
        newPOLI.Unit_Cost__c = qline.Disty_Cost__c;
        newPOLI.Is_Sample__c = qline.Is_Sample__c;
        newPOLI.RecordTypeId = poliRecordTypeID;
		newPOLI.Total_Weight_lbs__c = qline.Total_Weight_lbs__c;
        
        Decimal receivingFee = 0;
        decimal receivingPrice = 0;
        //String siteId = newPO.Site__c;
        Decimal weight = qline.Product_Name__r.Unit_Shipping_Weight_lbs__c;
        if(qline.MOQ__c > 1){
            weight = qline.Product_Name__r.Case_Shipping_Weight_lbs__c;
        }
       /* Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c,Bracket_Price__c ,
			Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c,Membership_Level__c FROM 
			Fulfillment_Rates_Table__c WHERE Site__c = :siteId AND Active__c = true AND Rate_Effective_From__c <= :System.today() 
			AND Rate_Effective_To__c >= :System.today() AND Membership_Level__c = :membershipLevel AND Fulfillment_Services__c =: FULFILLMENT_SERVICE_Receiving_Fee ORDER BY Weight_lbs__c DESC, MOQ__c DESC];*/
        if(!FRTList.isEmpty()){
            for(Fulfillment_Rates_Table__c FRT: FRTList){
                if(FRT.Weight_lbs__c  <= weight && FRT.MOQ__c <= qline.MOQ__c){
                    System.debug('###FRT for Receiving_Fee:'+FRT);
                    receivingPrice = FRT.Bracket_Price__c;
                    break;
                }
            }
        }
        newPOLI.Receiving_Fee__c = receivingPrice * qline.Line_Total_Qty__c;// Quantity_Cases__c* qline.MOQ__c;
        
        if(! Test.isRunningTest()) newPOLI.Ownership_Code__c = qline.Ownership_Code__c == null?bq.Ownership__c: qline.Ownership_Code__c;
        if(STL != NULL && STL.size() > 0){
            for(Service_Ticket_Line__c STLObj :STL){
                if(STLObj.New_Packaged_Product__c  == qline.Product_Name__c){
                    newPOLI.UID_New__c = STLObj.UID_New__c; 
                    //newPOLI.Harvest_Batch_Code__c =STLObj.Harvest_Batch_Code__c;
                } 
            }
        }
        newPOLI.Harvest_Batch_Code__c = qline.Harvest_Batch_Code__c;
            system.debug('newPOLI----'+newPOLI);
        return newPOLI;
    }
    public static Map<String,List<Brand_Quote_Line__c>> validateLineItems(String messages){
        Map<String,List<Brand_Quote_Line__c>> poToCreate = new Map<String,List<Brand_Quote_Line__c>>();
        Boolean isError = true;
        Boolean isAllNegative = true;
        List<string> Productsnames = new List<string>();
        string allproductName ;
        List<Brand_Quote_Line__c> bqLines = new List<Brand_Quote_Line__c>();
        for(BrandQuoteLineWrapper line : lines){  
            
            
            if(line.isSelected && line.quoteLine.Product_Name__r.Prepaid__c == True) 
            {	
                if(line.quoteLine.Product_Name__r.White_Labelled__c == true){
                    Productsnames.add(line.quoteLine.Product_Name__r.Licensee_Name__c);
                }else{
                    Productsnames.add(line.quoteLine.Product_Name__r.Name);
                }
                //Productsnames.add(line.quoteLine.Product_Name__r.Name);
                allproductName = string.join(Productsnames ,', ');
                message = String.format(ERR_MSG_PRODUCT_PREPAID_VALIDATION,new List<String>{String.valueOf(allproductName)});
            }
            
            
            if(line.isSelected){ Decimal qtyToBill = line.qtyToBill;
                                if(qtyToBill > 0){ isAllNegative = false;
                                    if(poToCreate.containsKey(line.Name)){bqLines = poToCreate.get(line.Name);
                                                                         }
                                    bqLines.add(line.quoteLine);poToCreate.put(line.name,bqLines);
                                    
                                } 
                                Decimal qytAvail = line.quoteLine.Billed_Quantity__c != null?line.quoteLine.Line_Total_Qty__c - line.quoteLine.Billed_Quantity__c : line.quoteLine.Line_Total_Qty__c;
                                System.debug(qtyToBill+' ##qytAvailAndqtyToBill: '+qytAvail);
                                if(isAllNegative && (String.isBlank(String.valueOf(qtyToBill)) || qtyToBill <0 ))
                                {
                                    message = ERR_MSG_POSITIVE_VALUES; isError = false;
                                    
                                }else if( qtyToBill > qytAvail){ message = ERR_MSG_QTYBILL_GREATER_VALUES; isError = false;
                                                                
            }  
                                
          }
        }
        
        if( !isError){ return null;
                     }
        
        if(isAllNegative){             
            message = ERR_MSG_RPRODUCT_GREATER_VALUES;
        } 
        
        return poToCreate;
    }
    
    public PageReference backToQuote(){
        PageReference retPage =new PageReference('/'+bq.Id);
        retPage.setRedirect(true);
        return retPage;
    }
    public class AllProductDetails{
        @AuraEnabled public List<splitPoWrpr> items {get; set;}
        @AuraEnabled public Boolean isValid {get; set;}
        @AuraEnabled public Boolean hasLines {get; set;}
        @AuraEnabled public Brand_Quote__c quote {get; set;}
        @AuraEnabled public Boolean isMulti {get; set;}
        @AuraEnabled public String redirectId {get; set;}
        @AuraEnabled public Decimal qtyToBill {get; set;}
        @Auraenabled public List<BrandQuoteLineWrapper> lines{get;set;}
    }
    
    public class splitPoWrpr{
        @Auraenabled public Boolean isSelected {get; set;}
        @Auraenabled public String name{get;set;}
        @Auraenabled public String producerId{set;get;}
        @Auraenabled public List<BrandQuoteLineWrapper> lines{get;set;}
        @AuraEnabled public Integer size { get; set; } 
        @Auraenabled public Brand_Quote_Line__c quoteLine {get; set;}
        
        public splitPoWrpr(){
            this.isSelected = false;    
        }
    }
    
    public class BrandQuoteLineWrapper{
        @Auraenabled public Boolean isSelected {get; set;}
        @Auraenabled public Boolean isDisabled {get; set;}
        @Auraenabled public Brand_Quote_Line__c quoteLine {get; set;}
        @Auraenabled public Decimal qtyToBill {get; set;}
        @AuraEnabled public Integer size { get; set; }  
        @AuraEnabled public Integer counter {get;set;}
        @Auraenabled public String name{get;set;}
        @Auraenabled public String producerId{set;get;}
        
        public BrandQuoteLineWrapper(){
            this.isSelected = false;    
        }
        // Constructor
        public BrandQuoteLineWrapper(Brand_Quote_Line__c quoteLine,Boolean isSelect){
            this.isSelected = isSelect;
            this.isDisabled = false;
            this.quoteLine = quoteLine;
            this.qtyToBill = 0;
            this.counter = 2;
        }
        
        public BrandQuoteLineWrapper(Brand_Quote_Line__c quoteLine,Integer counter,Boolean isSelect){
            this.isSelected = isSelect;
            this.isDisabled = false;
            this.quoteLine = quoteLine;
            this.qtyToBill = 0;
            this.counter = counter;
        }
        
    }
}