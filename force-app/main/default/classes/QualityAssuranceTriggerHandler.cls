public class QualityAssuranceTriggerHandler {
    private static String PO_QA_status_Confirmed{
        get{
            return String.isNotBlank(PO_QA_status_Confirmed) ? PO_QA_status_Confirmed : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_QA_status_Confirmed');
        }set;
    }
    private static String PO_QA_status_Open{
        get{
            return String.isNotBlank(PO_QA_status_Open) ? PO_QA_status_Open : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_QA_status_Open');
        }set;
    }
    public static void afterInsert(List<Quality_Assurance__c> lstQAs){
    	Set<Id> setId = new Set<Id>();
        Set<Id> RELIids  = new Set<Id>();
        for(Quality_Assurance__c qa : lstQAs){
            if(qa.Picklist_Line__c != null){
                setId.add(qa.Picklist_Line__c);
            }
            if(qa.Receiving_Line__c != null){
                RELIids.add(qa.Receiving_Line__c);
            }
        }
        if(setId.size() > 0){
            updatePickLineCount(setId);
        }
        if(RELIids.size() > 0){
            updatePOQAStatus(RELIids);
        }
    }
    
    public static void afterUpdate(List<Quality_Assurance__c> lstQAs, Map<Id,Quality_Assurance__c> oldMap){
    	Set<Id> setId = new Set<Id>();
        Set<Id> RELIids  = new Set<Id>();
        for(Quality_Assurance__c qa : lstQAs){
            Quality_Assurance__c oldQA = oldMap.get(qa.Id);
            if(qa.Picklist_Line__c != null && oldQA.Picklist_Line__c != qa.Picklist_Line__c){
                setId.add(qa.Picklist_Line__c);
                setId.add(oldQA.Picklist_Line__c);
            }
            if(qa.Receiving_Line__c != null && oldQA.Receiving_Line__c != qa.Receiving_Line__c){
                RELIids.add(qa.Receiving_Line__c);
            }
        }
        if(setId.size() > 0){
            updatePickLineCount(setId);
        }
        if(RELIids.size() > 0){
            updatePOQAStatus(RELIids);
        }
    }
    
    private static void updatePickLineCount(Set<Id> pickLineId){
        List<Picklist_Line__c> pickLine = [SELECT Id,Name,QA_Count__c,QA_Status__c,(SELECT Id FROM Quality_Assurances__r) FROM Picklist_Line__c WHERE Id In : pickLineId];
        if(pickLine.size() > 0){
            for(Picklist_Line__c pick : pickLine){
                List<Quality_Assurance__c> lstQA = pick.Quality_Assurances__r;
                if(lstQA != null && lstQA.size() > 0){
                    pick.QA_Count__c = lstQA.size();
                } else {
                    pick.QA_Count__c = 0;
                }
                pick.QA_Status__c = 'Yes';
            }
            update pickLine;
        }
    }
    private static void updatePOQAStatus(Set<Id> RELIids){
        Set<Id> POIds = new Set<Id>();
        for(Receiving_Line__c RELI :[SELECT id,Receiving_ID__r.Purchase_Order__c FROM Receiving_Line__c WHERE id IN :RELIids]){
            if(RELI.Receiving_ID__r.Purchase_Order__c != null){
                POIds.add(RELI.Receiving_ID__r.Purchase_Order__c);
            }
        }
        if(POIds.size() > 0){
            Map<String,List<Receiving_Line__c>> RELIsMap = new Map<String,List<Receiving_Line__c>>();
            for(Receiving_Line__c RELI :[SELECT id,Receiving_ID__r.Purchase_Order__c,(SELECT id,Name FROM Quality_Assurances__r) FROM Receiving_Line__c WHERE Receiving_ID__r.Purchase_Order__c IN :POIds]){
                if(RELIsMap.containsKey(RELI.Receiving_ID__r.Purchase_Order__c)){
                    RELIsMap.get(RELI.Receiving_ID__r.Purchase_Order__c).add(RELI);
                }else{
                    RELIsMap.put(RELI.Receiving_ID__r.Purchase_Order__c,new List<Receiving_Line__c>{RELI});
                }
            }
            List<Purchase_Order__c> updatePOs = new List<Purchase_Order__c>();
            for(String POId : RELIsMap.keySet()){
                Boolean isUpdatePO = true;
                for(Receiving_Line__c RELI  :RELIsMap.get(POId)){
                    if(RELI.Quality_Assurances__r.size() == 0){
                        isUpdatePO = false;
                    }
                }
                if(isUpdatePO){
                    updatePOs.add(new Purchase_Order__c(Id =POId,QA_Status__c =PO_QA_status_Confirmed));
                }else{
                    updatePOs.add(new Purchase_Order__c(Id =POId,QA_Status__c =PO_QA_status_Open));
                }
            }
            if(updatePOs.size() > 0 ){
                update updatePOs;
            }
        }
    }
}