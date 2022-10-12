@isTest(SeeAllData=false)
public class TransferPackageTest {
 static List<State_Licenses__c> licenses;
    static Shipping_Manifest__c rsmObj;
    static Sales_Order__c salesOrderObj;
    static Vehicles__c vehicleObj;
	static final String testEmail = 'tuser3@testMetrc.com';    
     @testSetup static void setTestData(){
        Id profId= [select id from Profile where name='System Administrator' limit 1].Id; 
        User testUser=Metrc_TestdataFactory.createUser(testEmail+System.currentTimeMillis(),profId,testEmail);
        Database.insert(testUser);
        system.runAs(testUser){
        List<Metrc_IntegrationSettings__C> customsettingList =Metrc_TestdataFactory.createIntegrationSettingData();
        Insert customsettingList;
        }
    }
    static testMethod void metrc_TransferShipmanifest(){
        TestUtilData.skipTrigger = true;  
        Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllStrainBatchRespTest());
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
       
        PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        Test.startTest();
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
        objContact2.LastName = 'Test Contact2';
        objContact2.FirstName = 'tes';    
        objContact2.AccountId = objAccount.Id;
        objContact2.Phone ='6276819013';
        contacts.add(objContact2);  
        
        // receiver contact
        Contact objContact3 = new Contact();
        objContact3.LastName = 'Test Contact3';
        objContact3.FirstName = 'tes3'; 
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
        rsmObj.Status__c = 'In-Transit';
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
        Shipping_Manifest__c sm = [select Id, Name from Shipping_Manifest__c];
         List<Shipping_Manifest__c>  obj = [select id,Track_Trace_Sync__c,Metrc_Manifest__c,Name,Distributor_License_Number__c,Distributor_Name__r.name,Distributor_Contact__r.phone,Distributor_Address__c,
                                           Distributor_License__r.License_City__c,Distributor_License__r.License_State__c,Distributor_License__r.License_Zip__c,
                                           Receiver_License_Number__c,Actual_Departure_Date_Time__c,Driver_License_Number__c,Driver__r.name, Vehicle__r.name,  Vehicle_Model__c,Vehicle__r.Vehicle_Make__c,Vehicle__r.Vehicle_License_Plate_Number__c,Planned_Ship_Transfer_Date__c,
                                           EstimatedDeparture_DateTime__c,EstimatedArrival_DateTime__c,
                                           (Select id,Picklist_Line__r.Pack_out_UID__c,Picklist_Line__r.Metrc_PackageID__c,Shipping_Manifest__r.Name,UID_1__c,Product_Name__r.name,Shipment_Qty__c,Product_Name__r.Metrc_UOM__c,Retail_Wholesale_Price__c,Harvest_Batch_Code__c 
                                            from Shipping_Manifest_Lines__r where SMLine_Status__c = null)
                                           from Shipping_Manifest__c  where id = :sm.Id and Status__c IN ('In-Transit' ,'Pending Delivery')];
        
       //TransferPackage.isTest = true; 
       //TransferPackage.isRecordType = false;
        List<Shipping_Manifest_Line__c> childObjList1 = obj[0].Shipping_Manifest_Lines__r;
            if(childObjList1.size()>0){
                for(Shipping_Manifest_Line__c var: childObjList1){
                    if(var.UID_1__c== null){
                      
                    }
                } 
            }
         
       TransferPackage.TransferShipmanifest(sm.Id);
          
