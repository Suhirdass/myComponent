@isTest
public class BatchToUpdateIPRecordValuesTest {
    
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
        
        Set<Id> setSOIds = new Set<Id>();
        for(Sales_Order_Line__c soli : [Select Id,Sales_Order__c, Status__c,Sales_Order__r.Ship_Confirmation_Date__c from Sales_Order_Line__c]){
            setSOIds.add(soli.Sales_Order__c);
        }
         
        List<Sales_Order__c> soLst = [SELECT Id,Ship_Confirmation_Date__c FROM Sales_Order__c WHERE Id IN : setSOIds];
        for(Sales_Order__c so : soLst){
            so.Ship_Confirmation_Date__c = Date.today();
        }
        update soLst;
        
        List<Sales_Order_Line__c> soLines = [Select Id,Sales_Order__c, Status__c,Sales_Order__r.Ship_Confirmation_Date__c from Sales_Order_Line__c];
        
        Site__c s = new Site__c();
        s.Name ='2089';
        insert s;
        
        Inventory_Location__c il = new Inventory_Location__c ();
        il.Name='QA Review';
        il.Site_Name__c=s.Id;
        insert il;
        
        Decimal totalQty = 0.0;
        List<Inventory_Position__c> lstIps = new List<Inventory_Position__c>();
        
        Inventory_Position__c iv = new Inventory_Position__c();
        iv.Inventory_Location__c=il.id;
        iv.Total_Days_in_Inventory__c = 62;
        iv.Site__c =s.Id;
        iv.Qty_On_Hand__c=0.2;
        iv.Sales_Order_Line__c = soLines[0].Id;
        iv.Inventory_Last_Movement_date__c = Date.today();
        totalQty = totalQty + iv.Qty_On_Hand__c;
        lstIps.add(iv);
        
        Inventory_Position__c iv2 = iv.clone();
        iv2.Total_Days_in_Inventory__c = 182;
        lstIps.add(iv2);
        
        Inventory_Position__c iv3 = iv.clone();
        iv3.Total_Days_in_Inventory__c = 152;
        lstIps.add(iv3);
        
        insert lstIps;
    }
    
    static testMethod void updateIPRecords1(){
        
        Database.executeBatch(new BatchToUpdateIPRecordValues());
        
        BatchToUpdateIPRecordValues sh1 = new BatchToUpdateIPRecordValues();
        String sch = '0 0 23 * * ?'; 
        system.schedule('Test BatchToUpdateIPRecordValues', sch, sh1);
    }
}