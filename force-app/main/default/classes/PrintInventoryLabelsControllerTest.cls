/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * PrintInventoryLabelsControllerTest
 */
@isTest
public class PrintInventoryLabelsControllerTest {
    
    static List<Inventory_Position__c> invPositions;
    static List<Product2> products;
    static List<Inventory_Location__c> invLocations;
     
    @TestSetUp
        static void testDataSetUp(){
        createTestData();
    }
  
  // Retrieve data created from data setup
    public static void retrieveData(){
        
        products = [Select Id from Product2];
        
        products[0].Cannabis_Weight__c = 10.0;
        update products[0];
        
        invLocations = [Select Id, Include_in_Inventory__c From Inventory_Location__c];
        for(Inventory_Location__c invLocationSO : invLocations){
            invLocationSO.Include_in_Inventory__c = true;
        }
        update invLocations;
    }

    static testMethod void inventoryDetailsTest(){
        
        retrieveData();
        PageReference pageRef = Page.PrintInventoryLabels;
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController stdController = new ApexPages.StandardController(products[0]);
        PrintInventoryLabelsController controllerObj = new PrintInventoryLabelsController(stdController);
        controllerObj.retrieveInventoryPositions();
        controllerObj.redirectItemDetail();
        controllerObj.getDymoLabelLayouts();
        
        controllerObj.generateImageXml();
        
        controllerObj.selectedDymoLabelLayout = PrintInventoryLabelsController.ONEBYTHREE;
        //controllerObj.invPositionWrappList[0].isSelected = true;
        controllerObj.generateImageXml();
        
        controllerObj.selectedDymoLabelLayout = PrintInventoryLabelsController.TWOBYFOUR;
        controllerObj.generateImageXml();
        
        controllerObj.selectedDymoLabelLayout = PrintInventoryLabelsController.FOURBYSIX;
        controllerObj.generateImageXml();
        
        PrintInventoryLabelsController.inventoryDetails(products[0].Id);
        
        List<InventoryPositionWrapper> lstInv = new List<InventoryPositionWrapper>();
        invPositions = [Select Inventory_Location__c,Name,Supplier_Name__c,License_Premise__c,Rack_Level__r.Name,
                        Supplier_License_Number__c,Product_Name__r.Name,Product_Description__c,Rack__r.Name,
                        Purchase_Order__c,Date_Received__c,Harvest_Batch_Code__r.Name,Stocking_UOM__c,Bin_Location__r.Name ,
                        UID_New__r.Name,Ownership__r.Name,Qty_Allocated__c,Quantity_Type__c,
                        Rack__c, Rack_Level__c, Bin_Location__c,Qty_On_Hand__c From Inventory_Position__c];
        for(Inventory_Position__c inv : invPositions){
        	lstInv.add(new InventoryPositionWrapper(true,inv));    
        }
        lstInv.add(new InventoryPositionWrapper(false,invPositions[0]));
        String str = JSON.serialize(lstInv);
        PrintInventoryLabelsController.generateImageXml(products[0].Id,str,PrintInventoryLabelsController.TWOBYFOUR,'test',true);
        System.assertNotEquals(products[0].Id, str);
        
        PrintInventoryLabelsController.fetchFilterProducts(invPositions[0].Name,str,products[0].Id);
        PrintInventoryLabelsController.getImage1X3Xml(invPositions[0]);
        PrintInventoryLabelsController.getImage4X6Xml(invPositions[0]);
        //System.debug('SIZE = '+invPositions.size());
    }
    
    static void createTestData(){
        // Create Accounts
     
        // supplier Account
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
        products.add(objProduct3);
        
        insert products;
        
        // Create price book entry for first product
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id=Test.getStandardPricebookId(), Product2Id=objProduct1.Id, UnitPrice=99, isActive=true);
        insert pbe;
        
        // Create Opportunity line item
        OpportunityLineItem opLineItem=new OpportunityLineItem ();
        opLineItem.Quantity=1;
        opLineItem.OpportunityId =opp.id;
        opLineItem.TotalPrice =100;
        opLineItem.PricebookEntryId = pbe.id;
        insert opLineItem;

        // Create brand quote
        Brand_Quote__c bq = new Brand_Quote__c ();
        bq.Opportunity_Name__c = opp.id; 
        bq.Distributor_License__c = objStateLicenses2.id;
        bq.Receiver_License__c = objStateLicenses3.id;
        bq.Distributor_Name__c = objAccount2.id;
        bq.Supplier_Name__c = objAccount.id;
        bq.Receiver_Name__c = objAccount3.id;
        bq.Supplier_License__c = objStateLicenses.id;
        bq.BQ_Status__c = 'Draft';
        bq.Shipping_Method__c = 'Distributor Pick-up';
        bq.Sales_Origin__c = 'Brand';
        bq.Shipping_Terms__c = 'CFR';        
        bq.Site__c = objSite.id;
        bq.Ownership__c = opp.Ownership__c;
        bq.Payment_Terms__c = opp.Payment_Terms__c;
        bq.Apply_Excise_Tax__c = true;
        insert bq;
        
