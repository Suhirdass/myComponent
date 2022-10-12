/**
 * Copyright (c) 2021 Filigreen Distro
 * All rights reserved.
 * MetrcTagUploadCtlr
 * MetrcTagUploadCtlrTest
 */
public with sharing class MetrcTagUploadCtlr {
    
    public static List<UID__c> lstuids{get;set;}
    public static set<Tags> TagsItems{get;set;}
        public Map<id, String> getSite { get; set; }

    public Static String ERR_MSG_UID_CHARCTER{
        get{
            return String.isNotBlank(ERR_MSG_UID_CHARCTER) ? ERR_MSG_UID_CHARCTER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','Err_Msg_UID_Char');
        }set;
    }
    
    public Static String UID_STATUS_NEW{
        get{
            return String.isNotBlank(UID_STATUS_NEW) ? UID_STATUS_NEW : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','UID_Status_New');
        }set;
    }
     
     public Static String UID_STATUS_ALREDAY_EXIST{
        get{
            return String.isNotBlank(UID_STATUS_ALREDAY_EXIST) ? UID_STATUS_ALREDAY_EXIST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','UID_Status_Alrady_Exist');
        }set;
    } 
    public Static String UID_STATUS_ACTIVE_YES{
        get{
            return String.isNotBlank(UID_STATUS_ACTIVE_YES) ? UID_STATUS_ACTIVE_YES : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('UID','UID_Status_Active_Yes');
        }set;
    }
    
    // Constructor
    public MetrcTagUploadCtlr()
    {
        
    }
    
    
     @AuraEnabled
    public static AuraResponse getActiveSite(string SiteNames){
        AuraResponse r = new AuraResponse('MetrcTagUploadCtlr.getActiveSite()');
        MetrcTagUploadCtlr assign = new MetrcTagUploadCtlr();
        assign.getSite = getSite();
        r.data.put('getSite', assign.getSite);
        return r;	
    }  
    
    
    
    
    
    
    
    
    //comparing uploading files tag into server side is that new tag or existing tag 
    
    @AuraEnabled
    public static AuraResponse gettags(String paymentsData){
        AuraResponse r = new AuraResponse('MetricTagUploadCtlr.gettags()');
       
        List<Tags> Taglst = (List<Tags>)JSON.deserialize(paymentsData, List<Tags>.class);
        set<string> AllTags = new set<string>();
        map<string,UID__c> mapUIDs = new map<string,UID__c>();
        List<UID__c> ProducaoList  = new List<UID__c>();
        TagsItems = new set<Tags>(); 
        for(Tags p:Taglst){
            AllTags.add(p.Tag);
        }
        
        For(UID__c lstuids : [select id , name from UID__c where name =:AllTags])
        {
            mapUIDs.put(lstuids.Name,lstuids);
        }   
        ProducaoList.addAll(mapUIDs.values());    
        
        for(Tags tdata:Taglst)
        {
            if(! mapUIDs.containsKey(tdata.Tag)) 
            {
                tdata.StatusUID = UID_STATUS_NEW;
                tdata.ActiveUID = UID_STATUS_ACTIVE_YES; 
                tdata.IRRUID = UID_STATUS_ACTIVE_YES; 
            }
            else
            { 
                tdata.Tagid ='' ;
                tdata.StatusUID = UID_STATUS_ALREDAY_EXIST; 
                tdata.ActiveUID = UID_STATUS_ACTIVE_YES; 
                tdata.IRRUID = UID_STATUS_ACTIVE_YES; 
            }
            TagsItems.add(tdata);  
        }
        r.data.put('TagsItems',TagsItems);
        r.data.put('Id',ProducaoList);
        
        return r;
    }
   
    // saving tag into uid object 
    @AuraEnabled 
    public static AuraResponse Savetags(String tagsvalues,String Siteids){
        system.debug('Siteids>'+Siteids);
        gettags(tagsvalues);
        AuraResponse r = new AuraResponse('MetricTagUploadCtlr.gettags()'); 
        List<Tags> tagobj = new List<Tags>();
        List<Tags> Taglstval = (List<Tags>)JSON.deserialize(tagsvalues, List<Tags>.class);
        List<UID__c> createUID = new List<UID__c>();
        List<string>errortags = new List<string>();
        List<String> successBillSuppliers=new List<String>(); 
        List<String> errors = new List<String>();
        for(Tags tagdata: TagsItems){
            String myStr = tagdata.Tag;
            Integer result = myStr.length();
            if(result <24 || result > 24) { 
                errors.add(String.format(ERR_MSG_UID_CHARCTER,new List<String>{String.valueOf(tagdata.Tag)}));
            }
            else if(tagdata.StatusUID == UID_STATUS_NEW )
            {
                UID__c UIDObj = new UID__c(
                    Name = tagdata.Tag,
                    IRR_UID__c = True,
                    Active__c =True,
                    Site__c=Siteids
                );
                
                createUID.add(UIDObj); 
                successBillSuppliers.add(tagdata.Tag);
                r.data.put('successBillSuppliers', successBillSuppliers);
            }
        } 
        r.data.put('error', String.join(errors, ', ')); 
        // validation on less then and  greater then 24 charcter
        if(errortags.size()== 0)
        {
            if(!createUID.isEmpty()){	insert createUID;
                system.debug('createUID>>'+createUID);
                r.data.put('message', createUID.size());
            }
        }
        
        return r ;
    }
    
    @AuraEnabled
    public static  Map<id, String> getSite(){
               Map<id, String> optionsbank = new Map<id, String>();
                 List <Site__c > lstsub= [select id,name,Active__c from Site__c where Active__c =true];
        for(Site__c bb : lstsub){ 
            optionsbank.put(bb.id,bb.name);
        }
                system.debug('RecordId>>'+optionsbank);

        return optionsbank;
    }
    
   
    
    // Wrapper class    
    public class Tags{
        @AuraEnabled  public String Tag {get;set;}
        @AuraEnabled public String ActiveUID {get;set;}
        @AuraEnabled public String IRRUID {get;set;}
        @AuraEnabled public String StatusUID {get;set;}
        @AuraEnabled public String Tagid {get;set;}
        
    }
}