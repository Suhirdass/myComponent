/**************************************************************************************
Apex Class Name    : OpportunityProductEditAllExtensionTest
Test Class for     :OpportunityProductEditAllExtension
Version            : 1.0
Created Date       : Aug 28 2018
Function           : Used for OpportunityProductEntry VF page
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresh                  08/28/2018              Original Version
  kumaravendan            08/09/2020              Modified
*******************************************************************************/
@istest
private class OpportunityProductEditAllExtensionTest{
    
    @isTest
    static void theTests(){
        Account a = new Account(Name = 'Test Account Joe ',Payment_Terms__c = 'COD');
        
        Product2 p1 = new Product2(Name='Product Monthly 1111', Family='Monthly', isActive=true,Quantity_Type__c ='Quantity',Stocking_UOM__c='EA');
        Product2 p2 = new Product2(Name='Product Yearly 2222', Family='Yearly', isActive=true,Quantity_Type__c ='Quantity',Stocking_UOM__c='EA');

        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        insert objProduct1;
        
        Id pricebookId = Test.getStandardPricebookId();
        
        PricebookEntry pbe1 = new PricebookEntry(Pricebook2id=pricebookId, Product2id=objProduct1.ID, isActive=true,  unitPrice=100);
        
        insert pbe1;

        Opportunity o = new Opportunity();
        
        
        insert a;
        
        o.AccountId = a.Id;
        o.Name = 'Test_Joe_123';
        o.StageName = 'Prospecting';
        o.CloseDate = date.today();
        o.Type = 'New Business';
        o.Pricebook2Id=pricebookId ;
        o.Payment_Terms__c = 'COD';
        insert o;
        
        OpportunityLineItem ol = new OpportunityLineItem();
        ol.OpportunityId = o.Id;
        ol.Quantity = 1;
        ol.UnitPrice = 2.00;
        ol.PricebookEntryId = pbe1.Id;
        ol.MOQ_TF__c = 1;
        ol.Available_Inventory__c=100;
        
        insert ol;
        
        OpportunityLineItem ol2 = new OpportunityLineItem();
        ol2.OpportunityId = o.Id;
        ol2.Quantity = 1;
        ol2.UnitPrice = 10;
        ol2.PricebookEntryId = pbe1.Id;
        ol2.MOQ_TF__c = 1;
        ol2.Available_Inventory__c=100;

        
        PageReference pageRef = Page.OpportunityProductEditAll;
        pageRef.getParameters().put('Id',o.id);
        Test.setCurrentPageReference(pageRef);
        
        OpportunityProductEditAllExtension oPEE = new OpportunityProductEditAllExtension(new ApexPages.StandardController(o));
        opEE.onSave();
        opEE.onCancel();
        
    }
    
    @isTest
    static void theTests2(){
        Account a = new Account(Name = 'Test Account Joe ',Payment_Terms__c = 'COD');
        
        Product2 p1 = new Product2(Name='Product Monthly 1111', Family='Monthly', isActive=true,Quantity_Type__c ='Quantity',Stocking_UOM__c='EA');
        Product2 p2 = new Product2(Name='Product Yearly 2222', Family='Yearly', isActive=true,Quantity_Type__c ='Quantity',Stocking_UOM__c='EA');

        
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        insert objProduct1;
        
        Id pricebookId = Test.getStandardPricebookId();
        
        PricebookEntry pbe1 = new PricebookEntry(Pricebook2id=pricebookId, Product2id=objProduct1.ID, isActive=true,  unitPrice=100);
        insert pbe1;

        Opportunity o = new Opportunity();
        
        
        insert a;
        
        o.AccountId = a.Id;
        o.Name = 'Test_Joe_123';
        o.StageName = 'Prospecting';
        o.CloseDate = date.today();
        o.Type = 'New Business';
        o.Pricebook2Id=pricebookId ;
        o.Payment_Terms__c='COD';
        insert o;
        
        OpportunityLineItem ol2 = new OpportunityLineItem();
        ol2.OpportunityId = o.Id;
        ol2.Quantity = 1;
        ol2.UnitPrice = 10;
        ol2.PricebookEntryId = pbe1.Id;
        ol2.MOQ_TF__c = 1;
        ol2.Available_Inventory__c = 100;
        insert ol2;
        
        PageReference pageRef = Page.OpportunityProductEditAll;
        pageRef.getParameters().put('Id',o.id);
        Test.setCurrentPageReference(pageRef);
        
        // load the extension
        OpportunityProductEditAllExtension oPEE = new OpportunityProductEditAllExtension(new ApexPages.StandardController(o));
        opEE.onSave();
        opEE.onCancel();
        OpportunityProductEditAllExtension.opportunityProductEdit(o.id);
        OpportunityProductEditAllExtension.onSaveCart(oPEE.shoppingCart);
    }
}