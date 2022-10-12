@isTest(SeeAllData=false)
/**********************************************************************************************************
Apex TestClass Name    : Metrc_HttpCalloutPackage_Test 
Apex Class Name    : Metrc_HttpCalloutHelper 
Version            : 1.0
Created Date       : 21/Dec/2019
Function           : Used for HTTPcallout testclass for package creation
------------------------------------------------------------------------------------------------------------
* Developer                                      Date                   Description
* ----------------------------------------------------------------------------------------------------------
* Suresh                                     21/Dec/2019              Original Version
************************************************************************************************************/

private class Metrc_HttpCalloutPackage_Test 
{
    /**************************************************************************************
    Method Name        : testsetupMethod  
    Version            : 1.0
    Function           : testdata setup Method
    *******************************************************************************/
    //@testSetup static void testsetupMethod() {
        static final String testEmail = 'tuser3@testMetrc.com';
        //Static final String emailId='%'+testEmail+'%';
    
    @testSetup static void setTestData(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.skipTrigger = true;
        Id profId= [select id from Profile where name='System Administrator' limit 1].Id; 
        User testUser=Metrc_TestdataFactory.createUser(testEmail+System.currentTimeMillis(),profId,testEmail);
        Database.insert(testUser);
                            
       //PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'ABI_POCU_GCC_CMD' limit 1];
       //database.insert (new PermissionSetAssignment(AssigneeId = tuser.id, PermissionSetId = perms.Id ));
        List<Metrc_IntegrationSettings__C> customsettingList =Metrc_TestdataFactory.createIntegrationSettingData();
        Insert customsettingList;
        
        Account objAccount = new Account();
        objAccount.Name = 'Metrc_Test Account1';
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
        objContact2.LastName = 'Test Contact2';
        objContact2.FirstName = 'filigreen1';
        objContact2.AccountId = objAccount.Id;
        contacts.add(objContact2);  
        
        // receiver contact
        Contact objContact3 = new Contact();
        objContact3.LastName = 'Test Contact3';
         objContact3.FirstName = 'filigreen';
        objContact3.AccountId = objAccount.Id;
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
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses.Default_Warehouse__c =objSite.ID;
        licenses.add(objStateLicenses);
        
        // distributor License
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount.id;
        objStateLicenses2.License_Number__c = 'AbcTest45678';
        objStateLicenses2.License_Status__c ='Active';
        objStateLicenses2.License_Type__c ='Type 1';
        objStateLicenses2.License_Class__c='A-License';
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses2.Default_Warehouse__c =objSite.ID;
        licenses.add(objStateLicenses2); 
        
        // receiver License
        State_Licenses__c objStateLicenses3 = new State_Licenses__c();
        objStateLicenses3.License_Name__c = objAccount.id;
        objStateLicenses3.License_Number__c = 'AbcTest54321';
        objStateLicenses3.License_Status__c ='Active';
        objStateLicenses3.License_Type__c ='Type 1';
        objStateLicenses3.License_Class__c='A-License';
        objStateLicenses3.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses3.Default_Warehouse__c =objSite.ID;
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
        bq.Notes__c ='Testnotes';
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
        
        
        
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
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
        
         // Create purchase order
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
        objPO.Brand_Quote__c = bq.id;
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
        List<UID__c> uidList= new List<UID__c>();
        UID__c uid = new UID__c(Name='1GGG60300005F51000003344',Active__c = true);
        UID__c uid2 = new UID__c(Name='1GGG60300005F51000003345',Active__c = true);

        uidList.add(uid);
        uidList.add(uid2);
        insert uidList; 
        
        Harvest_Batch_Code__c hbc = new Harvest_Batch_Code__c(Name='Test122',Active__c = true);
        insert hbc;
          
        Inventory_Position__c inv = new Inventory_Position__c();
        inv.Receiving_Line__c=receivingLines[0].ID;
        inv.Product_Name__c=objProduct1.id;
        inv.Qty_On_Hand__c=10;
        inv.Sales_Order_Line__c=objSOline1.id;
        inv.UID_New__c=uidList[0].ID;
        inv.Harvest_Batch_Code__c =hbc.id;
        insert inv;
        
        
        Picklist__c picklistObj = new Picklist__c();
        picklistObj.Sales_Order__c = objSO.Id;
        picklistObj.Site__c = objSO.Site__c;
        picklistObj.Status__c = 'Confirmed';
        insert picklistObj;
        
        List<Picklist_Line__c> picklistLines = new List<Picklist_Line__c>();
        Picklist_Line__c picklistLineObj = new Picklist_Line__c();
        picklistLineObj.Product_Name__c = objProduct1.id;
        picklistLineObj.Sales_Order_Line__c = objSOline1.id;
        picklistLineObj.Inventory_Position__c = inv.Id;
        picklistLineObj.Picklist__c = picklistObj.ID;
        picklistLineObj.Pack_out_UID__c=uidList[1].ID;
        //picklistLineObj.Harvest_Batch_or_Lot_Code__c='1235';
        picklistLines.add(picklistLineObj);
       
        insert picklistLines;

        
        //********************
        picklistObj.Status__c = 'QA Confirm';
        //picklistObj.Track_Trace_Sync__c =true;
        update picklistObj;
    }
    
