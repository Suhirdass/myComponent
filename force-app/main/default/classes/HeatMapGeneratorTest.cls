@IsTest 
public class HeatMapGeneratorTest {
    @testSetup static void setup() {
        Site__c site = new Site__c(Name='Test Site');
        insert site;
		Inventory_Location__c iLocation = new Inventory_Location__c(Name = 'Test Location',Site_Name__c = site.Id,Include_in_Heat_Map__c = TRUE);
        insert iLocation;
        
        Rack__c rack = new Rack__c(Name = 'Test Rack',Inventory_Location__c = iLocation.Id);
        insert rack;
        Rack_Level__c rackLevel = new Rack_Level__c(Name = 'Test Rack Level',Rack__c = rack.Id);
        insert rackLevel;
        Bin_Location__c binLocation = new Bin_Location__c(Name = 'Test Rack Level',Rack_Level__c = rackLevel.Id);
        insert binLocation;
        
        Rack__c rack1 = new Rack__c(Name = 'Test Rack',Inventory_Location__c = iLocation.Id);
        insert rack1;
        Rack_Level__c rackLevel1 = new Rack_Level__c(Name = 'Test Rack Level',Rack__c = rack.Id);
        insert rackLevel1;
        Bin_Location__c binLocation1 = new Bin_Location__c(Name = 'Test Rack Level',Rack_Level__c = rackLevel.Id);
        insert binLocation1;
        
        Inventory_Position__c iPosition = new Inventory_Position__c(
            Bin_Location__c = binLocation.Id,
            Rack__c  = rack.id,
            Rack_Level__c = rackLevel.Id,
         Inventory_Location__c  = iLocation.Id,
         Site__c  = site.Id);
        insert iPosition;
    }
    @isTest
    public static void testHeatMap(){
        HeatMapGeneratorCtlr heatMap = new HeatMapGeneratorCtlr();
        HeatMapGeneratorCtlr.heatMapGenerator();
        HeatMapGeneratorCtlr.getAllLocations(heatMap.siteId);
        HeatMapGeneratorCtlr.getProcessRackData(heatMap.iLocation);
        System.assertNotEquals(null, heatMap.jsonData);
    }
}