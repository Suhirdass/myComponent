@isTest
public class InvoiceTriggerTest { 
    private static testmethod void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
            insert GDMIs; 
        
        Document documentObj;
        
        documentObj = new Document();
        documentObj.Body = Blob.valueOf('Some Document Text For Test Class');
        documentObj.ContentType = 'application/pdf';
        documentObj.DeveloperName = 'TestX8300'; 
        documentObj.IsPublic = true;
        documentObj.Name = 'Test 8300';
        documentObj.FolderId = [select id from folder where name = 'Shared Documents'].id;
        insert documentObj;
        
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        //Account acc = [SELECT Id, Name,dBA__c,Community_Price_Book__c, Type FROM Account WHERE Name = 'Test Account1' LIMIT 1];
        Account acc = new Account();
        acc.Payment_Terms__c = 'COD';
        acc.Hold__c=true;
        acc.Type = 'Financial Interest - NL';
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        acc.Community_Price_Book__c = customPB.Id;
        acc.Hide_from_Marketplace__c = false;
        acc.Membership_Level__c = 'Boutique';
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
        insert acc;
        
        Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
        objContact.AccountId = acc.Id;
        objContact.Active__c = true;
        insert objContact;
        
        Site__c objSite = new Site__c();
        objSite.Name = '7027-CP';
        objSite.Warehouse_Name__c='TestWarehouse1';
        insert objSite;
        
        State_Licenses__c stLicence = new State_Licenses__c();
        stLicence.License_Name__c = acc.id;
        stLicence.License_Number__c = 'AbcTest12345';
        stLicence.License_Status__c ='Active';
        stLicence.License_Type__c ='Type 1';
        stLicence.Default_Warehouse__c = objSite.Id;
        stLicence.License_Class__c='A-License';
        stLicence.License_State__c = 'California';
        stLicence.License_City__c = 'San Francisco';
        stLicence.License_Address__c = '2089 Ingalls St. Unit 3';
        stLicence.License_Zip__c = '94124';
        stLicence.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        stLicence.Total_Miles__c = 10;
        stLicence.RecordTypeId =Schema.SObjectType.State_Licenses__c.getRecordTypeInfosByDeveloperName().get('NonCannabis').getRecordTypeId();
        insert stLicence;
        
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = stLicence.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName ='Qualification';
        opp.Site_Name__c = objSite.Id;
        opp.Ownership__c = acc.id;
        opp.Payment_Terms__c = 'COD';
        opp.Order__c = ord.Id;
        Opp.Order__c = ord.Id;
        insert opp;
        
        Brand_Quote__c bq = new Brand_Quote__c ();
        bq.Opportunity_Name__c = opp.id; 
        bq.Distributor_License__c = stLicence.id;
        bq.Receiver_License__c = stLicence.id;
        bq.Distributor_Name__c = acc.id;
        bq.Supplier_Name__c = acc.id;
        bq.Receiver_Name__c = acc.id;
        bq.Supplier_License__c = stLicence.id;
        bq.BQ_Status__c = 'Draft';
        bq.Shipping_Method__c = 'Distributor Pick-up';
        bq.Sales_Origin__c = 'Brand';
        bq.Shipping_Terms__c = 'CFR';        
        bq.Site__c = objSite.id;
        bq.Ownership__c = opp.Ownership__c;
        bq.Payment_Terms__c = opp.Payment_Terms__c;
        bq.Apply_Excise_Tax__c = true;
        bq.Order_Type__c = 'Retailer';
        bq.Sales_person__c = objContact.Name;
        bq.Opportunity_Name__c = Opp.Id;
        
        insert bq; 
       
        
        Invoice__c lstInvoice = new Invoice__c();
        lstInvoice.Ship_Confirmation_Date__c = Date.today();
        lstInvoice.Posted_Date__c = null;
        lstInvoice.AR_Status__c = 'Shipped';
        lstInvoice.Collections_Status__c = 'Pending';
        lstInvoice.Receiver_Name__c = acc.Id;
        lstInvoice.Ownership__c = acc.Id;
        lstInvoice.Brand_Quote__c =bq.id;
        lstInvoice.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByDeveloperName().get('Product').getRecordTypeId();
        insert lstInvoice;
        
        Invoice__c lstInvoice1 = new Invoice__c();
        lstInvoice1.Ship_Confirmation_Date__c = Date.today();
        lstInvoice1.Posted_Date__c = null;
        lstInvoice1.AR_Status__c = 'Shipped';
        lstInvoice1.Collections_Status__c = 'Pending';
        lstInvoice1.Receiver_Name__c = acc.Id;
        lstInvoice1.Ownership__c = acc.Id;
        lstInvoice1.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByDeveloperName().get('Tax').getRecordTypeId();
        insert lstInvoice1;
        
        Invoice__c lstInvoice2 = new Invoice__c();
        lstInvoice2.Ship_Confirmation_Date__c = Date.today();
        lstInvoice2.Posted_Date__c = null;
        lstInvoice2.AR_Status__c = 'Shipped';
        lstInvoice2.Collections_Status__c = 'Pending';
        lstInvoice2.Receiver_Name__c = acc.Id;
        lstInvoice2.Ownership__c = acc.Id;
        lstInvoice2.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByDeveloperName().get('Service').getRecordTypeId();
        insert lstInvoice2;
        
        Line_Card__c l= new Line_Card__c();
        l.Brand_Name__c=acc.id;
        l.Retailer_Name__c=acc.id;
        l.Mutual_Payment_Terms__c='COD';
        insert l;
        
        Receive_Payment__c receivePaymentSO = new Receive_Payment__c();
        receivePaymentSO.Invoice__c = lstInvoice.Id;
        receivePaymentSO.Payment_Memo__c = 'Test Invoice memo';
        receivePaymentSO.Payment_Received_Date__c = Date.today();
        receivePaymentSO.Payment_Form__c = 'Cash';
        receivePaymentSO.Payment_Amount__c = 100;
        receivePaymentSO.Posted_Date__c = Date.today();
        insert receivePaymentSO;
        
        lstInvoice.Collections_Status__c = 'Pending';
        update lstInvoice;
        
        lstInvoice.Collections_Status__c = 'Paid in Full';
        update lstInvoice;  
        
        
        InvoiceTriggerHandler.updatePostedDate(new Set<Id>{lstInvoice.id});
        lstInvoice.AR_Status__c = 'Cancelled';
        update lstInvoice;
        InvoiceTriggerHandler.updateOpenBalance(new List<Invoice__c>{lstInvoice2});
    }
}