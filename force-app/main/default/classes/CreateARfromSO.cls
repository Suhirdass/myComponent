/*
Copyright (c) 2018 Filigreen Distro
All rights reserved.

•  Test class  Name:  CreateARfromSOTest
*/

public class CreateARfromSO  {
    
    private ApexPages.StandardController stdController;
    private Sales_Order__c so = null;
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
    public Static String SALES_ORDER_STATUS_APPROVED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_APPROVED) ? SALES_ORDER_STATUS_APPROVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Approved');
        }set;
    }
    private Static String INVOICE_RECORDTYPE_SERVICE{
        get{
            return String.isNotBlank(INVOICE_RECORDTYPE_SERVICE) ? INVOICE_RECORDTYPE_SERVICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
    private Static String ERR_INVOICE_ALREADY_CTREATED{
        get{
            return String.isNotBlank(ERR_INVOICE_ALREADY_CTREATED) ? ERR_INVOICE_ALREADY_CTREATED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Err_Msg_Invoice_Already_Created');
        }set;
    }
    private Static String INVOICE_AR_STATUS_REJECTED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_REJECTED) ? INVOICE_AR_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Rejected');
        }set;
    }
    private Static String INVOICE_AR_STATUS_CANCELLED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_CANCELLED) ? INVOICE_AR_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Cancelled');
        }set;
    }
    private Static String ERR_SUBMIT_SO_APPROVAL_CREATE_INVOICE{
        get{
            return String.isNotBlank(ERR_SUBMIT_SO_APPROVAL_CREATE_INVOICE) ? ERR_SUBMIT_SO_APPROVAL_CREATE_INVOICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Err_Submit_SO_approva_and_Create_Invoice');
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
    public CreateARfromSO (ApexPages.StandardController controller) {
        this.stdController = controller;
        System.debug('stdController ' + stdController);
        System.assertNotEquals(null, controller, 'controller is null');
        so = ((Sales_Order__c)stdController.getRecord());
        System.assertNotEquals(null, so, 'order record is null');
    }
    
    public PageReference createAR() {
        PageReference retPage = null;
        try {
            
            Sales_Order__c sOrder = [select id, SO_Status__c from Sales_Order__c where Id  =: so.Id];
            if(sOrder.SO_Status__c != SALES_ORDER_STATUS_APPROVED)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,ERR_SUBMIT_SO_APPROVAL_CREATE_INVOICE));
                return retPage ;
            }
            
            List<Invoice__c> objects = [Select id from Invoice__c where Sales_Order__c =: so.Id and AR_Status__c != :INVOICE_AR_STATUS_CANCELLED and AR_Status__c != :INVOICE_AR_STATUS_REJECTED ];
            if (objects.size() >= 1) {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,ERR_INVOICE_ALREADY_CTREATED));
                return retPage ; 
            } 
            String newInvoiceId = createInvoiceOrder(so.Id);
            retPage =new PageReference('/'+newInvoiceId);
            retPage.setRedirect(true);
        } catch (Exception ex){
            ErrorLogs.log('CreateARfromSO',ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return retPage;
    }
    @Auraenabled
    public static String getRecordName(Id recordId){
        String objName = recordId.getSObjectType().getDescribe().getName();
        System.debug(objName);
        String q = 'SELECT Name FROM ' + objName + ' WHERE Id=\'' + recordId + '\'';
        List<SObject> records = Database.query(q);
        if(records.size()>0){
            return (String) (records[0].get('Name'));
        }
        return '';
    }
    @Auraenabled
     public static AuraResponse createARLighting(String soId) {
         system.debug('##SOID :'+soId);
         AuraResponse r = new AuraResponse('CreateARfromSO.createARLighting()');
        try {
            
            Sales_Order__c sOrder = [select id, SO_Status__c from Sales_Order__c where Id  =: soId];
            if(sOrder.SO_Status__c != SALES_ORDER_STATUS_APPROVED)
            {
                system.debug('##error 11 :');
                r.data.put('error',ERR_SUBMIT_SO_APPROVAL_CREATE_INVOICE);
                return r;   
            }
            
            List<Invoice__c> objects = [Select id from Invoice__c where Sales_Order__c =: soId and AR_Status__c != :INVOICE_AR_STATUS_CANCELLED and AR_Status__c != :INVOICE_AR_STATUS_REJECTED ];
            if (objects.size() >= 1) {
                system.debug('##error 22:'); 
                r.data.put('error',ERR_INVOICE_ALREADY_CTREATED);
                return r;  
            } 
            string newInvocieId = createInvoiceOrder(soId);
            r.data.put('newInvocieId',newInvocieId);
            return r;
        } catch (Exception ex){
            ErrorLogs.log('CreateARfromSO',ex.getStackTraceString(), ex.getMessage());
            system.debug('##error 33:');
            r.data.put('error',ex.getMessage());
            return r;
        }
        
    }
    public static String createInvoiceOrder(Id soId)
    {
        //PageReference retPage = null;
        System.debug('soid='+soId);
        ID sOrderID = soId;
        Sales_Order__c sOrder = [select id ,name
                                 ,Distributor_Name__c
                                 ,Distributor_License__c
                                 ,Distributor_Contact__c
                                 ,Supplier_Name__c
                                 ,Supplier_License__c
                                 ,Supplier_Contact__c
                                 ,Receiver_Name__c
                                 ,Receiver_License__c
                                 ,Receiver_Contact__c
                                 ,Site__c
                                 ,Sales_Order_Instructions__c
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
                                 ,Ownership__c
                                 ,Ship_Confirmation_Date__c
                                 ,Total_Weight_Fee__c , 
                                 Total_Mileage_Fee__c  , Ownership__r.Type,
                                 Stage_Manifest_Fee__c , Schedule_Dispatch_Fee__c , 
                                 Pack_Out_Fee__c , Order_Booking_Fee__c
                                 from Sales_Order__c where id =: sOrderID];
        
        //if (quote.fieldnameTBD != null){
        //throw new CustomerQuotationException('Brand Quote has already been converted to a Purchase Order.  You can only have one purchase order for a quote.');
        //}
        List<Sales_Order_Line__c> soLines = [select id
                                             ,name,Sales_Order__c
                                             ,Product_Name__c
                                             ,Product_Title__c
                                             ,Qty_Ordered__c
                                             ,Retail_Wholesale_Price__c
                                             ,Is_Sample__c,IsPromo__c,
                                             Ownership_Code__c
                                             ,Pick_Pack_Fee__c,QA_Review_Fee__c, Total_Weight_lbs__c
                                             from Sales_Order_Line__c
                                             where Sales_Order__c =: sOrderID];
        
        System.debug('soLines='+soLines);
        Invoice__c newInvoice = new Invoice__c();
        newInvoice.Sales_Order__c = sOrderID;
        newInvoice.Opportunity_Name__c = sOrder.Opportunity_Name__c;
        newInvoice.Distributor_Name__c = sOrder.Distributor_Name__c;
        newInvoice.Distributor_License__c = sOrder.Distributor_License__c;
        newInvoice.Distributor_Contact__c = sOrder.Distributor_Contact__c;
        newInvoice.Supplier_Name__c = sOrder.Supplier_Name__c;
        newInvoice.Invoice_Memo__c = sOrder.Sales_Order_Instructions__c;
        newInvoice.Supplier_License__c = sOrder.Supplier_License__c;
        newInvoice.Supplier_Contact__c = sOrder.Supplier_Contact__c;
        newInvoice.Receiver_Name__c = sOrder.Receiver_Name__c;
        newInvoice.Receiver_License__c = sOrder.Receiver_License__c;
        newInvoice.Receiver_Contact__c = sOrder.Receiver_Contact__c;
        newInvoice.Site__c = sOrder.Site__c;
        newInvoice.Shipped_Date__c = sOrder.Planned_Ship_Date__c;
        newInvoice.Sample_Order__c = sOrder.Sample_Order__c;
        newInvoice.AR_Type__c = sOrder.SO_Type__c;
        newInvoice.Customer_PO_or_Quote__c = sOrder.Customer_PO_or_Quote__c;
        newInvoice.Brand_Quote__c = sOrder.Brand_Quote__c;
        newInvoice.Shipping_Terms__c = sOrder.Shipping_Terms__c;
        newInvoice.Shipping_Method__c = sOrder.Shipping_Method__c;
        newInvoice.Payment_Terms__c = sOrder.Payment_Terms__c;
        newInvoice.Ownership__c = sOrder.Ownership__c;
        newInvoice.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_SERVICE).getRecordTypeId();
        newInvoice.Invoice_Due_Date__c     = InvoiceSupport.calculateInvoiceDueDate(sOrder.Ship_Confirmation_Date__c,sOrder.Planned_Ship_Date__c,
                                                                                    sOrder.Payment_Terms__c);
        newInvoice.Order_Booking_Fee__c = sOrder.Order_Booking_Fee__c;
        newInvoice.Pack_Out_Fee__c = sOrder.Pack_Out_Fee__c;
        newInvoice.Schedule_Dispatch_Fee__c = sOrder.Schedule_Dispatch_Fee__c;
        newInvoice.Stage_Manifest_Fee__c = sOrder.Stage_Manifest_Fee__c;
        newInvoice.Total_Mileage_Fee__c = sOrder.Total_Mileage_Fee__c;
        newInvoice.Total_Weight_Fee__c = sOrder.Total_Weight_Fee__c;
        
        Company_Custom_Settings__c companySettingRec = Company_Custom_Settings__c.getOrgDefaults();
        if(sOrder.Site__c != null && sOrder.Site__r.Name.equals(SITE_NAME_7027)){
            newInvoice.Distributor_Name__c = companySettingRec.Second_Warehouse_Id__c;
            newInvoice.Distributor_License__c = companySettingRec.Second_Warehouse_License__c;
        }
        
        if(sOrder.Site__c != null && sOrder.Site__r.Name.equals(SITE_NAME_2089)){
            newInvoice.Distributor_Name__c = companySettingRec.Default_Distributor__c;
            newInvoice.Distributor_License__c = companySettingRec.Default_License__c;
        }
        
        newInvoice.Supplier_Name__c = companySettingRec.Default_Distributor__c;
        newInvoice.Supplier_License__c = companySettingRec.Default_License__c;
        
        for(Contact con :[SELECT AccountId,Id FROM Contact WHERE AccountId =: companySettingRec.Default_Distributor__c AND Active__c = true ORDER BY CreatedDate ASC]){
            newInvoice.Supplier_Contact__c = con.id;
            break;
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
        try{        System.debug('newInvoice='+newInvoice);
            
            insert newInvoice;
            List<Invoice_Line__c> invLineItems = new List<Invoice_Line__c>();
            For (Sales_Order_Line__c soline : soLines)
            {
                Invoice_Line__c invLineItem = new Invoice_Line__c();
                invLineItem.Invoice__c = newInvoice.Id;
                invLineItem.Sales_Order_Line__c = soline.Id;
                invLineItem.Product_Name__c = soline.Product_Name__c;
                invLineItem.Product_Title__c = soline.Product_Title__c;
                invLineItem.Invoice_Qty__c = soline.Qty_Ordered__c;
                invLineItem.Is_Sample__c = soline.Is_Sample__c;
                invLineItem.IsPromo__c = soline.IsPromo__c;
                invLineItem.Retail_Wholesale_Price__c = soline.Retail_Wholesale_Price__c;
                invLineItem.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_SERVICE).getRecordTypeId();
                invLineItem.OwnershipCode__c = soline.Ownership_Code__c;
                invLineItem.Pick_Pack_Fee__c = soline.Pick_Pack_Fee__c;
                invLineItem.QA_Review_Fee__c = soline.QA_Review_Fee__c;
                invLineItem.Total_Weight_lbs__c = soline.Total_Weight_lbs__c;
                invLineItems.add(invLineItem);
            }
            System.debug('invLineItems='+invLineItems);
            insert invLineItems;
           }
        catch(Exception ex)
        {
            ErrorLogs.log('createInvoiceOrder',ex.getStackTraceString(), ex.getMessage());
        }
        //retPage =new PageReference('/'+newInvoice.Id);
        return newInvoice.Id;
    }
    
    public PageReference goBack() {
        return stdController.view().setRedirect(true);
    }
    
}