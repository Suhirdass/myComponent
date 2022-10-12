/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * PickConfirmControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class PickConfirmControllerTest{

    static PickList__c pickListObj;
    static List<PickList_Line__c> pickListLines;
    static Sales_Order__c salesOrderObj;
    static List<Inventory_Position__c> invPositions;
    static List<Shipping_Manifest__c> rsm;
    static List<Shipping_Manifest_Line__c> rsmLines;
      
    // Test Updating picklist status to confirmed and create RSM and lines
    static testMethod void testUpdatePicklistConfirmedAndCreateRSMAndLines(){
        TestUtilData.skipTrigger = true;
        // Get data created from setup
        retrieveData();
        
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        Shipping_Manifest__c rsmObj = PicklistSupport.createRSM(pickListObj);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        Id rtId = Schema.SObjectType.Shipping_Manifest_Line__c.getRecordTypeInfosByDeveloperName().get('RSM_Line').getRecordTypeId();
        PicklistSupport.createRSMLine(pickListLines[0],rsmObj.Id,rtId);
        
        PageReference pageRef = Page.PickConfirm;
        pageRef.getParameters().put('id', pickListObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(pickListObj);
        PickConfirmController controllerObj = new PickConfirmController(stdController);
        
        pageRef = controllerObj.pickConfirm();
        
        PickConfirmController.pickConfirm(pickListObj.Id);
     	PLStartPickingController.updatePLPickStart(pickListObj.Id);
        // Verify picklist status
        //System.assertEquals(PicklistSupport.STATUS_QA_REVIEW,[Select Status__c From PickList__c Where Id =:pickListObj.Id].Status__c,'Picklist status mis-match');
        
        // Validate Inventory Location as QA Review
        invPositions = invPositions = [Select Site__c, 
                                       Inventory_Location__r.Name,
                                       Rack__r.Name, 
                                       Rack_Level__r.Name, 
                                       Bin_Location__r.Name
                                       From Inventory_Position__c];
        for(Inventory_Position__c invPosition : invPositions){
            System.assertEquals(PicklistSupport.STATUS_QA_REVIEW, invPosition.Inventory_Location__r.Name,
                                'Inventory Location mis-match');
            System.assertEquals(PicklistSupport.STATUS_QA_REVIEW, invPosition.Rack__r.Name,
                                'Rack mis-match');
            System.assertEquals(PicklistSupport.STATUS_QA_REVIEW, invPosition.Rack_Level__r.Name,
                                'Rack Level mis-match');
            System.assertEquals(PicklistSupport.STATUS_QA_REVIEW, invPosition.Bin_Location__r.Name,
                                'Bin Location mis-match');
        }
                        
        System.assertEquals('/'+String.valueOf(pickListObj.Id), pageRef.getURL(), 'Page reference mis-match');
                PickConfirmController.pickConfirm(pickListObj.Id);

    }
    
    // Test validating already QA Confirmed picklist to confirm
    static testMethod void testValidateQAConfirmedPicklistToConfirm(){
        TestUtilData.skipTrigger = true;
        // Get data created from setup
        retrieveData();
        
        // Create picklist with QA Confirmed status and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, PicklistSupport.STATUS_QA_CONFIRM, true);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        
        PageReference pageRef = Page.PickConfirm;
        pageRef.getParameters().put('id', pickListObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(pickListObj);
        PickConfirmController controllerObj = new PickConfirmController(stdController);

        pageRef = controllerObj.pickConfirm();
        
        PickConfirmController.pickConfirm(pickListObj.Id);
        
        List<Account> lstAcc = [SELECT Id,Hold__c from Account LIMIT 10];
        for(Account acc : lstAcc){
        	acc.Hold__c = true;    
        }
        update lstAcc;
        
        List<Sales_Order__c> sOrder = [SELECT Id,Account_Hold_Exception__c from Sales_Order__c LIMIT 10];
        for(Sales_Order__c acc : sOrder){
        	acc.Account_Hold_Exception__c = false;    
        }
        update sOrder;
        
        
        PickConfirmController.pickConfirm(pickListObj.Id);
        
        System.assertEquals(null, pageRef, 'Page reference mis-match');

        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Already_QA_Confirm_Picklist), 'Validation message mis-match');
    }
    
    // Test validating already QA Review picklist to confirm
    static testMethod void testValidateQAReviewPicklistToConfirm(){
        TestUtilData.skipTrigger = true;
        // Get data created from setup
        retrieveData();
        
        // Create picklist with QA Review status and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, PicklistSupport.STATUS_QA_REVIEW, true);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
         pickListObj = TestUtilData.createPicklist(salesOrderObj, PicklistSupport.STATUS_QA_REVIEW, false);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, false);
        PageReference pageRef = Page.PickConfirm;
        pageRef.getParameters().put('id', pickListObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(pickListObj);
        PickConfirmController controllerObj = new PickConfirmController(stdController);

        pageRef = controllerObj.pickConfirm();
          PickConfirmController.pickConfirm(pickListObj.Id);

        System.assertEquals(null, pageRef, 'Page reference mis-match');
                System.assertEquals(null, pageRef, 'Validation message mis-match');

          PickConfirmController.pickConfirm(pickListObj.Id);

        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        //System.assert(msgList[0].getDetail().contains(Label.Already_QA_Review_Picklist), 'Validation message mis-match');

    }
    
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        
        TestUtilData.skipTrigger = true;
        invPositions = [Select Sales_Order_Line__c,
                               Sales_Order_Line__r.Product_Name__c
                               From Inventory_Position__c];
                               
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Site__c from Sales_Order__c];
                //  PickConfirmController.pickConfirm(pickListObj.Id);

        // Create inventory location with name as "QA Review"
        Inventory_Location__c newInventoryLocation = new Inventory_Location__c();
        newInventoryLocation.Name = 'Test Location';
        newInventoryLocation.Site_Name__c = [Select Id From Site__c LIMIT 1].Id;
        newInventoryLocation.Name = PicklistSupport.STATUS_QA_REVIEW;
        insert newInventoryLocation;
        
        
        // Create Rack with name as "QA Review"
        Rack__c rackSO = new Rack__c();
        rackSO.Inventory_Location__c = newInventoryLocation.Id;
        rackSO.Name = PicklistSupport.STATUS_QA_REVIEW;
        insert rackSO;
        
        // Create Rack Level with name as "QA Review"
        Rack_Level__c rackLevelSO = new Rack_Level__c();
        rackLevelSO.Rack__c = rackSO.Id;
        rackLevelSO.Name = PicklistSupport.STATUS_QA_REVIEW;
        insert rackLevelSO;
        
        // Create Bin location with name as "QA Review"
        Bin_Location__c binLocationSO = new Bin_Location__c();
        binLocationSO.Rack_Level__c = rackLevelSO.Id;
        binLocationSO.Bin_Height__c = 10.0;
        binLocationSO.Bin_Length__c = 10.0;
        binLocationSO.Bin_Width__c = 20.0;
        binLocationSO.Name = PicklistSupport.STATUS_QA_REVIEW;
        insert binLocationSO;
    }
}