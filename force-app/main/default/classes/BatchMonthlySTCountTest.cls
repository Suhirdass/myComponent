@isTest
public class BatchMonthlySTCountTest {
    static testMethod void runTest(){
        Google_Distance_Matrix_API__c g = new Google_Distance_Matrix_API__c();
        g.Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?';
        g.Name = 'Geocode_Endpoint';
        insert g;
        
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        
        ServiceTicketTriggerHandler.feesCalulated = true;
        
        Site__c s = new Site__c();
        s.Name = 'Test Site';
        s.Warehouse_Name__c='TestWarehouse1';
        insert s;
        
        Account acc =new Account();
        acc.Name = 'Test Account2';
        acc.Payment_Terms__c = 'COD';
        acc.Hide_from_Marketplace__c = false;
        acc.Type = 'Distributor';
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
        
        Service_Ticket__c st =new Service_Ticket__c();
        st.Status__c ='Completed';
        st.Brand_Contact__c=con.Id;
        st.Brand_Name__c=acc.Id;
        st.Transfer_Method__c='Pick-up';
        st.Request_Date_Time__c=system.today().addMonths(2);
        st.Destination_Site__c=s.id;
        st.Licensed_Premise__c =sl.id;
        st.Service_Complete__c = system.today();
        insert st;
        
        List<Service_Ticket__c> sList = new List<Service_Ticket__c>();
        sList.add(st);
        
        //Database.executeBatch(new BatchMonthlySTCount());
        Test.startTest();
        BatchMonthlySTCount bmc = new BatchMonthlySTCount();
        Database.QueryLocator ql = bmc.Start(null);
        bmc.execute(null, sList);
        bmc.finish(null);
        //Database.executeBatch(bmc);
        Test.stopTest();
    }
}