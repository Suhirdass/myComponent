@isTest(SeeAllData=false)
public class BQCloneControllerTest {
    static List<Brand_Quote_Line__c> bqLines;
    static final String BQ_STATUS_DRAFT = 'Draft';
    
       
    static testmethod void runBQClone(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        //distributor Account
        Account objAccount2 = new Account();
        objAccount2.Name = 'Test Account2';
        objAccount2.Payment_Terms__c = 'COD';
        insert objAccount2;
        //receiver Account
        Account objAccount3 = new Account();
        objAccount3.Name = 'Test Account3';
        objAccount3.Payment_Terms__c = 'COD';
        insert objAccount3;

        //Create State License

        //Supplier License
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c = 'Active';
        objStateLicenses.License_Type__c = 'Type 1';
        objStateLicenses.License_Class__c = 'A-License';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now());
        insert objStateLicenses;
        //distributor License
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount2.id;
        objStateLicenses2.License_Number__c = 'AbcTest45678';
        objStateLicenses2.License_Status__c = 'Active';
        objStateLicenses2.License_Type__c = 'Type 1';
        objStateLicenses2.License_Class__c = 'A-License';
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now());
        insert objStateLicenses2;
        //receiver License
        State_Licenses__c objStateLicenses3 = new State_Licenses__c();
        objStateLicenses3.License_Name__c = objAccount3.id;
        objStateLicenses3.License_Number__c = 'AbcTest54321';
        objStateLicenses3.License_Status__c = 'Active';
        objStateLicenses3.License_Type__c = 'Type 1';
        objStateLicenses3.License_Class__c = 'A-License';
        objStateLicenses3.License_Expiration_Date__c = date.valueof(system.now());

        insert objStateLicenses3;

        
        Google_Distance_Matrix_API__c ct =  new Google_Distance_Matrix_API__c();
        ct.Name = 'GMaps_Endpoint';
        ct.Value__c = 'value';
        insert ct;
        Google_Distance_Matrix_API__c ct1 =  new Google_Distance_Matrix_API__c();
        ct1.Name = 'Gmaps_APIKey';
        ct1.Value__c = 'value';
        insert ct1;
        
        //Create Site.
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        //objSite.License_ID__c= objStateLicenses.id;
        insert objSite;



        Inventory_Location__c newInventoryLocation = new Inventory_Location__c();
        newInventoryLocation.Name = 'Test InventoryLocation';
        newInventoryLocation.Site_Name__c = objSite.id;
        newInventoryLocation.Default_for_Site__c = true;

        insert newInventoryLocation;

        RecordType bqType = [select id, name, developername from recordtype where developername = 'Buy_Sell_Opportunity' limit 1];
        Opportunity opp = new Opportunity();
        opp.AccountId = objAccount.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName = 'Qualification';
        opp.RecordTypeId = bqType.Id;
        opp.Site_Name__c = objSite.Id;
        opp.Ownership__c = objAccount.id;
        opp.Payment_Terms__c='COD';

        insert opp;

        System.debug('opp.id' + opp.id);

        //Create Product

        //Create Product1
        /*
        Product2 objProduct1 = new Product2();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c = 'Yes';
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.IsActive = true;
        insert objProduct1; */
        
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product KD 1';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount2.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        insert objProduct1;
        
        //Create Product2
        /*
        Product2 objProduct2 = new Product2();
        objProduct2.Name = 'product 2';
        objProduct2.Family = 'Edibles';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
        objProduct2.Apply_Cultivation_Tax__c = 'Yes';
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.IsActive = true;
        insert objProduct2; */
        
        Product2  objProduct2 = new Product2 ();
        objProduct2.Name = 'product KD 2';
        objProduct2.Quantity_Type__c = 'Quantity';
        objProduct2.Family = 'Accessories';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount3.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct2.Apply_Excise_Tax__c='Yes';
        objProduct2.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct2.Unit_Length__c = 10.0;
        objProduct2.Unit_Width__c = 5.0;
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.Track_Trace_Category__c='Capsule';
        objProduct2.Net_Weight_UOM__c='EA';
        objProduct2.Unit_Of_Measure__c='Grams';
        insert objProduct2;
        
        
        Id pricebookId = Test.getStandardPricebookId();
		PricebookEntry pbe = new PricebookEntry(
          Pricebook2Id = pricebookId, Product2Id = objProduct1.Id,
          UnitPrice = 10000, IsActive = true);
        PricebookEntry pbe2 = new PricebookEntry(
          Pricebook2Id = pricebookId, Product2Id = objProduct2.Id,
          UnitPrice = 10000, IsActive = true);
        insert new List<PricebookEntry>{pbe,pbe2};
        //PricebookEntry pbe = [SELECT Id FROM PricebookEntry where isActive = true LIMIT 1];

        //Create New Opportunity
        OpportunityLineItem opLineItem = new OpportunityLineItem();
        opLineItem.Quantity = 1;
        opLineItem.OpportunityId = opp.id;
        opLineItem.TotalPrice = 100;
        opLineItem.PricebookEntryId = pbe.Id;
        insert opLineItem;

        

        RecordType bqTypeID = [select id, name, developername from recordtype where developername = 'Sell_Quote' limit 1];
        Brand_Quote__c bq = new Brand_Quote__c();
        bq.Opportunity_Name__c = opp.id;
        bq.Distributor_Name__c = objAccount2.id;
        bq.Distributor_License__c = objStateLicenses2.id;
        bq.Receiver_Name__c = opp.AccountId;
        bq.Receiver_License__c = objStateLicenses.id;
        bq.Supplier_Name__c = opp.Ownership__c;
        bq.Supplier_License__c = objStateLicenses.id;
        bq.BQ_Status__c = 'Draft';
        bq.Shipping_Method__c = 'Distributor Pick-up';
        bq.Sales_Origin__c = 'Brand';
        bq.Shipping_Terms__c = 'CFR';
        bq.Payment_Terms__c = 'COD';
        bq.Site__c = objSite.id;
        bq.RecordTypeId = bqTypeID.Id;
        bq.Ownership__c = opp.Ownership__c;
        insert bq;
        
        RecordType bqTypeID2 = [select id, name, developername from recordtype where developername = 'Sell_Quote' limit 1];
        Brand_Quote__c bq2 = bq.clone();
        bq2.Opportunity_Name__c = opp.id;
        bq2.Distributor_Name__c = objAccount2.id;
        bq2.Distributor_License__c = objStateLicenses2.id;
        bq2.Receiver_Name__c = opp.AccountId;
        bq2.Receiver_License__c = objStateLicenses.id;
        bq2.Supplier_Name__c = opp.Ownership__c;
        bq2.Supplier_License__c = objStateLicenses.id;
        bq2.BQ_Status__c = BQ_STATUS_DRAFT;
        bq2.Shipping_Method__c = 'Distributor Pick-up';
        bq2.Sales_Origin__c = 'Brand';
        bq2.Shipping_Terms__c = 'CFR';
        bq2.Payment_Terms__c = 'COD';
        bq2.Site__c = objSite.id;
        bq2.RecordTypeId = bqTypeID2.Id;
        bq2.Ownership__c = opp.Ownership__c;
        bq2.KP_Ready_for_Delivery__c = false;
        bq2.Kushy_Punch_Order_Number__c = null;
        bq2.Receiver_Acceptance_Date__c = null;
        bq2.Planned_Ship_Date__c = null;
        bq2.Collection_Status__c = null;
        bq2.Last_Payment_Date__c = null;
        
        insert bq2;
        

        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c = objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;

        Brand_Quote_Line__c objbqline2 = new Brand_Quote_Line__c();
        objbqline2.Brand_Quote_Number__c = bq.id;
        objbqline2.Product_Name__c = objProduct2.id;
        objbqline2.MOQ__c = 20;
        objbqline2.Quantity_Cases__c = 50;

        Brand_Quote_Line__c objbqline3 = new Brand_Quote_Line__c();
        objbqline3.Brand_Quote_Number__c = bq.id;
        objbqline3.Product_Name__c = objProduct1.id;
        objbqline3.MOQ__c = 8;
        objbqline3.Quantity_Cases__c = 100;

        list<Brand_Quote_Line__c> lstBrandQuoteLine = new list<Brand_Quote_Line__c> ();
        lstBrandQuoteLine.add(objbqline1);
        lstBrandQuoteLine.add(objbqline2);
        lstBrandQuoteLine.add(objbqline3);

        insert lstBrandQuoteLine;
        ApexPages.StandardController sc = new ApexPages.StandardController(bq);
        BQCloneController bqc = new BQCloneController(sc);
        
        bqc.cloneBrandQuote();
        
        AuraResponse r = new AuraResponse('BQCloneController.cloneBQ()');    
        BQCloneController assign = new BQCloneController();
        
        BQCloneController.cloneBQ(bq.Id);
        BQCloneController.getBQ(bq.Id);
        BQCloneController.getBQLines(bq.Id);
        
        List<BQCloneController.BrandQuoteLineWrapper> bqliWrapprList = new List<BQCloneController.BrandQuoteLineWrapper>();    
       
        BQCloneController.BrandQuoteLineWrapper bqliWrappr1  = new  BQCloneController.BrandQuoteLineWrapper();
        BQCloneController.BrandQuoteLineWrapper bqliWrappr2  = new  BQCloneController.BrandQuoteLineWrapper();
        BQCloneController.BrandQuoteLineWrapper bqliWrappr3  = new  BQCloneController.BrandQuoteLineWrapper();

        bqliWrappr1.isSelected = true;
        bqliWrappr1.brandQuoteLineBQ = objbqline1;
        bqliWrapprList.add(bqliWrappr1);
        
        bqliWrappr2.isSelected = true;
        bqliWrappr2.brandQuoteLineBQ = objbqline2;
        bqliWrapprList.add(bqliWrappr2);
        
        bqliWrappr3.isSelected = true;
        bqliWrappr3.brandQuoteLineBQ = objbqline3;
        bqliWrapprList.add(bqliWrappr3);
        
        BQCloneController.cloneBrandQuoteLight(bq, bqliWrapprList);
        

        
        //AuraResponse ar = BQCloneController.cloneBrandQuoteLight(bq, bqliWrapprList); 

        
    }
    static testmethod void runBQClone1(){
         Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        //distributor Account
        Account objAccount2 = new Account();
        objAccount2.Name = 'Test Account2';
        objAccount2.Payment_Terms__c = 'COD';
        insert objAccount2;
        //receiver Account
        Account objAccount3 = new Account();
        objAccount3.Name = 'Test Account3';
        objAccount3.Payment_Terms__c = 'COD';
        insert objAccount3;

        //Create State License

        //Supplier License
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c = 'Active';
        objStateLicenses.License_Type__c = 'Type 1';
        objStateLicenses.License_Class__c = 'A-License';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now());
        insert objStateLicenses;
        //distributor License
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount2.id;
        objStateLicenses2.License_Number__c = 'AbcTest45678';
        objStateLicenses2.License_Status__c = 'Expired';
        objStateLicenses2.License_Type__c = 'Type 1';
        objStateLicenses2.License_Class__c = 'A-License';
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now().addDays(-10));
        insert objStateLicenses2;
        Google_Distance_Matrix_API__c ct =  new Google_Distance_Matrix_API__c();
        ct.Name = 'GMaps_Endpoint';
        ct.Value__c = 'value';
        insert ct;
        Google_Distance_Matrix_API__c ct1 =  new Google_Distance_Matrix_API__c();
        ct1.Name = 'Gmaps_APIKey';
        ct1.Value__c = 'value';
        insert ct1;
        
        //receiver License
        State_Licenses__c objStateLicenses3 = new State_Licenses__c();
        objStateLicenses3.License_Name__c = objAccount3.id;
        objStateLicenses3.License_Number__c = 'AbcTest54321';
        objStateLicenses3.License_Status__c = 'Active';
        objStateLicenses3.License_Type__c = 'Type 1';
        objStateLicenses3.License_Class__c = 'A-License';
        objStateLicenses3.License_Expiration_Date__c = date.valueof(system.now());

        insert objStateLicenses3;

        //Create Site.
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        //objSite.License_ID__c= objStateLicenses.id;
        insert objSite;



        Inventory_Location__c newInventoryLocation = new Inventory_Location__c();
        newInventoryLocation.Name = 'Test InventoryLocation';
        newInventoryLocation.Site_Name__c = objSite.id;
        newInventoryLocation.Default_for_Site__c = true;

        insert newInventoryLocation;

        RecordType bqType = [select id, name, developername from recordtype where developername = 'Buy_Sell_Opportunity' limit 1];
        Opportunity opp = new Opportunity();
        opp.AccountId = objAccount.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName = 'Qualification';
        opp.RecordTypeId = bqType.Id;
        opp.Site_Name__c = objSite.Id;
        opp.Ownership__c = objAccount.id;
        opp.Payment_Terms__c='COD';

        insert opp;

        System.debug('opp.id' + opp.id);

        //Create Product

        //Create Product1
        /*
        Product2 objProduct1 = new Product2();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c = 'Yes';
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.IsActive = true;
        insert objProduct1; */
        
         Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product KD 1';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        insert objProduct1;
        
        //Create Product2
        /*
        Product2 objProduct2 = new Product2();
        objProduct2.Name = 'product 2';
        objProduct2.Family = 'Edibles';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
        objProduct2.Apply_Cultivation_Tax__c = 'Yes';
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.IsActive = true;
        insert objProduct2; */
        
        Product2  objProduct2 = new Product2 ();
        objProduct2.Name = 'product KD 2';
        objProduct2.Quantity_Type__c = 'Quantity';
        objProduct2.Family = 'Accessories';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
        objProduct2.Apply_Cultivation_Tax__c='Yes';
        objProduct2.Apply_Excise_Tax__c='Yes';
        objProduct2.IsActive = true;
        objProduct2.Unit_Height__c  = 10.0;
        objProduct2.Unit_Length__c = 10.0;
        objProduct2.Unit_Width__c = 5.0;
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.Track_Trace_Category__c='Capsule';
        objProduct2.Net_Weight_UOM__c='EA';
        objProduct2.Unit_Of_Measure__c='Grams';
        insert objProduct2;
        
        Id pricebookId = Test.getStandardPricebookId();
		PricebookEntry pbe = new PricebookEntry(
          Pricebook2Id = pricebookId, Product2Id = objProduct1.Id,
          UnitPrice = 10000, IsActive = true);
        PricebookEntry pbe2 = new PricebookEntry(
          Pricebook2Id = pricebookId, Product2Id = objProduct2.Id,
          UnitPrice = 10000, IsActive = true);
        insert new List<PricebookEntry>{pbe,pbe2};
        //PricebookEntry pbe = [SELECT Id FROM PricebookEntry where isActive = true LIMIT 1];

        //Create New Opportunity
        OpportunityLineItem opLineItem = new OpportunityLineItem();
        opLineItem.Quantity = 1;
        opLineItem.OpportunityId = opp.id;
        opLineItem.TotalPrice = 100;
        opLineItem.PricebookEntryId = pbe.Id;
        insert opLineItem;

        RecordType bqTypeID = [select id, name, developername from recordtype where developername = 'Sell_Quote' limit 1];
        Brand_Quote__c bq = new Brand_Quote__c();
        bq.Opportunity_Name__c = opp.id;
        bq.Distributor_Name__c = objAccount2.id;
        bq.Distributor_License__c = objStateLicenses2.id;
        bq.Receiver_Name__c = opp.AccountId;
        bq.Receiver_License__c = objStateLicenses.id;
        bq.Supplier_Name__c = opp.Ownership__c;
        bq.Supplier_License__c = objStateLicenses.id;
        //bq.Supplier_License__r.License_Status__c = 'Active';
        bq.BQ_Status__c = 'Draft';
        bq.Shipping_Method__c = 'Distributor Pick-up';
        bq.Sales_Origin__c = 'Brand';
        bq.Shipping_Terms__c = 'CFR';
        bq.Payment_Terms__c = 'COD';
        bq.Site__c = objSite.id;
        bq.RecordTypeId = bqTypeID.Id;
        bq.Ownership__c = opp.Ownership__c;
        insert bq;

         List<Brand_Quote__c> b = [SELECT Id FROM Brand_Quote__c WHERE Id =:bq.Id];
 		System.debug('Price after trigger fired: ' + b.size());
 
 // Test that the trigger correctly updated the price
         System.assertEquals(1,b.size());
        
        RecordType bqTypeID2 = [select id, name, developername from recordtype where developername = 'Sell_Quote' limit 1];
        Brand_Quote__c bq2 = new Brand_Quote__c();
        bq2.Opportunity_Name__c = opp.id;
        bq2.Distributor_Name__c = objAccount2.id;
        bq2.Distributor_License__c = objStateLicenses2.id;
        bq2.Receiver_Name__c = opp.AccountId;
        bq2.Receiver_License__c = objStateLicenses.id;
        bq2.Supplier_Name__c = opp.Ownership__c;
        bq2.Supplier_License__c = objStateLicenses.id;
        //bq2.Supplier_License__r.License_Status__c = 'Draft';
        bq2.BQ_Status__c = BQ_STATUS_DRAFT;
        bq2.Shipping_Method__c = 'Distributor Pick-up';
        bq2.Sales_Origin__c = 'Brand';
        bq2.Shipping_Terms__c = 'CFR';
        bq2.Payment_Terms__c = 'COD';
        bq2.Site__c = objSite.id;
        bq2.RecordTypeId = bqTypeID2.Id;
        bq2.Ownership__c = opp.Ownership__c;
        bq2.KP_Ready_for_Delivery__c = false;
        bq2.Kushy_Punch_Order_Number__c = null;
        bq2.Receiver_Acceptance_Date__c = null;
        bq2.Planned_Ship_Date__c = null;
        bq2.Collection_Status__c = null;
        bq2.Last_Payment_Date__c = null;
        
        insert bq2;


        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c = objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;

        Brand_Quote_Line__c objbqline2 = new Brand_Quote_Line__c();
        objbqline2.Brand_Quote_Number__c = bq.id;
        objbqline2.Product_Name__c = objProduct2.id;
        objbqline2.MOQ__c = 20;
        objbqline2.Quantity_Cases__c = 50;

        Brand_Quote_Line__c objbqline3 = new Brand_Quote_Line__c();
        objbqline3.Brand_Quote_Number__c = bq.id;
        objbqline3.Product_Name__c = objProduct1.id;
        objbqline3.MOQ__c = 8;
        objbqline3.Quantity_Cases__c = 100;

        list<Brand_Quote_Line__c> lstBrandQuoteLine = new list<Brand_Quote_Line__c> ();
        lstBrandQuoteLine.add(objbqline1);
        lstBrandQuoteLine.add(objbqline2);
        lstBrandQuoteLine.add(objbqline3);

        insert lstBrandQuoteLine;
        ApexPages.StandardController sc = new ApexPages.StandardController(bq);
        BQCloneController bqc = new BQCloneController(sc);
        
        bqc.cloneBrandQuote();   
        
         AuraResponse r = new AuraResponse('BQCloneController.cloneBQ()');    
        BQCloneController assign = new BQCloneController();
        
        BQCloneController.cloneBQ(bq.Id);
        
        BQCloneController.getBQ(bq.Id);
        BQCloneController.getBQLines(bq.Id);
        
        List<BQCloneController.BrandQuoteLineWrapper> bqliWrapprList = new List<BQCloneController.BrandQuoteLineWrapper>();    
       
        BQCloneController.BrandQuoteLineWrapper bqliWrappr1  = new  BQCloneController.BrandQuoteLineWrapper();
        BQCloneController.BrandQuoteLineWrapper bqliWrappr2  = new  BQCloneController.BrandQuoteLineWrapper();
        BQCloneController.BrandQuoteLineWrapper bqliWrappr3  = new  BQCloneController.BrandQuoteLineWrapper();

        bqliWrappr1.isSelected = true;
        bqliWrappr1.brandQuoteLineBQ = objbqline1;
        bqliWrapprList.add(bqliWrappr1);
        
        bqliWrappr2.isSelected = true;
        bqliWrappr2.brandQuoteLineBQ = objbqline2;
        bqliWrapprList.add(bqliWrappr2);
        
        bqliWrappr3.isSelected = true;
        bqliWrappr3.brandQuoteLineBQ = objbqline3;
        bqliWrapprList.add(bqliWrappr3);
        System.debug('bq.Distributor_License__r.License_Status__c...'+bq.Distributor_License__r.License_Status__c);
        AuraResponse ar = BQCloneController.cloneBrandQuoteLight(bq, bqliWrapprList); 
        //AuraResponse ar1 = BQCloneController.cloneBrandQuoteLight(bq2, bqliWrapprList); 
    }
 

}