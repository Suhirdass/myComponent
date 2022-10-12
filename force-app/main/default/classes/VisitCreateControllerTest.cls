/**************************************************************************************
Apex Class Name    : InventoryDetailsTest 
Version            : 1.0
Created Date       : July 01 2018
Function           : Used for InventoryDetails VF page and used in "InventoryDetails" VF page.
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresh                  07/01/2018              Original Version
* Suresh                  07/26/2018             MiscIssue test class added.
*******************************************************************************/
@isTest
public class VisitCreateControllerTest {
    
    static testMethod void VisitCreateControllerTest1(){
        
        CustomerVisit__c CustomerVisit = new CustomerVisit__c();
        CustomerVisit.FirstName__c ='Test';
        CustomerVisit.LastName__c='Test';
        CustomerVisit.Email__c='Test@test123.com';
        CustomerVisit.Phone__c ='121212';
        CustomerVisit.CompanyName__c='Test';
        CustomerVisit.Website__c='www.test123.com';
        CustomerVisit.VisityType__c='Inspection';
        CustomerVisit.ReasonForVisit__c='Test';
        CustomerVisit.PersonToMeet__c='Khanh Ngo';
        CustomerVisit.Address__c='Test';
        
        
        ContentVersion cont = new ContentVersion();
        cont.PathOnClient='test123';
        cont.VersionData=Blob.valueOf('Test Data');
        
        
        VisitCreateController  vc= new VisitCreateController();
        vc.CustomerVisit =CustomerVisit;
        vc.cont = cont;
        cont.Title = 'Test';
        vc.save();
        vc.homePage();
        vc.reloadData();
        
        
    }
    
}