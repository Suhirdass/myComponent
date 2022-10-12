@isTest
public class UIdsTriggerTest {
	@isTest
    private static void runTest(){
        list<UID__c>uidList = new list<UID__c>();
        UID__c uid = new UID__c();
        uid.Name = 'test12345678912341234125';
        insert uid;
    }
}