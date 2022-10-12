@istest
public class QuickBookConncetionTest {
        static State_Licenses__c receiverLicenseObj;
// static Invoice__c invoiceObj;
static testMethod void theTests(){
    Account objAccount = new Account();
    objAccount.Name = 'Testsd';
   // objAccount.Payment_Terms__c = 'COD'; 
    objAccount.BillingCity='tes4t2';
    objAccount.BillingCountry='cnrtrys';
    objAccount.BillingPostalCode='90000442';
    objAccount.BillingStreet='sw';
    objAccount.BillingState='stw';
    objAccount.Phone='32322434';
    objAccount.DBA__c='test2';
    insert objAccount;
   Account  accObj = [select id, name,DBA__c,QB_Customer_ID__c,Phone,BillingCity,BillingStreet,BillingCountry,BillingState,BillingPostalCode from Account limit 1];
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    Test.setMock(HttpCalloutMock.class, new QuickBookConnection_MockTest());
    QuickBookConncetion.SyncAccountWithQuickBooksCutomer(objAccount.Id);
//QuickBookConncetion.SyncProductsWithQuickBooksdoint(objAccount.Id);
    Test.stopTest();
       
  //  QuickBookConncetion.SyncAccountWithQuickBooksVendor(objAccount.Id);
}
 static testMethod void theTestscontact(){
    Account objAccount = new Account();
    objAccount.Name = 'Testsd';
   // objAccount.Payment_Terms__c = 'COD'; 
    objAccount.BillingCity='tes4t2';
    objAccount.BillingCountry='cnrtrys';
    objAccount.BillingPostalCode='90000442';
    objAccount.BillingStreet='sw';
    objAccount.BillingState='stw';
    objAccount.Phone='32322434';
    objAccount.DBA__c='test2';
     objAccount.QB_Customer_ID__c=1;
    insert objAccount;
      Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
      objContact.Salutation = 'MS';
    // objContact.Account.QB_Customer_ID__c= objAccount.QB_Customer_ID__c;
        objContact.AccountId = objAccount.Id;
       insert  objContact ;
 Contact  accObj = [select id, FirstName,LastName,Salutation,Account.QB_Customer_ID__c,Account.QB_VendorId__c from Contact where id=: objContact.Id];
     accObj.Account.QB_Customer_ID__c = 1;
         // accObj.Account.QB_VendorId__c = 5;

     update accObj;
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    Test.setMock(HttpCalloutMock.class, new QuickBookConnection_MockTest());
    QuickBookConncetion.checkRecordsContact(accObj.Id);
//QuickBookConncetion.SyncProductsWithQuickBooksdoint(objAccount.Id);
    Test.stopTest();
       
  //  QuickBookConncetion.SyncAccountWithQuickBooksVendor(objAccount.Id);
}   
   static testMethod void theTestscontactvendor(){
    Account objAccount = new Account();
    objAccount.Name = 'Testsd';
   // objAccount.Payment_Terms__c = 'COD'; 
    objAccount.BillingCity='tes4t2';
    objAccount.BillingCountry='cnrtrys';
    objAccount.BillingPostalCode='90000442';
    objAccount.BillingStreet='sw';
    objAccount.BillingState='stw';
    objAccount.Phone='32322434';
    objAccount.DBA__c='test2';
     objAccount.QB_VendorId__c=1;
    insert objAccount;
      Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
      objContact.Salutation = 'MS';
    // objContact.Account.QB_Customer_ID__c= objAccount.QB_Customer_ID__c;
        objContact.AccountId = objAccount.Id;
       insert  objContact ;
 Contact  accObj = [select id, FirstName,LastName,Salutation,Account.QB_Customer_ID__c,Account.QB_VendorId__c from Contact where id=: objContact.Id];
     accObj.Account.QB_VendorId__c = 1;
         // accObj.Account.QB_VendorId__c = 5;

     update accObj;
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    Test.setMock(HttpCalloutMock.class, new QuickBookConnection_MockTest());
    QuickBookConncetion.checkRecordsContact(accObj.Id);
//QuickBookConncetion.SyncProductsWithQuickBooksdoint(objAccount.Id);
    Test.stopTest();
       
  //  QuickBookConncetion.SyncAccountWithQuickBooksVendor(objAccount.Id);
}    
    static testMethod void theTestscontactvendorcust(){
    Account objAccount = new Account();
    objAccount.Name = 'Testsd';
   // objAccount.Payment_Terms__c = 'COD'; 
    objAccount.BillingCity='tes4t2';
    objAccount.BillingCountry='cnrtrys';
    objAccount.BillingPostalCode='90000442';
    objAccount.BillingStreet='sw';
    objAccount.BillingState='stw';
    objAccount.Phone='32322434';
    objAccount.DBA__c='test2';
     objAccount.QB_VendorId__c=1; 
        objAccount.QB_Customer_ID__c=10;
    insert objAccount;
      Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
      objContact.Salutation = 'MS';
    // objContact.Account.QB_Customer_ID__c= objAccount.QB_Customer_ID__c;
        objContact.AccountId = objAccount.Id;
       insert  objContact ;
 Contact  accObj = [select id, FirstName,LastName,Salutation,Email,Account.QB_Customer_ID__c,Account.QB_VendorId__c from Contact where id=: objContact.Id];
     accObj.Account.QB_VendorId__c = 1;
         accObj.Account.QB_VendorId__c = 5;
        accObj.Salutation='Ms';
          accObj.FirstName = 'Test';
        accObj.LastName = 'Contact1';
      accObj.Salutation = 'MS';
         accObj.Email = 'test@gmail.com';
       
     update accObj;
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    Test.setMock(HttpCalloutMock.class, new QuickBookConnection_MockTest());
    QuickBookConncetion.SyncAccountWithQuickBooksContact(accObj.Id);
//QuickBookConncetion.SyncProductsWithQuickBooksdoint(objAccount.Id);
    Test.stopTest();
       
  //  QuickBookConncetion.SyncAccountWithQuickBooksVendor(objAccount.Id);
}    
   static testMethod void theTestscontactvendorvendor(){
    Account objAccount = new Account();
    objAccount.Name = 'Testsd';
   // objAccount.Payment_Terms__c = 'COD'; 
    objAccount.BillingCity='tes4t2';
    objAccount.BillingCountry='cnrtrys';
    objAccount.BillingPostalCode='90000442';
    objAccount.BillingStreet='sw';
    objAccount.BillingState='stw';
    objAccount.Phone='32322434';
    objAccount.DBA__c='test2';
     objAccount.QB_VendorId__c=1; 
        objAccount.QB_Customer_ID__c=10;
    insert objAccount;
      Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
      objContact.Salutation = 'MS';
    // objContact.Account.QB_Customer_ID__c= objAccount.QB_Customer_ID__c;
        objContact.AccountId = objAccount.Id;
       insert  objContact ;
 Contact  accObj = [select id, FirstName,LastName,Salutation,Email,Account.QB_Customer_ID__c,Account.QB_VendorId__c from Contact where id=: objContact.Id];
     accObj.Account.QB_VendorId__c = 1;
         accObj.Account.QB_VendorId__c = 5;
        accObj.Salutation='Ms';
          accObj.FirstName = 'Test';
        accObj.LastName = 'Contact1';
      accObj.Salutation = 'MS';
         accObj.Email = 'test@gmail.com';
       
     update accObj;
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    Test.setMock(HttpCalloutMock.class, new QuickBookConnection_MockTest());
    QuickBookConncetion.SyncAccountWithQuickBooksvendorContact(accObj.Id);
//QuickBookConncetion.SyncProductsWithQuickBooksdoint(objAccount.Id);
    Test.stopTest();
       
  //  QuickBookConncetion.SyncAccountWithQuickBooksVendor(objAccount.Id);
} 



    
    static testMethod void theTestswithQB(){
    Account objAccount = new Account();
    objAccount.Name = 'Testsd';
   // objAccount.Payment_Terms__c = 'COD'; 
    objAccount.BillingCity='tes4t2';
        objAccount.QB_Customer_ID__c=1;
    objAccount.BillingCountry='cnrtrys';
    objAccount.BillingPostalCode='90000442';
    objAccount.BillingStreet='sw';
    objAccount.BillingState='stw';
    objAccount.Phone='32322434';
    objAccount.DBA__c='test2';
    insert objAccount;
   Account  accObj = [select id, name,DBA__c,QB_Customer_ID__c,Phone,BillingCity,BillingStreet,BillingCountry,BillingState,BillingPostalCode from Account limit 1];
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    Test.setMock(HttpCalloutMock.class, new QuickBookConnection_MockTest());
    QuickBookConncetion.SyncAccountWithQuickBooksCutomer(objAccount.Id);
    Test.stopTest();
       
  //  QuickBookConncetion.SyncAccountWithQuickBooksVendor(objAccount.Id);
}
        static testMethod void theTestswithvendor(){
    Account objAccount = new Account();
    objAccount.Name = 'Testsd';
   // objAccount.Payment_Terms__c = 'COD'; 
    objAccount.BillingCity='tes4t2';
        objAccount.QB_VendorId__c=2;
    objAccount.BillingCountry='cnrtrys';
    objAccount.BillingPostalCode='90000442';
    objAccount.BillingStreet='sw';
    objAccount.BillingState='stw';
    objAccount.Phone='32322434';
    objAccount.DBA__c='test2';
    insert objAccount;
   Account  accObj = [select id, name,DBA__c,QB_Customer_ID__c,Phone,BillingCity,BillingStreet,BillingCountry,BillingState,BillingPostalCode from Account limit 1];
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    Test.setMock(HttpCalloutMock.class, new QuickBookConnection_MockTest());
        QuickBookConncetion.SyncAccountWithQuickBooksVendor(objAccount.Id);
    Test.stopTest();
       
  //  QuickBookConncetion.SyncAccountWithQuickBooksVendor(objAccount.Id);
}
        static testMethod void theTestswithvendorQB(){
    Account objAccount = new Account();
    objAccount.Name = 'Testsd';
   // objAccount.Payment_Terms__c = 'COD'; 
    objAccount.BillingCity='tes4t2';
      //  objAccount.QB_Customer_ID__c=1;
    objAccount.BillingCountry='cnrtrys';
    objAccount.BillingPostalCode='90000442';
    objAccount.BillingStreet='sw';
    objAccount.BillingState='stw';
    objAccount.Phone='32322434';
    objAccount.DBA__c='test2';
    insert objAccount;
   Account  accObj = [select id, name,DBA__c,QB_Customer_ID__c,Phone,BillingCity,BillingStreet,BillingCountry,BillingState,BillingPostalCode from Account limit 1];
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    Test.setMock(HttpCalloutMock.class, new QuickBookConnection_MockTest());
        QuickBookConncetion.SyncAccountWithQuickBooksVendor(objAccount.Id);
    Test.stopTest();
         
  //  QuickBookConncetion.SyncAccountWithQuickBooksVendor(objAccount.Id);
}
    static testMethod void theTestsproduct(){
     Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
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
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    Test.setMock(HttpCalloutMock.class, new QuickBookConnection_MockTest());
QuickBookConncetion.checkRecordsActive(objProduct1.Id);
    Test.stopTest();
       
}
    static testMethod void theTestsproduct2(){
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
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
        
        //Instantiate the Pricebook2 record with StandardPricebookId
        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        
        //Execute an update DML on the Pricebook2 record, to make IsStandard to true
        Update standardPricebook;
        
        //Query for the Pricebook2 record, to check IsStandard field
        standardPricebook = [SELECT Id, IsStandard FROM Pricebook2 WHERE Id = :standardPricebook.Id];
        //It should return true
        System.assertEquals(true, standardPricebook.IsStandard);
        
        
        //Create the PricebookEntry
        PricebookEntry pbe = new PricebookEntry(
            Pricebook2Id = standardPricebook.Id,
            Product2Id = objProduct1.Id,
            UnitPrice = 1020,
            IsActive = true
        );
        Insert pbe;
        
        //Query the PricebookEntry record
        pbe = [SELECT Id, Pricebook2.IsStandard FROM PricebookEntry];
        //It should return true
        System.assertEquals(true, pbe.Pricebook2.IsStandard);
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        Test.setMock(HttpCalloutMock.class, new QuickBookConnection_MockTest());
        QuickBookConncetion.SyncProductsWithQuickBooks(objProduct1.Id);
        Test.stopTest();
    }
static testMethod void theTestsproduct3(){
    Product2  objProduct1 = new Product2 ();
    objProduct1.Name = 'product 1';
    objProduct1.Family = 'Accessories';
    objProduct1.Description = 'test product 1';
    objProduct1.Apply_Cultivation_Tax__c='Yes';
    objProduct1.Apply_Excise_Tax__c='Yes';
    objProduct1.IsActive = true;
    objProduct1.Unit_Height__c  = 10.0;
    objProduct1.Unit_Length__c = 10.0;
    objProduct1.Unit_Width__c = 5.0;
    objProduct1.QB_Id__c=3;
    objProduct1.Track_Trace_Category__c='Capsule';
    objProduct1.Net_Weight_UOM__c='EA';
    objProduct1.Unit_Of_Measure__c='Grams';
    insert objProduct1;
    
    //Instantiate the Pricebook2 record with StandardPricebookId
    Pricebook2 standardPricebook = new Pricebook2(
        Id = Test.getStandardPricebookId(),
        IsActive = true
    );
    
    //Execute an update DML on the Pricebook2 record, to make IsStandard to true
    Update standardPricebook;
    
    //Query for the Pricebook2 record, to check IsStandard field
    standardPricebook = [SELECT Id, IsStandard FROM Pricebook2 WHERE Id = :standardPricebook.Id];
    //It should return true
    System.assertEquals(true, standardPricebook.IsStandard);
    
    
    //Create the PricebookEntry
    PricebookEntry pbe = new PricebookEntry(
        Pricebook2Id = standardPricebook.Id,
        Product2Id = objProduct1.Id,
        UnitPrice = 1020,
        IsActive = true
    );
    Insert pbe;
    
    //Query the PricebookEntry record
    pbe = [SELECT Id, Pricebook2.IsStandard FROM PricebookEntry];
    //It should return true
    System.assertEquals(true, pbe.Pricebook2.IsStandard);
    
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    Test.setMock(HttpCalloutMock.class, new QuickBookConnection_MockTest());
   QuickBookConncetion.SyncProductsWithQuickBooks(objProduct1.Id);
    Test.stopTest();
    
}
   static testMethod void theTestinvoice(){
          // receiverLicenseObj = new State_Licenses__c();
       // receiverLicenseObj = [Select License_Name__c, License_Number__c, License_Status__c, License_Type__c, License_Expiration_Date__c, License_Class__c From State_Licenses__c LIMIT 1];
        
        // Retrieve invoice and lines
       // invoiceObj = new Invoice__c();
     //   invoiceObj = [Select Name,Brand_Quote__c, Invoice_Balance__c, Receiver_License__c,Product_Balance__c, Invoice_Due_Date__c, AR_Status__c from Invoice__c];
        
    Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
       objAccount.QB_Customer_ID__c=1;
       objAccount.BillingCity='test 2';
       objAccount.BillingStreet='test 3';
       objAccount.BillingCountry='us';
       objAccount.BillingPostalCode='8786';
       objAccount.BillingState='tn';
        insert objAccount;
         Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
       objContact.Email='test@gmail.com';
        objContact.AccountId = objAccount.Id;
       insert objContact;
      //  receiverLicenseObj.License_Name__c = objAccount.Id;
       // update receiverLicenseObj;
        Invoice__c invoiceObj = new Invoice__c();
        Id recordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        // Update pending invoice related to RSM
       // invoiceObj.RecordTypeId =recordTypeId;
        invoiceObj.Posted_Date__c = System.today();
        invoiceObj.Invoice_Due_Date__c = System.Today() - 5;
        invoiceObj.AR_Status__c = 'Draft';
        invoiceObj.Receiver_Name__c = objAccount.Id;
       invoiceObj.Receiver_Contact__c= objContact.Id;
    //   invoiceObj.Receiver_License__c = receiverLicenseObj.Id;
        invoiceObj.Collections_Status__c = 'Pending';
        invoiceObj.Total_Payments_Received__c = 1;
      
       
      //  invoiceObj.Receiver_Email__c='test@gmail.com';
        insert invoiceObj;
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    Test.setMock(HttpCalloutMock.class, new QuickBookConnection_MockTest());
    QuickBookConncetion.SyncInvoiceWithQuickBooks(invoiceObj.Id);
//QuickBookConncetion.SyncProductsWithQuickBooksdoint(objAccount.Id);
    Test.stopTest();
       
  //  QuickBookConncetion.SyncAccountWithQuickBooksVendor(objAccount.Id);
} 
   static testMethod void theTestinvoicewithid(){
          // receiverLicenseObj = new State_Licenses__c();
       // receiverLicenseObj = [Select License_Name__c, License_Number__c, License_Status__c, License_Type__c, License_Expiration_Date__c, License_Class__c From State_Licenses__c LIMIT 1];
        
        // Retrieve invoice and lines
       // invoiceObj = new Invoice__c();
     //   invoiceObj = [Select Name,Brand_Quote__c, Invoice_Balance__c, Receiver_License__c,Product_Balance__c, Invoice_Due_Date__c, AR_Status__c from Invoice__c];
        
    Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
       objAccount.QB_Customer_ID__c=1;
       objAccount.BillingCity='test 2';
       objAccount.BillingStreet='test 3';
       objAccount.BillingCountry='us';
       objAccount.BillingPostalCode='8786';
       objAccount.BillingState='tn';
        insert objAccount;
         Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
       objContact.Email='test@gmail.com';
        objContact.AccountId = objAccount.Id;
       insert objContact;
      //  receiverLicenseObj.License_Name__c = objAccount.Id;
       // update receiverLicenseObj;
        Invoice__c invoiceObj = new Invoice__c();
        Id recordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        // Update pending invoice related to RSM
       // invoiceObj.RecordTypeId =recordTypeId;
        invoiceObj.Posted_Date__c = System.today();
       invoiceObj.QB_Id__c=5;
        invoiceObj.Invoice_Due_Date__c = System.Today() - 5;
        invoiceObj.AR_Status__c = 'Draft';
        invoiceObj.Receiver_Name__c = objAccount.Id;
       invoiceObj.Receiver_Contact__c= objContact.Id;
    //   invoiceObj.Receiver_License__c = receiverLicenseObj.Id;
        invoiceObj.Collections_Status__c = 'Pending';
        invoiceObj.Total_Payments_Received__c = 1;
      
       
      //  invoiceObj.Receiver_Email__c='test@gmail.com';
        insert invoiceObj;
    Test.startTest();
    Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    Test.setMock(HttpCalloutMock.class, new QuickBookConnection_MockTest());
    QuickBookConncetion.SyncInvoiceWithQuickBooks(invoiceObj.Id);
//QuickBookConncetion.SyncProductsWithQuickBooksdoint(objAccount.Id);
    Test.stopTest();
       
  //  QuickBookConncetion.SyncAccountWithQuickBooksVendor(objAccount.Id);
} 

