public class DropboxUploadController {
	
    public static String errorMsgFinish = '';
    
    private String apiKey;
    private String apiSecret;
    private String redirectURI;
    private String Dropbox_Account_endpoint;
    private String Dropbox_OAuth_authorize;
    private String Dropbox_OAuth_token;
    private String get_current_account;
    private String authorizationCode;
    private String refreshToken;
    
    public String code { get; set; }
    public String username { get; set; }
    public Boolean success { get; set; }
    public Boolean connected { get; set; }
    
    public DropboxUploadController() {
        connected = false;
        
        List<DropBox_Access__c> lstDropBox = new List<DropBox_Access__c>([SELECT Id,Name,Secret_Key__c,Get_Current_Account__c,Dropbox_OAuth_token__c,Dropbox_Account_Endpoint__c,
                                                                         Api_Key__c,Redirect_URI__c,Dropbox_OAuth_authorize__c
                                                                         FROM DropBox_Access__c WHERE Name =: 'Dropbox']);
        
        if(lstDropBox.size() > 0){
            DropBox_Access__c dropbox = lstDropBox[0];
            if(dropbox.Api_Key__c != null) apiKey = dropbox.Api_Key__c;
            if(dropbox.Secret_Key__c != null) apiSecret = dropbox.Secret_Key__c;
            if(dropbox.Redirect_URI__c != null) redirectURI = dropbox.Redirect_URI__c;
            if(dropbox.Dropbox_Account_Endpoint__c != null) Dropbox_Account_endpoint = dropbox.Dropbox_Account_Endpoint__c;
            if(dropbox.Dropbox_OAuth_authorize__c != null) Dropbox_OAuth_authorize = dropbox.Dropbox_OAuth_authorize__c;
            if(dropbox.Dropbox_OAuth_token__c != null) Dropbox_OAuth_token = dropbox.Dropbox_OAuth_token__c;
            if(dropbox.Get_Current_Account__c != null) get_current_account = dropbox.Get_Current_Account__c;
        }
        
        code = apexpages.currentpage().getparameters().get('code');
        System.debug('code = '+code);
        if(code != null) {
            connected = true;
            authorizationCode = code;
            refreshToken = '';
            getRefreshToken();
            retrieveUserInfo();
        }
    }
    
    public PageReference getAuthorizationCode() {
        String uri = Dropbox_OAuth_authorize +
                     '?client_id=' + apiKey +
                     '&response_type=code' +
                     '&redirect_uri=' + redirectURI;
        System.debug(uri);
        PageReference pr = new PageReference(uri);
        pr.setRedirect(false);
        System.debug(uri);
        return pr;
    }
    
