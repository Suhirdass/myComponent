/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * DepartConfirmTSMControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class DepartConfirmTSMControllerTest{
    
    static Sales_Order__c salesOrderObj;
    static Shipping_Manifest__c tsmObj;
    
    // Test Validate already Received TSM
    static testMethod void testValidateDepartConfirm_AlreadyTSMReceived(){
        
        // Get data created from setup
        retrieveData();
        
        // Create TSM
        tsmObj = new Shipping_Manifest__c();
        tsmObj.Status__c = TSMSupport.STATUS_RECEIVED;
        tsmObj.RecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        insert tsmObj;
        
        PageReference pageRef = Page.DepartConfirm;
        pageRef.getParameters().put('id', tsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(tsmObj);
        DepartConfirmTSMController controllerObj = new DepartConfirmTSMController(stdController);
        
        pageRef = controllerObj.departConfirm();
        DepartConfirmTSMController.DepartConfirmTSMControllertsmlt(tsmObj.id);
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Already_TSM_Received), 'Validation message mis-match');
    }
    
    // Test Validate departure date/time already provided
    static testMethod void testValidateDepartConfirm_DepartureDateTimeAlreadyProvided(){
        
        // Get data created from setup
        retrieveData();
        
        // Create TSM
        tsmObj = new Shipping_Manifest__c();
        tsmObj.Actual_Departure_Date_Time__c = System.Today() - 3;
        tsmObj.RecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        insert tsmObj;
        
        PageReference pageRef = Page.DepartConfirm;
        pageRef.getParameters().put('id', tsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(tsmObj);
        DepartConfirmTSMController controllerObj = new DepartConfirmTSMController(stdController);
        
        pageRef = controllerObj.departConfirm();
                DepartConfirmTSMController.DepartConfirmTSMControllertsmlt(tsmObj.id);

        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Departure_Date_Already_Provided), 'Validation message mis-match');
    }
    
    // Test Validate mandatory fields missing error
    static testMethod void testValidateDepartConfirm_MandatoryFieldMissingError(){
        
        // Get data created from setup
        retrieveData();
        
        // Create TSM
        tsmObj = TestUtilData.createTSM(salesOrderObj, false);
        tsmObj.Payment_Terms__c = null;
        insert tsmObj;
        
        PageReference pageRef = Page.ShipConfirm;
        pageRef.getParameters().put('id', tsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        // Create picklist
        PickList__c pickListObj = TestUtilData.createPicklist(salesOrderObj, PickListSupport.STATUS_QA_CONFIRM, true);
        
        tsmObj.PickList__c = pickListObj.Id;
        update tsmObj;
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(tsmObj);
        DepartConfirmTSMController controllerObj = new DepartConfirmTSMController(stdController);
        
        pageRef = controllerObj.departConfirm();
                DepartConfirmTSMController.DepartConfirmTSMControllertsmlt(tsmObj.id);

        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.TSM_Mandatory_Fields_Error), 'Validation message mis-match');
    }
    
    // Test pass all validations and update TSM status and actual departure time
    static testMethod void testPassAllValidation_UpdateTSM(){
        Test.startTest();
        // Get data created from setup
        retrieveData();
        
        // Create Driver
        Drivers__c driverObj = TestUtilData.createDriver(true);
        
        // Create Vehicle
        Vehicles__c vehicleObj = TestUtilData.createVehicle(false);
        vehicleObj.Name = 'Test Vehicle'; 
        insert vehicleObj;
        
        // Create TSM
        tsmObj = TestUtilData.createTSM(salesOrderObj, false);
        tsmObj.Driver__c = driverObj.Id;
        tsmObj.Vehicle__c = vehicleObj.Id;
        insert tsmObj;
        
        PageReference pageRef = Page.DepartConfirm;
        pageRef.getParameters().put('id', tsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        // Create picklist
        PickList__c pickListObj = TestUtilData.createPicklist(salesOrderObj, PickListSupport.STATUS_QA_CONFIRM, true);
        
        tsmObj.PickList__c = pickListObj.Id;
        update tsmObj;
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(tsmObj);
        DepartConfirmTSMController controllerObj = new DepartConfirmTSMController(stdController);
        
        pageRef = controllerObj.departConfirm();
                DepartConfirmTSMController.DepartConfirmTSMControllertsmlt(tsmObj.id);

        System.assertEquals('/'+String.valueOf(tsmObj.Id).subString(0, 15), 
                            pageRef.getURL(), 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match'); 
        
        // Verify updated TSM status, actual departure date 
        tsmObj = [Select Status__c, Actual_Departure_Date_Time__c From Shipping_Manifest__c
                      Where Id =: tsmObj.Id AND RecordTypeId =: ShippinManifestSupport.getTSMRecordTypeId()];
        
        System.assertEquals(TSMSupport.STATUS_IN_TRASIT, 
                            tsmObj.Status__c, 'TSM Status mis-match');
        System.assertEquals(System.today(), 
                            tsmObj.Actual_Departure_Date_Time__c.Date(), 'TSM departure arrival date mis-match');
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
    }
}