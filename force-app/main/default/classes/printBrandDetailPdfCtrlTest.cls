@IsTest 
private class printBrandDetailPdfCtrlTest {
    @isTest
    private static void runTest(){
        Google_Distance_Matrix_API__c g = new Google_Distance_Matrix_API__c();
        g.Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?';
        g.Name = 'Geocode_Endpoint';
        insert g;
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        TestUtilData.createTestData();
        
        //ApexPages.currentPage().getParameters().put('id', o.id);
        printBrandDetailPdfCtrl printBrand = new printBrandDetailPdfCtrl();   
    }
}