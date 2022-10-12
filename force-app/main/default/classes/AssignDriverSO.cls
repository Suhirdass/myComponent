public class AssignDriverSO {
  private ApexPages.StandardController stdController;
    public Shipping_Manifest__c tsmObj {get; set;}
    public List<Shipping_Manifest__c> rsmList {get; set;}
    public List<Shipping_Manifest__c> tsmList {get; set;}
    public Boolean isInit{get;set;}
    public Drivers__c driverObj {get; set;}
    public Integer totalProduct {get; set;}
    private Id rsmRecordTypeId;
    private Id tsmRecordTypeId;
      public static String message;
    public List<String> errors {get;set;}
    
    // Standard controller constructor
    public AssignDriverSO (ApexPages.StandardController controller) {
                this.stdController = controller;

       tsmObj = new Shipping_Manifest__c();
        tsmObj = (Shipping_Manifest__c)stdController.getRecord();
        rsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get('RSM').getRecordTypeId();
        tsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get('Product TSM').getRecordTypeId();
        reset();
    }
    
    //  Default constructor
    public AssignDriverSO() {
       reset();
    }
    
    // reset variables
    public void reset(){
        if(tsmObj == null){
            tsmObj = new Shipping_Manifest__c();
        }
        System.debug('tsmObj::'+tsmObj);
        rsmList = new List<Shipping_Manifest__c>();
        tsmList = new List<Shipping_Manifest__c>();
        driverObj = new Drivers__c();
    }
    public class UserException extends Exception{ }
    
    /**
* Assign Driver to RSM
*
* @return PageReference of RSM detail page
*/
    @AuraEnabled
    public  static AuraResponse assignDriverToOrder(String recordId){
       
        AuraResponse r = new AuraResponse('AssignDriverSO.assignDriverToOrder()');    
        
        AssignDriverSO assign = new AssignDriverSO();
        assign.tsmObj = new Shipping_Manifest__c();
        List<Shipping_Manifest__c> lstPur = [SELECT Id, Status__c, Driver__c, Vehicle__c FROM Shipping_Manifest__c WHERE Id =: recordId limit 1];
        if(lstPur.size() > 0){
        	assign.tsmObj  = lstPur[0];  
        }
        assign.rsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get('RSM').getRecordTypeId();
        assign.tsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get('Product TSM').getRecordTypeId();
        assign.reset();
        assign.doPrepare();
         
        r.data.put('rsmList', assign.rsmList);
        r.data.put('tsmList', assign.tsmList);
        r.data.put('driverObj', assign.driverObj);
        r.data.put('tsmObj', assign.tsmObj);
         r.data.put('totalProduct', assign.totalProduct);
        return r;
    
    }
    
 @AuraEnabled
    public static AuraResponse assignDriver(Shipping_Manifest__c order) {
        AuraResponse r = new AuraResponse('AssignDriverToPurchaseOrderCtlr.assignDriver()');
        
        AssignDriverSO assign = new AssignDriverSO();
        assign.tsmObj = order;
        
        if(checkValidation(assign.tsmObj)){
            r.data.put('errorMessage', message);
            return r;
        }
        try {
            update assign.tsmObj;
        } 
        catch (Exception ex){
            ErrorLogs.log('AssignDriverController:assignDriver()', 
                          ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            message = String.valueOf(msg);
            r.data.put('errorMessage', message);
            return r;
        }
        return r;
    }    
    
    
    
  public PageReference assignDriver() {
        
        PageReference pageRef = null;
        
        // Perform validations for required field Driver
        if(checkValidation()){
            return pageRef;
        }
        
        try {
            update tsmObj;
        } 
        catch (Exception ex){
            ErrorLogs.log('AssignDriverSO:assignDriver()', 
                          ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(msg);
            return null;
        }
        return redirectToRSM();
    }   
    
    
      
    /**
* Retrieve RSM with lines record
*
* @return blank page reference
*/         
   public PageReference doPrepare() {
        if(tsmObj != null && tsmObj.Id != null){
            
            // Retrieve TSM detailsSELECT Id, Status__c, Driver__c, Vehicle__c FROM  
            tsmObj = [Select Name,
                      Driver__c,
                      Vehicle__c,Driver__r.Name,
                      Planned_Ship_Transfer_Date__c,
                      Status__c,
                      (Select Id from Shipping_Manifest_Lines__r) 
                      From Shipping_Manifest__c
                      Where Id =: tsmObj.Id];
            totalProduct = tsmObj.Shipping_Manifest_Lines__r.size();
            retrieveDriverAndRelatedRSMs();
        }
        return null;
    }
    
    @AuraEnabled
    public static AuraResponse retrieveDriverAndRelatedRSMs(Shipping_Manifest__c order){
      AuraResponse r = new AuraResponse('AssignDriverSO.retrieveDriverAndRelatedRSMs()'); 
        
        AssignDriverSO assign = new AssignDriverSO();
        assign.reset();
        assign.tsmObj = order;
        assign.rsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get('RSM').getRecordTypeId();
        assign.tsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get('Product TSM').getRecordTypeId();
            
        if(assign.tsmObj.Driver__c != NULL && !String.isBlank(assign.tsmObj.Driver__c)){
            System.debug('Driver 2 = '+assign.tsmObj.Driver__c);
            List<Drivers__c> lstDriver = new List<Drivers__c>();
            
            lstDriver = [Select Name,Active__c,Driver_License_Class__c, Driver_License_Number__c,Expiration_Date__c,License_Expired__c,State_Issued__c
                        From Drivers__c Where Id =: assign.tsmObj.Driver__c];
            if(lstDriver.size() > 0){
            	assign.driverObj = lstDriver[0];   
            }
            
            Date plannedDate = assign.tsmObj.Planned_Ship_Transfer_Date__c;
            Id driverObjId = assign.driverObj.Id;
            String tsmQuery = 'Select Name, Driver__c,Vehicle__c,Vehicle__r.Name,Planned_Ship_Transfer_Date__c,Status__c,Total_Route_Miles__c, Route_Miles__c,Actual_Departure_Date_Time__c,' +
                              'Actual_Arrival_Date_Time__c From Shipping_Manifest__c ' +
                              'Where Driver__c =: driverObjId ' +
                              //'AND RecordTypeId =: tsmRecordTypeId ';
            				' AND RecordTypeId =\''+ String.escapeSingleQuotes(assign.tsmRecordTypeId)+'\' ';
            if(assign.tsmObj.Id != null){
                tsmQuery += 'AND Planned_Ship_Transfer_Date__c =: plannedDate ';
            }
            tsmQuery += 'Order By Actual_Arrival_Date_Time__c DESC NULLS FIRST';
            assign.tsmList = Database.query(tsmQuery);
            
            String rsmQuery = 'Select Name, Driver__c,Vehicle__c,Vehicle__r.Name,Planned_Ship_Transfer_Date__c,Status__c,Total_Route_Miles__c, Route_Miles__c,Actual_Departure_Date_Time__c,' +
                              'Receiver_Acceptance_Date__c From Shipping_Manifest__c ' +
                              'Where Driver__c =: driverObjId ' +
                			' AND RecordTypeId =\''+ String.escapeSingleQuotes(assign.rsmRecordTypeId)+'\' ';
                            //  'AND RecordTypeId =: rsmRecordTypeId ';
            if(assign.tsmObj.Id != null){
                rsmQuery += 'AND Planned_Ship_Transfer_Date__c =: plannedDate ';
            }
            rsmQuery += 'Order By Receiver_Acceptance_Date__c DESC NULLS FIRST';
            assign.rsmList = Database.query(rsmQuery);
        }
        r.data.put('rsmList', assign.rsmList);
        r.data.put('tsmList', assign.tsmList);
        r.data.put('driverObj', assign.driverObj);
        r.data.put('tsmObj', assign.tsmObj);
        return r;  
        
     
    }
    /**
* Retrieve Driver details and list of RSMs associated with driver
*
* @return blank page reference
*/         
    public PageReference retrieveDriverAndRelatedRSMs() {
        reset();
        System.debug('tsmObj.Id2='+tsmObj.Id);
        System.debug('tsmObj.Driver__c='+tsmObj.Driver__c);
        if(tsmObj.Driver__c != null){
            driverObj = [Select Name, 
                         Active__c,
                         Driver_License_Class__c,
                         Driver_License_Number__c,
                         Expiration_Date__c,
                         License_Expired__c,
                         State_Issued__c
                         From Drivers__c
                         Where Id =: tsmObj.Driver__c];
            
            Date plannedDate = tsmObj.Planned_Ship_Transfer_Date__c;
            Id driverObjId = driverObj.Id;
            System.debug('driverObjId='+driverObjId);
            System.debug('rsmRecordTypeId='+rsmRecordTypeId);
            System.debug('plannedDate='+plannedDate);
            String rsmQuery = 'Select Name, ' +
                'Driver__c,Vehicle__c,Vehicle__r.Name, ' +
                'Planned_Ship_Transfer_Date__c, ' +
                'Status__c,Total_Route_Miles__c, Route_Miles__c,' +
                'Actual_Departure_Date_Time__c, ' +
                'Receiver_Acceptance_Date__c ' +
                'From Shipping_Manifest__c ' +
                'Where Driver__c =: driverObjId ' +
                'AND RecordTypeId =: rsmRecordTypeId ';
            if(tsmObj.Id != null){
                rsmQuery += 'AND Planned_Ship_Transfer_Date__c =: plannedDate ';
            }
            rsmQuery += 'Order By Receiver_Acceptance_Date__c DESC NULLS FIRST';
            rsmList = Database.query(rsmQuery);
            
            String tsmQuery = 'Select Name, ' +
                'Driver__c,Vehicle__c,Vehicle__r.Name, ' +
                'Planned_Ship_Transfer_Date__c, ' +
                'Status__c,Total_Route_Miles__c, Route_Miles__c,' +
                'Actual_Departure_Date_Time__c, ' +
                'Actual_Arrival_Date_Time__c ' +
                'From Shipping_Manifest__c ' +
                'Where Driver__c =: driverObjId ' +
                'AND RecordTypeId =: tsmRecordTypeId ';
            if(tsmObj.Id != null){
                tsmQuery += 'AND Planned_Ship_Transfer_Date__c =: plannedDate ';
            }
            tsmQuery += 'Order By Actual_Arrival_Date_Time__c DESC NULLS FIRST';
            tsmList = Database.query(tsmQuery);
        }
        return null;
    }
    
    /**
* Check validation to create invoice
*
* @return Boolean flag to indicate if any validation fails
*/
     public static Boolean checkValidation(Shipping_Manifest__c tsmObj){
        Boolean hasValidationError = false;
        // Check for Driver value
        if(tsmObj.Id != null && tsmObj.Driver__c == null){
            hasValidationError = true;
            message = Label.Select_Driver;
        }
        return hasValidationError;
    }
    
    
    
     public Boolean checkValidation(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        
        // Check for Driver value
        if(tsmObj.Id != null && tsmObj.Driver__c == null){
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, Label.Select_Driver);
            ApexPages.addMessage(message);
        }
        return hasValidationError;
    }
    
    /**
* Cancel action - Redirect to RSM detail page
*
* @return PageReference
*/
    public PageReference cancelAction() {
        return redirectToRSM();
    }
    
    /**
* Redirect to RSM detail page
*
* @return PageReference
*/         
    public PageReference redirectToRSM() {
        PageReference pageRef = null;
        if(stdController != null){
            pageRef = stdController.view().setRedirect(true);
        }
        return pageRef;
    }
}