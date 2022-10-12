@isTest
public class CalculateManifestMilesTest{
    @TestSetup
    static void setup(){
        TestUtilData.createTestData();
        Sales_Order__c salesObj = [SELECT Id,Brand_Quote__c,Planned_Ship_Date__c ,Distributor_Contact__c,Distributor_License__c,Distributor_Name__c,Opportunity_Name__c,Payment_Terms__c,Receiver_Contact__c,Receiver_License__c,Receiver_Name__c,Sample_Order__c,Shipping_Method__c ,Shipping_Terms__c  ,Site__c,Supplier_Contact__c,Supplier_License__c,Supplier_Name__c FROM Sales_Order__c LIMIT 1];
        TestUtilData.createTSM(salesObj,true);
    }
    private testMethod static void updateMilesManifestChnage() {
        Test.setMock(HttpCalloutMock.class, new CalculateManifestMilesMockResponse());
        Account acc = [SELECT Id FROM Account limit 1];
        State_Licenses__c license = [SELECT Id FROM State_Licenses__c WHERE License_Name__c =:acc.Id limit 1];
        Shipping_Manifest__c manifest = [SELECT Id,Total_Route_Miles__c FROM Shipping_Manifest__c LIMIT 1];
        
        System.assertEquals(null, manifest.Total_Route_Miles__c);
        
        manifest.Receiver_Name__c  = acc.Id; //filter on Receiver name Lookup
        manifest.Supplier_License__c = license.Id;
        manifest.Receiver_License__c  = license.Id;
        //manifest.Distributor_License__c = license.Id;
        update manifest;
        Test.startTest();
        List<Shipping_Manifest__c> records = [SELECT Id,recordType.DeveloperName, Geocode_Error__c ,Total_Route_Miles__c ,
                                              Distributor_Address__c,
                                              Distributor_City_State_Zip__c,
                                              Receiver_Address__c ,Receiver_City_State_Zip__c,
                                              Supplier_Address__c, Supplier_City_State_Zip__c,
                                              Distributor_License__c ,
                                              Receiver_License__c ,
                                              Supplier_License__c 
                                              
                                              FROM Shipping_Manifest__c WHERE Id =: manifest.Id];
        Database.executeBatch(new CalculateManifestMilesBtch(records), 1);
        Test.stopTest();
        
    } 
    
    private testMethod static void updateMilesLicenseChnage() {
        Test.setMock(HttpCalloutMock.class, new CalculateManifestMilesMockResponse());
        Account acc = [SELECT Id FROM Account limit 1];
        State_Licenses__c license = [SELECT Id,License_City__c FROM State_Licenses__c WHERE License_Name__c =:acc.Id LIMIT 1];
        Shipping_Manifest__c manifest = [SELECT Id,Total_Route_Miles__c FROM Shipping_Manifest__c LIMIT 1];
        
        System.assertEquals(null, manifest.Total_Route_Miles__c);
        
        manifest.Receiver_Name__c  = acc.Id; //filter on Receiver name Lookup
        manifest.Supplier_License__c = license.Id;
        manifest.Receiver_License__c  = license.Id;
        update manifest;
        license.License_City__c = 'Adelanto';
        update license;        
        Test.startTest();
        List<sObject> manifests = [SELECT Id, recordType.DeveloperName,Total_Route_Miles__c ,Geocode_Error__c ,Distributor_Address__c,
                                   Distributor_City_State_Zip__c,
                                   Receiver_Address__c ,Receiver_City_State_Zip__c,
                                   Supplier_Address__c, Supplier_City_State_Zip__c
                                   FROM Shipping_Manifest__c
                                   WHERE Supplier_License__c =:license.Id OR Distributor_License__c =: license.Id OR Receiver_License__c =: license.Id];
        Database.executeBatch(new CalculateManifestMilesBtch(manifests), 1);
        Test.stopTest();
        
    } 
    
    private testMethod static void insertManifest() {
        Test.setMock(HttpCalloutMock.class, new CalculateManifestMilesMockResponse());
        Account acc = [SELECT Id FROM Account limit 1];
        State_Licenses__c license = [SELECT Id,License_City__c FROM State_Licenses__c WHERE License_Name__c =:acc.Id LIMIT 1];
        Sales_Order__c salesObj = [SELECT Id,Brand_Quote__c,Planned_Ship_Date__c ,Distributor_Contact__c,Distributor_License__c,Distributor_Name__c,Opportunity_Name__c,Payment_Terms__c,Receiver_Contact__c,Receiver_License__c,Receiver_Name__c,Sample_Order__c,Shipping_Method__c ,Shipping_Terms__c  ,Site__c,Supplier_Contact__c,Supplier_License__c,Supplier_Name__c FROM Sales_Order__c LIMIT 1];
        Shipping_Manifest__c manifest = TestUtilData.createTSM(salesObj,false);
        
        System.assertEquals(null, manifest.Total_Route_Miles__c);
        
        manifest.Receiver_Name__c  = acc.Id; //filter on Receiver name Lookup
        manifest.Supplier_License__c = license.Id;
        manifest.Receiver_License__c  = license.Id;
        insert manifest;
        Test.startTest();

        List<Shipping_Manifest__c> records = [SELECT Id,recordType.DeveloperName, Geocode_Error__c ,Total_Route_Miles__c ,
                                              Distributor_Address__c,
                                              Distributor_City_State_Zip__c,
                                              Receiver_Address__c ,Receiver_City_State_Zip__c,
                                              Supplier_Address__c, Supplier_City_State_Zip__c,
                                              Distributor_License__c ,
                                              Receiver_License__c ,
                                              Supplier_License__c 
                                              
                                              FROM Shipping_Manifest__c WHERE Id =: manifest.Id];
        Database.executeBatch(new CalculateManifestMilesBtch(records), 1);
        Test.stopTest();
        
   } 
    
