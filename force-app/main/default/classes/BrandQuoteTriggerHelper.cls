/**************************************************************************************
Apex Class Name    : BrandQuoteTriggerHelper
Test Class         :BrandQuoteTriggerHelperTest
Version            : 1.0
Created Date       : Aug 28 2018
Function           : Used for BrandQuoteTrigger 
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresh                  09/07/2018                 Original Version
*******************************************************************************/
public class BrandQuoteTriggerHelper{
    private Static String BRANDQUOTERECORDTYPE_TRANSFER{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_DevName_Transfer_Quote');
        }set;
    }
    private Static String BRANDQUOTERECORDTYPE_SELLQUOTE{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_DevName_Sell');
        }set;
    }
    private Static String BRANDQUOTERECORDTYPE_TRANSFERQUOTE{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_DevName_Transfer_Quote');
        }set;
    }
    
    private Static String Brandquote_Status_Cancelled{
        get{
            return String.isNotBlank(Brandquote_Status_Cancelled) ? Brandquote_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand Quote Line','Brandquote_Status_Cancelled');
        }set;
    }
    private Static String STATUS_SALESORDERCANCELLED{
        get{
            return String.isNotBlank(STATUS_SALESORDERCANCELLED) ? STATUS_SALESORDERCANCELLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SalesOrder_Cancelled');
        }set;
    }
    public static Id bqSellQuoteRecordTypeId = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosByDeveloperName().get(BRANDQUOTERECORDTYPE_SELLQUOTE).getRecordTypeId();
    public static Id bqTransferQuoteRecordTypeId = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosByDeveloperName().get(BRANDQUOTERECORDTYPE_TRANSFERQUOTE).getRecordTypeId();
    public static Boolean isBQTriggerExecuted = false;
    
    public static List<Holiday> businessHolidays{
        get{
            if(businessHolidays == null){
                businessHolidays = [SELECT Id, Name, Description, ActivityDate, RecurrenceType, RecurrenceMonthOfYear, RecurrenceDayOfMonth, RecurrenceInterval FROM Holiday];
            }
            return businessHolidays;
        }set;
        
    }
    
    
    public static void updateMutualPaymentTerms(List<Brand_Quote__c> newList){
        if(newList !=null  && newList[0].Supplier_Name__c !=null && newList[0].Receiver_Name__c !=null && newList[0].Payment_Terms__c == null){       
            List<Line_Card__c> lineCardObj=[select ID,Mutual_Payment_Terms__c from Line_Card__c where Brand_Name__c=:newList[0].Supplier_Name__c  AND Retailer_Name__c=:newList[0].Receiver_Name__c limit 1];
            if(lineCardObj !=null && lineCardObj.size ()==1 && lineCardObj[0].Mutual_Payment_Terms__c !=null) {
                newList[0].Payment_Terms__c =lineCardObj[0].Mutual_Payment_Terms__c;
            }
        }
    }
    public static void updateBrandQuoteReceiverName(Map<Id,Brand_Quote__c> newList){
        Set<Id> bqIds = new Set<Id>();
        for(Brand_Quote__c bq: newList.values()){
            if(bq.Receiver_Contact__c == NULL){bqIds.add(bq.Id);}
        }
        if(bqIds.size() > 0){
            Brand_Quote__c[] BQs = [SELECT Opportunity_Name__r.Order__c,Opportunity_Name__r.Order__r.Retailer__c,Opportunity_Name__r.Order__r.Retailer_Contact__c, Opportunity_Name__r.Order__r.Customer__r.ContactId FROM Brand_Quote__c WHERE Id IN: newList.keySet() AND Opportunity_Name__r.Order__c != null AND Receiver_Contact__c =  NULL];
            if(!BQs.isEmpty()){
                for(Brand_Quote__c bq: BQs){
                    Brand_Quote__c b = newList.get(bq.Id);
                    if(bq.Opportunity_Name__r.Order__r.Retailer__c != null){
                        b.Receiver_Name__c = bq.Opportunity_Name__r.Order__r.Retailer__c;
                        b.Receiver_Contact__c = bq.Opportunity_Name__r.Order__r.Retailer_Contact__c;
                    }else if(b.Receiver_Name__c != null && bq.Opportunity_Name__r.Order__c != null){
                        b.Receiver_Contact__c =  bq.Opportunity_Name__r.Order__r.Customer__r.ContactId;
                    }
                }
                //update BQs;
            }
        }
        
        
        //Opportunity opp = [select Order__c, Order__r.Customer__r.ContactId from Opportunity where id =: oppID]
    }
    public static void updatePlanShipDate(List<Brand_Quote__c> newQuotes ,Map<Id,Brand_Quote__c> oldQuotes){
        Set<Date>holidays = new Set<Date>();
        Map<Id,Brand_Quote__c> oppMap = new Map<Id,Brand_Quote__c>();
        for(Holiday hd:businessHolidays){
            holidays.add(hd.ActivityDate);
        }
        for(Brand_Quote__c bq: newQuotes){
            if(bq.BQ_Status__c != 'Approved' && bq.Receiver_Acceptance_Date__c != null && bq.Receiver_Acceptance_Date__c != oldQuotes.get(bq.Id).Receiver_Acceptance_Date__c){
                String acceptanceTime = bq.Receiver_Acceptance_Date__c.format('hh:mm a');
                DateTime PlanShipDate = bq.Receiver_Acceptance_Date__c;
                Integer shipDays=1;
                if(acceptanceTime.endsWith('PM')){ shipDays=2;}
                else{
                    String[] timeParts = acceptanceTime.replace(' AM','').split(':');
                    if(Integer.valueOf(timeParts[0])>10 ||(Integer.valueOf(timeParts[0])==10 && Integer.valueOf(timeParts[1]) > 0)){shipDays=2;}
                }
                PlanShipDate = PlanShipDate.addDays(shipDays);
                Date shipDate = null;
                Boolean setPlanDate = false;
                while(!setPlanDate){
                    shipDate = PlanShipDate.dateGMT();
                    if(!holidays.contains(shipDate)){String dayOfWeek=PlanShipDate.formatgmt('EEEE');
                        if(dayOfWeek == 'Saturday'){PlanShipDate = PlanShipDate.addDays(2);}
                        else if(dayOfWeek == 'Sunday'){PlanShipDate = PlanShipDate.addDays(1);}
                        shipDate = PlanShipDate.dateGMT();
                        dayOfWeek=PlanShipDate.formatgmt('EEEE');
                        if(!holidays.contains(shipDate) &&(dayOfWeek != 'Saturday'&&dayOfWeek != 'Sunday')){setPlanDate = true;}
                        
                    }else{
                        PlanShipDate = PlanShipDate.addDays(1);
                        setPlanDate = false;
                    }
                    
                    
                }
                bq.Planned_Ship_Date__c =PlanShipDate.dateGMT();// Date.parse(PlanShipDate.formatGMT('MM/dd/yyyy'));
            }
            
        }
        
        
    }
    /**
* Update Site from Receiver License's Default Warehouse field
*
* @param Brand Quote List and Brand Quote oldMap
*/
    /*public static void updateSiteFromReceiverLicense(List<Brand_Quote__c> quotes,Map<Id, Brand_Quote__c> oldQuotesMap){
        Id transferRecordTypeId = Schema.SObjectType.Brand_Quote__c.getRecordTypeInfosByName().get(BRANDQUOTERECORDTYPE_TRANSFER.replace('_',' ')).getRecordTypeId();
        Map<Id,Brand_Quote__c[]> receiverLicenseBQMap = new Map<Id,Brand_Quote__c[]>();
        Set<Id> opportunityIds =new Set<Id>();
        for(Brand_Quote__c BQ: quotes){
            opportunityIds.add(BQ.Opportunity_Name__c);
        }
        Map<Id,Opportunity> opportunities =new  Map<Id,Opportunity>([SELECT Id,Order__c FROM Opportunity WHERE Id IN : opportunityIds]);
        
        for(Brand_Quote__c BQ: quotes){
            if(opportunities.get(BQ.Opportunity_Name__c).Order__c != NULL && BQ.RecordTypeId != transferRecordTypeId && BQ.Receiver_License__c != null &&(Trigger.isInsert || (Trigger.isUpdate && BQ.Receiver_License__c != oldQuotesMap.get(BQ.Id).Receiver_License__c )) ){
                if(receiverLicenseBQMap.containsKey(BQ.Receiver_License__c)){receiverLicenseBQMap.get(BQ.Receiver_License__c).add(BQ);}
                else{receiverLicenseBQMap.put(BQ.Receiver_License__c, new Brand_Quote__c[]{BQ});}
            }
        }
        if(!receiverLicenseBQMap.isEmpty()){
            State_Licenses__c[] receivingLicenses = [SELECT Id,Default_Warehouse__c  FROM State_Licenses__c WHERE Id IN:receiverLicenseBQMap.keySet()];
            for(State_Licenses__c SL: receivingLicenses){
                Brand_Quote__c[] BQList = receiverLicenseBQMap.get(SL.Id);
                if(!BQList.isEmpty()){
                    for(Brand_Quote__c BQ: BQList){
                        BQ.Site__c = SL.Default_Warehouse__c;
                    }
                }
            }
        }
    }*/
    
    public static void updateMileageFee(List<Brand_Quote__c> quotes, Map<Id,Brand_Quote__c> oldQuotes){
        if(quotes !=null){
            for(Brand_Quote__c bq: quotes){
                if(bqSellQuoteRecordTypeId != bq.RecordTypeId && bqTransferQuoteRecordTypeId!= bq.RecordTypeId && bq.Supplier_License__c != null && bq.Receiver_License__c != null && (bq.Receiver_License__c != oldQuotes.get(bq.Id).Receiver_License__c || bq.Supplier_License__c != oldQuotes.get(bq.Id).Supplier_License__c)){
                    calculateMiles(bq.id,bq.Supplier_License__c,bq.Receiver_License__c);
                    
                }
            }
        }
    }
    @future(callout=true)
    public static void calculateMiles(Id bqId, String supStateLicenseId, String recStateLicenseId ){
        
        
        Brand_Quote__c bq = [select Id,Site__c,Supplier_License__c, Supplier_License__r.Default_Warehouse__c, Supplier_Name__c, Supplier_Name__r.Membership_Level__c, Receiver_License__c,Ownership__r.Membership_Level__c, Name From Brand_Quote__c where id=:bqId];
        
        Shipping_Rates_Table__c [] mileageSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                                     Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                     FROM Shipping_Rates_Table__c 
                                                     WHERE Site__c = :bq.Supplier_License__r.Default_Warehouse__c
                                                     AND Active__c = true
                                                     AND Rate_Effective_From__c <= :System.today()
                                                     AND Rate_Effective_To__c >= :System.today()
                                                     AND Membership_Level__c = :bq.Supplier_Name__r.Membership_Level__c
                                                     Order By Mileage_Bracket__c];
        String siteId = bq.Supplier_License__r.Default_Warehouse__c;
        Decimal totalMiles = getTotalMiles(supStateLicenseId ,recStateLicenseId);
        Decimal  totalMileageFee = 0.0;                     
        if(!mileageSRTList.isEmpty() && totalMiles != null){
            for(Shipping_Rates_Table__c SRT: mileageSRTList){
                if(totalMiles <= SRT.Mileage_Bracket__c && siteId == SRT.Site__c && bq.Supplier_Name__r.Membership_Level__c == SRT.Membership_Level__c){
                    if(SRT.Fixed_Mileage_Fee__c){ 
                        totalMileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                    }else{
                        totalMileageFee = SRT.Mileage_Bracket_Price__c * totalMiles;
                        
                    }
                }    
            }
        }
        Brand_Quote__c bqUpdate = new Brand_Quote__c();
        bqUpdate.Id = bq.Id;
        bqUpdate.Total_Mileage_Fee__c = totalMileageFee;
        update bqUpdate; 
    }
    
    
    public static Decimal getTotalMiles(String supStateLicenseId, String recStateLicenseId){
        State_Licenses__c supst = [SELECT Id,License_Address__c ,License_City__c , License_Country__c,License_State__c,License_Zip__c FROM State_Licenses__c WHERE Id =:supStateLicenseId];
        State_Licenses__c recst = [SELECT Id,License_Address__c ,License_City__c , License_Country__c,License_State__c,License_Zip__c FROM State_Licenses__c WHERE Id =:recStateLicenseId];
        String url = Google_Distance_Matrix_API__c.getValues('GMaps_Endpoint').Value__c;
        String apiKey = Google_Distance_Matrix_API__c.getValues('Gmaps_APIKey').Value__c;
        String parameters = 'origins=' + supst.License_Address__c +','+ supst.License_City__c+ ','+supst.License_State__c +' '+ supst.License_Zip__c+','+ supst.License_Country__c + '&destinations=' + recst.License_Address__c +','+ recst.License_City__c +','+recst.License_State__c +' '+ recst.License_Zip__c+','+ recst.License_Country__c;
        String param2 =  '&language=en&key=';
        parameters = parameters.replace(' ','%20');
        url = url+parameters+param2+apiKey;
        url = url.replaceAll('#', '%20');

        
        HTTP http = new HTTP();
        HTTPRequest request = new HTTPRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        if(!Test.isRunningTest()){
            HTTPResponse response = http.send(request);
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
            }
        }else{
            return 50;
        }
        return 0;
    }
    public static void updateBQLIStatusToCancel(list<Brand_Quote__c>newList,Map<id,Brand_Quote__c>oldMap){
        Set<Id> bqIds = new Set<Id>();
        for(Brand_Quote__c bq : newList){
            if(bq.BQ_Status__c == STATUS_SALESORDERCANCELLED)
            	bqIds.add(bq.Id);
        }
        if(bqIds.size() > 0){
            List<Brand_Quote_Line__c> BQLIUpdates = new List<Brand_Quote_Line__c>();
            for(Brand_Quote_Line__c bqli : [SELECT id,Status__c FROM Brand_Quote_Line__c WHERE Brand_Quote_Number__c IN :bqIds]){
                
                bqli.Status__c = STATUS_SALESORDERCANCELLED;
                BQLIUpdates.add(bqli);
            }
            system.debug('##BQLIUpdates :'+BQLIUpdates);
            if(BQLIUpdates.size() > 0){
                update BQLIUpdates;
            }
        }
    }
}