/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * QAConfirmControllerTest
 */
/*@isTest(OnInstall=false SeeAllData=false)*/
@isTest
public class QAConfirmControllerTest{
    static Purchase_Order__c poObj; 
    /*static PickList__c pickListObj;
    static List<PickList_Line__c> pickListLines;
    static Sales_Order__c salesOrderObj;
    static List<Inventory_Position__c> invPositions;
    static List<Shipping_Manifest__c> rsm;
    static List<Shipping_Manifest_Line__c> rsmLines;
    
    // Test Updating picklist status to confirmed and create RSM and lines
    static testMethod void testUpdatePicklistConfirmedAndCreateRSMAndLines(){
        
        // Get data created from setup
        retrieveData();
        
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        
        // By default no RSM and Line created 
        rsm = [Select Id From Shipping_Manifest__c Where PickList__c =: pickListObj.Id AND RecordTypeId =: ShippinManifestSupport.getRSMRecordTypeId()];
        rsmLines = [Select Id From Shipping_Manifest_Line__c];
        System.assertEquals(0, rsm.size(), 'RSM size mis-match');
        System.assertEquals(0, rsmLines.size(), 'RSM Line size mis-match');
        
        PageReference pageRef = Page.QAConfirm;
        pageRef.getParameters().put('id', pickListObj.Id);
        Test.setCurrentPage(pageRef);
         
   
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(pickListObj);
        QAConfirmController controllerObj = new QAConfirmController(stdController);
        
        pageRef = controllerObj.qaConfirm();
        
                QAConfirmController.QAConfirm(pickListObj.Id);
        
        // Verify picklist status
        System.assertEquals(PicklistSupport.STATUS_QA_CONFIRM, 
                            [Select Status__c From PickList__c Where Id =:pickListObj.Id].Status__c,
                            'Picklist status mis-match');
                            
        // Verify RSM and Lines
        rsm = [Select Id From Shipping_Manifest__c Where PickList__c =: pickListObj.Id AND RecordTypeId =: ShippinManifestSupport.getRSMRecordTypeId()];
        rsmLines = [Select Id From Shipping_Manifest_Line__c];
        System.assertEquals(1, rsm.size(),
                            'RSM size mis-match');
        System.assertEquals(pickListLines.size(), rsmLines.size(), 'RSM line size mis-match');
        
        System.assertEquals('/'+String.valueOf(rsm[0].Id), pageRef.getURL(), 'Page reference mis-match');
    }
    
    // Test validating already confirmed picklist to confirm
    static testMethod void testValidateConfirmedPicklistToConfirm(){
        
        // Get data created from setup
        retrieveData();
        
        // Create picklist with confirmed status and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, PicklistSupport.STATUS_QA_CONFIRM, true);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        
        // By default no RSM and Line created 
        rsm = [Select Id From Shipping_Manifest__c Where PickList__c =: pickListObj.Id AND RecordTypeId =: ShippinManifestSupport.getRSMRecordTypeId()];
        rsmLines = [Select Id From Shipping_Manifest_Line__c];
        System.assertEquals(0, rsm.size(), 'RSM size mis-match');
        System.assertEquals(0, rsmLines.size(), 'RSM Line size mis-match');
        
        PageReference pageRef = Page.QAConfirm;
        pageRef.getParameters().put('id', pickListObj.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(pickListObj);
        QAConfirmController controllerObj = new QAConfirmController(stdController);

        pageRef = controllerObj.qaConfirm();
                        QAConfirmController.QAConfirm(pickListObj.Id);
        List<Account> lstAcc = [SELECT Id,Hold__c from Account LIMIT 10];
        for(Account acc : lstAcc){
        	acc.Hold__c = true;    
        }
        update lstAcc;
        
        List<Sales_Order__c> sOrder2 = [SELECT Id,Account_Hold_Exception__c from Sales_Order__c LIMIT 10];
        for(Sales_Order__c acc : sOrder2){
        	acc.Account_Hold_Exception__c = false;    
        }
        update sOrder2;
        
        QAConfirmController.QAConfirm(pickListObj.Id);

        System.assertEquals(null, pageRef, 'Page reference mis-match');
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Already_QA_Confirm_Picklist), 'Validation message mis-match');
        
        // Redirect to picklist
        pageRef = controllerObj.redirectToPicklist();
        System.assertEquals('/'+String.valueOf(pickListObj.Id), pageRef.getURL(), 'Page reference mis-match');
    }
    
       // Test Updating picklist status to confirmed and create RSM and lines
    static testMethod void testUpdatePicklistConfirmedAndCreateRSMAndLinesAurares(){
        
        // Get data created from setup
        retrieveData();
        
        // Create picklist and lines
        pickListObj = TestUtilData.createPicklist(salesOrderObj, 'Open', true);
        pickListLines = TestUtilData.createPicklistLines(invPositions, pickListObj.Id, true);
        
        // By default no RSM and Line created 
        rsm = [Select Id From Shipping_Manifest__c Where PickList__c =: pickListObj.Id AND RecordTypeId =: ShippinManifestSupport.getRSMRecordTypeId()];
        rsmLines = [Select Id From Shipping_Manifest_Line__c];
        System.assertEquals(0, rsm.size(), 'RSM size mis-match');
        System.assertEquals(0, rsmLines.size(), 'RSM Line size mis-match');
        
        PageReference pageRef = Page.QAConfirm;
        pageRef.getParameters().put('id', pickListObj.Id);
        Test.setCurrentPage(pageRef);
         
        AuraResponse r = new AuraResponse('QAConfirmController.QAConfirm()');    
        QAConfirmController assign = new QAConfirmController();
        
        assign.redirectToRSM();
                QAConfirmController.QAConfirm(pickListObj.Id);

       // QAConfirmController.redirectToRSM();
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(pickListObj);
        QAConfirmController controllerObj = new QAConfirmController(stdController);
        
        pageRef = controllerObj.qaConfirm();
        
        
        // Verify picklist status
        System.assertEquals(PicklistSupport.STATUS_QA_CONFIRM, 
                            [Select Status__c From PickList__c Where Id =:pickListObj.Id].Status__c,
                            'Picklist status mis-match');
                            
        // Verify RSM and Lines
        rsm = [Select Id From Shipping_Manifest__c Where PickList__c =: pickListObj.Id AND RecordTypeId =: ShippinManifestSupport.getRSMRecordTypeId()];
        rsmLines = [Select Id From Shipping_Manifest_Line__c];
        System.assertEquals(1, rsm.size(),
                            'RSM size mis-match');
        System.assertEquals(pickListLines.size(), rsmLines.size(), 'RSM line size mis-match');
        
        //System.assertEquals('/'+String.valueOf(rsm[0].Id), pageRef.getURL(), 'Page reference mis-match');
    } 
    
    
    
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.createTestData();
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        invPositions = [Select Sales_Order_Line__c,
                               Sales_Order_Line__r.Product_Name__c
                               From Inventory_Position__c];
                               
        salesOrderObj = new Sales_Order__c();
        salesOrderObj = [Select Site__c from Sales_Order__c];
    }*/
	@isTest
	private static void runTest(){
    	QAConfirmController qaConfirm = new QAConfirmController();
        
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        
        Account acc = new Account();
        acc.Payment_Terms__c = 'COD';
        acc.Hold__c=true;
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        acc.Community_Price_Book__c = customPB.Id;
        acc.Hide_from_Marketplace__c = false;
        acc.Membership_Level__c = 'Boutique';
        acc.Type = 'Financial Interest - NL';
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
        insert acc;
        
        Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
        objContact.AccountId = acc.Id;
        objContact.email = 'test@test.com';
        insert objContact;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Customer Community Plus User Custom'];
        
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.EmailHeader.triggerUserEmail = false;
        User usr = new User(alias = 'standt', email=objContact.email,
        emailencodingkey='UTF-8', lastname=objContact.lastname,
        firstname=objContact.firstname, languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, contactId=objContact.Id,
        timezonesidkey='America/Los_Angeles',
        username=objContact.email);
        usr.setOptions(dmo);
        insert usr;


        Site__c objSite = new Site__c();
        objSite.Name = '7027-CP';
        objSite.Warehouse_Name__c='TestWarehouse1';
        objSite.Active__c=True;
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
        insert stLicence;
        
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = stLicence.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        ord.Customer__c = usr.Id;
        ord.Order_Type__c = 'Brand';
        insert ord;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName ='Qualification';
        opp.Site_Name__c = objSite.Id;
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
        bq.Site__c = objSite.id;
        bq.Ownership__c = opp.Ownership__c;
        bq.Payment_Terms__c = opp.Payment_Terms__c;
        bq.Apply_Excise_Tax__c = true;
        bq.Order_Type__c = 'Retailer';
        bq.Sales_person__c = objContact.Name;
        bq.Opportunity_Name__c = Opp.Id;
        insert bq;
        
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'Mileage Fee';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
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
        
        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c= objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;
        objbqline1.Invoiced_Quantity__c = 20;
        objbqline1.Retail_Wholesale_Price__c  = 100;
        objbqline1.Billed_Quantity__c =10;
        insert objbqline1;
        
        Sales_Order__c SO = new Sales_Order__c();
        SO.Brand_Quote__c = BQ.Id;
        SO.Supplier_Name__c = acc.id;
        SO.Receiver_Name__c = acc.id;
        SO.Distributor_Name__c = acc.Id;
        insert SO;
        	
        Picklist__c pick = new Picklist__c();
        pick.Sales_Order__c = SO.Id;
        pick.Site__c=objSite.Id;
        
        insert pick;
        
        UID__c uid = new UID__c();
        insert uid;
         
        
        Inventory_Location__c receivingInventoryLocation = new Inventory_Location__c();
        receivingInventoryLocation.Name ='Storage Main';
        receivingInventoryLocation.Site_Name__c = objSite.id;
        receivingInventoryLocation.Default_for_Site__c = true;
        receivingInventoryLocation.Include_in_Inventory__c=true;
        insert receivingInventoryLocation;
        
        
      //  List<Receiving_Line__c> receivingLines = [select id from Receiving_Line__c];
        Inventory_Position__c inv = new Inventory_Position__c();
       // inv.Receiving_Line__c=receivingLines[0].ID;
        inv.Product_Name__c=objProduct1.id;
        inv.Qty_On_Hand__c=10;
        inv.Qty_Allocated__c=100;
        inv.Site__c=objSite.id;
        inv.Inventory_Location__c=receivingInventoryLocation.id;
        inv.UID_New__c = uid.Id;
        insert inv;
        
        
         
        
        
        Picklist_Line__c PickLine = new Picklist_Line__c();
        PickLine.Picklist__c = pick.Id;
        PickLine.Pack_out_UID__c = uid.Id;
        PickLine.Inventory_Position__c=inv.id;
       // PickLine.UID__c=uid.Id;
        insert PickLine;
        
        
        ApexPages.StandardController sc = new ApexPages.StandardController(pick);
        QAConfirmController qaConfirm1 = new QAConfirmController(sc);
        
        qaConfirm1.qaConfirm();
        qaConfirm1.redirectToPicklist();
        
        QAConfirmController.QAConfirm(pick.Id);
        
        SO.Account_Hold_Exception__c = true;
        update SO;
        
        QAConfirmController.QAConfirm(pick.Id);
        
        PickLine.Status__c = 'Cancelled';
        update PickLine;
        
        QAConfirmController.QAConfirm(pick.Id);
        
        pick.Status__c = 'QA Confirm';
        update pick;
          Site_User__c su = new Site_User__c(Site__c = pick.Site__c,User__c = UserInfo.getUserId(),Active__c = true);
        insert su;
      
        QAConfirmController.QAConfirm(pick.Id);
	}
    
