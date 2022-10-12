/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * ShipConfirmTSMController
 */
public class ShipConfirmTSMController{
      public static String errorMessage;
   public static String validateerrorMessage;
    private ApexPages.StandardController stdController;
    private Shipping_Manifest__c tsmObj = null;
    @testVisible
    private static final String RSM_STATUS_SHIPMENT_COMPLETE = 'Shipment Complete'; 
    @testVisible
    private static final String STATUS_RECEIVED = TSMSupport.STATUS_RECEIVED; 
     public Static String SHIPPING_MANIFEST_STATUS_DRAFT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_DRAFT) ? SHIPPING_MANIFEST_STATUS_DRAFT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Draft');
        }set;
    }
      public Static String ERR_MSG_COMPLETE_DEPART_CONFIRM{
        get{
            return String.isNotBlank(ERR_MSG_COMPLETE_DEPART_CONFIRM) ? ERR_MSG_COMPLETE_DEPART_CONFIRM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Complete_Depart_Confirm_TSM');
        }set;
    }
     public Static String SHIPPING_MANIFEST_STATUS_PENDING{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_PENDING) ? SHIPPING_MANIFEST_STATUS_PENDING: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_ShipmentPending');
        }set;
    }
    public Static String ERR_MSG_TSM_RECEIVED{
        get{
            return String.isNotBlank(ERR_MSG_TSM_RECEIVED) ? ERR_MSG_TSM_RECEIVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_TSM_Already_Received');
        }set;
    }
     private Static String ERR_MSG_ASSIGN_DRIVER_AND_VEHICLES{
        get{
            return String.isNotBlank(ERR_MSG_ASSIGN_DRIVER_AND_VEHICLES) ? ERR_MSG_ASSIGN_DRIVER_AND_VEHICLES: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_assign_Driver_And_Vehicle');
        }set;
    }
    // Constructor
    public ShipConfirmTSMController(ApexPages.StandardController controller) {
        this.stdController = controller;
        tsmObj = (Shipping_Manifest__c)stdController.getRecord();
    }
    
    public class UserException extends Exception{ }
    
    public ShipConfirmTSMController()
        
    {
        
    }
    
      @AuraEnabled
    public static AuraResponse shipConfirmtsmlt (String recordId) {
        
        AuraResponse r = new AuraResponse('shipConfirmlt()');
        ShipConfirmTSMController assign = new ShipConfirmTSMController();
        Savepoint savePoint;
        try {
            savePoint = Database.setSavepoint();
          assign.tsmObj = retrieveTSMlt(recordId);
               Boolean hasValidationError = false;
            
                if(assign.tsmObj.Status__c != STATUS_RECEIVED){
                    if(assign.checkValidation2()){
                      r.data.put('validatelite', validateerrorMessage);
                return r;
                    }
                }else{
                    errorMessage =  ERR_MSG_TSM_RECEIVED;
                  hasValidationError = true;
                      r.data.put('messagelightning', errorMessage);
                     return r;
                }
           
            assign.updateTSM(); 
        }catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('DepartConfirmController:departConfirm()', ex.getStackTraceString(), ex.getMessage());
        }
        return r;
    } 
     
    public Boolean checkValidation2(){
        
        Boolean hasValidationError = false;
        
        if(tsmObj.Status__c == SHIPPING_MANIFEST_STATUS_PENDING || tsmObj.Status__c == SHIPPING_MANIFEST_STATUS_DRAFT){
            validateerrorMessage = ERR_MSG_COMPLETE_DEPART_CONFIRM;
             hasValidationError = true;
        }
        
        
        
        return hasValidationError;
    } 
    
    /**
     * Change Status to TSM status, Actual Arrival time of TSM
     *
     * @return PageReference of TSM detail page
     */
    public PageReference shipConfirm() {
        PageReference pageRef = null;
        Savepoint savePoint;
        
        try {
            
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            
            tsmObj = retrieveTSM();
            ApexPages.Message msg;
            // Check validation if TSM status is not Received
            if(tsmObj.Actual_Departure_Date_Time__c == null){
                msg = new ApexPages.Message(ApexPages.Severity.WARNING,
                                            Label.Depart_Confirm_Is_Mandatory_For_Ship_Confirm_TSM);
                ApexPages.addMessage(msg);
                return null;
            
            }else{
                if(tsmObj.Status__c != STATUS_RECEIVED){
                    if(checkValidation()){
                        return null;
                    }
                }else{
                    msg = new ApexPages.Message(ApexPages.Severity.WARNING,
                                                                  Label.Already_TSM_Received);
                    ApexPages.addMessage(msg);
                    return null;
                }
            }
            
            updateTSM();
        } 
        catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('ShipConfirmTSMController:shipConfirm()', 
                          ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(msg);
            return null;
        }
        return redirectToTSM();
    }

    /**
     * Retrieve TSM record
     *
     * @return The record
     */         
    public Shipping_Manifest__c retrieveTSM() {
        return  [Select Status__c,
                        Actual_Arrival_Date_Time__c,
                        Actual_Departure_Date_Time__c,
                        Payment_Terms__c,
                        Driver__c,
                        Vehicle__c,
                 		(Select SMLine_Status__c
                              From Shipping_Manifest_Lines__r
                              Where SMLine_Status__c NOT IN (:RSMSupport.STATUS_CANCELLED, 
                                                              :RSMSupport.STATUS_REJECTED))
                From Shipping_Manifest__c
                Where Id =: tsmObj.Id];
    }
    
      public static Shipping_Manifest__c retrieveTSMlt(id recordId) {
        return  [Select Status__c,
                        Actual_Arrival_Date_Time__c,
                        Actual_Departure_Date_Time__c,
                        Payment_Terms__c,
                        Driver__c,
                        Vehicle__c,
                 		(Select SMLine_Status__c
                              From Shipping_Manifest_Lines__r
                              Where SMLine_Status__c NOT IN (:RSMSupport.STATUS_CANCELLED, 
                                                              :RSMSupport.STATUS_REJECTED))
                From Shipping_Manifest__c
                Where Id =: recordId];
    } 
    
    
    
    /**
     * Change Status to TSM status, Actual Arrival time of TSM
     */         
    public void updateTSM() {
        tsmObj.Status__c = STATUS_RECEIVED;
        tsmObj.Actual_Arrival_Date_Time__c = System.now();
        tsmObj.Receiver_Acceptance_Date__c = System.now();
        
        for(Shipping_Manifest_Line__c sml:tsmObj.Shipping_Manifest_Lines__r){
            sml.SMLine_Status__c = RSM_STATUS_SHIPMENT_COMPLETE;
        }
        update tsmObj;
        update tsmObj.Shipping_Manifest_Lines__r;
    }
    
    /**
     * Redirect to TSM detail page
     *
     * @return PageReference
     */         
    public PageReference redirectToTSM() {
        PageReference pageRef = stdController.view().setRedirect(true);
        return pageRef;
    }
    
    /**
     * Perform validation of all required fields of RSM and Lines
     *
     * @return Boolean flag to indicate if any validation fails
     */
    public Boolean checkValidation(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        String missingFieldError = Label.TSM_Mandatory_Fields_Error + '<BR/>';
        
        if(tsmObj.Payment_Terms__c == null){
            hasValidationError = true;
            missingFieldError += '<li>Payment Terms</li>';
        }
        
        if(tsmObj.Driver__c == null){
            hasValidationError = true;
            missingFieldError += '<li>Driver</li>';
        }
        
        if(tsmObj.Vehicle__c == null){
            hasValidationError = true;
            missingFieldError += '<li>Vehicle</li>';
        }
        
        if(hasValidationError){
            message = new ApexPages.Message(ApexPages.Severity.ERROR, missingFieldError);
            ApexPages.addMessage(message);
        }
        return hasValidationError;
    }
}