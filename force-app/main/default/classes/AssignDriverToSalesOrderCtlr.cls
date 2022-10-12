/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * AssignDriverToSalesOrderCtlr
 */
public class AssignDriverToSalesOrderCtlr{

    private ApexPages.StandardController stdController;
    public Sales_Order__c tsmObj {get; set;}
    public List<Shipping_Manifest__c> rsmList {get; set;}
    public List<Shipping_Manifest__c> tsmList {get; set;}
    public Drivers__c driverObj {get; set;}
    public Integer totalProduct {get; set;}
    private Id rsmRecordTypeId;
    private Id tsmRecordTypeId;
    
    // Standard controller constructor
    public AssignDriverToSalesOrderCtlr(ApexPages.StandardController controller) {
        this.stdController = controller;
        tsmObj = (Sales_Order__c)stdController.getRecord();
        rsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get('RSM').getRecordTypeId();
        tsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get('Product TSM').getRecordTypeId();
        reset();
    }
    
    // reset variables
    public void reset(){
        if(tsmObj == null){
            tsmObj = new Sales_Order__c();
        }
        rsmList = new List<Shipping_Manifest__c>();
        tsmList = new List<Shipping_Manifest__c>();
        driverObj = new Drivers__c();
    }
    public class UserException extends Exception{ }
    
    /**
     * Assign Driver to TSM
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
            update tsmObj;
        } 
        catch (Exception ex){
            ErrorLogs.log('AssignDriverController:assignDriver()', 
                          ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(msg);
            return null;
        }
        return redirectToTSM();
    }

    /**
     * Retrieve TSM with lines record
     *
     * @return blank page reference
     */         
    public PageReference doPrepare() {
        if(tsmObj != null && tsmObj.Id != null){
            
            // Retrieve TSM details
            tsmObj = [Select Name,
                             Driver__c,
                             Planned_Ship_Date__c 
                      From Sales_Order__c
                      Where Id =: tsmObj.Id];
            //totalProduct = tsmObj.Shipping_Manifest_Lines__r.size();
            retrieveDriverAndRelatedRSMTSMs();
        }
        return null;
    }
    
    /**
     * Retrieve Driver details and list of RSM/TSMs associated with driver
     *
     * @return blank page reference
     */         
    public PageReference retrieveDriverAndRelatedRSMTSMs() {
        reset();
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
                        
            Date plannedDate = tsmObj.Planned_Ship_Date__c;
            Id driverObjId = driverObj.Id;
            String tsmQuery = 'Select Name, ' +
                                   'Driver__c,Vehicle__c, ' +
                                   'Planned_Ship_Transfer_Date__c, ' +
                                   'Status__c, Route_Miles__c,' +
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
            
            String rsmQuery = 'Select Name, ' +
                                   'Driver__c,Vehicle__c, ' +
                                   'Planned_Ship_Transfer_Date__c, ' +
                                   'Status__c, Route_Miles__c,' +
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
        }
        return null;
    }
    
    /**
     * Check validation for driver value
     *
     * @return Boolean flag to indicate if any validation fails
     */
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
     * Cancel action - Redirect to TSM detail page
     *
     * @return PageReference
     */
    public PageReference cancelAction() {
        return redirectToTSM();
    }
    
    /**
     * Redirect to TSM detail page
     *
     * @return PageReference
     */         
    public PageReference redirectToTSM() {
        PageReference pageRef = null;
        if(stdController != null){
            pageRef = stdController.view().setRedirect(true);
        }
        return pageRef;
    }
}