    @isTest
	private static void runTest1(){
    	QAConfirmController qaConfirm = new QAConfirmController();
        
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        
        Account acc = new Account();
        acc.Payment_Terms__c = 'COD';
        acc.Hold__c=true;
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        acc.Community_Price_Book__c = customPB.Id;
        acc.Hide_from_Marketplace__c = false;
        acc.Membership_Level__c = 'Boutique';
        acc.Type = 'Distributor';
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
        insert acc;
        
        Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
        objContact.AccountId = acc.Id;
        objContact.email = 'test@test.com';
        insert objContact;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Customer Community Plus User Custom'];
        
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.EmailHeader.triggerUserEmail = false;
        User usr = new User(alias = 'standt', email=objContact.email,
        emailencodingkey='UTF-8', lastname=objContact.lastname,
        firstname=objContact.firstname, languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, contactId=objContact.Id,
        timezonesidkey='America/Los_Angeles',
        username=objContact.email);
        usr.setOptions(dmo);
        insert usr;


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
        insert stLicence;
        
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = stLicence.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        ord.Customer__c = usr.Id;
        ord.Order_Type__c = 'Brand';
        insert ord;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName ='Qualification';
        opp.Site_Name__c = objSite.Id;
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
        bq.Site__c = objSite.id;
        bq.Ownership__c = opp.Ownership__c;
        bq.Payment_Terms__c = opp.Payment_Terms__c;
        bq.Apply_Excise_Tax__c = true;
        bq.Order_Type__c = 'Retailer';
        bq.Sales_person__c = objContact.Name;
        bq.Opportunity_Name__c = Opp.Id;
        insert bq; 
        
        
          Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'Mileage Fee';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
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
        
        Sales_Order__c SO = new Sales_Order__c();
        SO.Brand_Quote__c = BQ.Id;
        SO.Supplier_Name__c = acc.id;
        SO.Receiver_Name__c = acc.id;
        SO.Distributor_Name__c = acc.Id;
        insert SO;
        
        Picklist__c pick = new Picklist__c();
        pick.Sales_Order__c = SO.Id;
        insert pick;
        
        UID__c uid = new UID__c();
        insert uid;
         Inventory_Location__c receivingInventoryLocation = new Inventory_Location__c();
        receivingInventoryLocation.Name ='Storage Main';
        receivingInventoryLocation.Site_Name__c = objSite.id;
        receivingInventoryLocation.Default_for_Site__c = true;
        receivingInventoryLocation.Include_in_Inventory__c=true;
        insert receivingInventoryLocation;
        
        
      //  List<Receiving_Line__c> receivingLines = [select id from Receiving_Line__c];
        Inventory_Position__c inv = new Inventory_Position__c();
       // inv.Receiving_Line__c=receivingLines[0].ID;
        inv.Product_Name__c=objProduct1.id;
        inv.Qty_On_Hand__c=10;
        inv.Qty_Allocated__c=100;
        inv.Site__c=objSite.id;
        inv.Inventory_Location__c=receivingInventoryLocation.id;
        inv.UID_New__c = uid.Id;
        insert inv;
        
        
        
        
        
        Picklist_Line__c PickLine = new Picklist_Line__c();
        PickLine.Picklist__c = pick.Id;
        PickLine.Pack_out_UID__c = uid.Id;
        PickLine.Inventory_Position__c=inv.id;
       // PickLine.UID__c=uid.Id;
        insert PickLine;
        
        ApexPages.StandardController sc = new ApexPages.StandardController(pick);
        QAConfirmController qaConfirm1 = new QAConfirmController(sc);
        
        QAConfirmController.QAConfirm(pick.Id);
        
        SO.Account_Hold_Exception__c = true;
        update SO;
        
        QAConfirmController.QAConfirm(pick.Id);
        
        PickLine.Status__c = 'Cancelled';
        update PickLine;
        
        QAConfirmController.QAConfirm(pick.Id);
        
        pick.Status__c = 'QA Confirm';
        update pick;
        
        QAConfirmController.QAConfirm(pick.Id);        
	}
    
