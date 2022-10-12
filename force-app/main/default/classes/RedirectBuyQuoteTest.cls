@isTest(SeeAllData = true)
public class RedirectBuyQuoteTest {
    private static testmethod void runTest(){
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        insert objSite;
        
        RecordType bqType = [select id, name, developername from recordtype where developername = 'Buy_Sell_Opportunity' limit 1];
        Opportunity opp = new Opportunity();
        opp.AccountId = objAccount.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName = 'Qualification';
        opp.RecordTypeId = bqType.Id;
        opp.Site_Name__c = objSite.Id;
        opp.Ownership__c = objAccount.id;
        opp.Payment_Terms__c='COD';
        insert opp;
        
        Product2 objProduct1 = new Product2();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c = 'Yes';
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.IsActive = true;
        insert objProduct1;
        //Create Product2
        Product2 objProduct2 = new Product2();
        objProduct2.Name = 'product 2';
        objProduct2.Family = 'Accessories';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
        objProduct2.Apply_Cultivation_Tax__c = 'Yes';
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.IsActive = true;
        insert objProduct2;

        PricebookEntry pbe = [SELECT Id FROM PricebookEntry where isActive = true LIMIT 1];

        //Create New Opportunity
        OpportunityLineItem opLineItem = new OpportunityLineItem();
        opLineItem.Quantity = 1;
        opLineItem.OpportunityId = opp.id;
        opLineItem.TotalPrice = 100;
        opLineItem.PricebookEntryId = pbe.id;
        insert opLineItem;
        
        OpportunityLineItem opLineItem2 = new OpportunityLineItem();
        opLineItem2.Quantity = 1;
        opLineItem2.OpportunityId = opp.id;
        opLineItem2.TotalPrice = 100;
        opLineItem2.Is_Sample__c = true;
        opLineItem2.PricebookEntryId = pbe.id;
        insert opLineItem2;
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
        RedirectBuyQuoteCtlr controllerObj = new RedirectBuyQuoteCtlr(stdController);
        controllerObj.redirectToSplitQuote();
    }
}