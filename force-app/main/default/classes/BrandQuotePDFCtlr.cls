/* Name: BrandQuotePDFCtlr
*/
public class BrandQuotePDFCtlr {
    public transient String  conDocId {set;get;} 
    public boolean fromDownload{get;set;}
    public Boolean isTemplatedLoaded{set;get;}
    public transient String  fileData {set;get;}
    public boolean defaultAttRemoved{get;set;}
    String code ;
    String state ;
    String key = '' ;
    String secret = '' ;
    String redirect_uri = '' ;
    String accesstoken ;
    Integer expiresIn ;
    String tokentype;
    String refreshToken;
    Boolean loginDone=false;
    public static PDFEngine_Config__c googleDrive;
    public string recordId{set;get;}
    string templateId{set;get;}
    string queryId{set;get;}
    string templateGroup{set;get;}
    string queryParams{set;get;}
    public string queryIdParams{set;get;}
    string line{set;get;}
    string originalparameters;
    Boolean isSuccess {set;get;}
    public FiligreenFileDetails details{set;get;}
    public List<SelectOption> templateOptions{set;get;}
    public List<SelectOption> emailTemplateOptions{set;get;}
    public String selectedTemplatedId{set;get;}
    public String selectedEmailTemplatedId{set;get;}
    public String documentName{set;get;}
    string subject{get;set;}
    public string bccAdd{get;set;}
    public string ccAdd{get;set;}
    public string additionalAdd{get;set;}
    public string BrandQuoteStr{get;set;}
    public string BrandQuotesellStr{get;set;}
    public String emailBody{set;get;}
    public Brand_Quote__c brandQuote{get;set;}
    public FG_Email_Template__c emailTemplate{get;set;}
    contact con{get;set;}
    public boolean contacts{get;set;}
    public boolean leads{get;set;}
    public boolean users{get;set;}
    public string searchText{get;set;}
    public list<EmailWrapperClass>EmailWrapperList{get;set;}
    string fileType{get;set;}
    public string fileName{get;set;}
    blob fileBody{get;set;}
    public Transient  blob resp{get;set;}
    public string bodyStr{get;set;}
    public string additionalFiles{get;set;}
    public string docName{get;set;}
    Boolean fromInvoice{get;set;}
    public Boolean isSaveAsAttachment{get;set;}
    public Boolean isLogActivity{get;set;}
    

      public Static String BRANDQUOTE_TEMPLATE_BUYQUOTE{
        get{
            return String.isNotBlank(BRANDQUOTE_TEMPLATE_BUYQUOTE) ? BRANDQUOTE_TEMPLATE_BUYQUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Template_Group_Name');
        }set;
      }
    
       public Static String BRANDQUOTE_TEMPLATE_SELLQUOTE{
        get{
            return String.isNotBlank(BRANDQUOTE_TEMPLATE_SELLQUOTE) ? BRANDQUOTE_TEMPLATE_SELLQUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Template_Group_Sellquote');
        }set;
      }
     
    public Static String BRANDQUOTE_FILENAME_BUYQUOTE{
        get{
            return String.isNotBlank(BRANDQUOTE_FILENAME_BUYQUOTE) ? BRANDQUOTE_FILENAME_BUYQUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_FileName_Buy_Quote');
        }set;
      }
    
    public Static String BRANDQUOTE_FILENAME_SELLQUOTE{
        get{
            return String.isNotBlank(BRANDQUOTE_FILENAME_SELLQUOTE) ? BRANDQUOTE_FILENAME_SELLQUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_FileName_Sell_Quote');
        }set;
      }
    
     public Static String FIELDNAME_ACCESS_TOKEN { 
        get{
            return  String.isNotBlank(FIELDNAME_ACCESS_TOKEN) ? FIELDNAME_ACCESS_TOKEN :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Fieldname_Access_Token');
        }set;
    }
    
    
    public Static String FIELDNAME_EXPIRES_IN { 
        get{
            return  String.isNotBlank(FIELDNAME_EXPIRES_IN) ? FIELDNAME_EXPIRES_IN :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Fieldname_Expires_In');
        }set;
    }
    
    public Static String FIELDNAME_TOKEN_TYPE { 
        get{
            return  String.isNotBlank(FIELDNAME_TOKEN_TYPE) ? FIELDNAME_TOKEN_TYPE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Fieldname_Token_Type');
        }set;
    }
    
