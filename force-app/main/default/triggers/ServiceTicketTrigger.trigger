trigger ServiceTicketTrigger on Service_Ticket__c (after insert,after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
        	ServiceTicketTriggerHandler.afterInsert(Trigger.new);    
        } else if(Trigger.isUpdate){
        	ServiceTicketTriggerHandler.afterUpdate(Trigger.new,Trigger.oldMap); 
            ServiceTicketTriggerHandler.manageAccountSetting(Trigger.new,Trigger.oldMap); 
        }  
        if(Trigger.isInsert || Trigger.isUpdate){
            Set<Id>setIds = new Set<Id>();
            for(Service_Ticket__c sTicket : Trigger.new){
                setIds.add(sTicket.Id);    
            }
            if(!ServiceTicketTriggerHandler.feesCalulated)
        		ServiceTicketTriggerHandler.updateFees(setIds);    
        }
    }
}