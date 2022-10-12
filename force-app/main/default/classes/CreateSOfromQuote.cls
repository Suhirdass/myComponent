/*
Copyright (c) 2018 Filigreen Distro
All rights reserved.

•  Test class  Name:  CreateRLfromPOlineTest
*/
public class CreateSOfromQuote  {
    
    private ApexPages.StandardController stdController;
    private Brand_Quote__c bq = null;
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
    private Static String SO_SHIPPING_METHOD_PICK_UP{ 
        get{
            return  String.isNotBlank(SO_SHIPPING_METHOD_PICK_UP) ? SO_SHIPPING_METHOD_PICK_UP :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Shipping_Method_Pick_Up');
        }set;
    }
    private Static String SALESORDER_RECORDTYPE_Transfer {		
        get{
              return String.isNotBlank(SALESORDER_RECORDTYPE_Transfer) ? SALESORDER_RECORDTYPE_Transfer: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Type_Transfer');
        }set;
    }
	private Static String BRAND_QUOTE_STATUS_APPROVED{
        get{
            return String.isNotBlank(BRAND_QUOTE_STATUS_APPROVED) ? BRAND_QUOTE_STATUS_APPROVED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Status_Approved');
        }set;
    }
    private Static String TYPE_SERVICEQUOTE{ 
        get{
            return  String.isNotBlank(TYPE_SERVICEQUOTE) ? TYPE_SERVICEQUOTE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_Service_Quote');
        }set;
    }
    public Static String BRAND_QUOTE_RECORDTYPE_RMA{
        get{
            return String.isNotBlank(BRAND_QUOTE_RECORDTYPE_RMA) ? BRAND_QUOTE_RECORDTYPE_RMA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_DevName_RMA');
        }set;
    }
    public Static String BRAND_QUOTE_RECORDTYPE_LABQUOTE{
        get{
            return String.isNotBlank(BRAND_QUOTE_RECORDTYPE_LABQUOTE) ? BRAND_QUOTE_RECORDTYPE_LABQUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_Name_Lab_Quote');
        }set;
    }
    public Static String BRAND_QUOTE_RECORDTYPE_TRANSFER_QUOTE{
        get{
            return String.isNotBlank(BRAND_QUOTE_RECORDTYPE_TRANSFER_QUOTE) ? BRAND_QUOTE_RECORDTYPE_TRANSFER_QUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_Name_Transfer_Quote');
        }set;
    }
    private Static String SO_STATUS_DRAFT {		
        get{
              return String.isNotBlank(SO_STATUS_DRAFT) ? SO_STATUS_DRAFT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Draft');
        }set;
    }
    private Static String SO_RECORDTYPE_SERVICE {		
        get{
              return String.isNotBlank(SO_RECORDTYPE_SERVICE) ? SO_RECORDTYPE_SERVICE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_Service');
        }set;
    }
    private Static String SO_RECORDTYPE_RMA {		
        get{
              return String.isNotBlank(SO_RECORDTYPE_RMA) ? SO_RECORDTYPE_RMA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_RMA');
        }set;
    }
    private Static String SO_RECORDTYPE_LAB {		
        get{
              return String.isNotBlank(SO_RECORDTYPE_LAB) ? SO_RECORDTYPE_LAB : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_Lab');
        }set;
    }
    private Static String SO_RECORDTYPE_TRANSFER {		
        get{
              return String.isNotBlank(SO_RECORDTYPE_TRANSFER) ? SO_RECORDTYPE_TRANSFER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_Transfer');
        }set;
    }
    private Static String SO_RECORDTYPE_PRODUCT {		
        get{
              return String.isNotBlank(SO_RECORDTYPE_PRODUCT) ? SO_RECORDTYPE_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_Product');
        }set;
    }
    
