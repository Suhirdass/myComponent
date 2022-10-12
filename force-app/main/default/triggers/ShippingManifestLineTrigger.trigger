trigger ShippingManifestLineTrigger on Shipping_Manifest_Line__c (before insert,after update) {
    // SmLine status change on internl
    if(Trigger.isAfter && Trigger.isUpdate)
   {
    if(ShippingManifestLineTriggerHandler.isSmlineRejToSmComple== False && ShippingManifestHandler.internsmStatusCompleteToReject==false && RSMTSMShipConfirmCotroller.IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED == True){
         ShippingManifestLineTriggerHandler.updateSmlineStatus(Trigger.new, Trigger.oldMap);
    }
   } 

    if(!ShippingManifestLineTriggerHandler.isSMCancelled && CancelRSMController.isTSMCancelled){ShippingManifestLineTriggerHandler.onAfterUpdate(Trigger.new, Trigger.oldMap);    
    }
        
}