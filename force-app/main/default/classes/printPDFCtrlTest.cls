@isTest
public class printPDFCtrlTest {
    
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
        
        FG_Template__c fgTem = new FG_Template__c();
        fgTem.Template_Group__c = 'BrandSellQuote';
        fgTem.Active__c = true;
        fgTem.Name__c = 'test';
        insert fgTem;
        
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
        cDocLink.LinkedEntityId = fgTem.id;
        cDocLink.ShareType = 'I';
        cDocLink.Visibility = 'AllUsers';
        Insert cDocLink;
        
         // supplier Account
        List<Account> accounts = new List<Account>();
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        accounts.add(objAccount);   
        
        // distributor Account
        Account objAccount2 = new Account();
        objAccount2.Name = 'Test Account2';
        objAccount2.Payment_Terms__c = 'COD';
        //objAccount2.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Supplier').getRecordTypeId();
        accounts.add(objAccount2);  
        
        // receiver Account
        Account objAccount3 = new Account();
        objAccount3.Name = 'Test Account3';
        objAccount3.Payment_Terms__c = 'COD';
        accounts.add(objAccount3);
        
        insert accounts;
        // Create Site
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        insert objSite;
        // Create State License
        Test.setMock(HttpCalloutMock.class, new Miles_Mock());  
        // Supplier License
        List<State_Licenses__c> licenses = new List<State_Licenses__c>();
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses.Default_Warehouse__c = objSite.Id;
        licenses.add(objStateLicenses);
        
        // distributor License
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount2.id;
        objStateLicenses2.License_Number__c = 'AbcTest45678';
        objStateLicenses2.License_Status__c ='Active';
        objStateLicenses2.License_Type__c ='Type 1';
        objStateLicenses2.License_Class__c='A-License';
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses2.Default_Warehouse__c = objSite.Id;
        licenses.add(objStateLicenses2); 
        
        // receiver License
        State_Licenses__c objStateLicenses3 = new State_Licenses__c();
        objStateLicenses3.License_Name__c = objAccount3.id;
        objStateLicenses3.License_Number__c = 'AbcTest54321';
        objStateLicenses3.License_Status__c ='Active';
        objStateLicenses3.License_Type__c ='Type 1';
        objStateLicenses3.License_Class__c='A-License';
        objStateLicenses3.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses3.Default_Warehouse__c = objSite.Id;
        licenses.add(objStateLicenses3);
        
        // receiver License
        State_Licenses__c objStateLicenses4 = new State_Licenses__c();
        objStateLicenses4.License_Name__c = objAccount3.id;
        objStateLicenses4.License_Number__c = 'AbcTest54321456';
        objStateLicenses4.License_Status__c ='Active';
        objStateLicenses4.License_Type__c ='Type 1';
        objStateLicenses4.License_Class__c='A-License';
        objStateLicenses4.License_Expiration_Date__c = date.valueof(system.now()) - 10;
        objStateLicenses4.Default_Warehouse__c = objSite.Id;
        licenses.add(objStateLicenses4);
        
        insert licenses;
        
        
        
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
       
      
        
        // Create brand quote
        Brand_Quote__c quote = new Brand_Quote__c ();
        quote.Opportunity_Name__c = opp.id; 
        quote.Supplier_Name__c = objAccount.id;
        quote.Supplier_License__c = objStateLicenses.id;
        quote.Distributor_Name__c = objAccount2.id;
        quote.Distributor_License__c = objStateLicenses2.id;
        quote.Receiver_Name__c = objAccount3.id;
        quote.Receiver_License__c = objStateLicenses3.id;
        quote.BQ_Status__c = 'Draft';
        quote.Shipping_Method__c = 'Distributor Pick-up';
        quote.Sales_Origin__c = 'Brand';
        quote.Shipping_Terms__c = 'CFR';        
        quote.Site__c = objSite.id;
        quote.Ownership__c = opp.Ownership__c;
        quote.Payment_Terms__c = opp.Payment_Terms__c;
        insert quote;
        
