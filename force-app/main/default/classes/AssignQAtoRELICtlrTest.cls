@isTest
public class AssignQAtoRELICtlrTest {
	@isTest
    static void test(){
        Purchase_Order__c po = new Purchase_Order__c();
        po.Create_Supplier_Bill__c = true;
        po.PO_Date__c = System.today();
        insert po;
        test.startTest();
        AuraResponse r = AssignQAtoRELICtlr.getPOandRELIsDeatils(po.Id);
        test.stopTest();
    }
}