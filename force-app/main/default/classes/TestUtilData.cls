/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * TestUtilData
 */
@isTest
public class TestUtilData{
    public static Boolean skipTrigger = false;
    private final static string RSM_STATUS_DRAFT = 'Draft';
    private final static string ETR_STATUS_DRAFT = 'Draft';
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
    public static void createTestData(){
        //Create Document
        Document documentObj;
        
        documentObj = new Document();
        documentObj.Body = Blob.valueOf('Some Document Text For Test Class');
        documentObj.ContentType = 'application/pdf';
        documentObj.DeveloperName = 'TestX8300'; 
        documentObj.IsPublic = true;
        documentObj.Name = 'Test 8300';
        documentObj.FolderId = [select id from folder where name = 'Shared Documents'].id;
        insert documentObj;
        // Create Accounts
     
        // supplier Account
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
        //Create Tax Table
        Tax_Table__c tb = new Tax_Table__c();
        tb.Tax_Due_Rate__c = 5;
        tb.Taxable_Gross_Receipts_Rate__c  = 25;
        tb.Actual_Tax_Rate_on_Product_Rev__c  = 0.5;
        tb.Active__c = true;
        tb.Start_Date__c = System.today().addDays(-10);
        tb.End_Date__c = System.today().addMonths(12);
        tb.City__c  = 'San Francisco';
        insert tb;
        
        
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
        
        // receiver License
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
        
        // receiver License
        State_Licenses__c objStateLicenses4 = new State_Licenses__c();
        objStateLicenses4.License_Name__c = objAccount3.id;
        objStateLicenses4.License_Number__c = 'AbcTest54321456';
        objStateLicenses4.License_Status__c ='Active';
        objStateLicenses4.License_Type__c ='Type 1';
        objStateLicenses4.License_Class__c='A-License';
        objStateLicenses4.Default_Warehouse__c = objSite.Id;
        objStateLicenses4.License_Expiration_Date__c = date.valueof(system.now()) - 10;
        objStateLicenses4.Total_Miles__c = 10;
        licenses.add(objStateLicenses4);
        
        insert licenses;
        Fulfillment_Rates_Table__c[] FRTList = new Fulfillment_Rates_Table__c[]{};
        Fulfillment_Rates_Table__c fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = objSite.Id;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Pick & Pack';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Boutique';
        FRTList.add(fullfillRateTable);
        fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = objSite.Id;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Pick & Pack';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Retail';
        FRTList.add(fullfillRateTable);
        fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = objSite.Id;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'QA Review';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Boutique';
        fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = objSite.Id;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'QA Review';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Retail';
        FRTList.add(fullfillRateTable);
        fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = objSite.Id;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Order Booking';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Boutique';
        fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = objSite.Id;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Order Booking';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Retail';
        FRTList.add(fullfillRateTable);
        fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = objSite.Id;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Stage & Manifest';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Boutique';
        fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = objSite.Id;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Stage & Manifest';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Retail';
        FRTList.add(fullfillRateTable);
        fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = objSite.Id;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Schedule & Dispatch';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Boutique';
        fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = objSite.Id;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Schedule & Dispatch';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Retail';
        FRTList.add(fullfillRateTable);
        fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = objSite.Id;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Pack-Out';
        fullfillRateTable.List_Price__c = 5;
        fullfillRateTable.Membership_Level__c = 'Boutique';
        fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = objSite.Id;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Pack-Out';
        fullfillRateTable.List_Price__c = 5;
        fullfillRateTable.Membership_Level__c = 'Retail';
        FRTList.add(fullfillRateTable);
        insert FRTList;
        Shipping_Rates_Table__c[] sRates = new Shipping_Rates_Table__c[]{};
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
        sRates.add(shipRateTable);
        shipRateTable = new Shipping_Rates_Table__c();
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
        shipRateTable.Membership_Level__c = 'Retail';
        sRates.add(shipRateTable);
        insert sRates;

          
        // Receiving Inspection inventory location
        List<Inventory_Location__c> inventoryLocations = new List<Inventory_Location__c>();
        Inventory_Location__c receivingInventoryLocation = new Inventory_Location__c();
        receivingInventoryLocation.Name = Label.Default_Inventory_Location;
        receivingInventoryLocation.Site_Name__c = objSite.id;
        receivingInventoryLocation.Default_for_Site__c = true;
        inventoryLocations.add(receivingInventoryLocation);
        
        // New Test inventory location
        Inventory_Location__c newInventoryLocation = new Inventory_Location__c();
        newInventoryLocation.Name = 'Test Location';
        newInventoryLocation.Site_Name__c = objSite.id;
        inventoryLocations.add(newInventoryLocation);

        insert inventoryLocations;

        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = objStateLicenses.Id;
        ord.Sales_Person__c = objContact.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        
        
        // Create opportunity
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
        
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        
        // Create Product
        List<Product2> products = new List<Product2>();
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        Id serviceRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Services').getRecordTypeId();
        
        //Create Product1
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
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
        objProduct1.Stocking_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        products.add(objProduct1);
        
        // Create Product2
        Product2  objProduct2 = new Product2 ();
        objProduct2.Name = 'product 2';
        objProduct2.Quantity_Type__c = 'Quantity';
        objProduct2.Family = 'Accessories';
        objProduct2.Description = 'test product 2';
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
        objProduct2.Stocking_UOM__c='EA';
        objProduct2.Unit_Of_Measure__c='Grams';
        objProduct2.MOQ__c = 10;
        products.add(objProduct2);
        
        // Create Product3
        Product2  objProduct3 = new Product2 ();
        objProduct3.Name = 'product 3';
        objProduct3.Quantity_Type__c = 'Quantity';
        objProduct3.Family = 'Accessories';
        objProduct3.Description = 'test product 3';
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
        objProduct3.Stocking_UOM__c='EA';
        objProduct3.Unit_Of_Measure__c='Grams';
        objProduct3.MOQ__c = 1;
        products.add(objProduct3);
        //Create Service Products
        // Create Product3
        Product2  serviceProduct = new Product2 ();
        serviceProduct.Name = PRODUCT_NAME_MILEAGE_FEE;
        serviceProduct.Quantity_Type__c = 'Quantity';
        serviceProduct.Family = 'Service';
        serviceProduct.Description = PRODUCT_NAME_MILEAGE_FEE;
        serviceProduct.Producer_Name__c = objAccount.id;
        serviceProduct.Apply_Cultivation_Tax__c='No';
        serviceProduct.IsActive = true;
        serviceProduct.Apply_Excise_Tax__c = 'No';
        serviceProduct.RecordTypeId = serviceRecordTypeId;
        serviceProduct.MOQ__c = 1;
        serviceProduct.Track_Trace_Category__c='Capsule';
        serviceProduct.Net_Weight_UOM__c='EA';
        serviceProduct.Unit_Of_Measure__c='Grams';
        products.add(serviceProduct);
        serviceProduct = new Product2 ();
        serviceProduct.Name = PRODUCT_NAME_PICK_AND_PACK_FEE;
        serviceProduct.Quantity_Type__c = 'Quantity';
        serviceProduct.Family = 'Service';
        serviceProduct.Description = PRODUCT_NAME_PICK_AND_PACK_FEE;
        serviceProduct.Producer_Name__c = objAccount.id;
        serviceProduct.Apply_Cultivation_Tax__c='No';
        serviceProduct.IsActive = true;
        serviceProduct.Apply_Excise_Tax__c = 'No';
        serviceProduct.RecordTypeId = serviceRecordTypeId;
        serviceProduct.MOQ__c = 1;
        serviceProduct.Track_Trace_Category__c='Capsule';
        serviceProduct.Net_Weight_UOM__c='EA';
        serviceProduct.Unit_Of_Measure__c='Grams';
        products.add(serviceProduct);
        
        serviceProduct = new Product2 ();
        serviceProduct.Name = PRODUCT_NAME_WEIGHT_FEE;
        serviceProduct.Quantity_Type__c = 'Quantity';
        serviceProduct.Family = 'Service';
        serviceProduct.Description = PRODUCT_NAME_WEIGHT_FEE;
        serviceProduct.Producer_Name__c = objAccount.id;
        serviceProduct.Apply_Cultivation_Tax__c='No';
        serviceProduct.IsActive = true;
        serviceProduct.Apply_Excise_Tax__c = 'No';
        serviceProduct.RecordTypeId = serviceRecordTypeId;
        serviceProduct.MOQ__c = 1;
        serviceProduct.Track_Trace_Category__c='Capsule';
        serviceProduct.Net_Weight_UOM__c='EA';
        serviceProduct.Unit_Of_Measure__c='Grams';
        products.add(serviceProduct);
        
        serviceProduct = new Product2 ();
        serviceProduct.Name = PRODUCT_NAME_QA_REVIEW_FEE;
        serviceProduct.Quantity_Type__c = 'Quantity';
        serviceProduct.Family = 'Service';
        serviceProduct.Description = PRODUCT_NAME_QA_REVIEW_FEE;
        serviceProduct.Producer_Name__c = objAccount.id;
        serviceProduct.Apply_Cultivation_Tax__c='No';
        serviceProduct.IsActive = true;
        serviceProduct.Apply_Excise_Tax__c = 'No';
        serviceProduct.RecordTypeId = serviceRecordTypeId;
        serviceProduct.MOQ__c = 1;
        serviceProduct.Track_Trace_Category__c='Capsule';
        serviceProduct.Net_Weight_UOM__c='EA';
        serviceProduct.Unit_Of_Measure__c='Grams';
        products.add(serviceProduct);
        
        serviceProduct = new Product2 ();
        serviceProduct.Name = PRODUCT_NAME_ORDER_BOOKING;
        serviceProduct.Quantity_Type__c = 'Quantity';
        serviceProduct.Family = 'Service';
        serviceProduct.Description = PRODUCT_NAME_ORDER_BOOKING;
        serviceProduct.Producer_Name__c = objAccount.id;
        serviceProduct.Apply_Cultivation_Tax__c='No';
        serviceProduct.IsActive = true;
        serviceProduct.Apply_Excise_Tax__c = 'No';
        serviceProduct.RecordTypeId = serviceRecordTypeId;
        serviceProduct.MOQ__c = 1;
        serviceProduct.Track_Trace_Category__c='Capsule';
        serviceProduct.Net_Weight_UOM__c='EA';
        serviceProduct.Unit_Of_Measure__c='Grams';
        products.add(serviceProduct);
        
        
        serviceProduct = new Product2 ();
        serviceProduct.Name = PRODUCT_NAME_PACK_OUT;
        serviceProduct.Quantity_Type__c = 'Quantity';
        serviceProduct.Family = 'Service';
        serviceProduct.Description = PRODUCT_NAME_PACK_OUT;
        serviceProduct.Producer_Name__c = objAccount.id;
        serviceProduct.Apply_Cultivation_Tax__c='No';
        serviceProduct.IsActive = true;
        serviceProduct.Apply_Excise_Tax__c = 'No';
        serviceProduct.RecordTypeId = serviceRecordTypeId;
        serviceProduct.MOQ__c = 1;
        serviceProduct.Track_Trace_Category__c='Capsule';
        serviceProduct.Net_Weight_UOM__c='EA';
        serviceProduct.Unit_Of_Measure__c='Grams';
        products.add(serviceProduct);
        
        serviceProduct = new Product2 ();
        serviceProduct.Name = PRODUCT_NAME_SCHEDULE_AND_DISPATCH;
        serviceProduct.Quantity_Type__c = 'Quantity';
        serviceProduct.Family = 'Service';
        serviceProduct.Description = PRODUCT_NAME_SCHEDULE_AND_DISPATCH;
        serviceProduct.Producer_Name__c = objAccount.id;
        serviceProduct.Apply_Cultivation_Tax__c='No';
        serviceProduct.IsActive = true;
        serviceProduct.Apply_Excise_Tax__c = 'No';
        serviceProduct.RecordTypeId = serviceRecordTypeId;
        serviceProduct.MOQ__c = 1;
        serviceProduct.Track_Trace_Category__c='Capsule';
        serviceProduct.Net_Weight_UOM__c='EA';
        serviceProduct.Unit_Of_Measure__c='Grams';
        products.add(serviceProduct);
        
        serviceProduct = new Product2 ();
        serviceProduct.Name = PRODUCT_NAME_STAGE_AND_MANIFEST;
        serviceProduct.Quantity_Type__c = 'Quantity';
        serviceProduct.Family = 'Service';
        serviceProduct.Description = PRODUCT_NAME_STAGE_AND_MANIFEST;
        serviceProduct.Producer_Name__c = objAccount.id;
        serviceProduct.Apply_Cultivation_Tax__c='Yes';
        serviceProduct.IsActive = true;
        serviceProduct.Apply_Excise_Tax__c = 'No';
        serviceProduct.RecordTypeId = serviceRecordTypeId;
        serviceProduct.MOQ__c = 1;
        serviceProduct.Track_Trace_Category__c='Capsule';
        serviceProduct.Net_Weight_UOM__c='EA';
        serviceProduct.Unit_Of_Measure__c='Grams';
        products.add(serviceProduct);
        
        serviceProduct = new Product2 ();
        serviceProduct.Name = PRODUCT_NAME_CHANGE_ORDER_FEE;
        serviceProduct.Quantity_Type__c = 'Quantity';
        serviceProduct.Family = 'Service';
        serviceProduct.Description = PRODUCT_NAME_CHANGE_ORDER_FEE;
        serviceProduct.Producer_Name__c = objAccount.id;
        serviceProduct.Apply_Cultivation_Tax__c='No';
        serviceProduct.IsActive = true;
        serviceProduct.Apply_Excise_Tax__c = 'No';
        serviceProduct.RecordTypeId = serviceRecordTypeId;
        serviceProduct.MOQ__c = 1;
        serviceProduct.Track_Trace_Category__c='Capsule';
        serviceProduct.Net_Weight_UOM__c='EA';
        serviceProduct.Unit_Of_Measure__c='Grams';
        products.add(serviceProduct);
        
        insert products;
        
        // Create price book entry for first product
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id=Test.getStandardPricebookId(), Product2Id=objProduct1.Id, UnitPrice=99, isActive=true);
        insert pbe;
        
