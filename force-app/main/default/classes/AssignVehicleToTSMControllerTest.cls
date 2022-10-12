/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * AssignVehicleToTSMControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class AssignVehicleToTSMControllerTest{
    
    static Vehicles__c vehicleObj;
    static Sales_Order__c salesOrderObj;
    static Shipping_Manifest__c tsmObj;
    static List<Product2> products;
    
    // Test loading of Assign Vehicle page from TSM detail page
    static testMethod void testLoadVehicleAndTSMDetails_FromTSMPage(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        PageReference pageRef = Page.AssignVehicle;
        pageRef.getParameters().put('id', tsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(tsmObj);
        AssignVehicleToTSMController controllerObj = new AssignVehicleToTSMController(stdController);
        
        pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(tsmObj.Id, controllerObj.tsmObj.Id, 'TSM mis-match');
        System.assertEquals(1, controllerObj.totalProduct, 'TSM Line mis-match');
        System.assertEquals(vehicleObj.Id, controllerObj.vehicleObj.Id, 'Vehicle mis-match');
        System.assertEquals(1, controllerObj.TSMList.size(), 'TSM List mis-match');
        
        pageRef = controllerObj.cancelAction();
        System.assertEquals('/'+String.valueOf(tsmObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
    }
    
    // Test update Vehicle of TSM
    static testMethod void testAssignVehicleToTSM(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        PageReference pageRef = Page.AssignVehicle;
        pageRef.getParameters().put('id', tsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(tsmObj);
        AssignVehicleToTSMController controllerObj = new AssignVehicleToTSMController(stdController);
        
        pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(tsmObj.Id, controllerObj.tsmObj.Id, 'TSM mis-match');
        System.assertEquals(1, controllerObj.totalProduct, 'TSM Line mis-match');
        System.assertEquals(vehicleObj.Id, controllerObj.vehicleObj.Id, 'Vehicle mis-match');
        System.assertEquals(1, controllerObj.tsmList.size(), 'TSM List mis-match');
        
        Test.startTest();
        
        // Set TSM vehicle to null to throw validation
        controllerObj.tsmObj.Vehicle__c = null;
        pageRef = controllerObj.assignVehicle();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Select_Vehicle), 'Validation message mis-match');
        
        // Assign new vehicle and planned ship date to TSM
        Vehicles__c newVehicleObj = TestUtilData.createVehicle(false);
        insert newVehicleObj;
        
        controllerObj.tsmObj.Vehicle__c = newVehicleObj.Id;
        controllerObj.tsmObj.Planned_Ship_Transfer_Date__c = System.Today() + 13;
        pageRef = controllerObj.assignVehicle();
        System.assertEquals('/'+String.valueOf(tsmObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        // verify TSM vehicle and planned ship date
        tsmObj = [Select Status__c, Planned_Ship_Transfer_Date__c, Vehicle__c From Shipping_Manifest__c Where Id =: tsmObj.Id AND RecordTypeId =: ShippinManifestSupport.getTSMRecordTypeId()];
        System.assertEquals(newVehicleObj.Id, tsmObj.Vehicle__c, 'Vehicle mis-match');
        System.assertEquals(System.Today() + 13, tsmObj.Planned_Ship_Transfer_Date__c, 'Planned ship date mis-match');
        System.assertEquals(RSMSupport.STATUS_DRAFT, tsmObj.Status__c, 'TSM Status mis-match');
        
        Test.stopTest();
    }
    
    // Test update Vehicle of TSM
    static testMethod void testUpdateTSMStatusToShipmentPending_DriverAndVehicleAssignedToTSM(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        // Create Driver record
        Drivers__c driverObj = TestUtilData.createDriver(true);
        tsmObj.Driver__c = driverObj.Id;
        update tsmObj;
        
        PageReference pageRef = Page.AssignVehicle;
        pageRef.getParameters().put('id', tsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(tsmObj);
        AssignVehicleToTSMController controllerObj = new AssignVehicleToTSMController(stdController);
        
        pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(tsmObj.Id, controllerObj.tsmObj.Id, 'TSM mis-match');
        System.assertEquals(1, controllerObj.totalProduct, 'TSM Line mis-match');
        System.assertEquals(vehicleObj.Id, controllerObj.vehicleObj.Id, 'Vehicle mis-match');
        System.assertEquals(1, controllerObj.tsmList.size(), 'TSM List mis-match');
        
        Test.startTest();
        
        // Set TSM vehicle to null to throw validation
        controllerObj.tsmObj.Vehicle__c = null;
        pageRef = controllerObj.assignVehicle();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Select_Vehicle), 'Validation message mis-match');
        
        // Assign new vehicle and planned ship date to TSM
        Vehicles__c newVehicleObj = TestUtilData.createVehicle(false);
        insert newVehicleObj;
        
        controllerObj.tsmObj.Vehicle__c = newVehicleObj.Id;
        controllerObj.tsmObj.Planned_Ship_Transfer_Date__c = System.Today() + 13;
        pageRef = controllerObj.assignVehicle();
        System.assertEquals('/'+String.valueOf(tsmObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        // verify TSM vehicle and planned ship date
        tsmObj = [Select Status__c, Planned_Ship_Transfer_Date__c, Vehicle__c From Shipping_Manifest__c Where Id =: tsmObj.Id AND RecordTypeId =: ShippinManifestSupport.getTSMRecordTypeId()];
        System.assertEquals(newVehicleObj.Id, tsmObj.Vehicle__c, 'Vehicle mis-match');
        System.assertEquals(System.Today() + 13, tsmObj.Planned_Ship_Transfer_Date__c, 'Planned ship date mis-match');
        System.assertEquals(RSMSupport.STATUS_SHIPMENT_PENDING, tsmObj.Status__c, 'TSM Status mis-match');
        
        Test.stopTest();
    }
    
    // Test update Driver of TSM - Status should not be changed if it is already In-Transit
    static testMethod void testDoNotUpdateTSMStatusToShipmentPending_ExistingStatusInTransit_DriverAndVehicleAssignedToTSM(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        // Create Driver record
        Drivers__c driverObj = TestUtilData.createDriver(true);
        tsmObj.Driver__c = driverObj.Id;
        tsmObj.Status__c = RSMSupport.STATUS_IN_TRANSIT;
        update tsmObj;
        
        PageReference pageRef = Page.AssignVehicle;
        pageRef.getParameters().put('id', tsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(tsmObj);
        AssignVehicleToTSMController controllerObj = new AssignVehicleToTSMController(stdController);
        
        pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(tsmObj.Id, controllerObj.tsmObj.Id, 'TSM mis-match');
        System.assertEquals(1, controllerObj.totalProduct, 'TSM Line mis-match');
        System.assertEquals(vehicleObj.Id, controllerObj.vehicleObj.Id, 'Vehicle mis-match');
        System.assertEquals(1, controllerObj.tsmList.size(), 'TSM List mis-match');
        
        Test.startTest();
        
        // Assign new vehicle and planned ship date to TSM
        Vehicles__c newVehicleObj = TestUtilData.createVehicle(false);
        insert newVehicleObj;
        
        controllerObj.tsmObj.Vehicle__c = newVehicleObj.Id;
        controllerObj.tsmObj.Planned_Ship_Transfer_Date__c = System.Today() + 13;
        pageRef = controllerObj.assignVehicle();
        System.assertEquals('/'+String.valueOf(tsmObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        // verify TSM vehicle and planned ship date
        tsmObj = [Select Status__c, Planned_Ship_Transfer_Date__c, Vehicle__c From Shipping_Manifest__c Where Id =: tsmObj.Id AND RecordTypeId =: ShippinManifestSupport.getTSMRecordTypeId()];
        System.assertEquals(newVehicleObj.Id, tsmObj.Vehicle__c, 'Vehicle mis-match');
        System.assertEquals(System.Today() + 13, tsmObj.Planned_Ship_Transfer_Date__c, 'Planned ship date mis-match');
        System.assertEquals(RSMSupport.STATUS_IN_TRANSIT, tsmObj.Status__c, 'TSM Status mis-match');
        
        Test.stopTest();
    }
    
    // Test update Vehicle of TSM - Status should not be changed if it is already shipment complete
    static testMethod void testVehicleAssignedToTSM_AfterStatusChangedToShipmentComplete(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        tsmObj.Status__c = RSMSupport.STATUS_SHIPMENT_COMPLETE;
        update tsmObj;
        
        PageReference pageRef = Page.AssignVehicle;
        pageRef.getParameters().put('id', tsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(tsmObj);
        AssignVehicleToTSMController controllerObj = new AssignVehicleToTSMController(stdController);
        
        pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(tsmObj.Id, controllerObj.tsmObj.Id, 'TSM mis-match');
        System.assertEquals(1, controllerObj.totalProduct, 'TSM Line mis-match');
        System.assertEquals(vehicleObj.Id, controllerObj.vehicleObj.Id, 'Vehicle mis-match');
        System.assertEquals(1, controllerObj.tsmList.size(), 'TSM List mis-match');
        
        Test.startTest();
        
        // Set TSM vehicle to null to throw validation
        controllerObj.tsmObj.Vehicle__c = null;
        pageRef = controllerObj.assignVehicle();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Select_Vehicle), 'Validation message mis-match');
        
        // Assign new vehicle and planned ship date to TSM
        Vehicles__c newVehicleObj = TestUtilData.createVehicle(false);
        insert newVehicleObj;
        
        controllerObj.tsmObj.Vehicle__c = newVehicleObj.Id;
        controllerObj.tsmObj.Planned_Ship_Transfer_Date__c = System.Today() + 13;
        pageRef = controllerObj.assignVehicle();
        System.assertEquals('/'+String.valueOf(tsmObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        // verify TSM vehicle and planned ship date
        tsmObj = [Select Status__c, Planned_Ship_Transfer_Date__c, Vehicle__c From Shipping_Manifest__c Where Id =: tsmObj.Id AND RecordTypeId =: ShippinManifestSupport.getTSMRecordTypeId()];
        System.assertEquals(newVehicleObj.Id, tsmObj.Vehicle__c, 'Vehicle mis-match');
        System.assertEquals(System.Today() + 13, tsmObj.Planned_Ship_Transfer_Date__c, 'Planned ship date mis-match');
        System.assertEquals(RSMSupport.STATUS_SHIPMENT_COMPLETE, tsmObj.Status__c, 'TSM Status mis-match');
        
        Test.stopTest();
    }
    
    @TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Site__c,
                                Brand_Quote__c,
                                Distributor_Contact__c,
                                Distributor_License__c,
                                Distributor_Name__c,
                                Opportunity_Name__c,
                                Payment_Terms__c,
                                Planned_Ship_Date__c,
                                Receiver_Contact__c,
                                Receiver_License__c,
                                Receiver_Name__c,
                                Sample_Order__c,
                                Shipping_Method__c,
                                Shipping_Terms__c,
                                Supplier_Contact__c,
                                Supplier_License__c,
                                Supplier_Name__c
                                from Sales_Order__c];
        
        products = new List<Product2>();
        products = [Select Id from Product2];
    }
    
    // Update necessary data for Assign Vehicle logic
    public static void updateAndCreateData(){
        // Create Vehicle
        vehicleObj = TestUtilData.createVehicle(true);
        
        tsmObj = TestUtilData.createTSM(salesOrderObj, false);
        tsmObj.Vehicle__c = vehicleObj.Id;
        insert tsmObj;
        
        Shipping_Manifest_Line__c tsmLineObj = TestUtilData.createTSMLine(products[0], tsmObj.Id, true);
    }
}