        string state = 'id='+quote.id+',QueryId='+'[bqline]'+fgQuery.id+'?pv0='+quote.id+',TempateId='+fgTem.id+',templateGroup=BrandSellQuote';
        apexpages.currentpage().getparameters().put('id',quote.id);
        apexpages.currentpage().getparameters().put('templateGroup','BrandSellQuote');
        apexpages.currentpage().getparameters().put('QueryId','[bqline]'+fgQuery.id+'?pv0='+quote.id);
        apexpages.currentpage().getparameters().put('TemplateId',fgTem.id);
        apexpages.currentpage().getparameters().put('EmailTemplateId',fgEmailTem.id);
        apexpages.currentpage().getparameters().put('code','test');
        apexpages.currentpage().getparameters().put('state',state);
        FileComposerUtility.getTemplateBody(fgTem.id);
        FiligreenFileDetails n =  new FiligreenFileDetails();
        FileComposerUtility.mergeEmailBody(quote.id, fgTem.id, '[bqline]');
            FileComposerUtility.getFileData(n, quote.id, fgTem.id, fgQuery.id, '[bqline]');
        printPDFCtrl brandQuote = new printPDFCtrl();
        brandQuote.redirectToSendEmail();
        //brandQuote.loadTemplate();
        brandQuote.fileData = 'test';
        brandQuote.createFile();
        //brandQuote.changeEmailBody();
        brandQuote.goBackToEmail();
        brandQuote.AccessToken();
        brandQuote.AccessTokenFromRefreshToken();
        printPDFCtrl.updateRefreshToken(pdfConfig.id,'','');
        brandQuote.UploadFile();
        brandQuote.fromDownload = true;
        brandQuote.details.isSaveAsAttachment = true;
       // brandQuote.downloadFile('');
        printPDFCtrl.deleteFile('','');
        printPDFCtrl.FileDetails fileDetial = new printPDFCtrl.FileDetails();
        fileDetial.filename = 'test.pdf';
        fileDetial.filetype = 'application/pdf';
        fileDetial.file = 'testing body';
        List<printPDFCtrl.FileDetails>fileDetailList = new List<printPDFCtrl.FileDetails>();
        fileDetailList.add(fileDetial);
        brandQuote.additionalFiles = JSON.serialize(fileDetailList);        
        brandQuote.additionalAdd = 'test@test.com';
        //brandQuote.invoice.Distributor_Contact__c = con.id;
        brandQuote.ccAdd = 'test@test.com';
        brandQuote.bccAdd = 'test@test.com';
        brandQuote.bodyStr = 'test';
        brandQuote.defaultAttRemoved = false;
        brandQuote.sendEmail();
        brandQuote.searchText = 'test@test.com';
        brandQuote.loadEmail();
        brandQuote.loadInitailSetup();
        brandQuote.goBack();
        brandQuote.redirectBack();
        brandQuote.loadTemplate();
       
       // FileComposerUtility.
        printPDFCtrl.EmailWrapperClass eml = new printPDFCtrl.EmailWrapperClass(con.id,con.lastname,'contact',con.email,null);

         String Status;
        Status = printPDFCtrl.TEMPLATE_GROUP_URLPATH_PO;
          Status = printPDFCtrl.TEMPLATE_GROUP_URLPATH_SM;
          Status = printPDFCtrl.TEMPLATE_GROUP_URLPATH_INVOICE;
          Status = printPDFCtrl.TEMPLATE_SEND_EMAIL_SM;
          Status = printPDFCtrl.TEMPLATE_SEND_EMAIL_PO;
          Status = printPDFCtrl.TEMPLATE_SEND_EMAIL_INVOICE;
          Status = printPDFCtrl.TEMPLATE_SEND_EMAIL_PICKLIST;
          Status = printPDFCtrl.FILENAME_INVOICE;
          Status = printPDFCtrl.FILENAME_PURCHASE_ORDER;
          Status = printPDFCtrl.FILENAME_SHIPPING_MAINFEST;
        Test.stopTest();
    }
}