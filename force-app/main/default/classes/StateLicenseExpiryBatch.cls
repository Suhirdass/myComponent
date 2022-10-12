/**************************************************************************************
Apex Class Name    : StateLicenseExpiryBatch
Class for     :StateLicenseExpiryBatchScheduler,StateLicenseExpiryBatchTest
Version            : 1.0
Created Date       : Aug 28 2018
Function           : Used for StateLicenseExpiry logic
Modification Log   :
------------------------------------------------------------------------------
 * Developer                   Date                   Description
 * ----------------------------------------------------------------------------
 * Suresh                  08/28/2018              Original Version
*******************************************************************************/
global class StateLicenseExpiryBatch implements Database.Batchable<sObject>{

   String query= 'select id,License_Status__c,License_Expiration_Date__c from State_Licenses__c where License_Status__c !=\'Expired\' and License_Expiration_Date__c < TODAY';

   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(Query);
   }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
     List<State_Licenses__c> scopeList = (List<State_Licenses__c>)scope;
     for(State_Licenses__c s : scopeList){
     s.License_Status__c='Expired';
     }
     update scope;
    }

   global void finish(Database.BatchableContext BC){
   }
}