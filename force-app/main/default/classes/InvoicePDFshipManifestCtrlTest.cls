@isTest
public class InvoicePDFshipManifestCtrlTest {
 @TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
                    Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());

    }
    	@isTest
    private static void runTestPO(){
        Test.startTest();
        contact con = new contact();
        con.lastname = 'test';
        con.firstname = 'test';
        con.email='test@test.com';
        insert con;
        
        PDFEngine_Config__c pdfConfig = new PDFEngine_Config__c();
        pdfConfig.Google_Api_Token_Url__c = 'https://oauth2.googleapis.com/token';
        pdfConfig.Access_Token__c = 'ya29';
        pdfConfig.Client_Id__c = '523150011284';
        pdfConfig.File_Download_Url__c = 'https://www.googleapis.com/drive/v3/files/';
        pdfConfig.File_Upload_Url__c = 'https://www.googleapis.com/upload/drive/v2/files?uploadType=multipart';
        pdfConfig.Google_Auth_Drive_Url__c = 'https://www.googleapis.com/auth/drive';
        pdfConfig.Google_Auth_Url__c = 'https://accounts.google.com/o/oauth2/';
        pdfConfig.Refresh_Token__c = '0f20obuQ8xNZcCgYIARAAGA8SNwF';
        pdfConfig.Return_Url__c = 'https://filigreen--dev--c.visualforce.com/apex/DocumentGenerator';
        pdfConfig.Secret__c = '77Ft1f3tBeFfRz8e7ckmLFi4';
        insert pdfConfig;
        
        FG_Queries__c fgQuery = new FG_Queries__c();
        fgQuery.Name__c = 'test';
        fgQuery.Active__c = true;
        fgQuery.Query__c = 'SELECT id  FROM Brand_Quote_Line__c WHERE Brand_Quote_Number__c = \'{pv0}\'';
        insert fgQuery;
        
        FG_Email_Template__c fgEmailTem = new FG_Email_Template__c();
        fgEmailTem.Email_Subject__c = 'test subject';
        fgEmailTem.Name__c = 'test';
        fgEmailTem.Active__c = true;
        fgEmailTem.Template_Group__c = 'BrandSellQuote';
        fgEmailTem.Email_Body__c = 'test email body';
        insert fgEmailTem;
        
        FG_Template__c fgTem1 = new FG_Template__c();
        fgTem1.Template_Group__c = 'BrandSellQuote';
        fgTem1.Active__c = true;
        fgTem1.Name__c = 'test';
        insert fgTem1;
        
        ContentVersion cVersion = new ContentVersion();
        cVersion.ContentLocation = 'S';
        cVersion.PathOnClient = 'test.docx';
        cVersion.Origin = 'H';
        cVersion.Title = 'fileName';
        cVersion.VersionData =blob.valueof('test body');
        Insert cVersion;
        
        Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion.id].ContentDocumentId;
        ContentDocumentLink cDocLink = new ContentDocumentLink();
        cDocLink.ContentDocumentId = conDocument;
        cDocLink.LinkedEntityId = fgTem1.id;
        cDocLink.ShareType = 'I';
        cDocLink.Visibility = 'AllUsers';
        Insert cDocLink;

        List<Account> accounts = new List<Account>();
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hold__c=true;
        objAccount.DBA__c='Test Account1';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Membership_Level__c = 'Boutique';
        objAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
        accounts.add(objAccount);   
        
        // distributor Account
        Account objAccount2 = new Account();
        objAccount2.Name = 'Test Account2';
        objAccount2.Payment_Terms__c = 'COD';
        objAccount2.Hide_from_Marketplace__c = false;
        accounts.add(objAccount2);  
        
        // receiver Account
        Account objAccount3 = new Account();
        objAccount3.Name = 'Test Account3';
        objAccount3.Payment_Terms__c = 'COD';
        objAccount3.Hide_from_Marketplace__c = false;
        accounts.add(objAccount3);
        
        insert accounts;
        
        // Create Contacts
        // supplier contact
        List<Contact> contacts = new List<Contact>();
        Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
        objContact.AccountId = objAccount.Id;
        contacts.add(objContact);   
        
        // distributor contact
        Contact objContact2 = new Contact();
        objContact2.FirstName = 'Test';
        objContact2.LastName = 'Contact2';
        objContact2.AccountId = objAccount2.Id;
        contacts.add(objContact2);  
        
        // receiver contact
        Contact objContact3 = new Contact();
        objContact3.FirstName = 'Test';
        objContact3.LastName = 'Contact3';
        objContact3.AccountId = objAccount3.Id;
        contacts.add(objContact3);
        
        insert contacts; 
        
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
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        insert licenses;
        
        
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.State_License__c = objStateLicenses.Id;
        ord.Sales_Person__c = objContact.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        
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
        Id serviceRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Services').getRecordTypeId();
        
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
       
        //insert products;
        
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
                
        Sales_Order__c objSO1 = new Sales_Order__c();
        objSO1.Site__c = bq.Site__c;
        objSO1.SO_Status__c = 'Approved';
        objSO1.SO_Type__c = 'Sell Quote';
        objSO1.Brand_Quote__c = bq.id;
        objSO1.Supplier_Contact__c = objContact.Id;
        objSO1.Supplier_Name__c = bq.Supplier_Name__c;
        objSO1.Supplier_License__c = bq.Supplier_License__c;
        objSO1.Distributor_Contact__c = objContact2.Id;
        objSO1.Distributor_Name__c = bq.Distributor_Name__c;
        objSO1.Distributor_License__c = bq.Distributor_License__c;
        objSO1.Receiver_Name__c = bq.Receiver_Name__c;
        objSO1.Receiver_Contact__c = objContact3.Id;
        objSO1.Receiver_License__c = bq.Receiver_License__c;
        objSO1.Payment_Terms__c = bq.Payment_Terms__c;
        objSO1.Shipping_Terms__c = bq.Shipping_Terms__c;
        objSO1.Shipping_Method__c = bq.Shipping_Method__c;
        objSO1.Ownership__c = accounts[0].Id;
        objSO1.Customer_PO_or_Quote__c = 'Test Quote';
        objSO1.Account_Hold_Exception__c = true;
        objSO1.Opportunity_Name__c = opp.Id;
        
        insert objSO1;
        
        Invoice__c inv = new Invoice__c();
        inv.Sales_Order__c = objSO1.id;
        inv.AR_Status__c = 'Draft';
        inv.Brand_Quote__c = bq.Id;
        insert inv;
        List<Invoice__c> invc = [select id from Invoice__c limit 1];
         List<String> vIds = new List<String>();
        
        for(Invoice__c inv1: invc){
            vIds.add(inv1.id);
        }
        
        Id recordTypeId = Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
                     
        Purchase_Order__c objPO1 = new Purchase_Order__c();
        objPO1.recordTypeId = recordTypeId;
        objPO1.Site__c = bq.Site__c;
        objPO1.PO_Status__c = 'Approved';
        objPO1.PO_Type__c = 'Buy Quote';
        objPO1.Supplier_Name__c = bq.Supplier_Name__c;
        objPO1.Supplier_License__c = bq.Supplier_License__c;
        objPO1.Distributor_Name__c = bq.Distributor_Name__c;
        objPO1.Distributor_License__c = bq.Distributor_License__c;
        objPO1.Receiver_Name__c = bq.Receiver_Name__c;
        objPO1.Receiver_License__c = bq.Receiver_License__c;
        objPO1.Ownership__c = bq.Ownership__c;
        objPO1.Total_Weight_Fee__c =10;
        insert objPO1;
        
        Drivers__c driverO = new Drivers__c();
        driverO.Name = 'Test Driver1';
        driverO.Driver_License_Number__c = '12311';
        driverO.Expiration_Date__c = System.Today() + 100;
        driverO.State_Issued__c = 'NY';
        insert driverO;
        
        Vehicles__c vehicle1 = new Vehicles__c();
        vehicle1.Name = 'Test Vehicle'; // Same as Inventory Location of Picklist Line
        insert vehicle1;
       Sales_Order__c objSO =[select id,Site__c, Site__r.Name, Planned_Ship_Date__c,Window_Start__c,Opportunity_Name__c, Opportunity_Name__r.Name, Window_End__c from Sales_Order__c limit 1];
        
        objSO.Planned_Ship_Date__c = date.today();
        update objSO;
        
        
        Picklist__c objPicklist= TestUtilData.createPicklist(objSO, 'Open', true);
        
        list<Shipping_Manifest__c> lstRSM = new list<Shipping_Manifest__c>();
        
        Shipping_Manifest__c objRSM1 = TestUtilData.createRSM(objPicklist, false);
        objRSM1.Planned_Ship_Transfer_Date__c = objSO.Planned_Ship_Date__c;
        objRSM1.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        objRSM1.Sales_Order__c = objSO.Id;
        lstRSM.add(objRSM1);
        
        Shipping_Manifest__c objRSM2 = TestUtilData.createRSM(objPicklist, false);
        objRSM2.Planned_Ship_Transfer_Date__c = objSO.Planned_Ship_Date__c;
        objRSM2.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        objRSM2.Sales_Order__c = objSO.Id;
        lstRSM.add(objRSM2);
        
        Shipping_Manifest__c objRSM3 = TestUtilData.createRSM(objPicklist, false);
        objRSM3.Planned_Ship_Transfer_Date__c = objSO.Planned_Ship_Date__c;
        objRSM3.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        lstRSM.add(objRSM3);
        insert lstRSM;
        
        Shipping_Manifest__c sm = [SELECT Id, Name, Priority__c, Site__c, Site__r.Name, Sales_Order__c, Receiver_Name__r.Name, Metrc_Manifest__c, Driver__c, Driver__r.Name, Vehicle__c, Vehicle__r.Name, Opportunity_Name__r.Name, Status__c, Planned_Ship_Transfer_Date__c, RecordTypeId, RecordType.Name,Receiver_Name__r.DBA__c FROM  Shipping_Manifest__c limit 1];
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        Test.setCurrentPage(Page.InvoicePDFshipManifest);
		ApexPages.currentPage().getParameters().put('id',sm.id);
        ApexPages.currentpage().getparameters().put('templateGroup','BrandSellQuote');
        InvoicePDFshipManifestCtrl brandQuote = new InvoicePDFshipManifestCtrl();    
        brandQuote.redirectToSendEmail();
        //brandQuote.loadTemplate();
        brandQuote.fileData = 'test';
        brandQuote.deleteFile('5561');
        brandQuote.createFile();
        brandQuote.changeEmailBody();
        brandQuote.goBackToEmail();
        brandQuote.AccessToken();
        brandQuote.AccessTokenFromRefreshToken();
        InvoicePDFshipManifestCtrl.updateRefreshToken(pdfConfig.id,'','');
        //brandQuote.UploadFile();
        InvoicePDFshipManifestCtrl.FileDetails fileDetial = new InvoicePDFshipManifestCtrl.FileDetails();
        fileDetial.filename = 'test.pdf'; 
        fileDetial.filetype = 'application/pdf';
        fileDetial.file = 'testing body';
        List<InvoicePDFshipManifestCtrl.FileDetails>fileDetailList = new List<InvoicePDFshipManifestCtrl.FileDetails>();
        fileDetailList.add(fileDetial);
        brandQuote.additionalFiles = JSON.serialize(fileDetailList);        
        brandQuote.additionalAdd = 'test@test.com';
        //brandQuote.invoice.Distributor_Contact__c = con.id;
        brandQuote.ccAdd = 'test@test.com';
        brandQuote.bccAdd = 'test@test.com';
        brandQuote.bodyStr = 'test';
       // brandQuote.defaultAttRemoved = false;
        //brandQuote.sendEmail();
        brandQuote.searchText = 'test@test.com';
        brandQuote.loadEmail();
        brandQuote.loadInitailSetup();
        brandQuote.processTemplateMerge('<hi>test</html>', vIds);
        String Clientkey = pdfConfig.Client_Id__c;
        String  redirect_uri = pdfConfig.Return_Url__c;
        brandQuote.GoogleDriveAuthUri(Clientkey, redirect_uri);
        brandQuote.filetype ='.docx';
        brandQuote.recordId = '13313';
        brandQuote.filename = 'test';
        InvoicePDFshipManifestCtrl.EmailWrapperClass eml = new InvoicePDFshipManifestCtrl.EmailWrapperClass(con.id,con.lastname,'contact',con.email,null);
        InvoicePDFshipManifestCtrl.getinvoiceDetail();  
        brandQuote.redirectToRSM();
        brandQuote.reDirectoDriverScreen();
      
       Test.stopTest();
    }
}