    private static String SOLI_STATUS_OPEN{
        get{
            return String.isNotBlank(SOLI_STATUS_OPEN) ? SOLI_STATUS_OPEN : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_Status_Open');
        }set;
    }
    private static String SOLI_RECORDTYPE_SERVICE{
        get{
            return String.isNotBlank(SOLI_RECORDTYPE_SERVICE) ? SOLI_RECORDTYPE_SERVICE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_RecordType_Service');
        }set;
    }
    private static String SOLI_RECORDTYPE_RMA{
        get{
            return String.isNotBlank(SOLI_RECORDTYPE_RMA) ? SOLI_RECORDTYPE_RMA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_RecordType_RMA');
        }set;
    }
    private static String SOLI_RECORDTYPE_LAB{
        get{
            return String.isNotBlank(SOLI_RECORDTYPE_LAB) ? SOLI_RECORDTYPE_LAB : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_RecordType_Lab');
        }set;
    }
    private static String SOLI_RECORDTYPE_TRANSFER{
        get{
            return String.isNotBlank(SOLI_RECORDTYPE_TRANSFER) ? SOLI_RECORDTYPE_TRANSFER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_RecordType_Transfer');
        }set;
    }
    private static String SOLI_RECORDTYPE_PRODUCT{
        get{
            return String.isNotBlank(SOLI_RECORDTYPE_PRODUCT) ? SOLI_RECORDTYPE_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_RecordType_Product');
        }set;
    }
    private Static String ERR_MSG_APPROVED_BRAND_QUOTE_FOR_SO{ 
        get{ 
            return String.isNotBlank(ERR_MSG_APPROVED_BRAND_QUOTE_FOR_SO) ? ERR_MSG_APPROVED_BRAND_QUOTE_FOR_SO : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','Err_Msg_Approved_BQ_For_SO');
        }set;
    }
    
    
    public CreateSOfromQuote(ApexPages.StandardController controller) {
        this.stdController = controller;
        bq = ((Brand_Quote__c)stdController.getRecord());
    }
    public class UserException extends Exception{ }
    
