@isTest
public class PublishOrderToSlackTest {
    @isTest
    private static void runTest(){
    	Order__c ord = new Order__c();
        ord.Order_Date__c = system.today();
        ord.Status__c='Pending';
    	insert ord;
        PublishOrderToSlack.publishToSlack(new List<Id>{ord.Id});
        
        ord.RecordTypeId=Schema.SObjectType.Order__C.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        update ord;
        PublishOrderToSlack.publishToSlack(new List<Id>{ord.Id});
        
        ord.RecordTypeId=Schema.SObjectType.Order__C.getRecordTypeInfosByName().get('Transfer').getRecordTypeId();
        update ord;
        PublishOrderToSlack.publishToSlack(new List<Id>{ord.Id});
        
    }
}