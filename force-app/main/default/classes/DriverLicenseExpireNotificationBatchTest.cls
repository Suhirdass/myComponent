@isTest
public class DriverLicenseExpireNotificationBatchTest {
    @isTest
    public static void testDriverExpiration(){
        Test.startTest();
        Database.executeBatch(new DriverLicenseExpireNotificationBatch());
        Test.stopTest();
    }
    
    @TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
        Drivers__c objDriver =TestUtilData.createDriver(false);
        objDriver.Expiration_Date__c = System.Today() + 7;
        objDriver.Notified_Before_N2_Days_License_Expire__c = false;
        insert objDriver;
        Company_Custom_Settings__c ccsObj = new Company_Custom_Settings__c();
        ccsObj.Driver_License_Expire_N1_Days_Notice__c = 15;
        ccsObj.Driver_License_Expire_N2_Days_Notice__c = 7;
        insert ccsObj;
    }
}