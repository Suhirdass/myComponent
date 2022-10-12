trigger UIdsTrigger on UID__c (before insert,before update) {
    UIdsTriggerHandler.checkDuplicate(trigger.New,trigger.oldMap);
}