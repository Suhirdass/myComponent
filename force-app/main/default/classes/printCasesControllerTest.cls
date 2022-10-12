@isTest
private class printCasesControllerTest {
  
 @isTest
    private static void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        TestUtilData.createTestData();
        
		String filter = '{ "orderByField": "createdDate", "isASC": false}';
        ApexPages.currentPage().getParameters().put('filters', filter);
        
        printCasesController printCase = new printCasesController();
        printCase.callgetCaseTicketsData();
    }
}