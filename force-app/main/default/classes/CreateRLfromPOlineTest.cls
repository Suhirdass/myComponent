@isTest(SeeAllData = false)
private class CreateRLfromPOlineTest {

  //  static CreateQuote bqext;
    static CreatePOfromQuote poext;
    static CreateSOfromQuote soext;
    static CreateShippingManifestfromPO tsmext;
    static CreateShippingManifestfromInvoice rsmext;
    static CreateCTRfromTSM ctrext;
    static CreateARfromSO arext;
    static CreateNewETR etrext;
    static CreateRLfromPOline ext;
    static Receiving__c objReceiving;
    static Purchase_Order__c objPO;
    static list<Purchase_Order_Line__c> lstPurchaseOrderLine;
    static PageReference pref;
    static Shipping_Manifest__c objTSM;
    static CreateCTIfromTSM tsmextn;
    static CreateCTIfromPO ctiext;
    static Purchase_Order__c poTest;
    static List<Purchase_Order_Line__c> poLines;

    private static void createData() {
        TestUtilData.skipTrigger = true;
		Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        //Create Account

        //supplier Account
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

        //Create Site.
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        //objSite.License_ID__c= objStateLicenses.id;
        insert objSite;

		UID__c uid = new UID__c(Name='T62874623462374623462831',Active__c = true);
		insert uid;
        Harvest_Batch_Code__c hbc = new Harvest_Batch_Code__c(Name='Test122',Active__c = true);
        insert hbc;
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
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'InvDetTestproduct 1';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Cannabis_Weight__c = 1.0;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        insert objProduct1;
        
        //Create Product2
        Product2 objProduct2 = new Product2();
        objProduct2.Name = 'product 2';
        objProduct2.Family = 'Edibles';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
        objProduct2.Apply_Cultivation_Tax__c = 'Yes';
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.IsActive = true;
        objProduct2.Quantity_Type__c = 'Quantity';
        objProduct2.Track_Trace_Category__c='Capsule';
        objProduct2.Net_Weight_UOM__c='EA';
        objProduct2.Unit_Of_Measure__c='Grams';
        insert objProduct2;

        //PricebookEntry pbe = [SELECT Id FROM PricebookEntry where isActive = true LIMIT 1];
		PricebookEntry pbe =  new PricebookEntry(
          Pricebook2Id = Test.getStandardPricebookId(), Product2Id =objProduct2.Id,
          UnitPrice = 10000, IsActive = true);
        insert pbe;
        //Create New Opportunity
        OpportunityLineItem opLineItem = new OpportunityLineItem();
        opLineItem.Quantity = 1;
        opLineItem.OpportunityId = opp.id;
        opLineItem.TotalPrice = 100;
        opLineItem.PricebookEntryId = pbe.id;
        insert opLineItem;

        //Create New Brand QUote
        pref = Page.createbuyquote;
        Test.setCurrentPage(pref);

        ApexPages.StandardController bqcon = new ApexPages.StandardController(opp);


        RecordType bqTypeID = [select id, name, developername from recordtype where developername = 'Sell_Quote' limit 1];
        Brand_Quote__c bq = new Brand_Quote__c();
        bq.Opportunity_Name__c = opp.id;
        bq.Distributor_Name__c = objAccount2.id;
        bq.Distributor_License__c = objStateLicenses2.id;
        bq.Receiver_Name__c = opp.AccountId;
        bq.Receiver_License__c = objStateLicenses.id;
        bq.Supplier_Name__c = opp.Ownership__c;
        bq.Supplier_License__c = objStateLicenses.id;
        bq.BQ_Status__c = 'Approved';
        bq.Shipping_Method__c = 'Distributor Pick-up';
        bq.Sales_Origin__c = 'Brand';
        bq.Shipping_Terms__c = 'CFR';
        bq.Payment_Terms__c = 'COD';
        bq.Site__c = objSite.id;
        bq.RecordTypeId = bqTypeID.Id;
        bq.Ownership__c = opp.Ownership__c;
        insert bq;

        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c = objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;
        objbqline1.Billed_Quantity__c = 100;

        Brand_Quote_Line__c objbqline2 = new Brand_Quote_Line__c();
        objbqline2.Brand_Quote_Number__c = bq.id;
        objbqline2.Product_Name__c = objProduct2.id;
        objbqline2.MOQ__c = 20;
        objbqline2.Quantity_Cases__c = 50;
        objbqline1.Billed_Quantity__c = 100;

        Brand_Quote_Line__c objbqline3 = new Brand_Quote_Line__c();
        objbqline3.Brand_Quote_Number__c = bq.id;
        objbqline3.Product_Name__c = objProduct1.id;
        objbqline3.MOQ__c = 8;
        objbqline3.Quantity_Cases__c = 100;
        objbqline1.Billed_Quantity__c = 100;

        list<Brand_Quote_Line__c> lstBrandQuoteLine = new list<Brand_Quote_Line__c> ();
        lstBrandQuoteLine.add(objbqline1);
        lstBrandQuoteLine.add(objbqline2);
        lstBrandQuoteLine.add(objbqline3);

        insert lstBrandQuoteLine;


        //Create PO from Brand Qoute.
        pref = Page.CreatePO;
        Test.setCurrentPage(pref);

        ApexPages.StandardController pocon = new ApexPages.StandardController(bq);
        poext = new CreatePOfromQuote(pocon);
        poext.createPO();

        objPO = new Purchase_Order__c();
        objPO.Site__c = bq.Site__c;
        objpo.PO_Status__c = 'Draft';
        objpo.PO_Type__c = 'Buy Quote';
        objPO.Supplier_Name__c = bq.Supplier_Name__c;
        objPO.Supplier_License__c = bq.Supplier_License__c;
        objPO.Distributor_Name__c = bq.Distributor_Name__c;
        objPO.Distributor_License__c = bq.Distributor_License__c;
        objPO.Receiver_Name__c = bq.Receiver_Name__c;
        objPO.Receiver_License__c = bq.Receiver_License__c;
        objPO.Ownership__c = bq.Ownership__c;
        insert objPO;


        Purchase_Order_Line__c objPOline1 = new Purchase_Order_Line__c();
        objPOline1.Purchase_Order__c = objPO.id;
        objPOline1.Product_Name__c = objbqline1.Product_Name__c;
        objPOline1.Qty_Ordered__c = 10;
        objPOline1.Unit_Cost__c = 10;
        objPOline1.UID_New__c = uid.Id;
        objPOline1.Harvest_Batch_Code__c = hbc.Id;
        objPOline1.Brand_Quote_Line__c = objbqline1.Id;
        
        Purchase_Order_Line__c objPOline2 = new Purchase_Order_Line__c();
        objPOline2.Purchase_Order__c = objPO.id;
        objPOline2.Product_Name__c = objbqline2.Product_Name__c;
        objPOline2.Qty_Ordered__c = 20;
        objPOline2.Unit_Cost__c = 20;
		objPOline2.UID_New__c = uid.Id;
        objPOline2.Harvest_Batch_Code__c = hbc.Id;
        objPOline2.Brand_Quote_Line__c = objbqline2.Id;
        
        Purchase_Order_Line__c objPOline3 = new Purchase_Order_Line__c();
        objPOline3.Purchase_Order__c = objPO.id;
        objPOline3.Product_Name__c = objbqline3.Product_Name__c;
        objPOline3.Qty_Ordered__c = 30;
        objPOline3.Unit_Cost__c = 30;
		objPOline3.UID_New__c = uid.Id;
        objPOline3.Harvest_Batch_Code__c = hbc.Id;
        objPOline3.Brand_Quote_Line__c = objbqline3.Id;
        
        lstPurchaseOrderLine = new list<Purchase_Order_Line__c> ();
        lstPurchaseOrderLine.add(objPOline1);
        lstPurchaseOrderLine.add(objPOline2);
        lstPurchaseOrderLine.add(objPOline3);

        insert lstPurchaseOrderLine;

        //Create New TSM from PO.
        pref = Page.CreateShippingManifestfromPO;
        Test.setCurrentPage(pref);

        ApexPages.StandardController tsmcon = new ApexPages.StandardController(objPO);
        tsmext = new CreateShippingManifestfromPO(tsmcon);
        tsmext.createTrShipManifest();
		CheckManifestRecursion.run = false;
        
        Shipping_Manifest__c newTrShipManifest = new Shipping_Manifest__c();
        newTrShipManifest.Purchase_Order__c = objPO.id;
        newTrShipManifest.Opportunity_Name__c = objPO.Opportunity_Name__c;
        newTrShipManifest.Distributor_Name__c = objPO.Distributor_Name__c;
        newTrShipManifest.Distributor_License__c = objPO.Distributor_License__c;
        newTrShipManifest.Distributor_Contact__c = objPO.Distributor_Contact__c;
        newTrShipManifest.Supplier_Name__c = objPO.Supplier_Name__c;
        newTrShipManifest.Supplier_License__c = objPO.Supplier_License__c;
        newTrShipManifest.Supplier_Contact__c = objPO.Supplier_Contact__c;
        newTrShipManifest.Receiver_Name__c = objPO.Receiver_Name__c;
        newTrShipManifest.Receiver_License__c = objPO.Receiver_License__c;
        newTrShipManifest.Receiver_Contact__c = objPO.Receiver_Contact__c;
        newTrShipManifest.Brand_Quote__c = objPO.Brand_Quote__c;
        newTrShipManifest.Sample_Order__c = objPO.Sample_Order__c;
        newTrShipManifest.Ownership__c = objPO.Ownership__c;
        newTrShipManifest.Site__c = objPO.Site__c;
        newTrShipManifest.TSM_Type__c = 'Product';
        newTrShipManifest.Status__c = 'Approved';
        newTrShipManifest.RecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        insert newTrShipManifest;

        List<Purchase_Order_Line__c> poLines = [select id
                                                , name
                                                , Purchase_Order__c
                                                , Product_Name__c
                                                , Unit_Cost__c
                                                , Product_Title__c
                                                , Qty_Ordered__c
                                                ,Harvest_Batch_Code__c
                                                ,UID_New__c
                                                from Purchase_Order_Line__c
                                                where Purchase_Order__c = :objPO.id];
        List<Shipping_Manifest_Line__c> trManifestLineItems = new List<Shipping_Manifest_Line__c> ();
        For (Purchase_Order_Line__c poline : poLines)
        {
            Shipping_Manifest_Line__c trManifestLineItem = new Shipping_Manifest_Line__c();
            trManifestLineItem.Purchase_Order_Line__c = poline.Id;
            trManifestLineItem.Product_Name__c = poline.Product_Name__c;
            trManifestLineItem.Product_Title__c = poline.Product_Title__c;
            trManifestLineItem.Unit_Cost__c = poline.Unit_Cost__c;
            trManifestLineItem.Qty_Ordered__c = poline.Qty_Ordered__c;
            trManifestLineItem.Shipping_Manifest__c = newTrShipManifest.Id;
            trManifestLineItem.RecordTypeId = ShippinManifestSupport.getTSMLineRecordTypeId();
            trManifestLineItems.add(trManifestLineItem);
        }
        insert trManifestLineItems;



        //Create New CTR from TSM.
        pref = Page.CreateCTRfromTSM;
        Test.setCurrentPage(pref);

        //Shipping_Manifest__c newtsm = [select id, name from Shipping_Manifest__c where Purchase_Order__c =: objpo.id limit 1];
        ApexPages.StandardController ctrcon = new ApexPages.StandardController(newTrShipManifest); //newtsm  objPO
        ctrext = new CreateCTRfromTSM(ctrcon);
        ctrext.createCTR();
        ctrext.goBack();
        //Create New SO from Brand QUote
        pref = Page.CreateSO;
        Test.setCurrentPage(pref);
        bq.BQ_Status__c = 'Approved';
        update bq;
        
        ApexPages.StandardController socon = new ApexPages.StandardController(bq);
        soext = new CreateSOfromQuote(socon);
        soext.createSO();
        soext.goBack();
        System.debug('bq.Name.....' + bq.Name);
        System.debug('bq.id.....' + bq.id);

		Sales_Order__c so = [SELECT Id FROM Sales_Order__c LIMIT 1];
        ApexPages.StandardController arcon1 = new ApexPages.StandardController(so);
        CreateARfromSO car = new CreateARfromSO(arcon1);
        car.createAR();
        car.goBack();
        CreateARfromSO.createInvoiceOrder(so.id);
        Sales_Order__c objSO = new Sales_Order__c();
        objSO.Site__c = bq.Site__c;
        objSO.SO_Status__c = 'Approved';
        objSO.SO_Type__c = 'Sell Quote';
        objSO.Brand_Quote__c = bq.id;
        objSO.Supplier_Name__c = bq.Supplier_Name__c;
        objSO.Supplier_License__c = bq.Supplier_License__c;
        objSO.Distributor_Name__c = bq.Distributor_Name__c;
        objSO.Distributor_License__c = bq.Distributor_License__c;
        objSO.Receiver_Name__c = bq.Receiver_Name__c;
        objSO.Receiver_License__c = bq.Receiver_License__c;
        objSO.Payment_Terms__c = bq.Payment_Terms__c;
        objSO.Shipping_Terms__c = bq.Shipping_Terms__c;
        objSO.Shipping_Method__c = bq.Shipping_Method__c;
        objSO.Ownership__c = bq.Ownership__c;
        insert objSO;

        Sales_Order_Line__c objSOline1 = new Sales_Order_Line__c();
        objSOline1.Sales_Order__c = objSO.id;
        objSOline1.Product_Name__c = objbqline1.Product_Name__c;
        objSOline1.Qty_Ordered__c = 10;
        objSOline1.Retail_Wholesale_Price__c = 10;

        Sales_Order_Line__c objSOline2 = new Sales_Order_Line__c();
        objSOline2.Sales_Order__c = objSO.id;
        objSOline2.Product_Name__c = objbqline2.Product_Name__c;
        objSOline2.Qty_Ordered__c = 20;
        objSOline2.Retail_Wholesale_Price__c = 20;

        Sales_Order_Line__c objSOline3 = new Sales_Order_Line__c();
        objSOline3.Sales_Order__c = objSO.id;
        objSOline3.Product_Name__c = objbqline3.Product_Name__c;
        objSOline3.Qty_Ordered__c = 30;
        objSOline3.Retail_Wholesale_Price__c = 30;

        list<Sales_Order_Line__c> lstSalesOrderLine = new list<Sales_Order_Line__c> ();
        lstSalesOrderLine.add(objSOline1);
        lstSalesOrderLine.add(objSOline2);
        lstSalesOrderLine.add(objSOline3);

        insert lstSalesOrderLine;

        Invoice__c inv = new Invoice__c();
        inv.Sales_Order__c = objSO.id;
        insert inv;

        Invoice_Line__c invLine1 = new Invoice_Line__c();
        invline1.Invoice__c = inv.id;
        insert invline1;

       
        //Create New RSM from Invoice.
        pref = Page.CreateShippingManifestfromInvoice;
        Test.setCurrentPage(pref);

        ApexPages.StandardController rsmcon = new ApexPages.StandardController(inv); // objSO);
        rsmext = new CreateShippingManifestfromInvoice(rsmcon);
        rsmext.createReShipManifest();
        rsmext.goBack();
        Shipping_Manifest__c newrsm = new Shipping_Manifest__c();
        newrsm.Invoice__c = inv.id;
        newrsm.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        insert newrsm;
        List<Invoice_Line__c> InvLines = [select id, name, Invoice__c
                                          from Invoice_Line__c
                                          where Invoice__c = :inv.id];
        List<Shipping_Manifest_Line__c> reManifestLineItems = new List<Shipping_Manifest_Line__c> ();
        For (Invoice_Line__c Invline : InvLines)
        {
            Shipping_Manifest_Line__c reManifestLineItem = new Shipping_Manifest_Line__c();
            reManifestLineItem.Invoice_Line__c = Invline.Id;
            reManifestLineItem.Shipping_Manifest__c = newrsm.Id;
            reManifestLineItem.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
            reManifestLineItems.add(reManifestLineItem);
        }
        insert reManifestLineItems;
		
        
        Test.startTest();
/*
        //Create New ETR from RSM.
         pref = Page.CreateNewETR;
          Test.setCurrentPage(pref);  
         
          ApexPages.StandardController etrcon = new ApexPages.StandardController(inv);//newrsm);//objSO);
          etrext = new CreateNewETR(etrcon);   
          etrext.createETR();
          etrext.goBack(); 
        //Create New AR from SO.
        pref = Page.CreateInvFromSO;
        Test.setCurrentPage(pref);
        
        
        ApexPages.StandardController arcon = new ApexPages.StandardController(objSO);
        arext = new CreateARfromSO(arcon);
        arext.createAR();
        arext.goBack();
        
        //create Cuntivation Tax Invoice from TSM
        ApexPages.StandardController tsmcont = new ApexPages.StandardController(newTrShipManifest);
        tsmextn = new CreateCTIfromTSM(tsmcont);
        tsmextn.createCTI();
        tsmextn.goBack();*/
        
        AuraResponse r = new AuraResponse('CreateCTIfromPO.createCTILight()');    
        CreateCTIfromPO assign = new CreateCTIfromPO();
        
        CreateCTIfromPO.createCTILight(objPO.Id);
        CreateCTIfromPO.createCTInvoiceLight(objPO.Id);
        CreateRLfromPOline.purchaseOrderDeatils(objPO.Id);
        
        
         List<CreateRLfromPOline.PurchaseOrderLineWrapper> poliWrapprList = new List<CreateRLfromPOline.PurchaseOrderLineWrapper>();    
       
        CreateRLfromPOline.PurchaseOrderLineWrapper poliWrappr1  = new  CreateRLfromPOline.PurchaseOrderLineWrapper();
        CreateRLfromPOline.PurchaseOrderLineWrapper poliWrappr2  = new  CreateRLfromPOline.PurchaseOrderLineWrapper();
        CreateRLfromPOline.PurchaseOrderLineWrapper poliWrappr3  = new  CreateRLfromPOline.PurchaseOrderLineWrapper();
		
        poliWrappr1.isSelected = true;
        poliWrappr1.isDisabled = false;
        poliWrappr1.recQty = 1;
        poliWrappr1.labTestStat = 'Passed';
        poliWrappr1.pOrderLineSO = poLines[0];
        poLines[0].POLI_Status__c = SalesOrderSupport.PO_LINE_STATUS_PARTIALLY_RECEIVED;
        poliWrapprList.add(poliWrappr1);

        poliWrappr2.isSelected = true;
        poliWrappr2.isDisabled = false;
        poliWrappr2.recQty = 1;
        poliWrappr1.labTestStat = 'Passed';
        poliWrappr2.pOrderLineSO = poLines[1];
        poLines[1].POLI_Status__c = SalesOrderSupport.SO_LINE_STATUS_CANCELLED;
        poliWrapprList.add(poliWrappr2);

        poliWrappr3.isSelected = true;
        poliWrappr3.isDisabled = false;
        poliWrappr2.recQty = 1;
        poliWrappr1.labTestStat = 'Passed';
        poliWrappr3.pOrderLineSO = poLines[2];
        poLines[2].POLI_Status__c = SalesOrderSupport.SO_LINE_STATUS_REJECTED;
        poliWrapprList.add(poliWrappr3);
       
        AuraResponse ar = CreateRLfromPOline.CreateRecevings(objPO, poliWrapprList,true);
           

        objPO.PO_Status__c = 'Approved';
        update objPO;

        //Create New CTI from PO.
        pref = Page.CreateCTIfromPO;
        Test.setCurrentPage(pref);
        

        ApexPages.StandardController cticon = new ApexPages.StandardController(objPO);
        ctiext = new CreateCTIfromPO(cticon);
        ctiext.createCTI();
        ctiext.goBack();

        //Create Receiving
        Receiving__c objReceiving = new Receiving__c(Purchase_Order__c = objPO.id, Site__c = objPO.Site__c, Ownership__c = objPO.Ownership__c);
        insert objReceiving;

        pref = Page.CreateReceivinglineFromPOline;
        Test.setCurrentPage(pref);


        ApexPages.StandardController con = new ApexPages.StandardController(objReceiving);
        ext = new CreateRLfromPOline(con);

        ext.currentID = objPOline1.Id;
        //ext.doCancel();
        Test.stopTest();
    }

    static testMethod void poDeatilsTest() {
        TestUtilData.skipTrigger = true;
        createData();
        CreateCTIfromPO.createCTInvoice(objPO.id);
   }

}