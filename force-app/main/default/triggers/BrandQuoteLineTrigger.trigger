trigger BrandQuoteLineTrigger on Brand_Quote_Line__c (before insert,after insert,before update,after update){
    if(!BrandQuoteTriggerHelper.isBQTriggerExecuted){
        /*if(Trigger.isBefore){
            LocalTaxCalculateHelper.calculateTaxOnCity(Trigger.New,Trigger.oldMap);        
		}*/
        if(Trigger.isBefore && Trigger.isInsert){
            BrandQuoteLineHandler.mapOwnershipCode(Trigger.new);
        }
        if(Trigger.isAfter && Trigger.isUpdate){
            BrandQuoteLineHandler.updateQuanitityOnOrderLineItems(Trigger.New,Trigger.oldMap);
        }
        if(Trigger.isAfter){
            BrandQuoteLineHandler.reCalculateFees(Trigger.New,Trigger.oldMap);
        }
    }
    
}