@isTest
public class LineCardTriggerTest {
    @isTest
    public static void Test(){
        
        Account acc = new Account();
        acc.Name = 'Test Account3';
        acc.Payment_Terms__c = 'COD';
        acc.Type = 'Distributor';
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        acc.Hide_From_Marketplace__c = false;
        insert acc;
        
        Line_Card__c l= new Line_Card__c();
        l.Brand_Name__c=acc.id;
        l.Retailer_Name__c=acc.id;
        l.Mutual_Payment_Terms__c='COD';
        insert l;
        
        System.assertEquals(acc.dBA__c, 'Irrational Raccoon');
    }
}