public class LicenseAddressChangeHlpr {
    public static void calculateDistanceData(List<State_Licenses__c> records,Map<Id,State_Licenses__c> oldMap){
        Set<Id> toUpdate = new Set<Id>();
        for(State_Licenses__c obj : records){
            if(oldMap.get(obj.Id).License_State__c != obj.License_State__c ||
               oldMap.get(obj.Id).License_City__c != obj.License_City__c ||
               oldMap.get(obj.Id).License_Address__c != obj.License_Address__c ||
               oldMap.get(obj.Id).License_Zip__c != obj.License_Zip__c){
                   toUpdate.add(obj.Id);
               }
        }
        if(toUpdate.size() > 0){
            List<sObject> manifests = [SELECT Id, recordType.DeveloperName,recordType.Name,Total_Route_Miles__c ,Geocode_Error__c ,Distributor_Address__c,
                                       Distributor_City_State_Zip__c,
                                       Receiver_Address__c ,Receiver_City_State_Zip__c,
                                       Supplier_Address__c, Supplier_City_State_Zip__c
                                       FROM Shipping_Manifest__c
                                       WHERE Supplier_License__c IN :toUpdate OR Distributor_License__c IN :toUpdate OR Receiver_License__c IN :toUpdate];
            if(!Test.isRunningTest()){
                Database.executeBatch(new CalculateManifestMilesBtch(manifests), 1);
            } 
        }
           
    }
}