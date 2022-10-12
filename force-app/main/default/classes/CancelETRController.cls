/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * CancelETRController
 */
public class CancelETRController{

    private ApexPages.StandardController stdController;
    public static final String STATUS_CANCELLED = 'Cancelled'; 
    public Excise_Tax_Receipt__c etrObj {get; set;}
    
    // Constructor
    public CancelETRController(ApexPages.StandardController controller) {
        this.stdController = controller;
        etrObj = (Excise_Tax_Receipt__c)stdController.getRecord();
    }
    
    public class UserException extends Exception{ }
    
    /**
     * Change Status of ETR status and line to cancelled
     */         
    public PageReference cancelETR() {
        
        etrObj = [Select ETR_Status__c, (Select ETRLine_Status__c From Excise_Tax_Receipt_Lines__r)
                  From Excise_Tax_Receipt__c Where Id =: etrObj.Id];
        
        // Check validation if ETR status is not cancelled
        if(etrObj.ETR_Status__c == STATUS_CANCELLED){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,
                                                          Label.Already_Cancelled_ETR);
            ApexPages.addMessage(msg);
            return null;
        }
        
        Savepoint savePoint;
        
        try {
            
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            
            // Update etr and line status as cancelled
            etrObj.ETR_Status__c = STATUS_CANCELLED;
            update etrObj;
         
            List<Excise_Tax_Receipt_Line__c> etrLines = etrObj.Excise_Tax_Receipt_Lines__r;
            for(Excise_Tax_Receipt_Line__c etrLineSO : etrLines){
                etrLineSO.ETRLine_Status__c = STATUS_CANCELLED;
            }
            update etrLines;
            
        }catch (Exception ex){
            Database.rollback(savePoint);
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(msg);
            return null;
        }
        return redirectToETR();
    }
    
    /**
     * Redirect to ETR detail page
     *
     * @return PageReference
     */         
    public PageReference redirectToETR() {
        PageReference pageRef = stdController.view().setRedirect(true);
        return pageRef;
    }
}