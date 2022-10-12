@isTest
public class BatchIDTriggerTest {
	private static testmethod void runTest(){
        Test.startTest();
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
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
        
        Compliance_Images__c com=new Compliance_Images__c();
        com.COA_Issued_Date__c=System.today().addDays(10);
        com.Product__c=objProduct1.id;
        insert com;
        
        Harvest_Batch_Code__c hbc = new Harvest_Batch_Code__c(Name='Test122',Active__c = true);
        insert hbc;
        
        Inventory_Position__c inv = new Inventory_Position__c();
        inv.Harvest_Batch_Code__c = hbc.Id;
        inv.Product_Name__c = objProduct1.Id;
        inv.Qty_On_Hand__c=10;
        inv.Hold__c = false;
        insert inv;
        
        com.Harvest_Batch_Code__c = hbc.Id;
        update com;
        
        hbc.THC__c = 10;
        hbc.Batch_ID_Hold__c = true;
        update hbc;
        
        hbc.Terpene__c = 12;
        hbc.Batch_ID_Hold__c = false;
        update hbc;
        
        try{
            Harvest_Batch_Code__c hbc2 = hbc.clone();
            insert hbc2;
        } catch(Exception ex){}
        
        System.assertEquals(com.Harvest_Batch_Code__c, hbc.Id);
        Test.stopTest();
    }
}