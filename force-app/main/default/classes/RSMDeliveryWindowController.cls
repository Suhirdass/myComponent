/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * RSMDeliveryWindowController
 */
public class RSMDeliveryWindowController{

    private ApexPages.StandardController stdController;
    private Shipping_Manifest__c rsmObj = null;
    public String recommendedTime{get; set;}
    public Boolean recommendedTimeMessageFlag {get; set;}
    public String recommendedTimeMessage {get; set;}
    
    // Constructor
    public RSMDeliveryWindowController(ApexPages.StandardController controller) {
        this.stdController = controller;
        rsmObj = (Shipping_Manifest__c)stdController.getRecord();
        recommendedTime = '';
        recommendedTimeMessage = '';
        recommendedTimeMessageFlag = false;
    }
    
    /**
     * Get recommended delivery time from delivery window records of related receiver account
     */
    public void getDeliveryTime() {
        if(rsmObj != null){
            
            // Get receiver name from RSM
            rsmObj = [Select Planned_Ship_Transfer_Date__c, Receiver_Name__c from Shipping_Manifest__c Where Id =: rsmObj.Id];
            
            Date plannedShipDate = rsmObj.Planned_Ship_Transfer_Date__c;
            
            // If planned ship date is not provided then do early exit
            if(plannedShipDate == null){
                recommendedTimeMessageFlag = true;
                recommendedTimeMessage = Label.Planned_ship_date_is_not_provided;
                return;
            }
            
            // If planned ship date is past date then do early exit
            if(plannedShipDate < System.Today()){
                recommendedTimeMessageFlag = true;
                recommendedTimeMessage = Label.Planned_ship_transfer_date_is_past_date;
                return;
            }
            
            // If no receiver found then do early exit
            if(rsmObj.Receiver_Name__c == null){
                recommendedTimeMessageFlag = true;
                recommendedTimeMessage = Label.Receiver_Account_Is_Not_Provided;
                return;
            }
            
            // Get delivery windows from receiver account
            List<Delivery_Window__c> deliveryWindows = DeliveryWindowSupport.getDeliveryWindows(rsmObj.Receiver_Name__c);
                                     
            // If no delivery windows found then do early exit
            if(deliveryWindows.size() == 0){
                recommendedTimeMessageFlag = true;
                recommendedTimeMessage = Label.No_delivery_window_found;
                return;
            }
            
            recommendedTime = DeliveryWindowSupport.getDeliveryTime(plannedShipDate, deliveryWindows);
        }
    }
}