trigger OpportunityLineItemsTrigger on OpportunityLineItem (before insert,after insert,after update) {
    if(Trigger.isInsert && Trigger.isUpdate){
        OpportunityLineItemsHandler.mapOwnershipCode(Trigger.new);
    }else if(Trigger.isUpdate){
        OpportunityLineItemsHandler.updateQuanitityOnOrderLineItems(Trigger.New,Trigger.oldMap);
    }
    if(Trigger.isAfter){
        OpportunityLineItemsHandler.reCalculateFees(Trigger.New,Trigger.oldMap);
    }
}