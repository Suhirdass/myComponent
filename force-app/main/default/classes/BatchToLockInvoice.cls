global class BatchToLockInvoice implements Database.Batchable<sObject>, Database.Stateful, Schedulable{
    global Database.QueryLocator start(Database.BatchableContext bc) {
        /*Date datobj = system.today();
        Integer year = datobj.year();
        Integer month = datobj.month();//CALENDAR_MONTH(Invoice_Date__c) =: month AND CALENDAR_YEAR(Invoice_Date__c) =: year*/
        return Database.getQueryLocator([SELECT id,IsLocked__c,Revenue_Recognition_Date__c FROM Invoice__c WHERE Invoice_Date__c <=: system.today() AND Revenue_Recognition_Date__c != null AND IsLocked__c = false]);
    }
    global void execute(Database.BatchableContext bc, List<Invoice__c> records){
        if(records.size() > 0){
            for(Invoice__c inv : records){
                inv.IsLocked__c = true;
            }
            update records;
        }
    }
    global void finish(Database.BatchableContext bc){
        
        /*for(CronTrigger c:[SELECT NextFireTime, CronJobDetail.Name, Id, State, StartTime, EndTime, CronExpression, TimesTriggered FROM CronTrigger WHERE TimesTriggered >= 1]){
            System.abortJob(c.Id);
        }*/
    } 
    global void execute(SchedulableContext sc){
        Database.executeBatch(new BatchToLockInvoice());
    }
}