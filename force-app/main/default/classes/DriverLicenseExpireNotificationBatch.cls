global class DriverLicenseExpireNotificationBatch implements Database.Batchable<Drivers__c>, Schedulable{
    
    global void execute(SchedulableContext SC) {
       Database.executeBatch(new DriverLicenseExpireNotificationBatch());
    }
    
    global Iterable<Drivers__c> start(Database.BatchableContext bc) {
        Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
        Date DateBeforeN1Days = Date.today().addDays(integer.valueOf(ccs.Driver_License_Expire_N1_Days_Notice__c));   
        Date DateBeforeN2Days = Date.today().addDays(integer.valueOf(ccs.Driver_License_Expire_N2_Days_Notice__c));        
        return [Select Id, Notified_Before_N1_Days_License_Expire__c, Notified_Before_N2_Days_License_Expire__c,
				Expiration_Date__c from Drivers__c Where Active__c = True AND  
                (
                    (Notified_Before_N1_Days_License_Expire__c = False AND Expiration_Date__c = : DateBeforeN1Days)
                    OR
                	(Notified_Before_N2_Days_License_Expire__c = False AND Expiration_Date__c = : DateBeforeN2Days)
                )
              ]; 
    }
    
    global void execute(Database.BatchableContext bc, List<Drivers__c> records){
        List<Drivers__c> listOfDriversBeforeN1DaysLicenseExpire = new List<Drivers__c>();
        List<Drivers__c> listOfDriversBeforeN2DaysLicenseExpire = new List<Drivers__c>();
        List<String> userEmailAddresses = getEmailAddresses();
        Company_Custom_Settings__c ccsDefault = Company_Custom_Settings__c.getOrgDefaults();
        Date DateBeforeN1DaysVal = Date.today().addDays(integer.valueOf(ccsDefault.Driver_License_Expire_N1_Days_Notice__c));   
        Date DateBeforeN2DaysVal = Date.today().addDays(integer.valueOf(ccsDefault.Driver_License_Expire_N2_Days_Notice__c));
        for(Drivers__c driver : records){
            if(driver.Notified_Before_N1_Days_License_Expire__c == False && driver.Expiration_Date__c == DateBeforeN1DaysVal){
                listOfDriversBeforeN1DaysLicenseExpire.add(driver);
                driver.Notified_Before_N1_Days_License_Expire__c = True;
            }else if(driver.Notified_Before_N2_Days_License_Expire__c == False && driver.Expiration_Date__c == DateBeforeN2DaysVal){
                listOfDriversBeforeN2DaysLicenseExpire.add(driver);
                driver.Notified_Before_N2_Days_License_Expire__c = True;
            }
        }
        for(Drivers__c driver : listOfDriversBeforeN1DaysLicenseExpire){
    		sendNotification(driver.Id, integer.valueOf(ccsDefault.Driver_License_Expire_N1_Days_Notice__c), userEmailAddresses);    
        }
        for(Drivers__c driver : listOfDriversBeforeN2DaysLicenseExpire){
    		sendNotification(driver.Id, integer.valueOf(ccsDefault.Driver_License_Expire_N2_Days_Notice__c), userEmailAddresses);    
        }
        
        update records;
    }
    
    public void sendNotification(String driverId, Integer beforeNDays, List<String> listOfToAddresses){
        EmailTemplate et = [Select id, Subject, Body from EmailTemplate where DeveloperName = 'Driver_License_Expire_Notification' limit 1];
        Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
        msg.setTemplateId(et.Id);
        msg.setWhatId(driverId);
        msg.setToAddresses(listOfToAddresses); 
        List<String> ccEmails = label.Driver_Expiration_CC_email.split(',');
        msg.setCcAddresses(ccEmails); 
        msg.setSubject(et.Subject + ' ' + beforeNDays + ' days.');
        msg.setPlainTextBody(et.Body);
        msg.setTreatBodiesAsTemplate(true);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { msg });
    }
    
    public List<String> getEmailAddresses(){
        List<String> mailList = new List<String>();
        List<String> mailAddresses = new List<String>(); 
        Group g = [SELECT (select userOrGroupId from groupMembers) FROM group WHERE developername = 'Driver_License_Expire_Notification'];
        for (GroupMember gm : g.groupMembers) {
            mailList.add(gm.userOrGroupId);
        }
        User[] listOfUsers = [SELECT email FROM user WHERE id IN : mailList];
        for(User u : listOfUsers){
            mailAddresses.add(u.email);
        } 
        return mailAddresses;
    }
    
    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
    }
}