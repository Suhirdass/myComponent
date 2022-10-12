public class ServiceTicketLineTriggerHelper {
    
    private Static String ST_Transfer_Method_Drop_Off{
        get{
            return String.isNotBlank(ST_Transfer_Method_Drop_Off) ? ST_Transfer_Method_Drop_Off: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Transfer_Method_Drop_Off');
        }set;
    }
    private Static String ST_Transfer_Method_Pick_up{
        get{
            return String.isNotBlank(ST_Transfer_Method_Pick_up) ? ST_Transfer_Method_Pick_up: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Transfer_Method_Pick_Up');
        }set;
    }
    private Static String ST_Status_Completed{
        get{
            return String.isNotBlank(ST_Status_Completed) ? ST_Status_Completed : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Status_Completed');
        }set;
    }
    private Static String ST_Status_Cancelled {
        get{
            return String.isNotBlank(ST_Status_Cancelled ) ? ST_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Status_Cancelled');
        }set;
    }
    private Static String ST_Status_Draft {
        get{
            return String.isNotBlank(ST_Status_Draft ) ? ST_Status_Draft : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Status_Draft');
        }set;
    }
    
    public static void onAfterInsertUpdate(List<Service_Ticket_Line__c> newList){
        Set<Id> serviceTicketIds = new Set<Id>();
        for(Service_Ticket_Line__c stl: newList){
            serviceTicketIds.add(stl.Service_Ticket__c);
        }
        if(serviceTicketIds.size() > 0){
            List<Service_Ticket__c> serviceTickets = [SELECT Id, Status__c,(SELECT Status__c FROM Service_Ticket_Lines__r WHERE Status__c NOT IN(:ST_Status_Completed,:ST_Status_Cancelled)) FROM Service_Ticket__c WHERE Status__c NOT IN (:ST_Status_Completed,:ST_Status_Cancelled) AND Id IN :serviceTicketIds];
            List<Service_Ticket__c> updateserviceTickets = new List<Service_Ticket__c>();
            if(serviceTickets.size() > 0){
                for(Service_Ticket__c ST: serviceTickets){
                    if(ST.Service_Ticket_Lines__r.size() == 0){
                        ST.Status__c = ST_Status_Completed;
                        updateserviceTickets.add(ST);
                    }
                }
                if(updateserviceTickets.size() > 0)
                	update updateserviceTickets;
            }
        }
    }
    
    
    public static void setInboundQtyOnProduct(List<Service_Ticket_Line__c> newList){
        Set<Id> serviceTicketIds = (new Map<Id,Service_Ticket_Line__c>(newList)).keySet();
        List<Product2> lstProductToUpdate = new List<Product2>();
        
       	Set<Id> productIds = new Set<Id>();
        
        for(Service_Ticket_Line__c stl : newList){
            if(stl.New_Packaged_Product__c != null) productIds.add(stl.New_Packaged_Product__c);
        }
        
        for(Product2 pro : [SELECT Id,Inbound_Qty__c,
                            (SELECT Id,Status__c,Service_Ticket__r.Transfer_Method__c,Total_Units__c  FROM Service_Ticket_Lines1__r 
                             WHERE Status__c NOT IN(:ST_Status_Cancelled,:ST_Status_Completed,:ST_Status_Draft) AND Service_Ticket__r.Transfer_Method__c IN (:ST_Transfer_Method_Drop_Off,:ST_Transfer_Method_Pick_up))
                            FROM Product2 WHERE Id IN : productIds]){
                                system.debug(pro.Service_Ticket_Lines1__r.size());
                                if(pro.Service_Ticket_Lines1__r.size() > 0){
                                    pro.Inbound_Qty__c = 0;
                                    for(Service_Ticket_Line__c stl : pro.Service_Ticket_Lines1__r){
                                    	pro.Inbound_Qty__c = pro.Inbound_Qty__c += stl.Total_Units__c ;
                                    }    
                                } else {
                                	pro.Inbound_Qty__c = 0;    
                                }
                                lstProductToUpdate.add(pro); 
                                
        }
        
        /*for(Service_Ticket_Line__c stl : [SELECT Id,Name,Status__c,Total_Units__c,Service_Ticket__c,Service_Ticket__r.Transfer_Method__c,
                                          New_Packaged_Product__c,New_Packaged_Product__r.Inbound_Qty__c
                                          FROM Service_Ticket_Line__c WHERE Id IN: serviceTicketIds AND Status__c != 'Completed' AND 
                                          Service_Ticket__r.Transfer_Method__c IN ('Drop-off','Pick-up')]){
                                              if(stl.New_Packaged_Product__c != null){
                                              	Product2 prod = new Product2();
                                                prod.Id = stl.New_Packaged_Product__c;
                                                prod.Inbound_Qty__c = stl.New_Packaged_Product__r.Inbound_Qty__c != null ? stl.New_Packaged_Product__r.Inbound_Qty__c += stl.Total_Units__c : stl.Total_Units__c;
                                                lstProductToUpdate.add(prod);  
                                              }						                                      
        }*/
        if(lstProductToUpdate.size() > 0){
            update lstProductToUpdate;
        }
    }
}