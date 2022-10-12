@isTest
public class AssignDriverVehicleToSalesOrderCtlrTest {
    static Drivers__c driverObj;
    static Vehicles__c vehicleObj;
    static Sales_Order__c salesOrderObj;
    static List<Sales_Order_Line__c> soLines;
    static Shipping_Manifest__c tsmObj;
    
	@TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
    }
    @isTest
    static void testAssignDriverVehicleToSO(){
        retrieveData();
        updateAndCreateData();
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderObj);
        AssignDriverVehicleToSalesOrderCtlr controllerObj = new AssignDriverVehicleToSalesOrderCtlr(stdController);
        Test.startTest();
        AssignDriverVehicleToSalesOrderCtlr.init(salesOrderObj.id);
       DateTime todaysDate = System.today();
        Date todayDate = Date.valueOf(todaysDate);
       string startTime ='8:00';
         string endTime ='9:00';
       string pDate ='2022-06-08';
        AssignDriverVehicleToSalesOrderCtlr.assignDriverVehicle(salesOrderObj,startTime,endTime,pDate);
        AssignDriverVehicleToSalesOrderCtlr.retrieveDriverVehicleAndRelated(salesOrderObj,vehicleObj.id,driverObj.id,''+System.today());
        
        controllerObj.cancelAction();
        controllerObj.redirectToRSM();
          Test.stopTest();
    }
    // Retrieve data created from data setup
    public static void retrieveData(){
        
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Site__c,
                                Brand_Quote__c,
                                Distributor_Contact__c,
                                Distributor_License__c,
                                Distributor_Name__c,
                                Opportunity_Name__c,
                                Payment_Terms__c,
                                Planned_Ship_Date__c,
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
        soLines = [Select Product_Name__c From Sales_Order_Line__c];
    }
    public static void updateAndCreateData(){
        // Create Vehicle
        vehicleObj = TestUtilData.createVehicle(true);
        
        // Create Driver
        driverObj = TestUtilData.createDriver(true);
        salesOrderObj.Vehicle__c=vehicleObj.id;
        salesOrderObj.Driver__c=driverObj.Id;
        update salesOrderObj;
        
    }
}