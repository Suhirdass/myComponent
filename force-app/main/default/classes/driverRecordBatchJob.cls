global class driverRecordBatchJob implements Database.Batchable<sObject>
{
    List<driver__c> listdriver =new List<driver__c>();
    String query = 'SELECT Id,Name,Expiration_Date__c FROM driver__c where Expiration_Date__c != null ';
    
global Database.QueryLocator start(Database.BatchableContext BC)
    {
        system.debug('inside batch');
      
        return Database.getQueryLocator(query);
    }
global void execute(Database.BatchableContext BC, List<driver__c> drive)
    {
        
        for( driver__c drv : drive)
        {
            
            
           if (drv.Expiration_Date__c < system.Today())
           {
              //drv.Licence_Expired__c = True;
               
               listdriver.add(drv);
               system.debug('listdriver'+drv);
           }
           
        }
        update listdriver;
    }
    global void finish(Database.BatchableContext BC) {
    }

}