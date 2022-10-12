@isTest
public class BatchToUpdateCVUinBinTest {
	private static testmethod void runTest(){
        Test.startTest();
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        Contact objContact = new Contact();
        objContact.firstName = 'Test';
        objContact.LastName = 'Contact1';
        objContact.AccountId = objAccount.Id;
        objContact.Active__c = true;
        objContact.Compliance_Alert__c = true;
        objContact.email = 'test@gmail.com';
        insert objContact;
        
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        
        //Create Product1
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
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
        objProduct1.RecordTypeId = productRecordTypeId;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        insert objProduct1;
        
        Harvest_Batch_Code__c hbc = new Harvest_Batch_Code__c(Name='Test122',Active__c = true);
        insert hbc;
        
        Compliance_Images__c com=new Compliance_Images__c();
        com.COA_Issued_Date__c=System.today().addDays(-365);
        com.Product__c=objProduct1.id;
        com.Harvest_Batch_Code__c = hbc.Id;
        insert com;
        
        // Create Site
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.Warehouse_Name__c='TestWarehouse1';
        insert objSite;
        
        Inventory_Location__c receivingInventoryLocation = new Inventory_Location__c();
        receivingInventoryLocation.Name = 'Transferred';
        receivingInventoryLocation.Site_Name__c = objSite.id;
        receivingInventoryLocation.Default_for_Site__c = true;
        receivingInventoryLocation.Include_Auto_Merge_IP__c = true;
        insert receivingInventoryLocation;
        
        Inventory_Position__c inv = new Inventory_Position__c();
        inv.Harvest_Batch_Code__c = hbc.Id;
        inv.Product_Name__c = objProduct1.Id;
        inv.Qty_On_Hand__c=10;
        inv.Hold__c = false;
        inv.Site__c =  objSite.id;
        inv.Inventory_Location__c = receivingInventoryLocation.Id;
        insert inv;
        
        Inventory_Position__c inv2 = new Inventory_Position__c();
        inv2.Harvest_Batch_Code__c = hbc.Id;
        inv2.Product_Name__c = objProduct1.Id;
        inv2.Qty_On_Hand__c=10;
        inv2.Hold__c = false;
        inv2.Site__c =  objSite.id;
        inv2.Inventory_Location__c = receivingInventoryLocation.Id;
        insert inv2;
        
         // Create Rack with name as "QA Review"
        Rack__c rackSO = new Rack__c();
        rackSO.Inventory_Location__c = receivingInventoryLocation.Id;
        rackSO.Name = PicklistSupport.STATUS_QA_REVIEW;
        insert rackSO;
        
        // Create Rack Level with name as "QA Review"
        Rack_Level__c rackLevelSO = new Rack_Level__c();
        rackLevelSO.Rack__c = rackSO.Id;
        rackLevelSO.Name = PicklistSupport.STATUS_QA_REVIEW;
        insert rackLevelSO;
        
        // Create Bin location with name as "QA Review"
        Bin_Location__c binLocationSO = new Bin_Location__c();
        binLocationSO.Rack_Level__c = rackLevelSO.Id;
        binLocationSO.Bin_Height__c = 10.0;
        binLocationSO.Bin_Length__c = 10.0;
        binLocationSO.Bin_Width__c = 20.0;
        binLocationSO.Name = PicklistSupport.STATUS_QA_REVIEW;
        insert binLocationSO;
        
        List<Bin_Location__c> testBin = new List<Bin_Location__c>();
        testBin.add(binLocationSO);
        
        BatchToUpdateCVUinBin batch= new BatchToUpdateCVUinBin();
		ID rec = Database.executeBatch(batch);
        
        Test.stopTest();
    }
}