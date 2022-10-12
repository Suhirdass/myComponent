@isTest(OnInstall=false SeeAllData=false)
public class opportunityHelperTest {
    
    static testMethod void testopportunity(){
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        
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
        
        List<Opportunity> opplst = new List<Opportunity>();     
        insert a;
        
        o.AccountId = a.Id;
        o.Name = 'Test_Joe_123';
        o.StageName = 'Prospecting';
        o.CloseDate = date.today();
        o.Type = 'New Business';
        o.Pricebook2Id=pricebookId ;
        o.Payment_Terms__c = 'COD';
        insert o;
        opplst.add(o);
        
        
        
        
        opportunityHelper.checkBrandquoteExists(opplst);
        String Status;
        Status = opportunityHelper.OPP_STAGENAME_CLOSED_LOST;
        Status = opportunityHelper.BRANDQUOTE_STATUS_CANCELLED;
        Status = opportunityHelper.BRANDQUOTE_GENERATED_ERROR_MESSAGE;
       
    }
    
}