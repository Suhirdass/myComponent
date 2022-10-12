/**************************************************************************************
Apex Class Name    : StrainTriggerHandler 
Test Class Name    : 
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : used for StrainTrigger businesslogic execute 
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
*******************************************************************************/
public with sharing class Metrc_StrainTriggerHandler {
    
    public static void afterInsert(List<Strain__c> strainList){
        for(Strain__c strainObj:strainList){
            if(strainObj.Track_Trace_Sync__c && strainObj.isActive__c && strainObj.Metrc_StrainID__c == null){
                syncDataToMetrc(strainObj.ID,'INSERT');
            }
        }
        
    }
    public static void afterUpdate(List<Strain__c> strainList,Map<ID,Strain__c> oldMap){
         for(Strain__c strainObj : strainList){
            if(strainObj.Track_Trace_Sync__c){
                if(strainObj.isActive__c && strainObj.Metrc_StrainID__c != null && strainObj.Name != oldMap.get(strainObj.ID).Name){
                    //if any changes in these fields then only sync it to Metrc
                        syncDataToMetrc(strainObj.ID,'UPDATE');
                }else if(!strainObj.isActive__c && strainObj.Metrc_StrainID__c != null){
                    syncDataToMetrc_Delete(strainObj.ID);
                }
            }
        
        }
        }
        
    @future(callout=true)
    public static void syncDataToMetrc(ID strainID,String eventType){
        Strain__c  strain = Metrc_SOQLDML_Handler.getStrains(strainID);
   //     Metrc_HttpCalloutHelper.CreateStrain(strain.ID,strain,eventType);
    }
    
    @future(callout=true)
    public static void syncDataToMetrc_Delete(ID strainID){
        Strain__c  strain = Metrc_SOQLDML_Handler.getStrains(strainID);
        Metrc_HttpCalloutHelper.deleteMetrcRecord(strain.ID,'Metrc_strains_deleteID');
        //Metrc_strains_deleteID -->Passing the URL from Metrc_IntegrationEndpoints__mdt.Metrc_strains_deleteID
    }
}