global class BatchToUpdateIPRecordValues implements Database.Batchable<sObject>, Database.Stateful, Schedulable{
    
    String X30_OR_LESS_DAYS = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Position','Aged_Bucket_30_or_Less_Days');
    String X31_TO_60_DAYS = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Position','Aged_Bucket_31_to_60_Days');
    String X61_to_90_DAYS = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Position','Aged_Bucket_61_to_90_Days');
    String X91_to_120_DAYS = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Position','Aged_Bucket_91_to_120_Days');
    String X121_to_150_DAYS = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Position','Aged_Bucket_121_to_150_Days');
    String X151_to_180_DAYS = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Position','Aged_Bucket_151_to_180_Days');
    String X181_or_More_DAYS = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Position','Aged_Bucket_181_or_More_Days');

    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        
		return Database.getQueryLocator([SELECT Id,Name,Aged_Bucket__c,Days_in_Inventory__c,Total_Days_in_Inventory__c 
                                         FROM Inventory_Position__c WHERE Days_in_Inventory__c != null]);        
    }
    
    global void execute(Database.BatchableContext bc, List<Inventory_Position__c> records){
        List<Inventory_Position__c> lstInvPos = new List<Inventory_Position__c>();
        Savepoint savePoint;
        try{
            savePoint = Database.setSavepoint();
            for(Inventory_Position__c inv : records){
                if(inv.Days_in_Inventory__c <= 30 && inv.Aged_Bucket__c != X30_OR_LESS_DAYS){
                    inv.Aged_Bucket__c = X30_OR_LESS_DAYS;
                    lstInvPos.add(inv);
                } else if(inv.Days_in_Inventory__c <= 60 && inv.Days_in_Inventory__c > 30 && inv.Aged_Bucket__c != X31_TO_60_DAYS){
                    inv.Aged_Bucket__c = X31_TO_60_DAYS; 
                    lstInvPos.add(inv);
                } else if(inv.Days_in_Inventory__c <= 90 && inv.Days_in_Inventory__c > 60 && inv.Aged_Bucket__c != X61_to_90_DAYS){
                    inv.Aged_Bucket__c = X61_to_90_DAYS;
                    lstInvPos.add(inv);
                } else if(inv.Days_in_Inventory__c <= 120 && inv.Days_in_Inventory__c > 90 && inv.Aged_Bucket__c != X91_to_120_DAYS){
                    inv.Aged_Bucket__c = X91_to_120_DAYS;
                    lstInvPos.add(inv);
                } else if(inv.Days_in_Inventory__c <= 150 && inv.Days_in_Inventory__c > 120 && inv.Aged_Bucket__c != X121_to_150_DAYS){
                    inv.Aged_Bucket__c = X121_to_150_DAYS;
                    lstInvPos.add(inv);
                } else if(inv.Days_in_Inventory__c <= 180 && inv.Days_in_Inventory__c > 150 && inv.Aged_Bucket__c != X151_to_180_DAYS){
                    inv.Aged_Bucket__c = X151_to_180_DAYS;
                    lstInvPos.add(inv);
                } else if(inv.Days_in_Inventory__c > 180 && inv.Aged_Bucket__c != X181_or_More_DAYS){
                    inv.Aged_Bucket__c = X181_or_More_DAYS;
                    lstInvPos.add(inv);
                }
            }
            if(lstInvPos.size() > 0){
                update lstInvPos;
            }
        } catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('BatchToUpdateIPRecordValues', ex.getStackTraceString(), ex.getMessage());
        }
    }
    
    global void execute(SchedulableContext sc){
        Database.executeBatch(new BatchToUpdateIPRecordValues());
    }
    
    global void finish(Database.BatchableContext bc){} 
}