/**************************************************************************************

*******************************************************************************/
@isTest
public class CancelSOTEST {
   static Sales_Order__c objSO;
   static Picklist__c picklistObj;

    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
    }
  
    static testMethod void inventoryDetailsTest(){
        retrieveData();
        Test.startTest();
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSO);
        CancelSO controllerObj = new CancelSO(stdController);
        
        controllerObj.CancelProcess();
        CancelSO.CancelSorder(objSO.Id, true);
        controllerObj.goBack();

        
    }
    
     static testMethod void inventoryDetailsCancelTest(){
        retrieveData();
         Test.startTest();
        objSO.SO_Status__c = 'Cancelled';
        update objSO;    
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSO);
        CancelSO controllerObj = new CancelSO(stdController);
        
        controllerObj.CancelProcess();
         CancelSO.CancelSorder(objSO.Id, true);
    
     }
    
     static testMethod void inventoryDetailsApprovedTest(){
        retrieveData();
         Test.startTest();
        objSO.SO_Status__c = 'Approved';
        update objSO;    
        objSO.Allocated__c = true;
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSO);
        CancelSO controllerObj = new CancelSO(stdController);
        
        controllerObj.CancelProcess();
         CancelSO.CancelSorder(objSO.Id, true);
    
     }
    
    static testMethod void picklistDetailsOpenTest(){ 
        retrieveData();
        Test.startTest();
        objSO.SO_Status__c = 'Approved';
        objSO.Allocated__c = true;
        update objSO;    

        
        Picklist__c objPicklist = [select id,Sales_Order__c, Status__c from Picklist__c limit 1];
        objPicklist.Status__c = 'Confirmed';
        update objPicklist;
        
         system.debug('objPicklist----'+objPicklist);
        
        
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSO);CancelSO controllerObj = new CancelSO(stdController);   

        controllerObj.CancelProcess();
        CancelSO.CancelSorder(objSO.Id, true);
    }


    static testMethod void picklistDetailsTest(){ 
        retrieveData();
        Test.startTest();
        objSO.SO_Status__c = 'Approved';
        objSO.Allocated__c = true;
        update objSO;    
        
            
            
       Picklist__c objPicklist = [select id,Sales_Order__c, Status__c from Picklist__c limit 1];
        objPicklist.Status__c = 'Confirmed';
        update objPicklist;
        
        system.debug('objPicklist1----'+objPicklist);

   

        ApexPages.StandardController stdController = new ApexPages.StandardController(objSO);
        CancelSO controllerObj = new CancelSO(stdController);   
         CancelSO.isConfirmed = true;
        controllerObj.CancelProcess();
        CancelSO.CancelSorder(objSO.Id, true);
        
                
    }


    
    static testMethod void picklistDetailsConfirmedTest(){ 
        retrieveData();
        Test.startTest();
        objSO.SO_Status__c = 'Approved';
        update objSO;    
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSO);
        CancelSO controllerObj = new CancelSO(stdController);
        
        controllerObj.CancelProcess();
        CancelSO.CancelSorder(objSO.Id, true);
    }
    
    static testMethod void SOdetailsDraftTest(){ 
        retrieveData();
        Test.startTest();
        objSO.SO_Status__c = 'Draft';
        update objSO;    
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSO);
        CancelSO controllerObj = new CancelSO(stdController);
        
        controllerObj.CancelProcess();
        CancelSO.CancelSorder(objSO.Id, true);
    }
    
    static testMethod void SOdetailsHoldTest(){ 
        retrieveData();
        Test.startTest();
        objSO.SO_Status__c = 'Hold';
        update objSO;    
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSO);
        CancelSO controllerObj = new CancelSO(stdController);
        
        controllerObj.CancelProcess();
        String Status;
        Status = CancelSO.SHIPPING_MANIFEST_STATUS_CANCELLED;
        Status = CancelSO.SHIPPING_MANIFEST_STATUS_DRAFT;
        Status = CancelSO.PICKLIST_STATUS_QACONFIRM;
        Status = CancelSO.PICKLIST_STATUS_CONFIRMED;
        Status = CancelSO.ERR_MSG_CANT_CANCEL_SO_CANCEL_PICKLIST;
        Status = CancelSO.ORDERCANCELLED_CUSTOMER;
        
        //AuraResponse r = new AuraResponse('CancelSO.CancelSorder()');
        CancelSO.CancelSorder(objSO.Id, true);
        CancelSO.getRecordName(objSO.Id);
    }
    
    
    public static void retrieveData(){
        objSO = new Sales_Order__c();
        objSO = [Select Id, SO_Status__c, Site__c, Allocated__c from Sales_Order__c];
        system.debug('objSO'+objSO);
       
        
        picklistObj = new Picklist__c();
        picklistObj.Sales_Order__c = objSO.Id;
        picklistObj.Site__c = objSO.Site__c;
        picklistObj.Status__c = 'Open';
       
        insert picklistObj;
        
        
        list<Sales_Order_Line__c> lstSO = [select id, Status__c from Sales_Order_Line__c]; 
        
        lstSO[0].Status__c = 'Back Ordered';
        
        lstSO[0].Qty_Allocated__c = 20;     
        
        lstSO[1].Status__c = 'Allocated';
        
        lstSO[1].Qty_Allocated__c = 10;
        
        lstSO[2].Status__c = 'Partially Allocated';
        
        lstSO[0].Qty_Allocated__c = 5;
        update lstSO;
                
        List<Inventory_Position__c> invPositions =[select id, Sales_Order_Line__c from Inventory_Position__c];
 
        invPositions[0].Sales_Order_Line__c = lstSO[0].id;
        invPositions[1].Sales_Order_Line__c = lstSO[0].id;
        invPositions[2].Sales_Order_Line__c = lstSO[0].id;
        
        update invPositions;
    }
    
    static testMethod void cancelSOWithShipmentCompleteRSM(){
        retrieveData();
        Test.startTest();
        objSO.SO_Status__c = 'Draft';
        update objSO;   

        Shipping_Manifest__c rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Sales_Order__c = objSO.Id;
        rsmObj.Status__c = CancelSO.SHIPMENT_COMPLETE;
        insert rsmObj;
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSO);
        CancelSO controllerObj = new CancelSO(stdController);
        
        PageReference pageRef = controllerObj.CancelProcess();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains('SO can be cancelled only for open RSM'), 'Validation message mis-match');
    
     }
     
    static testMethod void cancelSOWithShipmentDraftRSM(){
        
        retrieveData();
        Test.startTest();
        objSO.SO_Status__c = 'Draft';
        update objSO;   

        Shipping_Manifest__c rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Sales_Order__c = objSO.Id;
        insert rsmObj;
        
        List<Picklist__c> pickLists = [Select Id from Picklist__c Where Sales_Order__c =: objSO.Id];
        System.assertEquals(1, pickLists.size(), 'Picklist size mis-match');
        
        List<Shipping_Manifest__c> rsms = [Select Id from Shipping_Manifest__c Where Sales_Order__c =: objSO.Id];
        System.assertEquals(1, rsms.size(), 'RSM size mis-match');
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSO);
        CancelSO controllerObj = new CancelSO(stdController);
        
        PageReference pageRef = controllerObj.CancelProcess();
       
        pickLists = [Select Id from Picklist__c Where Sales_Order__c =: objSO.Id]; rsms = [Select Id from Shipping_Manifest__c Where Sales_Order__c =: objSO.Id];
        Test.stopTest();
     }
}