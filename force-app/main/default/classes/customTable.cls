public with sharing class customTable {
    @AuraEnabled(cacheable = true)
    public static List<Account> getAllAccounts(){
        List<Account> accList =[Select Id,Name,Ownership,
                                Industry,Rating,ParentId,Phone FROM Account limit 10];
        return accList;
    }
}