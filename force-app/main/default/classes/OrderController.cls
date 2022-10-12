public without sharing class OrderController {
    Public Static String SHIPPING_MANIFEST_STATUS_COMPLETE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_COMPLETE) ? SHIPPING_MANIFEST_STATUS_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Complete');
        }set;
    }
    Public Static String SHIPPING_MANIFEST_STATUS_INTRANSIT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_INTRANSIT) ? SHIPPING_MANIFEST_STATUS_INTRANSIT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_InTransit');
        }set;
    }
    private static String TYPE_ADD_BRAND_CONTACT{
        get{
            return String.isNotBlank(TYPE_ADD_BRAND_CONTACT) ? TYPE_ADD_BRAND_CONTACT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Retailer_Related_Contact__c','Type_Add_Brand_Contact');
        }set;
    }
    private static String DL_ASR{
        get{
            return String.isNotBlank(DL_ASR) ? DL_ASR : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','DL_ASR');
        }set;
    }
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
    private static String EARLIEST_DELIVERY_TIME {
        get{
            return String.isNotBlank(EARLIEST_DELIVERY_TIME) ? EARLIEST_DELIVERY_TIME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Earliest_Delivery_Time');
        }set;
    }
    private static String LATEST_DELIVERY_TIME { 
        get{
            return String.isNotBlank(LATEST_DELIVERY_TIME) ? LATEST_DELIVERY_TIME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Latest_Delivery_Time');
        }set;
    }
    private static String Order_Status_Shipped { 
        get{
            return String.isNotBlank(Order_Status_Shipped) ? Order_Status_Shipped : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Shipped');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_CANCELLED) ? SHIPPING_MANIFEST_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Cancelled');
        }set;
    }
    private Static String SO_Status_Cancelled{
        get{
            return String.isNotBlank(SO_Status_Cancelled) ? SO_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Cancelled');
        }set;
    }
    private Static String STATUS_SALESORDERLINECANCELLED{
        get{
            return String.isNotBlank(STATUS_SALESORDERLINECANCELLED) ? STATUS_SALESORDERLINECANCELLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SalesOrderLines_Cancelled');
        }set;
    }
    private Static String Order_Status_Approved{
        get{
            return String.isNotBlank(Order_Status_Approved) ? Order_Status_Approved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Approved');
        }set;
    }
    private Static String Order_Status_Pending{
        get{
            return String.isNotBlank(Order_Status_Pending) ? Order_Status_Pending : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Pending');
        }set;
    }
    private Static String Brandquote_Status_Cancelled{
        get{
            return String.isNotBlank(Brandquote_Status_Cancelled) ? Brandquote_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand Quote Line','Brandquote_Status_Cancelled');
        }set;
    }
    @AuraEnabled
    public static AuraResponse acceptOrder(Id recordId){
        AuraResponse r = new AuraResponse('OrderController.acceptOrder()');
        Order__c retailerOrder = [select Id, Status__c from Order__c where Id = :recordId];        
        if(retailerOrder.Status__c == Order_Status_Pending){
            retailerOrder.Status__c =Order_Status_Approved;
            update retailerOrder; 
            r.data.put('alreadyApproved',false);            
        }else{
            r.data.put('alreadyApproved',true);    
            if(retailerOrder.Status__c == Order_Status_Approved)
            	r.data.put('isStatusApproved',true);    
            else
                r.data.put('isStatusApproved',false);    
        }
        return r; 
    }
    @AuraEnabled
    public static AuraResponse acceptAndUpdateSiteOrder(Id recordId,String siteId){
        AuraResponse r = new AuraResponse('OrderController.acceptOrder()');
        Boolean isSuccess = false;
        Order__c order = [select Id, Status__c,Site__c,State_License__c,Account__r.Membership_Level__c,Total_Milage_Fee__c,Retailer_DBA__c,Planned_Ship_Date__c,State_License__r.License_Number__c,State_License__r.License_Address__c,State_License__r.License_City__c,State_License__r.License_Country__c,State_License__r.License_State__c,State_License__r.License_Zip__c from Order__c where Id = :recordId];
        if(order.Status__c == Order_Status_Pending){
            r.data.put('alreadyApproved',false);  
        }else{
            r.data.put('alreadyApproved',true);  
            if(order.Status__c == Order_Status_Approved)
            	r.data.put('isStatusApproved',true);    
            else
                r.data.put('isStatusApproved',false);  
        }
        if(String.isBlank(siteId)){
            if(order.Status__c == Order_Status_Pending){
                order.Status__c =Order_Status_Approved;
                update order;        
            }
        }else{
            Shipping_Rates_Table__c [] mileageSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                                         Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                         FROM Shipping_Rates_Table__c 
                                                         WHERE Site__c = :siteId
                                                         AND Active__c = true
                                                         AND Rate_Effective_From__c <= :System.today()
                                                         AND Rate_Effective_To__c >= :System.today()
                                                         AND Membership_Level__c = :order.Account__r.Membership_Level__c
                                                         Order By Mileage_Bracket__c];
            Decimal totalMiles = getTotalMiles(siteId,order.State_License__c);
            System.debug('##totalMiles::'+totalMiles);
            Decimal totalMileageFee = 0;
            if(!mileageSRTList.isEmpty() && totalMiles != null){
                for(Shipping_Rates_Table__c SRT: mileageSRTList){
                    if(totalMiles <= SRT.Mileage_Bracket__c && siteId == SRT.Site__c && order.Account__r.Membership_Level__c == SRT.Membership_Level__c){
                        if(SRT.Fixed_Mileage_Fee__c){
                            totalMileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                        }else{
                            totalMileageFee = SRT.Mileage_Bracket_Price__c * totalMiles; 
                        }
                        break;
                    }
                }    
            }
            if(order.Status__c == Order_Status_Pending){
                order.Status__c =Order_Status_Approved;
                order.Site__c = siteId;
                order.Total_Milage_Fee__c = totalMileageFee;
                update order;            
            }
        }       
        return r;
    }
    public static Decimal getTotalMiles(String siteId, String stateLicenseId){
        Site__c s = [SELECT Id,License_ID__r.License_Address__c ,License_ID__r.License_City__c ,License_ID__r.License_Country__c ,License_ID__r.License_State__c,License_ID__r.License_Zip__c FROM Site__c WHERE Id = :siteId];
        State_Licenses__c st = [SELECT Id,License_Address__c ,License_City__c , License_Country__c,License_State__c,License_Zip__c FROM State_Licenses__c WHERE Id =:stateLicenseId];
        String url = Google_Distance_Matrix_API__c.getValues('GMaps_Endpoint').Value__c;
        String apiKey = Google_Distance_Matrix_API__c.getValues('Gmaps_APIKey').Value__c;
        String parameters = 'origins=' + s.License_ID__r.License_Address__c +','+ s.License_ID__r.License_City__c+ ','+s.License_ID__r.License_State__c +' '+ s.License_ID__r.License_Zip__c+','+ s.License_ID__r.License_Country__c + '&destinations=' + st.License_Address__c +','+ st.License_City__c +','+st.License_State__c +' '+ st.License_Zip__c+','+ st.License_Country__c;
        String param2 =  '&language=en&key=';
        parameters = parameters.replace(' ','%20');
        url = url+parameters+param2+apiKey;
        url = url.replaceAll('#', '%20');
        System.debug('After... '+url);
        
        HTTP http = new HTTP();
        HTTPRequest request = new HTTPRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        HTTPResponse response = http.send(request);
        system.debug('response.getStatusCode()'+response.getStatusCode());
        System.debug('Respons..'+response.getBody());
        if(response.getStatusCode() == 200) {
            double distVal = 0;
            StateLicenseTotalMilesTriggerHelper.DistanceResponse reponse = (StateLicenseTotalMilesTriggerHelper.DistanceResponse) JSON.deserialize(response.getBody(), StateLicenseTotalMilesTriggerHelper.DistanceResponse.class); 
            if(reponse != null && reponse.rows != null){
                if(reponse.rows[0].elements != null){
                    distVal = reponse.rows[0].elements[0].distance.value;
                    distVal = distVal * 0.00062137;
                }
            }
            return distVal;
            //lstState.add(new State_Licenses__c(Id = st.Id,Total_Miles__c =  distVal));
        }
        return 0;
    }
    @AuraEnabled
    public static AuraResponse getOrderStatus(Id recordId,boolean reschedule){
        AuraResponse r = new AuraResponse('OrderController.getOrderStatus()');
        r.data.put('EARLIEST_DELIVERY_TIME',EARLIEST_DELIVERY_TIME);
        r.data.put('LATEST_DELIVERY_TIME',LATEST_DELIVERY_TIME);
        string Msg_for_Reschedule_Shipment_Complete = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Msg_for_Reschedule_Shipment_Complete');
        string Err_Msg_For_Past_Date = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_For_Past_Date');
        
        r.data.put('Err_Msg_For_Past_Date', Err_Msg_For_Past_Date != null ? Err_Msg_For_Past_Date : '');        
        r.data.put('Msg_for_Reschedule_Shipment_Complete', Msg_for_Reschedule_Shipment_Complete != null ? Msg_for_Reschedule_Shipment_Complete : '');        
        
    	Order__c retailerOrder = [SELECT Id,Name,Order_Date__c,Account__r.Name,Customer__r.Name,Total_Product_Price__c,Total_Excise_Tax_Amount__c,Retailer_DBA__c,Planned_Ship_Date__c,State_License__r.License_Number__c,State_License__r.License_Address__c,State_License__r.License_City__c,State_License__r.License_Country__c,State_License__r.License_State__c,State_License__r.License_Zip__c,
                                  Total__c,Payment_Terms__c,Retailer__r.Third_Party_Scheduler__c,Request_Ship_Date__c,Status__c,Sample_Order__c,Piggyback_sample__c,isPreapproved__c,Requested_Delivery_Earliest_Time__c,Requested_Delivery_Latest_Time__c,RecordType.Name FROM Order__c WHERE Id = :recordId LIMIT 1];
        r.data.put('retailerOrder', retailerOrder);
        
        Map<String, Community_Settings__c > Community_Settings= Community_Settings__c.getAll();
        if(Community_Settings.containsKey('default')){
            r.data.put('cutOffTime', Community_Settings.get('default').Order_Cutoff_time__c);
        }
        if(reschedule){
            
            if(retailerOrder.Request_Ship_Date__c != null && retailerOrder.Request_Ship_Date__c == retailerOrder.Planned_Ship_Date__c){
                r.data.put('allowedToApproved', false); 
                r.data.put('inActiveCalendar', true);
                return r;
            }
            
            Boolean inActive = false;
            Boolean isPlannedDateBlank = false;
           
            for(Shipping_Manifest__c sm : [SELECT Id,Opportunity_Name__c,Status__c,Rescheduled_Approved__c,Planned_Ship_Transfer_Date__c,Opportunity_Name__r.Order__c FROM Shipping_Manifest__c WHERE Opportunity_Name__r.Order__c =: retailerOrder.Id]){
                if(sm.Status__c == SHIPPING_MANIFEST_STATUS_INTRANSIT || sm.Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE){
                    inActive = true;
                    r.data.put('allowedToApproved', false); 
                    r.data.put('inActiveCalendar', true); 
                    return r;
                }
                if(sm.Rescheduled_Approved__c){
                    isPlannedDateBlank = true;
                }
            }
            
            if(isPlannedDateBlank){
                r.data.put('allowedToApproved', false); 
                r.data.put('inActiveCalendar', true);
                r.data.put('isLinkAlreadyUsed', true);
                return r;
            }
            if(retailerOrder.Status__c != Order_Status_Shipped && !inActive){
                if(retailerOrder.Status__c == 'Cancelled by WOVN' || retailerOrder.Status__c == 'Cancelled by Customer'){
                    r.data.put('allowedToApproved', true);
                    r.data.put('approved', true);
                }else{
                    r.data.put('allowedToApproved', true);
                    r.data.put('approved', false);
                }
            }else{
                 r.data.put('allowedToApproved', false); 
            }
            
        }else{
            if(retailerOrder.Status__c == Order_Status_Pending || retailerOrder.Status__c == Order_Status_Approved){
                r.data.put('allowedToApproved', true);    
            }else{
                r.data.put('allowedToApproved', false);        
            }
            if(retailerOrder.Status__c == Order_Status_Approved){
                r.data.put('approved', true);
            } else {
                r.data.put('approved', false);
            }
        }
        
        //r.data.put('retailerOrder', retailerOrder);
        List<string>holidayList = new List<string>();
        for(Holiday  businessHolidDay : [SELECT IsRecurrence,ActivityDate,RecurrenceMonthOfYear,RecurrenceEndDateOnly,RecurrenceInstance,RecurrenceDayOfWeekMask,RecurrenceInterval,RecurrenceType FROM Holiday]){
            if(businessHolidDay.IsRecurrence){
            	holidayList.addAll(getAllRecurrenceHoliday(businessHolidDay));
            }else{
            	holidayList.add(getDateStr(businessHolidDay.ActivityDate));   
            }    
        }
        r.data.put('holidayList', holidayList);
        return r;
    }
    private static list<String> getAllRecurrenceHoliday(Holiday businessHolidDay){
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
            holidayList.add(getDateStr(todayDt));       
        }
        return holidayList;
    }
    Public  static string getDateStr(Date holidayDate){
    	string dtStr = holidayDate.month()+'-'+holidayDate.Day()+'-'+holidayDate.year();  
        return dtStr;
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
    @AuraEnabled
    public static AuraResponse approveOrder(Id recordId,Boolean reschedule,Boolean isApproveOrRequestDate,String requestDate,String requestEarTime, String requestLatTime){
        AuraResponse r = new AuraResponse('OrderController.approveOrder()');
       	
        Order__c retailerOrder = [select Id,Name,RecordType.Name,Order_Date__c,Sample_Order__c,Account__r.Name,Customer__r.Name,Total_Product_Price__c,Total_Excise_Tax_Amount__c,Retailer_DBA__c,Planned_Ship_Date__c,State_License__r.License_Number__c,State_License__r.License_Address__c,State_License__r.License_City__c,State_License__r.License_Country__c,State_License__r.License_State__c,State_License__r.License_Zip__c,
                                  Total__c,Payment_Terms__c,Retailer__r.Third_Party_Scheduler__c,IsRescheduled__c, Status__c,Request_Ship_Date__c, Requested_Delivery_Earliest_Time__c, Requested_Delivery_Latest_Time__c from Order__c where Id = :recordId];
        if(reschedule){
            if(requestDate != '' && requestDate != NULL){
                retailerOrder.Request_Ship_Date__c = Date.valueOf(requestDate);
            }
            if(requestEarTime != NULL && requestEarTime != ''){
               String[] eTimeWithSpace = requestEarTime.split(' ');
                    String[] eTime = eTimeWithSpace[0].split(':');
               		retailerOrder.Requested_Delivery_Earliest_Time__c = Time.newInstance((eTimeWithSpace[1].equalsIgnoreCase('pm') && Integer.valueOf(eTime[0]) != 12 ?(Integer.valueOf(eTime[0])+12):Integer.valueOf(eTime[0])),Integer.valueOf(eTime[1]), 0, 0); 
                    //retailerOrder.Requested_Delivery_Earliest_Time__c = Time.newInstance(Integer.valueOf((Integer.valueOf(eTime[0]) == 0 ? '12' : eTime[0] )),Integer.valueOf(eTime[1]), 0, 0);   
                } 
                if(requestLatTime != NULL && requestLatTime != ''){
                    String[] lTimeWithSpace = requestLatTime.split(' ');
                    String[] lTime = lTimeWithSpace[0].split(':');
                    retailerOrder.Requested_Delivery_Latest_Time__c = Time.newInstance((lTimeWithSpace[1].equalsIgnoreCase('pm') && Integer.valueOf(lTime[0]) != 12 ?(Integer.valueOf(lTime[0])+12):Integer.valueOf(lTime[0])),Integer.valueOf(lTime[1]), 0, 0); 
                    //retailerOrder.Requested_Delivery_Latest_Time__c = Time.newInstance(Integer.valueOf((Integer.valueOf(lTime[0]) == 0 ? '12' : lTime[0] )), Integer.valueOf(lTime[1]), 0, 0);
                }
                if(isApproveOrRequestDate ){
                    if(requestDate == '' || requestDate == NULL ){
                        retailerOrder.Request_Ship_Date__c = retailerOrder.Planned_Ship_Date__c;
                        //SMRescheduleController.newShipDate = retailerOrder.Planned_Ship_Date__c;
                        SMRescheduleController.sendEmailByWovn(retailerOrder.id,retailerOrder.Planned_Ship_Date__c,null);
                    }
                }
            List<Shipping_Manifest__c> smList =  [SELECT Id,Opportunity_Name__c,Status__c,Rescheduled_Approved__c,Planned_Ship_Transfer_Date__c,Opportunity_Name__r.Order__c FROM Shipping_Manifest__c WHERE Opportunity_Name__r.Order__c =: retailerOrder.Id];
            if(smList.size() > 0){
                for(Shipping_Manifest__c sm : smList){
                    sm.Rescheduled_Approved__c = true;
                }
            }
            
            if(smList.size() > 0){
                update smList;
            }
             
                update retailerOrder;
                //r.data.put('retailerOrder', retailerOrder);
                r.data.put('approved', true);
        }else{
            if(retailerOrder.Status__c == Order_Status_Pending){
                retailerOrder.Status__c =Order_Status_Approved;
                
                if(requestDate != '' && requestDate != NULL){
                    retailerOrder.Request_Ship_Date__c = Date.valueOf(requestDate);    
                }
                if(requestEarTime != NULL && requestEarTime != ''){
                    String[] eTimeWithSpace = requestEarTime.split(' ');
                    String[] eTime = eTimeWithSpace[0].split(':');
               		retailerOrder.Requested_Delivery_Earliest_Time__c = Time.newInstance((eTimeWithSpace[1].equalsIgnoreCase('pm') && Integer.valueOf(eTime[0]) != 12 ?(Integer.valueOf(eTime[0])+12):Integer.valueOf(eTime[0])),Integer.valueOf(eTime[1]), 0, 0); 
                } 
                if(requestLatTime != NULL && requestLatTime != ''){
                    String[] lTimeWithSpace = requestLatTime.split(' ');
                    String[] lTime = lTimeWithSpace[0].split(':');
                    retailerOrder.Requested_Delivery_Latest_Time__c = Time.newInstance((lTimeWithSpace[1].equalsIgnoreCase('pm') && Integer.valueOf(lTime[0]) != 12 ?(Integer.valueOf(lTime[0])+12):Integer.valueOf(lTime[0])),Integer.valueOf(lTime[1]), 0, 0); 
                }
                update retailerOrder;
                
                r.data.put('approved', true);
            } else {
                r.data.put('approved', false);    
            }
        }
        Order__c retailerOrder2 = [select Id,Name,RecordType.Name,Order_Date__c,Sample_Order__c,Account__r.Name,Customer__r.Name,Total_Product_Price__c,Total_Excise_Tax_Amount__c,Retailer_DBA__c,Planned_Ship_Date__c,State_License__r.License_Number__c,State_License__r.License_Address__c,State_License__r.License_City__c,State_License__r.License_Country__c,State_License__r.License_State__c,State_License__r.License_Zip__c,
                                  Total__c,Payment_Terms__c,Retailer__r.Third_Party_Scheduler__c,IsRescheduled__c, Status__c,Request_Ship_Date__c, Requested_Delivery_Earliest_Time__c, Requested_Delivery_Latest_Time__c from Order__c where Id = :recordId];
        r.data.put('retailerOrder', retailerOrder2);
        //r.data.put('approved', acceptOrder(recordId));
        return r; 
    }
    @AuraEnabled
    public static AuraResponse cancelOrder(Id recordId){
        AuraResponse r = new AuraResponse('OrderController.cancelOrder()');
       	
        Order__c retailerOrder = [select Id,Name,RecordType.Name,Order_Date__c,Sample_Order__c,Account__r.Name,Customer__r.Name,Total_Product_Price__c,Total_Excise_Tax_Amount__c,
                                  Total__c,Payment_Terms__c,IsRescheduled__c, Status__c,Request_Ship_Date__c, Requested_Delivery_Earliest_Time__c, Requested_Delivery_Latest_Time__c from Order__c where Id = :recordId];
        List<Shipping_Manifest__c> SMList = new List<Shipping_Manifest__c>();
        Set<Id> oppIds = new Set<Id>();
        
        for(Shipping_Manifest__c sm : [SELECT Id,Opportunity_Name__c FROM Shipping_Manifest__c WHERE Opportunity_Name__r.Order__c =: retailerOrder.Id]){
            oppIds.add(sm.Opportunity_Name__c);
            sm.Status__c =SHIPPING_MANIFEST_STATUS_CANCELLED;
            SMList.add(sm);
        }
        if(oppIds.size() > 0){
            List<Sales_Order__c> SOList = new List<Sales_Order__c>();
            List<Sales_Order_Line__c> SOLIList = new List<Sales_Order_Line__c>();
            List<Brand_Quote__c> BQList = new List<Brand_Quote__c>();
            List<Brand_Quote_Line__c> BQLIList = new List<Brand_Quote_Line__c>();
            for(Brand_Quote__c bq : [SELECT Id ,BQ_Status__c,(SELECT Id,Status__c FROM Brand_Quote_Lines__r) FROM Brand_Quote__c WHERE Opportunity_Name__c IN :oppIds]){
                bq.BQ_Status__c = Brandquote_Status_Cancelled;
                for(Brand_Quote_Line__c bql : bq.Brand_Quote_Lines__r){
                    bql.Status__c = Brandquote_Status_Cancelled;
                    BQLIList.add(bql);
                }
                BQList.add(bq);
            }
            for(Sales_Order__c so : [SELECT Id ,SO_Status__c,(SELECT Id,Status__c FROM Sales_Order_Lines__r) FROM Sales_Order__c WHERE Opportunity_Name__c IN :oppIds]){
                so.SO_Status__c = SO_Status_Cancelled;
                for(Sales_Order_Line__c sol : so.Sales_Order_Lines__r){
                    sol.Status__c = STATUS_SALESORDERLINECANCELLED;
                    SOLIList.add(sol);
                }
                SOList.add(so);
            }
            
            if(BQList.size() > 0){
                update BQList;
                if(BQLIList.size() >0 )
                    update BQLIList;
            }
            if(SOList.size() > 0){
                update SOList;
                if(SOLIList.size() >0 )
                    update SOLIList;
            }
        }
       	if(SMList.size() > 0)
            update SMList; 
        r.data.put('retailerOrder', retailerOrder);
        r.data.put('approved', true);
        return r;
    }
    @AuraEnabled 
    public static AuraResponse getOrderDetails(Id recordId){
        AuraResponse r = new AuraResponse('OrderController.getOrderDetails()');
        Order__c odr = [SELECT Id,Name,RecordType.Name,Order_Type__c,Site__c,State_License__c FROM Order__c where Id = :recordId];
        List<Site__c> sites = [SELECT Id,Name, Warehouse_Name__c,License_ID__c FROM Site__c WHERE Active__c = true];
        string Err_Msg_of_Ship_To_and_Origin_Site = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Err_Msg_of_Ship_To_and_Origin_Site');
        
        r.data.put('Err_Msg_of_Ship_To_and_Origin_Site', Err_Msg_of_Ship_To_and_Origin_Site != null ? Err_Msg_of_Ship_To_and_Origin_Site : '');        
        r.data.put('order', odr);
        r.data.put('sites', sites);
        return r;
    }
     @Auraenabled
    public static String getRecordName(Id recordId){
        String objName = recordId.getSObjectType().getDescribe().getName();
        System.debug(objName);
        String q = 'SELECT Name FROM ' + objName + ' WHERE Id=\'' + recordId + '\'';
        List<SObject> records = Database.query(q);
        if(records.size()>0){
            return (String) (records[0].get('Name'));
        }
        return '';
    }
}