   /* private static testmethod void runTest(){
        TestUtilData.createTestData();
         
        Opportunity Opp = [SELECT Id,Name from Opportunity where Name=:'Test Opp' LIMIT 1];
        
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.Warehouse_Name__c='TestWarehouse1';
        insert objSite;
        
        State_Licenses__c stLicence = [SELECT ID,Name from State_Licenses__c LIMIT 1];
        
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = stLicence.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        
        Opp.Order__c = ord.Id;
        update Opp;

        Brand_Quote__c bq = [SELECT Id,Name,Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c from Brand_Quote__c where Opportunity_Name__c =: opp.Id LIMIT 1];
        
        Fulfillment_Rates_Table__c fullfillRateTable = new Fulfillment_Rates_Table__c();
        fullfillRateTable.Active__c = true;
        fullfillRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        fullfillRateTable.Site__c = bq.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c;
        fullfillRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        fullfillRateTable.Weight_lbs__c = 10;
        fullfillRateTable.Fulfillment_Services__c = 'Pick & Pack';
        fullfillRateTable.List_Price__c = 10;
        fullfillRateTable.Membership_Level__c = 'Boutique';
        insert fullfillRateTable;
        
        Shipping_Rates_Table__c ShippingRateTable = new Shipping_Rates_Table__c();
        ShippingRateTable.Rate_Effective_From__c = Date.Today().addMonths(-3);
        ShippingRateTable.Site__c = bq.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c;
        ShippingRateTable.Rate_Effective_To__c = Date.Today().addMonths(3);
        ShippingRateTable.Membership_Level__c = 'Boutique';
        insert ShippingRateTable;
        
        Account acc = [SELECT Id,Membership_Level__c FROM Account LIMIT 1];
        acc.Membership_Level__c = 'Boutique';
        update acc;
        
        List<Invoice__c> lstInv = [SELECT Id,Brand_Quote__c,Supplier_Name__c,Supplier_Name__r.Membership_Level__c from Invoice__c];
        for(Invoice__c inv : lstInv){
            inv.Brand_Quote__c = bq.Id; 
            inv.Supplier_Name__c = acc.Id;
        }
        update lstInv;
        
        List<Invoice_Line__c> lstInvLine = [SELECT Id,Invoice_Qty__c from Invoice_Line__c];
        lstInvLine[0].Invoice_Qty__c = 10;
        update lstInvLine[0];
        
        System.assertEquals(Opp.Order__c ,ord.Id);
         Test.startTest();
          Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
    Test.setMock(HttpCalloutMock.class, new QuickBookConnection_MockTest());
    //QuickBookConncetion.SyncInvoiceWithQuickBooks(invoiceObj.Id);
        Test.stopTest();        
    }    */
    
}