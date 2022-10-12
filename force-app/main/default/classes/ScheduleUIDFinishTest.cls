@isTest(SeeAllData=false)
public class ScheduleUIDFinishTest {
    static testmethod void uidFinishTest() 
    {
        /*String CRON_EXP = '0 0 0 15 3 ? *';
        
        // Create your test data
       

        Test.startTest();
        UID__c  uid   = new UID__c();
        uid.Name ='1A4FF0300000029000000083';
        uid.Available_Qty_in_METRC__c = 0;
        uid.Active__c = true;
        uid.Available_Qty__c = 0;
        uid.Received_Qty__c = 20;
        insert uid;
        String jobId = System.schedule('ScheduleUIDFinishTest',  CRON_EXP, new ScheduleUIDFinish());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        
        Test.stopTest();
        // Add assert here to validate result*/
    }
}