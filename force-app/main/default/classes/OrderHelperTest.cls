@isTest
public class OrderHelperTest {
	
    static testMethod void  testOrderAccept1 (){
        Test.setMock(HttpCalloutMock.class, new Miles_Mock());  
        TestUtilData.skipTrigger = true;
        
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        TestUtilData.createTestData();
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
        
		Contact objContact2 = new Contact();
        objContact2.FirstName = 'Test2';
        objContact2.LastName = 'Contact2';
        objContact2.AccountId = a.Id;
        objContact2.Email ='test@test.com';
        insert objContact2;
        
        Order__c ord= new Order__c();
        ord.Status__c='Draft';
        ord.Order_Date__c=Date.today();
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        ord.State_License__c = objStateLicenses.id;
        ord.Retailer_Contact__c =objContact2.Id;
        ord.Request_Ship_Date__c =Date.today();
        ord.Requested_Delivery_Earliest_Time__c = Time.newInstance(1, 12, 13, 12);
        ord.Requested_Delivery_Latest_Time__c = Time.newInstance(1, 12, 13, 12);
        insert ord;
        
        Order__c ord2= new Order__c();
        ord2.Status__c='Pending';
        ord2.Order_Date__c=Date.today();
        ord2.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Retailer').getRecordTypeId();
        ord2.State_License__c = objStateLicenses.id;
        insert ord2;
        
        Product2  objProduct1 = [Select Id,Name from Product2 LIMIT 1];
        
        PricebookEntry pbe = [SELECT Id,Name,Product2Id from PricebookEntry WHERE Product2Id =: objProduct1.Id];
        
        Order_Line_Item__c ol= new Order_Line_Item__c();
        ol.Price_Book_Entry_Id__c=Id.valueOf(pbe.id);
        ol.UnitPrice__c=10;
        ol.MOQ__c=4;
        ol.Quantity_Cases__c=2;
        ol.Order__c=ord.id;
        ol.Product__c = objProduct1.id;
        insert ol;
        test.startTest();
        	//ord.Status__c = 'Approved';
        //update ord;
        
        OrderHelper.getMonthNumber('January');
        OrderHelper.getMonthNumber('February');
        OrderHelper.getMonthNumber('March');
        OrderHelper.getMonthNumber('April');
        OrderHelper.getMonthNumber('May');
        OrderHelper.getMonthNumber('June');
        OrderHelper.getMonthNumber('July');
        OrderHelper.getMonthNumber('August');
        OrderHelper.getMonthNumber('September');
        OrderHelper.getMonthNumber('October');
        OrderHelper.getMonthNumber('November');
        OrderHelper.getMonthNumber('December');
        test.stopTest(); 
        
    }
    static testMethod void  testOrderApprove (){
        Test.setMock(HttpCalloutMock.class, new Miles_Mock());  
        TestUtilData.skipTrigger = true;
        
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        TestUtilData.createTestData();
        
        /*Map<String,Account> objAccount =new Map<String,Account>();
        for(Account acc :[SELECT Name,Id,Hold__c,Payment_Terms__c,RecordTypeId,Membership_Level__c,Hide_from_Marketplace__c,DBA__c FROM Account]){
            objAccount.put(acc.name,acc);
        }*/
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hold__c=False;
        objAccount.Type ='Producer';
        objAccount.Platform_Level__c ='Basic';
        objAccount.DBA__c='Test Account1';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Membership_Level__c = 'Boutique';
        objAccount.Auto_Order_Flow__c = true;
        objAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
        insert objAccount;
        
        Account a = new Account(Name = 'Seashore Enterprise Southern, LLC');
        a.Payment_Terms__c = 'COD';
        a.Hold__c=false;
        a.DBA__c='365 Recreational Cannabis';
        a.Hide_from_Marketplace__c = false;
        a.Membership_Level__c = 'Retail';
        a.Auto_Order_Flow__c = true;
        a.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Retail').getRecordTypeId();
        insert a;
        
        
        
        /*Map<String,State_Licenses__c> StateLicensesMap =new Map<String,State_Licenses__c>();
        for(State_Licenses__c sl :[SELECT License_Number__c,Total_Miles__c,License_Expiration_Date__c,License_Zip__c,License_Address__c,License_City__c,License_State__c,License_Class__c,Default_Warehouse__c,License_Type__c,License_Status__c,Id,License_Name__c FROM State_Licenses__c]){
            StateLicensesMap.put(sl.License_Number__c,sl);
        }*/
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = a.id;
        objStateLicenses.License_Number__c = 'AbcTest123';
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        //objStateLicenses.Default_Warehouse__c = objSite.Id;
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_State__c = 'California';
        objStateLicenses.License_City__c = 'San Francisco';
        objStateLicenses.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses.License_Zip__c = '94124';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses.Total_Miles__c = 10;
        insert objStateLicenses;
        
        
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount.Id;
        objStateLicenses2.License_Number__c = 'AbcTest12345';
        objStateLicenses2.License_Status__c ='Active';
        objStateLicenses2.License_Type__c ='Type 1';
        //objStateLicenses2.Default_Warehouse__c = objSite.Id;
        objStateLicenses2.License_Class__c='A-License';
        objStateLicenses2.License_State__c = 'California';
        objStateLicenses2.License_City__c = 'San Francisco';
        objStateLicenses2.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses2.License_Zip__c = '94124';
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses2.Total_Miles__c = 10;
        insert objStateLicenses2;
        
        Site__c objSite = new Site__c();
        objSite.Name = '2089-3';
        objSite.License_ID__c =objStateLicenses2.id;
        insert objSite;
        
        Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
        objContact.AccountId = a.Id;
        insert objContact;
        
        Contact objContact2 = new Contact();
        objContact2.FirstName = 'Test2';
        objContact2.LastName = 'Contact2';
        objContact2.AccountId = objAccount.Id;
        insert objContact2;
        system.debug('##Account Supp :'+a.id +'--'+objAccount.Id);
        Order__c ord= new Order__c();
        ord.Status__c='Pending';
        ord.Order_Type__c ='Brand';
        ord.Order_Date__c=Date.today();
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Brand').getRecordTypeId();
        ord.State_License__c = objStateLicenses.id;
        ord.Retailer__c =a.id;
        ord.Site__c =objSite.Id;
        ord.Retailer_Contact__c =objContact.id;
        ord.Account__c =objAccount.Id;
        ord.Payment_Terms__c ='COD';
        insert ord;
        
        Product2  objProduct1 = [Select Id,Name from Product2 LIMIT 1];
        
        PricebookEntry pbe = [SELECT Id,Name,Product2Id from PricebookEntry WHERE Product2Id =: objProduct1.Id];
        
        Order_Line_Item__c ol= new Order_Line_Item__c();
        ol.Price_Book_Entry_Id__c=Id.valueOf(pbe.id);
        ol.UnitPrice__c=10;
        ol.MOQ__c=4;
        ol.Quantity_Cases__c=2;
        ol.Order__c=ord.id;
        ol.Product__c = objProduct1.id;
        insert ol;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = a.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'Buy Sell Opportunity';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName ='Proposal/Price Quote';
        opp.Site_Name__c = objSite.Id;
        opp.Ownership__c = a.id;
        opp.Payment_Terms__c = 'COD';
        opp.Order__c = ord.Id;
        insert opp;
        
       /* Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
        objContact.AccountId = a.Id;
        insert objContact;
        List<Contact> conList = [SELECT Id ,FirstName,LastName,AccountId FROM Contact];
        Brand_Quote__c bq = new Brand_Quote__c ();
        bq.Opportunity_Name__c = opp.id; 
        bq.Distributor_License__c = StateLicensesMap.get('AbcTest45678').id;
        bq.Receiver_License__c = StateLicensesMap.get('AbcTest54321').id;
        bq.Distributor_Name__c = objAccount.get('Test Account2').id;
        bq.Supplier_Name__c = objAccount.get('Test Account1').id;
        bq.Receiver_Name__c = objAccount.get('Test Account3').id;
        //bq.Supplier_License__c = StateLicensesMap.get('AbcTest12345').id;
        bq.BQ_Status__c = 'Draft';
        bq.Shipping_Method__c = 'Distributor Pick-up';
        bq.Sales_Origin__c = 'Brand';
        bq.Shipping_Terms__c = 'CFR';        
        bq.Site__c = objSite.id;
        bq.Ownership__c = opp.Ownership__c;
        bq.Payment_Terms__c = opp.Payment_Terms__c;
        bq.Apply_Excise_Tax__c = true;
        bq.Order_Type__c = 'Brand';
        bq.Sales_person__c = objContact.Name;
        insert bq;*/
        test.startTest();
        //OrderHelper.onAfterInsert(new List<Order__c>{ord});
        ord.Status__c = 'Approved';
        update ord;
        String Status;
        Status = OrderHelper.PRODUCT_RECORD_TYPE_NAME_DISCOUNT;
        Status = OrderHelper.ERROR_OPP_ALREADY_EXISTS;
        Status = OrderHelper.SOLI_STATUS_ALLOCATED;
        Status = OrderHelper.SOLI_STATUS_BACKORDERED;
        Status = OrderHelper.SOLI_STATUS_PARTIALLY_ALLOCATED;
        Status = OrderHelper.STATE_LICENSE_ACTIVE;
        Status = OrderHelper.STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE;
        Status = OrderHelper.STATE_LICENSE_NONCANNABIS_RECORDTYPE;
        Status = OrderHelper.ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER;
        Status = OrderHelper.SO_STATUS_DRAFT;
        Status = OrderHelper.Org_Base_URL;
        Status = OrderHelper.ORDER_TYPE_TRANSFER;
        Status = OrderHelper.HOLIDAY_RECURSMONTHLY;
        Status = OrderHelper.HOLIDAY_RECURSMONTHLYNTH;
        Status = OrderHelper.HOLIDAY_RECURSWEEKLY;
        Status = OrderHelper.HOLIDAY_RECURSEVERYWEEKDAY;
        Status = OrderHelper.HOLIDAY_RECURSDAILY;
        Status = OrderHelper.HOLIDAY_RECURRENCE_FIRST;
        Status = OrderHelper.HOLIDAY_RECURRENCE_LAST;

        
    }
    static testMethod void  testOrder3 (){
        Test.setMock(HttpCalloutMock.class, new Miles_Mock());  
        TestUtilData.skipTrigger = true;
        
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
        TestUtilData.createTestData();
      
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hold__c=False;
        objAccount.Type ='Producer';
        objAccount.Platform_Level__c ='Basic';
        objAccount.DBA__c='Test Account1';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Membership_Level__c = 'Boutique';
        objAccount.Service_Type__c = 'Margin';
        objAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
        insert objAccount;
        
        Account a = new Account(Name = 'Irrational Raccoon, LLC');
        a.Payment_Terms__c = 'COD';
        a.Hold__c=false;
        a.DBA__c='WOVN SF';
        a.Hide_from_Marketplace__c = false;
        a.Membership_Level__c = 'Standard';
        a.Auto_Order_Flow__c = true;
        a.Type = 'Distributor';
        a.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
        insert a;
        
        
        
        
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = a.id;
        objStateLicenses.License_Number__c = 'AbcTest123';
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        //objStateLicenses.Default_Warehouse__c = objSite.Id;
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_State__c = 'California';
        objStateLicenses.License_City__c = 'San Francisco';
        objStateLicenses.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses.License_Zip__c = '94124';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses.Total_Miles__c = 10;
        insert objStateLicenses;
        
        
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount.Id;
        objStateLicenses2.License_Number__c = 'AbcTest12345';
        objStateLicenses2.License_Status__c ='Active';
        objStateLicenses2.License_Type__c ='Type 1';
        //objStateLicenses2.Default_Warehouse__c = objSite.Id;
        objStateLicenses2.License_Class__c='A-License';
        objStateLicenses2.License_State__c = 'California';
        objStateLicenses2.License_City__c = 'San Francisco';
        objStateLicenses2.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses2.License_Zip__c = '94124';
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses2.Total_Miles__c = 10;
        insert objStateLicenses2;
        
        Site__c objSite = new Site__c();
        objSite.Name = '2089-3';
        objSite.License_ID__c =objStateLicenses2.id;
        insert objSite;
        
        Contact objContact = new Contact();
        objContact.FirstName = 'Test';
        objContact.LastName = 'Contact1';
        objContact.AccountId = a.Id;
        insert objContact;
        
        Contact objContact2 = new Contact();
        objContact2.FirstName = 'Test2';
        objContact2.LastName = 'Contact2';
        objContact2.AccountId = objAccount.Id;
        insert objContact2;
        
        Order__c ord= new Order__c();
        ord.Status__c='Pending';
        ord.Order_Type__c ='Transfer';
        ord.Order_Date__c=Date.today();
        ord.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Transfer').getRecordTypeId();
        ord.State_License__c = objStateLicenses.id;
        ord.Retailer__c =a.id;
        ord.Site__c =objSite.Id;
        ord.Retailer_Contact__c =objContact.id;
        ord.Account__c =objAccount.Id;
        ord.Payment_Terms__c ='COD';
        ord.Sample_Order__c = true;
        ord.Delivered_Date__c = system.today();
        insert ord;
        
        Product2  objProduct1 = [Select Id,Name from Product2 LIMIT 1];
        
        PricebookEntry pbe = [SELECT Id,Name,Product2Id from PricebookEntry WHERE Product2Id =: objProduct1.Id];
        
        Order_Line_Item__c ol= new Order_Line_Item__c();
        ol.Price_Book_Entry_Id__c=Id.valueOf(pbe.id);
        ol.UnitPrice__c=10;
        ol.MOQ__c=4;
        ol.Quantity_Cases__c=2;
        ol.Order__c=ord.id;
        ol.Product__c = objProduct1.id;
        insert ol;
       
        test.startTest();
        ord.Status__c = 'Shipped';
        update ord;
        
    }
}