public without sharing class NewContactController {
    @AuraEnabled
    public static AuraResponse initNewContact(String accountId,String recordTypeId){
    	AuraResponse r = new AuraResponse('NewContactController.initNewContact()'); 
        if(accountId != null && accountId != ''){	
            Account acc  = [select id,Name,OwnerId from Account where id=: accountId];
            Contact con = new Contact();
            con.Active__c = true;
            con.MailingCountry = 'USA';
            con.LeadSource = 'Marketplace';
            con.RecordTypeId = recordTypeId;
            con.AccountId = accountId;
            con.OwnerId = acc.OwnerId;
            r.data.put('newContact',con);
            r.data.put('accountName',acc.Name);
        }
        return r;
    }
    @AuraEnabled
    public static AuraResponse saveContact(String recordStr){//String linecard,
    	AuraResponse r = new AuraResponse('NewContactController.saveContact()');
        if(recordStr != null && recordStr != ''){	
        	Contact con = (Contact)JSON.deserialize(recordStr, Contact.Class);
            Contact[] existingContactList = [SELECT Id,Name,AccountId,Account.Name,Email FROM Contact WHERE AccountId = :con.AccountId AND Email =: con.Email];
            if(existingContactList.size() > 0){
                r.data.put('contact',existingContactList[0]);
                r.data.put('alreadyExists',true);
            }else{
                insert con;
                r.data.put('alreadyExists',false);
            }
        }
        return r;
    }    
    @AuraEnabled
    public static AuraResponse getInsightTypes(String retailerId,String linecard){
        AuraResponse r = new AuraResponse('NewContactController.getInsightTypes()');
        List<Contact> lstContact = [select id,Name from Contact where AccountId =: retailerId];
        r.data.put('insightTypes', Utility.getPicklistItems('Customer_Insights__c', 'Insight_Type__c'));
        r.data.put('contacts', lstContact);
        
        Customer_Insights__c insight = new Customer_Insights__c();
        insight.Line_Card__c = linecard;   
        r.data.put('insight', insight);
        return r;
    }    
    @AuraEnabled
    public static AuraResponse saveInsight(String linecard, String recordStr){
        AuraResponse r = new AuraResponse('NewContactController.saveInsight()');
        if(recordStr != null && recordStr != ''){
            
        	Customer_Insights__c insight = (Customer_Insights__c)JSON.deserialize(recordStr, Customer_Insights__c.Class);
            /*if(insight.Line_Card__c == null){
            	insight.Line_Card__c = linecard;    
            }*/
            upsert insight;
            System.debug('Line Card = '+insight);
        }
        return r;
    }
    
    /*
    @AuraEnabled
    public static AuraResponse sendNotifitions(String contactId){
        AuraResponse r = new AuraResponse('NewContactController.sendNotifitions()');
        Group gp = [SELECT Id, Name, DeveloperName FROM Group WHERE DeveloperName = 'New_Retailer_Contact_from_MP'];
        Group g = [SELECT (select userOrGroupId from groupMembers) FROM group WHERE developername = 'New_Retailer_Contact_from_MP'];
        Set<Id> userIds = new Set<Id>(); 
        for (GroupMember gm : g.groupMembers) {
            userIds.add(gm.userOrGroupId);
        }
        EmailTemplate et = [Select id, Subject, Body from EmailTemplate where DeveloperName = 'Notify_On_Retailer_Contact_request' limit 1];
        Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[] {};
        for(Id userId: userIds){
            Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
            msg.setTemplateId(et.Id);
            msg.setTargetObjectId(userId);
            msg.setSaveAsActivity(false);
            emails.add(msg);
        }
        if(!emails.isEmpty()){
            Messaging.sendEmail(emails);
        }
        
        return r;
    }*/
}