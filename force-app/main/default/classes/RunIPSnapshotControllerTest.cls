@isTest
public class RunIPSnapshotControllerTest {
    static testMethod void runSnapshotTest(){
        Test.startTest();
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hold__c=true;
        objAccount.DBA__c='Test Account1';
        objAccount.Hide_from_Marketplace__c = false;
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
        
        Site__c s = new Site__c();
        s.Name ='2089';
        insert s;
        Inventory_Location__c il = new Inventory_Location__c ();
        il.Name='QA Review';
        il.Site_Name__c=s.Id;
        insert il;
        
        Decimal totalQty = 0.0;
        Inventory_Position__c iv = new Inventory_Position__c();
        iv.Inventory_Location__c=il.id;
        iv.Site__c =s.Id;
        iv.Qty_On_Hand__c=90;
        iv.Product_Name__c = objProduct1.Id;
        totalQty = totalQty + iv.Qty_On_Hand__c;
        insert iv;
        
        RunIPSnapshotController.runIPSnapshot(objProduct1.Id);
      	Database.executeBatch(new BatchToRunIPSnapshot());
        Test.stopTest();
    }
}