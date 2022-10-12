public without sharing class  TestInventorySnapshotCtlr {
	@AuraEnabled
    public static AuraResponse  getRecords(){
        AuraResponse r = new AuraResponse('getRecords()');
        List<Inventory_SnapShot__c> issList =  [SELECT Id, Name, Product_Name__c, Product_Name__r.Name FROM Inventory_SnapShot__c LIMIT 10];
        r.data.put('records',issList);
        return r;
    }
}