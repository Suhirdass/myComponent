/**
 * Copyright (c) 2018 Filigreen Distro 
 * All rights reserved.
 * AssignVehicleToSalesOrderCtlrTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class AssignVehicleToSalesOrderTest{
    
    static PickList__c pickListObj;
    static Vehicles__c vehicleObj;
    static List<PickList_Line__c> pickListLines;
    static Sales_Order__c salesOrderObj;
    static Sales_Order__c rsmObj;
    static List<Sales_Order_Line__c> soLines;
    static List<Inventory_Position__c> invPositions;
    static Shipping_Manifest__c rsmObj1;
    static List<Shipping_Manifest_Line__c> rsmLines;
    
    // Test loading of Assign Vehicle page from RSM detail page
    static testMethod void testLoadVehicleAndRSMDetails_FromRSMPage(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        PageReference pageRef = Page.AssignVehicle;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        AssignVehicleToSalesOrderCtlr controllerObj = new AssignVehicleToSalesOrderCtlr(stdController);
        
        pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(rsmObj.Id, controllerObj.rsmObj.Id, 'RSM mis-match');
        
        System.assertEquals(vehicleObj.Id, controllerObj.vehicleObj.Id, 'Vehicle mis-match');
        System.assertEquals(1, controllerObj.rsmList.size(), 'RSM List mis-match');
        
        pageRef = controllerObj.cancelAction();
        System.assertEquals('/'+String.valueOf(rsmObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        //Lightning Methods
        test.startTest();
        AssignVehicleToSalesOrderCtlr.assignVehicleToSalesOrder(rsmObj.Id);
        AssignVehicleToSalesOrderCtlr.retrieveVehicleAndRelated(salesOrderObj,null,null);
        AssignVehicleToSalesOrderCtlr.assignVehicle(salesOrderObj);
        test.stopTest();
    }
    
    // Test loading of Assign Vehicle page as VF tab
    static testMethod void testLoadVehicleAndRSMDetails_FromTab(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        AssignVehicleToSalesOrderCtlr controllerObj = new AssignVehicleToSalesOrderCtlr();
        
        PageReference pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(null, controllerObj.rsmObj.Id, 'RSM mis-match');
        System.assertEquals(null, controllerObj.totalProduct, 'RSM Line mis-match');
        System.assertEquals(null, controllerObj.vehicleObj.Id, 'Vehicle mis-match');
        System.assertEquals(0, controllerObj.rsmList.size(), 'RSM List mis-match');
    }
    
    // Test update Vehicle of RSM
    static testMethod void testAssignVehicleToRSM(){

        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        PageReference pageRef = Page.AssignVehicle;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        AssignVehicleToSalesOrderCtlr controllerObj = new AssignVehicleToSalesOrderCtlr(stdController);
        
        pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(rsmObj.Id, controllerObj.rsmObj.Id, 'RSM mis-match');
        
        System.assertEquals(vehicleObj.Id, controllerObj.vehicleObj.Id, 'Vehicle mis-match');
        System.assertEquals(1, controllerObj.rsmList.size(), 'RSM List mis-match');
        
        Test.startTest();
        
        // Set RSM vehicle to null to throw validation
        controllerObj.rsmObj.Vehicle__c = null;
        pageRef = controllerObj.assignVehicle();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Select_Vehicle), 'Validation message mis-match');
        
        // Assign new vehicle and planned ship date to RSM
        Vehicles__c newVehicleObj = TestUtilData.createVehicle(false);
        insert newVehicleObj;
        
        controllerObj.rsmObj.Vehicle__c = newVehicleObj.Id;
        controllerObj.rsmObj.Planned_Ship_Date__c = System.Today() + 13;
        pageRef = controllerObj.assignVehicle();
        System.assertEquals('/'+String.valueOf(rsmObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        // verify RSM vehicle and planned ship date
        rsmObj1 = [Select Planned_Ship_Transfer_Date__c, Vehicle__c From Shipping_Manifest__c Where Id =: rsmObj1.Id AND RecordTypeId =: ShippinManifestSupport.getRSMRecordTypeId()];
        
        Test.stopTest();
    }
    
    @TestSetUp
    static void testDataSetUp(){
  TestUtilData.skipTrigger = true;
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.createTestData();
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        invPositions = [Select Sales_Order_Line__c,
                               Sales_Order_Line__r.Product_Name__c,
                               Inventory_Location__r.Name
                               From Inventory_Position__c];
                               
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Site__c,Id,Planned_Ship_Date__c from Sales_Order__c];
        
        soLines = new List<Sales_Order_Line__c>();
        soLines = [Select Id from Sales_Order_Line__c];
    }
    
    // Update necessary data for Assign Vehicle logic
    public static void updateAndCreateData(){
        // Update SO lines in Inventory positions
        for(Integer i=0; i<invPositions.size(); i++){
            invPositions[i].Sales_Order_Line__c = soLines[i].Id;
        }
        update invPositions;
        
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        
        // Create Vehicle
        vehicleObj = TestUtilData.createVehicle(true);
        rsmObj = salesOrderObj;
        rsmObj.Vehicle__c = vehicleObj.Id;
        update rsmObj; 
        // Create RSM with planned ship date greater than license expiration date
        rsmObj1 = TestUtilData.createRSM(pickListObj, false);
        rsmObj1.Vehicle__c = vehicleObj.Id;
        insert rsmObj1;
        
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj1.Id, true);
    }
}