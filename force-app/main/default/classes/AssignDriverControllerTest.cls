/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * AssignDriverControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class AssignDriverControllerTest{
    
    static PickList__c pickListObj;
    static Drivers__c driverObj;
    static List<PickList_Line__c> pickListLines;
    static Sales_Order__c salesOrderObj;
    static List<Sales_Order_Line__c> soLines;
    static List<Inventory_Position__c> invPositions;
    static Shipping_Manifest__c rsmObj;
    static List<Shipping_Manifest_Line__c> rsmLines;
    
    // Test loading of Assign Driver page from RSM detail page
    static testMethod void testLoadDriverAndRSMDetails_FromRSMPage(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        PageReference pageRef = Page.AssignDriver;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        AssignDriverController controllerObj = new AssignDriverController(stdController);
        
        pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(rsmObj.Id, controllerObj.rsmObj.Id, 'RSM mis-match');
        System.assertEquals(1, controllerObj.totalProduct, 'RSM Line mis-match');
        System.assertEquals(driverObj.Id, controllerObj.driverObj.Id, 'Driver mis-match');
        System.assertEquals(1, controllerObj.rsmList.size(), 'RSM List mis-match');
        
        pageRef = controllerObj.cancelAction();
        System.assertEquals('/'+String.valueOf(rsmObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
    }
    
    // Test loading of Assign Driver page as VF tab
    static testMethod void testLoadDriverAndRSMDetails_FromTab(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        AssignDriverController controllerObj = new AssignDriverController();
        
        PageReference pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(null, controllerObj.rsmObj.Id, 'RSM mis-match');
        System.assertEquals(null, controllerObj.totalProduct, 'RSM Line mis-match');
        System.assertEquals(null, controllerObj.driverObj.Id, 'Driver mis-match');
        System.assertEquals(0, controllerObj.rsmList.size(), 'RSM List mis-match');
    }
    
    // Test update Driver of RSM
    static testMethod void testAssignDriverToRSM(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        PageReference pageRef = Page.AssignDriver;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        AssignDriverController controllerObj = new AssignDriverController(stdController);
        
        pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(rsmObj.Id, controllerObj.rsmObj.Id, 'RSM mis-match');
        System.assertEquals(1, controllerObj.totalProduct, 'RSM Line mis-match');
        System.assertEquals(driverObj.Id, controllerObj.driverObj.Id, 'Driver mis-match');
        System.assertEquals(1, controllerObj.rsmList.size(), 'RSM List mis-match');
        
        Test.startTest();
        
        // Set RSM driver to null to throw validation
        controllerObj.rsmObj.Driver__c = null;
        pageRef = controllerObj.assignDriver();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Select_Driver), 'Validation message mis-match');
        
        // Assign new driver and planned ship date to RSM
        Drivers__c newDriverObj = TestUtilData.createDriver(false);
        newDriverObj.Driver_License_Number__c = '123456';
        insert newDriverObj;
        
        controllerObj.rsmObj.Driver__c = newDriverObj.Id;
        controllerObj.rsmObj.Planned_Ship_Transfer_Date__c = System.Today() + 13;
        pageRef = controllerObj.assignDriver();
        System.assertEquals('/'+String.valueOf(rsmObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        // verify RSM driver and planned ship date
        rsmObj = [Select Status__c, Planned_Ship_Transfer_Date__c, Driver__c From Shipping_Manifest__c Where Id =: rsmObj.Id];
        System.assertEquals(newDriverObj.Id, rsmObj.Driver__c, 'Driver mis-match');
        System.assertEquals(System.Today() + 13, rsmObj.Planned_Ship_Transfer_Date__c, 'Planned ship date mis-match');
        System.assertEquals(RSMSupport.STATUS_DRAFT, rsmObj.Status__c, 'RSM Status mis-match');
        
        Test.stopTest();
    }
    
    // Test update Driver of RSM
    static testMethod void testUpdateRSMStatusToShipmentPending_DriverAndVehicleAssignedToRSM(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        // Create Vehicle record
        Vehicles__c vehicleObj = TestUtilData.createVehicle(true);
        rsmObj.Vehicle__c = vehicleObj.Id;
        update rsmObj;
        
        PageReference pageRef = Page.AssignDriver;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        AssignDriverController controllerObj = new AssignDriverController(stdController);
        
        pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(rsmObj.Id, controllerObj.rsmObj.Id, 'RSM mis-match');
        System.assertEquals(1, controllerObj.totalProduct, 'RSM Line mis-match');
        System.assertEquals(driverObj.Id, controllerObj.driverObj.Id, 'Driver mis-match');
        System.assertEquals(1, controllerObj.rsmList.size(), 'RSM List mis-match');
        
        Test.startTest();
        
        // Set RSM driver to null to throw validation
        controllerObj.rsmObj.Driver__c = null;
        pageRef = controllerObj.assignDriver();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Select_Driver), 'Validation message mis-match');
        
        // Assign new driver and planned ship date to RSM
        Drivers__c newDriverObj = TestUtilData.createDriver(false);
        newDriverObj.Driver_License_Number__c = '123456';
        insert newDriverObj;
        
        controllerObj.rsmObj.Driver__c = newDriverObj.Id;
        controllerObj.rsmObj.Planned_Ship_Transfer_Date__c = System.Today() + 13;
        pageRef = controllerObj.assignDriver();
        System.assertEquals('/'+String.valueOf(rsmObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        // verify RSM driver and planned ship date
        rsmObj = [Select Status__c, Planned_Ship_Transfer_Date__c, Driver__c From Shipping_Manifest__c Where Id =: rsmObj.Id];
        System.assertEquals(newDriverObj.Id, rsmObj.Driver__c, 'Driver mis-match');
        System.assertEquals(System.Today() + 13, rsmObj.Planned_Ship_Transfer_Date__c, 'Planned ship date mis-match');
        System.assertEquals(RSMSupport.STATUS_SHIPMENT_PENDING, rsmObj.Status__c, 'RSM Status mis-match');
        
        Test.stopTest();
    }
    
    // Test update Driver of RSM - Status should not be changed if it is already In-Transit
    static testMethod void testDoNotUpdateRSMStatusToShipmentPending_ExistingStatusInTransit_DriverAndVehicleAssignedToRSM(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        // Create Vehicle record
        Vehicles__c vehicleObj = TestUtilData.createVehicle(true);
        rsmObj.Vehicle__c = vehicleObj.Id;
        rsmObj.Status__c = RSMSupport.STATUS_IN_TRANSIT;
        update rsmObj;
        
        PageReference pageRef = Page.AssignDriver;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        AssignDriverController controllerObj = new AssignDriverController(stdController);
        
        pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(rsmObj.Id, controllerObj.rsmObj.Id, 'RSM mis-match');
        System.assertEquals(1, controllerObj.totalProduct, 'RSM Line mis-match');
        System.assertEquals(driverObj.Id, controllerObj.driverObj.Id, 'Driver mis-match');
        System.assertEquals(1, controllerObj.rsmList.size(), 'RSM List mis-match');
        
        Test.startTest();
        
        // Assign new driver and planned ship date to RSM
        Drivers__c newDriverObj = TestUtilData.createDriver(false);
        newDriverObj.Driver_License_Number__c = '123456';
        insert newDriverObj;
        
        controllerObj.rsmObj.Driver__c = newDriverObj.Id;
        controllerObj.rsmObj.Planned_Ship_Transfer_Date__c = System.Today() + 13;
        pageRef = controllerObj.assignDriver();
        System.assertEquals('/'+String.valueOf(rsmObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        // verify RSM driver and planned ship date
        rsmObj = [Select Status__c, Planned_Ship_Transfer_Date__c, Driver__c From Shipping_Manifest__c Where Id =: rsmObj.Id];
        System.assertEquals(newDriverObj.Id, rsmObj.Driver__c, 'Driver mis-match');
        System.assertEquals(System.Today() + 13, rsmObj.Planned_Ship_Transfer_Date__c, 'Planned ship date mis-match');
        System.assertEquals(RSMSupport.STATUS_IN_TRANSIT, rsmObj.Status__c, 'RSM Status mis-match');
        
        Test.stopTest();
    }
    
    // Test update Driver of RSM - Status should not be changed if it is already shipment complete
    static testMethod void testDriverAssignedToRSM_AfterStatusChangedToShipmentComplete(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        rsmObj.Status__c = RSMSupport.STATUS_SHIPMENT_COMPLETE;
        update rsmObj;
        
        PageReference pageRef = Page.AssignDriver;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        AssignDriverController controllerObj = new AssignDriverController(stdController);
        
        pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(rsmObj.Id, controllerObj.rsmObj.Id, 'RSM mis-match');
        System.assertEquals(1, controllerObj.totalProduct, 'RSM Line mis-match');
        System.assertEquals(driverObj.Id, controllerObj.driverObj.Id, 'Driver mis-match');
        System.assertEquals(1, controllerObj.rsmList.size(), 'RSM List mis-match');
        
        Test.startTest();
        
        // Set RSM driver to null to throw validation
        controllerObj.rsmObj.Driver__c = null;
        pageRef = controllerObj.assignDriver();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Select_Driver), 'Validation message mis-match');
        
        // Assign new driver and planned ship date to RSM
        Drivers__c newDriverObj = TestUtilData.createDriver(false);
        newDriverObj.Driver_License_Number__c = '123456';
        insert newDriverObj;
        
        controllerObj.rsmObj.Driver__c = newDriverObj.Id;
        controllerObj.rsmObj.Planned_Ship_Transfer_Date__c = System.Today() + 13;
        pageRef = controllerObj.assignDriver();
        System.assertEquals('/'+String.valueOf(rsmObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        // verify RSM driver and planned ship date
        rsmObj = [Select Status__c, Planned_Ship_Transfer_Date__c, Driver__c From Shipping_Manifest__c Where Id =: rsmObj.Id];
        System.assertEquals(newDriverObj.Id, rsmObj.Driver__c, 'Driver mis-match');
        System.assertEquals(System.Today() + 13, rsmObj.Planned_Ship_Transfer_Date__c, 'Planned ship date mis-match');
        System.assertEquals(RSMSupport.STATUS_SHIPMENT_COMPLETE, rsmObj.Status__c, 'RSM Status mis-match');
        
        Test.stopTest();
    }
    
    @TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        invPositions = [Select Sales_Order_Line__c,
                               Sales_Order_Line__r.Product_Name__c,
                               Inventory_Location__r.Name
                               From Inventory_Position__c];
                               
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Site__c from Sales_Order__c];
        
        soLines = new List<Sales_Order_Line__c>();
        soLines = [Select Id from Sales_Order_Line__c];
    }
    
    // Update necessary data for Assign Driver logic
    public static void updateAndCreateData(){
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
        
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Driver__c = driverObj.Id;
        insert rsmObj;
        
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj.Id, true);
    }
}