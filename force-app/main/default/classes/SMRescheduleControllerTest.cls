/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * SMRescheduleControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class SMRescheduleControllerTest{
    
    static PickList__c pickListObj;
    static Drivers__c driverObj;
    static Vehicles__c vehicleObj;
    static List<PickList_Line__c> pickListLines;
    static Sales_Order__c salesOrderObj;
    static List<Sales_Order_Line__c> soLines;
    static List<Inventory_Position__c> invPositions;
    static Shipping_Manifest__c rsmObj;
    static Account acc;
    static Invoice__c inv;
    static List<Invoice_Line__c> lstInvLine;
    static Order__c ord ;
    
    // Test Validate RSM with "Shipment Complete" status
    static testMethod void testValidateReschedule_RSM_Shipment_Complete_Status(){
        TestUtilData.skipTrigger = true;
        // Get data created from setup
        retrieveData();
        
        // Create Driver
        driverObj = TestUtilData.createDriver(true);
        
        rsmObj = new Shipping_Manifest__c();
        rsmObj.Status__c = RSMSupport.SHIPPING_MANIFEST_STATUS_COMPLETE ;
        rsmObj.Driver__c = driverObj.Id;
        insert rsmObj;
        
        
        PageReference pageRef = Page.SMReschedule;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        SMRescheduleController controllerObj = new SMRescheduleController(stdController);
        SMRescheduleController.rescheduleByCustomer(rsmObj.Id,'customer','Insufficient Funds','test',null,'','');
        //SMRescheduleController.getRecordName(rsmObj.Id); 
        pageRef = controllerObj.smReschedule();
        controllerObj.redirectToRSM();
        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.SM_Reschedule_Status_Validation), 'Validation message mis-match');
        
        
        
    }
    
    // Test pass all validations of Reschedule and validate updated records - RSM Status is Shipment Pending
   static testMethod void testPassAllValidationOfReschedule_Status_Shipment_Pending(){
        TestUtilData.skipTrigger = true;
        // Get data created from setup
        retrieveData();
        
        // Update SO lines in Inventory positions
        for(Integer i=0; i<2; i++){
            invPositions[i].Sales_Order_Line__c = soLines[i].Id;
        }
        update invPositions;
        
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        
        // Create Driver
        driverObj = TestUtilData.createDriver(true);
        
        // Create Vehicle
        vehicleObj = TestUtilData.createVehicle(false);
        insert vehicleObj;
        
        pickListObj = new PickList__c();
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
                
        picklistLines = new List<PickList_Line__c>();
        picklistLines = [Select Product_Name__c,
                               Sales_Order_Line__r.Product_Name__c,
                               Sales_Order_Line__r.Product_Title__c,
                               Sales_Order_Line__r.Qty_Allocated__c,
                               Sales_Order_Line__r.Retail_Wholesale_Price__c,
                               Sales_Order_Line__r.UID__c,
                               Inventory_Location__c
                        From Picklist_Line__c];
        
        // Create RSM 
        rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Driver__c = driverObj.Id;
        rsmObj.Vehicle__c = vehicleObj.Id;
       	rsmObj.Status__c = 'In-Transit';
        rsmObj.Sales_Order__c = salesOrderObj.id;
        insert rsmObj;
        
       List<Shipping_Manifest_Line__c> rsmLines = new List<Shipping_Manifest_Line__c>();
        for(PickList_Line__c picklistLineSO : pickListLines){
            rsmLines.add(TestUtilData.createRSMLine(picklistLineSO, rsmObj.Id, false));
        }
        insert rsmLines;
       
        
        pageReference pageRef = Page.SMReschedule;
        pageRef.getParameters().put('id', rsmObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(rsmObj);
        SMRescheduleController controllerObj = new SMRescheduleController(stdController);
        SMRescheduleController.smRescheduleLight(rsmObj.Id,'customer');
        // SMRescheduleController.getRecordName(rsmObj.Id);
       
    }
   
    // Test pass all validations of Reschedule and validate updated records - RS status is In-Transit
    static testMethod void testPassAllValidationOfReschedule_Status_In_Transit(){
        TestUtilData.skipTrigger = true;
        OrderHelper.runningTrigger = true;
        // Get data created from setup
        retrieveData();
        
        
        // Update SO lines in Inventory positions
        for(Integer i=0; i<2; i++){
            invPositions[i].Sales_Order_Line__c = soLines[i].Id;
        }
        update invPositions;
        
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        
        // Create Driver
        driverObj = TestUtilData.createDriver(true);
        
        // Create Vehicle
        vehicleObj = TestUtilData.createVehicle(false);
        insert vehicleObj;
        
        pickListObj = new PickList__c();
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
                       Site__c,Sales_Order__c,
                       Status__c
                From Picklist__c];
                
        picklistLines = new List<PickList_Line__c>();
        picklistLines = [Select Product_Name__c,
                               Sales_Order_Line__r.Product_Name__c,
                               Sales_Order_Line__r.Product_Title__c,
                               Sales_Order_Line__r.Qty_Allocated__c,
                               Sales_Order_Line__r.Retail_Wholesale_Price__c,
                               Sales_Order_Line__r.UID__c,
                               Inventory_Location__c
                        From Picklist_Line__c];
        
        
        // Create RSM 
        rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Driver__c = driverObj.Id;
        rsmObj.Vehicle__c = vehicleObj.Id;
        rsmObj.Status__c = 'In-Transit';
        rsmObj.Sales_Order__c = salesOrderObj.id;
        insert rsmObj;
        
       List<Shipping_Manifest_Line__c> rsmLines = new List<Shipping_Manifest_Line__c>();
        for(PickList_Line__c picklistLineSO : pickListLines){
            rsmLines.add(TestUtilData.createRSMLine(picklistLineSO, rsmObj.Id, false));
        }
        insert rsmLines;
       
        SMRescheduleController.rescheduleByCustomer(rsmObj.Id,'customer','Insufficient Funds','test',system.today(),'08:00 AM','08:00 PM');
        SMRescheduleController.getMonthNumber('January');
        SMRescheduleController.getMonthNumber('February');
            SMRescheduleController.getMonthNumber('March');
            SMRescheduleController.getMonthNumber('April');
            SMRescheduleController.getMonthNumber('May');
            SMRescheduleController.getMonthNumber('June');
            SMRescheduleController.getMonthNumber('July');
            SMRescheduleController.getMonthNumber('August');
            SMRescheduleController.getMonthNumber('September');
            SMRescheduleController.getMonthNumber('October');
            SMRescheduleController.getMonthNumber('November');
            SMRescheduleController.getMonthNumber('December');
        
        //pageRef = controllerObj.smReschedule();
        /*System.assertEquals('/'+String.valueOf(rsmObj.Id).subString(0, 15), 
                            pageRef.getURL(), 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match'); */
        
        // Verify updated RSM status, actual departure time 
        /*rsmObj = [Select Status__c, 
                         Actual_Departure_Date_Time__c,
                         Ship_Confirmation_Date__c,
                         Actual_Arrival_Date_Time__c,
                         Receiver_Acceptance_Date__c
                         From Shipping_Manifest__c
                      Where Id =: rsmObj.Id];
        
        //System.assertEquals(RSMSupport.STATUS_DRAFT, 
        //                    rsmObj.Status__c, 'RSM Status mis-match');
        System.assertEquals(null, 
                            rsmObj.Actual_Departure_Date_Time__c, 'RSM actual departure date time mis-match');
        System.assertEquals(null, 
                            rsmObj.Ship_Confirmation_Date__c, 'RSM ship confirmation date mis-match');
        System.assertEquals(null, 
                            rsmObj.Actual_Arrival_Date_Time__c, 'RSM actual arrival date time mis-match');
        System.assertEquals(null, 
                            rsmObj.Receiver_Acceptance_Date__c, 'RSM receiver acceptance date mis-match');*/
        
        // Verify updated inventory positions
        /*invPositions = invPositions = [Select Site__c, 
                                       Inventory_Location__r.Name,
                                       Rack__r.Name, 
                                       Rack_Level__r.Name, 
                                       Bin_Location__r.Name
                                       From Inventory_Position__c];
        for(Inventory_Position__c invPosition : invPositions){
            System.assertEquals(PicklistSupport.STATUS_QA_REVIEW, invPosition.Inventory_Location__r.Name,
                                'Inventory Location mis-match');
            System.assertEquals(PicklistSupport.STATUS_QA_REVIEW, invPosition.Rack__r.Name,
                                'Rack mis-match');
            System.assertEquals(PicklistSupport.STATUS_QA_REVIEW, invPosition.Rack_Level__r.Name,
                                'Rack Level mis-match');
            System.assertEquals(PicklistSupport.STATUS_QA_REVIEW, invPosition.Bin_Location__r.Name,
                                'Bin Location mis-match');
        }*/
        
        // Verify updated picklist status
        /*pickListObj = [Select Status__c From Picklist__c Where Id =: pickListObj.Id];
        System.assertEquals(PicklistSupport.STATUS_QA_REVIEW, 
                            pickListObj.Status__c, 'Picklist Status mis-match');*/
    }
    private static testmethod void testEmail(){
        TestUtilData.skipTrigger = true;
        OrderHelper.runningTrigger = true;
        retrieveData();
        
        
        // Update SO lines in Inventory positions
        for(Integer i=0; i<2; i++){
            invPositions[i].Sales_Order_Line__c = soLines[i].Id;
        }
        update invPositions;
        
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        
        // Create Driver
        driverObj = TestUtilData.createDriver(true);
        
        // Create Vehicle
        vehicleObj = TestUtilData.createVehicle(false);
        insert vehicleObj;
        
        pickListObj = new PickList__c();
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
                
        picklistLines = new List<PickList_Line__c>();
        picklistLines = [Select Product_Name__c,
                               Sales_Order_Line__r.Product_Name__c,
                               Sales_Order_Line__r.Product_Title__c,
                               Sales_Order_Line__r.Qty_Allocated__c,
                               Sales_Order_Line__r.Retail_Wholesale_Price__c,
                               Sales_Order_Line__r.UID__c,
                               Inventory_Location__c
                        From Picklist_Line__c];
        
        // Create RSM 
        rsmObj = TestUtilData.createRSM(pickListObj, false);
        rsmObj.Driver__c = driverObj.Id;
        rsmObj.Vehicle__c = vehicleObj.Id;
       	rsmObj.Status__c = 'In-Transit';
        rsmObj.Sales_Order__c = salesOrderObj.id;
        insert rsmObj;
        
       List<Shipping_Manifest_Line__c> rsmLines = new List<Shipping_Manifest_Line__c>();
        for(PickList_Line__c picklistLineSO : pickListLines){
            rsmLines.add(TestUtilData.createRSMLine(picklistLineSO, rsmObj.Id, false));
        }
        insert rsmLines;
        
        Product2  objProduct1 = [Select Id,Name from Product2 LIMIT 1];
        
        PricebookEntry pbe = [SELECT Id,Name,Product2Id from PricebookEntry WHERE Product2Id =: objProduct1.Id];
        
        Order_Line_Item__c ol= new Order_Line_Item__c();
        ol.Price_Book_Entry_Id__c=Id.valueOf(pbe.id);
        ol.UnitPrice__c=10;
        ol.MOQ__c=4;
        ol.Quantity_Cases__c=2;
        ol.Order__c=ord.id;
        ol.Product__c = objProduct1.id;
        insert ol;
        SMRescheduleController.sendEmailByWovn(ord.id,system.today(),'');
         SMRescheduleController.getRecordName(rsmObj.Id);
    }
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        TestUtilData.skipTrigger = true;
        OrderHelper.runningTrigger = true;
        TestUtilData.createTestData();
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        TestUtilData.skipTrigger = true;
        OrderHelper.runningTrigger = true;
        acc = [SELECT id FROM Account LIMIT 1];
        contact con = new Contact();
        con.FirstName = 'test';
        con.LastName = 'con';
        con.Email = 'test@test.com';
        con.AccountId = acc.Id;
        insert con;
        invPositions = [Select Sales_Order_Line__c,
                               Sales_Order_Line__r.Product_Name__c,
                               Inventory_Location__r.Name
                               From Inventory_Position__c];
        Site__c objSite = new Site__c();
        objSite.Name = '7027-CP';
        objSite.Warehouse_Name__c='TestWarehouse1';
        insert objSite;
        State_Licenses__c stLicence = new State_Licenses__c();
        stLicence.License_Name__c = acc.id;
        stLicence.License_Number__c = 'AbcTest12345';
        stLicence.License_Status__c ='Active';
        stLicence.License_Type__c ='Type 1';
        stLicence.Default_Warehouse__c = objSite.Id;
        stLicence.License_Class__c='A-License';
        stLicence.License_State__c = 'California';
        stLicence.License_City__c = 'San Francisco';
        stLicence.License_Address__c = '2089 Ingalls St. Unit 3';
        stLicence.License_Zip__c = '94124';
        stLicence.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        stLicence.Total_Miles__c = 10;
        stLicence.RecordTypeId =Schema.SObjectType.State_Licenses__c.getRecordTypeInfosByDeveloperName().get('NonCannabis').getRecordTypeId();
        insert stLicence;
        
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
        
        ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = stLicence.Id;
        ord.Request_Ship_Date__c = system.today();
        ord.Requested_Delivery_Earliest_Time__c = DateTime.now().Time();
        ord.Requested_Delivery_Latest_Time__c = DateTime.now().Time();
        ord.Retailer_Contact__c = con.Id;
        ord.Planned_Ship_Date__c = system.today();
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        Opportunity Opp = [SELECT Id,Name from Opportunity where Name=:'Test Opp' LIMIT 1];
        opp.Order__c = ord.id;
        update opp;
        
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
            .get('Product').getRecordTypeId();
        Product2  objProduct1 = [SELECT Id FROM Product2 WHERE Name =:'Weight Fee'];
        
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.Apply_Cultivation_Tax__c='No';
        objProduct1.Apply_Excise_Tax__c='No';
        objProduct1.Is_Sample__c = true;
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10;
        objProduct1.Unit_Length__c = 10;
        objProduct1.Unit_Width__c = 5;
        objProduct1.RecordTypeId = productRecordTypeId;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        objProduct1.Unit_Gross_Weight__c = 10;
        objProduct1.Retail_Unit_Form_Factor__c  ='Jar';
        objProduct1.Unit_Radius__c =3;
        
        update objProduct1;
        
        Product2  objProduct2 = [SELECT Id FROM Product2 WHERE Name =:'Stage & Manifest'];
        
        objProduct2.Quantity_Type__c = 'Quantity';
        objProduct2.Family = 'Accessories';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = acc.id;
        objProduct2.Apply_Cultivation_Tax__c='Yes';
        objProduct2.Apply_Excise_Tax__c='Yes';
        objProduct2.IsActive = true;
        objProduct2.Unit_Height__c  = 20.0;
        objProduct2.Unit_Length__c = 10.0;
        objProduct2.Unit_Width__c = 5.0;
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.RecordTypeId = productRecordTypeId;
        objProduct2.Track_Trace_Category__c='Capsule';
        objProduct2.Net_Weight_UOM__c='EA';
        objProduct2.Unit_Of_Measure__c='Grams';
        objProduct2.MOQ__c = 10;
        update objProduct2;
       
              
        
        Brand_Quote__c bq = [SELECT Id,Name,Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c from Brand_Quote__c where Opportunity_Name__c =: opp.Id LIMIT 1];
        bq.Opportunity_Name__c = opp.Id;
        update bq;
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Id,name
                                     ,Distributor_Name__c
                                     ,Distributor_License__c
                                     ,Distributor_Contact__c
                                     ,Supplier_Name__c
                                     ,Supplier_License__c
                                     ,Supplier_Contact__c
                                     ,Sales_Order_Instructions__c
                                     ,Brand_Quote__r.Distributor_Name__c
                                     ,Brand_Quote__r.Distributor_License__c
                                     ,Brand_Quote__r.Distributor_Contact__c
                                     ,Brand_Quote__r.Supplier_Name__c
                                     ,Brand_Quote__r.Supplier_License__c
                                     ,Brand_Quote__r.Supplier_Contact__c
                                     ,Receiver_Name__c
                                     ,Receiver_License__c
                                     ,Receiver_Contact__c
                                     ,Site__c,Supplier_Name__r.Payment_Terms__c
                                     ,Site__r.Name
                                     ,Opportunity_Name__c
                                     ,Planned_Ship_Date__c
                                     ,Sample_Order__c
                                     ,Customer_PO_or_Quote__c
                                     ,Brand_Quote__c
                                     ,Shipping_Terms__c
                                     ,Shipping_Method__c
                                     ,Payment_Terms__c
                                     ,SO_Type__c
                                     ,Ownership__c,Ownership__r.Type
                                     ,Total_Weight_Fee__c , 
                                     Total_Mileage_Fee__c  , 
                                     Stage_Manifest_Fee__c , Schedule_Dispatch_Fee__c , 
                                     Pack_Out_Fee__c , Order_Booking_Fee__c,Total_Pick_Pack_Fee__c,
                                     Total_QA_Review_Fee__c,Change_Order_Fee__c,
                                     Total_Weight_lbs__c, 
                                     Supplier_Name__r.Membership_Level__c, 
                                     Receiver_Name__r.Membership_Level__c, 
                                     Order_Type__c,Brand_Quote__r.Opportunity_Name__c,
                                     Ship_Confirmation_Date__c,Brand_Quote__r.Opportunity_Name__r.Order__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c,
                                     Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.Customer__r.ContactId,Total_Manifest_Revision__c,Total_Change_Fee__c from Sales_Order__c ];
        salesOrderObj.Total_Weight_Fee__c = 1;
        salesOrderObj.Stage_Manifest_Fee__c = 1;
        update salesOrderObj;
        
        soLines = new List<Sales_Order_Line__c>();
        soLines = [Select Id from Sales_Order_Line__c LIMIT 2];
        soLines[0].Product_Name__c = objProduct1.id;
        soLines[1].Product_Name__c = objProduct2.id;
        update soLines;
        string RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get('Service').getRecordTypeId();
        Invoice__c inv= [SELECT id,Brand_Quote__c,Supplier_Name__c,Supplier_Name__r.Membership_Level__c from Invoice__c LIMIT 1];
        inv.Sales_Order__c = salesOrderObj.id;
            inv.Brand_Quote__c = bq.Id; 
            inv.Supplier_Name__c = acc.Id;
        inv.RecordTypeId = RecordTypeId;
        update inv;
        
        List<Invoice_Line__c> lstInvLine = [SELECT Id,Invoice_Qty__c from Invoice_Line__c LIMIT 2];
        //lstInvLine[0].Invoice_Qty__c = 10;
        lstInvLine[0].Sales_Order_Line__c = soLines[0].id;
        lstInvLine[0].Product_Name__c = objProduct1.Id;
        lstInvLine[1].Product_Name__c = objProduct2.Id;
        lstInvLine[1].Sales_Order_Line__c = soLines[0].id;
        //lstInvLine[1].Invoice_Qty__c = 10;
        update lstInvLine[0];
        // Create inventory location with name as "QA Review"
        Inventory_Location__c newInventoryLocation = new Inventory_Location__c();
        newInventoryLocation.Name = 'Test Location';
        newInventoryLocation.Site_Name__c = [Select Id From Site__c LIMIT 1].Id;
        newInventoryLocation.Name = PicklistSupport.STATUS_QA_REVIEW;
        insert newInventoryLocation;
        Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Retail_Wholesale_Price__c=1,Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,Default_Distributor__c  = acc.Id,LateFee__c = 0.020,Route_Origin_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US',Route_Destination_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US');
        insert ccs;
        // Create Rack with name as "QA Review"
        Rack__c rackSO = new Rack__c();
        rackSO.Inventory_Location__c = newInventoryLocation.Id;
        rackSO.Name = PicklistSupport.STATUS_QA_REVIEW;
        insert rackSO;
        
        // Create Rack Level with name as "QA Review"
        Rack_Level__c rackLevelSO = new Rack_Level__c();
        rackLevelSO.Rack__c = rackSO.Id;
        rackLevelSO.Name = PicklistSupport.STATUS_QA_REVIEW;
        insert rackLevelSO;
        
        // Create Bin location with name as "QA Review"
        Bin_Location__c binLocationSO = new Bin_Location__c();
        binLocationSO.Rack_Level__c = rackLevelSO.Id;
        binLocationSO.Bin_Height__c = 10.0;
        binLocationSO.Bin_Length__c = 10.0;
        binLocationSO.Bin_Width__c = 20.0;
        binLocationSO.Name = PicklistSupport.STATUS_QA_REVIEW;
        insert binLocationSO;
    }
}