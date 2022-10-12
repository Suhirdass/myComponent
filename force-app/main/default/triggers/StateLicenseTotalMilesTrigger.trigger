trigger StateLicenseTotalMilesTrigger on State_Licenses__c (after insert, after update,before insert,before update) {
    if(StateLicense_HttpCalloutHelper.IS_STATELICENSETOTALMILES_TRIGGER_ENABLED){
        if(Trigger.isAfter)
        {
            StateLicenseTotalMilesTriggerHelper.passSLId(Trigger.new,Trigger.oldMap); 
        }
        
        
        if(Trigger.isBefore)
        {
            StateLicenseTotalMilesTriggerHelper.duplicateLicenseNumCheck(Trigger.new);
            
        }
    }
}