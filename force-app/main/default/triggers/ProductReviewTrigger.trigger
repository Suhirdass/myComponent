trigger ProductReviewTrigger on Product_Review__c (after insert, after update, after delete) {
    if(Trigger.isInsert || Trigger.isUpdate){
        ProductReviewTriggerHandler.onInsertUpdate(Trigger.New);
    }
    if(Trigger.isDelete){
        ProductReviewTriggerHandler.onDelete(Trigger.Old);
    }
}