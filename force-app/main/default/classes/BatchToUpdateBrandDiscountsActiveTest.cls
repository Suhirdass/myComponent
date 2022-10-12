@isTest
public class BatchToUpdateBrandDiscountsActiveTest {
    private static testmethod void runTest(){
        Brand_Discount__c bd = new Brand_Discount__c(Discount_Active__c = true, Discount_Start_DateTime__c = Date.today(),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        Database.executeBatch(new BatchToUpdateBrandDiscountsActive());
        
        BatchToUpdateBrandDiscountsActive sh1 = new BatchToUpdateBrandDiscountsActive();
        
        String sch = '0 0 23 * * ?'; 
        system.schedule('Test BatchToUpdateBrandDiscountsActive', sch, sh1);
    }
}