/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * PutAwayInventoryControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class PutAwayInventoryControllerTest{
    
    static List<Inventory_Position__c> invPositions;
    static List<Rack__c> racks;
    static List<Rack_Level__c> rackLevels;
    static List<Bin_Location__c> binLocations;
    static List<Inventory_Location__c> invLocations;
    
    // Test loading of VF page to retrieve inventory positions and verify pagination logic
    static testMethod void testRetrieveInventoryPositionsAndPagination(){
         test.startTest();
        PutAwayInventoryController controllerObj = new PutAwayInventoryController();
        controllerObj.pageSize = '2';
        
        // load page size picklist
        controllerObj.getPageSizeOptions();
        controllerObj.retrieveInventoryPositions(); 
        
        // get total inventory positions 
        System.assertEquals(4, controllerObj.inventoryPositions.size(), 'Total Inventory positions mis-match');
        System.assertEquals(2, controllerObj.inventoryPositionsIterable.totalPages, 'Total pages mis-match');
        System.assertEquals(true, controllerObj.hasInventoryPosition, 'Inventory position flag mis-match');
        
        // get inventory positions displayed per page based on page size
        // first page of pagination
        System.assertEquals(2, controllerObj.setInventoryPositions.size(),  'Inventory positions per page mis-match');
        System.assertEquals(true, controllerObj.hasNextInventoryPositions, 'Next link visible flag mis-match');
        System.assertEquals(false, controllerObj.hasPreviousInventoryPositions, 'Previous link visible flag mis-match');
        System.assertEquals(1, controllerObj.inventoryPositionsIterable.currentPage, 'Current page number mis-match');
        
        // next action of pagination
        controllerObj.nextInventoryPositions();
        System.assertEquals(2, controllerObj.setInventoryPositions.size(),  'Inventory positions per page mis-match');
        System.assertEquals(false, controllerObj.hasNextInventoryPositions, 'Next link visible flag mis-match');
        System.assertEquals(true, controllerObj.hasPreviousInventoryPositions, 'Previous link visible flag mis-match');
        System.assertEquals(2, controllerObj.inventoryPositionsIterable.currentPage, 'Current page number mis-match');
        
        // previous action of pagination
        controllerObj.previousInventoryPositions();
        System.assertEquals(2, controllerObj.setInventoryPositions.size(),  'Inventory positions per page mis-match');
        System.assertEquals(true, controllerObj.hasNextInventoryPositions, 'Next link visible flag mis-match');
        System.assertEquals(false, controllerObj.hasPreviousInventoryPositions, 'Previous link visible flag mis-match');
        System.assertEquals(1, controllerObj.inventoryPositionsIterable.currentPage, 'Current page number mis-match');
        
        // last action of pagination
        controllerObj.lastInventoryPositions();
        //System.assertEquals(1, controllerObj.setInventoryPositions.size(),  'Inventory positions per page mis-match');
        System.assertEquals(false, controllerObj.hasNextInventoryPositions, 'Next link visible flag mis-match');
        System.assertEquals(true, controllerObj.hasPreviousInventoryPositions, 'Previous link visible flag mis-match');
        System.assertEquals(2, controllerObj.inventoryPositionsIterable.currentPage, 'Current page number mis-match');
        
        // first action of pagination
        controllerObj.firstInventoryPositions();
        System.assertEquals(2, controllerObj.setInventoryPositions.size(),  'Inventory positions per page mis-match');
        System.assertEquals(true, controllerObj.hasNextInventoryPositions, 'Next link visible flag mis-match');
        System.assertEquals(false, controllerObj.hasPreviousInventoryPositions, 'Previous link visible flag mis-match');
        System.assertEquals(1, controllerObj.inventoryPositionsIterable.currentPage, 'Current page number mis-match');
        
        // reset page size
        controllerObj.pageSize = '10';
        controllerObj.doResetInventoryPositionsPageSize();
        System.assertEquals(1, controllerObj.inventoryPositionsIterable.totalPages, 'Total pages mis-match');
        System.assertEquals(4, controllerObj.setInventoryPositions.size(),  'Inventory positions per page mis-match');
        System.assertEquals(false, controllerObj.hasNextInventoryPositions, 'Next link visible flag mis-match');
        System.assertEquals(false, controllerObj.hasPreviousInventoryPositions, 'Previous link visible flag mis-match');
     test.stopTest();
    }
    
    // Test cancel button action
    static testMethod void testCancelAction(){
        test.startTest();
        PutAwayInventoryController controllerObj = new PutAwayInventoryController();
        controllerObj.retrieveInventoryPositions(); 
        PageReference pageRef = controllerObj.cancelAction();
        System.assertEquals('/apex/PutAwayInventory', pageRef.getURL(), 'Page reference mis-match');
        test.stopTest();
    }
    
    // Test validation 1 - No inventory position selected and user selected update button
    static testMethod void testInventoryPoistionsValidation1(){
          test.startTest();
        PutAwayInventoryController controllerObj = new PutAwayInventoryController();
        controllerObj.pageSize = '2';
        controllerObj.retrieveInventoryPositions();
        PageReference pageRef = controllerObj.updateInventoryLocations();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.No_Inventory_Position_Selected), 'Validation message mis-match');
     test.stopTest();
    }
    
    // Test validation 2
    // Qty to put away must be positive value
    // Qty to put away cannot be greater than qty on hand
    // Rack, Rack Level, Bin Location cannot be null
    static testMethod void testInventoryPoistionsValidation2(){
          test.startTest();
        PutAwayInventoryController controllerObj = new PutAwayInventoryController();
        controllerObj.retrieveInventoryPositions();
        System.debug('$$$$$'+controllerObj);
        System.debug('$$$$$'+controllerObj.setInventoryPositions);
        // Select inventory position and provide qty to put away values
        controllerObj.setInventoryPositions[0].isSelected = true;
        controllerObj.setInventoryPositions[0].qtyToPutAway = -5; // negative value
        controllerObj.setInventoryPositions[1].isSelected = true;
        controllerObj.setInventoryPositions[1].qtyToPutAway = 100; // greater than qty on hand
        controllerObj.setInventoryPositions[2].isSelected = true;
        controllerObj.setInventoryPositions[2].qtyToPutAway = 5; // no rack selected
        
        PageReference pageRef = controllerObj.updateInventoryLocations();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(3, msgList.size(), 'Number of Validation messages mis-match');
        
        String errorMessage1 = String.format(Label.Qty_To_Put_Away_Positive_Value, 
                        new List<String>{controllerObj.setInventoryPositions[0].invPositionSO.Product_Name__r.Name});
        System.assert(msgList[0].getDetail().contains(errorMessage1), 'Validation message mis-match');
        
        String errorMessage2 = String.format(Label.Qty_To_Put_Away_Cannot_Be_Greater_Than_Qty_On_Hand, 
                         new List<String>{controllerObj.setInventoryPositions[1].invPositionSO.Product_Name__r.Name});
        System.assert(msgList[1].getDetail().contains(errorMessage2), 'Validation message mis-match');
        
        String errorMessage3 = String.format(Label.Rack_Rack_Level_Bin_Location_Cannot_Be_Null, 
                         new List<String>{controllerObj.setInventoryPositions[2].invPositionSO.Product_Name__r.Name});
        System.assert(msgList[2].getDetail().contains(errorMessage3), 'Validation message mis-match');
    test.stopTest();
    }
    
    // Test validation 3
    // Qty to put away is greater than balance qty to put away
    static testMethod void testInventoryPoistionsValidation3(){
        Test.startTest();
        retrieveData();
        PutAwayInventoryController controllerObj = new PutAwayInventoryController();
        controllerObj.retrieveInventoryPositions();
        
        // Select inventory position and provide qty to put away values
        controllerObj.setInventoryPositions[0].isSelected = true;
        controllerObj.setInventoryPositions[0].qtyToPutAway = 5; 
        controllerObj.setInventoryPositions[0].invPositionSO.Rack__c = racks[0].Id;
        
        // Specify rack, rack level and bin location for first inventory position
        System.assertEquals(5, controllerObj.setInventoryPositions[0].invPositionSO.Qty_On_Hand__c, 'Qty on hand mis-match');
        
        System.assertEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        // load rack level, bin loaction and qty to put away
        controllerObj.selectedInvPositionId = controllerObj.setInventoryPositions[0].invPositionSO.Id;
        controllerObj.selectedRackId = racks[0].Id;
        
        controllerObj.loadRackLevels();
        
        controllerObj.setInventoryPositions[0].invPositionSO.Rack_Level__c = rackLevels[0].Id;
        controllerObj.selectedRackLevelId = rackLevels[0].Id;
        System.assertNotEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        
        System.assertEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        controllerObj.loadBinLocations();
        controllerObj.selectedBinLocationId = binLocations[0].Id;
        controllerObj.setInventoryPositions[0].invPositionSO.Bin_Location__c = binLocations[0].Id;
        System.assertNotEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(4, controllerObj.setInventoryPositions[0].balanceQtyToPutAway, 'Balance qty to put away mis-match');
        
        PageReference pageRef = controllerObj.updateInventoryLocations();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        
        String errorMessage1 = String.format(Label.Bin_Location_Capacity_Validation, 
                                        new List<String>{binLocations[0].Name,
                                        String.valueOf(controllerObj.setInventoryPositions[0].qtyToPutAway),
                                        controllerObj.setInventoryPositions[0].invPositionSO.Product_Name__r.Name});
        System.assert(msgList[0].getDetail().contains(errorMessage1), 'Validation message mis-match');
        Test.stopTest();
    }
    
    // Test validation 4
    // Total specified qty to put away vs available capacity of selected bin location
    static testMethod void testInventoryPoistionsValidation4(){
        Test.startTest();
        retrieveData();
        PutAwayInventoryController controllerObj = new PutAwayInventoryController();
        controllerObj.retrieveInventoryPositions();
        
        // Select inventory position and provide qty to put away values
        // Qty to put away is less than balance qty to put away for individual inventory position
        // But total qty to put away exceeds available capacity of selected bin locations
        
        // select first inventory position
        controllerObj.setInventoryPositions[0].isSelected = true;
        controllerObj.setInventoryPositions[0].qtyToPutAway = 4; 
        controllerObj.setInventoryPositions[0].invPositionSO.Rack__c = racks[0].Id;
        
        // Specify rack, rack level and bin location for first inventory position
        System.assertEquals(5, controllerObj.setInventoryPositions[0].invPositionSO.Qty_On_Hand__c, 'Qty on hand mis-match');
        
        System.assertEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        // load rack level, bin loaction and qty to put away
        controllerObj.selectedInvPositionId = controllerObj.setInventoryPositions[0].invPositionSO.Id;
        controllerObj.selectedRackId = racks[0].Id;
        
        controllerObj.loadRackLevels();
        
        controllerObj.setInventoryPositions[0].invPositionSO.Rack_Level__c = rackLevels[0].Id;
        controllerObj.selectedRackLevelId = rackLevels[0].Id;
        System.assertNotEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        
        System.assertEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        controllerObj.loadBinLocations();
        controllerObj.selectedBinLocationId = binLocations[0].Id;
        controllerObj.setInventoryPositions[0].invPositionSO.Bin_Location__c = binLocations[0].Id;
        System.assertNotEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(4, controllerObj.setInventoryPositions[0].balanceQtyToPutAway, 'Balance qty to put away mis-match');
        
        // select second inventory position
        controllerObj.setInventoryPositions[1].isSelected = true;
        controllerObj.setInventoryPositions[1].qtyToPutAway = 2; 
        controllerObj.setInventoryPositions[1].invPositionSO.Rack__c = racks[0].Id;
        
        // Specify rack, rack level and bin location for second inventory position
        System.assertEquals(10, controllerObj.setInventoryPositions[1].invPositionSO.Qty_On_Hand__c, 'Qty on hand mis-match');
        
        System.assertEquals(null, controllerObj.setInventoryPositions[1].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        // load rack level, bin loaction and qty to put away
        controllerObj.selectedInvPositionId = controllerObj.setInventoryPositions[1].invPositionSO.Id;
        controllerObj.selectedRackId = racks[0].Id;
        
        controllerObj.loadRackLevels();
        
        controllerObj.setInventoryPositions[1].invPositionSO.Rack_Level__c = rackLevels[0].Id;
        controllerObj.selectedRackLevelId = rackLevels[0].Id;
        System.assertNotEquals(null, controllerObj.setInventoryPositions[1].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        
        System.assertEquals(null, controllerObj.setInventoryPositions[1].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        controllerObj.loadBinLocations();
        controllerObj.selectedBinLocationId = binLocations[0].Id;
        controllerObj.setInventoryPositions[1].invPositionSO.Bin_Location__c = binLocations[0].Id;
        System.assertNotEquals(null, controllerObj.setInventoryPositions[1].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(4, controllerObj.setInventoryPositions[1].balanceQtyToPutAway, 'Balance qty to put away mis-match');
        
        PageReference pageRef = controllerObj.updateInventoryLocations();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        
        System.assert(msgList[0].getDetail().contains('exceeds available capacity'), 'Validation message mis-match');
        Test.stopTest();
    }

    // Update inventory position with new rack/rack level/bin location - Total qty on hand  put away
    static testMethod void testUpdateInventoryPositionWithTotalQtyOnHand(){
        Test.startTest();
        retrieveData();
        
        // Update qty on hand of first inventory position as 4
        invPositions[0].Qty_On_Hand__c = 4.0;
        update invPositions[0];
        
        // verify existing values of first inventory position
        System.assertEquals(4, invPositions.size(), 'Size of inventory positions mis-match');
        System.assertEquals(4, invPositions[0].Qty_On_Hand__c, 'Qty on hand mis-match');
        System.assertEquals(null, invPositions[0].Rack__c, 'Rack mis-match');
        System.assertEquals(null, invPositions[0].Rack_Level__c, 'Rack level mis-match');
        System.assertEquals(null, invPositions[0].Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(Label.Default_Inventory_Location, invPositions[0].Inventory_Location__r.Name, 'Inventory Location mis-match');
        
        PutAwayInventoryController controllerObj = new PutAwayInventoryController();
        controllerObj.retrieveInventoryPositions();
        
        // select first inventory position
        controllerObj.setInventoryPositions[0].isSelected = true;
        controllerObj.setInventoryPositions[0].qtyToPutAway = 4; 
        
        // Specify rack, rack level and bin location for first inventory position
        controllerObj.setInventoryPositions[0].invPositionSO.Rack__c = racks[0].Id;
        controllerObj.selectedInvPositionId = controllerObj.setInventoryPositions[0].invPositionSO.Id;
        controllerObj.selectedRackId = racks[0].Id;
        
        controllerObj.loadRackLevels();
        
        controllerObj.setInventoryPositions[0].invPositionSO.Rack_Level__c = rackLevels[0].Id;
        controllerObj.selectedRackLevelId = rackLevels[0].Id;
        System.assertNotEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        
        System.assertEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        controllerObj.loadBinLocations();
        controllerObj.selectedBinLocationId = binLocations[0].Id;
        controllerObj.setInventoryPositions[0].invPositionSO.Bin_Location__c = binLocations[0].Id;
        System.assertNotEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(4, controllerObj.setInventoryPositions[0].balanceQtyToPutAway, 'Balance qty to put away mis-match');
        
        PageReference pageRef = controllerObj.updateInventoryLocations();
        System.assertEquals('/apex/PutAwayInventory', pageRef.getURL(), 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        
        // Retrieve updated inventory positions
        retrieveData();
        //System.assertEquals(3, invPositions.size(), 'Size of inventory positions mis-match');
        System.assertEquals(racks[0].Id, invPositions[0].Rack__c, 'Rack mis-match');
        System.assertEquals(rackLevels[0].Id, invPositions[0].Rack_Level__c, 'Rack level mis-match');
        System.assertEquals(binLocations[0].Id, invPositions[0].Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(4, invPositions[0].Qty_On_Hand__c, 'Qty on hand mis-match');
        System.assertEquals('Test Location', invPositions[0].Inventory_Location__r.Name, 'Inventory Location mis-match');
        Test.stopTest();
    }
    
    // Update inventory position with new rack/rack level/bin location - Partial qty on hand  put away
    static testMethod void testUpdateInventoryPositionWithPartialQtyOnHand(){
        Test.startTest();
        retrieveData();
        
        // verify existing values of first inventory position
        System.assertEquals(4, invPositions.size(), 'Size of inventory positions mis-match');
        System.assertEquals(5, invPositions[0].Qty_On_Hand__c, 'Qty on hand mis-match');
        System.assertEquals(null, invPositions[0].Rack__c, 'Rack mis-match');
        System.assertEquals(null, invPositions[0].Rack_Level__c, 'Rack level mis-match');
        System.assertEquals(null, invPositions[0].Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(Label.Default_Inventory_Location, invPositions[0].Inventory_Location__r.Name, 'Inventory Location mis-match');
        
        PutAwayInventoryController controllerObj = new PutAwayInventoryController();
        controllerObj.retrieveInventoryPositions();
        
        // select first inventory position
        controllerObj.setInventoryPositions[0].isSelected = true;
        controllerObj.setInventoryPositions[0].qtyToPutAway = 3; 
        
        // Specify rack, rack level and bin location for first inventory position
        controllerObj.setInventoryPositions[0].invPositionSO.Rack__c = racks[0].Id;
        controllerObj.selectedInvPositionId = controllerObj.setInventoryPositions[0].invPositionSO.Id;
        controllerObj.selectedRackId = racks[0].Id;
        
        controllerObj.loadRackLevels();
        
        controllerObj.setInventoryPositions[0].invPositionSO.Rack_Level__c = rackLevels[0].Id;
        controllerObj.selectedRackLevelId = rackLevels[0].Id;
        System.assertNotEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        
        System.assertEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        controllerObj.loadBinLocations();
        controllerObj.selectedBinLocationId = binLocations[0].Id;
        controllerObj.setInventoryPositions[0].invPositionSO.Bin_Location__c = binLocations[0].Id;
        System.assertNotEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(4, controllerObj.setInventoryPositions[0].balanceQtyToPutAway, 'Balance qty to put away mis-match');
        
        PageReference pageRef = controllerObj.updateInventoryLocations();
        System.assertEquals('/apex/PutAwayInventory', pageRef.getURL(), 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        
        // Retrieve updated inventory positions
        retrieveData();
        //System.assertEquals(4, invPositions.size(), 'Size of inventory positions mis-match');
        
        // verify existing inventory position - update qty on hand
        System.assertEquals(2, invPositions[0].Qty_On_Hand__c, 'Qty on hand mis-match');
        System.assertEquals(null, invPositions[0].Rack__c, 'Rack mis-match');
        System.assertEquals(null, invPositions[0].Rack_Level__c, 'Rack level mis-match');
        System.assertEquals(null, invPositions[0].Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(Label.Default_Inventory_Location, invPositions[0].Inventory_Location__r.Name, 'Inventory Location mis-match');
        
        // verify cloned inventory position
        System.assertEquals(10, invPositions[3].Qty_On_Hand__c, 'Qty on hand mis-match');
        //System.assertEquals(racks[0].Id, invPositions[3].Rack__c, 'Rack mis-match');
        //System.assertEquals(rackLevels[0].Id, invPositions[3].Rack_Level__c, 'Rack level mis-match');
        //System.assertEquals(binLocations[0].Id, invPositions[3].Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals('Receiving Inspection', invPositions[3].Inventory_Location__r.Name, 'Inventory Location mis-match');
        Test.stopTest();
    }
    
    // Test no inventory position found with Receiving Inspection location 
    static testMethod void testNoInventoryPositionsFound_With_ReceivingInspectionLocation(){
        Test.startTest();
        retrieveData();
        for(Inventory_Position__c invPositionSO : invPositions){
            invPositionSO.Inventory_Location__c = invLocations[1].Id;
        }
        update invPositions;
        
        PutAwayInventoryController controllerObj = new PutAwayInventoryController();
        controllerObj.retrieveInventoryPositions(); 
        Test.stopTest();
        // get total inventory positions 
        //System.assertEquals(0, controllerObj.inventoryPositions.size(), 'Total Inventory positions mis-match');
        //System.assertEquals(TRUE, controllerObj.hasInventoryPosition, 'Inventory position flag mis-match');
    }
    
    // Bypass validation of total specified qty to put away vs available capacity of selected bin location
    // If Ignore Storage limit is true for selected bin location
    static testMethod void testInventoryPoistions_BypassAvailableCapacityValidationForIgnoreStorageLimit(){
        Test.startTest();
        retrieveData();
        
        // Update Ignore storage limit as true for bin location
        binLocations[0].Ignore_Storage_Limit__c = true;
        update binLocations[0];
        
        PutAwayInventoryController controllerObj = new PutAwayInventoryController();
        controllerObj.retrieveInventoryPositions();
        
        // Select inventory position and provide qty to put away values
        // Qty to put away is less than balance qty to put away for individual inventory position
        // But total qty to put away exceeds available capacity of selected bin locations
        
        // select first inventory position
        controllerObj.setInventoryPositions[0].isSelected = true;
        controllerObj.setInventoryPositions[0].qtyToPutAway = 5; 
        controllerObj.setInventoryPositions[0].invPositionSO.Rack__c = racks[0].Id;
        
        // Specify rack, rack level and bin location for first inventory position
        System.assertEquals(5, controllerObj.setInventoryPositions[0].invPositionSO.Qty_On_Hand__c, 'Qty on hand mis-match');
        
        System.assertEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        // load rack level, bin loaction and qty to put away
        controllerObj.selectedInvPositionId = controllerObj.setInventoryPositions[0].invPositionSO.Id;
        controllerObj.selectedRackId = racks[0].Id;
        
        controllerObj.loadRackLevels();
        
        controllerObj.setInventoryPositions[0].invPositionSO.Rack_Level__c = rackLevels[0].Id;
        controllerObj.selectedRackLevelId = rackLevels[0].Id;
        System.assertNotEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        
        System.assertEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        controllerObj.loadBinLocations();
        controllerObj.selectedBinLocationId = binLocations[0].Id;
        controllerObj.setInventoryPositions[0].invPositionSO.Bin_Location__c = binLocations[0].Id;
        System.assertNotEquals(null, controllerObj.setInventoryPositions[0].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(4, controllerObj.setInventoryPositions[0].balanceQtyToPutAway, 'Balance qty to put away mis-match');
        
        // select second inventory position
        controllerObj.setInventoryPositions[1].isSelected = true;
        controllerObj.setInventoryPositions[1].qtyToPutAway = 5; 
        controllerObj.setInventoryPositions[1].invPositionSO.Rack__c = racks[0].Id;
        
        // Specify rack, rack level and bin location for second inventory position
        System.assertEquals(10, controllerObj.setInventoryPositions[1].invPositionSO.Qty_On_Hand__c, 'Qty on hand mis-match');
        
        System.assertEquals(null, controllerObj.setInventoryPositions[1].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        // load rack level, bin loaction and qty to put away
        controllerObj.selectedInvPositionId = controllerObj.setInventoryPositions[1].invPositionSO.Id;
        controllerObj.selectedRackId = racks[0].Id;
        
        controllerObj.loadRackLevels();
        
        controllerObj.setInventoryPositions[1].invPositionSO.Rack_Level__c = rackLevels[0].Id;
        controllerObj.selectedRackLevelId = rackLevels[0].Id;
        System.assertNotEquals(null, controllerObj.setInventoryPositions[1].invPositionSO.Rack_Level__c, 'Rack level mis-match');
        
        System.assertEquals(null, controllerObj.setInventoryPositions[1].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        controllerObj.loadBinLocations();
        controllerObj.selectedBinLocationId = binLocations[0].Id;
        controllerObj.setInventoryPositions[1].invPositionSO.Bin_Location__c = binLocations[0].Id;
        System.assertNotEquals(null, controllerObj.setInventoryPositions[1].invPositionSO.Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(4, controllerObj.setInventoryPositions[1].balanceQtyToPutAway, 'Balance qty to put away mis-match');
        
        PageReference pageRef = controllerObj.updateInventoryLocations();
        System.assertEquals('/apex/PutAwayInventory', pageRef.getURL(), 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        
        // Retrieve updated inventory positions
        retrieveData();
        System.assertEquals(5, invPositions.size(), 'Size of inventory positions mis-match');
        System.assertEquals(racks[0].Id, invPositions[0].Rack__c, 'Rack mis-match');
        System.assertEquals(rackLevels[0].Id, invPositions[0].Rack_Level__c, 'Rack level mis-match');
        System.assertEquals(binLocations[0].Id, invPositions[0].Bin_Location__c, 'Bin Location mis-match');
        System.assertEquals(5, invPositions[0].Qty_On_Hand__c, 'Qty on hand mis-match');
        System.assertEquals(5, invPositions[1].Qty_On_Hand__c, 'Qty on hand mis-match');
        Test.stopTest();
        //System.assertEquals('Test Location', invPositions[0].Inventory_Location__r.Name, 'Inventory Location mis-match');
    }
    
    // Search functionality by product name, supplier name, producer name or po number
    static testMethod void testInventoryPoistions_SearchByProductName(){
        Test.startTest();
        retrieveData();
        
        PutAwayInventoryController controllerObj = new PutAwayInventoryController();
        controllerObj.retrieveInventoryPositions();
        System.assertEquals(4, controllerObj.inventoryPositions.size(), 'Total Inventory positions mis-match');
        
        // Provide search keyword - Search result found
        controllerObj.searchText = 'product 1';
        controllerObj.runSearch();
        System.assertEquals(2, controllerObj.inventoryPositions.size(), 'Total Inventory positions mis-match');
        
        // Provide search keyword - Search result found
        controllerObj.searchText = 'product';
        controllerObj.runSearch();
        //System.assertEquals(3, controllerObj.inventoryPositions.size(), 'Total Inventory positions mis-match');
        
        // Provide search keyword - No result found
        controllerObj.searchText = 'Test Search product';
        controllerObj.runSearch();
        System.assertEquals(0, controllerObj.inventoryPositions.size(), 'Total Inventory positions mis-match');
        
        // Reset search result
        controllerObj.resetSearch();
        System.assertEquals(4, controllerObj.inventoryPositions.size(), 'Total Inventory positions mis-match');
        Test.stopTest();
    }
    
    // test LDS methouds
    static testMethod void testAuraMethods(){
        Test.startTest();
        retrieveData();
        PutAwayInventoryController controllerObj = new PutAwayInventoryController();
        PutAwayInventoryController.putAwayInventoryCtrl();
        PutAwayInventoryController.onSiteChange('All','ASC','Product_Name__r.Name');
        PutAwayInventoryController.onOrderSort('ASC','Product_Name__r.Name','All');
        System.assertEquals('All', controllerObj.selectedSiteId, 'Selected Id Match');
        Test.stopTest();
    }
    
    // Sorting logic on Product name column
    static testMethod void testInventoryPoistions_SortProductNameColumn(){
        Test.startTest();
        retrieveData();
        
        PutAwayInventoryController controllerObj = new PutAwayInventoryController();
        controllerObj.retrieveInventoryPositions();
        System.assertEquals(4, controllerObj.inventoryPositions.size(), 'Total Inventory positions mis-match');
        
        // Default direction is ascending and default sortable field is product name
        System.assertEquals('asc', controllerObj.sortDir, 'Sorting direction mis-match');
        System.assertEquals('Product_Name__r.Name', controllerObj.sortField, 'Sorting field mis-match');
        System.assertEquals('product 1', 
                            controllerObj.inventoryPositions[0].invPositionSO.Product_Name__r.Name, 
                            'Product name mis-match');
        System.assertEquals('product 1', 
                            controllerObj.inventoryPositions[1].invPositionSO.Product_Name__r.Name, 
                            'Product name mis-match');
        /*System.assertEquals('product 3', 
                            controllerObj.inventoryPositions[2].invPositionSO.Product_Name__r.Name, 
                            'Product name mis-match');*/
        
        // Change sort direction of product name column
        controllerObj.toggleSort();
        System.assertEquals('desc', controllerObj.sortDir, 'Sorting direction mis-match');
        System.assertEquals('Product_Name__r.Name', controllerObj.sortField, 'Sorting field mis-match');
        System.assertEquals('product 3', 
                            controllerObj.inventoryPositions[0].invPositionSO.Product_Name__r.Name, 
                            'Product name mis-match');
        System.assertEquals('product 2', 
                            controllerObj.inventoryPositions[1].invPositionSO.Product_Name__r.Name, 
                            'Product name mis-match');
        System.assertEquals('product 1', 
                            controllerObj.inventoryPositions[2].invPositionSO.Product_Name__r.Name, 
                            'Product name mis-match');
        Test.stopTest();
    }
    
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        TestUtilData.createTestData();
        Test.startTest();
        Site__c[] sites = [SELECT Id FROM Site__c];
        Product2 [] objProduct = [SELECT Id FROM Product2 WHERE Name = 'product 1'];
        Inventory_Location__c newInventoryLocation = new Inventory_Location__c();
        newInventoryLocation.Name = 'Receiving Inspection';
        newInventoryLocation.Site_Name__c = sites[0].id;
        insert newInventoryLocation;
        Inventory_Location__c[] newInventoryLocations = [SELECT Id FROM Inventory_Location__c WHERE Name = 'Receiving Inspection'];

        
        List<Receiving_Line__c> receivingLines = [select id from Receiving_Line__c];
        Inventory_Position__c invp = new Inventory_Position__c();
        invp.Receiving_Line__c=receivingLines[0].ID;
        invp.Inventory_Location__c = newInventoryLocations[0].Id;
        invp.Product_Name__c=objProduct[0].id;
        invp.Qty_On_Hand__c=10;
        invp.Site__c = sites[0].Id;
        insert invp;
        
            Site_User__c su = new Site_User__c(Site__c = sites[0].Id,User__c = UserInfo.getUserId(),Active__c = true);
            insert su;
        test.stopTest();
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        invPositions = [Select Rack__c, 
                               Rack_Level__c, 
                               Bin_Location__c, 
                               Qty_On_Hand__c,
                               Inventory_Location__c,
                               Inventory_Location__r.Name
                               From Inventory_Position__c];
        System.debug('================'+invPositions.size());
        
        invLocations = [Select Id From Inventory_Location__c];
        racks = [Select Name, Inventory_Location__c, Inventory_Location__r.Name From Rack__c ORDER BY NAME];
        rackLevels = [Select Name, Rack__c From Rack_Level__c ORDER BY NAME];
        binLocations = [Select Name, Bin_Volume_Capacity__c, Rack_Level__c, 
                        Ignore_Storage_Limit__c From Bin_Location__c ORDER BY NAME];
    }
}