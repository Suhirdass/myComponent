public class ServiceTicketTriggerHandler {
    public static boolean feesCalulated = false;
    private Static String Account_Service_Type_Margin {		
        get{
              return String.isNotBlank(Account_Service_Type_Margin) ? Account_Service_Type_Margin : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Service_Type_Margin');
        }set;
    }
    public static String FULFILLMENT_SERVICE_BOOKING{
        get{ 
            return String.isNotBlank(FULFILLMENT_SERVICE_BOOKING) ? FULFILLMENT_SERVICE_BOOKING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Booking');
        }set;
    }
    public static String FULFILLMENT_SERVICE_SCHEDULING{
        get{ 
            return String.isNotBlank(FULFILLMENT_SERVICE_SCHEDULING) ? FULFILLMENT_SERVICE_SCHEDULING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Scheduling');
        }set;
    }
    public static String FULFILLMENT_SERVICE_STAGING{
        get{ 
            return String.isNotBlank(FULFILLMENT_SERVICE_STAGING) ? FULFILLMENT_SERVICE_STAGING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Staging');
        }set;
    }
    public Static String ST_Transfer_Method_Drop_Off{
        get{
            return String.isNotBlank(ST_Transfer_Method_Drop_Off) ? ST_Transfer_Method_Drop_Off: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Transfer_Method_Drop_Off');
        }set;
    }
    public Static String ST_Transfer_Method_Pick_up{
        get{
            return String.isNotBlank(ST_Transfer_Method_Pick_up) ? ST_Transfer_Method_Pick_up: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Transfer_Method_Pick_Up');
        }set;
    }
    public Static String ST_Status_Pending{
        get{
            return String.isNotBlank(ST_Status_Pending) ? ST_Status_Pending: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Status_Pending');
        }set;
    }
    public Static String ST_Status_Cancelled {
        get{
            return String.isNotBlank(ST_Status_Cancelled ) ? ST_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Status_Cancelled');
        }set;
    }
     private static String ST_Status_Completed{
        get{
            return String.isNotBlank(ST_Status_Completed) ? ST_Status_Completed : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Status_Completed');
        }set;
    }
    private static String ST_Transfer_Method_Product_Conversions{
        get{
            return String.isNotBlank(ST_Transfer_Method_Product_Conversions) ? ST_Transfer_Method_Product_Conversions : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Service_Ticket__c','ST_Transfer_Method_Product_Conversions');
        }set;
    }
    public static void afterInsert(List<Service_Ticket__c> lstSTicket){
    	ServiceTicketTriggerHandler.onSiteProductTransfer(lstSTicket);    
    }
    
    public static void afterUpdate(List<Service_Ticket__c> lstSTicket,Map<Id,Service_Ticket__c> oldMap){
    	List<Service_Ticket__c> lstnew = new List<Service_Ticket__c>();
        Set<Id> setIds = new Set<Id>();
        Set<Id> serviceIds = new Set<Id>();
        Set<Id> cancelIds = new Set<Id>();
        
        List<Event> listEvent = new List<Event>();
        
        for(Service_Ticket__c ser : lstSTicket){
        	serviceIds.add(ser.Id);    
        }
        
        for(Service_Ticket__c ser : [select Id,Name,Request_Date_Time__c,Brand_Contact__r.Salesforce_User__c,Status__c,Transfer_Method__c from Service_Ticket__c where Id In : serviceIds]){
            Service_Ticket__c oldService = oldMap.get(ser.Id);
            if(ser.Status__c == ST_Status_Pending && (ser.Transfer_Method__c == ST_Transfer_Method_Pick_up || ser.Transfer_Method__c ==ST_Transfer_Method_Drop_Off) && ser.Request_Date_Time__c != oldService.Request_Date_Time__c){
            	lstnew.add(ser);  
                setIds.add(ser.Id);    
            } else if(ser.Status__c == ST_Status_Cancelled){
            	cancelIds.add(ser.Id); 	
            }
        }
        system.debug('@@set :'+setIds);
        
        if(cancelIds.size() > 0){
        	List<Event> lstEvent = [select Id,StartDateTime,EndDateTime,WhatId from Event where WhatId In : cancelIds];
            if(lstEvent.size() > 0){
            	delete lstEvent;    
            }
        }
        
        if(lstnew.size() > 0){
            Map<Id,Event> mapEvent = new Map<Id,Event>();
            for(Event eve : [select Id,StartDateTime,EndDateTime,WhatId from Event where WhatId In : setIds]){
            	mapEvent.put(eve.WhatId,eve);    
            }
            
            list<Event> lstEve = new List<Event>();
            for(Service_Ticket__c ser : lstnew){
                if(mapEvent.containsKey(ser.Id)){
                	Event eve = mapEvent.get(ser.Id);
                    eve.StartDateTime = ser.Request_Date_Time__c;
                    eve.EndDateTime = ser.Request_Date_Time__c.addminutes(30);
                    lstEve.add(eve);
                }	    
            }
            if(lstEve.size() > 0){
            	update lstEve;    
            }
        	ServiceTicketTriggerHandler.onSiteProductTransfer(lstnew);      
        }
    }
    
    public static void onSiteProductTransfer(List<Service_Ticket__c> lstSTicket){
        list<Event> lstEve = new List<Event>();
        Set<Id> setIds = new Set<Id>();
        
        for(Service_Ticket__c sTicket : lstSTicket){
        	setIds.add(sTicket.Id);    
        }
        for(Service_Ticket__c sTicket : [select Id,Name,Request_Date_Time__c,Status__c,Brand_Contact__r.Salesforce_User__c, Brand_Name__c, Brand_Name__r.DBA__c, Transfer_Method__c  from Service_Ticket__c where Id In : setIds AND Transfer_Method__c IN (:ST_Transfer_Method_Pick_up,:ST_Transfer_Method_Drop_Off)]){
            if(sTicket.Status__c == ST_Status_Pending ){
                if(sTicket.Request_Date_Time__c != null){
                    Event eve = new Event();
                    eve.EndDateTime = sTicket.Request_Date_Time__c.addminutes(30);
                    List<Calendar> lstCalenders = [SELECT Id,Name FROM Calendar WHERE Name =: Label.Public_Calendar_Name];
                    if(lstCalenders.size() > 0)eve.OwnerId = lstCalenders[0].Id;
                    eve.StartDateTime = sTicket.Request_Date_Time__c;
                    /*if(sTicket.Brand_Contact__r.Salesforce_User__c != null)
eve.Subject = sTicket.Brand_Contact__r.Salesforce_User__c + ''+ sTicket.Name;
else
eve.Subject = sTicket.Name;*/
                    eve.Subject = sTicket.Brand_Name__r.DBA__c + ' - '+sTicket.Transfer_Method__c;
                    eve.WhatId = sTicket.Id;
                    lstEve.add(eve);
                }    
            }
        }
        if(lstEve.size() > 0){
        	insert lstEve;    
        }
    }
    
    public static void updateFees(set<Id>setIds){
        //System.enqueueJob(new UpdateFeeQueueable(setIds));
        if(BatchToOrderAutomationFlow.isBatchFinished == true){
            String hour = String.valueOf(Datetime.now().hour());
            String min = String.valueOf(Datetime.now().minute()); 
            Integer seconds = Datetime.now().second() + 5;
            if(seconds > = 60 ){
                Integer diff = seconds - 60;
                Integer mins = Integer.valueOf(min) + 1;
                if(mins > = 60){
                    Integer minsdiff = mins - 60;
                    hour = String.valueOf(Integer.valueOf(hour) + 1);
                }
                min = String.valueOf(Integer.valueOf(min) + 1);
                seconds = diff;
            }
            String ss = String.valueOf(seconds);
            //parse to cron expression
            String nextFireTime = ss + ' ' + min + ' ' + hour + ' * * ?';
            System.schedule('ScheduledJob ' + String.valueOf(Math.random()), nextFireTime, new UpdateFeeQueueable(setIds));
        }else{
            Database.executeBatch(new UpdateFeeQueueable(setIds));
        }
        	
    }
    
    /*public static void updateFeeCalculation(set<String>setIds){
    	list<Service_Ticket__c> stList = [SELECT Id,Destination_Site__c,Brand_Name__c,Brand_Name__r.Membership_Level__c,Licensed_Premise__c,Licensed_Premise__r.Default_Warehouse__c,
				(SELECT Id,Total_Units__c,New_Packaged_Product__c,New_Packaged_Product__r.Unit_Shipping_Weight_lbs__c,New_Packaged_Product__r.MOQ__c,New_Packaged_Product__r.Case_Shipping_Weight_lbs__c FROM Service_Ticket_Lines__r) From Service_Ticket__c WHERE  Id In : setIds];
        list<Service_Ticket_Line__c>stlList = new List<Service_Ticket_Line__c>();
        for(Service_Ticket__c st : stList){
            system.debug('st.Licensed_Premise__c '+st.Licensed_Premise__c);
        	String siteId = st.Destination_Site__c != null ? st.Destination_Site__c : st.Licensed_Premise__c != null ? st.Licensed_Premise__r.Default_Warehouse__c : null;
            if(siteId != null){
                String membershipLevel = st.Brand_Name__c != null ? st.Brand_Name__r.Membership_Level__c : '';
                Decimal serviceBookingFee = 0;
                Decimal serviceSchedulingFee = 0;
                Decimal serviceStagingFee = 0;
                Decimal totalWeightFee = 0;
                Decimal totalMileageFee = 0;
                Decimal totalOrderWeight = 0;
                Decimal totalMiles = getTotalMiles(siteId,st.Licensed_Premise__c);
            
                State_Licenses__c stateLicense= [SELECT Id, Default_Warehouse__c,Total_Miles__c FROM State_Licenses__c where Id =: st.Licensed_Premise__c];            
        
                for(Service_Ticket_Line__c stl: st.Service_Ticket_Lines__r){
                    Decimal totalWeight = 0;
                    if(stl.New_Packaged_Product__c != null){
                        Decimal shippingWeight = 0;
                        if(stl.New_Packaged_Product__r.MOQ__c == 1){
                        	shippingWeight = stl.New_Packaged_Product__r.Unit_Shipping_Weight_lbs__c;    
                        }else if(stl.New_Packaged_Product__r.MOQ__c > 1){
                        	shippingWeight = stl.New_Packaged_Product__r.Case_Shipping_Weight_lbs__c;        
                        }
                        totalWeight = ( stl.Total_Units__c / stl.New_Packaged_Product__r.MOQ__c ) * shippingWeight;
                    }                    
                    stl.Total_Weight_lbs__c = totalWeight;
                    totalOrderWeight += totalWeight;
                    stlList.add(stl);
                }
        
                Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c,Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c,Membership_Level__c
                                                     FROM Fulfillment_Rates_Table__c 
                                                     WHERE Site__c = :siteId
                                                     AND Active__c = true
                                                     AND Rate_Effective_From__c <= :System.today()
                                                     AND Rate_Effective_To__c >= :System.today()
                                                     AND Membership_Level__c = :membershipLevel
                                                     ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
                Shipping_Rates_Table__c [] weightSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                                    Weight_Bracket__c, Weight_Bracket_Price__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                    FROM Shipping_Rates_Table__c 
                                                    WHERE Site__c = :siteId
                                                    AND Active__c = true
                                                    AND Rate_Effective_From__c <= :System.today()
                                                    AND Rate_Effective_To__c >= :System.today()
                                                    AND Membership_Level__c = :membershipLevel
                                                    Order By Weight_Bracket__c];
        		Shipping_Rates_Table__c [] mileageSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                                     Weight_Bracket__c, Weight_Bracket_Price__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                     FROM Shipping_Rates_Table__c 
                                                     WHERE Site__c = :siteId
                                                     AND Active__c = true
                                                     AND Rate_Effective_From__c <= :System.today()
                                                     AND Rate_Effective_To__c >= :System.today()
                                                     AND Membership_Level__c = :membershipLevel
                                                     Order By Mileage_Bracket__c];
        
                Map<String,Fulfillment_Rates_Table__c []> serviceBasedFRTMap = new Map<String,Fulfillment_Rates_Table__c []>();
                if(!FRTList.isEmpty()){
                    for(Fulfillment_Rates_Table__c FRT:FRTList){
                        if(serviceBasedFRTMap.containsKey(FRT.Fulfillment_Services__c)){
                            serviceBasedFRTMap.get(FRT.Fulfillment_Services__c).add(FRT);
                        }else{
                            serviceBasedFRTMap.put(FRT.Fulfillment_Services__c,new Fulfillment_Rates_Table__c[]{FRT});
                        }
                    }
                }
        
                if(serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_BOOKING)){
                    Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_BOOKING);
                    system.debug('FRTs '+FRTs);
                    if(!FRTs.isEmpty()){
                        System.debug('###FRT for Order Booking:'+FRTs[0]);
                        serviceBookingFee = FRTs[0].Bracket_Price__c;
                    }
                }
                if(serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_SCHEDULING)){
                    Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_SCHEDULING);
                    system.debug('FRTs '+FRTs);
                    if(!FRTs.isEmpty()){
                        System.debug('###FRT for Order Booking:'+FRTs[0]);
                        serviceSchedulingFee = FRTs[0].Bracket_Price__c;
                    }
                }
                if(serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_STAGING)){
                    Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_STAGING);
                    system.debug('FRTs '+FRTs);
                    if(!FRTs.isEmpty()){
                        System.debug('###FRT for Order Booking:'+FRTs[0]);
                        serviceStagingFee = FRTs[0].Bracket_Price__c;
                    }
                }
            
                if(!weightSRTList.isEmpty()){
                    for(Shipping_Rates_Table__c SRT: weightSRTList){
                        if(totalOrderWeight <= SRT.Weight_Bracket__c){
                            System.debug('###SRT for Weight:'+SRT);
                            if(SRT.Fixed_Weight_Fee__c){
                                totalWeightFee = SRT.Fixed_Weight_Amount__c != null ? SRT.Fixed_Weight_Amount__c : 0;
                            }else{
                                totalWeightFee = SRT.Weight_Bracket_Price__c * totalOrderWeight; 
                            }
                            break;
                        }
                    }   
                }
        
                if(!mileageSRTList.isEmpty() && stateLicense.Total_Miles__c != null){
                    for(Shipping_Rates_Table__c SRT: mileageSRTList){
                        if(totalMiles <= SRT.Mileage_Bracket__c){
                            System.debug('###SRT for Mileage Fee:'+SRT);
                            if(SRT.Fixed_Mileage_Fee__c){
                                totalMileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                            }else{
                                totalMileageFee = SRT.Mileage_Bracket_Price__c * totalMiles; 
                            }
                            
                            break;
                        }
                    }    
                }
        
                st.Total_Mileage_Fee__c = totalMileageFee;
                st.Total_Weight_Fee__c = totalWeightFee;            
                st.Service_Booking_Fee__c = serviceBookingFee;
                st.Service_Scheduling_Fee__c = serviceSchedulingFee;
                st.Service_Staging_Fee__c  = serviceStagingFee;
            }
		}
        feesCalulated =true;
        update stList;
        update stlList;    
    }
    
    @future(callout=true)
    public static void updateFeeFuture(set<String> setIds){        
        updateFeeCalculation(setIds);
    }*/
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
        if(!Test.isRunningTest()){
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
        }else{
            return 50;
        }
        return 0;
    }
    public static void manageAccountSetting(list<Service_Ticket__c>newList,Map<Id,Service_Ticket__c> oldMap){
         Map<String,List<Service_Ticket__c>> stMap  = new Map<String,List<Service_Ticket__c>>();
        set<id> stIds = new set<id>();
        Integer currentMonth = System.Today().month();
        Integer currentYear = System.Today().year();
        for(Service_Ticket__c st : newList){
            if(st.Service_Complete__c != null && st.Transfer_Method__c != null && st.Status__c == ST_Status_Completed &&
              st.Transfer_Method__c != ST_Transfer_Method_Product_Conversions ){
                stIds.add(st.id);
            }
        }
        if(stIds.size() > 0 ){
            for(Service_Ticket__c st :[ SELECT id,Brand_Name__c FROM Service_Ticket__c WHERE Id IN : stIds AND Brand_Name__r.Service_Type__c =:Account_Service_Type_Margin AND CALENDAR_MONTH(Service_Complete__c) =:currentMonth AND CALENDAR_YEAR(Service_Complete__c) =: currentYear AND Status__c =: ST_Status_Completed AND Transfer_Method__c !=: ST_Transfer_Method_Product_Conversions]){
                if(stMap.containsKey(st.Brand_Name__c)){
                    stMap.get(st.Brand_Name__c).add(st);
                }else{
                    stMap.put(st.Brand_Name__c,new List<Service_Ticket__c>{st});
                }
            }
            if(stMap.size() > 0 ){
            List<Account_Setting__c> accSettingUpdateList = new List<Account_Setting__c>();
            Set<String> alreadyCreatedAccs = new Set<String>();
            List<Account_Setting__c> accSettingList = [SELECT id,Mthly_IB__c,Mthly_OB__c,Account__c FROM Account_Setting__c WHERE Account__c IN :stMap.keySet()];
            if(accSettingList.size() > 0 || Test.isRunningTest()){
                for(Account_Setting__c accset : accSettingList){
                    accset.Mthly_IB__c = (accset.Mthly_IB__c != null ? accset.Mthly_IB__c : 0) + stMap.get(accset.Account__c).size();
                    alreadyCreatedAccs.add(accset.Account__c);
                    accSettingUpdateList.add(accset);
                }
            }
            for(String accId : stMap.keySet()){
                if(!alreadyCreatedAccs.contains(accId)){
                    Account_Setting__c accset = new Account_Setting__c();
                    accset.Account__c = accId;
                    accset.Mthly_OB__c = stMap.get(accId).size();
                    accSettingUpdateList.add(accset);
                }
            }
            if(accSettingUpdateList.size() >0){
                upsert accSettingUpdateList;
            }
        }
        }
        
    }
}