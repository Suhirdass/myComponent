@isTest
public class PurchaseOrderCreateInvoiceControllerTest {
    static testMethod void  runTest (){
        test.startTest();
        TestUtilData.skipTrigger = true;
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
            insert GDMIs;
         TestUtilData.createTestData();
        Site__c s =[SELECT Id From Site__c Limit 1];
        Account acc =[SELECT Id From Account WHERE Name=:'Test Account1' Limit 1];
        State_Licenses__c stLicence = new State_Licenses__c();
        stLicence.License_Name__c = acc.id;
        stLicence.License_Number__c = 'AbcTest12345';
        stLicence.License_Status__c ='Active';
        stLicence.License_Type__c ='Type 1';
        stLicence.Default_Warehouse__c = s.Id;
        stLicence.License_Class__c='A-License';
        stLicence.License_State__c = 'California';
        stLicence.License_City__c = 'San Francisco';
        stLicence.License_Address__c = '2089 Ingalls St. Unit 3';
        stLicence.License_Zip__c = '94124';
        stLicence.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        stLicence.Total_Miles__c = 10;
        stLicence.RecordTypeId =Schema.SObjectType.State_Licenses__c.getRecordTypeInfosByDeveloperName().get('NonCannabis').getRecordTypeId();
        insert stLicence;
        State_Licenses__c sl = new State_Licenses__c();
        sl.License_Name__c = acc.Id;
        sl.License_Class__c = 'A-License';
        sl.License_Type__c = 'Type 11';
        sl.License_Number__c = 'A11-18-0000054-TEMP';
        sl.License_Status__c = 'Active';
        sl.License_Expiration_Date__c = System.today().addDays(60);
        sl.License_Address__c = '44650 101 Hwy N, Suite F';
        sl.License_City__c = 'Lafayette';
        sl.License_State__c = 'California';
        sl.License_Zip__c = '95454';
        sl.License_Country__c = 'US';
        sl.Default_Warehouse__c = s.Id;
        sl.Total_Miles__c=1;
        insert sl; 
        
        Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,Default_Distributor__c  = acc.Id,Default_License__c = sl.Id,LateFee__c = 0.020,Route_Origin_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US',Route_Destination_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US');
        insert ccs;
        
         Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = stLicence.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Transfer').getRecordTypeId();
        insert ord;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName ='Qualification';
        opp.Site_Name__c = s.Id;
        opp.Ownership__c = acc.id;
        opp.Payment_Terms__c = 'COD';
        opp.Order__c = ord.Id;
        Opp.Order__c = ord.Id;
        insert opp;
        
        Brand_Quote__c bq = new Brand_Quote__c ();
        bq.Opportunity_Name__c = opp.id; 
        bq.Distributor_License__c = stLicence.id;
        bq.Receiver_License__c = stLicence.id;
        bq.Distributor_Name__c = acc.id;
        bq.Supplier_Name__c = acc.id;
        bq.Receiver_Name__c = acc.id;
        bq.Supplier_License__c = stLicence.id;
        bq.BQ_Status__c = 'Draft';
        bq.Shipping_Method__c = 'Distributor Pick-up';
        bq.Sales_Origin__c = 'Brand';
        bq.Shipping_Terms__c = 'CFR';        
        bq.Site__c = s.id;
        bq.Ownership__c = opp.Ownership__c;
        bq.Payment_Terms__c = opp.Payment_Terms__c;
        bq.Apply_Excise_Tax__c = true;
        bq.Order_Type__c = '';
        bq.Opportunity_Name__c = Opp.Id;
        
        insert bq;  
        
        Purchase_Order__c  po = [Select Id,PO_Status__c,Site__c,Ownership__c,Supplier_Name__c,Supplier_License__c,Distributor_Name__c
                                 ,Distributor_License__c,Receiver_Name__c,Brand_Quote__c,Brand_Quote__r.Order_Type__c,Receiver_License__c from Purchase_Order__c LIMIT 1];
        po.Brand_Quote__c = bq.id;
        po.PO_Status__c='Closed';
        po.Total_Weight_Fee__c =1;
        po.Service_Booking_Fee__c = 1;
        PO.Shipping_Method__c ='Distributor Pick-up';
        po.Goods_Receipt_Date__c=system.today();
        update po;
        PurchaseOrderCreateInvoiceController.getRecordName(po.id);
        PurchaseOrderCreateInvoiceController.createInvoice(po.id,true);
        string status ;
            status = PurchaseOrderCreateInvoiceController.SITE_NAME_7027;
        status = PurchaseOrderCreateInvoiceController.SITE_NAME_2089;
        status = PurchaseOrderCreateInvoiceController.Err_Msg_PO_Create_Service_Invoice;
        status = PurchaseOrderCreateInvoiceController.PRODUCT_NAME_PICK_AND_PACK_FEE;
        status = PurchaseOrderCreateInvoiceController.PRODUCT_NAME_QA_REVIEW_FEE;
        status = PurchaseOrderCreateInvoiceController.PRODUCT_NAME_ORDER_BOOKING;
        status = PurchaseOrderCreateInvoiceController.PRODUCT_NAME_PACK_OUT;
        status = PurchaseOrderCreateInvoiceController.PRODUCT_NAME_PACK_OUT;
        status = PurchaseOrderCreateInvoiceController.PRODUCT_NAME_SCHEDULE_AND_DISPATCH;
        status = PurchaseOrderCreateInvoiceController.PRODUCT_NAME_STAGE_AND_MANIFEST;
        status = PurchaseOrderCreateInvoiceController.PRODUCT_NAME_CHANGE_ORDER_FEE;
           status = PurchaseOrderCreateInvoiceController.STANDARD_PRICE_BOOK;
        //po.Total_Mileage_Fee__c =1;
        //update po;
        //PurchaseOrderCreateInvoiceController.createInvoice(po.id);
       PurchaseOrderCreateInvoiceController.createCTI(po.id);
         Test.stopTest();
    }
}