global class BatchToUpdateBrandDiscountsActive implements Database.Batchable<sObject>, Database.Stateful, Schedulable{
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id,Name,Discount_Active__c,Discount_Start_DateTime__c,Discount_End_DateTime__c FROM Brand_Discount__c 
                                                 WHERE DAY_ONLY(Discount_Start_DateTime__c) =: Date.today() OR DAY_ONLY(Discount_End_DateTime__c) =: Date.today()]); 
    }
    
    global void execute(Database.BatchableContext bc, List<Brand_Discount__c> records){
        for(Brand_Discount__c brand : records){
            if(brand.Discount_Start_DateTime__c.Date() == Date.today()){
                brand.Discount_Active__c = true;
            }
            if(brand.Discount_End_DateTime__c.Date() == Date.today()){
                brand.Discount_Active__c = false;
            }
        }
        update records;
    }
    
    global void execute(SchedulableContext sc){}
    
    global void finish(Database.BatchableContext bc){} 
}