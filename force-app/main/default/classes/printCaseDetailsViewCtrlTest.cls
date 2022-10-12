@IsTest 
private class printCaseDetailsViewCtrlTest {
 @isTest
    private static void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        TestUtilData.createTestData();
        
        printCaseDetailsViewCtrl printCase = new printCaseDetailsViewCtrl();   
    }
}