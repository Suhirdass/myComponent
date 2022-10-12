trigger InvoiceLineTrigger on Invoice_Line__c (before insert, after insert,before update, after update, before delete) {
    if(TestUtilData.skipTrigger) return;
    if(Trigger.isBefore){
        InvoiceLineTriggerHelper.preventUpdatationOnLockedInvoice(Trigger.New,Trigger.Old);
    }
    if(Trigger.isBefore && !Trigger.isDelete){
        LocalTaxCalculateHelper.calculateTaxOnCity(Trigger.New,Trigger.oldMap);
        
    }
    if(Trigger.isAfter){
        InvoiceLineTriggerHelper.reCalculateFees(Trigger.New,Trigger.oldMap);
        InvoiceLineTriggerHelper.checkAllINLIisCancelled(Trigger.New,Trigger.oldMap);
    }
}