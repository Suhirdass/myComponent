/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * CancelRSMLineController
 */
public class CancelRSMLineController{

    private ApexPages.StandardController stdController;
    private Shipping_Manifest_Line__c rsmLineObj = null;
    
    private static final String STATUS_Cancelled = RSMSupport.STATUS_Cancelled; 
    private static final String STATUS_SHIPMENT_COMPLETE = RSMSupport.STATUS_SHIPMENT_COMPLETE; 
    
    // Constructor
    public CancelRSMLineController(ApexPages.StandardController controller) {
        this.stdController = controller;
        rsmLineObj = (Shipping_Manifest_Line__c)stdController.getRecord();
    }
    
    public class UserException extends Exception{ }
    
    /**
     * Change Status of RSMLine status update inventory location of inventory position to receiving inspection
     *
     * @return PageReference of RSMLine detail page
     */
    public PageReference cancelRSMLine() {
        PageReference pageRef = null;
        Savepoint savePoint;
        
        try {
            
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            
            rsmLineObj = RSMSupport.retrieveRSMLine(rsmLineObj.Id);
            
            // Check validation if RSMLine status is not Received
            if(rsmLineObj.SMLine_Status__c == STATUS_Cancelled){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,
                                                              Label.Already_RSMLine_Cancelled);
                ApexPages.addMessage(msg);
                return null;
            } else if(rsmLineObj.Shipping_Manifest__r.Status__c == STATUS_SHIPMENT_COMPLETE){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,
                                                              Label.Cannot_Cancel_RSMLine);
                ApexPages.addMessage(msg);
                return null;
            }
            
            updateRSMLine();
        } 
        catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('CancelRSMLineController:cancelRSMLine()', 
                          ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(msg);
            return null;
        }
        return redirectToRSMLine();
    }

    /**
     * Change Status to RSMLine status, Actual Departure time of RSMLine
     */         
    public void updateRSMLine() {        
        rsmLineObj.SMLine_Status__c = STATUS_Cancelled;        
        update rsmLineObj;

        // Check if all RSM Lines related to RSM are cancelled or not. 
        // If cancelled then update RSM header as cancelled
        Shipping_Manifest__c rsmObj = RSMSupport.retrieveRSM(rsmLineObj.Shipping_Manifest__c);
        Boolean allCancelledRSMLine = true;
        if(rsmObj.Shipping_Manifest_Lines__r != null){
            for(Shipping_Manifest_Line__c smLine : rsmObj.Shipping_Manifest_Lines__r){
                if(smLine.SMLine_Status__c != STATUS_Cancelled){
                    allCancelledRSMLine = false;
                    break;
                }
            }
            if(allCancelledRSMLine){
                rsmObj.Status__c = STATUS_Cancelled;        
                update rsmObj;
            }
        }
        RSMSupport.updateInvPositionsAndSOLines(new List<Shipping_Manifest_Line__c>{rsmLineObj}, allCancelledRSMLine);
    }
    
    /**
     * Redirect to RSMLine detail page
     *
     * @return PageReference
     */         
    public PageReference redirectToRSMLine() {
        PageReference pageRef = stdController.view().setRedirect(true);
        return pageRef;
    }
}