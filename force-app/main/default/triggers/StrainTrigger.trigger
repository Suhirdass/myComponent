trigger StrainTrigger on Strain__c (after insert,after update,before insert) {
    private static String Strain_Error_Message_Duplicate {
        get{
            return String.isNotBlank(Strain_Error_Message_Duplicate ) ? Strain_Error_Message_Duplicate  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Strain','Strain_Error_Message_Duplicate');
        }set;
    }
    if(Metrc_Utility.IS_STRAIN_TRIGGER_ENABLED){
        if(trigger.isAfter){
            if( Trigger.isInsert){
                Metrc_StrainTriggerHandler.afterInsert(Trigger.New);
            }
            if( Trigger.isUpdate){
                Metrc_StrainTriggerHandler.afterUpdate(Trigger.New,Trigger.oldMap);
            }
        }
    }
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            Set<String> strainNameSet = new Set<String>();
            Set<String> strainTypeSet = new Set<String>();
            for(Strain__c str: Trigger.new){
                strainNameSet.add(str.Name);
                strainTypeSet.add(str.Strain_Type__c);
            }
            if(strainNameSet.size() > 0 && strainTypeSet.size() > 0){
                List<Strain__c> lstStrain = [SELECT Id,Name,Strain_Type__c FROM Strain__c WHERE Name IN :strainNameSet AND Strain_Type__c IN :strainTypeSet];
                Map<String ,Strain__c> mapNameWiseStrain = new Map<String,Strain__c>();
                Map<String ,Strain__c> mapTypeWiseStrain = new Map<String,Strain__c>();
                for(Strain__c strin: lstStrain){
                    mapNameWiseStrain.put(strin.name.toLowerCase() ,strin);
                    mapTypeWiseStrain.put(strin.Strain_Type__c.toLowerCase() ,strin);
                }
                for(Strain__c str : trigger.new){
                    if(mapNameWiseStrain.containsKey(str.name.toLowerCase()) && mapTypeWiseStrain.containsKey(str.Strain_Type__c.toLowerCase())){
                        str.addError(Strain_Error_Message_Duplicate);
                        return;
                    }
                }
            }
        }
    }
}