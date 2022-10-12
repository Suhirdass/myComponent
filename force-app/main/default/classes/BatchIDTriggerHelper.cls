public class BatchIDTriggerHelper {
    
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
    
    private static String BATCH_ID_DUPLICATE_NAME_ERROR_MSG{
        get{
            return String.isNotBlank(BATCH_ID_DUPLICATE_NAME_ERROR_MSG) ? BATCH_ID_DUPLICATE_NAME_ERROR_MSG : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Batch ID','Batch ID Duplicate Error Msg');
        }set;
    }
    public static void verifyUniqueBatchID(List<Harvest_Batch_Code__c> newBatchList, Map<Id, Harvest_Batch_Code__c> oldBatchMap){
        
        List<Harvest_Batch_Code__c> updatedBatches = new List<Harvest_Batch_Code__c>();
        Set<Id> currentIds = new Set<Id>();
        
        for(Harvest_Batch_Code__c batch : newBatchList){
            Harvest_Batch_Code__c oldBatch = oldBatchMap != null ? (Harvest_Batch_Code__c)oldBatchMap.get(batch.Id) : null;
            
            // Get Batch ID where new value of Batch name is changed
            if(trigger.isInsert || (trigger.isUpdate && batch.Name != oldBatch.Name)){
                updatedBatches.add(batch);
                if(trigger.isUpdate){
                    currentIds.add(batch.Id);
                }
            }
        }
        
        // Get existing products to verify with new product records
        if(updatedBatches.size() > 0){
            
            Map<String, Id> caseInsensitiveBatchIdsByName = new Map<String, Id>();
            Map<Id, String> batchNamesById = new Map<Id, String>();
            
            for(Harvest_Batch_Code__c batch : [Select Id, Name From Harvest_Batch_Code__c WHERE Id Not IN: currentIds AND Active__c = true]){
                caseInsensitiveBatchIdsByName.put(batch.Name.toLowerCase(), batch.Id);
                batchNamesById.put(batch.Id, batch.Name);
            }
            
            for(Harvest_Batch_Code__c batch : updatedBatches){
                if(caseInsensitiveBatchIdsByName.containsKey(batch.Name.toLowerCase())){
                    String existingBatchId = caseInsensitiveBatchIdsByName.get(batch.Name.toLowerCase()); 
                    String existingBatchName = batchNamesById.get(existingBatchId); 
                    batch.addError(String.format(BATCH_ID_DUPLICATE_NAME_ERROR_MSG, 
                                        new List<String>{batch.Name,
                                        existingBatchId,
                                        existingBatchName}), false);
                }
            }
        }
    }
    public static void updateIPRecords(Harvest_Batch_Code__c[] newList, Map<Id,Harvest_Batch_Code__c> oldMap){
    	Set<Id> batchIds = new Set<Id>();
        for(Harvest_Batch_Code__c b: newList){
            System.debug(Trigger.isUpdate);
            //if(b.Batch_ID_Hold__c != oldMap.get(b.Id).Batch_ID_Hold__c){
                batchIds.add(b.Id);
            //}
        }
        if(batchIds.size() > 0){
            List<String> lstInvLocNames = EXCLUDE_INVENTORY_LOCATIONS.split(',');
        	List<Inventory_Position__c> lstInvPos = new List<Inventory_Position__c>([SELECT Id,Harvest_Batch_Code__c,Inventory_Location__c,
                                                                                     Inventory_Location__r.Name,Lab_Test_Status__c,Hold__c,
                                                                                     Harvest_Batch_Code__r.Batch_ID_Hold__c, Harvest_Batch_Code__r.Lab_Test_Status__c
                                                                                     FROM Inventory_Position__c 
                                                                                     WHERE Harvest_Batch_Code__c IN : batchIds AND
                                                                                     Inventory_Location__r.Name NOT IN :lstInvLocNames]);    
            if(lstInvPos.size() > 0){
                List<Inventory_Position__c> updateList = new List<Inventory_Position__c>();
                
                for(Inventory_Position__c inv : lstInvPos){
                    if(inv.Harvest_Batch_Code__r.Batch_ID_Hold__c){
                        inv.Hold__c = true;  
                        inv.Lab_Test_Status__c = inv.Harvest_Batch_Code__r.Lab_Test_Status__c;
                        updateList.add(inv);
                        /*if(inv.Inventory_Location__r.Name != NAME_CANNAWASTE && inv.Inventory_Location__r.Name != NAME_DELIVERED &&
                           inv.Inventory_Location__r.Name != NAME_PACKAGED && inv.Inventory_Location__r.Name != NAME_QUARANTINE &&
                           inv.Inventory_Location__r.Name != NAME_TEST_SAMPLED && inv.Inventory_Location__r.Name != NAME_TRANSFERRED){
                               inv.Hold__c = true;  
                               inv.Lab_Test_Status__c = inv.Harvest_Batch_Code__r.Lab_Test_Status__c;
                               updateList.add(inv);
                        }*/
                    } else {
                        inv.Hold__c = false;
                        inv.Lab_Test_Status__c = inv.Harvest_Batch_Code__r.Lab_Test_Status__c;
                        updateList.add(inv);
                        /*if(inv.Inventory_Location__r.Name != NAME_CANNAWASTE && inv.Inventory_Location__r.Name != NAME_DELIVERED &&
                           inv.Inventory_Location__r.Name != NAME_PACKAGED && inv.Inventory_Location__r.Name != NAME_QUARANTINE &&
                           inv.Inventory_Location__r.Name != NAME_TEST_SAMPLED && inv.Inventory_Location__r.Name != NAME_TRANSFERRED){
                               inv.Hold__c = false;
                               inv.Lab_Test_Status__c = inv.Harvest_Batch_Code__r.Lab_Test_Status__c;
                               updateList.add(inv);
                    	}*/
                    }
                }
                if(updateList.size() > 0){
                	update updateList;    
                }
            }
        }
    }
    
    public static void updateProductFields(Harvest_Batch_Code__c[] newList, Map<Id,Harvest_Batch_Code__c> oldMap){
        Set<Id> batchIds = new Set<Id>();
        for(Harvest_Batch_Code__c b: newList){
            System.debug(Trigger.isUpdate);
            if(Trigger.isInsert || (Trigger.isUpdate && (b.CBD__c != oldMap.get(b.Id).CBD__c || b.CBD_MG_G__c != oldMap.get(b.Id).CBD_MG_G__c ||
                                                         b.THC__c  != oldMap.get(b.Id).THC__c || b.THC_MG_G__c != oldMap.get(b.Id).THC_MG_G__c ||
                                                         b.Terpene__c  != oldMap.get(b.Id).Terpene__c || b.Terpene_MG_G__c != oldMap.get(b.Id).Terpene_MG_G__c ))){
                batchIds.add(b.Id);
            }
        }
        
        if(!batchIds.isEmpty()){
            
            Compliance_Images__c[] compImage = [SELECT Id,Product__c,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Terpene__c,
                                                Harvest_Batch_Code__r.Terpene_MG_G__c,
                                                Harvest_Batch_Code__r.CBD__c, Harvest_Batch_Code__r.CBD_MG_G__c,
                                                Harvest_Batch_Code__r.THC__c, Harvest_Batch_Code__r.THC_MG_G__c from Compliance_Images__c where Harvest_Batch_Code__c In : batchIds and COA_Expiration_Date__c >=: Date.today()];
            
            List<Product2> lstProduct = new List<Product2>();
            
            for(Compliance_Images__c comp : compImage){
            	Product2 prod = new Product2();
                Set<Id> prodIds = (new Map<Id,Product2>(lstProduct)).keySet();
                
                if(!prodIds.contains(comp.Product__c) && comp.Product__c != null && comp.Harvest_Batch_Code__c != null){
                	prod.Id = comp.Product__c;
                    prod.CDB_Amount__c = comp.Harvest_Batch_Code__r.CBD__c;
                    prod.CBD_MG_G__c = comp.Harvest_Batch_Code__r.CBD_MG_G__c;
                    prod.THC_Amount__c = comp.Harvest_Batch_Code__r.THC__c;
                    prod.THC_MG_G__c = comp.Harvest_Batch_Code__r.THC_MG_G__c;
                    prod.Terpene_percent__c = comp.Harvest_Batch_Code__r.Terpene__c;
                    prod.Terpene_MG_G__c = comp.Harvest_Batch_Code__r.Terpene_MG_G__c;
                    lstProduct.add(prod);
                }
            }
            
            if(lstProduct.size() > 0){
            	update lstProduct;    
            }
        }
    }
    
}