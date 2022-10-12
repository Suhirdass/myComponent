trigger QualityAssuranceTrigger on Quality_Assurance__c (after insert,after Update,after delete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            QualityAssuranceTriggerHandler.afterInsert(Trigger.new);
        } else if(Trigger.isUpdate){
            QualityAssuranceTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        } else if(Trigger.isDelete){
         	QualityAssuranceTriggerHandler.afterInsert(Trigger.old);   
        }
    }
}