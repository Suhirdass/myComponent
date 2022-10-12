global with Sharing class routeScheduleRestWebService {
    
    public Static String SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION) ? SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_CashCollect');
        }set;
    }
    
    
    public Static String SHIPPING_MANIFEST_STATUS_PENDING{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_PENDING) ? SHIPPING_MANIFEST_STATUS_PENDING: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_ShipmentPending');
        }set;
    }
        public Static String SHIPPING_MANIFEST_STRING_PUBLISHED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STRING_PUBLISHED) ? SHIPPING_MANIFEST_STRING_PUBLISHED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_String_Published');
        }set;
    }
     Public Static String message{
        get{
            return String.isNotBlank(message) ? message : Label.Select_Vehicle;
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
    public static String HOLIDAY_RECURSMONTHLY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSMONTHLY) ? HOLIDAY_RECURSMONTHLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursMonthly');
        }set;
    }
    public static String HOLIDAY_RECURSMONTHLYNTH{
        get{
            return String.isNotBlank(HOLIDAY_RECURSMONTHLYNTH) ? HOLIDAY_RECURSMONTHLYNTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursMonthlyNth');
        }set;
    }
    public static String HOLIDAY_RECURSWEEKLY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSWEEKLY) ? HOLIDAY_RECURSWEEKLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursWeekly');
        }set;
    }
    public static String HOLIDAY_RECURSDAILY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSDAILY) ? HOLIDAY_RECURSDAILY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursDaily');
        }set;
    }
    public static String HOLIDAY_RECURSEVERYWEEKDAY{
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
    public static String MAY_MONTH{
        get{
            return String.isNotBlank(MAY_MONTH) ? MAY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','May_Month');
        }set;
    }
    public static String JUNE_MONTH{
        get{
            return String.isNotBlank(JUNE_MONTH) ? JUNE_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','June_Month');
        }set;
    }
    public static String JULY_MONTH{
        get{
            return String.isNotBlank(JULY_MONTH) ? JULY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','July_Month');
        }set;
    }
    public static String AUGUST_MONTH{
        get{
            return String.isNotBlank(AUGUST_MONTH) ? AUGUST_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','August_Month');
        }set;
    }
    public static String SEPTEMBER_MONTH{
        get{
            return String.isNotBlank(SEPTEMBER_MONTH) ? SEPTEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','September_Month');
        }set;
    }
    public static String OCTOBER_MONTH{
        get{
            return String.isNotBlank(OCTOBER_MONTH) ? OCTOBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','October_Month');
        }set;
    }
    public static String NOVEMBER_MONTH{
        get{
            return String.isNotBlank(NOVEMBER_MONTH) ? NOVEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','November_Month');
        }set;
    }
    public static String DECEMBER_MONTH{
        get{
            return String.isNotBlank(DECEMBER_MONTH) ? DECEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','December_Month');
        }set;
    }
    public static String HOLIDAY_RECURRENCE_FIRST{
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
    public static String HOLIDAY_RECURRENCE_LAST{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_LAST) ? HOLIDAY_RECURRENCE_LAST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Last');
        }set;
    }
      public Static String SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM) ? SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_ProductTSM');
        }set;
    }
    
    @AuraEnabled  
    public static AuraResponse  doPostRouteInfo(Date scheduleDates){
        AuraResponse r = new AuraResponse('routeScheduleRestWebService.doPostRouteInfo()');
        Date nextDayDate = Date.Today().addDays(1);
        Date routeDate = Date.valueOf(scheduleDates);
        system.debug('scheduleDate>>>>'+routeDate);
        
        List<Route_Schedule__c> getRoute = new  List<Route_Schedule__c>();
        Set<ID> routeIds = new Set<ID>();
           Set<ID> smIds = new Set<ID>();
        getRoute = [select Id, name,Status__c,(Select id, Name,Shipping_Manifest__c from Route_Schedule_Lines__r)  from Route_Schedule__c where Route_Date__c=:routeDate ];
        if(getRoute.size() > 0 ){for(Route_Schedule__c  routeVal :getRoute){
                if(routeVal.Status__c!= Shipping_Manifest_String_Published){   routeIds.add(routeVal.Id);
                }else{
                    for(Route_Schedule_Line__c resLine : routeVal.Route_Schedule_Lines__r){ smIds.add(resLine.Shipping_Manifest__c);
                        
                    }
                }
                
            }
        }
        system.debug('smIds>>'+smIds);

       /* List<Route_Schedule__c> getRoute = new  List<Route_Schedule__c>();
     
        getRoute = [select Id, name, (Select id, Name,Shipping_Manifest__c from Route_Schedule_Lines__r) from Route_Schedule__c where Route_Date__c=2022-04-12 AND Status__c='Published'];
        
        for(Route_Schedule__c res : getRoute){
            
            for(Route_Schedule_Line__c resLine : res.Route_Schedule_Lines__r){
                smIds.add(resLine.Shipping_Manifest__c);
                
            }
        }*/
        
       
        Id cashCollectionRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION).getRecordTypeId();
        List<Site__c> routeSites = new List<Site__c>();
        routeSites =  [SELECT Id,Name , License_ID__r.License_Address__c , License_ID__r.License_Zip__c , License_ID__r.License_Country__c ,(SELECT Id, Name , 
                                                                                                                                             Sales_Order__c, Purchase_Order__c,Purchase_Order__r.Receiver_Address__c,Purchase_Order__r.Receiver_City_State_Zip__c , Purchase_Order__r.Name ,Sales_Order__r.Name, Purchase_Order__r.Supplier_Address__c , Purchase_Order__r.Supplier_City_State_Zip__c , Sales_Order__r.Receiver_Address__c , 
                                                                                                                                             Sales_Order__r.Receiver_City_State_Zip__c , Route_Start_Time__c , Route_End_Time__c , Window_Start__c , Window_End__c , Status__c , Planned_Ship_Transfer_Date__c 
                                                                                                                                            // FROM Shipping_Manifests__r WHERE Planned_Ship_Transfer_Date__c =2022-01-20  AND RecordTypeId!=:cashCollectionRecordTypeId AND Status__c=:SHIPPING_MANIFEST_STATUS_PENDING ) FROM Site__c];
                                                                                                                                             FROM Shipping_Manifests__r WHERE Planned_Ship_Transfer_Date__c =:routeDate  AND RecordTypeId!=:cashCollectionRecordTypeId AND Id NOt IN:smIds ) FROM Site__c];
        
        
      
        
        system.debug('routeSites>>'+routeSites);
        JSONGenerator genJson = JSON.createGenerator(true);    
        genJson.writeStartObject();   
        genJson.writeFieldName('records');
        genJson.writeStartArray();
        for(Site__c res : routeSites){  genJson.writeStartObject();
            genJson.writeStringField('SiteId', res.Id);
            genJson.writeStringField('Name', res.Name);
            genJson.writeFieldName('Site Address');
            genJson.writeStartArray();
            genJson.writeStartObject();
            genJson.writeStringField('Address', res.License_ID__r.License_Address__c);
            genJson.writeStringField('Zip', res.License_ID__r.License_Zip__c );
            genJson.writeStringField('Country', res.License_ID__r.License_Country__c);
            genJson.writeEndObject();  
            genJson.writeEndArray();
            
            if(res.Shipping_Manifests__r.size() > 0) {genJson.writeFieldName('records');genJson.writeStartArray();
                for(Shipping_Manifest__c soRes : res.Shipping_Manifests__r){  genJson.writeStartObject();
                                                                            
                                                                            if(soRes.Sales_Order__c != Null ) {  String sRcaddress  = soRes.Sales_Order__r.Receiver_Address__c;
                                                                                sRcaddress = sRcaddress.replaceAll('[^a-zA-Z0-9\\s+]', '');

                                                                                genJson.writeStringField('Id', soRes.Id);
                                                                                genJson.writeStringField('Name', soRes.Name);
                                                                                genJson.writeStringField('orderId', soRes.Sales_Order__c);genJson.writeStringField('orderName', soRes.Sales_Order__r.Name);
                                                                                genJson.writeStringField('Receiver Address',sRcaddress);
                                                                                genJson.writeStringField('Receiver City', soRes.Sales_Order__r.Receiver_City_State_Zip__c);
                                                                                
                                                                                if(soRes.Window_Start__c != Null){genJson.writeTimeField('Window Start', soRes.Window_Start__c);
                                                                                                                  
                                                                                                                 }else{
                                                                                                                     genJson.writeStringField('Window Start', 'none');
                                                                                                                     
                                                                                                                 }
                                                                                if(soRes.Window_End__c != Null){ genJson.writeTimeField('Window End', soRes.Window_End__c);
                                                                                                                
                                                                                                               }else{
                                                                                                                   genJson.writeStringField('Window End', 'none');
                                                                                                               }
                                                                                
                                                                            }
                                                                            
                                                                            if(soRes.Purchase_Order__c!= Null){String pRcaddress  = soRes.Purchase_Order__r.Receiver_Address__c;
                                                                                pRcaddress = pRcaddress.replaceAll('[^a-zA-Z0-9\\s+]', '');
                                                                                genJson.writeStringField('Id', soRes.Id); genJson.writeStringField('Name', soRes.Name);
                                                                                genJson.writeStringField('orderId', soRes.Purchase_Order__c); genJson.writeStringField('orderName', soRes.Purchase_Order__r.Name);
                                                                                genJson.writeStringField('Receiver Address', pRcaddress);
                                                                                genJson.writeStringField('Receiver City', soRes.Purchase_Order__r.Receiver_City_State_Zip__c);
                                                                                genJson.writeStringField('Supplier Address', soRes.Purchase_Order__r.Supplier_Address__c);
                                                                                genJson.writeStringField('Supplier City', soRes.Purchase_Order__r.Receiver_City_State_Zip__c);
                                                                                if(soRes.Window_Start__c != Null){ genJson.writeTimeField('Window Start', soRes.Window_Start__c);
                                                                                                                  
                                                                                                                 }else{
                                                                                                                     genJson.writeStringField('Window Start', 'none');
                                                                                                                 }
                                                                                if(soRes.Window_End__c != Null){ genJson.writeTimeField('Window End', soRes.Window_End__c);
                                                                                                                
                                                                                                               }else{
                                                                                                                   genJson.writeStringField('Window End', 'none');
                                                                                                               }
                                                                            }
                                                                            
                                                                            
                                                                            genJson.writeEndObject();  
                                                                            
                                                                           }
                genJson.writeEndArray();   
                
            }else{
                genJson.writeStringField('records', 'none');
            }
            
            genJson.writeEndObject();     
        }
        genJson.writeEndArray();
        genJson.writeEndObject();    
        String jsonRes = genJson.getAsString();
        system.debug('jsonRes>>>'+jsonRes);
        system.debug('requestPayload'+jsonRes);
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://trumatics-order-route.herokuapp.com/order_route');
        //req.setEndpoint('https://trumatics-order-schedule.herokuapp.com/order_route');
        // https://trumatics-order-route.herokuapp.com/order_route
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');
        //req.setHeader('Content-Length',requestPayload.length()+'');
        req.setBody(jsonRes);
        Http http = new Http();
        req.setTimeout(120000);
        HttpResponse res = http.send(req);
        
        String response = res.getBody();
        //system.debug('>>'+req.getBody());
        system.debug('response'+response); 
        //  system.debug('response'+res.getBody()); 
        
        
        list <Route_Schedule__c> lstrs = new list <Route_Schedule__c>();
        list <Route_Schedule_Line__c> lstrsline = new list <Route_Schedule_Line__c>();
        
        
        Map<String, Object> meta = (Map<String, Object>) JSON.deserializeUntyped(response);
        
        
        
        List<Map<String, Object>> myMaps = new List<Map<String, Object>>();
        List<Object> myMapObjects = (List<Object>) meta.get('Route');
        if(myMapObjects != null){for (Object obj : myMapObjects) {myMaps.add((Map<String, Object>)obj); 
                                            }    
        }
        
        
        Map<String,Object>lstobj = new Map<String,Object>();
        for (Map<String, Object> result : myMaps) {String objTypeRSname = String.valueOf(result.get('Name'));
            List<string> rsnames  = new list <string>();  rsnames.add(objTypeRSname);
            list<Object> lstproperty = (list<Object>)result.get('Records'); 
            Route_Schedule__c RS = new Route_Schedule__c();
            RS.Route_Name__c = String.valueOf(result.get('Name'));
            String stId = String.valueOf(result.get('SiteId'));  RS.Site__c = stId;
            RS.Route_Date__c = routeDate;  RS.Address__c = String.valueOf(result.get('address'));
            String sttime = String.valueOf(result.get('RouteStartTime')); String endtime = String.valueOf(result.get('RouteEndTime'));
            String[] strTimeSplitStart = sttime.split(':');
            Time starttimeChange = Time.newInstance( Integer.valueOf(strTimeSplitStart[0]) ,Integer.valueOf(strTimeSplitStart[1])  ,0  ,0);  
            String[] strTimeSplitend = endtime.split(':');
            Time endtimeChange = Time.newInstance( Integer.valueOf(strTimeSplitend[0]) ,Integer.valueOf(strTimeSplitend[1])  ,0  ,0);  
            RS.Route_Start_Time__c = starttimeChange;  RS.Route_End_Time__c = endtimeChange;  
            RS.VehicleId__c = String.valueOf(result.get('VehicleId'));lstrs.add(RS) ;
            for(object k :lstproperty ){ Map<String, Object> property = (Map<String, Object>)k;
                                        Route_Schedule_Line__c RSL = new Route_Schedule_Line__c();
                                        String RSLname = String.valueOf(property.get('Name'));String RSLids = String.valueOf(property.get('Id'));
                                        String SMId = String.valueOf(property.get('smid'));String orderids = String.valueOf(property.get('orderId'));
                                        if(RSLname.startsWith('SO')) {RSL.Sales_Order__c = RSLids;  
                                                                     }else{
                                                                         RSL.Purchase_Order__c = RSLids; 
                                                                     }
                                        RSL.Shipping_Manifest__c  = Id.valueOf(SMId);
                                        String RSLSeqNo = String.valueOf(property.get('SeqNo'));Decimal RSLSeq = decimal.valueOf(RSLSeqNo);
                                        String RSLPlannedArrivalTime = String.valueOf(property.get('PlannedArrivalTime'));String[] strTimeSplit = RSLPlannedArrivalTime.split(':');
                                        Time PlannedArrivalTime = Time.newInstance( Integer.valueOf(strTimeSplit[0]),Integer.valueOf(strTimeSplit[1]),0  ,0);
                                        String RSLPlannedDepartureTime = String.valueOf(property.get('PlannedDepartureTime')); String[] strTimeSplits = RSLPlannedDepartureTime.split(':'); Time DepartureTime = Time.newInstance( Integer.valueOf(strTimeSplits[0]) ,Integer.valueOf(strTimeSplits[1]) ,0  ,0);
                                        RSL.Sitename__c  =String.valueOf(property.get('SiteName')); RSL.Planned_Arrival_Time__c  =PlannedArrivalTime;
                                        RSL.Planned_Departure_Time__c  = DepartureTime; RSL.Schedule_sequence__c  = RSLSeq;
                                        RSL.Delivery_Address__c  =String.valueOf(property.get('delAddress')); RSL.VehicleId__c = String.valueOf(property.get('VehicleId'));String starttime = String.valueOf(property.get('starttime'));
                                        String[] starttimeTimeSplits = starttime.split(':');Time windowstartTime = Time.newInstance( Integer.valueOf(starttimeTimeSplits[0]),Integer.valueOf(starttimeTimeSplits[1]) ,0 ,0);
                                        String windowedtime = String.valueOf(property.get('endtime'));  String[]endtimeTimeSplits = windowedtime.split(':'); Time windowendTime = Time.newInstance( Integer.valueOf(endtimeTimeSplits[0]),Integer.valueOf(endtimeTimeSplits[1]) ,0 ,0);
                                        RSL.Window_Start__c = windowstartTime;RSL.Window_End__c = windowendTime;RSL.Route_Date__c = routeDate;lstrsline.add(RSL);
                                       } 
            
        }
        
        
        Insert lstrs; // rs insert
      
