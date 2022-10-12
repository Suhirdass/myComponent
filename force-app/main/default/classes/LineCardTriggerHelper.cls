public class LineCardTriggerHelper {
    public static void dupicateLineCardCheck(List<Line_Card__c>newList,Map<Id,Line_Card__c> oldMap){
        Set<String> uniqueLCSet = new Set<String>();
        Set<Id> LCIds = new Set<Id>();
        for(Line_Card__c LC: newList){
            if(LC.Brand_Name__c != null && LC.Retailer_Name__c != null && (Trigger.isInsert || 
                (Trigger.isUpdate &&(LC.Brand_Name__c != oldMap.get(LC.Id).Brand_Name__c || 
                LC.Retailer_Name__c != oldMap.get(LC.Id).Retailer_Name__c)))){
                	String uniqueKey = LC.Brand_Name__c +''+ LC.Retailer_Name__c;
                    //LC.Unique_Line_Card_Helper__c = uniqueKey;
                    if(uniqueLCSet.contains(uniqueKey)){
                        //LC.addError('Duplicate Linecard with same Brand Name and Retailer Name.');
                        LC.addError('Duplicate Line card between Brand and Retailer.');

                    } else{
                        uniqueLCSet.add(uniqueKey);
                    }   
                    if(Trigger.isUpdate){
                        LCIds.add(LC.Id);
                    }
            }
        }
        if(!uniqueLCSet.isEmpty()){
            Set<String> existingUniqueLCs = new Set<String>();
            for(Line_Card__c LC: [SELECT Id, Name, Brand_Name__c, Retailer_Name__c, Unique_Line_Card_Helper__c FROM Line_Card__c WHERE Unique_Line_Card_Helper__c IN :uniqueLCSet AND Id NOT IN : LCIds]){
                existingUniqueLCs.add(LC.Unique_Line_Card_Helper__c);
            }
            System.debug('##existingUniqueLCs::'+existingUniqueLCs);
            for(Line_Card__c LC: newList){
                if(existingUniqueLCs.contains(LC.Brand_Name__c +''+ LC.Retailer_Name__c)){
                    LC.addError('Duplicate Line card between Brand and Retailer.');
                }
            }
        }
    }
}