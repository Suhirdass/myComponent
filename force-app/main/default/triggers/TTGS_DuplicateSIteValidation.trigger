trigger TTGS_DuplicateSIteValidation on TTGS_Strain__c (before insert,before update,After Insert) {
    system.debug('TTGS_DuplicateSIteValidation');
    if(Metrc_HttpCalloutHelper.TTGSActiveValidationTrigger == false){
        
        
         if(Trigger.isBefore  && Trigger.isUpdate)  {
        TTGS_DuplicateSIte_Validation_Helper.beforeUpdate(Trigger.new,Trigger.oldMap); 
    
    }   
           if(Trigger.isBefore  && Trigger.isInsert)  {
        TTGS_DuplicateSIte_Validation_Helper.beforeInsert(Trigger.new); 
    
    }    
                if(Trigger.isAfter  && Trigger.isInsert)  {
    TTGS_DuplicateSIte_Validation_Helper.GetVlaueFromParentInsert(Trigger.new); 
    }  
    }
}
//TTGSStrain_Active_Validation