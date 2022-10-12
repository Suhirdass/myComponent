/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * DeliveryWindowSupport
 */
public class DeliveryWindowSupport{

    /**
     * Get delivery windows related to account
     *
     * @param accountId The account id to get related delivery windows
     *
     * @return The list of delivery windows
     */
    public static List<Delivery_Window__c> getDeliveryWindows(Id accountId){
        List<Delivery_Window__c> deliveryWindows = new List<Delivery_Window__c>();
        deliveryWindows = [Select Delivery_Day__c,
                                  Earliest_Delivery_Window__c,
                                  Full_Day_Delivery__c,
                                  Last_Delivery_Window__c
                                  From Delivery_Window__c
                                  Where Account__c =:accountId ORDER by Name];
        return deliveryWindows;
    }
    
    /**
     * Get recommended delivery time from delivery window records of related account
     * plannedShipDate - The planned date to deliver
     * deliveryWindows - The list of delivery windows to display recommended delivery time
     *
     * @return recommended delivery time
     */
    public static List<DeliveryWindowSupport.DeliveryWindowWrapper> getDeliveryTime(Date plannedShipDate, List<Delivery_Window__c> deliveryWindows) {
        String recommendedTime = '';
        
        Map<Integer, String> dayMap = new Map<Integer, String>();
        dayMap.put(0, 'Monday');
        dayMap.put(1, 'Tuesday');
        dayMap.put(2, 'Wednesday');
        dayMap.put(3, 'Thursday');
        dayMap.put(4, 'Friday');
        dayMap.put(5, 'Saturday');
        dayMap.put(6, 'Sunday');

        Map<String, Integer> dayNumberMap = new Map<String, Integer>();
        dayNumberMap.put('Monday', 0);
        dayNumberMap.put('Tuesday', 1);
        dayNumberMap.put('Wednesday', 2);
        dayNumberMap.put('Thursday', 3);
        dayNumberMap.put('Friday', 4);
        dayNumberMap.put('Saturday', 5);
        dayNumberMap.put('Sunday', 6);
        
        Datetime dt = DateTime.newInstance(plannedShipDate, Time.newInstance(0, 0, 0, 0));
        String dayOfPlannedShipDate = dt.format('EEEE');
        Integer plannedShipDayNumber = dayNumberMap.get(dayOfPlannedShipDate);
        Set<Id> matchingDeliveryWindows = new Set<Id>();
        Boolean infoFlag = false;
        
        List<DeliveryWindowWrapper> orderedDeliveryWindowList = new List<DeliveryWindowWrapper>();
        List<DeliveryWindowWrapper> finalOrderedDeliveryWindowList = new List<DeliveryWindowWrapper>();
        
        List<Holiday> holidays = [Select Name, 
                                         ActivityDate, 
                                         IsAllDay, 
                                         IsRecurrence, 
                                         RecurrenceDayOfMonth, 
                                         RecurrenceDayOfWeekMask, 
                                         RecurrenceEndDateOnly, 
                                         RecurrenceInstance, 
                                         RecurrenceInterval, 
                                         RecurrenceMonthOfYear, 
                                         RecurrenceStartDate, 
                                         RecurrenceType 
                                  FROM Holiday
                                  WHERE IsRecurrence = true OR ActivityDate = THIS_YEAR];
        
        // Sort delivery windows based on day - Monday, Tuesday etc.
        for(Integer dayKey : dayMap.keySet()){
            for(Delivery_Window__c deliveryWindowSO : deliveryWindows){
                if(dayMap.get(dayKey) == deliveryWindowSO.Delivery_Day__c){
                    DeliveryWindowWrapper deliveryWindowObj = new DeliveryWindowWrapper();
                    deliveryWindowObj.orderedDay = deliveryWindowSO.Delivery_Day__c;
                    deliveryWindowObj.orderedNumber = dayKey;
                    deliveryWindowObj.orderedDate = plannedShipDate;
                    deliveryWindowObj.deliveryWindowSO = deliveryWindowSO;
                    orderedDeliveryWindowList.add(deliveryWindowObj);
                }
            }
        }
        // Prepare list to display delivery windows based on following order
        // i.e. Planned ship date is Wednesday
        // Matching delivery window first - Wednesday
        // Future delivery window - Thursday, Friday etc.
        // Past delivery window - Monday, Tuesday
        
        Boolean matchingDeliveryWindowFound = false;
     
        // Prepare text to display delivery window
        for(DeliveryWindowWrapper deliveryWindowWrapperObj : orderedDeliveryWindowList){
                
            if(!deliveryWindowWrapperObj.matchingDeliveryWindow && !infoFlag){
                recommendedTime += '<b>Additional Delivery windows:</b> <br/><br/>';
                infoFlag = true;
            }
            
            recommendedTime += deliveryWindowWrapperObj.orderedDate.format();
            recommendedTime += '(' + deliveryWindowWrapperObj.orderedDay + ') - ';
            
            if(deliveryWindowWrapperObj.deliveryWindowSO.Full_Day_Delivery__c){
                recommendedTime += '5 AM PST To 10 PM PST';
            }else{
                recommendedTime += deliveryWindowWrapperObj.deliveryWindowSO.Earliest_Delivery_Window__c;
                recommendedTime += ' To ';
                recommendedTime += deliveryWindowWrapperObj.deliveryWindowSO.Last_Delivery_Window__c;
            }
            
            if(deliveryWindowWrapperObj.isHoliday){
                recommendedTime += ' (' + deliveryWindowWrapperObj.holidayName + ' - Holiday)';
            }
            recommendedTime += '<br/><br/>'; 
        }
        return orderedDeliveryWindowList;
    }
    
    // Wrapper class for delivery window parameters
    public class DeliveryWindowWrapper{
        public Integer orderedNumber {get; set;}
        public String orderedDay {get; set;}
        public Date orderedDate {get; set;}
        public Boolean isHoliday {get; set;}
        public String holidayName {get; set;}
        public Boolean matchingDeliveryWindow {get; set;}
        public Delivery_Window__c deliveryWindowSO;
        
        public DeliveryWindowWrapper(){
            isHoliday = false;
            matchingDeliveryWindow = false;
        }
    }
}