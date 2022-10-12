/**************************************************************************************
Apex Class Name    : AutocompleteV2_Con_Test
Version            : 1.0
Created Date       : July 01 2018
Function           : Test class for "AutoCompleteV2_Con "
Modification Log   :
------------------------------------------------------------------------------
 * Developer                   Date                   Description
 * ----------------------------------------------------------------------------
 * Suresh                  07/01/2018              Original Version
*******************************************************************************/
@isTest
private class AutocompleteV2_Con_Test{
    static testMethod void test_AutocompleteV2_Con(){
        //create some test account
        List<Account> accountList = new List<Account>();
        for(Integer i =0 ; i < 200 ; i++){
            accountList.add(new Account(Name='Test'+i, Payment_Terms__c='COD'));
        }
        //insert test records
        insert accountList;
        Test.startTest();
            System.assertEquals(accountList.size(),AutoCompleteV2_Con.getData('Account','Name','Id','','T').size());
            System.assertEquals(1, AutoCompleteV2_Con.getData('Account','Name','Id','','Test111').size());
            System.assertEquals(0, AutoCompleteV2_Con.getData('Account','Name','Id','','xxxxxxx').size());
            AutoCompleteV2_Con controller = new AutoCompleteV2_Con ();
            controller.setTargetFieldVar(accountList[0].Id);
            System.assertEquals(accountList[0].Id,controller.getTargetFieldVar());
            controller.setCacheField(null);
        Test.stopTest();
        
    }
}