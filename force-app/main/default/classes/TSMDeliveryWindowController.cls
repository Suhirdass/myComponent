/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * TSMDeliveryWindowController
 */
public class TSMDeliveryWindowController{

    private ApexPages.StandardController stdController;
    private Shipping_Manifest__c tsmObj = null;
    public String recommendedTime{get; set;}
    public Boolean recommendedTimeMessageFlag {get; set;}
    public String recommendedTimeMessage {get; set;}
    
    // Constructor
    public TSMDeliveryWindowController(ApexPages.StandardController controller) {
        this.stdController = controller;
        tsmObj = (Shipping_Manifest__c)stdController.getRecord();
        recommendedTime = '';
        recommendedTimeMessage = '';
        recommendedTimeMessageFlag = false;
    }
    
    /**
     * Get recommended delivery time from delivery window records of related supplier account
     */
    public void getDeliveryTime() {
        if(tsmObj != null){
            
            // Get supplier name from TSM
            tsmObj = [Select Planned_Ship_Transfer_Date__c, Supplier_Name__c from Shipping_Manifest__c Where Id =: tsmObj.Id];
            
            Date plannedTrasferDate = tsmObj.Planned_Ship_Transfer_Date__c;
            
            // If planned transfer date is not provided then do early exit
            if(plannedTrasferDate == null){
                recommendedTimeMessageFlag = true;
                recommendedTimeMessage = Label.Planned_transfer_date_is_not_provided;
                return;
            }
            
            // If planned transfer date is past date then do early exit
            if(plannedTrasferDate < System.Today()){
                recommendedTimeMessageFlag = true;
                recommendedTimeMessage = Label.Planned_ship_transfer_date_is_past_date;
                return;
            }
            
            // If no supplier found then do early exit
            if(tsmObj.Supplier_Name__c == null){
                recommendedTimeMessageFlag = true;
                recommendedTimeMessage = Label.Supplier_Account_Is_Not_Provided;
                return;
            }
            
            // Get delivery windows from supplier account
            List<Delivery_Window__c> deliveryWindows = DeliveryWindowSupport.getDeliveryWindows(tsmObj.Supplier_Name__c);
                                     
            // If no delivery windows found then do early exit
            if(deliveryWindows.size() == 0){
                recommendedTimeMessageFlag = true;
                recommendedTimeMessage = Label.No_delivery_window_found;
                return;
            }
            
            recommendedTime = DeliveryWindowSupport.getDeliveryTime(plannedTrasferDate, deliveryWindows);
        }
    }
}