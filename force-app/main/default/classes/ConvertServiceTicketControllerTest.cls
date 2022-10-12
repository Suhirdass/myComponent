@isTest
public class ConvertServiceTicketControllerTest {
    private static testmethod void convertServiceTicketLineError(){
        TestUtilData.skipTrigger = true;
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        TestUtilData.createTestData();
        Site__c s = [SELECT id FROM Site__c]; 
        
        Account acc =[SELECT id,Name,Membership_Level__c FROM Account WHERE Name =: 'Test Account1' LIMIT 1];
        acc.Type = 'Distributor';
        update acc;
        
        Contact con =new Contact();
        con.FirstName='con';
        con.LastName='test';
        con.AccountId=acc.Id;
        con.Email = 'Testcontactat1@filigreencustomer.com';
        con.Primary_Contact__c = true;
        insert con;
        State_Licenses__c sl = new State_Licenses__c();
        sl.License_Name__c = acc.Id;
        sl.License_Class__c = 'A-License';
        sl.License_Type__c = 'Type 11';
        sl.License_Number__c = 'A11-18-0000054-TEMP';
        sl.License_Status__c = 'Active';
        sl.License_Expiration_Date__c = System.today().addDays(60);
        sl.License_Address__c = '44650 101 Hwy N, Suite F';
        sl.License_City__c = 'Lafayette';
        sl.License_State__c = 'California';
        sl.License_Zip__c = '95454';
        sl.License_Country__c = 'US';
        sl.Default_Warehouse__c = s.Id;
        sl.Total_Miles__c=1;
        
        insert sl;
        
        Service_Ticket__c st =new Service_Ticket__c();
        st.Status__c ='Pending';
        st.Brand_Contact__c=con.Id;
        st.Brand_Name__c=acc.Id;
        st.Transfer_Method__c='Pick-up';
        st.Request_Date_Time__c=system.today().addMonths(2);
        st.Destination_Site__c=s.id;
        st.Licensed_Premise__c =sl.id;
        insert st;
        
        Service_Ticket_Line__c stl =new Service_Ticket_Line__c();
        stl.Status__c ='New';
        stl.Service_Ticket__c =st.id;
        stl.Transfer_of_Custody__c = false;
        insert stl;
        Brand_Quote__c quote = [SELECT Id FROM Brand_Quote__c LIMIT 1];
        quote.Service_Ticket_Line__c = stl.id;
        quote.RecordTypeId = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosByName().get('Service Quote').getRecordTypeId();
        update quote;
        ApexPages.StandardController sc = new ApexPages.StandardController(stl);
        ConvertServiceTicketLineController cstl = new ConvertServiceTicketLineController(sc);
        //cstl.createBuyQuote();
        cstl.convertServiceTicketLine();
        cstl.createBuyQuote();
    }
    private static testmethod void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
        Id pricebookId = Test.getStandardPricebookId();
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        Package_Type_Config__c[] ptcs = new Package_Type_Config__c[]{};
            ptcs.add(new Package_Type_Config__c(Name = 'Bagging 1.00g', Package_Type__c = 'Bagging',Size__c = '1.00(g)'));
        ptcs.add(new Package_Type_Config__c(Name = 'Jarring 1.00g', Package_Type__c = 'Jarring',Size__c = '1.00(g)'));
        ptcs.add(new Package_Type_Config__c(Name = 'Prerolling 1.00g', Package_Type__c = 'Prerolling',Size__c = '1.00(g)'));
        insert ptcs;
        Site__c s = new Site__c(Name= '2089-3');
        insert s;
        
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        Pricebook2 customPB2 = new Pricebook2(Name='Filigreen Originated Sales', isActive=true);
        insert customPB2;
        
        List<Product2> products = [SELECT Id,Most_Popular__c FROM Product2];
        products[0].Most_Popular__c = true;
        products[0].Available_Inventory__c = 200;
        update products[0];
        insert new Product_Review__c(Product__c = products[0].Id, Rating__c = 5,Rating_Text__c = '5', Review__c = 'Nice product');
        Account acc = [SELECT Id, Name,dBA__c,Community_Price_Book__c, Type FROM Account WHERE Name = 'Test Account1' LIMIT 1];
        acc.Type = 'Distributor';
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        acc.Community_Price_Book__c = customPB.Id;
        update acc;
        Product2[] prds = new Product2[]{};
            Set<String> serviceProducts = new Set<String>{'Labeling','Jarring','Testing','Bagging','Pre-Rolling','Tamper Clamshell','Tamper Proof Label','Tamper Shrink Band','Heat Seal','Label Large','Label Medium','Label Small'};
                Id devRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Services').getRecordTypeId();
        
