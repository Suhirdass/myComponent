public without sharing class VisitCreateController {
Public CustomerVisit__c CustomerVisit {get ; set;}
public ContentVersion cont {get;set;}


  public VisitCreateController() {
  CustomerVisit = new CustomerVisit__c();
  
  CustomerVisit.InTime__c=Datetime.now();
   cont = new ContentVersion();


  }
 public void reloadData(){
     try {
         if(CustomerVisit.ID !=null){
             CustomerVisit =[select Name,Email__c,InTime__c,ReasonForVisit__c,CompanyName__c, FirstName__c,LastName__c,PersonToMeet__c
                             from CustomerVisit__c where ID=:CustomerVisit.ID limit 1];
         }
     } catch (Exception e) {
         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
     }
  }
  
  // save button is clicked
  public PageReference save() {
  
    try {
    insert CustomerVisit; // inserts the new record into the database
        System.debug('cont.Title :'+cont.Title );
    if(cont.Title !=null) {
        cont.PathOnClient = cont.title;
        cont.Origin = 'H';
        cont.FirstPublishLocationId =CustomerVisit.ID;
        insert cont;
        cont = new ContentVersion();
    }
	return Page.VisitCreateThankyou;

      
    } catch (Exception e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,e.getMessage()));
      return null;
    }
    
    // if successfully inserted new contact, then displays the thank you page.

    
  }
    public PageReference homePage() {
    //  PageReference pageRef = new PageReference('https://uat-customervisit.cs66.force.com/CustomerVisit/');
     PageReference pageRef = new PageReference(System.Url.getSalesforceBaseURL().toExternalForm() +'/CustomerVisit/');
    
            return pageRef;
    
    }

}