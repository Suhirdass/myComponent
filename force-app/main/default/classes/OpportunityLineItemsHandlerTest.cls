@isTest
public class OpportunityLineItemsHandlerTest { 
    @isTest
    public static void testOLIUpdate(){
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
        TestUtilData.skipTrigger = false;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        OpportunityLineItem oli = [SELECT Id,Quantity,MOQ__c,OpportunityId,Product2Id FROM OpportunityLineItem LIMIT 1];
        Opportunity opp = [SELECT Id, Order__c FROM Opportunity WHERE Id =: oli.OpportunityId];
        State_Licenses__c sl = [SELECT Id,Default_Warehouse__c FROM State_Licenses__c LIMIT 1];
        
        Account acc = [SELECT Id,Membership_Level__c FROM Account LIMIT 1];
        acc.Membership_Level__c = 'Boutique';
        update acc;
        
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = sl.Id;
        ord.Account__c = acc.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        //Order__c order = [SELECT Id FROM Order__c LIMIT 1];
        opp.Order__c = ord.Id;
        update opp;
        
        Fulfillment_Rates_Table__c fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = sl.Default_Warehouse__c;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Pick & Pack';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Boutique';
        insert fullfillRateTable;
        
        Shipping_Rates_Table__c ShippingRateTable = new Shipping_Rates_Table__c();
        ShippingRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        ShippingRateTable.Site__c = sl.Default_Warehouse__c;
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
        
        oli.Quantity = 2;
        oli.Ownership_Code__c=acc.Id;
        update oli;
        
        List<OpportunityLineItem> lstOli = new List<OpportunityLineItem>();
        lstOli.add(oli);
        
        OpportunityLineItemsHandler.mapOwnershipCode(lstOli);
        
        Test.stopTest();
    }
}