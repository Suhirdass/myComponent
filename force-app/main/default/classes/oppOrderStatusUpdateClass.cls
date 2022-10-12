public class oppOrderStatusUpdateClass {
 /*   
    List<order__c> orderList=new List<order__c>();
    set<id> oppIdSet=new set<id>();
    public static void oppOrderStatusUpdateMethod(List<opportunity> oppList){ 
            for(opportunity obj:oppList){
            oppIdSet.add(obj.id);
        }
        for(opportunity obj:[Select id,StageName,(Select id,Status__c from Orders) from opportunity where id in:oppIdSet]){ 
            if(obj.StageName == 'Closed Lost'){
            for(order__c con:obj.Orders){ 
                con.Status__c= 'Cancelled by WOVN'; 
                orderList.add(con); .
            }
        }
        }
        if(orderList.size() > 0){ 
            update orderList; 
        }
       
    }*/
}


/*

 Map<Id,Opportunity> oppIdToOppMap = new Map<Id,Opportunity>();
        List<order__c> orderList = new List<order__c>();
        for(Opportunity opp : newList){
            if(oldMap != null && opp.StageName != oldMap.get(opp.Id).StageName){
                oppIdToOppMap.put(opp.Id,opp);
            }
        }
*/