        // Create Opportunity line item
        OpportunityLineItem opLineItem=new OpportunityLineItem ();
        opLineItem.Quantity=1;
        opLineItem.OpportunityId =opp.id;
        opLineItem.TotalPrice =100;
        opLineItem.PricebookEntryId = pbe.id;
        opLineItem.Product2Id = objProduct1.Id;
        insert opLineItem;

        // Create brand quote
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
        
        // Create brand quote lines
        List<Brand_Quote_Line__c> brandQuoteLines = new List<Brand_Quote_Line__c>();
        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c= objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;
        objbqline1.Invoiced_Quantity__c = 20;
        objbqline1.Retail_Wholesale_Price__c  = 100;
        objbqline1.Billed_Quantity__c =10;
        brandQuoteLines.add(objbqline1);
        
        Brand_Quote_Line__c objbqline2 = new Brand_Quote_Line__c();
        objbqline2.Brand_Quote_Number__c = bq.id;
        objbqline2.Product_Name__c= objProduct2.id;
        objbqline2.MOQ__c = 20;
        objbqline2.Quantity_Cases__c = 50;
        objbqline2.Invoiced_Quantity__c = 20;
        objbqline2.Retail_Wholesale_Price__c  = 100;
        objbqline2.Billed_Quantity__c =10;
        brandQuoteLines.add(objbqline2);
        
