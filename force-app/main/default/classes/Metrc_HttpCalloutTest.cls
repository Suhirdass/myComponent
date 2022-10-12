@isTest(SeeAllData=false)
/**********************************************************************************************************
Apex TestClass Name    : Metrc_HttpCalloutTest 
Apex Class Name    : Metrc_HttpCallout 
Version            : 1.0
Created Date       : 01/Sep/2019
Function           : Used for HTTPcallout
------------------------------------------------------------------------------------------------------------
* Developer                                      Date                   Description
* ----------------------------------------------------------------------------------------------------------
* Suresha Shettigar                             01/Sep/2019              Original Version
************************************************************************************************************/

private class Metrc_HttpCalloutTest 
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
                            Username = 'tuser1@test.org',
                            EmailEncodingKey = 'ISO-8859-1',
                            Alias ='tuser',
                            TimeZoneSidKey = 'America/Los_Angeles',
                            LocaleSidKey = 'en_US',
                            LanguageLocaleKey = 'en_US',
                            ProfileId = profId);
                            database.insert(tuser);
                            
   //PermissionSet perms = [SELECT ID From PermissionSet WHERE Name = 'ABI_POCU_GCC_CMD' limit 1];
   //database.insert (new PermissionSetAssignment(AssigneeId = tuser.id, PermissionSetId = perms.Id ));
    }
    
    /**************************************************************************************
    Method Name        : httpCalloutTest1  
    Version            : 1.0
    Function           :purpose of this method to give coverage to exception code in HttpCallout class
    *******************************************************************************/
     static testMethod void httpCalloutTest1()
    {
        User user1=[select Id,Name from User where Username='tuser1@test.org' limit 1];
        system.runAs(user1){
        Map<String, String> requestHeaders = new Map<String, String>();
        requestHeaders.put('content-type', 'application/json');
        Metrc_HttpCallout  oHttpCallout  = new Metrc_HttpCallout();
        HttpResponse oHttpResponse=null;
        Test.startTest();

        oHttpResponse=oHttpCallout.SendRequest('PUT', 'https://my-rest-dev.com/rest/api/', '', requestHeaders);
        oHttpResponse=oHttpCallout.SendRequest('POST', 'https://my-rest-dev.com/rest/api/', '', requestHeaders);
       
        
        Test.stopTest();
        
         system.assertEquals(500, oHttpResponse.getStatusCode());
        }
    }
    
     /**************************************************************************************
    Method Name        : httpCalloutTest2  
    Version            : 1.0
    Function           :purpose of this method to give coverage to exception code in HttpCallout class
    *******************************************************************************/
    static testMethod void httpCalloutTest2()
    {
        User user1=[select Id,Name from User where Username='tuser1@test.org' limit 1];
        system.runAs(user1){ 
        Map<String, String> requestHeaders = new Map<String, String>();
        requestHeaders.put('content-type', 'application/json');
        //HttpCallout oHttpCallout = new HttpCallout();
        Metrc_HttpCallout  oHttpCallout  = new Metrc_HttpCallout();
        HttpResponse oHttpResponse=null;
       Metrc_HttpRequestHelper hlper = new Metrc_HttpRequestHelper();
        Test.startTest();
       oHttpResponse = oHttpCallout.SendRequest('GET', 'https://my-rest-dev.com/rest/api/', '', requestHeaders);
              oHttpResponse = oHttpCallout.SendRequest('DELETE', 'https://my-rest-dev.com/rest/api/', '', requestHeaders);
       
       hlper.Timeout = 10;
        
        Test.stopTest();
        
         system.assertEquals(500, oHttpResponse.getStatusCode());
    }
   }
   /**************************************************************************************
    Method Name        : httpCalloutTest3  
    Version            : 1.0
    Function           :purpose of this method to give coverage to getters in Metrc_HttpRequestHelper class
    *******************************************************************************/
    static testMethod void httpCalloutTest3()
    {
      User user1=[select Id,Name from User where Username='tuser1@test.org' limit 1];
        system.runAs(user1){ 
        Test.startTest();
        Metrc_HttpRequestHelper  httpReqHelper=new Metrc_HttpRequestHelper ();
        httpReqHelper.Timeout = 50000;
        httpReqHelper.Endpoint ='https://my-rest-dev.com/rest/api/' ;
        httpReqHelper.Body='test';
        httpReqHelper.Headers=null;
        Test.stopTest();       
     }   
    } 
}