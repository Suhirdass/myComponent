@isTest
public class MetrcTagUploadCtlrTest {
private static testmethod void runTest(){
    
    UID__c uid = new UID__c(); 
    uid.Active__c=true;
    uid.Name='1A4060300005F51000018211';
    uid.IRR_UID__c=true;
    insert uid;
    UID__c uid2 = new UID__c(); 
    uid2.Active__c=true;
    uid2.Name='1A4060300005F51000019963';
    uid2.IRR_UID__c=true;
    insert uid2;
     site__c siteId = new site__c();
        siteId.Name = '2089-3';
        siteId.Warehouse_Name__c = 'San Francisco, CA';
        insert siteId;
       MetrcTagUploadCtlr.getActiveSite('2089');
    String paymentsData = '[{"Tag":"'+uid.Name+'","Active":"'+uid.Active__c+'","IRR UID":"'+uid.IRR_UID__c+'"}]';
    MetrcTagUploadCtlr.gettags(paymentsData); 
    MetrcTagUploadCtlr.Savetags(paymentsData,'2089');
    String paymentsData2 = '[{"Tag":"'+uid2.Name+'","Active":"'+uid2.Active__c+'","IRR UID":"'+uid2.IRR_UID__c+'"}]';
    MetrcTagUploadCtlr.gettags(paymentsData2);
    MetrcTagUploadCtlr.Savetags(paymentsData2,'NHWCA');
 
    string message=MetrcTagUploadCtlr.ERR_MSG_UID_CHARCTER;
}
}