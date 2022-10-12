@isTest
public class AcceptRetailerOrderControllerTest {
	
    static testmethod void theTests(){
        Account a = new Account(Name = 'Irrational Raccoon, LLC');
        insert a;
        
        Site__c objSite = new Site__c();
        objSite.Name = '2089-3';
        insert objSite;
        
        
        Order__c ord= new Order__c();
        ord.Status__c='Draft';
        ord.Order_Date__c=Date.today();
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        insert ord;
        
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        //    objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Quantity_Type__c = 'Quantity';
        insert objProduct1;
        
        
        // Create price book entry for first product
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id=Test.getStandardPricebookId(), Product2Id=objProduct1.Id, UnitPrice=99, isActive=true);
        insert pbe;
        
        Order_Line_Item__c ol= new Order_Line_Item__c();
        ol.Price_Book_Entry_Id__c=Id.valueOf(pbe.id);
        ol.UnitPrice__c=10;
        ol.MOQ__c=4;
        ol.Quantity_Cases__c=2;
        ol.Order__c=ord.id;
        ol.Product__c = objProduct1.id;
        insert ol;
	    ApexPages.currentPage().getParameters().put('id',ord.id);
        AcceptRetailerOrderController arc = new AcceptRetailerOrderController();
        arc.acceptOrder();
        arc.acceptOrder();
    }
}