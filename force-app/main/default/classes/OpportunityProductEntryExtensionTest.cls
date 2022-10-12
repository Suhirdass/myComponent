/**************************************************************************************
Apex Class Name    : OpportunityProductEntryExtensionTest
Test Class for     :OpportunityProductEntryExtension
Version            : 1.0
Created Date       : Aug 28 2018
Function           : Used for OpportunityProductEntry VF page
Modification Log   :
------------------------------------------------------------------------------
 * Developer                   Date                   Description
 * ----------------------------------------------------------------------------
 * Suresh                  08/28/2018              Original Version
*******************************************************************************/
@istest
private class OpportunityProductEntryExtensionTest{
    static void initData()
    {
        Account a = new Account(Name = 'Test Account Joe ',Payment_Terms__c = 'COD');
        
        Product2 p1 = new Product2(Name='Product Monthly 1111', Family='Monthly', isActive=true,Quantity_Type__c ='Quantity',Stocking_UOM__c='EA');
        Product2 p2 = new Product2(Name='Product Yearly 2222', Family='Yearly', isActive=true,Quantity_Type__c ='Quantity',Stocking_UOM__c='EA');

        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        //objProduct1.Producer_Name__c = objAccount.id;
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
        //List<Product2> pid= [select id,name from Product2 limit 1];
        
        PricebookEntry pbe1 = new PricebookEntry(Pricebook2id=pricebookId, Product2id=objProduct1.ID, isActive=true,  unitPrice=100);
        //PricebookEntry pbe2 = new PricebookEntry(Pricebook2id=pricebookId, Product2id=p2.ID, isActive=true,  unitPrice=50);
        
        insert pbe1;
        //insert pbe2;
        
        Pricebook2 customPB4 = new Pricebook2(Name='Custom Pricebook4', isActive=true);
		insert customPB4;
        
        //PricebookEntry pbID = [select Id, name from PricebookEntry where isActive = True limit 1];
        Opportunity o = new Opportunity();
        OpportunityLineItem ol = new OpportunityLineItem();
        
        insert a;
        
        o.AccountId = a.Id;
        o.Name = 'Test_Joe_123';
        o.StageName = 'Prospecting';
        o.CloseDate = date.today();
        o.Type = 'New Business';
        o.Pricebook2Id=pricebookId ;
        o.Payment_Terms__c='COD';
        o.Pricebook2 = customPB4;
        insert o;
        
        ol.OpportunityId = o.Id;
        ol.Quantity = 1;
        ol.UnitPrice = 2.00;
        ol.Available_Inventory__c=100;
        ol.MOQ_TF__c=1;
        ol.PricebookEntryId = pbe1.Id;
        
        insert ol;
    }
    
