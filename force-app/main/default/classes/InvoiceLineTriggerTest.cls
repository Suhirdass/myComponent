@isTest
public class InvoiceLineTriggerTest {
    private static testmethod void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj')};
        insert GDMIs;
        TestUtilData.createTestData();
        Test.startTest();
         
        Opportunity Opp = [SELECT Id,Name from Opportunity where Name=:'Test Opp' LIMIT 1];
        
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.Warehouse_Name__c='TestWarehouse1';
        insert objSite;
        
        State_Licenses__c stLicence = [SELECT ID,Name from State_Licenses__c LIMIT 1];
        
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = stLicence.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        
        Opp.Order__c = ord.Id;
        update Opp;

        Brand_Quote__c bq = [SELECT Id,Name,Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c from Brand_Quote__c where Opportunity_Name__c =: opp.Id LIMIT 1];
        
        Fulfillment_Rates_Table__c fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = bq.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Pick & Pack';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Boutique';
        insert fullfillRateTable;
        
        Shipping_Rates_Table__c ShippingRateTable = new Shipping_Rates_Table__c();
        ShippingRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        ShippingRateTable.Site__c = bq.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c;
        ShippingRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        ShippingRateTable.Membership_Level__c = 'Boutique';
        insert ShippingRateTable;
        
        Account acc = [SELECT Id,Membership_Level__c FROM Account LIMIT 1];
        acc.Membership_Level__c = 'Boutique';
        update acc;
        
        List<Invoice__c> lstInv = [SELECT Id,Brand_Quote__c,Supplier_Name__c,Supplier_Name__r.Membership_Level__c from Invoice__c];
        for(Invoice__c inv : lstInv){
            inv.Brand_Quote__c = bq.Id; 
            inv.Supplier_Name__c = acc.Id;
        }
        update lstInv;
        
        List<Invoice_Line__c> lstInvLine = [SELECT Id,Invoice_Qty__c from Invoice_Line__c];
        lstInvLine[0].Invoice_Qty__c = 10;
        update lstInvLine[0];
        
        System.assertEquals(Opp.Order__c ,ord.Id);
        
        Test.stopTest();        
    }
}