/**
* Copyright (c) 2021 WOVN
* All rights reserved.
* FullfullmentServiceInvoiceControllerTest
*/
@isTest
public class FullfullmentServiceInvoiceControllerTest {
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
        //acc.Service_Type__c ='Margin';
        //acc.Distribution_Fee__c = 1;
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
        
        Shipping_Rates_Table__c  shipRateTable = new Shipping_Rates_Table__c();
        shipRateTable.Active__c = true;
        shipRateTable.Site__c = objSite.Id;
        shipRateTable.Rate_Effective_From__c = Date.Today().addDays(-3);
        shipRateTable.Rate_Effective_To__c = Date.Today().addDays(3);
        shipRateTable.Mileage_Bracket__c = 100;
        shipRateTable.Weight_Bracket__c = 100;
        shipRateTable.Weight_Bracket_Cost__c = 0.60;
        shipRateTable.Mileage_Bracket_Cost__c = 0.40;
        shipRateTable.Weight_Bracket_Mark_Up__c = 100;
        shipRateTable.Mileage_Bracket_Mark_Up__c = 60;
        shipRateTable.Membership_Level__c = 'Boutique';
        
        insert shipRateTable;
        
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
        
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
            .get('Product').getRecordTypeId();
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'Mileage Fee';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.Apply_Cultivation_Tax__c='No';
        objProduct1.Apply_Excise_Tax__c='No';
        //objProduct1.Is_Sample__c = true;
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10;
        objProduct1.Unit_Length__c = 10;
        objProduct1.Unit_Width__c = 5;
        objProduct1.RecordTypeId = productRecordTypeId;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        objProduct1.Unit_Gross_Weight__c = 10;
        objProduct1.Retail_Unit_Form_Factor__c  ='Jar';
        objProduct1.Unit_Radius__c =3;
        
        insert objProduct1;
        
        Product2  objProduct2 = new Product2 ();
        objProduct2.Name = 'Stage & Manifest';
        objProduct2.Quantity_Type__c = 'Quantity';
        objProduct2.Family = 'Accessories';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = acc.id;
        objProduct2.Apply_Cultivation_Tax__c='Yes';
        objProduct2.Apply_Excise_Tax__c='Yes';
        objProduct2.IsActive = true;
        objProduct2.Unit_Height__c  = 20.0;
        objProduct2.Unit_Length__c = 10.0;
        objProduct2.Unit_Width__c = 5.0;
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.RecordTypeId = productRecordTypeId;
        objProduct2.Track_Trace_Category__c='Capsule';
        objProduct2.Net_Weight_UOM__c='EA';
        objProduct2.Unit_Of_Measure__c='Grams';
        objProduct2.MOQ__c = 10;
        insert objProduct2;
        
        
        
