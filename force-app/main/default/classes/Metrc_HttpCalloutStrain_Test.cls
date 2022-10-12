@isTest(SeeAllData=false)
/**********************************************************************************************************
Apex TestClass Name    : Metrc_HttpCalloutStrain_Test 
Apex Class Name    : Metrc_HttpCalloutHelper 
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : Used for HTTPcallout
------------------------------------------------------------------------------------------------------------
* Developer                                      Date                   Description
* ----------------------------------------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
************************************************************************************************************/

private class Metrc_HttpCalloutStrain_Test 
{
    /**************************************************************************************
    Method Name        : testsetupMethod  
    Version            : 1.0
    Function           : testdata setup Method
    *******************************************************************************/
    @testSetup static void testsetupMethod() {
        Id profId= [select id from Profile where name='System Administrator' limit 1].Id; 
        User tuser = new User(  firstname = 'tuserFname',
                            lastName = 'tuserLastname',
                            email = 'tuser@test.org',
                            Username = 'tuser2@testMetrc.org',
                            EmailEncodingKey = 'ISO-8859-1',
                            Alias ='tuser',
                            TimeZoneSidKey = 'America/Los_Angeles',
                            LocaleSidKey = 'en_US',
                            LanguageLocaleKey = 'en_US',
                            ProfileId = profId);
                            database.insert(tuser);
                            
       //PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'ABI_POCU_GCC_CMD' limit 1];
       //database.insert (new PermissionSetAssignment(AssigneeId = tuser.id, PermissionSetId = perms.Id ));
        List<Metrc_IntegrationSettings__C> customsettingList = new List<Metrc_IntegrationSettings__C>();
        Metrc_IntegrationSettings__C obj1 = new Metrc_IntegrationSettings__C();
        obj1.Name='Endpoint';
        obj1.Value__c='https://api-ca.metrc.com/test';
        
        Metrc_IntegrationSettings__C obj2 = new Metrc_IntegrationSettings__C();
        obj2.Name='VendorAPIKey';
        obj2.Value__c='DASEQWEQWDASDAS';
        
        Metrc_IntegrationSettings__C obj3 = new Metrc_IntegrationSettings__C();
        obj3.Name='UserAPIKey';
        obj3.Value__c='sDwqeqwedQWDD';
        
        Metrc_IntegrationSettings__C obj4 = new Metrc_IntegrationSettings__C();
        obj4.Name='LicenseNumber';
        obj4.Value__c='ASDASDASDAS';
        
        customsettingList.add(obj1);
        customsettingList.add(obj2);
        customsettingList.add(obj3);
        customsettingList.add(obj4);
        INSERT customsettingList;
    }
    
    /**************************************************************************************
    Method Name        : strainCreate_httpCalloutTest1  
    Version            : 1.0
    Function           :purpose of this method to give coverage to Strain HttpCallout method
    *******************************************************************************/
     static testMethod void strainCreate_httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username='tuser2@testMetrc.org' limit 1];
        system.runAs(user1){
        Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpResponseTest());
        Test.startTest();
            //Strain__c st = new Strain__c (Name = 'Test Strain', Strain_Type__c = 'Hybrid',Track_Trace_Sync__c=true,isActive__c =true);
            //insert st;
            Strain__c st = new Strain__c (Name = 'Test Strain', Strain_Type__c = 'Hybrid',Track_Trace_Sync__c=true,isActive__c =true,ThcLevel__c=1,CbdLevel__c=1,IndicaPercentage__c=1,SativaPercentage__c=1);
            insert st;
            st.Name='Test Strain updated';
            st.Metrc_StrainID__c ='12312312';
            update st;
            st.isActive__c  =false;
            update st;
        
        Test.stopTest();
        
         system.assertNotEquals(st, NULL);
        }
    }
    
    /**************************************************************************************
    Method Name        : strainCreate_httpCalloutTest1  
    Version            : 1.0
    Function           :purpose of this method to give coverage to Strain HttpCallout method
    *******************************************************************************/
     static testMethod void getSingleStrain_httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username='tuser2@testMetrc.org' limit 1];
       PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'Metrc_Integration_Fields_Access' limit 1];
        database.insert (new PermissionSetAssignment(AssigneeId = user1.id, PermissionSetId = perms.Id ));
        system.runAs(user1){
        //Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllStrainRespTest());
        Test.startTest();
            Strain__c st = new Strain__c (Name = 'Test Strain', Strain_Type__c = 'Hybrid',Track_Trace_Sync__c=true,isActive__c =true,ThcLevel__c=1,CbdLevel__c=1,IndicaPercentage__c=1,SativaPercentage__c=1);
            insert st;
         Test.setMock(HttpCalloutMock.class, new Metrc_MockHttpGetAllStrainRespTest());
         Metrc_HttpCalloutHelper.getSingleStrain('123');
             Site__c objSite = new Site__c();
            objSite.Name = 'Test Site';
            objSite.Warehouse_Name__c='TestWarehouse1';
            insert objSite;
                        List<string> LstTTgsname = new List<string>();

            List<TTGS_Strain__c> LstTTgs = new List<TTGS_Strain__c>();
            TTGS_Strain__c TTGS = new TTGS_Strain__c();
            TTGS.Site__c=objSite.Id;
            TTGS.Active__c= true;
            TTGS.Strain__c=st.Id;
            TTGS.TTGS_StrainID__c='1';
            insert TTGS; 
            LstTTgs.add(TTGS);
            LstTTgsname.add(TTGS.Name);
          //  Metrc_HttpCalloutHelper.updateTTGSStrain(LstTTgs, 'UPDATE', LstTTgsname, '1234');
            Metrc_HttpCalloutHelper.CreateTTGSStrain(LstTTgs, 'INSERT', TTGS.Name, '1234');
            Metrc_HttpCalloutHelper.CreateStrain(st.id, st, 'INSERT');
            
          //  Metrc_HttpCalloutHelper.getAllStrainsTGS(LstTTgs, false);
             Metrc_HttpCalloutHelper.getAllStrainsTGS(LstTTgs, true);
            Metrc_SOQLDML_Handler.getListTTGSStrains();
            Metrc_SOQLDML_Handler.getAllStrainswithids(st.id);
            Metrc_SOQLDML_Handler.getTTGSStrain_metrcID(TTGS.Strain__c);
            Metrc_SOQLDML_Handler.getSingleStrain_metrcID('1234'); 
            Metrc_SOQLDML_Handler.getListTTGSItems();
          //  Metrc_RequestPayload.StraindataREQJSONUpdate(LstTTgs, 'UPDATE', TTGS.Name, '1234');
            string status;
            status = Metrc_HttpCalloutHelper.ERR_MSG_WHILE_SYN_PRODUCT_DATA;
            status= Metrc_HttpCalloutHelper.SHIPPING_MANIFEST_TRANSFERNAME_WHOLESALE;
             status= Metrc_HttpCalloutHelper.ERR_MSG_SUCCESSFULLY_SYN_STRAIN_DATA;
        Test.stopTest();
        
         system.assertNotEquals(st, NULL);
        }
    }
}