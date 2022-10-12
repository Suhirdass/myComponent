@IsTest 
public class CustomRegisterEntriesTest {
    @testSetup static void setup() {
        Account acc = new Account(Name='Test Account');
        insert acc;
        Bank_Register__c br = new Bank_Register__c(Account__c =acc.Id,Bank_Name__c = 'Test Bank');
        insert br;
        Date dt = Date.newInstance(2019, 03, 05);
        Date dt1 = Date.newInstance(2019, 02, 05);
        Register_Entry_Line__c rel = new Register_Entry_Line__c(Bank_Register__c = br.Id,
                                                                Payee__c = acc.Id,
                                                                Entry_Date__c = dt);
        insert rel;
        
        Register_Entry_Line__c rel1 = new Register_Entry_Line__c(Bank_Register__c = br.Id,
                                                                Payee__c = acc.Id,
                                                                Entry_Date__c = System.today());
        insert rel1;
    }
    
    @isTest
    public static void testListViewLightning(){
        Bank_Register__c br = [SELECT Id FROM Bank_Register__c LIMIT 1];
        List<Register_Entry_Line__c> items = CustomRegisterEntriesCtlr.getLimitedAccounts('THIS_MONTH',br.Id);
        System.assertEquals(1, items.size());
        
        items = CustomRegisterEntriesCtlr.getLimitedAccounts('60',br.Id);
        System.assertEquals(2, items.size());
        
        items = CustomRegisterEntriesCtlr.getLimitedAccounts('all',br.Id);
        System.assertEquals(null, items);
    }
}