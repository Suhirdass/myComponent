@isTest
public class InventoryLocationsTriggerTest {
	@TestSetUp
        static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
    }
    
    static testMethod void inventoryLocationsTrigger(){
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
        receivingInventoryLocation.Auto_Hold__c=true;
        insert receivingInventoryLocation;
        
        Inventory_Position__c iv = new Inventory_Position__c();
        iv.Inventory_Location__c=receivingInventoryLocation.id;
        iv.Site__c =objSite.Id;
        iv.Qty_On_Hand__c=90;
        iv.Product_Name__c = objProduct1.Id;
        insert iv;
        
        receivingInventoryLocation.Auto_Hold__c=false;
        update receivingInventoryLocation;
        
        receivingInventoryLocation.Auto_Hold__c=true;
        update receivingInventoryLocation;
        
    }
}