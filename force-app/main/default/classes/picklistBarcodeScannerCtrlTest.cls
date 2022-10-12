@isTest(OnInstall=false SeeAllData=false)
public class picklistBarcodeScannerCtrlTest {
    
    static PickList__c pickListObj;
    static PickList_Line__c pickListLineObj;
    static List<PickList_Line__c> pickListLines;
    static Sales_Order__c salesOrderObj;
    static List<Inventory_Position__c> invPositions;
    static List<Shipping_Manifest__c> rsm;
    static List<Shipping_Manifest_Line__c> rsmLines;
    
    // Test Updating picklist status to confirmed and create RSM and lines
    static testMethod void testPicklistConfirmed(){
        
        // Get data created from setup
        retrieveData();
        
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        Shipping_Manifest__c rsmObj = PicklistSupport.createRSM(pickListObj);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        Id rtId = Schema.SObjectType.Shipping_Manifest_Line__c.getRecordTypeInfosByDeveloperName().get('RSM_Line').getRecordTypeId();
        PicklistSupport.createRSMLine(pickListLines[0],rsmObj.Id,rtId);
           
   
         Picklist_Line__c pkl = [select id, Sales_Order_Line__c, Sales_Order_Line__r.Actual_Qty_Ordered__c, Qty_to_Pick__c, Qty_Picked__c, Inventory_Position__c from Picklist_Line__c Limit 1];

         List<Inventory_Position__c>  invPositionsdata = [Select Site__c, 
                                       Inventory_Location__r.Name,
                                       Rack__r.Name, 
                                       Rack_Level__r.Name, 
                                       Bin_Location__r.Name
                                       From Inventory_Position__c];
        system.debug('in'+invPositions);
         for(Inventory_Position__c acc : invPositionsdata){
        	acc.Qty_Allocated__c = pickListLines[0].Qty_Picked__c;   
        }
        update invPositionsdata;
        Test.startTest();
        ApexPages.StandardController stdController = new ApexPages.StandardController(pickListObj);
        picklistBarcodeScannerCtrl controllerObj = new picklistBarcodeScannerCtrl(stdController);
        controllerObj.cancelAction();
        controllerObj.getScannedValue();

        picklistBarcodeScannerCtrl.getPicklistLineItems(pickListObj.Id);
        Test.stopTest();
        
    }
    
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
    }
      // Test Updating picklist status to confirmed and create RSM and lines
    static testMethod void testUpdatePicklistConfirmedAndCreateRSMAndLines(){
        Test.startTest();
        // Get data created from setup
        retrieveData();
        
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        Shipping_Manifest__c rsmObj = PicklistSupport.createRSM(pickListObj);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        Id rtId = Schema.SObjectType.Shipping_Manifest_Line__c.getRecordTypeInfosByDeveloperName().get('RSM_Line').getRecordTypeId();
        PicklistSupport.createRSMLine(pickListLines[0],rsmObj.Id,rtId);
        
    
        
        picklistBarcodeScannerCtrl.pickConfirm(pickListObj.Id);
     
        // Verify picklist status
  
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
           picklistBarcodeScannerCtrl.updatePicklistLineItems(pickListLines[0].Id,pickListLines);                
     test.stopTest();

    }
    
    // Test validating already QA Confirmed picklist to confirm
    static testMethod void testValidateQAConfirmedPicklistToConfirm(){
        
        // Get data created from setup
        retrieveData();
        
        // Create picklist with QA Confirmed status and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, PicklistSupport.STATUS_QA_CONFIRM, true);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
       
      
        
        picklistBarcodeScannerCtrl.pickConfirm(pickListObj.Id);
        
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
         
           //  Inventory_Position__c pklIP = new Inventory_Position__c();
           // pklIP.Id=pkl.Inventory_Position__c;
           // pklIP.Qty_Allocated__c = pkl.Qty_Picked__c;
          //  update pklIP;
        
        picklistBarcodeScannerCtrl.pickConfirm(pickListObj.Id);
        
      
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        invPositions = [Select Sales_Order_Line__c,
                        Sales_Order_Line__r.Product_Name__c
                        From Inventory_Position__c];
        
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Id, Site__c from Sales_Order__c];
        //PickConfirmController.pickConfirm(pickListObj.Id);
        
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
        string status ;
        status = picklistBarcodeScannerCtrl.DL_ASR_EMAILS;
        status = picklistBarcodeScannerCtrl.IP_HOLD_REASON_INVENTORY_DISCREPANCY;   
        picklistBarcodeScannerCtrl.isTestClass = true;
    }

}