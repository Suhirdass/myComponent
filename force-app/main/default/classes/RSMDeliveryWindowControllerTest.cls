/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * RSMDeliveryWindowControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class RSMDeliveryWindowControllerTest{
    
    static PickList__c pickListObj;
    static Sales_Order__c salesOrderObj;
    static List<Inventory_Position__c> invPositions;
    static Shipping_Manifest__c rsmObj;
    
    // Test validate receiver account not provided
    static testMethod void testReceiverAccoutNotProvided(){
        
        // Get data created from setup
        retrieveData();
        
        // Create RSM
        rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Sales_Order__c = salesOrderObj.Id;
        rsmObj.Planned_Ship_Transfer_Date__c = System.Today();
        rsmObj.Receiver_Name__c = null;
        rsmObj.Receiver_License__c = null;
        insert rsmObj;
        
        PageReference pageRef = Page.RSMDeliveryWindow;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        // standard controller constructor
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        RSMDeliveryWindowController controllerObj = new RSMDeliveryWindowController(stdController);
        controllerObj.getDeliveryTime();
        
        System.assertEquals(true, controllerObj.recommendedTimeMessageFlag, 'Recommeded time message flag mis-match');
        System.assertEquals(Label.Receiver_Account_Is_Not_Provided, 
                           controllerObj.recommendedTimeMessage, 
                           'Recommeded time message flag mis-match');
        System.assertEquals('', controllerObj.recommendedTime, 'Recommeded time value mis-match');
    }
    
    // Test validate receiver account not provided
    static testMethod void testPlannedShipDateNotProvided(){
        
        // Get data created from setup
        retrieveData();
        
        // Create RSM 
        rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Sales_Order__c = salesOrderObj.Id;
        insert rsmObj;
        
        PageReference pageRef = Page.RSMDeliveryWindow;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        // standard controller constructor
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        RSMDeliveryWindowController controllerObj = new RSMDeliveryWindowController(stdController);
        controllerObj.getDeliveryTime();
        
        System.assertEquals(true, controllerObj.recommendedTimeMessageFlag, 'Recommeded time message flag mis-match');
        System.assertEquals(Label.Planned_ship_date_is_not_provided, 
                           controllerObj.recommendedTimeMessage, 
                           'Recommeded time message flag mis-match');
        System.assertEquals('', controllerObj.recommendedTime, 'Recommeded time value mis-match');
    }
    
    // Test validate planned ship date is past date
    static testMethod void testPlannedShipDateIsPastDate(){
        
        // Get data created from setup
        retrieveData();
        
        // Create RSM
        rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Sales_Order__c = salesOrderObj.Id;
        rsmObj.Planned_Ship_Transfer_Date__c = System.Today() - 5;
        insert rsmObj;
        
        PageReference pageRef = Page.RSMDeliveryWindow;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        // standard controller constructor
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        RSMDeliveryWindowController controllerObj = new RSMDeliveryWindowController(stdController);
        controllerObj.getDeliveryTime();
        
        System.assertEquals(true, controllerObj.recommendedTimeMessageFlag, 'Recommeded time message flag mis-match');
        System.assertEquals(Label.Planned_ship_transfer_date_is_past_date, 
                           controllerObj.recommendedTimeMessage, 
                           'Recommeded time message flag mis-match');
        System.assertEquals('', controllerObj.recommendedTime, 'Recommeded time value mis-match');
    }
    
    // Test validate no delivery found
    static testMethod void testNoDeliveryWindowFound(){
        
        // Get data created from setup
        retrieveData();
        
        // Create RSM
        rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Sales_Order__c = salesOrderObj.Id;
        rsmObj.Planned_Ship_Transfer_Date__c = System.Today();
        insert rsmObj;
        
        PageReference pageRef = Page.RSMDeliveryWindow;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        // standard controller constructor
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        RSMDeliveryWindowController controllerObj = new RSMDeliveryWindowController(stdController);
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
        
        // Create RSM
        rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Sales_Order__c = salesOrderObj.Id;
        rsmObj.Planned_Ship_Transfer_Date__c = System.Today();
        insert rsmObj;
        
        // Create delivery window
        List<Delivery_Window__c> deliveryWindows = new List<Delivery_Window__c>();
        deliveryWindows.add(TestUtilData.createDeliveryWindow(rsmObj.Receiver_Name__c, 'Monday', '06:00 AM PST', '09:00 PM PST', true, false));
        deliveryWindows.add(TestUtilData.createDeliveryWindow(rsmObj.Receiver_Name__c, 'Tuesday', '06:00 AM PST', '09:00 PM PST', true, false));
        deliveryWindows.add(TestUtilData.createDeliveryWindow(rsmObj.Receiver_Name__c, 'Wednesday', '06:00 AM PST', '09:00 PM PST', true, false));
        deliveryWindows.add(TestUtilData.createDeliveryWindow(rsmObj.Receiver_Name__c, 'Thursday', '06:00 AM PST', '09:00 PM PST', true, false));
        deliveryWindows.add(TestUtilData.createDeliveryWindow(rsmObj.Receiver_Name__c, 'Friday', '06:00 AM PST', '09:00 PM PST', true, false));
        deliveryWindows.add(TestUtilData.createDeliveryWindow(rsmObj.Receiver_Name__c, 'Saturday', '06:00 AM PST', '09:00 PM PST', true, false));
        deliveryWindows.add(TestUtilData.createDeliveryWindow(rsmObj.Receiver_Name__c, 'Sunday', '10:00 AM PST', '01:00 PM PST', false, false));
        insert deliveryWindows;
        
        PageReference pageRef = Page.RSMDeliveryWindow;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        // standard controller constructor
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        RSMDeliveryWindowController controllerObj = new RSMDeliveryWindowController(stdController);
        controllerObj.getDeliveryTime();
        
        System.assertEquals(false, controllerObj.recommendedTimeMessageFlag, 'Recommeded time message flag mis-match');
        System.assertEquals('', 
                           controllerObj.recommendedTimeMessage, 
                           'Recommeded time message flag mis-match');
        System.assertNotEquals('', controllerObj.recommendedTime, 'Recommeded time value mis-match');
    }
    
    @TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
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
                                Supplier_Name__c
                                from Sales_Order__c];
        
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        
        pickListObj = [Select Sales_Order__r.Brand_Quote__c,
                       Sales_Order__r.Customer_PO_or_Quote__c,
                       Sales_Order__r.Distributor_Contact__c,
                       Sales_Order__r.Distributor_License__c,
                       Sales_Order__r.Distributor_Name__c,
                       Sales_Order__r.Opportunity_Name__c,
                       Sales_Order__r.Payment_Terms__c,
                       Sales_Order__r.Planned_Ship_Date__c,
                       Sales_Order__r.Receiver_Contact__c,
                       Sales_Order__r.Receiver_License__c,
                       Sales_Order__r.Receiver_Name__c,
                       Sales_Order__r.Sample_Order__c,
                       Sales_Order__r.Shipping_Method__c,
                       Sales_Order__r.Shipping_Terms__c,
                       Sales_Order__r.Supplier_Contact__c,
                       Sales_Order__r.Supplier_License__c,
                       Sales_Order__r.Supplier_Name__c,
                       Site__c,
                       Status__c
                From Picklist__c];
    }
}