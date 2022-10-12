/**************************************************************************************
Apex Class Name    : Metrc_PicklistTriggerHandler 
Test Class Name    : 
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : used for Metrc_PicklistTriggerHandler businesslogic execute 
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
*******************************************************************************/
public with sharing class Metrc_PicklistTriggerHandler {
    
    public static void afterUpdate(List<Picklist__c> picklist_List,Map<ID,Picklist__c> oldMap){
        for(Picklist__c picklistObj : picklist_List){
            if(picklistObj.Track_Trace_Sync__c && oldMap.get(picklistObj.ID).Track_Trace_Sync__c != picklistObj.Track_Trace_Sync__c){
               //if the flag is true ,update the picklist line package id
               updatepackageIDtoLineItem(picklistObj.ID);  //uncomment after checking with Vijay
            }
            if(picklistObj.Status__c == 'Cancelled'){
                //if any changes in these fields then only sync it to Metrc
                updatePicklistline_packoutUID(picklistObj.ID);
            }
        }
    }
        

    public static void syncDataToMetrc(ID picklistID,String eventType){
        system.debug('syncDataToMetrchandler');
        List<Picklist_Line__c> picklist_List = Metrc_SOQLDML_Handler.getPicklistLine(picklistID);
        
        Metrc_HttpCalloutHelper.createPicklist(picklistID,picklist_List,eventType);
    }
    

    public static void updatePicklistline_packoutUID(ID picklistID){
        List<String> UidList = new List<String>();
        List<Picklist_Line__c> picklist_List = Metrc_SOQLDML_Handler.getCancelledPicklistLine(picklistID);
        for(Picklist_Line__c obj:picklist_List ){
           UidList.add(obj.Pack_out_UID__c);
           //obj.Pack_out_UID__c=null;
        }
         system.debug('------------picklist_List ----------1--'+picklist_List );
        
        system.debug('------------UidList------------'+UidList);
        List<UID__c> objList = Metrc_SOQLDML_Handler.getUIDTagList(UidList);
        system.debug('------------objList ------------'+objList );
        for(Picklist_Line__c obj2:picklist_List ){
           //UidList.add(obj.Pack_out_UID__c);
           obj2.Pack_out_UID__c=null;
        }
        system.debug('------------picklist_List ------------'+picklist_List );
        
        for(UID__c var: objList ){
            var.In_Use__c = false;
        }
        
        update picklist_List;
        update objList;
    system.debug('objList>>'+objList);    
    }
    
    @future(callout=true)
    public static void updatepackageIDtoLineItem(ID picklistID){
    boolean isMetrcIDUpdated =false;  
       List<Picklist_Line__c> PicklistLine_List = Metrc_SOQLDML_Handler.getPicklistLine(picklistID);
       List<String> packoutUIDList= new List<String>();
       for(Picklist_Line__c var: PicklistLine_List){
           packoutUIDList.add(var.Pack_out_UID__c);
       }
        //create a map of <UID,Tag>
       Map<ID,String> packoutUIDMap = Metrc_SOQLDML_Handler.getUIDTagMap(packoutUIDList);
        
       isMetrcIDUpdated = Metrc_HttpCalloutHelper.updateMetrcPackageID(PicklistLine_List,packoutUIDMap,picklistID); 
       system.debug('------updatepackageIDtoLineItem------retry call-1-----------'+isMetrcIDUpdated );
       if(!isMetrcIDUpdated) {
           system.debug('------updatepackageIDtoLineItem------retry call---2---------' );
           Metrc_HttpCalloutHelper.updateMetrcPackageID(PicklistLine_List,packoutUIDMap,picklistID); //retry the API call for updating the Metrc packageid.
       }     
    }
}