@IsTest 
private class PrintOrdersPdfCtlrTest {
    @isTest
    private static void runTest(){
        Google_Distance_Matrix_API__c g = new Google_Distance_Matrix_API__c();
        g.Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?';
        g.Name = 'Geocode_Endpoint';
        insert g;
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        TestUtilData.createTestData();
        
        String filter = '{ "orderByField": "Name", "isASC": false }';
        ApexPages.currentPage().getParameters().put('filters', filter);
        ApexPages.currentPage().getParameters().put('showTransferOrders', 'false');
        
        PrintOrdersPdfCtlr printOrder = new PrintOrdersPdfCtlr();
        
        printOrder.callgetServiceTicketsData();
        printOrder.callGetRetailOrderData();
    }
}