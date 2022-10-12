public class FiligreenSocailAccountsController {
	@AuraEnabled
    public static Company_Custom_Settings__c  getSocialAccounts(){
        return Company_Custom_Settings__c.getOrgDefaults();
    }
}