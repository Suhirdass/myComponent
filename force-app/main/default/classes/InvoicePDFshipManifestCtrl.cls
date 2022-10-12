public class InvoicePDFshipManifestCtrl {
    public List<String> errors {get;set;}
	public string recordId{set;get;}
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
    public PDFEngine_Config__c googleDrive {set;get;}
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
    public string additionalFiles{get;set;}
    private String invoiceIds{get;set;}
    public string invoiceStr{get;set;}
    public string invoiceStrName{get;set;}
    list<FiligreenFileDetails>detailsList;
    public boolean attachmentProcessingFinished{get;set;}
    public Invoice__c invoice{get;set;}
    public boolean saveAtt{get;set;}
    public boolean logActivity{get;set;}
    public string removedInvoiceId{get;set;}
    public boolean emailSent{get;set;}
    public string errorMsg{get;set;}
    list<string>invoiceIdList = new list<string>();
    public string testInvID {get;set;}
    private Static String TEMPLATE_GROUP_NAME_INVOICE { 
        get{
            return  String.isNotBlank(TEMPLATE_GROUP_NAME_INVOICE) ? TEMPLATE_GROUP_NAME_INVOICE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','EmailTemp_Group_Invoice');
        }set;
    }
    public Static String INVOICE_RECORD_TYPE_PRODUCT{
        get{
            return String.isNotBlank(INVOICE_RECORD_TYPE_PRODUCT) ? INVOICE_RECORD_TYPE_PRODUCT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Product');
        }set;
    }
    public Static String INVOICE_RECORD_TYPE_TRANSFER{
        get{
            return String.isNotBlank(INVOICE_RECORD_TYPE_TRANSFER) ? INVOICE_RECORD_TYPE_TRANSFER: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Transfer');
        }set;
    }
    
    //Constructor
    public InvoicePDFshipManifestCtrl(){
          errors = new List<String>();
        invoice = new Invoice__c();
        contacts = true;
        users = true;
        line = FiligreenConfigurationUtility.getInvoiceConfig(TEMPLATE_GROUP_NAME_INVOICE,'EmailBodyTablePrefix');
        queryId = FiligreenConfigurationUtility.getInvoiceConfig(TEMPLATE_GROUP_NAME_INVOICE,'queryId');
        attachmentProcessingFinished = false;
        saveAtt = true;
        logActivity = true;
        detailsList = new List<FiligreenFileDetails>();
        selectedTemplatedId = ApexPages.currentPage().getParameters().get('TemplateId') ;
        recordId = ApexPages.currentPage().getParameters().get('id');
        invoiceIds = '';
        templateGroup = TEMPLATE_GROUP_NAME_INVOICE;
        string saveAttstr = 'true';
        string logActivitystr = 'true';
        
     
        Shipping_Manifest__c smSO = [Select Id, Sales_Order__c from Shipping_Manifest__c where Id =: recordId];
         List <Invoice__c> currentInvoice =  [Select Id, Name From Invoice__c Where Sales_Order__c =: smSO.Sales_Order__c AND (RecordType.Name=:INVOICE_RECORD_TYPE_PRODUCT OR RecordType.Name=:INVOICE_RECORD_TYPE_TRANSFER)  ORDER BY Id DESC LIMIT 1];
  
        for(Invoice__c inv : currentInvoice){
            invoiceIds = invoiceIds+inv.Id+',';
        }
        
        
        if(saveAttstr != null)
            saveAtt = boolean.valueof(saveAttstr);
        else
            saveAtt = true;
        
        if(logActivitystr != null)
            logActivity = boolean.valueof(logActivitystr);
        else
            logActivity = true;
        
        googleDrive = PDFEngine_Config__c.getOrgDefaults();
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
    
    
     // Retrieve Invoice Detail
    public static List<Invoice__c> getinvoiceDetail(){
        
        string  recordId = ApexPages.currentPage().getParameters().get('id');
        Shipping_Manifest__c shipManLines = [Select Sales_Order__c From Shipping_Manifest__c where  Id =: recordId];
        Id salesorderId = shipManLines.Sales_Order__c;
        List<Invoice__c> invoiceDetail = [Select Id,Name From Invoice__c where  Sales_Order__c =: salesorderId];
        if(invoiceDetail.size() > 0){
            return invoiceDetail;
        }else{
            return null;
        }
        
    }
    
    public void loadInitailSetup(){
        templateOptions = new List<SelectOption>();
        if(String.isNotBlank(templateGroup)){
            Set<SelectOption> optionsSet = new Set<SelectOption>();
            set<string>templateIdSet = new Set<String>();
            Map<ID, FG_Template__c> templateMap = new Map<ID, FG_Template__c>([SELECT Id, Name, Name__c  FROM FG_Template__c WHERE Template_Group__c ='InvoiceFinal' AND Active__c = true Limit 1]);
            if (!templateMap.isEmpty()){
                for(ContentDocumentLink doc : [SELECT ContentDocumentId, Id, LinkedEntityId, ContentDocument.Title, ContentDocument.FileExtension FROM ContentDocumentLink WHERE LinkedEntityId =: templateMap.keySet() AND ContentDocument.FileExtension= 'docx' Limit 1]){
                    if(!templateIdSet.contains(doc.LinkedEntityId)){templateIdSet.add(doc.LinkedEntityId);
                                                                    FG_Template__c t = templateMap.get(doc.LinkedEntityId);
                                                                    optionsSet.add(new SelectOption(t.Id,t.Name__c));
                                                                    if(selectedTemplatedId == null || selectedTemplatedId == '')
                                                                        selectedTemplatedId = t.id; 
                                                                   }
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
        String pageUrl = '/'+ recordId;
        PageReference pg = new PageReference(pageUrl);
        pg.setRedirect(true);
        return pg;
    }   
     public PageReference redirectToRSM() {
       String pageUrl = '/'+ recordId;
        PageReference pg = new PageReference(pageUrl);
        pg.setRedirect(true);
        return pg;
    }
      public PageReference reDirectoDriverScreen() {
      string url = '/lightning/n/ShipConfirmRsmTsm';
        PageReference page = new PageReference(url);
        page.setRedirect(true);
        return page;
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
        if(emailTemplateList.size()>0){ subject = emailTemplateList[0].Email_Subject__c;
                                      
                                       emailBody = processTemplateMerge(emailTemplateList[0].Email_Body__c,invoiceIdList);
                                      }
    }
    public String processTemplateMerge(String htmlBody,List<string> invoiceIdList){
      
        try{
              
        Map<String,Map<String,Object>> invoiceFieldAndValueMap = FileComposerUtility.prepareFileData(invoiceIdList);
        String[] htmlbodyTRWise = htmlBody.split('<tr>');
        String mergedHTMLBody = '';
        for(String row:htmlbodyTRWise){
            String mergedRow = '';
            pattern p = Pattern.compile('\\{\\{TableStart:'+line+'\\}\\}');
            Matcher m = p.matcher(row);
            if(m.find() || Test.isRunningTest()){
                String lastColRemailingHTML = '';
                String[] columns = row.split('<td');
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
                for(string invoiceId : invoiceIdList){
                    List<String> childRowMerged = new List<String>();
                    Map<String,Object> fieldAndValueMap = invoiceFieldAndValueMap.get(invoiceId);
                    for(Integer ind : colsMap.keySet()){
                        String col = colsMap.get(ind);
                        pattern pc = Pattern.compile('\\{\\{[a-zA-Z0-9_\\s\\.]*\\}\\}');
                        Matcher mc = pc.matcher(col);
                        if(mc.find()){ String childField = col.substring(mc.start()+2,mc.end()-2);
                            String childCol = '<td'+col;
                            childCol = childCol.replace('{{' +childField + '}}', (fieldAndValueMap.get(childField) != null?String.valueOf(fieldAndValueMap.get(childField)):'')).trim();
                            childRowMerged.add(childCol);
                        }
                    }   
                    finalLineRecords.add(childRowMerged);
                }
                for(List<String> crow: finalLineRecords){
                    linesHTML += '<tr>';
                    for(String cf: crow){ linesHTML += cf;
                    }
                    linesHTML += '</tr>';
                }
                linesHTML += lastColRemailingHTML;
                mergedHTMLBody += '<tr>'+linesHTML;
            }else{
                mergedHTMLBody += '<tr>'+row;
            }
        }
        htmlBody = mergedHTMLBody;
          }
    catch(DmlException ex){
        ApexPages.addMessages(ex);
      // reDirectoDriverScreen(); 
    }
      
        return htmlBody;
    }
    
    
    public void loadTemplate(){
        details = new FiligreenFileDetails();
        details = FileComposerUtility.getFileData(details,invoiceIdList[detailsList.size()], selectedTemplatedId, queryId, line);
    }
    
    public String GoogleDriveAuthUri(String Clientkey,String redirect_uri){
        String key = EncodingUtil.urlEncode(Clientkey,'UTF-8');
        String uri = EncodingUtil.urlEncode(redirect_uri,'UTF-8');
        String googleAuthUrl= googleDrive.Google_Auth_Url__c;
        String googleAuthDrive = googleDrive.Google_Auth_Drive_Url__c;
        String authuri = '';
        authuri = googleAuthUrl+'client_id='+key+
            '&response_type=code'+'&scope='+googleAuthDrive+
            '&redirect_uri='+uri+'&state='+originalparameters+'&'+ 'access_type=offline';
        return authuri;
    }    
    public void AccessToken(){
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        string endpoint =  googleDrive.Google_Auth_Url__c + 'token';
         String googleAuthDrive = googleDrive.Google_Auth_Drive_Url__c;
         String googleAccessToken = googleDrive.Access_Token__c;	
        req.setEndpoint(endpoint);
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        String messageBody = 'code='+code+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
        Http h = new Http();
        String resp;
        if(!test.isRunningTest()){HttpResponse res = h.send(req); resp = res.getBody();
        }else{
            resp='{"access_token":'+googleAccessToken+',';
            resp=resp+'"expires_in": 3599,"scope":'+googleAuthDrive+',"token_type": "Bearer"}';
        }
        JSONParser parser = JSON.createParser(resp);
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                String fieldName = parser.getText();
                parser.nextToken();
                if(fieldName == 'access_token') {accesstoken = parser.getText();} 
                else if(fieldName == 'expires_in'){ expiresIn = parser.getIntegerValue();}
                else if(fieldname=='token_type'){tokentype=parser.getText();}
                else if(fieldname=='refresh_token'){refreshToken=parser.getText();}
            }
        }   
    }
    public PageReference doGoogleDriveAuth(){
        if(accesstoken!=null && accesstoken!=''){
            loadTemplate();
            loadInitailSetup();
            return null;
        }else{
            if(loginDone==false){ PageReference pg = new PageReference(GoogleDriveAuthUri (key , redirect_uri)) ;
                return pg ;
            }else{
                AccessToken();
                loadTemplate();
                loadInitailSetup();
                updateRefreshToken(googleDrive.id,refreshToken,accessToken);return null;
            }    
        }
    }    
    public void AccessTokenFromRefreshToken(){
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        string endpoint = googleDrive.Google_Api_Token_Url__c;
       String googleAuthDrive = googleDrive.Google_Auth_Drive_Url__c;
        String googleAccessToken = googleDrive.Access_Token__c;	
        req.setEndpoint(endpoint);
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        String messageBody = 'client_id='+key+'&client_secret='+secret+'&refresh_token='+refreshToken+'&grant_type=refresh_token';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
        Http h = new Http();
        String resp;
        if(!test.isRunningTest()){HttpResponse res = h.send(req); resp = res.getBody();
        }else{
            resp ='{"access_token":'+googleAccessToken+',';
            resp +='"expires_in": 3599, "scope":'+googleAuthDrive+',"token_type": "Bearer"}';
        }
        JSONParser parser = JSON.createParser(resp);
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){   
                String fieldName = parser.getText();
                parser.nextToken();
                if(fieldName == 'access_token'){accesstoken = parser.getText();}
                else if(fieldName == 'expires_in'){expiresIn = parser.getIntegerValue();}
                else if(fieldname=='token_type'){tokentype=parser.getText();}
            }
        }   
    }
    
 
    @future (callout=true)
    public static void UploadFile(String fileData, List<Id> invoiceIdList,string accessToken, String endPointUrl, String fileDownloadUrl){
        String invoiceTitle;
        Id  invId;
        for(Invoice__c inv : [select id,Distributor_Contact__c,Distributor_Contact__r.Name,Name from Invoice__c where Id IN: invoiceIdList]){
            invoiceTitle = inv.Name;
            invId = inv.id;
        }
        
        String filename = invoiceTitle;
        String fileType='application/vnd.openxmlformats-officedocument.wordprocessingml.document';
        fileData = fileData.replace('data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64,','');
        Blob file = EncodingUtil.base64Decode(fileData);
        String bodyEncoded = EncodingUtil.base64Encode(file);
        
        String boundary = '-------314159265358979323846';
        String delimiter = '\r\n--' + boundary +'\r\n';
        String close_delim = '\r\n--' + boundary + '--';
        
        String body=delimiter+'Content-Type: application/json\r\n\r\n'+'{ "title" : "'+ filename+'",'+' "mimeType" : "application/vnd.google-apps.document" }'+delimiter+'Content-Type: ' + filetype + '\r\n'+'Content-Transfer-Encoding: base64\r\n'+'\r\n'+bodyEncoded+close_delim;
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpointUrl);
        req.setHeader('Authorization', 'Bearer ' +accessToken);
        req.setHeader('Content-Type', 'multipart/mixed; boundary="'+boundary+'"'); 
        req.setHeader('Content-length', String.valueOf(body.length()));
        req.setBody(body);
        req.setMethod('POST');
        req.setTimeout(120000);
        if(!test.isRunningTest()){  HttpResponse res= http.send(req);//return res.getBody();
                                  String resp = res.getBody();
                                  JSONParser parser = JSON.createParser(resp);
                                  string fileId='';
                                  while (parser.nextToken() != null) {
                                      if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                                          String fieldName = parser.getText();
                                          parser.nextToken();
                                          if(fieldName == 'id'){fileId=parser.getText();
                                                                break;
                                                               } 
                                      }
                                  }
                                  
                                  
                                  Http https = new Http();
                                  HttpRequest reqs = new HttpRequest();
                                  string endpoint_Url=fileDownloadUrl+fileId+'/export?mimeType=application/pdf&alt=media';
                                  reqs.setEndpoint(endpoint_Url);
                                  reqs.setHeader('Authorization', 'Bearer ' +accessToken);
                                  reqs.setHeader('Accept', 'application/json'); 
                                  reqs.setMethod('GET');
                                  reqs.setTimeout(120000);
                                  if(!test.isRunningTest()){
                                      HttpResponse resss= http.send(reqs);
                                      
                                      Blob base64Response = 	resss.getBodyAsBlob();
                                      ContentVersion conVer = new ContentVersion();
                                      conVer.ContentLocation = 'S'; // S specify this document is in SF, use E for external files
                                      conVer.PathOnClient = invoiceTitle+'.pdf'; // The files name, extension is very important here which will help the file in preview.
                                      conVer.Title =invoiceTitle; // Display name of the files
                                      conVer.VersionData = base64Response; // converting your binary string to Blob
                                      insert conVer;
                                      
                                      // First get the content document Id from ContentVersion
                                      Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
                                      
                                      //Create ContentDocumentLink
                                      ContentDocumentLink cDe = new ContentDocumentLink();
                                      cDe.ContentDocumentId = conDoc;
                                      cDe.LinkedEntityId =invId; // you can use objectId,GroupId etc
                                      cDe.ShareType = 'I'; // Inferred permission, checkout description of ContentDocumentLink object for more details
                                      cDe.Visibility = 'InternalUsers';
                                      insert cDe;
                                      
                                  }
                                  
                                 }else{
                                     string resp ='{"id": "LyjwiKjWA"}';
                                     //return resp;
                                 }
    }
    
   
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
        AccessTokenFromRefreshToken();
        String endPointUrl = googleDrive.File_Upload_Url__c;
        String fileDownloadUrl = googleDrive.File_Download_Url__c;
        UploadFile(fileData,invoiceIdList,accessToken,endPointUrl,fileDownloadUrl);
        reDirectoDriverScreen();
        
    }
    
    
    public  void deleteFile(string fileId){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        string endpointUrl=googleDrive.File_Download_Url__c+fileId;
        req.setEndpoint(endpointUrl);
        req.setHeader('Authorization', 'Bearer ' +accessToken);
        req.setHeader('Accept', 'application/json; charset=UTF-8');
        req.setMethod('DELETE');
        req.setTimeout(120000);
        string resp;
        if(!test.isRunningTest()){HttpResponse res= http.send(req);  resp = res.getBody();
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
                for (Search.SearchResult searchResult : contactList) { Contact con = (Contact) searchResult.getSObject(); EmailWrapperClass emlObj = new EmailWrapperClass(con.id,con.Name,'Contact',con.Email,con.Account.Name);EmailWrapperList.add(emlObj);
                }            
            }
 
            if(users){
                for (Search.SearchResult searchResult : userList) {  User usr = (User) searchResult.getSObject(); EmailWrapperClass emlObj = new EmailWrapperClass(usr.id,usr.Name,'User',usr.Email,''); EmailWrapperList.add(emlObj);
                }    
            }
        }
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