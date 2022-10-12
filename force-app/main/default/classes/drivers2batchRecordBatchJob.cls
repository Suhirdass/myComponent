global class drivers2batchRecordBatchJob implements Database.Batchable<sObject>
{
    List<driver__c> listdriver =new List<driver__c>();
    String query = 'SELECT Id, Name,Last_Working_Date__c,Intiate_Off_Date__c FROM driver__c where Last_Working_Date__c = system.today()';
    
global Database.QueryLocator start(Database.BatchableContext BC)
  {
        system.debug('inside batch');
      //  String query = 'SELECT Id, Name,Last_Working_Date__c,Intiate_Off_Date__c FROM driver__c where Last_Working_Date__c = system.today()';
       
        return Database.getQueryLocator(query);
    }
 global void execute(Database.BatchableContext BC, List<driver__c> drive)
    {
        
        for( driver__c drv : drive)
        {
            
            
           if (drv.Last_Working_Date__c == system.today())
           {
               drv.Intiate_Off_Date__c = True;
               
               listdriver.add(drv);
               system.debug('listdriver'+drv);
           }
           
        }
        update listdriver;
    }
    global void finish(Database.BatchableContext BC) {
    }


}