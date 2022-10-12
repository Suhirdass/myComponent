@isTest
public class StateLicenseTotalMilesTriggerTest {
    private static testmethod void runTest(){
        Test.setMock(HttpCalloutMock.class, new StateLicense_MockResponseTest());     
        Google_Distance_Matrix_API__c[] GDMIs = new Google_Distance_Matrix_API__c[]{new Google_Distance_Matrix_API__c(Name='GMaps_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/distancematrix/json?'),new Google_Distance_Matrix_API__c(Name='Gmaps_APIKey',Value__c = 'gjhghj3232342jkhj'),new Google_Distance_Matrix_API__c(Name='Geocode_Endpoint',Value__c = 'https://maps.googleapis.com/maps/api/geocode/json?')};
        insert GDMIs;
         Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        insert objAccount;
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.Warehouse_Name__c='TestWarehouse1';
        objSite.Active__c = true;
        insert objSite;
        List<State_Licenses__c> licenses = new List<State_Licenses__c>();
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
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
        insert objStateLicenses;
        objSite.License_ID__c = objStateLicenses.Id;
        update objSite;
        State_Licenses__c objStateLicenses1 = new State_Licenses__c();
        objStateLicenses1.License_Name__c = objAccount.id;
        objStateLicenses1.License_Number__c = 'AbcTest123456';
        objStateLicenses1.License_Status__c ='Active';
        objStateLicenses1.License_Type__c ='Type 1';
        objStateLicenses1.Default_Warehouse__c = objSite.Id;
        objStateLicenses1.License_Class__c='A-License';
        objStateLicenses1.License_State__c = 'California';
        objStateLicenses1.License_City__c = 'San Francisco';
        objStateLicenses1.License_Address__c = '375 Potrero Avenue, #5B';
        objStateLicenses1.License_Zip__c = '94103';
        objStateLicenses1.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        insert objStateLicenses1;
        objStateLicenses1.License_Address__c = '375 Potrero Avenue, #5C';
        update objStateLicenses1;
    }
}