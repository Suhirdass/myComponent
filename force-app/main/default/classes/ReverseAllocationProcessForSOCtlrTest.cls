/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * ReverseAllocationProcessForSOCtlrTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class ReverseAllocationProcessForSOCtlrTest{
    
    static Sales_Order__c salesOrderObj;
    static List<Sales_Order_Line__c> soLines;
    static List<Inventory_Position__c> invPositions;
    
    // Test Reverse allocation process - One SO line to one Inventory Position
    static testMethod void testReverseAllocationProcess_OneSOLineToOneInvPosition(){
        Test.startTest();
        // Get data created from setup
        retrieveData();
        
        // Update SO, SO lines and Inventory position to support allocation process
        salesOrderObj.Allocated__c = true;
        update salesOrderObj;
        
        System.assertEquals(3, invPositions.size(), 'Inventory positions size mis-match');
        Integer counter = 0;
        for(Inventory_Position__c invPositionObj : invPositions){
            invPositionObj.Qty_On_Hand__c = 0.0;
            invPositionObj.Qty_Allocated__c = 20.0;
            invPositionObj.Sales_Order_Line__c = soLines[counter].Id;
            counter++;
        }
        update invPositions;
        
        System.assertEquals(3, soLines.size());
        for(Sales_Order_Line__c soLineObj : soLines){
            soLineObj.Status__c = SalesOrderSupport.SO_LINE_STATUS_ALLOCATED;
            soLineObj.Qty_Allocated__c = 20.0;
        }
        update soLines;
        
        PageReference pageRef = Page.ReverseAllocationProcessForSO;
        pageRef.getParameters().put('id', salesOrderObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderObj);
        ReverseAllocationProcessForSOController controllerObj = new ReverseAllocationProcessForSOController(stdController);
        
        pageRef = controllerObj.reverseAllocationProcess();
        System.assertEquals('/'+String.valueOf(salesOrderObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        // Get updated data after reverse allocation process
        retrieveData();
        
        // Verify SO, SO lines and inventory positions data
        System.assertEquals(false, salesOrderObj.Allocated__c, 'SO Allocated flag mis-match');
        
        System.assertEquals(3, invPositions.size(), 'Inventory positions size mis-match');
        for(Inventory_Position__c invPositionObj : invPositions){
            System.assertEquals(20.0, invPositionObj.Qty_On_Hand__c, 'Qty on hand of Inventory position mis-match');
            System.assertEquals(0.0, invPositionObj.Qty_Allocated__c, 'Qty Allocated of Inventory position mis-match');
            System.assertEquals(null, invPositionObj.Sales_Order_Line__c, 'SO line of Inventory position mis-match');
        }
        
        System.assertEquals(3, soLines.size(), 'SO lines size mis-match');
        for(Sales_Order_Line__c soLineObj : soLines){
            System.assertEquals(0.0, soLineObj.Qty_Allocated__c, 'Qty Allocated of SO line mis-match');
            System.assertEquals(SalesOrderSupport.SO_LINE_STATUS_OPEN, 
                                soLineObj.Status__c, 
                                'Status of SO line mis-match');
        }
        Test.stopTest();
    }
    
    // Test Reverse allocation process - One SO line to many Inventory Positions
    static testMethod void testReverseAllocationProcess_OneSOLineToManyInvPositions(){
        
        // Get data created from setup
        retrieveData();
        
        // Update SO, SO lines and Inventory position to support allocation process
        salesOrderObj.Allocated__c = true;
        update salesOrderObj;
        
        System.assertEquals(3, invPositions.size(), 'Inventory positions size mis-match');
        
        // One SO line is related with two inventory position 
        // last SO line is not related with any inventory position
        for(Inventory_Position__c invPositionObj : invPositions){
            invPositionObj.Qty_On_Hand__c = 0.0;
            invPositionObj.Qty_Allocated__c = 20.0;
        }
        invPositions[0].Sales_Order_Line__c = soLines[0].Id;
        invPositions[1].Sales_Order_Line__c = soLines[0].Id;
        invPositions[2].Sales_Order_Line__c = soLines[1].Id;
        update invPositions;
        
        System.assertEquals(3, soLines.size());
        soLines[0].Status__c = SalesOrderSupport.SO_LINE_STATUS_ALLOCATED;
        soLines[0].Qty_Allocated__c = 40;
        soLines[1].Status__c = SalesOrderSupport.SO_LINE_STATUS_ALLOCATED;
        soLines[1].Qty_Allocated__c = 20;
        soLines[1].Status__c = SalesOrderSupport.SO_LINE_STATUS_BACK_ORDERED;
        soLines[2].Qty_Allocated__c = 0;
        update soLines;
        
        PageReference pageRef = Page.ReverseAllocationProcessForSO;
        pageRef.getParameters().put('id', salesOrderObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderObj);
        ReverseAllocationProcessForSOController controllerObj = new ReverseAllocationProcessForSOController(stdController);
        
        pageRef = controllerObj.reverseAllocationProcess();
        System.assertEquals('/'+String.valueOf(salesOrderObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        // Get updated data after reverse allocation process
        retrieveData();
        
        // Verify SO, SO lines and inventory positions data
        System.assertEquals(false, salesOrderObj.Allocated__c, 'SO Allocated flag mis-match');
        
        System.assertEquals(3, invPositions.size(), 'Inventory positions size mis-match');
        for(Inventory_Position__c invPositionObj : invPositions){
            System.assertEquals(20.0, invPositionObj.Qty_On_Hand__c, 'Qty on hand of Inventory position mis-match');
            System.assertEquals(0.0, invPositionObj.Qty_Allocated__c, 'Qty Allocated of Inventory position mis-match');
            System.assertEquals(null, invPositionObj.Sales_Order_Line__c, 'SO line of Inventory position mis-match');
        }
        
        System.assertEquals(3, soLines.size(), 'SO lines size mis-match');
        
        System.assertEquals(0.0, soLines[0].Qty_Allocated__c, 'Qty Allocated of SO line mis-match');
        System.assertEquals(SalesOrderSupport.SO_LINE_STATUS_OPEN, 
                            soLines[0].Status__c, 
                            'Status of SO line mis-match');
        
        System.assertEquals(0.0, soLines[1].Qty_Allocated__c, 'Qty Allocated of SO line mis-match');
        System.assertEquals(SalesOrderSupport.SO_LINE_STATUS_OPEN, 
                            soLines[1].Status__c, 
                            'Status of SO line mis-match');
        
        System.assertEquals(0.0, soLines[2].Qty_Allocated__c, 'Qty Allocated of SO line mis-match');
        System.assertEquals(SalesOrderSupport.SO_LINE_STATUS_OPEN, 
                            soLines[2].Status__c, 
                            'Status of SO line mis-match');
        
    }
    
    // Test Reverse allocation process 
    // Back ordered status of SO line to open 
    // Cancelled status of SO line should not be changed
    // One SO line to one Inventory Position
    static testMethod void testReverseAllocationProcess_BackOrderedAndCancelledSOLine(){
        Test.startTest();
        // Get data created from setup
        retrieveData();
        
        // Create open Picklist
        Picklist__c picklistObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        List<Picklist__c> picklists = [Select Id from Picklist__c];
        System.assertEquals(1, picklists.size(), 'Picklist size mis-match');
        
        // Update SO, SO lines and Inventory position to support allocation process
        salesOrderObj.Allocated__c = true;
        update salesOrderObj;
        
        System.assertEquals(3, invPositions.size(), 'Inventory positions size mis-match');
        Integer counter = 0;
        for(Inventory_Position__c invPositionObj : invPositions){
            invPositionObj.Qty_On_Hand__c = 0.0;
            invPositionObj.Qty_Allocated__c = 20.0;
            if(counter < 2){
                invPositionObj.Sales_Order_Line__c = soLines[counter].Id;
            }
            counter++;
        }
        update invPositions;
        
        System.assertEquals(3, soLines.size());
        soLines[0].Status__c = SalesOrderSupport.SO_LINE_STATUS_PARTIALLY_ALLOCATED;
        soLines[0].Qty_Allocated__c = 15.0;
        soLines[1].Status__c = SalesOrderSupport.SO_LINE_STATUS_BACK_ORDERED;
        soLines[1].Qty_Allocated__c = 0.0;
        soLines[2].Status__c = SalesOrderSupport.SO_LINE_STATUS_CANCELLED;
        soLines[2].Qty_Allocated__c = 20.0;
        update soLines;
        
        PageReference pageRef = Page.ReverseAllocationProcessForSO;
        pageRef.getParameters().put('id', salesOrderObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderObj);
        ReverseAllocationProcessForSOController controllerObj = new ReverseAllocationProcessForSOController(stdController);
        ReverseAllocationProcessForSOController.updateSOLinesAndInventoryPositionslight(salesOrderObj.Id);
        pageRef = controllerObj.reverseAllocationProcess();
        System.assertEquals('/'+String.valueOf(salesOrderObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        // Get updated data after reverse allocation process
        retrieveData();
        
        // Verify picklist record associated with sales order is deleted
        picklists = [Select Id from Picklist__c];
        System.assertEquals(0, picklists.size(), 'Picklist size mis-match');
        
        // Verify SO, SO lines and inventory positions data
        System.assertEquals(false, salesOrderObj.Allocated__c, 'SO Allocated flag mis-match');
        
        System.assertEquals(3, invPositions.size(), 'Inventory positions size mis-match');
        counter = 0;
        for(Inventory_Position__c invPositionObj : invPositions){
            if(counter < 2){
                System.assertEquals(20.0, invPositionObj.Qty_On_Hand__c, 'Qty on hand of Inventory position mis-match');
                System.assertEquals(0.0, invPositionObj.Qty_Allocated__c, 'Qty Allocated of Inventory position mis-match');
            }else{
                System.assertEquals(0.0, invPositionObj.Qty_On_Hand__c, 'Qty on hand of Inventory position mis-match');
                System.assertEquals(20.0, invPositionObj.Qty_Allocated__c, 'Qty Allocated of Inventory position mis-match');
            }
            System.assertEquals(null, invPositionObj.Sales_Order_Line__c, 'SO line of Inventory position mis-match');
            counter ++;
        }
        
        System.assertEquals(3, soLines.size(), 'SO lines size mis-match');
        
        counter = 0;
        for(Sales_Order_Line__c soLineObj : soLines){
            
            if(counter < 2){
                System.assertEquals(0.0, soLineObj.Qty_Allocated__c, 'Qty Allocated of SO line mis-match');
                System.assertEquals(SalesOrderSupport.SO_LINE_STATUS_OPEN, 
                                    soLineObj.Status__c, 
                                    'Status of SO line mis-match');
            }else{
                System.assertEquals(20.0, soLineObj.Qty_Allocated__c, 'Qty Allocated of SO line mis-match');
                System.assertEquals(SalesOrderSupport.SO_LINE_STATUS_CANCELLED, 
                                    soLineObj.Status__c, 
                                    'Status of SO line mis-match');
            }
            counter++;
        }
        Test.stopTest();
    }
    
    // Test Reverse allocation process for cancelled SO
    static testMethod void testReverseAllocationProcess_ForCancelledSO(){
        
        // Get data created from setup
        retrieveData();
        
        // Update SO, SO lines and Inventory position to support allocation process
        salesOrderObj.SO_Status__c = SalesOrderSupport.SO_STATUS_CANCELLED;
        update salesOrderObj;
        
        PageReference pageRef = Page.ReverseAllocationProcessForSO;
        pageRef.getParameters().put('id', salesOrderObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderObj);
        ReverseAllocationProcessForSOController controllerObj = new ReverseAllocationProcessForSOController(stdController);
        ReverseAllocationProcessForSOController.updateSOLinesAndInventoryPositionslight(salesOrderObj.Id);
        pageRef = controllerObj.reverseAllocationProcess();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.No_Reverse_Allocation_For_Cancelled_SO), 'Validation message mis-match');
    }
    
    // Test Reverse allocation process for confirmed picklist
    static testMethod void testReverseAllocationProcess_ForConfirmedPicklist(){
        
        // Get data created from setup
        retrieveData();
        
        // Create confirmed Picklist
        Picklist__c picklistObj = TestUtilData.createPicklist(salesOrderObj, 'Confirmed', true);
        
        PageReference pageRef = Page.ReverseAllocationProcessForSO;
        pageRef.getParameters().put('id', salesOrderObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderObj);
        ReverseAllocationProcessForSOController controllerObj = new ReverseAllocationProcessForSOController(stdController);
        ReverseAllocationProcessForSOController.updateSOLinesAndInventoryPositionslight(salesOrderObj.Id);
        
        pageRef = controllerObj.reverseAllocationProcess();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.No_Reverse_Allocation_For_Cancelled_SO), 'Validation message mis-match');
    }
    
    @TestSetUp
    static void testDataSetUp(){
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        invPositions = [Select Qty_On_Hand__c,
                               Qty_Allocated__c,
                               Sales_Order_Line__c
                               From Inventory_Position__c];
                               
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Allocated__c, Site__c from Sales_Order__c];
        
        soLines = new List<Sales_Order_Line__c>();
        soLines = [Select Status__c, Qty_Allocated__c From Sales_Order_Line__c];
    }
}