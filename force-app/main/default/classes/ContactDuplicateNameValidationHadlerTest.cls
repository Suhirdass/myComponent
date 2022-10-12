@istest
public class ContactDuplicateNameValidationHadlerTest {
static testMethod void theTests(){
    Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hold__c=true;
        objAccount.DBA__c='Test Account1';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Membership_Level__c = 'Boutique';
        objAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
    insert objAccount;
    List<contact>lstcon = new list<contact>();
     map<id,contact>lstconmap = new map<id,contact>();
    contact con = new contact();
    con.FirstName='contest';
    con.LastName='lasttest';
    con.Email='test@gmail.com';
    con.AccountId=objAccount.Id;
    insert con;
    lstcon.add(con);
      contact con2 = new contact();
    con2.FirstName='contest23';
    con2.LastName='lasttest2';
    con2.Email='test@gmail.com21';
    con2.AccountId=objAccount.Id;
    insert con2;
    lstconmap.put(con2.id,con2);
   // ContactDuplicateNameValidationHadler.beforeupdate(lstcon,lstconmap);
}
static testMethod void theTestsupdate(){
    Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        objAccount.Hold__c=true;
        objAccount.DBA__c='Test Account1';
        objAccount.Hide_from_Marketplace__c = false;
        objAccount.Membership_Level__c = 'Boutique';
        objAccount.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get('Brand').getRecordTypeId();
    insert objAccount;
    List<contact>lstcon = new list<contact>();
     map<id,contact>lstconmap = new map<id,contact>();
    contact con = new contact();
    con.FirstName='contest';
    con.LastName='lasttest';
    con.Email='test@gmail.com';
    con.AccountId=objAccount.Id;
    insert con;
    lstcon.add(con);
      contact con2 = new contact();
    con2.FirstName='contest23';
    con2.LastName='lasttest2';
    con2.Email='test@gmail.com21';
    con2.AccountId=objAccount.Id;
    insert con2;
    lstconmap.put(con2.id,con2);
      Test.startTest();
        try{
            con2.FirstName = 'product 1';
            update con2;
          //  System.assert(false);
        }catch(Exception ex){
          
        }
        Test.stopTest();
   // ContactDuplicateNameValidationHadler.beforeupdate(lstcon,lstconmap);
}
}