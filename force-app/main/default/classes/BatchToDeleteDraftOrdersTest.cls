@isTest
public class BatchToDeleteDraftOrdersTest {
	 @isTest
    Public static void Check(){
        list<Order__c> oList = new list<Order__c>();
        
        Id productRecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByDeveloperName()
                          .get('Brand').getRecordTypeId();
        
        
        Order__c o = new Order__c();
        o.Status__c='Draft';
        o.RecordTypeId = productRecordTypeId;
        o.Order_Date__c =system.today();
        DateTime dt = System.now();
        Time myTime = Time.newInstance(dt.hour(), dt.minute(), dt.second(), dt.millisecond());
        o.Requested_Delivery_Earliest_Time__c=myTime;
        o.Requested_Delivery_Latest_Time__c=myTime;
        o.Request_Ship_Date__c=system.today();
        oList.add(o);
         
        insert oList;
       
        
        Test.startTest();
        BatchToDeleteDraftOrders obj =new BatchToDeleteDraftOrders();
        DataBase.executeBatch(obj); 
        //obj.execute();
        String sch = '0 0 23 * * ?';
        system.schedule('Test status Check', sch, obj );
        Test.stopTest();
    }
}