    public Static String FIELDNAME_REFRESH_TOKEN {
        get{
            return  String.isNotBlank(FIELDNAME_REFRESH_TOKEN) ? FIELDNAME_REFRESH_TOKEN :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Fieldname_Refresh_Token');
        }set;
    }
    
    
    //Constructor
    public BrandQuotePDFCtlr(){
        EmailWrapperList = new List<EmailWrapperClass>();
        fromDownload = false;
        contacts = true;
        leads = true;
        users = true;
        isSaveAsAttachment = false;
        isLogActivity = false;
        details = new FiligreenFileDetails();
        isTemplatedLoaded = false;
        for(String key: ApexPages.currentPage().getParameters().keySet()){
            System.debug('##URL Param:'+key+'='+ApexPages.currentPage().getParameters().get(key));
        }
        googleDrive = PDFEngine_Config__c.getOrgDefaults();
        if(googleDrive != null){
            key = googleDrive.Client_Id__c;
            redirect_uri = googleDrive.Return_Url__c;
            secret = googleDrive.Secret__c ;
            refreshToken=googleDrive.Refresh_Token__c;
            accesstoken=googleDrive.Access_Token__c;
        }
        recordId = ApexPages.currentPage().getParameters().get('id') ;
        templateId = ApexPages.currentPage().getParameters().get('TemplateId') ;
        selectedEmailTemplatedId = ApexPages.currentPage().getParameters().get('EmailTemplateId') ;
        code = ApexPages.currentPage().getParameters().get('code') ; 
        queryIdParams = ApexPages.currentPage().getParameters().get('QueryId') ; 
        templateGroup = ApexPages.currentPage().getParameters().get('templateGroup') ; 
        docName = ApexPages.currentPage().getParameters().get('docName') ;
        if(ApexPages.currentPage().getParameters().get('isSaveAsAttachment') != null){
            isSaveAsAttachment = Boolean.valueOf(ApexPages.currentPage().getParameters().get('isSaveAsAttachment')) ;
        }
        if(ApexPages.currentPage().getParameters().get('isLogActivity') != null){
        	isLogActivity = Boolean.valueOf(ApexPages.currentPage().getParameters().get('isLogActivity'));    
        }
        if(ApexPages.currentPage().getParameters().get('documentName') != null){
            documentName = ApexPages.currentPage().getParameters().get('documentName');
        }
        
        if(code != '' && code != null){
            loginDone=true;
            String stateParam = ApexPages.currentPage().getParameters().get('state') ;
            String[] stateParams = stateParam.split(',');
            for(String param: stateParams){
            
                String p = param.substring(0,param.indexOf('='));
                String value = param.substring(param.indexOf('=')+1,param.length());
                if(p == 'id'){
                    recordId = value;
                }else if('TempateId'.equalsIgnoreCase(p)){
                    templateId = value;
                }else if('QueryId'.equalsIgnoreCase(p)){
                    queryParams = value;
                }else if('templateGroup'.equalsIgnoreCase(p)){
                    templateGroup = value;
                }else if('isSaveAsAttachment'.equalsIgnoreCase(p)){
                    isSaveAsAttachment = Boolean.valueOf(value);
                }else if('isLogActivity'.equalsIgnoreCase(p)){
                    isLogActivity = Boolean.valueOf(value);
                }else if('documentName'.equalsIgnoreCase(p)){
                    documentName = value;
                }
            }
        }
        if(String.isNotBlank(queryIdParams)){
            
            String[] queryParamsParts = queryIdParams.split('\\?');
            String queryIdPart = queryParamsParts[0];
            pattern pc = Pattern.compile('\\[[a-zA-Z0-9_\\s\\.]*\\]');
            Matcher mc = pc.matcher(queryIdPart);
            if(mc.find()){
                line = queryIdPart.substring(mc.start()+1,mc.end()-1);
                queryId = queryIdPart.substring(mc.end());
            }
            if(queryParamsParts.size()> 1){
                queryParams = queryParamsParts[1];
            }
            
        }

        originalparameters = 'id='+recordId+',QueryId='+queryIdParams+'?'+queryParams+',TempateId='+templateId+',templateGroup='+templateGroup;
        selectedTemplatedId = templateId;
        BrandQuotesellStr=BRANDQUOTE_TEMPLATE_BUYQUOTE;
        BrandQuoteStr = BRANDQUOTE_TEMPLATE_SELLQUOTE;    
        if(recordId != null)
            if(templateGroup==BrandQuotesellStr){
                brandQuote = [select id,Receiver_Contact__c,Name from Brand_Quote__c where id=: recordId];
        }else  if(templateGroup==BrandQuoteStr){
            brandQuote = [select id,Receiver_Contact__c,Name from Brand_Quote__c where id=: recordId];
        } 
            
   
        if(selectedEmailTemplatedId != null ){
            emailTemplate = [select id,Email_Subject__c,Email_Body__c from FG_Email_Template__c  where id=: selectedEmailTemplatedId];
            emailBody = processTemplateMerge(emailTemplate.Email_Body__c);
        }
    }
    public void loadInitailSetup(){
        templateOptions = new List<SelectOption>();
                   set<string>Listtempgrp = new set<string>();
        if(String.isNotBlank(templateGroup)){
            Set<SelectOption> optionsSet = new Set<SelectOption>();
      
            for(FG_Template__c t: [SELECT Id,Template_Group__c, Name, Name__c,(SELECT ContentDocumentId, ContentDocument.Title, ContentDocument.ContentSize 
                                                             FROM ContentDocumentLinks) FROM FG_Template__c WHERE Template_Group__c =: templateGroup AND Active__c = true Order by Name__c]){
                                                                  Listtempgrp.add(t.Template_Group__c);
                                                                 if(t.ContentDocumentLinks.size() > 0){
                                                                     optionsSet.add(new SelectOption(t.Id,t.Name__c));    
                                                                 }
                                                             }
            templateOptions.addAll(optionsSet);
           
        }
        if(String.isNotBlank(recordId)){
            Id recId = recordId;
            String objName = recId.getSObjectType().getDescribe().getName();
            String query = 'SELECT Name FROM '+objName+ ' WHERE Id = :recId';
            for(sObject obj: Database.query(query)){
                documentName = (String)obj.get('Name');
                break;
            }
         
        }
        emailTemplateOptions = new List<SelectOption>();
        Set<SelectOption> optionsSet = new Set<SelectOption>();
        for(FG_Email_Template__c t: [SELECT Id, Name, Name__c  FROM FG_Email_Template__c WHERE Active__c = true  AND Template_Group__c=:Listtempgrp order by Name__c]){
            optionsSet.add(new SelectOption(t.Id,t.Name__c));
            if(selectedEmailTemplatedId == null )
                selectedEmailTemplatedId = t.id;
        }
        emailTemplateOptions.addAll(optionsSet);
        
    }
    public PageReference goBack(){
        PageReference pg = new PageReference('/'+recordId);
        pg.setRedirect(true);
        return pg;
    }
    public PageReference goBackToEmail(){
        String pageUrl = '/apex/BrandQuotePDF?id='+recordId+'&QueryId='+queryIdParams+'&TemplateId='+selectedTemplatedId+'&TemplateGroup='+templateGroup;
        PageReference pg = new PageReference(pageUrl);
        pg.setRedirect(true);
        return pg;
    }
    public PageReference redirectBack(){
    	PageReference pg = new PageReference('/'+recordId);
        pg.setRedirect(true);
        return pg;     
    }
    public PageReference redirectToSendEmail(){
        if(templateGroup == BRANDQUOTE_TEMPLATE_SELLQUOTE)
        {
            PageReference pg = new PageReference('/apex/SendEmail?id='+recordId+'&TemplateId='+selectedTemplatedId+'&EmailTemplateId='+selectedEmailTemplatedId+'&QueryId='+queryIdParams+'&docName='+documentName+'&TemplateGroup='+templateGroup+'&isSaveAsAttachment='+details.isSaveAsAttachment+'&isLogActivity='+details.isLogActivity+'&documentName='+documentName);
            pg.setRedirect(true);
            return pg;  
        }else{
            PageReference pg = new PageReference('/apex/SendEmailBuyQuote?id='+recordId+'&TemplateId='+selectedTemplatedId+'&EmailTemplateId='+selectedEmailTemplatedId+'&QueryId='+queryIdParams+'&docName='+documentName+'&TemplateGroup='+templateGroup+'&isSaveAsAttachment='+details.isSaveAsAttachment+'&isLogActivity='+details.isLogActivity+'&documentName='+documentName);
            pg.setRedirect(true);
            return pg;
        }
     
    }
    public void loadTemplate(){
      
        details = FileComposerUtility.getFileData(details,recordId, selectedTemplatedId, queryId, queryParams, line);
        isTemplatedLoaded = true;
      
    }
    public String GoogleDriveAuthUri(String Clientkey,String redirect_uri){
        String key = EncodingUtil.urlEncode(Clientkey,'UTF-8');
        String uri = EncodingUtil.urlEncode(redirect_uri,'UTF-8');
        String authuri = '';
        authuri = googleDrive.Google_Auth_Url__c+'auth?'+
            'client_id='+key+
            '&response_type=code'+
            '&scope='+googleDrive.Google_Auth_Drive_Url__c+
            '&redirect_uri='+uri+
            '&state='+originalparameters+'&'+
            'access_type=offline';
        return authuri;
    }
    
