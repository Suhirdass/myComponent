@IsTest
public class SendNotificationToBrandUponNewOrderTest {
    private static testmethod void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
        
        List<Product2> products = [SELECT Id,Hide_From_Marketplace__c,Most_Popular__c,Producer_Name__c FROM Product2];
        Account acc = [SELECT Id FROM Account LIMIT 1];
        List<Contact> lstCon = [SELECT Id,Orders_Email_Opt_In__c,Active__c From Contact Where AccountId =: products[0].Producer_Name__c];
        for(Contact con : lstCon){
            con.Active__c = true;
            con.Orders_Email_Opt_In__c = true;  
            con.Email = 'test@gmail.com';
        }
        update lstCon;
        
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        
        // 1. Insert a price book entry for the standard price book.
        // Standard price book entries require the standard price book ID we got earlier.
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        Id pricebookId = Test.getStandardPricebookId();
        Map<String,PriceBookEntry> pbeMap = new Map<String,PriceBookEntry>();
        for(PriceBookEntry pbe: [SELECT Id, PriceBook2Id, Product2Id FROM PriceBookEntry]){
            pbeMap.put(pbe.PriceBook2Id+'-'+pbe.Product2Id,pbe);
        }
        for(Product2 p: products){
            p.MOQ__c = 1;
            p.Available_Inventory__c = 100;
            p.Producer_Name__c = acc.Id;
            p.Product_Rating__c = 0;
            if(!pbeMap.containsKey(pricebookId+'-'+p.Id)){
                pbeList.add(new PricebookEntry(
                    Pricebook2Id = pricebookId, Product2Id = p.Id,
                    UnitPrice = 10000, IsActive = true));
            }
            if(!pbeMap.containsKey(customPB.Id+'-'+p.Id)){
                pbeList.add(new PricebookEntry(
                    Pricebook2Id = customPB.Id, Product2Id = p.Id,
                    UnitPrice = 12000, IsActive = true));
            }
        }
        insert pbeList;
        
        RecordType rt= [SELECT id FROM RecordType WHERE Name='Retailer'];
        Order__c o =new Order__c();
        o.Account__c=acc.id;
        o.Status__c='Pending';
        o.RecordTypeId =rt.Id;
        o.Order_Date__c=system.today();
        //o.State_License__c=licenses[0].id;
        insert o;
        Order_Line_Item__c oli =new Order_Line_Item__c();
        oli.Order__c=o.id;
        oli.Ownership_Code__c =acc.id;
        oli.Quantity_Cases__c=1;
        oli.MOQ__c=1;
        oli.UnitPrice__c=3;
        oli.Product__c=products[0].id;
        oli.Price_Book_Entry_Id__c=pbeList[1].id;
        insert oli;
        
        SendNotificationToBrandUponNewOrder.notifyOnNewRetailerOrder(new List<Id>{o.Id});
    }
}