        Brand_Quote_Line__c objbqline3 = new Brand_Quote_Line__c();
        objbqline3.Brand_Quote_Number__c = bq.id;
        objbqline3.Product_Name__c= objProduct3.id;
        objbqline3.MOQ__c = 8;
        objbqline3.Quantity_Cases__c = 100;
        objbqline3.Invoiced_Quantity__c = 20;
        objbqline3.Retail_Wholesale_Price__c  = 100;
        objbqline3.Billed_Quantity__c =10;
        brandQuoteLines.add(objbqline3);
        
        insert brandQuoteLines;
        
        // Create purchase order
        Id recordTypeId = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
                      
        Purchase_Order__c objPO = new Purchase_Order__c();
        objPO.recordTypeId = recordTypeId;
        objPO.Site__c = bq.Site__c;
        objpO.PO_Status__c = 'Draft';
        objpO.PO_Type__c = 'Buy Quote';
        objPO.Supplier_Name__c = bq.Supplier_Name__c;
        objPO.Supplier_License__c = bq.Supplier_License__c;
        objPO.Distributor_Name__c = bq.Distributor_Name__c;
        objPO.Distributor_License__c = bq.Distributor_License__c;
        objPO.Receiver_Name__c = bq.Receiver_Name__c;
        objPO.Receiver_License__c = bq.Receiver_License__c;
        objPO.Ownership__c = bq.Ownership__c;
        insert objPO;
        
