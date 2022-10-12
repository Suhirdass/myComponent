/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * AssignVehicleToTSMController
 */
public class AssignVehicleToTSMController{

    private ApexPages.StandardController stdController;
    public Shipping_Manifest__c tsmObj {get; set;}
    public List<Shipping_Manifest__c> rsmList {get; set;}
    public List<Shipping_Manifest__c> tsmList {get; set;}
    public Vehicles__c vehicleObj {get; set;}
    public Integer totalProduct {get; set;}
    private Id rsmRecordTypeId;
    private Id tsmRecordTypeId;
    
    // Standard controller constructor
    public AssignVehicleToTSMController(ApexPages.StandardController controller) {
        this.stdController = controller;
        tsmObj = (Shipping_Manifest__c)stdController.getRecord();
        rsmRecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        tsmRecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        reset();
    }
    
    // reset variables
    public void reset(){
        if(tsmObj == null){
            tsmObj = new Shipping_Manifest__c();
        }
        rsmList = new List<Shipping_Manifest__c>();
        tsmList = new List<Shipping_Manifest__c>();
        vehicleObj = new Vehicles__c();
    }
    public class UserException extends Exception{ }
    
    /**
     * Assign Vehicle to TSM
     *
     * @return PageReference of TSM detail page
     */
    public PageReference assignVehicle() {
        
        PageReference pageRef = null;
        
        // Perform validations for required field Vehicle
        if(checkValidation()){
            return pageRef;
        }
        
        try {
            
            // Set status as shipment pending if both vehicle and driver are assigned to SM
            // Otherwise set status as Draft
            if(tsmObj.Status__c != RSMSupport.STATUS_SHIPMENT_COMPLETE){
                if(tsmObj.Driver__c != null && tsmObj.Vehicle__c != null){
                    // TSM status should not be In Transit
                    if(tsmObj.Status__c != RSMSupport.STATUS_IN_TRANSIT){
                        tsmObj.Status__c = RSMSupport.STATUS_SHIPMENT_PENDING;
                    }
                }else{
                    tsmObj.Status__c = RSMSupport.STATUS_DRAFT;
                }
            }
            update tsmObj;
        } 
        catch (Exception ex){
            ErrorLogs.log('AssignVehicleController:assignVehicle()', 
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
                             Vehicle__c,
                             Driver__c,
                             Planned_Ship_Transfer_Date__c,
                             Status__c,
                             (Select Id from Shipping_Manifest_Lines__r) 
                      From Shipping_Manifest__c
                      Where Id =: tsmObj.Id];
            totalProduct = tsmObj.Shipping_Manifest_Lines__r.size();
            retrieveVehicleAndRelatedRSMTSMs();
        }
        return null;
    }
    
    /**
     * Retrieve Vehicle details and list of TSMs associated with Vehicle
     *
     * @return blank page reference
     */         
    public PageReference retrieveVehicleAndRelatedRSMTSMs() {
        reset();
        if(tsmObj.Vehicle__c != null){
            vehicleObj = [Select Name, 
                                Vehicle_Cubic_Volume_Capacity__c,
                                Vehicle_Height__c,
                                Vehicle_in_Use__c,
                                Vehicle_Length__c,
                                Vehicle_License_Plate_Number__c,
                                Vehicle_Make__c,
                                Vehicle_Model__c,
                                Vehicle_Width__c
                        From Vehicles__c
                        Where Id =: tsmObj.Vehicle__c];
                        
            Date plannedDate = tsmObj.Planned_Ship_Transfer_Date__c;
            Id vehicleObjId = vehicleObj.Id;
            
            String rsmQuery = 'Select Name, ' +
                                   'Vehicle__c,Driver__c, ' +
                                   'Planned_Ship_Transfer_Date__c, ' +
                                   'Status__c, Route_Miles__c,' +
                                   'Actual_Departure_Date_Time__c, ' +
                                   'Receiver_Acceptance_Date__c ' +
                              'From Shipping_Manifest__c ' +
                              'Where Vehicle__c =: vehicleObjId ' +
                              'AND RecordTypeId =: rsmRecordTypeId ';
            if(tsmObj.Id != null){
                rsmQuery += 'AND Planned_Ship_Transfer_Date__c =: plannedDate ';
            }
            rsmQuery += 'Order By Receiver_Acceptance_Date__c DESC NULLS FIRST';
            rsmList = Database.query(rsmQuery);
            
            String tsmQuery = 'Select Name, ' +
                                   'Vehicle__c,Driver__c, ' +
                                   'Planned_Ship_Transfer_Date__c, ' +
                                   'Status__c, Route_Miles__c,' +
                                   'Actual_Departure_Date_Time__c, ' +
                                   'Actual_Arrival_Date_Time__c ' +
                              'From Shipping_Manifest__c ' +
                              'Where Vehicle__c =: vehicleObjId ' +
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
    public Boolean checkValidation(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        
        // Check for Vehicle value
        if(tsmObj.Id != null && tsmObj.Vehicle__c == null){
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, Label.Select_Vehicle);
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