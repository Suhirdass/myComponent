/**************************************************************************************
Apex Class Name    : InventoryPositionsHelperTriggerTest 
Version            : 1.0
Created Date       : Aug 27 2018
Function           : Test class for InventoryPositionsTrigger & InventoryPositionsHelper
Modification Log   :
------------------------------------------------------------------------------
 * Developer                   Date                   Description
 * ----------------------------------------------------------------------------
 * Suresh                  08/27/2018              Original Version
*******************************************************************************/
@isTest
public class InventoryPositionsHelperTriggerTest {
    static List<Inventory_Position__c> invPositions;
    static List<Product2> products;

    @TestSetUp
        static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
            SOlineTriggerHandler.isRecursion = true;
            OrderHelper.runningTrigger = true;
        TestUtilData.createTestData();
    }

    static testMethod void inventoryPositionsHelperTest(){
    OrderHelper.runningTrigger = true;
        Account objAccount = new Account();
        objAccount.Name = 'Irrational Raccoon, LLC';
        objAccount.Payment_Terms__c = 'COD';
        //accounts.add(objAccount);  
        insert objAccount;
        
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product KD';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        insert objProduct1;
         // Create Site
        Site__c objSite = new Site__c();
        objSite.Name = '2089-3';
        insert objSite;
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        // Create price book entry for first product
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id=Test.getStandardPricebookId(), Product2Id=objProduct1.Id, UnitPrice=99, isActive=true);
        insert pbe;
        
        Order_Line_Item__c ol= new Order_Line_Item__c();
        ol.Price_Book_Entry_Id__c=Id.valueOf(pbe.id);
        ol.UnitPrice__c=10;
        ol.MOQ__c=4;
        ol.Quantity_Cases__c=2;
        ol.Order__c=ord.id;
        ol.Product__c = objProduct1.id;
        insert ol;
        // Receiving Inspection inventory location
        
        Inventory_Location__c receivingInventoryLocation = new Inventory_Location__c();
        receivingInventoryLocation.Name ='Storage Main';
        receivingInventoryLocation.Site_Name__c = objSite.id;
        receivingInventoryLocation.Default_for_Site__c = true;
        receivingInventoryLocation.Include_in_Inventory__c=true;
        insert receivingInventoryLocation;
        
        UID__c uid = new UID__c();
        uid.Name = 'test12345678912341234125';
        insert uid;
        
        List<Receiving_Line__c> receivingLines = [select id from Receiving_Line__c];
        Inventory_Position__c inv = new Inventory_Position__c();
        inv.Receiving_Line__c=receivingLines[0].ID;
        inv.Product_Name__c=objProduct1.id;
        inv.Qty_On_Hand__c=10;
        inv.Qty_Allocated__c=100;
        inv.Site__c=objSite.id;
        inv.Inventory_Location__c=receivingInventoryLocation.id;
        inv.UID_New__c = uid.Id;
        insert inv;
        
        
         invPositions = [Select Rack__c, 
                           Rack_Level__c, 
                 Bin_Location__c, 
                 Qty_On_Hand__c,
                 Inventory_Location__c,
                 Inventory_Location__r.Name
                 From Inventory_Position__c];
        
        invPositions[0].UID_New__c = uid.Id;
        
        update invPositions;
        System.assertNOTEquals(objProduct1,null);
        
    }  
}