        // Create purchase order lines  
        Purchase_Order_Line__c objPOline1 = new Purchase_Order_Line__c();
        objPOline1.Purchase_Order__c = objPO.id;
        objPOline1.Product_Name__c= objbqline1.Product_Name__c;
        objPOline1.Qty_Ordered__c = 10;
        objPOline1.Unit_Cost__c = 10;
        objPOline1.Brand_Quote_Line__c =  objbqline1.Id;
        
        Purchase_Order_Line__c objPOline2 = new Purchase_Order_Line__c();
        objPOline2.Purchase_Order__c = objPO.id;
        objPOline2.Product_Name__c= objbqline2.Product_Name__c;
        objPOline2.Qty_Ordered__c = 20;
        objPOline2.Unit_Cost__c = 20;
        objPOline2.Brand_Quote_Line__c =  objbqline2.Id;
        
        Purchase_Order_Line__c objPOline3 = new Purchase_Order_Line__c();
        objPOline3.Purchase_Order__c = objPO.id;
        objPOline3.Product_Name__c= objbqline3.Product_Name__c;
        objPOline3.Qty_Ordered__c = 30;
        objPOline3.Unit_Cost__c = 30;
        objPOline3.Brand_Quote_Line__c =  objbqline3.Id;
        
        list<Purchase_Order_Line__c> purchaseOrderLines = new list<Purchase_Order_Line__c>();
        purchaseOrderLines.add(objPOline1);
        purchaseOrderLines.add(objPOline2);
        purchaseOrderLines.add(objPOline3);
        insert purchaseOrderLines;
        
        // Create Receiving
        Receiving__c objReceiving = new Receiving__c(Purchase_Order__c= objPO.id, Site__c= objPO.Site__c, Ownership__c = objPO.Ownership__c );
        insert objReceiving;
        
        // Create 3 receiving lines which will create inventory positions automatically
        List<Receiving_Line__c> receivingLines = new List<Receiving_Line__c>();
        for(Integer i=0; i<purchaseOrderLines.size(); i++){
            Receiving_Line__c objReceivingLine = new Receiving_Line__c();
            objReceivingLine.Inventory_Location__c = receivingInventoryLocation.Id;
            objReceivingLine.Product_Name__c = products[i].Id;
            objReceivingLine.Purchase_Order_Line__c = purchaseOrderLines[i].Id;
            objReceivingLine.Qty_to_Receive__c = 5.0;
            objReceivingLine.Receiving_ID__c = objReceiving.Id;
            objReceivingLine.Site__c = objSite.Id;
            objReceivingLine.UID__c = 'TEST' + i;
            objReceivingLine.Ownership__c = objAccount.Id;
            receivingLines.add(objReceivingLine);
        }
        insert receivingLines;
        
