public without sharing class  ApproveSelfRegisterUser {
    
    @AuraEnabled
    public static User_Self_Registration__c getInit(String recordId) {
        return [SELECT Id,License_Type__c, Account__c, Account__r.Name,Status__c FROM User_Self_Registration__c WHERE Id= :recordId LIMIT 1];
    }
    @AuraEnabled
    public static String approveUser(String recordId,String profileName, String accountId){
        Savepoint sp = Database.setSavepoint();
        try{
            
            System.debug('recordId::'+recordId+',String::'+profileName+' String ::'+accountId);
            String profileId = [SELECT Id, Name FROM Profile WHERE Name = :profileName LIMIT 1].Id;
            User_Self_Registration__c  userDetails = [SELECT Id, First_Name__c, Last_Name__c, Company_Name_DBA__c, Title__c,
                                                      Email__c, Phone_Number__c, State_License_Number__c, Response_Email__c
                                                      FROM User_Self_Registration__c WHERE Id = :recordId];
            //Profile customerCommunityDocUnity = [SELECT id FROM Profile WHERE name =: Label.Community_Profile];
            String userEmail = userDetails.Email__c;
            for (User u : [SELECT Id FROM User WHERE Username = :userEmail LIMIT 1]){
                return 'Email already exists.';
            }
            
            String companyName = userDetails.Company_Name_DBA__c;
            if(String.isBlank( accountId)){
                Account acc = new Account(Name = companyName);
                insert acc;
                accountId = acc.Id;
            }
            
            Contact newContact = new Contact();
            newContact.FirstName = userDetails.First_Name__c;
            newContact.LastName = userDetails.Last_Name__c;
            newContact.AccountId = accountId;
            newContact.Email = userDetails.Email__c;
            newContact.Title = userDetails.Title__c;
            newContact.Phone = userDetails.Phone_Number__c;
            insert newContact;
            
            User newCommunityUser = new User();
            newCommunityUser.Username = userDetails.Email__c;
            newCommunityUser.Email = userDetails.Email__c;
            newCommunityUser.FirstName = userDetails.First_Name__c;
            newCommunityUser.LastName = userDetails.Last_Name__c;
            newCommunityUser.ProfileId = profileId;
            newCommunityUser.ContactId = newContact.Id;
            newCommunityUser.CompanyName = userDetails.Company_Name_DBA__c;
            newCommunityUser.emailencodingkey = 'UTF-8';
            newCommunityUser.alias='default';
            newCommunityUser.Title = userDetails.Title__c;
            newCommunityUser.TimeZoneSidKey = 'America/Chicago';
            newCommunityUser.LocaleSidKey = 'en_US';
            newCommunityUser.LanguageLocaleKey = 'en_US';
            newCommunityUser.Hire_Date__c  = Date.today();
            if(userDetails.Phone_Number__c != null){
                newCommunityUser.Phone = userDetails.Phone_Number__c;
            }
            
            insert newCommunityUser;
            update new User_Self_Registration__c(Id=recordId, Account__c = accountId, Status__c = 'Activated');
            moveAttachedFile(recordId,accountId);
            return newContact.Id;
        }catch(Exception ex){
            Database.rollback(sp);
            System.debug('ex.getMessage()::'+ex.getMessage());
            return Label.Approve_User_Error;
        }
        
    }
    
    @AuraEnabled 
    public static List<RecordsData> fetchRecords( String searchString ) {
        List<RecordsData> recordsDataList = new List<RecordsData>();
        
        try {
            String query = 'SELECT Id,Name FROM Account WHERE Name LIKE ' + '\'' + String.escapeSingleQuotes(searchString.trim()) + '%\'' + ' LIMIT 50000';
            
            for(Account acc : Database.query(query)){
                RecordsData recordsData = new RecordsData();
                recordsData.value = acc.Id;
                recordsData.label = acc.Name;
                recordsDataList.add(recordsData);
            } 
        } catch (Exception err) {
            if ( String.isNotBlank( err.getMessage() ) && err.getMessage().contains( 'error:' ) ) {
                throw new AuraHandledException(err.getMessage().split('error:')[1].split(':')[0] + '.');
            } else {
                throw new AuraHandledException(err.getMessage());
            }
        }
        
        return recordsDataList;
    }
    
    public static void moveAttachedFile(String recordId,String accountId){
        try{
            List<Attachment> moveAttachments = new List<Attachment>();
            for(Attachment attch : [SELECT Id, Name, ContentType, Body FROM Attachment WHERE ParentId = :recordId]){
                moveAttachments.add(new Attachment(Name = attch.Name, Body = attch.Body, ParentId = accountId));
            }
            if(moveAttachments.size() >0)
                insert moveAttachments;
        }catch(Exception ex){
            
        }
    }
    public class RecordsData{
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String value {get;set;}
    }
}