@IsTest 
public class printColdAccountsCtlrTest {
	@isTest
    private static void runTest(){
        
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
        
        List<Product2> products = [SELECT Id,Most_Popular__c FROM Product2];
        products[0].Most_Popular__c = true;
        products[0].Available_Inventory__c = 200;
        update products[0];
        
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
        
        Contact[] cons = [SELECT Id,AccountId, Name,Primary_Contact__c, Email FROM Contact WHERE Name IN ('Test Contact1','Test Contact2')];
        cons[0].Email = 'Testcontactat1@filigreencustomer.com';
        cons[0].Primary_Contact__c = true;
        cons[1].Email = 'Testcontactat123@filigreencustomer.com';
        update cons;
        
        Id pricebookId = Test.getStandardPricebookId();
        List<PricebookEntry> pbeList = new List<PricebookEntry>();
        Map<String,PriceBookEntry> pbeMap = new Map<String,PriceBookEntry>();
        for(PriceBookEntry pbe: [SELECT Id, PriceBook2Id, Product2Id FROM PriceBookEntry]){
            pbeMap.put(pbe.PriceBook2Id+'-'+pbe.Product2Id,pbe);
        }       
        
        for(Product2 p: products){
            p.MOQ__c = 1;
            p.Available_Inventory__c = 100;
            p.Producer_Name__c = acc.Id;
            p.Product_Rating__c = 0;
            p.Unit_Gross_Weight__c =10;
            p.Retail_Unit_Form_Factor__c  ='Jar';
            p.Unit_Radius__c =3;
            p.Unit_Height__c =6;
            p.White_Labelled__c = false;
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
        
        list<Order__c>orderList = new list<Order__c>();
        RecordType rt= [SELECT id FROM RecordType WHERE Name='Retailer'];
        Order__c o =new Order__c();
        o.Account__c=accs[0].id;
        o.Status__c='Shipped';
       	o.RecordTypeId =rt.Id;
        o.Order_Date__c=system.today();
        o.State_License__c=licenses[0].id;
        o.Retailer__c = accs[0].id;
        o.Order_Date__c = system.today();
        orderList.add(o);
        
        Order__c o1 =new Order__c();
        o1.Account__c=accs[0].id;
        o1.Status__c='Shipped';
        o1.RecordTypeId =rt.Id;
        o1.Order_Date__c=system.today().addMonths(-4);
        o1.State_License__c=licenses[0].id;
        o1.Retailer__c = accs[1].id;
        orderList.add(o1);
        
        insert orderList;
        
        list<Order_Line_Item__c>orderLineList = new list<Order_Line_Item__c>();
        Order_Line_Item__c oli =new Order_Line_Item__c();
        oli.Order__c=o.id;
        oli.Ownership_Code__c =acc.id;
        oli.Quantity_Cases__c=1;
        oli.MOQ__c=1;
        oli.UnitPrice__c=3;
        oli.Product__c=products[0].id;
        oli.Price_Book_Entry_Id__c=pbeList[1].id;
        orderLineList.add(oli);
        
        Order_Line_Item__c oli1 =new Order_Line_Item__c();
        oli1.Order__c=o1.id;
        oli1.Ownership_Code__c =acc.id;
        oli1.Quantity_Cases__c=1;
        oli1.MOQ__c=1;
        oli1.UnitPrice__c=3;
        oli1.Product__c=products[0].id;
        oli1.Price_Book_Entry_Id__c=pbeList[1].id;
        orderLineList.add(oli1);
        
        insert orderLineList;
        
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
        
        test.startTest();
        
        	
            
            
        
            System.runAs(u){
                String filter = '{ "orderByField": "Name", "isASC": false }';
                ApexPages.currentPage().getParameters().put('filters', filter);
                printColdAccountsCtlr printColdAccount = new printColdAccountsCtlr();
            }
        test.stopTest();
        
    }
}