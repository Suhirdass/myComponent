/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * ProductTriggerHandlerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class ProductTriggerHandlerTest{
    
    // Test product name duplicate validation on insert
    static testMethod void testDuplicateProductNameOnInsert(){
        
        // Create account;
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        Id RecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Discount').getRecordTypeId();
        
        // Create Product
        List<Product2> products = new List<Product2>();
        
        //Create Product1
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c = 'Yes';
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.recordTypeId = RecordTypeId;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        objProduct1.Stocking_UOM__c = 'EA';
        products.add(objProduct1);
        
        // Create Product2
        Product2  objProduct2 = new Product2 ();
        objProduct2.Name = 'product 2';
        objProduct2.Family = 'Edibles';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
        objProduct2.Apply_Cultivation_Tax__c = 'Yes';
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.IsActive = true;
        objProduct2.Unit_Height__c  = 20.0;
        objProduct2.Unit_Length__c = 10.0;
        objProduct2.Unit_Width__c = 5.0;
        objProduct2.recordTypeId = RecordTypeId;
        objProduct2.Track_Trace_Category__c='Capsule';
        objProduct2.Net_Weight_UOM__c='EA';
        objProduct2.Unit_Of_Measure__c='Grams';
        objProduct2.MOQ__c = 1;
        objProduct2.Stocking_UOM__c = 'EA';
        products.add(objProduct2);
        
        // Create Product3
        Product2  objProduct3 = new Product2 ();
        objProduct3.Name = 'product 3';
        objProduct3.Family = 'Edibles';
        objProduct3.Description = 'test product 3';
        objProduct3.Producer_Name__c = objAccount.id;
        objProduct3.Apply_Cultivation_Tax__c = 'Yes';
        objProduct3.Apply_Excise_Tax__c = 'Yes';
        objProduct3.IsActive = true;
        objProduct3.Unit_Height__c  = 30.0;
        objProduct3.Unit_Length__c = 10.0;
        objProduct3.Unit_Width__c = 5.0;
        objProduct3.recordTypeId = RecordTypeId;
        objProduct3.Track_Trace_Category__c='Capsule';
        objProduct3.Net_Weight_UOM__c='EA';
        objProduct3.Unit_Of_Measure__c='Grams';
        objProduct3.MOQ__c = 1;
        objProduct3.Stocking_UOM__c = 'EA';
        products.add(objProduct3);
        
        insert products;
        
        Test.startTest();
        // Create Product4
        Product2  objProduct4 = new Product2 ();
        objProduct4.Name = 'product 1';
        objProduct4.Family = 'Edibles';
        objProduct4.Description = 'test product 1';
        objProduct4.Producer_Name__c = objAccount.id;
        objProduct4.Apply_Cultivation_Tax__c = 'Yes';
        objProduct4.Apply_Excise_Tax__c = 'Yes';
        objProduct4.IsActive = true;
        objProduct4.Unit_Height__c  = 30.0;
        objProduct4.Unit_Length__c = 10.0;
        objProduct4.Unit_Width__c = 5.0;
        
        try{
            insert objProduct4;
            //System.assert(false);
        }catch(Exception ex){
            System.assert(ex.getMessage().contains(
                          String.format(Label.Product_name_duplicate_validation_error, 
                          new List<String>{objProduct4.Name, objProduct1.Id, objProduct1.Name})),
                          'Exception message mis-match');
        }
        Test.stopTest();
    }
    
    // Test product name duplicate validation applies on inactive existing product on insert
    static testMethod void testDuplicateProductNameForExistigInActiveProductOnInsert(){
        
        // Create account;
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        // Create Product
        List<Product2> products = new List<Product2>();
        
        //Create Product1
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c = 'Yes';
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.IsActive = false;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        objProduct1.Stocking_UOM__c = 'EA';
        products.add(objProduct1);
        
        // Create Product2
        Product2  objProduct2 = new Product2 ();
        objProduct2.Name = 'product 2';
        objProduct2.Family = 'Edibles';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
        objProduct2.Apply_Cultivation_Tax__c = 'Yes';
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.IsActive = true;
        objProduct2.Unit_Height__c  = 20.0;
        objProduct2.Unit_Length__c = 10.0;
        objProduct2.Unit_Width__c = 5.0;
        objProduct2.Track_Trace_Category__c='Capsule';
        objProduct2.Net_Weight_UOM__c='EA';
        objProduct2.Unit_Of_Measure__c='Grams';
        objProduct2.MOQ__c = 1;
        objProduct2.Stocking_UOM__c = 'EA';
        products.add(objProduct2);
        
        // Create Product3
        Product2  objProduct3 = new Product2 ();
        objProduct3.Name = 'product 3';
        objProduct3.Family = 'Edibles';
        objProduct3.Description = 'test product 3';
        objProduct3.Producer_Name__c = objAccount.id;
        objProduct3.Apply_Cultivation_Tax__c = 'Yes';
        objProduct3.Apply_Excise_Tax__c = 'Yes';
        objProduct3.IsActive = true;
        objProduct3.Unit_Height__c  = 30.0;
        objProduct3.Unit_Length__c = 10.0;
        objProduct3.Unit_Width__c = 5.0;
        objProduct3.Track_Trace_Category__c='Capsule';
        objProduct3.Net_Weight_UOM__c='EA';
        objProduct3.Unit_Of_Measure__c='Grams';
        objProduct3.MOQ__c = 1;
        objProduct3.Stocking_UOM__c = 'EA';
        products.add(objProduct3);
        
        insert products;
        
        Test.startTest();
        // Create Product4
        Product2  objProduct4 = new Product2 ();
        objProduct4.Name = 'product 1';
        objProduct4.Family = 'Edibles';
        objProduct4.Description = 'test product 1';
        objProduct4.Producer_Name__c = objAccount.id;
        objProduct4.Apply_Cultivation_Tax__c = 'Yes';
        objProduct4.Apply_Excise_Tax__c = 'Yes';
        objProduct4.IsActive = true;
        objProduct4.Unit_Height__c  = 30.0;
        objProduct4.Unit_Length__c = 10.0;
        objProduct4.Unit_Width__c = 5.0;
        
        try{
            insert objProduct4;
            //System.assert(false);
        }catch(Exception ex){
            System.assert(ex.getMessage().contains(
                          String.format(Label.Product_name_duplicate_validation_error, 
                          new List<String>{objProduct4.Name, objProduct1.Id, objProduct1.Name})),
                          'Exception message mis-match');
        }
        Test.stopTest();
    }
    
    // Test product name duplicate validation with case insensitive on insert
    static testMethod void testDuplicateProductNameCaseInSensitiveOnInsert(){
        
        // Create account;
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        // Create Product
        List<Product2> products = new List<Product2>();
        
        //Create Product1
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c = 'Yes';
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        objProduct1.Stocking_UOM__c = 'EA';
        products.add(objProduct1);
        
        // Create Product2
        Product2  objProduct2 = new Product2 ();
        objProduct2.Name = 'product 2';
        objProduct2.Family = 'Edibles';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
        objProduct2.Apply_Cultivation_Tax__c = 'Yes';
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.IsActive = true;
        objProduct2.Unit_Height__c  = 20.0;
        objProduct2.Unit_Length__c = 10.0;
        objProduct2.Unit_Width__c = 5.0;
        objProduct2.Track_Trace_Category__c='Capsule';
        objProduct2.Net_Weight_UOM__c='EA';
        objProduct2.Unit_Of_Measure__c='Grams';
        objProduct2.MOQ__c = 1;
        objProduct2.Stocking_UOM__c = 'EA';
        products.add(objProduct2);
        
        // Create Product3
        Product2  objProduct3 = new Product2 ();
        objProduct3.Name = 'product 3';
        objProduct3.Family = 'Edibles';
        objProduct3.Description = 'test product 3';
        objProduct3.Producer_Name__c = objAccount.id;
        objProduct3.Apply_Cultivation_Tax__c = 'Yes';
        objProduct3.Apply_Excise_Tax__c = 'Yes';
        objProduct3.IsActive = true;
        objProduct3.Unit_Height__c  = 30.0;
        objProduct3.Unit_Length__c = 10.0;
        objProduct3.Unit_Width__c = 5.0;
        objProduct3.Track_Trace_Category__c='Capsule';
        objProduct3.Net_Weight_UOM__c='EA';
        objProduct3.Unit_Of_Measure__c='Grams';
        objProduct3.MOQ__c = 1;
        objProduct3.Stocking_UOM__c = 'EA';
        products.add(objProduct3);
        
        insert products;
        
        Test.startTest();
        // Create Product4
        Product2  objProduct4 = new Product2 ();
        objProduct4.Name = 'PRODUCT 1';
        objProduct4.Family = 'Edibles';
        objProduct4.Description = 'test product 1';
        objProduct4.Producer_Name__c = objAccount.id;
        objProduct4.Apply_Cultivation_Tax__c = 'Yes';
        objProduct4.Apply_Excise_Tax__c = 'Yes';
        objProduct4.IsActive = true;
        objProduct4.Unit_Height__c  = 30.0;
        objProduct4.Unit_Length__c = 10.0;
        objProduct4.Unit_Width__c = 5.0;
        
        try{
            insert objProduct4;
            //System.assert(false);
        }catch(Exception ex){
            System.assert(ex.getMessage().contains(
                          String.format(Label.Product_name_duplicate_validation_error, 
                          new List<String>{objProduct4.Name, objProduct1.Id, objProduct1.Name})),
                          'Exception message mis-match');
        }
        Test.stopTest();
    }
    
    // Test product name duplicate validation on update
    static testMethod void testDuplicateProductNameOnUpdate(){
        
        // Create account;
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        // Create Product
        List<Product2> products = new List<Product2>();
        
        //Create Product1
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c = 'Yes';
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        objProduct1.Stocking_UOM__c = 'EA';
        products.add(objProduct1);
        
        // Create Product2
        Product2  objProduct2 = new Product2 ();
        objProduct2.Name = 'product 2';
        objProduct2.Family = 'Edibles';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
        objProduct2.Apply_Cultivation_Tax__c = 'Yes';
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.IsActive = true;
        objProduct2.Unit_Height__c  = 20.0;
        objProduct2.Unit_Length__c = 10.0;
        objProduct2.Unit_Width__c = 5.0;
        objProduct2.Track_Trace_Category__c='Capsule';
        objProduct2.Net_Weight_UOM__c='EA';
        objProduct2.Unit_Of_Measure__c='Grams';
        objProduct2.MOQ__c = 1;
        objProduct2.Stocking_UOM__c = 'EA';
        products.add(objProduct2);
        
        // Create Product3
        Product2  objProduct3 = new Product2 ();
        objProduct3.Name = 'product 3';
        objProduct3.Family = 'Edibles';
        objProduct3.Description = 'test product 3';
        objProduct3.Producer_Name__c = objAccount.id;
        objProduct3.Apply_Cultivation_Tax__c = 'Yes';
        objProduct3.Apply_Excise_Tax__c = 'Yes';
        objProduct3.IsActive = true;
        objProduct3.Unit_Height__c  = 30.0;
        objProduct3.Unit_Length__c = 10.0;
        objProduct3.Unit_Width__c = 5.0;
        objProduct3.Track_Trace_Category__c='Capsule';
        objProduct3.Net_Weight_UOM__c='EA';
        objProduct3.Unit_Of_Measure__c='Grams';
        objProduct3.MOQ__c = 1;
        objProduct3.Stocking_UOM__c = 'EA';
        products.add(objProduct3);
        
        insert products;
        
        Test.startTest();
        try{
            objProduct2.Name = 'product 1';
            update objProduct2;
            System.assert(false);
        }catch(Exception ex){
            System.assert(ex.getMessage().contains(
                          String.format(Label.Product_name_duplicate_validation_error, 
                          new List<String>{objProduct2.Name, objProduct1.Id, objProduct1.Name})),
                          'Exception message mis-match');
        }
        Test.stopTest();
    }
    
    // Test allow unique name of product to save
    static testMethod void testAllowUniqueNameOfProduct(){
        
        // Create account;
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        // Create Product
        List<Product2> products = new List<Product2>();
        
        //Create Product1
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c = 'Yes';
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        objProduct1.Stocking_UOM__c = 'EA';
        products.add(objProduct1);
        
        // Create Product2
        Product2  objProduct2 = new Product2 ();
        objProduct2.Name = 'product 2';
        objProduct2.Family = 'Edibles';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
        objProduct2.Apply_Cultivation_Tax__c = 'Yes';
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.IsActive = true;
        objProduct2.Unit_Height__c  = 20.0;
        objProduct2.Unit_Length__c = 10.0;
        objProduct2.Unit_Width__c = 5.0;
        objProduct2.Track_Trace_Category__c='Capsule';
        objProduct2.Net_Weight_UOM__c='EA';
        objProduct2.Unit_Of_Measure__c='Grams';
        objProduct2.MOQ__c = 1;
        objProduct2.Stocking_UOM__c = 'EA';
        products.add(objProduct2);
        
        // Create Product3
        Product2  objProduct3 = new Product2 ();
        objProduct3.Name = 'product 3';
        objProduct3.Family = 'Edibles';
        objProduct3.Description = 'test product 3';
        objProduct3.Producer_Name__c = objAccount.id;
        objProduct3.Apply_Cultivation_Tax__c = 'Yes';
        objProduct3.Apply_Excise_Tax__c = 'Yes';
        objProduct3.IsActive = true;
        objProduct3.Unit_Height__c  = 30.0;
        objProduct3.Unit_Length__c = 10.0;
        objProduct3.Unit_Width__c = 5.0;
        objProduct3.Track_Trace_Category__c='Capsule';
        objProduct3.Net_Weight_UOM__c='EA';
        objProduct3.Unit_Of_Measure__c='Grams';
        objProduct3.MOQ__c = 1;
        objProduct3.Stocking_UOM__c = 'EA';
        products.add(objProduct3);
        
        insert products;
        
        Test.startTest();
        // Create Product4
        Product2  objProduct4 = new Product2 ();
        objProduct4.Name = 'product 4';
        objProduct4.Family = 'Edibles';
        objProduct4.Description = 'test product 4';
        objProduct4.Producer_Name__c = objAccount.id;
        objProduct4.Apply_Cultivation_Tax__c = 'Yes';
        objProduct4.Apply_Excise_Tax__c = 'Yes';
        objProduct4.IsActive = true;
        objProduct4.Unit_Height__c  = 30.0;
        objProduct4.Unit_Length__c = 10.0;
        objProduct4.Unit_Width__c = 5.0;
        
        try{
            insert objProduct4;
        }catch(Exception ex){
            //System.assert(false);
        }
        Test.stopTest();
    }
}