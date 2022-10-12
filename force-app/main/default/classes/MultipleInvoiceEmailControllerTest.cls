@isTest
public class MultipleInvoiceEmailControllerTest {
	@isTest
    private static void runTest(){
        
        contact con = new contact();
        con.lastname = 'test';
        con.firstname = 'test';
        con.email='test@test.com';
        insert con;
        
        PDFEngine_Config__c pdfConfig = new PDFEngine_Config__c();
        insert pdfConfig;
        
        FG_Queries__c fgQuery = new FG_Queries__c();
        fgQuery.Name__c = 'test';
        fgQuery.Active__c = true;
        fgQuery.Query__c = 'SELECT Apply_Cultivation_Tax__c  FROM Invoice_Line__c WHERE Invoice__c = \'{pv0}\'';
        insert fgQuery;
        
        FG_Email_Template__c fgEmailTem = new FG_Email_Template__c();
        fgEmailTem.Email_Subject__c = 'test subject';
        fgEmailTem.Name__c = 'test';
        fgEmailTem.Active__c = true;
        fgEmailTem.Template_Group__c = 'Product Invoice';
        fgEmailTem.Email_Body__c = 'test email body';
        insert fgEmailTem;
        
        FG_Template__c fgTem = new FG_Template__c();
        fgTem.Template_Group__c = 'Product Invoice';
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

        
        Invoice__c inv = new Invoice__c();
        insert inv;
        
        apexpages.currentpage().getparameters().put('invoiceIds',inv.id);
        apexpages.currentpage().getparameters().put('templateGroup','Product Invoice');
        MultipleInvoiceEmailController invoiceEmailCtrl = new MultipleInvoiceEmailController();
        
        invoiceEmailCtrl.redirectToSendEmail();
        
        invoiceEmailCtrl.queryId = fgQuery.id;
      //invoiceEmailCtrl.loadTemplate();
        invoiceEmailCtrl.fileData = 'test';
        invoiceEmailCtrl.createFile();
        
        invoiceEmailCtrl.changeEmailBody();
        invoiceEmailCtrl.goBackToEmail();
        invoiceEmailCtrl.AccessToken();
        invoiceEmailCtrl.AccessTokenFromRefreshToken();
        MultipleInvoiceEmailController.updateRefreshToken(pdfConfig.id,'','');
        //invoiceEmailCtrl.doGoogleDriveAuth();
        invoiceEmailCtrl.UploadFile();
        invoiceEmailCtrl.downloadFile('');
        invoiceEmailCtrl.deleteFile('');
        MultipleInvoiceEmailController.FileDetails fileDetial = new MultipleInvoiceEmailController.FileDetails();
        fileDetial.filename = 'test.pdf';
        fileDetial.filetype = 'application/pdf';
        fileDetial.file = 'testing body';
        fileDetial.recordId = inv.id; 
        List<MultipleInvoiceEmailController.FileDetails>fileDetailList = new List<MultipleInvoiceEmailController.FileDetails>();
        fileDetailList.add(fileDetial);
        invoiceEmailCtrl.additionalFiles = JSON.serialize(fileDetailList);        
        invoiceEmailCtrl.additionalAdd = 'test@test.com';
        invoiceEmailCtrl.invoice.Distributor_Contact__c = con.id;
        invoiceEmailCtrl.ccAdd = 'test@test.com';
        invoiceEmailCtrl.bccAdd = 'test@test.com';
        invoiceEmailCtrl.sendEmail();
        invoiceEmailCtrl.searchText = 'test@test.com';
        invoiceEmailCtrl.loadEmail();
        MultipleInvoiceEmailController.EmailWrapperClass eml = new MultipleInvoiceEmailController.EmailWrapperClass(con.id,con.lastname,'contact',con.email,null);
    }
}