    private void getRefreshToken() {
        if(authorizationCode != null) {
            try {
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                 
                req.setEndpoint(Dropbox_OAuth_token);  
                string bodyRequest = '';
                bodyRequest = 'code=' + EncodingUtil.urlEncode(authorizationCode, 'UTF-8');
                bodyRequest+= '&client_id=' + EncodingUtil.urlEncode(apiKey, 'UTF-8');
                bodyRequest+= '&client_secret=' + EncodingUtil.urlEncode(apiSecret, 'UTF-8');
                bodyRequest+= '&redirect_uri=' + EncodingUtil.urlEncode(redirectURI, 'UTF-8');
                bodyRequest+= '&grant_type=authorization_code';
                
                req.setBody(bodyRequest);    
                req.setHeader('Content-length', string.ValueOf(bodyRequest.length()));
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                req.setMethod('POST');
                req.setTimeout(60*1000);
                System.debug(req.getBody());
                HttpResponse res = h.send(req);  
                System.debug(res.getBody());
                map<string, string> jsonValues = new map<string, string>();
                jsonValues = parseJSONToMap(res.getBody());
                System.debug(jsonValues);
                if(jsonValues.containsKey('error')) {
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Couldn\'t connect to Dropbox.'));
                }
                else {
                    refreshToken = jsonValues.get('access_token');
                }
            }
            catch(Exception e) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Couldn\'t connect to Dropbox.'));
            }
        }
        else 
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Couldn\'t connect to Dropbox.'));
    }
    
    
    // method that returns the username of the connected dropbox account
    private void retrieveUserInfo() {
        if(refreshToken != null) {
            try {
                Http h = new Http();
                HttpRequest req = new HttpRequest(); 
                req.setEndpoint(get_current_account);
                req.setHeader('Authorization', 'Bearer '+refreshToken);
                //req.setHeader('Content-Type', 'application/json; charset=UTF-8');
                //req.setHeader('Accept','application/json');
                req.setMethod('POST');
                req.setTimeout(60*1000);
                
                HttpResponse res = h.send(req);
                map<string, string> jsonValues = new map<string, string>();
                jsonValues = parseJSONToMap(res.getBody());
                System.debug('res.getBody() = '+res.getBody());
                if(jsonValues.containsKey('error')){
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Couldn\'t connect to Dropbox.'));
                }
                else {
                    username = jsonValues.get('email');
                }
            }
            catch(Exception e) {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Couldn\'t connect to Dropbox.'));
            }
        }
        else
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Couldn\'t connect to Dropbox.'));
    }
    
    private map<string, string> parseJSONToMap(string JSONValue){
        JSONParser parser = JSON.createParser(JSONValue);
        map<string, string> jsonMap = new map<string, string>();
        string keyValue = '';
        string tempValue = '';
        while (parser.nextToken() != null) {
            if(parser.getCurrentToken() == JSONToken.FIELD_NAME){
                keyValue = parser.getText();
                parser.nextToken();
                tempValue = parser.getText();
                jsonMap.put(keyValue, tempValue);            
            }
        }
        return jsonMap;
    }
    
    @AuraEnabled
    public static AuraResponse getProduct(String recordId) {
        AuraResponse r = new AuraResponse('DropboxUploadController.getProduct()');
        Product2 product = [SELECT Id,Name,Producer_Name__r.Name,Brand_Name__c FROM Product2 WHERE Id =: recordId LIMIT 1];
        r.data.put('product',product);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse getAccount(String recordId) {
        AuraResponse r = new AuraResponse('DropboxUploadController.getAccount()');
        Account acc = [SELECT Id,Name FROM Account WHERE Id =: recordId LIMIT 1];
        r.data.put('accountRec',acc);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse checkFile(String fileName, String folderName, Boolean isAcc) {
        AuraResponse r = new AuraResponse('DropboxUploadController.checkFile()');
        List<DropBox_Access__c> lstDropBox = new List<DropBox_Access__c>([SELECT Id,Name,Access_Token__c,
                                                                          Api_Key__c,Logo_Path__c,Product_Photo_Path__c,Get_Metadata_Endpoint__c
                                                                          FROM DropBox_Access__c WHERE Name =: 'Dropbox']);
        
        Boolean fileExist = false;
        String errorMsg = '';
        if(lstDropBox.size() > 0){
            DropBox_Access__c dropbox = lstDropBox[0];
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            String endpoint = dropbox.Get_Metadata_Endpoint__c;
            req.setEndpoint(endpoint);
            req.setHeader('Authorization', 'Bearer '+dropbox.Access_Token__c);
            req.setHeader('Content-Type', 'application/json');
            String body = '';
            if(isAcc){
                body = '{"path":"/'+dropbox.Logo_Path__c +'/'+ fileName+'","include_deleted": false,"include_media_info": false,"include_has_explicit_shared_members": false}';
            } else {
                body = '{"path":"/'+dropbox.Product_Photo_Path__c + '/'+folderName+'/'+fileName+'","include_deleted": false,"include_media_info": false,"include_has_explicit_shared_members": false}';
            }
            System.debug('Request is'+body);
            req.setBody(body);
            req.setMethod('POST');
            req.setTimeout(60*1000);
            HttpResponse resp = http.send(req);
            ///jsonValues = parseJSONToMap(resp.getBody());
            System.debug(resp.getBody());
            JSONParser parser = JSON.createParser(resp.getBody());
            
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'name')){
                    parser.nextToken(); // object start
                    fileExist = true;
                } else if((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'error_summary')){
                    parser.nextToken();
                    System.debug(parser.getText());
                }
            }
        }
        r.data.put('isFileExist',fileExist);
        r.data.put('errorMsg',errorMsg);
        return r;
    }
    
    
    @AuraEnabled
    public static AuraResponse getSessionId(String base64Data){
        AuraResponse r = new AuraResponse('DropboxUploadController.getSessionId()');
        List<DropBox_Access__c> lstDropBox = new List<DropBox_Access__c>([SELECT Id,Name,Access_Token__c,
                                                                         Api_Key__c,Upload_Session_Endpoint__c
                                                                         FROM DropBox_Access__c WHERE Name =: 'Dropbox']);
        
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        System.debug('base64Data = '+base64Data.length());
        //String bodyEncoded = EncodingUtil.base64Encode(base64Data);
        Blob bodyEncoded2 = EncodingUtil.base64Decode(base64Data);
        System.debug('bodyEncoded2 = '+bodyEncoded2.size());
        
        DropBox_Access__c dropbox = lstDropBox[0];
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        String endpoint = dropbox.Upload_Session_Endpoint__c;
        req.setEndpoint(endpoint);
        req.setHeader('Authorization', 'Bearer '+dropbox.Access_Token__c);
		req.setHeader('Dropbox-API-Arg', '{"close": false}');    
        req.setHeader('Content-Type', 'application/octet-stream');
        req.setBodyAsBlob(bodyEncoded2);
        req.setMethod('POST');
        req.setTimeout(60*1000);
        System.debug('Request is'+req);
        HttpResponse resp = http.send(req);
        System.debug(resp.getBody());
        JSONParser parser = JSON.createParser(resp.getBody());
        
        String session_id = '';
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'session_id')){
                parser.nextToken(); // object start
                session_id = parser.getText();
            }
        }
        r.data.put('session_id',session_id);
        r.data.put('chunkSize',bodyEncoded2.size());
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse appendFile(String base64Data, String sessionId,Integer cnt){
        AuraResponse r = new AuraResponse('DropboxUploadController.appendFile()');
        List<DropBox_Access__c> lstDropBox = new List<DropBox_Access__c>([SELECT Id,Name,Access_Token__c,
                                                                         Api_Key__c,Upload_Session_Append_Endpoint__c 
                                                                         FROM DropBox_Access__c WHERE Name =: 'Dropbox']);
        
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        System.debug('base64Data = '+base64Data.length());
        //String bodyEncoded = EncodingUtil.base64Encode(base64Data);
        Blob bodyEncoded2 = EncodingUtil.base64Decode(base64Data);
        System.debug('bodyEncoded2 = '+bodyEncoded2.size());
        DropBox_Access__c dropbox = lstDropBox[0];
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        String endpoint = dropbox.Upload_Session_Append_Endpoint__c;
        req.setEndpoint(endpoint);
        req.setHeader('Authorization', 'Bearer '+dropbox.Access_Token__c);
        req.setHeader('Dropbox-API-Arg', '{"cursor": {"session_id":"'+ sessionId + '","offset":'+ (cnt * 2625000)+'},"close": false}');    
        req.setHeader('Content-Type', 'application/octet-stream');
        req.setBodyAsBlob(bodyEncoded2);
        req.setMethod('POST');
        req.setTimeout(60*1000);
        System.debug('Request is'+req);
        HttpResponse resp = http.send(req);
        System.debug(resp.getBody());
        r.data.put('chunkSize',2625000);
        return r;
    }
    
    
    @AuraEnabled
    public static AuraResponse saveChunk(String recordId,String fileName,String base64Data, String folderName, Boolean isAcc, String sessionId,Integer offset) {
        AuraResponse r = new AuraResponse('DropboxUploadController.appendFile()');
        saveTheFile(fileName, folderName,recordId,isAcc,sessionId,base64Data,offset);
        System.debug('errorMsgFinish = '+errorMsgFinish);
        r.data.put('errorMsg',errorMsgFinish);
        return r;
    }
    
    //@future(callout = true)
    public static void saveTheFile(String fileName, String folderName,String recordId, Boolean isAcc, String sessionId,String base64Data,Integer offset) {
        
        List<DropBox_Access__c> lstDropBox = new List<DropBox_Access__c>([SELECT Id,Name,Access_Token__c,
                                                                         Api_Key__c,Upload_Session_Finish__c,Logo_Path__c,Product_Photo_Path__c,
                                                                         Create_Shared_Link_Endpoint__c
                                                                         FROM DropBox_Access__c WHERE Name =: 'Dropbox']);
        if(lstDropBox.size() > 0){
            DropBox_Access__c dropbox = lstDropBox[0];
            
            base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
            
            //String bodyEncoded = EncodingUtil.base64Encode(base64Data);
            Blob bodyEncoded2 = EncodingUtil.base64Decode(base64Data);
            System.debug('SIZE = '+bodyEncoded2.size());
            System.debug('offset = '+offset);
            
            offset += bodyEncoded2.size();
            
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            String endpoint = dropbox.Upload_Session_Finish__c;
            req.setEndpoint(endpoint);
            req.setHeader('Authorization', 'Bearer '+dropbox.Access_Token__c);
            System.debug('PATH = '+fileName);
            if(isAcc){
                req.setHeader('Dropbox-API-Arg', '{"cursor": {"session_id":"'+sessionId+'","offset":'+offset+'},"commit":{"path": "/'+dropbox.Logo_Path__c +'/'+ fileName+'\","mode": "overwrite","autorename": false,"mute": false,"strict_conflict": false}}');    
            } else {
                req.setHeader('Dropbox-API-Arg', '{"cursor": {"session_id":"'+sessionId+'","offset":'+offset+'},"commit":{"path": "/'+dropbox.Product_Photo_Path__c +'/'+folderName+'/'+fileName+'\","mode": "overwrite","autorename": false,"mute": false,"strict_conflict": false}}');
            }
            req.setHeader('Content-Type', 'application/octet-stream');
            /*req.setHeader('Content-length', String.valueOf(bodyEncoded.length()));*/
            req.setBodyAsBlob(bodyEncoded2);
            req.setMethod('POST');
            req.setTimeout(60*1000);
            System.debug('Request is'+req);
            HttpResponse resp = http.send(req);
            ///jsonValues = parseJSONToMap(resp.getBody());
            System.debug(resp.getBody());
            
            JSONParser parser = JSON.createParser(resp.getBody());
            String imagePath = '';
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'path_display')){
                    parser.nextToken(); // object start
                    System.debug(parser.getText());
                    imagePath = parser.getText();
                } else if((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'error_summary')){
                    parser.nextToken();
                    System.debug(parser.getText());
                    errorMsgFinish = parser.getText();
                }
            }
            if(imagePath != '') createPublicURL(imagePath,dropbox,recordId,isAcc);
        }
    }
    
    public static void createPublicURL(String imageURL,DropBox_Access__c dropbox,String recordId,Boolean isAcc){
        System.debug('imageURL is'+imageURL);
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        String endpoint = dropbox.Create_Shared_Link_Endpoint__c;
        req.setEndpoint(endpoint);
        req.setHeader('Authorization', 'Bearer '+dropbox.Access_Token__c);
        String body = '{"path":"'+imageURL+'\","short_url": false}';
        req.setBody(body);
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('POST');
        req.setTimeout(60*1000);
        HttpResponse resp = http.send(req);
        System.debug('PATH = '+resp.getBody());
        JSONParser parser = JSON.createParser(resp.getBody());
        String publicURL = '';
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == 'url')){
                parser.nextToken(); // object start
                System.debug(parser.getText());
                publicURL = parser.getText();
            }
        }
        
        if(isAcc){
            Account acc = [SELECT Id,Name,Image_URL__c FROM Account WHERE Id =: recordId LIMIT 1];
            if(publicURL != ''){
                acc.Image_URL__c = publicURL.substring(0,publicURL.length()-4) + 'raw=1';
                update acc;
            }
        } else {
            Product2 product = [SELECT Id,Name,Image_URL__c FROM Product2 WHERE Id =: recordId LIMIT 1];
            if(publicURL != ''){
                product.Image_URL__c = publicURL.substring(0,publicURL.length()-4) + 'raw=1';
                update product;
            }
        }
    }
}