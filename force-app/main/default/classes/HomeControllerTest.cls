@isTest
public class HomeControllerTest {
    @isTest
    private static void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        SOlineTriggerHandler.isRecursion = true;
        
        TestUtilData.createTestData();
        
        Account acc = new Account();
        acc.Name = 'test acc';
        acc.Type = 'Distributor';
        insert acc;
        
        Contact con = new Contact();
        con.firstName = 'test';
        con.LastName = 'Con';
        con.email = 'test@test.com';
        con.AccountId = acc.id;
        insert con;
        
        Line_Card__c lineCard = new Line_Card__c();
        lineCard.Brand_Name__c = acc.id;
        lineCard.Retailer_Name__c = acc.id;
        insert lineCard;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Customer Community Plus User Custom'];
        
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.EmailHeader.triggerUserEmail = false;
        
        User u = new User(alias = 'standt', email=con.email,emailencodingkey='UTF-8', lastname=con.lastname,
			firstname=con.firstname, languagelocalekey='en_US',localesidkey='en_US', profileid = p.Id, contactId=con.Id,
			timezonesidkey='America/Los_Angeles',username=con.email);
        u.setOptions(dmo);
        insert u;       
        
        System.runAs(u) {
            
            Order__c ord = new Order__c();
            ord.Status__c = 'Shipped';
            ord.Order_Date__c = system.today();
            ord.Retailer__c = acc.id;
            insert ord;

			Order__c ord1 = new Order__c();
            ord1.Status__c = 'Delivered';
            ord1.Order_Date__c = system.today().addMonths(-4);
            ord1.Retailer__c = acc.id;
            insert ord1;     
            
            Opportunity opp = new Opportunity();
            opp.Order__c = ord1.id;
            opp.Name = 'test opp';
            opp.StageName = 'Qualification';
            opp.CloseDate = system.today();
            insert opp;
            
            Site__c Site = new Site__c();
            Site.Name = 'Test Site';
            Site.Warehouse_Name__c='TestWarehouse1';
            insert Site;
            
            Brand_Quote__c BQ = new Brand_Quote__c ();
            BQ.Opportunity_Name__c = opp.id; 
            BQ.Distributor_Name__c = Acc.id;
            BQ.Supplier_Name__c = Acc.id;
            BQ.Receiver_Name__c = Acc.id;
            BQ.BQ_Status__c = 'Draft';
            BQ.Shipping_Method__c = 'Distributor Pick-up';
            BQ.Sales_Origin__c = 'Brand';
            BQ.Shipping_Terms__c = 'CFR';        
            BQ.Site__c = Site.id;
            BQ.Ownership__c = Opp.Ownership__c;
            BQ.Payment_Terms__c = Opp.Payment_Terms__c;
            BQ.Apply_Excise_Tax__c = true;
            BQ.Order_Type__c = 'Retailer';
            BQ.Sales_person__c = Con.Name;
            insert BQ;
            
            Sales_Order__c salesOrd = new Sales_Order__c();
            salesOrd.Opportunity_Name__c = opp.id;
            salesOrd.Brand_Quote__c = bq.id;
            insert salesOrd;
            
            Id RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get('Product').getRecordTypeId();
            
            Invoice__c inv = new Invoice__c();
            inv.Invoice_Due_Date__c = system.today().addMonths(-1);
            inv.Sales_Order__c = salesOrd.id;
            inv.RecordTypeId = RecordTypeId;
            insert inv;
            
            Invoice_Line__c lnvoiceLine = new Invoice_Line__c();
            lnvoiceLine.InvoiceLine_Status__c = 'Shipped';
            lnvoiceLine.Invoice__c = inv.id;
            insert lnvoiceLine;
            
            Shipping_Manifest__c sm = new Shipping_Manifest__c();
            sm.Ship_Confirmation_Date__c = system.today().addmonths(-1);
            sm.Order_Number__c = ord1.id;
            insert sm;
            
            system.debug('sm '+[select id from Shipping_Manifest__c where Ship_Confirmation_Date__c = LAST_N_Months:6]);
            
            Shipping_Manifest_Line__c smLine = new Shipping_Manifest_Line__c();
            smLine.SMLine_Status__c = 'Shipment Complete';
            smLine.Shipping_Manifest__c = sm.id;
            insert smLine;
            
            Product_Categories__c prodCat = new Product_Categories__c();
            prodCat.Icon_Name__c = 'test';
            prodCat.Name = 'test';
            prodCat.Category__c = 'test';
            prodCat.Product_Families__c = 'Accessories';
            prodCat.Sort_Order__c = 1;
            insert prodCat;
            
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
            
            Inventory_Location__c invLoc = new Inventory_Location__c();
            invLoc.Include_in_Inventory__c = true;
            invLoc.Site_Name__c = s.Id;
            insert invLoc;
            
            Inventory_Position__c ip =new Inventory_Position__c();
            ip.Product_Name__c =products[0].id;
            ip.Site__c =s.Id;
            ip.Ownership__c =acc.id;
            ip.Inventory_Location__c = invLoc.id;
            insert ip;
            test.startTest();
    		HomeController.getHomePageData();
            HomeController.dontShowAgain();
            string filter = '{ "orderByField": "Name", "isASC": false }';
            Map<String, Object> filters = (Map<String, Object>)JSON.deserializeUntyped(filter);
            
            AuraResponse r = HomeController.getAllColdAccountIds(filters);
            List<Id> ids = new List<Id>();
            for(Id id : (Set<Id>)r.data.get('ids')){
                ids.add(id);
            }
            HomeController.getAllColdAccounts(ids,filters);
            
            HomeController.TopBuyingRetailer topBuying = new HomeController.TopBuyingRetailer('','','',0.0);
            HomeController.TopSellingProducts topSelling = new HomeController.TopSellingProducts('','','',0,0.0);
            test.stopTest();
        }
    }
}