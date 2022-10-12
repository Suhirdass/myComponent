public class SyncTotalMilesController {
	@AuraEnabled
    public static AuraResponse syncTotalMiles(String recordId){
        AuraResponse r = new AuraResponse('SyncTotalMilesController.syncTotalMiles()');
        Set<Id> stLicenceId = new Set<Id>();
        stLicenceId.add(recordId);
        StateLicenseTotalMilesTriggerHelper.getMiles(stLicenceId);
        StateLicenseTotalMilesTriggerHelper.getGeoCodes(stLicenceId);   
        return r;
    }
}