    /**************************************************************************************
    Method Name        : packageCreate_httpCalloutTest2
    Version            : 1.0
    Function           :purpose of this method to give coverage to Picklist line items HttpCallout method
    *******************************************************************************/
     static testMethod void packageCreate_httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        system.runAs(user1){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Metrc_MockPackageHttpRespTest());        
        //******************
        List<Picklist__c> picklist_List=[select ID,name from Picklist__c where Status__c ='QA Confirm' order by createddate desc limit 1];
        
        Metrc_PicklistTriggerHandler.syncDataToMetrc(picklist_List[0].ID,'INSERT');
        
        //Metrc_ProductTriggerHandler.syncDataToMetrc(prod.ID,'INSERT');
        
        Test.stopTest();
        
        //system.assertNotEquals(picklistObj, NULL);
        }
        }
        
        /**************************************************************************************
    Method Name        : packageCreate_httpCalloutTest2
    Version            : 1.0
    Function           :purpose of this method to give coverage to Picklist line items HttpCallout method
    *******************************************************************************/
     static testMethod void packageCreate_httpCalloutTest2()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        system.runAs(user1){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Metrc_MockPackageHttpRespTest());        
        List<Picklist__c> picklist_List=[select ID,name from Picklist__c where Status__c ='QA Confirm' order by createddate desc limit 1];
        picklist_List[0].Track_Trace_Sync__c =true;
        update picklist_List;
        Metrc_PicklistTriggerHandler.syncDataToMetrc(picklist_List[0].ID,'INSERT');
        
        Test.stopTest();
        }
        }
        
            
        /**************************************************************************************
    Method Name        : updatePicklistline_packoutUIDTest3
    Version            : 1.0
    Function           :purpose of this method to give coverage to updatePicklistline_packoutUID method
    *******************************************************************************/
     static testMethod void updatePicklistline_packoutUIDTest3()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        system.runAs(user1){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Metrc_MockPackageHttpRespTest());        
        List<Picklist__c> picklist_List=[select ID,name from Picklist__c where Status__c ='QA Confirm' order by createddate desc limit 1];
        picklist_List[0].Track_Trace_Sync__c =true;
        picklist_List[0].Status__c ='Cancelled';
        update picklist_List;
        Metrc_PicklistTriggerHandler.updatePicklistline_packoutUID(picklist_List[0].ID);
        
        Test.stopTest();
        }
        }
        
        
        
    /**************************************************************************************
    Method Name        : updatePicklistline_packoutUIDTest3
    Version            : 1.0
    Function           :purpose of this method to give coverage to updatePicklistline_packoutUID method
    *******************************************************************************/
     static testMethod void metrc_PicklistSyncData_LT()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        system.runAs(user1){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Metrc_MockPackageHttpRespTest());        
        List<Picklist__c> picklist_List=[select ID,name from Picklist__c where Status__c ='QA Confirm' order by createddate desc limit 1];
        picklist_List[0].Track_Trace_Sync__c =false;
       // picklist_List[0].Status__c ='Cancelled';
        update picklist_List;
        Metrc_PicklistSyncData_LT.checkUserMetrcAcsess(picklist_List[0].ID);
        Metrc_PicklistSyncData_LT.syncDataToMetrcNew(picklist_List[0].ID,'Picklist');
        
        Test.stopTest();
        }
        }
    }