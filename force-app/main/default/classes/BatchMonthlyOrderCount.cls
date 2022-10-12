global class BatchMonthlyOrderCount implements Database.Batchable<sObject>, Database.Stateful, Schedulable{
    private static String Order_Status_Shipped{
        get{
            return String.isNotBlank(Order_Status_Shipped) ? Order_Status_Shipped : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Shipped');
        }set;
    }
    private static String Order_Type_Transfer{
        get{
            return String.isNotBlank(Order_Type_Transfer) ? Order_Type_Transfer : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Transfer');
        }set;
    }
    private static String Account_DBA_ZASP {
        get{
            return String.isNotBlank(Account_DBA_ZASP ) ? Account_DBA_ZASP  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_DBA_ZASP');
        }set;
    }
    private static String Account_DBA_IRR {
        get{
            return String.isNotBlank(Account_DBA_IRR ) ? Account_DBA_IRR  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_DBA_IRR');
        }set;
    }
     private Static String Account_Service_Type_Margin {		
        get{
              return String.isNotBlank(Account_Service_Type_Margin) ? Account_Service_Type_Margin : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Service_Type_Margin');
        }set;
    }
    global Database.QueryLocator start(Database.BatchableContext bc) {
        Integer currentMonth = System.Today().month();
        Integer currentYear = System.Today().year();//AND Account__r.Service_Type__c =:Account_Service_Type_Margin
        return Database.getQueryLocator([ SELECT id,Delivered_Date__c,Account__c FROM Order__c WHERE CALENDAR_MONTH(Delivered_Date__c) =:currentMonth AND CALENDAR_YEAR(Delivered_Date__c) =: currentYear AND Status__c =: Order_Status_Shipped AND RecordType.Name =: Order_Type_Transfer  AND Sample_Order__c = false AND (Retailer__r.DBA__c =: Account_DBA_ZASP OR Retailer__r.DBA__c =: Account_DBA_IRR)]);
    }
    global void execute(Database.BatchableContext bc, List<Order__c> records){
         Map<String,List<Order__c>> odrMap  = new Map<String,List<Order__c>>();
        for(Order__c o : records){
           if(odrMap.containsKey(o.Account__c)){
                odrMap.get(o.Account__c).add(o);
            }else{
                odrMap.put(o.Account__c,new List<Order__c>{o});
            }
        }
        if(odrMap.size() > 0 ){
            List<Account_Setting__c> accSettingUpdateList = new List<Account_Setting__c>();
            Set<String> alreadyCreatedAccs = new Set<String>();
            List<Account_Setting__c> accSettingList = [SELECT id,Mthly_IB__c,Mthly_OB__c,Account__c FROM Account_Setting__c WHERE Account__c IN :odrMap.keySet()];
            if(accSettingList.size() > 0){
                for(Account_Setting__c accset : accSettingList){
                    accset.Mthly_OB__c =  odrMap.get(accset.Account__c).size();
                    alreadyCreatedAccs.add(accset.Account__c);
                    accSettingUpdateList.add(accset);
                }
            }
            for(String accId : odrMap.keySet()){
                if(!alreadyCreatedAccs.contains(accId)){
                    Account_Setting__c accset = new Account_Setting__c();
                    accset.Account__c = accId;
                    accset.Mthly_OB__c = odrMap.get(accId).size();
                    accSettingUpdateList.add(accset);
                }
            }
            if(accSettingUpdateList.size() >0){
                upsert accSettingUpdateList;
            }
        }
        
    }
    global void execute(SchedulableContext sc){
        Database.executeBatch(new BatchMonthlyOrderCount());
    }
    global void finish(Database.BatchableContext bc){}
}