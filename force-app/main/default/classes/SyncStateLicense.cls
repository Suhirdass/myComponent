public class SyncStateLicense {
	
    @AuraEnabled
    public static AuraResponse SyncStateLicenseDCA(String recordId){
        String responseMessage = '';
        AuraResponse r = new AuraResponse('SyncStateLicense.SyncStateLicenseDCA()');
        List<State_Licenses__c>  slObj = [select License_Number__c from State_Licenses__c where id = :recordId];
        responseMessage = StateLicense_HttpCalloutHelper.getAllLicenseByNumber(slObj);
        r.data.put('responseMessage', responseMessage);
        return r;
        
    }
    
   /*@AuraEnabled
    public static AuraResponse getAllBccLicenses(){
        
        AuraResponse r = new AuraResponse('SyncStateLicense.getAllBccLicenses()');
        List<Object> respMap = new  List<Object>();
        //respMap = StateLicense_HttpCalloutHelper.getAllBccLicenses();
        
        //responseMessage = StateLicense_HttpCalloutHelper.getAllLicenseByNumber(slObj);
        //r.data.put('responseMessage', );
        r.data.put('response', respMap); 
        return r;
        
    }

     @AuraEnabled
    public static AuraResponse searchLicenseNumber(String licenseNumber){
        String responseMessage = '';
        //String errorMessage = '';
        AuraResponse r = new AuraResponse('SyncStateLicense.searchLicenseNumber()');
        List<Object> respMap = new  List<Object>();
        respMap = StateLicense_HttpCalloutHelper.searchLicenseByNumber(licenseNumber);
        r.data.put('response', respMap);
        //r.data.put('errorMessage', errorMessage); 
        return r;
        
    }*/
    
     @Auraenabled
    public static AuraResponse getRecordName(Id recordId){
        String objName = recordId.getSObjectType().getDescribe().getName();
         AuraResponse r = new AuraResponse('TransferPackage.getRecordName()');
        String q = 'SELECT Name FROM ' + objName + ' WHERE Id=\'' + recordId + '\'';
        List<SObject> records = Database.query(q);
        if(records.size()>0){
             r.data.put('name', (String) (records[0].get('Name')));
            return r;
        }
        return r;
    }
    
    
}