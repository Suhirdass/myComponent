public class StateLicense_HttpCalloutHelper {
    public static Map<String,String> integrationEndpointsMap = new Map<String,String>();
    public static boolean IS_STATELICENSETOTALMILES_TRIGGER_ENABLED = true;
    public static boolean isTestClass = false;
    public Static String ERR_MSG_STATE_LICENSE_NOT_MATCH{
        get{
            return String.isNotBlank(ERR_MSG_STATE_LICENSE_NOT_MATCH) ? ERR_MSG_STATE_LICENSE_NOT_MATCH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','Err_Msg_State_License_Not_Match');
        }set;
    }
    public Static String STATE_LICENSE_STATUS_CANCELLED{
        get{
            return String.isNotBlank(STATE_LICENSE_STATUS_CANCELLED) ? STATE_LICENSE_STATUS_CANCELLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_Status_Cancelled');
        }set;
    }
    public Static String STATE_LICENSE_STATUS_CANCELED{
        get{
            return String.isNotBlank(STATE_LICENSE_STATUS_CANCELED) ? STATE_LICENSE_STATUS_CANCELED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_Status_Canceled');
        }set;
    }
    public Static String STATE_LICENSE_ADULT_USE_YES{
        get{
            return String.isNotBlank(STATE_LICENSE_ADULT_USE_YES) ? STATE_LICENSE_ADULT_USE_YES : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_Adult_Use_Yes');
        }set;
    }
    
    public static Map<String,String>  getStateLicenseIntegrationEndpoints(){
        
        if(integrationEndpointsMap.size()>0) return integrationEndpointsMap;
        else{
            List<StateLicense_IntegrationEndpoints__mdt> integrationEndpoints = [select id,MasterLabel,URL__c from StateLicense_IntegrationEndpoints__mdt];
            
            for(StateLicense_IntegrationEndpoints__mdt var : integrationEndpoints){
                integrationEndpointsMap.put(var.MasterLabel,var.URL__c);
            }
            integrationEndpointsMap.put('baseURL',State_License_Settings__c.getValues('StateLicense_EndPoint').Value__c);
            return integrationEndpointsMap;
        }   
    }
    public static String allIdStateLicense_RequestJSON(list<State_Licenses__c> objectlist)
    {   
        String requestjson ='';
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartArray();
        for(State_Licenses__c st: objectlist)
        {
            gen.writeStartObject();	
            gen.writeStringField('licenseNumber',st.License_Number__c);
            gen.writeEndObject();
            
        }
        /*gen.writeStartObject();	
gen.writeStringField('licenseNumber','C10-0000005-LIC');
gen.writeEndObject();*/
        gen.writeEndArray();
        requestjson = gen.getAsString();
        return requestjson;
        
    }
    
    
    /* public static String searchStateLicense_RequestJSON(String licenseNumber)
{   
String requestjson ='';
JSONGenerator gen = JSON.createGenerator(true);
gen.writeStartArray();
gen.writeStartObject();	
gen.writeStringField('licenseNumber',licenseNumber);
gen.writeEndObject();
gen.writeEndArray();
requestjson = gen.getAsString();
return requestjson;

}*/
    
    public static String getAllLicenseByNumber(list<State_Licenses__c> objectlist)
    {   
        String endPointURL='';
        String requestPayload='';
        List<Object> responseList = new List<Object>();
        List<State_Licenses__c> updateList = new List<State_Licenses__c>();
        List<String> errors = new List<String>();
        Map<String,String> endPointMap=getStateLicenseIntegrationEndpoints();
        endPointURL= endPointMap.get('baseURL')+endPointMap.get('getAllLicenseByNumber');
        requestPayload = allIdStateLicense_RequestJSON(objectlist);
        String licenseError = String.format(ERR_MSG_STATE_LICENSE_NOT_MATCH,new List<String>{String.valueOf(objectlist[0].License_Number__c)});
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPointURL);
        req.setMethod('POST');
        String APP_ID = State_License_Settings__c.getValues('StateLicense_APP_ID').Value__c;
        String APP_KEY = State_License_Settings__c.getValues('StateLicense_APP_KEY').Value__c; 
        req.setHeader('content-type','application/Json');
        req.setHeader('APP_ID', APP_ID);
        req.setHeader('APP_KEY', APP_KEY);
        req.setBody(requestPayload);
        
        
        // Send the request, and return a response
        HttpResponse res = http.send(req);
        String response = res.getBody();
        if(res.getstatuscode() == 200){
            responseList = (List<Object>) JSON.deserializeUntyped(res.getBody());
            if(responseList.size()>0){ 
                for(State_Licenses__c  statelicense: objectlist){
                    for(Object  obj:responseList){
                        Map<String,Object> respMap= (Map<String,Object>)obj;
                        if((String)respMap.get('licenseNumber')==statelicense.License_Number__c || isTestClass ==true){
                            State_Licenses__c stList = new State_Licenses__c();
                            stList.Id = statelicense.ID;
                            stList.Business_Owner__c = (String)respMap.get('businessOwner');
                            if((String)respMap.get('businessStructure')=='null' ||(String)respMap.get('businessStructure')=='undefined' || isTestClass ==true){
                                stList.Business_Structure__c = '';
                            }else{
                                stList.Business_Structure__c = (String)respMap.get('businessStructure'); 
                            }
                            stList.bccLicenseType__c = (String)respMap.get('licenseType');
                            if((String)respMap.get('licenseStatus') ==STATE_LICENSE_STATUS_CANCELED){
                                stList.License_Status__c = STATE_LICENSE_STATUS_CANCELLED;
                            }else{
                                stList.License_Status__c = (String)respMap.get('licenseStatus');
                            }
                            stList.Phone__c = (String)respMap.get('phone');
                            stList.Website__c = (String)respMap.get('website');
                            String convertData = toTitleCase((String)respMap.get('premiseCity'));
                            stList.Premise_City__c= convertData;
                            stList.Premise_State__c= (String)respMap.get('premiseState');
                            stList.Premise_Address__c =(String)respMap.get('addressLine1');
                            stList.Premise_Zip__c = (String)respMap.get('premiseZip');
                            if((String)respMap.get('expiryDate')!=null){
                                string stringDate = (String)respMap.get('expiryDate');
                                stList.License_Expiration_Date__c = getDate(stringDate); 
                            }
                            if((String)respMap.get('issuedDate')!=null){
                                string stringDate = (String)respMap.get('issuedDate');
                                stList.Issued_Date__c = getDate(stringDate); 
                            }
                            if((String)respMap.get('adultUse')==STATE_LICENSE_ADULT_USE_YES){
                                stList.Adult_Use__c = TRUE;   
                            }else{
                                stList.Adult_Use__c = FALSE; 
                            }
                            if((String)respMap.get('medicinal')==STATE_LICENSE_ADULT_USE_YES){
                                stList.Medicinal__c = TRUE;   
                            }else{
                                stList.Medicinal__c = FALSE; 
                            }
                            updateList.add(stList); 
                        }
                        
                    } 
                }
                IS_STATELICENSETOTALMILES_TRIGGER_ENABLED = FALSE;
                Database.update(updateList,true);
                return 'SUCCESS';   
            }
            else{
                return licenseError;
            }
        }
        return '';
        
    }
    
    public static Date getDate(String stringDate){
        List<String> arrayDate = stringDate.split('/');
        String newDateFormat = arrayDate[2]+'-'+arrayDate[0]+'-'+arrayDate[1];
        Date convertDate = Date.valueOf(string.valueof(newDateFormat));
        return convertDate;
    }
    
    @future(callout=true)
    public static void getAllLicenseByNumberBatch()
    {   
        String endPointURL='';
        String requestPayload='';
        List<State_Licenses__c>  objectlist = [select License_Number__c from State_Licenses__c where License_Expiration_Date__c>= today and License_Expiration_Date__c<=Next_N_Days:7];
        List<Object> responseList = new List<Object>();
        List<State_Licenses__c> updateList = new List<State_Licenses__c>();
        Map<String,String> endPointMap=getStateLicenseIntegrationEndpoints();
        endPointURL= endPointMap.get('baseURL')+endPointMap.get('getAllLicenseByNumber');
        requestPayload = allIdStateLicense_RequestJSON(objectlist);
        
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPointURL);
        req.setMethod('POST');
        String APP_ID = State_License_Settings__c.getValues('StateLicense_APP_ID').Value__c;
        String APP_KEY = State_License_Settings__c.getValues('StateLicense_APP_KEY').Value__c; 
        req.setHeader('content-type','application/Json');
        req.setHeader('APP_ID', APP_ID);
        req.setHeader('APP_KEY', APP_KEY);
        req.setBody(requestPayload);
        
        
        // Send the request, and return a response
        HttpResponse res = http.send(req);
        String response = res.getBody();
        if(res.getstatuscode() == 200){   
            responseList = (List<Object>) JSON.deserializeUntyped(res.getBody());
            for(State_Licenses__c  statelicense: objectlist){
                for(Object  obj:responseList){
                    Map<String,Object> respMap= (Map<String,Object>)obj;
                    if((String)respMap.get('licenseNumber')==statelicense.License_Number__c){
                        State_Licenses__c stList = new State_Licenses__c();
                        stList.Id = statelicense.ID;
                        stList.Business_Owner__c = (String)respMap.get('businessOwner');
                        if((String)respMap.get('businessStructure')=='null' ||(String)respMap.get('businessStructure')=='undefined'){
                            stList.Business_Structure__c = '';
                        }else{
                            stList.Business_Structure__c = (String)respMap.get('businessStructure'); 
                        }
                        
                        stList.bccLicenseType__c = (String)respMap.get('licenseType');
                        
                        if((String)respMap.get('licenseStatus') ==STATE_LICENSE_STATUS_CANCELED){
                            stList.License_Status__c = STATE_LICENSE_STATUS_CANCELLED;
                        }else{
                            stList.License_Status__c = (String)respMap.get('licenseStatus');
                        }
                        
                        stList.Phone__c = (String)respMap.get('phone');
                        stList.Website__c = (String)respMap.get('website');
                        String convertData = toTitleCase((String)respMap.get('premiseCity'));
                        stList.Premise_City__c= convertData;
                        stList.Premise_State__c= (String)respMap.get('premiseState');
                        stList.Premise_Address__c =(String)respMap.get('addressLine1');
                        stList.Premise_Zip__c = (String)respMap.get('premiseZip');
                        if((String)respMap.get('expiryDate')!=null){
                            string stringDate = (String)respMap.get('expiryDate');
                            stList.License_Expiration_Date__c = getDate(stringDate); 
                        }
                        if((String)respMap.get('issuedDate')!=null){
                            string stringDate = (String)respMap.get('issuedDate');
                            stList.Issued_Date__c = getDate(stringDate); 
                        }
                        if((String)respMap.get('adultUse')==STATE_LICENSE_ADULT_USE_YES){
                            stList.Adult_Use__c = TRUE;   
                        }else{
                            stList.Adult_Use__c = FALSE; 
                        }
                        if((String)respMap.get('medicinal')==STATE_LICENSE_ADULT_USE_YES){
                            stList.Medicinal__c = TRUE;   
                        }else{
                            stList.Medicinal__c = FALSE; 
                        }
                        updateList.add(stList); 
                    }
                    
                } 
            }
            IS_STATELICENSETOTALMILES_TRIGGER_ENABLED = FALSE;
            Database.update(updateList,true);
            
        }else{
            
        }
        
    }
    
    /*  public static List<Object> getAllBccLicenses(){

String endPointURL='';
String requestPayload='';

Transient List<Object> responseList = new List<Object>();
//List<State_Licenses__c>  objectlist = [select License_Number__c from State_Licenses__c where License_Expiration_Date__c>= today and License_Expiration_Date__c<=Next_N_Days:7];
Map<String,String> endPointMap=getStateLicenseIntegrationEndpoints();
endPointURL= endPointMap.get('baseURL')+endPointMap.get('getAllLicense');
//endPointURL= endPointMap.get('baseURL')+endPointMap.get('getAllLicenseByNumber');
system.debug('endPointURL'+endPointURL);
//requestPayload = allIdStateLicense_RequestJSON(objectlist);


Http http = new Http();
HttpRequest req = new HttpRequest();
req.setEndpoint(endPointURL);
req.setMethod('GET');
//req.setMethod('POST');
String APP_ID = State_License_Settings__c.getValues('StateLicense_APP_ID').Value__c;
String APP_KEY = State_License_Settings__c.getValues('StateLicense_APP_KEY').Value__c; 
req.setHeader('content-type','application/Json');
req.setHeader('APP_ID', APP_ID);
req.setHeader('APP_KEY', APP_KEY);
//req.setBody(requestPayload);


// Send the request, and return a response
HttpResponse res = http.send(req);

String response = res.getBody();  
if(res.getstatuscode() == 200){   
res = null;
req = null;
http = null;
return (List<Object>) JSON.deserializeUntyped(response);
}
//system.debug('responseList'+responseList);
return responseList;

}

public static List<Object> searchLicenseByNumber(String licenseNumber)
{   
String endPointURL='';
String requestPayload='';

List<Object> responseList = new List<Object>();
Map<String,String> endPointMap=getStateLicenseIntegrationEndpoints();
endPointURL= endPointMap.get('baseURL')+endPointMap.get('getAllLicenseByNumber');
system.debug('endPointURL'+endPointURL);
requestPayload = searchStateLicense_RequestJSON(licenseNumber);
system.debug('requestPayload'+requestPayload);

Http http = new Http();
HttpRequest req = new HttpRequest();
req.setEndpoint(endPointURL);
req.setMethod('POST');
String APP_ID = State_License_Settings__c.getValues('StateLicense_APP_ID').Value__c;
String APP_KEY = State_License_Settings__c.getValues('StateLicense_APP_KEY').Value__c; 
req.setHeader('content-type','application/Json');
req.setHeader('APP_ID', APP_ID);
req.setHeader('APP_KEY', APP_KEY);
req.setBody(requestPayload);


// Send the request, and return a response
HttpResponse res = http.send(req);
String response = res.getBody();
if(res.getstatuscode() == 200){   
responseList = (List<Object>) JSON.deserializeUntyped(res.getBody());
system.debug('responseList'+responseList);
}
return responseList;
}*/
    
    public static String toTitleCase(String phrase){
        String titlePhrase = '';
        //a set of words that should always (or at least, almost always) be in lower case when in Title Case
        //eg The Day of the Jackal.  First and last word of a phrase should always be Capped though.
        Set<String> forceLower = new Set<String>{'of', 'the', 'for', 'and', 'a', 'to', 'at' ,'an', 'but', 'if', 'or', 'nor'};
            
            if(phrase != null && phrase.length() > 0){
                String[] splitPhrase = phrase.trim().split(' ');
                
                for(integer i = 0; i < splitPhrase.size(); i++){
                    if(!forceLower.contains(splitPhrase[i].toLowerCase()) || i == 0 || i == (splitPhrase.size()-1) ){
                        titlePhrase += (splitPhrase[i].substring(0,1).toUpperCase())+(splitPhrase[i].substring(1).toLowerCase())+' ';
                    }else{
                        titlePhrase += splitPhrase[i].toLowerCase()+' ';
                    }
                }
            }
        return titlePhrase.trim();
    }
}