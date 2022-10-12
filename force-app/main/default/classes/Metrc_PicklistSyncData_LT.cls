/**************************************************************************************
Apex Class Name    : Metrc_PicklistSyncData_LT
Test Class Name    : 
Version            : 1.0
Created Date       : 13/March/2020
Function           : Methods are getting called from LEX -Metrc_PicklistSync.cmp
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
* Suresha Shettigar                             15/Nov/2019              Added Exception handling.
*******************************************************************************/
public  with sharing class Metrc_PicklistSyncData_LT{

    @AuraEnabled
    public static Boolean checkUserMetrcAcsess(Id recID){
    
    List<PermissionSetAssignment> psList=[SELECT ID FROM PermissionSetAssignment WHERE AssigneeId = :Userinfo.getUserId() AND PermissionSet.Name = 'Metrc_Integration_Fields_Access'];
    if(psList.size()>0){ return true;} else { return false;}
    }
    
    @AuraEnabled
    public static  String syncDataToMetrcNew(Id picklistID,String objName){
    List<Picklist__c > picklistObj = Metrc_SOQLDML_Handler.getPicklistDetails(picklistID);
    system.debug('----------picklistObj --------------'+picklistObj);
     if(!picklistObj[0].Track_Trace_Sync__c && picklistObj[0].Status__c == 'QA Confirm'){
         system.debug('inside trace');
        //if any changes in these fields then only sync it to Metrc
        Metrc_PicklistTriggerHandler.syncDataToMetrc(picklistObj[0].ID,'INSERT');
		//
         return System.Label.PicklistSyncMsg;
    }else{
        system.debug('----------picklistObj ------else--------');
        return System.Label.PicklistSyncError;
    }
    
    }
    
   /*
    @AuraEnabled
    public static  String syncDataToMetrc_Transfer(Id recID,String objName){
        Metrc_ShippingManifestTriggerHandler.syncDataToMetrc(recID,'INSERT');
        return 'Sucessfully created';
    
    }*/
}