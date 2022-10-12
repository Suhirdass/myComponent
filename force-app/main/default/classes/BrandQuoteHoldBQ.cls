public class BrandQuoteHoldBQ {
    @AuraEnabled
    public Static Boolean holdBQ(Id recordId){
        List<Brand_Quote__c> bqs=[select Id, BQ_Status__c from Brand_Quote__c where Id =:recordId];
        for(Integer i=0;i<bqs.size();i++){
            if(bqs[i].BQ_Status__c != 'Draft'){
                return false;
            }else{
                bqs[i].BQ_Status__c = 'Hold';
            }
        }
        update bqs;
        return true;
    }
     @Auraenabled
    public static String getRecordName(Id recordId){
        return DataCRUDUtility.getRecordName(recordId);
    }

}