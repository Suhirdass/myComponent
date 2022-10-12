public class TaxTableTriggerHelper {
    public static void validateTaxTableForCity(Tax_Table__c[] newList, Map<Id,Tax_Table__c> oldMap){
        Set<Id> newTTIds = new Set<Id>();
        Map<String,Tax_Table__c[]> cityTaxTable = new Map<String,Tax_Table__c[]>();
        if(Trigger.isInsert){
            for(Tax_Table__c tt: newList){
                if(tt.Active__c){
                    if(cityTaxTable.containsKey(tt.City__c)){
                        cityTaxTable.get(tt.City__c).add(tt);
                    }else{
                        cityTaxTable.put(tt.City__c,new List<Tax_Table__c>{tt});
                    }
                }
            } 
            
        }else if(Trigger.isUpdate){
            
            for(Tax_Table__c tt: newList){
                if(tt.Active__c && tt.Active__c != oldMap.get(tt.Id).Active__c){
                    newTTIds.add(tt.Id);
                    if(cityTaxTable.containsKey(tt.City__c)){
                        cityTaxTable.get(tt.City__c).add(tt);
                    }else{
                        cityTaxTable.put(tt.City__c,new List<Tax_Table__c>{tt});
                    }
                }
            }
        }
        if(!cityTaxTable.isEmpty()){
            Tax_Table__c[] existingTTs = [SELECT Id, Active__c,City__c FROM Tax_Table__c WHERE Id NOT IN :newTTIds AND City__c IN :cityTaxTable.keySet() and Active__c = true];
            System.debug('##existingTTs::'+existingTTs);
            if(!existingTTs.isEmpty()){
                newList[0].addError('Can not create two Active Tax Table records for a City.');
            }else{
                for(String city: cityTaxTable.keySet()){
                    if(cityTaxTable.get(city).size() > 1){
                        newList[0].addError('Can not create two Active Tax Table records for a City.');
                        break;
                    }
                }
            }
        }
    }
}