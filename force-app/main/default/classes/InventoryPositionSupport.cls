/**
 * Copyright (c) 2019 Filigreen Distro
 * All rights reserved.
 * InventoryPositionSupport
 */
public class InventoryPositionSupport{
    
    /**
     * Set Inventory Position - Inventory Location, Rack, Rack Level and Bin Location to QA Review
     * @param invPositions The list of inventory positions 
     * @param siteIds The set of site ids
     * @param nameString The hard coded name string as same name of Inventory Location, Rack, Rack Level and 
     *        Bin Location
     */         
    public static void updateInvPositions(List<Inventory_Position__c> invPositions,
                                          Set<Id> siteIds,
                                          String nameString) {
        
        if(invPositions == null || invPositions.size() == 0 || String.isBlank(nameString)){
            return;
        }
        
        Map<Id, Id> invLocationIdBySiteId = new Map<Id, Id>();
        Map<Id, Id> rackIdByInvLocationId = new Map<Id, Id>();
        Map<Id, Id> rackLevelIdByRackId = new Map<Id, Id>();
        Map<Id, Id> binLocationIdByRackLevelId = new Map<Id, Id>();
        
        // Create map of Inventory location Id by Site Id
        for(Inventory_Location__c invLocation : [Select Name, Site_Name__c from Inventory_Location__c 
                                                 Where Site_Name__c IN: siteIds AND Name =: nameString]){
            if(invLocation.Name == nameString){
                invLocationIdBySiteId.put(invLocation.Site_Name__c, invLocation.Id);
            } 
        }
        
        // Create map of rack Id by Inventory location Id
        for(Rack__c rackSO : [Select Inventory_Location__c from Rack__c Where Inventory_Location__c IN: invLocationIdBySiteId.values() AND Name =: nameString]){
            rackIdByInvLocationId.put(rackSO.Inventory_Location__c, rackSO.Id);
        }
        
        // Create map of rack level Id by rack Id
        for(Rack_Level__c rackLevelSO : [Select Rack__c from Rack_Level__c Where Rack__c IN: rackIdByInvLocationId.values() AND Name =: nameString]){
            rackLevelIdByRackId.put(rackLevelSO.Rack__c, rackLevelSO.Id);
        }
        
        // Create map of bin location Id by rack level Id
        for(Bin_Location__c binLocationSO : [Select Rack_Level__c from Bin_Location__c Where Rack_Level__c IN: rackLevelIdByRackId.values() AND Name =: nameString]){
            binLocationIdByRackLevelId.put(binLocationSO.Rack_Level__c, binLocationSO.Id);
        }
        
        // Update inventory positions
        for(Inventory_Position__c invPosition : invPositions){
            invPosition.Inventory_Location__c = invLocationIdBySiteId.get(invPosition.Site__c);
            invPosition.Rack__c = rackIdByInvLocationId.get(invPosition.Inventory_Location__c);
            invPosition.Rack_Level__c = rackLevelIdByRackId.get(invPosition.Rack__c);
            invPosition.Bin_Location__c = binLocationIdByRackLevelId.get(invPosition.Rack_Level__c);
        }
        update invPositions;
    }
}