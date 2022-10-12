Trigger InventoryPositionsTrigger on Inventory_Position__c (after insert, after update, after delete,before update) { 
    System.debug('####InventoryPositionsTrigger');//!InventoryPositionsHelper.invPositionTriggerExecuted &&
    if(TestUtilData.skipTrigger){
       return; 
    }
    if(Trigger.isBefore  && Trigger.isUpdate)  {
                InventoryPositionsHelper.updateLastIPLocation(Trigger.new,Trigger.oldMap);
    
    }                        

    if ( Trigger.isAfter && (Trigger.isDelete || Trigger.isInsert || Trigger.isUpdate)) {
        InventoryPositionsHelper.calculateRollupSummary(Trigger.new,Trigger.old);
        InventoryPositionsHelper.invPositionTriggerExecuted = true;
        
        InventoryPositionsHelper.updateQtytoReceive(Trigger.new,Trigger.old);
        
        if(Trigger.isUpdate){
            InventoryPositionsHelper.updateTotalDaysAndLastMovementDate(false,Trigger.new,Trigger.oldMap);
            InventoryPositionsHelper.updateIPHold(false,Trigger.new,Trigger.oldMap);


        } else if(Trigger.isInsert){
            InventoryPositionsHelper.updateTotalDaysAndLastMovementDate(true,Trigger.new,Trigger.oldMap);
            InventoryPositionsHelper.updateIPHold(true,Trigger.new,Trigger.oldMap);
        }
    }
}