   private testMethod static void updateMilesManifestDChnage() {
       Test.setMock(HttpCalloutMock.class, new CalculateManifestMilesMockResponse());
       Account acc = [SELECT Id FROM Account limit 1];
       Account acc1 = [SELECT Id FROM Account WHERE Id !=:acc.Id limit 1];
       System.debug(acc +':::'+acc1);
       State_Licenses__c license = [SELECT Id FROM State_Licenses__c WHERE License_Name__c =:acc.Id limit 1];
       State_Licenses__c license1 = [SELECT Id, License_Name__c  FROM State_Licenses__c WHERE License_Name__c =:acc1.Id limit 1];

       license1.License_Name__c =acc1.Id;
       update license1;
       license1 = [SELECT Id, License_Name__c  FROM State_Licenses__c WHERE License_Name__c =:acc1.Id limit 1];
       Sales_Order__c salesObj = [SELECT Id,Brand_Quote__c,Planned_Ship_Date__c ,Distributor_Contact__c,Distributor_License__c,Distributor_Name__c,Opportunity_Name__c,Payment_Terms__c,Receiver_Contact__c,Receiver_License__c,Receiver_Name__c,Sample_Order__c,Shipping_Method__c ,Shipping_Terms__c  ,Site__c,Supplier_Contact__c,Supplier_License__c,Supplier_Name__c FROM Sales_Order__c LIMIT 1];
       Shipping_Manifest__c manifest = TestUtilData.createTSM(salesObj,false);
        
        System.assertEquals(null, manifest.Total_Route_Miles__c);
        
       manifest.Receiver_Name__c  = acc.Id; //filter on Receiver name Lookup
       //manifest.Supplier_License__c = license.Id;
       manifest.Receiver_License__c  = license.Id;
       insert manifest;     
       CheckManifestRecursion.run = true;
       manifest.Supplier_License__c = license1.Id;
       manifest.Supplier_Name__c = acc1.Id;
       update manifest;
       
       Test.startTest();
       List<Shipping_Manifest__c> records = [SELECT Id,recordType.DeveloperName, Geocode_Error__c ,Total_Route_Miles__c ,
                                              Distributor_Address__c,
                                              Distributor_City_State_Zip__c,
                                              Receiver_Address__c ,Receiver_City_State_Zip__c,
                                              Supplier_Address__c, Supplier_City_State_Zip__c,
                                              Distributor_License__c ,
                                              Receiver_License__c ,
                                              Supplier_License__c 
                                              
                                              FROM Shipping_Manifest__c WHERE Id =: manifest.Id];
        Database.executeBatch(new CalculateManifestMilesBtch(records), 1); 
       
       Test.stopTest();
       
    } 
    
    private testMethod static void updateMilesManifestDistributorChnage() {
       Test.setMock(HttpCalloutMock.class, new CalculateManifestMilesMockResponse());
       Account acc = [SELECT Id FROM Account limit 1];
       Account acc1 = [SELECT Id FROM Account WHERE Id !=:acc.Id limit 1];
       System.debug(acc +':::'+acc1);
       State_Licenses__c license = [SELECT Id FROM State_Licenses__c WHERE License_Name__c =:acc.Id limit 1];
       State_Licenses__c license1 = [SELECT Id, License_Name__c  FROM State_Licenses__c WHERE License_Name__c =:acc1.Id limit 1];

       license1.License_Name__c =acc1.Id;
       update license1;
       license1 = [SELECT Id, License_Name__c  FROM State_Licenses__c WHERE License_Name__c =:acc1.Id limit 1];
       Sales_Order__c salesObj = [SELECT Id,Brand_Quote__c,Planned_Ship_Date__c ,Distributor_Contact__c,Distributor_License__c,Distributor_Name__c,Opportunity_Name__c,Payment_Terms__c,Receiver_Contact__c,Receiver_License__c,Receiver_Name__c,Sample_Order__c,Shipping_Method__c ,Shipping_Terms__c  ,Site__c,Supplier_Contact__c,Supplier_License__c,Supplier_Name__c FROM Sales_Order__c LIMIT 1];
       Shipping_Manifest__c manifest = TestUtilData.createTSM(salesObj,false);
        
        System.assertEquals(null, manifest.Total_Route_Miles__c);
        
       manifest.Receiver_Name__c  = acc.Id; //filter on Receiver name Lookup
       //manifest.Supplier_License__c = license.Id;
       manifest.Receiver_License__c  = license.Id;
       insert manifest;     
       CheckManifestRecursion.run = true;
       manifest.Distributor_License__c = license1.Id;
       manifest.Distributor_Name__c = acc1.Id;
       update manifest;
       
       Test.startTest();
       List<Shipping_Manifest__c> records = [SELECT Id,recordType.DeveloperName, Geocode_Error__c ,Total_Route_Miles__c ,
                                              Distributor_Address__c,
                                              Distributor_City_State_Zip__c,
                                              Receiver_Address__c ,Receiver_City_State_Zip__c,
                                              Supplier_Address__c, Supplier_City_State_Zip__c,
                                              Distributor_License__c ,
                                              Receiver_License__c ,
                                              Supplier_License__c 
                                              
                                              FROM Shipping_Manifest__c WHERE Id =: manifest.Id];
        Database.executeBatch(new CalculateManifestMilesBtch(records), 1); 
       
       Test.stopTest();
       
    } 
    
}