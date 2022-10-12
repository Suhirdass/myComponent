@isTest(SeeAllData=false)
public class Metrc_UID_Test {

    static final String testEmail = 'tuser3@testMetrc.com';
        //Static final String emailId='%'+testEmail+'%';
    
    @testSetup static void setTestData(){
        
        Id profId= [select id from Profile where name='System Administrator' limit 1].Id; 
        User testUser=Metrc_TestdataFactory.createUser(testEmail+System.currentTimeMillis(),profId,testEmail);
        Database.insert(testUser);
                            
       //PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'ABI_POCU_GCC_CMD' limit 1];
       //database.insert (new PermissionSetAssignment(AssigneeId = tuser.id, PermissionSetId = perms.Id ));
        List<Metrc_IntegrationSettings__C> customsettingList =Metrc_TestdataFactory.createIntegrationSettingData();
        Insert customsettingList;
        
        UID__c  uid   = new UID__c();
        uid.Name ='1A4FF0300000029000000083';
        uid.Available_Qty_in_METRC__c = 0;
        uid.Available_Qty__c = 0;
        uid.Received_Qty__c = 7;
        uid.Active__c = true;
        uid.METRC_Status__c='Unfinished';
        //uid.Finished_date__c=null;
        insert uid;
        
        
    }
    

    static testMethod void getSinglePackage_httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        system.runAs(user1){
            Test.startTest();
             //Test.setMock(HttpCalloutMock.class, new Metrc_MockProductHttpResponseTest());
            Test.setMock(HttpCalloutMock.class, new Metrc_MockUIDHttpRespTest());
            Map<String,Object> respMap = new  Map<String,Object>();
            UID__c uid =[select ID,name from UID__c limit 1];
            String a  =uid.Name;
       		Metrc_HttpCalloutHelper.getSinglePackage(a);
            Test.stopTest();
            
        }
    }
    
     static testMethod void createPackageFinish_httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        system.runAs(user1){
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new Metrc_MockUIDHttpRespTest());
            Map<String,Object> respMap = new  Map<String,Object>();
            UID__c uid =[select ID,name from UID__c limit 1];
            DateTime actualDate = Datetime.now();
            String dateOutput = actualDate.format('yyyy-MM-dd');
       		Metrc_HttpCalloutHelper.createPackageFinish(uid.Name, dateOutput);
            Test.stopTest();
            
        }
    }
    
     static testMethod void BatchPackageFinishFinish_httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username like'%tuser3@testMetrc.com%' limit 1];
        system.runAs(user1){
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new Metrc_MockUIDHttpRespTest());
            Map<String,Object> respMap = new  Map<String,Object>();
            UID__c  uid1   = new UID__c();
            uid1.Name ='1A4FF0300000029000000085';
            uid1.Available_Qty_in_METRC__c = 0;
            uid1.Available_Qty__c = 0;
            uid1.Received_Qty__c = 7;
            uid1.Active__c = true;
            uid1.METRC_Status__c='Unfinished';
            insert uid1;
            List<UID__c> uidlist = [select ID,name from UID__c];
            system.debug('uidlist'+uidlist);
            DateTime actualDate = Datetime.now();
            String dateOutput = actualDate.format('yyyy-MM-dd');
       		//Metrc_HttpCalloutHelper.BatchPackageFinish(uidlist, 10, 20);
       
             
            Test.stopTest();
            
        }
    }
        
     
    }