@isTest
public class ShipmentManifestPrintLabelTest {
  static List<Shipping_Manifest__c> SMobj;  
    static  Shipping_Manifest__c sm;
    static List<Shipping_Manifest__c> SMobjlst;
     @AuraEnabled public boolean isSelected {get;set;}
        @AuraEnabled public Shipping_Manifest__c SMPos {get;set;}
        @AuraEnabled Public Integer qtyToAdjust{get; set;}
         
    public ShipmentManifestPrintLabelTest(boolean isSelected, Shipping_Manifest__c SMPosObj)
        {
             
            this.isSelected = isSelected;
            this.SMPos = SMPosObj;
            this.qtyToAdjust= 0;
        } 
    
   @TestSetUp
    static void testDataSetUp(){
          Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
            TestUtilData.skipTrigger = true;
        createTestData();
    }
    public static void retrieveData(){
       sm = new Shipping_Manifest__c();
        sm.Metrc_Manifest__c= '1234';
        insert sm;
        List<Shipping_Manifest_Line__c> line = new List<Shipping_Manifest_Line__c>();
        Product2 prd = [select id from Product2 limit 1];
        for(Integer i=0; i <28 ; i++) {
            Shipping_Manifest_Line__c smLine = new Shipping_Manifest_Line__c();
            smLine.Product_Name__c	= prd.Id;
            smLine.Shipment_Qty__c = i;
           	//smLine.Harvest_Batch_Code__c ='SLDTN17, WBDTN17,';
            smLine.Shipping_Manifest__c = sm.Id;
            
            line.add(smLine);
            
        }
        insert line;
    }  
    
    
    static testMethod void SMDetailsTest()
    {
        retrieveData(); 
        System.debug('SM...'+sm);
        ShipmentManifestPrintLabel.smDetails(sm.Id) ;   
        //  ShipmentManifestPrintLabel.getImage4X6Xml(SMobj[0]);
        List<ShipmentManifestPrintLabelTest> lstSM = new List<ShipmentManifestPrintLabelTest>();
        SMobjlst = [select Name, Order_Number__c,Box_Count__c, Brand_Quote__r.Name, Receiver_DBA__c, Total_Price__c, Order_Number__r.name,Supplier_DBA__c,Supplier_Name__c,Supplier_Name__r.name,
                    Ship_Confirmation_Date__c,  Metrc_Manifest__c, Receiver_Address__c, Receiver_City_State_Zip__c,Supplier_License__r.name,Supplier_License__c,
                    Receiver_First_Name__c, Receiver_Contact__r.MailingPostalCode, Receiver_Contact__r.MailingState, 
                    Receiver_Contact__r.Name, Receiver_Contact__r.MailingStreet, Receiver_Contact__r.MailingAddress,Receiver_License_Number__c, 
                    Receiver_Contact__r.MailingCity, Receiver_Contact__r.MailingCountry, Sales_Order__c, Sales_Order__r.Name,
                    Sales_Order__r.Total_Line_Items__c, Site__r.License_ID__r.License_Number__c, Receiver_License__r.License_City__c,Receiver_License__c,
                    Site__r.License_ID__r.License_Address__c, Site__r.License_ID__r.License_City__c,Receiver_License__r.License_Zip__c,Receiver_License__r.License_State__c,Receiver_License__r.License_Address__c,
                    Site__r.License_ID__r.License_State__c,Site__r.License_ID__r.License_Zip__c, id from 
                    Shipping_Manifest__c limit 6];    
        
        for(Shipping_Manifest__c SM : SMobjlst){
            lstSM.add(new ShipmentManifestPrintLabelTest(true,SM));    
        }
        lstSM.add(new ShipmentManifestPrintLabelTest(false,SMobjlst[0]));
        String str = JSON.serialize(lstSM);
      //  ShipmentManifestPrintLabel.generateImageXml(sm.Id,str,ShipmentManifestPrintLabel.TWOBYFOUR,'test',true);
        ShipmentManifestPrintLabel.generateImageXml(sm.Id,str,ShipmentManifestPrintLabel.FOURBYSIX,'test',true);
        System.assertNotEquals(sm.Id, str);
        ShipmentManifestPrintLabel.getImage4X6Xml(SMobjlst[0]); 
        ShipmentManifestPrintLabel.getImage1X2Xml(SMobjlst[0]);
       // ShipmentManifestPrintLabel.getImage2X4Xml(SMobjlst[0]);       
        string pro = 'test';
        ShipmentManifestPrintLabel.buildSecondPageXMLs(str);   
        ShipmentManifestPrintLabel.buildFirstPageXML(sm, str);   
        
        
        // dummy 
        Integer totalrecords = SMobjlst.size();
        Integer modval = math.mod(totalrecords, 9);
        system.debug('totalrecords>'+totalrecords);
        Integer	currentPage = 1;
        Integer totalRecInCurrentPage = 1;
        Integer currentRecInCurrentPage =1;
        Integer TotalPages=0;
        String secondPageString = '';
        String firstPageString = '';
        List<String> printLabelList = new List<String>();  
        
        if(totalrecords >= 5)
        {
            if(modval == 0)
            {
                TotalPages =totalrecords/9;
                system.debug('TotalPages>>'+TotalPages);
            }
            else if(modval < 6)
            {
                system.debug('im inside less then 6');
                TotalPages = (totalrecords/9)+1; 
                system.debug('TotalPages>>'+TotalPages);    
            }
            else if(modval >= 6)
            {
                system.debug('im inside >= then 6');
                TotalPages = (totalrecords/9)+2; 
                system.debug('TotalPages>>'+TotalPages);
            } 
            
        }
        else
        {
            TotalPages =1; 
            system.debug('TotalPages>>'+TotalPages);
        }      
        
        for( Integer i=0;i < totalrecords ; i++) {
            system.debug('insode for');
            
            if(currentPage == 1 && totalRecords < 5) {
                totalRecInCurrentPage = totalrecords;
                System.debug('totalRecords < 5.. '+totalRecInCurrentPage);
            }
            else if(currentPage == 1 &&  totalRecords >= 5){
                totalRecInCurrentPage = 5;
                System.debug('totalRecords = 5.. '+totalRecInCurrentPage);
            } 
            else if(currentPage < totalPages && currentPage != 1 ) {
                totalRecInCurrentPage = 9;
                System.debug('totalRecords = 9.. '+totalRecInCurrentPage);
            } 
            else if(currentPage == totalPages ) {
                totalRecInCurrentPage= math.mod((totalRecords - 5), 9);
                System.debug('totalRecords mod.. '+totalRecInCurrentPage);
            }
            //Integer TotalPages = 1;
            
            if (currentRecInCurrentPage == totalRecInCurrentPage) {
                
                system.debug('i am inside 1st if>>>>>>>>>>>>>>>>>>>>>>>>>');
                System.debug('currentRecInCurrentPage == totalRecInCurrentPage'+currentRecInCurrentPage + ','+  totalRecInCurrentPage);
                if(currentPage == 1 && str != '') {
                    ShipmentManifestPrintLabel.buildFirstPageXML(sm, str);    
                }
                if(currentPage > 1 && str != '') {
                    ShipmentManifestPrintLabel.buildSecondPageXMLs(str);   
                }
                currentPage++;
                currentRecInCurrentPage = 0;
                totalRecInCurrentPage = 0;
            }
        }
    }
    
