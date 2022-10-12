@isTest(SEEALLDATA=true)
public class DataCRUDUtilityTest {
    private static testmethod void runTest(){
         // Create Accounts
     Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
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
        objContact.FirstName = 'Test Contact1';
        objContact.LastName = 'Test Contact1';
        objContact.AccountId = objAccount.Id;
        contacts.add(objContact);   
        
        // distributor contact
        Contact objContact2 = new Contact();
        objContact2.FirstName = 'Test Contact2';
        objContact2.LastName = 'Test Contact2';
        objContact2.AccountId = objAccount2.Id;
        contacts.add(objContact2);  
        
        // receiver contact
        Contact objContact3 = new Contact();
        objContact3.FirstName = 'Test Contact3';
        objContact3.LastName = 'Test Contact3';
        objContact3.AccountId = objAccount3.Id;
        contacts.add(objContact3);
        
        insert contacts;
        //Create Tax Table
        Tax_Table__c tb = new Tax_Table__c();
        tb.Tax_Due_Rate__c = 5;
        tb.Taxable_Gross_Receipts_Rate__c  = 25;
        tb.Actual_Tax_Rate_on_Product_Rev__c  = 0.5;
        tb.Active__c = true;
        tb.Start_Date__c = System.today().addDays(-10);
        tb.End_Date__c = System.today().addMonths(12);
        tb.City__c  = 'San Francisco';
        insert tb;
        
        
        // Create Site
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.Warehouse_Name__c='TestWarehouse1';
        insert objSite;
        
        
        // Create State License
        
        // Supplier License
        List<State_Licenses__c> licenses = new List<State_Licenses__c>();
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
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
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses2.Default_Warehouse__c = objSite.Id;
        objStateLicenses2.Total_Miles__c = 10;
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
        objStateLicenses3.Total_Miles__c = 10;
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
        objStateLicenses4.Total_Miles__c = 10;
        licenses.add(objStateLicenses4);
        
        insert licenses;
      
        
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
        insert shipRateTable;

          
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

        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = objStateLicenses.Id;
        ord.Sales_Person__c = objContact.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        
        
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
        opp.Order__c = ord.Id;
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
        
        // Create price book entry for first product
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id=Test.getStandardPricebookId(), Product2Id=objProduct1.Id, UnitPrice=99, isActive=true);
        insert pbe;
        
        // Create Opportunity line item
        OpportunityLineItem opLineItem=new OpportunityLineItem ();
        opLineItem.Quantity=1;
        opLineItem.OpportunityId =opp.id;
        opLineItem.TotalPrice =100;
        opLineItem.PricebookEntryId = pbe.id;
        opLineItem.Product2Id = objProduct1.Id;
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
        bq.Order_Type__c = 'Retailer';
        bq.Sales_person__c = objContact.Name;
        insert bq;
        
        // Create brand quote lines
        List<Brand_Quote_Line__c> brandQuoteLines = new List<Brand_Quote_Line__c>();
        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c= objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;
        objbqline1.Invoiced_Quantity__c = 20;
        objbqline1.Retail_Wholesale_Price__c  = 100;
        objbqline1.Billed_Quantity__c =10;
        brandQuoteLines.add(objbqline1);
        
        Brand_Quote_Line__c objbqline2 = new Brand_Quote_Line__c();
        objbqline2.Brand_Quote_Number__c = bq.id;
        objbqline2.Product_Name__c= objProduct2.id;
        objbqline2.MOQ__c = 20;
        objbqline2.Quantity_Cases__c = 50;
        objbqline2.Invoiced_Quantity__c = 20;
        objbqline2.Retail_Wholesale_Price__c  = 100;
        objbqline2.Billed_Quantity__c =10;
        brandQuoteLines.add(objbqline2);
        
        Brand_Quote_Line__c objbqline3 = new Brand_Quote_Line__c();
        objbqline3.Brand_Quote_Number__c = bq.id;
        objbqline3.Product_Name__c= objProduct3.id;
        objbqline3.MOQ__c = 8;
        objbqline3.Quantity_Cases__c = 100;
        objbqline3.Invoiced_Quantity__c = 20;
        objbqline3.Retail_Wholesale_Price__c  = 100;
        objbqline3.Billed_Quantity__c =10;
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
        objPOline1.Brand_Quote_Line__c =  objbqline1.Id;
        
        Purchase_Order_Line__c objPOline2 = new Purchase_Order_Line__c();
        objPOline2.Purchase_Order__c = objPO.id;
        objPOline2.Product_Name__c= objbqline2.Product_Name__c;
        objPOline2.Qty_Ordered__c = 20;
        objPOline2.Unit_Cost__c = 20;
        objPOline2.Brand_Quote_Line__c =  objbqline2.Id;
        
