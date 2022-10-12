@IsTest
public class NotifyOnNewRDTTest {
    
	private static testmethod void notifyOnNewRDTTest(){
        OrderHelper.runningTrigger = true;
        List<Id> listOfOrderIds = new List<Id>();
        Account acc = new Account(Name = 'Irrational Raccoon, LLC');
        insert acc;
		        
        // Create Site
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.Warehouse_Name__c='TestWarehouse1';
        insert objSite;
        
        List<Contact> contacts = new List<Contact>();
        Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
        objContact.AccountId = acc.Id;
        objContact.EMail = 'test1@gmail.com';
        contacts.add(objContact);   
        
        Contact objContact2 = new Contact();
        objContact2.FirstName = 'Test';
        objContact2.LastName = 'Contact2';
        objContact2.AccountId = acc.Id;
        objContact2.EMail = 'test2@gmail.com';
        contacts.add(objContact2);  
        
        Contact objContact3 = new Contact();
        objContact3.FirstName = 'Test';
        objContact3.LastName = 'Contact3';
        objContact3.AccountId = acc.Id;
        objContact3.EMail = 'test3@gmail.com';
        contacts.add(objContact3);
        
        insert contacts;
        
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = acc.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        objStateLicenses.Default_Warehouse__c = objSite.Id;
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_State__c = 'California';
        objStateLicenses.License_City__c = 'San Francisco';
        objStateLicenses.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses.License_Zip__c = '94124';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses.Total_Miles__c = 10;
        
        List<Profile> profiles = [SELECT Id, Name FROM Profile WHERE Name = 'Customer Community Plus User Custom'];
        User u = new User();
        u.ProfileId = profiles[0].Id;
        u.firstName = 'testcontact1';
        u.lastName = 'customeruser';
        u.Username = 'Testcontactat1@filigreencustomer.com.testaccount1';
        u.Email = 'Testcontactat1@filigreencustomer.com';
        u.ContactId = contacts[1].Id;
        u.Title = 'Customer';
        u.CommunityNickname = 'ruser';
        u.Alias = 'testser';
        u.TimeZoneSidKey = 'America/Los_Angeles'; // Required
        u.LocaleSidKey = 'en_US'; // Required
        u.EmailEncodingKey = 'ISO-8859-1'; // Required
        u.LanguageLocaleKey = 'en_US'; // Required
        insert u;
        
        Order__c ord= new Order__c();
        ord.Status__c='Approved';
        ord.Order_Date__c=Date.today();
        ord.Retailer_Contact__c = contacts[0].Id;
        ord.State_License__c = objStateLicenses.Id;
        ord.Customer__c = u.Id;
        insert ord; 
        listOfOrderIds.add(ord.Id);
        
        Document documentObj;
        
        documentObj = new Document();
        documentObj.Body = Blob.valueOf('Some Document Text For Test Class');
        documentObj.ContentType = 'application/pdf';
        documentObj.DeveloperName = 'TestX8300'; 
        documentObj.IsPublic = true;
        documentObj.Name = 'Test 8300';
        documentObj.FolderId = [select id from folder where name = 'Shared Documents'].id;
        insert documentObj;
        
        
        Id recTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Brand').getRecordTypeId();
        Order__c ord1= new Order__c();
        ord1.Status__c='Draft';
        ord1.Order_Date__c=Date.today();
        ord1.Retailer_Contact__c = contacts[0].Id;
        ord1.State_License__c = objStateLicenses.Id;
        ord1.Customer__c = u.Id;
        ord1.RecordTypeId = recTypeId;
        insert ord1;
        listOfOrderIds.add(ord1.Id);
        
        Retailer_Related_Contact__c rrc = new Retailer_Related_Contact__c();
        rrc.Order__c = ord.Id;
        rrc.Contact__c = contacts[2].Id;
        insert rrc;
            
        NotifyOnNewRDT.notifyOnNewRTD(listOfOrderIds);
        NotifyAfter48HoursRDT.notifyOnNewRDTAfter48Hours(listOfOrderIds);
        NotifyAfter24HoursRDT.notifyOnNewRDTAfter24Hours(listOfOrderIds);
    }
}