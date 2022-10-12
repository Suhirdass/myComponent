public class SlackIntegrationController {
    @future(callout=true)
    public static void postMessage(String objectName, String msg){
        String slackMsg = '{"text":"';
        slackMsg += msg;
        slackMsg += '"}';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(getWebHookURL(objectName));
        req.setMethod('POST');
        req.setBody(slackMsg);
        Http http = new Http();
        if(!test.isRunningTest())
        	HttpResponse res = http.send(req);
    }
    public static String getWebHookURL(String objectName){
    	List<Slack_Config__mdt> slackConfigList = [SELECT Id, Object_Name__c, Slack_Web_Hook_URL__c
                                                   FROM Slack_Config__mdt WHERE  Object_Name__c =: objectName]; 
        if(slackConfigList.size() > 0)
            return slackConfigList[0].Slack_Web_Hook_URL__c;
        else
            return '';
    }
}