        Purchase_Order_Line__c objPOline3 = new Purchase_Order_Line__c();
        objPOline3.Purchase_Order__c = objPO.id;
        objPOline3.Product_Name__c= objbqline3.Product_Name__c;
        objPOline3.Qty_Ordered__c = 30;
        objPOline3.Unit_Cost__c = 30;
        objPOline3.Brand_Quote_Line__c =  objbqline3.Id;
        
        list<Purchase_Order_Line__c> purchaseOrderLines = new list<Purchase_Order_Line__c>();
        purchaseOrderLines.add(objPOline1);
        purchaseOrderLines.add(objPOline2);
        purchaseOrderLines.add(objPOline3);
        insert purchaseOrderLines;
        
       
       
        
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
        objSO.Account_Hold_Exception__c = true;
        objSO.Opportunity_Name__c = opp.Id;
        
        insert objSO;    
            
        Sales_Order_Line__c objSOline1 = new Sales_Order_Line__c();
        objSOline1.Sales_Order__c = objSO.id;
        objSOline1.Product_Name__c= objbqline1.Product_Name__c;
        objSOline1.Product_Title__c = 'Distributor';
        objSOline1.Qty_Ordered__c = 10;
        objSOline1.Qty_Invoiced__c = 5.0;
        objSOline1.Retail_Wholesale_Price__c = 10;
        objSOline1.Status__c = 'Allocated';
        
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
        inv.Brand_Quote__c = bq.Id;
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
        
        
        insert ivoiceLines;
        inv.Receiver_Name__c = objAccount.Id;
        inv.Receiver_License__c = objStateLicenses.Id;
        inv.Invoice_Date__c = System.today();
        update inv;
        insert invLine3;
 /*   //Create Account
 
        //supplier Account
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        //distributor Account
        Account objAccount2 = new Account();
        objAccount2.Name = 'Test Account2';
        objAccount2.Payment_Terms__c = 'COD';
        insert objAccount2;
        //receiver Account
        Account objAccount3 = new Account();
        objAccount3.Name = 'Test Account3';
        objAccount3.Payment_Terms__c = 'COD';
        insert objAccount3;

        //Create State License

        //Supplier License
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c = 'Active';
        objStateLicenses.License_Type__c = 'Type 1';
        objStateLicenses.License_Class__c = 'A-License';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now());
        insert objStateLicenses;
        //distributor License
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount2.id;
        objStateLicenses2.License_Number__c = 'AbcTest45678';
        objStateLicenses2.License_Status__c = 'Active';
        objStateLicenses2.License_Type__c = 'Type 1';
        objStateLicenses2.License_Class__c = 'A-License';
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now());
        insert objStateLicenses2;
        //receiver License
        State_Licenses__c objStateLicenses3 = new State_Licenses__c();
        objStateLicenses3.License_Name__c = objAccount3.id;
        objStateLicenses3.License_Number__c = 'AbcTest54321';
        objStateLicenses3.License_Status__c = 'Expired';
        objStateLicenses3.License_Type__c = 'Type 1';
        objStateLicenses3.License_Class__c = 'A-License';
        objStateLicenses3.License_Expiration_Date__c = date.valueof(system.now());

        insert objStateLicenses3;

        //Create Site.
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        //objSite.License_ID__c= objStateLicenses.id;
        insert objSite;



        Inventory_Location__c newInventoryLocation = new Inventory_Location__c();
        newInventoryLocation.Name = 'Test InventoryLocation';
        newInventoryLocation.Site_Name__c = objSite.id;
        newInventoryLocation.Default_for_Site__c = true;

        insert newInventoryLocation;

        RecordType bqType = [select id, name, developername from recordtype where developername = 'Buy_Sell_Opportunity' limit 1];
        Opportunity opp = new Opportunity();
        opp.AccountId = objAccount.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName = 'Qualification';
        opp.RecordTypeId = bqType.Id;
        opp.Site_Name__c = objSite.Id;
        opp.Ownership__c = objAccount.id;
        opp.Payment_Terms__c='COD';

        insert opp;

        System.debug('opp.id' + opp.id);

        //Create Product

        //Create Product1
        Product2 objProduct1 = new Product2();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c = 'Yes';
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.IsActive = true;
        insert objProduct1;
        //Create Product2
        Product2 objProduct2 = new Product2();
        objProduct2.Name = 'product 2';
        objProduct2.Family = 'Accessories';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
        objProduct2.Apply_Cultivation_Tax__c = 'Yes';
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.IsActive = true;
        insert objProduct2;

        PricebookEntry pbe = [SELECT Id FROM PricebookEntry where isActive = true LIMIT 1];

        //Create New Opportunity
        OpportunityLineItem opLineItem = new OpportunityLineItem();
        opLineItem.Quantity = 1;
        opLineItem.OpportunityId = opp.id;
        opLineItem.TotalPrice = 100;
        opLineItem.PricebookEntryId = pbe.id;
        insert opLineItem;


        RecordType bqTypeID = [select id, name, developername from recordtype where developername = 'Sell_Quote' limit 1];
        Brand_Quote__c bq = new Brand_Quote__c();
        bq.Opportunity_Name__c = opp.id;
        bq.Distributor_Name__c = objAccount2.id;
        bq.Distributor_License__c = objStateLicenses2.id;
        bq.Receiver_Name__c = opp.AccountId;
        bq.Receiver_License__c = objStateLicenses.id;
        bq.Supplier_Name__c = opp.Ownership__c;
        bq.Supplier_License__c = objStateLicenses.id;
        bq.BQ_Status__c = 'Cancelled';
        bq.Shipping_Method__c = 'Distributor Pick-up';
        bq.Sales_Origin__c = 'Brand';
        bq.Shipping_Terms__c = 'CFR';
        bq.Payment_Terms__c = 'COD';
        bq.Site__c = objSite.id;
        bq.RecordTypeId = bqTypeID.Id;
        bq.Ownership__c = opp.Ownership__c;
        insert bq;
        
        Brand_Quote__c bq1 = new Brand_Quote__c();
        bq1.Opportunity_Name__c = opp.id;
        bq1.Distributor_Name__c = objAccount3.id;
        bq1.Distributor_License__c = objStateLicenses3.id;
        bq1.Receiver_Name__c = opp.AccountId;
        bq1.Receiver_License__c = objStateLicenses.id;
        bq1.Supplier_Name__c = opp.Ownership__c;
        bq1.Supplier_License__c = objStateLicenses.id;
        bq1.BQ_Status__c = 'Cancelled';
        bq1.Shipping_Method__c = 'Distributor Pick-up';
        bq1.Sales_Origin__c = 'Brand';
        bq1.Shipping_Terms__c = 'CFR';
        bq1.Payment_Terms__c = 'COD';
        bq1.Site__c = objSite.id;
        bq1.RecordTypeId = bqTypeID.Id;
        bq1.Ownership__c = opp.Ownership__c;
        insert bq1;
        
        Brand_Quote__c bq2 = new Brand_Quote__c();
        bq2.Opportunity_Name__c = opp.id;
        bq2.Distributor_Name__c = objAccount3.id;
        bq2.Receiver_Name__c = opp.AccountId;
        bq2.Receiver_License__c = objStateLicenses.id;
        bq2.Supplier_Name__c = opp.Ownership__c;
        bq2.Supplier_License__c = objStateLicenses.id;
        bq2.BQ_Status__c = 'Cancelled';
        bq2.Shipping_Method__c = 'Distributor Pick-up';
        bq2.Sales_Origin__c = 'Brand';
        bq2.Shipping_Terms__c = 'CFR';
        bq2.Payment_Terms__c = 'COD';
        bq2.Site__c = objSite.id;
        bq2.RecordTypeId = bqTypeID.Id;
        bq2.Ownership__c = opp.Ownership__c;
        insert bq2;
        
        Brand_Quote__c bq3 = new Brand_Quote__c();
        bq3.Opportunity_Name__c = opp.id;
        bq3.Distributor_Name__c = objAccount3.id;
        bq3.Distributor_License__c = objStateLicenses3.id;
        bq3.Receiver_Name__c = opp.AccountId;
        bq3.Receiver_License__c = objStateLicenses.id;
        bq3.Supplier_Name__c = opp.Ownership__c;

        bq3.BQ_Status__c = 'Cancelled';
        bq3.Shipping_Method__c = 'Distributor Pick-up';
        bq3.Sales_Origin__c = 'Brand';
        bq3.Shipping_Terms__c = 'CFR';
        bq3.Payment_Terms__c = 'COD';
        bq3.Site__c = objSite.id;
        bq3.RecordTypeId = bqTypeID.Id;
        bq.Ownership__c = opp.Ownership__c;
        insert bq3;
        
        Brand_Quote__c bq4 = new Brand_Quote__c();
        bq4.Opportunity_Name__c = opp.id;
        bq4.Distributor_Name__c = objAccount3.id;
        bq4.Distributor_License__c = objStateLicenses3.id;
        bq4.Receiver_Name__c = opp.AccountId;

        bq4.Supplier_Name__c = opp.Ownership__c;
        bq4.Supplier_License__c = objStateLicenses.id;
        bq4.BQ_Status__c = 'Cancelled';
        bq4.Shipping_Method__c = 'Distributor Pick-up';
        bq4.Sales_Origin__c = 'Brand';
        bq4.Shipping_Terms__c = 'CFR';
        bq4.Payment_Terms__c = 'COD';
        bq4.Site__c = objSite.id;
        bq4.RecordTypeId = bqTypeID.Id;
        bq4.Ownership__c = opp.Ownership__c;
        insert bq4;*/
        
        DataCRUDUtility.getRecordName(bq.Id);
        DataCRUDUtility.getBQStatus(bq.Id);
        
      
	}
}