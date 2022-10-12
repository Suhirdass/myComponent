@isTest
public class RSMControllerTest {
    @isTest
    public static void RSMControllerTestMethod() {
        
        Id RecordTypeIdAccount = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Retail').getRecordTypeId();
        Id RecordTypeIdsalesorder = Schema.SObjectType.Sales_Order__c.getRecordTypeInfosByName().get('Transfer').getRecordTypeId();
        Id RecordTypeIdManifest = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get('Product TSM').getRecordTypeId();
        Id RecordTypeIdproduct = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Product').getRecordTypeId();
        
        Account acc = new Account();
        acc.name = 'LDJNBW, LLC.';
        acc.Phone = '8965231452';
        acc.RecordTypeId = RecordTypeIdAccount;
        insert acc;
        
        Brand_Quote__c brand =new Brand_Quote__c();
        brand.BQ_Status__c = 'Approved';
        brand.Order_Type__c = 'Retail';
        insert brand;
        
        
        
        Sales_Order__c sales = new Sales_Order__c();
        sales.RecordTypeId = RecordTypeIdsalesorder;
        sales.Distributor_Name__c = acc.Id;
        sales.Brand_Quote__c = brand.Id;
        
        insert sales;
        
        Picklist__c picklist = new Picklist__c();
        picklist.Pick_Hold__c = True;
        picklist.Status__c = 'QA Confirm';
        picklist.Sales_Order__c = sales.Id;
        insert picklist;
        
        
        Shipping_Manifest__c ship = new Shipping_Manifest__c();
        ship.Sales_Order__c = sales.Id;
        ship.Payment_Terms__c = 'COD';
        ship.RecordTypeId = RecordTypeIdManifest;
        ship.Status__c = 'Draft';
        ship.Distributor_Name__c = acc.Id;  
        ship.Status__c = 'Draft';        
        insert ship;
       
        
        Product2 pro = new Product2();
        pro.name = 'GB-ChiliMango-M-E-10Pack';
        pro.Producer_Name__c= acc.Id;
        pro.RecordTypeId = RecordTypeIdproduct;
        pro.Description = 'Edible Gummy, Chili Mango, 10 Pack, Mixed';
        pro.Product_Short_Description__c = '10 Pack Gummy - Chili Mango';
        pro.Family = 'Accessories';
        pro.Apply_Excise_Tax__c = 'Yes';
        pro.Apply_Cultivation_Tax__c = 'Yes';
        pro.Retail_Unit_Form_Factor__c = 'Bag';
        pro.MOQ__c = 30;
        insert pro;
        
        
        Shipping_Manifest_Line__c shipping = new Shipping_Manifest_Line__c();
        shipping.Shipping_Manifest__c = ship.Id;
        shipping.Product_Name__c = pro.Id;
        shipping.Order_Type__c = 'Online';
        shipping.Product_Title__c = 'Distributor';
        shipping.Rejection_Reason__c = 'Damaged Products';
        shipping.Sales_Person__c = 'James Doherty';
        shipping.SMLine_Status__c = 'Draft';
        insert shipping;
        system.assert(shipping!=Null);
        
        
        Test.startTest();
        RSMController.getShippingDetails(ship.Id);
        RSMController.getRsmLines(ship.Id);
        Test.stopTest();
        
    }
    
}