        // Create Racks
        List<Rack__c> racks = new List<Rack__c>();
        Rack__c rackSO = new Rack__c();
        rackSO.Inventory_Location__c = newInventoryLocation.Id;
        racks.add(rackSO);
        insert racks;
        
        // Create Rack Levels
        List<Rack_Level__c> rackLevels = new List<Rack_Level__c>();
        Rack_Level__c rackLevelSO = new Rack_Level__c();
        rackLevelSO.Rack__c = racks[0].Id;
        rackLevels.add(rackLevelSO);
        insert rackLevels;
        
        // Create Bin Locations
        List<Bin_Location__c> binLocations = new List<Bin_Location__c>();
        Bin_Location__c binLocationSO = new Bin_Location__c();
        binLocationSO.Rack_Level__c = rackLevels[0].Id;
        binLocationSO.Bin_Height__c = 10.0;
        binLocationSO.Bin_Length__c = 10.0;
        binLocationSO.Bin_Width__c = 20.0;
        binLocations.add(binLocationSO);
        insert binLocations;
        
        Sales_Order__c objSO = new Sales_Order__c();
        objSO.Site__c = bq.Site__c;
        objSO.SO_Status__c = 'Draft';
        objSO.SO_Type__c = 'Sell Quote';
        objSO.Brand_Quote__c = bq.id;
        objSO.Supplier_Contact__c = objContact.Id;
        objSO.Supplier_Name__c = bq.Supplier_Name__c;
        objSO.Supplier_License__c = bq.Supplier_License__c;
        objSO.Distributor_Contact__c = objContact2.Id;
        objSO.Distributor_Name__c = bq.Distributor_Name__c;
        objSO.Distributor_License__c = bq.Distributor_License__c;
        objSO.Receiver_Name__c = bq.Receiver_Name__c;
        objSO.Receiver_Contact__c = objContact3.Id;
        objSO.Receiver_License__c = bq.Receiver_License__c;
        objSO.Payment_Terms__c = bq.Payment_Terms__c;
        objSO.Shipping_Terms__c = bq.Shipping_Terms__c;
        objSO.Shipping_Method__c = bq.Shipping_Method__c;
        objSO.Ownership__c = accounts[0].Id;
        objSO.Customer_PO_or_Quote__c = 'Test Quote';
        objSO.Account_Hold_Exception__c = true;
        objSO.Opportunity_Name__c = opp.Id;
        
        insert objSO;    
            
        Sales_Order_Line__c objSOline1 = new Sales_Order_Line__c();
        objSOline1.Sales_Order__c = objSO.id;
        objSOline1.Product_Name__c= objbqline1.Product_Name__c;
        objSOline1.Product_Title__c = 'Distributor';
        objSOline1.Qty_Ordered__c = 10;
        objSOline1.Qty_Invoiced__c = 5.0;
        objSOline1.Retail_Wholesale_Price__c = 10;
        objSOline1.Status__c = 'Allocated';
        
        Sales_Order_Line__c objSOline2 = new Sales_Order_Line__c();
        objSOline2.Sales_Order__c = objSO.id;
        objSOline2.Product_Name__c= objbqline2.Product_Name__c;
        objSOline2.Product_Title__c = 'Distributor';
        objSOline2.Qty_Ordered__c = 20;
        objSOline2.Qty_Invoiced__c = 15.0;
        objSOline2.Retail_Wholesale_Price__c = 20;
        
        Sales_Order_Line__c objSOline3 = new Sales_Order_Line__c();
        objSOline3.Sales_Order__c = objSO.id;
        objSOline3.Product_Name__c= objbqline3.Product_Name__c;
        objSOline3.Product_Title__c = 'Distributor';
        objSOline3.Qty_Ordered__c = 30;
        objSOline3.Qty_Invoiced__c = 25.0;
        objSOline3.Retail_Wholesale_Price__c = 30;
        
        list<Sales_Order_Line__c> lstSalesOrderLine = new list<Sales_Order_Line__c>();
        lstSalesOrderLine.add(objSOline1);
        lstSalesOrderLine.add(objSOline2);
        lstSalesOrderLine.add(objSOline3);
        
        insert lstSalesOrderLine;
        
        Invoice__c inv = new Invoice__c();
        inv.Sales_Order__c = objSO.id;
        inv.AR_Status__c = 'Draft';
        inv.Brand_Quote__c = bq.Id;
        insert inv;
        
        Invoice_Line__c invLine1 = new Invoice_Line__c();
        invline1.Invoice__c = inv.id;
        invLine1.Sales_Order_Line__c = lstSalesOrderLine[0].Id;
        invLine1.Invoice_Qty__c = 5.0;
        invLine1.Retail_Wholesale_Price__c = 100.0;
        invLine1.Excise_Tax_Amount__c = 10.0;
        invLine1.Product_Name__c = objProduct1.Id;
        
        Invoice_Line__c invLine2 = new Invoice_Line__c();
        invLine2.Invoice__c = inv.id;
        invLine2.Sales_Order_Line__c = lstSalesOrderLine[1].Id;
        invLine2.Invoice_Qty__c = 15.0;
        invLine2.Retail_Wholesale_Price__c = 100.0;
        invLine2.Excise_Tax_Amount__c = 15.0;
        invLine2.Product_Name__c = objProduct2.Id;
        
