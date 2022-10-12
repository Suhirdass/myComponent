@isTest
public class AllocationProcessforSOLITest {
    static Sales_Order_Line__c objSOLI;
    
    
    @TestSetUp
    static void testDataSetUp(){
        TestUtilData.createTestData();
    }
    
    static testMethod void allocationTest(){
        objSOLI = new Sales_Order_Line__c();
        objSOLI = [Select Id, Status__c, Balance_Qty_to_Allocate__c  from Sales_Order_Line__c LIMIT 1];
        objSOLI.Status__c = 'Open';
        objSOLI.Qty_Ordered__c = 1;
        update objSOLI;
        //system.debug('objSO'+objSO);
        List<Inventory_Location__c> inventoryLocations = [select Available_for_Allocation__c, Default_for_Site__c from Inventory_Location__c];
        
        for(Inventory_Location__c invLocationObj : inventoryLocations){
            invLocationObj.Default_for_Site__c =false;
            invLocationObj.Available_for_Allocation__c = true;
        }
        update inventoryLocations;
        
        List<Inventory_Position__c> inventorypossitions = [select id, Qty_On_Hand__c from Inventory_Position__c];
        inventorypossitions[1].Qty_On_Hand__c = 1;
        inventorypossitions[2].Qty_On_Hand__c = 4;
        
        update inventorypossitions;
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSOLI);
        AllocationProcessforSOLICtlr controllerObj = new AllocationProcessforSOLICtlr(stdController);
        controllerObj.AllocationProcess();
        controllerObj.goBack();
        list<Sales_Order_Line__c> lstSO = [select id, Status__c from Sales_Order_Line__c];
        System.assertNOTEquals(lstSO[1].Status__c,'Draft');
    }
    
    static testMethod void allocationTest1(){
        objSOLI = new Sales_Order_Line__c();
        objSOLI = [Select Id, Status__c, Balance_Qty_to_Allocate__c  from Sales_Order_Line__c LIMIT 1];
        objSOLI.Status__c = 'Open';
        update objSOLI;
        //system.debug('objSO'+objSO);
        List<Inventory_Location__c> inventoryLocations = [select Available_for_Allocation__c, Default_for_Site__c from Inventory_Location__c];
        
        for(Inventory_Location__c invLocationObj : inventoryLocations){
            invLocationObj.Default_for_Site__c =false;
            invLocationObj.Available_for_Allocation__c = true;
        }
        update inventoryLocations;
        
        List<Inventory_Position__c> inventorypossitions = [select id, Qty_On_Hand__c from Inventory_Position__c];
        inventorypossitions[1].Qty_On_Hand__c = 5;
        inventorypossitions[2].Qty_On_Hand__c = 5;
        
        update inventorypossitions;
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSOLI);
        AllocationProcessforSOLICtlr controllerObj = new AllocationProcessforSOLICtlr(stdController);
        controllerObj.AllocationProcess();
        controllerObj.goBack();
        list<Sales_Order_Line__c> lstSO = [select id, Status__c from Sales_Order_Line__c];
        System.assertNOTEquals(lstSO[1].Status__c,'Draft');
    }
    
    static testMethod void allocationTest2(){
        objSOLI = new Sales_Order_Line__c();
        objSOLI = [Select Id, Status__c, Balance_Qty_to_Allocate__c  from Sales_Order_Line__c LIMIT 1];
        objSOLI.Status__c = 'Open';
        objSOLI.Qty_Ordered__c = 5;
        update objSOLI;
        //system.debug('objSO'+objSO);
        List<Inventory_Location__c> inventoryLocations = [select Available_for_Allocation__c, Default_for_Site__c from Inventory_Location__c];
        
        for(Inventory_Location__c invLocationObj : inventoryLocations){
            invLocationObj.Default_for_Site__c =false;
            invLocationObj.Available_for_Allocation__c = true;
        }
        update inventoryLocations;
        
        List<Inventory_Position__c> inventorypossitions = [select id, Qty_On_Hand__c from Inventory_Position__c];
        inventorypossitions[1].Qty_On_Hand__c = 11;
        inventorypossitions[2].Qty_On_Hand__c = 4;
        
        update inventorypossitions;
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(objSOLI);
        AllocationProcessforSOLICtlr controllerObj = new AllocationProcessforSOLICtlr(stdController);
        controllerObj.AllocationProcess();
        controllerObj.goBack();
        list<Sales_Order_Line__c> lstSO = [select id, Status__c from Sales_Order_Line__c];
        System.assertNOTEquals(lstSO[1].Status__c,'Draft');
    }
    
}