@isTest
public class ProductInventoryByBatchControllerTest {
	@TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        SOlineTriggerHandler.isRecursion = true;
        OrderHelper.runningTrigger = true;
        //ProductsCtlr.skipTrigger = true;
        TestUtilData.createTestData();
    }
    public static testmethod void runTest(){
        OrderHelper.runningTrigger = true;
        Account acc = new Account();
        acc.Name = 'test acc';
        insert acc;
        
        Contact con = new Contact();
        con.firstName = 'test';
        con.LastName = 'Con';
        con.email = 'test@test.com';
        con.AccountId = acc.id;
        insert con;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Customer Community Plus User Custom'];
        
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.EmailHeader.triggerUserEmail = false;
        
        User u = new User(alias = 'standt', email=con.email,emailencodingkey='UTF-8', lastname=con.lastname,
			firstname=con.firstname, languagelocalekey='en_US',localesidkey='en_US', profileid = p.Id, contactId=con.Id,
			timezonesidkey='America/Los_Angeles',username=con.email);
        u.setOptions(dmo);
        insert u;
        
        Site__c s = new Site__c(Name= '2089-3');
        insert s;
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        List<Product2> products = [SELECT Id,Hide_From_Marketplace__c,Most_Popular__c FROM Product2];
        products[0].Hide_From_Marketplace__c = false;
        products[0].Most_Popular__c = true;
        products[0].Available_Inventory__c = 200;
        products[0].Producer_Name__c = acc.Id;
        update products[0];
        
        products[1].Parent_Product__c = products[0].Id;
        update products[1];
        
        
        Order__c o =new Order__c();
        o.Account__c=acc.id;
        o.Status__c='Approved';
       //	o.RecordTypeId =rt.Id;
        o.Order_Date__c=system.today();
        //State_License__c=licenses[0].id;
        insert o;
        Order_Line_Item__c oli =new Order_Line_Item__c();
        oli.Order__c=o.id;
        oli.Ownership_Code__c =acc.id;
        oli.Quantity_Cases__c=1;
        oli.MOQ__c=1;
        oli.UnitPrice__c=3;
        oli.Product__c=products[0].id;
        oli.Price_Book_Entry_Id__c=customPB.id;
        insert oli;
        
        Harvest_Batch_Code__c hbc =new Harvest_Batch_Code__c();
        hbc.Name='test';
        hbc.Producer_Name__c =acc.id;
        insert hbc;
        test.startTest();
        Inventory_Position__c ip =new Inventory_Position__c();
        ip.Product_Name__c =products[0].id;  
        ip.Site__c =s.Id;
        ip.Harvest_Batch_Code__c=hbc.id;
        ip.Ownership__c =acc.id;
        ip.Qty_On_Hand__c = 10;
        ip.Qty_Allocated__c = 10;
        insert ip;
        
        ApexPages.currentPage().getParameters().put('sortfield','Product_Name__c');
        ApexPages.currentPage().getParameters().put('sortOrder','DESC');
        ApexPages.currentPage().getParameters().put('searchText','');
        
         System.runAs(u) {
             ProductInventoryByBatchController pi =new ProductInventoryByBatchController();
             
             	AuraResponse r = ProductInventoryByBatchController.fetchInvenotry('Product_Name__c','DESC','t',1,true); 
             	ProductInventoryByBatchController.changePageRecords(JSON.serialize(r.data.get('totelRecords')),JSON.serialize(r.data.get('productList')),10,11,20);
             test.stopTest();
         }
    }
}