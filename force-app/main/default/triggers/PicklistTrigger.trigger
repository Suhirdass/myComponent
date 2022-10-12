trigger PicklistTrigger on Picklist__c (after update) {
if(Metrc_Utility.IS_PICKLIST_TRIGGER_ENABLED){
    if(trigger.isAfter){
            if( Trigger.isUpdate){
                Metrc_PicklistTriggerHandler.afterUpdate(Trigger.New,Trigger.oldMap);
            }
    
    }
}
}