    public void AccessToken(){
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        string endpoint =  googleDrive.Google_Auth_Url__c + 'token';
        req.setEndpoint(endpoint);
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        String messageBody = 'code='+code+'&client_id='+key+'&client_secret='+secret+'&redirect_uri='+redirect_uri+'&grant_type=authorization_code';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
        Http h = new Http();
        String resp;
        if(!test.isRunningTest()){
            HttpResponse res = h.send(req);
            resp = res.getBody();
        }else{
            resp='{"access_token": "ya29.Il-8B0sVpCSVwF3VQ2o--8DMwIjEvwWCwUWfySIL-_lWz21rk2_uibBsuNq1tFDu5ZK4q9bcVanuydYY1M0C7RAo256nefk9SGXtXEbbB_gdN_WNIsNxTmsHJl5lIbyzgQ",';
            resp=resp+'"expires_in": 3599,"scope": "https://www.googleapis.com/auth/drive","token_type": "Bearer"}';
        }
        JSONParser parser = JSON.createParser(resp);
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                String fieldName = parser.getText();
                parser.nextToken();
                if(fieldName == FIELDNAME_ACCESS_TOKEN)
                {
                    accesstoken = parser.getText();
                } 
                else if(fieldName == FIELDNAME_EXPIRES_IN)
                {
                    expiresIn = parser.getIntegerValue();
                  
                }
                else if(fieldname==FIELDNAME_TOKEN_TYPE)
                {
                    tokentype=parser.getText();
                }
                else if(fieldname==FIELDNAME_REFRESH_TOKEN)
                {
                    refreshToken=parser.getText();
                    
                }
            }
        }   
        System.debug('Access Token Response Body' + resp);
    }
    public PageReference doGoogleDriveAuth(){
       
        if(accesstoken!=null && accesstoken!=''){
            loadInitailSetup();
            return null;
        }else{
            if(loginDone==false){
                PageReference pg = new PageReference(GoogleDriveAuthUri (key , redirect_uri)) ;
                return pg ;
            }else{
                AccessToken();
                loadInitailSetup();
                updateRefreshToken(googleDrive.id,refreshToken,accessToken);
                return null;
            }    
        }
    }
    
    public void AccessTokenFromRefreshToken(){
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        string endpoint = googleDrive.Google_Api_Token_Url__c;
        req.setEndpoint(endpoint);
        req.setHeader('content-type', 'application/x-www-form-urlencoded');
        String messageBody = 'client_id='+key+'&client_secret='+secret+'&refresh_token='+refreshToken+'&grant_type=refresh_token';
        req.setHeader('Content-length', String.valueOf(messageBody.length()));
        req.setBody(messageBody);
        req.setTimeout(60*1000);
        Http h = new Http();
        String resp;
        if(!test.isRunningTest()){
            HttpResponse res = h.send(req);
            resp = res.getBody();
        }else{
            resp ='{"access_token": "ya29.ImC8BwrypoQ4NtJ0QKNfFpLAZ-y6XUlXWsi0w-KFed5tljUPXyd87briC_MnKS6ffdvLInGQZHjHZLRuZKZ_GEuIpGeZzXZfJWr9gzOaXZWukCPOc-Crkmd-lLyjwiK-jWA",';
            resp +='"expires_in": 3599, "scope": "https://www.googleapis.com/auth/drive","token_type": "Bearer"}';
        }
        JSONParser parser = JSON.createParser(resp);
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME)){
                String fieldName = parser.getText();
                parser.nextToken();
                if(fieldName == FIELDNAME_ACCESS_TOKEN)
                {
                    accesstoken = parser.getText();
                } 
                else if(fieldName == FIELDNAME_EXPIRES_IN)
                {
                    expiresIn = parser.getIntegerValue();
                }
                else if(fieldname==FIELDNAME_TOKEN_TYPE)
                {
                    tokentype=parser.getText();
                }
            }
        }   
        System.debug('Access Token From Refresh Token Response Body' + resp);
    }
    public String UploadFile(){
         String filename = ' ';
        if(templateGroup == BRANDQUOTE_TEMPLATE_BUYQUOTE)
        {
            filename = BRANDQUOTE_FILENAME_BUYQUOTE;   
        }else{
            filename = BRANDQUOTE_FILENAME_SELLQUOTE;
        }
       
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
        if(googleDrive == null)
        	googleDrive = PDFEngine_Config__c.getOrgDefaults();
        string endpointUrl=googleDrive.File_Upload_Url__c;
        req.setEndpoint(endpointUrl);
        req.setHeader('Authorization', 'Bearer ' +accessToken);
        req.setHeader('Content-Type', 'multipart/mixed; boundary="'+boundary+'"'); 
        req.setHeader('Content-length', String.valueOf(body.length()));
        req.setBody(body);
        req.setMethod('POST');
        req.setTimeout(120000);
        if(!test.isRunningTest()){
            HttpResponse res= http.send(req);
            return res.getBody();
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
            resp = UploadFile();
            Map<String, Object> p = (Map<String, Object>) JSON.deserializeUntyped(resp);
            if(p.containsKey('error')){
                AccessTokenFromRefreshToken();
                updateAccessToken = true;
                resp = UploadFile();
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
            if(updateAccessToken){
                updateRefreshToken(googleDrive.id,refreshToken,accessToken);
            }
    }
    public blob downloadFile(string fileId){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        string endpointUrl=googleDrive.File_Download_Url__c+fileId+'/export?mimeType=application/pdf&alt=media';
        req.setEndpoint(endpointUrl);
        req.setHeader('Authorization', 'Bearer ' +accessToken);
        req.setHeader('Accept', 'application/json'); 
        req.setMethod('GET');
        req.setTimeout(120000);
        resp = blob.valueof('');
        try{
            if(!test.isRunningTest()){
                HttpResponse res= http.send(req);
                resp = res.getBodyAsBlob();
            }else{
                resp = blob.valueOf('testing body');
            }
           
            if(fromDownload && details.isSaveAsAttachment){
                
                Blob base64Response = 	resp;
                ContentVersion conVer = new ContentVersion();
                conVer.ContentLocation = 'S'; // S specify this document is in SF, use E for external files
                conVer.PathOnClient = documentName+'.pdf'; // The files name, extension is very important here which will help the file in preview.
                conVer.Title =documentName; // Display name of the files
                conVer.VersionData = base64Response; // converting your binary string to Blob
                insert conVer;
                
                // First get the content document Id from ContentVersion
                Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
                
                //Create ContentDocumentLink
                ContentDocumentLink cDe = new ContentDocumentLink();
                cDe.ContentDocumentId = conDoc;
                cDe.LinkedEntityId =recordId; // you can use objectId,GroupId etc
                cDe.ShareType = 'I'; // Inferred permission, checkout description of ContentDocumentLink object for more details
                cDe.Visibility = 'InternalUsers';
                insert cDe;
                
             
            }
            if(fromDownload && details.isLogActivity){
                Task tsk = new Task();
                tsk.Whatid = recordId;
                tsk.Subject = 'Downloaded Sell Quote '+documentName;
                tsk.ActivityDate = system.today();
                insert tsk;
            }
            details.templateBodyPDF = 'data:application/pdf;base64,'+EncodingUtil.Base64Encode(resp);
            isTemplatedLoaded = false;
            deleteFile(fileId,accessToken);
        }catch(Exception e){
            System.debug('Exception:'+e.getMessage());
        }
        return resp;
    }
    @future(callout=true)
    public static void deleteFile(string fileId,String accessToken){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        if(googleDrive == null)
        	googleDrive = PDFEngine_Config__c.getOrgDefaults();
        string endpointUrl=googleDrive.File_Download_Url__c+fileId;
        req.setEndpoint(endpointUrl);
        req.setHeader('Authorization', 'Bearer ' +accessToken);
        req.setHeader('Accept', 'application/json; charset=UTF-8');
        req.setMethod('DELETE');
        req.setTimeout(120000);
        string resp;
        if(!test.isRunningTest()){
            HttpResponse res= http.send(req);
            resp = res.getBody();
            //isTemplatedLoaded = false;
        }
        system.debug('Delete File Response Body : '+resp);
    }
    public String processTemplateMerge(String htmlBody){
        String JSONData = FileComposerUtility.prepareFileData(recordId,queryId,queryParams,line);
        Map<String,Object> fieldAndValueMap = (Map<String,Object>) JSON.deserializeUntyped(JSONData);
        Set<String>mergeFieldSet = fieldAndValueMap.keySet();
        
        String[] htmlbodyTRWise = htmlBody.split('<tr>');
        String mergedHTMLBody = '';
        for(String row:htmlbodyTRWise){
            String mergedRow = '';
            pattern p = Pattern.compile('\\{\\{TableStart:'+line+'\\}\\}');
            Matcher m = p.matcher(row);
            if(m.find()){
                String lastColRemailingHTML = '';
                String[] columns = row.split('<td');
                Map<Integer,String> colsMap = new Map<Integer,String>();
                Integer i = 0;
                for(String col: columns){
                    if(String.isBlank(col)) continue;
                    col = col.replace('{{TableStart:'+line+'}}', '');
                    
                    //Check for TableEnd
                    if(col.indexOf('{{TableEnd:'+line+'}}') >= 0){
                        String[] cols = col.split('</tr>');
                        String lastCol = cols[0];
                        col = lastCol.replace('{{TableEnd:'+line+'}}', '');
                        lastColRemailingHTML = cols[1];
                    }
                    
                    colsMap.put(i++,col);
                }
                
                String linesHTML = '';
                if(String.isNotBlank(line)){
                    List<Object> lineList = (List<Object>)fieldAndValueMap.get(line);
                    List<List<String>> finalLineRecords = new List<List<String>>();
                    for(Object lineObj:lineList){
                        List<String> childRowMerged = new List<String>();
                        Map<String,Object> childFieldMap = (Map<String,Object>)lineObj;
                        for(Integer ind : colsMap.keySet()){
                            String col = colsMap.get(ind);
                            pattern pc = Pattern.compile('\\{\\{[a-zA-Z0-9_\\s\\.]*\\}\\}');
                            Matcher mc = pc.matcher(col);
                            if(mc.find()){
                                String childField = col.substring(mc.start()+2,mc.end()-2);
                                String childCol = '<td'+col;
                                childCol = childCol.replace('{{' +childField + '}}', (childFieldMap.get(childField) != null?String.valueOf(childFieldMap.get(childField)):'')).trim();
                                childRowMerged.add(childCol);
                            }
                        }
                        finalLineRecords.add(childRowMerged);
                    }
                    
                    for(List<String> crow: finalLineRecords){
                        linesHTML += '<tr>';
                        for(String cf: crow){
                            linesHTML += cf;
                        }
                        linesHTML += '</tr>';
                    }
                }
                linesHTML += lastColRemailingHTML;
                mergedHTMLBody += '<tr>'+linesHTML;
            }else{
                mergedHTMLBody += '<tr>'+row;
            }
        }
        htmlBody = mergedHTMLBody;
        for(String fieldName: fieldAndValueMap.keySet()){
            if(String.isNotBlank(fieldName) && fieldAndValueMap.get(fieldName) != null){
                htmlBody = htmlBody.replace('{{' +fieldName + '}}', (fieldAndValueMap.get(fieldName) != null?String.valueOf(fieldAndValueMap.get(fieldName)):'')).trim();
            }
        }
        return htmlBody;
    }
    public void sendEmail(){  
        FileDetails[] aFiles;
        
        String replaceString = 'data:application/pdf;base64,';
        bodyStr = bodyStr.replace(replaceString,'');
        Blob attBody = EncodingUtil.base64Decode(bodyStr);
        
        if(isSaveAsAttachment){
            
                ContentVersion conVer = new ContentVersion();
                conVer.ContentLocation = 'S'; // S specify this document is in SF, use E for external files
                conVer.PathOnClient = documentName+'.pdf'; // The files name, extension is very important here which will help the file in preview.
                conVer.Title =documentName; // Display name of the files
                conVer.VersionData = attBody; // converting your binary string to Blob
                insert conVer;
                
                // First get the content document Id from ContentVersion
                Id conDoc = [SELECT ContentDocumentId FROM ContentVersion WHERE Id =:conVer.Id].ContentDocumentId;
                
                //Create ContentDocumentLink
                ContentDocumentLink cDe = new ContentDocumentLink();
                cDe.ContentDocumentId = conDoc;
                cDe.LinkedEntityId =recordId; // you can use objectId,GroupId etc
                cDe.ShareType = 'I'; // Inferred permission, checkout description of ContentDocumentLink object for more details
                cDe.Visibility = 'InternalUsers';
                insert cDe;
         
            
        }
      
        list<Contact> conList  = new list<contact>();
        if(brandQuote.Receiver_Contact__c != null)
            conList = [select id,email from contact where id=: brandQuote.Receiver_Contact__c];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
        list<string>toAddList =new list<string>();
        if(additionalAdd != null && additionalAdd!='null' && additionalAdd.trim() !=''){
            toAddList.addAll(additionalAdd.split(','));
        }
        if(conList.size()>0 && conList[0].email != null)
            toAddList.add(conList[0].email);
        if(toAddList.size() > 0){
            mail.setToAddresses(toAddList);
            if(ccAdd != null && ccAdd!='null' && ccAdd.trim() !=''){
                list<string>ccAddList = ccAdd.trim().split(',');
                if(ccAddList.size() > 0)
                    mail.setCcAddresses(ccAddList);
            }
           
            mail.setSubject(emailTemplate.Email_Subject__c);
            mail.setHtmlBody(emailBody);
            list<Messaging.EmailFileAttachment>emailAttList = new List<Messaging.EmailFileAttachment>();
            Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
            
            if(!defaultAttRemoved){
                efa.setFileName(docName+'.pdf');
                efa.setBody(attBody);
                efa.setContentType('application/pdf');  
                emailAttList.add(efa);
            }
            if(additionalFiles != '[]'){
                aFiles = (FileDetails[]) JSON.deserialize(additionalFiles, List<FileDetails>.class);
                if(aFiles != null && aFiles.size() > 0){
                    for(FileDetails fd: aFiles){
                        replaceString = 'data:'+fd.filetype+';base64,';
                        fd.file = fd.file.replace(replaceString,'');
                        efa = new Messaging.EmailFileAttachment();
                        efa.setFileName(fd.filename);                        
                        efa.setBody(EncodingUtil.base64Decode(fd.file));
                        efa.setContentType(fd.filetype);   
                        emailAttList.add(efa);
                    }
                }
            }
            mail.setWhatId(recordId);
            mail.setFileAttachments(emailAttList);
            mail.setSaveAsActivity(isLogActivity);
            mails.add(mail);
            additionalFiles = '';
            Messaging.sendEmail(mails); 
            
        }
        bodyStr = '';
    }
    public void loadEmail(){
        EmailWrapperList = new list<EmailWrapperClass>();
        if(searchText != null && searchText != ''){
            Search.SearchResults searchResults = Search.find('FIND \''+searchText+'\' IN ALL FIELDS RETURNING Contact(Name,Email,Account.Name WHERE Active__c = true AND Email != null),Lead(Name,Email),User(Name,Email WHERE IsActive = true AND Email != null)');
            List<Search.SearchResult> contactList = searchResults.get('Contact');
            List<Search.SearchResult> leadList = searchResults.get('Lead');
            List<Search.SearchResult> userList = searchResults.get('User');
            if(contacts){	
                for (Search.SearchResult searchResult : contactList) { 
                    Contact con = (Contact) searchResult.getSObject(); 
                    EmailWrapperClass emlObj = new EmailWrapperClass(con.id,con.Name,'Contact',con.Email,con.Account.Name);
                    EmailWrapperList.add(emlObj);
                }            
            }
        
            if(users){
                for (Search.SearchResult searchResult : userList) { 
                    User usr = (User) searchResult.getSObject(); 
                    EmailWrapperClass emlObj = new EmailWrapperClass(usr.id,usr.Name,'User',usr.Email,'');
                    EmailWrapperList.add(emlObj);
                }    
            }
        }
    }
    
    public class FileDetails{
        public String filename;
        public String filetype;
        public String file;
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