@isTest
public class CancelPWOControllerTest {
    private static testmethod void runTest(){
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        //distributor Account
        Account objAccount2 = new Account();
        objAccount2.Name = 'Test Account2';
        objAccount2.Payment_Terms__c = 'COD';
        insert objAccount2;
        //receiver Account
        Account objAccount3 = new Account();
        objAccount3.Name = 'Test Account3';
        objAccount3.Payment_Terms__c = 'COD';
        insert objAccount3;

        //Create State License

        //Supplier License
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c = 'Active';
        objStateLicenses.License_Type__c = 'Type 1';
        objStateLicenses.License_Class__c = 'A-License';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now());
        insert objStateLicenses;
        //distributor License
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount2.id;
        objStateLicenses2.License_Number__c = 'AbcTest45678';
        objStateLicenses2.License_Status__c = 'Active';
        objStateLicenses2.License_Type__c = 'Type 1';
        objStateLicenses2.License_Class__c = 'A-License';
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now());
        insert objStateLicenses2;
        //receiver License
        State_Licenses__c objStateLicenses3 = new State_Licenses__c();
        objStateLicenses3.License_Name__c = objAccount3.id;
        objStateLicenses3.License_Number__c = 'AbcTest54321';
        objStateLicenses3.License_Status__c = 'Active';
        objStateLicenses3.License_Type__c = 'Type 1';
        objStateLicenses3.License_Class__c = 'A-License';
        objStateLicenses3.License_Expiration_Date__c = date.valueof(system.now());

        insert objStateLicenses3;

        //Create Site.
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        //objSite.License_ID__c= objStateLicenses.id;
        insert objSite;



        Inventory_Location__c newInventoryLocation = new Inventory_Location__c();
        newInventoryLocation.Name = 'Test InventoryLocation';
        newInventoryLocation.Site_Name__c = objSite.id;
        newInventoryLocation.Default_for_Site__c = true;

        insert newInventoryLocation;

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

        System.debug('opp.id' + opp.id);

        //Create Product

        //Create Product1
        Product2 objProduct1 = new Product2();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c = 'Yes';
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.IsActive = true;
        insert objProduct1;
        //Create Product2
        Product2 objProduct2 = new Product2();
        objProduct2.Name = 'product 2';
        objProduct2.Family = 'Edibles';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
        objProduct2.Apply_Cultivation_Tax__c = 'Yes';
        objProduct2.Apply_Excise_Tax__c = 'Yes';
        objProduct2.IsActive = true;
        insert objProduct2;
        Id pricebookId = Test.getStandardPricebookId();
		PricebookEntry pbe = new PricebookEntry(
          Pricebook2Id = pricebookId, Product2Id = objProduct1.Id,
          UnitPrice = 10000, IsActive = true);
        PricebookEntry pbe2 = new PricebookEntry(
          Pricebook2Id = pricebookId, Product2Id = objProduct2.Id,
          UnitPrice = 10000, IsActive = true);
        insert new List<PricebookEntry>{pbe,pbe2};
        //PricebookEntry pbe = [SELECT Id FROM PricebookEntry where isActive = true LIMIT 1];

        //Create New Opportunity
        OpportunityLineItem opLineItem = new OpportunityLineItem();
        opLineItem.Quantity = 1;
        opLineItem.OpportunityId = opp.id;
        opLineItem.TotalPrice = 100;
        opLineItem.PricebookEntryId = pbe.Id;
        insert opLineItem;

        

        RecordType bqTypeID = [select id, name, developername from recordtype where developername = 'Sell_Quote' limit 1];
        Brand_Quote__c bq = new Brand_Quote__c();
        bq.Opportunity_Name__c = opp.id;
        bq.Distributor_Name__c = objAccount2.id;
        bq.Distributor_License__c = objStateLicenses2.id;
        bq.Receiver_Name__c = opp.AccountId;
        bq.Receiver_License__c = objStateLicenses.id;
        bq.Supplier_Name__c = opp.Ownership__c;
        bq.Supplier_License__c = objStateLicenses.id;
        bq.BQ_Status__c = 'Draft';
        bq.Shipping_Method__c = 'Distributor Pick-up';
        bq.Sales_Origin__c = 'Brand';
        bq.Shipping_Terms__c = 'CFR';
        bq.Payment_Terms__c = 'COD';
        bq.Site__c = objSite.id;
        bq.RecordTypeId = bqTypeID.Id;
        bq.Ownership__c = opp.Ownership__c;
        insert bq;

        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c = objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;

        Brand_Quote_Line__c objbqline2 = new Brand_Quote_Line__c();
        objbqline2.Brand_Quote_Number__c = bq.id;
        objbqline2.Product_Name__c = objProduct2.id;
        objbqline2.MOQ__c = 20;
        objbqline2.Quantity_Cases__c = 50;

        Brand_Quote_Line__c objbqline3 = new Brand_Quote_Line__c();
        objbqline3.Brand_Quote_Number__c = bq.id;
        objbqline3.Product_Name__c = objProduct1.id;
        objbqline3.MOQ__c = 8;
        objbqline3.Quantity_Cases__c = 100;

        list<Brand_Quote_Line__c> lstBrandQuoteLine = new list<Brand_Quote_Line__c> ();
        lstBrandQuoteLine.add(objbqline1);
        lstBrandQuoteLine.add(objbqline2);
        lstBrandQuoteLine.add(objbqline3);

        insert lstBrandQuoteLine;
        Production_Work_Order__c pwo = new Production_Work_Order__c();
        pwo.Brand_Quote__c = bq.Id;
        pwo.Jar_Bag_Arrival_Date__c = System.today().addDays(5);
        pwo.Label_Arrival_Date__c= System.today().addDays(5);
        pwo.Packaging_Status__c = 'New';
        pwo.Pick_up_or_Arrival_Date__c = System.today().addDays(8);
        pwo.QA_Compliance_Sign_off_Date__c  = System.today().addDays(10);
        pwo.Status__c = 'Draft';
        pwo.Product__c = objProduct2.Id;
        
        insert pwo;
        Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController(pwo);
        CancelPWOController cc = new CancelPWOController(sc);
        cc.cancelPWO();
        CancelPWOController.getPWO(pwo.Id);
        CancelPWOController.updatePWO(pwo.Id);
        cc.redirectToPWO();
        cc.cancelPWO();
    }
}