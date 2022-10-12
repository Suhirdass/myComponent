trigger ComplianceImageTrigger on Compliance_Images__c (after insert, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ComplianceImageTriggerHandler.afterInsert(Trigger.new);
        } else if(Trigger.isUpdate){
        	ComplianceImageTriggerHandler.afterUpdate(Trigger.new,Trigger.oldMap);    
        }   
    }
}