/**
 * Copyright (c) 2021 WOVN
 * All rights reserved.
 * DisplayRSMTSMControllerTest
 */

@isTest(OnInstall=false SeeAllData=false)
public class DisplayRSMTSMControllerTest {
    
   static List<Shipping_Manifest__c> lstrsm;
   static List<Shipping_Manifest__c > lsttsm;
    
   static testMethod void testDisplayRSMTSM(){ 
      DisplayRSMTSMController controllerObj = new DisplayRSMTSMController();
      controllerObj.retreiveTSMRSM(); 
   }
    
    
    static testMethod void testDisplayRSMTSMErrorMsg(){
        DisplayRSMTSMController controllerObj = new DisplayRSMTSMController();
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
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
        Id recordTypeId = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
                     
        Purchase_Order__c objPO1 = new Purchase_Order__c();
        objPO1.recordTypeId = recordTypeId;
        objPO1.Site__c = bq.Site__c;
        objPO1.PO_Status__c = 'Approved';
        objPO1.PO_Type__c = 'Buy Quote';
        objPO1.Supplier_Name__c = bq.Supplier_Name__c;
        objPO1.Supplier_License__c = bq.Supplier_License__c;
        objPO1.Distributor_Name__c = bq.Distributor_Name__c;
        objPO1.Distributor_License__c = bq.Distributor_License__c;
        objPO1.Receiver_Name__c = bq.Receiver_Name__c;
        objPO1.Receiver_License__c = bq.Receiver_License__c;
        objPO1.Ownership__c = bq.Ownership__c;
        objPO1.Total_Weight_Fee__c =10;
        insert objPO1;
        
        Drivers__c driverO = new Drivers__c();
        driverO.Name = 'Test Driver1';
        driverO.Driver_License_Number__c = '12311';
        driverO.Expiration_Date__c = System.Today() + 100;
        driverO.State_Issued__c = 'NY';
        insert driverO;
        
        Vehicles__c vehicle1 = new Vehicles__c();
        vehicle1.Name = 'Test Vehicle'; // Same as Inventory Location of Picklist Line
        insert vehicle1;
       Sales_Order__c objSO =[select id,Site__c, Site__r.Name, Planned_Ship_Date__c,Window_Start__c,Opportunity_Name__c, Opportunity_Name__r.Name, Window_End__c from Sales_Order__c limit 1];
        
        objSO.Planned_Ship_Date__c = date.today();
        update objSO;
        
        
        Picklist__c objPicklist= TestUtilData.createPicklist(objSO, 'Open', true);
        
        list<Shipping_Manifest__c> lstRSM = new list<Shipping_Manifest__c>();
        
        Shipping_Manifest__c objRSM1 = TestUtilData.createRSM(objPicklist, false);
        objRSM1.Planned_Ship_Transfer_Date__c = objSO.Planned_Ship_Date__c;
        objRSM1.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        objRSM1.Sales_Order__c = objSO.Id;
        lstRSM.add(objRSM1);
        
        Shipping_Manifest__c objRSM2 = TestUtilData.createRSM(objPicklist, false);
        objRSM2.Planned_Ship_Transfer_Date__c = objSO.Planned_Ship_Date__c;
        objRSM2.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        objRSM2.Sales_Order__c = objSO.Id;
        lstRSM.add(objRSM2);
        
        Shipping_Manifest__c objRSM3 = TestUtilData.createRSM(objPicklist, false);
        objRSM3.Planned_Ship_Transfer_Date__c = objSO.Planned_Ship_Date__c;
        objRSM3.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        lstRSM.add(objRSM3);
        insert lstRSM;
        
        
        
        Purchase_Order__c objPO = [Select id, Name, Brand_Quote__c, Opportunity_Name__c, Opportunity_Name__r.Name, Site__c, Site__r.Name, Ownership__c, 
                                   Distributor_Name__c, Distributor_Contact__c, Supplier_Name__c, Supplier_Contact__c,
                                   Receiver_Name__c, Receiver_Contact__c, Planned_Ship_Transfer_Date__c from Purchase_Order__c limit 1];
        
        Shipping_Manifest__c sm = [SELECT Id, Name, Priority__c, Site__c, Site__r.Name, Sales_Order__c, Receiver_Name__r.Name, Metrc_Manifest__c, Driver__c, Driver__r.Name, Vehicle__c, Vehicle__r.Name, Opportunity_Name__r.Name, Status__c, Planned_Ship_Transfer_Date__c, RecordTypeId, RecordType.Name,Receiver_Name__r.DBA__c FROM  Shipping_Manifest__c limit 1];

        String totalSMRecord = '[{"driverId":"a0K6A000007QakhUAC","driverName":"Sathiyaraj R","oppId":"0067b00000HNmcqAAD","oppName":"ST-2021-05-02471","plannedShipDate":"2021-06-05","poId":"a0W7b000006fCHqEAM","poName":"PO-0000013098","recordTypeId":"0126A000000isgxQAA","recordTypeName":"Product TSM","shipDate":"2021-05-09","siteId":"a0e6A0000033X2sQAE","siteName":"2089-3","smId":"a0b7b000002BJEbAAO","smName":"SM-2021-06-0000010335","status":"Shipment Pending","vehicleId":"a0P6A000002QPINUA4","vehicleName":"FordF150","StatusCheck":false,"isUpdated":true}]';
		//String totalPORecord = '[{"driverId":"a0K7b000004o6mEEAQ","driverName":"Sathiyaraj R","oppId":"0064o00000Z80GjAAJ","oppName":"O-006650","plannedShipDate":"3/25/2021","poId":"a0W4o000004qNb5EAE","poName":"PO-0000012659","recordTypeId":"0126A000000BIZPQA4","recordTypeName":"Product","siteId":"a0e6A0000033X2sQAE","siteName":"2089-3","vehicleId":"a0P7b000003SJdqEAG","vehicleName":"ProMaster 1","StatusCheck":false,"isUpdated":true}]';
        String totalPORecord ='[]';
        String totalSORecord = '[{"driverId":"a0K3s00000BpnoqEAB","driverName":"Matthew Vaughan","oppId":"0067b00000HNus3AAD","oppName":"O-007924","plannedShipDate":"2021-06-03","recordTypeId":"0126A000000BI4TQAW","recordTypeName":"Product","siteId":"a0e6A0000033X2sQAE","siteName":"2089-3","shipDate":"2021-05-09","soId":"a0d7b000007fezXAAQ","soName":"SO-0000012298","vehicleId":"a0P3s000007mPxpEAE","vehicleName":"ProMaster 1","StatusCheck":false,"isUpdated":true,"windowEnd":"00:30:00","windowStart":"00:30:00"}]';
        
        
       
        
      /*  List<Sales_Order__c>  soList = [SELECT Id, name, Site__c, Planned_Ship_Date__c, Site__r.Name, Opportunity_Name__r.Name, Site__r.Id, Driver__c, Driver__r.Name, RecordTypeId, RecordType.Name, Vehicle__c,
                                        Vehicle__r.Name,Window_Start__c, Window_End__c,(SELECT Id, Name, Site__c, Site__r.Name, Sales_Order__c, Receiver_Name__r.Name, Metrc_Manifest__c, Driver__c, Driver__r.Name, Vehicle__c, Vehicle__r.Name, Opportunity_Name__r.Name, Status__c, Planned_Ship_Transfer_Date__c, RecordTypeId, RecordType.Name,Receiver_Name__r.DBA__c 
                                         FROM  Shipping_Manifests__r 
                                         WHERE Status__c =:DisplayRSMTSMController.SHIPPING_MANIFEST_STATUS_PENDING) FROM  Sales_Order__c 
                                        WHERE SO_Status__c =:DisplayRSMTSMController.SALES_ORDER_STATUS_APPROVED limit 2];*/
        
       List<Sales_Order__c>  soList1 = [SELECT Id, name, Site__c, Planned_Ship_Date__c, Site__r.Name, Opportunity_Name__r.Name, Site__r.Id, Driver__c, Driver__r.Name, RecordTypeId, RecordType.Name, Vehicle__c,
                                        Vehicle__r.Name,Window_Start__c, Window_End__c FROM  Sales_Order__c 
                                        WHERE SO_Status__c =:DisplayRSMTSMController.SALES_ORDER_STATUS_APPROVED limit 2];
        
        List<Purchase_Order__c>  purchaseOrderList =[select Id, Name, Site__c, Planned_Ship_Transfer_Date__c, Site__r.Name, Opportunity_Name__r.Name,
                                                     Site__r.Id, Driver__c, Driver__r.Name, RecordTypeId, RecordType.Name, Vehicle__c, Vehicle__r.Name
                                                     FROM Purchase_Order__c where PO_Status__c=:DisplayRSMTSMController.PURCHASE_ORDER_STATUS_APPROVED limit 2];
        
        controllerObj.dat = null;
        controllerObj.retreiveTSMRSM(); 
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        DisplayRSMTSMController.displayRSMTSM();
        DisplayRSMTSMController.getRSMTSM(Date.today(),Date.today().addDays(5));
        DisplayRSMTSMController.getActiveDrivers();
        DisplayRSMTSMController.getActiveVechile();
        TestUtilData.skipTrigger = true;
        //DisplayRSMTSMController.updateSMData(totalSMRecord,totalPORecord,totalSORecord );
        DisplayRSMTSMController.rsmRecordWrapper empW = new DisplayRSMTSMController.rsmRecordWrapper();
        empW.driverId = driverO.Id ;
        empW.driverName = driverO.Name;
        empW.vehicleId = vehicle1.Id;
        empw.vehicleName = vehicle1.Name;
        empW.status = DisplayRSMTSMController.SHIPPING_MANIFEST_STATUS_DRAFT;
        empW.siteId = objSO.Site__c;
        empW.siteName = objSO.Site__r.Name;
        empW.soId = objSO.Id;
        empw.soName = objSO.Name;
        empW.smId = sm.Id;
        empw.smName = sm.Name;
        empw.shipDate = objSO.Planned_Ship_Date__c;
        empw.windowEnd = objSO.Window_End__c;
        empw.windowStart = objSO.Window_Start__c;
        empw.oppId= objSO.Opportunity_Name__c;
        empw.oppName = objSO.Opportunity_Name__r.Name;
        empw.metrc = sm.Metrc_Manifest__c;
        empw.recordTypeId = sm.RecordTypeId;
        empw.recordTypeName = sm.RecordType.Name;
        empw.recieverName = sm.Receiver_Name__r.Name;
        
        
        DisplayRSMTSMController.tsmRecordWrapper tsm = new DisplayRSMTSMController.tsmRecordWrapper();
        tsm.driverId = driverO.Id ;
        tsm.driverName = driverO.Name;
        tsm.vehicleId = vehicle1.Id;
        tsm.vehicleName = vehicle1.Name;
        tsm.status = DisplayRSMTSMController.SHIPPING_MANIFEST_STATUS_DRAFT;
        tsm.siteId = objPO.Site__c;
        tsm.siteName = objPO.Site__r.Name;
        tsm.poId = objPO.Id;
        tsm.poName = objPO.Name;
        tsm.smId = sm.Id;
        tsm.smName = sm.Name;
        tsm.shipDate = objPO.Planned_Ship_Transfer_Date__c;
        tsm.oppId= objPO.Opportunity_Name__c;
        tsm.oppName = objPO.Opportunity_Name__r.Name;
        tsm.recordTypeName = sm.RecordType.Name;
        tsm.recordTypeId = sm.RecordTypeId;
        tsm.priority = sm.Priority__c;
       
   }
    static testMethod void testDisplayRSMTSMErrorMsg1(){
         TestUtilData.skipTrigger = true;
        DisplayRSMTSMController controllerObj = new DisplayRSMTSMController();
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
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
        objSO1.Planned_Ship_Date__c = Date.today();
        insert objSO1;
        Id recordTypeId = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
                     
        Purchase_Order__c objPO1 = new Purchase_Order__c();
        objPO1.recordTypeId = recordTypeId;
        objPO1.Site__c = bq.Site__c;
        objPO1.PO_Status__c = 'Approved';
        objPO1.PO_Type__c = 'Buy Quote';
        objPO1.Supplier_Name__c = bq.Supplier_Name__c;
        objPO1.Supplier_License__c = bq.Supplier_License__c;
        objPO1.Distributor_Name__c = bq.Distributor_Name__c;
        objPO1.Distributor_License__c = bq.Distributor_License__c;
        objPO1.Receiver_Name__c = bq.Receiver_Name__c;
        objPO1.Receiver_License__c = bq.Receiver_License__c;
        objPO1.Ownership__c = bq.Ownership__c;
        objPO1.Total_Weight_Fee__c =10;
        insert objPO1;
        
        Drivers__c driverO = new Drivers__c();
        driverO.Name = 'Test Driver1';
        driverO.Driver_License_Number__c = '12311';
        driverO.Expiration_Date__c = System.Today() + 100;
        driverO.State_Issued__c = 'NY';
        insert driverO;
        
        Vehicles__c vehicle1 = new Vehicles__c();
        vehicle1.Name = 'Test Vehicle'; // Same as Inventory Location of Picklist Line
        insert vehicle1;
       	Sales_Order__c objSO =[select id,Site__c, Site__r.Name, Planned_Ship_Date__c,Window_Start__c,Opportunity_Name__c, Opportunity_Name__r.Name, Window_End__c from Sales_Order__c limit 1];
        
        objSO.Planned_Ship_Date__c = date.today();
        objSO.Driver__c = driverO.id;
        objSO.Vehicle__c = vehicle1.id;
        update objSO;
        
        
        Picklist__c objPicklist= TestUtilData.createPicklist(objSO, 'Open', true);
        
        list<Shipping_Manifest__c> lstRSM = new list<Shipping_Manifest__c>();
        
        Shipping_Manifest__c objRSM1 = TestUtilData.createRSM(objPicklist, false);
        objRSM1.Planned_Ship_Transfer_Date__c = objSO.Planned_Ship_Date__c;
        objRSM1.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        objRSM1.Driver__c = driverO.id;
        objRSM1.Vehicle__c = vehicle1.id;
        lstRSM.add(objRSM1);
        
        Shipping_Manifest__c objRSM2 = TestUtilData.createRSM(objPicklist, false);
        objRSM2.Planned_Ship_Transfer_Date__c = objSO.Planned_Ship_Date__c;
        objRSM2.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        //objRSM2.Sales_Order__c = objSO.Id;
        lstRSM.add(objRSM2);
        
        Shipping_Manifest__c objRSM3 = TestUtilData.createRSM(objPicklist, false);
        objRSM3.Planned_Ship_Transfer_Date__c = objSO.Planned_Ship_Date__c;
        objRSM3.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        lstRSM.add(objRSM3);
        insert lstRSM;
        
        
        
        Purchase_Order__c objPO = [Select id, Name, Brand_Quote__c, Opportunity_Name__c, Opportunity_Name__r.Name, Site__c, Site__r.Name, Ownership__c, 
                                   Distributor_Name__c, Distributor_Contact__c, Supplier_Name__c, Supplier_Contact__c,
                                   Receiver_Name__c, Receiver_Contact__c, Planned_Ship_Transfer_Date__c from Purchase_Order__c limit 1];
        
        Shipping_Manifest__c sm = [SELECT Id, Name, Priority__c, Site__c, Site__r.Name, Sales_Order__c, Receiver_Name__r.Name, Metrc_Manifest__c, Driver__c, Driver__r.Name, Vehicle__c, Vehicle__r.Name, Opportunity_Name__r.Name, Status__c, Planned_Ship_Transfer_Date__c, RecordTypeId, RecordType.Name,Receiver_Name__r.DBA__c FROM  Shipping_Manifest__c limit 1];
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();
        gen.writeStartObject();
        gen.writeStringField('smId',sm.id); 
        gen.writeStringField('driverId',sm.Driver__c); 
        gen.writeStringField('driverName',sm.Driver__r.Name);          
        gen.writeStringField('plannedShipDate','6/1/2021');
		gen.writeStringField('vehicleId',sm.Vehicle__c); 
        gen.writeStringField('vehicleName',sm.Vehicle__r.Name);          
        gen.writeStringField('shipDate','2021-06-10');
        gen.writeEndObject();
        gen.writeEndArray();
        String requestjson = gen.getAsString();
        
        String totalSMRecord = requestjson;
        
        	Sales_Order__c objSO2 =[select id,Site__c, Site__r.Name, Driver__c, Driver__r.Name, Vehicle__c, Vehicle__r.Name, Planned_Ship_Date__c,Window_Start__c,Opportunity_Name__c, Opportunity_Name__r.Name, Window_End__c from Sales_Order__c limit 1];
        String totalPORecord ='[]';
        JSONGenerator gen1 = JSON.createGenerator(true);
        gen1.writeStartArray();
        gen1.writeStartObject();
        gen1.writeStringField('soId',objSO2.id); 
        gen1.writeStringField('driverId',sm.Driver__c); 
        gen1.writeStringField('driverName',sm.Driver__r.Name);          
        gen1.writeStringField('plannedShipDate','6/1/2021');
		gen1.writeStringField('vehicleId',sm.Vehicle__c); 
        gen1.writeStringField('vehicleName',sm.Vehicle__r.Name);          
        gen1.writeStringField('shipDate','2021-06-10');
        gen1.writeEndObject();
        gen1.writeEndArray();
        String requestjson1 = gen1.getAsString();
        String totalSORecord = requestjson1;

       List<Sales_Order__c>  soList = [SELECT Id, name, Site__c, Planned_Ship_Date__c, Site__r.Name, Opportunity_Name__r.Name, Site__r.Id, Driver__c, Driver__r.Name, RecordTypeId, RecordType.Name, Vehicle__c,
                                        Vehicle__r.Name,Window_Start__c, Window_End__c FROM  Sales_Order__c 
                                        WHERE SO_Status__c =:DisplayRSMTSMController.SALES_ORDER_STATUS_APPROVED limit 2];
        
        List<Purchase_Order__c>  purchaseOrderList =[select Id, Name, Site__c, Planned_Ship_Transfer_Date__c, Site__r.Name, Opportunity_Name__r.Name,
                                                     Site__r.Id, Driver__c, Driver__r.Name, RecordTypeId, RecordType.Name, Vehicle__c, Vehicle__r.Name
                                                     FROM Purchase_Order__c where PO_Status__c=:DisplayRSMTSMController.PURCHASE_ORDER_STATUS_APPROVED limit 2];
        
        controllerObj.dat = null;
        controllerObj.retreiveTSMRSM(); 
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        DisplayRSMTSMController.displayRSMTSM();
        DisplayRSMTSMController.getRSMTSM(Date.today(),Date.today().addDays(5));
        DisplayRSMTSMController.getActiveDrivers();
        DisplayRSMTSMController.getActiveVechile();
        DisplayRSMTSMController.updateSMData(totalSMRecord,totalPORecord,totalSORecord );
        DisplayRSMTSMController.rsmRecordWrapper empW = new DisplayRSMTSMController.rsmRecordWrapper();
		List<Route_Schedule__c> updateRoute = [SELECT Id,Status__c  FROM Route_Schedule__c  limit 1];
        Route_Schedule__c rs = new Route_Schedule__c();
        rs.Route_Name__c ='test';
        insert rs;
        DisplayRSMTSMController.assignDriverVehicle(rs.id, driverO.id, vehicle1.id);
        DisplayRSMTSMController.getRouteScheduleLineData(rs.id);
        DisplayRSMTSMController.getRouteInfo(rs.id);
        DisplayRSMTSMController.getDataLight(rs.id);
        DisplayRSMTSMController.getRouteScheduleData(system.today());
        string d= string.valueOf(system.today());
        DisplayRSMTSMController.getRouteSchedule(d);
        string st = DisplayRSMTSMController.message;
      //  assignDriverVehicle
        DisplayRSMTSMController.publishRoute(rs.Id);
        empW.driverId = driverO.Id ;
        empW.driverName = driverO.Name;
        empW.vehicleId = vehicle1.Id;
        empw.vehicleName = vehicle1.Name;
        empW.status = DisplayRSMTSMController.SHIPPING_MANIFEST_STATUS_DRAFT;
        empW.siteId = objSO.Site__c;
        empW.siteName = objSO.Site__r.Name;
        empW.soId = objSO.Id;
        empw.soName = objSO.Name;
        empW.smId = sm.Id;
        empw.smName = sm.Name;
        empw.shipDate = objSO.Planned_Ship_Date__c;
        empw.windowEnd = objSO.Window_End__c;
        empw.windowStart = objSO.Window_Start__c;
        empw.oppId= objSO.Opportunity_Name__c;
        empw.oppName = objSO.Opportunity_Name__r.Name;
        empw.metrc = sm.Metrc_Manifest__c;
        empw.recordTypeId = sm.RecordTypeId;
        empw.recordTypeName = sm.RecordType.Name;
        empw.recieverName = sm.Receiver_Name__r.Name;
        
        
        DisplayRSMTSMController.tsmRecordWrapper tsm = new DisplayRSMTSMController.tsmRecordWrapper();
        tsm.driverId = driverO.Id ;
        tsm.driverName = driverO.Name;
        tsm.vehicleId = vehicle1.Id;
        tsm.vehicleName = vehicle1.Name;
        tsm.status = DisplayRSMTSMController.SHIPPING_MANIFEST_STATUS_DRAFT;
        tsm.siteId = objPO.Site__c;
        tsm.siteName = objPO.Site__r.Name;
        tsm.poId = objPO.Id;
        tsm.poName = objPO.Name;
        tsm.smId = sm.Id;
        tsm.smName = sm.Name;
        tsm.shipDate = objPO.Planned_Ship_Transfer_Date__c;
        tsm.oppId= objPO.Opportunity_Name__c;
        tsm.oppName = objPO.Opportunity_Name__r.Name;
        tsm.recordTypeName = sm.RecordType.Name;
        tsm.recordTypeId = sm.RecordTypeId;
        tsm.priority = sm.Priority__c;
        
          String Status;
         Status = DisplayRSMTSMController.SHIPPING_MANIFEST_STRING_PUBLISHED;
          Status = DisplayRSMTSMController.SHIPPING_MANIFEST_RECORDTYPE_CASHCOLLECTION;
          Status = DisplayRSMTSMController.SHIPPING_MANIFEST_STATUS_INTRANSIT;
          Status = DisplayRSMTSMController.SHIPPING_MANIFEST_STATUS_COMPLETE;
          Status = DisplayRSMTSMController.SHIPPING_MANIFEST_STATUS_CANCELLED;
        
          Status = DisplayRSMTSMController.SHIPPING_MANIFEST_STATUS_REJECTED;
        
        
        
   }
            
}