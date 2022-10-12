@isTest
public class PublishServicesTicketToSlackTest {
	@isTest
    private static void runTest(){
        Google_Distance_Matrix_API__c g = new Google_Distance_Matrix_API__c();
        g.Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?';
        g.Name = 'Geocode_Endpoint';
        insert g;
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
        Site__c s = new Site__c(Name= '2089-3',Warehouse_Name__c='San Francisco',Sort_Order__c=1,Active__c=true);
        insert s;
        Account acc =new Account();
        acc.Name='acName';
        acc.Type = 'Distributor';
        insert acc;
        Contact con =new Contact();
        con.FirstName='con';
        con.LastName='test';
        con.AccountId=acc.Id;
        con.Email = 'Testcontactat1@filigreencustomer.com';
        con.Primary_Contact__c = true;
        insert con;
        integer j=10;
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = acc.id;
        objStateLicenses.License_Number__c = 'AbcTest'+(j*10)+10;
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_City__c = 'Banning';
        objStateLicenses.License_State__c = 'Florida';
        objStateLicenses.License_Country__c = 'US';
        objStateLicenses.License_Zip__c = '12333';
        objStateLicenses.Default_Warehouse__c =s.id;
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        insert objStateLicenses;
        
        Service_Ticket__c st =new Service_Ticket__c();
     //   st.Status__c ='New';
        st.Brand_Contact__c=con.Id;
        st.Brand_Name__c=acc.Id;
        st.Licensed_Premise__c =objStateLicenses.id;
        st.Transfer_Method__c='Product Conversions';
      //  st.Status__c='New';
        insert st;
        PublishServicesTicketToSlack.publishToSlack(new List<Id>{st.Id});
        st.Transfer_Method__c='Drop-off';
        update st;
        PublishServicesTicketToSlack.publishToSlack(new List<Id>{st.Id});
        
    }
}