        Sales_Order__c so = new Sales_Order__c();
        so.Site__c = bq.Site__c;
        so.SO_Status__c = 'Draft';
        so.SO_Type__c = 'Sell Quote';
        so.Brand_Quote__c = bq.id;
        so.Supplier_Contact__c = objContact.Id;
        so.Supplier_Name__c = bq.Supplier_Name__c;
        so.Supplier_License__c = bq.Supplier_License__c;
        so.Distributor_Contact__c = objContact.Id;
        so.Distributor_Name__c = bq.Distributor_Name__c;
        so.Distributor_License__c = bq.Distributor_License__c;
        so.Receiver_Name__c = bq.Receiver_Name__c;
        so.Receiver_Contact__c = objContact.Id;
        so.Receiver_License__c = bq.Receiver_License__c;
        so.Payment_Terms__c = bq.Payment_Terms__c;
        so.Shipping_Terms__c = bq.Shipping_Terms__c;
        //so.Shipping_Method__c = bq.Shipping_Method__c;
        so.Ownership__c = acc.Id;
        so.Customer_PO_or_Quote__c = 'Test Quote';
        so.Account_Hold_Exception__c = true;
        so.Opportunity_Name__c = opp.Id;
        so.Total_Weight_Fee__c = 20;
        so.Total_Mileage_Fee__c = 10;
        so.Stage_Manifest_Fee__c = 10;
        so.Order_Booking_Fee__c  =10;
        so.Change_Order_Fee__c = true;
        insert so;
        Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Retail_Wholesale_Price__c=1,Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,Default_Distributor__c  = acc.Id,LateFee__c = 0.020,Route_Origin_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US',Route_Destination_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US');
        insert ccs;
        
        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c= objProduct2.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;
        objbqline1.Invoiced_Quantity__c = 20;
        objbqline1.Retail_Wholesale_Price__c  = 100;
        objbqline1.Billed_Quantity__c =10;
        insert objbqline1;
        
        Sales_Order_Line__c sol = new Sales_Order_Line__c();
        sol.Sales_Order__c = so.id;
        sol.Product_Name__c = objProduct2.id;
        sol.Qty_Ordered__c = 2;
        //sol.Is_Sample__c = true;
        insert sol;
        Sales_Order_Line__c sol2 = new Sales_Order_Line__c();
        sol2.Sales_Order__c = so.id;
        sol2.Product_Name__c = objProduct1.id;
        sol2.Qty_Ordered__c = 2;
        //sol2.Is_Sample__c = true;
        insert sol2;
        
        Purchase_Order__c po = new Purchase_Order__c();
        insert po;
        
        Purchase_Order_Line__c pol = new Purchase_Order_Line__c();
        pol.Billable_Cultivation_Tax__c = 'Yes';
        pol.Purchase_Order__c = po.id;
        insert pol;
        
        Receiving_Line__c rl = new Receiving_Line__c();
        rl.Purchase_Order_Line__c = pol.id;
        insert rl;
        
        Inventory_Position__c IP = new Inventory_Position__c();
        IP.Sales_Order_Line__c = sol.id;
        IP.Receiving_Line__c = rl.Id;
        IP.Product_Name__c =objProduct1.id;
        insert IP;
        
        State_Licenses__c sl = new State_Licenses__c();
        sl.License_Name__c = acc.Id;
        sl.License_Class__c = 'A-License';
        sl.License_Type__c = 'Type 11';
        sl.License_Number__c = 'A11-18-0000054-TEMP';
        sl.License_Status__c = 'Active';
        sl.License_Expiration_Date__c = System.today().addDays(60);
        sl.License_Address__c = '44650 101 Hwy N, Suite F';
        sl.License_City__c = 'Lafayette';
        sl.License_State__c = 'California';
        sl.License_Zip__c = '95454';
        sl.License_Country__c = 'US';
        sl.Default_Warehouse__c = objSite.Id;
        insert sl;
        
        
        test.startTest();
        Sales_Order__c so1 =[SELECT Id, Name,Stage_Manifest_Fee__c from Sales_Order__c limit 1];
        system.debug('so id'+so.id);
        //Sales_Order_Line__c soLine = [SELECT Id,Name,Qty_Ordered__c,Brand_Quote_Line__c,Qty_Allocated__c,Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c FROM Sales_Order_Line__c LIMIT 1];
        //try{
        //FullfullmentServiceInvoiceController.getRecordName(so.Id);
        FullfullmentServiceInvoiceController.createServiceInvoice(so.Id,false);  
        FullfullmentServiceInvoiceController.createCultivationTaxInvoice(so.Id);
        FullfullmentServiceInvoiceController.createCTInvoice(so.Id);
        System.assertEquals(so.Stage_Manifest_Fee__c, 10);
        
        bq.Order_Type__c = 'Brand';
        update bq;
        
        so.Site__c = objSite.id;
        update so;
        
        //FullfullmentServiceInvoiceController.createServiceInvoice(so.Id);  
        
        so.SO_Status__c = 'Approved';
        update so;            
        FullfullmentServiceInvoiceController.createCultivationTaxInvoice(so.Id);
        
        so.SO_Status__c = 'Cancelled';
        update so;            
        FullfullmentServiceInvoiceController.createCultivationTaxInvoice(so.Id);
        
        so.SO_Status__c = 'Rejected';
        update so;            
        FullfullmentServiceInvoiceController.createCultivationTaxInvoice(so.Id);
        String ERR_MSG_NO_INVOICE_LINE_AVAILABLE = FullfullmentServiceInvoiceController.ERR_MSG_NO_INVOICE_LINE_AVAILABLE;
        String  Label_Not_For_Resale_Product = FullfullmentServiceInvoiceController.Label_Not_For_Resale_Product;
        String PRODUCT_NAME_LISTING_FEE = FullfullmentServiceInvoiceController.PRODUCT_NAME_LISTING_FEE;
        String Sample_Product_Price = FullfullmentServiceInvoiceController.Sample_Product_Price;
        //}catch(Exception ex){}      
        FullfullmentServiceInvoiceController.getRecordName(so.Id);
        
        Test.stopTest();        
    }
    private static testmethod void runTest2(){
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
        acc.Name = 'test';
        acc.dBA__c = 'test';
        acc.Type = 'Cultivator';
        acc.Community_Price_Book__c = customPB.Id;
        acc.Hide_from_Marketplace__c = false;
        acc.Membership_Level__c = 'Boutique';
        acc.Service_Type__c = 'Margin';
        acc.Distribution_Fee__c = 10;
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
        
        Shipping_Rates_Table__c  shipRateTable = new Shipping_Rates_Table__c();
        shipRateTable.Active__c = true;
        shipRateTable.Site__c = objSite.Id;
        shipRateTable.Rate_Effective_From__c = Date.Today().addDays(-3);
        shipRateTable.Rate_Effective_To__c = Date.Today().addDays(3);
        shipRateTable.Mileage_Bracket__c = 100;
        shipRateTable.Weight_Bracket__c = 100;
        shipRateTable.Weight_Bracket_Cost__c = 0.60;
        shipRateTable.Mileage_Bracket_Cost__c = 0.40;
        shipRateTable.Weight_Bracket_Mark_Up__c = 100;
        shipRateTable.Mileage_Bracket_Mark_Up__c = 60;
        shipRateTable.Membership_Level__c = 'Boutique';
        
        insert shipRateTable;
        
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = stLicence.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Brand').getRecordTypeId();
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
        bq.Order_Type__c = 'Brand';
        bq.Sales_person__c = objContact.Name;
        bq.Opportunity_Name__c = Opp.Id;
        
        insert bq;        
        
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
            .get('Product').getRecordTypeId();
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'Mileage Fee';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.Apply_Cultivation_Tax__c='No';
        objProduct1.Apply_Excise_Tax__c='No';
        objProduct1.Is_Sample__c = true;
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10;
        objProduct1.Unit_Length__c = 10;
        objProduct1.Unit_Width__c = 5;
        objProduct1.RecordTypeId = productRecordTypeId;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        objProduct1.Unit_Gross_Weight__c = 10;
        objProduct1.Retail_Unit_Form_Factor__c  ='Jar';
        objProduct1.Unit_Radius__c =3;
        
        insert objProduct1;
        
       
        
        Sales_Order__c so = new Sales_Order__c();
        so.Site__c = bq.Site__c;
        so.SO_Status__c = 'Draft';
        so.SO_Type__c = 'Sell Quote';
        so.Brand_Quote__c = bq.id;
        so.Supplier_Contact__c = objContact.Id;
        so.Supplier_Name__c = bq.Supplier_Name__c;
        so.Supplier_License__c = bq.Supplier_License__c;
        so.Distributor_Contact__c = objContact.Id;
        so.Distributor_Name__c = bq.Distributor_Name__c;
        so.Distributor_License__c = bq.Distributor_License__c;
        so.Receiver_Name__c = bq.Receiver_Name__c;
        so.Receiver_Contact__c = objContact.Id;
        so.Receiver_License__c = bq.Receiver_License__c;
        so.Payment_Terms__c = bq.Payment_Terms__c;
        so.Shipping_Terms__c = bq.Shipping_Terms__c;
        so.Shipping_Method__c = bq.Shipping_Method__c;
        so.Ownership__c = acc.Id;
        so.Customer_PO_or_Quote__c = 'Test Quote';
        so.Account_Hold_Exception__c = true;
        so.Opportunity_Name__c = opp.Id;
        so.Total_Weight_Fee__c = 20;
        so.Total_Mileage_Fee__c = 10;
        so.Stage_Manifest_Fee__c = 10;
        so.Change_Order_Fee__c = true;
        insert so;
        Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Retail_Wholesale_Price__c=1,Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,Default_Distributor__c  = acc.Id,LateFee__c = 0.020,Route_Origin_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US',Route_Destination_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US');
        insert ccs;
        
        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c= objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;
        objbqline1.Invoiced_Quantity__c = 20;
        objbqline1.Retail_Wholesale_Price__c  = 100;
        objbqline1.Billed_Quantity__c =10;
        insert objbqline1;
        
       
        Sales_Order_Line__c sol2 = new Sales_Order_Line__c();
        sol2.Sales_Order__c = so.id;
        sol2.Product_Name__c = objProduct1.id;
        sol2.Qty_Ordered__c = 2;
        sol2.Is_Sample__c = true;
        sol2.Ownership_Code__c = acc.id;
        insert sol2;
        
        Purchase_Order__c po = new Purchase_Order__c();
        insert po;
        
        Purchase_Order_Line__c pol = new Purchase_Order_Line__c();
        pol.Billable_Cultivation_Tax__c = 'Yes';
        pol.Purchase_Order__c = po.id;
        insert pol;
        
        Receiving_Line__c rl = new Receiving_Line__c();
        rl.Purchase_Order_Line__c = pol.id;
        insert rl;
        
        Inventory_Position__c IP = new Inventory_Position__c();
        IP.Sales_Order_Line__c = sol2.id;
        IP.Receiving_Line__c = rl.Id;
        IP.Product_Name__c =objProduct1.id;
        insert IP;
        
        State_Licenses__c sl = new State_Licenses__c();
        sl.License_Name__c = acc.Id;
        sl.License_Class__c = 'A-License';
        sl.License_Type__c = 'Type 11';
        sl.License_Number__c = 'A11-18-0000054-TEMP';
        sl.License_Status__c = 'Active';
        sl.License_Expiration_Date__c = System.today().addDays(60);
        sl.License_Address__c = '44650 101 Hwy N, Suite F';
        sl.License_City__c = 'Lafayette';
        sl.License_State__c = 'California';
        sl.License_Zip__c = '95454';
        sl.License_Country__c = 'US';
        sl.Default_Warehouse__c = objSite.Id;
        insert sl;
        
        
        test.startTest();
        Sales_Order__c so1 =[SELECT Id, Name,Stage_Manifest_Fee__c from Sales_Order__c limit 1];
        system.debug('so id'+so.id);
        //Sales_Order_Line__c soLine = [SELECT Id,Name,Qty_Ordered__c,Brand_Quote_Line__c,Qty_Allocated__c,Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c FROM Sales_Order_Line__c LIMIT 1];
        //try{
        //FullfullmentServiceInvoiceController.getRecordName(so.Id);
        FullfullmentServiceInvoiceController.createServiceInvoice(so.Id,false);  
        FullfullmentServiceInvoiceController.createCultivationTaxInvoice(so.Id);
        FullfullmentServiceInvoiceController.createCTInvoice(so.Id);
        System.assertEquals(so.Stage_Manifest_Fee__c, 10);
        
        bq.Order_Type__c = 'Brand';
        update bq;
        
        so.Site__c = objSite.id;
        update so;
        
        //FullfullmentServiceInvoiceController.createServiceInvoice(so.Id);  
        
        so.SO_Status__c = 'Approved';
        update so;            
        FullfullmentServiceInvoiceController.createCultivationTaxInvoice(so.Id);
        
        so.SO_Status__c = 'Cancelled';
        update so;            
        FullfullmentServiceInvoiceController.createCultivationTaxInvoice(so.Id);
        
        so.SO_Status__c = 'Rejected';
        update so;            
        FullfullmentServiceInvoiceController.createCultivationTaxInvoice(so.Id);
        String ERR_MSG_NO_INVOICE_LINE_AVAILABLE = FullfullmentServiceInvoiceController.ERR_MSG_NO_INVOICE_LINE_AVAILABLE;
        String  Label_Not_For_Resale_Product = FullfullmentServiceInvoiceController.Label_Not_For_Resale_Product;
        String PRODUCT_NAME_LISTING_FEE = FullfullmentServiceInvoiceController.PRODUCT_NAME_LISTING_FEE;
        String Sample_Product_Price = FullfullmentServiceInvoiceController.Sample_Product_Price;
        //}catch(Exception ex){}      
        FullfullmentServiceInvoiceController.getRecordName(so.Id);
        
        Test.stopTest();        
    }
    private static testmethod void runTest3(){
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
        acc.Name = 'test';
        acc.dBA__c = 'test';
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
        
        Shipping_Rates_Table__c  shipRateTable = new Shipping_Rates_Table__c();
        shipRateTable.Active__c = true;
        shipRateTable.Site__c = objSite.Id;
        shipRateTable.Rate_Effective_From__c = Date.Today().addDays(-3);
        shipRateTable.Rate_Effective_To__c = Date.Today().addDays(3);
        shipRateTable.Mileage_Bracket__c = 100;
        shipRateTable.Weight_Bracket__c = 100;
        shipRateTable.Weight_Bracket_Cost__c = 0.60;
        shipRateTable.Mileage_Bracket_Cost__c = 0.40;
        shipRateTable.Weight_Bracket_Mark_Up__c = 100;
        shipRateTable.Mileage_Bracket_Mark_Up__c = 60;
        shipRateTable.Membership_Level__c = 'Boutique';
        
        insert shipRateTable;
        
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = stLicence.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Brand').getRecordTypeId();
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
        //opp.Order__c = ord.Id;
        
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
        bq.Order_Type__c = 'Brand';
        bq.Sales_person__c = objContact.Name;
        bq.Opportunity_Name__c = Opp.Id;
        
        insert bq;        
        
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
            .get('Product').getRecordTypeId();
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'Mileage Fee';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.Apply_Cultivation_Tax__c='No';
        objProduct1.Apply_Excise_Tax__c='No';
        objProduct1.Is_Sample__c = true;
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10;
        objProduct1.Unit_Length__c = 10;
        objProduct1.Unit_Width__c = 5;
        objProduct1.RecordTypeId = productRecordTypeId;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        objProduct1.Unit_Gross_Weight__c = 10;
        objProduct1.Retail_Unit_Form_Factor__c  ='Jar';
        objProduct1.Unit_Radius__c =3;
        
        insert objProduct1;
        
       
        
        Sales_Order__c so = new Sales_Order__c();
        so.Site__c = bq.Site__c;
        so.SO_Status__c = 'Draft';
        so.SO_Type__c = 'Sell Quote';
        so.Brand_Quote__c = bq.id;
        so.Supplier_Contact__c = objContact.Id;
        so.Supplier_Name__c = bq.Supplier_Name__c;
        so.Supplier_License__c = bq.Supplier_License__c;
        so.Distributor_Contact__c = objContact.Id;
        so.Distributor_Name__c = bq.Distributor_Name__c;
        so.Distributor_License__c = bq.Distributor_License__c;
        so.Receiver_Name__c = bq.Receiver_Name__c;
        so.Receiver_Contact__c = objContact.Id;
        so.Receiver_License__c = bq.Receiver_License__c;
        so.Payment_Terms__c = bq.Payment_Terms__c;
        so.Shipping_Terms__c = bq.Shipping_Terms__c;
        so.Shipping_Method__c = bq.Shipping_Method__c;
        so.Ownership__c = acc.Id;
        so.Customer_PO_or_Quote__c = 'Test Quote';
        so.Account_Hold_Exception__c = true;
        so.Opportunity_Name__c = opp.Id;
        so.Total_Weight_Fee__c = 20;
        so.Total_Mileage_Fee__c = 10;
        so.Stage_Manifest_Fee__c = 10;
        so.Change_Order_Fee__c = true;
        insert so;
        Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Retail_Wholesale_Price__c=1,Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,Default_Distributor__c  = acc.Id,LateFee__c = 0.020,Route_Origin_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US',Route_Destination_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US');
        insert ccs;
        
        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c= objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;
        objbqline1.Invoiced_Quantity__c = 20;
        objbqline1.Retail_Wholesale_Price__c  = 100;
        objbqline1.Billed_Quantity__c =10;
        insert objbqline1;
        
       
        Sales_Order_Line__c sol2 = new Sales_Order_Line__c();
        sol2.Sales_Order__c = so.id;
        sol2.Product_Name__c = objProduct1.id;
        sol2.Qty_Ordered__c = 2;
        sol2.Is_Sample__c = true;
        sol2.Ownership_Code__c = acc.id;
        insert sol2;
        
        Purchase_Order__c po = new Purchase_Order__c();
        insert po;
        
        Purchase_Order_Line__c pol = new Purchase_Order_Line__c();
        pol.Billable_Cultivation_Tax__c = 'Yes';
        pol.Purchase_Order__c = po.id;
        insert pol;
        
        Receiving_Line__c rl = new Receiving_Line__c();
        rl.Purchase_Order_Line__c = pol.id;
        insert rl;
        
        Inventory_Position__c IP = new Inventory_Position__c();
        IP.Sales_Order_Line__c = sol2.id;
        IP.Receiving_Line__c = rl.Id;
        IP.Product_Name__c =objProduct1.id;
        insert IP;
        
        State_Licenses__c sl = new State_Licenses__c();
        sl.License_Name__c = acc.Id;
        sl.License_Class__c = 'A-License';
        sl.License_Type__c = 'Type 11';
        sl.License_Number__c = 'A11-18-0000054-TEMP';
        sl.License_Status__c = 'Active';
        sl.License_Expiration_Date__c = System.today().addDays(60);
        sl.License_Address__c = '44650 101 Hwy N, Suite F';
        sl.License_City__c = 'Lafayette';
        sl.License_State__c = 'California';
        sl.License_Zip__c = '95454';
        sl.License_Country__c = 'US';
        sl.Default_Warehouse__c = objSite.Id;
        insert sl;
        
        
        test.startTest();
        Sales_Order__c so1 =[SELECT Id, Name,Stage_Manifest_Fee__c from Sales_Order__c limit 1];
        system.debug('so id'+so.id);
        //Sales_Order_Line__c soLine = [SELECT Id,Name,Qty_Ordered__c,Brand_Quote_Line__c,Qty_Allocated__c,Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c FROM Sales_Order_Line__c LIMIT 1];
        //try{
        //FullfullmentServiceInvoiceController.getRecordName(so.Id);
        FullfullmentServiceInvoiceController.createServiceInvoice(so.Id,false);  
        FullfullmentServiceInvoiceController.createCultivationTaxInvoice(so.Id);
        FullfullmentServiceInvoiceController.createCTInvoice(so.Id);
        System.assertEquals(so.Stage_Manifest_Fee__c, 10);
        
        bq.Order_Type__c = 'Brand';
        update bq;
        
        so.Site__c = objSite.id;
        update so;
        
        //FullfullmentServiceInvoiceController.createServiceInvoice(so.Id);  
        
        so.SO_Status__c = 'Approved';
        update so;            
        FullfullmentServiceInvoiceController.createCultivationTaxInvoice(so.Id);
        
        so.SO_Status__c = 'Cancelled';
        update so;            
        FullfullmentServiceInvoiceController.createCultivationTaxInvoice(so.Id);
        
        so.SO_Status__c = 'Rejected';
        update so;            
        FullfullmentServiceInvoiceController.createCultivationTaxInvoice(so.Id);
        String ERR_MSG_NO_INVOICE_LINE_AVAILABLE = FullfullmentServiceInvoiceController.ERR_MSG_NO_INVOICE_LINE_AVAILABLE;
        String  Label_Not_For_Resale_Product = FullfullmentServiceInvoiceController.Label_Not_For_Resale_Product;
        String PRODUCT_NAME_LISTING_FEE = FullfullmentServiceInvoiceController.PRODUCT_NAME_LISTING_FEE;
        String Sample_Product_Price = FullfullmentServiceInvoiceController.Sample_Product_Price;
        //}catch(Exception ex){}      
        FullfullmentServiceInvoiceController.getRecordName(so.Id);
        
        Test.stopTest();        
    }
}