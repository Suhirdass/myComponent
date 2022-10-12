global class BatchToAutoCancelOrders implements Database.Batchable<sObject>, Database.Stateful, Schedulable{
    
    String statusDraft = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Draft');
    String statusPending = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Pending');
    String ORDERCANCELLED_FILIGREEN = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Filigreen');
    String OrderLineCancelled = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Line Item','Order_Line_Status_Cancelled');
    
    static List<Order__c> updateOrderList = new LIst<Order__c>();
    static List<Order_Line_Item__c> updateOLIList = new LIst<Order_Line_Item__c>();
    
    private static String RECURSYEARLY{
        get{
            return String.isNotBlank(RECURSYEARLY) ? RECURSYEARLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursYearly');
        }set;
    }
    private static String RECURSYEARLYNTH{
        get{
            return String.isNotBlank(RECURSYEARLYNTH) ? RECURSYEARLYNTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursYearlyNth');
        }set;
    }
    private static String HOLIDAY_RECURSMONTHLY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSMONTHLY) ? HOLIDAY_RECURSMONTHLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursMonthly');
        }set;
    }
    private static String HOLIDAY_RECURSMONTHLYNTH{
        get{
            return String.isNotBlank(HOLIDAY_RECURSMONTHLYNTH) ? HOLIDAY_RECURSMONTHLYNTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursMonthlyNth');
        }set;
    }
    private static String HOLIDAY_RECURSWEEKLY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSWEEKLY) ? HOLIDAY_RECURSWEEKLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursWeekly');
        }set;
    }
    private static String HOLIDAY_RECURSDAILY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSDAILY) ? HOLIDAY_RECURSDAILY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursDaily');
        }set;
    }
    private static String HOLIDAY_RECURSEVERYWEEKDAY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSEVERYWEEKDAY) ? HOLIDAY_RECURSEVERYWEEKDAY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursEveryWeekday');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_FIRST{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_FIRST) ? HOLIDAY_RECURRENCE_FIRST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_First');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_SECOND{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_SECOND) ? HOLIDAY_RECURRENCE_SECOND : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Second');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_THIRD{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_THIRD) ? HOLIDAY_RECURRENCE_THIRD : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Third');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_FOURTH{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_FOURTH) ? HOLIDAY_RECURRENCE_FOURTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Fourth');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_LAST{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_LAST) ? HOLIDAY_RECURRENCE_LAST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Last');
        }set;
    }
    private static String JANUARY_MONTH{
        get{
            return String.isNotBlank(JANUARY_MONTH) ? JANUARY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','January_Month');
        }set;
    }
    private static String FEBRUARY_MONTH{
        get{
            return String.isNotBlank(FEBRUARY_MONTH) ? FEBRUARY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','February_Month');
        }set;
    }
    private static String MARCH_MONTH{
        get{
            return String.isNotBlank(MARCH_MONTH) ? MARCH_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','March_Month');
        }set;
    }
    private static String APRIL_MONTH{
        get{
            return String.isNotBlank(APRIL_MONTH) ? APRIL_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','April_Month');
        }set;
    }
    private static String MAY_MONTH{
        get{
            return String.isNotBlank(MAY_MONTH) ? MAY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','May_Month');
        }set;
    }
    private static String JUNE_MONTH{
        get{
            return String.isNotBlank(JUNE_MONTH) ? JUNE_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','June_Month');
        }set;
    }
    private static String JULY_MONTH{
        get{
            return String.isNotBlank(JULY_MONTH) ? JULY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','July_Month');
        }set;
    }
    private static String AUGUST_MONTH{
        get{
            return String.isNotBlank(AUGUST_MONTH) ? AUGUST_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','August_Month');
        }set;
    }
    private static String SEPTEMBER_MONTH{
        get{
            return String.isNotBlank(SEPTEMBER_MONTH) ? SEPTEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','September_Month');
        }set;
    }
    private static String OCTOBER_MONTH{
        get{
            return String.isNotBlank(OCTOBER_MONTH) ? OCTOBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','October_Month');
        }set;
    }
    private static String NOVEMBER_MONTH{
        get{
            return String.isNotBlank(NOVEMBER_MONTH) ? NOVEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','November_Month');
        }set;
    }
    private static String DECEMBER_MONTH{
        get{
            return String.isNotBlank(DECEMBER_MONTH) ? DECEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','December_Month');
        }set;
    }
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
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id,lastmodifieddate,Status__c,Account__c,Account__r.DBA__c,Retailer__c,Name,Retailer__r.Name,Retailer_DBA__c,
                                         Order_Type__c,Total__c,Total_Line_Items__c,
                                         (SELECT Id,Name,OrderLine_Status__c,Line_Total_Qty__c,Product__r.White_Labelled__c,
                                          Product__r.Licensee_Name__c,Product__r.Producer_Name__c,Order__c
                                          FROM Order_Line_Items__r) FROM Order__c WHERE Status__c IN (:statusDraft,:statusPending) ORDER BY createdDate ASC]);
    }
    
    global void execute(Database.BatchableContext bc, List<Order__c> records){
        //List<Holiday> holidays = [Select StartTimeInMinutes, Name, ActivityDate From Holiday];
        List<string>holidayList = new List<string>();
        for(Holiday  businessHolidDay : [SELECT IsRecurrence,ActivityDate,RecurrenceMonthOfYear,RecurrenceEndDateOnly,RecurrenceInstance,RecurrenceDayOfWeekMask,RecurrenceInterval,RecurrenceType FROM Holiday]){
            if(businessHolidDay.IsRecurrence){
            	holidayList.addAll(getAllRecurrenceHoliday(businessHolidDay));
            }else{
            	holidayList.add(String.valueOf(businessHolidDay.ActivityDate)/*getDateStr(businessHolidDay.ActivityDate)*/);   
            }    
        }
        
        Savepoint savePoint;
        try{
            savePoint = Database.setSavepoint();
            
            Set<Id> brandIds = new Set<Id>();
            
            for(Order__c ord: records){
                Integer allDaysBetween;
                if(!Test.isRunningTest()){
                    allDaysBetween = ord.lastmodifieddate.Date().daysBetween(Date.today());
                } else {
                    allDaysBetween = 90;
                }
                
                Integer allWorkingDays = 0;
                for(Integer k=0;k<allDaysBetween ;k++ ){
                    if(checkifItisWorkingDay(ord.lastmodifieddate.Date().addDays(k),holidayList)){
                        allWorkingDays++;
                    }
                }
                if((ord.Status__c == statusDraft && allWorkingDays > AUTO_CANCEL_DAYS_DRAFT) || 
                   (ord.Status__c == statusPending && allWorkingDays > AUTO_CANCEL_DAYS_PENDING)){
                       ord.Status__c = ORDERCANCELLED_FILIGREEN;
                       for(Order_Line_Item__c oli : ord.Order_Line_Items__r){
                           oli.OrderLine_Status__c = OrderLineCancelled;
                           updateOLIList.add(oli);
                           
                           if(oli.Product__r.White_Labelled__c == true){
                               if(oli.Product__r.Licensee_Name__c != null && !brandIds.contains(oli.Product__r.Licensee_Name__c)){
                                   brandIds.add(oli.Product__r.Licensee_Name__c);
                               }
                           }else{
                               if(oli.Product__r.Producer_Name__c != null && !brandIds.contains(oli.Product__r.Producer_Name__c)){
                                   brandIds.add(oli.Product__r.Producer_Name__c);
                               }
                           }
                       }
                       //brandIds.add(ord.Retailer__c);
                       updateOrderList.add(ord);
                   }
            }
            if(brandIds.size() > 0){
                sendEmails(brandIds);
            }
            
            if(updateOrderList.size() > 0) update updateOrderList;
            if(updateOLIList.size() > 0) update updateOLIList;
            
        } catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('BatchToAutoCancelOrders', ex.getStackTraceString(), ex.getMessage());
        }
    }
    
    
    public static void sendEmails(Set<Id> brandIds){
        orgwideemailaddress orgWide = [select Id,Address, displayName from orgwideemailaddress where displayName =: 'DL-Orders' limit 1]; 
        /*Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        EmailTemplate emailTemplate = [select Id, Body from EmailTemplate where DeveloperName = 'Auto_Cancel_Order'];
        
        List<String> toAddress = new List<String>();
        toAddress.addAll(label.DL_ASR.split(','));
        mail.setToAddresses(toAddress);
        mail.setSaveAsActivity(false);
        mail.setTemplateId(emailTemplate.Id);
        mail.setTargetObjectId(UserInfo.getUserId());
        if(orgWide != null) mail.setOrgWideEmailAddressId(orgWide.Id);
        Messaging.sendEmail(new Messaging.Singleemailmessage [] {mail});*/
        
        if(brandIds.size() > 0){
            
            Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{};
            
            for(Account acc : [SELECT Id,Name,(SELECT Id,FirstName FROM Contacts WHERE Active__c = true AND Email != NULL) FROM Account WHERE Id IN :brandIds]){
            	List<Order__c> lstOrd = new List<Order__c>();
                Set<Id> orderIds = new Set<Id>();
                for(Order_Line_Item__c oli : updateOLIList){
                    if(oli.Product__r.White_Labelled__c == true){
                        if(oli.Product__r.Licensee_Name__c != null && oli.Product__r.Licensee_Name__c == acc.Id){
                            orderIds.add(oli.Order__c);
                        }
                    }else{
                        if(oli.Product__r.Producer_Name__c != null && oli.Product__r.Producer_Name__c == acc.Id){
                            orderIds.add(oli.Order__c);
                        }
                    }
                }
                System.debug('orderIds = '+orderIds.size());
                for(Order__c ord : updateOrderList){
                    if(orderIds.contains(ord.Id)){
                        lstOrd.add(ord);
                    }
                }
                System.debug('lstOrd = '+lstOrd.size());
                if(lstOrd.size() > 0){
                    
                    String itemsHTML = '<table cellspacing="0" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Order</th><th style="border:1px solid #000">Status</th><th style="border:1px solid #000">Order Type</th><th style="border:1px solid #000">Supplier</th><th style="border:1px solid #000">Retailer</th><th style="border:1px solid #000">DBA</th>'
                        +'<th style="border:1px solid #000">Total Price</th><th style="border:1px solid #000">Total Lines</th><th style="border:1px solid #000">Last Modified Date</th></tr>';
                    
                    for(Order__c ord: lstOrd){
                        itemsHTML +='<tr style="border:1px solid #000">'
                            +'<td style="border:1px solid #000;padding:5px;font-size: 11px;"><a href="'+Label.Org_URL+''+ord.Id+'">'+ ord.Name+'</a></td>'
                            +'<td style="border:1px solid #000;padding:5px;font-size: 11px;">'+ord.Status__c+'</td>'
                            +'<td style="border:1px solid #000;padding:5px;font-size: 11px;">'+ord.Order_Type__c+'</td>'
                            +'<td style="border:1px solid #000;padding:5px;font-size: 11px;">'+ord.Account__r.DBA__c+'</td>'
                            +'<td style="border:1px solid #000;padding:5px;font-size: 11px;">'+ord.Retailer__r.Name+'</td>'
                            +'<td style="border:1px solid #000;padding:5px;font-size: 11px;">'+ord.Retailer_DBA__c+'</td>'
                            +'<td style="border:1px solid #000;padding:5px;font-size: 11px;">$'+getFormattedCurrency(ord.Total__c)+'</td>'
                            +'<td style="border:1px solid #000;padding:5px;font-size: 11px;">'+ord.Total_Line_Items__c+'</td>'
                            +'<td style="border:1px solid #000;padding:5px;font-size: 11px;">'+ord.lastmodifieddate.Month()+'/'+ord.lastmodifieddate.day()+'/'+ord.lastmodifieddate.year()+'</td></tr>';
                    }   
                    
                    itemsHTML +='</table>';
                    System.debug('acc.Contacts = '+acc.Id);
                	/*if(acc.Contacts != null && acc.Contacts.size() > 0){	
                        for(Contact con: acc.Contacts){
                            System.debug('con = '+con);
                            String htmlBody = 'Hello '+con.FirstName+',<br><br>The following orders have auto cancelled in Salesforce.<br><br>';
                            htmlBody +=itemsHTML;
                            Messaging.SingleEmailMessage mailCon = new Messaging.SingleEmailMessage();
                            mailCon.setSubject('Marketplace Order: Auto Cancellation - '+Date.today().Month()+'/'+Date.today().day()+'/'+Date.today().year());
                            mailCon.setHtmlBody(htmlBody); 
                            mailCon.setTargetObjectId(con.Id);
                            List<String> ccEmails = label.DL_ASR.split(',');
                            mailCon.setCcAddresses(ccEmails); 
                            emails.add(mailCon);
                        }
                    } else {*/
                        String htmlBody = 'Hello,<br><br>The following orders have auto cancelled in Salesforce.<br><br>';
                        htmlBody +=itemsHTML;
                        Messaging.SingleEmailMessage mailCon = new Messaging.SingleEmailMessage();
                        mailCon.setSubject('Marketplace Order: Auto Cancellation - '+Date.today().Month()+'/'+Date.today().day()+'/'+Date.today().year());
                        mailCon.setHtmlBody(htmlBody); 
                        List<String> toAddress = new List<String>();
                        toAddress.addAll(label.DL_ASR.split(','));
                        mailCon.setToAddresses(toAddress);
                        mailCon.setSaveAsActivity(false);
                        mailCon.setTargetObjectId(UserInfo.getUserId());
                        if(orgWide != null) mailCon.setOrgWideEmailAddressId(orgWide.Id);
                        emails.add(mailCon);
                    //}
                }
            }
        
            if(emails.size() > 0){
                System.debug('###notifyOnNewRetailerOrder...'+emails.size());
                try{
                    Messaging.sendEmail(emails);
                } catch(Exception ex){}
            }
        }
    }
    
    private static String getFormattedCurrency(Decimal x){
        String formattedValue = '';
        if(x == null){
            x = 0;
        }
        x = x.setScale(2);
        String y = String.valueOf(x);
        String z = '.';
        if(y.contains(',')) z = ',';
        y = y.substring(0, y.indexOf(z));
        if(x - Decimal.valueOf(y) == 0)
            formattedValue =  String.valueOf(x.format()) + z + '00';
        else formattedValue = String.valueOf(x.format());
        String[] values = formattedValue.split('\\.');
        if(values.size() == 1){
            formattedValue += '.00';
        }else if(values.size() == 2){
            String last = values[1];
            if(last.length() ==1){
                last += '0';
                values[1] = last;
            }
            formattedValue = String.join(values,'.');
        }
        
        return formattedValue;
    }
    
    Public  static integer getMonthNumber(string monthName){
        if(monthName == JANUARY_MONTH){
            return 1;
        }else if(monthName == FEBRUARY_MONTH){
            return 2;
        }else if(monthName == MARCH_MONTH){
            return 3;
        }else if(monthName == APRIL_MONTH){
            return 4;
        }else if(monthName == MAY_MONTH){
            return 5;
        }else if(monthName == JUNE_MONTH){
            return 6;
        }else if(monthName == JULY_MONTH){
            return 7;
        }else if(monthName == AUGUST_MONTH){
            return 8;
        }else if(monthName == SEPTEMBER_MONTH){
            return 9;
        }else if(monthName == OCTOBER_MONTH){
            return 10;
        }else if(monthName == NOVEMBER_MONTH){
            return 11;
        }else if(monthName == DECEMBER_MONTH){
            return 12;
        }return 1;
    }
    
    Public  static Date getHolidayDate(Date todayDt,Holiday businessHolidDay){
        if(businessHolidDay.RecurrenceDayOfWeekMask == 127){
            integer year = todayDt.year();
            integer month = getMonthNumber(businessHolidDay.RecurrenceMonthOfYear);
            integer day = 0;
            if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_FIRST){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_SECOND){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_THIRD){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_FOURTH){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_LAST){
                day = Date.daysInMonth(year, month);  
            } 
            return Date.newInstance(year,month,day);
        }else{
            date dt = todayDt;            
            Date weekDay = todayDt.toStartOfMonth().toStartOfWeek(); 
            
            if(businessHolidDay.RecurrenceDayOfWeekMask == 2)
                weekDay = weekDay.addDays(1);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 4)
                weekDay = weekDay.addDays(2);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 8)
                weekDay = weekDay.addDays(3);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 16)
                weekDay = weekDay.addDays(4);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 32)
                weekDay = weekDay.addDays(5);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 64)
                weekDay = weekDay.addDays(6);  
            
            if((todayDt.month() > 1 && weekDay.month() < todayDt.month()) || (todayDt.month() == 1 && weekDay.month() == 12))
                weekDay = weekDay.addDays(7);
            
            if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_SECOND){
                weekDay = weekDay.addDays(7);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_THIRD){
                weekDay = weekDay.addDays(14);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_FOURTH){
                weekDay = weekDay.addDays(21);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_LAST){
                weekDay = weekDay.addDays(28);        
            }
            
            if((todayDt.month() < 12 && weekDay.month() > todayDt.month()) || (todayDt.month() == 12 && weekDay.month() == 1))
                weekDay = weekDay.addDays(-7);
            return weekDay;
        }
    }
    
    public static list<String> getAllRecurrenceHoliday(Holiday businessHolidDay){
    	List<string>holidayList = new List<string>();
        date todayDt = businessHolidDay.ActivityDate;
        date holidayEndDt = businessHolidDay.RecurrenceEndDateOnly != null ? businessHolidDay.RecurrenceEndDateOnly : system.today();
        
        while(todayDt <= holidayEndDt){
        	if(businessHolidDay.RecurrenceType == RECURSYEARLY){
                todayDt = todayDt.addYears(1);
            }else if(businessHolidDay.RecurrenceType == RECURSYEARLYNTH){
                todayDt = todayDt.addYears(1);
                todayDt = getHolidayDate(todayDt,businessHolidDay);        
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSMONTHLY){
            	todayDt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);
                todayDt = getHolidayDate(todayDt,businessHolidDay);        
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSMONTHLYNTH){
            	date dt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);      
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSWEEKLY){
            	todayDt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);        
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSDAILY){
                todayDt = todayDt.addDays(businessHolidDay.RecurrenceInterval);
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSEVERYWEEKDAY){
            	todayDt = todayDt.addDays(1);
            }    
            holidayList.add(String.valueOf(todayDt)/*getDateStr(todayDt)*/);       
        }
        return holidayList;
    }
    
    Public  static string getDateStr(Date holidayDate){
    	string dtStr = holidayDate.month()+'-'+holidayDate.Day()+'-'+holidayDate.year();  
        return dtStr;
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
    
	global void finish(Database.BatchableContext bc){ } 
    
    global void execute(SchedulableContext sc){}
}