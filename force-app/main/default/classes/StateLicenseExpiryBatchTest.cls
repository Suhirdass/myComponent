/**************************************************************************************
Apex Class Name    : StateLicenseExpiryBatchTest
Test Class for     :StateLicenseExpiryBatch
Version            : 1.0
Created Date       : Aug 28 2018
Function           : Used for StateLicenseExpiryBatchJob
Modification Log   :
------------------------------------------------------------------------------
 * Developer                   Date                   Description
 * ----------------------------------------------------------------------------
 * Suresh                  08/28/2018              Original Version
*******************************************************************************/
@istest
private class StateLicenseExpiryBatchTest{
Static testmethod void theTests(){
    Test.StartTest();
    TestUtilData.createTestData();
    StateLicenseExpiryBatch b = new StateLicenseExpiryBatch(); 
    database.executebatch(b);
    Test.StopTest();
}
static testMethod void testschedule() {
    Test.StartTest();
    TestUtilData.createTestData();
    StateLicenseExpiryBatchScheduler sh1 = new StateLicenseExpiryBatchScheduler();
    String sch = '0 0 23 * * ?'; 
    system.schedule('Test Territory Check', sch, sh1); 
    Test.StopTest();

}
}