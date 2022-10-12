@isTest
public class TaxTableTriggerHelperTest {
    public static testmethod void runTest(){
        Tax_Table__c tb = new Tax_Table__c();
        tb.Tax_Due_Rate__c = 5;
        tb.Taxable_Gross_Receipts_Rate__c  = 25;
        tb.Actual_Tax_Rate_on_Product_Rev__c  = 0.5;
        tb.Active__c = true;
        tb.Start_Date__c = System.today().addDays(-10);
        tb.End_Date__c = System.today().addMonths(12);
        tb.City__c  = 'San Francisco';
        insert tb;
        tb.Active__c = false;
        update tb;
        tb.Active__c = true;
        update tb;
    }
}