@isTest
public class RecalculateServiceInvoiceControllerTest {
    @isTest
    private static void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
            insert GDMIs;
        
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.Warehouse_Name__c='TestWarehouse1';
        insert objSite;
        
        Account acc = new Account();
        acc.Name = 'Test Account1';
        acc.Payment_Terms__c = 'COD';
        acc.Hold__c=true;
        acc.DBA__c='Test Account1';
        acc.Hide_from_Marketplace__c = false;
        acc.Membership_Level__c = 'Boutique';
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
        insert acc;
        
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = acc.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        objStateLicenses.Default_Warehouse__c = objSite.Id;
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_State__c = 'California';
        objStateLicenses.License_City__c = 'San Francisco';
        objStateLicenses.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses.License_Zip__c = '94124';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses.Total_Miles__c = 10;
        insert objStateLicenses;
        
        Order__c order = new Order__c();
        order.Order_Date__c = system.today();
        order.State_License__c = objStateLicenses.Id;
        insert order;
        
        Opportunity opp = new Opportunity();
        opp.Name = 'test opp';
        opp.Order__c = order.Id;
        opp.StageName = 'Qualification';
        opp.CloseDate = system.today();
        insert opp;
        
        Brand_Quote__c brandQuote = new Brand_Quote__c();
        brandQuote.Opportunity_Name__c = opp.Id;
        insert brandQuote;
        
        Sales_Order__c salesOrder = new Sales_Order__c();
        salesOrder.Brand_Quote__c = brandQuote.Id;
        salesOrder.Receiver_License__c = objStateLicenses.id; 
        salesOrder.Receiver_Name__c = acc.id;
        salesOrder.Supplier_Name__c = acc.Id;
        salesOrder.Site__c = objSite.id;
        salesOrder.Ownership__c =acc.id;
        insert salesOrder;
        
        salesOrder.Order_Booking_Fee__c = 10;
        salesOrder.Pack_Out_Fee__c = 29;
        salesOrder.Stage_Manifest_Fee__c = 37;
        salesOrder.Schedule_Dispatch_Fee__c = 893;
        salesOrder.Total_Mileage_Fee__c = 137.00;
        salesOrder.Total_Weight_Fee__c = 37.0;
        update salesOrder;
        
        Id devRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Services').getRecordTypeId();
        Product2  objProd = new Product2 ();
        objProd.RecordTypeId = devRecordTypeId;
        objProd.Name = 'Labeling';
        objProd.Family = 'Service';
        objProd.Description = 'test Labeling';
        objProd.Producer_Name__c = acc.id;
        objProd.IsActive = true;
        objProd.Quantity_Type__c = 'Quantity';
        objProd.Track_Trace_Category__c='Capsule';
        objProd.Net_Weight_UOM__c='EA';
        objProd.Unit_Gross_Weight__c = 10;
        insert objProd;
        
        Sales_Order_Line__c oli = new Sales_Order_Line__c();
        oli.Sales_Order__c = salesOrder.id;
        oli.Product_Name__c =objProd.Id;
        oli.Qty_Ordered__c = 1;
        insert oli;
        
        Fulfillment_Rates_Table__c fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = objSite.Id;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Pick & Pack';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Boutique';
        insert fullfillRateTable;
        
        Shipping_Rates_Table__c ShippingRateTable = new Shipping_Rates_Table__c();
        ShippingRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        ShippingRateTable.Site__c = objSite.Id;
        ShippingRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        ShippingRateTable.Membership_Level__c = 'Boutique';
        insert ShippingRateTable;
        
        Fulfillment_Rates_Table__c fullfillRateTable2 = fullfillRateTable.clone();
        fullfillRateTable2.Fulfillment_Services__c = 'Schedule & Dispatch';
        insert fullfillRateTable2;
        
        Fulfillment_Rates_Table__c fullfillRateTable3 = fullfillRateTable.clone();
        fullfillRateTable3.Fulfillment_Services__c = 'Stage & Manifest';
        insert fullfillRateTable3;
        
        Fulfillment_Rates_Table__c fullfillRateTable4 = fullfillRateTable.clone();
        fullfillRateTable4.Fulfillment_Services__c = 'Order Booking';
        insert fullfillRateTable4;
        
        Fulfillment_Rates_Table__c fullfillRateTable5 = fullfillRateTable.clone();
        fullfillRateTable5.Fulfillment_Services__c = 'QA Review';
        insert fullfillRateTable5;
        
        Fulfillment_Rates_Table__c fullfillRateTable6 = fullfillRateTable.clone();
        fullfillRateTable6.Fulfillment_Services__c = 'Pack-Out';
        insert fullfillRateTable6;
        
        Decimal totalMiles = 0.0;
        String SO_SHIPPING_METHOD_PICK_UP = RecalculateServiceInvoiceController.SO_SHIPPING_METHOD_PICK_UP;
        String  ERR_SO_RES_lICENSE_NOT_MATCH_WITH_ORDER = RecalculateServiceInvoiceController.ERR_SO_RES_lICENSE_NOT_MATCH_WITH_ORDER;
        Boolean createWMLines = true;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(salesOrder);
        RecalculateServiceInvoiceController recal = new RecalculateServiceInvoiceController(sc);
        
        RecalculateServiceInvoiceController recal1 = new RecalculateServiceInvoiceController();
        
        RecalculateServiceInvoiceController.recalculateServiceInvoice(salesOrder.id);
        
        recal1.redirectToRecord();
        
    }	
}