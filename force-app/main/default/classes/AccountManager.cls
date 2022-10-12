public with sharing class AccountManager {
  /*  
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccount(){

        return [SELECT Id, Name, Phone FROM Account Limit 10];
        
    }*/

    //calling imperative method
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccount(integer numOfAccounts){

        return [SELECT Id, Name, Phone FROM Account Limit :numOfAccounts];
        
    }
}
