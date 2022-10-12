@istest
private class AutoCancelOrdersEmailTemplateCtrlTest {
	@isTest
    static void theTests(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?')};
        insert GDMIs;
        
        Account a = new Account(Name = 'Irrational Raccoon, LLC');
        //a.Membership_Level__c = 'Boutique';
        insert a;
        
        Site__c objSite = new Site__c();
        objSite.Name = '2089-3';
        insert objSite;
        
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = a.id;
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
        
        Order__c ord= new Order__c();
        ord.Status__c='Draft';
        ord.Order_Date__c=Date.today();
        ord.Account__c= a.Id;
        ord.State_License__c = objStateLicenses.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        
        Order__c ord2= new Order__c();
        ord2.Status__c='Pending';
        ord2.Order_Date__c=Date.today();
        ord2.Account__c= a.Id;
        ord2.State_License__c = objStateLicenses.Id;
        ord2.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord2;
        
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        //Create Product1
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = a.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.RecordTypeId = productRecordTypeId;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        insert objProduct1;
        
        
        // Create price book entry for first product
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id=Test.getStandardPricebookId(), Product2Id=objProduct1.Id, UnitPrice=99, isActive=true);
        insert pbe;
        
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
        
        Order_Line_Item__c ol= new Order_Line_Item__c();
        ol.Price_Book_Entry_Id__c=Id.valueOf(pbe.id);
        ol.UnitPrice__c=10;
        ol.MOQ__c=4;
        ol.Quantity_Cases__c=2;
        ol.Order__c=ord.id;
        ol.Product__c = objProduct1.id;
        insert ol;
        
        List<string>holidayList = new List<string>();
        for(Holiday  businessHolidDay : [SELECT IsRecurrence,ActivityDate,RecurrenceMonthOfYear,RecurrenceEndDateOnly,RecurrenceInstance,RecurrenceDayOfWeekMask,RecurrenceInterval,RecurrenceType FROM Holiday]){
            holidayList.add(String.valueOf(businessHolidDay.ActivityDate));
        }
        
        AutoCancelOrdersEmailTemplateController autoCancel= new AutoCancelOrdersEmailTemplateController();
        autoCancel.checkifItisWorkingDay(Date.today(),holidayList);
    }
}