        Invoice_Line__c invLine3 = new Invoice_Line__c();
        invLine3.Invoice__c = inv.id;
        invLine3.Sales_Order_Line__c = lstSalesOrderLine[2].Id;
        invLine3.Invoice_Qty__c = 25.0;
        invLine3.Retail_Wholesale_Price__c = 100.0;
        invLine3.Excise_Tax_Amount__c = 20.0;
        invLine3.Product_Name__c = objProduct3.Id;
        
        list<Invoice_Line__c> ivoiceLines = new list<Invoice_Line__c>();
        ivoiceLines.add(invLine1);
        ivoiceLines.add(invLine2);
        
        
        insert ivoiceLines;
        inv.Receiver_Name__c = objAccount.Id;
        inv.Receiver_License__c = objStateLicenses.Id;
        inv.Invoice_Date__c = System.today();
        update inv;
        insert invLine3;
    }
    
    // Create picklist record
    public static Picklist__c createPicklist(Sales_Order__c soObj, String status, Boolean isCreate){
        Picklist__c picklistObj = new Picklist__c();
        picklistObj.Sales_Order__c = soObj.Id;
        picklistObj.Site__c = soObj.Site__c;
        picklistObj.Status__c = status;
        if(isCreate){
            insert picklistObj;
        }
        return picklistObj;
    }
    
    // Create picklist line record
    public static List<Picklist_Line__c> createPicklistLines(List<Inventory_Position__c> invPositions,
                                                             Id picklistId,
                                                             Boolean isCreate){
        return createPicklistLines(invPositions, picklistId, null, isCreate);
    }
    
    public static List<Picklist_Line__c> createPicklistLines(List<Inventory_Position__c> invPositions,
                                                             Id picklistId,
                                                             String status,
                                                             Boolean isCreate){
        List<Picklist_Line__c> picklistLines = new List<Picklist_Line__c>();
        for(Inventory_Position__c invPositionObj : invPositions){
            Picklist_Line__c picklistLineObj = new Picklist_Line__c();
            picklistLineObj.Product_Name__c = invPositionObj.Sales_Order_Line__r.Product_Name__c;
            picklistLineObj.Sales_Order_Line__c = invPositionObj.Sales_Order_Line__c;
            picklistLineObj.Inventory_Position__c = invPositionObj.Id;
            picklistLineObj.Picklist__c = picklistId;
            picklistLineObj.Status__c = status;
            picklistLines.add(picklistLineObj);
        }
        if(isCreate){
            insert picklistLines;
        }
        return picklistLines;
    }
    
    // Create RSM record
    public static Shipping_Manifest__c createRSM(Picklist__c picklistObj, Boolean isCreate){
        Id rsmRecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        Shipping_Manifest__c rsmObj  = new Shipping_Manifest__c();
        rsmObj.Brand_Quote__c               = picklistObj.Sales_Order__r.Brand_Quote__c;
        rsmObj.Customer_PO_or_Quote__c      = picklistObj.Sales_Order__r.Customer_PO_or_Quote__c;
        rsmObj.Distributor_Contact__c       = picklistObj.Sales_Order__r.Distributor_Contact__c;
        rsmObj.Distributor_License__c       = picklistObj.Sales_Order__r.Distributor_License__c;
        rsmObj.Distributor_Name__c          = picklistObj.Sales_Order__r.Distributor_Name__c;
        rsmObj.Opportunity_Name__c          = picklistObj.Sales_Order__r.Opportunity_Name__c;
        rsmObj.Payment_Terms__c             = picklistObj.Sales_Order__r.Payment_Terms__c;
        rsmObj.Picklist__c                  = picklistObj.Id;
        rsmObj.Planned_Ship_Transfer_Date__c         = picklistObj.Sales_Order__r.Planned_Ship_Date__c;
        rsmObj.Receiver_Contact__c          = picklistObj.Sales_Order__r.Receiver_Contact__c;
        rsmObj.Receiver_License__c          = picklistObj.Sales_Order__r.Receiver_License__c;
        rsmObj.Receiver_Name__c             = picklistObj.Sales_Order__r.Receiver_Name__c;
        rsmObj.Status__c                = RSM_STATUS_DRAFT;
        rsmObj.Sample_Order__c              = picklistObj.Sales_Order__r.Sample_Order__c;
        rsmObj.Shipping_Method__c           = picklistObj.Sales_Order__r.Shipping_Method__c;
        rsmObj.Shipping_Terms__c            = picklistObj.Sales_Order__r.Shipping_Terms__c;
        rsmObj.Site__c                      = picklistObj.Site__c;
        rsmObj.Supplier_Contact__c          = picklistObj.Sales_Order__r.Supplier_Contact__c;
        rsmObj.Supplier_License__c          = picklistObj.Sales_Order__r.Supplier_License__c;
        rsmObj.Supplier_Name__c             = picklistObj.Sales_Order__r.Supplier_Name__c;
        rsmObj.RecordTypeId                 = rsmRecordTypeId;
        
        if(isCreate){
            insert rsmObj;
        }
        return rsmObj;
    }
    
    // Create RSM Line record
    public static Shipping_Manifest_Line__c createRSMLine(Picklist_Line__c picklistLineObj, 
                                                                 Id rsmId,
                                                                 Boolean isCreate){
        Id rsmLineRecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        Shipping_Manifest_Line__c rsmLineObj = new Shipping_Manifest_Line__c();
        rsmLineObj.Shipping_Manifest__c      = rsmId;
        rsmLineObj.PickList_Line__c                 = picklistLineObj.Id;
        rsmLineObj.Product_Name__c                  = picklistLineObj.Sales_Order_Line__r.Product_Name__c;
        rsmLineObj.Product_Title__c                 = picklistLineObj.Sales_Order_Line__r.Product_Title__c;
        rsmLineObj.Qty_Received__c                  = 10;
        rsmLineObj.Retail_Wholesale_Price__c        = picklistLineObj.Sales_Order_Line__r.Retail_Wholesale_Price__c;
        rsmLineObj.RecordTypeId                     = rsmLineRecordTypeId;
        rsmLineObj.Shipment_Qty__c                  = 10;
        if(isCreate){
            insert rsmLineObj;
        }
        return rsmLineObj;
    }
    
    // Create Driver
    public static Drivers__c createDriver(Boolean isCreate){
        Drivers__c driverObj = new Drivers__c();
        driverObj.Name = 'Test Driver';
        driverObj.Driver_License_Number__c = '123';
        driverObj.Expiration_Date__c = System.Today() + 100;
        driverObj.State_Issued__c = 'AL';
        if(isCreate){
            insert driverObj;
        }
        return driverObj;
    }
        
    // Create Vehicle
    public static Vehicles__c createVehicle(Boolean isCreate){
        Vehicles__c vehicleObj = new Vehicles__c();
        vehicleObj.Name = 'Test Vehicle'; // Same as Inventory Location of Picklist Line
        if(isCreate){
            insert vehicleObj;
        }
        return vehicleObj;
    }
    
    // Create TSM record
    public static Shipping_Manifest__c createTSM(Sales_Order__c salesObj, Boolean isCreate){
        Id tsmRecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        Shipping_Manifest__c tsmObj  = new Shipping_Manifest__c();
        tsmObj.Brand_Quote__c               = salesObj.Brand_Quote__c;
        tsmObj.Distributor_Contact__c       = salesObj.Distributor_Contact__c;
        tsmObj.Distributor_License__c       = salesObj.Distributor_License__c;
        tsmObj.Distributor_Name__c          = salesObj.Distributor_Name__c;
        tsmObj.Opportunity_Name__c          = salesObj.Opportunity_Name__c;
        tsmObj.Payment_Terms__c             = salesObj.Payment_Terms__c;
        tsmObj.Planned_Ship_Transfer_Date__c         = salesObj.Planned_Ship_Date__c;
        tsmObj.Receiver_Contact__c          = salesObj.Receiver_Contact__c;
        tsmObj.Receiver_License__c          = salesObj.Receiver_License__c;
        tsmObj.Receiver_Name__c             = salesObj.Receiver_Name__c;
        tsmObj.Status__c                    = 'Approved';
        tsmObj.Sample_Order__c              = salesObj.Sample_Order__c;
        tsmObj.Shipping_Method__c           = salesObj.Shipping_Method__c;
        tsmObj.Shipping_Terms__c            = salesObj.Shipping_Terms__c;
        tsmObj.Site__c                      = salesObj.Site__c;
        tsmObj.Supplier_Contact__c          = salesObj.Supplier_Contact__c;
        tsmObj.Supplier_License__c          = salesObj.Supplier_License__c;
        tsmObj.Supplier_Name__c             = salesObj.Supplier_Name__c;
        tsmObj.RecordTypeId                 = tsmRecordTypeId;
        
        if(isCreate){
            insert tsmObj;
        }
        System.debug('tsmObj:'+tsmObj.Id);
        return tsmObj;
    }
    
    // Create TSM Line record
    public static Shipping_Manifest_Line__c createTSMLine(Product2 productObj, 
                                                          Id tsmId,
                                                          Boolean isCreate){
        Id tsmLineRecordTypeId = ShippinManifestSupport.getTSMLineRecordTypeId();
        Shipping_Manifest_Line__c tsmLineObj = new Shipping_Manifest_Line__c();
        tsmLineObj.Shipping_Manifest__c      = tsmId;
        tsmLineObj.Product_Name__c                    = productObj.Id;
        tsmLineObj.Qty_Received__c                    = 10;
        tsmLineObj.RecordTypeId                       = tsmLineRecordTypeId;
        if(isCreate){
            insert tsmLineObj;
        }
        return tsmLineObj;
    }
    
    // Create ETR record
    public static Excise_Tax_Receipt__c createETR(Invoice__c invoiceObj,
                                                  Sales_Order__c soObj, 
                                                  Boolean isCreate){
                                                      
        Excise_Tax_Receipt__c etrObj  = new Excise_Tax_Receipt__c();
        etrObj.Brand_Quote__c               = soObj.Brand_Quote__c;
        etrObj.Customer_PO_or_Quote__c      = soObj.Customer_PO_or_Quote__c;
        etrObj.Distributor_Contact__c       = soObj.Distributor_Contact__c;
        etrObj.Distributor_License__c       = soObj.Distributor_License__c;
        etrObj.Distributor_Name__c          = soObj.Distributor_Name__c;
        etrObj.Opportunity_Name__c          = soObj.Opportunity_Name__c;
        etrObj.Payment_Terms__c             = soObj.Payment_Terms__c;
        etrObj.Receiver_Contact__c          = soObj.Receiver_Contact__c;
        etrObj.Receiver_License__c          = soObj.Receiver_License__c;
        etrObj.Receiver_Name__c             = soObj.Receiver_Name__c;
        etrObj.ETR_Status__c                = ETR_STATUS_DRAFT;
        etrObj.Sample_Order__c              = soObj.Sample_Order__c;
        etrObj.Shipping_Method__c           = soObj.Shipping_Method__c;
        etrObj.Shipping_Terms__c            = soObj.Shipping_Terms__c;
        etrObj.Site__c                      = soObj.Site__c;
        etrObj.Supplier_Contact__c          = soObj.Supplier_Contact__c;
        etrObj.Supplier_License__c          = soObj.Supplier_License__c;
        etrObj.Supplier_Name__c             = soObj.Supplier_Name__c;
        etrObj.Sales_Order__c               = soObj.Id;
        etrObj.Invoice__c                   = invoiceObj.Id;
        
        if(isCreate){
            insert etrObj;
        }
        return etrObj;
    }
    
    // Create Payment Term Setting record
    public static Payment_Terms_Settings__c createPaymentTermSettigs(String termName, 
                                                                     Integer offset, 
                                                                     Boolean isCreate){
                                                                         
        Payment_Terms_Settings__c paymentTermSettings = new Payment_Terms_Settings__c();
        paymentTermSettings.Name = termName;
        paymentTermSettings.Offset__c = offset;
        
        if(isCreate){
            insert paymentTermSettings;
        }
        return paymentTermSettings;
    }
    
    // Create Delivery Window record
    public static Delivery_Window__c createDeliveryWindow(Id accountId, 
                                                          String deliveryDay,
                                                          String startTime,
                                                          String endTime,
                                                          Boolean fullDayDelivery,
                                                          Boolean isCreate){
        
        Delivery_Window__c deliveryWindowSO = new Delivery_Window__c();
        deliveryWindowSO.Account__c = accountId;
        deliveryWindowSO.Delivery_Day__c = deliveryDay;
        deliveryWindowSO.Earliest_Delivery_Window__c = startTime;
        deliveryWindowSO.Last_Delivery_Window__c = endTime;
        deliveryWindowSO.Full_Day_Delivery__c = fullDayDelivery;
        
        if(isCreate){
            insert deliveryWindowSO;
        }
        return deliveryWindowSO;
    } 

    // Create Bank Register record
    public static Bank_Register__c createBankRegister(Id accountId, Boolean isCreate){
        Bank_Register__c bankRegisterSO = new Bank_Register__c();
        bankRegisterSO.Account__c = accountId;
        bankRegisterSO.Account_Number__c = 'Test123';
        bankRegisterSO.Register_Type__c = 'Savings';
        bankRegisterSO.Bank_Name__c = 'Test Bank';
        bankRegisterSO.Starting_Balance__c = 100000;
        bankRegisterSO.Active__c = true;
        if(isCreate){
            insert bankRegisterSO;
        }
        return bankRegisterSO;
    }
    
    // Create Bank Register Entry record
    public static Register_Entry_Line__c createBankRegisterEntry(Id accountId,
                                                               Id bankReisterId, 
                                                               Date entryDate,
                                                               String entryMemo,
                                                               Id receivePaymentId,
                                                               Boolean reconciledFlag,
                                                               Decimal creditAmount,
                                                               Decimal debitAmount, 
                                                               Boolean isCreate){
        Register_Entry_Line__c registerEntrySO = new Register_Entry_Line__c();
        registerEntrySO.Bank_Register__c = bankReisterId;
        registerEntrySO.Entry_Date__c = entryDate;
        registerEntrySO.Payee__c = accountId;
        registerEntrySO.Entry_Memo__c = entryMemo;
        registerEntrySO.Related_Payment__c = receivePaymentId;
        registerEntrySO.Reconciled__c = reconciledFlag;
        registerEntrySO.Credit_Amount__c = creditAmount;
        registerEntrySO.Debit_Amount__c = debitAmount;
        if(isCreate){
            insert registerEntrySO;
        }
        return registerEntrySO;
    }
}