            Test.stopTest();
        // system.assertNotEquals(obj[0].Driver__c, NULL);
        }
        
    }
    static testMethod void metrc_TransferShipmanifest1(){
        TestUtilData.skipTrigger = true;  
        
        Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllStrainBatchRespTest());
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
       
        PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        
        system.runAs(user1){
            
        Test.startTest();
        Account objAccount = new Account();
        objAccount.name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD'; 
        insert objAccount;
        Account objAccount1 = new Account();
        objAccount1.name = 'Test Account2';
        objAccount1.Payment_Terms__c = 'COD'; 
        insert objAccount1;            
        Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,Second_Warehouse_Id__c= objAccount.id, Default_Distributor__c= objAccount1.id);
        insert ccs;
        
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
        objContact2.FirstName = 'tes2';     
        objContact2.AccountId = objAccount.Id;
        objContact2.Phone ='6276819013';
        contacts.add(objContact2);  
        
        // receiver contact
        Contact objContact3 = new Contact();
        objContact3.LastName = 'Test Contact3';
        objContact3.FirstName = 'tes4'; 
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
        rsmObj.Status__c = 'In-Transit';
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
        string ERR_MSG_ASSIGN_UID =  TransferPackage.ERR_MSG_ASSIGN_UID;
        string ERR_MSG_SHIPPING_MANIFEST_ASSIGN_VEHICLE =  TransferPackage.ERR_MSG_SHIPPING_MANIFEST_ASSIGN_VEHICLE;
        string SHIPPING_MANIFEST_STATUS_INTRANSIT =  TransferPackage.SHIPPING_MANIFEST_STATUS_INTRANSIT;
        string SHIPPING_MANIFEST_STATUS_SHIPMENT_PENDING =  TransferPackage.SHIPPING_MANIFEST_STATUS_SHIPMENT_PENDING;
        string ERR_MSG_SHIPPING_MANIFEST_DRIVER_LICENSE =  TransferPackage.ERR_MSG_SHIPPING_MANIFEST_DRIVER_LICENSE;
        string ERR_MSG_SHIPPING_MANIFEST_TEMPLATE_CREATED =  TransferPackage.ERR_MSG_SHIPPING_MANIFEST_TEMPLATE_CREATED;
        string ERR_MSG_SHIPPING_MANIFEST_DEPART_TIME =  TransferPackage.ERR_MSG_SHIPPING_MANIFEST_DEPART_TIME;
        string ERR_MSG_SHIPPING_MANIFEST_ARRAIVAL_TIME =  TransferPackage.ERR_MSG_SHIPPING_MANIFEST_ARRAIVAL_TIME;
        string ERR_MSG_SHIPPING_MANIFEST_REC_LICENSE =  TransferPackage.ERR_MSG_SHIPPING_MANIFEST_REC_LICENSE;
        string ERR_MSG_SHIPPING_MANIFEST_DIST_LICENSE =  TransferPackage.ERR_MSG_SHIPPING_MANIFEST_DIST_LICENSE;
        string ERR_MSG_SHIPPING_MANIFEST_PLANSHIPDATE =  TransferPackage.ERR_MSG_SHIPPING_MANIFEST_PLANSHIPDATE;
        string ERR_MSG_SHIPPING_MANIFEST_ASSIGN_DRIVER =  TransferPackage.ERR_MSG_SHIPPING_MANIFEST_ASSIGN_DRIVER;
         string ERR_MSG_SHIPPING_MANIFEST_CHANGE_STATUS =TransferPackage.ERR_MSG_SHIPPING_MANIFEST_CHANGE_STATUS;
          string ERR_MSG_SHIPPING_MANIFEST_LINE_CHANGE_STATUS =TransferPackage.ERR_MSG_SHIPPING_MANIFEST_CHANGE_STATUS;
            Shipping_Manifest__c sm = [select Id, Name from Shipping_Manifest__c];
Shipping_Manifest__c  obj = [select id,Track_Trace_Sync__c,Metrc_Manifest__c,Name,Distributor_License_Number__c,Distributor_Name__r.name,Distributor_Contact__r.phone,Distributor_Address__c,
                                           Distributor_License__r.License_City__c,Distributor_License__r.License_State__c,Distributor_License__r.License_Zip__c,
                                           Receiver_License_Number__c,Actual_Departure_Date_Time__c,Driver_License_Number__c,Driver__r.name, Vehicle__r.name,  Vehicle_Model__c,Vehicle__r.Vehicle_Make__c,Vehicle__r.Vehicle_License_Plate_Number__c,Planned_Ship_Transfer_Date__c,
                                           EstimatedDeparture_DateTime__c,EstimatedArrival_DateTime__c,
                                           (Select id,Picklist_Line__r.Pack_out_UID__c,Picklist_Line__r.Metrc_PackageID__c,Shipping_Manifest__r.Name,UID_1__c,Product_Name__r.name,Shipment_Qty__c,Product_Name__r.Metrc_UOM__c,Retail_Wholesale_Price__c,Harvest_Batch_Code__c 
                                            from Shipping_Manifest_Lines__r where SMLine_Status__c = null)
                                           from Shipping_Manifest__c  where id = :sm.Id and Status__c IN ('In-Transit' ,'Pending Delivery')];
            //TransferPackage.isTest = false;
            TransferPackage.TransferShipmanifest(sm.Id);
            //TransferPackage.isRecordType = false;
            //System.assertEquals(rsmObj.Planned_Ship_Transfer_Date__c, system.today()); 
            TransferPackage.getRecordName(sm.Id);
            Company_Custom_Settings__c cs = [select Second_Warehouse_Id__c, Default_Distributor__c from Company_Custom_Settings__c];
            TransferPackage.syncDataToMetrc(sm.Id, 'INSERT');
            //Metrc_PicklistSyncData_LT.syncDataToMetrc_Transfer(sm.Id, 'INSERT');
            //Metrc_HttpCalloutHelper.createShippingManifest(sm.Id,obj,'INSERT');
            Test.stopTest();
             string status;
           status = TransferPackage.PRODUCT_RECORD_TYPE;
            
             status = TransferPackage.ERR_MSG_NON_CANNABIS;
         //system.assertNotEquals(prod, NULL);
        }
        
    }
    
}