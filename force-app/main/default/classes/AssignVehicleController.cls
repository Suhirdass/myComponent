/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * AssignVehicleController
 */
public class AssignVehicleController{

    private ApexPages.StandardController stdController;
    public Shipping_Manifest__c rsmObj {get; set;}
    public List<Shipping_Manifest__c> rsmList {get; set;}
    public List<Shipping_Manifest__c> tsmList {get; set;}
    public Vehicles__c vehicleObj {get; set;}
    public Integer totalProduct {get; set;}
    private Id rsmRecordTypeId;
    private Id tsmRecordTypeId;
    
    // Standard controller constructor
    public AssignVehicleController(ApexPages.StandardController controller) {
        this.stdController = controller;
        rsmObj = (Shipping_Manifest__c)stdController.getRecord();
        rsmRecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        tsmRecordTypeId = ShippinManifestSupport.getTSMRecordTypeId();
        reset();
    }
    
    //  Default constructor
    public AssignVehicleController() {
        reset();
    }
    
    // reset variables
    public void reset(){
        if(rsmObj == null){
            rsmObj = new Shipping_Manifest__c();
        }
        rsmList = new List<Shipping_Manifest__c>();
        tsmList = new List<Shipping_Manifest__c>();
        vehicleObj = new Vehicles__c();
    }
    public class UserException extends Exception{ }
    
    /**
     * Assign Vehicle to RSM
     *
     * @return PageReference of RSM detail page
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
            ErrorLogs.log('AssignVehicleController:assignVehicle()', 
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
                             Vehicle__c,
                             Driver__c,
                             Planned_Ship_Transfer_Date__c,
                             Status__c,
                             (Select Id from Shipping_Manifest_Lines__r) 
                      From Shipping_Manifest__c
                      Where Id =: rsmObj.Id];
            totalProduct = rsmObj.Shipping_Manifest_Lines__r.size();
            retrieveVehicleAndRelatedRSMs();
        }
        return null;
    }
    
    /**
     * Retrieve Vehicle details and list of RSMs associated with Vehicle
     *
     * @return blank page reference
     */         
    public PageReference retrieveVehicleAndRelatedRSMs() {
        reset();
        if(rsmObj.Vehicle__c != null){
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
                        Where Id =: rsmObj.Vehicle__c];
                        
            Date plannedDate = rsmObj.Planned_Ship_Transfer_Date__c;
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
            if(rsmObj.Id != null){
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
        
        // Check for Vehicle value
        if(rsmObj.Id != null && rsmObj.Vehicle__c == null){
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, Label.Select_Vehicle);
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