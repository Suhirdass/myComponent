public class PublishOrderToSlack{
    public Static String CRM_Redirect_URL{
        get{
            return String.isNotBlank(CRM_Redirect_URL) ? CRM_Redirect_URL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','CRM_Redirect_URL');
        }set;
    }    
    public Static String Order_Record_Type_Name_Brand{
        get{
            return String.isNotBlank(Order_Record_Type_Name_Brand) ? Order_Record_Type_Name_Brand : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_ Brand');
        }set;
    }
	public Static String Order_Record_Type_Name_Retailer{
        get{
            return String.isNotBlank(Order_Record_Type_Name_Retailer) ? Order_Record_Type_Name_Retailer : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_Retailer');
        }set;
    }       
    public Static String Order_Record_Type_Name_Transfer{
        get{
            return String.isNotBlank(Order_Record_Type_Name_Transfer) ? Order_Record_Type_Name_Transfer : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_Transfer');
        }set;
    } 
    public Static String Order_Status_Draft{
        get{
            return String.isNotBlank(Order_Status_Draft) ? Order_Status_Draft : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Draft');
        }set;
    }
    public Static String Adira_Distribution_Inc_Id{
        get{
            return String.isNotBlank(Adira_Distribution_Inc_Id) ? Adira_Distribution_Inc_Id : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Adira_Distribution_Inc_Id');
        }set;
    }
    @InvocableMethod 
    public static void publishToSlack(List<Id> orderIds) {
        String AdiraDistributionSlackMsg = '';
        String brandOrdersSlackMsg = '';
        String retailerOrdersSlackMsg = '';
        String transferOrdersSlackMsg = '';
        for(Order__c ord : [select Id, Name, Retailer_DBA__c,Account_DBA__c, State_License__r.License_City__c, Distribution__c,
                            CreatedBy.FirstName, CreatedBy.LastName, Total__c, Total_Product_Price__c, Total_Excise_Tax_Amount__c, Total_Line_Items__c, RecordType.Name,  
                            Customer__r.Contact.AccountId from order__c where id IN: orderIds ]){
			if(ord.RecordType.Name == Order_Record_Type_Name_Brand){
                if(ord.Customer__r.Contact.AccountId == Adira_Distribution_Inc_Id){
                	AdiraDistributionSlackMsg += 'Order Number : <' + CRM_Redirect_URL + '/lightning/r/Order__c/' + ord.Id + '/view|' + ord.Name  + '> \n' ;
                    AdiraDistributionSlackMsg += 'Receiver DBA : ' + ord.Retailer_DBA__c  + ' \n';
                    AdiraDistributionSlackMsg += 'City : ' + ord.State_License__r.License_City__c + '\n';
                    AdiraDistributionSlackMsg += 'Brand DBA : ' + ord.Account_DBA__c  + ' \n';
                    AdiraDistributionSlackMsg += 'Submitted By : ' + ord.CreatedBy.FirstName + ' ' + ord.CreatedBy.LastName   + ' \n';
                    AdiraDistributionSlackMsg += 'Total Product price : $' + ord.Total_Product_Price__c+ ' \n';
                    AdiraDistributionSlackMsg += 'Total Excise Tax Amount : $' + ord.Total_Excise_Tax_Amount__c  + ' \n';
                    AdiraDistributionSlackMsg += 'Total Lines : ' + ord.Total_Line_Items__c + '\n';
                     AdiraDistributionSlackMsg += 'Distribution : ' + ord.Distribution__c +'%'+ '\n'; 
                }else{
                    brandOrdersSlackMsg += 'Order Number : <' + CRM_Redirect_URL + '/lightning/r/Order__c/' + ord.Id + '/view|' + ord.Name  + '> \n' ;
                    brandOrdersSlackMsg += 'Receiver DBA : ' + ord.Retailer_DBA__c  + ' \n';
                    brandOrdersSlackMsg += 'City : ' + ord.State_License__r.License_City__c + '\n';
                    brandOrdersSlackMsg += 'Brand DBA : ' + ord.Account_DBA__c  + ' \n';
                    brandOrdersSlackMsg += 'Submitted By : ' + ord.CreatedBy.FirstName + ' ' + ord.CreatedBy.LastName   + ' \n';
                    brandOrdersSlackMsg += 'Total Product price : $' + ord.Total_Product_Price__c +'\n';
                    brandOrdersSlackMsg += 'Total Excise Tax Amount : $' + ord.Total_Excise_Tax_Amount__c + ' \n';
                    brandOrdersSlackMsg += 'Total Lines : ' + ord.Total_Line_Items__c + '\n'; 
                    brandOrdersSlackMsg += 'Distribution : ' + ord.Distribution__c  +'%'+ '\n'; 
                }
            }
        	if(ord.RecordType.Name == Order_Record_Type_Name_Retailer){
            	retailerOrdersSlackMsg += 'Order Number : <' + CRM_Redirect_URL + '/lightning/r/Order__c/' + ord.Id + '/view|' + ord.Name  + '> \n' ;
                retailerOrdersSlackMsg += 'Receiver DBA : ' + ord.Retailer_DBA__c  + ' \n';
                retailerOrdersSlackMsg += 'City : ' + ord.State_License__r.License_City__c + '\n';
                retailerOrdersSlackMsg += 'Submitted By : ' + ord.CreatedBy.FirstName + ' ' + ord.CreatedBy.LastName   + ' \n';
                retailerOrdersSlackMsg += 'Total Product price : $' + ord.Total_Product_Price__c + ' \n';
                retailerOrdersSlackMsg += 'Total Excise Tax Amount : $' + ord.Total_Excise_Tax_Amount__c + ' \n';
                retailerOrdersSlackMsg += 'Total Lines : ' + ord.Total_Line_Items__c + '\n';     
               retailerOrdersSlackMsg += 'Distribution : ' + ord.Distribution__c  +'%'+ '\n'; 
            }
			if(ord.RecordType.Name == Order_Record_Type_Name_Transfer){
            	transferOrdersSlackMsg += 'Order Number : <' + CRM_Redirect_URL + '/lightning/r/Order__c/' + ord.Id + '/view|' + ord.Name  + '> \n' ;
                transferOrdersSlackMsg += 'Receiver DBA : ' + ord.Retailer_DBA__c  + ' \n';
                transferOrdersSlackMsg += 'City : ' + ord.State_License__r.License_City__c + '\n';
                transferOrdersSlackMsg += 'Brand DBA : ' + ord.Account_DBA__c  + ' \n';
                transferOrdersSlackMsg += 'Submitted By : ' + ord.CreatedBy.FirstName + ' ' + ord.CreatedBy.LastName   + ' \n';
                transferOrdersSlackMsg += 'Total Product price : $' + ord.Total_Product_Price__c+ ' \n';
                transferOrdersSlackMsg += 'Total Excise Tax Amount : $' + ord.Total_Excise_Tax_Amount__c + ' \n';
                transferOrdersSlackMsg += 'Total Lines : ' + ord.Total_Line_Items__c + '\n';     
                transferOrdersSlackMsg += 'Distribution : ' + ord.Distribution__c  +'%'+ '\n'; 
            }
        }  
        if(AdiraDistributionSlackMsg != ''){
            AdiraDistributionSlackMsg = AdiraDistributionSlackMsg.removeEnd('\n');
            SlackIntegrationController.postMessage('Adira Distribution Orders', AdiraDistributionSlackMsg);
        }
        if(brandOrdersSlackMsg != ''){
            brandOrdersSlackMsg = brandOrdersSlackMsg.removeEnd('\n');
            SlackIntegrationController.postMessage(Order_Record_Type_Name_Brand, brandOrdersSlackMsg);
        }
        if(retailerOrdersSlackMsg != ''){
            retailerOrdersSlackMsg = retailerOrdersSlackMsg.removeEnd('\n');
            SlackIntegrationController.postMessage(Order_Record_Type_Name_Retailer, retailerOrdersSlackMsg);
        }
        if(transferOrdersSlackMsg != ''){
            transferOrdersSlackMsg = transferOrdersSlackMsg.removeEnd('\n');
            SlackIntegrationController.postMessage(Order_Record_Type_Name_Transfer, transferOrdersSlackMsg);
        }
    }
}