public class getAccountRecord {
  

    @AuraEnabled(cacheable=true)

    public static List<Account> getAccountRecordMethod(String recordIdAccount) {

    List<Account> accList=[SELECT Id, Name, Industry

        FROM Account

        Where id=:recordIdAccount];

        return accList;

    }

}