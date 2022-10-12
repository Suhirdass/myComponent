Trigger OrderTrigger on Order__c (before insert,after insert,after update,before update) { 
    if(OrderHelper.runningTrigger){
        return;
    }
        
    if(Trigger.isBefore){
        OrderHelper.updateOrderRequestShipDate(Trigger.New,Trigger.oldMap);
        OrderHelper.updateOrderSubmitDate(Trigger.New,Trigger.oldMap);
        if(CancelRSMController.CANCELFROM_CANCELRSMCONTROLLER == False && CancelledPickListCtrl.CANCELPICKLIST == False && CancelSO.CANCELSO == False && CancelBQController.CANCELBQ == False && ShippingManifestHandler.internsmStatusCompleteToCancelled== False ) {
          OrderHelper.checkOppBqExists(Trigger.New,Trigger.oldMap);  
        }
        
    }
    if(Trigger.isBefore && Trigger.isInsert){
        OrderHelper.onBeforeInsert(Trigger.New);
    }
	
    if (Trigger.isAfter && Trigger.isUpdate) {
        OrderHelper.updateTotalOrderedQty(Trigger.New,Trigger.oldMap,true);
        OrderHelper.createOpportunity(Trigger.newMap,Trigger.oldMap);
        OrderHelper.updateOrderLineStatusToCancel(Trigger.New);
       OrderHelper.manageAccountSetting(Trigger.New,Trigger.oldMap);
    }
    /*if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)){
       OrderHelper.sendEmailToReceiver(Trigger.New,Trigger.oldMap);
    }*/
}