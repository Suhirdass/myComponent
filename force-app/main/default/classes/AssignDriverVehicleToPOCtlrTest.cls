@isTest
public class AssignDriverVehicleToPOCtlrTest {
    static Drivers__c driverObj;
    static Vehicles__c vehicleObj;
    static Purchase_Order__c purchaseOrderObj;
    static List<Purchase_Order_Line__c> poLines;
	@TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
    }
    @isTest
    static void testAssignDriverVehicleToPO(){
        retrieveData();
        updateAndCreateData();
        ApexPages.StandardController stdController = new ApexPages.StandardController(purchaseOrderObj);
        AssignDriverVehicleToPOCtlr controllerObj = new AssignDriverVehicleToPOCtlr(stdController);
        Test.startTest();
        AssignDriverVehicleToPOCtlr.init(purchaseOrderObj.id);
        AssignDriverVehicleToPOCtlr.assignDriverVehicle(purchaseOrderObj);
        AssignDriverVehicleToPOCtlr.retrieveDriverVehicleAndRelated(purchaseOrderObj,vehicleObj.id,driverObj.id,''+System.today());
        controllerObj.cancelAction();
        controllerObj.redirectToRSM();
        Test.stopTest();
    }
    // Retrieve data created from data setup
    public static void retrieveData(){
        
        purchaseOrderObj = new Purchase_Order__c();
        purchaseOrderObj = [Select Id,Planned_Ship_Transfer_Date__c,
                         		Driver__c,Ship_Confirmation_Date__c,
                         		Vehicle__c
                                from Purchase_Order__c];
        poLines = new List<Purchase_Order_Line__c>();
        poLines = [Select Id, Purchase_Order__c,Product_Name__c, Qty_Ordered__c,Unit_Cost__c,Brand_Quote_Line__c from Purchase_Order_Line__c];
        
    }
    public static void updateAndCreateData(){
        purchaseOrderObj.Planned_Ship_Transfer_Date__c =system.today();
        update purchaseOrderObj;
        // Create Vehicle
        vehicleObj = TestUtilData.createVehicle(true);
        
        // Create Driver
        driverObj = TestUtilData.createDriver(true);
        purchaseOrderObj.Vehicle__c=vehicleObj.id;
        purchaseOrderObj.Driver__c=driverObj.Id;
        update purchaseOrderObj;
        poLines[0].POLI_Status__c='New';
        poLines[1].POLI_Status__c='New';
        poLines[2].POLI_Status__c='New';
        update poLines;
    }
}