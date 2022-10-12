trigger TTGSItem_Active_Validation on TTGS_Item__c (before insert,before update) {
    
    // TTGSItem_Active_Validation_Helper.beforeInsert(Trigger.New);
    
           if(Trigger.isBefore  && Trigger.isInsert)  {
        TTGSItem_Active_Validation_Helper.beforeInsert(Trigger.new); 
    
    }   
    
    if(Trigger.isBefore  && Trigger.isUpdate)  {
        TTGSItem_Active_Validation_Helper.beforeUpdate(Trigger.new,Trigger.oldMap); 
    
    }   
}