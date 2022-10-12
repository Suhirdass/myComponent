@isTest
public class RetailDeliveryTicketsCtlrTest { 
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
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        List<Product2> products = [SELECT Id,Most_Popular__c FROM Product2];
        products[0].Most_Popular__c = true;
        products[0].Available_Inventory__c = 200;
        update products[0];
        
        insert new Product_Review__c(Product__c = products[0].Id, Rating__c = 5,Rating_Text__c = '5', Review__c = 'Nice product');
        Account acc = [SELECT Id, Name,dBA__c,Community_Price_Book__c,Hide_From_Marketplace__c, Type FROM Account WHERE Name = 'Test Account1' LIMIT 1];
        acc.Type = 'Distributor';
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        acc.Community_Price_Book__c = customPB.Id;
        acc.Hide_From_Marketplace__c = false;
        update acc;
        Account[] accs = [SELECT Id, Name,dBA__c,Community_Price_Book__c, Type FROM Account WHERE Id != :acc.Id];
        Integer i=0;
        List<Line_Card__c> lineCards = new List< Line_Card__c >();
        List<State_Licenses__c> licenses = new List<State_Licenses__c>();
        Integer j=10;
        for(Account a: accs){
            a.dBA__c = acc.Name;
            a.Hide_From_Marketplace__c = false;
            a.Community_Price_Book__c = customPB.Id;
            if(i == 0){
                a.Type = 'Manufacturer'; 
            }else if(i==1){
                a.Type = 'Supplier';
            }else{
                a.Type = 'Customer';
            }
            lineCards.add(new Line_Card__c(Brand_Name__c = acc.Id,Mutual_Payment_Terms__c ='NET 15', Onboard_Date__c = System.today().addDays(-10), Retailer_Name__c = a.Id, Retail_Account_Rating__c  = 'Preferred', Brand_Account_Rating__c ='Standard'));
            State_Licenses__c objStateLicenses = new State_Licenses__c();
            objStateLicenses.License_Name__c = a.id;
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
            licenses.add(objStateLicenses);
            
            // distributor License
            State_Licenses__c objStateLicenses2 = new State_Licenses__c();
            objStateLicenses2.License_Name__c = a.id;
            objStateLicenses2.License_Number__c = 'AbcTest'+(j*10)+15;
            objStateLicenses2.License_Status__c ='Active';
            objStateLicenses2.License_Type__c ='Type 11';
            objStateLicenses2.License_Class__c='A-License';
            objStateLicenses2.License_City__c = 'Auburn';
            objStateLicenses2.License_State__c = 'California';
            objStateLicenses2.License_Country__c = 'US';
            objStateLicenses2.License_Zip__c = '12355';
            objStateLicenses2.Default_Warehouse__c =s.id;
            objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now()) + 10;
            licenses.add(objStateLicenses2);
            j+= 10;
        }
        insert lineCards;
        insert licenses;
        update accs;
        Brand_Discount__c bd = new Brand_Discount__c(Brand__c = acc.Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        bd = new Brand_Discount__c(Product_Name__c = products[0].Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        Contact[] cons = [SELECT Id,AccountId, Name,Primary_Contact__c, Email FROM Contact WHERE Name IN ('Test Contact1','Test Contact2')];
        Account accDT = new Account(Id =cons[0].AccountId, Type='Disty Partner');
        accDT.Platform_Level__c='Basic';
        update accDT;
        cons[0].Email = 'Testcontactat1@filigreencustomer.com';
        cons[0].Primary_Contact__c = true;
        cons[1].Email = 'Testcontactat123@filigreencustomer.com';
        update cons;
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
           p.Hide_From_Marketplace__c =false;
            p.White_Labelled__c =false;
            p.Product_Rating__c = 0;
            p.Unit_Gross_Weight__c =10;
            p.Retail_Unit_Form_Factor__c  ='Jar';
            p.Unit_Radius__c =3;
            p.Unit_Height__c =6;
            p.Family='Marketing Materials';
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
        List<Profile> profiles = [SELECT Id, Name FROM Profile WHERE Name = 'Customer Community Plus User Custom'];
        User u = new User();
        u.ProfileId = profiles[0].Id;
        u.firstName = 'testcontact1';
        u.lastName = 'customeruser';
        u.Username = 'Testcontactat1@filigreencustomer.com.testaccount1';
        u.Email = 'Testcontactat1@filigreencustomer.com';
        u.ContactId = cons[0].Id;
        u.Title = 'Customer';
        u.CommunityNickname = 'ruser';
        u.Alias = 'testser';
        u.TimeZoneSidKey = 'America/Los_Angeles'; // Required
        u.LocaleSidKey = 'en_US'; // Required
        u.EmailEncodingKey = 'ISO-8859-1'; // Required
        u.LanguageLocaleKey = 'en_US'; // Required
        insert u;
        RecordType rt= [SELECT id FROM RecordType WHERE Name='Retailer'];
        Order__c o =new Order__c();
        o.Account__c=acc.id;
        o.Status__c='Approved';
       	o.RecordTypeId =rt.Id;
        o.Order_Date__c=system.today();
        o.State_License__c=licenses[0].id;
        insert o;
        Order_Line_Item__c oli =new Order_Line_Item__c();
        oli.Order__c=o.id;
        oli.Ownership_Code__c =acc.id;
        oli.Quantity_Cases__c=1;
        oli.MOQ__c=1;
        oli.UnitPrice__c=3;
        oli.Product__c=products[0].id;
        oli.Price_Book_Entry_Id__c=pbeList[1].id;
        insert oli;
        
       	Inventory_Location__c il =new Inventory_Location__c();
        il.Site_Name__c =s.id;
        il.Name ='stage1';
        il.Include_in_Inventory__c =true;
        insert il;
        Inventory_Position__c ip =new Inventory_Position__c();
        ip.Site__c =s.id;
        ip.Inventory_Location__c = il.id;
        ip.Qty_On_Hand__c=12;
        ip.Hold__c =false;
        ip.Product_Name__c =products[0].id;
        insert ip;
        Factoring_Relationship__c fr =new Factoring_Relationship__c();
        fr.Buyer_Account__c =acc.id;
        fr.Factoring_Assignee__c =acc.Id;
        fr.Seller_Account__c =acc.id;
        insert fr;
        Fulfillment_Rates_Table__c frt =new Fulfillment_Rates_Table__c();
        frt.Active__c =true;
        frt.Fulfillment_Services__c='Pick & Pack';
        frt.Bracket_Cost__c =200;
        frt.Bracket_Mark_Up__c=2;
        frt.Rate_Effective_From__c =system.today();
        frt.Rate_Effective_To__c =system.today();
        frt.Site__c=s.id;
        frt.Membership_Level__c='Standard';
        frt.Weight_lbs__c =12;
        insert frt;
        Test.startTest();
        System.runAs(u){
            
            Boolean isBrand = ProductsCtlr.isBrand;
            AuraResponse r = ProductsCtlr.isCommunityPlusUser();
            Map<String, Object> filters = new Map<String, Object> ();
            filters.put('searchTerm', 'test');
            filters.put('status', 'All');
            r = RetailDeliveryTicketsCtlr.init('',false,'','','False');
            RetailDeliveryTicketsCtlr.RetailDeliveryTicket retailDeliveryTicket =  (RetailDeliveryTicketsCtlr.RetailDeliveryTicket) r.data.get('retailDeliveryTicket');
            List<RetailDeliveryTicketsCtlr.RetailDeliveryTicketLineItem> retailDeliveryTicketLineItems = (list<RetailDeliveryTicketsCtlr.RetailDeliveryTicketLineItem>) r.data.get('retailDeliveryTicketLineItems');
            List<Map<String, String>> retailers = (List<Map<String, String>>) r.data.get('retailers');
            List<RetailDeliveryTicketsCtlr.Product> rproducts = (List<RetailDeliveryTicketsCtlr.Product>) r.data.get('products');
            	
            retailDeliveryTicket.retailer = retailers[0].get('id');
            retailDeliveryTicket.paymentTerms = 'COD';
           	//system.debug('------>'+retailDeliveryTicketLineItems);
            System.debug('##products'+rproducts);
            Map<String, Object> retailersDetail = (Map<String, Object>) r.data.get('retailersDetail');
            Map<String, Object> rDetails = (Map<String, Object>) retailersDetail.get(retailers[0].get('id'));
            System.debug('###rDetails::'+rDetails);
            List<Map<String, String>> rlicenses = (List<Map<String, String>>) rDetails.get('licenses');
            System.debug('##rlicenses'+rlicenses);
            retailDeliveryTicket.stateLicense = rlicenses[0].get('id');
            List<Map<String, String>> contacts = (List<Map<String, String>>) rDetails.get('contacts');
            retailDeliveryTicket.retailerContact = contacts[0].get('id');
            retailDeliveryTicket.requestShipDate = System.today().addDays(10);
            retailDeliveryTicket.retailerPO = '5656767';
            retailDeliveryTicket.specialDeliveryInstructions = '5656767';
            
            retailDeliveryTicketLineItems[0].Product = rproducts[0].id; 
            retailDeliveryTicketLineItems[0].listPrice = rproducts[0].price.unitPrice;
            retailDeliveryTicketLineItems[0].salesPrice = rproducts[0].salePrice;
            retailDeliveryTicketLineItems[0].MOQ = rproducts[0].MOQ;
            retailDeliveryTicketLineItems[0].orderQty = 1;
            retailDeliveryTicketLineItems[0].availableInventory = rproducts[0].availableInventory;
            retailDeliveryTicketLineItems[0].ProductBookEntryId = rproducts[0].price.id;
            String[] conIds = new String[]{cons[1].Id};
                    string cIds = cons[1].Id;           
            r = RetailDeliveryTicketsCtlr.saveRetailDeliveryTicket('',JSON.serialize(retailDeliveryTicket),JSON.serialize(retailDeliveryTicketLineItems),cIds,cIds,cIds,false,'DRAFT');
            r = RetailDeliveryTicketsCtlr.getIds(filters,false);
            RetailDeliveryTicketsCtlr.calculateOrderProcessingFee(retailDeliveryTicket.stateLicense,'',JSON.serialize(retailDeliveryTicketLineItems),JSON.serialize(retailDeliveryTicket),JSON.serialize(rproducts));
            Set<Id> ids = (Set<Id>)r.data.get('ids');
            List<String> idList = new  List<String>();
            for(Id rId: ids){
                idList.add(rId);
            }
            
            //Utility.notifyOnNewRetailerDiliveryTicket(idList);
            r = RetailDeliveryTicketsCtlr.getRetailDeliveryTickets(idList,filters);
            List<RetailDeliveryTicketsCtlr.RetailDeliveryTicket> rList = (List<RetailDeliveryTicketsCtlr.RetailDeliveryTicket>) r.data.get('retailDeliveryTickets');
            r =RetailDeliveryTicketsCtlr.getRetailDeliveryTicket(rList[0].id);
            /*Order_Line_Item__c[] lst = new RetailerOrderEmailTemplateController().getOrderLineItems();
            r = RetailDeliveryTicketsCtlr.getProductsByRetailerId('',false);
            r= RetailDeliveryTicketsCtlr.getSortedRDTLineItems(o.id,filters);
            string prdut =products[0].id;
            r= RetailDeliveryTicketsCtlr.removeProduct(prdut);
            r= RetailDeliveryTicketsCtlr.removeProducts();
            //RetailDeliveryTicketsCtlr.getDistance('Los Angels','New York');
            Utility.getCartTotal();
            Utility.hasAccepted();
            Utility.init();
            //r = RetailDeliveryTicketsCtlr.init(o.id,false,JSON.serialize(retailDeliveryTicket),JSON.serialize(retailDeliveryTicketLineItems),'True');
            //Map<String, Object>  filterNew = new Map<String, Object> {'orderByField' =>'Name', 'isASC' => true,'searchTerm'=>'t','status'=>'Delivered'};
            //r = RetailDeliveryTicketsCtlr.getRetailDeliveryTickets(idList,filterNew); 
            RetailDeliveryTicketsCtlr.deleteOrder(o.id);
            RetailDeliveryTicketsCtlr.getMonthNumber('December');
            RetailDeliveryTicketsCtlr.getMonthNumber('November');
            RetailDeliveryTicketsCtlr.getMonthNumber('October');
            RetailDeliveryTicketsCtlr.getMonthNumber('September');
            RetailDeliveryTicketsCtlr.getMonthNumber('August');
            RetailDeliveryTicketsCtlr.getMonthNumber('July');
            RetailDeliveryTicketsCtlr.getMonthNumber('June');
            RetailDeliveryTicketsCtlr.getMonthNumber('April');
            RetailDeliveryTicketsCtlr.getMonthNumber('March');
            RetailDeliveryTicketsCtlr.getMonthNumber('February');
            RetailDeliveryTicketsCtlr.getMonthNumber('January');*/
            
        }
    }
   private static testmethod void runTest2(){
        Google_Distance_Matrix_API__c g = new Google_Distance_Matrix_API__c();
        g.Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?';
        g.Name = 'Geocode_Endpoint';
        insert g;
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());   
        TestUtilData.skipTrigger = true;
        TestUtilData.createTestData();
        Site__c s = new Site__c(Name= '2089-3',Warehouse_Name__c='San Francisco',Sort_Order__c=1,Active__c=true);
        insert s;
        // Create a custom price book
        Pricebook2 customPB = new Pricebook2(Name='Custom Pricebook', isActive=true);
        insert customPB;
        List<Product2> products = [SELECT Id,Most_Popular__c FROM Product2];
        products[0].Most_Popular__c = true;
        products[0].Available_Inventory__c = 200;
        update products[0];
        
        insert new Product_Review__c(Product__c = products[0].Id, Rating__c = 5,Rating_Text__c = '5', Review__c = 'Nice product');
        Account acc = [SELECT Id, Name,dBA__c,Community_Price_Book__c,Hide_From_Marketplace__c, Type FROM Account WHERE Name = 'Test Account1' LIMIT 1];
        acc.Type = 'Distributor';
        acc.Name = 'Irrational Raccoon, LLC';
        acc.dBA__c = 'Irrational Raccoon';
        acc.Community_Price_Book__c = customPB.Id;
        acc.Hide_From_Marketplace__c = false;
        update acc;
        Account[] accs = [SELECT Id, Name,dBA__c,Community_Price_Book__c, Type FROM Account WHERE Id != :acc.Id];
        Integer i=0;
        List<Line_Card__c> lineCards = new List< Line_Card__c >();
        List<State_Licenses__c> licenses = new List<State_Licenses__c>();
        Integer j=10;
        for(Account a: accs){
            a.dBA__c = acc.Name;
            a.Hide_From_Marketplace__c = false;
            a.Community_Price_Book__c = customPB.Id;
            if(i == 0){
                a.Type = 'Manufacturer'; 
            }else if(i==1){
                a.Type = 'Supplier';
            }else{
                a.Type = 'Customer';
            }
            lineCards.add(new Line_Card__c(Brand_Name__c = acc.Id,Mutual_Payment_Terms__c ='NET 15', Onboard_Date__c = System.today().addDays(-10), Retailer_Name__c = a.Id, Retail_Account_Rating__c  = 'Preferred', Brand_Account_Rating__c ='Standard'));
            State_Licenses__c objStateLicenses = new State_Licenses__c();
            objStateLicenses.License_Name__c = a.id;
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
            licenses.add(objStateLicenses);
            
            // distributor License
            State_Licenses__c objStateLicenses2 = new State_Licenses__c();
            objStateLicenses2.License_Name__c = a.id;
            objStateLicenses2.License_Number__c = 'AbcTest'+(j*10)+15;
            objStateLicenses2.License_Status__c ='Active';
            objStateLicenses2.License_Type__c ='Type 11';
            objStateLicenses2.License_Class__c='A-License';
            objStateLicenses2.License_City__c = 'Auburn';
            objStateLicenses2.License_State__c = 'California';
            objStateLicenses2.License_Country__c = 'US';
            objStateLicenses2.License_Zip__c = '12355';
            objStateLicenses2.Default_Warehouse__c =s.id;
            objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now()) + 10;
            licenses.add(objStateLicenses2);
            j+= 10;
        }
        insert lineCards;
        insert licenses;
        update accs;
        Brand_Discount__c bd = new Brand_Discount__c(Brand__c = acc.Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        bd = new Brand_Discount__c(Product_Name__c = products[0].Id, Discount_Active__c = true, Discount_Start_DateTime__c = System.now().addDays(-1),Discount_End_DateTime__c  = System.now().addDays(2), Discount_Percentage__c = 10);
        insert bd;
        Contact[] cons = [SELECT Id,AccountId, Name,Primary_Contact__c, Email FROM Contact WHERE Name IN ('Test Contact1','Test Contact2')];
        Account accDT = new Account(Id =cons[0].AccountId, Type='Disty Partner');
        accDT.Platform_Level__c='Basic';
        update accDT;
        cons[0].Email = 'Testcontactat1@filigreencustomer.com';
        cons[0].Primary_Contact__c = true;
        cons[1].Email = 'Testcontactat123@filigreencustomer.com';
        update cons;
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
           p.Hide_From_Marketplace__c =false;
            p.White_Labelled__c =false;
            p.Product_Rating__c = 0;
            p.Unit_Gross_Weight__c =10;
            p.Retail_Unit_Form_Factor__c  ='Jar';
            p.Unit_Radius__c =3;
            p.Unit_Height__c =6;
            p.Family='Marketing Materials';
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
        List<Profile> profiles = [SELECT Id, Name FROM Profile WHERE Name = 'Customer Community Plus User Custom'];
        User u = new User();
        u.ProfileId = profiles[0].Id;
        u.firstName = 'testcontact1';
        u.lastName = 'customeruser';
        u.Username = 'Testcontactat1@filigreencustomer.com.testaccount1';
        u.Email = 'Testcontactat1@filigreencustomer.com';
        u.ContactId = cons[0].Id;
        u.Title = 'Customer';
        u.CommunityNickname = 'ruser';
        u.Alias = 'testser';
        u.TimeZoneSidKey = 'America/Los_Angeles'; // Required
        u.LocaleSidKey = 'en_US'; // Required
        u.EmailEncodingKey = 'ISO-8859-1'; // Required
        u.LanguageLocaleKey = 'en_US'; // Required
        insert u;
        RecordType rt= [SELECT id FROM RecordType WHERE Name='Retailer'];
        Order__c o =new Order__c();
        o.Account__c=acc.id;
        o.Status__c='Approved';
       	o.RecordTypeId =rt.Id;
        o.Order_Date__c=system.today();
        o.State_License__c=licenses[0].id;
        insert o;
        
        Order_Line_Item__c oli =new Order_Line_Item__c();
        oli.Order__c=o.id;
        oli.Ownership_Code__c =acc.id;
        oli.Quantity_Cases__c=1;
        oli.MOQ__c=1;
        oli.UnitPrice__c=3;
        oli.Product__c=products[0].id;
        oli.Price_Book_Entry_Id__c=pbeList[1].id;
        insert oli;
        
       	Inventory_Location__c il =new Inventory_Location__c();
        il.Site_Name__c =s.id;
        il.Name ='stage1';
        il.Include_in_Inventory__c =true;
        insert il;
        Inventory_Position__c ip =new Inventory_Position__c();
        ip.Site__c =s.id;
        ip.Inventory_Location__c = il.id;
        ip.Qty_On_Hand__c=12;
        ip.Hold__c =false;
        ip.Product_Name__c =products[0].id;
        insert ip;
        Factoring_Relationship__c fr =new Factoring_Relationship__c();
        fr.Buyer_Account__c =acc.id;
        fr.Factoring_Assignee__c =acc.Id;
        fr.Seller_Account__c =acc.id;
        insert fr;
        Fulfillment_Rates_Table__c frt =new Fulfillment_Rates_Table__c();
        frt.Active__c =true;
        frt.Fulfillment_Services__c='Pick & Pack';
        frt.Bracket_Cost__c =200;
        frt.Bracket_Mark_Up__c=2;
        frt.Rate_Effective_From__c =system.today();
        frt.Rate_Effective_To__c =system.today();
        frt.Site__c=s.id;
        frt.Membership_Level__c='Standard';
        frt.Weight_lbs__c =12;
        insert frt;
        Test.startTest();
        System.runAs(u){
            
            Boolean isBrand = ProductsCtlr.isBrand;
            AuraResponse r = ProductsCtlr.isCommunityPlusUser();
            Map<String, Object> filters = new Map<String, Object> ();
            filters.put('searchTerm', 'test');
            filters.put('status', 'All');
            //r = RetailDeliveryTicketsCtlr.init(o.id,false,'','','False');
            
            Order_Line_Item__c[] lst = new RetailerOrderEmailTemplateController().getOrderLineItems();
            r = RetailDeliveryTicketsCtlr.getProductsByRetailerId('',false);
            r= RetailDeliveryTicketsCtlr.getSortedRDTLineItems(o.id,filters);
            string prdut =products[0].id;
            r= RetailDeliveryTicketsCtlr.removeProduct(prdut);
            r= RetailDeliveryTicketsCtlr.removeProducts();
            //RetailDeliveryTicketsCtlr.getDistance('Los Angels','New York');
            Utility.getCartTotal();
            Utility.hasAccepted();
            Utility.init();
            //r = RetailDeliveryTicketsCtlr.init(o.id,false,JSON.serialize(retailDeliveryTicket),JSON.serialize(retailDeliveryTicketLineItems),'True');
            //Map<String, Object>  filterNew = new Map<String, Object> {'orderByField' =>'Name', 'isASC' => true,'searchTerm'=>'t','status'=>'Delivered'};
            //r = RetailDeliveryTicketsCtlr.getRetailDeliveryTickets(idList,filterNew); 
            RetailDeliveryTicketsCtlr.deleteOrder(o.id);
            RetailDeliveryTicketsCtlr.getMonthNumber('December');
            RetailDeliveryTicketsCtlr.getMonthNumber('November');
            RetailDeliveryTicketsCtlr.getMonthNumber('October');
            RetailDeliveryTicketsCtlr.getMonthNumber('September');
            RetailDeliveryTicketsCtlr.getMonthNumber('August');
            RetailDeliveryTicketsCtlr.getMonthNumber('July');
            RetailDeliveryTicketsCtlr.getMonthNumber('June');
            RetailDeliveryTicketsCtlr.getMonthNumber('April');
            RetailDeliveryTicketsCtlr.getMonthNumber('March');
            RetailDeliveryTicketsCtlr.getMonthNumber('February');
            RetailDeliveryTicketsCtlr.getMonthNumber('January');
            
        }
    }
}