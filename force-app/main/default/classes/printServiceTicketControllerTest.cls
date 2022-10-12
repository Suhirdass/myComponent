@isTest
public class printServiceTicketControllerTest {
    public static testmethod void runTest(){        
        Service_Ticket__c tic = new Service_Ticket__c();
        insert tic;
        
        Account acc = new Account();
        acc.Name = 'test acc';
        insert acc;
        
        Contact con = new Contact();
        con.firstName = 'test';
        con.LastName = 'Con';
        con.email = 'test@test.com';
        con.AccountId = acc.id;
        insert con;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Customer Community Plus User Custom'];
        
        Database.DMLOptions dmo = new Database.DMLOptions();
        dmo.EmailHeader.triggerUserEmail = false;
        
        User u = new User(alias = 'standt', email=con.email,emailencodingkey='UTF-8', lastname=con.lastname,
			firstname=con.firstname, languagelocalekey='en_US',localesidkey='en_US', profileid = p.Id, contactId=con.Id,
			timezonesidkey='America/Los_Angeles',username=con.email);
        u.setOptions(dmo);
        insert u;
        
        System.runAs(u) {
            
        	ApexPages.currentPage().getParameters().put('recordId',tic.id);
    		printServiceTicketController print = new printServiceTicketController();    
        }
    }
}