    static void createTestData(){
        // Create Accounts
     List<Account> accounts = new List<Account>();
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        accounts.add(objAccount);   
        
        // distributor Account
        Account objAccount2 = new Account();
        objAccount2.Name = 'Test Account2';
        objAccount2.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        accounts.add(objAccount2);  
        
        // receiver Account
        Account objAccount3 = new Account();
        objAccount3.Name = 'Test Account3';
        objAccount3.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        accounts.add(objAccount3);
        
        insert accounts;
        
        // Create Contacts
        // supplier contact
        List<Contact> contacts = new List<Contact>();
        Contact objContact = new Contact();
        objContact.LastName = 'Test Contact1';
        objContact.AccountId = objAccount.Id;
        contacts.add(objContact);   
        
        // distributor contact
        Contact objContact2 = new Contact();
        objContact2.LastName = 'Test Contact2';
        objContact2.AccountId = objAccount2.Id;
        contacts.add(objContact2);  
        
        // receiver contact
        Contact objContact3 = new Contact();
        objContact3.LastName = 'Test Contact3';
        objContact3.AccountId = objAccount3.Id;
        contacts.add(objContact3);
        
        insert contacts;
        
        
        // Create Site
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.Warehouse_Name__c='test1';
        insert objSite;
        
        // Create State License
        
        // Supplier License
        List<State_Licenses__c> licenses = new List<State_Licenses__c>();
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_State__c = 'California';
        objStateLicenses.License_City__c = 'San Francisco';
        objStateLicenses.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses.License_Zip__c = '94124';
        objStateLicenses.Default_Warehouse__c = objSite.Id;
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        licenses.add(objStateLicenses);
        
        // distributor License
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount2.id;
        objStateLicenses2.License_Number__c = 'AbcTest45678';
        objStateLicenses2.License_Status__c ='Active';
        objStateLicenses2.License_Type__c ='Type 1';
        objStateLicenses2.License_Class__c='A-License';
        objStateLicenses2.License_State__c = 'California';
        objStateLicenses2.License_City__c = 'San Francisco';
        objStateLicenses2.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses2.License_Zip__c = '94124';
        objStateLicenses2.Default_Warehouse__c = objSite.Id;
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        licenses.add(objStateLicenses2); 
        
        // receiver License
        State_Licenses__c objStateLicenses3 = new State_Licenses__c();
        objStateLicenses3.License_Name__c = objAccount3.id;
        objStateLicenses3.License_Number__c = 'AbcTest54321';
        objStateLicenses3.License_Status__c ='Active';
        objStateLicenses3.License_Type__c ='Type 1';
        objStateLicenses3.License_Class__c='A-License';
        objStateLicenses3.License_State__c = 'California';
        objStateLicenses3.License_City__c = 'San Francisco';
        objStateLicenses3.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses3.License_Zip__c = '94124';
        objStateLicenses3.Default_Warehouse__c = objSite.Id;
        objStateLicenses3.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        
        licenses.add(objStateLicenses3);
        
        // receiver License
        State_Licenses__c objStateLicenses4 = new State_Licenses__c();
        objStateLicenses4.License_Name__c = objAccount3.id;
        objStateLicenses4.License_Number__c = 'AbcTest54321456';
        objStateLicenses4.License_Status__c ='Active';
        objStateLicenses4.License_Type__c ='Type 1';
        objStateLicenses4.License_Class__c='A-License';
        objStateLicenses4.Default_Warehouse__c = objSite.Id;
        objStateLicenses4.License_Expiration_Date__c = date.valueof(system.now()) - 10;
        licenses.add(objStateLicenses4);
        
        insert licenses;
        
        
        
        // Receiving Inspection inventory location
        List<Inventory_Location__c> inventoryLocations = new List<Inventory_Location__c>();
        Inventory_Location__c receivingInventoryLocation = new Inventory_Location__c();
        receivingInventoryLocation.Name = Label.Default_Inventory_Location;
        receivingInventoryLocation.Site_Name__c = objSite.id;
        receivingInventoryLocation.Default_for_Site__c = true;
        inventoryLocations.add(receivingInventoryLocation);
        
        // New Test inventory location
        Inventory_Location__c newInventoryLocation = new Inventory_Location__c();
        newInventoryLocation.Name = 'Test Location';
        newInventoryLocation.Site_Name__c = objSite.id;
        inventoryLocations.add(newInventoryLocation);
        
        insert inventoryLocations;
        
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
        
        // Create Product
        List<Product2> products = new List<Product2>();
       
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        
        //Create Product1
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
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
        products.add(objProduct1);
        
        // Create Product2
        Product2  objProduct2 = new Product2 ();
        objProduct2.Name = 'product 2';
        objProduct2.Quantity_Type__c = 'Quantity';
        objProduct2.Family = 'Accessories';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
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
        products.add(objProduct2);
        
        // Create Product3
        Product2  objProduct3 = new Product2 ();
        objProduct3.Name = 'product 3';
        objProduct3.Quantity_Type__c = 'Quantity';
        objProduct3.Family = 'Accessories';
        objProduct3.Description = 'test product 3';
        objProduct3.Producer_Name__c = objAccount.id;
        objProduct3.Apply_Cultivation_Tax__c='Yes';
        objProduct3.Apply_Excise_Tax__c='Yes';
        objProduct3.IsActive = true;
        objProduct3.Unit_Height__c  = 30.0;
        objProduct3.Unit_Length__c = 10.0;
        objProduct3.Unit_Width__c = 5.0;
        objProduct3.Apply_Excise_Tax__c = 'Yes';
        objProduct3.RecordTypeId = productRecordTypeId;
        objProduct3.Track_Trace_Category__c='Capsule';
        objProduct3.Net_Weight_UOM__c='EA';
        objProduct3.Unit_Of_Measure__c='Grams';
        objProduct3.MOQ__c = 1;
        products.add(objProduct3);
        
        insert products;
      
    }
}