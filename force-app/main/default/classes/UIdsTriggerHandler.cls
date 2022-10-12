public class UIdsTriggerHandler {
    public static void checkDuplicate(list<UID__c>newList,Map<id,UID__c>oldMap){
        set<string>uidNameSet = new set<string>();
        set<string>uidIdSet = new set<string>();
        for(UID__c uid : newList){
            if(uid.Name != null && (trigger.isInsert || (trigger.isUpdate && uid.Name != oldMap.get(uid.id).Name))){
                if(uidNameSet.contains(uid.Name)){
                	uid.addError('UID '+uid.Name +' already exists.');
                }else{
                	uidNameSet.add(uid.Name);   
                }
                if(trigger.isUpdate){
                    uidIdSet.add(uid.id);
                }
            }
        }
        if(uidNameSet.size() >0){
            set<string>existingUidNameSet = new set<string>();
            for(UID__c uid : [select Id,Name from UID__c where Name IN: uidNameSet AND Id NOT IN: uidIdSet AND Active__c = true]){
                existingUidNameSet.add(uid.Name);    
            }
            for(UID__c uid : newList){
                if(existingUidNameSet.contains(uid.Name)){
                    uid.addError('UID '+uid.Name +' already exists.');
                }
            }
        }
    }
}