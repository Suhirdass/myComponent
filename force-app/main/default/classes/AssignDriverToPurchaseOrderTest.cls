/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * AssignDriverToPurchaseOrderCtlrTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class AssignDriverToPurchaseOrderTest{
    
    static List<Product2> products;
    static Drivers__c driverObj;
    static Purchase_Order__c salesOrderObj;
    static Purchase_Order__c tsmObj;
    static Shipping_Manifest__c tsmObj1;
    
    // Test loading of Assign Driver page from TSM detail page
    static testMethod void testLoadDriverAndTSMDetails_FromTSMPage(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        PageReference pageRef = Page.AssignDriver;
        pageRef.getParameters().put('id', tsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(tsmObj);
        AssignDriverToPurchaseOrderCtlr controllerObj = new AssignDriverToPurchaseOrderCtlr(stdController);
        
        pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(tsmObj.Id, controllerObj.tsmObj.Id, 'TSM mis-match');
        System.assertEquals(driverObj.Id, controllerObj.driverObj.Id, 'Driver mis-match');
        System.assertEquals(1, controllerObj.TSMList.size(), 'TSM List mis-match');
        
        pageRef = controllerObj.cancelAction();
        System.assertEquals('/'+String.valueOf(tsmObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        //Lightning Methods 
        
        AssignDriverToPurchaseOrderCtlr.assignDriverToPurchaseOrder(tsmObj.Id);
        AssignDriverToPurchaseOrderCtlr.assignDriver(salesOrderObj);
        AssignDriverToPurchaseOrderCtlr.retrieveDriverAndRelatedRSMTSMLight(salesOrderObj);
    }
    
    // Test update Driver of TSM
    static testMethod void testAssignDriverToTSM(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        PageReference pageRef = Page.AssignDriver;
        pageRef.getParameters().put('id', tsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(tsmObj);
        AssignDriverToPurchaseOrderCtlr controllerObj = new AssignDriverToPurchaseOrderCtlr(stdController);
        
        pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(tsmObj.Id, controllerObj.tsmObj.Id, 'TSM mis-match');
        System.assertEquals(driverObj.Id, controllerObj.driverObj.Id, 'Driver mis-match');
        System.assertEquals(1, controllerObj.TSMList.size(), 'TSM List mis-match');
        
        Test.startTest();
        
        // Set TSM driver to null to throw validation
        controllerObj.tsmObj.Driver__c = null;
        pageRef = controllerObj.assignDriver();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Select_Driver), 'Validation message mis-match');
        
        // Assign new driver and planned ship date to TSM
        Drivers__c newDriverObj = TestUtilData.createDriver(false);
        newDriverObj.Driver_License_Number__c = '123456';
        insert newDriverObj;
        
        controllerObj.tsmObj.Driver__c = newDriverObj.Id;
        controllerObj.tsmObj.Supplier_Payable_Date__c = System.Today() + 13;
        pageRef = controllerObj.assignDriver();
        
        // verify TSM driver and planned ship date
        tsmObj1 = [Select Planned_Ship_Transfer_Date__c, Driver__c From Shipping_Manifest__c Where Id =: tsmObj1.Id AND RecordTypeId =: ShippinManifestSupport.getTSMRecordTypeId()];
        
        Test.stopTest();
    }
    
    @TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        salesOrderObj = new Purchase_Order__c();
        salesOrderObj = [Select Id,Planned_Ship_Transfer_Date__c,
                         		Driver__c,Ship_Confirmation_Date__c,
                         		Vehicle__c
                                from Purchase_Order__c];
        
        products = new List<Product2>();
        products = [Select Id from Product2];
    }
    
    // Update necessary data for Assign Driver logic
    public static void updateAndCreateData(){
        // Create Driver
        driverObj = TestUtilData.createDriver(true);
        tsmObj = salesOrderObj;
        tsmObj.Driver__c = driverObj.Id;
        update tsmObj; 
        // Create TSM with planned ship date greater than license expiration date
        Sales_Order__c salesOrderObj1 = new Sales_Order__c();
        salesOrderObj1 = [Select Id,Site__c,
                         		Driver__c,
                         		Vehicle__c,
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
        tsmObj1 = TestUtilData.createTSM(salesOrderObj1, false);
        tsmObj1.Driver__c = driverObj.Id;
        insert tsmObj1;
        
        Shipping_Manifest_Line__c tsmLineObj = TestUtilData.createTSMLine(products[0], tsmObj1.Id, true);
    }
}