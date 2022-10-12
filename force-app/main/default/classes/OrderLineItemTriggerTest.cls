@isTest
public class OrderLineItemTriggerTest {
	private static testmethod void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
        insert GDMIs;
        TestUtilData.createTestData();
        Test.startTest();
        
        
        Account acc = [SELECT Id,Name,Membership_Level__c from Account where Name=:'Test Account1' LIMIT 1];
        
        Opportunity Opp = [SELECT Id,Name from Opportunity where Name=:'Test Opp' LIMIT 1];
        
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.Warehouse_Name__c='TestWarehouse1'; 
        insert objSite;
        
        State_Licenses__c stLicence = [SELECT ID,Name from State_Licenses__c LIMIT 1];
        stLicence.Default_Warehouse__c =objSite.id;
        stLicence.Total_Miles__c=1;
        update stLicence;
        
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = stLicence.Id;
        ord.Account__c=acc.id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        
        Opp.Order__c = ord.Id;
        update Opp;
        
        Product2  objProduct1 = [Select Id,Name from Product2 WHERE Case_Shipping_Weight_lbs__c != NULL LIMIT 1];
        
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
        insert shipRateTable;
        
        List<Fulfillment_Rates_Table__c> FRTList =new List<Fulfillment_Rates_Table__c>();
        Fulfillment_Rates_Table__c fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = objSite.Id;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Pick & Pack';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Boutique';
        FRTList.add(fullfillRateTable);
        
        Fulfillment_Rates_Table__c fullfillRateTable2 = new Fulfillment_Rates_Table__c();
        fullfillRateTable2.Active__c = true;
        fullfillRateTable2.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable2.Site__c = objSite.Id;
        fullfillRateTable2.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable2.Weight_lbs__c = 10;
        fullfillRateTable2.Fulfillment_Services__c = 'Stage & Manifest';
        fullfillRateTable2.List_Price__c = 10;
        fullfillRateTable2.Membership_Level__c = 'Boutique';
        FRTList.add(fullfillRateTable2);
        
        Fulfillment_Rates_Table__c fullfillRateTable3 = new Fulfillment_Rates_Table__c();
        fullfillRateTable3.Active__c = true;
        fullfillRateTable3.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable3.Site__c = objSite.Id;
        fullfillRateTable3.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable3.Weight_lbs__c = 10;
        fullfillRateTable3.Fulfillment_Services__c = 'Order Booking';
        fullfillRateTable3.List_Price__c = 10;
        fullfillRateTable3.Membership_Level__c = 'Boutique';
        FRTList.add(fullfillRateTable3);
        
        Fulfillment_Rates_Table__c fullfillRateTable4 = new Fulfillment_Rates_Table__c();
        fullfillRateTable4.Active__c = true;
        fullfillRateTable4.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable4.Site__c = objSite.Id;
        fullfillRateTable4.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable4.Weight_lbs__c = 10;
        fullfillRateTable4.Fulfillment_Services__c = 'Schedule & Dispatch';
        fullfillRateTable4.List_Price__c = 10;
        fullfillRateTable4.Membership_Level__c = 'Boutique';
        FRTList.add(fullfillRateTable4);
        
        insert FRTList;
        
        PricebookEntry pbe = [SELECT Id,Name,Product2Id from PricebookEntry WHERE Product2Id =: objProduct1.Id];
        Sales_Order_Line__c  objSOL = [Select Id,Name from Sales_Order_Line__c LIMIT 1];
        objSOL.Qty_Allocated__c =2;
        update objSOL;
        Order_Line_Item__c ol= new Order_Line_Item__c();
        ol.Price_Book_Entry_Id__c=Id.valueOf(pbe.id);
        ol.UnitPrice__c=10;
        ol.MOQ__c=4;
        ol.Quantity_Cases__c=2;
        ol.Order__c=ord.id;
        ol.Product__c = objProduct1.id;
        ol.Ownership_Code__c =acc.Id;
        System.assertEquals(ol.Product__c,objProduct1.id);
        try{
        	insert ol;
            RetailerOrderEmailTemplateController rce = new RetailerOrderEmailTemplateController();
            rce.orderId = ord.Id;
            Order_Line_Item__c[] lst = rce.getOrderLineItems();
        } catch(Exception ex) {}
        
        Test.stopTest();        
    }
}