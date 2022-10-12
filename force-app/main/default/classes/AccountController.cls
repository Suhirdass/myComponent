public with sharing class AccountController {
    @AuraEnabled( cacheable = true )
    public static List< Account > fetchAccounts() {
        
        return [ SELECT Id, Name, Industry, ParentId, RecordTypeId FROM Account LIMIT 10 ];
        
    }
    
}