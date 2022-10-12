@isTest
public class OrderControllerTest {
    static testMethod void  testOrderAccept (){
        Test.setMock(HttpCalloutMock.class, new Miles_Mock());     
        Order__c  ord = [Select Id from Order__c LIMIT 1];
        OrderController.approveOrder(ord.Id,'2020-05-28','01:00:00.000','17:00:00.000');
        OrderController.getOrderStatus(ord.Id);
        OrderController.acceptOrder(ord.Id);
        OrderController.getRecordName(ord.Id);
        ord.Status__c = 'Pending';
        update ord;
        OrderController.approveOrder(ord.Id,'2020-05-28','01:00:00.000','17:00:00.000');
        
        OrderController.acceptOrder(ord.Id);
        OrderController.getMonthNumber('January');
        OrderController.getMonthNumber('February');
        OrderController.getMonthNumber('March');
        OrderController.getMonthNumber('April');
        OrderController.getMonthNumber('May');
        OrderController.getMonthNumber('June');
        OrderController.getMonthNumber('July');
        OrderController.getMonthNumber('August');
        OrderController.getMonthNumber('September');
        OrderController.getMonthNumber('October');
        OrderController.getMonthNumber('November');
        OrderController.getMonthNumber('December');
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hold__c=true;
        objAccount.DBA__c='Test Account1';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Membership_Level__c = 'Boutique';
        objAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
        insert objAccount;       
        
        objAccount = [Select Id FROM Account LIMIT 1];
        
        Contact con = new Contact();
        con.lastname = 'test';
        con.firstname = 'con';
        con.AccountId = objAccount.id;
        insert con;
        
        List<Profile> profiles = [SELECT Id, Name FROM Profile WHERE Name = 'Customer Community Plus User Custom'];
        User u = new User();
        u.ProfileId = profiles[0].Id;
        u.firstName = 'testcontact1';
        u.lastName = 'customeruser';
        u.Username = 'Testcontactat1@filigreencustomer.com.testaccount1';
        u.Email = 'Testcontactat1@filigreencustomer.com';
        u.ContactId = con.Id;
        u.Title = 'Customer';
        u.CommunityNickname = 'ruser';
        u.Alias = 'testser';
        u.TimeZoneSidKey = 'America/Los_Angeles'; // Required
        u.LocaleSidKey = 'en_US'; // Required
        u.EmailEncodingKey = 'ISO-8859-1'; // Required
        u.LanguageLocaleKey = 'en_US'; // Required
        insert u;
        
        system.runAs(u){
            Test.startTest();
            list<Holiday> holidayList = [SELECT Id,RecurrenceType,RecurrenceInterval FROM Holiday];
            
            Holiday holidayObj = new Holiday();
            holidayObj.Name = 'Test Daily';
            holidayObj.ActivityDate = System.Today();
            holidayObj.IsRecurrence = true;
            holidayObj.RecurrenceInterval = 6;
            holidayObj.RecurrenceType = 'RecursDaily';
            holidayObj.RecurrenceStartDate = System.Today();
            insert holidayObj;
            
            OrderController.getOrderStatus(ord.Id);
            OrderController.getOrderDetails(ord.Id);
            Test.stopTest();    
        }
    }
    @TestSetUp
    static void testDataSetUp(){
        Test.setMock(HttpCalloutMock.class, new Miles_Mock());  
        TestUtilData.skipTrigger = true;
        
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        
        Account a = new Account(Name = 'Irrational Raccoon, LLC');
        insert a;
        
        Site__c objSite = new Site__c();
        objSite.Name = '2089-3';
        insert objSite;
        
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = a.id;
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
        insert objStateLicenses;
        
        Order__c ord= new Order__c();
        ord.Status__c='Draft';
        ord.Order_Date__c=Date.today();
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        ord.State_License__c = objStateLicenses.id;
        insert ord;
    }
    static testMethod void  testOrderAccept1 (){
        Test.setMock(HttpCalloutMock.class, new Miles_Mock());     
        Order__c  ord = [Select Id from Order__c LIMIT 1]; 
        
        Site__c objSite1 = new Site__c();
        objSite1.Name = '7027-CP';
        insert objSite1;  
        
        test.startTest();
        	OrderController.acceptAndUpdateSiteOrder(ord.Id, objSite1.Id);       
        test.stopTest();
        
    }
}