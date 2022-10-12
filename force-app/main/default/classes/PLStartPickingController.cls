/*
TestClass : PickConfirmControllerTest
*/
public class PLStartPickingController {
    private static String PL_STATUS_IN_PROGRESS{
        get{
            return String.isNotBlank(PL_STATUS_IN_PROGRESS) ? PL_STATUS_IN_PROGRESS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','PL_Status_In_Progress');
        }set;
    }
	 @AuraEnabled
    public static Void updatePLPickStart(String recordId){
        Picklist__c PL = new Picklist__c();
        PL.Id =recordId;
        PL.Pick_Start__c = System.now();
        PL.Status__c=PL_STATUS_IN_PROGRESS;
        update PL;
    }
}