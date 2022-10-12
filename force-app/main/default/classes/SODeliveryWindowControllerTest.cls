/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * SODeliveryWindowControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class SODeliveryWindowControllerTest{
    
    static Sales_Order__c salesOrderObj;
    static List<Inventory_Position__c> invPositions;
    
    // Test validate receiver account not provided
    static testMethod void testReceiverAccoutNotProvided(){
        
        // Get data created from setup
        retrieveData();
        
        salesOrderObj.Planned_Ship_Date__c = System.Today();
        salesOrderObj.Receiver_Name__c = null;
        salesOrderObj.Receiver_License__c = null;
        //update salesOrderObj;
        
        PageReference pageRef = Page.SODeliveryWindow;
        pageRef.getParameters().put('id', salesOrderObj.Id);
        Test.setCurrentPage(pageRef);
        
        // standard controller constructor
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderObj);
        SODeliveryWindowController controllerObj = new SODeliveryWindowController(stdController);
        controllerObj.getDeliveryTime();
        
      
    }
    
    // Test validate receiver account not provided
    static testMethod void testPlannedShipDateNotProvided(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        // Get data created from setup
        retrieveData();
        
        PageReference pageRef = Page.SODeliveryWindow;
        pageRef.getParameters().put('id', salesOrderObj.Id);
        Test.setCurrentPage(pageRef);
        
        // standard controller constructor
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderObj);
        SODeliveryWindowController controllerObj = new SODeliveryWindowController(stdController);
        controllerObj.getDeliveryTime();
        
      //  System.assertEquals(true, controllerObj.recommendedTimeMessageFlag, 'Recommeded time message flag mis-match');
       // System.assertEquals(Label.Planned_ship_date_is_not_provided, 
                        //   controllerObj.recommendedTimeMessage, 
                        //   'Recommeded time message flag mis-match');
      //  System.assertEquals('', controllerObj.recommendedTime, 'Recommeded time value mis-match');
    }
    
    // Test validate planned ship date is past date
    static testMethod void testPlannedShipDateIsPastDate(){
        
        // Get data created from setup
        retrieveData();
           Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        salesOrderObj.Planned_Ship_Date__c = System.Today() - 5;
       // update salesOrderObj;
        
        PageReference pageRef = Page.SODeliveryWindow;
        pageRef.getParameters().put('id', salesOrderObj.Id);
        Test.setCurrentPage(pageRef);
        
        // standard controller constructor
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderObj);
        SODeliveryWindowController controllerObj = new SODeliveryWindowController(stdController);
        controllerObj.getDeliveryTime();
        
       
    }
    
    // Test validate no delivery found
    static testMethod void testNoDeliveryWindowFound(){
        
        // Get data created from setup
        retrieveData();
           Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        salesOrderObj.Planned_Ship_Date__c = System.Today();
      //  update salesOrderObj;
        
        PageReference pageRef = Page.SODeliveryWindow;
        pageRef.getParameters().put('id', salesOrderObj.Id);
        Test.setCurrentPage(pageRef);
        
        // standard controller constructor
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderObj);
        SODeliveryWindowController controllerObj = new SODeliveryWindowController(stdController);
        controllerObj.getDeliveryTime();
        
        System.assertEquals(true, controllerObj.recommendedTimeMessageFlag, 'Recommeded time message flag mis-match');
        System.assertEquals(Label.No_delivery_window_found, 
                           controllerObj.recommendedTimeMessage, 
                           'Recommeded time message flag mis-match');
        System.assertEquals('', controllerObj.recommendedTime, 'Recommeded time value mis-match');
    }
    
    // Test display delivery window time
    static testMethod void testDisplayDeliveryWindowTime(){
        
        // Get data created from setup
        retrieveData();
           Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        salesOrderObj.Payment_Terms__c = 'NET 30';
       // update salesOrderObj;
        
        // Create delivery window
        List<Delivery_Window__c> deliveryWindows = new List<Delivery_Window__c>();
        deliveryWindows.add(TestUtilData.createDeliveryWindow(salesOrderObj.Receiver_Name__c, 'Monday', '06:00 AM PST', '09:00 PM PST', true, false));
        deliveryWindows.add(TestUtilData.createDeliveryWindow(salesOrderObj.Receiver_Name__c, 'Tuesday', '06:00 AM PST', '09:00 PM PST', true, false));
        deliveryWindows.add(TestUtilData.createDeliveryWindow(salesOrderObj.Receiver_Name__c, 'Wednesday', '06:00 AM PST', '09:00 PM PST', true, false));
        deliveryWindows.add(TestUtilData.createDeliveryWindow(salesOrderObj.Receiver_Name__c, 'Thursday', '06:00 AM PST', '09:00 PM PST', true, false));
        deliveryWindows.add(TestUtilData.createDeliveryWindow(salesOrderObj.Receiver_Name__c, 'Friday', '06:00 AM PST', '09:00 PM PST', true, false));
        deliveryWindows.add(TestUtilData.createDeliveryWindow(salesOrderObj.Receiver_Name__c, 'Saturday', '06:00 AM PST', '09:00 PM PST', true, false));
        deliveryWindows.add(TestUtilData.createDeliveryWindow(salesOrderObj.Receiver_Name__c, 'Sunday', '10:00 AM PST', '01:00 PM PST', false, false));
        insert deliveryWindows;
        
        PageReference pageRef = Page.SODeliveryWindow;
        pageRef.getParameters().put('id', salesOrderObj.Id);
        Test.setCurrentPage(pageRef);
        
        // standard controller constructor
        ApexPages.StandardController stdController = new ApexPages.StandardController(salesOrderObj);
        SODeliveryWindowController controllerObj = new SODeliveryWindowController(stdController);
        controllerObj.getDeliveryTime();
        
        System.assertEquals(false, controllerObj.recommendedTimeMessageFlag, 'Recommeded time message flag mis-match');
        System.assertEquals('', 
                           controllerObj.recommendedTimeMessage, 
                           'Recommeded time message flag mis-match');
        //System.assertNotEquals('', controllerObj.recommendedTime, 'Recommeded time value mis-match');
    }
    
    @TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
           Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        invPositions = [Select Sales_Order_Line__c,
                               Sales_Order_Line__r.Product_Name__c,
                               Inventory_Location__r.Name,
                               Inventory_Location__c,
                               Rack__c,
                               Rack_Level__c,
                               Bin_Location__c
                               From Inventory_Position__c];
                               
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Site__c,
                                Brand_Quote__c,
                                Customer_PO_or_Quote__c,
                                Distributor_Contact__c,
                                Distributor_License__c,
                                Distributor_Name__c,
                                Opportunity_Name__c,
                                Payment_Terms__c,
                                Receiver_Contact__c,
                                Receiver_License__c,
                                Receiver_Name__c,
                                Sample_Order__c,
                                Shipping_Method__c,
                                Shipping_Terms__c,
                                Supplier_Contact__c,
                                Supplier_License__c,
                                Supplier_Name__c,
                                Planned_Ship_Date__c
                                from Sales_Order__c];
    }
}