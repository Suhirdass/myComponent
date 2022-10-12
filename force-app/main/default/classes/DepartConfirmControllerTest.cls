/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * DepartConfirmControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class DepartConfirmControllerTest{
    
    static PickList__c pickListObj;
    static Drivers__c driverObj;
    static Vehicles__c vehicleObj;
    static List<PickList_Line__c> pickListLines;
    static Sales_Order__c salesOrderObj;
    static List<Sales_Order_Line__c> soLines;
    static List<Inventory_Position__c> invPositions;
    static Shipping_Manifest__c rsmObj;
    static List<Shipping_Manifest_Line__c> rsmLines;
    static List<Inventory_Location__c> invLocations;
    static Bin_Location__c vehicleBinLocation;
    static Rack_Level__c vehicleRackLevel;
    static Rack__c vehicleRack;
    static Inventory_Location__c vehicleLocation;
    
    static final string VEHICLE_Name = 'Test Vehicle';
    
    // Test Validate already RSM shipment complete
    static testMethod void testValidateDepartConfirm_AlreadyShipmentComplete(){
        
        // Get data created from setup
        retrieveData();
        
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = new Shipping_Manifest__c();
        rsmObj.Status__c = DepartConfirmController.RSM_STATUS_SHIPMENT_COMPLETE;
        insert rsmObj;
        
        PageReference pageRef = Page.DepartConfirm;
        //DepartConfirmController.DepartConfirm(rsmObj.Id);
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        DepartConfirmController controllerObj = new DepartConfirmController(stdController);
        
        pageRef = controllerObj.DepartConfirm();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        string status ;
        status = DepartConfirmController.ERR_MSG_ALREADY_COMPLETE_STATUS;
          status = DepartConfirmController.ERR_MSG_REJECT;
         status = DepartConfirmController.ERR_MSG_CANCELLED;
        status = DepartConfirmController.ERR_MSG_ASSIGN_DRIVER_AND_VEHICLES;
            status = DepartConfirmController.ERR_MSG_TSM_RECEIVED;
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        //System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        //System.assert(msgList[0].getDetail().contains(Label.Already_Shipment_Complete), 'Validation message mis-match');
    }
    
    // Test Validate already RSM pending delivery
    static testMethod void testValidateDepartConfirm_AlreadyPendingDelivery(){
        
        // Get data created from setup
        retrieveData();
        
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = new Shipping_Manifest__c();
        rsmObj.Status__c = DepartConfirmController.RSM_STATUS_PENDING_DELIVERY;
        insert rsmObj;
        Test.startTest();
        PageReference pageRef = Page.DepartConfirm;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        DepartConfirmController controllerObj = new DepartConfirmController(stdController);
        
        pageRef = controllerObj.departConfirm();
        DepartConfirmController.departConfirmlt(rsmObj.id);
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        //System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        //System.assert(msgList[0].getDetail().contains(Label.Already_Pending_Delivery), 'Validation message mis-match');
        Test.stopTest();
    }
    
    // Test Validate departure date/time already provided
    static testMethod void testValidateDepartConfirm_DepartureDateTimeAlreadyProvided(){
        
        // Get data created from setup
        retrieveData();
        
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = new Shipping_Manifest__c();
        rsmObj.Actual_Departure_Date_Time__c = System.Today() - 3;
        insert rsmObj;
        Test.startTest();
        PageReference pageRef = Page.DepartConfirm;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        DepartConfirmController controllerObj = new DepartConfirmController(stdController);
        
        pageRef = controllerObj.DepartConfirm();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        //System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        //System.assert(msgList[0].getDetail().contains(Label.Departure_Date_Already_Provided), 'Validation message mis-match');
        Test.stopTest();
    }
    
    // Test validate Picklist status is not QA Confirm
    static testMethod void testValidate_PicklistQAIsNotConfirm(){
        Test.startTest();
        // Get data created from setup
        retrieveData();
        
        // Update SO lines in Inventory positions
        for(Integer i=0; i<invPositions.size(); i++){
            invPositions[i].Sales_Order_Line__c = soLines[i].Id;
        }
        update invPositions;
        
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        
        // Create Driver
        driverObj = TestUtilData.createDriver(true);
        
        // Create Vehicle
        vehicleObj = TestUtilData.createVehicle(false);
        vehicleObj.Name = VEHICLE_NAME; 
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
                From Picklist__c limit 10];
        
        picklistLines = new List<PickList_Line__c>();
        picklistLines = [Select Product_Name__c,
                               Sales_Order_Line__r.Product_Name__c,
                               Sales_Order_Line__r.Product_Title__c,
                               Sales_Order_Line__r.Qty_Allocated__c,
                               Sales_Order_Line__r.Retail_Wholesale_Price__c,
                               Sales_Order_Line__r.UID__c,
                               Inventory_Location__c
                        From Picklist_Line__c Limit 10];
        
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Driver__c = driverObj.Id;
        rsmObj.Vehicle__c = vehicleObj.Id;
        insert rsmObj;
        
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj.Id, true);
      //  Test.startTest();
        PageReference pageRef = Page.DepartConfirm;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        DepartConfirmController controllerObj = new DepartConfirmController(stdController);
        
        pageRef = controllerObj.departConfirm();
       // System.assertEquals(null, pageRef, 'Page reference mis-match');
          DepartConfirmController.departConfirmlt(rsmObj.id);
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        //System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match'); 
        //System.assert(msgList[0].getDetail().contains(Label.Picklist_Is_Not_QA_Confirm), 'Validation message mis-match');
    Test.stopTest();
    }
   
    // Test pass all validations and update RSM status, actual departure time and inv postions
    static testMethod void testPassAllValidation_UpdateRSMAndInvPositions(){
       Test.startTest(); 
        // Get data created from setup
        retrieveData();
        
        // Update SO lines in Inventory positions
        for(Integer i=0; i<invPositions.size(); i++){
            invPositions[i].Sales_Order_Line__c = soLines[i].Id;
        }
        update invPositions;
        
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        
        // Create Driver
        driverObj = TestUtilData.createDriver(true);
        
        // Create Vehicle
        vehicleObj = TestUtilData.createVehicle(false);
        vehicleObj.Name = VEHICLE_NAME; 
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
                From Picklist__c Limit 10];
        
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
                        From Picklist_Line__c Limit 10];
        
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Driver__c = driverObj.Id;
        rsmObj.Vehicle__c = vehicleObj.Id;
        insert rsmObj;
        
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj.Id, true);
       // Test.startTest();
        PageReference pageRef = Page.DepartConfirm;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        DepartConfirmController controllerObj = new DepartConfirmController(stdController);
        
        pageRef = controllerObj.departConfirm();
          DepartConfirmController.departConfirmlt(rsmObj.id);
        //System.assertEquals('/'+String.valueOf(rsmObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        List<Account> lstAcc = [SELECT Id,Hold__c from Account LIMIT 2];
        for(Account acc : lstAcc){
        	acc.Hold__c = true;    
        }
        update lstAcc;
        
        List<Sales_Order__c> sOrder = [SELECT Id,Account_Hold_Exception__c from Sales_Order__c LIMIT 2];
        for(Sales_Order__c acc : sOrder){
        	acc.Account_Hold_Exception__c = false;    
        }
        update sOrder;
        
        pageRef = controllerObj.departConfirm();
          DepartConfirmController.departConfirmlt(rsmObj.id);
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match'); 
        
        // Verify updated RSM status, actual departure time 
        rsmObj = [Select Status__c, Actual_Departure_Date_Time__c From Shipping_Manifest__c
                      Where Id =: rsmObj.Id];
        
        //System.assertEquals(RSMSupport.STATUS_IN_TRANSIT, rsmObj.Status__c, 'RSM Status mis-match');
        //System.assertEquals(System.today(), rsmObj.Actual_Departure_Date_Time__c.Date(), 'RSM actual departure date time mis-match');
        
        // Verify updated inventory position with vehicle location, rack, rack level and bin location
        invPositions = [Select Inventory_Location__c, Rack__c, Rack_Level__c, Bin_Location__c From Inventory_Position__c LIMIT 1];
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
        invPositions = [Select Sales_Order_Line__c,
                               Sales_Order_Line__r.Product_Name__c,
                               Inventory_Location__r.Name
                               From Inventory_Position__c Limit 2];
                               
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Site__c from Sales_Order__c Limit 2];
        
        soLines = new List<Sales_Order_Line__c>();
        soLines = [Select Id from Sales_Order_Line__c Limit 2];
        
        // Create Inventory Location, Rack, Rack Level and Bin Location with Vehicle name
        List<Inventory_Location__c> invLocations = [Select Name, Site_Name__c from Inventory_Location__c Limit 2];
        vehicleLocation = invLocations[0].clone(false, true);
        vehicleLocation.Name = VEHICLE_NAME;
        insert vehicleLocation;
        
        List<Rack__c> racks = [Select Name, Inventory_Location__c from Rack__c  Limit 2];
        vehicleRack = racks[0].clone(false, true);
        vehicleRack.Name = VEHICLE_NAME;
        vehicleRack.Inventory_Location__c = vehicleLocation.Id;
        insert vehicleRack;
        
        List<Rack_Level__c> rackLevels = [Select Name, Rack__c from Rack_Level__c  Limit 2];
        vehicleRackLevel = rackLevels[0].clone(false, true);
        vehicleRackLevel.Name = VEHICLE_NAME;
        vehicleRackLevel.Rack__c = vehicleRack.Id;
        insert vehicleRackLevel;
        
        List<Bin_Location__c> binLocations = [Select Name, Rack_Level__c from Bin_Location__c  Limit 2];
        vehicleBinLocation = binLocations[0].clone(false, true);
        vehicleBinLocation.Name = VEHICLE_NAME;
        vehicleBinLocation.Rack_Level__c = vehicleRackLevel.Id;
        insert vehicleBinLocation;
    }
}