/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * CancelRSMLineControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class CancelRSMLineControllerTest{
    
    static PickList__c pickListObj;
    static List<PickList_Line__c> pickListLines;
    static Sales_Order__c salesOrderObj;
    static List<Sales_Order_Line__c> soLines;
    static List<Inventory_Position__c> invPositions;
    static Shipping_Manifest__c rsmObj;
    static List<Shipping_Manifest_Line__c> rsmLines;
    static List<Inventory_Location__c> invLocations;
    static Inventory_Location__c defaultLocation;
    static Invoice__c invoiceObj;
    static List<Invoice_Line__c> invLines;
    static Excise_Tax_Receipt__c etrObj;
    static List<Excise_Tax_Receipt_Line__c> etrLines;
    
    // Test Validate already RSM shipment complete
    static testMethod void testValidateCancelRSMLine_AlreadyShipmentComplete(){
        
        // Get data created from setup
        retrieveData();
        
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = new Shipping_Manifest__c();
        rsmObj.Status__c = RSMSupport.STATUS_SHIPMENT_COMPLETE;
        rsmObj.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        insert rsmObj;
        
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj.Id, true);
        
        PageReference pageRef = Page.CancelRSMLine;
        pageRef.getParameters().put('id', rsmLineObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmLineObj);
        CancelRSMLineController controllerObj = new CancelRSMLineController(stdController);
        
        pageRef = controllerObj.cancelRSMLine();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Cannot_Cancel_RSMLine), 'Validation message mis-match');
    }
    
    // Test Validate already RSM cancelled
    static testMethod void testValidateCancelRSMLine_AlreadyCancelled(){
        
        // Get data created from setup
        retrieveData();
        
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = new Shipping_Manifest__c();
        rsmObj.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        insert rsmObj;
        
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj.Id, false);
        rsmLineObj.SMLine_Status__c = RSMSupport.STATUS_CANCELLED;
        insert rsmLineObj;
        
        PageReference pageRef = Page.CancelRSMLine;
        pageRef.getParameters().put('id', rsmLineObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmLineObj);
        CancelRSMLineController controllerObj = new CancelRSMLineController(stdController);
        
        pageRef = controllerObj.cancelRSMLine();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Already_RSMLine_Cancelled), 'Validation message mis-match');
    }
    
    // Test pass all validations and update RSM line status and inv postions
    static testMethod void testPassAllValidation_UpdateRSMLineAndInvPositions(){
        
        // Get data created from setup
        retrieveData();
        Test.startTest();
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = TestUtilData.createRSM(pickListObj, true);
        List<Shipping_Manifest_Line__c> rsmLines = new List<Shipping_Manifest_Line__c>();
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj.Id, false);
        rsmLineObj.Sales_Order_Line__c = soLines[0].Id;
        rsmLines.add(rsmLineObj);
        
        Shipping_Manifest_Line__c rsmLineObj1 = TestUtilData.createRSMLine(pickListLines[1], rsmObj.Id, false);
        rsmLineObj1.Sales_Order_Line__c = soLines[1].Id;
        rsmLineObj1.Shipment_Qty__c = 10;
        rsmLines.add(rsmLineObj1);
        
        insert rsmLines;
        
        PageReference pageRef = Page.CancelRSMLine;
        pageRef.getParameters().put('id', rsmLineObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmLineObj);
        CancelRSMLineController controllerObj = new CancelRSMLineController(stdController);
        
        pageRef = controllerObj.cancelRSMLine();
        /*System.assertEquals('/'+String.valueOf(rsmLineObj.Id).subString(0, 15), 
                            pageRef.getURL(), 'Page reference mis-match');*/
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        //System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match'); 
        
        // Verify updated RSM line status
        rsmLineObj = [Select SMLine_Status__c From Shipping_Manifest_Line__c
                      Where Id =: rsmLineObj.Id];
        
        /*System.assertEquals(RSMSupport.STATUS_CANCELLED, 
                            rsmLineObj.SMLine_Status__c, 'RSM line Status mis-match');*/
                            
        // Verify RSM status is not updated
        rsmObj = [Select Status__c From Shipping_Manifest__c Where Id =: rsmObj.Id];
        
        System.assertEquals(RSMSupport.STATUS_DRAFT, 
                            rsmObj.Status__c, 'RSM Status mis-match');
        
        // Verify updated inventory position with default location and blank rack, rack level and bin location
        invPositions = [Select Inventory_Location__c, Rack__c, Rack_Level__c, Bin_Location__c From Inventory_Position__c LIMIT 1];
        //System.assertEquals(defaultLocation.Id, invPositions[0].Inventory_Location__c, 'Inventory Location mis-match');
                            
        System.assertEquals(null, invPositions[0].Rack__c, 'Rack mis-match');
                            
        System.assertEquals(null, invPositions[0].Rack_Level__c, 'Rack Level mis-match');
                            
        System.assertEquals(null, invPositions[0].Bin_Location__c, 'Bin Location mis-match');
        Test.stopTest();
        // Verify update SO line status as Rejected
        //soLines = [Select Id, Status__c from Sales_Order_Line__c];
        /*System.assertEquals(RSMSupport.SO_STATUS_REJECTED, 
                            soLines[0].Status__c, 'SO line Status mis-match');*/
        
        /*// Verify updated Invoice line(related to SO line) status as Rejected
        invLines = [Select Id, InvoiceLine_Status__c from Invoice_Line__c];
        System.assertEquals(RSMSupport.SO_STATUS_REJECTED, 
                            invLines[0].InvoiceLine_Status__c, 'Invoice line Status mis-match');
                            
        // Verify updated ETR line(related to invoice line) status as Rejected
        etrLines = [Select Id, ETRLine_Status__c from Excise_Tax_Receipt_Line__c];
        System.assertEquals(RSMSupport.SO_STATUS_REJECTED, 
                            etrLines[0].ETRLine_Status__c, 'ETR line Status mis-match');
                            
        // Verify related picklist line record should be cancelled
        List<PickList_Line__c> picklistLines = [Select Status__c From PickList_Line__c];
        System.assertEquals(RSMSupport.STATUS_CANCELLED, 
                                picklistLines[0].Status__c, 'PickList line Status mis-match');
        System.assertEquals(RSMSupport.SO_STATUS_OPEN, 
                                picklistLines[1].Status__c, 'PickList line Status mis-match');
        System.assertEquals(RSMSupport.SO_STATUS_OPEN, 
                                picklistLines[2].Status__c, 'PickList line Status mis-match');*/
    }
    
    // Test cancel all RSM lines which update RSM Status to cancelled
    static testMethod void testCancelAllRSMLines_UpdateRSMStatusAsCancelled(){
        
        // Get data created from setup
        retrieveData();
        Test.startTest();
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = TestUtilData.createRSM(pickListObj, true);
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj.Id, false);
        rsmLineObj.Sales_Order_Line__c = soLines[0].Id;
        insert rsmLineObj;
        
        PageReference pageRef = Page.CancelRSMLine;
        pageRef.getParameters().put('id', rsmLineObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmLineObj);
        CancelRSMLineController controllerObj = new CancelRSMLineController(stdController);
        
        pageRef = controllerObj.cancelRSMLine();
        /*System.assertEquals('/'+String.valueOf(rsmLineObj.Id).subString(0, 15), 
                            pageRef.getURL(), 'Page reference mis-match');*/
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        //System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match'); 
        
        // Verify updated RSM line status
        rsmLineObj = [Select SMLine_Status__c From Shipping_Manifest_Line__c
                      Where Id =: rsmLineObj.Id];
        
        /*System.assertEquals(RSMSupport.STATUS_CANCELLED, 
                            rsmLineObj.SMLine_Status__c, 'RSM line Status mis-match');*/
                            
        // Verify updated RSM status as cancelled
        rsmObj = [Select Status__c From Shipping_Manifest__c Where Id =: rsmObj.Id];
        
        /*System.assertEquals(RSMSupport.STATUS_CANCELLED, 
                            rsmObj.Status__c, 'RSM Status mis-match');*/
        
        // Verify updated inventory position with default location and blank rack, rack level and bin location
        invPositions = [Select Inventory_Location__c, Rack__c, Rack_Level__c, Bin_Location__c From Inventory_Position__c LIMIT 1];
       // System.assertEquals(defaultLocation.Id, invPositions[0].Inventory_Location__c, 'Inventory Location mis-match');
                            
        System.assertEquals(null, invPositions[0].Rack__c, 'Rack mis-match');
                            
        System.assertEquals(null, invPositions[0].Rack_Level__c, 'Rack Level mis-match');
                            
        System.assertEquals(null, invPositions[0].Bin_Location__c, 'Bin Location mis-match');
        
        Test.stopTest();
        /*// Verify update SO line status as Rejected
        soLines = [Select Id, Status__c from Sales_Order_Line__c];
        System.assertEquals(RSMSupport.SO_STATUS_REJECTED, 
                            soLines[0].Status__c, 'RSM line Status mis-match');
        
        // Verify updated Invoice line(related to SO line) status as Rejected
        invLines = [Select Id, InvoiceLine_Status__c from Invoice_Line__c];
        System.assertEquals(RSMSupport.SO_STATUS_REJECTED, 
                            invLines[0].InvoiceLine_Status__c, 'Invoice line Status mis-match');
                            
        // Verify updated ETR line(related to invoice line) status as Rejected
        etrLines = [Select Id, ETRLine_Status__c from Excise_Tax_Receipt_Line__c];
        System.assertEquals(RSMSupport.SO_STATUS_REJECTED, 
                            etrLines[0].ETRLine_Status__c, 'ETR line Status mis-match');
                            
        // Verify related picklist line record should be cancelled
        List<PickList_Line__c> picklistLines = [Select Status__c From PickList_Line__c];
        System.assertEquals(RSMSupport.STATUS_CANCELLED, 
                                picklistLines[0].Status__c, 'PickList line Status mis-match');
        System.assertEquals(RSMSupport.SO_STATUS_OPEN, 
                                picklistLines[1].Status__c, 'PickList line Status mis-match');
        System.assertEquals(RSMSupport.SO_STATUS_OPEN, 
                                picklistLines[2].Status__c, 'PickList line Status mis-match');*/
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
                               From Inventory_Position__c];
                               
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Site__c,
                                Brand_Quote__c,
                                Customer_PO_or_Quote__c,
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
                                Supplier_Name__c
                                from Sales_Order__c];
        
        soLines = new List<Sales_Order_Line__c>();
        soLines = [Select Id, Status__c from Sales_Order_Line__c];
        
        // Update SO lines in Inventory positions
        for(Integer i=0; i<invPositions.size(); i++){
            invPositions[i].Sales_Order_Line__c = soLines[i].Id;
        }
        update invPositions;
        
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, 'Open', true);
        
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
                
        picklistLines = new List<PickList_Line__c>();
        picklistLines = [Select Product_Name__c,
                               Sales_Order_Line__r.Product_Name__c,
                               Sales_Order_Line__r.Product_Title__c,
                               Sales_Order_Line__r.Qty_Allocated__c,
                               Sales_Order_Line__r.Retail_Wholesale_Price__c,
                               Sales_Order_Line__r.UID__c,
                               Inventory_Location__c
                        From Picklist_Line__c];
        
        // Create Inventory Location, Rack, Rack Level and Bin Location with Vehicle name
        List<Inventory_Location__c> invLocations = [Select Name, Site_Name__c from Inventory_Location__c];
        defaultLocation = invLocations[0].clone(false, true);
        defaultLocation.Name = Label.Default_Inventory_Location;
        insert defaultLocation;
        
        // Retrieve invoice and lines
        invoiceObj = new Invoice__c();
        invoiceObj = [Select AR_Status__c from Invoice__c];
        
        invLines = new List<Invoice_Line__c>();
        invLines = [Select InvoiceLine_Status__c From Invoice_Line__c];
        
        // Create ETR and lines
        etrObj = TestUtilData.CreateETR(invoiceObj, salesOrderObj, true);
        
        etrLines = new List<Excise_Tax_Receipt_Line__c>();
        for(Integer i=0; i<invLines.size(); i++){
            etrLines.add(new Excise_Tax_Receipt_Line__c(Excise_Tax_Receipt__c = etrObj.Id,
                                                        Invoice_Line__c = invLines[i].Id));
        }
        insert etrLines;
    }
}