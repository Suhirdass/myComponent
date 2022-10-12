@isTest
public class QuickBaseWebhookTest {
    private static testmethod void runQuickBaseWebhookTest(){
        
        List<Account> accounts = new List<Account>();
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.dBA__c = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        accounts.add(objAccount);   
        
        // distributor Account
        Account objAccount2 = new Account();
        objAccount2.Name = 'Test Account2';
        objAccount2.dBA__c = 'Kushy Punch';
        objAccount2.Payment_Terms__c = 'COD';
        accounts.add(objAccount2);  
        
        // receiver Account
        Account objAccount3 = new Account();
        objAccount3.Name = 'Test Account3';
        objAccount3.Payment_Terms__c = 'COD';
        accounts.add(objAccount3);
        
        insert accounts;
        
        // Create Contacts
        // supplier contact
        List<Contact> contacts = new List<Contact>();
        Contact objContact = new Contact();
        objContact.LastName = 'Test Contact1';
        objContact.AccountId = objAccount.Id;
        contacts.add(objContact);   
        
        // distributor contact
        Contact objContact2 = new Contact();
        objContact2.LastName = 'Test Contact2';
        objContact2.AccountId = objAccount2.Id;
        contacts.add(objContact2);  
        
        // receiver contact
        Contact objContact3 = new Contact();
        objContact3.LastName = 'Test Contact3';
        objContact3.AccountId = objAccount3.Id;
        contacts.add(objContact3);
        
        insert contacts;
        // Supplier License
        List<State_Licenses__c> licenses = new List<State_Licenses__c>();
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        licenses.add(objStateLicenses);
        
        // distributor License
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount2.id;
        objStateLicenses2.License_Number__c = 'AbcTest45678';
        objStateLicenses2.License_Status__c ='Active';
        objStateLicenses2.License_Type__c ='Type 1';
        objStateLicenses2.License_Class__c='A-License';
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        licenses.add(objStateLicenses2); 
        
        // receiver License
        State_Licenses__c objStateLicenses3 = new State_Licenses__c();
        objStateLicenses3.License_Name__c = objAccount3.id;
        objStateLicenses3.License_Number__c = 'AbcTest54321';
        objStateLicenses3.License_Status__c ='Active';
        objStateLicenses3.License_Type__c ='Type 1';
        objStateLicenses3.License_Class__c='A-License';
        objStateLicenses3.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        
        licenses.add(objStateLicenses3);
        
        // receiver License
        State_Licenses__c objStateLicenses4 = new State_Licenses__c();
        objStateLicenses4.License_Name__c = objAccount3.id;
        objStateLicenses4.License_Number__c = 'AbcTest54321456';
        objStateLicenses4.License_Status__c ='Active';
        objStateLicenses4.License_Type__c ='Type 1';
        objStateLicenses4.License_Class__c='A-License';
        objStateLicenses4.License_Expiration_Date__c = date.valueof(system.now()) - 10;
        licenses.add(objStateLicenses4);
        
        insert licenses;
		Company_Custom_Settings__c ccs = new Company_Custom_Settings__c();
        ccs.Default_Distributor__c = objAccount.Id;
        ccs.Default_License__c = objStateLicenses.Id;
        ccs.Default_Contact__c = objContact.Id;
        
        insert ccs;
        
        // Create Site
        Site__c objSite = new Site__c();
        objSite.Name = '2089-3';
        insert objSite;

        // Create Product
        List<Product2> products = new List<Product2>();
        
        //Create Product1
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Family = 'Edibles';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        products.add(objProduct1);
        
        // Create Product2
        Product2  objProduct2 = new Product2 ();
        objProduct2.Name = 'product 2';
        objProduct2.Family = 'Edibles';
        objProduct2.Description = 'test product 2';
        objProduct2.Producer_Name__c = objAccount.id;
        objProduct2.Apply_Cultivation_Tax__c='Yes';
        objProduct2.Apply_Excise_Tax__c='Yes';
        objProduct2.IsActive = true;
        objProduct2.Unit_Height__c  = 20.0;
        objProduct2.Unit_Length__c = 10.0;
        objProduct2.Unit_Width__c = 5.0;
        products.add(objProduct2);
        
        // Create Product3
        Product2  objProduct3 = new Product2 ();
        objProduct3.Name = 'product 3';
        objProduct3.Family = 'Edibles';
        objProduct3.Description = 'test product 3';
        objProduct3.Producer_Name__c = objAccount.id;
        objProduct3.Apply_Cultivation_Tax__c='Yes';
        objProduct3.Apply_Excise_Tax__c='Yes';
        objProduct3.IsActive = true;
        objProduct3.Unit_Height__c  = 30.0;
        objProduct3.Unit_Length__c = 10.0;
        objProduct3.Unit_Width__c = 5.0;
        products.add(objProduct3);
        
        insert products;
        
        // Create price book entry for first product
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id=Test.getStandardPricebookId(), Product2Id=objProduct1.Id, UnitPrice=99, isActive=true);
        insert pbe;
        QuickBaseWebhook.Order odr = new QuickBaseWebhook.Order();
        odr.OrderNumber = '1234567';
        odr.OrderDate = '10-10-2018';
        odr.AccountName = 'Test Account1';
        odr.ContactName = 'Contact1, Test ';
        odr.OrderStatus = 'Draft';
        
        String myJSON = JSON.serialize(odr);
        RestRequest request = new RestRequest();
        //request.requestUri ='https://staging-customervisit.cs95.force.com/filigreenb2b/services/apexrest/createOrder/';

		request.requestUri ='https://customervisit.secure.force.com/fgapiSync/services/apexrest/createOrder/';
        request.httpMethod = 'POST';
        request.requestBody = Blob.valueof(myJSON);
		RestContext.request = request;
		Map<String, String> res = QuickBaseWebhook.createOrder();
        
        KPWebhookLineItem.Order od = new KPWebhookLineItem.Order();
        od.OrderNumber = '1234567';
        od.LineItemNumber = '123';
        od.Product = 'product 1';
        od.Quantity = 10;
        od.Price = '$20';
        od.SalePrice = '$20';
        
        myJSON = JSON.serialize(od);
        request = new RestRequest();
        //request.requestUri ='https://staging-customervisit.cs95.force.com/filigreenb2b/services/apexrest/createOrderLine/';
        
		request.requestUri ='https://customervisit.secure.force.com/fgapiSync/services/apexrest/createOrderLine/';
		request.httpMethod = 'POST';
        request.requestBody = Blob.valueof(myJSON);
		RestContext.request = request;
		res = KPWebhookLineItem.createOrderLineItem();
    }
}