    public PageReference createSO() {
        PageReference retPage = null;
        try
        {
            Brand_Quote__c bq = [select id, BQ_Status__c from Brand_Quote__c where Id  =: bq.Id];
            if(bq.BQ_Status__c != BRAND_QUOTE_STATUS_APPROVED)
                throw new UserException(ERR_MSG_APPROVED_BRAND_QUOTE_FOR_SO);
            
            /*   List<Sales_Order__c> objects = [Select id from Sales_Order__c where Brand_Quote__c =: bq.Id and SO_Status__c = 'Approved'];
if (objects.size() >= 1) 
{
throw new UserException('Brand Quote has already been converted to a Sales Order. You cannot have more than one Approved Sales Order for a quote.');
}*/
            retPage = createOrder(bq.Id);
            retPage.setRedirect(true);
        } 
        catch (Exception ex)
        {
            ErrorLogs.log('CreateSOfromQuote:createSO()',ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return retPage;
    }
    
    public static PageReference createOrder(Id quoteId)
    {
        PageReference retPage = null;
        ID bqID = quoteId;
        Brand_Quote__c quote = [select id ,name,RecordTypeId
                                ,BQ_Status__c
                                ,Opportunity_Name__c
                                ,Sample_Order__c
                                ,Opportunity_Name__r.AccountId
                                ,Payment_Terms__c
                                ,Site__c
                                ,Notes__c
                                ,Ownership__c
                                ,Customer_PO_or_Quote__c
                                ,Shipping_Method__c
                                ,Shipping_Terms__c
                                ,Receiver_Name__c
                                ,Receiver_License__c
                                ,Receiver_Contact__c
                                ,Supplier_Name__c
                                ,Supplier_License__c
                                ,Supplier_Contact__c
                                ,Distributor_Name__c
                                ,Distributor_License__c
                                ,Distributor_Contact__c
                                ,Requested_Ship_Date__c
                                ,Service_Ticket_Line__c
                                ,Total_Quoted_Price__c
                                ,Planned_Ship_Date__c,
                                Total_Weight_Fee__c , 
                                Factoring_Assignee__c,
                                Factoring_Contact__c,
                                Factoring_Rate__c,
                                Factoring_Discount__c,
                                Retailer_PO__c,Opportunity_Name__r.Order__r.Retailer__r.Third_Party_Scheduler__c,
                                Total_Mileage_Fee__c  ,Ownership__r.Platform_Level__c,Opportunity_Name__r.Order__r.Piggyback_sample__c,
                                Invoice_Memo__c,Supplier_Name__r.DBA__c,Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c,
                                Stage_Manifest_Fee__c , Schedule_Dispatch_Fee__c , Receiver_Name__r.DBA__c,
                                Pack_Out_Fee__c , Order_Booking_Fee__c,Opportunity_Name__r.Order__c,
                                Opportunity_Name__r.Order__r.Requested_Delivery_Earliest_Time__c,
                                Opportunity_Name__r.Order__r.Requested_Delivery_Latest_Time__c
                                from Brand_Quote__c where id =: bqID];
        if(quote.Service_Ticket_Line__c != null){
            Service_Ticket_Line__c stl = new Service_Ticket_Line__c(Id = quote.Service_Ticket_Line__c, Total_Quoted_Price__c = quote.Total_Quoted_Price__c);
            update stl;
        }
        //if (quote.fieldnameTBD != null){
        //throw new CustomerQuotationException('Brand Quote has already been converted to a Sales Order.  You can only have one Sales Order for a quote.');
        //}
        List<Brand_Quote_Line__c> quoteLines = [select id
                                                ,name
                                                ,Brand_Quote_Number__c
                                                ,Disty_Margin__c
                                                ,MOQ__c
                                                ,Price_Book__c
                                                ,Line_Total_Qty__c
                                                ,Product_Name__c
                                                ,Product_Title__c
                                                ,Retail_Wholesale_Price__c
                                                ,Is_Sample__c,Ownership_Code__c,IsPromo__c
                                                ,Pick_Pack_Fee__c,QA_Review_Fee__c, Total_Weight_lbs__c,Listing_Fee__c
                                                from Brand_Quote_Line__c
                                                where Brand_Quote_Number__c =: bqID];
        
        string recordtypename = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosById().get(quote.RecordTypeId).getname();
        
        Id soRecordTypeId;
        if(recordtypename == TYPE_SERVICEQUOTE)
            soRecordTypeId = Schema.SObjectType.Sales_Order__c.getRecordTypeInfosByDeveloperName().get(SO_RECORDTYPE_SERVICE).getRecordTypeId();
        else if(recordtypename == BRAND_QUOTE_RECORDTYPE_RMA)
            soRecordTypeId = Schema.SObjectType.Sales_Order__c.getRecordTypeInfosByDeveloperName().get(SO_RECORDTYPE_RMA).getRecordTypeId();
        else if(recordtypename == BRAND_QUOTE_RECORDTYPE_LABQUOTE)
            soRecordTypeId = Schema.SObjectType.Sales_Order__c.getRecordTypeInfosByDeveloperName().get(SO_RECORDTYPE_LAB).getRecordTypeId();
        else if(recordtypename == BRAND_QUOTE_RECORDTYPE_TRANSFER_QUOTE)
            soRecordTypeId = Schema.SObjectType.Sales_Order__c.getRecordTypeInfosByDeveloperName().get(SO_RECORDTYPE_TRANSFER).getRecordTypeId();
        else
            soRecordTypeId = Schema.SObjectType.Sales_Order__c.getRecordTypeInfosByDeveloperName().get(SO_RECORDTYPE_PRODUCT).getRecordTypeId();
        
        Sales_Order__c newSO = new Sales_Order__c();
        newSO.Brand_Quote__c = bqID;
        newSO.SO_Status__c = SO_STATUS_DRAFT;
        newSO.Ownership__c = quote.Ownership__c;
        //newSO.SO_Type__c = recordtypename;
        newSO.Shipping_Terms__c = quote.Shipping_Terms__c;
        newSO.Shipping_Method__c = quote.Shipping_Method__c;
        newSO.Payment_Terms__c = quote.Payment_Terms__c;
        newSO.Site__c = quote.Site__c;
        newSO.Sample_Order__c = quote.Sample_Order__c;
        newSO.Customer_PO_or_Quote__c = quote.Customer_PO_or_Quote__c;
        newSO.Opportunity_Name__c = quote.Opportunity_Name__c;
        newSO.Distributor_Name__c = quote.Distributor_Name__c;
        newSO.Distributor_License__c = quote.Distributor_License__c;
        newSO.Distributor_Contact__c = quote.Distributor_Contact__c;
        newSO.Supplier_Name__c = quote.Supplier_Name__c;
        newSO.Supplier_License__c = quote.Supplier_License__c;
        newSO.Supplier_Contact__c = quote.Supplier_Contact__c;
        newSO.Receiver_Name__c = quote.Receiver_Name__c;
        newSO.Receiver_License__c = quote.Receiver_License__c;
        newSO.Receiver_Contact__c = quote.Receiver_Contact__c;
        newSO.Order_Booking_Fee__c = quote.Order_Booking_Fee__c;
        newSO.Pack_Out_Fee__c = quote.Pack_Out_Fee__c;
        newSO.Schedule_Dispatch_Fee__c = quote.Schedule_Dispatch_Fee__c;
        newSO.Stage_Manifest_Fee__c = quote.Stage_Manifest_Fee__c;
        newSO.Sales_Order_Instructions__c = quote.Notes__c;
        newSO.Invoice_Memo__c = quote.Invoice_Memo__c;
        newSO.RecordTypeId = soRecordTypeId;
        
        if(quote.Opportunity_Name__r.Order__c != null){
            newSO.Third_Party_Scheduler__c = quote.Opportunity_Name__r.Order__r.Retailer__r.Third_Party_Scheduler__c;
            newSO.Piggyback_sample__c = quote.Opportunity_Name__r.Order__r.Piggyback_sample__c;
        }
        
        /*if(recordtypename == BRAND_QUOTE_RECORDTYPE_TRANSFER_QUOTE && newSO.Shipping_Method__c != NULL && newSO.Shipping_Method__c.contains(SO_SHIPPING_METHOD_PICK_UP)){
            newSO.Total_Mileage_Fee__c = 0;
            newSO.Total_Weight_Fee__c = 0;
        } else {
            
        }*/
        newSO.Total_Mileage_Fee__c = quote.Total_Mileage_Fee__c;
        newSO.Total_Weight_Fee__c = quote.Total_Weight_Fee__c;
        Boolean skipMWFee = false;
        if(quote.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE  && 
           (
               (quote.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || quote.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR) 
               || (quote.Supplier_Name__r.DBA__c == Account_Plateformlevel_ZASP || quote.Supplier_Name__r.DBA__c == Account_Plateformlevel_IRR)
           ) 
           && recordtypename == BRAND_QUOTE_RECORDTYPE_TRANSFER_QUOTE){
               skipMWFee = true;
           }  
        if(
            (
                (quote.Supplier_Name__r.DBA__c != Account_Plateformlevel_ZASP && quote.Supplier_Name__r.DBA__c != Account_Plateformlevel_IRR) 
                || (quote.Receiver_Name__r.DBA__c != Account_Plateformlevel_ZASP && quote.Receiver_Name__r.DBA__c != Account_Plateformlevel_IRR)
            ) && (quote.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_ZASP && quote.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_IRR) && recordtypename == BRAND_QUOTE_RECORDTYPE_TRANSFER_QUOTE){
                skipMWFee = true;
            } 
        if(skipMWFee == true && recordtypename == BRAND_QUOTE_RECORDTYPE_TRANSFER_QUOTE){
           newSO.Total_Mileage_Fee__c = 0;
                 newSO.Total_Weight_Fee__c = 0; 
        }
        //newSO.Planned_Ship_Date__c = quote.Planned_Ship_Date__c;// Requested_Ship_Date__c;
        if(quote.Opportunity_Name__r.Order__c != null){
            newSO.Window_End__c = quote.Opportunity_Name__r.Order__r.Requested_Delivery_Latest_Time__c;
            newSO.Window_Start__c = quote.Opportunity_Name__r.Order__r.Requested_Delivery_Earliest_Time__c;
        }
        
        newSO.Retailer_PO__c = quote.Retailer_PO__c;
        newSO.Factoring_Assignee__c = quote.Factoring_Assignee__c;
        newSO.Factoring_Contact__c = quote.Factoring_Contact__c;
        newSO.Factoring_Rate__c = quote.Factoring_Rate__c;
        newSO.Factoring_Discount__c = quote.Factoring_Discount__c;
        //newSO.Planned_Ship_Date__c = quote.Requested_Ship_Date__c;
        try
        {
            insert newSO;
            List<Sales_Order_Line__c> soLineItems = new List<Sales_Order_Line__c>();
            Id soliRecordTypeId;
            if(recordtypename == TYPE_SERVICEQUOTE)
                soliRecordTypeId = Schema.SObjectType.Sales_Order_Line__c.getRecordTypeInfosByDeveloperName().get(SOLI_RECORDTYPE_SERVICE).getRecordTypeId();
            else if(recordtypename == BRAND_QUOTE_RECORDTYPE_RMA)
                soliRecordTypeId = Schema.SObjectType.Sales_Order_Line__c.getRecordTypeInfosByDeveloperName().get(SOLI_RECORDTYPE_RMA).getRecordTypeId();
            else if(recordtypename == BRAND_QUOTE_RECORDTYPE_LABQUOTE)
                soliRecordTypeId = Schema.SObjectType.Sales_Order_Line__c.getRecordTypeInfosByDeveloperName().get(SOLI_RECORDTYPE_LAB).getRecordTypeId();
            else if(recordtypename == BRAND_QUOTE_RECORDTYPE_TRANSFER_QUOTE)
                soliRecordTypeId = Schema.SObjectType.Sales_Order_Line__c.getRecordTypeInfosByDeveloperName().get(SOLI_RECORDTYPE_TRANSFER).getRecordTypeId();
            else
                soliRecordTypeId = Schema.SObjectType.Sales_Order_Line__c.getRecordTypeInfosByDeveloperName().get(SOLI_RECORDTYPE_PRODUCT).getRecordTypeId();
            For (Brand_Quote_Line__c qline : quoteLines)
            {
                Sales_Order_Line__c newSOLI = new Sales_Order_Line__c();
                newSOLI.Brand_Quote_Line__c = qline.Id;
                newSOLI.Status__c = SOLI_STATUS_OPEN;
                newSOLI.Product_Name__c =  qline.Product_Name__c;
                newSOLI.Product_Title__c =  qline.Product_Title__c;
                newSOLI.Qty_Ordered__c = qline.Line_Total_Qty__c;
                newSOLI.Actual_Qty_Ordered__c = qline.Line_Total_Qty__c;
                newSOLI.Sales_Order__c = newSO.Id;
                newSOLI.Is_Sample__c = qline.Is_Sample__c;
                newSOLI.IsPromo__c = qline.IsPromo__c;
                newSOLI.Retail_Wholesale_Price__c = qline.Retail_Wholesale_Price__c;
                newSOLI.RecordTypeId = soliRecordTypeId;
                newSOLI.Ownership_Code__c = qline.Ownership_Code__c;
                newSOLI.Pick_Pack_Fee__c = qline.Pick_Pack_Fee__c;
                newSOLI.QA_Review_Fee__c = qline.QA_Review_Fee__c;
                newSOLI.Total_Weight_lbs__c = qline.Total_Weight_lbs__c;
                newSOLI.Listing_Fee__c = qline.Listing_Fee__c;
                soLineItems.add(newSOLI);
            }
            insert soLineItems;
        }
        catch(Exception ex)
        {
            ErrorLogs.log('CreateSOfromQuote:createOrder()',ex.getStackTraceString(), ex.getMessage());
            
        }
        retPage =new PageReference('/'+newSO.Id);
        return retPage;
    }
    
    public PageReference goBack() {
        return stdController.view().setRedirect(true);
    }
}