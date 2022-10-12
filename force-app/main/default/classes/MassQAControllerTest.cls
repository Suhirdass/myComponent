@isTest
public class MassQAControllerTest {
	@isTest
    static void test(){
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        Purchase_Order__c objPO = new Purchase_Order__c();
        objpO.PO_Status__c = 'Approved';
        objpO.PO_Type__c = 'Buy Quote';
        objPO.Supplier_Name__c = objAccount.Id;
        objPO.Ownership__c = objAccount.Id;
        insert objPO;
        
        Receiving__c rec = new Receiving__c();
        rec.Purchase_Order__c = objPO.Id;
        insert rec;
        
        
        Purchase_Order_Line__c pol = new Purchase_Order_Line__c();
        pol.Purchase_Order__c = objPO.Id;
        insert pol;
        
        Receiving_Line__c rl = new Receiving_Line__c();
        rl.Receiving_ID__c = rec.Id;
        rl.Purchase_Order_Line__c = pol.Id;
        insert rl;
        
        List<String> rlList = new List<String>();
        rlList.add(rl.Id);
        
        Test.startTest();
        MassQAController.createNewRecord(rlList);
        MassQAController.createRecord(rec.Id);
        Test.stopTest();
    }
}