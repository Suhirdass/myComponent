@isTest
public class BatchMonthlyOrderCountTest {
    static testMethod void runTest(){
        Google_Distance_Matrix_API__c g = new Google_Distance_Matrix_API__c();
        g.Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?';
        g.Name = 'Geocode_Endpoint';
        insert g;
        
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        
        Site__c s = new Site__c();
        s.Name = 'Test Site';
        s.Warehouse_Name__c='TestWarehouse1';
        insert s;
        
        Account acc =new Account();
        acc.Name = 'Test Account2';
        acc.Payment_Terms__c = 'COD';
        acc.Hide_from_Marketplace__c = false;
        acc.Type = 'Distributor';
        acc.DBA__c = 'WOVN LA | Zasp';
        insert acc;
        
        Contact con =new Contact();
        con.FirstName='con';
        con.LastName='test';
        con.AccountId=acc.Id;
        con.Email = 'Testcontactat1@filigreencustomer.com';
        con.Primary_Contact__c = true;
        
        insert con;
        

        State_Licenses__c sl = new State_Licenses__c();
        sl.License_Name__c = acc.Id;
        sl.License_Class__c = 'A-License';
        sl.License_Type__c = 'Type 11';
        sl.License_Number__c = 'A11-18-0000054-TEMP';
        sl.License_Status__c = 'Active';
        sl.License_Expiration_Date__c = System.today().addDays(60);
        sl.License_Address__c = '44650 101 Hwy N, Suite F';
        sl.License_City__c = 'Lafayette';
        sl.License_State__c = 'California';
        sl.License_Zip__c = '95454';
        sl.License_Country__c = 'US';
        sl.Default_Warehouse__c = s.Id;
        sl.Total_Miles__c=1;
        
        insert sl;
        Order__c ord= new Order__c();
        ord.Status__c='Shipped';
        ord.Account__c = acc.Id;
        ord.Order_Date__c=Date.today();
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Transfer').getRecordTypeId();
        ord.State_License__c = sl.id;
        ord.Retailer__c = acc.Id;
        ord.Retailer_Contact__c =con.Id;
        ord.Request_Ship_Date__c =Date.today();
        ord.Delivered_Date__c =Date.today();
        ord.Requested_Delivery_Earliest_Time__c = Time.newInstance(1, 12, 13, 12);
        ord.Requested_Delivery_Latest_Time__c = Time.newInstance(1, 12, 13, 12);
        insert ord;
        
         List<Order__c> o = new List<Order__c>();
        o.add(ord);
        
         //Database.executeBatch(new BatchMonthlyOrderCount());
        Test.startTest();
        BatchMonthlyOrderCount bmc = new BatchMonthlyOrderCount();
        Database.QueryLocator ql = bmc.Start(null);
        bmc.execute(null, o);
        bmc.finish(null);
        //Database.executeBatch(bmc);
        Test.stopTest();
    }
}