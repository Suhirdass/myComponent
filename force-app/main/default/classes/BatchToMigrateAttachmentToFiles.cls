global class BatchToMigrateAttachmentToFiles implements Database.Batchable<sObject>, Database.Stateful, Schedulable{
	Integer processedCount = 0;
    String lastNMonths 	= FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Attachment','Last_N_Months');
    String objName 		= FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Attachment','Object_Name');
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        String query = 'SELECT Id, Name, Body,OwnerId,Description, ContentType, ParentId From Attachment WHERE Description = NULL AND createddate = LAST_N_MONTHS:'+lastNMonths;
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext bc, List<Attachment> records){
        
        Map<Id,List<ContentVersion>> mapContentVersion = new Map<Id,List<ContentVersion>>();
        List<Attachment> processedAttachments = new List<Attachment>();
        for(Attachment attach : records){
            if(processedCount <5000){
                String sObjName = attach.ParentId.getSObjectType().getDescribe().getName();
                if(sObjName == objName){
                    processedCount++;
                    //Insert ContentVersion
                    ContentVersion cVersion = new ContentVersion();
                    cVersion.ContentLocation = 'S'; //S-Document is in Salesforce. E-Document is outside of Salesforce. L-Document is on a Social Netork.
                    cVersion.PathOnClient = attach.Name;//File name with extention
                    cVersion.Origin = 'H';//C-Content Origin. H-Chatter Origin.
                    cVersion.FirstPublishLocationId  = userinfo.getUserId();//Owner of the file
                    cVersion.Title = attach.Name;//Name of the file
                    cVersion.VersionData = attach.Body;//File content
                    if(mapContentVersion.containsKey(attach.ParentId)){
                        List<ContentVersion> lstcv = mapContentVersion.get(attach.ParentId);
                        lstcv.add(cVersion);
                        mapContentVersion.put(attach.ParentId,lstcv);
                    } else {
                        mapContentVersion.put(attach.ParentId,new List<ContentVersion>{cVersion});
                    }
                    attach.Description = System.Now().format('MM/dd/yyyy HH:mm:ss');
                    processedAttachments.add(attach);
                }
            }else{
                break;
            }
            
        }
        
        if(mapContentVersion.size() > 0){
            records.clear();
            //insert mapContentVersion.values();
            List<ContentVersion> recordsLst = new List<ContentVersion>();
            for(List<ContentVersion> cv : mapContentVersion.values())
                recordsLst.addAll(cv);
			insert recordsLst;
            
            Set<Id> cvIds = new Set<Id>();
            Map<Id,Id> mapCVIds = new Map<Id,Id>();
            for(Id attchId : mapContentVersion.keySet()){
                for(ContentVersion cv : mapContentVersion.get(attchId)){
                    mapCVIds.put(cv.Id,attchId);
                }
            }
            
            List<ContentDocumentLink> cdlList = new List<ContentDocumentLink>();
            
            for(ContentVersion cv : [SELECT ContentDocumentId,Id FROM ContentVersion WHERE Id IN :mapCVIds.keySet()]){
                //Insert ContentDocumentLink
                ContentDocumentLink cDocLink = new ContentDocumentLink();
                cDocLink.ContentDocumentId = cv.ContentDocumentId;//Add ContentDocumentId
                cDocLink.LinkedEntityId = mapCVIds.get(cv.Id);//Add attachment parentId
                cDocLink.ShareType = 'I';//V - Viewer permission. C - Collaborator permission. I - Inferred permission.
                cDocLink.Visibility = 'InternalUsers';//AllUsers, InternalUsers, SharedUsers
                cdlList.add(cDocLink);
            }
            
            if(cdlList.size() > 0){
	        	insert cdlList;
                update processedAttachments;
            }
        }
    }
    
    global void finish(Database.BatchableContext bc){ } 
    
    global void execute(SchedulableContext sc){}
}