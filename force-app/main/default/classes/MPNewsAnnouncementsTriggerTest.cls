@isTest
public class MPNewsAnnouncementsTriggerTest {
	@isTest
    private static void runTest(){
        MP_News_Announcements__c mpNews = new MP_News_Announcements__c(News_Details__c = 'test');
        insert mpNews;
    }
}