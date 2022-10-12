public class DataCRUDUtility{
    @Auraenabled
    public static String getRecordName(Id recordId){
        String objName = recordId.getSObjectType().getDescribe().getName();
        System.debug(objName);
        String q = 'SELECT Name FROM ' + objName + ' WHERE Id=\'' + recordId + '\'';
        List<SObject> records = Database.query(q);
        if(records.size()>0){
            return (String) (records[0].get('Name'));
        }
        return '';
    }
    @AuraEnabled
    public static StatusWithError getBQStatus(String recordId){
        Boolean isCancelled = false;
        Brand_Quote__c bq = [SELECT Id, BQ_Status__c,Name,
                             Distributor_Name__r.Id,Distributor_License__r.License_Name__r.Id,
                             Receiver_Name__r.Id,Receiver_License__r.License_Name__r.Id,
                             Supplier_Name__r.Id,Supplier_License__r.License_Name__r.Id,
                             Receiver_License__r.License_Status__c,Supplier_License__r.License_Status__c,
                             Distributor_License__r.License_Status__c,
                             Distributor_Contact__c,Receiver_Contact__c,Supplier_Contact__c,
                             Distributor_Contact__r.Active__c ,
                             Receiver_Contact__r.Active__c ,
                             Supplier_Contact__r.Active__c 
                             FROM Brand_Quote__c WHERE Id=:recordId];
        
        String misMatchData = '';
        if(String.isBlank(bq.Distributor_Name__c)){misMatchData = 'BlankDistributorName';}
        else if(String.isBlank(bq.Receiver_Name__c)){misMatchData = 'BlankReceiverName';}
        else if(String.isBlank(bq.Supplier_Name__c)){misMatchData = 'BlankSupplierName';}
        else if(String.isBlank(bq.Distributor_License__c)){misMatchData = 'BlankDistributorLC';}
        else if(String.isBlank(bq.Receiver_License__c)){misMatchData = 'BlankReceiverLC';}
        else if(String.isBlank(bq.Supplier_License__c)){misMatchData = 'BlankSupplierLC';}
        else if(bq.Distributor_Name__r.Id != bq.Distributor_License__r.License_Name__r.Id){misMatchData = 'Distributor';}
        else if(bq.Receiver_Name__r.Id != bq.Receiver_License__r.License_Name__r.Id){misMatchData = 'Receiver';}
        else if(bq.Supplier_Name__r.Id != bq.Supplier_License__r.License_Name__r.Id){misMatchData = 'Supplier';}
        else if(bq.BQ_Status__c != 'Approved' && bq.Distributor_License__r.License_Status__c  == 'Expired' ){misMatchData = 'DLInactive';}
        else if(bq.BQ_Status__c != 'Approved' && bq.Receiver_License__r.License_Status__c  == 'Expired' ){misMatchData = 'RLInactive';}
        else if(bq.BQ_Status__c != 'Approved' && bq.Supplier_License__r.License_Status__c  == 'Expired' ){misMatchData = 'SLInactive';}
        else if(bq.Distributor_Contact__c != null && bq.Distributor_Contact__r.Active__c == false){misMatchData = 'DCBlank';}
        else if(bq.Receiver_Contact__c != null && bq.Receiver_Contact__r.Active__c == false) {misMatchData = 'RCBlank';}
        else if(bq.Supplier_Contact__c != null && bq.Supplier_Contact__r.Active__c == false) {misMatchData = 'SCBlank';}
        else if(bq.BQ_Status__c == 'Cancelled'){ misMatchData = 'Status'; }
        
        StatusWithError wrpData = new StatusWithError();
        wrpData.misMatchData = misMatchData;
        wrpData.status = bq.BQ_Status__c;
        wrpData.recordName = bq.Name;

        return wrpData;
    }
    
    public class StatusWithError{
        @AuraEnabled public String misMatchData{set;get;}
        @AuraEnabled public String status{set;get;}
        @AuraEnabled public String recordName{set;get;}
        
        public StatusWithError(){
            this.misMatchData = '';
            this.status = '';
            this.recordName = '';
        }
    }
}