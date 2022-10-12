public without sharing class ManageExternalProductCtrl {
    
	public static String brandId = Utility.loggedInUser.AccountId;
    public static Id priceBookId = (Utility.loggedInUser.Contact.Account.Community_Price_Book__c != null? Utility.loggedInUser.Contact.Account.Community_Price_Book__c: null);
    static String recordTypeName = 'Product';
    //Return Product list
    @AuraEnabled
    public static ProductDetails getProductList(){
        Id devRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Product').getRecordTypeId();
        
    	List<Product2> lstProduct = [select id,Name,Available_Qty__c,THC_Amount__c,Hide_From_Marketplace__c,Total_Inventory__c,Hide_from_Bulk_exchange__c,
                                     THC_MG_G__c,CDB_Amount__c,CBD_MG_G__c,Available_Inventory__c,MOQ__c,Terpene_percent__c,Terpene_MG_G__c,
                                     Producer_Name__r.Hide_from_Marketplace__c,Description,Product_Short_Description__c from Product2
                                     Where IsActive = true 
                                     AND Hide_From_Marketplace__c = false 
                                     AND Hide_from_Bulk_exchange__c = false
                                     AND Fulfilled_by_Filigreen__c = false 
                                     AND RecordType.Name =: recordTypeName 
                                     AND Producer_Name__c =: brandId 
                                     AND Producer_Name__r.Hide_from_Marketplace__c = false 
                                     ORDER by Name];
        Map<Id,Product2>productMap = new Map<Id,Product2>(lstProduct);
        
        set<Id> setIds = new Set<Id>();
        for(Product2 pro : lstProduct){
            setIds.add(pro.Id);
        }
        
        List<PricebookEntry> lstEntry = [select id,Product2Id from PricebookEntry where Product2Id In :setIds and Pricebook2Id =: priceBookId];
        Map<String,String> mapProduct = new Map<String,String>();
        
        for(PricebookEntry entry : lstEntry){
        	mapProduct.put(entry.Product2Id,entry.Id);    
        }
        List<Product2> tempList = new List<Product2>();
        for(Product2 p : lstProduct){
            if(mapProduct.containsKey(p.Id)){
                tempList.add(p);
            }
        }
        lstProduct = tempList;
        ProductDetails proWrp = new ProductDetails();
        proWrp.products = lstProduct;
        proWrp.productPriceBookMap = mapProduct;
        
        return proWrp;
    }
    
    //Save Products
    @AuraEnabled
    public static AuraResponse saveProducts(List<Product2> productList){
        AuraResponse r = new AuraResponse('ManageExternalProductCtrl.saveProducts()');
        if(productList.size() > 0){
            for(Product2 pro : productList){
                if(pro.Available_Inventory__c == null){
                	r.data.put('isValid', false);	
                    return r;
                } else {
                	pro.Total_Inventory__c = (pro.Available_Inventory__c != null) ? pro.Available_Inventory__c : 0; 
                    pro.Description = pro.Product_Short_Description__c; 
                }   
            }
        	update productList;  
        }
        r.data.put('isValid', true);
        return r;
    }
    
    public class ProductDetails {
        @AuraEnabled
        public List<Product2> products 				  {get;set;}
        @AuraEnabled
        public Map<String,String> productPriceBookMap {get;set;}
    }
}