@isTest
public class BrandQuotePDFCtlrTest {
	@isTest
    private static void runTest(){
        
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
        
        Brand_Quote__c quote = new Brand_Quote__c();
        insert quote;
        
        string state = 'id='+quote.id+',QueryId='+'[bqline]'+fgQuery.id+'?pv0='+quote.id+',TempateId='+fgTem.id+',templateGroup=BrandSellQuote';
        apexpages.currentpage().getparameters().put('id',quote.id);
        apexpages.currentpage().getparameters().put('templateGroup','BrandSellQuote');
        apexpages.currentpage().getparameters().put('QueryId','[bqline]'+fgQuery.id+'?pv0='+quote.id);
        apexpages.currentpage().getparameters().put('TemplateId',fgTem.id);
        apexpages.currentpage().getparameters().put('EmailTemplateId',fgEmailTem.id);
        apexpages.currentpage().getparameters().put('code','test');
        apexpages.currentpage().getparameters().put('state',state);
        BrandQuotePDFCtlr brandQuote = new BrandQuotePDFCtlr();
        brandQuote.redirectToSendEmail();
        //brandQuote.loadTemplate();
        brandQuote.fileData = 'test';
        brandQuote.createFile();
        //brandQuote.changeEmailBody();
        brandQuote.goBackToEmail();
        brandQuote.AccessToken();
        brandQuote.AccessTokenFromRefreshToken();
        BrandQuotePDFCtlr.updateRefreshToken(pdfConfig.id,'','');
        brandQuote.UploadFile();
        brandQuote.fromDownload = true;
        brandQuote.details.isSaveAsAttachment = true;
        brandQuote.downloadFile('');
        BrandQuotePDFCtlr.deleteFile('','');
        BrandQuotePDFCtlr.FileDetails fileDetial = new BrandQuotePDFCtlr.FileDetails();
        fileDetial.filename = 'test.pdf';
        fileDetial.filetype = 'application/pdf';
        fileDetial.file = 'testing body';
        List<BrandQuotePDFCtlr.FileDetails>fileDetailList = new List<BrandQuotePDFCtlr.FileDetails>();
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
        BrandQuotePDFCtlr.EmailWrapperClass eml = new BrandQuotePDFCtlr.EmailWrapperClass(con.id,con.lastname,'contact',con.email,null);
        
        string status;
        status = BrandQuotePDFCtlr.BRANDQUOTE_FILENAME_BUYQUOTE;
        status = BrandQuotePDFCtlr.BRANDQUOTE_FILENAME_SELLQUOTE;
        
    }
}