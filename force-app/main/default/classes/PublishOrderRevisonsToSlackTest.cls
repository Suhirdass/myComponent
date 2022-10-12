@isTest
public class PublishOrderRevisonsToSlackTest {
 @isTest
    private static void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
       
    List<Id>Lstord = new List<Id>();
        Order_Revision__c ord = new Order_Revision__c();
        ord.Revision_Reason__c = ' Reschedule by Customer';
        insert ord;
        Lstord.add(ord.id);
        PublishOrderRevisonsToSlack.publishToSlack(Lstord);
    }
}