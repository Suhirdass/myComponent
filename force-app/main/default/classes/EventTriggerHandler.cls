public class EventTriggerHandler {
    
    public static void afterInsert(List<Event> lstEvent){
        String tempPrefix = Schema.getGlobalDescribe().get('Service_Ticket__c').getDescribe().getKeyPrefix();
        Map<Id,DateTime> mapReqDate = new Map<Id,DateTime>();
        for(Event eve : lstEvent){
            if(eve.whatId != null){
            	String recId = eve.whatId+'';
                if(eve.StartDateTime != null && recId.startsWith(tempPrefix)){  
                	mapReqDate.put(eve.whatId,eve.StartDateTime);    
                }    
            }
        }
        if(mapReqDate.size() > 0){
        	EventTriggerHandler.updateServiceTicket(mapReqDate);	
        }
    }
    
    public static void afterUpdate(List<Event> lstEvent,Map<Id,Event> oldMap){
    	String tempPrefix = Schema.getGlobalDescribe().get('Service_Ticket__c').getDescribe().getKeyPrefix();
        Map<Id,DateTime> mapReqDate = new Map<Id,DateTime>();
        for(Event eve : lstEvent){
            if(eve.whatId != null){
                String recId = eve.whatId+'';
                Event oldEvent = oldMap.get(eve.Id);
                if(eve.StartDateTime != null && oldEvent.StartDateTime != eve.StartDateTime && recId.startsWith(tempPrefix)){  
                    mapReqDate.put(eve.whatId,eve.StartDateTime);    
                }    
            }
        }
        if(mapReqDate.size() > 0){
        	EventTriggerHandler.updateServiceTicket(mapReqDate);	
        }
    }
    
    public static void updateServiceTicket(Map<Id,DateTime> mapReqDate){
        List<Service_Ticket__c> lstService = [select Id,Request_Date_Time__c from Service_Ticket__c where Id In : mapReqDate.keySet()];
        if(lstService.size() > 0){
            for(Service_Ticket__c ser : lstService){
                ser.Request_Date_Time__c = mapReqDate.get(ser.Id);	    
            }
            update lstService;  
        }
    }
}