        for(String pName: serviceProducts){
            Product2  objProd = new Product2 ();
            objProd.RecordTypeId = devRecordTypeId;
            objProd.Name = pName;
            objProd.Family = 'Service';
            objProd.Description = 'test '+pName;
            objProd.Producer_Name__c = acc.id;
            objProd.IsActive = true;
            objProd.Quantity_Type__c = 'Quantity';
            objProd.Track_Trace_Category__c='Capsule';
            objProd.Net_Weight_UOM__c='EA';
            objProd.MOQ__c =1;
            prds.add(objProd);
        }
        
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'Testing';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.MOQ__c =2;
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Labeling';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.MOQ__c =2;
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Jarring';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.MOQ__c =1;
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Jarring 1.00g';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.MOQ__c =2;
        
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Bagging';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.MOQ__c =1;
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Bagging 1.00g';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.MOQ__c =1;
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Pre-Rolling';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.MOQ__c =2;
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Prerolling 1.00g';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.MOQ__c =2;
        prds.add(objProduct1);
        insert prds;
        for(Product2 p: prds){
            pbeList.add(new PricebookEntry(
                Pricebook2Id = pricebookId, Product2Id = p.Id,
                UnitPrice = 10000, IsActive = true));
            pbeList.add(new PricebookEntry(
                Pricebook2Id = customPB2.Id, Product2Id = p.Id,
                UnitPrice = 1, IsActive = true));
        }
        Brand_Discount__c bd = new Brand_Discount__c(Brand__c = acc.Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        bd = new Brand_Discount__c(Product_Name__c = products[0].Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        Contact con = [SELECT Id, Name,Primary_Contact__c, Email FROM Contact WHERE Name = 'Test Contact1' LIMIT 1];
        con.Email = 'Testcontactat1@filigreencustomer.com';
        con.Primary_Contact__c = true;
        update con;
        
        // 1. Insert a price book entry for the standard price book.
        // Standard price book entries require the standard price book ID we got earlier.
        
        Map<String,PriceBookEntry> pbeMap = new Map<String,PriceBookEntry>();
        for(PriceBookEntry pbe: [SELECT Id, PriceBook2Id, Product2Id FROM PriceBookEntry]){
            pbeMap.put(pbe.PriceBook2Id+'-'+pbe.Product2Id,pbe);
        }
        for(Product2 p: products){
            p.MOQ__c = 1;
            p.Available_Inventory__c = 100;
            p.Producer_Name__c = acc.Id;
            p.Product_Rating__c = 0;
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
        System.debug('##PriceBookEntries:'+[SELECT Id, PriceBook2.Name, Product2.Name FROM PriceBookEntry]);
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
        
        // Create Site
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        insert objSite;
        
        List<UID__c> uidList= new List<UID__c>();
        UID__c uid = new UID__c(Name='1GGG60300005F51000003344',Active__c = true);
        UID__c uid2 = new UID__c(Name='1GGG60300005F51000003345',Active__c = true);

        uidList.add(uid);
        uidList.add(uid2);
        insert uidList; 
        
        Harvest_Batch_Code__c hbc = new Harvest_Batch_Code__c(Name='Test122',Active__c = true);
        insert hbc;
        
        State_Licenses__c[] slList = new State_Licenses__c[]{};
            State_Licenses__c sl = new State_Licenses__c();
        sl.License_Name__c = acc.Id;
        sl.License_Class__c = 'A-License';
        sl.License_Type__c = 'Type 11';
        sl.License_Number__c = 'A11-18-0000054-TEMP';
        sl.License_Status__c = 'Active';
        sl.License_Expiration_Date__c = System.today().addDays(60);
        sl.License_Address__c = '44650 101 Hwy N, Suite F';
        sl.License_City__c = 'Lafayette';
        sl.License_State__c = 'California';
        sl.License_Zip__c = '95454';
        sl.License_Country__c = 'US';
        sl.Default_Warehouse__c = s.Id;
        sl.Total_Miles__c=1;
        slList.add(sl);
        insert slList;
        Service_Ticket__c st1 =new Service_Ticket__c();
        st1.Status__c ='Pending';
        st1.Brand_Contact__c=con.Id;
        st1.Brand_Name__c=acc.Id;
        st1.Transfer_Method__c='Pick-up';
        st1.Request_Date_Time__c=system.today().addMonths(2);
        st1.Destination_Site__c=objSite.id;
        st1.Licensed_Premise__c =slList[0].id;
        insert st1;
        Service_Ticket_Line__c stl =new Service_Ticket_Line__c();
        stl.Status__c ='New';
        stl.Service_Ticket__c =st1.id;
        stl.Total_Units__c =10;
        stl.New_Packaged_Product__c =products[0].id;
        stl.Expected_Arrival_At_Filligreen__c=system.today().addMonths(2);
        insert stl;
        Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,Default_Distributor__c  = acc.Id,Default_License__c = sl.Id,LateFee__c = 0.020,Route_Origin_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US',Route_Destination_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US');
        insert ccs;
        Test.startTest();
        System.runAs(u){
            AuraResponse r = ServiceTicketsCtlr.init('');
            ServiceTicketsCtlr.BrandContact[] contacts = (ServiceTicketsCtlr.BrandContact[]) r.data.get('contacts');
            ServiceTicketsCtlr.BrandProduct[] bproducts = (ServiceTicketsCtlr.BrandProduct[]) r.data.get('products');
            ServiceTicketsCtlr.ServiceTicket st = (ServiceTicketsCtlr.ServiceTicket) r.data.get('serviceTicket');
            ServiceTicketsCtlr.ServiceTicketLine[] serviceTicketLines = (ServiceTicketsCtlr.ServiceTicketLine[])r.data.get('serviceTicketLines');
            st.brandContactId = contacts[0].Id;
            st.status = 'Draft';
            st.destinationSiteId = objSite.Id;
            serviceTicketLines[0].New_Packaged_Product = bproducts[0].Id;
            serviceTicketLines[0].Harvest_Batch_ID = hbc.Id;
            serviceTicketLines[0].UID = uidList[0].Id;
            serviceTicketLines[0].Per_Unit_Weight_g = '453.60 (g)';
            serviceTicketLines[0].Total_Units = 10;
            serviceTicketLines[0].Desired_Retail_Ready_Form = '1.00(g)';
            serviceTicketLines[0].Package_Type = 'Labeling';
            serviceTicketLines[0].Tamper_Type = 'Tamper Proof Label';
            serviceTicketLines[0].Top_Front_Label = 'Small';
            serviceTicketLines[0].Bottom_Back_Label = 'Medium';
            serviceTicketLines[0].Body_Tube_Label = 'Small';
            serviceTicketLines[0].THC_CBD_Claim_Label = 'Large';
            serviceTicketLines[0].Qty_of_Misc_Label = 2;
            serviceTicketLines[0].Retail_Wholesale_Price = 10;
            //serviceTicketLines[0].Test_Required = 'Yes';
            serviceTicketLines[0].Spl_Packaging_Notes = 'Test';
            serviceTicketLines[0].Labels_Qty = 2;
            
            r = ServiceTicketsCtlr.saveSeriveTicket('',JSON.serialize(st),JSON.serialize(serviceTicketLines),'02-11-2021 00:00:00',true);
            r = ServiceTicketsCtlr.getIds(new Map<String,Object>{'orderByField'=> 'Name', 'isASC' => false},'true');
            Set<Id> ids = (Set<Id>)r.data.get('ids');
            List<String> idsList = new List<String>();
            for(Id idStr : ids){
                idsList.add(idStr);
            }
            r = ServiceTicketsCtlr.getServiceTickets(idsList,new Map<String,Object>{'orderByField'=> 'Name', 'isASC' => false});
            ServiceTicketsCtlr.ServiceTicket[] serviceTickets = (ServiceTicketsCtlr.ServiceTicket[])r.data.get('records');
            
            r = ServiceTicketsCtlr.getServiceTicket(serviceTickets[0].id);
            st.id = serviceTickets[0].id;
            r = ServiceTicketsCtlr.saveSeriveTicket(st.id,JSON.serialize(st),JSON.serialize(serviceTicketLines),'02-11-2021 00:00:00',true);
            r = ServiceTicketsCtlr.init(st.id);
        }
        Service_Ticket__c[] sts = [SELECT Id FROM Service_Ticket__c WHERE id =: st1.id LIMIT 1];
        ApexPages.StandardController sc = new ApexPages.StandardController(sts[0]);
        ConvertServiceTicketController cst = new ConvertServiceTicketController(sc);
        cst.convertServiceTicket();
        //Service_Ticket__c  st1 = [SELECT Id,Brand_Contact__c,Opportunity__r.AccountId,Request_Date_Time__c,Status__c FROM Service_Ticket__c WHERE Id =:sts[0].Id];
        st1.Request_Date_Time__c = Date.today();
        st1.Status__c = 'Pending';
        //update st1;
        //Service_Ticket__c  st1 = [SELECT Id,Brand_Contact__c,Opportunity__r.AccountId FROM Service_Ticket__c WHERE Id =:sts[0].Id];
        Account[] oacc = [SELECT Id,(SELECT Id FROM Contacts) FROM Account WHERE Id =: st1.Opportunity__r.AccountId];
        
        if(!oacc.isEmpty()){
            st1.Brand_Contact__c = oacc[0].Contacts[0].Id;
            
        }
        update st1;
        Service_Ticket_Line__c[] stls = [SELECT Id FROM Service_Ticket_Line__c LIMIT 1];
        if(!stls.isEmpty()){
            Brand_Quote__c quote = [SELECT Id FROM Brand_Quote__c LIMIT 1];
            quote.Service_Ticket_Line__c = stls[0].id;
            quote.RecordTypeId = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosByName().get('Buy Quote').getRecordTypeId();
        	update quote;
            sc = new ApexPages.StandardController(stls[0]);
            ConvertServiceTicketLineController cstl = new ConvertServiceTicketLineController(sc);
            cstl.createBuyQuote();
            cstl.convertServiceTicketLine();
            
            //cstl.convertServiceTicketLine();
        }
        
        
        
    }
    
    private static testmethod void runTestaura(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
        Id pricebookId = Test.getStandardPricebookId();
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        Package_Type_Config__c[] ptcs = new Package_Type_Config__c[]{};
            ptcs.add(new Package_Type_Config__c(Name = 'Bagging 1.00g', Package_Type__c = 'Bagging',Size__c = '1.00(g)'));
        ptcs.add(new Package_Type_Config__c(Name = 'Jarring 1.00g', Package_Type__c = 'Jarring',Size__c = '1.00(g)'));
        ptcs.add(new Package_Type_Config__c(Name = 'Prerolling 1.00g', Package_Type__c = 'Prerolling',Size__c = '1.00(g)'));
        insert ptcs;
        Site__c s = new Site__c(Name= '2089-3');
        insert s;
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        Pricebook2 customPB2 = new Pricebook2(Name='Filigreen Originated Sales', isActive=true);
        insert customPB2;
        
        List<Product2> products = [SELECT Id,Most_Popular__c FROM Product2];
        products[0].Most_Popular__c = true;
        products[0].Available_Inventory__c = 200;
        update products[0];
        insert new Product_Review__c(Product__c = products[0].Id, Rating__c = 5,Rating_Text__c = '5', Review__c = 'Nice product');
        Account acc = [SELECT Id, Name,dBA__c,Community_Price_Book__c, Type FROM Account WHERE Name = 'Test Account1' LIMIT 1];
        acc.Type = 'Distributor';
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        acc.Community_Price_Book__c = customPB.Id;
        update acc;
        Product2[] prds = new Product2[]{};
            Set<String> serviceProducts = new Set<String>{'Labeling','Jarring','Testing','Bagging','Pre-Rolling','Tamper Clamshell','Tamper Proof Label','Tamper Shrink Band','Heat Seal','Label Large','Label Medium','Label Small'};
                Id devRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Services').getRecordTypeId();
        
        for(String pName: serviceProducts){
            Product2  objProd = new Product2 ();
            objProd.RecordTypeId = devRecordTypeId;
            objProd.Name = pName;
            objProd.Family = 'Service';
            objProd.Description = 'test '+pName;
            objProd.Producer_Name__c = acc.id;
            objProd.IsActive = true;
            objProd.Quantity_Type__c = 'Quantity';
            objProd.Track_Trace_Category__c='Capsule';
            objProd.Net_Weight_UOM__c='EA';
            prds.add(objProd);
        }
        
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'Testing';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Labeling';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Jarring';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Jarring 1.00g';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Bagging';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Bagging 1.00g';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Pre-Rolling';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Prerolling 1.00g';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        prds.add(objProduct1);
        insert prds;
        for(Product2 p: prds){
            pbeList.add(new PricebookEntry(
                Pricebook2Id = pricebookId, Product2Id = p.Id,
                UnitPrice = 10000, IsActive = true));
            pbeList.add(new PricebookEntry(
                Pricebook2Id = customPB2.Id, Product2Id = p.Id,
                UnitPrice = 1, IsActive = true));
        }
        Brand_Discount__c bd = new Brand_Discount__c(Brand__c = acc.Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        bd = new Brand_Discount__c(Product_Name__c = products[0].Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        Contact con = [SELECT Id, Name,Primary_Contact__c, Email FROM Contact WHERE Name = 'Test Contact1' LIMIT 1];
        con.Email = 'Testcontactat1@filigreencustomer.com';
        con.Primary_Contact__c = true;
        update con;
        
        // 1. Insert a price book entry for the standard price book.
        // Standard price book entries require the standard price book ID we got earlier.
        
        Map<String,PriceBookEntry> pbeMap = new Map<String,PriceBookEntry>();
        for(PriceBookEntry pbe: [SELECT Id, PriceBook2Id, Product2Id FROM PriceBookEntry]){
            pbeMap.put(pbe.PriceBook2Id+'-'+pbe.Product2Id,pbe);
        }
        for(Product2 p: products){
            p.MOQ__c = 1;
            p.Available_Inventory__c = 100;
            p.Producer_Name__c = acc.Id;
            p.Product_Rating__c = 0;
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
        System.debug('##PriceBookEntries:'+[SELECT Id, PriceBook2.Name, Product2.Name FROM PriceBookEntry]);
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
        
        // Create Site
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        insert objSite;
        
        List<UID__c> uidList= new List<UID__c>();
        UID__c uid = new UID__c(Name='1GGG60300005F51000003344',Active__c = true);
        UID__c uid2 = new UID__c(Name='1GGG60300005F51000003345',Active__c = true);

        uidList.add(uid);
        uidList.add(uid2);
        insert uidList; 
        
        Harvest_Batch_Code__c hbc = new Harvest_Batch_Code__c(Name='Test122',Active__c = true);
        insert hbc;
        
        State_Licenses__c[] slList = new State_Licenses__c[]{};
            State_Licenses__c sl = new State_Licenses__c();
        sl.License_Name__c = acc.Id;
        sl.License_Class__c = 'A-License';
        sl.License_Type__c = 'Type 11';
        sl.License_Number__c = 'A11-18-0000054-TEMP';
        sl.License_Status__c = 'Active';
        sl.License_Expiration_Date__c = System.today().addDays(60);
        sl.License_Address__c = '44650 101 Hwy N, Suite F';
        sl.License_City__c = 'Lafayette';
        sl.License_State__c = 'California';
        sl.License_Zip__c = '95454';
        sl.License_Country__c = 'US';
        sl.Default_Warehouse__c = objSite.Id;
        slList.add(sl);
        insert slList;
        Service_Ticket__c st2 =new Service_Ticket__c();
        st2.Status__c ='Pending';
        st2.Brand_Contact__c=con.Id;
        st2.Brand_Name__c=acc.Id;
        st2.Transfer_Method__c='Pick-up';
        st2.Request_Date_Time__c=system.today().addMonths(2);
        st2.Destination_Site__c=objSite.id;
        st2.Licensed_Premise__c =slList[0].id;
        insert st2;
        Service_Ticket_Line__c stl =new Service_Ticket_Line__c();
        stl.Status__c ='New';
        stl.Service_Ticket__c =st2.id;
        stl.Total_Units__c =10;
        stl.New_Packaged_Product__c =products[0].id;
        stl.Expected_Arrival_At_Filligreen__c=system.today().addMonths(2);
        insert stl;
        Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,Default_Distributor__c  = acc.Id,Default_License__c = sl.Id,LateFee__c = 0.020,Route_Origin_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US',Route_Destination_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US');
        insert ccs;
        Test.startTest();
        System.runAs(u){
            AuraResponse r = ServiceTicketsCtlr.init('');
            ServiceTicketsCtlr.BrandContact[] contacts = (ServiceTicketsCtlr.BrandContact[]) r.data.get('contacts');
            ServiceTicketsCtlr.BrandProduct[] bproducts = (ServiceTicketsCtlr.BrandProduct[]) r.data.get('products');
            ServiceTicketsCtlr.ServiceTicket st = (ServiceTicketsCtlr.ServiceTicket) r.data.get('serviceTicket');
            ServiceTicketsCtlr.ServiceTicketLine[] serviceTicketLines = (ServiceTicketsCtlr.ServiceTicketLine[])r.data.get('serviceTicketLines');
            st.brandContactId = contacts[0].Id;
            st.status = 'Draft';
            serviceTicketLines[0].New_Packaged_Product = products[0].Id;
            serviceTicketLines[0].Harvest_Batch_ID = hbc.Id;
            serviceTicketLines[0].UID = uidList[0].Id;
            serviceTicketLines[0].Per_Unit_Weight_g = '453.60 (g)';
            serviceTicketLines[0].Total_Units = 10;
            serviceTicketLines[0].Desired_Retail_Ready_Form = '1.00(g)';
            serviceTicketLines[0].Package_Type = 'Labeling';
            serviceTicketLines[0].Tamper_Type = 'Tamper Proof Label';
            serviceTicketLines[0].Top_Front_Label = 'Small';
            serviceTicketLines[0].Bottom_Back_Label = 'Medium';
            serviceTicketLines[0].Body_Tube_Label = 'Small';
            serviceTicketLines[0].THC_CBD_Claim_Label = 'Large';
            serviceTicketLines[0].Qty_of_Misc_Label = 2;
            serviceTicketLines[0].Retail_Wholesale_Price = 10;
            //serviceTicketLines[0].Test_Required = 'Yes';
            serviceTicketLines[0].Spl_Packaging_Notes = 'Test';
            serviceTicketLines[0].Labels_Qty = 2;
            
            r = ServiceTicketsCtlr.saveSeriveTicket('',JSON.serialize(st),JSON.serialize(serviceTicketLines),'02-11-2021 00:00:00',true);
            r = ServiceTicketsCtlr.getIds(new Map<String,Object>{'orderByField'=> 'Name', 'isASC' => false},'true');
            Set<Id> ids = (Set<Id>)r.data.get('ids');
            List<String> idsList = new List<String>();
            for(Id idStr : ids){
                idsList.add(idStr);
            }
            r = ServiceTicketsCtlr.getServiceTickets(idsList,new Map<String,Object>{'orderByField'=> 'Name', 'isASC' => false});
            ServiceTicketsCtlr.ServiceTicket[] serviceTickets = (ServiceTicketsCtlr.ServiceTicket[])r.data.get('records');
            
            r = ServiceTicketsCtlr.getServiceTicket(serviceTickets[0].id);
            st.id = serviceTickets[0].id;
            r = ServiceTicketsCtlr.saveSeriveTicket(st.id,JSON.serialize(st),JSON.serialize(serviceTicketLines),'02-11-2021 00:00:00',true);
            r = ServiceTicketsCtlr.init(st.id);
        }
        Service_Ticket__c[] sts = [SELECT Id FROM Service_Ticket__c WHERE Id =: st2.id LIMIT 1];
        
        AuraResponse rs = new AuraResponse('ConvertServiceTicketController.convertServiceTickets()');    
        ConvertServiceTicketController assigns = new ConvertServiceTicketController();
        ConvertServiceTicketController.convertServiceTickets(sts[0].Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(sts[0]);
        // ConvertServiceTicketController cst = new ConvertServiceTicketController(sc);
        //cst.convertServiceTicket();
        Service_Ticket__c  st1 = [SELECT Id,Brand_Contact__c,Opportunity__r.AccountId,Request_Date_Time__c,Status__c FROM Service_Ticket__c WHERE Id =:sts[0].Id];
        st1.Request_Date_Time__c = Date.today();
        st1.Status__c = 'Pending';
        //update st1;
        //Service_Ticket__c  st1 = [SELECT Id,Brand_Contact__c,Opportunity__r.AccountId FROM Service_Ticket__c WHERE Id =:sts[0].Id];
        Account[] oacc = [SELECT Id,(SELECT Id FROM Contacts) FROM Account WHERE Id =: st1.Opportunity__r.AccountId];
        if(!oacc.isEmpty()){
            st1.Brand_Contact__c = oacc[0].Contacts[0].Id;
            
        }
        update st1;
        
        Service_Ticket_Line__c[] stls = [SELECT Id FROM Service_Ticket_Line__c LIMIT 1];
        if(!stls.isEmpty()){
            sc = new ApexPages.StandardController(stls[0]);
            ConvertServiceTicketLineController cstl = new ConvertServiceTicketLineController(sc);
            cstl.convertServiceTicketLine();
        }
    }
    /*private static testmethod void runTest2(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        Id pricebookId = Test.getStandardPricebookId();
        Site__c s = new Site__c(Name= '2089-3');
        insert s;
        Package_Type_Config__c[] ptcs = new Package_Type_Config__c[]{};
            ptcs.add(new Package_Type_Config__c(Name = 'Bagging 1.00g', Package_Type__c = 'Bagging',Size__c = '1.00(g)'));
        ptcs.add(new Package_Type_Config__c(Name = 'Jarring 1.00g', Package_Type__c = 'Jarring',Size__c = '1.00(g)'));
        ptcs.add(new Package_Type_Config__c(Name = 'Prerolling 1.00g', Package_Type__c = 'Prerolling',Size__c = '1.00(g)'));
        insert ptcs;
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        Pricebook2 customPB2 = new Pricebook2(Name='Filigreen Originated Sales', isActive=true);
        insert customPB2;
        List<Product2> products = [SELECT Id,Most_Popular__c FROM Product2];
        products[0].Most_Popular__c = true;
        products[0].Available_Inventory__c = 200;
        update products[0];
        insert new Product_Review__c(Product__c = products[0].Id, Rating__c = 5,Rating_Text__c = '5', Review__c = 'Nice product');
        Account acc = [SELECT Id, Name,dBA__c,Community_Price_Book__c, Type FROM Account WHERE Name = 'Test Account1' LIMIT 1];
        acc.Type = 'Distributor';
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        acc.Community_Price_Book__c = customPB.Id;
        update acc;
        //Create Product1
        Product2[] prds = new Product2[]{};
            Set<String> serviceProducts = new Set<String>{'Labeling','Jarring','Testing','Bagging','Pre-Rolling','Tamper Clamshell','Tamper Proof Label','Tamper Shrink Band','Heat Seal','Label Large','Label Medium','Label Small'};
                Id devRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Services').getRecordTypeId();
        for(String pName: serviceProducts){
            Product2  objProd = new Product2 ();
            objProd.RecordTypeId = devRecordTypeId;
            objProd.Name = pName;
            objProd.Family = 'Service';
            objProd.Description = 'test '+pName;
            objProd.Producer_Name__c = acc.id;
            objProd.IsActive = true;
            objProd.Quantity_Type__c = 'Quantity';
            objProd.Track_Trace_Category__c='Capsule';
            objProd.Net_Weight_UOM__c='EA';
            prds.add(objProd);
        }
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'Testing';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Labeling';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Jarring';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Bagging';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Pre-Rolling';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Bagging 1.00g';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Jarring 1.00g';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Prerolling 1.00g';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        prds.add(objProduct1);
        insert prds;
        for(Product2 p: prds){
            System.debug('##Product::'+p);
            pbeList.add(new PricebookEntry(
                Pricebook2Id = pricebookId, Product2Id = p.Id,
                UnitPrice = 10000, IsActive = true));
            pbeList.add(new PricebookEntry(
                Pricebook2Id = customPB2.Id, Product2Id = p.Id,
                UnitPrice = 1, IsActive = true));
            
        }
        Brand_Discount__c bd = new Brand_Discount__c(Brand__c = acc.Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        bd = new Brand_Discount__c(Product_Name__c = products[0].Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        Contact con = [SELECT Id, Name,Primary_Contact__c, Email FROM Contact WHERE Name = 'Test Contact1' LIMIT 1];
        con.Email = 'Testcontactat1@filigreencustomer.com';
        con.Primary_Contact__c = true;
        update con;
        
        
        // 1. Insert a price book entry for the standard price book.
        // Standard price book entries require the standard price book ID we got earlier.
        
        Map<String,PriceBookEntry> pbeMap = new Map<String,PriceBookEntry>();
        for(PriceBookEntry pbe: [SELECT Id, PriceBook2Id, Product2Id FROM PriceBookEntry]){
            pbeMap.put(pbe.PriceBook2Id+'-'+pbe.Product2Id,pbe);
        }
        for(Product2 p: products){
            p.MOQ__c = 1;
            p.Available_Inventory__c = 100;
            p.Producer_Name__c = acc.Id;
            p.Product_Rating__c = 0;
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
        System.debug('##PriceBookEntries:'+[SELECT Id, PriceBook2.Name, Product2.Name FROM PriceBookEntry]);
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
        
        // Create Site
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        insert objSite;
        
        List<UID__c> uidList= new List<UID__c>();
        UID__c uid = new UID__c(Name='1GGG60300005F51000003344',Active__c = true);
        UID__c uid2 = new UID__c(Name='1GGG60300005F51000003345',Active__c = true);

        uidList.add(uid);
        uidList.add(uid2);
        insert uidList; 
        
        Harvest_Batch_Code__c hbc = new Harvest_Batch_Code__c(Name='Test122',Active__c = true);
        insert hbc;

        //insert slList;
        Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,Default_Distributor__c  = acc.Id,LateFee__c = 0.020,Route_Origin_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US',Route_Destination_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US');
        ccs.Default_Contact__c = con.Id;
        insert ccs;
        
        State_Licenses__c[] slList = new State_Licenses__c[]{};
            State_Licenses__c sl = new State_Licenses__c();
        sl.License_Name__c = acc.Id;
        sl.License_Class__c = 'A-License';
        sl.License_Type__c = 'Type 11';
        sl.License_Number__c = 'A11-18-0000054-TEMP';
        sl.License_Status__c = 'Active';
        sl.License_Expiration_Date__c = System.today().addDays(60);
        sl.License_Address__c = '44650 101 Hwy N, Suite F';
        sl.License_City__c = 'Lafayette';
        sl.License_State__c = 'California';
        sl.License_Zip__c = '95454';
        sl.License_Country__c = 'US';
        sl.Default_Warehouse__c = objSite.Id;
        slList.add(sl);
        //insert slList;
        Test.startTest();
        System.runAs(u){
            AuraResponse r = ServiceTicketsCtlr.init('');
            ServiceTicketsCtlr.BrandContact[] contacts = (ServiceTicketsCtlr.BrandContact[]) r.data.get('contacts');
            ServiceTicketsCtlr.BrandProduct[] bproducts = (ServiceTicketsCtlr.BrandProduct[]) r.data.get('products');
            ServiceTicketsCtlr.ServiceTicket st = (ServiceTicketsCtlr.ServiceTicket) r.data.get('serviceTicket');
            ServiceTicketsCtlr.ServiceTicketLine[] serviceTicketLines = (ServiceTicketsCtlr.ServiceTicketLine[])r.data.get('serviceTicketLines');
            st.brandContactId = contacts[0].Id;
            serviceTicketLines[0].New_Packaged_Product = bproducts[0].Id;
            serviceTicketLines[0].Harvest_Batch_ID = hbc.Id;
            serviceTicketLines[0].UID = uidList[0].Id;
            serviceTicketLines[0].Per_Unit_Weight_g = '453.60 (g)';
            serviceTicketLines[0].Total_Units = 10;
            serviceTicketLines[0].Desired_Retail_Ready_Form = '1.00(g)';
            serviceTicketLines[0].Package_Type = 'Bagging';
            serviceTicketLines[0].Tamper_Type = 'Tamper Proof Label';
            serviceTicketLines[0].Top_Front_Label = 'Small';
            serviceTicketLines[0].Bottom_Back_Label = 'Medium';
            serviceTicketLines[0].Body_Tube_Label = 'Small';
            serviceTicketLines[0].THC_CBD_Claim_Label = 'Large';
            serviceTicketLines[0].Qty_of_Misc_Label = 2;
            serviceTicketLines[0].Retail_Wholesale_Price = 10;
            //serviceTicketLines[0].Test_Required = 'Yes';
            serviceTicketLines[0].Spl_Packaging_Notes = 'Test';
            serviceTicketLines[0].Labels_Qty = 2;
            serviceTicketLines.add(new ServiceTicketsCtlr.ServiceTicketLine());
            serviceTicketLines[1].New_Packaged_Product = bproducts[0].Id;
            serviceTicketLines[1].Harvest_Batch_ID = hbc.Id;
            serviceTicketLines[1].UID = uidList[0].Id;
            serviceTicketLines[1].Per_Unit_Weight_g = '453.60 (g)';
            serviceTicketLines[1].Total_Units = 10;
            serviceTicketLines[1].Desired_Retail_Ready_Form = '1.00(g)';
            serviceTicketLines[1].Package_Type = 'Pre-Rolling';
            serviceTicketLines[1].Tamper_Type = 'Tamper Proof Label';
            serviceTicketLines[1].Top_Front_Label = 'Small';
            serviceTicketLines[1].Bottom_Back_Label = 'Medium';
            serviceTicketLines[1].Body_Tube_Label = 'Small';
            serviceTicketLines[1].THC_CBD_Claim_Label = 'Large';
            serviceTicketLines[1].Qty_of_Misc_Label = 2;
            serviceTicketLines[1].Retail_Wholesale_Price = 10;
            serviceTicketLines[1].Transfer_of_Custody = true;
            //serviceTicketLines[1].Test_Required = 'Yes';
            serviceTicketLines[1].Spl_Packaging_Notes = 'Test';
            serviceTicketLines[1].Qty_Per_Multi_Unit = 2;
            r = ServiceTicketsCtlr.saveSeriveTicket('',JSON.serialize(st),JSON.serialize(serviceTicketLines),'02-11-2021 00:00:00',true);
            r = ServiceTicketsCtlr.getIds(new Map<String,Object>{'orderByField'=> 'Name', 'isASC' => false},'true');
            Set<Id> ids = (Set<Id>)r.data.get('ids');
            List<String> idsList = new List<String>();
            for(Id idStr : ids){
                idsList.add(idStr);
            }
            r = ServiceTicketsCtlr.getServiceTickets(idsList,new Map<String,Object>{'orderByField'=> 'Name', 'isASC' => false});
            ServiceTicketsCtlr.ServiceTicket[] serviceTickets = (ServiceTicketsCtlr.ServiceTicket[])r.data.get('records');
            
            r = ServiceTicketsCtlr.getServiceTicket(serviceTickets[0].id);
            st.id = serviceTickets[0].id;
            r = ServiceTicketsCtlr.saveSeriveTicket(st.id,JSON.serialize(st),JSON.serialize(serviceTicketLines),'02-11-2021 00:00:00',true);
            r = ServiceTicketsCtlr.init(st.id);
        }
        Service_Ticket__c[] sts = [SELECT Id FROM Service_Ticket__c LIMIT 1];
        
        ApexPages.StandardController sc = new ApexPages.StandardController(sts[0]);
        ConvertServiceTicketController cst = new ConvertServiceTicketController(sc);
        cst.convertServiceTicket();
        Service_Ticket__c  st1 = [SELECT Id,Brand_Contact__c,Opportunity__r.AccountId FROM Service_Ticket__c WHERE Id =:sts[0].Id];
        Account[] oacc = [SELECT Id,(SELECT Id FROM Contacts) FROM Account WHERE Id =: st1.Opportunity__r.AccountId];
        if(!oacc.isEmpty()){
            st1.Brand_Contact__c = oacc[0].Contacts[0].Id;
            update st1;
        }
        
        Service_Ticket_Line__c[] stls = [SELECT Id FROM Service_Ticket_Line__c];
        for(Service_Ticket_Line__c stl : stls){
            stl.Total_Units__c = 40;
            stl.Per_Unit_Weight_g__c = '1 (each)';
            stl.Desired_Retail_Ready_Form__c = '1 (each)';
            stl.Package_Type__c = 'Casing';
            stl.Transfer_of_Custody__c = true;
            //stl.New_Packaged_Product__c = pro.id;
        }
        update stls;
        
        if(!stls.isEmpty()){
            sc = new ApexPages.StandardController(stls[0]);
            ConvertServiceTicketLineController cstl = new ConvertServiceTicketLineController(sc);
            cstl.convertServiceTicketLine();
            sc = new ApexPages.StandardController(stls[1]);
            cstl = new ConvertServiceTicketLineController(sc);
            cstl.convertServiceTicketLine();
            cstl.createBuyQuote();
            ConvertServiceTicketLineController.createBuyQuote(stls[0].Id);
            
        }
        Test.stopTest();
    }*/
    /*private static testmethod void csq(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());  
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        Id pricebookId = Test.getStandardPricebookId();
        Site__c s = new Site__c(Name= '2089-3');
        insert s;
        
        Test.startTest();
        
        Package_Type_Config__c[] ptcs = new Package_Type_Config__c[]{};
            ptcs.add(new Package_Type_Config__c(Name = 'Bagging 1.00g', Package_Type__c = 'Bagging',Size__c = '1.00(g)'));
        ptcs.add(new Package_Type_Config__c(Name = 'Jarring 1.00g', Package_Type__c = 'Jarring',Size__c = '1.00(g)'));
        ptcs.add(new Package_Type_Config__c(Name = 'Prerolling 1.00g', Package_Type__c = 'Prerolling',Size__c = '1.00(g)'));
        insert ptcs;
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        Pricebook2 customPB2 = new Pricebook2(Name='Filigreen Originated Sales', isActive=true);
        insert customPB2;
        List<Product2> products = [SELECT Id,Most_Popular__c FROM Product2];
        products[0].Most_Popular__c = true;
        products[0].Available_Inventory__c = 200;
        update products[0];
        insert new Product_Review__c(Product__c = products[0].Id, Rating__c = 5,Rating_Text__c = '5', Review__c = 'Nice product');
        Account acc = [SELECT Id, Name,dBA__c,Community_Price_Book__c, Type FROM Account WHERE Name = 'Test Account1' LIMIT 1];
        acc.Type = 'Distributor';
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        acc.Community_Price_Book__c = customPB.Id;
        update acc;
        
        List<UID__c> uidList= new List<UID__c>();
        UID__c uid = new UID__c(Name='1GGG60300005F51000003344',Active__c = true);
        UID__c uid2 = new UID__c(Name='1GGG60300005F51000003345',Active__c = true);

        uidList.add(uid);
        uidList.add(uid2);
        insert uidList; 
        
        Harvest_Batch_Code__c hbc = new Harvest_Batch_Code__c(Name='Test122',Active__c = true);
        insert hbc;
        
        //Create Product1
        Product2[] prds = new Product2[]{};
            Set<String> serviceProducts = new Set<String>{'Labeling','Jarring','Testing','Bagging','Bagging 1.00(g)','Pre-Rolling','Tamper Clamshell','Tamper Proof Label','Tamper Shrink Band','Heat Seal','Label Large','Label Medium','Label Small'};
                Id devRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByName().get('Services').getRecordTypeId();
        for(String pName: serviceProducts){
            Product2  objProd = new Product2 ();
            objProd.RecordTypeId = devRecordTypeId;
            objProd.Name = pName;
            objProd.Family = 'Service';
            objProd.Description = 'test '+pName;
            objProd.Producer_Name__c = acc.id;
            objProd.IsActive = true;
            objProd.Quantity_Type__c = 'Quantity';
            objProd.Track_Trace_Category__c='Capsule';
            objProd.Net_Weight_UOM__c='EA';
            objProd.Cannabis_Weight__c  = 2.5;
            prds.add(objProd);
        }
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'Testing';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Cannabis_Weight__c  = 2.5;
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Labeling';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Cannabis_Weight__c  = 2.5;
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Jarring';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Cannabis_Weight__c  = 2.5;
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Bagging';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Cannabis_Weight__c  = 2.5;
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Pre-Rolling';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Cannabis_Weight__c  = 2.5;
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Bagging 1.00g';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Cannabis_Weight__c  = 2.5;
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Jarring 1.00g';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Cannabis_Weight__c  = 2.5;
        prds.add(objProduct1);
        objProduct1 = new Product2 ();
        objProduct1.Name = 'Prerolling 1.00g';
        objProduct1.Family = 'Service';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = acc.id;
        objProduct1.IsActive = true;
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Cannabis_Weight__c  = 2.5;
        prds.add(objProduct1);
        insert prds;
        for(Product2 p: prds){
            System.debug('##Product::'+p);
            pbeList.add(new PricebookEntry(
                Pricebook2Id = pricebookId, Product2Id = p.Id,
                UnitPrice = 10000, IsActive = true));
            pbeList.add(new PricebookEntry(
                Pricebook2Id = customPB2.Id, Product2Id = p.Id,
                UnitPrice = 1, IsActive = true));
            
        }
        Brand_Discount__c bd = new Brand_Discount__c(Brand__c = acc.Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        bd = new Brand_Discount__c(Product_Name__c = products[0].Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        Contact con = [SELECT Id, Name,Primary_Contact__c, Email FROM Contact WHERE Name = 'Test Contact1' LIMIT 1];
        con.Email = 'Testcontactat1@filigreencustomer.com';
        con.Primary_Contact__c = true;
        update con;
        
        //insert slList;
        Company_Custom_Settings__c ccs = new Company_Custom_Settings__c (Driver_License_Expire_N2_Days_Notice__c=2,Driver_License_Expire_N1_Days_Notice__c=2,Default_Distributor__c  = acc.Id,LateFee__c = 0.020,Route_Origin_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US',Route_Destination_Address__c = '2089 Ingalls St. Unit 3 San Francisco, CA 94124 US');
        ccs.Default_Contact__c = con.Id;
        insert ccs;
        // 1. Insert a price book entry for the standard price book.
        // Standard price book entries require the standard price book ID we got earlier.
        
        Map<String,PriceBookEntry> pbeMap = new Map<String,PriceBookEntry>();
        for(PriceBookEntry pbe: [SELECT Id, PriceBook2Id, Product2Id FROM PriceBookEntry]){
            pbeMap.put(pbe.PriceBook2Id+'-'+pbe.Product2Id,pbe);
        }
        for(Product2 p: products){
            p.MOQ__c = 1;
            p.Available_Inventory__c = 100;
            p.Producer_Name__c = acc.Id;
            p.Product_Rating__c = 0;
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
        System.debug('##PriceBookEntries:'+[SELECT Id, PriceBook2.Name, Product2.Name FROM PriceBookEntry]);
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
        
        // Create Site
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        insert objSite;
        
        State_Licenses__c[] slList = new State_Licenses__c[]{};
            State_Licenses__c sl = new State_Licenses__c();
        sl.License_Name__c = acc.Id;
        sl.License_Class__c = 'A-License';
        sl.License_Type__c = 'Type 11';
        sl.License_Number__c = 'A11-18-0000054-TEMP';
        sl.License_Status__c = 'Active';
        sl.License_Expiration_Date__c = System.today().addDays(60);
        sl.License_Address__c = '44650 101 Hwy N, Suite F';
        sl.License_City__c = 'Lafayette';
        sl.License_State__c = 'California';
        sl.License_Zip__c = '95454';
        sl.License_Country__c = 'US';
        sl.Default_Warehouse__c = objSite.Id;
        slList.add(sl);
        //insert slList;
        System.runAs(u){
            AuraResponse r = ServiceTicketsCtlr.init('');
            ServiceTicketsCtlr.BrandContact[] contacts = (ServiceTicketsCtlr.BrandContact[]) r.data.get('contacts');
            ServiceTicketsCtlr.BrandProduct[] bproducts = (ServiceTicketsCtlr.BrandProduct[]) r.data.get('products');
            ServiceTicketsCtlr.ServiceTicket st = (ServiceTicketsCtlr.ServiceTicket) r.data.get('serviceTicket');
            ServiceTicketsCtlr.ServiceTicketLine[] serviceTicketLines = (ServiceTicketsCtlr.ServiceTicketLine[])r.data.get('serviceTicketLines');
            
            Product2 pro = [SELECT Id,Cannabis_Weight__c FROM PRODUCT2 WHERE Id =: bproducts[0].Id LIMIT 1];
            pro.Cannabis_Weight__c = 1 ;
            update pro;
            
            st.brandContactId = contacts[0].Id;
            st.status = 'Draft';
            serviceTicketLines[0].New_Packaged_Product = bproducts[0].Id;
            serviceTicketLines[0].Harvest_Batch_ID = hbc.Id;
            serviceTicketLines[0].UID = uidList[0].Id;
            serviceTicketLines[0].Per_Unit_Weight_g = '453.60 (g)';
            serviceTicketLines[0].Total_Units = 10;
            serviceTicketLines[0].Desired_Retail_Ready_Form = '1.00(g)';
            serviceTicketLines[0].Package_Type = 'Labeling';
            serviceTicketLines[0].Tamper_Type = 'Tamper Proof Label';
            serviceTicketLines[0].Top_Front_Label = 'Small';
            serviceTicketLines[0].Bottom_Back_Label = 'Medium';
            serviceTicketLines[0].Body_Tube_Label = 'Small';
            serviceTicketLines[0].THC_CBD_Claim_Label = 'Large';
            serviceTicketLines[0].Qty_of_Misc_Label = 2;
            serviceTicketLines[0].Retail_Wholesale_Price = 10;
            //serviceTicketLines[0].Test_Required = 'Yes';
            serviceTicketLines[0].Spl_Packaging_Notes = 'Test';
            serviceTicketLines[0].Labels_Qty = 2;
            serviceTicketLines.add(new ServiceTicketsCtlr.ServiceTicketLine());
            serviceTicketLines[1].New_Packaged_Product = bproducts[0].Id;
            serviceTicketLines[1].Harvest_Batch_ID = hbc.Id;
            serviceTicketLines[1].UID = uidList[0].Id;
            serviceTicketLines[1].Per_Unit_Weight_g = '453.60 (g)';
            serviceTicketLines[1].Total_Units = 10;
            serviceTicketLines[1].Desired_Retail_Ready_Form = '1.00(g)';
            serviceTicketLines[1].Package_Type = 'Cannabis Waste';
            serviceTicketLines[1].Tamper_Type = 'Tamper Proof Label';
            serviceTicketLines[1].Top_Front_Label = 'Small';
            serviceTicketLines[1].Bottom_Back_Label = 'Medium';
            serviceTicketLines[1].Body_Tube_Label = 'Small';
            serviceTicketLines[1].THC_CBD_Claim_Label = 'Large';
            serviceTicketLines[1].Qty_of_Misc_Label = 2;
            serviceTicketLines[1].Retail_Wholesale_Price = 10;
            serviceTicketLines[1].Transfer_of_Custody = true;
            //serviceTicketLines[1].Test_Required = 'Yes';
            serviceTicketLines[1].Spl_Packaging_Notes = 'Test';
            serviceTicketLines[1].Qty_Per_Multi_Unit = 2;
            r = ServiceTicketsCtlr.saveSeriveTicket('',JSON.serialize(st),JSON.serialize(serviceTicketLines),'02-11-2021 00:00:00',true);
            r = ServiceTicketsCtlr.getIds(new Map<String,Object>{'orderByField'=> 'Name', 'isASC' => false},'true');
            Set<Id> ids = (Set<Id>)r.data.get('ids');
            List<String> idsList = new List<String>();
            for(Id idStr : ids){
                idsList.add(idStr);
            }
            r = ServiceTicketsCtlr.getServiceTickets(idsList,new Map<String,Object>{'orderByField'=> 'Name', 'isASC' => false});
            ServiceTicketsCtlr.ServiceTicket[] serviceTickets = (ServiceTicketsCtlr.ServiceTicket[])r.data.get('records');
            
            r = ServiceTicketsCtlr.getServiceTicket(serviceTickets[0].id);
            st.id = serviceTickets[0].id;
            r = ServiceTicketsCtlr.saveSeriveTicket(st.id,JSON.serialize(st),JSON.serialize(serviceTicketLines),'02-11-2021 00:00:00',true);
            r = ServiceTicketsCtlr.init(st.id);
        }
        Service_Ticket__c[] sts = [SELECT Id FROM Service_Ticket__c LIMIT  1];
        
        AuraResponse rs = new AuraResponse('ConvertServiceTicketController.convertServiceTickets()');    
        ConvertServiceTicketController assigns = new ConvertServiceTicketController();
        ConvertServiceTicketController.convertServiceTickets(sts[0].Id);
        
        ApexPages.StandardController sc = new ApexPages.StandardController(sts[0]);
        ConvertServiceTicketController cst = new ConvertServiceTicketController(sc);
        cst.convertServiceTicket();
        Service_Ticket__c  st1 = [SELECT Id,Brand_Contact__c,Opportunity__r.AccountId FROM Service_Ticket__c WHERE Id =:sts[0].Id];
        Account[] oacc = [SELECT Id,(SELECT Id FROM Contacts) FROM Account WHERE Id =: st1.Opportunity__r.AccountId];
        if(!oacc.isEmpty()){
            st1.Brand_Contact__c = oacc[0].Contacts[0].Id;
            update st1;
        }
        
        Service_Ticket_Line__c[] stls = [SELECT Id FROM Service_Ticket_Line__c];
        for(Service_Ticket_Line__c stl : stls){
            stl.Total_Units__c = 40;
            stl.Per_Unit_Weight_g__c = '1 (each)';
            stl.Desired_Retail_Ready_Form__c = '1 (each)';
            stl.Package_Type__c = 'Casing';
            //stl.Transfer_of_Custody__c = true;
            //stl.New_Packaged_Product__c = pro.id;
        }
        update stls;
        //system.debug('aaa '+[SELECT Id,Converted_Single_Qty__c,Qty_Label_Large__c FROM Service_Ticket_Line__c]);
        if(!stls.isEmpty()){
            AuraResponse r = new AuraResponse('ConvertServiceTicketLineController.convertServiceQuote()');    
            ConvertServiceTicketLineController.convertServiceQuote(stls[0].Id);
            ConvertServiceTicketLineController.createBuyQuote(stls[0].Id);
        } 
        Test.stopTest();
    }*/
}