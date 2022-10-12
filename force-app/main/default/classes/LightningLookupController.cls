/**
* Copyright (c) 2021 WOVN
* All rights reserved.
* LightningLookupController
*/
public class LightningLookupController {
    
    public Static String VEHICLE_STRING_REFRIGERATED{
        get{
            return String.isNotBlank(VEHICLE_STRING_REFRIGERATED) ? VEHICLE_STRING_REFRIGERATED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Vehicle','Vehicle_String_Refrigerated');
        }set;
    } 

    @AuraEnabled
    public static LookupRecord[] getRecords(String objectName,String fieldName,String searchTerm, String value){
        LookupRecord[] licenseeAccounts = new LookupRecord[]{};
            String query;
        if(objectName == 'Vehicles__c')
        {
            query = 'SELECT Id,Refrigerated__c,Vehicle_in_Use__c,'+fieldName+' FROM Vehicles__c WHERE Vehicle_in_Use__c = true AND Tag_Expiration_Date__c >=TODAY';
        }
        else if(objectName == 'Drivers__c')
        {
            query = 'SELECT Id,Active__c,'+fieldName+' FROM Drivers__c WHERE Active__c = true AND Expiration_Date__c >=TODAY';
        }
        else
        { 
            query = 'SELECT Id,'+fieldName+'  FROM '+objectName;
        }
        
        if((String.isNotBlank(value))&& !(objectName == 'Vehicles__c') && !(objectName == 'Drivers__c')){
            query += ' WHERE Id =:value';
        }
        else if(objectName == 'Vehicles__c' || objectName == 'Drivers__c')
        {
            query +=' AND '+fieldName+' LIKE ' + '\'' + String.escapeSingleQuotes(searchTerm.trim()) + '%\''; 
        }
        else
        {
            query +=' WHERE '+fieldName+' LIKE ' + '\'' + String.escapeSingleQuotes(searchTerm.trim()) + '%\''; 
        }
        
        query+= ' LIMIT 3000';
        for(sObject a : Database.query(query)){
            LookupRecord recordsData = new LookupRecord();
            recordsData.value = String.valueOf(a.get('Id'));
            
            if(objectName == 'Vehicles__c')
            {
                if(Boolean.valueOf(a.get('Refrigerated__c')) == true)
                {
                    recordsData.label = String.valueOf(a.get(fieldName))+ VEHICLE_STRING_REFRIGERATED; 
                }else{
                    recordsData.label = String.valueOf(a.get(fieldName));
                }
                
            }else{
                recordsData.label = String.valueOf(a.get(fieldName));
            }
            
            licenseeAccounts.add(recordsData);
        }
        return licenseeAccounts;
    }
    
    public class LookupRecord{
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String value {get;set;}
    }
}