public class PublishOrderRevisonsToSlack{
    public Static String CRM_Redirect_URL{
        get{
            return String.isNotBlank(CRM_Redirect_URL) ? CRM_Redirect_URL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','CRM_Redirect_URL');
        }set;
    }   
    @InvocableMethod 
    public static void publishToSlack(List<Id> OrderRevisionId) {
        system.debug('OrderRevisionId'+OrderRevisionId);
        Set<id>smids = new set<id>();
        for(Order_Revision__c OrdRevR : [select Id,Order__r.name,Shipping_Manifest__r.Ownership__r.DBA__c,Shipping_Manifest__r.Receiver_City_State_Zip__c,
                                         Name,Order__c,Shipping_Manifest__r.Ownership__r.Name,Shipping_Manifest__r.Receiver_DBA__c,Shipping_Manifest__c,Notes__c,
                                         Shipping_Manifest__r.Ownership__c,Shipping_Manifest__r.Name,Shipping_Manifest__r.Actual_Departure_Date_Time__c,
                                         Shipping_Manifest__r.Actual_Arrival_Date_Time__c,	Reason_code__c	from Order_Revision__c where id IN: OrderRevisionId]){
                                             smids.add(OrdRevR.Shipping_Manifest__c);      
                                             
                                         }
        string depart; 
        List<Shipping_Manifest__History> SHM = [SELECT ParentId, OldValue, NewValue FROM Shipping_Manifest__History  where parentId =:smids AND Field = 'Actual_Departure_Date_Time__c'  ORDER BY CreatedDate DESC  Limit 1];
        
            
        
        for(Shipping_Manifest__History ss :SHM){
            if(ss.NewValue != null){
             datetime dt = datetime.valueOf(ss.NewValue);
            depart =dt.format('MM/dd/yyyy HH:mm a', 'PST');
            }
           
        }
        
        string OrderRevisionSlackMsg = '';
        for(Order_Revision__c ord : [select Id,Order__r.name,Shipping_Manifest__r.Ownership__r.DBA__c,Shipping_Manifest__r.Receiver_City_State_Zip__c, Name,Order__c,Shipping_Manifest__r.Ownership__r.Name,Shipping_Manifest__r.Receiver_DBA__c,Shipping_Manifest__c,Notes__c,Shipping_Manifest__r.Ownership__c,Shipping_Manifest__r.Name,Shipping_Manifest__r.Actual_Departure_Date_Time__c,Shipping_Manifest__r.Actual_Arrival_Date_Time__c,	Reason_code__c	from Order_Revision__c where id IN: OrderRevisionId]){
           
            OrderRevisionSlackMsg += 'Order Revision: <' + CRM_Redirect_URL + '/lightning/r/Order_Revision__c/' + ord.Id + '/view|' + ord.Name  + '>' + '\n';
            OrderRevisionSlackMsg += 'Order Number: <' + CRM_Redirect_URL + '/lightning/r/Order__c/' + ord.Order__r.Id + '/view|' + ord.Order__r.name  + '>' + '\n';
            OrderRevisionSlackMsg += 'Receiver DBA: ' +  ord.Shipping_Manifest__r.Receiver_DBA__c+ '\n';
            OrderRevisionSlackMsg += 'City: ' +  ord.Shipping_Manifest__r.Receiver_City_State_Zip__c+ '\n';
            OrderRevisionSlackMsg += 'Brand DBA: ' +ord.Shipping_Manifest__r.Ownership__r.DBA__c + '\n';
            if(depart !=null ){
                OrderRevisionSlackMsg += 'Last Depart Confirm: ' + depart + '\n';
            }  else{
                OrderRevisionSlackMsg += 'Last Depart Confirm: ' +  + '\n';
                
            }
            if(ord.Shipping_Manifest__r.Id  != null){
                OrderRevisionSlackMsg += 'Shipping Manifest: <' + CRM_Redirect_URL + '/lightning/r/Shipping_Manifest__c/' + ord.Shipping_Manifest__r.Id + '/view|' + ord.Shipping_Manifest__r.Name  + '>' + '\n';
                
            }else{
                OrderRevisionSlackMsg += 'Shipping Manifest: '+ + '\n';
                
            }if( ord.Reason_code__c !=null){
                OrderRevisionSlackMsg += 'Reason Code: ' + ord.Reason_code__c+ '\n';
                
            }else{
                OrderRevisionSlackMsg += 'Reason Code: ' + + '\n';
                
            }
            if( ord.Notes__c !=null){
                OrderRevisionSlackMsg += 'Notes: ' + ord.Notes__c+ '\n';
                
            }else{
                OrderRevisionSlackMsg += 'Notes: ' + + '\n';
                
            }
            
        }
        if(OrderRevisionSlackMsg != ''){
            OrderRevisionSlackMsg = OrderRevisionSlackMsg.removeEnd('\n');
            SlackIntegrationController.postMessage('Order Revision', OrderRevisionSlackMsg);
        }
      
   
}
}