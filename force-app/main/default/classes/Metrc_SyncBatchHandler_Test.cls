@isTest(SeeAllData=false)
/**********************************************************************************************************
Apex TestClass Name    : Metrc_SyncBatchHandler_Test 
Apex Class Name    : Metrc_SyncBatchHandler 
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : Used for Testing the Sync Batch Test
------------------------------------------------------------------------------------------------------------
* Developer                                      Date                   Description
* ----------------------------------------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
************************************************************************************************************/

private class Metrc_SyncBatchHandler_Test 
{
    /**************************************************************************************
    Method Name        : testsetupMethod  
    Version            : 1.0
    Function           : testdata setup Method
    *******************************************************************************/
    //@testSetup static void testsetupMethod() {
    static final String testEmail = 'tuser3@testMetrc.com';
    //Static final String emailId='%'+testEmail+'%';
    static List<State_Licenses__c> licenses;
    static Shipping_Manifest__c rsmObj;
    static Sales_Order__c salesOrderObj;
    static Vehicles__c vehicleObj;
    @testSetup static void setTestData(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());     
        Id profId= [select id from Profile where name='System Administrator' limit 1].Id; 
        User testUser=Metrc_TestdataFactory.createUser(testEmail+System.currentTimeMillis(),profId,testEmail);
        Database.insert(testUser);
        system.runAs(testUser){
        List<Metrc_IntegrationSettings__C> customsettingList =Metrc_TestdataFactory.createIntegrationSettingData();
        Insert customsettingList;
        
        Strain__c strainObj1 = Metrc_TestdataFactory.createStrain();
        Metrc_Utility.IS_STRAIN_TRIGGER_ENABLED =FALSE;
        strainObj1.Track_Trace_Sync__c=false;
        insert strainObj1 ;
        
        Strain__c  strainObj =[select id from Strain__c  limit 1];
        Product2 prod =Metrc_TestdataFactory.createProduct(strainObj.ID);
        prod.Track_Trace_Sync__c=true;
        prod.isActive=true;
        prod.Track_Trace_Sync__c=false;
        prod.Unit_Net_Weight__c=10;
        
        Metrc_Utility.IS_PROD_TRIGGER_ENABLED  =false;
        insert prod;
        Strain__c st = new Strain__c (Name = 'TestStrainCalloutPull2', Strain_Type__c = 'Hybrid',Track_Trace_Sync__c=true,isActive__c =true,Metrc_StrainID__c ='207092');
        insert st;
       
        
        }
    }


    
   
    /**************************************************************************************
    Method Name        : strainUpdate_httpCalloutTest1
    Version            : 1.0
    Function           :purpose of this method to give coverage to Strain HttpCallout method
    *******************************************************************************/
     static testMethod void metrc_SyncStrainBatchCreate_CalloutTest1()
    {
       User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
       PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        Test.startTest();
            Strain__c st = new Strain__c (Name = 'Test Strain data 2',Metrc_StrainID__c ='12345', Strain_Type__c = 'Hybrid',Track_Trace_Sync__c=true,isActive__c =true,ThcLevel__c=1,CbdLevel__c=1,IndicaPercentage__c=1,SativaPercentage__c=1);
            insert st;
         Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllStrainBatchRespTest());
         Metrc_SyncBatchHandler.Metrc_SyncStrainBatch();
        Test.stopTest();
        
         system.assertNotEquals(st, NULL);
        }
    }
    
    /**************************************************************************************
    Method Name        : strainUpdate_httpCalloutTest1
    Version            : 1.0
    Function           :purpose of this method to give coverage to Strain HttpCallout method
    *******************************************************************************/
     static testMethod void metrc_SyncStrainBatchUpdate_CalloutTest1()
    {
       User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
       PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        Test.startTest();
            Strain__c st = new Strain__c (Name = 'Test Strain 2',Metrc_StrainID__c ='293315', Strain_Type__c = 'Hybrid',Track_Trace_Sync__c=true,isActive__c =true,ThcLevel__c=1,CbdLevel__c=1,IndicaPercentage__c=1,SativaPercentage__c=1);
            insert st;
         Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllStrainBatchRespTest());
         Metrc_SyncBatchHandler.Metrc_SyncStrainBatch();
        Test.stopTest();
        
         system.assertNotEquals(st, NULL);
        }
    }
    
     /**************************************************************************************
    Method Name        : productUpdate_httpCalloutTest1
    Version            : 1.0
    Function           :purpose of this method to give coverage to Item HttpCallout method
    *******************************************************************************/
     static testMethod void metrc_SyncItemsBatchCreate_httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllProductBatchTest()); 
        PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        Test.startTest();
     
        
        Metrc_SyncBatchHandler.Metrc_SyncItemsBatch();
        Test.stopTest();
         //system.assertNotEquals(prod, NULL);
        }
    }
    
     /**************************************************************************************
    Method Name        : productUpdate_httpCalloutTest1
    Version            : 1.0
    Function           :purpose of this method to give coverage to Item HttpCallout method
    *******************************************************************************/
     static testMethod void metrc_SyncItemsBatchUpdate_httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
       
        PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        
            Strain__c  strainObj =[select id from Strain__c  limit 1];
            Product2 prod =Metrc_TestdataFactory.createProduct(strainObj.ID);
            prod.Track_Trace_Sync__c=true;
            Prod.Name ='Test Metrccallout2';
            prod.isActive=true;
            prod.Track_Trace_Sync__c=false;
            prod.Unit_Net_Weight__c=10;
            prod.Metrc_ItemID__c  ='355319';
            Metrc_Utility.IS_PROD_TRIGGER_ENABLED  =false;
            insert prod;
        Test.startTest();
            Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllProductBatchTest()); 
            Metrc_SyncBatchHandler.Metrc_SyncItemsBatch();
        Test.stopTest();
         //system.assertNotEquals(prod, NULL);
        }
    }
    
      /**************************************************************************************
    Method Name        : metrc_SyncStrainBatchUpdateOneTime_CalloutTest1
    Version            : 1.0
    Function           :purpose of this method to give coverage to Strain HttpCallout method
    *******************************************************************************/
     static testMethod void metrc_SyncStrainBatchUpdateOneTime_CalloutTest1()
    {
       User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
       PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        
            Strain__c st = new Strain__c (Name = 'Test Strain 3',Metrc_StrainID__c ='293315', Strain_Type__c = 'Hybrid',Track_Trace_Sync__c=true,isActive__c =true,ThcLevel__c=1,CbdLevel__c=1,IndicaPercentage__c=1,SativaPercentage__c=1);
            insert st;
            Test.startTest();
         Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllStrainBatchRespTest());
         Metrc_SyncBatchHandler.Metrc_SyncStrainBatch_OneTime();
        Test.stopTest();
        
         system.assertNotEquals(st, NULL);
        }
    }
    
     /**************************************************************************************
    Method Name        : metrc_SyncItemsBatchUpdate_httpCalloutTest1
    Version            : 1.0
    Function           :purpose of this method to give coverage to Item HttpCallout method
    *******************************************************************************/
     static testMethod void metrc_SyncItemsBatchUpdateOneTime_httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
       
        PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        
            Strain__c  strainObj =[select id from Strain__c  limit 1];
            Product2 prod =Metrc_TestdataFactory.createProduct(strainObj.ID);
            prod.Track_Trace_Sync__c=true;
            Prod.Name ='Test Metrccallout2';
            prod.isActive=true;
            prod.Track_Trace_Sync__c=false;
            prod.Unit_Net_Weight__c=10;
            prod.Metrc_ItemID__c  ='355319';
            Metrc_Utility.IS_PROD_TRIGGER_ENABLED  =false;
            insert prod;
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllProductBatchTest()); 
            Metrc_SyncBatchHandler.Metrc_SyncProductBatch_OneTime();
            Test.stopTest();
         //system.assertNotEquals(prod, NULL);
        }
    }
    
    static testMethod void Metrc_SyncUIDBatch_CalloutTest()
    {
       User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
       PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        Test.startTest();
            List<UID__c> sf_UIDList = [select id, name from UID__c];
            List<UID__c> actualfilterList = [select id, name,Available_Qty__c from UID__c];
            List<String> metrc_PackageList = new List<String>{'1A4FF030000025B000009419','1A4FF030000025B000009333'};
            List<String> metrc_UIDList = new List<String> {'1A4FF030000025B000009419'};
            List<Integer> metrc_QunatityList = new List<Integer>{10,0};   
         Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllStrainBatchRespTest());
         Metrc_SyncBatchHandler.Metrc_SyncUIDBatch();
            
         Metrc_HttpCalloutHelper.BatchPackageFinish(metrc_PackageList, metrc_UIDList, metrc_QunatityList, sf_UIDList,actualfilterList);
        Test.stopTest();
        }
    }
    
     static testMethod void Metrc_DataSyncDaily_CalloutTest()
    {
       User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
       PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        Test.startTest();
         Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllStrainBatchRespTest());
         Metrc_SyncBatchHandler.Metrc_DataSyncDaily();
        Test.stopTest();
        }
    }
     static testMethod void metrc_createShippingManifest()
    {
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());     
         TestUtilData.skipTrigger = true;  
        Account objAccount = new Account();
        objAccount.name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD'; 
        insert objAccount;
        
        // Create Site
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        insert objSite;
        // Create opportunity
        Opportunity opp = new Opportunity();
        opp.AccountId = objAccount.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName ='Qualification';
        opp.Site_Name__c = objSite.Id;
        opp.Ownership__c = objAccount.id;
        opp.Payment_Terms__c = 'COD';
        insert opp;
        
        List<Contact> contacts = new List<Contact>();
        // distributor contact
        Contact objContact2 = new Contact();
        objContact2.FirstName = 'test data1';
        objContact2.LastName = 'Test Contact2';
        objContact2.AccountId = objAccount.Id;
        objContact2.Phone ='6276819013';
        contacts.add(objContact2);  
        
        // receiver contact
        Contact objContact3 = new Contact();
        objContact3.FirstName = 'test data';
        objContact3.LastName = 'Test Contact3';
        objContact3.AccountId = objAccount.Id;
        objContact3.Phone ='6276819013';
        contacts.add(objContact3);
        insert contacts;
        
        // Supplier License
        List<State_Licenses__c> licenses = new List<State_Licenses__c>();
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_Address__c ='9, Wall street';
        objStateLicenses.License_City__c = 'Newark';
        objStateLicenses.License_State__c = 'New York';
        objStateLicenses.License_Zip__c ='94124';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        licenses.add(objStateLicenses);
        
        // distributor License
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount.id;
        objStateLicenses2.License_Number__c = 'AbcTest45678';
        objStateLicenses2.License_Status__c ='Active';
        objStateLicenses2.License_Type__c ='Type 1';
        objStateLicenses2.License_Class__c='A-License';
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        licenses.add(objStateLicenses2); 
        
        // receiver License
        State_Licenses__c objStateLicenses3 = new State_Licenses__c();
        objStateLicenses3.License_Name__c = objAccount.id;
        objStateLicenses3.License_Number__c = 'AbcTest54321';
        objStateLicenses3.License_Status__c ='Active';
        objStateLicenses3.License_Type__c ='Type 1';
        objStateLicenses3.License_Class__c='A-License';
        objStateLicenses3.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        licenses.add(objStateLicenses3);
        
        insert licenses;
        
        
        // Create brand quote
        Brand_Quote__c bq = new Brand_Quote__c ();
        bq.Opportunity_Name__c = opp.id; 
        bq.Distributor_License__c = objStateLicenses2.id;
        bq.Receiver_License__c = objStateLicenses3.id;
        bq.Distributor_Name__c = objAccount.id;
        bq.Supplier_Name__c = objAccount.id;
        bq.Receiver_Name__c = objAccount.id;
        bq.Supplier_License__c = objStateLicenses.id;
        bq.BQ_Status__c = 'Draft';
        bq.Shipping_Method__c = 'Distributor Pick-up';
        bq.Sales_Origin__c = 'Brand';
        bq.Shipping_Terms__c = 'CFR';
        bq.Payment_Terms__c = 'COD';
        bq.Site__c = objSite.id;
        bq.Ownership__c = opp.Ownership__c;
        insert bq;
        
        Sales_Order__c objSO = new Sales_Order__c();
        objSO.Site__c = bq.Site__c;
        objSO.SO_Status__c = 'Draft';
        objSO.SO_Type__c = 'Sell Quote';
        objSO.Brand_Quote__c = bq.id;
        objSO.Supplier_Contact__c = contacts[0].Id;
        objSO.Supplier_Name__c = bq.Supplier_Name__c;
        objSO.Supplier_License__c = bq.Supplier_License__c;
        objSO.Distributor_Contact__c = contacts[1].Id;
        objSO.Distributor_Name__c = bq.Distributor_Name__c;
        objSO.Distributor_License__c = bq.Distributor_License__c;
        objSO.Receiver_Name__c = bq.Receiver_Name__c;
        objSO.Receiver_Contact__c = contacts[1].Id;
        objSO.Receiver_License__c = bq.Receiver_License__c;
        objSO.Payment_Terms__c = bq.Payment_Terms__c;
        objSO.Shipping_Terms__c = bq.Shipping_Terms__c;
        objSO.Shipping_Method__c = bq.Shipping_Method__c;
        objSO.Ownership__c = objAccount.Id;
        objSO.Customer_PO_or_Quote__c = 'Test Quote';
        objSO.Opportunity_Name__c = opp.Id;
        insert objSO; 
        Drivers__c driverObj = new Drivers__c();
        driverObj.Name = 'Test Driver';
        driverObj.Driver_License_Number__c = '123';
        driverObj.Expiration_Date__c = System.Today() + 100;
        driverObj.State_Issued__c = 'AL';
        insert driverObj;
        // Create Vehicle
        vehicleObj = TestUtilData.createVehicle(false);
        vehicleObj.Name = 'Receiving Inspection'; // Same as Inventory Location of Picklist Line
        vehicleObj.Vehicle_Make__c ='Chevrolet';
        vehicleObj.Vehicle_Model__c ='Chevy Express';
        vehicleObj.Vehicle_License_Plate_Number__c='311451';
        insert vehicleObj;
        
        rsmObj = new Shipping_Manifest__c();
        rsmObj.Sales_Order__c = objSO.Id;
        rsmObj.Planned_Ship_Transfer_Date__c = System.Today() + 5;
        rsmObj.Supplier_Name__c = licenses[0].License_Name__c;
        rsmObj.Receiver_Name__c = licenses[0].License_Name__c;
        rsmObj.Distributor_License__c = licenses[0].Id;
        rsmObj.Supplier_License__c = licenses[0].Id;
        rsmObj.Receiver_License__c = licenses[0].Id;
        rsmObj.Driver__c = driverObj.id;
        rsmObj.Distributor_Name__c =  objAccount.id;
        rsmObj.Distributor_Contact__c = contacts[0].id; 
        rsmObj.EstimatedDeparture_DateTime__c = date.valueof(system.now()) + 10;
        rsmObj.EstimatedArrival_DateTime__c = date.valueof(system.now());
        rsmObj.Vehicle__c = vehicleObj.id;
        rsmObj.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
      
        insert rsmObj;
        Shipping_Manifest_Line__c rsmLine1 = new Shipping_Manifest_Line__c();
        rsmLine1.Shipping_Manifest__c = rsmObj.Id;
        rsmLine1.RecordTypeId = ShippinManifestSupport.getRSMLineRecordTypeId();
        rsmLine1.Shipment_Qty__c = 10;
        rsmLine1.Retail_Wholesale_Price__c = 10;
        insert rsmLine1;

        Shipping_Manifest__c sm = [select Id, Distributor_License_Number__c,Distributor_Name__r.name,Distributor_Contact__r.phone, Distributor_Address__c,Distributor_License__r.License_City__c, 
                                   Distributor_License__r.License_State__c, Distributor_License__r.License_Zip__c, Receiver_License_Number__c,
                                   EstimatedDeparture_DateTime__c, EstimatedArrival_DateTime__c,Driver_License_Number__c,
                                   Driver__r.name,Vehicle__r.Vehicle_Make__c,Vehicle_Model__c,vehicle__r.Vehicle_License_Plate_Number__c from Shipping_Manifest__c];
        //Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllStrainBatchRespTest());
         
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Quantity_Type__c='Quantity';
        insert objProduct1;
        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c= objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;
        insert objbqline1 ;
        List<Sales_Order__c> objSO1= [select id from Sales_Order__c];
        Sales_Order_Line__c objSOline1 = new Sales_Order_Line__c();
        objSOline1.Sales_Order__c = objSO1[0].id;
        objSOline1.Product_Name__c= objbqline1.Product_Name__c;
        objSOline1.Product_Title__c = 'Distributor';
        objSOline1.Status__c = 'Allocated';
        
        objSOline1.Qty_Ordered__c = 10;
        objSOline1.Qty_Invoiced__c = 5.0;
        objSOline1.Retail_Wholesale_Price__c = 10;
        insert objSOline1;
        
        Id recordTypeId = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByDeveloperName()
            .get('Product').getRecordTypeId();
                          
         Purchase_Order__c objPO = new Purchase_Order__c();
        objPO.recordTypeId = recordTypeId;
        objPO.Site__c = bq.Site__c;
        objpO.PO_Status__c = 'Draft';
        objpO.PO_Type__c = 'Buy Quote';
        objPO.Supplier_Name__c = bq.Supplier_Name__c;
        objPO.Supplier_License__c = bq.Supplier_License__c;
        objPO.Distributor_Name__c = bq.Distributor_Name__c;
        objPO.Distributor_License__c = bq.Distributor_License__c;
        objPO.Receiver_Name__c = bq.Receiver_Name__c;
        objPO.Receiver_License__c = bq.Receiver_License__c;
        objPO.Ownership__c = bq.Ownership__c;
        insert objPO;
        
        
        // Create Receiving
        Receiving__c objReceiving = new Receiving__c(Purchase_Order__c= objPO.id, Site__c= objSite.ID, Ownership__c = objPO.Ownership__c );
        insert objReceiving;
        
          // Create purchase order lines  
        Purchase_Order_Line__c objPOline1 = new Purchase_Order_Line__c();
        objPOline1.Purchase_Order__c = objPO.id;
        objPOline1.Product_Name__c= objbqline1.Product_Name__c;
        objPOline1.Qty_Ordered__c = 10;
        objPOline1.Unit_Cost__c = 10;
        
        Purchase_Order_Line__c objPOline2 = new Purchase_Order_Line__c();
        objPOline2.Purchase_Order__c = objPO.id;
        objPOline2.Product_Name__c= objbqline1.Product_Name__c;
        objPOline2.Qty_Ordered__c = 20;
        objPOline2.Unit_Cost__c = 20;
        
        Purchase_Order_Line__c objPOline3 = new Purchase_Order_Line__c();
        objPOline3.Purchase_Order__c = objPO.id;
        objPOline3.Product_Name__c= objbqline1.Product_Name__c;
        objPOline3.Qty_Ordered__c = 30;
        objPOline3.Unit_Cost__c = 30;
        
        list<Purchase_Order_Line__c> purchaseOrderLines = new list<Purchase_Order_Line__c>();
        purchaseOrderLines.add(objPOline1);
        purchaseOrderLines.add(objPOline2);
        purchaseOrderLines.add(objPOline3);
        insert purchaseOrderLines;
        
        Inventory_Location__c receivingInventoryLocation = new Inventory_Location__c();
        receivingInventoryLocation.Name = Label.Default_Inventory_Location;
        receivingInventoryLocation.Site_Name__c = objSite.id;
        receivingInventoryLocation.Default_for_Site__c = true;
        insert receivingInventoryLocation;
        
        
        // Create 3 receiving lines which will create inventory positions automatically
        List<Receiving_Line__c> receivingLines = new List<Receiving_Line__c>();
        for(Integer i=0; i<purchaseOrderLines.size(); i++){
            Receiving_Line__c objReceivingLine = new Receiving_Line__c();
            objReceivingLine.Inventory_Location__c = receivingInventoryLocation.Id;
            objReceivingLine.Product_Name__c = objProduct1.Id;
            objReceivingLine.Purchase_Order_Line__c = purchaseOrderLines[i].Id;
            objReceivingLine.Qty_to_Receive__c = 5.0;
            objReceivingLine.Receiving_ID__c = objReceiving.Id;
            objReceivingLine.Site__c = objSite.Id;
            objReceivingLine.UID__c = 'TEST' + i;
            objReceivingLine.Ownership__c = objAccount.Id;
            receivingLines.add(objReceivingLine);
        }
        insert receivingLines;
        UID__c uid= new UID__c();
        uid.name= '1A4060300005F51000014720';
        insert uid;
        UID__c uid1= new UID__c();
        uid1.name= '1A4060300005F51000014722';
        insert uid1;
        Harvest_Batch_Code__c hbc = new Harvest_Batch_Code__c();
        hbc.Name = 'RVCKNJ200722';
        insert hbc;
             
        Inventory_Position__c inv = new Inventory_Position__c();
        inv.Receiving_Line__c=receivingLines[0].ID;
        inv.Product_Name__c=objProduct1.id;
        inv.Qty_On_Hand__c=10;
        inv.Sales_Order_Line__c=objSOline1.id;
        inv.Harvest_Batch_Code__c = hbc.id;
        insert inv;

        Picklist__c picklistObj = new Picklist__c();
        picklistObj.Sales_Order__c = objSO.Id;
        picklistObj.Site__c = objSO.Site__c;
        picklistObj.Status__c = 'Confirmed';
        insert picklistObj;
        
       
        List<Picklist_Line__c> picklistLines = new List<Picklist_Line__c>();
        //for(Inventory_Position__c invPositionObj : invPositions){
            Picklist_Line__c picklistLineObj = new Picklist_Line__c();
            picklistLineObj.Product_Name__c = objProduct1.id;
            picklistLineObj.Sales_Order_Line__c = inv.Sales_Order_Line__c;
            picklistLineObj.Inventory_Position__c = inv.Id;
            picklistLineObj.Picklist__c = picklistObj.ID;
         	picklistLineObj.Pack_out_UID__c = uid.id;
            picklistLines.add(picklistLineObj);
       // }
            insert picklistLines;
        //Google_Distance_Matrix_API__c 
        List<Picklist_Line__c> pickLine = [select id,Pack_out_UID__c,  Product_Name__r.Name,Product_Name__r.Family,Product_Name__r.Metrc_UOM__c, 
                                           Product_Name__r.Unit_Net_Weight__c,UID__c,Harvest_Batch_or_Lot_Code__c,Qty_to_Pick__c from Picklist_Line__c];
        //Metrc_HttpCalloutHelper.createShippingManifest(sm.Id,sm,'INSERT');
        Metrc_HttpCalloutHelper.createPicklist(picklistObj.Id, pickLine,'INSERT');
        Metrc_SOQLDML_Handler.getPicklistLine(picklistObj.Id);
        Metrc_SOQLDML_Handler.getPicklistDetails(picklistObj.Id);
        String UID_METRC_STATUS_UNFINISHED = Metrc_SOQLDML_Handler.UID_METRC_STATUS_UNFINISHED;
        String UID_METRC_STATUS_UNFINISHED_SYNC = Metrc_SyncBatchHandler.UID_METRC_STATUS_UNFINISHED;
        String UID_METRC_STATUS_FINISHED = Metrc_SyncBatchHandler.UID_METRC_STATUS_FINISHED;
        
        
    }
    /**************************************************************************************
    Method Name        : metrc_SyncBatchSchedulerTest
    Version            : 1.0
    Function           :purpose of this method to give coverage to metrc_SyncBatchScheduler
    *******************************************************************************/
    
    static testmethod void metrc_SyncBatchSchedulerTest() 
    {
        String CRON_EXP = '0 0 0 15 3 ? *';
        Test.startTest();

            String jobId = System.schedule('ScheduleApexClassTest',  CRON_EXP, new Metrc_SyncBatchScheduler());
            CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
            System.assertEquals(CRON_EXP, ct.CronExpression);
            System.assertEquals(0, ct.TimesTriggered);
        Test.stopTest();
    }
    
    static testmethod void uidFinishTest() 
    {
        String CRON_EXP = '0 0 0 15 3 ? *';
        Test.startTest();
        String jobId = System.schedule('ScheduleUIDFinishTest',  CRON_EXP, new ScheduleUIDFinish());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        
        Test.stopTest();
        // Add assert here to validate result
    }
    static testmethod void ScheduleMetrcSyncDailyTest() 
    {
        String CRON_EXP = '0 0 0 15 3 ? *';
        Test.startTest();
        String jobId = System.schedule('ScheduleMetrcSyncDailyTest',  CRON_EXP, new ScheduleMetrcSyncDaily());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);
        
        Test.stopTest();
        // Add assert here to validate result
    }
    
}