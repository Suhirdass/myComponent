@isTest
public class UpdateOwnerShipCodeTest {
	@isTest
    public static void testBehaviour(){
        TestUtilData.createTestData();
        Test.startTest();
        	Database.executeBatch(new UpdateOwnerShipCode('Opportunitylineitem','Product2Id'));
        Test.stopTest();
    }
}