        // Create brand quote lines
        List<Brand_Quote_Line__c> brandQuoteLines = new List<Brand_Quote_Line__c>();
        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c= objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;
        brandQuoteLines.add(objbqline1);
        
        Brand_Quote_Line__c objbqline2 = new Brand_Quote_Line__c();
        objbqline2.Brand_Quote_Number__c = bq.id;
        objbqline2.Product_Name__c= objProduct2.id;
        objbqline2.MOQ__c = 20;
        objbqline2.Quantity_Cases__c = 50;
        brandQuoteLines.add(objbqline2);
        
        Brand_Quote_Line__c objbqline3 = new Brand_Quote_Line__c();
        objbqline3.Brand_Quote_Number__c = bq.id;
        objbqline3.Product_Name__c= objProduct3.id;
        objbqline3.MOQ__c = 8;
        objbqline3.Quantity_Cases__c = 100;
        brandQuoteLines.add(objbqline3);
        
        insert brandQuoteLines;
        
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
        insert objPO;
        
        // Create purchase order lines  
        Purchase_Order_Line__c objPOline1 = new Purchase_Order_Line__c();
        objPOline1.Purchase_Order__c = objPO.id;
        objPOline1.Product_Name__c= objbqline1.Product_Name__c;
        objPOline1.Qty_Ordered__c = 10;
        objPOline1.Unit_Cost__c = 10;
        
        Purchase_Order_Line__c objPOline2 = new Purchase_Order_Line__c();
        objPOline2.Purchase_Order__c = objPO.id;
        objPOline2.Product_Name__c= objbqline2.Product_Name__c;
        objPOline2.Qty_Ordered__c = 20;
        objPOline2.Unit_Cost__c = 20;
        
        Purchase_Order_Line__c objPOline3 = new Purchase_Order_Line__c();
        objPOline3.Purchase_Order__c = objPO.id;
        objPOline3.Product_Name__c= objbqline3.Product_Name__c;
        objPOline3.Qty_Ordered__c = 30;
        objPOline3.Unit_Cost__c = 30;
        
        list<Purchase_Order_Line__c> purchaseOrderLines = new list<Purchase_Order_Line__c>();
        purchaseOrderLines.add(objPOline1);
        purchaseOrderLines.add(objPOline2);
        purchaseOrderLines.add(objPOline3);
        insert purchaseOrderLines;
        
        // Create Receiving
        Receiving__c objReceiving = new Receiving__c(Purchase_Order__c= objPO.id, Site__c= objPO.Site__c, Ownership__c = objPO.Ownership__c );
        insert objReceiving;
        
        // Create 3 receiving lines which will create inventory positions automatically
        List<Receiving_Line__c> receivingLines = new List<Receiving_Line__c>();
        for(Integer i=0; i<purchaseOrderLines.size(); i++){
            Receiving_Line__c objReceivingLine = new Receiving_Line__c();
            objReceivingLine.Inventory_Location__c = receivingInventoryLocation.Id;
            objReceivingLine.Product_Name__c = products[i].Id;
            objReceivingLine.Purchase_Order_Line__c = purchaseOrderLines[i].Id;
            objReceivingLine.Qty_to_Receive__c = 5.0;
            objReceivingLine.Receiving_ID__c = objReceiving.Id;
            objReceivingLine.Site__c = objSite.Id;
            objReceivingLine.UID__c = 'TEST' + i;
            objReceivingLine.Ownership__c = objAccount.Id;
            receivingLines.add(objReceivingLine);
        }
        insert receivingLines;
        
        // Create Racks
        List<Rack__c> racks = new List<Rack__c>();
        Rack__c rackSO = new Rack__c();
        rackSO.Inventory_Location__c = newInventoryLocation.Id;
        racks.add(rackSO);
        insert racks;
        
        // Create Rack Levels
        List<Rack_Level__c> rackLevels = new List<Rack_Level__c>();
        Rack_Level__c rackLevelSO = new Rack_Level__c();
        rackLevelSO.Rack__c = racks[0].Id;
        rackLevels.add(rackLevelSO);
        insert rackLevels;
        
        // Create Bin Locations
        List<Bin_Location__c> binLocations = new List<Bin_Location__c>();
        Bin_Location__c binLocationSO = new Bin_Location__c();
        binLocationSO.Rack_Level__c = rackLevels[0].Id;
        binLocationSO.Bin_Height__c = 10.0;
        binLocationSO.Bin_Length__c = 10.0;
        binLocationSO.Bin_Width__c = 20.0;
        binLocations.add(binLocationSO);
        insert binLocations;
        
