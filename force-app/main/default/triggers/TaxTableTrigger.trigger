trigger TaxTableTrigger on Tax_Table__c (before insert,before update) {
	TaxTableTriggerHelper.validateTaxTableForCity(Trigger.New, Trigger.oldMap);
}