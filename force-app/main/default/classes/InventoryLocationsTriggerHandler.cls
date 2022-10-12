public class InventoryLocationsTriggerHandler {
    public static void afterInsert(List<Inventory_Location__c> invLocations){
        Set<Id> locIds = new Set<Id>();
        for(Inventory_Location__c inv : invLocations){
            if(inv.Auto_Hold__c){
                locIds.add(inv.Id);
            }
        }
        if(locIds.size() > 0) updateIPRecordsHold(locIds);
    }
    
    public static void afterUpdate(List<Inventory_Location__c> invLocations, Map<Id,Inventory_Location__c> oldMap){
        Set<Id> locIds = new Set<Id>();
        for(Inventory_Location__c inv : invLocations){
            Inventory_Location__c oldIpLoc = oldMap.get(inv.Id);
            if(inv.Auto_Hold__c && inv.Auto_Hold__c != oldIpLoc.Auto_Hold__c){
                locIds.add(inv.Id);
            }
        }
        if(locIds.size() > 0) updateIPRecordsHold(locIds);
    }
    
    public static void updateIPRecordsHold(Set<Id> invLocationsIds){
        List<Inventory_Position__c> updatesToIP = new List<Inventory_Position__c>();
        for(Inventory_Position__c invPos : [SELECT Id,Inventory_Hold_Reason_Code__c,Hold__c,Inventory_Location__c FROM Inventory_Position__c WHERE Inventory_Location__c IN : invLocationsIds]){
        	invPos.Hold__c = true;
            invPos.Inventory_Hold_Reason_Code__c = 'Not Tested';
            updatesToIP.add(invPos);	    
        }
        if(updatesToIP.size()> 0) update updatesToIP;
    }
    
}