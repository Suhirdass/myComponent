@isTest
public class CreateFactoringServiceInvoiceCtrlTest {
	private static testmethod void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
        insert GDMIs;
        TestUtilData.createTestData();
        TestUtilData.skipTrigger = true;
        Test.startTest();
        
        Purchase_Order__c objPO =[select id,Name FROM Purchase_Order__c limit 1];
        Account acc = [SELECT Id,Name FROM Account LIMIT 1];
        Contact con = [SELECT Id,Name FROM Contact LIMIT 1];
        
        objPO.Factoring_Assignee__c = acc.Id;
        objPO.Factoring_Rate__c = 10;
        objPO.Factoring_Contact__c = con.Id;
        update objPO;
        
        CreateFactoringServiceInvoiceController.getRecordDetails(objPO.Id);
        CreateFactoringServiceInvoiceController.createFactoringServiceInvoice(objPO.Id);
        Test.stopTest();
    }
}