        Sales_Order__c objSO = new Sales_Order__c();
        objSO.Site__c = bq.Site__c;
        objSO.SO_Status__c = 'Draft';
        objSO.SO_Type__c = 'Sell Quote';
        objSO.Brand_Quote__c = bq.id;
        objSO.Supplier_Contact__c = objContact.Id;
        objSO.Supplier_Name__c = bq.Supplier_Name__c;
        objSO.Supplier_License__c = bq.Supplier_License__c;
        objSO.Distributor_Contact__c = objContact2.Id;
        objSO.Distributor_Name__c = bq.Distributor_Name__c;
        objSO.Distributor_License__c = bq.Distributor_License__c;
        objSO.Receiver_Name__c = bq.Receiver_Name__c;
        objSO.Receiver_Contact__c = objContact3.Id;
        objSO.Receiver_License__c = bq.Receiver_License__c;
        objSO.Payment_Terms__c = bq.Payment_Terms__c;
        objSO.Shipping_Terms__c = bq.Shipping_Terms__c;
        objSO.Shipping_Method__c = bq.Shipping_Method__c;
        objSO.Ownership__c = accounts[0].Id;
        objSO.Customer_PO_or_Quote__c = 'Test Quote';
        objSO.Opportunity_Name__c = opp.Id;
        
        insert objSO;    
            
        Sales_Order_Line__c objSOline1 = new Sales_Order_Line__c();
        objSOline1.Sales_Order__c = objSO.id;
        objSOline1.Product_Name__c= objbqline1.Product_Name__c;
        objSOline1.Product_Title__c = 'Distributor';
        objSOline1.Qty_Ordered__c = 10;
        objSOline1.Qty_Invoiced__c = 5.0;
        objSOline1.Retail_Wholesale_Price__c = 10;
        
        Sales_Order_Line__c objSOline2 = new Sales_Order_Line__c();
        objSOline2.Sales_Order__c = objSO.id;
        objSOline2.Product_Name__c= objbqline2.Product_Name__c;
        objSOline2.Product_Title__c = 'Distributor';
        objSOline2.Qty_Ordered__c = 20;
        objSOline2.Qty_Invoiced__c = 15.0;
        objSOline2.Retail_Wholesale_Price__c = 20;
        
        Sales_Order_Line__c objSOline3 = new Sales_Order_Line__c();
        objSOline3.Sales_Order__c = objSO.id;
        objSOline3.Product_Name__c= objbqline3.Product_Name__c;
        objSOline3.Product_Title__c = 'Distributor';
        objSOline3.Qty_Ordered__c = 30;
        objSOline3.Qty_Invoiced__c = 25.0;
        objSOline3.Retail_Wholesale_Price__c = 30;
        
        list<Sales_Order_Line__c> lstSalesOrderLine = new list<Sales_Order_Line__c>();
        lstSalesOrderLine.add(objSOline1);
        lstSalesOrderLine.add(objSOline2);
        lstSalesOrderLine.add(objSOline3);
        
        insert lstSalesOrderLine;
        
        Invoice__c inv = new Invoice__c();
        inv.Sales_Order__c = objSO.id;
        inv.AR_Status__c = 'Draft';
        insert inv;
        
        Invoice_Line__c invLine1 = new Invoice_Line__c();
        invline1.Invoice__c = inv.id;
        invLine1.Sales_Order_Line__c = lstSalesOrderLine[0].Id;
        invLine1.Invoice_Qty__c = 5.0;
        invLine1.Retail_Wholesale_Price__c = 100.0;
        invLine1.Excise_Tax_Amount__c = 10.0;
        invLine1.Product_Name__c = objProduct1.Id;
        
        Invoice_Line__c invLine2 = new Invoice_Line__c();
        invLine2.Invoice__c = inv.id;
        invLine2.Sales_Order_Line__c = lstSalesOrderLine[1].Id;
        invLine2.Invoice_Qty__c = 15.0;
        invLine2.Retail_Wholesale_Price__c = 100.0;
        invLine2.Excise_Tax_Amount__c = 15.0;
        invLine2.Product_Name__c = objProduct2.Id;
        
        Invoice_Line__c invLine3 = new Invoice_Line__c();
        invLine3.Invoice__c = inv.id;
        invLine3.Sales_Order_Line__c = lstSalesOrderLine[2].Id;
        invLine3.Invoice_Qty__c = 25.0;
        invLine3.Retail_Wholesale_Price__c = 100.0;
        invLine3.Excise_Tax_Amount__c = 20.0;
        invLine3.Product_Name__c = objProduct3.Id;
        
        list<Invoice_Line__c> ivoiceLines = new list<Invoice_Line__c>();
        ivoiceLines.add(invLine1);
        ivoiceLines.add(invLine2);
        ivoiceLines.add(invLine3);
        
        insert ivoiceLines;
    }
}