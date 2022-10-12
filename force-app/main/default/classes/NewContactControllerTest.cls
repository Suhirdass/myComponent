@isTest
public class NewContactControllerTest {
    private static testmethod void testNewContact(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact con = new Contact(FirstName='Test',LastName = 'Contact',Email='testcontact@email.com',AccountId = acc.Id);
        insert con;
        
        Line_Card__c l= new Line_Card__c();
        l.Brand_Name__c=acc.id;
        l.Retailer_Name__c=acc.id;
        l.Mutual_Payment_Terms__c='COD';
        insert l;
        
        Customer_Insights__c cust = new Customer_Insights__c();
        cust.Line_Card__c = l.Id;
        
        contact con1  = new contact();
        con1.firstname = 'contact';
        con1.lastname = 'test';
        
        Test.startTest();
        //AuraResponse r =  NewContactController.checkExistingContacts(con.AccountId,con.Email);
        //System.assertEquals(true, (Boolean) r.data.get('alreadyExists'));
        //r =  NewContactController.checkExistingContacts(con.AccountId,'customer1@filigreen.com');
        NewContactController.getInsightTypes(acc.Id,l.Id);
        NewContactController.saveInsight(l.Id,JSON.serialize(cust));
        
        Id contactRecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Contact').getRecordTypeId();
        
        NewContactController.initNewContact(acc.Id,contactRecordTypeId);
        NewContactController.saveContact('',JSON.serialize(con));
        NewContactController.saveContact('',JSON.serialize(con1));
        
        //System.assertEquals(false,(Boolean) r.data.get('alreadyExists'));
    }
}