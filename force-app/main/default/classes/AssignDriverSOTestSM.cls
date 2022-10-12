@isTest(OnInstall=false SeeAllData=false)
public class AssignDriverSOTestSM 
{
 	static List<Product2> products;
    static Drivers__c driverObj;
    static Sales_Order__c salesOrderObj;
    static Shipping_Manifest__c tsmObj;
     static PickList__c pickListObj;
    static List<PickList_Line__c> pickListLines;
    static List<Sales_Order_Line__c> soLines;
    static List<Inventory_Position__c> invPositions;
   // Test loading of Assign Driver page from TSM detail page
    static testMethod void testLoadDriverAndTSMDetails_FromTSMPage(){
        
        // Get data created from setup
       retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        PageReference pageRef = Page.AssignDriver;
        pageRef.getParameters().put('id', tsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(tsmObj);
        AssignDriverSO controllerObj = new AssignDriverSO(stdController);
        
        pageRef = controllerObj.doPrepare();
         System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(tsmObj.Id, controllerObj.tsmObj.Id, 'RSM mis-match');
        System.assertEquals(1, controllerObj.totalProduct, 'RSM Line mis-match');
        System.assertEquals(driverObj.Id, controllerObj.driverObj.Id, 'Driver mis-match');
        System.assertEquals(1, controllerObj.rsmList.size(), 'RSM List mis-match');
        
       /* System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(tsmObj.Id, controllerObj.tsmObj.Id, 'TSM mis-match');
        System.assertEquals(driverObj.Id, controllerObj.driverObj.Id, 'Driver mis-match');
        System.assertEquals(1, controllerObj.TSMList.size(), 'TSM List mis-match');*/
        
        pageRef = controllerObj.cancelAction();
        System.assertEquals('/'+String.valueOf(tsmObj.Id).subString(0, 15), pageRef.getURL(), 'Page reference mis-match');
        
        //Lightning Methods 
        
        AssignDriverSO.assignDriverToOrder(tsmObj.Id);
        AssignDriverSO.assignDriver(tsmObj);
        AssignDriverSO.retrieveDriverAndRelatedRSMs(tsmObj);
    } 
        // Test update Driver of TSM
    static testMethod void testAssignDriverToTSM(){
        
        // Get data created from setup
        retrieveData();
        
        // Update and create necessary data
        updateAndCreateData();
        
        PageReference pageRef = Page.AssignDriver;
        pageRef.getParameters().put('id', tsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(tsmObj);
        AssignDriverSO controllerObj = new AssignDriverSO(stdController);
        
        
                pageRef = controllerObj.doPrepare();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(tsmObj.Id, controllerObj.tsmObj.Id, 'RSM mis-match');
        System.assertEquals(1, controllerObj.totalProduct, 'RSM Line mis-match');
        System.assertEquals(driverObj.Id, controllerObj.driverObj.Id, 'Driver mis-match');
        System.assertEquals(1, controllerObj.rsmList.size(), 'RSM List mis-match');
        
        
        
    /*    System.assertEquals(null, pageRef, 'Page reference mis-match');
        System.assertEquals(tsmObj.Id, controllerObj.tsmObj.Id, 'TSM mis-match');
        System.assertEquals(driverObj.Id, controllerObj.driverObj.Id, 'Driver mis-match');
        System.assertEquals(1, controllerObj.TSMList.size(), 'TSM List mis-match');*/
        
        Test.startTest();
        
        // Set TSM driver to null to throw validation
        controllerObj.tsmObj.Driver__c = null;
        pageRef = controllerObj.assignDriver();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Select_Driver), 'Validation message mis-match');
        
        // Assign new driver and planned ship date to TSM
        Drivers__c newDriverObj = TestUtilData.createDriver(false);
        newDriverObj.Driver_License_Number__c = '123456';
        insert newDriverObj;
        
        controllerObj.tsmObj.Driver__c = newDriverObj.Id;
        controllerObj.tsmObj.Planned_Ship_Transfer_Date__c = System.Today() + 13;
        pageRef = controllerObj.assignDriver();
        
        // verify TSM driver and planned ship date
        tsmObj = [Select Status__c, Planned_Ship_Transfer_Date__c, Driver__c From Shipping_Manifest__c Where Id =: tsmObj.Id];
        
        Test.stopTest();
    }
    
     @TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
    }
    // Retrieve data created from data setup
    public static void retrieveData(){
       invPositions = [Select Sales_Order_Line__c,
                               Sales_Order_Line__r.Product_Name__c,
                               Inventory_Location__r.Name
                               From Inventory_Position__c];
                               
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Site__c from Sales_Order__c];
        
        soLines = new List<Sales_Order_Line__c>();
        soLines = [Select Id from Sales_Order_Line__c];
    }
     
   // Update necessary data for Assign Driver logic
    public static void updateAndCreateData(){
        
    // Update SO lines in Inventory positions
        for(Integer i=0; i<invPositions.size(); i++){
            invPositions[i].Sales_Order_Line__c = soLines[i].Id;
        }
        update invPositions;
         
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        
        // Create Driver
        driverObj = TestUtilData.createDriver(true);
        
        // Create RSM with planned ship date greater than license expiration date
        tsmObj = TestUtilData.createRSM(pickListObj, false);
        tsmObj.Driver__c = driverObj.Id;
        insert tsmObj;
        
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], tsmObj.Id, true);
  
        
    }
    
    
}