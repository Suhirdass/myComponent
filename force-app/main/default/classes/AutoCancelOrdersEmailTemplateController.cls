public class AutoCancelOrdersEmailTemplateController {
    
    public List<Order__c> orders {set;get;}
    
    String statusDraft = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Draft');
    String statusPending = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Pending');
    private static Integer AUTO_CANCEL_DAYS_DRAFT{
        get{
            return AUTO_CANCEL_DAYS_DRAFT != null ? AUTO_CANCEL_DAYS_DRAFT : Integer.valueOf(FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Auto_Cancel_Days_Draft'));
        }set;
    }
    private static Integer AUTO_CANCEL_DAYS_PENDING{
        get{
            return AUTO_CANCEL_DAYS_PENDING != null ? AUTO_CANCEL_DAYS_PENDING : Integer.valueOf(FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Auto_Cancel_Days_Pending'));
        }set;
    }
    
    public AutoCancelOrdersEmailTemplateController(){
        orders = new List<Order__c>();
        List<Order__c> lstOrd = [SELECT Id,lastmodifieddate,Status__c,Name,Retailer__r.Name,Retailer_DBA__c,
                                 Order_Type__c,Total__c,Total_Line_Items__c,
                                 (SELECT Id,Name,OrderLine_Status__c,Line_Total_Qty__c FROM Order_Line_Items__r)
                                 FROM Order__c WHERE Status__c IN (:statusDraft,:statusPending) ORDER BY createdDate ASC];
        if(lstOrd.size() > 0){
            List<string>holidayList = new List<string>();
            for(Holiday  businessHolidDay : [SELECT IsRecurrence,ActivityDate,RecurrenceMonthOfYear,RecurrenceEndDateOnly,RecurrenceInstance,RecurrenceDayOfWeekMask,RecurrenceInterval,RecurrenceType FROM Holiday]){
                if(businessHolidDay.IsRecurrence){
                    holidayList.addAll(BatchToAutoCancelOrders.getAllRecurrenceHoliday(businessHolidDay));
                }else{
                    holidayList.add(String.valueOf(businessHolidDay.ActivityDate)/*getDateStr(businessHolidDay.ActivityDate)*/);   
                }    
            }
            
            List<Order__c> updateOrderList = new LIst<Order__c>();
            List<Order_Line_Item__c> updateOLIList = new LIst<Order_Line_Item__c>();
                
            for(Order__c ord: lstOrd){
                Integer allDaysBetween = ord.lastmodifieddate.Date().daysBetween(Date.today());
                Integer allWorkingDays = 0;
                for(Integer k=0;k<allDaysBetween ;k++ ){
                    if(checkifItisWorkingDay(ord.lastmodifieddate.Date().addDays(k),holidayList)){
                        allWorkingDays++;
                    }
                }
                if(ord.Status__c == statusDraft && allWorkingDays > AUTO_CANCEL_DAYS_DRAFT){
                    orders.add(ord);
                } else if(ord.Status__c == statusPending && allWorkingDays > AUTO_CANCEL_DAYS_PENDING){
                    orders.add(ord);
                } 
            }
        }
    }
    
    public boolean checkifItisWorkingDay(Date currentDate,List<String> holidays){
        Date weekStart  = currentDate.toStartofWeek();
        for(String hDay : holidays){
            if(currentDate.daysBetween(Date.valueOf(hDay)) == 0){
                return false;
            }
        }
        if(weekStart.daysBetween(currentDate) ==0 || weekStart.daysBetween(currentDate) == 6){
            return false;
        } else
            return true;
    }
}