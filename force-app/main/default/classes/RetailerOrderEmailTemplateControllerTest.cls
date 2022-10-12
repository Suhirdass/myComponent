@isTest
public class RetailerOrderEmailTemplateControllerTest {
    static testMethod void getOLI() {
        Test.setMock(HttpCalloutMock.class, new Miles_Mock());  
        TestUtilData.skipTrigger = true;
        
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        TestUtilData.createTestData();
        
        Order__c ord= new Order__c();
        ord.Status__c='Draft';
        ord.Order_Date__c=Date.today();
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        Product2  objProduct1 = [Select Id,Name from Product2 LIMIT 1];
        
        PricebookEntry pbe = [SELECT Id,Name,Product2Id from PricebookEntry WHERE Product2Id =: objProduct1.Id];
        
        Order_Line_Item__c ol= new Order_Line_Item__c();
        ol.Price_Book_Entry_Id__c=Id.valueOf(pbe.id);
        ol.UnitPrice__c=10;
        ol.MOQ__c=4;
        ol.Quantity_Cases__c=2;
        ol.Order__c=ord.id;
        ol.Product__c = objProduct1.id;
        insert ol;
        
        RetailerOrderEmailTemplateController retailOLI = new RetailerOrderEmailTemplateController();
        retailOLI.orderId = ord.id;
        retailOLI.getOrderLineItems();
        
        System.assertEquals(ord.Status__c,'Draft');
        System.debug('###'+RetailerOrderEmailTemplateController.PRODUCT_RECORD_TYPE_NAME_DISCOUNT);
    }
}