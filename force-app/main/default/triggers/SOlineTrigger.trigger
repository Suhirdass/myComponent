trigger SOlineTrigger on Sales_Order_Line__c (before insert,after insert,before update, after update) {
    //SOlineTriggerHandler.validateAllocation(Trigger.New, Trigger.oldMap);
    if(Trigger.isBefore){
        //LocalTaxCalculateHelper.calculateTaxOnCity(Trigger.New,Trigger.oldMap);
    }else if(Trigger.isAfter && Trigger.isUpdate){   
        
        if(ShipConfirmController.IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED == False || CancelRSMController.CANCELFROM_CANCELRSMCONTROLLER == true || ShippingManifestLineTriggerHandler.isSmlineRejectFromSmComple == True
           || ShippingManifestLineTriggerHandler.isSmlinePartialFromSmComple == True)
        {
            
            SOlineTriggerHandler.updateQuanitityOnOrderLineItems(Trigger.New,Trigger.oldMap);
        }
    }
    if(Trigger.isAfter){
        SOlineTriggerHandler.reCalculateFees(Trigger.New,Trigger.oldMap);
    }
    
}