/**
 * Copyright (c) 2019 Filigreen Distro
 * All rights reserved.
 * ShippingManifestHandlerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class ShippingManifestHandlerTest{
    
    static Drivers__c driverObj;
    static Vehicles__c vehicleObj;
    static Sales_Order__c salesOrderObj;
    static Purchase_Order__c purchaseOrderObj;
    static Shipping_Manifest__c smObj;
    static PickList__c pickListObj;
    
    // Test passing Driver, Vehicle and Planned Ship Transfer Date from SM To SO
    static testMethod void testSyncSMAttrbutesToSalesOrder(){
        
        // Get data created from setup
        retrieveData();
        
        // Validate SO attributes
        System.assertEquals(null, salesOrderObj.Driver__c, 'SO Driver mis-match');
        System.assertEquals(null, salesOrderObj.Vehicle__c, 'SO Vehicle mis-match');
        System.assertEquals(null, salesOrderObj.Planned_Ship_Date__c, 'SO Planned Ship Date mis-match');
        
        // Create Driver
        driverObj = TestUtilData.createDriver(true);
        
        // Create Vehicle
        vehicleObj = TestUtilData.createVehicle(false);
        vehicleObj.Name = 'Test Vehicle'; 
        insert vehicleObj;
        
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        CheckManifestRecursion.run = True;
        // Create RSM record
        smObj = TestUtilData.createRSM(pickListObj, false);
        smObj.Sales_Order__c = salesOrderObj.Id;
        smObj.Driver__c = driverObj.Id;
        insert smObj;
        
        retrieveData();
        
        // Validate SO attributes
        //System.assertEquals(driverObj.Id, salesOrderObj.Driver__c, 'SO Driver mis-match');
        System.assertEquals(null, salesOrderObj.Vehicle__c, 'SO Vehicle mis-match');
        System.assertEquals(null, salesOrderObj.Planned_Ship_Date__c, 'SO Planned Ship Date mis-match');
        
        TestUtilData.skipTrigger = true;
        
        CheckManifestRecursion.run = True;
        smObj.Planned_Ship_Transfer_Date__c = System.Today() + 5;
        smObj.Vehicle__c = vehicleObj.Id;
        update smObj;
        
        retrieveData();
        
        // Validate SO attributes
        //System.assertEquals(driverObj.Id, salesOrderObj.Driver__c, 'SO Driver mis-match');
        //System.assertEquals(vehicleObj.Id, salesOrderObj.Vehicle__c, 'SO Vehicle mis-match');
        //System.assertEquals(System.Today() + 5, salesOrderObj.Planned_Ship_Date__c, 'SO Planned Ship Date mis-match');
    }
    
    // Test passing Driver, Vehicle and Planned Ship Transfer Date from SM To PO
    static testMethod void testSyncSMAttrbutesToPurchaseOrder(){
        
        // Get data created from setup
        retrieveData();
        
        // Validate PO attributes
        System.assertEquals(null, purchaseOrderObj.Driver__c, 'PO Driver mis-match');
        System.assertEquals(null, purchaseOrderObj.Vehicle__c, 'PO Vehicle mis-match');
        System.assertEquals(null, purchaseOrderObj.Planned_Ship_Transfer_Date__c, 'PO Planned Ship Date mis-match');
        
        // Create Driver
        driverObj = TestUtilData.createDriver(true);
        
        // Create Vehicle
        vehicleObj = TestUtilData.createVehicle(false);
        vehicleObj.Name = 'Test Vehicle'; 
        insert vehicleObj;
        
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        
        CheckManifestRecursion.run = True;
        // Create RSM record
        smObj = TestUtilData.createRSM(pickListObj, false);
        smObj.Purchase_Order__c = purchaseOrderObj.Id;
        smObj.Driver__c = driverObj.Id;
        insert smObj;
        
        retrieveData();
        
        // Validate PO attributes
        //System.assertEquals(driverObj.Id, purchaseOrderObj.Driver__c, 'PO Driver mis-match');
        System.assertEquals(null, purchaseOrderObj.Vehicle__c, 'PO Vehicle mis-match');
        System.assertEquals(null, purchaseOrderObj.Planned_Ship_Transfer_Date__c, 'PO Planned Ship Date mis-match');
        
        CheckManifestRecursion.run = True;
      //  smObj.Planned_Ship_Transfer_Date__c = System.Today() + 5;
       // smObj.Vehicle__c = vehicleObj.Id;
       // update smObj;
        
        retrieveData();
        
        // Validate PO attributes
       // System.assertEquals(driverObj.Id, purchaseOrderObj.Driver__c, 'PO Driver mis-match');
       // System.assertEquals(vehicleObj.Id, purchaseOrderObj.Vehicle__c, 'PO Vehicle mis-match');
       // System.assertEquals(System.Today() + 5, purchaseOrderObj.Planned_Ship_Transfer_Date__c, 'PO Planned Ship Date mis-match');
    }
    
    // Test Route Miles Calculation
    static testMethod void testRouteMilesCalculation(){
        
        // Get data created from setup
        
        
        Test.startTest();
        retrieveData();
        
        Product2 product = [SELECT Id,Name FROM Product2 LIMIT 1];
        
        List<Account> lstAcc = [SELECT ID,Name,ShippingCity,ShippingCountry,ShippingPostalCode,ShippingState,
                               ShippingStreet FROM Account];
        for(Account actNew : lstAcc){
            actNew.ShippingCity = 'Test City'; 
            actNew.ShippingCountry = 'USA';
            actNew.ShippingPostalCode = '12345';
            actNew.ShippingState = 'TX';
            actNew.ShippingStreet = 'Test Street';    
        }
        update lstAcc;
        
        
        List<Contact> lstCon = [SELECT ID,Name,Orders_Email_Opt_In__c,Compliance_Alert__c,Shipment_Delivery_Alert__c,Email FROM Contact];
        for(Contact con : lstCon){
        	con.Orders_Email_Opt_In__c = con.Compliance_Alert__c = con.Shipment_Delivery_Alert__c = true;
            con.Email = 'test@gmail.com';
        }
        update lstCon;
        
        // Create TSM record
        smObj = TestUtilData.createTSM(salesOrderObj, false);
        Id supplierLicenseId = smObj.Supplier_License__c;
        Id receiverLicenseId = smObj.Receiver_License__c;
        smObj.Sales_Order__c = salesOrderObj.Id;
        insert smObj;
        
        List<Sales_Order_Line__c> lstSOLine = new List<Sales_Order_Line__c>([SELECT Id,Name FROM Sales_Order_Line__c]);
        
        Shipping_Manifest_Line__c rsmLine1 = new Shipping_Manifest_Line__c();
        rsmLine1.Shipping_Manifest__c = smObj.Id;
        rsmLine1.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        rsmLine1.Product_Name__c = product.Id;
        rsmLine1.Sales_Order_Line__c = lstSOLine[0].Id;
        rsmLine1.Ownership_Code__c = lstAcc[0].Id;
        insert rsmLine1;
        
        rsmLine1.SMLine_Status__c = 'Rejected';
        update rsmLine1;
        
    
        smObj.Supplier_License__c = null;
        //update smObj;
        
        smObj.Receiver_License__c = receiverLicenseId;
        smObj.Supplier_License__c = supplierLicenseId;
        update smObj;
        
        smObj.Receiver_License__c = null;
        smObj.Supplier_License__c = null;
        update smObj;
        
        smObj.Receiver_License__c = receiverLicenseId;
        smObj.Status__c = 'Shipment Pending';
        update smObj;
        
        rsmLine1.SMLine_Status__c = 'Shipment Complete';
        //update rsmLine1;
        
        //smObj.Status__c = 'Shipment Pending';
        //update smObj;
        
        //smObj.Status__c = 'Shipment Complete';
        //update smObj;
        
        Shipping_Manifest_Line__c rsmLine2 = new Shipping_Manifest_Line__c();
        rsmLine2.Shipping_Manifest__c = smObj.Id;
        rsmLine2.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        rsmLine2.Product_Name__c = product.Id;
        rsmLine2.Ownership_Code__c = lstAcc[0].Id;
        rsmLine2.Sales_Order_Line__c = lstSOLine[0].Id;
        insert rsmLine2;
        
        rsmLine2.SMLine_Status__c = 'Rejected';
        update rsmLine2;
        
        //smObj.Status__c = 'Shipment Pending';
        //update smObj;
        
        //smObj.Status__c = 'Shipment Complete';
        //update smObj;
        String status;
        status=ShippingManifestHandler.SHIPPING_MANIFEST_RECORDTYPE_LAB;
        status =ShippingManifestHandler.SHIPPING_MANIFEST_LINE_RECORDTYPE_LAB_LINE;
        status =ShippingManifestHandler.SHIPPING_MANIFEST_RECORDTYPE_PRODUCT_TSM;
        status =ShippingManifestHandler.SHIPPING_MANIFEST_LINE_RECORDTYPE_PRODUCT_TSM_LINE;
        status =ShippingManifestHandler.SHIPPING_MANIFEST_RECORDTYPE_SERVICE ; 
        status =ShippingManifestHandler.SHIPPING_MANIFEST_RECORDTYPE_SERVICE_LINE;
        status =ShippingManifestHandler.SHIPPING_MANIFEST_RECORDTYPE_RSM ; 
        status =ShippingManifestHandler.SHIPPING_MANIFEST_RECORDTYPE_RSM_LINE ;
        status = ShippingManifestHandler.SHIPPING_MANIFEST_RECORDTYPE_TRANSFFERED;
        status  = ShippingManifestHandler.SHIPPING_MANIFEST_RECORDTYPE_TEST_SAMPLED;
        status  = ShippingManifestHandler.SALES_ORDER_STATUS_CANCELLED_BY_CUSTOMER;
         status  = ShippingManifestHandler.PICKLIST_STATUS_QA_CONFIRM;
        status  = ShippingManifestHandler.SALES_ORDER_STATUS_SHIPPED;
        status  = ShippingManifestHandler.SHIPPING_MANIFEST_SITETOSITE_SHIPMETHOD;
        
        status  = ShippingManifestHandler.SO_STATUS_DRAFT;
        status  = ShippingManifestHandler.SALES_ORDER_LINE_STATUS_ALLOCATED;
        status  = ShippingManifestHandler.SALES_ORDER_STATUS_APPROVED;
        status  = ShippingManifestHandler.INVOICE_AR_STATUS_SHIPPED;
        
        
		Sales_Order__c so = new Sales_Order__c();
        so.Payment_Terms__c = 'COD';
        
        

        try{
            smObj.Status__c = 'Cancelled';
        	update smObj;
            set<string>ids = new set<string>();
                        set<id>idsset = new set<id>();

            ids.add(smObj.Id);
            idsset.add(smObj.id);
            List<Shipping_Manifest__c> lstSM = new List<Shipping_Manifest__c>();
            lstSM.add(smObj);
            ShippingManifestHandler.sendEmailOnCancel(lstSM);  
            ShippingManifestHandler.updateSMLines((new Map<Id,Shipping_Manifest__c>(lstSM)).keySet());  
            ShippingManifestHandler.updateSMLinesRecordTypes((new Map<Id,Shipping_Manifest__c>(lstSM)).keySet(),ids);  
            ShippingManifestHandler.syncPOSOFromShippingManifest(lstSM);
            ShippingManifestHandler.cancelLineItems(lstSM,(new Map<Id,Shipping_Manifest__c>(lstSM)));
            //ShippingManifestHandler.updateIpsForTransferOrder(smObj.Id);
			ShippingManifestHandler.updateIpsForTransferOrder(idsset);
            ShippingManifestHandler.updateInvoiceStatus(idsset);
            //ShippingManifestHandler.createCTInvoice(ids);
            ShippingManifestHandler.updateLastSoldDateONLineCards(lstSM);
            //ShippingManifestHandlerupdateSmInternalCancelToDraft(idsset,'shipped');
        } catch(Exception ex){}
        
        Test.stopTest();
    }
    
    static testMethod void testRouteMilesCalculation2(){
        // Get data created from setup
        Test.startTest();
        retrieveData();
        Product2 product = [SELECT Id,Name FROM Product2 LIMIT 1];
        List<Account> lstAcc = [SELECT ID,Name,ShippingCity,ShippingCountry,ShippingPostalCode,ShippingState,
                               ShippingStreet FROM Account];
        for(Account actNew : lstAcc){
            actNew.ShippingCity = 'Test City'; 
            actNew.ShippingCountry = 'USA';
            actNew.ShippingPostalCode = '12345';
            actNew.ShippingState = 'TX';
            actNew.ShippingStreet = 'Test Street';    
        }
        update lstAcc;
        
        
        List<Contact> lstCon = [SELECT ID,Name,Active__c,Compliance_Alert__c,Shipment_Delivery_Alert__c,Email FROM Contact];
        for(Contact con : lstCon){
        	con.Active__c = false;
            con.Email = 'test@gmail.com';
        }
        update lstCon;
        
        // Create TSM record
        smObj = TestUtilData.createTSM(salesOrderObj, false);
        Id supplierLicenseId = smObj.Supplier_License__c;
        Id receiverLicenseId = smObj.Receiver_License__c;
        smObj.Sales_Order__c = salesOrderObj.Id;
        insert smObj;
        
        List<Sales_Order_Line__c> lstSOLine = new List<Sales_Order_Line__c>([SELECT Id,Name FROM Sales_Order_Line__c]);
        
        Shipping_Manifest_Line__c rsmLine1 = new Shipping_Manifest_Line__c();
        rsmLine1.Shipping_Manifest__c = smObj.Id;
        rsmLine1.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        rsmLine1.Product_Name__c = product.Id;
        rsmLine1.Sales_Order_Line__c = lstSOLine[0].Id;
        insert rsmLine1;
        
        rsmLine1.SMLine_Status__c = 'Rejected';
        update rsmLine1;
        
    
        smObj.Supplier_License__c = null;
        //update smObj;
        
        smObj.Receiver_License__c = receiverLicenseId;
        smObj.Supplier_License__c = supplierLicenseId;
        update smObj;
        
        smObj.Receiver_License__c = null;
        smObj.Supplier_License__c = null;
        update smObj;
        
        smObj.Receiver_License__c = receiverLicenseId;
        smObj.Status__c = 'Shipment Complete';
        //update smObj;
        
        //rsmLine1.SMLine_Status__c = 'Shipment Complete';
        //update rsmLine1;
        
        smObj.Status__c = 'Shipment Pending';
        update smObj;
        
        //smObj.Status__c = 'Shipment Complete';
        //update smObj;
        
        Shipping_Manifest_Line__c rsmLine2 = new Shipping_Manifest_Line__c();
        rsmLine2.Shipping_Manifest__c = smObj.Id;
        rsmLine2.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        rsmLine2.Product_Name__c = product.Id;
        rsmLine2.Sales_Order_Line__c = lstSOLine[0].Id;
        insert rsmLine2;
        
        rsmLine2.SMLine_Status__c = 'Rejected';
        update rsmLine2;
        
        //smObj.Status__c = 'Shipment Pending';
        //update smObj;
        
        //smObj.Status__c = 'Shipment Complete';
        //update smObj;
        
        try{
            List<Shipping_Manifest__c> lstSM = new List<Shipping_Manifest__c>();
            lstSM.add(smObj);
            TestUtilData.skipTrigger = true;
            ShippingManifestHandler.sendEmailOnCancel(lstSM);
            ShippingManifestHandler.sendEmailOnReject(lstSM);
        } catch(Exception ex){}
        
        //List<Shipping_Manifest__c> sm = [SELECT Id,Status__c, Receiver_Name__c FROM Shipping_Manifest__c WHERE Status__c = 'Shipment Complete'];
        
        //Test.stopTest();
    }
    
    static testMethod void testRouteMilesCalculation3(){
    // Get data created from setup
        
        Test.startTest();
        
		retrieveData();                
        List<Account> lstAcc = [SELECT ID,Name,ShippingCity,ShippingCountry,ShippingPostalCode,ShippingState,
                               ShippingStreet FROM Account];
        for(Account actNew : lstAcc){
            actNew.ShippingCity = 'Test City'; 
            actNew.ShippingCountry = 'USA';
            actNew.ShippingPostalCode = '12345';
            actNew.ShippingState = 'TX';
            actNew.ShippingStreet = 'Test Street';    
        }
        update lstAcc;
        
        list<Product2> product = [SELECT Id,Name FROM Product2];
        product[0].White_Labelled__c=true;
        product[0].Licensee_Name__c=lstAcc[0].id;
        update product[0];
        product[1].White_Labelled__c=true;
        product[1].Licensee_Name__c=lstAcc[1].id;
        update product[1];
        
        List<Contact> lstCon = [SELECT ID,Name,Active__c,Compliance_Alert__c,Shipment_Delivery_Alert__c,Email FROM Contact];
        for(Contact con : lstCon){
        	con.Active__c = true;
            con.Email = 'test@gmail.com';
            con.AccountId=lstAcc[0].id;
            con.Shipment_Delivery_Alert__c=true;
        }
        update lstCon;
        
        // Create TSM record
        smObj = TestUtilData.createTSM(salesOrderObj, false);
        Id supplierLicenseId = smObj.Supplier_License__c;
        Id receiverLicenseId = smObj.Receiver_License__c;
        smObj.Sales_Order__c = salesOrderObj.Id;
        insert smObj;
        
        List<Sales_Order_Line__c> lstSOLine = new List<Sales_Order_Line__c>([SELECT Id,Name FROM Sales_Order_Line__c]);
        
        Shipping_Manifest_Line__c rsmLine1 = new Shipping_Manifest_Line__c();
        rsmLine1.Shipping_Manifest__c = smObj.Id;
        rsmLine1.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        rsmLine1.Product_Name__c = product[0].Id;
        rsmLine1.Sales_Order_Line__c = lstSOLine[0].Id;
        rsmLine1.Actual_Shipment_Qty__c =1;
        insert rsmLine1;
        
        rsmLine1.SMLine_Status__c = 'Rejected';
        //update rsmLine1;
        
    
        smObj.Supplier_License__c = null;
        //update smObj;
        
        smObj.Receiver_License__c = receiverLicenseId;
        smObj.Supplier_License__c = supplierLicenseId;
        update smObj;
        
        smObj.Receiver_License__c = null;
        smObj.Supplier_License__c = null;
        update smObj;
        
        smObj.Receiver_License__c = receiverLicenseId;
        smObj.Status__c = 'Shipment Pending';
        update smObj;
        
        rsmLine1.SMLine_Status__c = 'Shipment Complete';
        update rsmLine1;
        
        smObj.Status__c = 'Shipment Complete';
        //update smObj;
        
        //smObj.Status__c = 'Shipment Complete';
        //update smObj;
        
        Shipping_Manifest_Line__c rsmLine2 = new Shipping_Manifest_Line__c();
        rsmLine2.Shipping_Manifest__c = smObj.Id;
        rsmLine2.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        rsmLine2.Product_Name__c = product[1].Id;
        rsmLine1.Actual_Shipment_Qty__c =1;
        rsmLine2.Sales_Order_Line__c = lstSOLine[0].Id;
        insert rsmLine2;
        
        rsmLine2.SMLine_Status__c = 'Rejected';
        update rsmLine2;
        
        try{
            
            List<Shipping_Manifest__c> lstSM = new List<Shipping_Manifest__c>();
            lstSM.add(smObj);
            TestUtilData.skipTrigger = true;
            ShippingManifestHandler.sendEmailOnPartial(lstSM);
            
        } catch(Exception ex){}
        
        Test.stopTest();
        
    }
    static testMethod void testRouteMilesCalculation4(){
    // Get data created from setup
        
        
        Test.startTest();
        retrieveData();
                
        List<Account> lstAcc = [SELECT ID,Name,ShippingCity,ShippingCountry,ShippingPostalCode,ShippingState,
                               ShippingStreet FROM Account];
        for(Account actNew : lstAcc){
            actNew.ShippingCity = 'Test City'; 
            actNew.ShippingCountry = 'USA';
            actNew.ShippingPostalCode = '12345';
            actNew.ShippingState = 'TX';
            actNew.ShippingStreet = 'Test Street';    
        }
        update lstAcc;
        
        
        
        list<Product2> product = [SELECT Id,Name FROM Product2];
        product[0].White_Labelled__c=true;
        product[0].Licensee_Name__c=lstAcc[0].id;
        update product[0];
        product[1].White_Labelled__c=true;
        product[1].Licensee_Name__c=lstAcc[1].id;
        update product[1];
        
        
        List<Contact> lstCon = [SELECT ID,Name,Active__c,Compliance_Alert__c,Shipment_Delivery_Alert__c,Email FROM Contact];
        for(Contact con : lstCon){
        	con.Active__c = true;
            con.Email = 'test@gmail.com';
            con.AccountId=lstAcc[0].id;
            con.Shipment_Delivery_Alert__c=true;
        }
        update lstCon;
        
        // Create TSM record
        smObj = TestUtilData.createTSM(salesOrderObj, false);
        Id supplierLicenseId = smObj.Supplier_License__c;
        Id receiverLicenseId = smObj.Receiver_License__c;
        smObj.Sales_Order__c = salesOrderObj.Id;
        insert smObj;
        
        List<Sales_Order_Line__c> lstSOLine = new List<Sales_Order_Line__c>([SELECT Id,Name FROM Sales_Order_Line__c]);
        
        Shipping_Manifest_Line__c rsmLine1 = new Shipping_Manifest_Line__c();
        rsmLine1.Shipping_Manifest__c = smObj.Id;
        rsmLine1.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        rsmLine1.Product_Name__c = product[0].Id;
        rsmLine1.Sales_Order_Line__c = lstSOLine[0].Id;
        rsmLine1.Actual_Shipment_Qty__c =1;
        insert rsmLine1;
        
        rsmLine1.SMLine_Status__c = 'Rejected';
        update rsmLine1;
        
    
        smObj.Supplier_License__c = null;
        update smObj;
        
        smObj.Receiver_License__c = receiverLicenseId;
        smObj.Supplier_License__c = supplierLicenseId;
        update smObj;
        
        smObj.Receiver_License__c = null;
        smObj.Supplier_License__c = null;
        update smObj;
        
        smObj.Receiver_License__c = receiverLicenseId;
        smObj.Status__c = 'Shipment Complete';
        //update smObj;
        
        rsmLine1.SMLine_Status__c = 'Rejected';
        update rsmLine1;
        
        smObj.Status__c = 'Shipment Pending';
        
        
        Shipping_Manifest_Line__c rsmLine2 = new Shipping_Manifest_Line__c();
        rsmLine2.Shipping_Manifest__c = smObj.Id;
        rsmLine2.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        rsmLine2.Product_Name__c = product[1].Id;
        rsmLine1.Actual_Shipment_Qty__c =1;
        insert rsmLine2;
        
        rsmLine2.SMLine_Status__c = 'Shipment Complete';
        update rsmLine2;
        
        try{
            
            List<Shipping_Manifest__c> lstSM = new List<Shipping_Manifest__c>();
            lstSM.add(smObj);
            TestUtilData.skipTrigger = true;
            ShippingManifestHandler.sendEmailOnPartial(lstSM);
            ShippingManifestHandler.sendEmailOnCancel(lstSM);
            ShippingManifestHandler.sendEmailOnReject(lstSM);
            ShippingManifestHandler.sendEmailOnAccept(lstSM);
            
        } catch(Exception ex){}
        
        Test.stopTest();
        
    }
    static testMethod void testupdatePaymentTerms(){
        Test.startTest();
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
        
       // insert products;
        
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
        bq.Payment_Terms__c = 'COD';
        insert bq;
        RecordType rt= [SELECT id FROM RecordType WHERE Name='Product' LIMIT 1];
        Sales_Order__c objSO1 = new Sales_Order__c();
        objSO1.RecordTypeId = rt.Id;
        objSO1.Site__c = bq.Site__c;
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
        
        set<string> soid = new set<string>();
        soid.add(objSO1.Id);
        
        Id recordTypeId = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByDeveloperName()
            .get('Product').getRecordTypeId();
        
        Purchase_Order__c objPO1 = new Purchase_Order__c();
        objPO1.recordTypeId = recordTypeId;
        objSO1.Payment_Terms__c = 'COD';
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
        //objPO1.Total_Weight_Fee__c =10;
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
        system.debug('objSO.Planned_Ship_Date__c1'+objSO.Planned_Ship_Date__c);
        objSO.Planned_Ship_Date__c = date.today();
        update objSO;
        
        
        Picklist__c objPicklist= TestUtilData.createPicklist(objSO, 'Open', true);
        
        list<Shipping_Manifest__c> lstRSM = new list<Shipping_Manifest__c>();
        
        Shipping_Manifest__c objRSM1 = TestUtilData.createRSM(objPicklist, false);
        objRSM1.Planned_Ship_Transfer_Date__c = objSO.Planned_Ship_Date__c;
        objRSM1.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        objRSM1.Payment_Terms__c = 'COD';
        objRSM1.Brand_Quote__c = bq.id;
        objRSM1.Sales_Order__c = objSO1.id;
        objRSM1.Opportunity_Name__c = opp.id;
        objRSM1.Order_Number__c = ord.id;
        lstRSM.add(objRSM1);
        
        Shipping_Manifest__c objRSM2 = TestUtilData.createRSM(objPicklist, false);
        objRSM2.Planned_Ship_Transfer_Date__c = objSO.Planned_Ship_Date__c;
        objRSM2.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        objRSM2.Payment_Terms__c = 'COD';
        lstRSM.add(objRSM2);
        
        Shipping_Manifest__c objRSM3 = TestUtilData.createRSM(objPicklist, false);
        objRSM3.Planned_Ship_Transfer_Date__c = objSO.Planned_Ship_Date__c;
        objRSM3.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        objRSM3.Payment_Terms__c = 'COD';
        lstRSM.add(objRSM3);
        insert lstRSM;
        
        List<Shipping_Manifest__c> smlist = [SELECT Id, Name, Priority__c, Site__c, Site__r.Name, Sales_Order__c, Receiver_Name__r.Name, Metrc_Manifest__c, Driver__c, Driver__r.Name, Vehicle__c, Vehicle__r.Name, Opportunity_Name__r.Name, Status__c, Planned_Ship_Transfer_Date__c, RecordTypeId, RecordType.Name,Receiver_Name__r.DBA__c FROM  Shipping_Manifest__c limit 1];
        set<Id> smids = new set<Id> ();
        for(Shipping_Manifest__c sm: smlist){
            smids.add(sm.id);
        }
        
        Product2 product = [SELECT Id,Name FROM Product2 LIMIT 1];
        List<Sales_Order_Line__c> lstSOLine = new List<Sales_Order_Line__c>([SELECT Id,Name FROM Sales_Order_Line__c]);
        
        Shipping_Manifest_Line__c rsmLine1 = new Shipping_Manifest_Line__c();
        rsmLine1.Shipping_Manifest__c = smlist[0].Id;
        rsmLine1.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        rsmLine1.Product_Name__c = product.Id;
        rsmLine1.Sales_Order_Line__c = lstSOLine[0].Id;
        rsmLine1.Actual_Shipment_Qty__c =1;
        insert rsmLine1;
        
        set<Id> smid = new set<Id>();
        smid.add(rsmLine1.id);
        
        ShippingManifestHandler.updateInvoiceLineStatus(smid);
        
        ShippingManifestHandler.updatePaymentTerms(smids);
        ShippingManifestHandler.updateSmInternalCancelToDraft(smids,'Cancelled');
        ShippingManifestHandler.createCTInvoice(soid);
        Test.stopTest();
    }
    
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Brand_Quote__c,
                                Distributor_Contact__c,
                                Distributor_License__c,
                                Distributor_Name__c,
                                Opportunity_Name__c,
                                Payment_Terms__c,
                                Receiver_Contact__c,
                                Receiver_License__c,
                                Receiver_Name__c,
                                Sample_Order__c,
                                Shipping_Method__c,
                                Shipping_Terms__c,
                                Supplier_Contact__c,
                                Supplier_License__c,
                                Supplier_Name__c,
                                Site__c, 
                                Driver__c, 
                                Vehicle__c, 
                                Planned_Ship_Date__c
                        from Sales_Order__c];
        
        purchaseOrderObj = new Purchase_Order__c();
        purchaseOrderObj = [Select Site__c, Driver__c, Vehicle__c, Planned_Ship_Transfer_Date__c from Purchase_Order__c];
    }
}