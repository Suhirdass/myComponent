@isTest
public class AssignDriverVehicleToSMCtlrTest {
    static Drivers__c driverObj;
    static Vehicles__c vehicleObj;
    static Shipping_Manifest__c sm;
    static Shipping_Manifest_Line__c sml;
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
    }
	@isTest
    private static void runTest(){
        updateAndCreateData();
        
        ApexPages.StandardController sc = new ApexPages.StandardController(sm);
        AssignDriverVehicleToSMCtlr assignDriverVehicleSM = new AssignDriverVehicleToSMCtlr(sc);
        assignDriverVehicleSM.cancelAction();
        
        
        AssignDriverVehicleToSMCtlr.init(sm.Id);
        AssignDriverVehicleToSMCtlr.assignDriverVehicle(sm,'08:00AM','08:00PM');
        AssignDriverVehicleToSMCtlr.retrieveDriverVehicleAndRelated(sm,vehicleObj.id,driverObj.id,''+System.today());
    }
    public static void updateAndCreateData(){
        sm = new Shipping_Manifest__c();
        sm.Metrc_Manifest__c= '1234';
        insert sm;
        sml = new Shipping_Manifest_Line__c();
        sml.Shipment_Qty__c= 20.89;
        sml.Shipping_Manifest__c =sm.Id;
        insert sml;
        List<Shipping_Manifest_Line__c> line = new List<Shipping_Manifest_Line__c>();
        Product2 prd = [select id from Product2 limit 1];
        for(Integer i=0; i <28 ; i++) {
            Shipping_Manifest_Line__c smLine = new Shipping_Manifest_Line__c();
            smLine.Product_Name__c	= prd.Id;
            smLine.Shipment_Qty__c = i;
            smLine.Shipping_Manifest__c = sm.Id;
            line.add(smLine);
            
        }
        insert line;
        // Create Vehicle
        vehicleObj = TestUtilData.createVehicle(true);
        
        // Create Driver
        driverObj = TestUtilData.createDriver(true);
        sm.Vehicle__c=vehicleObj.id;
        sm.Driver__c=driverObj.Id;
        update sm;
    }
}