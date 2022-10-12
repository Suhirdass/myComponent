/* Name: MultipleInvoiceEmailController


*/
public class MultipleInvoiceEmailController {
    
    private Static String DL_Finance { 
        get{
            return  String.isNotBlank(DL_Finance) ? DL_Finance :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','DL_Finance');
        }set;
    }
    
    public string dlFinance{get;set;}
    public String  fileData {set;get;}
    private String code ;
    private String state ;
    private String key = '' ;
    private String secret = '' ;
    private String redirect_uri = '' ;
    private String accesstoken ;
    private Integer expiresIn ;
    private String tokentype;
    private String refreshToken;
    private Boolean loginDone=false;
    private PDFEngine_Config__c googleDrive;
    public string queryId{set;get;}
    public string templateGroup{set;get;}
    public string line{set;get;}
    private string originalparameters;
    public FiligreenFileDetails details{set;get;}
    public List<SelectOption> templateOptions{set;get;}
    public List<SelectOption> emailTemplateOptions{set;get;}
    public String selectedTemplatedId{set;get;}
    public String selectedEmailTemplatedId{set;get;}
    public string subject{get;set;}
    public string bccAdd{get;set;}
    public string ccAdd{get;set;}
    public string additionalAdd{get;set;}
    public String emailBody{set;get;}
    public boolean contacts{get;set;}
    public boolean users{get;set;}
    public string searchText{get;set;}
    public list<EmailWrapperClass>EmailWrapperList{get;set;}
    public string fileType{get;set;}
    public string fileName{get;set;}
    public blob fileBody{get;set;}
    public Transient  blob resp{get;set;}
    public string bodyStr{get;set;}
    public Transient string additionalFiles{get;set;}
    private String invoiceIds{get;set;}
    public string invoiceStr{get;set;}
    public string invoiceStrName{get;set;}
    list<FiligreenFileDetails>detailsList;
    public boolean attachmentProcessingFinished{get;set;}
    public Invoice__c invoice{get;set;}
    public Invoice__c invoice2{get;set;}
    public boolean saveAtt{get;set;}
    public boolean logActivity{get;set;}
    public string removedInvoiceId{get;set;}
    public boolean emailSent{get;set;}
    public string errorMsg{get;set;}
    public  decimal tempSum3{get;set;}
     public  String tempSumformat{get;set;}
      public  String tempSum2format{get;set;}
      public  String tempSum3format{get;set;}
    list<string>invoiceIdList = new list<string>();
    //Constructor
    public MultipleInvoiceEmailController(){
        invoice = new Invoice__c();
        invoice2 = new Invoice__c();
        contacts = true;
        users = true;
        line = FiligreenConfigurationUtility.getInvoiceConfig('Invoice','EmailBodyTablePrefix');
        queryId = FiligreenConfigurationUtility.getInvoiceConfig('Invoice','queryId');
        attachmentProcessingFinished = false;
        saveAtt = true;
        logActivity = true;
        detailsList = new List<FiligreenFileDetails>();
        templateGroup = ApexPages.currentPage().getParameters().get('templateGroup') ;
        invoiceIds = ApexPages.currentPage().getParameters().get('invoiceIds') ;
        selectedTemplatedId = ApexPages.currentPage().getParameters().get('TemplateId') ;
        selectedEmailTemplatedId = ApexPages.currentPage().getParameters().get('EmailTemplateId');        
        string saveAttstr = ApexPages.currentPage().getParameters().get('saveAtt') ;
        string logActivitystr = ApexPages.currentPage().getParameters().get('logActivity') ;
        dlFinance = DL_Finance;
        
        if(saveAttstr != null)  saveAtt = boolean.valueof(saveAttstr);
        else
            saveAtt = true;
        
        if(logActivitystr != null) logActivity = boolean.valueof(logActivitystr);
        else
            logActivity = true;
        
        googleDrive = PDFEngine_Config__c.getOrgDefaults();
        system.debug('googleDrive'+googleDrive);
        if(googleDrive != null){
            key = googleDrive.Client_Id__c;
            redirect_uri = googleDrive.Return_Url__c;
            secret = googleDrive.Secret__c ;
            refreshToken=googleDrive.Refresh_Token__c;
            accesstoken=googleDrive.Access_Token__c;
        }
        invoiceIdList = invoiceIds.split(',');
        loadInitailSetup();
        loadEmailTemplate();
    }
    public void loadInitailSetup(){
        templateOptions = new List<SelectOption>();
        if(String.isNotBlank(templateGroup)){
            Set<SelectOption> optionsSet = new Set<SelectOption>();
            set<string>templateIdSet = new Set<String>();
            system.debug('templateGroup '+templateGroup);
                        List<string> tempdata = new List<string>{'EmailCTI','EmailInvoice'};

            Map<ID, FG_Template__c> templateMap = new Map<ID, FG_Template__c>([SELECT Id, Name, Name__c  FROM FG_Template__c WHERE Template_Group__c =: templateGroup AND Active__c = true]);
            for(ContentDocumentLink doc : [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId IN: templateMap.keySet() AND ContentDocument.FileExtension= 'docx' Order By ContentDocument.CreatedDate DESC]){
                if(!templateIdSet.contains(doc.LinkedEntityId)){
                    templateIdSet.add(doc.LinkedEntityId);
                    FG_Template__c t = templateMap.get(doc.LinkedEntityId);
                    optionsSet.add(new SelectOption(t.Id,t.Name__c));
                    if(selectedTemplatedId == null || selectedTemplatedId == '')
                        selectedTemplatedId = t.id; 
                }
            }
            templateOptions.addAll(optionsSet);
        }
        emailTemplateOptions = new List<SelectOption>();
        Set<SelectOption> optionsSet = new Set<SelectOption>();
        for(FG_Email_Template__c t: [SELECT Id, Name, Name__c  FROM FG_Email_Template__c WHERE Active__c = true AND Template_Group__c =: templateGroup]){
            optionsSet.add(new SelectOption(t.Id,t.Name__c));
            if(selectedEmailTemplatedId == null || selectedEmailTemplatedId == '')
                selectedEmailTemplatedId = t.id;
        }
        emailTemplateOptions.addAll(optionsSet);
    }
    public void changeEmailBody(){
    	list<String>invoiceList = new List<string>();
        for(string str : invoiceIdList){
            if(str != removedInvoiceId){
            	invoiceList.add(str);
            }
        }
        invoiceIdList = invoiceList;
        loadEmailTemplate();
    }
    public PageReference redirectToSendEmail(){
        PageReference pg = new PageReference('/apex/SendEmailInvoice?invoiceIds='+invoiceIds+'&TemplateId='+selectedTemplatedId+'&EmailTemplateId='+selectedEmailTemplatedId+'&TemplateGroup='+templateGroup+'&saveAtt='+saveAtt+'&logActivity='+logActivity);
        pg.setRedirect(true);
        return pg;
    }
    public PageReference goBackToEmail(){
        String pageUrl = '/apex/MultipleInvoiceEmail?invoiceIds='+invoiceIds+'&TemplateId='+selectedTemplatedId+'&EmailTemplateId='+selectedEmailTemplatedId+'&TemplateGroup='+templateGroup+'&saveAtt='+saveAtt+'&logActivity='+logActivity;
        PageReference pg = new PageReference(pageUrl);
        pg.setRedirect(true);
        return pg;
    }   
    public void loadEmailTemplate(){
        invoiceStrName = '';
        emailBody = '';
        subject = '';
        for(Invoice__c inv : [select id,Distributor_Contact__c,Distributor_Contact__r.Name,Name from Invoice__c where Id IN: invoiceIdList]){
            invoiceStrName += inv.Name + ','; 
        }
        invoiceStrName = invoiceStrName.removeEnd(',');
        invoiceStr = 'Invoice'; 
        List<FG_Email_Template__c> emailTemplateList = [select id,Email_Subject__c,Email_Body__c from FG_Email_Template__c  where id=: selectedEmailTemplatedId];
        if(emailTemplateList.size()>0){
            subject = emailTemplateList[0].Email_Subject__c;
            emailBody = processTemplateMerge(emailTemplateList[0].Email_Body__c,invoiceIdList);
        }
    }
    public String processTemplateMerge(String htmlBody,List<string> invoiceIdList){
          decimal tempSum = 0.00;
        decimal tempSum2 = 0.00;
         tempSum3 = 0.00;
        tempSumformat='';
        tempSum2format='';
           tempSum3format='';
        Map<String,Map<String,Object>> invoiceFieldAndValueMap = FileComposerUtility.prepareFileData(invoiceIdList);
        String[] htmlbodyTRWise = htmlBody.split('<tr>');
        String mergedHTMLBody = '';
         decimal sumofinvblnce =0.00;
        decimal sumofExciseTax =0.00;
        decimal sumofproductprice =0.00;
         decimal sumofproductpricest =0.00;
         String amountpro='';
        String amountTax='';
         String amountinvbl='';
         for(Invoice__c inv : [select id,Invoice_Balance__c,Excise_Tax_Balance__c,Product_Balance__c,Name from Invoice__c where Id IN: invoiceIdList]){
             sumofinvblnce += inv.Invoice_Balance__c;
              sumofExciseTax += inv.Excise_Tax_Balance__c;
              sumofproductprice += inv.Product_Balance__c;
             
        }
       
        if (!string.valueof(sumofproductprice.format()).right(3).contains('.')){
            amountpro = string.valueof(sumofproductprice.format()) + '.00';
        }else if (string.valueof(sumofproductprice.format()).right(2).contains('.')){            amountpro =  string.valueof(sumofproductprice.format()) + '0';
        }else {
            amountpro =string.valueof(sumofproductprice.format());
        }   
        System.debug('amount'+amountpro);  
          if (!string.valueof(sumofExciseTax.format()).right(3).contains('.')){
            amountTax = string.valueof(sumofExciseTax.format()) + '.00';
        }else if (string.valueof(sumofExciseTax.format()).right(2).contains('.')){ amountTax =  string.valueof(sumofExciseTax.format()) + '0';
        }else {
            amountTax =string.valueof(sumofExciseTax.format());
        }   
        System.debug('amount'+amountTax);  
        
          if (!string.valueof(sumofinvblnce.format()).right(3).contains('.')){
            amountinvbl = string.valueof(sumofinvblnce.format()) + '.00';
        }else if (string.valueof(sumofinvblnce.format()).right(2).contains('.')){
            amountinvbl =  string.valueof(sumofinvblnce.format()) + '0';
        }else {
            amountinvbl =string.valueof(sumofinvblnce.format());
        }   
        System.debug('amount'+amountinvbl);  
        
         

        
                  mergedHTMLBody += '<div id="inner"> Hi , </div> </br> <p  style="font-size: 13px;font-family: Roboto, sans-serif;">We hope you’re having a fantastic week so far! </br></br>For your convenience we have compiled a detailed Open Invoice Summary for your account. Please review this email and <b>provide us with an estimated day & time</b> for us to stop by to collect so we can bring your account current. </br></br>Feel free to contact us with any questions or concerns.</p><p style="font-size: 12px;font-family: Roboto, sans-serif;"><b>TOTAL PAST DUE AMOUNT</b> </br><b> Total Past Due Product Price:</b> $'+amountpro+'</br><b>Total Past Due Excise Tax Amount:</b> $'+amountTax +'</br><b>Total Past Due Invoice Balance:</b> $'+amountinvbl+'</p>';

        for(String row:htmlbodyTRWise){
            system.debug('row '+row);
            String mergedRow = '';
            pattern p = Pattern.compile('\\{\\{TableStart:'+line+'\\}\\}');
            Matcher m = p.matcher(row);
            if(m.find()){String lastColRemailingHTML = ''; String[] columns = row.split('<td');
                Map<Integer,String> colsMap = new Map<Integer,String>();
                Integer i = 0;
                for(String col: columns){
                    if(String.isBlank(col)) continue;
                    col = col.replace('{{TableStart:'+line+'}}', '');
                    if(col.indexOf('{{TableEnd:'+line+'}}') >= 0){
                        String[] cols = col.split('</tr>');
                        String lastCol = cols[0];
                        col = lastCol.replace('{{TableEnd:'+line+'}}', '');
                        lastColRemailingHTML = cols[1];
                    }    
                    colsMap.put(i++,col);
                }                
                String linesHTML = '';
                List<List<String>> finalLineRecords = new List<List<String>>();
                
                for(string invoiceId : invoiceIdList){ List<String> childRowMerged = new List<String>();
                    Map<String,Object> fieldAndValueMap = invoiceFieldAndValueMap.get(invoiceId);  Integer k =0;
                    for(Integer ind : colsMap.keySet()){ String col = colsMap.get(ind);
                        pattern pc = Pattern.compile('\\{\\{[a-zA-Z0-9_\\s\\.]*\\}\\}');
                        Matcher mc = pc.matcher(col);
                        if(mc.find()){ String childField = col.substring(mc.start()+2,mc.end()-2);
                     
                            String childCol;
                            if(childField == 'INVOICE_BALANCE')     {  childCol =  String.valueOf(fieldAndValueMap.get(childField));
                                
                            }
                            string tval;
                            if(k==6) {  tval =  String.valueOf(fieldAndValueMap.get(childField));
                            }
                            if(tval!= Null)
                            { 
                                string  kk= tval.replace('$',''); String KKK = kk.replace(',','');
                                tempSum += decimal.valueOf(KKK);
                                if (!string.valueof(tempSum.format()).right(3).contains('.')){tempSumformat = string.valueof(tempSum.format()) + '.00';
                                }else if (string.valueof(tempSum.format()).right(2).contains('.')){ tempSumformat =  string.valueof(tempSum.format()) + '0';
                                }else {
                                    tempSumformat =string.valueof(tempSum.format());
                                }     
                                
                                
                            }
                                if(childField == 'EXCISE_TAX_BALANCE') { childCol =  String.valueOf(fieldAndValueMap.get(childField));
                                
                            }
                            string tval2;
                            if(k==5)
                            {
                              tval2 =  String.valueOf(fieldAndValueMap.get(childField));
                            }
                            if(tval2!= Null)
                            { 
                                string  kk2= tval2.replace('$',''); String KKK2 = kk2.replace(',','');
                                tempSum2 += decimal.valueOf(KKK2);
                                 if (!string.valueof(tempSum2.format()).right(3).contains('.')){ tempSum2format = string.valueof(tempSum2.format()) + '.00';
                                }else if (string.valueof(tempSum2.format()).right(2).contains('.')){tempSum2format =  string.valueof(tempSum2.format()) + '0';
                                }else {
                                    tempSum2format =string.valueof(tempSum2.format());
                                }  
                            }
                             if(childField == 'TOTAL_PRODUCT_PRICE'){   childCol =  String.valueOf(fieldAndValueMap.get(childField));
                                
                            }
                            string tval3;
                            if(k==4)
                            {
                              tval3 =  String.valueOf(fieldAndValueMap.get(childField));
                            }
                            if(tval3!= Null)
                            { 
                                string  kk3= tval3.replace('$','');String KKK3 = kk3.replace(',','');
                                tempSum3 += decimal.valueOf(KKK3);
                                 if (!string.valueof(tempSum3.format()).right(3).contains('.')){tempSum3format = string.valueof(tempSum3.format()) + '.00';
                                }else if (string.valueof(tempSum3.format()).right(2).contains('.')){  tempSum3format =  string.valueof(tempSum3.format()) + '0';
                                }else {
                                    tempSum3format =string.valueof(tempSum3.format());
                                }  
                            }
                            
                            //
                           childCol = '<td'+col;
                            childCol = childCol.replace('{{' +childField + '}}', (fieldAndValueMap.get(childField) != null?String.valueOf(fieldAndValueMap.get(childField)):'')).trim();
                            childRowMerged.add(childCol);
                        }
                     k++;
                    }   
                    finalLineRecords.add(childRowMerged);
                }
                
                integer v = 0;
                for(List<String> crow: finalLineRecords){linesHTML += '<tr>';
                    for(String cf: crow){linesHTML += cf ;
                    }
                    if(v++ == finalLineRecords.size() - 1){linesHTML += '</tr><tr><td colspan="4" style="text-align:right"><b>Total</b></td><td><b>$'+tempSum3format+'</b></td><td><b>$' +tempSum2format+' </b></td><td><b>$'+tempSumformat+'</b></td></tr> ';
                    }
                    else{
                         linesHTML += '</tr> ';
                    }
                   
                }
                linesHTML += lastColRemailingHTML; mergedHTMLBody += '<tr>'+linesHTML;
            }else{
                mergedHTMLBody += '<tr>'+row ;
            }
        }
      
         //  mergedHTMLBody += '<p style="position: absolute;top: 390px;margin-left: 556px;"><b>Total: </b>$'+String.valueOf(tempSum)+'</p>';
   
        htmlBody = mergedHTMLBody;
        return htmlBody;
    }
    public void loadTemplate(){  details = new FiligreenFileDetails();
        id ids=invoiceIdList[detailsList.size()];
       Invoice__c inv = [select id,Distributor_Contact__c,RecordTypeId,Distributor_Contact__r.Name,Name from Invoice__c where Id =:ids];
        String recordtypename = Schema.SObjectType.Invoice__c.getRecordTypeInfosById().get(inv.RecordTypeId).getname();
      
        system.debug('recordtypename>>>'+recordtypename);
        if(recordtypename == 'Service') { FG_Template__c fgtemp =  [SELECT Id, Name, Name__c  FROM FG_Template__c WHERE Name__c = 'Service Invoice'];
            selectedTemplatedId = fgtemp.Id;
            details = FileComposerUtility.getFileData(details,invoiceIdList[detailsList.size()], selectedTemplatedId, queryId, line);
            
        }else if(recordtypename == 'Product'){FG_Template__c fgtemp =  [SELECT Id, Name, Name__c  FROM FG_Template__c WHERE Name__c = 'Product Invoice'];
           selectedTemplatedId = fgtemp.Id;
            details = FileComposerUtility.getFileData(details,invoiceIdList[detailsList.size()], selectedTemplatedId, queryId, line);
            
        }else if(recordtypename=='Tax'){ FG_Template__c fgtemp =  [SELECT Id, Name, Name__c  FROM FG_Template__c WHERE Name__c = 'Cultivation Tax Invoice'];
           selectedTemplatedId = fgtemp.Id;
            details = FileComposerUtility.getFileData(details,invoiceIdList[detailsList.size()], selectedTemplatedId, queryId, line);
        }
           
    }
    public String GoogleDriveAuthUri(String Clientkey,String redirect_uri){
        String key = EncodingUtil.urlEncode(Clientkey,'UTF-8');
        String uri = EncodingUtil.urlEncode(redirect_uri,'UTF-8');
        String authuri = '';
        authuri = 'https://accounts.google.com/o/oauth2/auth?'+
            'client_id='+key+
            '&response_type=code'+
            '&scope=https://www.googleapis.com/auth/drive'+
            '&redirect_uri='+uri+
            '&state='+originalparameters+'&'+
            'access_type=offline';
        return authuri;
    }    
    public void AccessToken(){
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://accounts.google.com/o/oauth2/token');
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        String messageBody = 'code='+code+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
        Http h = new Http();
        String resp;
        if(!test.isRunningTest()){  HttpResponse res = h.send(req);resp = res.getBody();
        }else{
            resp='{"access_token": "ya29.Il-8B0sVpCSVwF3VQ2o--8DMwIjEvwWCwUWfySIL-_lWz21rk2_uibBsuNq1tFDu5ZK4q9bcVanuydYY1M0C7RAo256nefk9SGXtXEbbB_gdN_WNIsNxTmsHJl5lIbyzgQ",';
            resp=resp+'"expires_in": 3599,"scope": "https://www.googleapis.com/auth/drive","token_type": "Bearer"}';
        }
        JSONParser parser = JSON.createParser(resp);
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                String fieldName = parser.getText();
                parser.nextToken();
                if(fieldName == 'access_token')
                {
                    accesstoken = parser.getText();
                } 
                else if(fieldName == 'expires_in')
                {
                    expiresIn = parser.getIntegerValue();
                    system.debug('aaa : '+expiresIn );
                }
                else if(fieldname=='token_type')
                {
                    tokentype=parser.getText();
                }
                else if(fieldname=='refresh_token') {  refreshToken=parser.getText();
                    
                }
            }
        }   
        System.debug('Access Token Response Body' + resp);
    }
    public PageReference doGoogleDriveAuth(){
        if(accesstoken!=null && accesstoken!=''){  loadTemplate();
            loadInitailSetup();
            return null;
        }else{
            if(loginDone==false){  PageReference pg = new PageReference(GoogleDriveAuthUri (key , redirect_uri)) ; return pg ;
            }else{
                AccessToken();
                loadTemplate();
                loadInitailSetup();
                updateRefreshToken(googleDrive.id,refreshToken,accessToken);
                return null;
            }    
        }
    }    
    public void AccessTokenFromRefreshToken(){
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://oauth2.googleapis.com/token');
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        String messageBody = 'client_id='+key+'&client_secret='+secret+'&refresh_token='+refreshToken+'&grant_type=refresh_token';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
        Http h = new Http();
        String resp;
        if(!test.isRunningTest()){ HttpResponse res = h.send(req); resp = res.getBody();
        }else{
            resp ='{"access_token": "ya29.ImC8BwrypoQ4NtJ0QKNfFpLAZ-y6XUlXWsi0w-KFed5tljUPXyd87briC_MnKS6ffdvLInGQZHjHZLRuZKZ_GEuIpGeZzXZfJWr9gzOaXZWukCPOc-Crkmd-lLyjwiK-jWA",';
            resp +='"expires_in": 3599, "scope": "https://www.googleapis.com/auth/drive","token_type": "Bearer"}';
        }
        JSONParser parser = JSON.createParser(resp);
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                String fieldName = parser.getText();
                parser.nextToken();
                if(fieldName == 'access_token'){
                    accesstoken = parser.getText();
                }else if(fieldName == 'expires_in'){
                    expiresIn = parser.getIntegerValue();
                    system.debug('aaa : '+expiresIn );
                }else if(fieldname=='token_type'){
                    tokentype=parser.getText();
                }
            }
        }   
        System.debug('Access Token From Refresh Token Response Body' + resp);
    }
    public String UploadFile(){
        String filename = 'Test File2';
        String fileType='application/vnd.openxmlformats-officedocument.wordprocessingml.document';
        fileData = fileData.replace('data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,','');
        Blob file = EncodingUtil.base64Decode(fileData);
        String bodyEncoded = EncodingUtil.base64Encode(file);
        
        String boundary = '-------314159265358979323846';
        String delimiter = '\r\n--' + boundary +'\r\n';
        String close_delim = '\r\n--' + boundary + '--';
        //String body ='{ "title" : "' + filename + '","name":"'+filename+'",' + ' "mimeType" : "' + filetype + '"' + '}';
        String body=delimiter+'Content-Type: application/json\r\n\r\n'+'{ "title" : "'+ filename+'",'+' "mimeType" : "application/vnd.google-apps.document" }'+delimiter+'Content-Type: ' + filetype + '\r\n'+'Content-Transfer-Encoding: base64\r\n'+'\r\n'+bodyEncoded+close_delim;
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        string endpointUrl='https://www.googleapis.com/upload/drive/v2/files?uploadType=multipart';
        req.setEndpoint(endpointUrl);
        req.setHeader('Authorization', 'Bearer ' +accessToken);
        req.setHeader('Content-Type', 'multipart/mixed; boundary="'+boundary+'"'); 
        req.setHeader('Content-length', String.valueOf(body.length()));
        req.setBody(body);
        req.setMethod('POST');
        req.setTimeout(120000);
        if(!test.isRunningTest()){ HttpResponse res= http.send(req); return res.getBody();
        }else{
            string resp ='{"id": "LyjwiKjWA"}';
            return resp;
 
        }
    }
    @future
    public static  void updateRefreshToken(string id,string refreshToken,string accessToken){
        PDFEngine_Config__c updateRefreshToken =new PDFEngine_Config__c();
        updateRefreshToken.id=id;
        updateRefreshToken.Refresh_Token__c=refreshToken;
        updateRefreshToken.Access_Token__c=accessToken;
        update updateRefreshToken;        
    }  
    public void createFile(){
        Boolean updateAccessToken = false;
        string resp;
        //if(!test.isRunningTest()){
            resp = UploadFile();
            system.debug('resp '+resp);
            Map<String, Object> p = (Map<String, Object>) JSON.deserializeUntyped(resp);
            System.debug('Response:'+p);
            if(p.containsKey('error')){ AccessTokenFromRefreshToken();
                updateAccessToken = true; resp = UploadFile();
            }
            JSONParser parser = JSON.createParser(resp);
            string fileId='';
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                    String fieldName = parser.getText();
                    parser.nextToken();
                    if(fieldName == 'id')
                    {
                        fileId=parser.getText();
                        break;
                    } 
                }
            }
            if(String.isNotBlank(fileId)){
                downloadFile(fileId);
            }
            if(updateAccessToken){ updateRefreshToken(googleDrive.id,refreshToken,accessToken);
            }
       // }
        detailsList.add(details);
        if(detailsList.size() == invoiceIdList.size())
            attachmentProcessingFinished = true;
    }
    public blob downloadFile(string fileId){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        string endpointUrl='https://www.googleapis.com/drive/v3/files/'+fileId+'/export?mimeType=application/pdf&alt=media';
        req.setEndpoint(endpointUrl);
        req.setHeader('Authorization', 'Bearer ' +accessToken);
        req.setHeader('Accept', 'application/json'); 
        req.setMethod('GET');
        req.setTimeout(120000);
        resp = blob.valueof('');
        try{
            if(!test.isRunningTest()){HttpResponse res= http.send(req);
                resp = res.getBodyAsBlob();
                system.debug('details.isSaveAsAttachment '+details.isSaveAsAttachment);
                //details = FileComposerUtility.getFileData(details,invoiceIdList[detailsList.size()], selectedTemplatedId, queryId, line);
                details.templateBodyPDF = 'data:application/pdf;base64,'+EncodingUtil.Base64Encode(resp); deleteFile(fileId);
            }else{
                resp =blob.valueof('testing body');
            }
            system.debug('Download File Response Body :  '+resp);
        }catch(Exception e){
            System.debug('Exception:'+e.getMessage());
        }
        return resp;
    }    
    public  void deleteFile(string fileId){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        string endpointUrl='https://www.googleapis.com/drive/v3/files/'+fileId;
        req.setEndpoint(endpointUrl);
        req.setHeader('Authorization', 'Bearer ' +accessToken);
        req.setHeader('Accept', 'application/json; charset=UTF-8');
        req.setMethod('DELETE');
        req.setTimeout(120000);
        string resp;
        if(!test.isRunningTest()){ HttpResponse res= http.send(req);   resp = res.getBody();
        }
        system.debug('Delete File Response Body : '+resp);
    }
    public void sendEmail(){
        Savepoint sp = Database.setSavepoint();
        try{
            emailSent = true;
            errorMsg = '';
            FileDetails[] aFiles;
            list<string>toAddList =new list<string>();        
            list<Contact> conList  = new list<contact>();
            if(invoice.Distributor_Contact__c != null)
                conList = [select id,email from contact where id =: invoice.Distributor_Contact__c];        
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
            if(additionalAdd != null && additionalAdd!='null' && additionalAdd.trim() !='')
                toAddList.addAll(additionalAdd.split(','));
            if(conList.size()>0 && conList[0].email != null)
                toAddList.add(conList[0].email);
            if(toAddList.size() > 0){
                mail.setToAddresses(toAddList);
                if(ccAdd != null && ccAdd!='null' && ccAdd.trim() !=''){
                    list<string>ccAddList = ccAdd.trim().split(',');
                    if(ccAddList.size() > 0)
                        mail.setCcAddresses(ccAddList);
                }
                /*if(bccAdd != null && bccAdd!='null' && bccAdd.trim() !=''){
                    list<string>bccAddList = bccAdd.trim().split(',');
                    if(bccAddList.size()>0)
                        mail.setBCcAddresses(bccAddList);
                }*/
                mail.setSubject(subject);
                mail.setHtmlBody(emailBody);
                list<Messaging.EmailFileAttachment>emailAttList = new List<Messaging.EmailFileAttachment>(); 
                list<Attachment>attList = new List<Attachment>();
                list<Task>taskList = new list<Task>();
                system.debug('additionalFiles '+additionalFiles);
                if(additionalFiles != null && additionalFiles != '[]'){
                    aFiles = (FileDetails[]) JSON.deserialize(additionalFiles, List<FileDetails>.class);
                    if(aFiles != null && aFiles.size() > 0){
                        for(FileDetails fd: aFiles){
                            String replaceString = 'data:'+fd.filetype+';base64,';
                            fd.file = fd.file.replace(replaceString,'');
                            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
                            efa.setFileName(fd.filename);                        
                            efa.setBody(EncodingUtil.base64Decode(fd.file));
                            efa.setContentType(fd.filetype);   
                            emailAttList.add(efa);
                            
                            if(fd.recordId != null && fd.recordId != ''){
                                if(saveAtt){
                        ContentVersion cVersion = new ContentVersion();
                cVersion.ContentLocation = 'S'; //S-Document is in Salesforce. E-Document is outside of Salesforce. L-Document is on a Social Netork.
                cVersion.PathOnClient = fd.filename;//File name with extention
                cVersion.Origin = 'H';//C-Content Origin. H-Chatter Origin.
               // cVersion.OwnerId = attachs.OwnerId;//Owner of the file
               // cVersion.Title = attachs.Name;//Name of the file
                cVersion.VersionData = EncodingUtil.base64Decode(fd.file);//File content
                Insert cVersion;       
                system.debug('cVersion>'+cVersion);  
                             Id conDocument = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:cVersion.Id].ContentDocumentId;
                
                //Insert ContentDocumentLink
                ContentDocumentLink cDocLink = new ContentDocumentLink();
                cDocLink.ContentDocumentId = conDocument;//Add ContentDocumentId
                cDocLink.LinkedEntityId = fd.recordId;//Add attachment parentId
                cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
                cDocLink.Visibility = 'InternalUsers';//AllUsers, InternalUsers, SharedUsers
                Insert cDocLink;
               //delete attachs;
                system.debug('cDocLink>'+cDocLink);             
                                    Attachment att = new Attachment(); 
                                    att.body = EncodingUtil.base64Decode(fd.file);
                                    att.ParentId = fd.recordId;
                                    att.Name = fd.filename;
                                    attList.add(att);
                                }
                                /*if(logActivity){
                                    Task tsk = new Task();
                                    tsk.Whatid = fd.recordId;
                                    tsk.Subject = 'Downloaded Invoice Quote '+fd.filename;
                                    tsk.ActivityDate = system.today();
                                    taskList.add(tsk);
                                }*/
                            }
                         
                        }
                    }
                } 
                mail.setFileAttachments(emailAttList);
                mail.setSaveAsActivity(logActivity);
                
                if(Invoice2.Receiver_Contact__c != NULL){
                    List<Contact> fromContacts = [SELECT Id,Name, Email FROM Contact WHERE Id = :Invoice2.Receiver_Contact__c];
                    if(fromContacts.size() > 0){
                        mail.setInReplyTo(fromContacts[0].Email);
                        mail.setSenderDisplayName(fromContacts[0].Name);
                    }
                }else{
                    List<OrgWideEmailAddress> orgEmailList = [SELECT Id, DisplayName FROM OrgWideEmailAddress WHERE DisplayName =: DL_Finance];
                    if(orgEmailList.size() > 0){
                        mail.setOrgWideEmailAddressId(orgEmailList[0].id);
                    }
                }
                
                mail.setWhatId(invoiceIdList[0]);
                mails.add(mail);
                additionalFiles = '';
                Messaging.sendEmail(mails);  
                List<Invoice__c>lstinvemail = new list<Invoice__c>();
            //   id ids=invoiceIdList[detailsList.size()];
      		List<Invoice__c>  inv = [select id,Invoice_Balance__c,Excise_Tax_Balance__c,Invoice_Emailed__c,Product_Balance__c,Name from Invoice__c where Id IN: invoiceIdList];
                for(Invoice__c inobj :inv ){
                    if(inobj.Invoice_Emailed__c == false) {
                        Invoice__c invinst = new Invoice__c();
                        invinst.Id=inobj.id;
                        invinst.Invoice_Emailed__c=true;
                        lstinvemail.add(invinst);
                    }
                }
                upsert lstinvemail;
                system.debug('lstinvemail>>>>>>>>>>>>>>>>>>>>>'+lstinvemail);
      // Invoice__c inv = [select id,Distributor_Contact__c,RecordTypeId,Invoice_Emailed__c,Distributor_Contact__r.Name,Name from Invoice__c where Id =:ids];
               // system.debug('inv>>>>>>>>>>>>>>>>>>>>>'+inv);
              //  if(inv.Invoice_Emailed__c == false){
             //      system.debug('inv>>>>>>>>>>>>>>>>>>>>>'+inv.Invoice_Emailed__c);   
             //   }
                if(attList.size() > 0)
                //    insert attList;
         
                if(logActivity){
                    list<EmailMessage>emailMsgList = new List<EmailMessage>();
                    EmailMessage emailMsg = [SELECT ParentId, TextBody, HtmlBody, Headers, Subject, FromName, FromAddress, ValidatedFromAddress, ToAddress, CcAddress, BccAddress, Incoming, HasAttachment, Status, MessageDate, IsDeleted, ReplyToEmailMessageId, IsExternallyVisible, MessageIdentifier, ThreadIdentifier, IsClientManaged, RelatedToId, IsTracked, IsOpened, FirstOpenedDate, LastOpenedDate, IsBounced, EmailTemplateId FROM EmailMessage where RelatedToId =: invoiceIdList[0]  order by CreatedDate desc limit 1];
                    for(integer i=1;i<invoiceIdList.size();i++){  EmailMessage newEmailMsg = emailMsg.clone();
                        newEmailMsg.RelatedToId = invoiceIdList[i];
                        emailMsgList.add(newEmailMsg);
                    }
                    if(emailMsgList.size()>0) insert emailMsgList;
                }
            }
        }catch(exception ex){ Database.rollback( sp );  emailSent = false;
            errorMsg = ex.getMessage();
            system.debug('ex.getMessage() '+ex.getMessage());
        }
	}
    public void loadEmail(){
        EmailWrapperList = new list<EmailWrapperClass>();
        if(searchText != null && searchText != ''){
            Search.SearchResults searchResults = Search.find('FIND \''+searchText+'\' IN ALL FIELDS RETURNING Contact(Name,Email,Account.Name),Lead(Name,Email),User(Name,Email)');
            List<Search.SearchResult> contactList = searchResults.get('Contact');
            List<Search.SearchResult> leadList = searchResults.get('Lead');
            List<Search.SearchResult> userList = searchResults.get('User');
            if(contacts){	
                for (Search.SearchResult searchResult : contactList) {  Contact con = (Contact) searchResult.getSObject(); 
                    EmailWrapperClass emlObj = new EmailWrapperClass(con.id,con.Name,'Contact',con.Email,con.Account.Name); EmailWrapperList.add(emlObj);
                }            
            }
            /*if(leads){
                for (Search.SearchResult searchResult : leadList) { 
                    Lead led = (Lead) searchResult.getSObject(); 
                    EmailWrapperClass emlObj = new EmailWrapperClass(led.id,led.Name,'Lead',led.Email,'');
                    EmailWrapperList.add(emlObj);
                }	    
            }*/
            if(users){
                for (Search.SearchResult searchResult : userList) {    User usr = (User) searchResult.getSObject(); EmailWrapperClass emlObj = new EmailWrapperClass(usr.id,usr.Name,'User',usr.Email,'');EmailWrapperList.add(emlObj);
                }    
            }
        }
        system.debug('aa EmailWrapperList '+EmailWrapperList.size());
    }
    public class FileDetails{
        public String filename;
        public String filetype;
        public String file;
        public String recordId;
    }
    public class EmailWrapperClass{
        public string id{get;set;}
        public string name{get;set;}
        public string emailType{get;set;}
        public string email{get;set;}
        public string account{get;set;}
        public EmailWrapperClass(string i,string nm,string t,string em,string acc){
        	name = nm;
            emailType = t;
            email = em;
            account = acc;
            id = i;
        }        
    }
}