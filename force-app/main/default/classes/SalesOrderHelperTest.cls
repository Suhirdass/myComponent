/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * SalesOrderHelperTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class SalesOrderHelperTest{
    
    static Sales_Order__c salesOrderObj;
    static List<PickList__c> pickLists;
    static List<PickList_Line__c> picklistLines;
    static List<Sales_Order_Line__c> soLines;
    static List<Inventory_Position__c> invPositions;
    
    // Test Create Picklist and Lines if Status is Approved
    static testMethod void testCreatePicklistAndLines(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        // Get data created from setup
        retrieveData();
        
        // Initially no pickLists and lines present
        System.assertEquals(0, pickLists.size(), 'Picklist size mis-match');
        System.assertEquals(0, picklistLines.size(), 'Picklist line size mis-match');
        
        // Allocate SO line qty
        Integer counter = 0;
        for(Inventory_Position__c invPositionObj : invPositions){
            invPositionObj.Qty_On_Hand__c = 0.0;
            invPositionObj.Qty_Allocated__c = 20.0;
            invPositionObj.Sales_Order_Line__c = soLines[counter].Id;
            counter++;
        }
        update invPositions;
        
        // Update SO status as Submitted. It should not create pickLists and lines
        salesOrderObj.SO_STATUS__c = 'Submitted';
        update salesOrderObj;
        
        // Get updated data after updating SO
        retrieveData();
        
        // Verify pickLists and lines
        System.assertEquals(0, pickLists.size(), 'Picklist size mis-match');
        System.assertEquals(0, picklistLines.size(), 'Picklist line size mis-match');
        
        // Update SO status as Approved. It should not create pickLists and lines
        salesOrderObj.SO_STATUS__c = SalesOrderSupport.SO_STATUS_APPROVED;
        update salesOrderObj;
        
        // Get updated data after updating SO
        retrieveData();
        
        // Verify pickLists and lines
        System.assertEquals(1, pickLists.size(), 'Picklist size mis-match');
        System.assertEquals(1, picklistLines.size(), 'Picklist line size mis-match');
        verifyPicklistAndLines();
        Id pickListId = pickLists[0].Id;
        
        // Again update record without changing any value. It should not create new pickList and lines
        salesOrderObj.SO_STATUS__c = SalesOrderSupport.SO_STATUS_APPROVED;
        update salesOrderObj;
        
        // Get updated data after updating SO
        retrieveData();
        
        // Verify pickLists and lines
        System.assertEquals(1, pickLists.size(), 'Picklist size mis-match');
        System.assertEquals(1, picklistLines.size(), 'Picklist line size mis-match');
        System.assertEquals(pickListId, pickLists[0].Id, 'Picklist Id mis-match');
        verifyPicklistAndLines();
        
        // update record with status as Submitted. It should not create new pickList and lines
        salesOrderObj.SO_STATUS__c = 'Submitted';
        update salesOrderObj;
        
        // Get updated data after updating SO
        retrieveData();
        
        // Verify pickLists and lines
        System.assertEquals(1, pickLists.size(), 'Picklist size mis-match');
        System.assertEquals(1, picklistLines.size(), 'Picklist line size mis-match');
        System.assertEquals(pickListId, pickLists[0].Id, 'Picklist Id mis-match');
        verifyPicklistAndLines();
        
        // Again update record with status as Approved. 
        // It should delete old picklist and create new pickList and lines
        salesOrderObj.SO_STATUS__c = SalesOrderSupport.SO_STATUS_APPROVED;
        update salesOrderObj;
        
        // Get updated data after updating SO
        retrieveData();
        
        // Verify pickLists and lines
        System.assertEquals(1, pickLists.size(), 'Picklist size mis-match');
        System.assertEquals(1, picklistLines.size(), 'Picklist line size mis-match');
        System.assertNotEquals(pickListId, pickLists[0].Id, 'Picklist Id mis-match');
        verifyPicklistAndLines();
        Test.stopTest();
        
    }
    
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        TestUtilData.skipTrigger = true;
        Metrc_Utility.IS_PROD_TRIGGER_ENABLED = false;
        SOlineTriggerHandler.isRecursion = true;
        TestUtilData.createTestData();
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        invPositions = [Select Qty_On_Hand__c,
                               Qty_Allocated__c,
                               Sales_Order_Line__c
                               From Inventory_Position__c limit 1];
                               
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Site__c from Sales_Order__c limit 1];
        
        soLines = new List<Sales_Order_Line__c>();
        soLines = [Select Product_Name__c From Sales_Order_Line__c limit 1];
        
        
        pickLists = new List<PickList__c>();
        pickLists = [Select Sales_Order__c, Site__c, Status__c From PickList__c limit 1];
        
        picklistLines = new List<PickList_Line__c>();
        picklistLines = [Select Product_Name__c, 
                            Sales_Order_Line__c, 
                            Inventory_Position__c, 
                            Picklist__c 
                            From PickList_Line__c limit 1];
    }
    
    // Verify picklist and lines
    private static void verifyPicklistAndLines(){
        
        // Verify picklists
        System.assertEquals(salesOrderObj.Site__c, pickLists[0].Site__c, 'Site mis-match');
        System.assertEquals('Open', pickLists[0].Status__c, 'Status mis-match');
        System.assertEquals(salesOrderObj.Id, pickLists[0].Sales_Order__c, 'SO mis-match');
        
        // Verify picklist lines
        for(Integer i=0; i<picklistLines.size(); i++){
            System.assertEquals(soLines[i].Product_Name__c, picklistLines[i].Product_Name__c, 'Product name mis-match');
            System.assertEquals(soLines[i].Id, picklistLines[i].Sales_Order_Line__c, ' SO line mis-match');
            System.assertEquals(invPositions[i].Id, picklistLines[i].Inventory_Position__c, 'Inventory Position mis-match');
            System.assertEquals(pickLists[0].Id, picklistLines[i].Picklist__c, 'Picklist id mis-match');
        }
    }
    public static testmethod void runSOLineTrigger(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        retrieveData();
        BrandQuoteTriggerHelper.isBQTriggerExecuted = true;
        List<Brand_Quote_Line__c> brandQuoteLines = [Select Id From Brand_Quote_Line__c limit 1];
        String PRODUCT_NAME_MILEAGE_FEE = SalesOrderHelper.PRODUCT_NAME_MILEAGE_FEE;
        String INVOICE_RECORDTYPE_SERVICE  = SalesOrderHelper.INVOICE_RECORDTYPE_SERVICE;
        String PICKLIST_OPEN = SalesOrderHelper.PICKLIST_OPEN;
        
        Test.startTest();
        List<Account> accounts = new List<Account>();
         Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hold__c=true;
        objAccount.DBA__c='Test Account1';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Membership_Level__c = 'Boutique';
        objAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
        accounts.add(objAccount);   
        
        // distributor Account
        Account objAccount2 = new Account();
        objAccount2.Name = 'Test Account2';
        objAccount2.Payment_Terms__c = 'COD';
        objAccount2.Hide_from_Marketplace__c = false;
        accounts.add(objAccount2);  
        
        // receiver Account
        Account objAccount3 = new Account();
        objAccount3.Name = 'Test Account3';
        objAccount3.Payment_Terms__c = 'COD';
        objAccount3.Hide_from_Marketplace__c = false;
        accounts.add(objAccount3);
        
        insert accounts;
        
        // Create Contacts
        // supplier contact
        List<Contact> contacts = new List<Contact>();
        Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
        objContact.AccountId = objAccount.Id;
        contacts.add(objContact);   
        
        // distributor contact
        Contact objContact2 = new Contact();
        objContact2.FirstName = 'Test';
        objContact2.LastName = 'Contact2';
        objContact2.AccountId = objAccount2.Id;
        contacts.add(objContact2);  
        
        // receiver contact
        Contact objContact3 = new Contact();
        objContact3.FirstName = 'Test';
        objContact3.LastName = 'Contact3';
        objContact3.AccountId = objAccount3.Id;
        contacts.add(objContact3);
        
        insert contacts; 
        
        // Create Site
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.Warehouse_Name__c='TestWarehouse1';
        insert objSite;
        
        
        // Create State License
        
        // Supplier License
        List<State_Licenses__c> licenses = new List<State_Licenses__c>();
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        objStateLicenses.Default_Warehouse__c = objSite.Id;
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_State__c = 'California';
        objStateLicenses.License_City__c = 'San Francisco';
        objStateLicenses.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses.License_Zip__c = '94124';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses.Total_Miles__c = 10;
        licenses.add(objStateLicenses);
        
        // distributor License
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount2.id;
        objStateLicenses2.License_Number__c = 'AbcTest45678';
        objStateLicenses2.License_Status__c ='Active';
        objStateLicenses2.License_Type__c ='Type 1';
        objStateLicenses2.License_Class__c='A-License';
        objStateLicenses2.License_State__c = 'California';
        objStateLicenses2.License_City__c = 'San Francisco';
        objStateLicenses2.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses2.License_Zip__c = '94124';
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses2.Default_Warehouse__c = objSite.Id;
        objStateLicenses2.Total_Miles__c = 10;
        licenses.add(objStateLicenses2); 
        
        State_Licenses__c objStateLicenses3 = new State_Licenses__c();
        objStateLicenses3.License_Name__c = objAccount3.id;
        objStateLicenses3.License_Number__c = 'AbcTest54321';
        objStateLicenses3.License_Status__c ='Active';
        objStateLicenses3.License_Type__c ='Type 1';
        objStateLicenses3.License_Class__c='A-License';
        objStateLicenses3.License_State__c = 'California';
        objStateLicenses3.License_City__c = 'San Francisco';
        objStateLicenses3.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses3.License_Zip__c = '94124';
        objStateLicenses3.Default_Warehouse__c = objSite.Id;
        objStateLicenses3.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses3.Total_Miles__c = 10;
        licenses.add(objStateLicenses3);
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        insert licenses;
        
        
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = objStateLicenses.Id;
        ord.Sales_Person__c = objContact.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = objAccount.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName ='Qualification';
        opp.Site_Name__c = objSite.Id;
        opp.Ownership__c = objAccount.id;
        opp.Payment_Terms__c = 'COD';
        opp.Order__c = ord.Id;
        insert opp;
        
        // Create Product
        List<Product2> products = new List<Product2>();
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        Id serviceRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Services').getRecordTypeId();
        
        //Create Product1
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 7';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 7';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.RecordTypeId = productRecordTypeId;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        products.add(objProduct1);
        
        // Create Product2
        Product2  objProduct2 = new Product2 ();
        objProduct2.Name = 'product 8';
        objProduct2.Quantity_Type__c = 'Quantity';
        objProduct2.Family = 'Accessories';
        objProduct2.Description = 'test product 8';
        objProduct2.Producer_Name__c = objAccount.id;
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
        products.add(objProduct2);
        
        // Create Product3
        Product2  objProduct3 = new Product2 ();
        objProduct3.Name = 'product 9';
        objProduct3.Quantity_Type__c = 'Quantity';
        objProduct3.Family = 'Accessories';
        objProduct3.Description = 'test product 9';
        objProduct3.Producer_Name__c = objAccount.id;
        objProduct3.Apply_Cultivation_Tax__c='Yes';
        objProduct3.Apply_Excise_Tax__c='Yes';
        objProduct3.IsActive = true;
        objProduct3.Unit_Height__c  = 30.0;
        objProduct3.Unit_Length__c = 10.0;
        objProduct3.Unit_Width__c = 5.0;
        objProduct3.Apply_Excise_Tax__c = 'Yes';
        objProduct3.RecordTypeId = productRecordTypeId;
        objProduct3.Track_Trace_Category__c='Capsule';
        objProduct3.Net_Weight_UOM__c='EA';
        objProduct3.Unit_Of_Measure__c='Grams';
        objProduct3.MOQ__c = 1;
        products.add(objProduct3);
       
        insert products;
        
        Brand_Quote__c bq = new Brand_Quote__c ();
        bq.Opportunity_Name__c = opp.id; 
        bq.Distributor_License__c = objStateLicenses2.id;
        bq.Receiver_License__c = objStateLicenses3.id;
        bq.Distributor_Name__c = objAccount2.id;
        bq.Supplier_Name__c = objAccount.id;
        bq.Receiver_Name__c = objAccount3.id;
        bq.Supplier_License__c = objStateLicenses.id;
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
        insert bq;
                
        Sales_Order__c objSO1 = new Sales_Order__c();
        objSO1.Site__c = bq.Site__c;
        objSO1.SO_Status__c = 'Approved';
        objSO1.SO_Type__c = 'Sell Quote';
        objSO1.Brand_Quote__c = bq.id;
        objSO1.Supplier_Contact__c = objContact.Id;
        objSO1.Supplier_Name__c = bq.Supplier_Name__c;
        objSO1.Supplier_License__c = bq.Supplier_License__c;
        objSO1.Distributor_Contact__c = objContact2.Id;
        objSO1.Distributor_Name__c = bq.Distributor_Name__c;
        objSO1.Distributor_License__c = bq.Distributor_License__c;
        objSO1.Receiver_Name__c = bq.Receiver_Name__c;
        objSO1.Receiver_Contact__c = objContact3.Id;
        objSO1.Receiver_License__c = bq.Receiver_License__c;
        objSO1.Payment_Terms__c = bq.Payment_Terms__c;
        objSO1.Shipping_Terms__c = bq.Shipping_Terms__c;
        objSO1.Shipping_Method__c = bq.Shipping_Method__c;
        objSO1.Ownership__c = accounts[0].Id;
        objSO1.Customer_PO_or_Quote__c = 'Test Quote';
        objSO1.Account_Hold_Exception__c = true;
        objSO1.Opportunity_Name__c = opp.Id;
        
        insert objSO1;
        Sales_Order__c soObj = [Select Id,Name from Sales_Order__c limit 1];
        SalesOrderHelper.getTotalMilesAndUpdateSO(soObj.Id);
        Test.stopTest();
        
    }
}