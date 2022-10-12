public class UpdateFeeQueueable implements Database.Batchable<sObject>, Database.Stateful, Database.AllowsCallouts, Schedulable {
    public Set<Id> serviceTicketIds{set;get;}
    public UpdateFeeQueueable(Set<Id> serviceTicketIds){
        this.serviceTicketIds = serviceTicketIds;
    }
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator([SELECT Id,Destination_Site__c,Brand_Name__c,Brand_Name__r.Membership_Level__c,Licensed_Premise__c,Licensed_Premise__r.Default_Warehouse__c,
				(SELECT Id,Total_Units__c,New_Packaged_Product__c,New_Packaged_Product__r.Unit_Shipping_Weight_lbs__c,New_Packaged_Product__r.MOQ__c,New_Packaged_Product__r.Case_Shipping_Weight_lbs__c FROM Service_Ticket_Lines__r) From Service_Ticket__c WHERE  Id In : serviceTicketIds]);   
    }
    public void execute(SchedulableContext sc) {
        Database.executeBatch(new UpdateFeeQueueable(serviceTicketIds));
    }
	public void execute(Database.BatchableContext bc, List<Service_Ticket__c> records){
        /*list<Service_Ticket__c> stList = [SELECT Id,Destination_Site__c,Brand_Name__c,Brand_Name__r.Membership_Level__c,Licensed_Premise__c,Licensed_Premise__r.Default_Warehouse__c,
				(SELECT Id,Total_Units__c,New_Packaged_Product__c,New_Packaged_Product__r.Unit_Shipping_Weight_lbs__c,New_Packaged_Product__r.MOQ__c,New_Packaged_Product__r.Case_Shipping_Weight_lbs__c FROM Service_Ticket_Lines__r) From Service_Ticket__c WHERE  Id In : serviceTicketIds];*/
        list<Service_Ticket_Line__c>stlList = new List<Service_Ticket_Line__c>();
        for(Service_Ticket__c st : records){
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
                Decimal totalMiles = ServiceTicketTriggerHandler.getTotalMiles(siteId,st.Licensed_Premise__c);
            
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
        
                if(serviceBasedFRTMap.containsKey(ServiceTicketTriggerHandler.FULFILLMENT_SERVICE_BOOKING)){
                    Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(ServiceTicketTriggerHandler.FULFILLMENT_SERVICE_BOOKING);
                    system.debug('FRTs '+FRTs);
                    if(!FRTs.isEmpty()){
                        System.debug('###FRT for Order Booking:'+FRTs[0]);
                        serviceBookingFee = FRTs[0].Bracket_Price__c;
                    }
                }
                if(serviceBasedFRTMap.containsKey(ServiceTicketTriggerHandler.FULFILLMENT_SERVICE_SCHEDULING)){
                    Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(ServiceTicketTriggerHandler.FULFILLMENT_SERVICE_SCHEDULING);
                    system.debug('FRTs '+FRTs);
                    if(!FRTs.isEmpty()){
                        System.debug('###FRT for Order Booking:'+FRTs[0]);
                        serviceSchedulingFee = FRTs[0].Bracket_Price__c;
                    }
                }
                if(serviceBasedFRTMap.containsKey(ServiceTicketTriggerHandler.FULFILLMENT_SERVICE_STAGING)){
                    Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(ServiceTicketTriggerHandler.FULFILLMENT_SERVICE_STAGING);
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
        ServiceTicketTriggerHandler.feesCalulated =true;
        update records;
        update stlList; 
        
    }
    public void finish(Database.BatchableContext BC){
        // Get the ID of the AsyncApexJob representing this batch job from Database.BatchableContext.
        // Query the AsyncApexJob object to retrieve the current job's information.
        AsyncApexJob a = [SELECT Id FROM AsyncApexJob WHERE Id =  :BC.getJobId()];
        
        //then use the active job id and abort it
        system.abortJob(a.id);
    }
}