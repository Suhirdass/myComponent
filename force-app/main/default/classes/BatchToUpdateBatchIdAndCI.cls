global class BatchToUpdateBatchIdAndCI implements Database.Batchable<sObject>, Schedulable{
    
    private static String LAB_TEST_STATUS_EXPIRED_COA{
        get{
            return String.isNotBlank(LAB_TEST_STATUS_EXPIRED_COA) ? LAB_TEST_STATUS_EXPIRED_COA : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Compliance Images','Lab_Test_Status_Expired_COA');
        }set;
    }
    /*private static String NAME_CANNAWASTE{
        get{
            return String.isNotBlank(NAME_CANNAWASTE) ? NAME_CANNAWASTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_CannaWaste');
        }set;
    }
    private static String NAME_DELIVERED{
        get{
            return String.isNotBlank(NAME_DELIVERED) ? NAME_DELIVERED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Delivered');
        }set;
    }
    private static String NAME_PACKAGED{
        get{
            return String.isNotBlank(NAME_PACKAGED) ? NAME_PACKAGED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Packaged');
        }set;
    }
    private static String NAME_QUARANTINE{
        get{
            return String.isNotBlank(NAME_QUARANTINE) ? NAME_QUARANTINE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Quarantine');
        }set;
    }
    private static String NAME_TEST_SAMPLED{
        get{
            return String.isNotBlank(NAME_TEST_SAMPLED) ? NAME_TEST_SAMPLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Test_Sampled');
        }set;
    }
    private static String NAME_TRANSFERRED{
        get{
            return String.isNotBlank(NAME_TRANSFERRED) ? NAME_TRANSFERRED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Transferred');
        }set;
    }*/
    private static String EXCLUDE_INVENTORY_LOCATIONS{
        get{
            return String.isNotBlank(EXCLUDE_INVENTORY_LOCATIONS) ? EXCLUDE_INVENTORY_LOCATIONS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Exclude_Inventory_Locations');
        }set;
    }
    
    
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id,COA_Issued_Date__c,Product__c,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Batch_ID_Hold__c,
                                         Harvest_Batch_Code__r.Lab_Test_Status__c,COA_Expiration_Date__c,Lab_Test_Status__c 
                                         FROM Compliance_Images__c WHERE Lab_Test_Status__c <> :LAB_TEST_STATUS_EXPIRED_COA AND COA_Expiration_Date__c =: Date.today()]);
    }
    global void execute(Database.BatchableContext bc, List<Compliance_Images__c> records){
        
        Set<Id> batchIds = new Set<Id>();
        Set<Id> productIds = new Set<Id>();
        
        for(Compliance_Images__c comp : records){
            comp.Lab_Test_Status__c = LAB_TEST_STATUS_EXPIRED_COA;
            if(comp.Harvest_Batch_Code__c != null){
                batchIds.add(comp.Harvest_Batch_Code__c);
            }
            if(comp.Product__c != null){
                productIds.add(comp.Product__c);
            }
        }
		update records;
        
        List<Harvest_Batch_Code__c> lstBatch = new List<Harvest_Batch_Code__c>();
        if(batchIds.size() > 0){
            List<Harvest_Batch_Code__c> batchList = [SELECT ID,Batch_ID_Hold__c,Lab_Test_Status__c,
                                                     (SELECT Id,Lab_Test_Status__c,COA_Expiration_Date__c FROM Compliance_Images__r)
                                                     FROM Harvest_Batch_Code__c WHERE Id IN : batchIds];
            for(Harvest_Batch_Code__c batch : batchList){
                Boolean isExist = false;
                for(Compliance_Images__c comp : batch.Compliance_Images__r){
                    if(comp.COA_Expiration_Date__c > Date.today()){
                        isExist = true;
                        break;
                    }
                }
                if(!isExist){
                    batch.Batch_ID_Hold__c = true;
                    batch.Lab_Test_Status__c = LAB_TEST_STATUS_EXPIRED_COA;
                    lstBatch.add(batch);
                }
            }
        }
        
        if(lstBatch.size() > 0){
            update lstBatch;
        }
        List<String> lstInvLocNames = EXCLUDE_INVENTORY_LOCATIONS.split(',');
        List<Inventory_Position__c> lstInvPos = new List<Inventory_Position__c>([SELECT Id,Harvest_Batch_Code__c,Inventory_Location__c,Product_Name__c,
                                                                                 Inventory_Location__r.Name,Lab_Test_Status__c,Hold__c
                                                                                 FROM Inventory_Position__c 
                                                                                 WHERE Harvest_Batch_Code__c IN : batchIds AND Product_Name__c IN : productIds
                                                                                 AND Hold__c =: false AND Inventory_Location__r.Name NOT IN :lstInvLocNames]);
        System.debug('lstInvPos.size() = '+lstInvPos.size());
        if(lstInvPos.size() > 0){
            List<Inventory_Position__c> updateList = new List<Inventory_Position__c>();
            for(Inventory_Position__c inv : lstInvPos){
                inv.Hold__c = true;
                inv.Lab_Test_Status__c = LAB_TEST_STATUS_EXPIRED_COA;  
                updateList.add(inv);
                /*if(inv.Inventory_Location__r.Name != NAME_CANNAWASTE && inv.Inventory_Location__r.Name != NAME_DELIVERED &&
                   inv.Inventory_Location__r.Name != NAME_PACKAGED && inv.Inventory_Location__r.Name != NAME_QUARANTINE &&
                   inv.Inventory_Location__r.Name != NAME_TEST_SAMPLED && inv.Inventory_Location__r.Name != NAME_TRANSFERRED){
                       inv.Hold__c = true;
                       inv.Lab_Test_Status__c = LAB_TEST_STATUS_EXPIRED_COA;  
                       updateList.add(inv);
            	}*/    
            }
            if(updateList.size() > 0) {
                update updateList;    
            }
        }
    }    
    
    global void execute(SchedulableContext sc){
        Database.executeBatch(new BatchToUpdateBatchIdAndCI());
    } 
    global void finish(Database.BatchableContext bc){}    
}