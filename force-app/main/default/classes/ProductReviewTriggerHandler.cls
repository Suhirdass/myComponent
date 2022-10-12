public class ProductReviewTriggerHandler {
    public static void onInsertUpdate(List<Product_Review__c> productReviews){
        Set<Id> productIds = new Set<Id>();
        for(Product_Review__c pr: productReviews){
            productIds.add(pr.Product__c);
        }
        updateProductReview(productIds);
    }
    
    public static void onDelete(List<Product_Review__c> productReviews){
        Set<Id> productIds = new Set<Id>();
        for(Product_Review__c pr: productReviews){
            productIds.add(pr.Product__c);
        }
        updateProductReview(productIds);
    }
    
    public static void updateProductReview(Set<Id> productIds){
        List<Product2> products = [SELECT Id, Product_Rating__c, (SELECT Id, Rating__c FROM Product_Reviews__r) FROM Product2];
        if(!products.isEmpty()){
            for(Product2 p: products){
                Decimal totalReviewPoints = 0;
                if(p.Product_Reviews__r.size() > 0){
                    for(Product_Review__c pr: p.Product_Reviews__r){
                        totalReviewPoints += (pr.Rating__c != null?pr.Rating__c:0);
                    }
                    p.Product_Rating__c = totalReviewPoints/p.Product_Reviews__r.size();
                }else{
                    p.Product_Rating__c = 0;
                }
                
            }
            update products;
        }
    }
}