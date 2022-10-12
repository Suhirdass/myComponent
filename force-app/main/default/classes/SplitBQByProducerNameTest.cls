@isTest
public class SplitBQByProducerNameTest {
    @isTest
    private static void runTest(){
        
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        //ord.State_License__c = objStateLicenses.Id;
        //ord.Sales_Person__c = objContact.Id;
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        
        Shipping_Manifest__c SM = new Shipping_Manifest__c();
        SM.Order_Number__c = ord.Id;
        insert SM;
        
        Opportunity Opp = new Opportunity();
        Opp.Name = 'Test Opp';
        Opp.CloseDate = System.today();
        Opp.StageName = 'Qualification';
        insert Opp;
        
        Account Acc = new Account();
        Acc.Name = 'Test Acc';
        insert Acc;
        
        String productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Product').getRecordTypeId();
            
        Product2 Prd =  new Product2();
        Prd.Name = 'product 1';
        Prd.Quantity_Type__c = 'Quantity';
        Prd.Family = 'Accessories';
        Prd.Description = 'test product 1';
        Prd.Producer_Name__c = Acc.id;
        Prd.Apply_Cultivation_Tax__c='Yes';
        Prd.Apply_Excise_Tax__c='Yes';
        Prd.IsActive = true;
        Prd.Unit_Height__c  = 10.0;
        Prd.Unit_Length__c = 10.0;
        Prd.Unit_Width__c = 5.0;
        Prd.Apply_Excise_Tax__c = 'Yes';
        Prd.RecordTypeId = productRecordTypeId;
        Prd.Track_Trace_Category__c='Capsule';
        Prd.Net_Weight_UOM__c='EA';
        Prd.Unit_Of_Measure__c='Grams';
        Prd.MOQ__c = 1;
        insert Prd;
        
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id=Test.getStandardPricebookId(), Product2Id=Prd.Id, UnitPrice=99, isActive=true);
        insert pbe;
        
        OpportunityLineItem opLineItem=new OpportunityLineItem();
        opLineItem.Quantity=1;
        opLineItem.OpportunityId =opp.id;
        opLineItem.TotalPrice =100;
        opLineItem.PricebookEntryId = pbe.id;
        opLineItem.Product2Id = Prd.Id;
        opLineItem.Is_Sample__c = true;
        insert opLineItem;
        
        Service_Ticket__c ST = new Service_Ticket__c();
        ST.Opportunity__c = opp.id;
        insert ST;
        
        SplitBQByProducerNameCtlr controllerObj1 = new SplitBQByProducerNameCtlr();  
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(opp);
        SplitBQByProducerNameCtlr controllerObj = new SplitBQByProducerNameCtlr(stdController);  
        SplitBQByProducerNameCtlr.splitBQByProducerName(opp.Id,'');
        SplitBQByProducerNameCtlr.createQuoteRec(opp,controllerObj.lineItems,true,'');
        SplitBQByProducerNameCtlr.createQuoteRec(opp,controllerObj.lineItems,false,'');
        
		String serviceRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Service Opportunity').getRecordTypeId();
        opp.RecordTypeId = serviceRecordTypeId;
        update opp;
        opp = [Select Id,RecordType.DeveloperName,Order__c,Order__r.Request_Ship_Date__c, Order__r.State_License__c from Opportunity where Id =: opp.id];
        SplitBQByProducerNameCtlr.createQuoteRec(opp,controllerObj.lineItems,true,'');
        
        String transferRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Transfer').getRecordTypeId();
        opp.RecordTypeId = transferRecordTypeId;
        update opp;
        opp = [Select Id,RecordType.DeveloperName,Order__c,Order__r.Request_Ship_Date__c, Order__r.State_License__c from Opportunity where Id =: opp.id];
        SplitBQByProducerNameCtlr.createQuoteRec(opp,controllerObj.lineItems,true,'');
        
        test.startTest();
        String labRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Lab Opportunity').getRecordTypeId();
        opp.RecordTypeId = labRecordTypeId;
        update opp;
        
        ST.Transfer_Method__c = 'Drop-off';
        update ST;
        
        opp = [Select Id,RecordType.DeveloperName,Order__c,Order__r.Request_Ship_Date__c, Order__r.State_License__c from Opportunity where Id =: opp.id];
        SplitBQByProducerNameCtlr.createQuoteRec(opp,controllerObj.lineItems,true,'');
        
        String buySellOppRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Buy Sell Opportunity').getRecordTypeId();
        opp.RecordTypeId = buySellOppRecordTypeId;
        update opp;
        opp = [Select Id,RecordType.DeveloperName,Order__c,Order__r.Request_Ship_Date__c, Order__r.State_License__c from Opportunity where Id =: opp.id];
        SplitBQByProducerNameCtlr.createQuoteRec(opp,controllerObj.lineItems,true,'');
        
