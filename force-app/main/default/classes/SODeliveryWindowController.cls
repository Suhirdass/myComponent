/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * SODeliveryWindowController
 */
public class SODeliveryWindowController{
    
    private ApexPages.StandardController stdController;
    private Sales_Order__c soObj = null;
    public List<Delivery_Window__c> deliveryWindata {get; set;}
    public  List<DeliveryWindowSupport.DeliveryWindowWrapper> recommendedTimes{get; set;}
    public String recommendedTime{get; set;} public String fuldaydelivery{get; set;}
    public Boolean recommendedTimeMessageFlag {get; set;}
    public String recommendedTimeMessage {get; set;}
    
    // Constructor
    public SODeliveryWindowController(ApexPages.StandardController controller) {
        this.stdController = controller;
        soObj = (Sales_Order__c)stdController.getRecord();
        recommendedTime = '';
        recommendedTimeMessage = '';
        recommendedTimeMessageFlag = false;
    }
    
    /**
     * Get recommended delivery time from delivery window records of related receiver account
     */
    public void getDeliveryTime() {
        if(soObj != null){
            
            // Get receiver name from TSM
            soObj = [Select Planned_Ship_Date__c, Receiver_Name__c from Sales_Order__c Where Id =: soObj.Id];
            
            Date plannedShipDate = system.today();
            
            // If planned ship date is not provided then do early exit
            if(plannedShipDate == null){ recommendedTimeMessageFlag = true;
                recommendedTimeMessage = Label.Planned_ship_date_is_not_provided;
                return;
            }
            
          
            
            // If no receiver found then do early exit
            if(soObj.Receiver_Name__c == null){ recommendedTimeMessageFlag = true;
                recommendedTimeMessage = Label.Receiver_Account_Is_Not_Provided;
                return;
            }
            
            // Get delivery windows from receiver account
            List<Delivery_Window__c> deliveryWindows = DeliveryWindowSupport.getDeliveryWindows(soObj.Receiver_Name__c);
                                     
            // If no delivery windows found then do early exit
            if(deliveryWindows.size() == 0){
                recommendedTimeMessageFlag = true;
                recommendedTimeMessage = Label.No_delivery_window_found;
                return;
            }
            deliveryWindata = new list<Delivery_Window__c>();
            List<DeliveryWindowSupport.DeliveryWindowWrapper> recommendedTimes = DeliveryWindowSupport.getDeliveryTime(plannedShipDate, deliveryWindows);
            for(DeliveryWindowSupport.DeliveryWindowWrapper datas : recommendedTimes){
                deliveryWindata.add(datas.deliveryWindowSO);
            }
            
          
         
        }
    }
}