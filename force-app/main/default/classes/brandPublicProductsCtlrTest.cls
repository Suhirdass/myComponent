@IsTest 
public class brandPublicProductsCtlrTest {
    static Account acc;
    Static Account[] accs;
    Static List<PricebookEntry> pbeList;
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
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        List<Product2> products = [SELECT MSRP__c,White_Labelled__c,Id,Out_of_stock_product__c, Status__c,Name,Description,Product_Details__c,Family,Quantity_Type__c,Cultivation_Type__c,IsActive,
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
                                   Certifications__c,Available_Inventory__c,Total_Order_Qty__c, Appellation__c,Product_Short_Description__c,Brand_Name__c,Image_URL__c,Available_Qty__c
                                   FROM Product2];
        products[0].Hide_From_Marketplace__c = false;
        products[0].Most_Popular__c = true;
        products[0].Available_Inventory__c = 10;
        products[0].Is_Sample__c=false;
        update products[0];
        products[1].Hide_From_Marketplace__c = false;
        products[1].Most_Popular__c = true;
        products[1].Available_Inventory__c = 10;
        products[1].Is_Sample__c=false;
        products[1].Parent_Product__c = products[0].Id;
        update products[1];
        
        acc = [SELECT Id, Name,dBA__c,Community_Price_Book__c, Type FROM Account WHERE Name = 'Test Account1' LIMIT 1];
        acc.Type = 'Distributor';
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        acc.Community_Price_Book__c = customPB.Id;
        acc.Hide_From_Marketplace__c = false;
        update acc;
        accs = [SELECT Id, Name,dBA__c,Community_Price_Book__c, Type FROM Account WHERE Id != :acc.Id];
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
        Drivers__c driverObj = TestUtilData.createDriver(false);
        driverObj.Name = UserInfo.getName();
        insert driverObj;
        Sales_Order__c salesOrderObj = [Select Site__c,
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
        List<Inventory_Position__c> invPositions = [Select Sales_Order_Line__c,
                        Sales_Order_Line__r.Product_Name__c,
                        Inventory_Location__r.Name,
                        Inventory_Location__c,
                        Rack__c,
                        Rack_Level__c,
                        Bin_Location__c
                        From Inventory_Position__c];
        List<Sales_Order_Line__c> soLines = [Select Id, Status__c, Brand_Quote_Line__c from Sales_Order_Line__c];
        PickList__c pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        List<PickList_Line__c> pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, 'Open', true);
        Shipping_Manifest__c rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Driver__c = driverObj.Id;
        insert rsmObj;
        Shipping_Manifest_Line__c rsmLineObj = TestUtilData.createRSMLine(pickListLines[0], rsmObj.Id, false);
        rsmLineObj.Sales_Order_Line__c = soLines[0].Id;
        rsmLineObj.Shipment_Qty__c = 10.0;
        Compliance_Images__c comImg =new Compliance_Images__c(COA_Issued_Date__c = System.today(), Lab_Test_Status__c = 'Passed',Product__c= rsmLineObj.Product_Name__c,Batch_ID__c = rsmLineObj.Harvest_Batch_Code__c,UID__c = rsmLineObj.UID_1__c);
        