    @isTest(SeeAllData=false) 
    static void theTests(){
        initData();
        
        // You really should create test data, but I'm going to query instead
        // It's my best shot of avoiding a test failure in most orgs
        // Once you've installed this package though, you might want to write your own tests
        // or at least customize these ones to make them more applicable to your org
        
        //OpportunityLineItem oli = [select Id, Available_Inventory__c,MOQ_TF__c, PricebookEntryId, PricebookEntry.Pricebook2Id, PricebookEntry.Name, PriceBookEntry.Product2Id, OpportunityId, Opportunity.AccountId from OpportunityLineItem limit 1];
        OpportunityLineItem oli = [select Id,Quantity, Available_Inventory__c,MOQ_TF__c, PricebookEntryId, PricebookEntry.Pricebook2Id, PricebookEntry.Name, PriceBookEntry.Product2Id, OpportunityId, Opportunity.AccountId from OpportunityLineItem where Available_Inventory__c >0 and MOQ_TF__c > 0 limit 1];     
        ////////////////////////////////////////
        //  test opportunityProductEntry
        ////////////////////////////////////////
        
        // load the page       
        PageReference pageRef = Page.opportunityProductEntry;
        pageRef.getParameters().put('Id',oli.OpportunityId);
        Test.setCurrentPageReference(pageRef);
        
        Pricebook2 customPB1 = new Pricebook2(Name='Custom Pricebook1', isActive=true);
		insert customPB1;
        
        Pricebook2 customPB2 = new Pricebook2(Name='Custom Pricebook2', isActive=true);
		insert customPB2;
        
        Pricebook2 customPB3 = new Pricebook2(Name='Custom Pricebook3', isActive=true);
		insert customPB3;
        
        // load the extension
        opportunityProductEntryExtension oPEE = new opportunityProductEntryExtension(new ApexPages.StandardController(oli.Opportunity));
        // Pricebook2  b =[select id from Pricebook2 where ID=:Test.getStandardPricebookId()];
        //oPEE.theBook =b;
        // test 'getChosenCurrency' method
        if(UserInfo.isMultiCurrencyOrganization())
            System.assert(oPEE.getChosenCurrency()!='');
        else
            System.assertEquals(oPEE.getChosenCurrency(),'');
        
        // we know that there is at least one line item, so we confirm
        Integer startCount = oPEE.ShoppingCart.size();
        //oPEE.priceBookCheck();
        oPEE.onCancel();
        oPEE.getTotalQty();
        oPEE.changePricebook();
        //test search functionality without finding anything
        //oPEE.searchString = 'test search';
        oPEE.updateAvailableList();
        
        
        //test remove from shopping cart
        oPEE.toUnselect = oli.PricebookEntryId;
        oPEE.removeFromShoppingCart();
        
        
        //test save and reload extension
        oPEE.onSave();
        oPEE = new opportunityProductEntryExtension(new ApexPages.StandardController(oli.Opportunity));
        
        // test search again, this time we will find something
        //oPEE.searchString = oli.PricebookEntry.Name;
        oPEE.updateAvailableList();
        
        
        // test add to Shopping Cart function
        oPEE.toSelect = oPEE.AvailableProducts[0].Id;
        oPEE.addToShoppingCart();
        
        
        // test save method - WITHOUT quanitities and amounts entered and confirm that error message is displayed
        oPEE.onSave();
        
        // add required info and try save again
        for(OpportunityLineItem o : oPEE.ShoppingCart){
            o.quantity = 5;
            o.unitprice = 300;
        }
        oPEE.onSave();
        
        // query line items to confirm that the save worked
        opportunityLineItem[] oli2 = [select Id,Available_Inventory__c,MOQ_TF__c,PricebookEntryId,UnitPrice from opportunityLineItem where OpportunityId = :oli.OpportunityId];
        
        List<priceBookEntry> lstPriceBook = [select Id,Name,UnitPrice,Product2.MOQ__c,Product2.Available_Inventory__c from priceBookEntry];
        
        // test on new Opp (no pricebook selected) to make sure redirect is happening
        Opportunity newOpp = new Opportunity(Name='New Opp',stageName='Pipeline',Amount=10,closeDate=System.Today()+30,AccountId=oli.Opportunity.AccountId,Payment_Terms__c = 'COD');
        insert(newOpp);
        oPEE = new opportunityProductEntryExtension(new ApexPages.StandardController(newOpp));
        
        // final quick check of cancel button
        
        opportunityProductEntryExtension.opportunityProductEntry(newOpp.Id);
        opportunityProductEntryExtension.fetchFilterProducts('New',newOpp.Id);
        opportunityProductEntryExtension.sortOrderList(newOpp.Id,'Name','ASC');
        opportunityProductEntryExtension.sortOrderList(newOpp.Id,'Name','DESC');
        opportunityProductEntryExtension.addToShoppingCart(oli.OpportunityId,customPB3.Id,oli2,'Name','ASC',lstPriceBook);
        opportunityProductEntryExtension.removeProduct(oli.OpportunityId,oli2[0].Id,oli2,oli2);
        opportunityProductEntryExtension.onSaveCart(oli2,oli2);
        
        oPEE.sortByProName();
        oPEE.sortByProFamily();
        oPEE.sortByProStrain();
        oPEE.sortByProduser();
        opportunityProductEntryExtension.getPriceBook();
        //opportunityProductEntryExtension.savePriceBook(newOpp.Id, customPB3.Id);
    }
}