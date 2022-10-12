global class BatchMonthlySTCount implements Database.Batchable<sObject>, Database.Stateful, Schedulable{
    private static String ST_Status_Completed{
        get{
            return String.isNotBlank(ST_Status_Completed) ? ST_Status_Completed : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Status_Completed');
        }set;
    }
    private static String ST_Transfer_Method_Product_Conversions{
        get{
            return String.isNotBlank(ST_Transfer_Method_Product_Conversions) ? ST_Transfer_Method_Product_Conversions : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Transfer_Method_Product_Conversions');
        }set;
    }
    private Static String Account_Service_Type_Margin {		
        get{
              return String.isNotBlank(Account_Service_Type_Margin) ? Account_Service_Type_Margin : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Service_Type_Margin');
        }set;
    }
    
    public BatchMonthlySTCount() {
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        system.debug('##enter batch');
        Integer currentMonth = System.Today().month();
        Integer currentYear = System.Today().year();//Brand_Name__r.Service_Type__c =:Account_Service_Type_Margin AND 
        return Database.getQueryLocator([ SELECT id,Brand_Name__c FROM Service_Ticket__c WHERE CALENDAR_MONTH(Service_Complete__c) =:currentMonth AND CALENDAR_YEAR(Service_Complete__c) =: currentYear AND Status__c =: ST_Status_Completed AND Transfer_Method__c !=: ST_Transfer_Method_Product_Conversions]);
    }
    global void execute(Database.BatchableContext bc, List<Service_Ticket__c> records){
        system.debug('##records :'+records.size());
         Map<String,List<Service_Ticket__c>> stMap  = new Map<String,List<Service_Ticket__c>>();
        for(Service_Ticket__c st : records){
            if(stMap.containsKey(st.Brand_Name__c)){
                stMap.get(st.Brand_Name__c).add(st);
            }else{
                stMap.put(st.Brand_Name__c,new List<Service_Ticket__c>{st});
            }
        }
        if(stMap.size() > 0 ){
            List<Account_Setting__c> accSettingUpdateList = new List<Account_Setting__c>();
            Set<String> alreadyCreatedAccs = new Set<String>();
            List<Account_Setting__c> accSettingList = [SELECT id,Mthly_IB__c,Mthly_OB__c,Account__c FROM Account_Setting__c WHERE Account__c IN :stMap.keySet()];
            if(accSettingList.size() > 0){
                for(Account_Setting__c accset : accSettingList){
                    accset.Mthly_IB__c =  stMap.get(accset.Account__c).size();
                    alreadyCreatedAccs.add(accset.Account__c);
                    accSettingUpdateList.add(accset);
                }
            }
            for(String accId : stMap.keySet()){
                if(!alreadyCreatedAccs.contains(accId)){
                    Account_Setting__c accset = new Account_Setting__c();
                    accset.Account__c = accId;
                    accset.Mthly_OB__c = stMap.get(accId).size();
                    accSettingUpdateList.add(accset);
                }
            }
            if(accSettingUpdateList.size() >0){
                upsert accSettingUpdateList;
            }
        }
        
    }
    global void execute(SchedulableContext sc){
        Database.executeBatch(new BatchMonthlySTCount());
    }
    global void finish(Database.BatchableContext bc){}
}