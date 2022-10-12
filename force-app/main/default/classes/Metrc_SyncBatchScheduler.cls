/**********************************************************************************************************
Apex Class Name    : Metrc_SyncBatchScheduler 
Test Class Name    : Metrc_SyncBatchSchedulerTest
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : Used for syncing the metrc data to sfdc
Modification Log   : 
------------------------------------------------------------------------------------------------------------
* Developer         Date                   Description
* ----------------------------------------------------------------------------------------------------------
* Suresh S          24/Sep/2019              Original Version
************************************************************************************************************/
global class Metrc_SyncBatchScheduler implements Schedulable{
    
    global void execute(SchedulableContext sc) 
    {        
        Metrc_SyncBatchHandler.Metrc_SyncStrainBatch();
        Metrc_SyncBatchHandler.Metrc_SyncItemsBatch();
    }    
}