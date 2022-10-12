@isTest
public class BrandQuoteLineHandlerTest {
	private static testmethod void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
        insert GDMIs;
        TestUtilData.createTestData();
        Test.startTest();
                
        Opportunity Opp = [SELECT Id,Name from Opportunity where Name=:'Test Opp' LIMIT 1];
        
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.Warehouse_Name__c='TestWarehouse1';
        insert objSite;
        
        State_Licenses__c stLicence = [SELECT ID,Name from State_Licenses__c LIMIT 1];
        
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = stLicence.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        
        Opp.Order__c = ord.Id;
        update Opp;
        
        Brand_Quote_Line__c bqLine = [SELECT Id,Name,MOQ__c from Brand_Quote_Line__c LIMIT 1];
        bqLine.MOQ__c = 14.2;
        bqLine.Quantity_Cases__c = 12;
        update bqLine;
        
        System.assertEquals(bqLine.Quantity_Cases__c,12);
        Test.stopTest();        
    }
}