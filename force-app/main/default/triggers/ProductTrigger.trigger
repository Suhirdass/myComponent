/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * ProductTrigger
 */
trigger ProductTrigger on Product2 (before insert, before update, after update,after insert) {
    if(trigger.isBefore){
        ProductTriggerHandler.updateStrainPercentage(trigger.New, trigger.oldMap);
    }
  if(Metrc_Utility.IS_PROD_TRIGGER_ENABLED ){  
    if(trigger.isBefore){
        ProductTriggerHandler.verifyUniqueProductName(trigger.New, trigger.oldMap);
        
    }
    if(Trigger.isAfter && Trigger.isUpdate){
        ProductTriggerHandler.notifyCustomerOnAvailableInventory(trigger.New, trigger.oldMap);
    }
    
     //This code is triggered for Metrc integration
//    if(Metrc_Utility.IS_PROD_TRIGGER_ENABLED ){
    if(trigger.isAfter){
        if( Trigger.isInsert){
        system.debug('------------prod trigger------');
            Metrc_ProductTriggerHandler.afterInsert(Trigger.New);
        }
        if(Trigger.isUpdate){
            Metrc_ProductTriggerHandler.afterUpdate(Trigger.New,Trigger.oldMap);
        }
    }
}   
}