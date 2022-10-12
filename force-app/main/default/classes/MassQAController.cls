public class MassQAController {
	 private Static String Confirmation_for_QA_Record { 
        get{
            return  String.isNotBlank(Confirmation_for_QA_Record) ? Confirmation_for_QA_Record :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Quality Assurance','Confirmation_for_QA_Record');
        }set;
    }
    
    @AuraEnabled
    public static AuraResponse createRecord(String recordId){
        AuraResponse r = new AuraResponse('MassQAController.createRecord()');
        Boolean showpopup = false;
        list<Receiving_Line__c> rlList = [SELECT Id, Name, Receiving_ID__c,(select Id From Quality_Assurances__r) FROM Receiving_Line__c where Receiving_ID__c =: recordId];
        String alreadyCreatedQAName = '';
        List<string> alreadyQAIds = new List<string>();
        List<Quality_Assurance__c> qaList = new List<Quality_Assurance__c>();
        String recordType = Schema.SObjectType.Quality_Assurance__c.getRecordTypeInfosByName().get('QA Receiving Line').getRecordTypeId();
        for(Receiving_Line__c rl : rlList){
                if(rl.Quality_Assurances__r.size() > 0){
                    showpopup = true;
                    alreadyCreatedQAName += alreadyCreatedQAName == '' ? rl.Name : ', '+rl.Name;
                    alreadyQAIds.add(rl.Id);
                }else{
                    Quality_Assurance__c QA = new Quality_Assurance__c();
                    QA.Receiving_Line__c = rl.Id;
                    QA.Pass_All__c = true;
                    QA.RecordTypeId = recordType;
                    qaList.add(QA);
                }
        }
        
        if(qaList.size() > 0 ){
            insert qaList;
        }
        
        r.data.put('showpopup',showpopup);
        r.data.put('Confirmation_for_QA_Record', Confirmation_for_QA_Record.replace('{0}', alreadyCreatedQAName));
        r.data.put('alreadyQAIds',alreadyQAIds);
       
        return r;
    }
    @AuraEnabled
    public static AuraResponse createNewRecord(List<String> recordIds){
        AuraResponse r = new AuraResponse('MassQAController.createNewRecord()');
        String recordType = Schema.SObjectType.Quality_Assurance__c.getRecordTypeInfosByName().get('QA Receiving Line').getRecordTypeId();
        list<Receiving_Line__c> rlList = [SELECT Id, Name, Receiving_ID__c FROM Receiving_Line__c where Id IN : recordIds];
        List<Quality_Assurance__c> qaList = new List<Quality_Assurance__c>();
        for(Receiving_Line__c rl : rlList){
            Quality_Assurance__c QA = new Quality_Assurance__c();
            QA.Receiving_Line__c = rl.Id;
            QA.Pass_All__c = true;
            QA.RecordTypeId = recordType;
            qaList.add(QA);
        }
        if(qaList.size() > 0 ){
            insert qaList;
        }
        return r;
        
    }
    
}