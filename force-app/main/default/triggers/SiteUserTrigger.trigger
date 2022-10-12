trigger SiteUserTrigger on Site_User__c (after insert, after update, after delete) {
    if(Trigger.isDelete){
        SiteUserTriggerHandler.updateAssignedWarehouseIdsOnUser(Trigger.old,null);
    }else{
        SiteUserTriggerHandler.updateAssignedWarehouseIdsOnUser(Trigger.new,Trigger.oldMap);
    }
	
}