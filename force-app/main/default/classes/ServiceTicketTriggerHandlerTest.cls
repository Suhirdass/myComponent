@isTest
public class ServiceTicketTriggerHandlerTest {
    private static testmethod void runTest(){
        Google_Distance_Matrix_API__c g = new Google_Distance_Matrix_API__c();
        g.Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?';
        g.Name = 'Geocode_Endpoint';
        insert g;
        
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
        
        Site__c s = [SELECT id FROM Site__c];
        
        Account acc =[SELECT id,Name,Membership_Level__c FROM Account WHERE Name =: 'Test Account1' LIMIT 1];
        acc.Service_Type__c = 'Margin';
        acc.Type = 'Distributor';
        update acc;
        
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
        List<Product2> products = [SELECT Id,Most_Popular__c FROM Product2];
        products[0].Most_Popular__c = true;
        products[0].Available_Inventory__c = 200;
        update products[0];
        
        for(Product2 p: products){
            p.MOQ__c = 1;
            p.Available_Inventory__c = 100;
            p.Producer_Name__c = acc.Id;
            p.Product_Rating__c = 0;
        }
        update products;
        Service_Ticket_Line__c stl =new Service_Ticket_Line__c();
        stl.Status__c ='New';
        stl.Service_Ticket__c =st.id;
        stl.Total_Units__c =10;
        stl.New_Packaged_Product__c =products[0].id;
        insert stl;
        st.Status__c='Pending';
        st.Request_Date_Time__c=system.today().addMonths(4);
        update st;
        
        Site__c si = new Site__c();
        si.Name = 'Test Site';
        si.Warehouse_Name__c='TestWarehouse1';
        insert si;
        
        ServiceTicketTriggerHandler.getTotalMiles(si.Id, sl.Id);
        
        st.Status__c ='Cancelled';
        update st;
    }
}