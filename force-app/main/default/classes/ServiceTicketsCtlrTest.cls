@isTest
public class ServiceTicketsCtlrTest {
    private static testmethod void runTest(){
        Google_Distance_Matrix_API__c g = new Google_Distance_Matrix_API__c();
        g.Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?';
        g.Name = 'Geocode_Endpoint';
        insert g;
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
        Site__c s = new Site__c(Name= '2089-3',Warehouse_Name__c='San Francisco',Sort_Order__c=1,Active__c=true);
        insert s;
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        Account acc =new Account();
        acc.Name='acName';
        acc.Type = 'Distributor';
        insert acc;
        Contact con =new Contact();
        con.FirstName='con';
        con.LastName='test';
        con.AccountId=acc.Id;
        con.Email = 'Testcontactat1@filigreencustomer.com';
        con.Primary_Contact__c = true;
        insert con;
        integer j=10;
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = acc.id;
        objStateLicenses.License_Number__c = 'AbcTest'+(j*10)+10;
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_City__c = 'Banning';
        objStateLicenses.License_State__c = 'Florida';
        objStateLicenses.License_Country__c = 'US';
        objStateLicenses.License_Zip__c = '12333';
        objStateLicenses.Default_Warehouse__c =s.id;
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        insert objStateLicenses;
        
        List<Product2> products = [SELECT Id,Most_Popular__c FROM Product2];
        products[0].Most_Popular__c = true;
        products[0].Available_Inventory__c = 200;
        update products[0];
        
        Service_Ticket__c st =new Service_Ticket__c();
        st.Status__c ='Pending';
        st.Brand_Contact__c=con.Id;
        st.Brand_Name__c=acc.Id;
        st.Licensed_Premise__c =objStateLicenses.id;
        st.Transfer_Method__c='Product Conversions';
        st.Status__c='Pending';
        insert st;
        
        Service_Ticket_Line__c stl =new Service_Ticket_Line__c();
        stl.New_Packaged_Product__c=products[0].id;
        stl.Service_Ticket__c =st.Id;
        stl.Status__c='Completed';
        stl.Total_Units__c =10;
        stl.New_Packaged_Product__c =products[0].id;
        insert stl;
        
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
        
        Id pricebookId = Test.getStandardPricebookId();
        
        // 1. Insert a price book entry for the standard price book.
        // Standard price book entries require the standard price book ID we got earlier.
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        Map<String,PriceBookEntry> pbeMap = new Map<String,PriceBookEntry>();
        for(PriceBookEntry pbe: [SELECT Id, PriceBook2Id, Product2Id FROM PriceBookEntry]){
            pbeMap.put(pbe.PriceBook2Id+'-'+pbe.Product2Id,pbe);
        }
        
         
        
        for(Product2 p: products){
            p.MOQ__c = 1;
            p.Available_Inventory__c = 100;
            p.Producer_Name__c = acc.Id;
            //p.Supplier_UOM__c='CT';
           // p.Case_Radius__c=122;
           // p.Case_Height__c=152;
            p.Product_Rating__c = 0;
            p.Unit_Gross_Weight__c =10;
            p.Retail_Unit_Form_Factor__c  ='Jar';
            p.Unit_Radius__c =3;
            p.Unit_Height__c =6;
            //p.Case_Dim_Weight__c=20;
            if(!pbeMap.containsKey(pricebookId+'-'+p.Id)){
                pbeList.add(new PricebookEntry(
                    Pricebook2Id = pricebookId, Product2Id = p.Id,
                    UnitPrice = 10000, IsActive = true));
            }
            if(!pbeMap.containsKey(customPB.Id+'-'+p.Id)){
                pbeList.add(new PricebookEntry(
                    Pricebook2Id = customPB.Id, Product2Id = p.Id,
                    UnitPrice = 12000, IsActive = true));
            }
        }
        insert pbeList;
        update products;
        
        Test.startTest();
        System.runAs(u){
            AuraResponse r = ServiceTicketsCtlr.init(st.id);
            ServiceTicketsCtlr.ServiceTicket ServiceTicket =  (ServiceTicketsCtlr.ServiceTicket) r.data.get('serviceTicket');
            List<ServiceTicketsCtlr.serviceTicketLine> serviceTicketLine = (list<ServiceTicketsCtlr.serviceTicketLine>) r.data.get('serviceTicketLines');
            //List<Map<String, String>> ServiceTicketList = (List<Map<String, String>>) r.data.get('ServiceTicket');
            List<ServiceTicketsCtlr.BrandProduct> bproducts = (List<ServiceTicketsCtlr.BrandProduct>) r.data.get('products');
            Datetime todayDateTime = Date.today();
            String reqDate = todayDateTime+'';
            System.debug('reqDate = '+serviceTicketLine);
            
            //serviceTicketLine[0].Product = bproducts[0].id; 
            //serviceTicketLine[0].
            //ServiceTicketsCtlr.saveSeriveTicket('',JSON.serialize(ServiceTicket),JSON.serialize(serviceTicketLine),dateStr,true);
            
            
            
            r=ServiceTicketsCtlr.getServiceTicket(st.id);
            ServiceTicketsCtlr.insertBatchId('01214',acc.Id);
            //ServiceTicketsCtlr.insertUId('01256');
            Map<String, Object> filters = new Map<String, Object>();
            filters.put('orderByField','Name');
            filters.put('isASC','false');
            filters.put('searchTerm','S');
            filters.put('family','false');
            r=ServiceTicketsCtlr.getIds(filters,'true');
            Set<Id> ids = (Set<Id>)r.data.get('ids');
            List<String> idsList = new List<String>();
            for(Id idStr : ids){
                idsList.add(idStr);
            }
            ServiceTicketsCtlr.getServiceTickets(idsList,filters);
            r=ServiceTicketsCtlr.getIdsForFile(filters,'true');
            ids = (Set<Id>)r.data.get('ids');
            idsList = new List<String>();
            for(Id idStr : ids){
                idsList.add(idStr);
            }
            ServiceTicketsCtlr.getServiceTicketsFile(idsList,filters);
            
            try{
                for(ServiceTicketsCtlr.serviceTicketLine ser: serviceTicketLine){
                    ser.Product = products[0].Id;
                }
                
                r = ServiceTicketsCtlr.saveSeriveTicket('',JSON.serialize(ServiceTicket),JSON.serialize(serviceTicketLine),'',true);
            } catch(Exception ex){}
            
        }
    }
    private static testmethod void runProductCtrl(){
        
        
        Account[] rAccounts = new Account[]{};
            Account objAccount = new Account();
        objAccount.Name = 'Test Microbusiness';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Type = 'Microbusiness';
        objAccount.Licensed_Verticals__c = 'Cultivator';
        rAccounts.add(objAccount);
        objAccount = new Account();
        objAccount.Name = 'Test Retailer';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Type = 'Retailer';
        rAccounts.add(objAccount);
        objAccount = new Account();
        objAccount.Name = 'Test NonStoreFront';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Type = 'Retailer NonStoreFront';
        insert objAccount;
        
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
            list<Holiday>holidayList = new List<Holiday>();
            Holiday h1 = new Holiday();
            h1.ActivityDate = system.today().addMonths(2);
            h1.Name = 'test 1';
            h1.RecurrenceType = 'RecursYearly';
            h1.IsRecurrence = true;
            h1.RecurrenceStartDate = system.today().addMonths(2);
            h1.RecurrenceDayOfMonth = 5;
            h1.RecurrenceMonthOfYear = 'July';
            holidayList.add(h1);
            
            Holiday h2 = new Holiday();
            h2.ActivityDate = system.today().addMonths(2);
            h2.Name = 'test 2';
            h2.RecurrenceType = 'RecursMonthly';
            h2.IsRecurrence = true;
            h2.RecurrenceStartDate = system.today().addMonths(2);
            h2.RecurrenceInterval = 3;
            h2.RecurrenceDayOfMonth = 5;
            holidayList.add(h2);
            
            insert holidayList;
            Test.stopTest(); 
            ServiceTicketsCtlr.getMonthNumber('December');
            ServiceTicketsCtlr.getHolidayDate(system.today(),holidayList[0]);
            ServiceTicketsCtlr.calanderEvents('01-01-2021','10:25 a');
            //ServiceTicketsCtlr.downloadFile();
            //ServiceTicketsCtlr.downloadPDFFile();
            ServiceTicketsCtlr.insertUId('N/A');
            //ServiceTicketsCtlr.saveSeriveTicket();
        }
    }
}