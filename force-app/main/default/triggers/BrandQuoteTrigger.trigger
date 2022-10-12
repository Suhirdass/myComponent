trigger BrandQuoteTrigger on Brand_Quote__c (before insert ,before update,after update) {
    if(!Test.isRunningTest() || (Test.isRunningTest() && !BrandQuoteTriggerHelper.isBQTriggerExecuted)){
        if(Trigger.isBefore){
            //BrandQuoteTriggerHelper.updateSiteFromReceiverLicense(Trigger.new,Trigger.oldMap);
            BrandQuoteTriggerHelper.updateMutualPaymentTerms(trigger.new);
             
            if(Trigger.isUpdate && !ShippingManifestLineTriggerHandler.isSMCancelled){
                BrandQuoteTriggerHelper.updateBrandQuoteReceiverName(Trigger.newMap);
                BrandQuoteTriggerHelper.updatePlanShipDate(Trigger.new,Trigger.oldMap);
                BrandQuoteTriggerHelper.updateMileageFee(Trigger.new,Trigger.oldMap);
            }
        }
        if (Trigger.isAfter &&  Trigger.isUpdate) {
            BrandQuoteTriggerHelper.updateBQLIStatusToCancel(Trigger.New,Trigger.oldMap);
        }
       
    }
}