@isTest
public class BatchNotifyOnExpireCITest {
	private static testmethod void runTest(){
        Test.startTest();
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        Account objAccount2 = new Account();
        objAccount2.Name = 'Test Account2';
        objAccount2.Payment_Terms__c = 'COD';
        insert objAccount2;
        
        Contact objContact = new Contact();
        objContact.FirstName = 'Test';
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
        objProduct1.Total_Inventory__c = 100;
        insert objProduct1;
        
        //Create Product1
        Product2  objProduct2 = new Product2 ();
        objProduct2.Name = 'product 2';
        objProduct2.Quantity_Type__c = 'Quantity';
        objProduct2.Family = 'Accessories';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
        objProduct2.Apply_Cultivation_Tax__c='Yes';
        objProduct2.Apply_Excise_Tax__c='Yes';
        objProduct2.IsActive = true;
        objProduct2.Unit_Height__c  = 10.0;
        objProduct2.Unit_Length__c = 10.0;
        objProduct2.Unit_Width__c = 5.0;
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.RecordTypeId = productRecordTypeId;
        objProduct2.Track_Trace_Category__c='Capsule';
        objProduct2.Net_Weight_UOM__c='EA';
        objProduct2.Unit_Of_Measure__c='Grams';
        objProduct2.MOQ__c = 1;
        objProduct2.Total_Inventory__c = 100;
        objProduct2.White_Labelled__c = true;
        objProduct2.Licensee_Name__c = objAccount.Id;
        insert objProduct2;
        
        //Create Product1
        Product2  objProduct3 = new Product2 ();
        objProduct3.Name = 'product 3';
        objProduct3.Quantity_Type__c = 'Quantity';
        objProduct3.Family = 'Accessories';
        objProduct3.Description = 'test product 1';
        objProduct3.Producer_Name__c = objAccount2.id;
        objProduct3.Apply_Cultivation_Tax__c='Yes';
        objProduct3.Apply_Excise_Tax__c='Yes';
        objProduct3.IsActive = true;
        objProduct3.Unit_Height__c  = 10.0;
        objProduct3.Unit_Length__c = 10.0;
        objProduct3.Unit_Width__c = 5.0;
        objProduct3.Apply_Excise_Tax__c = 'Yes';
        objProduct3.RecordTypeId = productRecordTypeId;
        objProduct3.Track_Trace_Category__c='Capsule';
        objProduct3.Net_Weight_UOM__c='EA';
        objProduct3.Unit_Of_Measure__c='Grams';
        objProduct3.MOQ__c = 1;
        objProduct3.Total_Inventory__c = 100;
        insert objProduct3;
        
        Harvest_Batch_Code__c hbc = new Harvest_Batch_Code__c(Name='Test122',Active__c = true);
        insert hbc;
        
        Compliance_Images__c com=new Compliance_Images__c();
        com.COA_Issued_Date__c= Date.today().addDays(-365);
        com.Product__c=objProduct1.id;
        com.Harvest_Batch_Code__c = hbc.Id;
        com.Lab_Test_Status__c = 'Sampled';
        insert com;
        
        Compliance_Images__c com2=new Compliance_Images__c();
        com2.COA_Issued_Date__c= Date.today().addDays(-365);
        com2.Product__c=objProduct2.id;
        com2.Harvest_Batch_Code__c = hbc.Id;
        com2.Lab_Test_Status__c = 'Sampled';
        insert com2;
        
        Compliance_Images__c com3=new Compliance_Images__c();
        com3.COA_Issued_Date__c= Date.today().addDays(-365);
        com3.Product__c=objProduct3.id;
        com3.Harvest_Batch_Code__c = hbc.Id;
        com3.Lab_Test_Status__c = 'Sampled';
        insert com3;
        
        Inventory_Position__c inv = new Inventory_Position__c();
        inv.Harvest_Batch_Code__c = hbc.Id;
        inv.Product_Name__c = objProduct1.Id;
        inv.Qty_On_Hand__c=10;
        inv.Hold__c = false;
        insert inv;
        
        Inventory_Position__c inv2 = new Inventory_Position__c();
        inv2.Harvest_Batch_Code__c = hbc.Id;
        inv2.Product_Name__c = objProduct3.Id;
        inv2.Qty_On_Hand__c=10;
        inv2.Hold__c = false;
        insert inv2;
        
        Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Expire_Days__c='1,30',Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,LateFee__c = 0.020,Route_Origin_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US',Route_Destination_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US');
        insert ccs;
        
        BatchNotifyOnExpireCI batch= new BatchNotifyOnExpireCI(1);
		ID rec = Database.executeBatch(batch);
        
        BatchNotifyOnExpireCI sh1 = new BatchNotifyOnExpireCI();
        
        String sch = '0 0 23 * * ?'; 
        system.schedule('Test BatchNotifyOnExpireCI', sch, sh1);
        
        Test.stopTest();
    }
}