system.debug('lstrs>>'+lstrs);        
        list <Route_Schedule_Line__c> lstrsline2 = new list <Route_Schedule_Line__c>();
        
        
        Integer i=0;
        for(Route_Schedule__c rsinsert :lstrs){Integer k=0;  for(Route_Schedule_Line__c rslinsert : lstrsline) {
                                                  
                                                   if(rsinsert.Route_Name__c ==rslinsert.Sitename__c && rsinsert.VehicleId__c == rslinsert.VehicleId__c && rsinsert.Route_Date__c == rslinsert.Route_Date__c  ){
                                                   rslinsert.Route_Schedule__c = rsinsert.id;lstrsline2.add(rslinsert);   }} i++;
                                              }  Insert lstrsline2;
        deleteUnPublishedRoute(routeIds);
        return r;
    }
    
    
    
    @future
    public static void deleteUnPublishedRoute(Set<ID> routeIds){
           List<Route_Schedule__c> getRoute = new  List<Route_Schedule__c>();
      
        getRoute = [select Id, name from Route_Schedule__c where Id IN :routeIds];
        if(getRoute.size()>0){delete getRoute;
        }
        
    }
    
    
      
    // New Route schedule
   
     /** Method to return data to component **/
    
            @AuraEnabled 
    public List<Route_Schedule__c> setRouteData {get; set;}
    
         @AuraEnabled 
    public List<Route_Schedule__c> setShipLines {get; set;}
    
    public Route_Schedule__c setRouteSchedule {get; set;}
    
    public List<Route_Schedule_Line__c> setRsLines {get; set;}
    
    
    @AuraEnabled
    public static AuraResponse getRouteSchedule(Date selectedDays){
        AuraResponse r = new AuraResponse('routeScheduleRestWebService.getRouteSchedule()');
        routeScheduleRestWebService assign = new routeScheduleRestWebService();
        
        Date newDate = Date.valueOf(selectedDays); 
          system.debug('newDate>>'+newDate);
        DateTime dt = (DateTime)Cache.Session.get('datetime');
        r.data.put('dt',dt);
        assign.setRouteData = getRouteScheduleData(newDate);
        system.debug('assign.setRouteData'+assign.setRouteData);
        r.data.put('setShipLines', assign.setRouteData);
        
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
        	if(businessHolidDay.RecurrenceType == RECURSYEARLY){todayDt = todayDt.addYears(1);
            }else if(businessHolidDay.RecurrenceType == RECURSYEARLYNTH){
                todayDt = todayDt.addYears(1);
                todayDt = getHolidayDate(todayDt,businessHolidDay);   }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSMONTHLY){todayDt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);
                todayDt = getHolidayDate(todayDt,businessHolidDay);    }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSMONTHLYNTH){date dt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);      
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSWEEKLY){todayDt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);        
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSDAILY){ todayDt = todayDt.addDays(businessHolidDay.RecurrenceInterval);
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSEVERYWEEKDAY){todayDt = todayDt.addDays(1);
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
        if(monthName == JANUARY_MONTH){ return 1;
        }else if(monthName == FEBRUARY_MONTH){ return 2;
        }else if(monthName == MARCH_MONTH){return 3;
        }else if(monthName == APRIL_MONTH){return 4;
        }else if(monthName == MAY_MONTH){return 5;
        }else if(monthName == JUNE_MONTH){return 6;
        }else if(monthName == JULY_MONTH){return 7;
        }else if(monthName == AUGUST_MONTH){return 8;
        }else if(monthName == SEPTEMBER_MONTH){return 9;
        }else if(monthName == OCTOBER_MONTH){return 10;
        }else if(monthName == NOVEMBER_MONTH){return 11;
        }else if(monthName == DECEMBER_MONTH){return 12;}return 1;
    }
    Public  static Date getHolidayDate(Date todayDt,Holiday businessHolidDay){
          integer year = todayDt.year();
            integer month = getMonthNumber(businessHolidDay.RecurrenceMonthOfYear); integer day = 0;
        if(businessHolidDay.RecurrenceDayOfWeekMask == 127){  if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_FIRST){  day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_SECOND){ day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_THIRD){day = 1; }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_FOURTH){day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_LAST){day = Date.daysInMonth(year, month);  
            } 
            return Date.newInstance(year,month,day);
        }else{
            date dt = todayDt;            
            Date weekDay = todayDt.toStartOfMonth().toStartOfWeek(); 
            
            if(businessHolidDay.RecurrenceDayOfWeekMask == 2) weekDay = weekDay.addDays(1);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 4)  weekDay = weekDay.addDays(2);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 8) weekDay = weekDay.addDays(3);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 16)
                weekDay = weekDay.addDays(4);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 32)
                weekDay = weekDay.addDays(5);     else if(businessHolidDay.RecurrenceDayOfWeekMask == 64) weekDay = weekDay.addDays(6);  
            
            if((todayDt.month() > 1 && weekDay.month() < todayDt.month()) || (todayDt.month() == 1 && weekDay.month() == 12))
                weekDay = weekDay.addDays(7);
            
            if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_SECOND){ weekDay = weekDay.addDays(7);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_THIRD){weekDay = weekDay.addDays(14);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_FOURTH){
                weekDay = weekDay.addDays(21); }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_LAST){weekDay = weekDay.addDays(28);        
            }
            
            if((todayDt.month() < 12 && weekDay.month() > todayDt.month()) || (todayDt.month() == 12 && weekDay.month() == 1))weekDay = weekDay.addDays(-7);
            return weekDay;
        }
    }
    
    /*
    @AuraEnabled
    public static AuraResponse getRouteSchedule(String selectedDays){
        AuraResponse r = new AuraResponse('routeScheduleRestWebService.getRouteSchedule()');
        routeScheduleRestWebService assign = new routeScheduleRestWebService();
        Date newDate = Date.valueOf(selectedDays); 
        DateTime dt = (DateTime)Cache.Session.get('datetime');
        r.data.put('dt',dt);
        assign.setRouteData = getRouteScheduleData(newDate);
        r.data.put('setShipLines', assign.setRouteData);
        return r;
    }  
    */
    
    @AuraEnabled  
    public static List<Route_Schedule__c> getRouteScheduleData(Date selectedDay) { 
        system.debug('selectedDay>>'+selectedDay);
        Date newDate = Date.valueOf(selectedDay); 
        List<Route_Schedule__c> res = new LIST<Route_Schedule__c>();  
        res = [SELECT Id, Name,Route_Date__c,Route_Start_Time__c,Route_End_Time__c,Driver__c,Vehicle__c,Status__c,Vehicle__r.Name,Driver__r.Name,Site__c,Site__r.Name,VehicleId__c FROM Route_Schedule__c WHERE Route_Date__c=:newDate ];
        return res;
    }
    
    
    
    
     @AuraEnabled
    public static AuraResponse getDataLight(String recordId){
        
        AuraResponse r = new AuraResponse('routeScheduleRestWebService.getDataLight()');
        routeScheduleRestWebService assign = new routeScheduleRestWebService();
                Route_Schedule__c routeRes = [Select Id, Name,Route_Date__c,Route_Start_Time__c,Route_End_Time__c,Driver__c,Vehicle__c,Status__c,Vehicle__r.Name,Driver__r.Name,Address__c  From Route_Schedule__c where Id =: recordId  Limit 1];

        assign.setRouteSchedule = getRouteInfo(recordId);
        assign.setRsLines = getRouteScheduleLineData(recordId);
               r.data.put('assignedVehicleId', routeRes.Vehicle__c); 
        r.data.put('assignedDriverId', routeRes.Driver__c); 
        r.data.put('setRouteSchedule', assign.setRouteSchedule);
        r.data.put('setRsmLines', assign.setRsLines); 
      
        return r;
    }
    
        
      public static Route_Schedule__c getRouteInfo(String recordId){
        
        Route_Schedule__c routeRes = [Select Id, Name,Route_Date__c,Route_Start_Time__c,Route_End_Time__c,Driver__c,Vehicle__c,Status__c,Vehicle__r.Name,Driver__r.Name,Address__c,Route_Name__c,Site__c,Site__r.Name,VehicleId__c  From Route_Schedule__c where Id =: recordId  Limit 1];
        return routeRes;
    }
    
    
    @AuraEnabled  
    public static List<Route_Schedule_Line__c> getRouteScheduleLineData(String recordId) { 
        
        List<Route_Schedule_Line__c> res = new LIST<Route_Schedule_Line__c>();  
        res = [SELECT Id, Name,Window_Start__c,Window_End__c,Sales_Order__c,Sales_Order__r.Name,Purchase_Order__c,Purchase_Order__r.Name,Shipping_Manifest__c,Shipping_Manifest__r.Name,Planned_Arrival_Time__c,Planned_Departure_Time__c,Route_Schedule__r.Address__c,Delivery_Address__c,Schedule_sequence__c,Route_Schedule__r.Site__c,Route_Schedule__r.Site__r.Name FROM Route_Schedule_Line__c WHERE Route_Schedule__c=:recordId ORDER BY Schedule_sequence__c,Planned_Arrival_Time__c ASC ];
        return res;
    }
    
      @AuraEnabled
    public static AuraResponse assignDriverVehicle(Id recordId, Id driverId, Id vehicleId,Date rDate, String selectedOption){
        AuraResponse r = new AuraResponse('routeScheduleRestWebService.assignDriverVehicle()'); 
                routeScheduleRestWebService assign = new routeScheduleRestWebService();

        string errorMessage;
        Date routeDate = Date.valueOf(rDate); 
       system.debug('shmainDate>>'+routeDate);
        List<Route_Schedule__c> updateRoute = [SELECT Id,Driver__c,Vehicle__c,Status__c  FROM Route_Schedule__c WHERE Id =: recordId];
         List<Route_Schedule__c> updateRoutevalidate = [SELECT Id,Driver__c,Vehicle__c  FROM Route_Schedule__c WHERE Route_Date__c =:routeDate and Driver__c=:driverId AND Id !=: recordId];
         List<Route_Schedule__c> updateRoutevalidatevehicle= [SELECT Id,Driver__c,Vehicle__c  FROM Route_Schedule__c WHERE Route_Date__c =:routeDate and Vehicle__c=:vehicleId AND Id !=: recordId];
        system.debug('rDate>>>'+routeDate);
		 system.debug('updateRoutevalidate>>>'+updateRoutevalidate.size());
        system.debug('updateRoutevalidatevehicle>>>'+updateRoutevalidatevehicle.size());
        
        
        if(updateRoutevalidate.size()>=1){  errorMessage = 'driverExists';r.data.put('errorMessage', errorMessage); 

        }else if(updateRoutevalidatevehicle.size()>=1){  errorMessage = 'vehicleExists'; r.data.put('errorMessage', errorMessage); 

        }else {
              
        for(Route_Schedule__c res : updateRoute){
            
                
            res.Driver__c = driverId;
            res.Vehicle__c = vehicleId;
            if(selectedOption == 'Save & Publish')
            {
                 res.Status__c = SHIPPING_MANIFEST_STRING_PUBLISHED;
            }
        }
        
        try {
            if(updateRoute.size() > 0) 
            {
                
                update updateRoute;
                    system.debug('selectedOption>>'+selectedOption);
                system.debug('updateRoute>>'+updateRoute);
                 if(selectedOption == 'Save & Publish')
            {
                 Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{};
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String htmlBody = 'Hello';
                
                
                Integer i = 1;
                
                htmlBody += ',<br><br>Route schedule information: ';
                
                htmlBody += '<br><br><table cellspacing="0" cellpadding="5" style="border:1px solid #000;width: 100%;"><tr style="border:1px solid #000"><th style="border:1px solid #000"> Route# </th><th style="border:1px solid #000"> Site </th><th style="border:1px solid #000">Date</th><th style="border:1px solid #000">Start Time</th><th style="border:1px solid #000">End Time</th><th style="border:1px solid #000">Driver</th><th style="border:1px solid #000">Vehicle</th><th style="border:1px solid #000">Status</th></tr>';
                
                List<Route_Schedule__c> Lists = [SELECT Name,Site__c,Site__r.Name,Route_Date__c,Route_Start_Time__c,Route_End_Time__c,Driver__c,Driver__r.Related_User__r.Email
                                                 ,Driver__r.Name,Vehicle__c,Vehicle__r.Name,Status__c FROM Route_Schedule__c WHERE id =:recordId];
                
                for(Route_Schedule__c rsList : Lists){
                    
                     String routeStartTime = timeConvertion(string.valueOf(rsList.Route_Start_Time__c)); String routeEndTime = timeConvertion(string.valueOf(rsList.Route_End_Time__c));
                    Date dtTodayDate =rsList.Route_Date__c ;
                    Datetime dtTodayDateTime = datetime.newInstance(dtTodayDate.year(), dtTodayDate.month(),dtTodayDate.day()); string strDate = dtTodayDateTime.format('YYYY-MM-dd');
                    
                    htmlBody +='<tr style="border:1px solid #000">' +'<td style="border:1px solid #000">'+ rsList.Name +'</td>';
                    
                    htmlBody +='<td style="border:1px solid #000">'+ rsList.Site__r.Name +'</td>';  htmlBody +='<td style="border:1px solid #000">'+ strDate+'</td>';htmlBody +='<td style="border:1px solid #000">'+ routeStartTime+'</td>';  htmlBody +='<td style="border:1px solid #000">'+routeEndTime+'</td>';
                    
                    htmlBody +='<td style="border:1px solid #000">'+ rsList.Driver__r.Name +'</td>'; htmlBody +='<td style="border:1px solid #000">'+ rsList.Vehicle__r.Name +'</td>';
                    
                    htmlBody +='<td style="border:1px solid #000">'+ rsList.Status__c +'</td></tr>';
                   
                    
                }
                
                htmlBody +='</table>';
                
                htmlBody += '<br><br><br>';
                
                // List<Id> rsId = Lists.Id;
                
                List<Route_Schedule_Line__c> lineList = [SELECT Name,Window_Start__c,Window_End__c,Planned_Arrival_Time__c,Planned_Departure_Time__c,Shipping_Manifest__c,Shipping_Manifest__r.Name,Sales_Order__c,Sales_Order__r.Name,Purchase_Order__c,Purchase_Order__r.Name,Route_Schedule__r.Address__c,Delivery_Address__c FROM Route_Schedule_Line__c WHERE Route_Schedule__c =:recordId]; 
                
                htmlBody += '<table cellspacing="0" cellpadding="5" style="border:1px solid #000;width: 100%;"><tr style="border:1px solid #000"><th style="border:1px solid #000"> Sq.No </th><th style="border:1px solid #000"> Name </th><th style="border:1px solid #000"> Window Start </th><th style="border:1px solid #000">Window End</th><th style="border:1px solid #000">Arival Time</th><th style="border:1px solid #000">Departure Time</th><th style="border:1px solid #000">Address</th><th style="border:1px solid #000">Shipping Manifest</th><th style="border:1px solid #000">Sales Order</th><th style="border:1px solid #000">Purchase Order</th>';
                
                
                

//String dtStr=dt.format('HH:mm');
                
                for(Route_Schedule_Line__c rsLineList : lineList) {String windowStartTime='';   String windowEndTime ='';
                     String plannedArrTime ='';  String plannedepTime=''; windowStartTime = timeConvertion(string.valueOf(rsLineList.Window_Start__c));windowEndTime = timeConvertion(string.valueOf(rsLineList.Window_End__c));
                      plannedArrTime = timeConvertion(string.valueOf(rsLineList.Planned_Arrival_Time__c));plannedepTime = timeConvertion(string.valueOf(rsLineList.Planned_Departure_Time__c));
             
                    
                  
                    
                  //  String stTime = routeScheduleRestWebService.timeConvertion(rsLineList.Window_Start__c);
                    
                    htmlBody +='<tr style="border:1px solid #000">' +'<td style="border:1px solid #000">'+ i +'</td>';htmlBody +='<td style="border:1px solid #000">'+ rsLineList.Name +'</td>';
                    
                    htmlBody +='<td style="border:1px solid #000">'+windowStartTime+'</td>'; htmlBody +='<td style="border:1px solid #000">'+windowEndTime+'</td>';  htmlBody +='<td style="border:1px solid #000">'+plannedArrTime+'</td>'; htmlBody +='<td style="border:1px solid #000">'+plannedepTime+'</td>';
                    
                    htmlBody +='<td style="border:1px solid #000">'+ rsLineList.Delivery_Address__c +'</td>';htmlBody +='<td style="border:1px solid #000">'+ rsLineList.Shipping_Manifest__r.Name +'</td>';
                      if(rsLineList.Sales_Order__r.Name !=NULL){  htmlBody +='<td style="border:1px solid #000">'+ rsLineList.Sales_Order__r.Name +'</td>';
                    }else{
                        htmlBody +='<td style="border:1px solid #000">---</td>';
                    }
                    
                    if(rsLineList.Purchase_Order__r.Name!=NULL){ htmlBody +='<td style="border:1px solid #000">'+ rsLineList.Purchase_Order__r.Name +'</td></tr>';
                    }else{
                                                htmlBody +='<td style="border:1px solid #000">---</td></tr>';
                    }
                    
                    
                    i++;
                }
                
                htmlBody +='</table>';                String UserName =Lists[0].Driver__r.Name;
                if(UserName!=Null){ User activeUser = [Select Email From User where Name =: UserName limit 1];String userEmail = activeUser.Email;
                    
                    
                    
                    mail.setToAddresses(new list<string>{userEmail});
                    mail.setSubject('Route Schedule Detail');  mail.setHtmlBody(htmlBody);
                    emails.add(mail);Messaging.sendEmail(emails);
                }
                
            } 
            }
            
        } catch (Exception ex){
            ErrorLogs.log('routeScheduleRestWebService:assignDriver()', ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()); message = String.valueOf(msg); r.data.put('errorMessage', message);
            return r;
        }
            
        }
        
        
      
        return r;
    }
    
     @AuraEnabled
    public static AuraResponse publishRoute(Id recordId){
        AuraResponse r = new AuraResponse('routeScheduleRestWebService.publishRoute()'); 
        
        List<Route_Schedule__c> updateRoute = [SELECT Id,Status__c  FROM Route_Schedule__c WHERE Id =: recordId];
        
        for(Route_Schedule__c res : updateRoute){
            res.Status__c = SHIPPING_MANIFEST_STRING_PUBLISHED;
        }
        
        try {
            if(updateRoute.size() > 0) 
            {
                update updateRoute;
                
                
                
                Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{};
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String htmlBody = 'Hello';
                
                
                Integer i = 1;
                
                htmlBody += ',<br><br>Route schedule information: ';
                
                htmlBody += '<br><br><table cellspacing="0" cellpadding="5" style="border:1px solid #000;width: 100%;"><tr style="border:1px solid #000"><th style="border:1px solid #000"> Route# </th><th style="border:1px solid #000"> Site </th><th style="border:1px solid #000">Date</th><th style="border:1px solid #000">Start Time</th><th style="border:1px solid #000">End Time</th><th style="border:1px solid #000">Driver</th><th style="border:1px solid #000">Vehicle</th><th style="border:1px solid #000">Status</th></tr>';
                
                List<Route_Schedule__c> Lists = [SELECT Name,Site__c,Site__r.Name,Route_Date__c,Route_Start_Time__c,Route_End_Time__c,Driver__c,Driver__r.Related_User__r.Email
                                                 ,Driver__r.Name,Vehicle__c,Vehicle__r.Name,Status__c FROM Route_Schedule__c WHERE id =:recordId];
                
                for(Route_Schedule__c rsList : Lists){
                    
                     String routeStartTime = timeConvertion(string.valueOf(rsList.Route_Start_Time__c));
                     String routeEndTime = timeConvertion(string.valueOf(rsList.Route_End_Time__c));Date dtTodayDate =rsList.Route_Date__c ;
                    Datetime dtTodayDateTime = datetime.newInstance(dtTodayDate.year(), dtTodayDate.month(),dtTodayDate.day());
                    string strDate = dtTodayDateTime.format('YYYY-MM-dd');
                    
                    htmlBody +='<tr style="border:1px solid #000">' +'<td style="border:1px solid #000">'+ rsList.Name +'</td>';htmlBody +='<td style="border:1px solid #000">'+ rsList.Site__r.Name +'</td>';htmlBody +='<td style="border:1px solid #000">'+ strDate+'</td>';
                    
                    htmlBody +='<td style="border:1px solid #000">'+ routeStartTime+'</td>'; htmlBody +='<td style="border:1px solid #000">'+routeEndTime+'</td>'; htmlBody +='<td style="border:1px solid #000">'+ rsList.Driver__r.Name +'</td>'; htmlBody +='<td style="border:1px solid #000">'+ rsList.Vehicle__r.Name +'</td>';
                    
                    htmlBody +='<td style="border:1px solid #000">'+ rsList.Status__c +'</td></tr>';
                   
                    
                }
                
                htmlBody +='</table>'; htmlBody += '<br><br><br>';
                
                // List<Id> rsId = Lists.Id;
                
                List<Route_Schedule_Line__c> lineList = [SELECT Name,Window_Start__c,Window_End__c,Planned_Arrival_Time__c,Planned_Departure_Time__c,Shipping_Manifest__c,Shipping_Manifest__r.Name,Sales_Order__c,Sales_Order__r.Name,Purchase_Order__c,Purchase_Order__r.Name,Route_Schedule__r.Address__c,Delivery_Address__c FROM Route_Schedule_Line__c WHERE Route_Schedule__c =:recordId]; 
                
                htmlBody += '<table cellspacing="0" cellpadding="5" style="border:1px solid #000;width: 100%;"><tr style="border:1px solid #000"><th style="border:1px solid #000"> Sq.No </th><th style="border:1px solid #000"> Name </th><th style="border:1px solid #000"> Window Start </th><th style="border:1px solid #000">Window End</th><th style="border:1px solid #000">Arival Time</th><th style="border:1px solid #000">Departure Time</th><th style="border:1px solid #000">Address</th><th style="border:1px solid #000">Shipping Manifest</th><th style="border:1px solid #000">Sales Order</th><th style="border:1px solid #000">Purchase Order</th>';
                
                
                

//String dtStr=dt.format('HH:mm');
                
                for(Route_Schedule_Line__c rsLineList : lineList) {   String windowStartTime='';String windowEndTime ='';
                     String plannedArrTime ='';  String plannedepTime='';
                     windowStartTime = timeConvertion(string.valueOf(rsLineList.Window_Start__c));windowEndTime = timeConvertion(string.valueOf(rsLineList.Window_End__c));
                      plannedArrTime = timeConvertion(string.valueOf(rsLineList.Planned_Arrival_Time__c)); plannedepTime = timeConvertion(string.valueOf(rsLineList.Planned_Departure_Time__c));
              
                    htmlBody +='<tr style="border:1px solid #000">' +'<td style="border:1px solid #000">'+ i +'</td>';  htmlBody +='<td style="border:1px solid #000">'+ rsLineList.Name +'</td>'; htmlBody +='<td style="border:1px solid #000">'+windowStartTime+'</td>';
                    
                    htmlBody +='<td style="border:1px solid #000">'+windowEndTime+'</td>';htmlBody +='<td style="border:1px solid #000">'+plannedArrTime+'</td>';
                    
                    htmlBody +='<td style="border:1px solid #000">'+plannedepTime+'</td>'; htmlBody +='<td style="border:1px solid #000">'+ rsLineList.Delivery_Address__c +'</td>';
                    
                    htmlBody +='<td style="border:1px solid #000">'+ rsLineList.Shipping_Manifest__r.Name +'</td>';  if(rsLineList.Sales_Order__r.Name !=NULL)
                    {
                    htmlBody +='<td style="border:1px solid #000">'+ rsLineList.Sales_Order__r.Name +'</td>'; }else{
                        htmlBody +='<td style="border:1px solid #000">---</td>';
                    }
                    
                    if(rsLineList.Purchase_Order__r.Name!=NULL) {htmlBody +='<td style="border:1px solid #000">'+ rsLineList.Purchase_Order__r.Name +'</td></tr>';
                    }else{
                                                htmlBody +='<td style="border:1px solid #000">---</td></tr>';
                    }
                    
                    
                    i++;
                }
                
                htmlBody +='</table>'; String UserName =Lists[0].Driver__r.Name;
                if(UserName!=Null){   User activeUser = [Select Email From User where Name =: UserName limit 1]; String userEmail = activeUser.Email;
                    
                    
                    
                    mail.setToAddresses(new list<string>{userEmail});
                    mail.setSubject('Route Schedule Detail'); 
                    mail.setHtmlBody(htmlBody);emails.add(mail);
                    Messaging.sendEmail(emails);
                }
                
                
                
            } 
            
        } catch (Exception ex){
            ErrorLogs.log('routeScheduleRestWebService:assignDriver()',  ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()); message = String.valueOf(msg); r.data.put('errorMessage', message);
            return r;
        }
        return r;
    }
    
    
    public static String timeConvertion(String startTime)
    {//first 2 characters are hour
        Integer hour = Integer.valueOf(startTime.left(2));   Integer minute = Integer.valueOf(startTime.substringBetween(':',':')); // between both : in String
        
        DateTime myDT = DateTime.newInstance(Date.today(), Time.newInstance(hour, minute, 0, 0)); // only care about hour and minute
        String myDate = myDT.format('h:mm a');return myDate;
    }
    
    
    
    /** Ship Confirm Console New Screen **/
    
     /*** 
    Shipmainfest  Lightning conversion code
    Ship Mainfest List With Pending Invoice Count & Google Map Distance Calcuation
    **/ 
     
    /** Method to return data to component **/
    
         @AuraEnabled 
    public List<Route_Schedule_Line__c> setRoutedatas {get; set;}
           @AuraEnabled public List<accountLocationWrapper> setgeolocation {get; set;}
    @AuraEnabled
    public static AuraResponse shipConfirmRoute(String selectedDays){
        AuraResponse r = new AuraResponse('routeScheduleRestWebService.shipConfirmLight()');
        routeScheduleRestWebService assign = new routeScheduleRestWebService();
      //  assign.selectedDay = selectedDays;
        Date newDate = Date.valueOf(selectedDays); 
        DateTime dt = (DateTime)Cache.Session.get('datetime');
        r.data.put('dt',dt);
        assign.setRoutedatas = getRouteLineData(selectedDays);
        assign.setgeolocation = getLocation(newDate);
        r.data.put('setRoutedata', assign.setRoutedatas);
       r.data.put('getLocation', assign.setgeolocation);
        return r;
    }  
    
    @AuraEnabled  
    public static List<Route_Schedule_Line__c> getRouteLineData(String selectedDays) { 
         Date newDate = Date.valueOf(selectedDays);
        List<Route_Schedule_Line__c> res = new LIST<Route_Schedule_Line__c>();  
        res = [SELECT Id, Name,Window_Start__c,Window_End__c,Sales_Order__c,Sales_Order__r.Name,Purchase_Order__c,Purchase_Order__r.Name,Shipping_Manifest__c,Shipping_Manifest__r.Name,Planned_Arrival_Time__c,Planned_Departure_Time__c,Shipping_Manifest__r.Receiver_Name__r.DBA__c,Shipping_Manifest__r.Receiver_Name__r.Id,
             Shipping_Manifest__r.Box_Count__c,Shipping_Manifest__r.Customer_PO_or_Quote__c,Shipping_Manifest__r.Metrc_Manifest__c,Shipping_Manifest__r.Payment_Terms__c,Shipping_Manifest__r.Receiver_Contact__r.Name,Shipping_Manifest__r.Receiver_Phone__c,Shipping_Manifest__r.Receiver_Contact__c,Route_Schedule__r.Address__c,Delivery_Address__c,Schedule_sequence__c,Route_Schedule__r.Site__c,Route_Schedule__r.Site__r.Name,Route_Date__c FROM Route_Schedule_Line__c WHERE Route_Date__c=:newDate ORDER BY Schedule_sequence__c,Planned_Arrival_Time__c ASC ];
        return res;
    }
        
    
         /** Method to get receiver address for googlemap distance calculation **/
    @AuraEnabled
    public static list<accountLocationWrapper> getLocation(Date selectedDay){

        list<accountLocationWrapper> lstALW = new list<accountLocationWrapper>();
        Date newDate = Date.valueOf(selectedDay); 
        String driverName = UserInfo.getName();
        Id rsmRecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
      //  List <Shipping_Manifest__c> smLocationList = new List <Shipping_Manifest__c>();
      List<Route_Schedule_Line__c> smLocationList = new LIST<Route_Schedule_Line__c>();  
        Boolean isMasterGroupMember = false;
        Company_Custom_Settings__c companySettings = Company_Custom_Settings__c.getOrgDefaults();
        
        if(companySettings != null && String.isNotBlank(companySettings.Ship_Confirm_Master_User_Group__c)){
            for(Group g: [SELECT Id, Name,(SELECT Id, UserOrGroupId FROM GroupMembers) FROM Group WHERE Name = :companySettings.Ship_Confirm_Master_User_Group__c]){
                if(!g.GroupMembers.isEmpty()){
                    for(GroupMember GM: g.GroupMembers){
                        if(UserInfo.getUserId() == GM.UserOrGroupId){  
                            isMasterGroupMember = true;   break;
                           
                        }
                    }
                }
            }
        }
        
        // Get recordTypeIds from Method
        Set<Id> smRecordTypeIds= new Set<Id>();
        smRecordTypeIds = smRecordTypeIds();
        String smListQuery= '';
        
          smListQuery = 'SELECT Id, Name,Delivery_Address__c,Schedule_sequence__c,Route_Date__c FROM Route_Schedule_Line__c WHERE Route_Date__c=:newDate ORDER BY Schedule_sequence__c,Planned_Arrival_Time__c ASC';
                   smLocationList = Database.query(smListQuery);
        /*
        
        smListQuery = 'Select  RecordType.Name,Supplier_Address__c,Supplier_City_State_Zip__c,Receiver_Contact__r.Name,Receiver_Address__c,Receiver_City_State_Zip__c,Site__c,Site__r.Name,Site__r.License_ID__r.License_Address__c,Site__r.License_ID__r.License_City__c,Site__r.License_ID__r.License_Country__c,Site__r.License_ID__r.License_State__c,Site__r.License_ID__r.License_Zip__c From Shipping_Manifest__c where Status__c NOT IN (:SHIPPING_MANIFEST_STATUS_CANCELLED,:SHIPPING_MANIFEST_STATUS_COMPLETE,:SHIPPING_MANIFEST_STATUS_RECEIVED,:SHIPPING_MANIFEST_STATUS_DRAFT) AND Planned_Ship_Transfer_Date__c=:newDate '
            +(!isMasterGroupMember?' AND Driver__r.Name =: driverName ':'')
            +' AND Actual_Arrival_Date_Time__c = null AND Receiver_Acceptance_Date__c = null '
            +' AND (Picklist__c = NULL OR Picklist__r.Status__c =: PICKLIST_STATUS_QACONFIRM)'
            +' AND  RecordTypeId IN :smRecordTypeIds ORDER By Id';
        smLocationList = Database.query(smListQuery);
        
        */
        for (Route_Schedule_Line__c    acc: smLocationList)
        {
            locationDetailWrapper oLocationWrap = new locationDetailWrapper();
            accountLocationWrapper oWrapper = new accountLocationWrapper();
            oWrapper.icon = 'utility:location'; 
              oWrapper.description = acc.Delivery_Address__c;
             oWrapper.rsAddress  = acc.Delivery_Address__c+' ';
         //   oWrapper.description = acc.Site__r.License_ID__r.License_Address__c+','+acc.Site__r.License_ID__r.License_City__c+', '+acc.Site__r.License_ID__r.License_Country__c+','+acc.Site__r.License_ID__r.License_State__c+' '+acc.Site__r.License_ID__r.License_Zip__c;
           /*if(acc.RecordType.Name== SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM) {  oWrapper.rsAddress  = acc.Supplier_Address__c+' '+acc.Supplier_City_State_Zip__c; 
          
             
           }else{
               
                oWrapper.rsAddress  = acc.Receiver_Address__c+' '+acc.Receiver_City_State_Zip__c; 
           }*/
            oWrapper.location = oLocationWrap;
            lstALW.add(oWrapper);
        }
        return lstALW;
    } 
     
    /* wrapper class to store required properties for "lightning:map" component' */ 
    public class accountLocationWrapper{
        @AuraEnabled public string icon{get;set;} 
        @AuraEnabled public string title{get;set;} 
        @AuraEnabled public string description{get;set;} 
        @AuraEnabled public string rsAddress{get;set;} 
        @AuraEnabled public string SourceAddress{get;set;} 
        @AuraEnabled public locationDetailWrapper location{get;set;} 
    }
    
    /* sub wrapper class to store location details for "accountLocationWrapper" location property.*/ 
    public class locationDetailWrapper{
        @AuraEnabled public string Street{get;set;}
        @AuraEnabled public string PostalCode{get;set;}
    }
    
    // get record types rsm, tsm, tranfer, lab
    public static Set<Id> smRecordTypeIds(){ 
        
        Set<Id> smRecordTypeIds = new Set<Id>();
        smRecordTypeIds.add(ShippinManifestSupport.getRSMRecordTypeId()) ;
        smRecordTypeIds.add(ShippinManifestSupport.getTSMRecordTypeId()) ;
      //  smRecordTypeIds.add(ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER));
       // smRecordTypeIds.add(ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_LAB));
       // smRecordTypeIds.add(ShippinManifestSupport.getTransferRecordTypeId('Cash_Collection'));
        return smRecordTypeIds;
        
    }
    
    
    
    
}