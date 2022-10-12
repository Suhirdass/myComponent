@isTest
public class FiligreenProductsCtrlTest {
	static PickList__c pickListObj;
    static Contact con;
    static List<Product2> products;
    static Drivers__c driverObj;
    static Vehicles__c vehicleObj;
    static List<PickList_Line__c> pickListLines;
    static Sales_Order__c salesOrderObj;
    static List<Sales_Order_Line__c> soLines;
    static List<Inventory_Position__c> invPositions;
    static Shipping_Manifest__c rsmObj;
    static List<Shipping_Manifest_Line__c> rsmLines;
    static List<Inventory_Location__c> invLocations;
    static List<Rack__c> racks;
    static List<Rack_Level__c> rackLevels;
    static List<Bin_Location__c> binLocations;
    static Inventory_Location__c vehicleLocation;
    static Bin_Location__c vehicleBinLocation;
    static Rack_Level__c vehicleRackLevel;
    static Rack__c vehicleRack;
    static Inventory_Location__c defaultLocation;
    static Invoice__c invoiceObj;
    static List<Invoice_Line__c> invLines;
    static Excise_Tax_Receipt__c etrObj;
    static List<Excise_Tax_Receipt_Line__c> etrLines;
    
    static final string VEHICLE_Name = 'Test Vehicle';
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        SOlineTriggerHandler.isRecursion = true;
        TestUtilData.createTestData();
    }
    // Retrieve data created from data setup
    public static void retrieveData(){
        TestUtilData.skipTrigger = true;
        Site__c s = new Site__c(Name= '2089-3');
        insert s;
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        products = [SELECT Id,Hide_From_Marketplace__c,Available_Inventory__c,Available_Qty__c,Most_Popular__c FROM Product2];
        products[0].Hide_From_Marketplace__c = false;
        products[0].Most_Popular__c = true;
        products[0].Available_Inventory__c = 200;
        update products[0];
        insert new Product_Review__c(Product__c = products[0].Id, Rating__c = 5,Rating_Text__c = '5', Review__c = 'Nice product');
        Account acc = [SELECT Id, Name,dBA__c,Community_Price_Book__c, Type FROM Account WHERE Name = 'Test Account1' LIMIT 1];
        acc.Type = 'Distributor';
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        acc.Community_Price_Book__c = customPB.Id;
        acc.Hide_From_Marketplace__c = false;
        update acc;
        Account[] accs = [SELECT Id, Name,dBA__c,Community_Price_Book__c, Type FROM Account WHERE Id != :acc.Id];
        Integer i=0;
        List<Line_Card__c> lineCards = new List< Line_Card__c >();
        for(Account a: accs){
            a.dBA__c = acc.Name;
            a.Community_Price_Book__c = customPB.Id;
            a.Hide_From_Marketplace__c = false;
            if(i == 0){
                a.Type = 'Manufacturer';
            }else if(i==1){
                a.Type = 'Supplier';
            }else{
                a.Type = 'Customer';
            }
            lineCards.add(new Line_Card__c(Brand_Name__c = acc.Id,Mutual_Payment_Terms__c ='NET 15', Onboard_Date__c = System.today().addDays(-10), Retailer_Name__c = a.Id, Retail_Account_Rating__c  = 'Preferred', Brand_Account_Rating__c ='Standard',Community_Price_Book__c = customPB.Id));
        }
        insert lineCards;
        update accs;
        Account[] rAccounts = new Account[]{};
            Account objAccount = new Account();
        objAccount.Name = 'Test Microbusiness';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Type = 'Microbusiness';
        rAccounts.add(objAccount);
        objAccount = new Account();
        objAccount.Name = 'Test Retailer';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Type = 'Retailer';
        rAccounts.add(objAccount);
        objAccount = new Account();
        objAccount.Name = 'Test NonStoreFront';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Type = 'Retailer NonStoreFront';
        rAccounts.add(objAccount);
        insert rAccounts;
        Brand_Discount__c bd = new Brand_Discount__c(Brand__c = acc.Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        bd = new Brand_Discount__c(Product_Name__c = products[0].Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        con = [SELECT Id, Name,Primary_Contact__c,AccountId, Email FROM Contact WHERE Name = 'Test Contact1' LIMIT 1];
        con.Email = 'Testcontactat1@filigreencustomer.com';
        con.Primary_Contact__c = true;
        update con;
        Id pricebookId = Test.getStandardPricebookId();
        
        // 1. Insert a price book entry for the standard price book.
        // Standard price book entries require the standard price book ID we got earlier.
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        Map<String,PriceBookEntry> pbeMap = new Map<String,PriceBookEntry>();
        for(PriceBookEntry pbe: [SELECT Id, PriceBook2Id, Product2Id FROM PriceBookEntry]){
            pbeMap.put(pbe.PriceBook2Id+'-'+pbe.Product2Id,pbe);
        }
        for(Product2 p: products){
            p.MOQ__c = 1;
            p.Available_Inventory__c = 100;
            p.Available_Inventory__c = 200;
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
        update products;
        System.debug('##PriceBookEntries:'+[SELECT Id, PriceBook2.Name, Product2.Name FROM PriceBookEntry]);
         Harvest_Batch_Code__c hbc = new Harvest_Batch_Code__c(Name='Test122',Active__c = true);
        insert hbc;
        
        Compliance_Images__c com=new Compliance_Images__c();
        com.COA_Issued_Date__c=System.today().addDays(386);
        com.Product__c=products[0].id;
        com.Harvest_Batch_Code__c = hbc.Id;
        insert com;
        string before = 'Testing base 64 encode';            
            Blob beforeblob = Blob.valueOf(before);
            //Insert contentdocument data
            ContentVersion cv = new ContentVersion();
            cv.title = 'test content trigger';      
            cv.PathOnClient ='test';           
            cv.VersionData =beforeblob;          
            insert cv;         
        
        	ContentVersion testContent = [SELECT id, ContentDocumentId FROM ContentVersion where Id = :cv.Id];
            
            State_Licenses__c stateLicense = [SELECT Id FROM State_Licenses__c LIMIT 1];
            
            ContentDocumentLink newFileShare2 = new ContentDocumentLink();
            newFileShare2.contentdocumentid = testContent.contentdocumentid;
            newFileShare2.LinkedEntityId = products[0].Id;
            newFileShare2.ShareType= 'V';
            insert newFileShare2;
            
            Test.setMock(HttpCalloutMock.class, new ShortenURLMockTest());
            Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,Default_Distributor__c  = acc.Id,Default_License__c = stateLicense.Id,LateFee__c = 0.020,Route_Origin_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US',Route_Destination_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US');
            insert ccs;
    }
    private static testmethod void runTest(){
        TestUtilData.skipTrigger = true;
        retrieveData();
        List<Profile> profiles = [SELECT Id, Name FROM Profile WHERE Name = 'Customer Community Plus User Custom'];
        User u = new User();
        u.ProfileId = profiles[0].Id;
        u.firstName = 'testcontact1';
        u.lastName = 'customeruser';
        u.Username = 'Testcontactat1@filigreencustomer.com.testaccount1';
        u.Email = 'Testcontactat1@filigreencustomer.com';
        u.ContactId = con.Id;
        u.Title = 'Customer';
        u.CommunityNickname = 'ruser';
        u.Alias = 'testser';
        u.TimeZoneSidKey = 'America/Los_Angeles'; // Required
        u.LocaleSidKey = 'en_US'; // Required
        u.EmailEncodingKey = 'ISO-8859-1'; // Required
        u.LanguageLocaleKey = 'en_US'; // Required
        insert u;
        Test.startTest();
        //OrderHelper.runningTrigger = true;
        System.runAs(u){
            OrderHelper.runningTrigger = true;
            Boolean isBrand = ProductsCtlr.isBrand;
            Map<String,String> strainTypeMap = ProductsCtlr.strainTypeMap;
            FiligreenProductsCtrl.getCategories();
            Map<String, Object> filters = new Map<String, Object> {'families'=>'Edibles','orderByField' =>'Product2.Name', 'isASC' => true, 'searchTerm' => 'product'};
                
            AuraResponse r = FiligreenProductsCtrl.getCategories();
            r = FiligreenProductsCtrl.getIds(new Map<String, Object> {'orderByField' =>'Product2.Name', 'isASC' => true});
            Set<Id> ids = (Set<Id>)r.data.get('ids');
            List<String> idsList = new List<String>();
            for(Id idStr : ids){
                idsList.add(idStr);
            }
            PriceBookEntry pbe = [SELECT Id FROM PriceBookEntry WHERE PriceBook2Id = :FiligreenProductsCtrl.priceBookId AND Product2Id =: products[0].Id];
            filters = new Map<String, Object> {'orderByField' =>'Product2.Name', 'isASC' => true};
                r = FiligreenProductsCtrl.getProducts(idsList,filters);
            r = FiligreenProductsCtrl.getProductAndReviews(''+EncodingUtil.base64Encode(Blob.valueOf(pbe.Id)),5);
            r = FiligreenProductsCtrl.getRecentProducts(new Map<String,Object>());
        }
    }
    
}