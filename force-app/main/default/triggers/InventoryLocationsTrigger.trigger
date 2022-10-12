trigger InventoryLocationsTrigger on Inventory_Location__c (after insert, after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            InventoryLocationsTriggerHandler.afterInsert(Trigger.new);
        } else if(Trigger.isUpdate){
            InventoryLocationsTriggerHandler.afterUpdate(Trigger.new,Trigger.oldMap);

        }
    }
}