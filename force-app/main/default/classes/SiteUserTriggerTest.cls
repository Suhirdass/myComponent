@isTest
public class SiteUserTriggerTest {
    private static testmethod void runTest(){
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hide_from_Marketplace__c = false;
        insert objAccount; 
        State_Licenses__c objStateLicenses = new State_Licenses__c();
        objStateLicenses.License_Name__c = objAccount.id;
        objStateLicenses.License_Number__c = 'AbcTest12345';
        objStateLicenses.License_Status__c ='Active';
        objStateLicenses.License_Type__c ='Type 1';
        objStateLicenses.License_Class__c='A-License';
        objStateLicenses.License_State__c = 'California';
        objStateLicenses.License_City__c = 'San Francisco';
        objStateLicenses.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses.License_Zip__c = '94124';
        objStateLicenses.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        insert objStateLicenses;
        
        State_Licenses__c objStateLicenses1 = new State_Licenses__c();
        objStateLicenses1.License_Name__c = objAccount.id;
        objStateLicenses1.License_Number__c = 'AbcTest12356';
        objStateLicenses1.License_Status__c ='Active';
        objStateLicenses1.License_Type__c ='Type 1';
        objStateLicenses1.License_Class__c='A-License';
        objStateLicenses1.License_State__c = 'California';
        objStateLicenses1.License_City__c = 'San Francisco';
        objStateLicenses1.License_Address__c = '2089 Ingalls St. Unit 3';
        objStateLicenses1.License_Zip__c = '94124';
        objStateLicenses1.License_Expiration_Date__c = date.valueof(system.now()) + 10;
        insert objStateLicenses1;
        // Create Site
        Site__c[] sites = new Site__c[]{};
        Site__c objSite = new Site__c();
        objSite.Name = 'Test Site';
        objSite.License_ID__c = objStateLicenses.Id;
        sites.add(objSite);
        Site__c objSite1 = new Site__c();
        objSite1.Name = 'Test Site2';
        objSite1.License_ID__c = objStateLicenses1.Id;
        sites.add(objSite1);
        insert sites;
        
        Test.startTest();
        Site_User__c su = new Site_User__c(Site__c = objSite.Id,User__c = UserInfo.getUserId(),Active__c = true);
        insert su;
        su.Active__c = false;
        update su;
        su.Active__c = true;
        update su;
        delete su;
    }
}