@isTest(SeeAllData=false)
public class MetrcAlertEmailManagerTest {
    
    static testMethod void MetricAlertTest(){
        OrgWideEmailAddress orgEmailID = [SELECT DisplayName,Id FROM OrgWideEmailAddress where DisplayName='Filigreen IT Support'];
        EmailTemplate emtmp = [SELECT Body,Description,HtmlValue,Id,Name,Subject,TemplateType FROM EmailTemplate where Description ='Metrc Alert'];
        Test.startTest();
        List<string> address = new String[] { 'test@trumatics.com'};
        List<UID__c> uidlist = [select id, name from UID__c];
        List<UID__c> actualfilterList = [select id, name,Available_Qty__c from UID__c];
        List<String> metrc_PackageList = new List<String>{'1A4FF030000025B000009419','1A4FF030000025B000009333'};
        List<String> metrc_UIDList = new List<String> {'1A4FF030000025B000009419'};
        List<Integer> metrc_QunatityList = new List<Integer>{10,0};
        String ERR_MSG_METRC_FINISHED_YES = MetrcAlertEmailManager.ERR_MSG_METRC_FINISHED_YES;
        MetrcAlertEmailManager.MetricAlertSuccess('test@trumatics.com',metrc_PackageList,metrc_UIDList,metrc_QunatityList,uidlist, actualfilterList,'pass');
        MetrcAlertEmailManager.MetricAlertSuccess('test@trumatics.com',metrc_PackageList,metrc_UIDList,metrc_QunatityList,uidlist, actualfilterList,'fail');
        Test.stopTest();
    }
}