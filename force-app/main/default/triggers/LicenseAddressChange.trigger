trigger LicenseAddressChange on State_Licenses__c ( after update) {
    if(StateLicense_HttpCalloutHelper.IS_STATELICENSETOTALMILES_TRIGGER_ENABLED){
        if(CheckManifestRecursion.runOnce()){
            LicenseAddressChangeHlpr.calculateDistanceData(Trigger.New, Trigger.oldMap);
        }
    }
}