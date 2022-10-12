@isTest
public class ServiceTicketLineTriggerTest {
	  @isTest
    public static void Test(){
        
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
        
        Service_Ticket__c st =new Service_Ticket__c();
        st.Status__c ='Draft';
        st.Transfer_Method__c='Pick-up';
        insert st;
        
        List<Product2> products = [SELECT Id,Most_Popular__c FROM Product2];
        
        Service_Ticket_Line__c stl =new Service_Ticket_Line__c();
        stl.Status__c ='New';
        stl.Total_Units__c = 10;
        stl.Service_Ticket__c =st.id;
        stl.New_Packaged_Product__c = products[0].id;
        insert stl;
        stl.Status__c ='Completed';
        update stl;
        System.assertEquals(stl.Status__c, 'Completed');
    }
}