@IsTest 
private class ProductsCtlrTest2 {
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
        Metrc_Utility.IS_PROD_TRIGGER_ENABLED = false;
        SOlineTriggerHandler.isRecursion = true;
        //ProductsCtlr.skipTrigger = true;
        TestUtilData.createTestData();
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        TestUtilData.skipTrigger = true;
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
        // Create Driver
        driverObj = TestUtilData.createDriver(false);
        driverObj.Name = UserInfo.getName();
        insert driverObj;
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
            soLines[0].Status__c = 'Allocated';
        }
        //update soLines;
        
        soLines[0].Status__c = 'Open';
        //update soLines[0];
        // Update SO lines in Inventory positions
        for(Integer i=0; i<invPositions.size(); i++){
            invPositions[i].Inventory_Location__c = racks[0].Inventory_Location__c;
            invPositions[i].Sales_Order_Line__c = soLines[i].Id;
            invPositions[i].Rack__c = racks[0].Id;
            invPositions[i].Rack_Level__c = rackLevels[0].Id;
            invPositions[i].Bin_Location__c = binLocations[0].Id;
        }
        //update invPositions;
        
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        /*pickListObj = [Select Site__c,
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
                       from Picklist__c];*/
        
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, 'Open', true);
        /*picklistLines = [Select Product_Name__c,
                         Sales_Order_Line__r.Product_Name__c,
                         Sales_Order_Line__r.Product_Title__c,
                         Sales_Order_Line__r.Qty_Allocated__c,
                         Sales_Order_Line__r.Retail_Wholesale_Price__c,
                         Sales_Order_Line__r.UID__c,
                         Inventory_Location__c
                         From Picklist_Line__c];*/
        
        
    }
    private static testmethod void runProfileCtrl2(){
        Metrc_Utility.IS_PROD_TRIGGER_ENABLED = false;
        retrieveData();
        Test.startTest();
        TestUtilData.skipTrigger = true;
        Site__c s = new Site__c(Name= '2089-3');
        insert s;
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        List<Product2> products = [SELECT MSRP__c,Id, Status__c,Name,Description,Product_Details__c,Family,Quantity_Type__c,Cultivation_Type__c,IsActive,
                                   Apply_Cultivation_Tax__c,Apply_Excise_Tax__c,Producer_Name__c,Producer_Name__r.Name,Cannabis_Category_1__c,
                                   Cannabis_Category_2__c ,Unit_Cannabis_Weight_1__c,Cannabis_Ratio_1__c,Unit_Cannabis_Weight_2__c,
                                   Cannabis_Ratio_2__c,Unit_Cultivation_Tax_1__c,Retail_Unit_Form_Factor__c,
                                   Unit_Height__c,Stocking_UOM__c,Unit_Width__c,Unit_Net_Weight__c,Unit_Length__c,
                                   Unit_Gross_Weight__c,Unit_Radius__c,Case_Height__c,Supplier_UOM__c,Case_Width__c,
                                   MOQ__c,Case_Length__c,Carton_Net_Weight__c,Case_Radius__c,Carton_Gross_Weight__c,
                                   THC_Amount__c,THC_MG_G__c,CDB_Amount__c,CBD_MG_G__c,Terpene_percent__c,Alpha_Bisabolol__c,
                                   Delta_3_Carene__c,Alpha_Pinene__c,Eucalyptol__c,Beta_Pinene__c,Limonene_percent__c,
                                   Borneol__c,Linalool__c,Caryophyllene__c,Myrcene__c,Camphene__c,Terpineol__c,
                                   Lead_Time__c,Reorder_Point__c,Safety_Stock_Qty__c,Enable_Replenishment_Alert__c,
                                   Safety_Stock_Low__c,Safety_Stock_Medium__c,Strain__c,Strain__r.Name,Strain_Type__c,
                                   Safety_Stock_Contact_Name__c,Safety_Stock_Contact_Name__r.Name,Fulfilled_by_Filigreen__c,
                                   Certifications__c, Appellation__c,Product_Short_Description__c,Brand_Name__c,Image_URL__c,Available_Qty__c
                                   FROM Product2];
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
        Shipping_Manifest__c rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Driver__c = driverObj.Id;
        
        Shipping_Manifest__c rsmObj1 = TestUtilData.createRSM(pickListObj, false);
        rsmObj1.Driver__c = driverObj.Id;
        
        rsmList.add(rsmObj);
        rsmList.add(rsmObj1);
        insert rsmList;
        
        List<Shipping_Manifest_Line__c> rsmLines = new List<Shipping_Manifest_Line__c>();
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj.Id, false);
        rsmLineObj.Sales_Order_Line__c = soLines[0].Id;
        rsmLineObj.Shipment_Qty__c = 10.0;
        rsmLines.add(rsmLineObj);
        
        Shipping_Manifest_Line__c rsmLineObj1 = TestUtilData.createRSMLine(pickListLines[1], rsmObj.Id, false);
        rsmLineObj1.Sales_Order_Line__c = soLines[1].Id;
        rsmLineObj1.Shipment_Qty__c = 10.0;
        rsmLines.add(rsmLineObj1);
        
        Shipping_Manifest_Line__c rsmLineObj2 = TestUtilData.createRSMLine(pickListLines[2], rsmObj.Id, false);
        rsmLineObj2.Sales_Order_Line__c = soLines[2].Id;
        rsmLineObj2.Shipment_Qty__c = 10.0;
        rsmLines.add(rsmLineObj2);
        insert rsmLines;
        Compliance_Images__c[] cImages = new Compliance_Images__c[]{};
            //Shipping_Manifest_Line__c[] SMLList = [SELECT Id, Harvest_Batch_Code__c  ,UID_1__c,Product_Name__c FROM Shipping_Manifest_Line__c  WHERE Shipping_Manifest__c = :rsmObj.Id];
        for(Shipping_Manifest_Line__c SML: rsmLines){
            cImages.add(new Compliance_Images__c(COA_Issued_Date__c = System.today(), Lab_Test_Status__c = 'Passed',Product__c= SML.Product_Name__c,Batch_ID__c = SML.Harvest_Batch_Code__c,UID__c = SML.UID_1__c));
        }
        insert cImages;
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
        newFileShare.LinkedEntityId = cImages[0].Id;
        newFileShare.ShareType= 'V';
        insert newFileShare;
        
        Case myCase= new Case(Subject='Test12', Description='Test32');
        insert myCase;
        
        ProductsCtlr.caseAttachment caseAttach = new ProductsCtlr.caseAttachment();
        ProductsCtlr.caseAttachment caseAttach2 = new ProductsCtlr.caseAttachment(myCase,newFileShare,true);
        
        //OrderHelper.runningTrigger = true;
        System.runAs(u){
            
            ProductsCtlr.brandId = con.AccountId;
            OrderHelper.runningTrigger = true;
            Boolean isBrand = ProductsCtlr.isBrand;
            Map<String,String> strainTypeMap = ProductsCtlr.strainTypeMap;
            ProductsCtlr.getCategories();
            //AuraResponse r = ProductsCtlr.isCommunityPlusUser();
            Map<String, Object> filters = new Map<String, Object> {'families'=>'Edibles','orderByField' =>'Product2.Name', 'isASC' => true, 'searchTerm' => 'product'};
            AuraResponse r = ProductsCtlr.getIds(filters);
            Set<Id> ids = (Set<Id>)r.data.get('ids');
            List<String> idsList = new List<String>();
            for(Id idStr : ids){
                idsList.add(idStr);
            }
            
            filters = new Map<String, Object> {'orderByField' =>'Product2.Name', 'isASC' => true};
                ProductsCtlr.getProducts(idsList,filters);
            PriceBookEntry pbe = [SELECT Id FROM PriceBookEntry WHERE PriceBook2Id = :customPB.Id AND Product2Id =: products[0].Id];
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
            
            filters = new Map<String, Object> {'orderByField' =>'DBA__c', 'isASC' => true,'searchTerm'=>'test','retailerFilter'=>'My Retailers'};
                r = ProductsCtlr.getRetailerIds(filters);
            idsList = (List<String>)r.data.get('ids');
                        
            State_Licenses__c stateLicense = [SELECT Id FROM State_Licenses__c LIMIT 1];
            
            ContentDocumentLink newFileShare2 = new ContentDocumentLink();
            newFileShare2.contentdocumentid = testContent.contentdocumentid;
            newFileShare2.LinkedEntityId = stateLicense.Id;
            newFileShare2.ShareType= 'V';
            insert newFileShare2;
            
            try{
                r = ProductsCtlr.getOrdersIds(new Map<String, Object>());
                ids = (Set<Id>)r.data.get('ids');
                idsList = new List<String>();
                
                for(Id idStr : ids){
                    idsList.add(idStr);
                }
                if(idsList.size() > 0){
                    String ordId = idsList[0];
                    rsmObj.Order_Number__c = ordId;
                    update rsmObj;
                    ProductsCtlr.getRetailOrder(ordId);
                    r = ProductsCtlr.getRetailOrderForReturn(ordId);
                }
                
                ProductsCtlr.Order o = (ProductsCtlr.Order)r.data.get('retailOrder');
                ProductsCtlr.OrderLineItem [] returnItems = new ProductsCtlr.OrderLineItem[]{};
                    if(o != null && o.items != null){
                        for(ProductsCtlr.OrderLineItem oli : o.items){
                            oli.returnCode = 'Product Cosmetic Damage';
                            oli.rquantity = 1;
                            oli.additionalNotes = 'Test';
                            oli.SMLineId = rsmLineObj.Id;
                            returnItems.add(oli);
                        }
                    }
                
                if(idsList.size() > 0)
                    ProductsCtlr.saveRMARequest(idsList[0],rsmObj.Id,JSON.serialize(returnItems));
                Returns__c[] rRecs = [SELECT Id FROM Returns__c];
                
                if(rRecs.size() > 0){
                    ProductsCtlr.approveRMAAndCreateOpp(rRecs[0].Id);
                    r = ProductsCtlr.getRMADetails(rRecs[0].Id);
                }
                
                Set<String> hybridPriceBooks = Utility.hybridPriceBooks;
                Utility.hasAccepted();
                Utility.init();
                Utility.getPicklistItems('Account','Type');
                //Utility.logout();
                //FiligreenProductsCtrl Class coverage
                r = FiligreenProductsCtrl.getCategories();
                r = FiligreenProductsCtrl.getIds(new Map<String, Object> {'orderByField' =>'Product2.Name', 'isASC' => true});
                ids = (Set<Id>)r.data.get('ids');
                idsList = new List<String>();
                for(Id idStr : ids){
                    idsList.add(idStr);
                }
                
                filters = new Map<String, Object> {'orderByField' =>'Name', 'isASC' => true};
                    r = ProductsCtlr.getBrandLicenseIds(acc.id,filters);
                ids = (Set<Id>)r.data.get('ids');
                idsList = new List<String>();
                for(Id idStr : ids){
                    idsList.add(idStr);
                }
                ProductsCtlr.getBrandLicense(idsList,filters);
                r = ProductsCtlr.getretailerInsightIds(acc.id,filters);
                ids = (Set<Id>)r.data.get('ids');
                idsList = new List<String>();
                for(Id idStr : ids){
                    idsList.add(idStr);
                }
                ProductsCtlr.getretailerInsights(idsList,filters);
                
                r = ProductsCtlr.getBrandContactIds(acc.id,filters);
                ids = (Set<Id>)r.data.get('ids');
                idsList = new List<String>();
                for(Id idStr : ids){
                    idsList.add(idStr);
                }
                Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,Default_Distributor__c  = acc.Id,Default_License__c = stateLicense.Id,LateFee__c = 0.020,Route_Origin_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US',Route_Destination_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US');
                insert ccs;
                
                ProductsCtlr.getBrandContacts(idsList,filters);
                ProductsCtlr.filigreenThemeInit();
                ProductsCtlr.getCategories();
                ProductsCtlr.getCaseCategories();
                string strig ='';
                ProductsCtlr.globalSearch(strig);
                
                Strain__c st = new Strain__c();
                insert st;
                
                ProductsCtlr.getStrainDetails(st.id);
                ProductsCtlr.Product testProduct = new ProductsCtlr.Product();
                testProduct.discount = 10;
                testProduct.productDiscount = 10;
                testProduct.salePrice = 10;
                testProduct.addistionalDiscount = 10;
                
                Product2 tProduct = products[0];
                tProduct.Cannabis_Category_1__c = 'Fresh';
                testProduct = new ProductsCtlr.Product(tProduct);
                
                tProduct.Cannabis_Category_1__c = 'Leaves';
                testProduct = new ProductsCtlr.Product(tProduct);
                
                tProduct.Cannabis_Category_1__c = 'Flower';
                testProduct = new ProductsCtlr.Product(tProduct);
                
                tProduct.Cannabis_Category_2__c = 'Leaves';
                testProduct = new ProductsCtlr.Product(tProduct);
                ProductsCtlr.getContacts(rAccounts[0].Id);
                
                List<String> proIds = new List<String>();
                proIds.add(pbe.Id);
                ProductsCtlr.getProducts(proIds,filters);
                
                //r = ProductsCtlr.checkout(rAccounts[0].Id,'',null,stateLicense.Id,false,'','');
                
                //AuraResponse response = ProductsCtlr.newProductInit(products[0].Id);
                //ProductsCtlr.saveNewProduct(products[0].Id,JSON.serialize(testProduct));
                // r = FiligreenProductsCtrl.getProducts(idsList,filters);
                //r = FiligreenProductsCtrl.getProductAndReviews(pbe.Id,5);
                //r = FiligreenProductsCtrl.getRecentProducts(new Map<String,Object>());
                Test.stopTest();
            } catch(Exception ex){ }
        }
    }
    
    
    private static testmethod void runProfileCtrl3(){
        TestUtilData.skipTrigger = true;
        retrieveData();
        
        Test.startTest();
        List<Product2> products = [SELECT MSRP__c,Id, Status__c,Name,Description,Product_Details__c,Family,Quantity_Type__c,Cultivation_Type__c,IsActive,
                                   Apply_Cultivation_Tax__c,Apply_Excise_Tax__c,Producer_Name__c,Producer_Name__r.Name,Cannabis_Category_1__c,
                                   Cannabis_Category_2__c ,Unit_Cannabis_Weight_1__c,Cannabis_Ratio_1__c,Unit_Cannabis_Weight_2__c,
                                   Cannabis_Ratio_2__c,Unit_Cultivation_Tax_1__c,Retail_Unit_Form_Factor__c,
                                   Unit_Height__c,Stocking_UOM__c,Unit_Width__c,Unit_Net_Weight__c,Unit_Length__c,
                                   Unit_Gross_Weight__c,Unit_Radius__c,Case_Height__c,Supplier_UOM__c,Case_Width__c,
                                   MOQ__c,Case_Length__c,Carton_Net_Weight__c,Case_Radius__c,Carton_Gross_Weight__c,
                                   THC_Amount__c,THC_MG_G__c,CDB_Amount__c,CBD_MG_G__c,Terpene_percent__c,Alpha_Bisabolol__c,
                                   Delta_3_Carene__c,Alpha_Pinene__c,Eucalyptol__c,Beta_Pinene__c,Limonene_percent__c,
                                   Borneol__c,Linalool__c,Caryophyllene__c,Myrcene__c,Camphene__c,Terpineol__c,
                                   Lead_Time__c,Reorder_Point__c,Safety_Stock_Qty__c,Enable_Replenishment_Alert__c,
                                   Safety_Stock_Low__c,Safety_Stock_Medium__c,Strain__c,Strain__r.Name,Strain_Type__c,
                                   Safety_Stock_Contact_Name__c,Safety_Stock_Contact_Name__r.Name,Fulfilled_by_Filigreen__c,
                                   Certifications__c, Appellation__c,Product_Short_Description__c,Brand_Name__c,Image_URL__c,Available_Qty__c
                                   FROM Product2];
        
        ProductsCtlr.Product testProduct = new ProductsCtlr.Product();
        products[0].Name = 'Test2';
        try{
            ProductsCtlr.saveNewProduct(products[0].Id,JSON.serialize(testProduct));
        } catch(Exception ex){}
    }
    
    private static testmethod void runProfileCtrl4(){
        Test.startTest();
        try{
            ProductsCtlr.BrandCartItem brCrtItem = new ProductsCtlr.BrandCartItem();
            brCrtItem.id = 'test';
            brCrtItem.name = 'test';
            brCrtItem.imageUrl = 'test';
            brCrtItem.brandName = 'test';
            brCrtItem.brandId = 'test';
            brCrtItem.priceBookId = 'test';
            brCrtItem.shortDesc = 'test';
            brCrtItem.productName = 'test';
            brCrtItem.specialInstructions = 'test';
            brCrtItem.applyExciseTax = 'test';
            brCrtItem.MOQ = 10;
            brCrtItem.unitPrice = 10;
            brCrtItem.availableQty = 10;
            brCrtItem.lineTotalQty = 10;
            brCrtItem.quantity = 10;
            brCrtItem.isSample = true;
            ProductsCtlr.getShortURL('https://www.google.com','testDemo');
            
        } catch(Exception ex){}
        Test.stopTest();
    }
}