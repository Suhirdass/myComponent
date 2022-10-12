trigger OrderLineItemOrder on Order_Line_Item__c (after insert,before insert, after update,before update, after delete) {
    if(OrderHelper.runningTrigger){
        return;
    }
    if(Trigger.isAfter){
        Order_Line_Item__c[] OLIList = Trigger.isDelete ? Trigger.old:Trigger.new;
        
        Order__c[] orders = new Order__c[]{};
            List<Id> productIds = new List<Id>();
            for(Order_Line_Item__c oli: OLIList){
                productIds.add(oli.Product__c);
                //orders.add(new Order__c(Id = oli.Order__c));
            }
        
        if(!productIds.isEmpty()){
            InventoryPositionsHelper.updateAvailableQty(productIds);
        }
        
    }/*else if(Trigger.isBefore){
        OrderLineItemHelper.updateLocalTax(Trigger.New,Trigger.oldMap);
    }*/
    if(Trigger.isAfter && (Trigger.isUpdate || Trigger.isInsert)){
        OrderLineItemHelper.reCalculateFees(Trigger.New,Trigger.oldMap);
    }
}