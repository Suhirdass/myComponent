public class PublishShippingManifestToSlack {
    
    public Static String CRM_Redirect_URL{
        get{
            return String.isNotBlank(CRM_Redirect_URL) ? CRM_Redirect_URL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','CRM_Redirect_URL');
        }set;
    }       
    public Static String Shipping_Manifest_LineStatus_Rejected{
        get{
            return String.isNotBlank(Shipping_Manifest_LineStatus_Rejected) ? Shipping_Manifest_LineStatus_Rejected: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Rejected');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_LINE_RECORDTYPE_PRODUCT_TSM_LINE {
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_RECORDTYPE_PRODUCT_TSM_LINE) ? SHIPPING_MANIFEST_LINE_RECORDTYPE_PRODUCT_TSM_LINE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SM_Line_RecordType_Product_TSM_Line');
        }set;
    } 
    // sending slack message After ShipmentComplete or Reject 

    @InvocableMethod 
    public static void publishToSlack(List<Id> smIds) {
        system.debug('smIds >>>>' + smIds);
        String ShipManifestlackMsg = '';
        String SMLstatus = 'No';
        for(Shipping_Manifest__c SM : [select Id, Name, Status__c,Slack_Notes__c, Receiver_Contact__r.Name, Receiver_DBA__c, Delivery_City__c,Supplier_DBA__c, 
                                       Order_Number__r.Account_DBA__c,RecordType.Name, Total_Line_Items__c,Ownership__c,Ownership__r.Name,Ownership__r.DBA__c, 
                                       Total_Price__c, Order_Number__r.Total__c,  Metrc_Manifest__c, Payment_Terms__c, Actual_Receiver_Name__c, Driver__r.Name,
									   (select id, name, SMLine_Status__c, Shipment_Qty__c, Qty_Received__c,RecordType.Name from Shipping_Manifest_Lines__r) from Shipping_Manifest__c  where id IN: smIds]){
                                           
        	for(Shipping_Manifest_Line__c sml: SM.Shipping_Manifest_Lines__r){
            	If(sml.SMLine_Status__c == Shipping_Manifest_LineStatus_Rejected || sml.Shipment_Qty__c != sml.Qty_Received__c){ 
                    SMLstatus = 'Yes';
             		}
           	 }
                                           
			if(SM.Id != null){
                If(SM.Ownership__r.Name != null)ShipManifestlackMsg += 'Ownership DBA : ' + SM.Ownership__r.DBA__c + '\n';
                else ShipManifestlackMsg += 'Ownership DBA  : ' + '\n';
                If(SM.Driver__r.Name != null)ShipManifestlackMsg += 'Driver : ' + SM.Driver__r.Name+ '\n';
                else ShipManifestlackMsg += '\n';
                If(SM.Receiver_DBA__c != null)ShipManifestlackMsg += 'Receiver DBA : ' + SM.Receiver_DBA__c + '\n';
                else ShipManifestlackMsg += 'Receiver DBA : ' + '\n';
                ShipManifestlackMsg += 'Delivery City : ' + SM.Delivery_City__c + '\n';
                ShipManifestlackMsg += 'Payment Terms : ' + SM.Payment_Terms__c + '\n';
                If(SM.Total_Line_Items__c != null)ShipManifestlackMsg += 'Total Lines : ' + SM.Total_Line_Items__c + '\n';
                else ShipManifestlackMsg += 'Total Lines : ' + '\n';
                If(SM.Status__c != null) ShipManifestlackMsg += 'Status : ' + SM.Status__c + '\n';
                else ShipManifestlackMsg += 'Status : ' + '\n';
                ShipManifestlackMsg += 'Partial Rejection : ' + SMLstatus + '\n';
                If(SM.Metrc_Manifest__c != null) ShipManifestlackMsg += 'Metrc Manifest : ' + SM.Metrc_Manifest__c + '\n';
                else ShipManifestlackMsg += 'Metrc Manifest : ' + '\n';
                ShipManifestlackMsg += 'Shipping Manifest : <' + CRM_Redirect_URL + '/lightning/r/Shipping_Manifest__c/' + SM.Id + '/view|' + SM.Name  + '>';
                ShipManifestlackMsg += ' - ' + SM.RecordType.Name + '\n';
                If(SM.Slack_Notes__c != null) ShipManifestlackMsg += 'Slack Notes : ' + SM.Slack_Notes__c  + ' \n';
                else ShipManifestlackMsg += 'Slack Notes : ' + '\n';
            }
        }  
        if(ShipManifestlackMsg != ''){
            	ShipManifestlackMsg = ShipManifestlackMsg.removeEnd('\n');
            	SlackIntegrationController.postMessage('Shipping Manifest', ShipManifestlackMsg);
        }
    }

}