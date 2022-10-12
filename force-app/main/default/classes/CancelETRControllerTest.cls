/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * CancelETRControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class CancelETRControllerTest{
    
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
    static Excise_Tax_Receipt__c etrObj;
    static Invoice__c invoiceObj;
    
    // Test Validate already ETR cancelled
    static testMethod void testValidateCancelETR_AlreadyCancelled(){
        
        // Get data created from setup
        retrieveData();
        
        // Create ETR with cancelled status
        etrObj = TestUtilData.CreateETR(invoiceObj, salesOrderObj, false);
        etrObj.ETR_Status__c = CancelETRController.STATUS_CANCELLED;
        insert etrObj;
        
        PageReference pageRef = Page.CancelETR;
        pageRef.getParameters().put('id', etrObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(etrObj);
        CancelETRController controllerObj = new CancelETRController(stdController);
        
        pageRef = controllerObj.cancelETR();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Already_Cancelled_ETR), 'Validation message mis-match');
    }
    
    // Test pass all validations and update ETR and  ETR line status
    static testMethod void testCancelETRAndLines(){
        
        // Get data created from setup
        retrieveData();
        
        // Create ETR with draft status
        etrObj = TestUtilData.CreateETR(invoiceObj, salesOrderObj, true);
        
        List<Excise_Tax_Receipt_Line__c> etrLines = new List<Excise_Tax_Receipt_Line__c>();
        etrLines.add(new Excise_Tax_Receipt_Line__c(Excise_Tax_Receipt__c = etrObj.Id));
        insert etrLines;
        
        PageReference pageRef = Page.CancelETR;
        pageRef.getParameters().put('id', etrObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(etrObj);
        CancelETRController controllerObj = new CancelETRController(stdController);
        
        pageRef = controllerObj.cancelETR();
        System.assertEquals('/'+String.valueOf(etrObj.Id).subString(0, 15), 
                            pageRef.getURL(), 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match'); 
        
        // Verify updated ETR status
        etrObj = [Select ETR_Status__c From Excise_Tax_Receipt__c
                      Where Id =: etrObj.Id];
        System.assertEquals(CancelETRController.STATUS_CANCELLED, 
                            etrObj.ETR_Status__c, 'ETR Status mis-match');
        
        // Verify updated ETR line status
        etrLines = [Select ETRLine_Status__c From Excise_Tax_Receipt_Line__c
                      Where Excise_Tax_Receipt__c =: etrObj.Id];
        
        System.assertEquals(1, etrLines.size(), 'Number of ETR lines mis-match'); 
        for(Excise_Tax_Receipt_Line__c etrLineSO : etrLines){
            System.assertEquals(CancelETRController.STATUS_CANCELLED, 
                                etrLineSO.ETRLine_Status__c, 'ETR line Status mis-match');
        }
    }
    
    @TestSetUp
    static void testDataSetUp(){
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
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        
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
        
        rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Sales_Order__c = salesOrderObj.Id;
        insert rsmObj;
        
        List<Shipping_Manifest_Line__c> rsmLines = new List<Shipping_Manifest_Line__c>();
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj.Id, false);
        rsmLineObj.Sales_Order_Line__c = soLines[0].Id;
        rsmLines.add(rsmLineObj);
        
        Shipping_Manifest_Line__c rsmLineObj1 = TestUtilData.createRSMLine(pickListLines[1], rsmObj.Id, false);
        rsmLineObj1.Sales_Order_Line__c = soLines[1].Id;
        rsmLines.add(rsmLineObj1);
        
        insert rsmLines;
        
        invoiceObj = new Invoice__c();
        invoiceObj = [Select Id from Invoice__c];
    }
}