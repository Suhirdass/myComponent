trigger EventTrigger on Event (after insert,after update) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
        	EventTriggerHandler.afterInsert(Trigger.new);	    	
        } else if(Trigger.isUpdate){
            EventTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }    
    }
}