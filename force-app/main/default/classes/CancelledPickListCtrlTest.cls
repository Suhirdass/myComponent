@isTest(SeeAllData=false)
public class CancelledPickListCtrlTest {
    
    static PickList__c pickListObj;
    static List<PickList_Line__c> pickListLines;
    static Sales_Order__c salesOrderObj;
    static List<Inventory_Position__c> invPositions;
    
	@TestSetUp
    static void testDataSetUp(){
        
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'Test Account1' LIMIT 1];
        acc.Name = 'Irrational Raccoon, LLC';
        update acc;
        Site__c objSite = new Site__c();
        objSite.Name = '2089-3';
        objSite.Warehouse_Name__c='Test-2089-3';
        insert objSite;
        
    }
    
    private static testmethod void cancelledPickListTest(){
    	Test.StartTest();
        TestUtilData.skipTrigger = true;
        // Get data created from setup
        retrieveData();
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        
        pickListObj.Status__c = 'QA Review';
        update pickListObj;
        
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        CancelledPickListCtrl.getRecordName(pickListObj.Id);
        CancelledPickListCtrl.getPickListLineItems(pickListObj.Id);
        
        List<CancelledPickListCtrl.SelectedLineItems> lstSelect = new List<CancelledPickListCtrl.SelectedLineItems>();
        
        for(Picklist_Line__c var : pickListLines){
        	PicklistLineWrapper wrap = new PicklistLineWrapper(var,var.Qty_to_Pick__c);
            lstSelect.add(new CancelledPickListCtrl.SelectedLineItems(true,wrap));
        }
        
        String str = JSON.serialize(lstSelect);
        CancelledPickListCtrl.saveLineItems(str,true);
        //CancelledPickListCtrl.SelectedLineItems selItems = new CancelledPickListCtrl.SelectedLineItems();
        CancelledPickListCtrl.deletePicklistAndLines(pickListObj.Id);
        System.assertEquals(pickListObj.Status__c, 'QA Review');
        Test.stopTest();
    }
    private static testmethod void cancelledOpenPickListTest(){
    	Test.StartTest();
        TestUtilData.skipTrigger = true;
        // Get data created from setup
        retrieveData();
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        
        pickListObj.Status__c = 'Open';
        update pickListObj;
        
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        CancelledPickListCtrl.getRecordName(pickListObj.Id);
        CancelledPickListCtrl.getPickListLineItems(pickListObj.Id);
        
        List<CancelledPickListCtrl.SelectedLineItems> lstSelect = new List<CancelledPickListCtrl.SelectedLineItems>();
        
        for(Picklist_Line__c var : pickListLines){
        	PicklistLineWrapper wrap = new PicklistLineWrapper(var,var.Qty_to_Pick__c);
            lstSelect.add(new CancelledPickListCtrl.SelectedLineItems(true,wrap));
        }
        
        String str = JSON.serialize(lstSelect);
        CancelledPickListCtrl.saveLineItems(str,true);
         CancelledPickListCtrl.cancelOrder(pickListObj.Id);
        //CancelledPickListCtrl.SelectedLineItems selItems = new CancelledPickListCtrl.SelectedLineItems();
        CancelledPickListCtrl.deletePicklistAndUpdateSO(pickListObj.Id);
       
        System.assertEquals(pickListObj.Status__c, 'Open');
        Test.stopTest();
          string STATUS_ORDERCANCELLEDBYFILIGREEN = CancelledPickListCtrl.STATUS_ORDERCANCELLEDBYFILIGREEN;
         string STATUS_SALESORDERCANCELLED = CancelledPickListCtrl.STATUS_SALESORDERCANCELLED;
         string STATUS_BRANDQUOTECANCELLED = CancelledPickListCtrl.STATUS_BRANDQUOTECANCELLED;
         string SOLI_STATUS_OPEN = CancelledPickListCtrl.SOLI_STATUS_OPEN;
         string Invoice_Line_Status_Cancelled = CancelledPickListCtrl.Invoice_Line_Status_Cancelled;
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        invPositions = [Select Sales_Order_Line__c,
                               Sales_Order_Line__r.Product_Name__c
                               From Inventory_Position__c];
                               
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Site__c from Sales_Order__c];
        Sales_Order_Line__c[] SOLInes = [SELECT Id FROM Sales_Order_Line__c WHERE Sales_Order__c = :salesOrderObj.Id];
        if(SOLInes.size() > 0){
            invPositions[0].Sales_Order_Line__c = SOLInes[0].Id;
            update invPositions;
        }
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