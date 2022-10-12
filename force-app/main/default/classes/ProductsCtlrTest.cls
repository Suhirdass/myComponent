@IsTest 
private class ProductsCtlrTest { 
    static PickList__c pickListObj;
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
        
        //ProductsCtlr.skipTrigger = true;
        TestUtilData.createTestData();
    }
    private static testmethod void TestCase() {
        Test.StartTest();
        
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        Case myCase= new Case(Subject='Test12', Description='Test32');
        
        ProductsCtlr.saveCase(mycase);
        Map<String, String> filters = new Map<String, String> ();
        filters.put('orderByField', 'createdDate');
        filters.put('isASC', 'false');
        filters.put('searchTerm', 'test');
        ProductsCtlr.getCases( filters);
        ProductsCtlr.getCaseDetails(new List<Id> {mycase.Id}, filters);
        ProductsCtlr.getCaseFullDetails(myCase.id);
        ProductsCtlr.printCaseDetails(myCase.id);
        ProductsCtlr.closeMyCase(myCase.id);
        Test.StopTest();
        
    }
    // Retrieve data created from data setup
    public static void retrieveData(){
        SOlineTriggerHandler.isRecursion = true;
        invPositions = [Select Sales_Order_Line__c,
                        Sales_Order_Line__r.Product_Name__c,
                        Inventory_Location__r.Name,
                        Inventory_Location__c,
                        Rack__c,
                        Rack_Level__c,
                        Bin_Location__c
                        From Inventory_Position__c];
        
        racks = [Select Inventory_Location__c From Rack__c ORDER BY NAME];
        rackLevels = [Select Id From Rack_Level__c ORDER BY NAME];
        binLocations = [Select Id From Bin_Location__c ORDER BY NAME];
        
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Site__c,
                         Brand_Quote__c, 
                         Distributor_Contact__c, 
                         Distributor_License__c,
                         Distributor_Name__c,
                         Opportunity_Name__c,
                         Payment_Terms__c,
                         Planned_Ship_Date__c,
                         Receiver_Contact__c,
                         Receiver_License__c,
                         Receiver_Name__c,
                         Sample_Order__c,
                         Shipping_Method__c,
                         Shipping_Terms__c,
                         Supplier_Contact__c,
                         Supplier_License__c,
                         Supplier_Name__c
                         from Sales_Order__c];
        
        // Update planned ship date of SO
        salesOrderObj.Planned_Ship_Date__c = System.Today();
        update salesOrderObj;
        
        List<Brand_Quote_Line__c> brandQuoteLines = [Select Id,Quantity_Cases__c From Brand_Quote_Line__c];
        for(Brand_Quote_Line__c bql : brandQuoteLines){
            if(bql.Quantity_Cases__c == null){
                bql.Quantity_Cases__c = 10;
            }
        }
        update brandQuoteLines;
        soLines = new List<Sales_Order_Line__c>();
        soLines = [Select Id, Status__c, Brand_Quote_Line__c from Sales_Order_Line__c];
        
        for(Integer i=0; i<soLines.size(); i++){
            soLines[i].Brand_Quote_Line__c = brandQuoteLines[i].Id;
            soLines[i].Qty_Ordered__c = (i+1)*2;
        }
        update soLines;
        soLines[0].Status__c = 'Allocated';
        update soLines[0];
        soLines[0].Status__c = 'Open';
        update soLines[0];
        // Update SO lines in Inventory positions
        for(Integer i=0; i<invPositions.size(); i++){
            invPositions[i].Inventory_Location__c = racks[0].Inventory_Location__c;
            invPositions[i].Sales_Order_Line__c = soLines[i].Id;
            invPositions[i].Rack__c = racks[0].Id;
            invPositions[i].Rack_Level__c = rackLevels[0].Id;
            invPositions[i].Bin_Location__c = binLocations[0].Id;
        }
        update invPositions;
        
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        pickListObj = [Select Site__c,
                       Sales_Order__r.Brand_Quote__c, 
                       Sales_Order__r.Customer_PO_or_Quote__c,
                       Sales_Order__r.Distributor_Contact__c, 
                       Sales_Order__r.Distributor_License__c,
                       Sales_Order__r.Distributor_Name__c,
                       Sales_Order__r.Opportunity_Name__c,
                       Sales_Order__r.Payment_Terms__c,
                       Sales_Order__r.Planned_Ship_Date__c,
                       Sales_Order__r.Receiver_Contact__c,
                       Sales_Order__r.Receiver_License__c,
                       Sales_Order__r.Receiver_Name__c,
                       Sales_Order__r.Sample_Order__c,
                       Sales_Order__r.Shipping_Method__c,
                       Sales_Order__r.Shipping_Terms__c,
                       Sales_Order__r.Supplier_Contact__c,
                       Sales_Order__r.Supplier_License__c,
                       Sales_Order__r.Supplier_Name__c,
                       Sales_Order__c,
                       Status__c
                       from Picklist__c];
        
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, 'Open', true);
        picklistLines = [Select Product_Name__c,
                         Sales_Order_Line__r.Product_Name__c,
                         Sales_Order_Line__r.Product_Title__c,
                         Sales_Order_Line__r.Qty_Allocated__c,
                         Sales_Order_Line__r.Retail_Wholesale_Price__c,
                         Sales_Order_Line__r.UID__c,
                         Inventory_Location__c
                         From Picklist_Line__c];
        
        // Create Inventory Location, Rack, Rack Level and Bin Location with Vehicle name
        List<Inventory_Location__c> invLocations = [Select Name, Site_Name__c from Inventory_Location__c];
        defaultLocation = invLocations[0].clone(false, true);
        defaultLocation.Name = Label.Default_Inventory_Location;
        insert defaultLocation;
        
        vehicleLocation = invLocations[0].clone(false, true);
        vehicleLocation.Name = VEHICLE_NAME;
        insert vehicleLocation;
        
        List<Rack__c> racks = [Select Name, Inventory_Location__c from Rack__c];
        vehicleRack = racks[0].clone(false, true);
        vehicleRack.Name = VEHICLE_NAME;
        vehicleRack.Inventory_Location__c = vehicleLocation.Id;
        insert vehicleRack;
        
        List<Rack_Level__c> rackLevels = [Select Name, Rack__c from Rack_Level__c];
        vehicleRackLevel = rackLevels[0].clone(false, true);
        vehicleRackLevel.Name = VEHICLE_NAME;
        vehicleRackLevel.Rack__c = vehicleRack.Id;
        insert vehicleRackLevel;
        
        List<Bin_Location__c> binLocations = [Select Name, Rack_Level__c from Bin_Location__c];
        vehicleBinLocation = binLocations[0].clone(false, true);
        vehicleBinLocation.Name = VEHICLE_NAME;
        vehicleBinLocation.Rack_Level__c = vehicleRackLevel.Id;
        insert vehicleBinLocation;
        
        // Create Driver
        driverObj = TestUtilData.createDriver(false);
        driverObj.Name = UserInfo.getName();
        insert driverObj;
        
        // Create Vehicle
        vehicleObj = TestUtilData.createVehicle(false);
        vehicleObj.Name = VEHICLE_NAME; 
        insert vehicleObj;
        
        // Retrieve invoice and lines
        invoiceObj = new Invoice__c();
        invoiceObj = [Select Name, Invoice_Balance__c, Invoice_Due_Date__c, AR_Status__c from Invoice__c];
        
        invLines = new List<Invoice_Line__c>();
        invLines = [Select InvoiceLine_Status__c, Retail_Wholesale_Price__c From Invoice_Line__c];
        
        for(Invoice_Line__c invoiceLineObj : invLines){
            invoiceLineObj.Retail_Wholesale_Price__c = 100.0;
            invoiceLineObj.InvoiceLine_Status__c = RSMSupport.STATUS_DRAFT;
        }
        update invLines;
        
        // Create ETR and lines
        etrObj = TestUtilData.CreateETR(invoiceObj, salesOrderObj, true);
        
        etrLines = new List<Excise_Tax_Receipt_Line__c>();
        for(Integer i=0; i<invLines.size(); i++){
            etrLines.add(new Excise_Tax_Receipt_Line__c(Excise_Tax_Receipt__c = etrObj.Id,
                                                        Invoice_Line__c = invLines[i].Id,
                                                        ETRLine_Status__c = RSMSupport.STATUS_DRAFT));
        }
        insert etrLines;
    }
    private static testmethod void runProfileCtrl(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        TestUtilData.skipTrigger = true;
        OrderHelper.runningTrigger =true;
        Site__c s = new Site__c(Name= '2089-3');
        s.Active__c =true;
        s.Sort_Order__c =1;
        insert s;
        
        
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        List<Product2> products = [SELECT Id,Hide_From_Marketplace__c,Most_Popular__c FROM Product2];
        products[0].Hide_From_Marketplace__c = false;
        products[0].Most_Popular__c = true;
        products[0].Available_Inventory__c = 200;
        update products[0];
        
        products[1].Parent_Product__c = products[0].Id;
        update products[1];
        
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
        
        ContentDocumentLink newFileShare = new ContentDocumentLink();
        newFileShare.contentdocumentid = testContent.contentdocumentid;
        newFileShare.LinkedEntityId = com.Id;
        newFileShare.ShareType= 'V';
        insert newFileShare;
        
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
                a.Type = 'Microbusiness';
            }else{
                a.Type = 'Retailer';
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
        objAccount.Licensed_Verticals__c = 'Cultivator';
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
        Strain__c st = new Strain__c (Name = 'Test Strain', Strain_Type__c = 'Hybrid');
        insert st;
        Brand_Discount__c bd = new Brand_Discount__c(Brand__c = acc.Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        bd = new Brand_Discount__c(Product_Name__c = products[0].Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        Contact con = [SELECT Id, Name,Primary_Contact__c,AccountId, Email FROM Contact WHERE Name = 'Test Contact1' LIMIT 1];
        con.Email = 'Testcontactat1@filigreencustomer.com';
        con.Primary_Contact__c = true;
        con.AccountId = acc.Id;
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
        
        //System.debug('##PriceBookEntries:'+[SELECT Id, PriceBook2.Name, Product2.Name FROM PriceBookEntry]);
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
        //OrderHelper.runningTrigger = true;
        Test.startTest();
        System.runAs(u){
            OrderHelper.runningTrigger = true;
            Boolean isBrand = ProductsCtlr.isBrand;
            System.debug('##ProductsCtlr.brandId::'+ProductsCtlr.brandId);
            Map<String,String> strainTypeMap = ProductsCtlr.strainTypeMap;
            //ProductsCtlr.getCategories();
            PriceBookEntry pbe = [SELECT Id FROM PriceBookEntry WHERE PriceBook2Id = :customPB.Id AND Product2Id =: products[0].Id];
            AuraResponse r = ProductsCtlr.isCommunityPlusUser();
            Map<String, Object> filters = new Map<String, Object> {'families'=>'Edibles','orderByField' =>'Product2.Name', 'isASC' => true, 'searchTerm' => 'product'};
                r = ProductsCtlr.getIds(filters);
            Set<Id> ids = (Set<Id>)r.data.get('ids');
            List<String> idsList = new List<String>();
            for(Id idStr : ids){
                idsList.add(idStr);
            }
            
            filters = new Map<String, Object> {'orderByField' =>'Product2.Name', 'isASC' => true};
                ProductsCtlr.getProducts(idsList,filters);
            r = ProductsCtlr.getRecentProducts(new Map<String,Object>());
            r = ProductsCtlr.getMostPopularProducts(new Map<String,Object>());
            r = ProductsCtlr.getRecentBrands(new Map<String,Object>());
            
            
            ProductsCtlr.AddtoCart a = new ProductsCtlr.AddtoCart();
            
            a.productId = products[0].Id;
            a.pricebookId = pbe.Id;
            a.quantity = 2;
            a.MOQ = 8;
            a.unitPrice = 10;
            a.isUpdate = false;
            a.isSample = true;
            r = ProductsCtlr.addToCart(JSON.serialize(a));
            a.isUpdate = true;
            r = ProductsCtlr.addToCart(JSON.serialize(a));
            a.productId = products[1].Id;
            a.isUpdate = false;
            a.isSample = true;
            r = ProductsCtlr.addToCart(JSON.serialize(a));
            
            List<Id> setIds = new List<Id>();
            setIds.add(pbe.Id);
            
            // Brands related - End
            String review = '{"productId":"'+products[0].Id+'", "review": "This awesome product", "rating": 4}';
            r = ProductsCtlr.saveReview(review);
            r = ProductsCtlr.notifyMe(products[0].Id);
            r = ProductsCtlr.getProductAndReviews(pbe.Id,5);
            r = ProductsCtlr.getRecentRetailers(new Map<String, Object>());
            r = ProductsCtlr.getAddresses();
            //r = ProductsCtlr.getProducts(setIds,filters);
            
            State_Licenses__c stateLicense = [SELECT Id FROM State_Licenses__c LIMIT 1];
            //r = ProductsCtlr.checkout('','',System.today(),stateLicense.Id,false);
            r = ProductsCtlr.getOrdersIds(new Map<String, Object>());
            ids = (Set<Id>)r.data.get('ids');
            idsList = new List<String>();
            
            for(Id idStr : ids){
                idsList.add(idStr);
            }
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
            
            idsList.add(o.Id);
            
            filters = new Map<String, Object> {'orderByField' =>'Name', 'isASC' => true};
            
            SendNotificationToBrandUponNewOrder.notifyOnNewRetailerOrder(new List<Id>{o.Id});
            r = ProductsCtlr.getOrders(idsList,filters);
            //ProductsCtlr.verifyProductsAvailability(s.id);
            ProductsCtlr.removeProduct(products[1].Id);
            
            ProductsCtlr.cancelOrder(idsList[0]);
            ProductsCtlr.getContactInformation();
            ProductsCtlr.Retailer wrpRetail = new ProductsCtlr.Retailer(lineCards[0]);
            ProductsCtlr.ReviewChart wrpReview = new ProductsCtlr.ReviewChart(3,4);
            ProductsCtlr.Product wrpProduct = new ProductsCtlr.Product(pbeList[0]);
            wrpProduct.setDiscountPercent(10);
            wrpProduct.setProductDiscountPercent(5);
            wrpProduct.notifyRequested(false);
            salesOrderObj = new Sales_Order__c();
            salesOrderObj = [Select Site__c,Name,
                             Customer_PO_or_Quote__c, 
                             SO_Date__c, 
                             SO_Status__c,
                             Total_Line_Items__c,
                             Total_Price__c,
                             Brand_Quote__r.Opportunity_Name__r.Order__c,
                             Brand_Quote__r.Opportunity_Name__r.Order__r.Name,
                             Brand_Quote__c,
                             Brand_Quote__r.Name,
                             Receiver_Name__c,
                             Sample_Order__c,
                             Shipping_Method__c,
                             Shipping_Terms__c,
                             Supplier_Contact__c,
                             Supplier_License__c,
                             Supplier_Name__c
                             from Sales_Order__c];
            Map<Id,Purchase_Order__c> mapPurchase = new Map<Id,Purchase_Order__c>([ select Site__c,id,PO_Status__c, PO_Type__c, Supplier_Name__c,
                                                                                  Supplier_License__c,Distributor_Name__c,Distributor_License__c,
                                                                                  Receiver_Name__c,Receiver_License__c,Ownership__c from Purchase_Order__c limit 1]);
            ProductsCtlr.SalesOrder wrpSales = new ProductsCtlr.SalesOrder(salesOrderObj,mapPurchase);
            r = ProductsCtlr.getOrdersIds(new Map<String, Object> {'orderByField' =>'Name', 'isASC' => true, 'searchTerm' => 't','status' => 'Cancelled'});
            //r = ProductsCtlr.getOrdersIds(new Map<String, Object> {'orderByField' =>'Name', 'isASC' => true, 'searchTerm' => 't','status' => 'Draft'});
            
        }
    }
    private static testmethod void testRetailersAndBrands(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        TestUtilData.skipTrigger = true;
        Site__c s = new Site__c(Name= '2089-3');
        s.Active__c =true;
        s.Sort_Order__c =1;
        insert s;
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        List<Product2> products = [SELECT Id,Hide_From_Marketplace__c,Most_Popular__c FROM Product2];
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
        acc.Business_Type__c = 'Equity Brand';
        acc.Description = 'testtesttesttesttesttesttesttesttesttesttest';
        update acc;
        
        Line_Card__c l= new Line_Card__c();
        l.Brand_Name__c=acc.id;
        l.Retailer_Name__c=acc.id;
        l.Mutual_Payment_Terms__c='COD';
        insert l;
        
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
                a.Type = 'Microbusiness';
            }else{
                a.Type = 'Retailer';
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
        objAccount.Licensed_Verticals__c = 'Cultivator';
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
        Strain__c st = new Strain__c (Name = 'Test Strain', Strain_Type__c = 'Hybrid');
        insert st;
        Brand_Discount__c bd = new Brand_Discount__c(Brand__c = acc.Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        bd = new Brand_Discount__c(Product_Name__c = products[0].Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        Contact con = [SELECT Id, Name,Primary_Contact__c,AccountId, Email FROM Contact WHERE Name = 'Test Contact1' LIMIT 1];
        con.Email = 'Testcontactat1@filigreencustomer.com';
        con.Primary_Contact__c = true;
        con.AccountId = acc.Id;
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
        //System.debug('##PriceBookEntries:'+[SELECT Id, PriceBook2.Name, Product2.Name FROM PriceBookEntry]);
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
        
        string before = 'Testing base 64 encode';            
        Blob beforeblob = Blob.valueOf(before);
        //Insert contentdocument data
        ContentVersion cv = new ContentVersion();
        cv.title = 'test content trigger';      
        cv.PathOnClient ='test';           
        cv.VersionData =beforeblob;          
        insert cv;  
        
        ContentVersion testContent = [SELECT id, ContentDocumentId FROM ContentVersion where Id = :cv.Id ];
        
        Order__c ord = new Order__c();
        ord.Order_Date__c = system.today();
        insert ord;
        
        Harvest_Batch_Code__c hbc = new Harvest_Batch_Code__c(Name='Test122',Active__c = true);
        insert hbc;
        
        UID__c uid2 = new UID__c(Name='1GGG60300005F51000003345',Active__c = true);
        insert uid2;
        
        Purchase_Order__c po = new Purchase_Order__c();
        insert po;
        
        // Create purchase order lines  
        Purchase_Order_Line__c objPOline1 = new Purchase_Order_Line__c();
        objPOline1.Purchase_Order__c = po.id;
        objPOline1.Product_Name__c= products[0].Id;
        objPOline1.Qty_Ordered__c = 10;
        objPOline1.Unit_Cost__c = 10;
        objPOline1.Harvest_Batch_Code__c = hbc.Id;
        insert objPOline1;
        
        Shipping_Manifest__c sm = new Shipping_Manifest__c();
        sm.Purchase_Order__c = po.id;
        insert sm; 
        
        
        Shipping_Manifest_Line__c smLine = new Shipping_Manifest_Line__c();
        smLine.Product_Name__c	= products[0].Id;
        smLine.Shipment_Qty__c = 2;
        smLine.Shipping_Manifest__c = sm.Id;
        insert smLine;
        
        ContentDocumentLink newFileShare = new ContentDocumentLink();
        newFileShare.contentdocumentid = testContent.contentdocumentid;
        newFileShare.LinkedEntityId = sm.Id;
        newFileShare.ShareType= 'V';
        insert newFileShare;
        
        //OrderHelper.runningTrigger = true;
        
        System.runAs(u){
            
            Holiday h = new Holiday();
            h.ActivityDate = system.today().addMonths(2);
            h.Name = 'Test Holiday';
            insert h;
            
            ProductsCtlr.brandId = con.AccountId;
            Map<String, Object>  filters = new Map<String, Object> {'orderByField' =>'DBA__c', 'isASC' => true,'searchTerm'=>'test'};
            AuraResponse r = ProductsCtlr.getRetailerIds(filters);
            List<String> idsList = (List<String>)r.data.get('ids');
            r = ProductsCtlr.getRetailers(idsList,filters);
            String retailerId = idsList[0];
            r = ProductsCtlr.getRetailer(idsList[0]);
            // Brands related - Start
            filters.put('orderByField', 'DBA__c');
            
            AuraResponse res = ProductsCtlr.getBrandIds(filters);
            ProductsCtlr.getBrands((List<String>)res.data.get('ids'), filters);
            res = ProductsCtlr.getBrand(((List<String>)res.data.get('ids'))[0]);
            
            ProductsCtlr.Brand b = (ProductsCtlr.Brand) res.data.get('brand');
            filters.put('searchTerm', b.name);
            ProductsCtlr.getBrandIds(filters);
            ProductsCtlr.getRecords('Strain__c','Test','');
            ProductsCtlr.getLicenseeAccounts('Test','');
            r = ProductsCtlr.addLineCardInit(retailerId,'',true);
            ProductsCtlr.LineCard lineCard = (ProductsCtlr.LineCard)r.data.get('lineCard');
            lineCard.brandAccountRating = 'Standard';
            lineCard.mutualPaymentTerms = 'COD';
            lineCard.retailAccountRating = 'Standard';
            ProductsCtlr.addLineCardSave(JSON.serialize(lineCard));
            List<String> values = new List<String>();
            
            list<String>filterList = new List<String>();
            filterList.add('1');
            filters.put('order',filterList);
            ProductsCtlr.getValues(filters,'order',values);
            
            List<Integer> values1 = new List<Integer>();
            ProductsCtlr.getValues(filters,'order',values1);
            
            ProductsCtlr.hasListFilter(filters,'order');
            
            ProductsCtlr.getCategories();
            
            //ProductsCtlr.updateRMA();
            
            
            Returns__c ret = new Returns__c();
            ret.Shipping_Manifest__c = sm.id;
            insert ret;
            
            Return_Line__c retLine = new Return_Line__c(Return__c = ret.Id,Shipping_Manifest_Line__c = smLine.Id);
            insert retLine;
            
            sm.Order_Number__c = ord.id;
            update sm;
            
            ProductsCtlr.RMAInit(ret.id);
            
            ProductsCtlr.cancelRMA(ret.id);
            
            ProductsCtlr.getRMADetails(ret.id);
            
            ProductsCtlr.getRetailOrderForReturn(ord.id);
            
            //ProductsCtlr.getContactInformation();
            
            //ProductsCtlr.cancelOrder(ord.id);
            
            ProductsCtlr.verifyProductsAvailability(s.id);
            
            try{
                ProductsCtlr.approveRMAAndCreateOpp(ret.id);
            } catch(Exception ex){}
            
            //ProductsCtlr.checkout()
            //ProductsCtlr.saveRMARequest();
            //ProductsCtlr.updateRMA('',JSON.serialize(retLine));
        }
    }
    private static testmethod void runProductCtrl(){
        TestUtilData.skipTrigger = true;
        
        Account[] rAccounts = new Account[]{};
            Account objAccount = new Account();
        objAccount.Name = 'Test Microbusiness';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Type = 'Microbusiness';
        objAccount.Licensed_Verticals__c = 'Cultivator';
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
        insert objAccount;
            
        Contact con = new Contact();
        con.firstname ='test';
        con.lastname ='test';
        con.AccountId = objAccount.id;
        insert con;
        
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
        
        system.runAs(u){
            Test.startTest();
            list<Holiday>holidayList = new List<Holiday>();
        	Holiday h1 = new Holiday();
            h1.ActivityDate = system.today().addMonths(2);
            h1.Name = 'test 1';
            h1.RecurrenceType = 'RecursYearly';
            h1.IsRecurrence = true;
            h1.RecurrenceStartDate = system.today().addMonths(2);
            h1.RecurrenceDayOfMonth = 5;
            h1.RecurrenceMonthOfYear = 'July';
            holidayList.add(h1);
            
            Holiday h2 = new Holiday();
            h2.ActivityDate = system.today().addMonths(2);
            h2.Name = 'test 2';
            h2.RecurrenceType = 'RecursMonthly';
            h2.IsRecurrence = true;
            h2.RecurrenceStartDate = system.today().addMonths(2);
            h2.RecurrenceInterval = 3;
            h2.RecurrenceDayOfMonth = 5;
            holidayList.add(h2);
        
        	insert holidayList;
            
            Order__c ord= new Order__c();
            ord.Status__c='Draft';
            ord.Order_Date__c=Date.today();
            ord.Customer__c = u.Id;
            ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
            insert ord;
            
            Product2  objProduct1 = new Product2 ();
            objProduct1.Name = 'product 8';
            objProduct1.Family = 'Edibles';
            objProduct1.Description = 'test product 1';
            //    objProduct1.Producer_Name__c = objAccount.id;
            objProduct1.Apply_Cultivation_Tax__c='Yes';
            objProduct1.Apply_Excise_Tax__c='Yes';
            objProduct1.IsActive = true;
            objProduct1.Unit_Height__c  = 10.0;
            objProduct1.Unit_Length__c = 10.0;
            objProduct1.Unit_Width__c = 5.0;
            objProduct1.Quantity_Type__c = 'Quantity';
            insert objProduct1;
            
            
            // Create price book entry for first product
            PricebookEntry pbe = new PricebookEntry(Pricebook2Id=Test.getStandardPricebookId(), Product2Id=objProduct1.Id, UnitPrice=99, isActive=true);
            insert pbe;
            
            Order_Line_Item__c ol= new Order_Line_Item__c();
            ol.Price_Book_Entry_Id__c=Id.valueOf(pbe.id);
            ol.UnitPrice__c=10;
            ol.MOQ__c=4;
            ol.Quantity_Cases__c=2;
            ol.Order__c=ord.id;
            ol.Product__c = objProduct1.id;
            insert ol;
            
            Test.stopTest();
        	ProductsCtlr.getCartItems(); 
            ProductsCtlr.getMonthNumber('January');
            ProductsCtlr.getMonthNumber('February');
            ProductsCtlr.getMonthNumber('March');
            ProductsCtlr.getMonthNumber('April');
            ProductsCtlr.getMonthNumber('May');
            ProductsCtlr.getMonthNumber('June');
            ProductsCtlr.getMonthNumber('July');
            ProductsCtlr.getMonthNumber('August');
            ProductsCtlr.getMonthNumber('September');
            ProductsCtlr.getMonthNumber('October');
            ProductsCtlr.getMonthNumber('November');
            ProductsCtlr.getMonthNumber('December');
            ProductsCtlr.getHolidayDate(system.today(),holidayList[0]);
            ProductsCtlr.getHolidayDate(system.today(),holidayList[1]);
            //ProductsCtlr.getTrainingVideos();
        }
        
         
    }
    private static testmethod void runProfileCtrl3(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        OrderHelper.runningTrigger =true;
        Site__c s = new Site__c(Name= '2089-3');
        insert s;
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        List<Product2> products = [SELECT Id,Hide_From_Marketplace__c,Most_Popular__c FROM Product2];
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
                a.Type = 'Microbusiness';
            }else{
                a.Type = 'Retailer';
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
        objAccount.Licensed_Verticals__c = 'Cultivator';
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
        Strain__c st = new Strain__c (Name = 'Test Strain', Strain_Type__c = 'Hybrid');
        insert st;
        Brand_Discount__c bd = new Brand_Discount__c(Brand__c = acc.Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        bd = new Brand_Discount__c(Product_Name__c = products[0].Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        Contact con = [SELECT Id, Name,Primary_Contact__c,AccountId, Email FROM Contact WHERE Name = 'Test Contact1' LIMIT 1];
        con.Email = 'Testcontactat1@filigreencustomer.com';
        con.Primary_Contact__c = true;
        con.AccountId = rAccounts[0].Id;
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
        //System.debug('##PriceBookEntries:'+[SELECT Id, PriceBook2.Name, Product2.Name FROM PriceBookEntry]);
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
        RecordType rt= [SELECT id FROM RecordType WHERE Name='Retailer'];
        Order__c o =new Order__c();
        o.Account__c=acc.id;
        o.Status__c='Draft';
       	o.RecordTypeId =rt.Id;
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
        oli.Price_Book_Entry_Id__c=pbeList[1].id;
        insert oli;  
        
        
        //OrderHelper.runningTrigger = true;
        
        System.runAs(u){
            
            o.Customer__c = u.Id;
            update o;
            
            ProductsCtlr.brandId = con.AccountId;
            AuraResponse r = ProductsCtlr.newProductInit(products[0].Id,'False');
            ProductsCtlr.Product pr = (ProductsCtlr.Product)r.data.get('product');
            //ProductsCtlr.saveNewProduct(products[0].Id,JSON.serialize(pr));
            Map<String, Object> filters = new Map<String, Object>();
            r = ProductsCtlr.getNewProductRequestIds(filters);
            filters.put('orderByField','Name');
            filters.put('isASC','false');
            filters.put('searchTerm','test');
            filters.put('families','false');
            r = ProductsCtlr.getNewProductRequestIds(filters);
            List<String> pids = (List<String>)r.data.get('ids');
            r = ProductsCtlr.getNewProductRequests(pids,new Map<String, Object>());
            r = ProductsCtlr.getNewProductRequests(pids,filters);
            State_Licenses__c stateLicense = [SELECT Id FROM State_Licenses__c LIMIT 1];
            
            Product2 prod = products[0];
            prod.Name = 'Retail-MOV-Fee';
            update prod;
            
            Pricebook2 standardPricebook = new Pricebook2(Id = Test.getStandardPricebookId(), IsActive = true);
            Update standardPricebook;
            
            PricebookEntry pbe = [SELECT Id,Product2Id,Product2.Id,Pricebook2Id FROM PricebookEntry WHERE Pricebook2Id =: standardPricebook.Id LIMIT 1];
            pbe.Product2.Id = prod.Id;
            update pbe;
            
            ProductsCtlr.checkout(String.valueOf(rAccounts[0].Id),String.valueOf(con.Id),Date.today(),stateLicense.Id,true,null,null);
           
        }
    }
    private static testmethod void runProfileCtrl2(){
      //  retrieveData();
      	Test.startTest();
     	TestUtilData.skipTrigger = true;
        Site__c s = new Site__c(Name= '2089-3');
        insert s;
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        List<Product2> products = [SELECT Id,Hide_From_Marketplace__c,Most_Popular__c FROM Product2];
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
        Contact con = [SELECT Id, Name,Primary_Contact__c,AccountId, Email FROM Contact WHERE Name = 'Test Contact1' LIMIT 1];
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
     	RecordType rt= [SELECT id FROM RecordType WHERE Name='Retailer'];
        Order__c o =new Order__c();
        o.Account__c=acc.id;
        o.Status__c='Approved';
       	o.RecordTypeId =rt.Id;
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
        oli.Price_Book_Entry_Id__c=pbeList[1].id;
        insert oli;   
     
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
        CheckManifestRecursion.run = false;
        ShippingManifestLineTriggerHandler.isSMCancelled = true;
        // Create RSM data
        List<Shipping_Manifest__c> rsmList = new List<Shipping_Manifest__c>();
        
        string before = 'Testing base 64 encode';            
        Blob beforeblob = Blob.valueOf(before);
        //Insert contentdocument data
        ContentVersion cv = new ContentVersion();
        cv.title = 'test content trigger';      
        cv.PathOnClient ='test';           
        cv.VersionData =beforeblob;          
        insert cv;         
        
        ContentVersion testContent = [SELECT id, ContentDocumentId FROM ContentVersion where Id = :cv.Id];
        
        ContentDocumentLink newFileShare = new ContentDocumentLink();
        newFileShare.contentdocumentid = testcontent.contentdocumentid;
        //newFileShare.LinkedEntityId = cImages[0].Id;
        newFileShare.ShareType= 'V';
        
     
     AuraResponse bpRes = ProductsCtlr.getBrandProductIds(acc.id,new Map<String, Object> {'orderByField' =>'Name', 'isASC' => true});
     Set<Id> ids = (Set<Id>)bpRes.data.get('ids');
     List<String> idsList = new List<String>();
     for(Id idStr : ids){
         idsList.add(idStr);
     }
     Map<String, Object> filters2 = new Map<String, Object> {'orderByField' =>'Name', 'isASC' => true,'searchTerm'=>''};
     ProductsCtlr.getBrandProducts(idsList,filters2);
     
     bpRes = ProductsCtlr.getBrandContactIds(acc.id,filters2);
     ids = (Set<Id>)bpRes.data.get('ids');
     idsList = new List<String>();
     for(Id idStr : ids){
         idsList.add(idStr);
     }
     ProductsCtlr.getBrandContacts(idsList,filters2);
     ProductsCtlr.getContacts(acc.id);
     bpRes = ProductsCtlr.getBrandOrderIds(acc.id,filters2);
     Test.stopTest();
      
    }
    private static testmethod void runProfileCtrl4(){
      //  retrieveData();
      	Test.startTest();
        TestUtilData.skipTrigger = true;
        Site__c s = new Site__c(Name= '2089-3');
        insert s;
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        List<Product2> products = [SELECT Id,Hide_From_Marketplace__c,Most_Popular__c FROM Product2];
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
        Contact con = [SELECT Id, Name,Primary_Contact__c,AccountId, Email FROM Contact WHERE Name = 'Test Contact1' LIMIT 1];
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
     	RecordType rt= [SELECT id FROM RecordType WHERE Name='Retailer'];
        Order__c o =new Order__c();
        o.Account__c=acc.id;
        o.Status__c='Approved';
       	o.RecordTypeId =rt.Id;
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
        oli.Price_Book_Entry_Id__c=pbeList[1].id;
        insert oli;   
     
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
        CheckManifestRecursion.run = false;
        ShippingManifestLineTriggerHandler.isSMCancelled = true;
        // Create RSM data
        List<Shipping_Manifest__c> rsmList = new List<Shipping_Manifest__c>();
        
        string before = 'Testing base 64 encode';            
        Blob beforeblob = Blob.valueOf(before);
        //Insert contentdocument data
        ContentVersion cv = new ContentVersion();
        cv.title = 'test content trigger';      
        cv.PathOnClient ='test';           
        cv.VersionData =beforeblob;          
        insert cv;         
        
        ContentVersion testContent = [SELECT id, ContentDocumentId FROM ContentVersion where Id = :cv.Id];
        
        ContentDocumentLink newFileShare = new ContentDocumentLink();
        newFileShare.contentdocumentid = testcontent.contentdocumentid;
        //newFileShare.LinkedEntityId = cImages[0].Id;
        newFileShare.ShareType= 'V';
        
        
        AuraResponse bpRes = ProductsCtlr.getBrandProductIds(acc.id,new Map<String, Object> {'orderByField' =>'Name', 'isASC' => true});
        Set<Id> ids = (Set<Id>)bpRes.data.get('ids');
        List<String> idsList = new List<String>();
        for(Id idStr : ids){
            idsList.add(idStr);
        }
        Map<String, Object> filters2 = new Map<String, Object> {'orderByField' =>'Name', 'isASC' => true,'searchTerm'=>''};
            ProductsCtlr.getBrandProducts(idsList,filters2);
        
        bpRes = ProductsCtlr.getBrandContactIds(acc.id,filters2);
        ids = (Set<Id>)bpRes.data.get('ids');
        idsList = new List<String>();
        bpRes = ProductsCtlr.getBrandRetailerOrderIds(acc.id,filters2);
        ids = (Set<Id>)bpRes.data.get('ids');
        idsList = new List<String>();
        for(Id idStr : ids){
            idsList.add(idStr);
        }
        ProductsCtlr.getBrandRetailerOrders(idsList,filters2);
        
        Test.stopTest();
        
    }
}