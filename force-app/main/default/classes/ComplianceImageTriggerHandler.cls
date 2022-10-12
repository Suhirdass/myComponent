public class ComplianceImageTriggerHandler {
	
    private static String LAB_TEST_STATUS_TESTED_PASSED{
        get{
            return String.isNotBlank(LAB_TEST_STATUS_TESTED_PASSED) ? LAB_TEST_STATUS_TESTED_PASSED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Compliance Images','Lab_Test_Status_Tested_Passed');
        }set;
    }
    private static String LAB_TEST_STATUS_TESTED_FAILED{
        get{
            return String.isNotBlank(LAB_TEST_STATUS_TESTED_FAILED) ? LAB_TEST_STATUS_TESTED_FAILED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Compliance Images','Lab_Test_Status_Tested_Failed');
        }set;
    }
    
    public static void afterInsert(Compliance_Images__c[] newList){
    	Set<Id> batchIds = new Set<Id>();
        Set<Id> bIds = new Set<Id>();
        Set<Id> compIds = new Set<Id>();
        for(Compliance_Images__c com : newList){
            if(com.COA_Expiration_Date__c >= Date.today() && (com.Lab_Test_Status__c == LAB_TEST_STATUS_TESTED_FAILED || com.Lab_Test_Status__c == LAB_TEST_STATUS_TESTED_PASSED)){
            	if(com.Harvest_Batch_Code__c != null) batchIds.add(com.Harvest_Batch_Code__c);    
            }
            if(com.Harvest_Batch_Code__c != null) bIds.add(com.Harvest_Batch_Code__c);
            
            if(com.Send_Email__c){
            	compIds.add(com.Id);    
            }
        }
        if(batchIds.size() > 0){
        	ComplianceImageTriggerHandler.updateCompFields(batchIds);    
        }
        if(bIds.size() > 0){
            //ComplianceImageTriggerHandler.updateBatchFields(bIds);
        }
        if(compIds.size() > 0){
        	//ComplianceImageTriggerHandler.sendEmailOnLabStatusPassed(compIds);    
        }
    }
    
    public static void afterUpdate(Compliance_Images__c[] newList,Map<Id,Compliance_Images__c> oldMap){
    	Set<Id> batchIds = new Set<Id>();
        Set<Id> compIds = new Set<Id>();
        for(Compliance_Images__c com : newList){
            if(com.COA_Expiration_Date__c >= Date.today() && (com.COA_Expiration_Date__c != oldMap.get(com.Id).COA_Expiration_Date__c ||
                                                              com.THC__c != oldMap.get(com.Id).THC__c ||
                                                              com.THC_MG_G__c != oldMap.get(com.Id).THC_MG_G__c ||
                                                              com.Terpene__c != oldMap.get(com.Id).Terpene__c ||
                                                              com.Terpene_MG_G__c != oldMap.get(com.Id).Terpene_MG_G__c ||
                                                              com.CBD__c != oldMap.get(com.Id).CBD__c ||
                                                              com.CBD_MG_G__c != oldMap.get(com.Id).CBD_MG_G__c || 
                                                              (com.Lab_Test_Status__c == LAB_TEST_STATUS_TESTED_PASSED && com.Lab_Test_Status__c != oldMap.get(com.Id).Lab_Test_Status__c) || 
                                                              (com.Lab_Test_Status__c == LAB_TEST_STATUS_TESTED_FAILED && com.Lab_Test_Status__c != oldMap.get(com.Id).Lab_Test_Status__c))){
            	if(com.Harvest_Batch_Code__c != null) batchIds.add(com.Harvest_Batch_Code__c);   
            }
            
            if(com.Send_Email__c && com.Send_Email__c != oldMap.get(com.Id).Send_Email__c){
            	compIds.add(com.Id);    
            }
        }
        if(batchIds.size() > 0){
        	ComplianceImageTriggerHandler.updateCompFields(batchIds);    
        }
        if(compIds.size() > 0){
        	ComplianceImageTriggerHandler.sendEmailOnLabStatusPassed(compIds);    
        }
    }
    
    /*public static void updateBatchFields(Set<Id> bIds){
    	Compliance_Images__c[] compImage = [SELECT Id,Lab_Test_Status__c,Harvest_Batch_Code__c,COA_Number__c,
                                            Harvest_Batch_Code__r.COA_Number__c,COA_Issued_Date__c,
                                            Harvest_Batch_Code__r.COA_Issued_Date__c, Harvest_Batch_Code__r.Lab_Test_Status__c from Compliance_Images__c where Harvest_Batch_Code__c In : bIds];   
        List<Harvest_Batch_Code__c> lstBatch = new List<Harvest_Batch_Code__c>();
        Set<Id> setIds = new Set<Id>();
        for(Compliance_Images__c comp : compImage){
            Harvest_Batch_Code__c batch = new Harvest_Batch_Code__c();
            if(!setIds.contains(comp.Harvest_Batch_Code__c)){
                batch.Id = comp.Harvest_Batch_Code__c;
                batch.COA_Issued_Date__c = comp.COA_Issued_Date__c;
                batch.COA_Number__c = comp.COA_Number__c;
                batch.Lab_Test_Status__c = comp.Lab_Test_Status__c;
                lstBatch.add(batch);    
                setIds.add(comp.Harvest_Batch_Code__c);    
            }
        }
        if(lstBatch.size() > 0){
            System.debug(lstBatch.size());
        	update lstBatch;    
        }
    }*/
    
    public static void updateCompFields(Set<Id> batchIds){
        
        List<Harvest_Batch_Code__c> lstBatch = [SELECT Id,COA_Number__c,Lab_Test_Status__c,COA_Issued_Date__c,CBD__c,CBD_MG_G__c,Terpene__c,Terpene_MG_G__c,THC__c,THC_MG_G__c,Batch_ID_Hold__c,
                                                (SELECT Id,COA_Expiration_Date__c,Lab_Test_Status__c,COA_Issued_Date__c,THC_MG_G__c ,Harvest_Batch_Code__c,COA_Number__c,CBD__c,CBD_MG_G__c,Terpene__c,Terpene_MG_G__c,THC__c
                                                 FROM Compliance_Images__r Order By COA_Expiration_Date__c DESC) FROM Harvest_Batch_Code__c WHERE Id IN: batchIds];
        
        List<Harvest_Batch_Code__c> lstBatchToUpdate = new List<Harvest_Batch_Code__c>();
        for(Harvest_Batch_Code__c batch : lstBatch){
            Integer cnt = 0;
            for(Compliance_Images__c comp : batch.Compliance_Images__r){
                if(comp.COA_Expiration_Date__c >= Date.today()){
                    batch.Id = comp.Harvest_Batch_Code__c;
                    batch.THC__c = comp.THC__c;
                    batch.THC_MG_G__c = comp.THC_MG_G__c;
                    batch.Terpene__c = comp.Terpene__c;
                    batch.Terpene_MG_G__c = comp.Terpene_MG_G__c;
                    batch.CBD__c = comp.CBD__c;
                    batch.CBD_MG_G__c = comp.CBD_MG_G__c;
                    batch.Batch_ID_Hold__c = comp.Lab_Test_Status__c == LAB_TEST_STATUS_TESTED_PASSED ? false : true;
                    batch.COA_Issued_Date__c = comp.COA_Issued_Date__c;
                    batch.COA_Number__c = comp.COA_Number__c;
                    batch.Lab_Test_Status__c = comp.Lab_Test_Status__c;
                    //cnt++;
                    break;
                }
            }
            //if(cnt == 1){
            lstBatchToUpdate.add(batch);
            //}
        }
        if(lstBatchToUpdate.size() > 0){
            System.debug(lstBatchToUpdate.size());
        	update lstBatchToUpdate;    
        }
        /*Compliance_Images__c[] compImage = [SELECT Id,Product__c,Harvest_Batch_Code__c,COA_Number__c,Harvest_Batch_Code__r.COA_Number__c,
                                            THC__c,THC_MG_G__c,Terpene__c,Terpene_MG_G__c,CBD__c,CBD_MG_G__c,
                                            Harvest_Batch_Code__r.CBD__c, Harvest_Batch_Code__r.CBD_MG_G__c,
                                            Harvest_Batch_Code__r.Terpene__c, Harvest_Batch_Code__r.Terpene_MG_G__c,
                                            Harvest_Batch_Code__r.THC__c, Harvest_Batch_Code__r.THC_MG_G__c from Compliance_Images__c where Harvest_Batch_Code__c In : batchIds];
        
        List<Harvest_Batch_Code__c> lstBatch = new List<Harvest_Batch_Code__c>();
        Set<Id> setIds = new Set<Id>();
        for(Compliance_Images__c comp : compImage){
        	Harvest_Batch_Code__c batch = new Harvest_Batch_Code__c();
            if(comp.Harvest_Batch_Code__c != null && comp.COA_Number__c == comp.Harvest_Batch_Code__r.COA_Number__c){
                if(!setIds.contains(comp.Harvest_Batch_Code__c)){
                    batch.Id = comp.Harvest_Batch_Code__c;
                    batch.THC__c = comp.THC__c;
                    batch.THC_MG_G__c = comp.THC_MG_G__c;
                    batch.Terpene__c = comp.Terpene__c;
                    batch.Terpene_MG_G__c = comp.Terpene_MG_G__c;
                    batch.CBD__c = comp.CBD__c;
                    batch.CBD_MG_G__c = comp.CBD_MG_G__c;
                    lstBatch.add(batch);    
                    setIds.add(comp.Harvest_Batch_Code__c);
                }
            }
        }    
        if(lstBatch.size() > 0){
            System.debug(lstBatch.size());
        	update lstBatch;    
        }*/
    }
    
    public static void sendEmailOnLabStatusPassed(Set<Id> compIds){
        Set<Id> brandIds = new Set<Id>();
        Map<Id,List<Compliance_Images__c>> mapBrands = new Map<Id,List<Compliance_Images__c>>();
        
        Map<String,String> mapContentDocument = new Map<String,String>();
		for(contentDocumentLink CDLink : [SELECT LinkedEntityid, ContentDocumentid 
                                          FROM contentDocumentLink WHERE LinkedEntityid IN : compIds]){
               mapContentDocument.put(CDLink.ContentDocumentid,CDLink.LinkedEntityid); 
        }
        
        Map<Id,List<ContentVersion>> mapVersion = new Map<Id,List<ContentVersion>>();
        
        Set<String> linkKeySet = mapContentDocument.keySet();
        
        for(ContentVersion cversion : [SELECT title, PathOnClient, FileType, versiondata, ContentDocumentId
                                       FROM ContentVersion  WHERE ContentDocumentId IN : linkKeySet]){
                                           if(mapVersion.containsKey(mapContentDocument.get(cversion.ContentDocumentId))){
                                               mapVersion.get(mapContentDocument.get(cversion.ContentDocumentId)).add(cversion);    
                                           } else {
                                               mapVersion.put(mapContentDocument.get(cversion.ContentDocumentId),new List<ContentVersion>{cversion});    
                                           }
                                       }
        
        
        for(Compliance_Images__c comp : [SELECT Id,Lab_Test_Status__c,COA_Issued_Date__c,Terpene__c,Terpene_MG_G__c,CBD__c,CBD_MG_G__c,THC__c,THC_MG_G__c,Laboratory_Name__r.Name,Product__c,Product__r.Brand_Name__c,Product__r.Licensee_Name__c,Product__r.White_Labelled__c,Product__r.Name,Harvest_Batch_Code__r.Name,Batch_Size__c,COA_Number__c,Product__r.Product_Short_Description__c,Product__r.Producer_Name__c,COA_Expiration_Date__c from Compliance_Images__c WHERE Id IN : compIds]){
            if(comp.Product__r.White_Labelled__c){
                if(comp.Product__r.Licensee_Name__c != null){
                    brandIds.add(comp.Product__r.Licensee_Name__c); 
                    if(mapBrands.containsKey(comp.Product__r.Licensee_Name__c)){
                        mapBrands.get(comp.Product__r.Licensee_Name__c).add(comp);    
                    } else{
                        mapBrands.put(comp.Product__r.Licensee_Name__c, new List<Compliance_Images__c>{comp});
                    }
                }     
            } else {
                if(comp.Product__r.Producer_Name__c != null){
                    if(comp.Product__r.Brand_Name__c != null){
                        brandIds.add(comp.Product__r.Producer_Name__c); 
                        if(mapBrands.containsKey(comp.Product__r.Producer_Name__c)){
                            mapBrands.get(comp.Product__r.Producer_Name__c).add(comp);    
                        } else{
                            mapBrands.put(comp.Product__r.Producer_Name__c, new List<Compliance_Images__c>{comp});
                        }    
                    }
                }    
            }  
        }
        if(brandIds.size() > 0){
        	List<Account> lstAcc = new List<Account>([SELECT Id,Name,
                                                      (SELECT Id,Name,Email,FirstName,Orders_Email_Opt_In__c from Contacts WHERE Active__c =: true AND Orders_Email_Opt_In__c =: true AND Compliance_Alert__c =: true AND Email != null)
                                                      FROM Account WHERE Id In : brandIds]); 
            if(lstAcc.size() > 0){
                Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{};
                
                orgwideemailaddress orgWide = [select Id,Address, displayName from orgwideemailaddress where displayName =: 'DL-Orders' limit 1];     
                    
            	for(Account acc : lstAcc){
                    List<Contact> lstCon = acc.Contacts;
                    List<Compliance_Images__c> lstComp = mapBrands.get(acc.Id);
                    if(lstCon.size() > 0){
                        for(Contact con: lstCon){
                            for(Compliance_Images__c comp : lstComp){
                                String expDate = '';
                                String issueDate = '';
                                if(comp.COA_Issued_Date__c != null) {
                                	Datetime dt = (Datetime)comp.COA_Issued_Date__c; 
                                    issueDate = dt.formatGmt('MM/dd/yyyy');
                                }
                                if(comp.COA_Expiration_Date__c != null) {
                                	Datetime dt = (Datetime)comp.COA_Expiration_Date__c;  
                                    expDate = dt.formatGmt('MM/dd/yyyy');
                                }
                                
                                String htmlBody = '';
                                if(comp.Laboratory_Name__r.Name != null)
                                	htmlBody = 'Hello '+con.FirstName+',<br><br> Your compliance testing for '+comp.Product__r.Product_Short_Description__c+' has been uploaded! For a summary of results from '+comp.Laboratory_Name__r.Name+', please see below. If you have any questions, please reach out to your ASR.';
                                else
                                    htmlBody = 'Hello '+con.FirstName+',<br><br> Your compliance testing for '+comp.Product__r.Product_Short_Description__c+' has been uploaded! For a summary of results from , please see below. If you have any questions, please reach out to your ASR.';
                                
                                htmlBody += '<br><br><u><b>COA Details:</b></u><br>';
                                htmlBody += '<ul><li>Product Name: '+comp.Product__r.Product_Short_Description__c+'</li>';
                                htmlBody += '<li>Results: '+comp.Lab_Test_Status__c+'</li>';
                                htmlBody += '<li>COA Issue Date: '+issueDate+'</li><li>COA Expiration Date: '+expDate+'</li>';
                                if(comp.Harvest_Batch_Code__r.Name != null) htmlBody += '<li>Batch ID: '+comp.Harvest_Batch_Code__r.Name+'</li></ul>';
                                else htmlBody += '<li>Batch ID: N/A</li></ul>';
                                
                                if(comp.THC__c != null || comp.THC_MG_G__c != null || comp.CBD__c != null || comp.CBD_MG_G__c != null ||
                                   comp.Terpene__c != null || comp.Terpene_MG_G__c != null){
                                       htmlBody += '<br><u><b>Cannabinoid Content:</b></u><br><ul>';  
                                       
                                       if(comp.THC__c != null)
                                           htmlBody += '<li>THC (%): '+comp.THC__c+'</li>';	
                                       if(comp.THC_MG_G__c != null)
                                           htmlBody += '<li>THC (MG/G): '+comp.THC_MG_G__c+'</li>';
                                       if(comp.CBD__c != null)
                                           htmlBody += '<li>CBD (%): '+comp.CBD__c+'</li>';
                                       if(comp.CBD_MG_G__c != null)
                                           htmlBody += '<li>CBD (MG/G): '+comp.CBD_MG_G__c+'</li>';
                                       if(comp.Terpene__c != null)
                                           htmlBody += '<li>Terpene (%): '+comp.Terpene__c+'</li>';
                                       if(comp.Terpene_MG_G__c != null)
                                           htmlBody += '<li>Terpene (MG/G): '+comp.Terpene_MG_G__c+'</li>';
                                       
                                       
                                       htmlBody += '</ul>';
                                   }
                                
                                List<String> listOfToAddresses = new List<String>();
                                listOfToAddresses.add(con.Email);
                                //listOfToAddresses.add('kapil.dhalwal@icloudygems.com');
                                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                mail.setSubject('Test Results: '+comp.Product__r.Product_Short_Description__c +', '+comp.Lab_Test_Status__c);
                                List<String> lstStr = label.DL_ASR.split(',');
                                mail.setCcAddresses(new List<String>{lstStr[0]});
                                //mail.setBccAddresses(new List<String>{label.Brand_BCC_Addresses});
                                
                                if(orgWide != null)
									mail.setOrgWideEmailAddressId(orgWide.Id);
                                
                                mail.setHtmlBody(htmlBody);
                                mail.setTargetObjectId(con.Id);
                                mail.setToAddresses(listOfToAddresses); 
                                
                                if(mapVersion.containsKey(comp.Id)){
                                    List<Messaging.EmailFileAttachment> attachments = new List<Messaging.EmailFileAttachment>();
                                    
                                	List<ContentVersion> lstVersion = mapVersion.get(comp.Id);
                                    for(ContentVersion cVersion : lstVersion){
                                        blob WOCFbody = cVersion.versiondata;
                                        Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
										efa.setBody(WOCFbody);
                                        efa.setFileName(cVersion.title+'.'+cVersion.FileType);
										attachments.add(efa);
                                    }
                                    if(attachments.size() > 0){
                                        mail.setFileAttachments(attachments);
                                    }
                                }
                                
                                emails.add(mail);
                            }
                        }
                    }
                }
                if(!emails.isEmpty()){
                    System.debug('###notifyOnNewRetailerOrder...'+emails.size());
                    Messaging.sendEmail(emails);
                }
                List<Compliance_Images__c> lstCMP = [SELECT Id,Send_Email__c from Compliance_Images__c where Id IN : compIds];
                for(Compliance_Images__c cmp : lstCMP){
                    cmp.Send_Email__c = false;    
                }
                update lstCMP;                    
            }
        }
    }
}