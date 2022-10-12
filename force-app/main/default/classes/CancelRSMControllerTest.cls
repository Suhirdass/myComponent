/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * CancelRSMControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class CancelRSMControllerTest{
    
    static PickList__c pickListObj;
    static List<PickList_Line__c> pickListLines;
    static Sales_Order__c salesOrderObj;
    static List<Sales_Order_Line__c> soLines;
    static List<Inventory_Position__c> invPositions;
    static Shipping_Manifest__c rsmObj;
    static List<Shipping_Manifest_Line__c> rsmLines;
    static List<Inventory_Location__c> invLocations;
    static Inventory_Location__c defaultLocation;
    static List<Rack__c> racks;
    static List<Rack_Level__c> rackLevels;
    static List<Bin_Location__c> binLocations;
    static Invoice__c invoiceObj;
    static List<Invoice_Line__c> invLines;
    static Excise_Tax_Receipt__c etrObj;
    static List<Excise_Tax_Receipt_Line__c> etrLines;
      static Shipping_Manifest_Line__c rsmlinesIL ;
    
    
    
    // Test Validate already RSM shipment complete
    static testMethod void testValidateCancelRSM_AlreadyShipmentComplete(){
        TestUtilData.skipTrigger = true;
        // Get data created from setup
        retrieveData();
        
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = new Shipping_Manifest__c();
        rsmObj.Status__c = RSMSupport.STATUS_SHIPMENT_COMPLETE;
        rsmObj.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        insert rsmObj;
        
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj.Id, true);
        
        PageReference pageRef = Page.CancelRSM;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        CancelRSMController controllerObj = new CancelRSMController(stdController);
        
        pageRef = controllerObj.retrieveRSMLines();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Cannot_Cancel_RSM), 'Validation message mis-match');
    }
    
    
    // Test Validate already RSM cancelled
    static testMethod void testValidateCancelRSM_AlreadyCancelled(){
        
        TestUtilData.skipTrigger = true;
        // Get data created from setup
        retrieveData();
         
        Account a = new Account(Name = 'Irrational Raccoon, LLC');
        //a.Membership_Level__c = 'Boutique';
        insert a; 
        
         Order__c ord= new Order__c();
        ord.Status__c='Draft';
        ord.Order_Date__c=Date.today();
        ord.Account__c= a.Id;
      //  ord.State_License__c = objStateLicenses.Id;
     //   ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        // Create RSM with planned ship date greater than license expiration date
       Picklist__c   pickListObj1 = TestUtilData.createPicklist(salesOrderObj,'Open',true);
        rsmObj = new Shipping_Manifest__c();
        rsmObj.Picklist__c = pickListObj1.Id;
        rsmObj.Status__c = RSMSupport.STATUS_CANCELLED;
        rsmObj.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        rsmObj.Order_Number__c = ord.id;
        insert rsmObj;
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        //accounts.add(objAccount);  
        insert objAccount;
        
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product KD 1';
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
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        insert objProduct1;
        
        List<Receiving_Line__c> receivingLines = [select id from Receiving_Line__c];
        Inventory_Position__c inv = new Inventory_Position__c();
        inv.Receiving_Line__c=receivingLines[0].ID;
        inv.Product_Name__c=objProduct1.id;
        inv.Qty_On_Hand__c=10;
        insert inv;
        
        
        
        
        List<id> reordsids = new list<id>();
        
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj.Id, false);
        rsmLineObj.SMLine_Status__c = RSMSupport.STATUS_CANCELLED;
       // rsmLineObj.Product_Name__c = objProduct1.Id;
        rsmLineObj.Sales_Order_Line__c = soLines[0].Id;
        insert rsmLineObj;
         system.debug('rsmLineObj>>>'+rsmLineObj);
        reordsids.add(rsmLineObj.Id);
        
        Shipping_Manifest_Line__c rsmLineObj2 = TestUtilData.createRSMLine(pickListLines[1], rsmObj.Id, false);
        rsmLineObj2.SMLine_Status__c = RSMSupport.STATUS_CANCELLED;
        //rsmLineObj2.Product_Name__c = objProduct1.Id;
        rsmLineObj2.Sales_Order_Line__c = soLines[1].Id;
        insert rsmLineObj2;
        reordsids.add(rsmLineObj2.Id); 
       Test.startTest();
        CancelRSMController.getSmLines(rsmObj.Id, rsmObj.Id, invoiceObj.id);
        
        List<Shipping_Manifest_Line__c> listOfLineIds = [SELECT Id,Name FROM Shipping_Manifest_Line__c Limit 2];
        List<id> smLineids = new list<id>();
        smLineids.add(listOfLineIds[0].Id);
        
        Shipping_Manifest__c getSmId = [SELECT Id,Name FROM Shipping_Manifest__c Limit 1];
      
        PageReference pageRef = Page.CancelRSM;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        CancelRSMController controllerObj = new CancelRSMController(stdController);
        CancelRSMController.getShipMan(rsmObj.Id);
        CancelRSMController.getRsmLines(rsmObj.Id);
        String rcId = rsmObj.Id;
     
        CancelRSMController.rsmlinesWrapper rsmlinewapper = new CancelRSMController.rsmlinesWrapper();
        rsmlinewapper.rsmlinesIL = rsmlinesIL;
        
        String JSONStr1 = JSON.serialize(new List<Object>{rsmlinewapper});
       
        List<CancelRSMController.rsmlinesWrapper> rsmlinewapperList = new List<CancelRSMController.rsmlinesWrapper>();
        rsmlinewapperList.add(rsmlinewapper);
        List<Id> lstRecordId = new List<Id>();
        
        CancelRSMController.updateSmLines(smLineids, rcId,true,rsmlinewapperList);
        CancelRSMController.updateOnlyServiceLine(rcId);
        //CancelRSMController.updateOnlyServiceLine()
        
       // CancelRSMController.getDataLight(rsmLines[0].Id , rsmObj.Id, invoiceObj.Id);
        pageRef = controllerObj.retrieveRSMLines();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Already_RSM_Cancelled), 'Validation message mis-match');
    Test.stopTest();
    }
    
    // Test pass all validations and select all RSM lines to cancel
    // update RSM, RSM line status, SO, SO line status and inv positions
    // update Invoice, Invoice lines, ETR and ETR lines
    static testMethod void testCancelAllRSMLines_UpdateRSM_RSMLine_SO_SOLine_InvPositions(){
        TestUtilData.skipTrigger = true;
        // Get data created from setup
        retrieveData();
        
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Sales_Order__c = salesOrderObj.Id;
        insert rsmObj;
        
        List<Shipping_Manifest_Line__c> rsmLines = new List<Shipping_Manifest_Line__c>();
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj.Id, false);
        rsmLineObj.Sales_Order_Line__c = soLines[0].Id;
        rsmLineObj.Shipment_Qty__c = 10;
        rsmLines.add(rsmLineObj);
        
        Shipping_Manifest_Line__c rsmLineObj1 = TestUtilData.createRSMLine(pickListLines[1], rsmObj.Id, false);
        rsmLineObj1.Sales_Order_Line__c = soLines[1].Id;
        rsmLineObj1.Shipment_Qty__c = 10;
        rsmLines.add(rsmLineObj1);
        
        Shipping_Manifest_Line__c rsmLineObj2 = TestUtilData.createRSMLine(pickListLines[2], rsmObj.Id, false);
        rsmLineObj2.Sales_Order_Line__c = soLines[2].Id;
        rsmLineObj2.Shipment_Qty__c = 10;
        rsmLines.add(rsmLineObj2);
        
        insert rsmLines;
       
        Test.startTest();
        PageReference pageRef = Page.CancelRSM;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        // default constructor
        CancelRSMController controllerObj1 = new CancelRSMController();
        
        // standard controller constructor
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        CancelRSMController controllerObj = new CancelRSMController(stdController);
        
        pageRef = controllerObj.retrieveRSMLines();
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match'); 
        
        pageRef = controllerObj.cancelRSMAction();
        // Verify validation messages
        msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match'); 
        System.assert(msgList[0].getDetail().contains(Label.Select_RSM_Line_To_Cancel), 'Validation message mis-match');
        
        // Select RSM lines to cancel
        controllerObj.rsmLines[0].selected = true;
        controllerObj.rsmLines[1].selected = true;
        controllerObj.rsmLines[2].selected = true;
        pageRef = controllerObj.cancelRSMAction();
        System.assertEquals('/'+String.valueOf(rsmObj.Id).subString(0, 15), 
                            pageRef.getURL(), 'Page reference mis-match');
        
        // Verify updated RSM status
        rsmObj = [Select Status__c From Shipping_Manifest__c
                      Where Id =: rsmObj.Id AND RecordTypeId =: ShippinManifestSupport.getRSMRecordTypeId()];
        System.assertEquals(RSMSupport.STATUS_CANCELLED, 
                            rsmObj.Status__c, 'RSM Status mis-match');
        
        // Verify updated RSM line status
        rsmLines = [Select SMLine_Status__c From Shipping_Manifest_Line__c
                      Where Id =: rsmLineObj.Id];
        
        for(Shipping_Manifest_Line__c rsmLineSO : rsmLines){
            System.assertEquals(RSMSupport.STATUS_CANCELLED, 
                                rsmLineSO.SMLine_Status__c, 'RSM line Status mis-match');
        }
        
        // Verify updated inventory position with default location and blank rack, rack level and bin location
        invPositions = [Select Inventory_Location__c, Rack__c, Rack_Level__c, Bin_Location__c From Inventory_Position__c];
            
        for(Inventory_Position__c invPositionSO : invPositions){    
            System.assertEquals(defaultLocation.Id, invPositionSO.Inventory_Location__c, 'Inventory Location mis-match');
                                
            System.assertEquals(null, invPositionSO.Rack__c, 'Rack mis-match');
                                
            System.assertEquals(null, invPositionSO.Rack_Level__c, 'Rack Level mis-match');
                                
            System.assertEquals(null, invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        }
        
        // Verify updated SO status as Rejected
        salesOrderObj = [Select Id, SO_Status__c from Sales_Order__c];
       // System.assertEquals(RSMSupport.SO_STATUS_REJECTED,salesOrderObj.SO_Status__c, 'SO Status mis-match'); 
                            
        
        // Verify updated SO line status as Rejected
        soLines = [Select Id, Status__c from Sales_Order_Line__c];
        for(Sales_Order_Line__c soLineSO : soLines){
          //  System.assertEquals(RSMSupport.SO_STATUS_REJECTED, 
                             //   soLineSO.Status__c, 'SO line Status mis-match');
        }
        
        // Verify updated Invoice(related to SO) status as Rejected
        invoiceObj = [Select Id, AR_Status__c from Invoice__c];
 //System.assertEquals(RSMSupport.SO_STATUS_REJECTED, 
//                          invoiceObj.AR_Status__c, 'Invoice Status mis-match');
        
        // Verify updated Invoice line(related to SO line) status as Rejected
        invLines = [Select Id, InvoiceLine_Status__c from Invoice_Line__c];
        for(Invoice_Line__c invLineSO : invLines){
          //  System.assertEquals(RSMSupport.SO_STATUS_REJECTED, 
                        //        invLineSO.InvoiceLine_Status__c, 'Invoice line Status mis-match');
        }
        
        // Verify updated ETR(related to Invoice) status as Rejected
        etrObj = [Select ETR_Status__c From Excise_Tax_Receipt__c
                      Where Id =: etrObj.Id];
       // System.assertEquals(RSMSupport.SO_STATUS_REJECTED, 
//                            etrObj.ETR_Status__c, 'ETR Status mis-match');
        
        // Verify updated ETR line(related to Invoice line) status as Rejected
        etrLines = [Select Id, ETRLine_Status__c from Excise_Tax_Receipt_Line__c];
        for(Excise_Tax_Receipt_Line__c etrLineSO : etrLines){
          //  System.assertEquals(RSMSupport.SO_STATUS_REJECTED, 
                             //   etrLineSO.ETRLine_Status__c, 'ETR line Status mis-match');
        }
        
        // Verify related picklist should be in draft and selected line record should be cancelled
        pickListObj = [Select Status__c From PickList__c];
      //  System.assertEquals(RSMSupport.STATUS_CANCELLED, 
                         //   pickListObj.Status__c, 'PickList Status mis-match');
                            
        List<PickList_Line__c> picklistLines = [Select Status__c From PickList_Line__c];
      //  System.assertEquals(RSMSupport.STATUS_CANCELLED, 
    //                      //      picklistLines[0].Status__c, 'PickList line Status mis-match');
     //   System.assertEquals(RSMSupport.STATUS_CANCELLED, 
                          //      picklistLines[1].Status__c, 'PickList line Status mis-match');
   //     System.assertEquals(RSMSupport.STATUS_CANCELLED, 
                            //    picklistLines[2].Status__c, 'PickList line Status mis-match');
       //  CancelRSMController.getDataLight(rsmLineObj1.Id , rsmObj.Id, invoiceObj.Id);
        
        Test.stopTest();
    }
    
    // Test pass all validations and select one RSM lines to cancel
    // update RSM line status, SO line status and inv positions
    static testMethod void testCancelPartialRSMLines_UpdateRSMLine_SOLine_InvPositions(){
          TestUtilData.skipTrigger = true;
        // Get data created from setup
        retrieveData();
        
        // Create RSM with planned ship date greater than license expiration date
        rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Sales_Order__c = salesOrderObj.Id;
        insert rsmObj;
        
        List<Shipping_Manifest_Line__c> rsmLines = new List<Shipping_Manifest_Line__c>();
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj.Id, false);
        rsmLineObj.Sales_Order_Line__c = soLines[0].Id;
        rsmLineObj.Shipment_Qty__c = 10;
        rsmLines.add(rsmLineObj);
        
        Shipping_Manifest_Line__c rsmLineObj1 = TestUtilData.createRSMLine(pickListLines[1], rsmObj.Id, false);
        rsmLineObj1.Sales_Order_Line__c = soLines[1].Id;
        rsmLineObj1.Shipment_Qty__c = 10;
        rsmLines.add(rsmLineObj1);
        
        Shipping_Manifest_Line__c rsmLineObj2 = TestUtilData.createRSMLine(pickListLines[2], rsmObj.Id, false);
        rsmLineObj2.Sales_Order_Line__c = soLines[2].Id;
        rsmLineObj2.Shipment_Qty__c = 10;
        rsmLines.add(rsmLineObj2);
        
        insert rsmLines;
        Test.startTest();
        PageReference pageRef = Page.CancelRSM;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        CancelRSMController controllerObj = new CancelRSMController(stdController);
        
        pageRef = controllerObj.retrieveRSMLines();
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match'); 
        
        pageRef = controllerObj.cancelRSMAction();
        // Verify validation messages
        msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match'); 
        System.assert(msgList[0].getDetail().contains(Label.Select_RSM_Line_To_Cancel), 'Validation message mis-match');
        
        // Select one RSM lines to cancel
        controllerObj.rsmLines[0].selected = true;
        pageRef = controllerObj.cancelRSMAction();
        System.assertEquals('/'+String.valueOf(rsmObj.Id).subString(0, 15), 
                            pageRef.getURL(), 'Page reference mis-match');
        
        // Verify RSM status is still draft
        rsmObj = [Select Status__c From Shipping_Manifest__c
                      Where Id =: rsmObj.Id AND RecordTypeId =: ShippinManifestSupport.getRSMRecordTypeId()];
        System.assertEquals(RSMSupport.STATUS_DRAFT, 
                            rsmObj.Status__c, 'RSM Status mis-match');
        
        // Verify updated RSM line status
        rsmLines = [Select SMLine_Status__c From Shipping_Manifest_Line__c
                      Where Id =: rsmLineObj.Id];
        
        Integer counter = 0;
        String status = '';
        for(Shipping_Manifest_Line__c rsmLineSO : rsmLines){
            status = counter == 0 ? RSMSupport.STATUS_CANCELLED : '';
            System.assertEquals(status, 
                                rsmLineSO.SMLine_Status__c, 'RSM line Status mis-match');
            counter++;
        }
        
        // Verify updated inventory position with default location and blank rack, rack level and bin location
        invPositions = [Select Inventory_Location__c, Rack__c, Rack_Level__c, Bin_Location__c From Inventory_Position__c];
            
        counter = 0;
        for(Inventory_Position__c invPositionSO : invPositions){    
            // Inv position related to cancelled RSM line
            if(counter == 0){
                System.assertEquals(defaultLocation.Id, invPositionSO.Inventory_Location__c, 'Inventory Location mis-match');
                                    
                System.assertEquals(null, invPositionSO.Rack__c, 'Rack mis-match');
                                    
                System.assertEquals(null, invPositionSO.Rack_Level__c, 'Rack Level mis-match');
                                    
                System.assertEquals(null, invPositionSO.Bin_Location__c, 'Bin Location mis-match');
            
            // Inv position related to non cancelled RSM line
            }else{
                System.assertNotEquals(defaultLocation.Id, invPositionSO.Inventory_Location__c, 'Inventory Location mis-match');
                                
                System.assertEquals(racks[0].Id, invPositionSO.Rack__c, 'Rack mis-match');
                                    
                System.assertEquals(rackLevels[0].Id, invPositionSO.Rack_Level__c, 'Rack Level mis-match');
                                    
                System.assertEquals(binLocations[0].Id, invPositionSO.Bin_Location__c, 'Bin Location mis-match');
            }
            counter++;
        }
        
        // Verify SO status is still as Draft
        salesOrderObj = [Select Id, SO_Status__c from Sales_Order__c];
        System.assertEquals(RSMSupport.STATUS_DRAFT, 
                            salesOrderObj.SO_Status__c, 'SO Status mis-match');
        
        // Verify updated SO line status as Rejected
        soLines = [Select Id, Status__c from Sales_Order_Line__c];
        counter = 0;
        status = '';
        for(Sales_Order_Line__c soLineSO : soLines){
            status = counter == 0 ? RSMSupport.SO_STATUS_REJECTED : RSMSupport.SO_STATUS_OPEN;
           // System.assertEquals(status, 
                               // soLineSO.Status__c, 'SO line Status mis-match');
            counter++;
        }
        
        // Verify Invoice(related to SO) status is still as Draft
        invoiceObj = [Select Id, AR_Status__c from Invoice__c];
        System.assertEquals(RSMSupport.STATUS_DRAFT, 
                            invoiceObj.AR_Status__c, 'Invoice Status mis-match');
        
        // Verify updated Invoice line(related to SO line) status as Rejected
        invLines = [Select Id, InvoiceLine_Status__c from Invoice_Line__c];
        counter = 0;
        status = '';
        for(Invoice_Line__c invLineSO : invLines){
            status = counter == 0 ? RSMSupport.SO_STATUS_REJECTED : RSMSupport.STATUS_DRAFT;
           // System.assertEquals(status, 
                              //  invLineSO.InvoiceLine_Status__c, 'Invoice line Status mis-match');
            counter++;
        }
        
        // Verify ETR(related to invoice) status is still as Draft
        etrObj = [Select ETR_Status__c From Excise_Tax_Receipt__c
                      Where Id =: etrObj.Id];
        System.assertEquals(RSMSupport.STATUS_DRAFT, 
                            etrObj.ETR_Status__c, 'ETR Status mis-match');
                            
        // Verify updated ETR line(related to invoice line) status as Rejected
        etrLines = [Select Id, ETRLine_Status__c from Excise_Tax_Receipt_Line__c];
        counter = 0;
        status = '';
        for(Excise_Tax_Receipt_Line__c etrLineSO : etrLines){
            status = counter == 0 ? RSMSupport.SO_STATUS_REJECTED : RSMSupport.STATUS_DRAFT;
           // System.assertEquals(status, 
                               // etrLineSO.ETRLine_Status__c, 'ETR line Status mis-match');
            counter++;
        }
        
        // Verify related picklist should be in draft and selected line record should be cancelled
        pickListObj = [Select Status__c From PickList__c];
       // System.assertEquals(RSMSupport.SO_STATUS_OPEN,  pickListObj.Status__c, 'PickList Status mis-match');
        List<PickList_Line__c> picklistLines = [Select Status__c From PickList_Line__c];
        System.assertEquals(RSMSupport.STATUS_CANCELLED, picklistLines[0].Status__c, 'PickList line Status mis-match'); 
       // System.assertEquals(RSMSupport.SO_STATUS_OPEN, picklistLines[1].Status__c, 'PickList line Status mis-match'); 
        //System.assertEquals(RSMSupport.SO_STATUS_OPEN, picklistLines[2].Status__c, 'PickList line Status mis-match');
                                
        
        // If Cancel RSM is again clicked then 
        // verify first RSM line is already cancelled so it should be disabled while displaying on UI to cancel
        controllerObj = new CancelRSMController(stdController);
        pageRef = controllerObj.retrieveRSMLines();
        
        counter = 0;
        for(RSMLineWrapper rsmLineWrapperSO : controllerObj.rsmLines){
            if(counter == 0){
                System.assertEquals(true, rsmLineWrapperSO.disabled, 'RSM line should be disabled'); 
            }else{
                System.assertEquals(false, rsmLineWrapperSO.disabled, 'RSM line should not be disabled'); 
            }
            counter++;
        }
        
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
                               Inventory_Location__r.Name,
                               Inventory_Location__c,
                               Rack__c,
                               Rack_Level__c,
                               Bin_Location__c
                               From Inventory_Position__c];
                               
        racks = [Select Id, Inventory_Location__c From Rack__c ORDER BY NAME];
        rackLevels = [Select Id From Rack_Level__c ORDER BY NAME];
        binLocations = [Select Id From Bin_Location__c ORDER BY NAME];
                               
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
            invPositions[i].Inventory_Location__c = racks[0].Inventory_Location__c;
            invPositions[i].Sales_Order_Line__c = soLines[i].Id;
            invPositions[i].Rack__c = racks[0].Id;
            invPositions[i].Rack_Level__c = rackLevels[0].Id;
            invPositions[i].Bin_Location__c = binLocations[0].Id;
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
            invLines[i].InvoiceLine_Status__c = 'Draft';
            etrLines.add(new Excise_Tax_Receipt_Line__c(Excise_Tax_Receipt__c = etrObj.Id,
                                                        Invoice_Line__c = invLines[i].Id,
                                                        ETRLine_Status__c = 'Draft'));
        }
        update invLines;
        insert etrLines;
        
        
    }
}