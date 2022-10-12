/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * ShipConfirmControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class ShipConfirmControllerTest{
    
    static PickList__c pickListObj;
    static Drivers__c driverObj;
    static Vehicles__c vehicleObj;
    static List<PickList_Line__c> pickListLines;
    static Sales_Order__c salesOrderObj;
    static List<Sales_Order_Line__c> soLines;
    static List<Inventory_Position__c> invPositions;
    static Shipping_Manifest__c rsmObj;
    static List<Shipping_Manifest_Line__c> rsmLines;
    static List<State_Licenses__c> licenses;
    static List<Inventory_Location__c> invLocations;
    static Bin_Location__c deliveredBinLocation;
    static Rack_Level__c deliveredRackLevel;
    static Rack__c deliveredRack;
    static Inventory_Location__c deliveredLocation;
    
    // Test Validate all required fields of RSM and lines
    static testMethod void testValidateShipConfirm_AllRSMAndLineRequiredFields(){
          Test.startTest();
        // Get data created from setup
        retrieveData();
        
      
        
        //Brand_Quote__c brandQuoteData = [SELECT Id,BQ_Status__c FROM Brand_Quote__c LIMIT 1 ]; 
        
        Sales_Order__c sOrder = [SELECT Id,Name from Sales_Order__c LIMIT 1];
        
        //Sales_Order__c sOrder = [SELECT Id,Name from Sales_Order__c WHERE Brand_Quote__c =: brandQuoteData.Id];
        // Create blank RSM and lines to validate all required fields
        rsmObj = new Shipping_Manifest__c();
        rsmObj.Sales_Order__c = sOrder.Id;
        rsmObj.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        insert rsmObj;
        
        Shipping_Manifest_Line__c rsmLine1 = new Shipping_Manifest_Line__c();
        rsmLine1.Shipping_Manifest__c = rsmObj.Id;
        rsmLine1.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        insert rsmLine1;
        
        
        PageReference pageRef = Page.ShipConfirm;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        ShipConfirmController controllerObj = new ShipConfirmController(stdController);
        pageRef = controllerObj.shipConfirm();
        controllerObj.updateRSMAndLines();
        //controllerObj.redirectToRSM();
        ShipConfirmController.shipConfirmlt(rsmObj.Id);
		controllerObj.checkValidation2();
        List<Account> lstAcc = [SELECT Id,Hold__c from Account LIMIT 10];
        for(Account acc : lstAcc){
        	acc.Hold__c = true;    
        }
        update lstAcc;
        
        List<Sales_Order__c> sOrder2 = [SELECT Id,Account_Hold_Exception__c from Sales_Order__c LIMIT 10];
        for(Sales_Order__c acc : sOrder2){
        	acc.Account_Hold_Exception__c = false;    
        }
        update sOrder2;
        
        
        
        pageRef = controllerObj.shipConfirm();
        controllerObj.updateRSMAndLines();
        ShipConfirmController.shipConfirmlt(rsmObj.Id);
        //ShipConfirmController.shipConfirm(rsmObj.Id);
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        
      	
	Test.stopTest();
        
    }
    
    // Test Validate all License Expiration Date
    static testMethod void testValidateShipConfirm_LicenseExpirationDate1(){
        Test.startTest();
        // Get data created from setup
        retrieveData();
        
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = new Shipping_Manifest__c();
        rsmObj.Planned_Ship_Transfer_Date__c = System.Today() + 5;
        rsmObj.Distributor_Name__c = licenses[0].License_Name__c;
        rsmObj.Supplier_Name__c = licenses[0].License_Name__c;
        rsmObj.Receiver_Name__c = licenses[0].License_Name__c;
        rsmObj.Distributor_License__c = licenses[0].Id;
        rsmObj.Supplier_License__c = licenses[0].Id;
        rsmObj.Receiver_License__c = licenses[0].Id;
        rsmObj.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        insert rsmObj;
        
        Shipping_Manifest_Line__c rsmLine1 = new Shipping_Manifest_Line__c();
        rsmLine1.Shipping_Manifest__c = rsmObj.Id;
        rsmLine1.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        rsmLine1.Shipment_Qty__c = 10;
        rsmLine1.Retail_Wholesale_Price__c = 10;
        insert rsmLine1;
         Invoice__c lstInvoice = new Invoice__c();
        lstInvoice.Ship_Confirmation_Date__c = Date.today();
        lstInvoice.Posted_Date__c = null;
        lstInvoice.AR_Status__c = 'Shipped';
        lstInvoice.Collections_Status__c = 'Pending';
        insert lstInvoice;

        
        PageReference pageRef = Page.ShipConfirm;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        ShipConfirmController controllerObj = new ShipConfirmController(stdController);
        
        pageRef = controllerObj.shipConfirm();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
                ShipConfirmController.shipConfirmlt(rsmObj.Id);
ShipConfirmController.getRsmLines(rsmObj.Id);
        ShipConfirmController.getRsmLinesOLD(rsmObj.Id);
        ShipConfirmController.getShipMan(rsmObj.Id);
        ShipConfirmController.getSmLines(rsmObj.Id, rsmObj.Id, lstInvoice.id);
        controllerObj.redirectToRSM();
      //  ShipConfirmController.updateShipmentConfirm(rsmLines, 'RSM', rsmObj.Id);
        Shipping_Manifest__c sm = [select Id, Distributor_License_Number__c from Shipping_Manifest__c where id =: rsmObj.id];
        system.debug('sm>>>>>>>>>>>>>>>>>>>>>>>'+sm);
       Test.stopTest();
       
    }
    
    // Test Validate all License Expiration Date
    static testMethod void testValidateShipConfirm_LicenseExpirationDate2(){
        Test.startTest();
        // Get data created from setup
        retrieveData();
        
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = new Shipping_Manifest__c();
        rsmObj.Actual_Departure_Date_Time__c = System.Today() + 5;
        rsmObj.Distributor_Name__c = licenses[0].License_Name__c;
        rsmObj.Supplier_Name__c = licenses[0].License_Name__c;
        rsmObj.Receiver_Name__c = licenses[0].License_Name__c;
        rsmObj.Distributor_License__c = licenses[0].Id;
        rsmObj.Supplier_License__c = licenses[0].Id;
        rsmObj.Receiver_License__c = licenses[0].Id;
        rsmObj.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        insert rsmObj;
        
        Shipping_Manifest_Line__c rsmLine1 = new Shipping_Manifest_Line__c();
        rsmLine1.Shipping_Manifest__c = rsmObj.Id;
        rsmLine1.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        insert rsmLine1;
        
        PageReference pageRef = Page.ShipConfirm;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        ShipConfirmController controllerObj = new ShipConfirmController(stdController);
        
        pageRef = controllerObj.shipConfirm();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
                ShipConfirmController.shipConfirmlt(rsmObj.Id);

       Test.stopTest();
     
    }
    
    // Test Validate all License status
    static testMethod void testValidateShipConfirm_CancelledLicense(){
     Test.startTest();   
        // Get data created from setup
        retrieveData();
     
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = new Shipping_Manifest__c();
        rsmObj.Planned_Ship_Transfer_Date__c = System.Today();
        rsmObj.Distributor_Name__c = licenses[0].License_Name__c;
        rsmObj.Supplier_Name__c = licenses[0].License_Name__c;
        rsmObj.Receiver_Name__c = licenses[0].License_Name__c;
        rsmObj.Distributor_License__c = licenses[0].Id;
        rsmObj.Supplier_License__c = licenses[0].Id;
        rsmObj.Receiver_License__c = licenses[0].Id;
        rsmObj.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        insert rsmObj;
        
        Shipping_Manifest_Line__c rsmLine1 = new Shipping_Manifest_Line__c();
        rsmLine1.Shipping_Manifest__c = rsmObj.Id;
        rsmLine1.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        rsmLine1.Shipment_Qty__c = 10;
        rsmLine1.Retail_Wholesale_Price__c = 10;
        insert rsmLine1;
        
        PageReference pageRef = Page.ShipConfirm;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        ShipConfirmController controllerObj = new ShipConfirmController(stdController);
        
        pageRef = controllerObj.shipConfirm();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
                ShipConfirmController.shipConfirmlt(rsmObj.Id);

        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        test.stopTest();
      
    }
    
    // Test Validate already RSM shipment complete
    static testMethod void testValidateShipConfirm_AlreadyShipmentComplete(){
        Test.startTest();
        // Get data created from setup
        retrieveData();
        
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = new Shipping_Manifest__c();
        rsmObj.Status__c = ShipConfirmController.RSM_STATUS_SHIPMENT_COMPLETE;
        rsmObj.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        insert rsmObj;
        
        PageReference pageRef = Page.ShipConfirm;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        ShipConfirmController controllerObj = new ShipConfirmController(stdController);
        
        pageRef = controllerObj.shipConfirm();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
                ShipConfirmController.shipConfirmlt(rsmObj.Id);

      Test.stopTest();
      
    }
    
    // Test pass all validations and update RSM status, ship confirmation Date and RSM line Shipment Qty
    static testMethod void testPassAllValidation_UpdateRSMAndLine(){
           Test.startTest();
        // Get data created from setup
        retrieveData();
        
     
        
        // Update SO lines in Inventory positions
        for(Integer i=0; i<invPositions.size(); i++){
            invPositions[i].Sales_Order_Line__c = soLines[i].Id;
            invPositions[i].Qty_Allocated__c = 10;
        }
        update invPositions;
        
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        
        // Create Driver
        driverObj = TestUtilData.createDriver(true);
        
        // Create Vehicle
        vehicleObj = TestUtilData.createVehicle(false);
        vehicleObj.Name = 'Receiving Inspection'; // Same as Inventory Location of Picklist Line
        insert vehicleObj;
        
        pickListObj = new PickList__c();
        pickListObj = [Select Sales_Order__r.Brand_Quote__c,
                       Sales_Order__r.Customer_PO_or_Quote__c,
                       Sales_Order__r.Distributor_Contact__c,
                       Sales_Order__r.Distributor_License__c,
                       Sales_Order__r.Distributor_Name__c,
                       Sales_Order__r.Opportunity_Name__c,
                       Sales_Order__r.Payment_Terms__c,
                       Sales_Order__r.Planned_Ship_Date__c,
                       Sales_Order__r.Receiver_Contact__c,
                       Sales_Order__r.Receiver_License__c,
                       Sales_Order__r.Receiver_Name__c,
                       Sales_Order__r.Sample_Order__c,
                       Sales_Order__r.Shipping_Method__c,
                       Sales_Order__r.Shipping_Terms__c,
                       Sales_Order__r.Supplier_Contact__c,
                       Sales_Order__r.Supplier_License__c,
                       Sales_Order__r.Supplier_Name__c,
                       Site__c,
                       Status__c
                From Picklist__c];
        
        // Update picklist status as QA ConfirmationCallback
        pickListObj.Status__c = PickListSupport.STATUS_QA_CONFIRM;
        update pickListObj;
        
        picklistLines = new List<PickList_Line__c>();
        picklistLines = [Select Product_Name__c,
                               Sales_Order_Line__r.Product_Name__c,
                               Sales_Order_Line__r.Product_Title__c,
                               Sales_Order_Line__r.Qty_Allocated__c,
                               Sales_Order_Line__r.Retail_Wholesale_Price__c,
                               Sales_Order_Line__r.UID__c,
                               Inventory_Location__c
                        From Picklist_Line__c];
        
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Driver__c = driverObj.Id;
        rsmObj.Vehicle__c = vehicleObj.Id;
        rsmObj.Status__c = RSMSupport.STATUS_IN_TRANSIT;
        rsmObj.Invoice__c = [Select Id From Invoice__c LIMIT 1].Id;
        rsmObj.Sales_Order__c = salesOrderObj.Id;
        insert rsmObj;
        
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj.Id, true);
        List<Shipping_Manifest_Line__c> rsmLinesTwo = new List<Shipping_Manifest_Line__c>();
        rsmLinesTwo.add(rsmLineObj);
        
        string deliveryName = Label.Default_Inventory_Location;
        
        PageReference pageRef = Page.ShipConfirm;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        ShipConfirmController controllerObj = new ShipConfirmController(stdController);
        
        pageRef = controllerObj.shipConfirm();
        ShipConfirmController.shipConfirmlt(rsmObj.Id);
      //  ShipConfirmController.setInvPositionToDelivered(rsmLinesTwo,deliveryName);
        
        RSMSupport.updateInvPositionsAndSOLines(rsmLinesTwo, true);

        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match'); 
        Test.stopTest();
     
    }
    
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
      
        TestUtilData.createTestData();
          TestUtilData.skipTrigger = true;
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        invPositions = [Select Sales_Order_Line__c,
                               Sales_Order_Line__r.Product_Name__c,
                               Inventory_Location__r.Name
                               From Inventory_Position__c];
                               
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Site__c from Sales_Order__c];
      // ShipConfirmController.updateBqAndOrderLineItems(salesOrderObj.i)
        soLines = new List<Sales_Order_Line__c>();
        soLines = [Select Id from Sales_Order_Line__c];
        
        licenses = new List<State_Licenses__c>();
        licenses = [Select License_Name__c, License_Status__c, License_Expiration_Date__c From State_Licenses__c];
        
        // Create Inventory Location, Rack, Rack Level and Bin Location with Delivered name
        List<Inventory_Location__c> invLocations = [Select Name, Site_Name__c from Inventory_Location__c];
        deliveredLocation = invLocations[0].clone(false, true);
        deliveredLocation.Name = ShipConfirmController.DELIVERED;
        insert deliveredLocation;
        
        List<Rack__c> racks = [Select Name, Inventory_Location__c from Rack__c];
        deliveredRack = racks[0].clone(false, true);
        deliveredRack.Name = ShipConfirmController.DELIVERED;
        deliveredRack.Inventory_Location__c = deliveredLocation.Id;
        insert deliveredRack;
        
        List<Rack_Level__c> rackLevels = [Select Name, Rack__c from Rack_Level__c];
        deliveredRackLevel = rackLevels[0].clone(false, true);
        deliveredRackLevel.Name = ShipConfirmController.DELIVERED;
        deliveredRackLevel.Rack__c = deliveredRack.Id;
        insert deliveredRackLevel;
        
        List<Bin_Location__c> binLocations = [Select Name, Rack_Level__c from Bin_Location__c];
        deliveredBinLocation = binLocations[0].clone(false, true);
        deliveredBinLocation.Name = ShipConfirmController.DELIVERED;
        deliveredBinLocation.Rack_Level__c = deliveredRackLevel.Id;
        insert deliveredBinLocation;
        
        string status ;
        status = ShipConfirmController.ERR_MSG_ASSIGN_DRIVER_AND_VEHICLE;
        status = ShipConfirmController.ERR_MSG_SHIPPING_METHOD;   
        status = ShipConfirmController.ERR_MSG_PAYMENT_TERMS;   
        status = ShipConfirmController.ERR_MSG_DISTI_LICENSE_ACTIVE;   
        status = ShipConfirmController.ERR_MSG_DISTI_LICENSE_ALREADY_EXIPIRED;   
        status = ShipConfirmController.ERR_MSG_REJECT;   
        status = ShipConfirmController.ERR_MSG_CANCELLED; 
        status = ShipConfirmController.ERR_MSG_ASSIGN_DRIVER_AND_VEHICLE;
        status = ShipConfirmController.ERR_MSG_SHIPPING_METHOD;
        status = ShipConfirmController.ERR_MSG_PAYMENT_TERMS;
        status = ShipConfirmController.ERR_MSG_DISTI_LICENSE_ACTIVE;
        status = ShipConfirmController.ERR_MSG_DISTI_LICENSE_ALREADY_EXIPIRED;
        status = ShipConfirmController.SHIPPING_MANIFEST_EXCEPTION_ERROR_UPDATING_RSM_TSM;
         status = ShipConfirmController.SHIPPING_MANIFEST_STATUS_RECEIVED;
         status = ShipConfirmController.SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION;
         status = ShipConfirmController.SHIPPING_MANIFEST_STATUS_REJECTED;
         status = ShipConfirmController.BRAND_QUOTE_STATUS_REJECTED;
         status = ShipConfirmController.ORDERCANCELLED_CUSTOMER;
         status = ShipConfirmController.SHIPPING_MANIFEST_RECORDTYPE_TRANSFER;
         status = ShipConfirmController.SHIPPING_MANIFEST_RECORDTYPE_LAB;
         status = ShipConfirmController.SHIPPING_MANIFEST_RECORDTYPE_TRANSFFERED;
         status = ShipConfirmController.SHIPPING_MANIFEST_RECORDTYPE_TEST_SAMPLED;
          status = ShipConfirmController.SHIPPING_MANIFEST_RECORDTYPE_DELIVERED;
        status = ShipConfirmController.SALES_ORDER_STATUS_CANCELLED_BY_FILIGREEN;
         status = ShipConfirmController.SO_STATUS_DRAFT;
          status = ShipConfirmController.ORDER_STATUS_SHIPPED;
       status=  ShipConfirmController.PURCHASE_ORDER_STATUS_REJECTED;
    }
}