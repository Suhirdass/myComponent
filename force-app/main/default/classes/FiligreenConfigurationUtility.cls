public class FiligreenConfigurationUtility {
    //Config from Custom Metadata Type
    public static Map<String, Config__mdt[] > objectConfigMetadataMap{
        get{
            if(objectConfigMetadataMap == NULL){
                objectConfigMetadataMap = new Map<String, Config__mdt[] >();
                for(Config__mdt config: [SELECT Id, Related_To__c, Key__c, Value__c  FROM Config__mdt WHERE  Active__c = true AND Used_In__c IN ('CRM & Marketplace','CRM')]){
                    if(objectConfigMetadataMap.containsKey(config.Related_To__c)){
                       objectConfigMetadataMap.get(config.Related_To__c).add(config);
                    }else{
                        objectConfigMetadataMap.put(config.Related_To__c, new Config__mdt[]{config});
                    }
                }
            }
            return objectConfigMetadataMap;
        }set;
    }
    //Config from Custom Metadata Type
    public static Map<String, Map<String,String>> objectConfigMetadataKeyValueMap{
        get{
            if(objectConfigMetadataKeyValueMap == NULL){
                objectConfigMetadataKeyValueMap = new Map<String, Map<String,String>>();
                for(Config__mdt config: [SELECT Id, Related_To__c, Key__c, Value__c  FROM Config__mdt WHERE  Active__c = true AND Used_In__c IN ('CRM & Marketplace','CRM')]){
                    Map<String,String> objectKeyValueConfigurationMap = new Map<String,String>();
                    if(objectConfigMetadataKeyValueMap.containsKey(config.Related_To__c)){
                        objectKeyValueConfigurationMap = objectConfigMetadataKeyValueMap.get(config.Related_To__c);
                    }
                    objectKeyValueConfigurationMap.put(config.Key__c, config.Value__c);
                    objectConfigMetadataKeyValueMap.put(config.Related_To__c, objectKeyValueConfigurationMap);
                }
            }
            return objectConfigMetadataKeyValueMap;
        }set;
    }
    public static Map<String,String> getConfigKeyValueMap(String objectName){
        Map<String,String> objectKeyValueConfigurationMap = new Map<String,String>();
        if(String.isNotBlank(objectName)){
            objectKeyValueConfigurationMap =  objectConfigMetadataKeyValueMap.get(objectName);
        }
        return objectKeyValueConfigurationMap;
    }
    //Return value of given Key related to specific Object
    public static String getConfigValueByObjectAndKey(String objectName,String key){
        Map<String,String> objectKeyValueConfigurationMap = new Map<String,String>();
        if(String.isNotBlank(objectName) && String.isNotBlank(key)){
            objectKeyValueConfigurationMap = getConfigKeyValueMap(objectName);
        }
        if(objectKeyValueConfigurationMap == NULL){
            objectKeyValueConfigurationMap = new Map<String,String>();
        }
        return objectKeyValueConfigurationMap.get(key);
    }
    public Static List<String> getCollectionStatus(String objectName){
        list<String>collectionStatusList = new List<String>();
        for(Config__mdt config: [SELECT Id, Related_To__c, Key__c, Value__c  FROM Config__mdt WHERE  Active__c = true AND Related_To__c =: objectName AND  Used_In__c IN ('CRM & Marketplace','CRM')]){
        	if(config.Key__c == 'collectionStatus')
            	collectionStatusList =  config.Value__c.split(',');
        }   
        return collectionStatusList;
    }
    public Static String getInvoiceConfig(String objectName,String key){
    	for(Config__mdt config: [SELECT Id, Related_To__c, Key__c, Value__c  FROM Config__mdt WHERE  Active__c = true AND Related_To__c =: objectName AND  Used_In__c IN ('CRM & Marketplace','CRM')]){
        	if(config.Key__c == key)
            	return config.Value__c;
        } 
        return '';
    }    
}