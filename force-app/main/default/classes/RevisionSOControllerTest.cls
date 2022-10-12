@isTest
public class RevisionSOControllerTest {
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        SOlineTriggerHandler.isRecursion = true;
        TestUtilData.createTestData();
    }
    private static testmethod void runTest(){
        Site__c s = new Site__c(Name= '2089-3');
        insert s;
        Account acc = [SELECT Id, Name,dBA__c,Community_Price_Book__c, Type FROM Account WHERE Name = 'Test Account1' LIMIT 1];
        acc.Type = 'Distributor';
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        acc.Hide_From_Marketplace__c = false;
        update acc;
        List<RecordType> rt= [SELECT id FROM RecordType WHERE Name='Product'];
       Sales_Order__c salesOrderObj = [Select Site__c,
                         Brand_Quote__c, 
                         Distributor_Contact__c, 
                         Distributor_License__c,
                         Distributor_Name__c,
                         Opportunity_Name__c,
                         Payment_Terms__c,
                         Planned_Ship_Date__c,
                         Receiver_Contact__c,
                         Receiver_License__c,
                         Receiver_Name__c,
                         Sample_Order__c,
                         Shipping_Method__c,
                         Shipping_Terms__c,
                         Supplier_Contact__c,
                         Supplier_License__c,
                         Supplier_Name__c
                         from Sales_Order__c];
        //salesOrderObj.Site__c=s.Id;
        salesOrderObj.RecordTypeId=rt[0].id;
        update salesOrderObj;
        Picklist__c pl =new Picklist__c(Sales_Order__c=salesOrderObj.id);
        insert pl;
        Shipping_Manifest__c sm=new Shipping_Manifest__c();
        sm.Sales_Order__c=salesOrderObj.id;
        //sm.Status__c='Approved';
        insert sm;
        Invoice__c invoice = new Invoice__c();
        invoice.Sales_Order__c = salesOrderObj.Id;
        invoice.AR_Status__c = 'Approved';
        invoice.RecordTypeId =Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get('Service').getRecordTypeId();
        insert invoice;
        List<Sales_Order_Line__c> soLines = new List<Sales_Order_Line__c>();
        soLines = [Select Id, Status__c, Brand_Quote_Line__c from Sales_Order_Line__c];
        Invoice_Line__c invoiceLine = new Invoice_Line__c();
        invoiceLine.Sales_Order_Line__c = soLines[0].Id;
        invoiceLine.Invoice__c = invoice.Id;
        insert invoiceLine;
        Order_Revision__c orderRevi =new Order_Revision__c();
        orderRevi.Sales_Order__c =salesOrderObj.id;
        orderRevi.Sales_Order_Line__c=soLines[0].id;
        orderRevi.Revision_Reason__c='test';
        insert orderRevi;
        Test.StartTest();
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        AuraResponse r = RevisionSOController.checkSOStatus(salesOrderObj.id);
        system.debug('####salesOrderObj.Id :'+salesOrderObj.Id);
        system.debug('####salesOrderObj.RecordTypeId :'+salesOrderObj.RecordTypeId);
        r = RevisionSOController.createOrderRevisions(JSON.serialize(soLines),salesOrderObj.id,'test',False);
        
        salesOrderObj.SO_Status__c='Shipped';
        update salesOrderObj;
        
         r = RevisionSOController.checkSOStatus(salesOrderObj.id);
         salesOrderObj.SO_Status__c='Approved';
        update salesOrderObj;
        r = RevisionSOController.checkSOStatus(salesOrderObj.id);
        Test.stopTest();
    }
}