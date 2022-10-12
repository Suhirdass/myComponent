trigger UserTrigger on User (after insert,after update,before insert,before update) {
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate )){
        UserHelper.onBeforeInsertUpdate(Trigger.new,Trigger.oldMap);
    }
    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate )){
        UserHelper.portalLoginTypeUpdate(Trigger.new,Trigger.oldMap);
    }
}