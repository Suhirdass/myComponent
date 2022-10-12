public class ProductionWorkOrderTriggerHelper {
    public static List<Holiday> businessHolidays{
        get{
            if(businessHolidays == null){
                businessHolidays = [SELECT Id, Name, Description, ActivityDate, RecurrenceType, RecurrenceMonthOfYear, RecurrenceDayOfMonth, RecurrenceInterval FROM Holiday];
            }
            return businessHolidays;
        }set;
        
    }
    
    public static void updateEarliestPackagingDate(Production_Work_Order__c[] orders, Map<Id,Production_Work_Order__c>oldOrders){
        Set<Date>holidays = new Set<Date>();
        for(Holiday hd:businessHolidays){
            holidays.add(hd.ActivityDate);
        }
        for(Production_Work_Order__c POW: orders){
            if(Trigger.isInsert || (POW.Pick_up_or_Arrival_Date__c != oldOrders.get(POW.Id).Pick_up_or_Arrival_Date__c 
              || POW.Jar_Bag_Arrival_Date__c != oldOrders.get(POW.Id).Jar_Bag_Arrival_Date__c 
              || POW.Label_Arrival_Date__c != oldOrders.get(POW.Id).Label_Arrival_Date__c
              || POW.QA_Compliance_Sign_off_Date__c != oldOrders.get(POW.Id).QA_Compliance_Sign_off_Date__c
              || POW.Scope_Established_Date__c  != oldOrders.get(POW.Id).Scope_Established_Date__c)){
                  List<Date> allDates = new List<Date>();
                  if(POW.Pick_up_or_Arrival_Date__c != null){
                      allDates.add(POW.Pick_up_or_Arrival_Date__c);
                  }
                  if(POW.Jar_Bag_Arrival_Date__c != null){
                      allDates.add(POW.Jar_Bag_Arrival_Date__c);
                  }
                  if(POW.Label_Arrival_Date__c != null){
                      allDates.add(POW.Label_Arrival_Date__c);
                  }
                  if(POW.QA_Compliance_Sign_off_Date__c != null){
                      allDates.add(POW.QA_Compliance_Sign_off_Date__c);
                  }
                  if(POW.Scope_Established_Date__c != null){
                      allDates.add(POW.Scope_Established_Date__c);
                  }
                  allDates.sort();
                  if(allDates.size() > 0){
                      Date maxDate = allDates[allDates.size() -1];
                      DateTime earliestPakcageDate = maxDate.addDays(7);//changed 1 to 7 maxDate.addDays(1)
                      Boolean setPackageDate = false;
                      Date shipDate = null;
                      while(!setPackageDate){
                          shipDate = earliestPakcageDate.dateGMT();
                          if(!holidays.contains(shipDate)){
                              String dayOfWeek=earliestPakcageDate.formatgmt('EEEE');
                              System.debug('##dayOfWeek::'+dayOfWeek);
                              if(dayOfWeek == 'Saturday'){
                                  earliestPakcageDate = earliestPakcageDate.addDays(2);
                              }else if(dayOfWeek == 'Sunday'){
                                  earliestPakcageDate = earliestPakcageDate.addDays(1);
                              }
                              System.debug('##earliestPakcageDate2::'+earliestPakcageDate);
                              shipDate = earliestPakcageDate.dateGMT();
                              dayOfWeek=earliestPakcageDate.formatgmt('EEEE');
                              if(!holidays.contains(shipDate) &&(dayOfWeek != 'Saturday'&&dayOfWeek != 'Sunday')){
                                  setPackageDate = true;
                              }
                              
                          }else{
                              earliestPakcageDate = earliestPakcageDate.addDays(1);
                              setPackageDate = false;
                          }
                      }
                      POW.Earliest_Packaging_Date2__c  = earliestPakcageDate.dateGMT();
                  }
                  
                
            }
        }
    }
}