trigger ServiceTicketLineTrigger on Service_Ticket_Line__c (after insert,after update) {
	ServiceTicketLineTriggerHelper.onAfterInsertUpdate(Trigger.New);
    ServiceTicketLineTriggerHelper.setInboundQtyOnProduct(Trigger.New);
}