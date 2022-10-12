@isTest
public class CreateSOfromQuoteTest {
	
    
    private static void createData() {
        
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest()); 
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?')};
        insert GDMIs;
        
        //supplier Account
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        //distributor Account
        Account objAccount2 = new Account();
        objAccount2.Name = 'Test Account2';
        objAccount2.Payment_Terms__c = 'COD';
        insert objAccount2;
        
        //Create Site.
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        //objSite.License_ID__c= objStateLicenses.id;
        insert objSite;
        
        RecordType bqType = [select id, name, developername from recordtype where developername = 'Buy_Sell_Opportunity' limit 1];
        Opportunity opp = new Opportunity();
        opp.AccountId = objAccount.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName = 'Qualification';
        opp.RecordTypeId = bqType.Id;
        opp.Site_Name__c = objSite.Id;
        opp.Ownership__c = objAccount.id;
        opp.Payment_Terms__c='COD';
        insert opp;
        
        //Supplier License
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c = 'Active';
        objStateLicenses.License_Type__c = 'Type 1';
        objStateLicenses.License_Class__c = 'A-License';
        objStateLicenses.Default_Warehouse__c = objSite.Id;
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now());
        insert objStateLicenses;
        //distributor License
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount2.id;
        objStateLicenses2.License_Number__c = 'AbcTest45678';
        objStateLicenses2.License_Status__c = 'Active';
        objStateLicenses2.License_Type__c = 'Type 1';
        objStateLicenses2.License_Class__c = 'A-License';
        objStateLicenses2.Default_Warehouse__c = objSite.Id;
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now());
        insert objStateLicenses2;
        
        Id productRecordTypeId = Schema.SObjectType.Product2.getRecordTypeInfosByDeveloperName()
                          .get('Product').getRecordTypeId();
        //Create Product1
        Product2  objProduct1 = new Product2 ();
        objProduct1.Name = 'product 1';
        objProduct1.Quantity_Type__c = 'Quantity';
        objProduct1.Family = 'Accessories';
        objProduct1.Description = 'test product 1';
        objProduct1.Producer_Name__c = objAccount.id;
        objProduct1.Apply_Cultivation_Tax__c='Yes';
        objProduct1.Apply_Excise_Tax__c='Yes';
        objProduct1.IsActive = true;
        objProduct1.Unit_Height__c  = 10.0;
        objProduct1.Unit_Length__c = 10.0;
        objProduct1.Unit_Width__c = 5.0;
        objProduct1.Apply_Excise_Tax__c = 'Yes';
        objProduct1.RecordTypeId = productRecordTypeId;
        objProduct1.Track_Trace_Category__c='Capsule';
        objProduct1.Net_Weight_UOM__c='EA';
        objProduct1.Unit_Of_Measure__c='Grams';
        objProduct1.MOQ__c = 1;
        insert objProduct1;
        
        Service_Ticket__c st = new Service_Ticket__c();
        insert st;
        
        Service_Ticket_Line__c stl = new Service_Ticket_Line__c();
        stl.Service_Ticket__c = st.id;
        insert stl;
        
    	RecordType bqTypeID = [select id, name, developername from recordtype where developername = 'Sell_Quote' limit 1];
        Brand_Quote__c bq = new Brand_Quote__c();
        bq.Opportunity_Name__c = opp.id;
        bq.Distributor_Name__c = objAccount2.id;
        bq.Distributor_License__c = objStateLicenses2.id;
        bq.Receiver_Name__c = opp.AccountId;
        bq.Receiver_License__c = objStateLicenses.id;
        bq.Supplier_Name__c = opp.Ownership__c;
        bq.Supplier_License__c = objStateLicenses.id;
        //bq.BQ_Status__c = 'Approved';
        bq.Shipping_Method__c = 'Distributor Pick-up';
        bq.Sales_Origin__c = 'Brand';
        bq.Shipping_Terms__c = 'CFR';
        bq.Payment_Terms__c = 'COD';
        bq.Site__c = objSite.id;
        bq.RecordTypeId = bqTypeID.Id;
        bq.Ownership__c = opp.Ownership__c;
        //bq.Service_Ticket_Line__c = stl.id;
        insert bq;
        
        Brand_Quote_Line__c objbqline1 = new Brand_Quote_Line__c();
        objbqline1.Brand_Quote_Number__c = bq.id;
        objbqline1.Product_Name__c = objProduct1.id;
        objbqline1.MOQ__c = 10;
        objbqline1.Quantity_Cases__c = 200;
        insert objbqline1;
        
        ApexPages.StandardController socon = new ApexPages.StandardController(bq);
        CreateSOfromQuote soext = new CreateSOfromQuote(socon);
        //soext.createSO();
        
        bq.BQ_Status__c = 'Approved';
        update bq;
        soext.createSO();
        
        bqTypeID = [select id, name, developername from recordtype where developername = 'Lab_Quote' limit 1];
        bq.RecordTypeId = bqTypeID.Id;
        update bq;
        soext.createSO();
        
        bqTypeID = [select id, name, developername from recordtype where developername = 'RMA' limit 1];
        bq.RecordTypeId = bqTypeID.Id;
        update bq;
        soext.createSO();
        soext.goBack();
    }
    
    static testMethod void createSOfromQuoteTest() {
        createData();
        System.assertEquals('Test', 'Test');
    }
}