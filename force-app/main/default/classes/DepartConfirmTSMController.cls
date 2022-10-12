/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * DepartConfirmTSMController
 */
public class DepartConfirmTSMController{
      public static String errorMessage;
 public static String validateerrorMessage;
    private ApexPages.StandardController stdController;
    private Shipping_Manifest__c tsmObj = null;
    
    private static final String STATUS_IN_TRASIT = TSMSupport.STATUS_IN_TRASIT; 
    private static final String STATUS_RECEIVED = TSMSupport.STATUS_RECEIVED; 
      public Static String ERR_MSG_TSM_RECEIVED{
        get{
            return String.isNotBlank(ERR_MSG_TSM_RECEIVED) ? ERR_MSG_TSM_RECEIVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_TSM_Already_Received');
        }set;
    }
         public Static String ERR_MSG_COMPLETE_DEPART_CONFIRM{
        get{
            return String.isNotBlank(ERR_MSG_COMPLETE_DEPART_CONFIRM) ? ERR_MSG_COMPLETE_DEPART_CONFIRM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Complete_Depart_Confirm_TSM');
        }set;
    }
       public Static String SHIPPING_MANIFEST_STATUS_DRAFT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_DRAFT) ? SHIPPING_MANIFEST_STATUS_DRAFT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Draft');
        }set;
    }
      public Static String SHIPPING_MANIFEST_STATUS_PENDING{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_PENDING) ? SHIPPING_MANIFEST_STATUS_PENDING: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_ShipmentPending');
        }set;
    }
     private Static String ERR_MSG_ASSIGN_DRIVER_AND_VEHICLES{
        get{
            return String.isNotBlank(ERR_MSG_ASSIGN_DRIVER_AND_VEHICLES) ? ERR_MSG_ASSIGN_DRIVER_AND_VEHICLES: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_assign_Driver_And_Vehicle');
        }set;
    }
    // Constructor
    public DepartConfirmTSMController(ApexPages.StandardController controller) {
        this.stdController = controller;
        tsmObj = (Shipping_Manifest__c)stdController.getRecord();
    }
    
    public class UserException extends Exception{ }
    
    
    
        
    public DepartConfirmTSMController()
        
    {
        
    }
    
      @AuraEnabled
    public static AuraResponse DepartConfirmTSMControllertsmlt (String recordId) {
        
        AuraResponse r = new AuraResponse('shipConfirmlt()');
        DepartConfirmTSMController assign = new DepartConfirmTSMController();
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
            
            List<Shipping_Manifest__c>SMList = [SELECT Id,Brand_Quote__c FROM Shipping_Manifest__c WHERE Id =: recordId];
            List<Brand_Quote__c>BQList = [SELECT Id,(SELECT Id FROM Purchase_Orders__r) FROM Brand_Quote__c WHERE Id =: SMList[0].Brand_Quote__c];
            if(BQList.size() > 0){
            	for(Purchase_Order__c PO : BQList[0].Purchase_Orders__r){
                    PO.Flash_Title_Date__c = system.now();
            	}   
                update BQList[0].Purchase_Orders__r;
            }
            
        }catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('DepartConfirmController:departConfirm()', ex.getStackTraceString(), ex.getMessage());
        }
        return r;
    } 
     
    public Boolean checkValidation2(){
        
        Boolean hasValidationError = false;
         if(tsmObj.Status__c == SHIPPING_MANIFEST_STATUS_DRAFT){
            validateerrorMessage = ERR_MSG_ASSIGN_DRIVER_AND_VEHICLES;
            hasValidationError = true;
            
        }
     else if(tsmObj.Actual_Departure_Date_Time__c != null){
            validateerrorMessage = Label.Departure_Date_Already_Provided;
            hasValidationError = true;
            
        }
        
       
        
        
        return hasValidationError;
    } 
    
    /**
     * Change Status to TSM status, Actual Departure time of TSM
     *
     * @return PageReference of TSM detail page
     */
    public PageReference departConfirm() {
        PageReference pageRef = null;
        Savepoint savePoint;
        
        try {
            
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            
            tsmObj = retrieveTSM();
            
            // Check if Departure Date and Time is already provided or not
            if(tsmObj.Actual_Departure_Date_Time__c != null){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,
                                                              Label.Departure_Date_Already_Provided);
                ApexPages.addMessage(msg);
                return null;
            
            // Check if Picklist is QA Confirm or not
            } else if(tsmObj.Picklist__c != null && tsmObj.Picklist__r.Status__c != PicklistSupport.STATUS_QA_CONFIRM){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,
                                                              Label.Picklist_Is_Not_QA_Confirm);
                ApexPages.addMessage(msg);
                return null;
            }
            
            // Check validation if TSM status is not Received
            if(tsmObj.Status__c != STATUS_RECEIVED){
                if(checkValidation()){
                    return null;
                }
            }else{
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,
                                                              Label.Already_TSM_Received);
                ApexPages.addMessage(msg);
                return null;
            }
            
            updateTSM();
            
            List<Brand_Quote__c>BQList = [SELECT Id,(SELECT Id FROM Purchase_Orders__r) FROM Brand_Quote__c WHERE Id =: tsmObj.Brand_Quote__c];
            if(BQList.size() > 0){
            	for(Purchase_Order__c PO : BQList[0].Purchase_Orders__r){
                    PO.Flash_Title_Date__c = system.now();
            	}   
                update BQList[0].Purchase_Orders__r;
            }
        } 
        catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('DepartConfirmTSMController:departConfirm()', 
                          ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(msg);
            return null;
        }
        return redirectToTSM();
    }

     public static Shipping_Manifest__c retrieveTSMlt( id recordId) {
        return  [Select Status__c,
                        Actual_Arrival_Date_Time__c,
                        Actual_Departure_Date_Time__c,
                        Payment_Terms__c,
                        Driver__c,
                        Vehicle__c,
                        Picklist__r.Status__c
                From Shipping_Manifest__c
                Where Id =: recordId];
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
                 		Brand_Quote__c,
                        Picklist__r.Status__c
                From Shipping_Manifest__c
                Where Id =: tsmObj.Id];
    }
    
    /**
     * Change Status to TSM status, Actual Departure time of TSM
     */         
    public void updateTSM() {
        tsmObj.Status__c = STATUS_IN_TRASIT;
        tsmObj.Actual_Departure_Date_Time__c = System.now();
        update tsmObj;
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
        if(tsmObj.Status__c != 'Approved'){
            hasValidationError = true;
            missingFieldError += '<li>Submit TSM for Approval</li>';
        }
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