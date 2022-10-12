/**************************************************************************************
Apex Class Name    : BrandQuoteTriggerHelperTest
Test Class for     :BrandQuoteTriggerHelper
Version            : 1.0
Created Date       : Aug 28 2018
Function           : Used for BrandQuoteTrigger 
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresh                  09/07/2018                 Original Version
*******************************************************************************/
@istest
private class BrandQuoteTriggerHelperTest{
    
    @isTest
    static void theTests(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
            insert GDMIs;
        // supplier Account
        List<Account> accounts = new List<Account>();
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        accounts.add(objAccount);   
        
        // distributor Account
        Account objAccount2 = new Account();
        objAccount2.Name = 'Test Account2';
        objAccount2.Payment_Terms__c = 'COD';
        //objAccount2.RecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get('Supplier').getRecordTypeId();
        accounts.add(objAccount2);  
        
        // receiver Account
        Account objAccount3 = new Account();
        objAccount3.Name = 'Test Account3';
        objAccount3.Payment_Terms__c = 'COD';
        accounts.add(objAccount3);
        
        insert accounts;
        // Create Site
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        insert objSite;
        // Create State License
        Test.setMock(HttpCalloutMock.class, new Miles_Mock());  
        // Supplier License
        List<State_Licenses__c> licenses = new List<State_Licenses__c>();
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses.Default_Warehouse__c = objSite.Id;
        licenses.add(objStateLicenses);
        
        // distributor License
        State_Licenses__c objStateLicenses2 = new State_Licenses__c();
        objStateLicenses2.License_Name__c = objAccount2.id;
        objStateLicenses2.License_Number__c = 'AbcTest45678';
        objStateLicenses2.License_Status__c ='Active';
        objStateLicenses2.License_Type__c ='Type 1';
        objStateLicenses2.License_Class__c='A-License';
        objStateLicenses2.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses2.Default_Warehouse__c = objSite.Id;
        licenses.add(objStateLicenses2); 
        
        // receiver License
        State_Licenses__c objStateLicenses3 = new State_Licenses__c();
        objStateLicenses3.License_Name__c = objAccount3.id;
        objStateLicenses3.License_Number__c = 'AbcTest54321';
        objStateLicenses3.License_Status__c ='Active';
        objStateLicenses3.License_Type__c ='Type 1';
        objStateLicenses3.License_Class__c='A-License';
        objStateLicenses3.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        objStateLicenses3.Default_Warehouse__c = objSite.Id;
        licenses.add(objStateLicenses3);
        
        // receiver License
        State_Licenses__c objStateLicenses4 = new State_Licenses__c();
        objStateLicenses4.License_Name__c = objAccount3.id;
        objStateLicenses4.License_Number__c = 'AbcTest54321456';
        objStateLicenses4.License_Status__c ='Active';
        objStateLicenses4.License_Type__c ='Type 1';
        objStateLicenses4.License_Class__c='A-License';
        objStateLicenses4.License_Expiration_Date__c = date.valueof(system.now()) - 10;
        objStateLicenses4.Default_Warehouse__c = objSite.Id;
        licenses.add(objStateLicenses4);
        
        insert licenses;
        
        
        
        // Create opportunity
        Opportunity opp = new Opportunity();
        opp.AccountId = objAccount.Id;
        opp.Name = 'Test Opp';
        opp.Sales_Origin__c = 'Brand';
        opp.Type = 'New Business';
        opp.CloseDate = Date.today().addDays(5);
        opp.StageName ='Qualification';
        opp.Site_Name__c = objSite.Id;
        opp.Ownership__c = objAccount.id;
        opp.Payment_Terms__c = 'COD';
        insert opp;
        
        Line_Card__c l= new Line_Card__c();
        l.Brand_Name__c=objAccount.id;
        l.Retailer_Name__c=objAccount3.id;
        l.Mutual_Payment_Terms__c='COD';
        insert l;
        
        Shipping_Rates_Table__c[] sRates = new Shipping_Rates_Table__c[]{};
        Shipping_Rates_Table__c  shipRateTable = new Shipping_Rates_Table__c();
        shipRateTable.Active__c = true;
        shipRateTable.Site__c = objSite.Id;
        shipRateTable.Rate_Effective_From__c = Date.Today().addDays(-3);
        shipRateTable.Rate_Effective_To__c = Date.Today().addDays(3);
        shipRateTable.Mileage_Bracket__c = 100;
        shipRateTable.Weight_Bracket__c = 100;
        shipRateTable.Weight_Bracket_Cost__c = 0.60;
        shipRateTable.Mileage_Bracket_Cost__c = 0.40;
        shipRateTable.Weight_Bracket_Mark_Up__c = 100;
        shipRateTable.Mileage_Bracket_Mark_Up__c = 60;
        shipRateTable.Membership_Level__c = 'Boutique';
        sRates.add(shipRateTable);
        shipRateTable = new Shipping_Rates_Table__c();
        shipRateTable.Active__c = true;
        shipRateTable.Site__c = objSite.Id;
        shipRateTable.Rate_Effective_From__c = Date.Today().addDays(-3);
        shipRateTable.Rate_Effective_To__c = Date.Today().addDays(3);
        shipRateTable.Mileage_Bracket__c = 100;
        shipRateTable.Weight_Bracket__c = 100;
        shipRateTable.Weight_Bracket_Cost__c = 0.60;
        shipRateTable.Mileage_Bracket_Cost__c = 0.40;
        shipRateTable.Weight_Bracket_Mark_Up__c = 100;
        shipRateTable.Mileage_Bracket_Mark_Up__c = 60;
        shipRateTable.Membership_Level__c = 'Retail';
        sRates.add(shipRateTable);
        insert sRates;
        
        
        // Create brand quote
        Brand_Quote__c bq = new Brand_Quote__c ();
        bq.Opportunity_Name__c = opp.id; 
        bq.Supplier_Name__c = objAccount.id;
        bq.Supplier_License__c = objStateLicenses.id;
        bq.Distributor_Name__c = objAccount2.id;
        bq.Distributor_License__c = objStateLicenses2.id;
        bq.Receiver_Name__c = objAccount3.id;
        bq.Receiver_License__c = objStateLicenses3.id;
        bq.BQ_Status__c = 'Draft';
        bq.Shipping_Method__c = 'Distributor Pick-up';
        bq.Sales_Origin__c = 'Brand';
        bq.Shipping_Terms__c = 'CFR';        
        bq.Site__c = objSite.id;
        bq.Ownership__c = opp.Ownership__c;
        bq.Payment_Terms__c = opp.Payment_Terms__c;
        insert bq;
        bq.Payment_Terms__c = NULL;
        BrandQuoteTriggerHelper.isBQTriggerExecuted = false;
        //Brand_Quote__c [] bq1 = [select ]
        bq.Receiver_Acceptance_Date__c = DateTime.newInstance(2019, 1, 1, 5, 0, 0);
        update bq;
        //Map<Id,Brand_Quote__c[]> receiverLicenseBQMap = new Map<Id,Brand_Quote__c[]>();
        //receiverLicenseBQMap.put(bq.Receiver_License__c, bq);
        State_Licenses__c[] receivingLicenses = [SELECT Id,Default_Warehouse__c  FROM State_Licenses__c WHERE Id =:bq.Receiver_License__c];
        Shipping_Rates_Table__c [] mileageSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                                     Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                     FROM Shipping_Rates_Table__c 
                                                     WHERE Site__c = :bq.Site__c
                                                     AND Active__c = true
                                                     AND Rate_Effective_From__c <= :System.today()
                                                     AND Rate_Effective_To__c >= :System.today()
                                                     AND Membership_Level__c = :bq.Ownership__r.Membership_Level__c
                                                     Order By Mileage_Bracket__c];
        Test.setMock(HttpCalloutMock.class, new Miles_Mock()); 
        BrandQuoteTriggerHelper.calculateMiles(bq.Id, bq.Supplier_License__c, bq.Receiver_License__c);
    }
    
}