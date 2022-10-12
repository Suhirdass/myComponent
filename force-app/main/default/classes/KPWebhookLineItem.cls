@RestResource(urlMapping='/createOrderLine/*')
global without sharing class KPWebhookLineItem {
    
    @HttpGet
    global static String getData() {
        return 'ReturnKPOrderLineDatafromSalesforce';
    }
    
    @HttpPost
    global static Map<String, String> createOrderLineItem() {
        Brand_Quote__c newQuote = new Brand_Quote__c(BQ_Status__c = 'Draft');
        Map<String, String> r = new Map<String, String>();
        try{
        RestRequest request = RestContext.request;
        System.debug('Actual Order Line Request: ' + request);
		System.debug('Order Line ITem request: ' + request.requestBody.toString());
		Order order = (Order)JSON.deserialize(request.requestBody.toString(), Order.Class);
        Id BQLRecordTypeId = Schema.SObjectType.Brand_Quote_Line__c.getRecordTypeInfosByName().get('Sell Quote Line').getRecordTypeId();
        Brand_Quote_Line__c bql = new Brand_Quote_Line__c(RecordTypeId=BQLRecordTypeId,Kushy_Punch_Order_Line_Item__c = order.LineItemNumber,Product_Title__c ='Distributor',MOQ__c =1,Quantity_Cases__c=order.Quantity,Retail_Wholesale_Price__c=(String.isNotBlank(order.price)?Decimal.valueOf(order.price.replace('$','')):0));
        Brand_Quote__c bq = new Brand_Quote__c(Kushy_Punch_Order_Number__c = order.OrderNumber);
 
		System.debug('bq List='+bq);		
		Brand_Quote__c oppID = [select id,Opportunity_Name__c from Brand_Quote__c where Kushy_Punch_Order_Number__c =: order.OrderNumber];
		System.debug('oppID List='+oppID);
		 
		bql.Brand_Quote_Number__r = bq;
        bql.Retail_Wholesale_Price__c = Decimal.valueOf(order.SalePrice.remove('$'));
		List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();
		if(String.isNotBlank(order.Product)){
            OpportunityLineItem[] existingOLIs = [SELECT Id, PricebookEntry.DistyMargin__c,Disty_Discount_Per_Unit__c FROM  OpportunityLineItem WHERE Kushy_Punch_Order_Line_Item__c = :order.LineItemNumber LIMIT 1];
            for(Product2 prd:[SELECT Id, Name FROM Product2 WHERE StockKeepingUnit = :order.Product]){
                bql.Product_Name__c = prd.Id;
                break;
            }
            if(bql.Product_Name__c != null){
                for(PriceBookEntry pbe: [SELECT Id, PriceBook2Id FROM PriceBookEntry WHERE Product2Id = :bql.Product_Name__c AND PriceBook2.IsStandard = true]){
                    bql.Price_Book__c = pbe.PriceBook2Id;
                    OpportunityLineItem oli;
                    if(existingOLIs.isEmpty()){
                        oli = new OpportunityLineItem(OpportunityId=oppID.Opportunity_Name__c, PricebookEntryId=pbe.Id, Quantity = order.Quantity, UnitPrice = Decimal.valueOf(order.SalePrice.remove('$')), Product_Title__c = 'Distributor',Kushy_Punch_Order_Line_Item__c = order.LineItemNumber);
                    }else{
                        oli = new OpportunityLineItem(OpportunityId=oppID.Opportunity_Name__c, Quantity = order.Quantity, UnitPrice = Decimal.valueOf(order.SalePrice.remove('$')), Product_Title__c = 'Distributor',Kushy_Punch_Order_Line_Item__c = order.LineItemNumber);
                    }

					oliList.add(oli);
					System.debug('OLI List='+oli);
                    break;
                }
            }
        }
		Database.UpsertResult[] res = Database.upsert(oliList,OpportunityLineItem.fields.Kushy_Punch_Order_Line_Item__c,false);
            System.debug('##Database.UpsertResult[]::'+res);
        for(OpportunityLineItem oli: [SELECT Id, PricebookEntry.DistyMargin__c,Disty_Discount_Per_Unit__c FROM  OpportunityLineItem WHERE Id IN :oliList]){
            bql.Disty_Margin__c = oli.PricebookEntry.DistyMargin__c;
            bql.Disty_Discount_Per_Unit__c = oli.Disty_Discount_Per_Unit__c;
        }
		System.debug('OPPLI List='+oliList);
		Database.upsert(bql,Brand_Quote_Line__c.Fields.Kushy_Punch_Order_Line_Item__c,false);
		
		System.debug('BQL: ' + bql);
        r.put('name', order.OrderNumber);
        }catch(Exception e){
            System.debug('###Exception:'+e.getMessage());
        }
        return r;
    }
    public class Order{
        public String OrderNumber			{get;set;}
        public String LineItemNumber 		{get;set;}
        public String Product  				{get;set;}
        public Integer Quantity     		{get;set;}
        public String Price      			{get;set;}
        public String SalePrice       		{get;set;}
    }
    
}