    @isTest
	private static void runTest2(){
    	QAConfirmController qaConfirm = new QAConfirmController();
        
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        
        Account acc = new Account();
        acc.Payment_Terms__c = 'COD';
        acc.Hold__c=true;
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        acc.Community_Price_Book__c = customPB.Id;
        acc.Hide_from_Marketplace__c = false;
        acc.Membership_Level__c = 'Boutique';
        acc.Type = 'Distributor';
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
        insert acc;
        
        Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
        objContact.AccountId = acc.Id;
        objContact.email = 'test@test.com';
        insert objContact;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Customer Community Plus User Custom'];
        
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.EmailHeader.triggerUserEmail = false;
        User usr = new User(alias = 'standt', email=objContact.email,
        emailencodingkey='UTF-8', lastname=objContact.lastname,
        firstname=objContact.firstname, languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, contactId=objContact.Id,
        timezonesidkey='America/Los_Angeles',IsActive = true,
        username=objContact.email);
        usr.setOptions(dmo);
        insert usr;


        Site__c objSite = new Site__c();
        objSite.Name = '7027-CP';
        objSite.Warehouse_Name__c='TestWarehouse1';
        objSite.Active__c=True;
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
        insert stLicence;
        
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = stLicence.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        ord.Customer__c = usr.Id;
        ord.Order_Type__c = 'Retail';
        insert ord;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName ='Qualification';
        opp.Site_Name__c = objSite.Id;
        opp.Ownership__c = acc.id;
        opp.Payment_Terms__c = 'COD';
        opp.Order__c = ord.Id;
        //Opp.Order__c = ord.Id;
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
        bq.Site__c = objSite.id;
        bq.Ownership__c = opp.Ownership__c;
        bq.Payment_Terms__c = opp.Payment_Terms__c;
        bq.Apply_Excise_Tax__c = true;
        bq.Order_Type__c = 'Retailer';
        bq.Sales_person__c = objContact.Name;
        bq.Opportunity_Name__c = Opp.Id;
        insert bq; 
        
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'Mileage Fee';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
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
        List<Brand_Quote_Line__c> bqlist = new list<Brand_Quote_Line__c>();
        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c= objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;
        objbqline1.Invoiced_Quantity__c = 20;
        objbqline1.Retail_Wholesale_Price__c  = 100;
        objbqline1.Billed_Quantity__c =10;
        insert objbqline1;
        bqlist.add(objbqline1);
        
        Sales_Order__c SO = new Sales_Order__c();
        SO.Brand_Quote__c = BQ.Id;
        SO.Supplier_Name__c = acc.id;
        SO.Receiver_Name__c = acc.id;
        SO.Distributor_Name__c = acc.Id;
        SO.Opportunity_Name__c = opp.Id;
        insert SO;
        
        Picklist__c pick = new Picklist__c();
        pick.Sales_Order__c = SO.Id;
        pick.Site__c=objSite.Id;
        insert pick;
        
        UID__c uid = new UID__c();
        insert uid;
        
        
         Inventory_Location__c receivingInventoryLocation = new Inventory_Location__c();
        receivingInventoryLocation.Name ='Storage Main';
        receivingInventoryLocation.Site_Name__c = objSite.id;
        receivingInventoryLocation.Default_for_Site__c = true;
        receivingInventoryLocation.Include_in_Inventory__c=true;
        insert receivingInventoryLocation;
        
        
      //  List<Receiving_Line__c> receivingLines = [select id from Receiving_Line__c];
        Inventory_Position__c inv = new Inventory_Position__c();
       // inv.Receiving_Line__c=receivingLines[0].ID;
        inv.Product_Name__c=objProduct1.id;
        inv.Qty_On_Hand__c=10;
        inv.Qty_Allocated__c=100;
        inv.Site__c=objSite.id;
        inv.Inventory_Location__c=receivingInventoryLocation.id;
        inv.UID_New__c = uid.Id;
        insert inv;
        
        
        
        
        
        Picklist_Line__c PickLine = new Picklist_Line__c();
        PickLine.Picklist__c = pick.Id;
       // PickLine.Pack_out_UID__c = uid.Id;
        PickLine.Inventory_Position__c=inv.id;
       // PickLine.UID__c=uid.Id;
        insert PickLine;
        
      /*  Picklist_Line__c PickLine = new Picklist_Line__c();
        PickLine.Picklist__c = pick.Id;
        PickLine.Pack_out_UID__c = uid.Id;
        insert PickLine;*/
        
        ApexPages.StandardController sc = new ApexPages.StandardController(pick);
        QAConfirmController qaConfirm1 = new QAConfirmController(sc);
        
        QAConfirmController.QAConfirm(pick.Id);
        string poRecordTypeID   = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByName().get('Product').getRecordTypeId();
        string polRecordTypeID   = Schema.SObjectType.Purchase_Order_Line__c.getRecordTypeInfosByName().get('Product').getRecordTypeId();
 // Purchase_Order__c  po = [Select Id,PO_Status__c  from Purchase_Order__c LIMIT 1];
        Purchase_Order__c po = new Purchase_Order__c();
        po.PO_Status__c ='Cancelled';
        Po.Total_Weight_Fee__c =10;
        po.Planned_Ship_Transfer_Date__c = system.today();
        insert po;
        QAConfirmController.createPO(bq, 'Buy Quote	', poRecordTypeID);
        QAConfirmController.createPOLine(bqlist, po, polRecordTypeID, bq);
       
        SO.Account_Hold_Exception__c = true;
        update SO;
        
        QAConfirmController.QAConfirm(pick.Id);
        
        PickLine.Status__c = 'Cancelled';
        update PickLine;
        
        QAConfirmController.QAConfirm(pick.Id);
        
        pick.Status__c = 'QA Confirm';
        update pick;
        
         string PURCHASE_ORDER_STATUS_APPROVED = QAConfirmController.PURCHASE_ORDER_STATUS_APPROVED;
         string BRAND_QUOTE_RECORDTYPE_SELL_QUOTE = QAConfirmController.BRAND_QUOTE_RECORDTYPE_SELL_QUOTE;
         string BRAND_QUOTE_RECORDTYPE_SERVICE_QUOTE = QAConfirmController.BRAND_QUOTE_RECORDTYPE_SERVICE_QUOTE;
         string PURCHASE_ORDER_RECORDTYPE_INVOICE_ONLY = QAConfirmController.PURCHASE_ORDER_RECORDTYPE_INVOICE_ONLY;
         string BRAND_QUOTE_RECORDTYPE_RMA = QAConfirmController.BRAND_QUOTE_RECORDTYPE_RMA;
         string PURCHASE_ORDER_LINE_RECORDTYPE_INVOICE_ONLY = QAConfirmController.PURCHASE_ORDER_LINE_RECORDTYPE_INVOICE_ONLY;
         string PURCHASE_ORDER_RECORDTYPE_RMA = QAConfirmController.PURCHASE_ORDER_RECORDTYPE_RMA;
         string PURCHASE_ORDER_LINE_RECORDTYPE_RMA = QAConfirmController.PURCHASE_ORDER_LINE_RECORDTYPE_RMA;
        string PURCHASE_ORDER_RECORDTYPE_PRODUCT = QAConfirmController.PURCHASE_ORDER_RECORDTYPE_PRODUCT;
        string PURCHASE_ORDER_LINE_RECORDTYPE_PRODUCT = QAConfirmController.PURCHASE_ORDER_LINE_RECORDTYPE_PRODUCT;
        string ERROR_CUSTOMER_INACTIVE = QAConfirmController.ERROR_CUSTOMER_INACTIVE;
        string SM_LINE_RECORDTYPE_LABLINE = QAConfirmController.SM_LINE_RECORDTYPE_LABLINE;
        string SM_LINE_RECORDTYPE_TRANSFERLINE = QAConfirmController.SM_LINE_RECORDTYPE_TRANSFERLINE;
        string ORDER_TYPE_BRAND = QAConfirmController.ORDER_TYPE_BRAND;
        string ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER = QAConfirmController.ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER;
        string ORDER_TYPE_RETAIL = QAConfirmController.ORDER_TYPE_RETAIL;
        string ACCOUNT_HOLD_MESSAGE = QAConfirmController.ACCOUNT_HOLD_MESSAGE;
          string PRODUCT_RECORD_TYPE_SERVICES = QAConfirmController.PRODUCT_RECORD_TYPE_SERVICES;
       string  PICKLIST_UID_NULL_MESSAGE=QAConfirmController.PICKLIST_UID_NULL_MESSAGE;
                Site_User__c su = new Site_User__c(Site__c = pick.Site__c,User__c = UserInfo.getUserId(),Active__c = true);
        insert su;
      
        
        QAConfirmController.QAConfirm(pick.Id);        
	}
 @isTest
	private static void runTest3(){
    	QAConfirmController qaConfirm = new QAConfirmController();
        
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        
        Account acc = new Account();
        acc.Payment_Terms__c = 'COD';
        acc.Hold__c=true;
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        acc.Community_Price_Book__c = customPB.Id;
        acc.Hide_from_Marketplace__c = false;
        acc.Membership_Level__c = 'Boutique';
        acc.Type = 'Financial Interest - NL';
        acc.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
        insert acc;
        
        Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
        objContact.AccountId = acc.Id;
        objContact.email = 'test@test.com';
        insert objContact;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Customer Community Plus User Custom'];
        
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.EmailHeader.triggerUserEmail = false;
        User usr = new User(alias = 'standt', email=objContact.email,
        emailencodingkey='UTF-8', lastname=objContact.lastname,
        firstname=objContact.firstname, languagelocalekey='en_US',
        localesidkey='en_US', profileid = p.Id, contactId=objContact.Id,
        timezonesidkey='America/Los_Angeles',
        username=objContact.email);
        usr.setOptions(dmo);
        insert usr;


        Site__c objSite = new Site__c();
        objSite.Name = '7027-CP';
        objSite.Active__c=True;
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
        insert stLicence;
        
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = stLicence.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        ord.Customer__c = usr.Id;
        ord.Order_Type__c = 'Brand';
        insert ord;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName ='Qualification';
        opp.Site_Name__c = objSite.Id;
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
        bq.Site__c = objSite.id;
        bq.Ownership__c = opp.Ownership__c;
        bq.Payment_Terms__c = opp.Payment_Terms__c;
        bq.Apply_Excise_Tax__c = true;
        bq.Order_Type__c = 'Retailer';
        bq.Sales_person__c = objContact.Name;
        bq.Opportunity_Name__c = Opp.Id;
        insert bq;
        
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'Mileage Fee';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
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
        
        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c= objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;
        objbqline1.Invoiced_Quantity__c = 20;
        objbqline1.Retail_Wholesale_Price__c  = 100;
        objbqline1.Billed_Quantity__c =10;
        insert objbqline1;
        
        Sales_Order__c SO = new Sales_Order__c();
        SO.Brand_Quote__c = BQ.Id;
        SO.Supplier_Name__c = acc.id;
        SO.Receiver_Name__c = acc.id;
        SO.Distributor_Name__c = acc.Id;
        insert SO;
        	
        Picklist__c pick = new Picklist__c();
        pick.Sales_Order__c = SO.Id;
        pick.Site__c=objSite.Id;
        insert pick;
        
        UID__c uid = new UID__c();
        insert uid;
         
        Inventory_Location__c receivingInventoryLocation = new Inventory_Location__c();
        receivingInventoryLocation.Name ='Storage Main';
        receivingInventoryLocation.Site_Name__c = objSite.id;
        receivingInventoryLocation.Default_for_Site__c = true;
        receivingInventoryLocation.Include_in_Inventory__c=true;
        insert receivingInventoryLocation;
        
        
      //  List<Receiving_Line__c> receivingLines = [select id from Receiving_Line__c];
        Inventory_Position__c inv = new Inventory_Position__c();
       // inv.Receiving_Line__c=receivingLines[0].ID;
        inv.Product_Name__c=objProduct1.id;
        inv.Qty_On_Hand__c=10;
        inv.Qty_Allocated__c=100;
        inv.Site__c=objSite.id;
        inv.Inventory_Location__c=receivingInventoryLocation.id;
        inv.UID_New__c = uid.Id;
        insert inv;
        
        
        
        
        
      
        Site_User__c su = new Site_User__c(Site__c = pick.Site__c,User__c = UserInfo.getUserId(),Active__c = true);
        insert su;
      
        QAConfirmController.QAConfirm(pick.Id);
	}
     
}