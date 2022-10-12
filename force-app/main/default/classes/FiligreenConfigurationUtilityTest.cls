@isTest
public class FiligreenConfigurationUtilityTest {
    private static testmethod void runTest(){
       FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Compliance Images','Lab_Test_Status_Expired_COA');
       Map<String, Config__mdt[] > objectConfigMetadataMap = FiligreenConfigurationUtility.objectConfigMetadataMap;
       FiligreenConfigurationUtility.getCollectionStatus('contact');
    }
}