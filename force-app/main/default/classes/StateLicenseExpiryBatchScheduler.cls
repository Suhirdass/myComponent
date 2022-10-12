/**************************************************************************************
Apex Class Name    : StateLicenseExpiryBatchScheduler 
     Class for     :StateLicenseExpiryBatch
Version            : 1.0
Created Date       : Aug 28 2018
Function           : Used for StateLicenseExpiryBatch
Modification Log   :
------------------------------------------------------------------------------
 * Developer                   Date                   Description
 * ----------------------------------------------------------------------------
 * Suresh                  08/28/2018              Original Version
*******************************************************************************/
global class StateLicenseExpiryBatchScheduler implements Schedulable {
   global void execute(SchedulableContext sc) {
     StateLicenseExpiryBatch b = new StateLicenseExpiryBatch(); 
     database.executebatch(b,200);
   }
}