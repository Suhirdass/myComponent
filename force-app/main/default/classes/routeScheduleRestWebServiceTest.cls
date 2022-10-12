@isTest(OnInstall=false SeeAllData=false)
public class routeScheduleRestWebServiceTest {
    
    static Drivers__c driverObj;
    static Vehicles__c vehicleObj;
    static Sales_Order__c salesOrderObj;
    static Purchase_Order__c purchaseOrderObj;
    static Shipping_Manifest__c smObj;
    static PickList__c pickListObj;
    
    static testMethod void routeScheduleRestWebServiceTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());     
          TestUtilData.skipTrigger = true;
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
            insert GDMIs; 
        Test.startTest();
         
          
    //Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        routeScheduleRestWebService.doPostRouteInfo(system.today());
        routeScheduleRestWebService.getRouteSchedule(system.today());
        routeScheduleRestWebService.getMonthNumber('December');
        Test.setMock(HttpCalloutMock.class, new routeScheduleRestWebService_MockTest());
        
     /*List<Site__c>  sites=[SELECT Id,Name , License_ID__r.License_Address__c , License_ID__r.License_Zip__c ,
 License_ID__r.License_Country__c ,(SELECT Id, Name ,  Sales_Order__c, Purchase_Order__c,Purchase_Order__r.Receiver_Address__c,Purchase_Order__r.Receiver_City_State_Zip__c , 
 Purchase_Order__r.Name ,Sales_Order__r.Name, Purchase_Order__r.Supplier_Address__c , Purchase_Order__r.Supplier_City_State_Zip__c , 
 Sales_Order__r.Receiver_Address__c , Sales_Order__r.Receiver_City_State_Zip__c , Route_Start_Time__c , Route_End_Time__c , Window_Start__c , Window_End__c , Status__c , 
Planned_Ship_Transfer_Date__c FROM Shipping_Manifests__r WHERE Planned_Ship_Transfer_Date__c =:routeDate AND Id NOt IN:smIds ) FROM Site__c]; */
        
        
        
        
        
        
        
        
        
        List<Route_Schedule__c> updateRoute = [SELECT Id,Status__c  FROM Route_Schedule__c  where Route_Date__c=: system.today() limit 1];
        Route_Schedule__c rs = new Route_Schedule__c();
        rs.Route_Name__c ='test';
        rs.Route_Date__c=system.today();
        //Route_Schedule__c.Route_Date__c =system.today();
         rs.Status__c='Open';
        
        
      //  rs.Route_End_Time__c=now() ;
        insert rs;
        Route_Schedule_Line__c rsl = new Route_Schedule_Line__c();
        rsl.Schedule_sequence__c=1;
        rsl.Route_Schedule__c=rs.id;
        
        insert rsl;
        system.debug('rsl>>'+rsl);
         DateTime todaysDate = System.today();
        Date routeDate = Date.valueOf(todaysDate);
   List<Route_Schedule__c> getRoute = new  List<Route_Schedule__c>();
        Set<ID> routeIds = new Set<ID>();
           Set<ID> smIds = new Set<ID>();
        getRoute = [select Id, name,Status__c,(Select id, Name,Shipping_Manifest__c from Route_Schedule_Lines__r)  from Route_Schedule__c where Route_Date__c=:routeDate];
system.debug('getRoute>>'+getRoute.size());
                routeScheduleRestWebService.getDataLight(rs.id);
          Drivers__c driverO = new Drivers__c();
        driverO.Name = 'Test Driver1';
        driverO.Driver_License_Number__c = '12311';
        driverO.Expiration_Date__c = System.Today() + 100;
        driverO.State_Issued__c = 'NY';
        insert driverO;
        
        Vehicles__c vehicle1 = new Vehicles__c();
        vehicle1.Name = 'Test Vehicle'; // Same as Inventory Location of Picklist Line
        insert vehicle1;
        
routeScheduleRestWebService.assignDriverVehicle(rs.id,driverO.Id,vehicle1.Id,system.today(),'Save & Publish');
       routeScheduleRestWebService.publishRoute(rs.id);
        string month;
            month = routeScheduleRestWebService.HOLIDAY_RECURRENCE_LAST;
        month = routeScheduleRestWebService.AUGUST_MONTH;
        month = routeScheduleRestWebService.HOLIDAY_RECURRENCE_FIRST;
        month = routeScheduleRestWebService.DECEMBER_MONTH;
        month = routeScheduleRestWebService.NOVEMBER_MONTH;
        month = routeScheduleRestWebService.OCTOBER_MONTH;
        month = routeScheduleRestWebService.SEPTEMBER_MONTH;
         month = routeScheduleRestWebService.JULY_MONTH;
         month = routeScheduleRestWebService.JUNE_MONTH;
         month = routeScheduleRestWebService.SHIPPING_MANIFEST_STATUS_PENDING;
         month = routeScheduleRestWebService.HOLIDAY_RECURSMONTHLY;
         month = routeScheduleRestWebService.HOLIDAY_RECURSMONTHLYNTH;
         month = routeScheduleRestWebService.HOLIDAY_RECURSDAILY;
         month = routeScheduleRestWebService.HOLIDAY_RECURSEVERYWEEKDAY;
         month = routeScheduleRestWebService.MAY_MONTH;
         month = routeScheduleRestWebService.HOLIDAY_RECURSWEEKLY;
        routeSchduleBatch x = new routeSchduleBatch();
    database.executeBatch(x);
//QuickBookConncetion.SyncProductsWithQuickBooksdoint(objAccount.Id);
    Test.stopTest();
     
      
   

    }

}