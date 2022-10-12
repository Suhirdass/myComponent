global class BatchToUpdateCVUinBin implements Database.Batchable<sObject>, Schedulable {
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id, Name, Cubic_Volume_Utilization__c, (SELECT id, name FROM Inventory_Positions__r LIMIT 1) FROM Bin_Location__c]);
    }
    
    global void execute(Database.BatchableContext bc, List<Bin_Location__c> records){
        List<Bin_Location__c> binToUpdate = new List<Bin_Location__c>();
         for(Bin_Location__c bin : records){
             if(bin.Inventory_Positions__r.size() == 0){
                 bin.Cubic_Volume_Utilization__c = 0;
                 binToUpdate.add(bin);
             } 
         }
        if(binToUpdate.size() > 0){
            update binToUpdate;
        }
         
    }
    
    global void execute(SchedulableContext sc){
        Database.executeBatch(new BatchToUpdateCVUinBin());
    } 
    global void finish(Database.BatchableContext bc){}

}