/**************************************************************************************
Apex Class Name    : Metrc_HttpCalloutHelper
Test Class Name    : 
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : Used for callout Response  
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
*******************************************************************************/
global with sharing class Metrc_HttpCalloutHelper
{   
    Public static Map<String,String> integrationEndpointsMap = new Map<String,String>();
    Public static Map<String,String> requestHeaders = new Map<String,String>();
             public static boolean TTGSActiveValidationTrigger = False;

    private Static String UID_METRC_STATUS_FINISHED{
        get{
            return String.isNotBlank(UID_METRC_STATUS_FINISHED) ? UID_METRC_STATUS_FINISHED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','UID_Metrc_Status_Finished');
        }set;
    }
    private Static String UID_METRC_SYNC_STATUS{
        get{
            return String.isNotBlank(UID_METRC_SYNC_STATUS) ? UID_METRC_SYNC_STATUS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','UID_Metrc_Sync_Status');
        }set;
    }
    public Static String ERR_MSG_SUCCESSFULLY_SYN_STRAIN_DATA{
        get{
            return String.isNotBlank(ERR_MSG_SUCCESSFULLY_SYN_STRAIN_DATA) ? ERR_MSG_SUCCESSFULLY_SYN_STRAIN_DATA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Strain','Err_Msg_Successfully_Syn_Strain_Data');
        }set;
    }
    private Static String ERR_MSG_FAILED_TO_GET_RECORDID{
        get{
            return String.isNotBlank(ERR_MSG_FAILED_TO_GET_RECORDID) ? ERR_MSG_FAILED_TO_GET_RECORDID : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Err_Msg_Failed_To_Get_RecordId');
        }set;
    }
    public Static String ERR_MSG_WHILE_SYN_PRODUCT_DATA{
        get{
            return String.isNotBlank(ERR_MSG_WHILE_SYN_PRODUCT_DATA) ? ERR_MSG_WHILE_SYN_PRODUCT_DATA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Err_Msg_While_Syn_Product_Data');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_PLANNED_SHIP_DATE_6PM{ 
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_PLANNED_SHIP_DATE_6PM) ? SHIPPING_MANIFEST_PLANNED_SHIP_DATE_6PM : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Planned_Ship_Date_6PM');
        }set;
    }
    public Static String SHIPPING_MANIFEST_PLANNED_SHIP_DATE_8AM{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_PLANNED_SHIP_DATE_8AM) ? SHIPPING_MANIFEST_PLANNED_SHIP_DATE_8AM : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Planned_Ship_Date_8AM');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_TRANSFERNAME_WHOLESALE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_TRANSFERNAME_WHOLESALE) ? SHIPPING_MANIFEST_TRANSFERNAME_WHOLESALE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_TransferName_Wholesale');
        }set;
    }
    public Static String SHIPPING_MANIFEST_TRANSFERNAME_TRANSFER{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_TRANSFERNAME_TRANSFER) ? SHIPPING_MANIFEST_TRANSFERNAME_TRANSFER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_TransferName_Transfer');
        }set;
    }
    
     public Static String PRODUCT_ENDPOINT_URL{
        get{
            return String.isNotBlank(PRODUCT_ENDPOINT_URL) ? PRODUCT_ENDPOINT_URL: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Metrc_Get_Product_EndPoint');
        }set;
    }
     public Static String STRAIN_ENDPOINT_URL{
        get{
            return String.isNotBlank(STRAIN_ENDPOINT_URL) ? STRAIN_ENDPOINT_URL: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Strain','Metrc_Get_Strain_EndPoint');
        }set;
    }
   
     public static String updateTTGSStrain(List<TTGS_Strain__c> TTGSstrain,String eventType,List<string> TTGSName,string strainids)
    {
        system.debug('TTGSstrain'+TTGSstrain);
        system.debug('eventType'+eventType);
        system.debug('TTGSName'+TTGSName);
        system.debug('strainids'+strainids);

        if(strainids != null){
            
       
     
         Boolean isStrainRecFound =false; String action ='POST'; String endPointURL='';String requestPayload='';  Integer metrcStrainID=0;
        string error; Map<String,String> endPointMap=getMetrcIntegrationEndpoints(); Map<String,String> requestHeaders = getHttpRequestHeaders();
        Map<string,TTGS_Strain__c> mapsobj = new Map<string,TTGS_Strain__c>();
        set<object>names = new set<object>();List<TTGS_Strain__c>lstttg = new List<TTGS_Strain__c>(); Map<id,TTGS_Strain__c> mapslst = new map<id,TTGS_Strain__c>();String response;
        Map<Id,TTGS_Strain__c> newUpdatedIPMap = new Map<Id,TTGS_Strain__c>();List<Object> responseListupdate = new List<Object>();
         if(eventType == 'UPDATE'){for(TTGS_Strain__c TTGSData :TTGSstrain ){   names.add(TTGSData.Strain__r.Name);
                 endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_strains_update')+TTGSData.License_Number__c; requestPayload = Metrc_RequestPayload.StraindataREQJSONUpdate(TTGSstrain,'UPDATE',TTGSData.Id,strainids); 
                 Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();HttpResponse  httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);   
                 response = httpResponse.getBody();
                 system.debug('response>>'+response);
                 system.debug('response>>'+httpResponse.getstatuscode());
                 
             }
        }
                       List<TTGS_Strain__c> ttdata = new List<TTGS_Strain__c>();  List<String> responsedata= new List<string>();

              
         for(TTGS_Strain__c TTGSData :TTGSstrain  ){  if(TTGSData.Active__c == true){ names.add(TTGSData.Strain__r.Name);string strainnames = TTGSData.Strain__r.Name;
             Http http = new Http();HttpRequest req = new HttpRequest(); String encoded = EncodingUtil.urlEncode(strainnames, 'UTF-8');
                   	 req.setEndpoint(String.format(STRAIN_ENDPOINT_URL,  new List<String>{String.valueOf(encoded),String.valueOf(TTGSData.License_Number__c)})); 

             //req.setEndpoint('https://wovn-utility.herokuapp.com/metrc_data?ObjectName=Strain__c&ObjectValue='+encoded+'&LicenseNumber='+TTGSData.License_Number__c);  
             req.setHeader('Content-Type', 'application/Json'); req.setBody('');  req.setMethod('GET');
             req.setTimeout(120000);  HttpResponse res = http.send(req); String responseget = res.getBody();
             Map<String, Object> deserialized = (Map<String, Object>)JSON.deserializeUntyped(res.getBody()); List<Map<String, Object>> data = new List<Map<String, Object>>();
             for (Object instance : (List<Object>)deserialized.get('response')){  Map<String,Object> respMap= (Map<String,Object>)instance;if(respMap.containsKey('Name') && names.contains(respMap.get('Name'))){metrcStrainID = (Integer)respMap.get('Id');
                        TTGS_Strain__c tt = new TTGS_Strain__c(); tt.Id = TTGSData.Id;tt.TTGS_StrainID__c =string.valueOf(metrcStrainID);ttdata.add(tt); break;
                   }    	
               }
              TTGSActiveValidationTrigger = true;upsert ttdata; return ERR_MSG_SUCCESSFULLY_SYN_STRAIN_DATA;
           }
         } 
        //   }
        
        
      }   
        
        
         return null; 
       }
     
   
   /**************************************************************************************
Method name        : CreateStrain
Created Date       : 01/Sep/2019
Function           : Used for creating the Strain in Metrc system.
*******************************************************************************/
    public static String CreateTTGSStrain(List<TTGS_Strain__c> TTGSstrain,String eventType,string TTGSName,string strainids)
    {
        system.debug('TTGSstrain'+TTGSstrain);
        system.debug('eventType'+eventType);
        system.debug('TTGSName'+TTGSName);
         Boolean isStrainRecFound =false;
        String action ='POST';
        String endPointURL='';
        String requestPayload='';
        Integer metrcStrainID=0;
        string error;
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        Map<string,TTGS_Strain__c> mapsobj = new Map<string,TTGS_Strain__c>();
        set<object>names = new set<object>();
        List<TTGS_Strain__c>lstttg = new List<TTGS_Strain__c>();
        Map<id,TTGS_Strain__c> mapslst = new map<id,TTGS_Strain__c>();
        String response;
        HttpResponse httpResponse;
        Map<Id,TTGS_Strain__c> newUpdatedIPMap = new Map<Id,TTGS_Strain__c>();
        List<Object> responseListupdate = new List<Object>();
        
         if(eventType == 'UPDATE'){ for(TTGS_Strain__c TTGSData :TTGSstrain ){ TTGSName =TTGSData.Id;    names.add(TTGSData.Strain__r.Name);
                string licnum = TTGSData.License_Number__c;endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_strains_update')+licnum;
                requestPayload = Metrc_RequestPayload.Straindata_REQJSON(TTGSstrain,'UPDATE',TTGSName,strainids); 
                Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);   
                response = httpResponse.getBody();
               
              
            }
        }
        
        
        
        if(eventType == 'INSERT'){
            for(TTGS_Strain__c TTGSData :TTGSstrain ){
                TTGSName =TTGSData.Id;   
                names.add(TTGSData.Strain__r.Name);string licnum = TTGSData.License_Number__c;
                endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_strains_create')+licnum;
                requestPayload = Metrc_RequestPayload.Straindata_REQJSON(TTGSstrain,'INSERT',TTGSName,null); 
                Metrc_HttpCallout httpcallout = new Metrc_HttpCallout(); httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);   
                response = httpResponse.getBody();
          
                
            
                
            }
        }
                       List<Object> responseList2 = new List<Object>();
                       List<TTGS_Strain__c> ttdata = new List<TTGS_Strain__c>();
       if(httpResponse.getstatuscode() == 200){   
              
               List<String> responsedata= new List<string>();Map<integer,TTGS_Strain__c>metrcidwithRecids =new Map<integer,TTGS_Strain__c>();
             
         for(TTGS_Strain__c TTGSData :TTGSstrain  ){if(TTGSData.Active__c == true){ string strainnames = TTGSData.Strain__r.Name;Http http = new Http();   HttpRequest req = new HttpRequest();
             String encoded = EncodingUtil.urlEncode(strainnames, 'UTF-8');
             req.setEndpoint(String.format(STRAIN_ENDPOINT_URL,  new List<String>{String.valueOf(encoded),String.valueOf(TTGSData.License_Number__c)})); 
            // req.setEndpoint('https://wovn-utility.herokuapp.com/metrc_data?ObjectName=Strain__c&ObjectValue='+encoded+'&LicenseNumber='+TTGSData.License_Number__c);  
             req.setHeader('Content-Type', 'application/Json'); req.setBody('');  req.setMethod('GET'); req.setTimeout(120000);
             HttpResponse res = http.send(req); String responseget = res.getBody();
             system.debug('response'+responseget); 
            
             Map<String, Object> deserialized = (Map<String, Object>)JSON.deserializeUntyped(res.getBody()); List<Map<String, Object>> data = new List<Map<String, Object>>();
            
             for (Object instance : (List<Object>)deserialized.get('response')){   Map<String,Object> respMap= (Map<String,Object>)instance;
                
                 if(respMap.containsKey('Name') && names.contains(respMap.get('Name'))){ metrcStrainID = (Integer)respMap.get('Id');
                     TTGS_Strain__c tt = new TTGS_Strain__c();tt.Id = TTGSData.Id; tt.TTGS_StrainID__c =string.valueOf(metrcStrainID);
                   
                    ttdata.add(tt);  break;
                 }    	
             }
         }
              }
 TTGSActiveValidationTrigger = true;upsert ttdata;return ERR_MSG_SUCCESSFULLY_SYN_STRAIN_DATA; 
             
           }
      
       else{
                      String errMsg='';
            
            
            if(response.contains('[{')){ List<Object> responseList = (List<Object>) JSON.deserializeUntyped(response); for(Object  obj : responseList){ Map<String,Object> respMap= (Map<String,Object>)obj;
                    if(respMap.containsKey('message')){ errMsg=errMsg +';'+(String)respMap.get('message');
                        system.debug('---------------errMsg----1------------'+errMsg);
                    }
                }
            } else if(response.startsWith('{')) { Map<String,Object> responseMap = (Map<String,Object>) JSON.deserializeUntyped(response); if(responseMap.containskey('Message')){
                    errMsg=(String)responseMap.get('Message');
                }
                system.debug('---------------errMsg----2------------'+errMsg);
            }else {errMsg = response; 
                   system.debug('---------------errMsg----3------------'+errMsg);}
            
           // productObj.Metrc_HttpResponse__c='#Error Code:'+httpResponse.getstatuscode()+'-Error Message::'+errMsg ;
         error ='#Error Code:'+httpResponse.getstatuscode()+'-Error Message::'+errMsg ;
   
       }
        
          
        
        
         return error; 
       }
     
      
    
     
    
    
    
    
    
     public static String getAllStrainsTGS(List<TTGS_Strain__c>  TTGSstrainObj,boolean sameSite)
    {   
        system.debug('sameSite'+sameSite);
         system.debug('TTGSstrainObj'+TTGSstrainObj);
        
        
        
        String message='';
       /*  if(sameSite == true){
        for(TTGS_Strain__c TTGSData :TTGSstrainObj ){
      
            message = Metrc_HttpCalloutHelper.CreateTTGSStrain(TTGSstrainObj,'INSERT',TTGSData.Strain__c,null);
            
        }
         }*/
        List<string> namedata = new List<string>();
        List<string> strainids = new List<string>();
        List<TTGS_Strain__c> samesiterec = new List<TTGS_Strain__c>();
       
            for(TTGS_Strain__c ttgs :TTGSstrainObj ){
            if(ttgs.Active__c == True) {
              samesiterec.add(ttgs); 
                namedata.add(ttgs.id);}else if(ttgs.Active__c == false){ strainids.add(ttgs.TTGS_StrainID__c);
            }
        }
        system.debug('namedata>>'+namedata);
        system.debug('strainids>>'+strainids);
        
        
        system.debug('TTGSstrainObj'+TTGSstrainObj);
        if(strainids.size()>0){  for(string straioldids : strainids){  message = Metrc_HttpCalloutHelper.updateTTGSStrain(samesiterec,'UPDATE',namedata,straioldids);
                
            }   
        
        }
            
        Integer metrcStrainID=0;
        Integer metrcRecordID =0;
        Boolean isStrainRecFound =false;
        Boolean isProdRecFound =false;
        String action ='GET';
        String endPointURL='';
        String requestPayload='';
        String response ;
        List<Object> responseList = new List<Object>();
        List<TTGS_Strain__c> ttdata = new List<TTGS_Strain__c>();
        List<TTGS_Strain__c> withoutids = new List<TTGS_Strain__c>();
        set<id>ids = new set<id>();
        set<object>names = new set<object>();
        string TTGSName;
        boolean checkTTGS = false;
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        set<string> licnum = new set<string>();
         for(TTGS_Strain__c TTGSData :TTGSstrainObj ){
             if(TTGSData.Active__c == true){
                 
            
       // if(TTGSData.Strain__c !=null  && strainObj.TTGS_StrainID__c == null ){
             names.add(TTGSData.Strain__r.Name);
              TTGSName = TTGSData.Strain__c;
      string strainnames = TTGSData.Strain__r.Name;Http http = new Http();   HttpRequest req = new HttpRequest();String encoded;
                 if(strainnames != null){ encoded = EncodingUtil.urlEncode(strainnames, 'UTF-8');}
             
              req.setEndpoint(String.format(STRAIN_ENDPOINT_URL,  new List<String>{String.valueOf(encoded),String.valueOf(TTGSData.License_Number__c)})); 
            // req.setEndpoint('https://wovn-utility.herokuapp.com/metrc_data?ObjectName=Strain__c&ObjectValue='+encoded+'&LicenseNumber='+TTGSData.License_Number__c);  
             req.setHeader('Content-Type', 'application/Json'); req.setBody('');  req.setMethod('GET'); req.setTimeout(120000);
             HttpResponse res = http.send(req); String responseget = res.getBody();
             system.debug('response'+responseget); 
            
             Map<String, Object> deserialized = (Map<String, Object>)JSON.deserializeUntyped(res.getBody()); List<Map<String, Object>> data = new List<Map<String, Object>>();
            
             for (Object instance : (List<Object>)deserialized.get('response')){   Map<String,Object> respMap= (Map<String,Object>)instance;
                
           if(respMap.containsKey('Name') && respMap.get('Name') == TTGSData.Strain__r.Name ){
                    metrcStrainID = (Integer)respMap.get('Id'); isStrainRecFound =true;  break;
                    }
                }
            if(isStrainRecFound){  TTGS_Strain__c tt = new TTGS_Strain__c();tt.Id = TTGSData.Id; tt.TTGS_StrainID__c =string.valueOf(metrcStrainID);
                ttdata.add(tt);TTGSActiveValidationTrigger = true; upsert ttdata;message = 'Successfully updated the product data.';
            }
           else{
                   message = Metrc_HttpCalloutHelper.CreateTTGSStrain(TTGSstrainObj,'INSERT',TTGSName,null);
                }
            
       // }
                  }
         }
       
       
return message;
    }
    
    
   /* public static String updateItemsTGS(List<TTGS_Item__c> TTGSItems,String eventType,List<string> TTGSName,string strainids)
    {
        system.debug('TTGSItems'+TTGSItems);
        system.debug('eventType'+eventType);
        system.debug('TTGSName'+TTGSName);
        system.debug('strainids'+strainids);

         Boolean isStrainRecFound =false;
        String action ='POST';
        String endPointURL='';
        String requestPayload='';
        Integer metrcStrainID=0;
        string error;
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        Map<string,TTGS_Item__c> mapsobj = new Map<string,TTGS_Item__c>();
        set<object>names = new set<object>();
        set<string>namesdatas= new set<string>();
        List<TTGS_Item__c>lstttg = new List<TTGS_Item__c>();
        Map<id,TTGS_Item__c> mapslst = new map<id,TTGS_Item__c>();
        String response;
        HttpResponse httpResponse;
        Map<Id,TTGS_Item__c> newUpdatedIPMap = new Map<Id,TTGS_Item__c>();
        List<Object> responseListupdate = new List<Object>();
        
         if(eventType == 'UPDATE'){
                        system.debug('CreateTTGSStrain UPDATE');

            for(TTGS_Item__c TTGSData :TTGSItems ){ 
                 system.debug('TTGSData'+TTGSData);
                names.add(TTGSData.Product_Name__r.Name);
                
                
                
                endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_strains_update')+TTGSData.License_Number__c;
                 system.debug('endPointURL'+endPointURL);
                  // requestPayload = Metrc_RequestPayload.StraindataREQJSONUpdate(TTGSItems,'UPDATE',TTGSData.Id,strainids); 
                //                endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_items_update')+licnum;

            system.debug('requestPayload'+requestPayload);     
                Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
                httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);   
                response = httpResponse.getBody();
                system.debug('response>>'+response);
                system.debug('response>>'+httpResponse.getstatuscode());
              
            }
        }
                      List<Object> responseList2 = new List<Object>();
                       List<TTGS_Item__c> ttdata = new List<TTGS_Item__c>();
       if(httpResponse.getstatuscode() == 200){   
               String action2 ='GET';
               String endPointURL2='';
           String requestPayload2='';
               String response2;
           List<String> responsedata= new List<string>();
               Map<integer,TTGS_Item__c>metrcidwithRecids =new Map<integer,TTGS_Item__c>();
               Map<String,String> endPointMap2=getMetrcIntegrationEndpoints();
           Map<String,String> requestHeaders2 = getHttpRequestHeaders();
         for(TTGS_Item__c TTGSData :TTGSItems  ){  
              Http http = new Http();
             HttpRequest req = new HttpRequest();
               string Prodnames = TTGSData.Product_Name__r.Name;
             String encoded = EncodingUtil.urlEncode(Prodnames, 'UTF-8');
             req.setEndpoint('https://wovn-utility.herokuapp.com/metrc_data?ObjectName=Product2&ObjectValue='+encoded+'&LicenseNumber='+TTGSData.License_Number__c);  
             req.setHeader('Content-Type', 'application/Json');
             req.setBody('');
             req.setMethod('GET');
             req.setTimeout(120000);
             HttpResponse res = http.send(req);
             String responseget = res.getBody();
             system.debug('response'+responseget); 
             Map<String, Object> deserialized = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
             List<Map<String, Object>> data = new List<Map<String, Object>>();
             for (Object instance : (List<Object>)deserialized.get('response')){
                   system.debug('instance>>>'+instance);
                 
                 Map<String,Object> respMap= (Map<String,Object>)instance;
                   system.debug('respMap>>>'+respMap.containsKey('Name'));
                                  system.debug('respMapnames>>>'+names.contains(respMap.get('Name')));
                                  system.debug('names>>>'+names);
                    if(respMap.containsKey('Name') && names.contains(respMap.get('Name'))){
                        metrcStrainID = (Integer)respMap.get('Id');
                        TTGS_Item__c tt = new TTGS_Item__c(); 
                        tt.Id = TTGSData.Id;
                        tt.TTGS_ItemID__c =string.valueOf(metrcStrainID);
                        ttdata.add(tt); break;
                   }    	
               }
           }
           upsert ttdata; return ERR_MSG_SUCCESSFULLY_SYN_STRAIN_DATA; 
           }
        
        
        
        
        
         return null; 
       } 
    
    
*/    
    
    
    
    
    
    
    
    
    
    
   
    /**************************************************************************************
Method name        : CreateStrain
Created Date       : 01/Sep/2019
Function           : Used for creating the Strain in Metrc system.
*******************************************************************************/
    public static String CreateStrain(ID sfdc_strainID,Strain__c strain,String eventType)
    {
        
        String action ='POST';
        String endPointURL='';
        String requestPayload='';
        Integer metrcStrainID=0;
        
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        
        if(eventType == 'INSERT'){
            endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_strains_create')+endPointMap.get('licenseNumber');
           requestPayload = Metrc_RequestPayload.CreateStrain_RequestJSON(sfdc_strainID,'INSERT'); 
        }
        if(eventType == 'UPDATE'){endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_strains_update')+endPointMap.get('licenseNumber');requestPayload = Metrc_RequestPayload.CreateStrain_RequestJSON(sfdc_strainID,'UPDATE'); 
        }
        Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
        HttpResponse httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);
        String response = httpResponse.getBody();  
        if(httpResponse.getstatuscode() == 200){   if(eventType == 'INSERT'){List<Object> responseList=getAllStrains(); for(Object  obj:responseList){
                    Map<String,Object> respMap= (Map<String,Object>)obj; if(respMap.containsKey('Name') && respMap.get('Name') == strain.Name ){metrcStrainID = (Integer)respMap.get('Id');
                        break;
                    }
                }
                strain.Metrc_StrainID__c =string.valueof(metrcStrainID);strain.Metrc_HttpResponse__c='';Metrc_Utility.IS_STRAIN_TRIGGER_ENABLED =FALSE;
                Database.update(strain,true);  return ERR_MSG_SUCCESSFULLY_SYN_STRAIN_DATA;  }else return ERR_MSG_SUCCESSFULLY_SYN_STRAIN_DATA;
        }else
        {       
            strain.Metrc_HttpResponse__c='Error Code:'+httpResponse.getstatuscode()+'-Error Message::'+response;
            Metrc_Utility.IS_STRAIN_TRIGGER_ENABLED =FALSE;
            Database.update(strain,true);
            return strain.Metrc_HttpResponse__c;
        }
        
    }
    
    /**************************************************************************************
Method name        : createProduct
Created Date       : 01/Sep/2019
Function           : Used for creating the Items record in Metrc system.
*******************************************************************************/
   public static String createProduct(ID sfdc_productID,Product2 productObj,String eventType)
    {   
        String action ='POST';
        String endPointURL='';
        String requestPayload='';
        Integer metrcRecordID=0;
        
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        
        if(eventType == 'INSERT'){
            endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_items_create')+endPointMap.get('licenseNumber');
            requestPayload = Metrc_RequestPayload.createProduct_RequestJSON(sfdc_productID,'INSERT'); 
        }
        if(eventType == 'UPDATE'){ endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_items_update')+endPointMap.get('licenseNumber'); requestPayload = Metrc_RequestPayload.createProduct_RequestJSON(sfdc_productID,'UPDATE'); 
        }
        Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
        HttpResponse httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);
        String response = httpResponse.getBody();  
        if(httpResponse.getstatuscode() == 200){     if(eventType == 'INSERT'){getAllProductsUpdate(productObj.Id); return ERR_MSG_SUCCESSFULLY_SYN_STRAIN_DATA;  }else return ERR_MSG_SUCCESSFULLY_SYN_STRAIN_DATA;
        }else
        {   //Capture the error here
            String errMsg='';
            
            
            if(response.contains('[{')){List<Object> responseList = (List<Object>) JSON.deserializeUntyped(response); for(Object  obj : responseList){ Map<String,Object> respMap= (Map<String,Object>)obj;
                    if(respMap.containsKey('message')){ errMsg=errMsg +';'+(String)respMap.get('message');
                        system.debug('---------------errMsg----1------------'+errMsg);
                    }
                }
            } else if(response.startsWith('{')) { Map<String,Object> responseMap = (Map<String,Object>) JSON.deserializeUntyped(response);
                if(responseMap.containskey('Message')){ errMsg=(String)responseMap.get('Message');
                }
                system.debug('---------------errMsg----2------------'+errMsg);
            }else {errMsg = response; 
                   system.debug('---------------errMsg----3------------'+errMsg);}
            
            productObj.Metrc_HttpResponse__c='#Error Code:'+httpResponse.getstatuscode()+'-Error Message::'+errMsg ;
            Metrc_Utility.IS_PROD_TRIGGER_ENABLED  =FALSE;
            if(!Test.isrunningtest()){  Database.update(productObj,true);  return productObj.Metrc_HttpResponse__c;
            }
        } return ERR_MSG_WHILE_SYN_PRODUCT_DATA;                
    }
    
    
    
     public static String getAllItemsTGS(List<TTGS_Item__c>  TTGSitemObj)
    {   
        
       String message=''; List<string> namedata = new List<string>();   List<string> strainids = new List<string>();
     
       
        Integer metrcStrainID=0;Integer metrcRecordID =0; Boolean isStrainRecFound =false; String action ='GET';  String endPointURL='';
        String requestPayload='';  String response ;List<Object> responseList = new List<Object>();
        List<TTGS_Item__c> ttdata = new List<TTGS_Item__c>();  List<TTGS_Item__c> withoutids = new List<TTGS_Item__c>();
        set<id>ids = new set<id>();set<object>names = new set<object>();
        string TTGSName;boolean checkTTGS = false;
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints(); Map<String,String> requestHeaders = getHttpRequestHeaders();  set<string> licnum = new set<string>();
         for(TTGS_Item__c TTGSData :TTGSitemObj ){  Http http = new Http();HttpRequest req = new HttpRequest();
               string Prodnames = TTGSData.Product_Name__r.Name;
              String encoded = EncodingUtil.urlEncode(Prodnames, 'UTF-8');
                                                  system.debug('encoded'+encoded);
             req.setEndpoint(String.format(PRODUCT_ENDPOINT_URL,  new List<String>{String.valueOf(encoded),String.valueOf(TTGSData.License_Number__c)})); 
                                     
            // req.setEndpoint('https://wovn-utility.herokuapp.com/metrc_data?ObjectName=Product2&ObjectValue='+encoded+'&LicenseNumber='+TTGSData.License_Number__c);  
             req.setHeader('Content-Type', 'application/Json'); 
              req.setBody(''); 
              req.setMethod('GET');
             req.setTimeout(120000);
               HttpResponse res = http.send(req);  
                String responseget = res.getBody();
             system.debug('response'+responseget.contains('1005'));
                system.debug('res.getStatusCode()'+res.getStatusCode()); 
              //system.debug('res.getStatusCode()'); 

                                                      
             if(responseget.contains('1005')== true){
            message = Metrc_HttpCalloutHelper.createTTGSItem(TTGSitemObj,'INSERT',TTGSName,null);
                                                      
                  }else{
                                                      
                                               
             Map<String, Object> deserialized = (Map<String, Object>)JSON.deserializeUntyped(responseget);
             List<Map<String, Object>> data = new List<Map<String, Object>>(); 
                                                  for (Object instance : (List<Object>)deserialized.get('response')){
                   system.debug('instance>>>'+instance);
                 
                 Map<String,Object> respMap= (Map<String,Object>)instance;
                 system.debug('respMap>>>'+respMap.containsKey('Name'));
                 system.debug('respMapnames>>>'+names.contains(respMap.get('Name')));
                 system.debug('names>>>'+names); 
                 if(respMap.containsKey('Name') && respMap.get('Name') == TTGSData.Product_Name__r.Name ){   metrcStrainID = (Integer)respMap.get('Id');
                    isStrainRecFound =true;  break;
                    }
                }
            if(isStrainRecFound){    TTGS_Item__c tt = new TTGS_Item__c(); tt.Id = TTGSData.Id;  tt.TTGS_ItemID__c =string.valueOf(metrcStrainID);	
                ttdata.add(tt); TTGSActiveValidationTrigger = true;   upsert ttdata;
                //insertRecTTGItem(JSOn.serialize(ttdata)); 
                message = 'Successfully updated the product data.'; }
                 else{    
                     message = Metrc_HttpCalloutHelper.createTTGSItem(TTGSitemObj,'INSERT',TTGSName,null);
                }
                                                 
         }     
         }
       



return message;
      
    }
    
   
    
   public static String createTTGSItem(List<TTGS_Item__c> TTGSitems,String eventType,string TTGIName,string strainids) 
    {
        system.debug('TTGSitems'+TTGSitems);
        system.debug('eventType'+eventType);
        system.debug('TTGIName'+TTGIName);
         Boolean isProductRecFound =false; String action ='POST'; String endPointURL='';   String requestPayload='';
        Integer metrcStrainID=0; string error;  Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        Map<String,String> requestHeaders = getHttpRequestHeaders();Map<string,TTGS_Item__c> mapiobj = new Map<string,TTGS_Item__c>();
        set<object>names = new set<object>();set<string>licencenum = new set<string>();List<TTGS_Item__c>lstttg = new List<TTGS_Item__c>();Map<id,TTGS_Item__c> mapilst = new map<id,TTGS_Item__c>(); String response;HttpResponse httpResponse;
        Map<Id,TTGS_Item__c> newUpdatedIPMap = new Map<Id,TTGS_Item__c>();  List<Object> responseListupdate = new List<Object>();
        if(eventType == 'UPDATE'){
                        system.debug('CreateTTGSItem UPDATE');

            for(TTGS_Item__c TTGIData :TTGSitems ){ TTGIName =TTGIData.Id;   names.add(TTGIData.Product_Name__r.Name);  string licnum = TTGIData.License_Number__c;
                endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_items_update')+licnum;requestPayload = Metrc_RequestPayload.Itemsdata_REQJSON(TTGSitems,'UPDATE',TTGIName,null); 
                system.debug('endPointURL'+endPointURL);
                system.debug('requestPayload'+requestPayload); 
                Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();  httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);   response = httpResponse.getBody();
                system.debug('response>>'+response);
                system.debug('response>>'+httpResponse.getstatuscode());
              
            }
        }
        
        
        
        if(eventType == 'INSERT'){for(TTGS_Item__c TTGIData :TTGSitems ){TTGIName =TTGIData.Id; names.add(TTGIData.Product_Name__r.Name); string licnum = TTGIData.License_Number__c;endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_items_create')+licnum;
              requestPayload = Metrc_RequestPayload.Itemsdata_REQJSON(TTGSitems,'INSERT',TTGIName,null); Metrc_HttpCallout httpcallout = new Metrc_HttpCallout(); httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);   
                response = httpResponse.getBody();
                system.debug('response>>'+response);
                system.debug('response>>'+httpResponse.getstatuscode());
          
                
            
                
            }
        }
                       List<TTGS_Item__c> ttdata = new List<TTGS_Item__c>();if(httpResponse.getstatuscode() == 200){    String action2 ='GET'; String endPointURL2='';
               String requestPayload2='';String response2;List<String> responsedata= new List<string>();  Map<String,String> endPointMap2=getMetrcIntegrationEndpoints();
               Map<String,String> requestHeaders2 = getHttpRequestHeaders();
         for(TTGS_Item__c TTGIData :TTGSitems  ){Http http = new Http(); HttpRequest req = new HttpRequest();
               string Prodnames = TTGIData.Product_Name__r.Name; String encoded = EncodingUtil.urlEncode(Prodnames, 'UTF-8');
             req.setEndpoint(String.format(PRODUCT_ENDPOINT_URL,  new List<String>{String.valueOf(encoded),String.valueOf(TTGIData.License_Number__c)}));                                     
            // req.setEndpoint('https://wovn-utility.herokuapp.com/metrc_data?ObjectName=Product2&ObjectValue='+encoded+'&LicenseNumber='+TTGIData.License_Number__c);  
             req.setHeader('Content-Type', 'application/Json');  req.setBody('');req.setMethod('GET'); req.setTimeout(120000);  HttpResponse res = http.send(req);String responseget = res.getBody();
             system.debug('response'+responseget); 
             Map<String, Object> deserialized = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());List<Map<String, Object>> data = new List<Map<String, Object>>();
             for (Object instance : (List<Object>)deserialized.get('response')){ Map<String,Object> respMap= (Map<String,Object>)instance;
               if(respMap.containsKey('Name') && names.contains(respMap.get('Name'))){ metrcStrainID = (Integer)respMap.get('Id');
                        TTGS_Item__c tt = new TTGS_Item__c();  tt.Id = TTGIData.Id;tt.TTGS_ItemID__c =string.valueOf(metrcStrainID);ttdata.add(tt);break;
                   }      	
               }
           }
           upsert ttdata;  return 'product Sync Sucessfully '; 
           }
       else{
                      String errMsg='';
            
            
            if(response.contains('[{')){   List<Object> responseList = (List<Object>) JSON.deserializeUntyped(response); for(Object  obj : responseList){Map<String,Object> respMap= (Map<String,Object>)obj;
                    if(respMap.containsKey('message')){ errMsg=errMsg +';'+(String)respMap.get('message');
                        system.debug('---------------errMsg----1------------'+errMsg);
                    }
                }
            } else if(response.startsWith('{')) {Map<String,Object> responseMap = (Map<String,Object>) JSON.deserializeUntyped(response);
                if(responseMap.containskey('Message')){ errMsg=(String)responseMap.get('Message');
                }
                system.debug('---------------errMsg----2------------'+errMsg);
            }else {errMsg = response; 
                   system.debug('---------------errMsg----3------------'+errMsg);}
            
           // productObj.Metrc_HttpResponse__c='#Error Code:'+httpResponse.getstatuscode()+'-Error Message::'+errMsg ;
         error ='#Error Code:'+httpResponse.getstatuscode()+'-Error Message::'+errMsg ;
   
       }
        
        
        
        
         return error; 
    }
 
    /**************************************************************************************
Method name        : getMetrcIntegrationEndpoints
Created Date       : 01/Sep/2019
Function           : Used for catching the integrationEndpoints,method is called internally.
*******************************************************************************/
    public static Map<String,String>  getMetrcIntegrationEndpoints(){
        
        if(integrationEndpointsMap.size()>0) return integrationEndpointsMap;
        else{
            List<Metrc_IntegrationEndpoints__mdt> integrationEndpoints = [select id,MasterLabel,URL__c from Metrc_IntegrationEndpoints__mdt];
            
            for(Metrc_IntegrationEndpoints__mdt var : integrationEndpoints){
                integrationEndpointsMap.put(var.MasterLabel,var.URL__c);
            }
            integrationEndpointsMap.put('baseURL',Metrc_IntegrationSettings__C.getValues('Endpoint').Value__c);
            integrationEndpointsMap.put('licenseNumber',Metrc_IntegrationSettings__C.getValues('LicenseNumber').Value__c);
            return integrationEndpointsMap;
        }   
    }
    
   
    /**************************************************************************************
Method name        : getAllStrains
Created Date       : 01/Sep/2019
Function           : Used for retrieving all the Strains created recently.
*******************************************************************************/
    public static List<Object> getAllStrains()
    {   
        String action ='GET';
        String endPointURL='';
        String requestPayload='';
        
        List<Object> responseList = new List<Object>();
        
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        
        endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_strains_getAll')+endPointMap.get('licenseNumber');
        
        Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
        HttpResponse httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);
        String response = httpResponse.getBody();  
        if(httpResponse.getstatuscode() == 200){   
            responseList = (List<Object>) JSON.deserializeUntyped(response);
            
        }
        return responseList;
    }
    
    /**************************************************************************************
Method name        : getAllProducts
Created Date       : 01/Sep/2019
Function           : Used for retrieving all the Items created recently.
*******************************************************************************/
    public static List<Object>  getAllProducts()
    {   
        String action ='GET'; String endPointURL=''; String requestPayload='';
        
        List<Object> responseList = new List<Object>(); Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_items_getAll')+endPointMap.get('licenseNumber');
        Map<String,String> requestHeaders = getHttpRequestHeaders(); Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
        HttpResponse httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);
        String response = httpResponse.getBody();  
        if(httpResponse.getstatuscode() == 200){  responseList = (List<Object>) JSON.deserializeUntyped(response);
        }
        return responseList;
    }
    
    @future(callout=true)
    public static void  getAllProductsUpdate(String productId)
    {   
        String action ='GET'; String endPointURL='';
        String requestPayload='';  Integer metrcRecordID=0;
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_items_getAll')+endPointMap.get('licenseNumber');
        Map<String,String> requestHeaders = getHttpRequestHeaders(); Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
        HttpResponse httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);
        String response = httpResponse.getBody();    List<Object> responseList = (List<Object>)JSON.deserializeUntyped(response);
        Product2 prodObj = [select id, Name,Metrc_ItemID__c,Metrc_HttpResponse__c from Product2 where id=:productId];
        for(Object  obj:responseList){   Map<String,Object> respMap= (Map<String,Object>)obj;
            if(respMap.containsKey('Name') && respMap.get('Name') == prodObj.Name ){  metrcRecordID = (Integer)respMap.get('Id'); break;
            }
            
        }  
        prodObj.Metrc_ItemID__c =string.valueof(metrcRecordID); prodObj.Metrc_HttpResponse__c='';
        if(metrcRecordID == 0){ prodObj.Metrc_ItemID__c ='#ERROR'; 
            prodObj.Metrc_HttpResponse__c= ERR_MSG_FAILED_TO_GET_RECORDID;
        }
        Metrc_Utility.IS_PROD_TRIGGER_ENABLED  =FALSE;  Database.update(prodObj,true);
    }
    /**************************************************************************************
Method name        : deleteMetrcRecord
Created Date       : 01/Sep/2019
Function           : Used for inactivate the Strains & Products on update of Active flag.
*******************************************************************************/
    public static void deleteMetrcRecord(ID metrc_ID,String endPointURL){
        String action ='DELETE'; String intEndPointURL='';
        String requestPayload='';
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        intEndPointURL= endPointMap.get('baseURL')+endPointMap.get(endPointURL)+endPointMap.get('licenseNumber');
        intEndPointURL.replace('{id}', metrc_ID);  //update the metrc_ID in URL string
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
        HttpResponse httpResponse = httpcallout.SendRequest(action,intEndPointURL,requestPayload,requestHeaders);
        String response = httpResponse.getBody();  
        if(httpResponse.getstatuscode() == 200){   
            System.debug('------httpResponse Success---------');
        }else
        {   
        }                
    }
    
    
    public static Map<String,String> getHttpRequestHeaders(){
        if(requestHeaders.size() > 0) {return requestHeaders;}
        else {
            String vendor_api_key = Metrc_IntegrationSettings__C.getValues('VendorAPIKey').Value__c;
            String user_api_key = Metrc_IntegrationSettings__C.getValues('UserAPIKey').Value__c;
            Blob beforeblob = Blob.valueOf(vendor_api_key+':'+user_api_key);
            requestHeaders.put('Content-Type', 'application/json');           
           String encodedAPIkey=EncodingUtil.base64Encode(beforeblob);
            string endcoded2 ='d0Vsa0JRdmhiaUpyRThuODJSc2lweC00UzVWOFdLNVd1Q1J1b3pyM3VlRWdnNHlIOnZudEQ1bHBRY3V4VVRQNEdlWkl1RmVJem02UFZEbm5GcnVCbEpzbzl6ZzBvV0Z5cQ==';
            requestHeaders.put('Authorization','Basic '+encodedAPIkey); 
            return requestHeaders;
        }
    }
    
    /**************************************************************************************
Method name        : getSingleStrain
Created Date       : 01/Sep/2019
Function           : Used for retrieving all the Strains created recently.
*******************************************************************************/
    public static Map<String,Object> getSingleStrain(String metrc_strainID)
    {   
        String action ='GET';
        String endPointURL='';
        String requestPayload='';
        
        Map<String,Object> responseMap = new Map<String,Object>();
        
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_strains_getID')+endPointMap.get('licenseNumber');
        endPointURL= endPointURL.replace('{id}', metrc_strainID);  //update the metrc_strainID in URL string
        Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
        HttpResponse httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);
        String response = httpResponse.getBody();  
        if(httpResponse.getstatuscode() == 200){   responseMap = (Map<String,Object>) JSON.deserializeUntyped(response);
            
        }
        return responseMap ;
    }
    
    /**************************************************************************************
Method name        : getSingleProducts
Created Date       : 01/Sep/2019
Function           : Used for retrieving all the Items created recently.
*******************************************************************************/
    public static Map<String,Object>  getSingleProducts(String metrc_ID)
    {   
        String action ='GET';
        String endPointURL='';
        String requestPayload='';
        
        Map<String,Object> responseMap = new Map<String,Object>();
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_items_getID')+endPointMap.get('licenseNumber');
        endPointURL= endPointURL.replace('{id}', metrc_ID);  //update the metrc_ID in URL string
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
        HttpResponse httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);
        String response = httpResponse.getBody();  
        if(httpResponse.getstatuscode() == 200){    responseMap = (Map<String,Object>) JSON.deserializeUntyped(response);
        }
        return responseMap;
      //  return null;
    }
    
    /**************************************************************************************
Method name        : createPicklist
Created Date       : 01/Sep/2019
Function           : Used for creating the Packages record in Metrc system.
*******************************************************************************/
    public static void createPicklist(ID sfdc_PickListRecID,List<Picklist_Line__c> PicklistLine_List,String eventType)
    {   
        system.debug('createPicklist>>>');
        String action ='POST';
        String endPointURL='';
        String requestPayload='';
        Integer metrcPackageID=0;
        
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        
        List<String> packoutUIDList= new List<String>();
        for(Picklist_Line__c var: PicklistLine_List){
            packoutUIDList.add(var.Pack_out_UID__c);
        }
        //create a map of <UID,Tag>
        Map<ID,String> packoutUIDMap = Metrc_SOQLDML_Handler.getUIDTagMap(packoutUIDList);
        
        if(eventType == 'INSERT'){
            endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_packages_create')+endPointMap.get('licenseNumber');
            requestPayload = Metrc_RequestPayload.createPicklistLine_RequestJSON(PicklistLine_List,packoutUIDMap); 
                    system.debug('requestPayload>>'+requestPayload);

        }
        
        Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
        HttpResponse httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);
        String response = httpResponse.getBody();  
        system.debug('response>>'+response);
                system.debug('response>>'+httpResponse.getstatuscode());

        if(httpResponse.getstatuscode() == 200){
            boolean isMetrcIDUpdated =false;            
            if(eventType == 'INSERT'){
                /*isMetrcIDUpdated = updateMetrcPackageID(PicklistLine_List,packoutUIDMap,sfdc_PickListRecID); 
if(!isMetrcIDUpdated) {
updateMetrcPackageID(PicklistLine_List,packoutUIDMap,sfdc_PickListRecID); //retry the API call for updating the Metrc packageid.
} */  
                // picklistLine.Metrc_HttpResponse__c='Succesfuly sent to Metrc';         
                
            }
            Picklist__c picklist= new Picklist__c();
            picklist.id=sfdc_PickListRecID;
            picklist.Track_Trace_Sync__c =true;
            update picklist;
       system.debug('picklist>>>'+picklist);     
        }else { // statuscode() != 200 //Capture the error here  
            for(Picklist_Line__c picklistLine : PicklistLine_List){     
                //picklistLine.Metrc_PackageID__c ='#ERROR';
                picklistLine.Metrc_HttpResponse__c='Error Code:'+httpResponse.getstatuscode()+'-Error Message::'+response;
                
            }
            Database.update(PicklistLine_List,true);
        }             
    }
    public static boolean updateMetrcPackageID(List<Picklist_Line__c> PicklistLineList,Map<ID,String> packoutUIDMap,ID sfdc_PickListRecID)
    { 
        Integer metrcPackageID=0;
        boolean isMetrcIDUpdated =false;
        List<Object> responseList=getAllPackages();
        for(Picklist_Line__c picklistLine : PicklistLineList){
            for(Object  obj:responseList){
                Map<String,Object> respMap= (Map<String,Object>)obj;
                if(respMap.containsKey('Label') && respMap.get('Label') == packoutUIDMap.get(picklistLine.Pack_out_UID__c)){
                    metrcPackageID = (Integer)respMap.get('Id');
                    picklistLine.Metrc_PackageID__c =String.valueof(metrcPackageID);
                    picklistLine.Metrc_HttpResponse__c=''; //clear the Error msgs.
                    isMetrcIDUpdated =true;
                    break;
                }
            }
        }
        if(isMetrcIDUpdated){
            /* Picklist__c picklist= new Picklist__c();
picklist.id=sfdc_PickListRecID;
picklist.Track_Trace_Sync__c =true;
update picklist;*/
            
            Metrc_Utility.IS_PICKLIST_TRIGGER_ENABLED =FALSE;  
            Database.update(PicklistLineList,true);
        }
        return isMetrcIDUpdated;
    }
    public static List<Object> getAllPackages()
    {   
        String action ='GET';
        String endPointURL='';
        String requestPayload='';
        
        List<Object> responseList = new List<Object>();
        
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        system.debug('requestHeaders'+requestHeaders);
        system.debug('endPointMap'+endPointMap.get('licenseNumber'));
        endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_packages_getAll')+endPointMap.get('licenseNumber');
        Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
        HttpResponse httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);
        String response = httpResponse.getBody();  
        if(httpResponse.getstatuscode() == 200){   
            responseList = (List<Object>) JSON.deserializeUntyped(response);
        }
        return responseList;
    }
    //Metrc Transfers creation
  
    public static String createShippingManifest(Shipping_Manifest__c shippingManifestObj,String eventType,String route)
    {   
        String action ='POST';
        String endPointURL='';
        String requestPayload='';
        
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        
        if(eventType == 'INSERT'){endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_transfers_template')+endPointMap.get('licenseNumber');
            system.debug('endPointURL>>'+endPointURL);
            requestPayload = Metrc_RequestPayload.createShippingManifest_RequestJSON(shippingManifestObj, route); 
           system.debug('requestPayload>>'+requestPayload);

        }
        Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
        /*Map<String,String> requestHeadersdata = new Map<String,String>();
        string typecont = 'Content-Type=application/json';
     string basic='Authorization=Basic d0Vsa0JRdmhiaUpyRThuODJSc2lweC00UzVWOFdLNVd1Q1J1b3pyM3VlRWdnNHlIOnZudEQ1bHBRY3V4VVRQNEdlWkl1RmVJem02UFZEbm5GcnVCbEpzbzl6ZzBvV0Z5cQ==';
       requestHeadersdata.put(basic,typecont);
                system.debug('requestHeadersdata>>'+requestHeadersdata); */
                system.debug('requestHeaders>>'+requestHeaders);

        HttpResponse httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);
        String response = httpResponse.getBody(); 
                   system.debug('response>>'+httpResponse.getstatuscode());

        if(httpResponse.getstatuscode() == 200){  if(eventType == 'INSERT'){
                List<Object> responseList=getAllTemplates();  for(Object  obj:responseList){
                    Map<String,Object> respMap= (Map<String,Object>)obj;
                    system.debug('respMap>>'+respMap);
                    if((String)respMap.get('Name')==shippingManifestObj.Name){if(respMap.containsKey('ManifestNumber')){ shippingManifestObj.Metrc_Manifest__c =(String)respMap.get('ManifestNumber'); shippingManifestObj.Metrc_HttpResponse__c='';  break;
                        }
                    }
                    
                }
                Metrc_Utility.IS_SHIPPINGMANIFEST_TRIGGER_ENABLED  =FALSE; Database.update(shippingManifestObj,true);
                return 'SUCCESS';
            }
        }else { 
            shippingManifestObj.Metrc_HttpResponse__c='Error Code:'+httpResponse.getstatuscode()+'-Error Message::'+response;  Metrc_Utility.IS_SHIPPINGMANIFEST_TRIGGER_ENABLED  =FALSE;              
            Database.update(shippingManifestObj,true);  return 'ERROR';
        }
        return '';
    }

    public static List<Object> getAllTemplates()
    {   
        String action ='GET';
        String endPointURL='';
        String requestPayload='';
        List<Object> responseList = new List<Object>();
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_transfers_template')+endPointMap.get('licenseNumber');
        Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
        HttpResponse httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);
        String response = httpResponse.getBody();  
        if(httpResponse.getstatuscode() == 200){   
            responseList = (List<Object>) JSON.deserializeUntyped(response);
        }
        return responseList;
    } 
    public static Map<String,Object> getSinglePackage(String metrc_packageID)
    {   
        String action ='GET';
        String endPointURL='';
        String requestPayload='';
        
        Map<String,Object> responseMap = new Map<String,Object>();
        
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_packages_getID')+endPointMap.get('licenseNumber');
        endPointURL= endPointURL.replace('{id}', metrc_packageID); 
        Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
        HttpResponse httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);
        String response = httpResponse.getBody();  
        if(httpResponse.getstatuscode() == 200){   
            responseMap = (Map<String,Object>)System.JSON.deserializeUntyped(response);
            
        }
        return responseMap ;
    }
    @future(callout=true)
    public static void createPackageFinish(String Name, String actualDate)
    {   
        String action ='POST';
        String endPointURL='';
        String requestPayload='';
        String uidName = Name;
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        Map<String,Object> responseMap = new Map<String,Object>();
        
        endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_packages_Finish')+endPointMap.get('licenseNumber');
        requestPayload = Metrc_RequestPayload.createPackageFinish_RequestJSON(Name,actualDate);
        
        Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
        HttpResponse httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);
        
        String response = httpResponse.getBody(); 
        UID__c customObjectList = [Select ID, Name,METRC_Status__c,METRC_Sync_status__c,Finished_Date__c,METRC_Lab_Status__c from UID__c where name=:Name];
        
        if(httpResponse.getstatuscode() == 200){
            customObjectList.METRC_Status__c = UID_METRC_STATUS_FINISHED;
            customObjectList.Finished_Date__c = System.today();
            customObjectList.METRC_Sync_status__c = UID_METRC_SYNC_STATUS;
            Database.update(customObjectList,true);
        }else{
            customObjectList.METRC_Sync_status__c ='Error Code:'+httpResponse.getstatuscode()+'-Error Message::'+response; Database.update(customObjectList,true);
        }
        
    }

    public static void BatchPackageFinish(list<string>metrc_PackageList, list<string> metrc_UIDList, list<Integer> metrc_QunatityList, list<UID__c> objectlist,list<UID__c> actualfilterList)
    {   
        String action ='POST';
        String endPointURL='';
        String requestPayload= '';
        Map<String,String> endPointMap=getMetrcIntegrationEndpoints();
        Map<String,String> requestHeaders = getHttpRequestHeaders();
        List<UID__c> uidList = new List<UID__c>();
        endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_packages_Finish')+endPointMap.get('licenseNumber');
        List<Metrc_IntegrationEndpoints__mdt> integrationEndpoints = [select id,MasterLabel,URL__c from Metrc_IntegrationEndpoints__mdt];
        
        for(Metrc_IntegrationEndpoints__mdt var : integrationEndpoints){
            integrationEndpointsMap.put(var.MasterLabel,var.URL__c);
        }
        integrationEndpointsMap.put('Metrc_Alert',Metrc_IntegrationSettings__C.getValues('Metrc_Alert').Value__c);
        String mailId = integrationEndpointsMap.get('Metrc_Alert');
        requestPayload = Metrc_RequestPayload.createBatchFinish_RequestJSON(objectlist);
        Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
        HttpResponse httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);
        String response = httpResponse.getBody(); 
        if(httpResponse.getstatuscode() == 200){
            for(UID__c uid: objectlist){  UID__c uidList1 = new UID__c(); uidList1.Finished_Date__c = System.today();
                uidList1.METRC_Sync_status__c = UID_METRC_SYNC_STATUS; uidList1.METRC_Status__c = UID_METRC_STATUS_FINISHED;
                uidList1.Available_Qty__c = 0;  uidList1.Id = uid.id; uidList.add(uidList1);
            }
            Database.update(uidList,true);
            MetrcAlertEmailManager.MetricAlertSuccess(mailId, metrc_PackageList, metrc_UIDList, metrc_QunatityList, objectlist,actualfilterList,'pass');  }else if(httpResponse.getstatuscode() == 400){ for(UID__c uid: objectlist)
            {   
                UID__c uidList1 = new UID__c(); uidList1.Finished_Date__c = System.today();
                uidList1.METRC_Sync_status__c ='Error Code:'+httpResponse.getstatuscode()+'-Error Message:: Package ' + uid.Name +' cannot be Finished because its not empty';
                uidList1.Id = uid.id; uidList.add(uidList1);
            }
            Database.update(uidList,true);  MetrcAlertEmailManager.MetricAlertSuccess(mailId, metrc_PackageList, metrc_UIDList, metrc_QunatityList, objectlist,actualfilterList,'fail');
            
        }
        
    }

}