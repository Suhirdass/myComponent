public class MetrcSynUIDController {

	@AuraEnabled
    public static String synData(String recordId){
		
        Map<String,Object> respMap = new  Map<String,Object>();
        List<UID__c> uidList = new List<UID__c>();
        String responseMessage= '';
        UID__c uid = [SELECT Available_Qty_in_METRC__c,Available_Qty__c,Batch_ID__c,Id,METRC_Status__c,	Finished_Date__c, METRC_Lab_Status__c, METRC_Sync_status__c,Name,Received_Qty__c FROM UID__c where Id=: recordId];
        
            respMap = Metrc_HttpCalloutHelper.getSinglePackage(uid.Name);
            if(respMap.get('Quantity')!=null){
                uid.Available_Qty_in_METRC__c = Integer.valueof(respMap.get('Quantity'));
                uid.METRC_Lab_Status__c = String.valueof(respMap.get('LabTestingState'));
                upsert uid; 
            }else{
                responseMessage = 'NOT FOUND';
            }

        if(respMap.get('Quantity')==0 && respMap.get('FinishedDate') !=null){
            if(uid.Available_Qty_in_METRC__c == 0 && uid.Available_Qty__c == 0 && uid.Received_Qty__c> 0){
                if(uid.METRC_Status__c=='Unfinished'){
                    uid.METRC_Status__c = 'Finished';
                }
                if(uid.Finished_Date__c==null){
                    uid.Finished_Date__c = System.today();
                }
                upsert uid;
                responseMessage = 'success';
            } 
        } else if(respMap.get('Quantity')==0 && respMap.get('FinishedDate') ==null)
        {
            if(uid.Available_Qty_in_METRC__c == 0 && uid.Available_Qty__c == 0 && uid.Received_Qty__c> 0){
                DateTime actualDate = Datetime.now();
                String dateOutput = actualDate.format('yyyy-MM-dd');
                Metrc_HttpCalloutHelper.createPackageFinish(uid.Name,dateOutput);
                responseMessage = 'success';
            }
        }
        
        
      return responseMessage;
        
    }
}