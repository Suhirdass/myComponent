public class PublishServicesTicketToSlack{
    public Static String CRM_Redirect_URL{
        get{
            return String.isNotBlank(CRM_Redirect_URL) ? CRM_Redirect_URL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','CRM_Redirect_URL');
        }set;
    }       
    
    @InvocableMethod 
    public static void publishToSlack(List<Id> stIds) {
        system.debug('stIds' + stIds);
        String ServiceTicketslackMsg = '';
        String inboundTransferslackMsg = '';
        for(Service_Ticket__c ST : [select Id, Brand_Contact__r.Name, Total_Service_Lines__c,Destination_Site__r.Warehouse_Name__c, Transfer_Method__c, 
                                    Licensed_Premise__r.Default_Warehouse__r.Warehouse_Name__c, Name, Status__c, 
                                    Brand_Name__r.DBA__c from Service_Ticket__c  where id IN: stIds]){        
			if(ST.Transfer_Method__c == 'Product Conversions'){
            	ServiceTicketslackMsg += 'Service Ticket Number : <' + CRM_Redirect_URL + '/lightning/r/Service_Ticket__c/' + ST.Id + '/view|' + ST.Name  + '> \n' ;
                ServiceTicketslackMsg += 'Transfer Method : ' + ST.Transfer_Method__c + '\n';
                ServiceTicketslackMsg += 'Status : ' + ST.Status__c  + ' \n';
                ServiceTicketslackMsg += 'Brand DBA : ' + ST.Brand_Name__r.DBA__c  + ' \n';
                ServiceTicketslackMsg += 'Brand Contact : ' + ST.Brand_Contact__r.Name   + ' \n';
                ServiceTicketslackMsg += 'Total Service Lines : ' + ST.Total_Service_Lines__c + '\n';   
            }
			if(ST.Transfer_Method__c != 'Product Conversions'){
            	inboundTransferslackMsg += 'Service Ticket Number : <' + CRM_Redirect_URL + '/lightning/r/Service_Ticket__c/' + ST.Id + '/view|' + ST.Name  + '> \n' ;
                inboundTransferslackMsg += 'Transfer Method : ' + ST.Transfer_Method__c + '\n';
            // inboundTransferslackMsg += 'Receiving Location : ' + ST.Destination_Site__r.Warehouse_Name__c + '\n';
              //  inboundTransferslackMsg += 'Receiving Location : ' + ST.Licensed_Premise__r.Default_Warehouse__r.Warehouse_Name__c + '\n';

                inboundTransferslackMsg += 'Receiving Location : ' +ST.Destination_Site__r.Warehouse_Name__c + '\n';
                inboundTransferslackMsg += 'Status : ' + ST.Status__c  + ' \n';
                inboundTransferslackMsg += 'Brand DBA : ' + ST.Brand_Name__r.DBA__c  + ' \n';
                inboundTransferslackMsg += 'Brand Contact : ' + ST.Brand_Contact__r.Name   + ' \n';
                inboundTransferslackMsg += 'Total Service Lines : ' + ST.Total_Service_Lines__c + '\n';   
            }
        }  
        if(ServiceTicketslackMsg != ''){
            ServiceTicketslackMsg = ServiceTicketslackMsg.removeEnd('\n');
            SlackIntegrationController.postMessage('Service Ticket', ServiceTicketslackMsg);
        }
        if(inboundTransferslackMsg != ''){
            inboundTransferslackMsg = inboundTransferslackMsg.removeEnd('\n');
            SlackIntegrationController.postMessage('Inbound Transfer', inboundTransferslackMsg);
        }
    }
}