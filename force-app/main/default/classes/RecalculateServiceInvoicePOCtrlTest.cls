@isTest
public class RecalculateServiceInvoicePOCtrlTest {
    
   @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
    } 
       @isTest
    private static void runTest(){
           Test.startTest();
                Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());

        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
            insert GDMIs;
        
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.Warehouse_Name__c='TestWarehouse1';
        insert objSite;
        
          // supplier Account
        List<Account> accounts = new List<Account>();
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        accounts.add(objAccount);   
        
        // distributor Account
        Account objAccount2 = new Account();
        objAccount2.Name = 'Test Account2';
        objAccount2.Payment_Terms__c = 'COD';
        //objAccount2.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Supplier').getRecordTypeId();
        accounts.add(objAccount2);  
        
        // receiver Account
        Account objAccount3 = new Account();
        objAccount3.Name = 'Test Account3';
        objAccount3.Payment_Terms__c = 'COD';
        accounts.add(objAccount3);
        
        insert accounts;
     
        // Create State License
      //  Test.setMock(HttpCalloutMock.class, new Miles_Mock());  
        // Supplier License
        List<State_Licenses__c> licenses = new List<State_Licenses__c>();
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses.Default_Warehouse__c = objSite.Id;
        licenses.add(objStateLicenses);
        
        // distributor License
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount2.id;
        objStateLicenses2.License_Number__c = 'AbcTest45678';
        objStateLicenses2.License_Status__c ='Active';
        objStateLicenses2.License_Type__c ='Type 1';
        objStateLicenses2.License_Class__c='A-License';
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses2.Default_Warehouse__c = objSite.Id;
        licenses.add(objStateLicenses2); 
        
        // receiver License
        State_Licenses__c objStateLicenses3 = new State_Licenses__c();
        objStateLicenses3.License_Name__c = objAccount3.id;
        objStateLicenses3.License_Number__c = 'AbcTest54321';
        objStateLicenses3.License_Status__c ='Active';
        objStateLicenses3.License_Type__c ='Type 1';
        objStateLicenses3.License_Class__c='A-License';
        objStateLicenses3.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses3.Default_Warehouse__c = objSite.Id;
        licenses.add(objStateLicenses3);
        
        // receiver License
        State_Licenses__c objStateLicenses4 = new State_Licenses__c();
        objStateLicenses4.License_Name__c = objAccount3.id;
        objStateLicenses4.License_Number__c = 'AbcTest54321456';
        objStateLicenses4.License_Status__c ='Active';
        objStateLicenses4.License_Type__c ='Type 1';
        objStateLicenses4.License_Class__c='A-License';
        objStateLicenses4.License_Expiration_Date__c = date.valueof(system.now()) - 10;
        objStateLicenses4.Default_Warehouse__c = objSite.Id;
        licenses.add(objStateLicenses4);
        
        insert licenses;
        
        Order__c order = new Order__c();
        order.Order_Date__c = system.today();
        order.State_License__c = objStateLicenses.Id;
        insert order;
        
        // Create opportunity
        Opportunity opp = new Opportunity();
        opp.AccountId = objAccount.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName ='Qualification';
        opp.Site_Name__c = objSite.Id;
        opp.Ownership__c = objAccount.id;
        opp.Payment_Terms__c = 'COD';
        insert opp;
        
        Line_Card__c l= new Line_Card__c();
        l.Brand_Name__c=objAccount.id;
        l.Retailer_Name__c=objAccount3.id;
        l.Mutual_Payment_Terms__c='COD';
        insert l;
        
        Shipping_Rates_Table__c[] sRates = new Shipping_Rates_Table__c[]{};
        Shipping_Rates_Table__c  shipRateTable = new Shipping_Rates_Table__c();
        shipRateTable.Active__c = true;
        shipRateTable.Site__c = objSite.Id;
        shipRateTable.Rate_Effective_From__c = Date.Today().addDays(-3);
        shipRateTable.Rate_Effective_To__c = Date.Today().addDays(3);
        shipRateTable.Mileage_Bracket__c = 100;
        shipRateTable.Weight_Bracket__c = 100;
        shipRateTable.Weight_Bracket_Cost__c = 0.60;
        shipRateTable.Mileage_Bracket_Cost__c = 0.40;
        shipRateTable.Weight_Bracket_Mark_Up__c = 100;
        shipRateTable.Mileage_Bracket_Mark_Up__c = 60;
        shipRateTable.Membership_Level__c = 'Boutique';
        sRates.add(shipRateTable);
        shipRateTable = new Shipping_Rates_Table__c();
        shipRateTable.Active__c = true;
        shipRateTable.Site__c = objSite.Id;
        shipRateTable.Rate_Effective_From__c = Date.Today().addDays(-3);
        shipRateTable.Rate_Effective_To__c = Date.Today().addDays(3);
        shipRateTable.Mileage_Bracket__c = 100;
        shipRateTable.Weight_Bracket__c = 100;
        shipRateTable.Weight_Bracket_Cost__c = 0.60;
        shipRateTable.Mileage_Bracket_Cost__c = 0.40;
        shipRateTable.Weight_Bracket_Mark_Up__c = 100;
        shipRateTable.Mileage_Bracket_Mark_Up__c = 60;
        shipRateTable.Membership_Level__c = 'Retail';
        sRates.add(shipRateTable);
        insert sRates;
          shipRateTable.Mileage_Bracket__c = 1;
         update sRates;
        // Create brand quote
        Brand_Quote__c bq = new Brand_Quote__c ();
        bq.Opportunity_Name__c = opp.id; 
        bq.Supplier_Name__c = objAccount.id;
        bq.Supplier_License__c = objStateLicenses.id;
        bq.Distributor_Name__c = objAccount2.id;
        bq.Distributor_License__c = objStateLicenses2.id;
        bq.Receiver_Name__c = objAccount3.id;
        bq.Receiver_License__c = objStateLicenses3.id;
        bq.BQ_Status__c = 'Draft';
        bq.Shipping_Method__c = 'Distributor Pick-up';
        bq.Sales_Origin__c = 'Brand';
        bq.Shipping_Terms__c = 'CFR';        
        bq.Site__c = objSite.id;
        bq.Ownership__c = opp.Ownership__c;
        bq.Payment_Terms__c = opp.Payment_Terms__c;
        insert bq;
        
          Product2 objProduct2 = new Product2();
        objProduct2.Name = 'product 2';
        objProduct2.Family = 'Edibles';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = accounts[0].id;
        objProduct2.Apply_Cultivation_Tax__c = 'Yes';
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.IsActive = true;
        insert objProduct2;
   
        
        Brand_Quote_Line__c objbqline2 = new Brand_Quote_Line__c();
        objbqline2.Brand_Quote_Number__c = bq.id;
        objbqline2.Product_Name__c = objProduct2.id;
        objbqline2.MOQ__c = 0;
        objbqline2.Quantity_Cases__c = 50;
        insert objbqline2;
        Brand_Quote_Line__c bqLine = [SELECT Id,Name,MOQ__c from Brand_Quote_Line__c LIMIT 1];
        bqLine.MOQ__c = 14.2;
        bqLine.Quantity_Cases__c = 12;
        update bqLine;
         
            
       
        Purchase_Order__c objPO = new Purchase_Order__c();
      //  objPO.recordTypeId = recordTypeId;
        objPO.Site__c = bq.Site__c;
        objPO.Opportunity_Name__c = opp.Id;
        objpO.PO_Status__c = 'Draft';
        objpO.PO_Type__c = 'Buy Quote';
        objPO.Brand_Quote__c=bq.Id;
        objPO.Supplier_Name__c = bq.Supplier_Name__c;
        objPO.Supplier_License__c = objStateLicenses.id; 
        objPO.Distributor_Name__c = bq.Distributor_Name__c;
        objPO.Distributor_License__c = bq.Distributor_License__c;
        objPO.Receiver_Name__c = bq.Receiver_Name__c;
        objPO.Receiver_License__c = objStateLicenses3.id; 
        objPO.Ownership__c = bq.Ownership__c;
        objPO.Total_Weight_Fee__c =10;
        insert objPO;
        
           objPO.Service_Booking_Fee__c = 10;
        objPO.Service_Scheduling_Fee__c = 29;
        objPO.Service_Staging_Fee__c = 37;
        objPO.Total_Mileage_Fee__c = 137.00;
        objPO.Total_Weight_Fee__c = 37.0;
        update objPO;
        
          Set<id> bqids = new set<id>();
        bqids.add(objPO.Brand_Quote__c);
    	 BrandQuoteLineHandler.updateShippingFee(bqIds);  
         
       
   
        System.assertEquals(bqLine.Quantity_Cases__c,12);
		    // Create purchase order lines  
        Purchase_Order_Line__c objPOline1 = new Purchase_Order_Line__c();
        objPOline1.Purchase_Order__c = objPO.id;
        objPOline1.Qty_Ordered__c = 10;
        objPOline1.Brand_Quote_Line__c=objbqline2.Id;
        objPOline1.Unit_Cost__c = 10;
        insert objPOline1;   
      
       


        
        
        
        
        Id devRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Services').getRecordTypeId();
        Product2  objProd = new Product2 ();
        objProd.RecordTypeId = devRecordTypeId;
        objProd.Name = 'Labeling';
        objProd.Family = 'Service';
        objProd.Description = 'test Labeling';
        objProd.Producer_Name__c = accounts[0].id;
        objProd.IsActive = true;
        objProd.Quantity_Type__c = 'Quantity';
        objProd.Track_Trace_Category__c='Capsule';
        objProd.Net_Weight_UOM__c='EA';
        objProd.Unit_Gross_Weight__c = 10;
        insert objProd;
        
         Service_Ticket__c st =new Service_Ticket__c();
        st.Status__c ='Pending';
       // st.Brand_Contact__c=con.Id;
        st.Brand_Name__c=accounts[0].id;
        st.Transfer_Method__c='Pick-up';
        st.Request_Date_Time__c=system.today().addMonths(2);
        st.Destination_Site__c=objSite.id;
        st.Licensed_Premise__c =objStateLicenses.id;
        insert st;
       
        Fulfillment_Rates_Table__c fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = objSite.Id;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Pick & Pack';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Boutique';
        fullfillRateTable.Fulfillment_Services__c = 'Order Booking';
        insert fullfillRateTable;
        
         Fulfillment_Rates_Table__c fullfillRateTableser = new Fulfillment_Rates_Table__c();
        fullfillRateTableser.Active__c = true;
        fullfillRateTableser.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTableser.Site__c = objSite.Id;
        fullfillRateTableser.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTableser.Weight_lbs__c = 10;
        fullfillRateTableser.Fulfillment_Services__c = 'Pick & Pack';
        fullfillRateTableser.List_Price__c = 10;
        fullfillRateTableser.Membership_Level__c = 'Boutique';
        fullfillRateTableser.Fulfillment_Services__c = 'Service Staging';
        insert fullfillRateTableser;
       
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
        fullfillRateTable4.Fulfillment_Services__c = 'Service Staging';
        insert fullfillRateTable4;
        
        Fulfillment_Rates_Table__c fullfillRateTable5 = fullfillRateTable.clone();
        fullfillRateTable5.Fulfillment_Services__c = 'QA Review';
        insert fullfillRateTable5;
        
        Fulfillment_Rates_Table__c fullfillRateTable6 = fullfillRateTable.clone();
        fullfillRateTable6.Fulfillment_Services__c = 'Pack-Out';
        insert fullfillRateTable6;
  
        ApexPages.StandardController sc = new ApexPages.StandardController(objPO);
        RecalculateServiceInvoicePOController recal = new RecalculateServiceInvoicePOController(sc);
        
        RecalculateServiceInvoicePOController recal1 = new RecalculateServiceInvoicePOController();
        system.debug('objPO.Supplier_License__c'+objPO.Supplier_License__c);
                system.debug('objPO.objStateLicenses'+objStateLicenses.Id);

        RecalculateServiceInvoicePOController.recalculateServiceInvoicePo(objPO.id);
     //RecalculateServiceInvoicePOController.getTotalMiles(objPO.Supplier_License__c,objPO.Receiver_License__c);
 
        String FULFILLMENT_SERVICE_BOOKING = RecalculateServiceInvoicePOController.FULFILLMENT_SERVICE_BOOKING;
        String FULFILLMENT_SERVICE_STAGING = RecalculateServiceInvoicePOController.FULFILLMENT_SERVICE_STAGING;
        String FULFILLMENT_SERVICE_PICK_PACK = RecalculateServiceInvoicePOController.FULFILLMENT_SERVICE_PICK_PACK;
        
        String FULFILLMENT_SERVICE_QA_REVIEW = RecalculateServiceInvoicePOController.FULFILLMENT_SERVICE_QA_REVIEW;
        
        String FULFILLMENT_SERVICE_ORDER_BOOKING = RecalculateServiceInvoicePOController.FULFILLMENT_SERVICE_ORDER_BOOKING;
        
        String FULFILLMENT_SERVICE_STAGE_MANIFEST = RecalculateServiceInvoicePOController.FULFILLMENT_SERVICE_STAGE_MANIFEST;
        
        String FULFILLMENT_SERVICE_SCHEDULE_DISPATCH = RecalculateServiceInvoicePOController.FULFILLMENT_SERVICE_SCHEDULE_DISPATCH;
                String Invoice_Ar_Status_Shipped = RecalculateServiceInvoicePOController.Invoice_Ar_Status_Shipped;
        String INVOICE_RECORDTYPE_SERVICE = RecalculateServiceInvoicePOController.INVOICE_RECORDTYPE_SERVICE;
        String FULFILLMENT_SERVICE_PACKOUT = RecalculateServiceInvoicePOController.FULFILLMENT_SERVICE_PACKOUT;

            String PURCHASE_ORDER_STATUS_APPROVED = RecalculateServiceInvoicePOController.PURCHASE_ORDER_STATUS_APPROVED;
            //String PURCHASE_ORDER = RecalculateServiceInvoicePOController.Product_Families_to_Skip_QA_Review_Set;

        String ORDER_TYPE_RETAIL = RecalculateServiceInvoicePOController.ORDER_TYPE_RETAIL;
         String SO_SHIPPING_METHOD_PICK_UP = RecalculateServiceInvoicePOController.SO_SHIPPING_METHOD_PICK_UP;
        String SALESORDER_RECORDTYPE_Transfer = RecalculateServiceInvoicePOController.SALESORDER_RECORDTYPE_Transfer;
        String SALES_ORDER_LINE_STATUS_REJECTED = RecalculateServiceInvoicePOController.SALES_ORDER_LINE_STATUS_REJECTED;

        String PRODUCT_NAME_RECEIVING_FEE = RecalculateServiceInvoicePOController.PRODUCT_NAME_RECEIVING_FEE;

        
        String FULFILLMENT_SERVICE_SCHEDULING = RecalculateServiceInvoicePOController.FULFILLMENT_SERVICE_SCHEDULING;
                     Map<String,Fulfillment_Rates_Table__c []> serviceBasedFRTMap = new Map<String,Fulfillment_Rates_Table__c[] >();

        Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c, Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c ,Membership_Level__c
                                                     FROM Fulfillment_Rates_Table__c ORDER BY Weight_lbs__c DESC, MOQ__c DESC limit 1];
        serviceBasedFRTMap.put(FRTList[0].Fulfillment_Services__c,new Fulfillment_Rates_Table__c[]{FRTList[0]});  
                                             
                                                   
                                                     
        
        Shipping_Rates_Table__c [] mileageSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                                         Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                         FROM Shipping_Rates_Table__c 
                                                         Order By Mileage_Bracket__c];
        system.debug('mileageSRTList'+mileageSRTList);
        RecalculateServiceInvoicePOController.createWMLines = true;
          Decimal totalMiles = 123.0;
        if(RecalculateServiceInvoicePOController.createWMLines && !mileageSRTList.isEmpty()){
            
        }
        
        Test.stopTest();
        
        //recal1.redirectToRecord();
        
    }	
 
}