        String buyOppRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Buy Opportunity').getRecordTypeId();
        opp.RecordTypeId = buyOppRecordTypeId;
        Opp.Order__c = ord.Id;
        update opp;
        opp = [Select Id, Name, Account.DBA__c, Account.Id, Opportunity_Number__c, Order__r.Order_Date__c, Payment_Terms__c, 
                    RecordType.DeveloperName, Order__r.Name, Order__c, Order__r.State_License__c,Order__r.Retailer_DBA__c,
                    Order__r.Retailer_Contact__c,Order__r.Retailer_Contact__r.AccountId,Order__r.Retailer_Contact__r.Name,
                    Order__r.Special_Instructions__c,Order__r.State_License__r.License_Number__c,Order__r.State_License__r.License_Name__c,
                    Order__r.Retailer__c,Order__r.Account__r.Type,Order__r.Order_Type__c,Site_Name__r.Name,Site_Name__r.Warehouse_Name__c, Site_Name__c from Opportunity where Id =: opp.id];
        SplitBQByProducerNameCtlr.createQuoteRec(opp,controllerObj.lineItems,true,'');
        
        String rmaRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('RMA').getRecordTypeId();
        String PricebookInActive = SplitBQByProducerNameCtlr.PricebookInActive;
        String OPPORTUNITY_BUYSELL_RECORDTYPE = SplitBQByProducerNameCtlr.OPPORTUNITY_BUYSELL_RECORDTYPE;
        String BRANDQUOTELINERECORDTYPE_BUYQOUTELINE = SplitBQByProducerNameCtlr.BRANDQUOTELINERECORDTYPE_BUYQOUTELINE;
        String BRANDQUOTELINERECORDTYPE_LABLINE = SplitBQByProducerNameCtlr.BRANDQUOTELINERECORDTYPE_LABLINE;
        String BRANDQUOTESHIPPINGMETHOD_DISTIBUTORPICKUP = SplitBQByProducerNameCtlr.BRANDQUOTESHIPPINGMETHOD_DISTIBUTORPICKUP;
        String BRANDQUOTESHIPPINGMETHOD_SUPPLIERPICKUP = SplitBQByProducerNameCtlr.BRANDQUOTESHIPPINGMETHOD_SUPPLIERPICKUP;
        String TYPE_BUYQUOTE = SplitBQByProducerNameCtlr.TYPE_BUYQUOTE;
        String TYPE_SELLQUOTE = SplitBQByProducerNameCtlr.TYPE_SELLQUOTE;
        String ErrMsgCreate_Quote_OrderRetailerContact = SplitBQByProducerNameCtlr.ErrMsgCreate_Quote_OrderRetailerContact;
        String ErrMsgCreate_Quote_OrderStateLicense = SplitBQByProducerNameCtlr.ErrMsgCreate_Quote_OrderStateLicense;
        String ErrMsgCreate_Quote_STStateLicense = SplitBQByProducerNameCtlr.ErrMsgCreate_Quote_STStateLicense;
        String ErrMsgCreate_Quote_STBrandContact = SplitBQByProducerNameCtlr.ErrMsgCreate_Quote_STBrandContact;
        String BRANDQUOTELINERECORDTYPE_RMALINE = SplitBQByProducerNameCtlr.BRANDQUOTELINERECORDTYPE_RMALINE;
        opp.RecordTypeId = rmaRecordTypeId;
        update opp;
        opp = [Select Id, Name, Account.DBA__c, Account.Id, Opportunity_Number__c, Order__r.Order_Date__c, Payment_Terms__c, 
                    RecordType.DeveloperName, Order__r.Name, Order__c, Order__r.State_License__c,Order__r.Retailer_DBA__c,
                    Order__r.Retailer_Contact__c,Order__r.Retailer_Contact__r.AccountId,Order__r.Retailer_Contact__r.Name,
                    Order__r.Special_Instructions__c,Order__r.State_License__r.License_Number__c,Order__r.State_License__r.License_Name__c,
                    Order__r.Retailer__c,Order__r.Account__r.Type,Order__r.Order_Type__c,Site_Name__r.Name,Site_Name__r.Warehouse_Name__c, Site_Name__c from Opportunity where Id =: opp.id];

        
        SplitBQByProducerNameCtlr.createQuoteRec(opp,controllerObj.lineItems,true,'');
        //SplitBQByProducerNameCtlr.getTotalMiles(opp.Order__r.State_License__c, opp.Site_Name__r.Name);
        SplitBQByProducerNameCtlr.oppLineWrapper oppwrap = new SplitBQByProducerNameCtlr.oppLineWrapper(opLineItem);
        test.stopTest();
        
    }
}