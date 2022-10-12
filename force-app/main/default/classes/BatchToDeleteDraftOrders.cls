global class BatchToDeleteDraftOrders implements Database.Batchable<sObject>, Database.Stateful, Schedulable{
    
    
    String status = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Delete_Order_Status');
    String recordTypeName = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_ Brand');
    Integer hours = Integer.valueOf(FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Delete_Order_Hours'));
    public BatchToDeleteDraftOrders() {
    }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        Datetime lastDate = datetime.now().addhours(-hours);
        return Database.getQueryLocator([SELECT Id,lastmodifieddate FROM Order__c WHERE Status__c =: status AND lastmodifieddate < :lastDate ]);
    }
    global void execute(Database.BatchableContext bc, List<Order__c> records){
        delete records;
    }
    
    global void finish(Database.BatchableContext bc){} 
    
    global void execute(SchedulableContext sc){}
    
}