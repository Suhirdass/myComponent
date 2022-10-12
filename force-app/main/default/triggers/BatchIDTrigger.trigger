trigger BatchIDTrigger on Harvest_Batch_Code__c (before insert, before update, after insert, after update) {
    
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
        if(Trigger.isUpdate){
            BatchIDTriggerHelper.updateIPRecords(Trigger.new,Trigger.oldMap);    
        }
        BatchIDTriggerHelper.updateProductFields(Trigger.new,Trigger.oldMap);
    }else if(Trigger.isBefore){
        BatchIDTriggerHelper.verifyUniqueBatchID(Trigger.New,Trigger.oldMap);
    }
    
}