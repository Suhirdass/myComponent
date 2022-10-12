trigger LineCardTrigger on Line_Card__c (before insert,before update) {
	LineCardTriggerHelper.dupicateLineCardCheck(Trigger.new, Trigger.oldMap);
}