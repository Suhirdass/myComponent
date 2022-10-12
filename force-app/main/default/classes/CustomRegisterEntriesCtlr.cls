public class CustomRegisterEntriesCtlr {
	@AuraEnabled(cacheable=true)
    public static List<Register_Entry_Line__c> getLimitedAccounts(String selectedCriteria,String parentId){
        String query = 'SELECT Name, Entry_Date__c, Entry_Memo__c ,Payee__r.Name,Credit_Amount__c ,Debit_Amount__c,Old_Balance__c,Transaction_Amount__c,Running_Balance__c ,Chart_of_Account__r.Name FROM Register_Entry_Line__c WHERE Bank_Register__c =:parentId ';
        if(String.isBlank(selectedCriteria)){
            selectedCriteria = 'THIS_MONTH';
        }
        if(selectedCriteria.equalsIgnoreCase('60') || selectedCriteria.equalsIgnoreCase('90')){
            query += 'AND Entry_Date__c = LAST_N_DAYS:'+selectedCriteria +' ORDER BY Entry_Date__c DESC,Name DESC';
        	return Database.query(query);
        }else if(selectedCriteria.equalsIgnoreCase('THIS_MONTH')){
            query += 'AND Entry_Date__c = '+ selectedCriteria+' ORDER BY Entry_Date__c DESC,Name DESC';
            return Database.query(query);
        }else if(selectedCriteria.equalsIgnoreCase('all1')){
            query += ' ORDER BY Entry_Date__c DESC,Name DESC';
            return Database.query(query);
        }
        return null;
    }
}