        Id pricebookId = Test.getStandardPricebookId();
        pbeList = new List<PricebookEntry>();
        Map<String,PriceBookEntry> pbeMap = new Map<String,PriceBookEntry>();
        for(PriceBookEntry pbe: [SELECT Id, PriceBook2Id, Product2Id FROM PriceBookEntry]){
            pbeMap.put(pbe.PriceBook2Id+'-'+pbe.Product2Id,pbe);
        }
        for(Product2 p: products){
            p.MOQ__c = 1;
            p.Available_Inventory__c =10;
            p.Total_Order_Qty__c=3;
            p.Producer_Name__c = acc.Id;
            p.Product_Rating__c = 0;
            p.Status__c='Draft';
            p.White_Labelled__c=false;
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
    }
    private static testmethod void TestRun() {
        retrieveData();
        
        Test.startTest();
        try{
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
            newFileShare2.LinkedEntityId = stateLicense.Id;
            newFileShare2.ShareType= 'V';
            insert newFileShare2;
            
            Test.setMock(HttpCalloutMock.class, new ShortenURLMockTest());
            Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,Default_Distributor__c  = acc.Id,Default_License__c = stateLicense.Id,LateFee__c = 0.020,Route_Origin_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US',Route_Destination_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US');
            insert ccs;
            
            brandPublicProductsCtlr.getCategories();
            brandPublicProductsCtlr.getBrandPriceBooks(accs[0].Id);
            brandPublicProductsCtlr.getShortURL('https://www.google.com');
            
        }catch(Exception ex){}
         Test.stopTest();
    }
    private static testmethod void TestRun2(){
        TestUtilData.skipTrigger = true;
        Product_Categories__c prodCat = new Product_Categories__c();
            prodCat.Icon_Name__c = 'test';
            prodCat.Name = 'test';
            prodCat.Category__c = 'test';
            prodCat.Product_Families__c = 'Accessories';
            prodCat.Sort_Order__c = 1;
            insert prodCat;
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
       Account acc1 = [SELECT Id, Name,dBA__c,Community_Price_Book__c, Type FROM Account WHERE Name = 'Test Account1' LIMIT 1];
        acc1.Type = 'Distributor';
        acc1.Name = 'Irrational Raccoon, LLC';
        acc1.dBA__c = 'Irrational Raccoon';
        acc1.Community_Price_Book__c = customPB.Id;
        acc1.Hide_From_Marketplace__c = false;
        update acc1;
        Product2  objProduct3 = new Product2 ();
        objProduct3.Name = 'product 3';
        objProduct3.Quantity_Type__c = 'Quantity';
        objProduct3.Family = 'Accessories';
        objProduct3.Description = 'test product 3';
        objProduct3.Apply_Cultivation_Tax__c='Yes';
        objProduct3.Apply_Excise_Tax__c='Yes';
        objProduct3.IsActive = true;
        objProduct3.Unit_Height__c  = 30.0;
        objProduct3.Unit_Length__c = 10.0;
        objProduct3.Unit_Width__c = 5.0;
        objProduct3.Apply_Excise_Tax__c = 'Yes';
        objProduct3.RecordTypeId = productRecordTypeId;
        objProduct3.Track_Trace_Category__c='Capsule';
        objProduct3.Net_Weight_UOM__c='EA';
        objProduct3.Unit_Of_Measure__c='Grams';
        objProduct3.MOQ__c = 1;
        objProduct3.Available_Inventory__c =10;
        objProduct3.Total_Order_Qty__c=3;
        objProduct3.Producer_Name__c = acc1.Id;
        objProduct3.Product_Rating__c = 0;
        objProduct3.Status__c='Active';
        objProduct3.White_Labelled__c=false;
        objProduct3.Hide_From_Marketplace__c = false;
        objProduct3.Most_Popular__c = true;
        objProduct3.Is_Sample__c=false;
        insert objProduct3;
        insert new Product_Review__c(Product__c = objProduct3.Id, Rating__c = 5,Rating_Text__c = '5', Review__c = 'Nice product');
        
        Product2  objProduct = new Product2 ();
        objProduct.Name = 'product 2';
        objProduct.Quantity_Type__c = 'Quantity';
        objProduct.Family = 'Accessories';
        objProduct.Description = 'test product 2';
        objProduct.Apply_Cultivation_Tax__c='Yes';
        objProduct.Apply_Excise_Tax__c='Yes';
        objProduct.IsActive = true;
        objProduct.Unit_Height__c  = 30.0;
        objProduct.Unit_Length__c = 10.0;
        objProduct.Unit_Width__c = 5.0;
        objProduct.Apply_Excise_Tax__c = 'Yes';
        objProduct.RecordTypeId = productRecordTypeId;
        objProduct.Track_Trace_Category__c='Capsule';
        objProduct.Net_Weight_UOM__c='EA';
        objProduct.Unit_Of_Measure__c='Grams';
        objProduct.MOQ__c = 1;
        objProduct.Available_Inventory__c =10;
        objProduct.Total_Order_Qty__c=3;
        objProduct.Producer_Name__c = acc1.Id;
        objProduct.Product_Rating__c = 0;
        objProduct.Status__c='Active';
        objProduct.White_Labelled__c=false;
        objProduct.Hide_From_Marketplace__c = false;
        objProduct.Most_Popular__c = true;
        objProduct.Is_Sample__c=false;
        objProduct.Parent_Product__c = objProduct3.Id;
        insert objProduct;
        
        insert new Product_Review__c(Product__c = objProduct.Id, Rating__c = 5,Rating_Text__c = '5', Review__c = 'Nice product');
        
        Compliance_Images__c[] cImages = new Compliance_Images__c[]{};
        cImages.add(new Compliance_Images__c(COA_Issued_Date__c=System.today().addDays(386), Lab_Test_Status__c = 'Passed',Product__c= objProduct.Id));
        cImages.add(new Compliance_Images__c(COA_Issued_Date__c=System.today().addDays(386), Lab_Test_Status__c = 'Passed',Product__c= objProduct3.Id));
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
        
        ContentDocumentLink newFileShare2 = new ContentDocumentLink();
        newFileShare2.contentdocumentid = testContent.contentdocumentid;
        newFileShare2.LinkedEntityId = cImages[1].Id;
        newFileShare2.ShareType= 'V';
        insert newFileShare2;
        
        
        Id pricebookId = Test.getStandardPricebookId();
        list<PricebookEntry> pbelst =new list<PricebookEntry>();
        PricebookEntry pbe =new PricebookEntry(
                    Pricebook2Id = pricebookId, Product2Id = objProduct3.Id,
                    UnitPrice = 10000, IsActive = true);
        PricebookEntry pbe1 = new PricebookEntry(
                    Pricebook2Id = customPB.Id, Product2Id = objProduct3.Id,
                    UnitPrice = 12000, IsActive = true);
        pbelst.add(pbe);
        pbelst.add(pbe1);
        insert pbelst;
        
        
        
        Test.startTest();
        Map<String, Object> filters = new Map<String, Object> {'families'=>'Accessories','orderByField' =>'Product2.Name', 'isASC' => true, 'searchTerm' => 'product'};
        AuraResponse r =brandPublicProductsCtlr.getIds(filters,''+EncodingUtil.base64Encode(Blob.valueOf(acc1.Id)));
        Set<Id> ids = (Set<Id>)r.data.get('ids');
        List<String> idsList = new List<String>();
        for(Id idStr : ids){
            idsList.add(idStr);
        }
        System.debug('#####IDdddddddds :'+idsList);
        brandPublicProductsCtlr.getProducts(idsList,filters,''+EncodingUtil.base64Encode(Blob.valueOf(acc1.Id)));
        brandPublicProductsCtlr.getProductAndReviews(''+EncodingUtil.base64Encode(Blob.valueOf(pbelst[0].Id)),''+EncodingUtil.base64Encode(Blob.valueOf(acc1.Id)),1);
        Test.stopTest();
    }
}