trigger ShippingManifestTrigger on Shipping_Manifest__c (after insert,after update) {
    if(TestUtilData.skipTrigger){
        return;
    }
    if(trigger.isAfter){
        if(Trigger.isInsert){
             ShippingManifestHandler.afterInsert(Trigger.New);
        } else if(Trigger.isUpdate){
               if(ShippingManifestLineTriggerHandler.isSmlineRejectFromSmComple == false || RSMTSMShipConfirmCotroller.IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED== true)
           {
              ShippingManifestHandler.afterUpdate(Trigger.New,Trigger.oldMap); 
           }
            ShippingManifestHandler.updateWinStartEnd(trigger.new, trigger.oldMap);
        }
    }
    
    if(CheckManifestRecursion.runOnce() && !system.isBatch()){
        if(Trigger.isInsert){
            ShippingManifestHandler.routeMilesCalculation(Trigger.New,new Map<Id,Shipping_Manifest__c>());
            //ShippingManifestHandler.syncPOSOFromShippingManifest(Trigger.New);
        }else{
            if(!ShippingManifestLineTriggerHandler.isSMCancelled){
                ShippingManifestHandler.cancelLineItems(Trigger.New,Trigger.oldMap);
                ShippingManifestHandler.routeMilesCalculation(Trigger.New,Trigger.oldMap);
               // ShippingManifestHandler.syncPOSOFromShippingManifest(Trigger.New);
                
            }
            
        }
    }
}