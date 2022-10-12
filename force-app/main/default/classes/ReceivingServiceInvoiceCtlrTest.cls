@isTest
public class ReceivingServiceInvoiceCtlrTest {
    private static testmethod void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
        insert GDMIs;
        
        Document documentObj;
        
        documentObj = new Document();
        documentObj.Body = Blob.valueOf('Some Document Text For Test Class');
        documentObj.ContentType = 'application/pdf';
        documentObj.DeveloperName = 'TestX8300'; 
        documentObj.IsPublic = true;
        documentObj.Name = 'Test 8300';
        documentObj.FolderId = [select id from folder where name = 'Shared Documents'].id;
        insert documentObj;
        
        Site__c objSite = new Site__c();
        objSite.Name = '2089-3';
        objSite.Warehouse_Name__c='TestWarehouse1';
        insert objSite;
        
        Account acc = new Account();//Disty Partner
        acc.Name = 'Test Account';
        acc.Type ='Disty Partner';
        //acc.Membership_Level__c = 'Boutique';
        insert acc;
        
        Account acc2 = new Account();
        acc2.Name = 'Test Account2';
        acc2.Type ='Disty Partner';
        //acc.Membership_Level__c = 'Boutique';
        insert acc2;
        
        Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
        objContact.AccountId = acc.Id;
        insert objContact;
        
        Id SLRecordTypeId = Schema.SObjectType.State_Licenses__c.getRecordTypeInfosByName().get('License Holder').getRecordTypeId();
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = acc.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        objStateLicenses.Default_Warehouse__c = objSite.Id;
        objStateLicenses.RecordTypeId = SLRecordTypeId;
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_State__c = 'California';
        objStateLicenses.License_City__c = 'San Francisco';
        objStateLicenses.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses.License_Zip__c = '94124';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses.Total_Miles__c = 10;
        insert objStateLicenses;
        
        
        Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Default_License__c =objStateLicenses.Id,Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,Default_Distributor__c  = acc.Id,LateFee__c = 0.020,Route_Origin_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US',Route_Destination_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US');
        ccs.Second_Warehouse_Id__c = acc.Id;
        ccs.Second_Warehouse_License__c = objStateLicenses.Id;
        insert ccs;
        
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
        salesOrder.Site__c =objSite.id;
        salesOrder.Ownership__c =acc.id;
        insert salesOrder;
        
        Id devRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Product').getRecordTypeId();
        Product2  objProd = new Product2 ();
        objProd.RecordTypeId = devRecordTypeId;
        objProd.Name = 'Pick & Pack';
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
        oli.Pick_Pack_Fee__c = 10;
        oli.Status__c = 'Open';
        insert oli;
        
        Sales_Order_Line__c SOLineDetails = oli;
        
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
            
        ReceivingServiceInvoiceCtlr.getSalesOrderDetails(salesOrder.Id);
        
        ReceivingServiceInvoiceCtlr.SOLineDetails soLine = new ReceivingServiceInvoiceCtlr.SOLineDetails(SOLineDetails);
        ReceivingServiceInvoiceCtlr.ProducerDetails  ProducerDetails = new ReceivingServiceInvoiceCtlr.ProducerDetails(acc.Id,acc.Name,2,soLine);
        
        ProducerDetails.isSelected = true;
        
        List<ReceivingServiceInvoiceCtlr.ProducerDetails> lstProduct = new List<ReceivingServiceInvoiceCtlr.ProducerDetails>();
        lstProduct.add(ProducerDetails);
        
        String jsonProduct = JSON.serialize(lstProduct);
        
        ReceivingServiceInvoiceCtlr.createInvoices(salesOrder.Id,jsonProduct,true);
        
    }
    
}