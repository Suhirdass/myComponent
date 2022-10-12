trigger ProductionWorkOrderTrigger on Production_Work_Order__c (before insert,before update) {
	ProductionWorkOrderTriggerHelper.updateEarliestPackagingDate(Trigger.New,Trigger.oldMap);
}