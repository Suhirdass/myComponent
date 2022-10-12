/**************************************************************************************
Apex Class Name    : Metrc_ProductTriggerHandler 
Test Class Name    : 
Version            : 1.0
Created Date       : 13/Sep/2019
Function           : used for StrainTrigger businesslogic execute 
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresha Shettigar                             13/Sep/2019              Original Version
*******************************************************************************/
public with sharing class Metrc_ProductTriggerHandler {
    public static void afterInsert(List<Product2> productList){
        for(Product2 prodObj:productList){
                    Id productRecordTypeID   = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Product').getRecordTypeId();

            if(prodObj.Track_Trace_Sync__c && prodObj.RecordTypeId == productRecordTypeID){ syncDataToMetrc(prodObj.ID,'INSERT'); }
        }
        
    }
    public static void afterUpdate(List<Product2> productList,Map<ID,Product2> oldMap){
        for(Product2 prodObj:productList){
              Id productRecordTypeID   = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Product').getRecordTypeId();
            if(prodObj.Track_Trace_Sync__c && prodObj.RecordTypeId == productRecordTypeID){
                if(prodObj.IsActive && prodObj.Metrc_ItemID__c != null){
                    //if any changes in these fields then only sync it to Metrc
                    if(prodObj.Track_Trace_Category__c != oldMap.get(prodObj.ID).Track_Trace_Category__c ||prodObj.Name != oldMap.get(prodObj.ID).Name || prodObj.Metrc_UOM__c != oldMap.get(prodObj.ID).Metrc_UOM__c ||prodObj.Strain__c != oldMap.get(prodObj.ID).Strain__c  ||prodObj.Unit_Net_Weight__c != oldMap.get(prodObj.ID).Unit_Net_Weight__c){
                        syncDataToMetrc(prodObj.ID,'UPDATE');
                    }
                }else if(!prodObj.IsActive && prodObj.Metrc_ItemID__c != null){ syncDataToMetrc_Delete(prodObj.ID); }
            }
        
        }
        }
    @future(callout=true)
    public static void syncDataToMetrc(ID prodID,String eventType){
        Product2  prodObj = Metrc_SOQLDML_Handler.getProduct(prodID);
       // Metrc_HttpCalloutHelper.createProduct(prodObj.ID,prodObj,eventType);
    }
    
    @future(callout=true)
    public static void syncDataToMetrc_Delete(ID prodID){
        Product2  prodObj  = Metrc_SOQLDML_Handler.getProduct(prodID);
        Metrc_HttpCalloutHelper.deleteMetrcRecord(prodObj.ID,'Metrc_items_deleteID');
        //Metrc_items_deleteID -->Passing the URL from Metrc_IntegrationEndpoints__mdt.Metrc_items_deleteID
    }
}