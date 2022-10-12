/**
* Copyright (c) 2021 Filigreen Distro
* All rights reserved.
* MetrcAlertEmailManager
*/
public class MetrcAlertEmailManager {
    public Static String UID_MAIL_DISPLAYNAME{
        get{
            return String.isNotBlank(UID_MAIL_DISPLAYNAME) ? UID_MAIL_DISPLAYNAME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','UID_Mail_DisplayName');
        }set;
    }
    public Static String UID_EMAIL_TEMPLATE_DESCRIPTION{
        get{
            return String.isNotBlank(UID_EMAIL_TEMPLATE_DESCRIPTION) ? UID_EMAIL_TEMPLATE_DESCRIPTION : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','UID_Email_Template_Description');
        }set;
    }
    public Static String UID_EMAIL_TEMPLATE_SUBJECT{
        get{
            return String.isNotBlank(UID_EMAIL_TEMPLATE_SUBJECT) ? UID_EMAIL_TEMPLATE_SUBJECT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','UID_Email_Template_Subject');
        }set;
    }
    public Static String ERR_MSG_METRC_FINISHED_YES{
        get{
            return String.isNotBlank(ERR_MSG_METRC_FINISHED_YES) ? ERR_MSG_METRC_FINISHED_YES : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','Err_Msg_Metrc_Finished_Yes');
        }set;
    }
    public Static String ERR_MSG_METRC_FINISHED_NO{
        get{
            return String.isNotBlank(ERR_MSG_METRC_FINISHED_NO) ? ERR_MSG_METRC_FINISHED_NO : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','Err_Msg_Metrc_Finished_No');
        }set;
    }
    public Static String ERR_MSG_METRC_ALERT_CASE_CHECK{
        get{
            return String.isNotBlank(ERR_MSG_METRC_ALERT_CASE_CHECK) ? ERR_MSG_METRC_ALERT_CASE_CHECK : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','Err_Msg_Metrc_Alert_Case_Check');
        }set;
    }
    public static void MetricAlertSuccess(String toAddress, list<string> metrc_PackageList, list<string> metrc_UIDList, list<Integer> metrc_QuantityList, list<UID__c> objectList, list<UID__c> actual_FilterList, String caseCheck){
        OrgWideEmailAddress orgEmailID = [SELECT DisplayName,Id FROM OrgWideEmailAddress WHERE DisplayName =: UID_MAIL_DISPLAYNAME];
        EmailTemplate emtmp = [SELECT Body, Description, HtmlValue, Id, Name, Subject,TemplateType FROM EmailTemplate WHERE Description =:UID_EMAIL_TEMPLATE_DESCRIPTION];
        List <String> sendTo = toAddress.split(',');
        DateTime actualDate = Datetime.now();
        String htmlStyle = '';
        String dateOutput = actualDate.format('MM-dd-yyyy');
        Integer metrcQuantity = 0;
        Decimal sfQuantity = 0.00;
        htmlStyle ='<br/><br/>';
        htmlStyle += '<table border="1" style="border-collapse: collapse"><tr><th style="padding:6px">ACTIVE Packages in METRC</th><th style="padding:6px">Available Quantity in METRC</th><th style="padding:6px">Available Quantity in Salesforce</th><th style="padding:6px">Finished in METRC</th><th style="padding:6px">Finished in Salesforce</th></tr>';
        if(caseCheck == ERR_MSG_METRC_ALERT_CASE_CHECK){
            for(integer i = 0;  i<metrc_PackageList.size(); i++){
                String metrcFinish = ERR_MSG_METRC_FINISHED_NO;
                Boolean sfAvailablity = false;
                metrcQuantity = metrc_QuantityList[i];
                for(integer j = 0;  j<actual_FilterList.size(); j++){
                    for(integer k = 0;  k<objectList.size(); k++){
                        if(metrc_PackageList[i] == objectList[k].Name){
                            metrcFinish = ERR_MSG_METRC_FINISHED_YES;
                        }
                    }
                    if(metrc_PackageList[i] == actual_FilterList[j].Name) {
                        if(actual_FilterList[j].Available_Qty__c!=null){
                            sfQuantity = actual_FilterList[j].Available_Qty__c; 
                        }else{
                            sfQuantity = 0.00;
                        }
                        sfAvailablity = true;
                        htmlStyle += '<tr><td style="padding:6px">' + metrc_PackageList[i] + '</td><td style="padding:6px">' + metrcQuantity+'.00' + '</td><td style="padding:6px">' + sfQuantity + '</td><td style="padding:6px">' + metrcFinish + '</td><td style="padding:6px">' + metrcFinish + '</td></tr>';  
                    }   
                }
                if(!sfAvailablity){
                    htmlStyle += '<tr><td style="padding:6px">' + metrc_PackageList[i] + '</td><td style="padding:6px">' + metrcQuantity+'.00' + '</td><td style="padding:6px">' + 'Record not found' + '</td><td style="padding:6px">' + metrcFinish + '</td><td style="padding:6px">' + metrcFinish + '</td></tr>';    
                }
            } 
        }
        else{
            for(integer i = 0;  i<metrc_PackageList.size(); i++){
                String metrcFinish = ERR_MSG_METRC_FINISHED_NO;
                Boolean sfAvailablity = false;
                metrcQuantity = metrc_QuantityList[i];
                for(integer j = 0;  j<actual_FilterList.size(); j++){
                       metrcFinish = ERR_MSG_METRC_FINISHED_NO;
                    if(metrc_PackageList[i] == actual_FilterList[j].Name) {
                        if(actual_FilterList[j].Available_Qty__c!=null){
                            sfQuantity = actual_FilterList[j].Available_Qty__c; 
                        }else{
                            sfQuantity = 0.00;
                        }
                        sfAvailablity = true;
                        htmlStyle += '<tr><td style="padding:6px">' + metrc_PackageList[i] + '</td><td style="padding:6px">' + metrcQuantity+'.00' + '</td><td style="padding:6px">' + sfQuantity + '</td><td style="padding:6px">' + metrcFinish + '</td><td style="padding:6px">' + metrcFinish + '</td></tr>';  
                    }   
                }
                if(!sfAvailablity){
                    htmlStyle += '<tr><td style="padding:6px">' + metrc_PackageList[i] + '</td><td style="padding:6px">' + metrcQuantity+'.00' + '</td><td style="padding:6px">' + 'Record not found' + '</td><td style="padding:6px">' + metrcFinish + '</td><td style="padding:6px">' + metrcFinish + '</td></tr>';    
                }
            } 
        }        
        htmlStyle += '</table>';
        String htmlBody = emtmp.HtmlValue ;
        String subject = UID_EMAIL_TEMPLATE_SUBJECT + dateOutput;
        htmlBody = htmlBody + htmlStyle;
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setSubject(subject);
        email.setToAddresses(sendTo); 
        email.setTemplateId(emtmp.Id);
        email.setTargetObjectId(UserInfo.getUserId());
        email.setSaveAsActivity(false);
        email.setOrgWideEmailAddressId(orgEmailID.Id);
        email.setHtmlBody(htmlBody);
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {email};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
    }
}