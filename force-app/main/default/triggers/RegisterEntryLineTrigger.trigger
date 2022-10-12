/**
 * Copyright (c) 2021 Wovn
 * All rights reserved.
 * RegisterEntryLineTrigger
 */
trigger RegisterEntryLineTrigger on Register_Entry_Line__c (before insert, after insert,after update ) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            RegisterEntryLineTriggerHandler.updateOldBalance(Trigger.New);
           
        }
    }
    //
    if(Trigger.isAfter && (Trigger.isUpdate || Trigger.isInsert)){   
        if(massInvoiceRP.REGISTER_LINE_CHECK == False)  {
                  RegisterEntryLineTriggerHandler.updateReconciled(Trigger.New);
  
        }
     }
}