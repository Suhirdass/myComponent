@isTest
public class SMCancelAllRelatedItemsTest {
	@TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        SOlineTriggerHandler.isRecursion = true;
        
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        
        /*TestUtilData.createTestData();
        Sales_Order__c salesObj = [SELECT Id,Brand_Quote__c,Planned_Ship_Date__c ,Distributor_Contact__c,Distributor_License__c,Distributor_Name__c,Opportunity_Name__c,Payment_Terms__c,Receiver_Contact__c,Receiver_License__c,Receiver_Name__c,Sample_Order__c,Shipping_Method__c ,Shipping_Terms__c  ,Site__c,Supplier_Contact__c,Supplier_License__c,Supplier_Name__c FROM Sales_Order__c LIMIT 1];
        Shipping_Manifest__c ms = TestUtilData.createTSM(salesObj,true);
        ms.Sales_Order__c = salesObj.Id;
        update ms;
        Purchase_Order__c po = [SELECT Id, Brand_Quote__c  FROM Purchase_Order__c LIMIT 1];
        po.Brand_Quote__c = salesObj.Brand_Quote__c;
        update po;*/
    }
    
    @isTest
    public static void testCancelItems(){
        /*Sales_Order__c salesObj = [SELECT Id FROM Sales_Order__c LIMIT 1];
        Picklist__c pickObj = TestUtilData.createPicklist(salesObj,)*/
        //Shipping_Manifest__c ms = [SELECT Id FROM Shipping_Manifest__c LIMIT 1];
        
        /*Shipping_Manifest_Line__c rsmLine1 = new Shipping_Manifest_Line__c();
        rsmLine1.Shipping_Manifest__c = ms.Id;
        rsmLine1.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        insert rsmLine1;
        
        Test.startTest();
        rsmLine1.SMLine_Status__c = 'Cancelled';
        update rsmLine1;
        
        Test.stopTest();
        //System.debug('ms:'+ms.size());*/
        
        Opportunity Opp = new Opportunity();
        Opp.Name = 'Test Opp';
        Opp.CloseDate = System.today();
        Opp.StageName = 'Qualification';
        insert Opp;
        
        Account Acc = new Account();
        Acc.Name = 'Test Acc';
        insert Acc;
        
        Contact Con = new Contact();
        Con.FirstName = 'Test';
        Con.LastName = 'Contact2';
        Con.AccountId = Acc.Id;
        insert Con;

		Site__c Site = new Site__c();
        Site.Name = 'Test Site';
        Site.Warehouse_Name__c='TestWarehouse1';
        insert Site;
        
        State_Licenses__c STL = new State_Licenses__c();
        STL.License_Name__c = Acc.id;
        STL.License_Number__c = 'AbcTest45678';
        STL.License_Status__c ='Active';
        STL.License_Type__c ='Type 1';
        STL.License_Class__c='A-License';
        STL.License_State__c = 'California';
        STL.License_City__c = 'San Francisco';
        STL.License_Address__c = '2089 Ingalls St. Unit 3';
        STL.License_Zip__c = '94124';
        STL.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        STL.Default_Warehouse__c = Site.Id;
        STL.Total_Miles__c = 10;
        //insert STL;
        
        Brand_Quote__c BQ = new Brand_Quote__c ();
        BQ.Opportunity_Name__c = opp.id; 
        //BQ.Distributor_License__c = STL.id;
        //BQ.Receiver_License__c = STL.id;
        BQ.Distributor_Name__c = Acc.id;
        BQ.Supplier_Name__c = Acc.id;
        BQ.Receiver_Name__c = Acc.id;
        //BQ.Supplier_License__c = STL.id;
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
        
        String productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Product').getRecordTypeId();
            
        Product2 Prd =  new Product2();
        Prd.Name = 'product 1';
        Prd.Quantity_Type__c = 'Quantity';
        Prd.Family = 'Accessories';
        Prd.Description = 'test product 1';
        Prd.Producer_Name__c = Acc.id;
        Prd.Apply_Cultivation_Tax__c='Yes';
        Prd.Apply_Excise_Tax__c='Yes';
        Prd.IsActive = true;
        Prd.Unit_Height__c  = 10.0;
        Prd.Unit_Length__c = 10.0;
        Prd.Unit_Width__c = 5.0;
        Prd.Apply_Excise_Tax__c = 'Yes';
        Prd.RecordTypeId = productRecordTypeId;
        Prd.Track_Trace_Category__c='Capsule';
        Prd.Net_Weight_UOM__c='EA';
        Prd.Unit_Of_Measure__c='Grams';
        Prd.MOQ__c = 1;
        insert Prd;
        
        Brand_Quote_Line__c BQL = new Brand_Quote_Line__c();
        BQL.Brand_Quote_Number__c = bq.id;
        BQL.Product_Name__c= Prd.id;
        BQL.MOQ__c = 10;
        BQL.Quantity_Cases__c = 200;
        BQL.Invoiced_Quantity__c = 20;
        BQL.Retail_Wholesale_Price__c  = 100;
        BQL.Billed_Quantity__c =10;
        insert BQL;
        
        Sales_Order__c SO = new Sales_Order__c();
        SO.Brand_Quote__c = BQ.Id;
        insert SO;
        
        Sales_Order_Line__c SOL = new Sales_Order_Line__c();
        SOL.Sales_Order__c = SO.id;
        SOL.Product_Name__c= BQL.Product_Name__c;
        SOL.Product_Title__c = 'Distributor';
        SOL.Qty_Ordered__c = 10;
        SOL.Qty_Invoiced__c = 5.0;
        SOL.Retail_Wholesale_Price__c = 10;
        SOL.Status__c = 'Allocated';
        //insert SOL;
        
        Invoice__c inv = new Invoice__c();
        inv.Sales_Order__c = SO.id;
        inv.AR_Status__c = 'Draft';
        inv.Brand_Quote__c = BQ.Id;
        insert inv;
        
        Invoice_Line__c invLine = new Invoice_Line__c();
        invLine.Invoice__c = inv.id;
        //invLine.Sales_Order_Line__c = lstSalesOrderLine[0].Id;
        invLine.Invoice_Qty__c = 5.0;
        invLine.Retail_Wholesale_Price__c = 100.0;
        invLine.Excise_Tax_Amount__c = 10.0;
        invLine.Product_Name__c = Prd.Id;
        insert invLine;
        
        Id recordTypeId = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByDeveloperName().get('Product').getRecordTypeId();
        Purchase_Order__c PO = new Purchase_Order__c();
        PO.recordTypeId = recordTypeId;
        PO.Site__c = BQ.Site__c;
        PO.PO_Status__c = 'Draft';
        PO.PO_Type__c = 'Buy Quote';
        PO.Supplier_Name__c = BQ.Supplier_Name__c;
        PO.Supplier_License__c = BQ.Supplier_License__c;
        PO.Distributor_Name__c = BQ.Distributor_Name__c;
        PO.Distributor_License__c = BQ.Distributor_License__c;
        PO.Receiver_Name__c = BQ.Receiver_Name__c;
        PO.Receiver_License__c = BQ.Receiver_License__c;
        PO.Ownership__c = BQ.Ownership__c;
        PO.Brand_Quote__c = BQ.Id;
        insert PO;
        
        Purchase_Order_Line__c POL = new Purchase_Order_Line__c();
        POL.Purchase_Order__c = PO.id;
        POL.Product_Name__c= BQL.Product_Name__c;
        POL.Qty_Ordered__c = 10;
        POL.Unit_Cost__c = 10;
        POL.Brand_Quote_Line__c =  BQL.Id;
        insert POL;
        
        Invoice__c inv1 = new Invoice__c();
        inv1.Sales_Order__c = SO.id;
        inv1.AR_Status__c = 'Draft';
        inv1.Purchase_Order__c = PO.Id;
        insert inv1;
        
        Invoice_Line__c invLine1 = new Invoice_Line__c();
        invLine1.Invoice__c = inv1.id;
        //invLine1.Sales_Order_Line__c = lstSalesOrderLine[0].Id;
        invLine1.Invoice_Qty__c = 5.0;
        invLine1.Retail_Wholesale_Price__c = 100.0;
        invLine1.Excise_Tax_Amount__c = 10.0;
        invLine1.Product_Name__c = Prd.Id;
        insert invLine1;
        
        Shipping_Manifest__c SM = new Shipping_Manifest__c();
        SM.Brand_Quote__c = BQ.Id;
        SM.Sales_Order__c = SO.Id;
        insert SM;
        
        SMCancelAllRelatedItems.getRelatedItems(new List<Shipping_Manifest__c>{SM});
    }
}