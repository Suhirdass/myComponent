global class BatchMonthlyInventory implements Database.Batchable<sObject>, Database.Stateful, Schedulable{
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([ select id,Total_Inventory__c,Month_Starting_Inventory__c from Product2 where IsActive =: true]);
    }
    global void execute(Database.BatchableContext bc, List<Product2> records){
        for(Product2 prd : records){
            prd.Month_Starting_Inventory__c = prd.Total_Inventory__c;
        }  
        Database.SaveResult[] lsr = Database.update(records,false);
    }
    global void execute(SchedulableContext sc){
        Database.executeBatch(new BatchMonthlyInventory());
    }
    global void finish(Database.BatchableContext bc){}
}