global class routeSchduleBatch implements Database.Batchable<sObject>,Database.AllowsCallouts {
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
 global Database.QueryLocator start(Database.BatchableContext BC) {
        // collect the batches of records or objects to be passed to execute

     
     DateTime myDateTime = DateTime.newInstance(system.today().year(),system.today().month(), system.today().day()+1, 0 , 0,0);
     String strDate = myDateTime.format('yyyy-MM-dd');
     
     DateTime todaysDate = System.today()+1;
     Date routeDate = Date.valueOf(todaysDate);

   List<Route_Schedule__c> getRoute = new  List<Route_Schedule__c>();
        Set<ID> routeIds = new Set<ID>();
           Set<ID> smIds = new Set<ID>();
        getRoute = [select Id, name,Status__c,(Select id, Name,Shipping_Manifest__c from Route_Schedule_Lines__r)  from Route_Schedule__c where Route_Date__c=:routeDate ];
        if(getRoute.size() > 0 ){
            for(Route_Schedule__c  routeVal :getRoute){
                if(routeVal.Status__c!='Published'){
                    routeIds.add(routeVal.Id);
                }else{
                    for(Route_Schedule_Line__c resLine : routeVal.Route_Schedule_Lines__r){
                        smIds.add(resLine.Shipping_Manifest__c);
                        
                    }
                }
                
            }
        }
     
     
     
return Database.getQueryLocator([SELECT Id,Name , License_ID__r.License_Address__c , License_ID__r.License_Zip__c ,
 License_ID__r.License_Country__c ,(SELECT Id, Name ,  Sales_Order__c, Purchase_Order__c,Purchase_Order__r.Receiver_Address__c,Purchase_Order__r.Receiver_City_State_Zip__c , 
 Purchase_Order__r.Name ,Sales_Order__r.Name, Purchase_Order__r.Supplier_Address__c , Purchase_Order__r.Supplier_City_State_Zip__c , 
 Sales_Order__r.Receiver_Address__c , Sales_Order__r.Receiver_City_State_Zip__c , Route_Start_Time__c , Route_End_Time__c , Window_Start__c , Window_End__c , Status__c , 
Planned_Ship_Transfer_Date__c FROM Shipping_Manifests__r WHERE Planned_Ship_Transfer_Date__c =:routeDate AND Id NOt IN:smIds ) FROM Site__c]);
     
    }
     
    global void execute(Database.BatchableContext BC, List<Site__c> siteList) {
        

        Datetime getCurrentSystemTime = System.now();
        String dayOfWeek = getCurrentSystemTime.format('EEEE');
         Date nextDayDate;
      if(dayOfWeek !='Saturday' && dayOfWeek!='Sunday')
      {
           if(dayOfWeek=='Friday')
           {
                 nextDayDate = Date.Today().addDays(3);
           }else{
                 nextDayDate = Date.Today().addDays(1);
           }
        
        List<Holiday>  checkHoliday = [SELECT IsRecurrence,ActivityDate,RecurrenceMonthOfYear,RecurrenceEndDateOnly,RecurrenceInstance,RecurrenceDayOfWeekMask,RecurrenceInterval,RecurrenceType FROM Holiday where ActivityDate=:nextDayDate ];
          
        if(checkHoliday.size() ==0 ){
        try {
            
            JSONGenerator genJson = JSON.createGenerator(true);    
            genJson.writeStartObject();   
            genJson.writeFieldName('records');
            genJson.writeStartArray();
            for(Site__c res : siteList){
          
            genJson.writeStartObject();
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
            
            if(res.Shipping_Manifests__r.size() > 0 ) {genJson.writeFieldName('records');genJson.writeStartArray();
                for(Shipping_Manifest__c soRes : res.Shipping_Manifests__r){  genJson.writeStartObject();
                                                                            
                                                                            if(soRes.Sales_Order__c != Null)
                                                                            {
                                                                                genJson.writeStringField('Id', soRes.Id);
                                                                                genJson.writeStringField('Name', soRes.Name);
                                                                                genJson.writeStringField('orderId', soRes.Sales_Order__c);genJson.writeStringField('orderName', soRes.Sales_Order__r.Name);
                                                                                genJson.writeStringField('Receiver Address', soRes.Sales_Order__r.Receiver_Address__c);
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
                                                                            
                                                                            if(soRes.Purchase_Order__c!= Null)
                                                                            {
                                                                                genJson.writeStringField('Id', soRes.Id); genJson.writeStringField('Name', soRes.Name);
                                                                                genJson.writeStringField('orderId', soRes.Purchase_Order__c); genJson.writeStringField('orderName', soRes.Purchase_Order__r.Name);
                                                                                genJson.writeStringField('Receiver Address', soRes.Purchase_Order__r.Receiver_Address__c);
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
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://trumatics-order-route.herokuapp.com/order_route');
        //req.setEndpoint('https://trumatics-order-schedule.herokuapp.com/order_route');
        // https://trumatics-order-route.herokuapp.com/order_route
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');
        req.setBody(jsonRes);
        Http http = new Http();
        req.setTimeout(120000);
        HttpResponse res = http.send(req);
        
        String response = res.getBody();
       
        list <Route_Schedule__c> lstrs = new list <Route_Schedule__c>();
        list <Route_Schedule_Line__c> lstrsline = new list <Route_Schedule_Line__c>();
        
        
        Map<String, Object> meta = (Map<String, Object>) JSON.deserializeUntyped(response);
        
        
        
        List<Map<String, Object>> myMaps = new List<Map<String, Object>>();
        List<Object> myMapObjects = (List<Object>) meta.get('Route');
        if(myMapObjects != null){for (Object obj : myMapObjects) {myMaps.add((Map<String, Object>)obj); 
                                            }    
        }
        
        
        Map<String,Object>lstobj = new Map<String,Object>();
        for (Map<String, Object> result : myMaps) {

            String objTypeRSname = String.valueOf(result.get('Name'));
            List<string> rsnames  = new list <string>();  rsnames.add(objTypeRSname);
            list<Object> lstproperty = (list<Object>)result.get('Records'); 
            Route_Schedule__c RS = new Route_Schedule__c();
            RS.Route_Name__c = String.valueOf(result.get('Name'));
            String stId = String.valueOf(result.get('SiteId'));  RS.Site__c = stId;
            RS.Route_Date__c = Date.Today().addDays(1);  RS.Address__c = String.valueOf(result.get('address'));
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
                                        String RSLPlannedArrivalTime = String.valueOf(property.get('PlannedArrivalTime'));
                                        String[] strTimeSplit = RSLPlannedArrivalTime.split(':');
                                        Time PlannedArrivalTime = Time.newInstance( Integer.valueOf(strTimeSplit[0]),Integer.valueOf(strTimeSplit[1]),0  ,0);
                                        String RSLPlannedDepartureTime = String.valueOf(property.get('PlannedDepartureTime'));
                                        String[] strTimeSplits = RSLPlannedDepartureTime.split(':');
                                        Time DepartureTime = Time.newInstance( Integer.valueOf(strTimeSplits[0]) ,Integer.valueOf(strTimeSplits[1]) ,0  ,0);
                                        RSL.Sitename__c  =String.valueOf(property.get('SiteName')); RSL.Planned_Arrival_Time__c  =PlannedArrivalTime;
                                        RSL.Planned_Departure_Time__c  = DepartureTime; RSL.Schedule_sequence__c  = RSLSeq;
                                        RSL.Delivery_Address__c  =String.valueOf(property.get('delAddress'));
                                        RSL.VehicleId__c = String.valueOf(property.get('VehicleId'));String starttime = String.valueOf(property.get('starttime'));
                                        String[] starttimeTimeSplits = starttime.split(':');
                                        Time windowstartTime = Time.newInstance( Integer.valueOf(starttimeTimeSplits[0]),Integer.valueOf(starttimeTimeSplits[1]) ,0 ,0);
                                        String windowedtime = String.valueOf(property.get('endtime'));
                                        String[]endtimeTimeSplits = windowedtime.split(':');
                                        Time windowendTime = Time.newInstance( Integer.valueOf(endtimeTimeSplits[0]),Integer.valueOf(endtimeTimeSplits[1]) ,0 ,0);
                                        RSL.Window_Start__c = windowstartTime;RSL.Window_End__c = windowendTime;RSL.Route_Date__c = Date.Today().addDays(1);lstrsline.add(RSL);
                                       } 
            
        }
        
        
        Insert lstrs; // rs insert
      system.debug('lstrs>>'+lstrs);
        
        list <Route_Schedule_Line__c> lstrsline2 = new list <Route_Schedule_Line__c>();
        
        
        Integer i=0;
        for(Route_Schedule__c rsinsert :lstrs){Integer k=0;  for(Route_Schedule_Line__c rslinsert : lstrsline) 
                                               {if(rsinsert.Route_Name__c ==rslinsert.Sitename__c && rsinsert.VehicleId__c == rslinsert.VehicleId__c && rsinsert.Route_Date__c == rslinsert.Route_Date__c ){
                                                   rslinsert.Route_Schedule__c = rsinsert.id;lstrsline2.add(rslinsert);   }} i++;
                                              }insert lstrsline2;         
            
         
        } catch(Exception e) {
            System.debug(e);
        }
        }
      }
    }   
     
    global void finish(Database.BatchableContext BC) {
        // execute any post-processing operations like sending email
    }
}