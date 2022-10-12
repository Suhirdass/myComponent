/**************************************************************************************
Apex Class Name    : Metrc_SyncData_LT 
Test Class Name    : 
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : Methods are getting called from LEX -Metrc_SyncData.cmp
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
* Suresha Shettigar                             15/Nov/2019              Added Exception handling.
*******************************************************************************/
public  with sharing class Metrc_SyncData_LT {

    public static boolean TTGSActiveValidationTrigger = False;
    private Static String TTGS_INACTIVE_DATA{
        get{
            return String.isNotBlank(TTGS_INACTIVE_DATA) ? TTGS_INACTIVE_DATA: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Strain','TTFG_Strain_InActive');
        }set;
    }
     private Static String STRAIN_INACTIVE_DATA{
        get{
            return String.isNotBlank(STRAIN_INACTIVE_DATA) ? TTGS_INACTIVE_DATA: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Strain','Strain_Inactive');
        }set;
    }
    @AuraEnabled
    public static Boolean checkUserMetrcAcsess(Id recID){
        List<PermissionSetAssignment> psList=[SELECT ID FROM PermissionSetAssignment WHERE AssigneeId = :Userinfo.getUserId() AND PermissionSet.Name = 'Metrc_Integration_Fields_Access'];
        if(psList.size()>0){ return true;} else { return false;}
    }
    
    @AuraEnabled
    public static  String syncDataToMetrcNew(Id recID,String objName){
        String message='';
        
        string namesstrain;
        if(objName == 'Strain__c'){
            List<TTGS_Strain__c>  TTGSstrainObj= Metrc_SOQLDML_Handler.getTTGSStrainswithids(recID);
            List<TTGS_Strain__c> listdata = new List<TTGS_Strain__c> ();
            List<TTGS_Strain__c> nullstrainids = new List<TTGS_Strain__c> ();
            List<TTGS_Strain__c> withoutmetrcids = new List<TTGS_Strain__c> ();
            List<TTGS_Strain__c> validatedata = new List<TTGS_Strain__c> ();
            Strain__c  strainObj= Metrc_SOQLDML_Handler.getStrains(recID); 
      List<TTGS_Strain__c> ttgsStrainDataallinactive =[select id,name,TTGS_Response__c,Strain__c,Site__c,Site__r.Name,Active__c,Strain__r.name,License_Number__c,TTGS_StrainID__c  FROM TTGS_Strain__c WHERE Active__c = False AND Strain__c=:strainObj.Id];
            if(ttgsStrainDataallinactive.size() == TTGSstrainObj.size()){
                message= TTGS_INACTIVE_DATA;  }else{ if(strainObj.isActive__c == true && TTGSstrainObj.size()>0  ){  Set<Id> ttgsIds =  new Set<Id>(); List<TTGS_Strain__c> ttgsStrainData = new List<TTGS_Strain__c>(); List<TTGS_Strain__c> intiallistdata = new List<TTGS_Strain__c>();
                ttgsStrainData =[select id,name,TTGS_Response__c,Strain__c,Site__c,Site__r.Name,Active__c,Strain__r.name,License_Number__c,TTGS_StrainID__c FROM TTGS_Strain__c WHERE Active__c = True AND Strain__c=:strainObj.Id];
                for(TTGS_Strain__c resVal : ttgsStrainData){ ttgsIds.add(resVal.Site__c);
                }
                if(ttgsIds.size() > 0){ for(TTGS_Strain__c resttgsVal : [select id,name,TTGS_Response__c,Strain__c,Site__c,Site__r.Name,Active__c,Strain__r.name,License_Number__c,TTGS_StrainID__c FROM TTGS_Strain__c WHERE Site__c IN :ttgsIds AND Strain__c=:strainObj.Id]){intiallistdata.add(resttgsVal);
                    }
                }
                for(TTGS_Strain__c  ttgs :intiallistdata)  {    namesstrain = ttgs.id;  if(ttgs.TTGS_StrainID__c == null && ttgs.Active__c== true){nullstrainids.add(ttgs) ;
                    }
                    if(ttgs.TTGS_StrainID__c !=null && ttgs.Active__c== true){  validatedata.add(ttgs);  } else{  withoutmetrcids.add(ttgs);
                    }
                }
            if(validatedata.size() == TTGSstrainObj.size()){   message = Metrc_HttpCalloutHelper.CreateTTGSStrain(TTGSstrainObj,'UPDATE',namesstrain,null);
                
            }
            else if(nullstrainids.size() == TTGSstrainObj.size()){ message = Metrc_HttpCalloutHelper.CreateTTGSStrain(nullstrainids,'INSERT',namesstrain,null); 
            } else if(validatedata.size() != TTGSstrainObj.size()) {  message = Metrc_HttpCalloutHelper.getAllStrainsTGS(withoutmetrcids,false); } }else{ message= STRAIN_INACTIVE_DATA;     
            } 
          }
        
        }
        if(objName == 'Product2'){
            
         Map<string,TTGS_Item__c> mappobj = new Map<string,TTGS_Item__c>();
            List<TTGS_Item__c>  TTGSItemObj= Metrc_SOQLDML_Handler.getTTGSItemswithids(recID);
            List<TTGS_Item__c> validatedata = new List<TTGS_Item__c> ();
            List<TTGS_Item__c> nullItemids = new List<TTGS_Item__c> ();
            List<TTGS_Item__c> withoutmetrcids = new List<TTGS_Item__c> ();
            Product2  ProdObj= Metrc_SOQLDML_Handler.getProduct(recID);
            if(ProdObj.IsActive == true && TTGSItemObj.size()>0){ for(TTGS_Item__c  ttgi :TTGSItemObj)  { namesstrain =ttgi.Product_Name__c;  if(ttgi.TTGS_ItemID__c == null){nullItemids.add(ttgi) ;
                }
                if(ttgi.TTGS_ItemID__c !=null){ validatedata.add(ttgi);  } else{ withoutmetrcids.add(ttgi);

                }
            }
            if(validatedata.size() == TTGSItemObj.size()){  message = Metrc_HttpCalloutHelper.createTTGSItem(TTGSItemObj,'UPDATE',namesstrain,null);  }
               else if(nullItemids.size() == TTGSItemObj.size()){  message = Metrc_HttpCalloutHelper.createTTGSItem(nullItemids,'INSERT',namesstrain,null);
            }
                 else if(validatedata.size() != TTGSItemObj.size())  {for(TTGS_Item__c  itemvalid :withoutmetrcids){ message = Metrc_HttpCalloutHelper.getAllItemsTGS(withoutmetrcids);
                            system.debug('diff size'+withoutmetrcids);   
                        
                    }
                   

    
            }
            
            }
            else{
               message= 'Error#:Please enable the Active flag & try.';
            } 
            
            
       
            
        }
        return message;

    }
   
  
    
    
    
    
    @AuraEnabled
    public static  String syncMetrcDataToSFDC(Id recID,String objName){
        
        if(objName == 'Strain__c'){List<TTGS_Strain__c>  TTGSstrainObj= Metrc_SOQLDML_Handler.getTTGSStrainswithids(recID);return metrc_PullTTGSbulkRecord(TTGSstrainObj);
        }
        return null;
         /*   if(objName == 'Product2'){
             Product2  prodObj = Metrc_SOQLDML_Handler.getProduct(recID);
            
        if(prodObj.IsActive && prodObj.Metrc_ItemID__c != null ){
               return metrc_PullProductSingleRecord(prodObj);
            }else return 'Error :please check the Active flag & Metrc_ItemID';
        } else return 'syncMetrcDataToSFDC-Error while syncing the data !';
        
      if(objName == 'Product2'){
            
           // List<TTGS_Item__c>  TTGSItemObj= Metrc_SOQLDML_Handler.getTTGSItemswithids(recID);
            // return metrc_PullTTGSbulkRecordTTGSItem(TTGSItemObj);
        }*/
    }  
    
    
    
    
   
    
    
     public static String metrc_PullTTGSbulkRecord(List<TTGS_Strain__c>  TTGSstrainObj) {
      Map<String,Object> respMap = new  Map<String,Object>();
      List<TTGS_Strain__c> strainList = new List<TTGS_Strain__c>();
         for(TTGS_Strain__c TTGSObj :TTGSstrainObj ){
             if(TTGSObj.Active__c == true){
                 
           
             system.debug('TTGSObj++'+TTGSObj);
             String action ='GET';
             String endPointURL='';
             String requestPayload='';
             
             //   Map<String,Object> respMap = new Map<String,Object>();
             // Map<String,Object> responseMap = new Map<String,Object>();
             
             Map<String,String> endPointMap=Metrc_HttpCalloutHelper.getMetrcIntegrationEndpoints();
             Map<String,String> requestHeaders = Metrc_HttpCalloutHelper.getHttpRequestHeaders();
             endPointURL= endPointMap.get('baseURL')+endPointMap.get('Metrc_strains_getID')+TTGSObj.License_Number__c;
             endPointURL= endPointURL.replace('{id}', TTGSObj.TTGS_StrainID__c);  //update the metrc_strainID in URL string
             system.debug('endPointURL>>>'+endPointURL);
             Metrc_HttpCallout httpcallout = new Metrc_HttpCallout();
             HttpResponse httpResponse = httpcallout.SendRequest(action,endPointURL,requestPayload,requestHeaders);
             String response = httpResponse.getBody();  
             if(httpResponse.getstatuscode() == 200){    respMap = (Map<String,Object>) JSON.deserializeUntyped(response); if(test.isrunningtest()){ respMap =(Map<String,Object>)JSON.deserializeUntyped('{"Id": 293315,"Name":"'+TTGSObj.Strain__r.Name+'","IsUsed":"true","CbdLevel":"1","ThcLevel":"2","IndicaPercentage":"3","SativaPercentage":"4"}');
             }else{
        if(respMap.containsKey('Id')){TTGSObj.Strain__r.Name =string.valueof(respMap.get('Name')); if(respMap.get('ThcLevel') !=null){TTGSObj.THC_Level__c=Integer.valueof(respMap.get('ThcLevel'));  }else TTGSObj.THC_Level__c=0.0;
                if(respMap.get('CbdLevel') !=null){ TTGSObj.CBD_Level__c=Integer.valueof(respMap.get('CbdLevel')); }else TTGSObj.CBD_Level__c=0.0; if(respMap.get('IndicaPercentage') !=null){TTGSObj.Indica_Percentage__c=Integer.valueof(respMap.get('IndicaPercentage')); }else TTGSObj.Indica_Percentage__c=0.0;
                if(respMap.get('SativaPercentage') !=null){ TTGSObj.Sativa_Percentage__c=Integer.valueof(respMap.get('SativaPercentage')); }else TTGSObj.Sativa_Percentage__c=0.0;strainList.add(TTGSObj);Metrc_Utility.IS_STRAIN_TRIGGER_ENABLED =FALSE;
        }
             }
         }
             }
             }
           Metrc_HttpCalloutHelper.TTGSActiveValidationTrigger = true;
          upsert strainList;
         
         system.debug('strainList>>'+strainList);

       return null;
       
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   /* public static String metrc_PullTTGSbulkRecordTTGSItem(List<TTGS_Item__c>  TTGSItemObj) {
      List<TTGS_Item__c> ProductUpdateList = new List<TTGS_Item__c>();

                Map<String,Object> respMap = new  Map<String,Object>();
        Map<String,Object> metrc_WeightUOM_Mapping = (Map<String,Object>) JSON.deserializeUntyped(system.label.Metrc_WeightUOM_Mapping);

         for(TTGS_Item__c TTGSObj :TTGSItemObj ){
             system.debug('TTGSObj++'+TTGSObj);
            
              Http http = new Http();
             HttpRequest req = new HttpRequest();
               string Prodnames = TTGSObj.Product_Name__r.Name;
             String encoded = EncodingUtil.urlEncode(Prodnames, 'UTF-8');
             req.setEndpoint('https://wovn-utility.herokuapp.com/metrc_data?ObjectName=Product2&ObjectValue='+encoded+'&LicenseNumber='+TTGSObj.License_Number__c);  
             req.setHeader('Content-Type', 'application/Json');
             req.setBody('');
             req.setMethod('GET');
             req.setTimeout(120000);
             HttpResponse res = http.send(req);
             String responseget = res.getBody();
             system.debug('response'+responseget); 
             respMap = (Map<String, Object>)JSON.deserializeUntyped(responseget);
              if(res.getstatuscode() == 200){   respMap = (Map<String,Object>) JSON.deserializeUntyped(responseget);
        if(test.isrunningtest()){ 
            //respMap =(Map<String,Object>)JSON.deserializeUntyped('{"Id": 293315,"Name":"'+TTGSObj.Strain__r.Name+'","IsUsed":"true","CbdLevel":"1","ThcLevel":"2","IndicaPercentage":"3","SativaPercentage":"4"}');
             }else{
        if(respMap.containsKey('Id')){ TTGSObj.Product_Name__r.Name =string.valueof(respMap.get('Name'));
               // TTGSObj.Track_Trace_Category__c =string.valueof(respMap.get('ProductCategoryName'));
                if(metrc_WeightUOM_Mapping.containsKey(string.valueof(respMap.get('UnitOfMeasureName')))){
                TTGSObj.UOM__c =string.valueof(metrc_WeightUOM_Mapping.get(string.valueof(respMap.get('UnitOfMeasureName')))); 
                } //changed from Net_Weight_UOM__c -->Cannabis_Weight_UOM__c
                if(string.valueof(respMap.get('UnitVolumeUnitOfMeasureName')) != null){
                    ProductObj.Unit_Of_Measure__c=string.valueof(respMap.get('UnitVolumeUnitOfMeasureName'));
                    ProductObj.Unit_Net_Weight__c =double.valueof(respMap.get('UnitVolume'));
                }else if(string.valueof(respMap.get('UnitWeightUnitOfMeasureName')) != null){
                    ProductObj.Unit_Net_Weight__c =double.valueof(respMap.get('UnitWeight'));
                    ProductObj.Unit_Of_Measure__c=string.valueof(respMap.get('UnitWeightUnitOfMeasureName'));
                }
                //ProductObj.IsActive =Boolean.valueof(respMap.get('IsUsed'));
                if(strainObjList !=null && strainObjList.size()>0){
                ProductObj.Strain__c =strainObjList[0].ID; 
                }
                ProductUpdateList.add(TTGSObj);
            
system.debug('ProductUpdateList>>'+ProductUpdateList);
        }
             }
         }
                 
             }

       return null;
       
    }  */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /* public static String metrc_PullProductSingleRecord(Product2 ProductObj) {
     try{
        Map<String,Object> respMap = Metrc_HttpCalloutHelper.getSingleProducts(ProductObj.Metrc_ItemID__c);
        List<Product2> ProductUpdateList = new List<Product2>();
        List<Strain__c> strainObjList = Metrc_SOQLDML_Handler.getSingleStrain_metrcID(string.valueof(respMap.get('StrainId')));
        Map<String,Object> metrc_WeightUOM_Mapping = (Map<String,Object>) JSON.deserializeUntyped(system.label.Metrc_WeightUOM_Mapping);
        if(respMap.containsKey('Id') || test.isrunningtest()){
                ProductObj.Name =string.valueof(respMap.get('Name'));
                ProductObj.Track_Trace_Category__c =string.valueof(respMap.get('ProductCategoryName'));
                if(metrc_WeightUOM_Mapping.containsKey(string.valueof(respMap.get('UnitOfMeasureName')))){
                ProductObj.Net_Weight_UOM__c =string.valueof(metrc_WeightUOM_Mapping.get(string.valueof(respMap.get('UnitOfMeasureName')))); 
                } //changed from Net_Weight_UOM__c -->Cannabis_Weight_UOM__c
                if(string.valueof(respMap.get('UnitVolumeUnitOfMeasureName')) != null){
                    ProductObj.Unit_Of_Measure__c=string.valueof(respMap.get('UnitVolumeUnitOfMeasureName'));
                    ProductObj.Unit_Net_Weight__c =double.valueof(respMap.get('UnitVolume'));
                }else if(string.valueof(respMap.get('UnitWeightUnitOfMeasureName')) != null){
                    ProductObj.Unit_Net_Weight__c =double.valueof(respMap.get('UnitWeight'));
                    ProductObj.Unit_Of_Measure__c=string.valueof(respMap.get('UnitWeightUnitOfMeasureName'));
                }
                //ProductObj.IsActive =Boolean.valueof(respMap.get('IsUsed'));
                if(strainObjList !=null && strainObjList.size()>0){
                ProductObj.Strain__c =strainObjList[0].ID; 
                }
                ProductUpdateList.add(ProductObj);
                Metrc_Utility.IS_PROD_TRIGGER_ENABLED =FALSE;
                Database.update(ProductUpdateList,true);
                return 'Successfully updated the product data.';
        }else{ return 'PullProductSingleRecord-Error while syncing the data !'+respMap;}
        }catch(Exception ex){
            return 'Error while syncing the data !'+ex;
        }
       
    }*/
    
}