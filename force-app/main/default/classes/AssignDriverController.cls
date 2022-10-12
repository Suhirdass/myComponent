/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * AssignDriverController
 */
public class AssignDriverController{

    private ApexPages.StandardController stdController;
    public Shipping_Manifest__c rsmObj {get; set;}
    public List<Shipping_Manifest__c> rsmList {get; set;}
    public List<Shipping_Manifest__c> tsmList {get; set;}
    public Drivers__c driverObj {get; set;}
    public Integer totalProduct {get; set;}
    private Id rsmRecordTypeId;
    private Id tsmRecordTypeId;
    
    // Standard controller constructor
    public AssignDriverController(ApexPages.StandardController controller) {
        this.stdController = controller;
        rsmObj = (Shipping_Manifest__c)stdController.getRecord();
        rsmRecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        tsmRecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        reset();
    }
    
    //  Default constructor
    public AssignDriverController() {
        reset();
    }
    
    // reset variables
    public void reset(){
        if(rsmObj == null){
            rsmObj = new Shipping_Manifest__c();
        }
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
    public PageReference assignDriver() {
        
        PageReference pageRef = null;
        
        // Perform validations for required field Driver
        if(checkValidation()){
            return pageRef;
        }
        
        try {
            
            // Set status as shipment pending if both vehicle and driver are assigned to SM
            // Otherwise set status as Draft
            if(rsmObj.Status__c != RSMSupport.STATUS_SHIPMENT_COMPLETE){
                if(rsmObj.Driver__c != null && rsmObj.Vehicle__c != null){
                    // RSM status should not be In Transit
                    if(rsmObj.Status__c != RSMSupport.STATUS_IN_TRANSIT){
                        rsmObj.Status__c = RSMSupport.STATUS_SHIPMENT_PENDING;
                    }
                }else{
                    rsmObj.Status__c = RSMSupport.STATUS_DRAFT;
                }
            }
            update rsmObj;
        } 
        catch (Exception ex){
            ErrorLogs.log('AssignDriverController:assignDriver()', 
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
        if(rsmObj != null && rsmObj.Id != null){
            
            // Retrieve RSM details
            rsmObj = [Select Name,
                             Driver__c,
                             Vehicle__c,
                             Planned_Ship_Transfer_Date__c,
                             Status__c,
                             (Select Id from Shipping_Manifest_Lines__r) 
                      From Shipping_Manifest__c
                      Where Id =: rsmObj.Id];
            totalProduct = rsmObj.Shipping_Manifest_Lines__r.size();
            retrieveDriverAndRelatedRSMs();
        }
        return null;
    }
    
    /**
     * Retrieve Driver details and list of RSMs associated with driver
     *
     * @return blank page reference
     */         
    public PageReference retrieveDriverAndRelatedRSMs() {
        reset();
        if(rsmObj.Driver__c != null){
            driverObj = [Select Name, 
                                Active__c,
                                Driver_License_Class__c,
                                Driver_License_Number__c,
                                Expiration_Date__c,
                                License_Expired__c,
                                State_Issued__c
                        From Drivers__c
                        Where Id =: rsmObj.Driver__c];
                        
            Date plannedDate = rsmObj.Planned_Ship_Transfer_Date__c;
            Id driverObjId = driverObj.Id;
            
            String rsmQuery = 'Select Name, ' +
                                   'Driver__c,Vehicle__c, ' +
                                   'Planned_Ship_Transfer_Date__c, ' +
                                   'Status__c, Route_Miles__c,' +
                                   'Actual_Departure_Date_Time__c, ' +
                                   'Receiver_Acceptance_Date__c ' +
                              'From Shipping_Manifest__c ' +
                              'Where Driver__c =: driverObjId ' +
                              'AND RecordTypeId =: rsmRecordTypeId ';
            if(rsmObj.Id != null){
                rsmQuery += 'AND Planned_Ship_Transfer_Date__c =: plannedDate ';
            }
            rsmQuery += 'Order By Receiver_Acceptance_Date__c DESC NULLS FIRST';
            rsmList = Database.query(rsmQuery);
            
            String tsmQuery = 'Select Name, ' +
                                   'Driver__c,Vehicle__c, ' +
                                   'Planned_Ship_Transfer_Date__c, ' +
                                   'Status__c, Route_Miles__c,' +
                                   'Actual_Departure_Date_Time__c, ' +
                                   'Actual_Arrival_Date_Time__c ' +
                              'From Shipping_Manifest__c ' +
                              'Where Driver__c =: driverObjId ' +
                              'AND RecordTypeId =: tsmRecordTypeId ';
            if(rsmObj.Id != null){
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
    public Boolean checkValidation(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        
        // Check for Driver value
        if(rsmObj.Id != null && rsmObj.Driver__c == null){
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