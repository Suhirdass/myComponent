@isTest
public class ProductReviewTriggerTest {
	@TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
    }
    static testmethod void runProductReviewTrigger(){
        Product2[] prods = [SELECT Id FROM Product2];
        if(!prods.isEmpty()){
            Product_Review__c p =  new Product_Review__c(Product__c = prods[0].Id, Rating__c = 5,Rating_Text__c = '5', Review__c = 'Test Review');
            insert p;
            
            delete p;
        }
    }
}