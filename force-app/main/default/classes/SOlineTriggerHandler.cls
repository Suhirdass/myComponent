public class SOlineTriggerHandler {
	public static Boolean isRecursion = false;
    public static Boolean isSoCancelToShipped = false;
	private static String ORDER_TYPE_RETAIL{
        get{
            return String.isNotBlank(ORDER_TYPE_RETAIL) ? ORDER_TYPE_RETAIL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Retail');
        }set;
    }  
    private static String ACCOUNT_PLATEFORMLEVEL_BASIC {
        get{
            return String.isNotBlank(ACCOUNT_PLATEFORMLEVEL_BASIC ) ? ACCOUNT_PLATEFORMLEVEL_BASIC  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Plateformlevel_Basic');
        }set;
    }
   public Static String TYPE_BUYQUOTE{ 
        get{
            return  String.isNotBlank(TYPE_BUYQUOTE) ? TYPE_BUYQUOTE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuoteType_BuyQuote');
        }set;
    }
    private static String Account_Plateformlevel_ZASP {
        get{
            return String.isNotBlank(Account_Plateformlevel_ZASP ) ? Account_Plateformlevel_ZASP  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_DBA_ZASP');
        }set;
    }
    private static String Account_Plateformlevel_IRR {
        get{
            return String.isNotBlank(Account_Plateformlevel_IRR ) ? Account_Plateformlevel_IRR  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_DBA_IRR');
        }set;
    }
    public Static String SO_SHIPPING_METHOD_PICK_UP{ 
        get{
            return  String.isNotBlank(SO_SHIPPING_METHOD_PICK_UP) ? SO_SHIPPING_METHOD_PICK_UP :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Shipping_Method_Pick_Up');
        }set;
    }
    private Static String SALESORDER_RECORDTYPE_Transfer {		
        get{
              return String.isNotBlank(SALESORDER_RECORDTYPE_Transfer) ? SALESORDER_RECORDTYPE_Transfer: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Type_Transfer');
        }set;
    }
    private Static String SALES_ORDER_LINE_STATUS_REJECTED{
        get{
            return String.isNotBlank(SALES_ORDER_LINE_STATUS_REJECTED) ? SALES_ORDER_LINE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Rejected');
        }set;
    }
    private Static String STATUS_SALESORDERLINECANCELLED{
        get{
            return String.isNotBlank(STATUS_SALESORDERLINECANCELLED) ? STATUS_SALESORDERLINECANCELLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SalesOrderLines_Cancelled');
        }set;
    }
    public Static String SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE{
        get{
            return String.isNotBlank(SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE) ? SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Shipment_Complet');
        }set;
    }
    public static String SOLI_STATUS_ALLOCATED{
        get{
            return String.isNotBlank(SOLI_STATUS_ALLOCATED) ? SOLI_STATUS_ALLOCATED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_Status_ Allocated');
        }set;
    }
    public static String SOLI_STATUS_PARTIAL_ALLOCATED{
        get{
            return String.isNotBlank(SOLI_STATUS_PARTIAL_ALLOCATED) ? SOLI_STATUS_PARTIAL_ALLOCATED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_Status_Partially_Allocated');
        }set;
    }
    public Static String SO_STATUS_DRAFT {		
        get{
              return String.isNotBlank(SO_STATUS_DRAFT) ? SO_STATUS_DRAFT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Draft');
        }set;
    }
    public Static String SO_ORDER_TYPE_BRAND {
        get{
            return String.isNotBlank(SO_ORDER_TYPE_BRAND) ? SO_ORDER_TYPE_BRAND:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Type_Brand');
        }set;
    }
    public static String FULFILLMENT_SERVICE_PICK_PACK{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_PICK_PACK) ? FULFILLMENT_SERVICE_PICK_PACK : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Pick_Pack');
        }set;
    }
    private static String FULFILLMENT_SERVICE_QA_REVIEW{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_QA_REVIEW) ? FULFILLMENT_SERVICE_QA_REVIEW : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_QA_Review');
        }set;
    }
    private static String FULFILLMENT_SERVICE_ORDER_BOOKING{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_ORDER_BOOKING) ? FULFILLMENT_SERVICE_ORDER_BOOKING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Order_Booking');
        }set;
    }
    private static String FULFILLMENT_SERVICE_STAGE_MANIFEST{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_STAGE_MANIFEST) ? FULFILLMENT_SERVICE_STAGE_MANIFEST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Stage_Manifest');
        }set;
    }
    private static String FULFILLMENT_SERVICE_SCHEDULE_DISPATCH{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_SCHEDULE_DISPATCH) ? FULFILLMENT_SERVICE_SCHEDULE_DISPATCH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Schedule_Dispatch');
        }set;
    }
    public static String FULFILLMENT_SERVICE_PACKOUT{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_PACKOUT) ? FULFILLMENT_SERVICE_PACKOUT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_PackOut');
        }set;
    } 
    private Static String ORDER_TYPE_TRANSFER {
        get{
            return String.isNotBlank(ORDER_TYPE_TRANSFER) ? ORDER_TYPE_TRANSFER :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Transfer');
        }set;
    } 
    public static String ACCOUNT_PLATEFORMLEVEL_ADVANCE {
        get{
            return String.isNotBlank(ACCOUNT_PLATEFORMLEVEL_ADVANCE ) ? ACCOUNT_PLATEFORMLEVEL_ADVANCE  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Plateformlevel_Advance');
        }set;
    }
    public static Set<String> Product_Families_to_Skip_QA_Review_Set{
        get{
            Product_Families_to_Skip_QA_Review_Set = new Set<String>();
            String Product_Families_to_Skip_QA_Review = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Families_to_Skip_QA_Review');
            for(String pftsqr : Product_Families_to_Skip_QA_Review.split(';')){
                Product_Families_to_Skip_QA_Review_Set.add(pftsqr);
            }
            return Product_Families_to_Skip_QA_Review_Set;
        }set;
    }
     
    
    
    public static void cancel(){
        isRecursion = true;
    }
   
    
   
    public static void updateQuanitityOnOrderLineItems(List<Sales_Order_Line__c> items,Map<Id,Sales_Order_Line__c> oldMap){
        Set<Id> SOLIds = new Set<Id>();
        Set<Id> bolineIds = new Set<Id>();
       
        Map<Id,Brand_Quote_Line__c> BQLineMap = new Map<Id,Brand_Quote_Line__c>();
        Set<String> updateBqStatusSet = new Set<String>{STATUS_SALESORDERLINECANCELLED,SALES_ORDER_LINE_STATUS_REJECTED,SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE};
            
        for(Sales_Order_Line__c sli: items){
            if(sli.Brand_Quote_Line__c != null ){
                 bolineIds.add(sli.Brand_Quote_Line__c);                   
            	if(sli.Qty_Ordered__c  != oldMap.get(sli.Id).Qty_Ordered__c || (sli.Status__c != oldMap.get(sli.Id).Status__c && sli.Status__c == SOLI_STATUS_ALLOCATED) ||(sli.Status__c != oldMap.get(sli.Id).Status__c && (oldMap.get(sli.Id).Status__c == SOLI_STATUS_ALLOCATED || oldMap.get(sli.Id).Status__c == SOLI_STATUS_PARTIAL_ALLOCATED))
                                                  ){
                                                      
                                                      SOLIds.add(sli.Id);
                                                  }
                if(sli.Status__c == SALESORDER_LINE_STATUS_SHIPMENT_COMPLETE && sli.Qty_Ordered__c!= sli.Actual_Qty_Ordered__c){BQLineMap.put(sli.Brand_Quote_Line__c,new Brand_Quote_Line__c(Id = sli.Brand_Quote_Line__c,Status__c = sli.Status__c,Quantity_Cases__c = sli.Qty_Ordered__c/sli.MOQ__c));  
                    
                }else{
                    
                    if(sli.Qty_Ordered__c  != oldMap.get(sli.Id).Qty_Ordered__c ){BQLineMap.put(sli.Brand_Quote_Line__c,new Brand_Quote_Line__c(Id = sli.Brand_Quote_Line__c,Quantity_Cases__c = sli.Qty_Ordered__c/sli.MOQ__c)); 
                    }
                    if(sli.Status__c != oldMap.get(sli.Id).Status__c && updateBqStatusSet.contains(sli.Status__c)){  BQLineMap.put(sli.Brand_Quote_Line__c,new Brand_Quote_Line__c(Id = sli.Brand_Quote_Line__c,Status__c = sli.Status__c));    
                    }
                }
             
                
            } 
        }
        if(SOLIds.size() > 0){
            items = [SElECT Status__c,Qty_Ordered__c,MOQ__c,Qty_Allocated__c, Balance_Qty_to_Allocate__c ,Brand_Quote_Line__c, Sales_Order__c  FROM Sales_Order_Line__c WHERE Id IN: oldMap.keySet() AND Sales_Order__r.SO_Status__c =: SO_STATUS_DRAFT];
            List<Brand_Quote_Line__c> BQLToUpdate = new List<Brand_Quote_Line__c>();
            for(Sales_Order_Line__c sli: items){
                if(sli.Brand_Quote_Line__c != null){
                    Brand_Quote_Line__c bql = new Brand_Quote_Line__c();
                    if(sli.Qty_Ordered__c  != oldMap.get(sli.Id).Qty_Ordered__c){
                        if(BQLineMap.containsKey(sli.Brand_Quote_Line__c)){ bql = BQLineMap.get(sli.Brand_Quote_Line__c); 
                            bql.Quantity_Cases__c=sli.Qty_Ordered__c/sli.MOQ__c;
                        } else {
                        	bql = new Brand_Quote_Line__c(Id = sli.Brand_Quote_Line__c,Quantity_Cases__c=sli.Qty_Ordered__c/sli.MOQ__c);    
                        }
                       
                    }else if(sli.Status__c != oldMap.get(sli.Id).Status__c && sli.Status__c == SOLI_STATUS_ALLOCATED){
                        if(BQLineMap.containsKey(sli.Brand_Quote_Line__c)){ bql = BQLineMap.get(sli.Brand_Quote_Line__c); 
                            bql.Quantity_Cases__c=sli.Qty_Ordered__c/sli.MOQ__c;
                        } else {
                        	bql = new Brand_Quote_Line__c(Id = sli.Brand_Quote_Line__c,Quantity_Cases__c=sli.Qty_Allocated__c/sli.MOQ__c);    
                        }
                       
                    }else if(sli.Status__c != oldMap.get(sli.Id).Status__c && (oldMap.get(sli.Id).Status__c == SOLI_STATUS_ALLOCATED || oldMap.get(sli.Id).Status__c == SOLI_STATUS_PARTIAL_ALLOCATED)){
                        if(BQLineMap.containsKey(sli.Brand_Quote_Line__c)){
                            bql = BQLineMap.get(sli.Brand_Quote_Line__c);   bql.Quantity_Cases__c=sli.Qty_Ordered__c/sli.MOQ__c;
                        } else {
                        	bql = new Brand_Quote_Line__c(Id = sli.Brand_Quote_Line__c,Quantity_Cases__c=sli.Balance_Qty_to_Allocate__c/sli.MOQ__c);    
                        }
                       
                    }
                    if(bql != null && bql.Id != null){
                    	BQLineMap.put(sli.Brand_Quote_Line__c,bql);    
                    }
                }
            }
        }
        if(BQLineMap.size() > 0){ update BQLineMap.values();
            updatePolinestatus(bolineIds);
        }
       
    }
    
    
    
    @future
    public static void updatePolinestatus(Set<Id> bqLineIds)
    {
        if(bqLineIds.size() > 0 ) {
            
            List<Purchase_Order_Line__c> polineList = new List<Purchase_Order_Line__c>();
            List<Purchase_Order_Line__c> polineToUpdate = new List<Purchase_Order_Line__c>();
            polineList= [select Id,Brand_Quote_Line__c,Brand_Quote_Line__r.Line_Total_Qty__c,Brand_Quote_Line__r.Status__c,POLI_Status__c  from Purchase_Order_Line__c where Brand_Quote_Line__c IN:bqLineIds];
            if(polineList.size()>0 ){for(Purchase_Order_Line__c po: polineList){ 
                Purchase_Order_Line__c poIds = new Purchase_Order_Line__c();
                poIds.Id = po.Id;
                if(po.Brand_Quote_Line__r.Status__c ==STATUS_SALESORDERLINECANCELLED ){  
                    
                    poIds.POLI_Status__c = po.Brand_Quote_Line__r.Status__c;  }
                else  if( po.Brand_Quote_Line__r.Status__c == SALES_ORDER_LINE_STATUS_REJECTED ){poIds.POLI_Status__c = po.Brand_Quote_Line__r.Status__c;  
                }
                polineToUpdate.add(poIds);
            } system.debug('polineToUpdate>>>'+polineToUpdate);
                                     if(polineToUpdate.size() >0){ update polineToUpdate;  
                                     }
                                     
                                    }
            
        }
    }
    
    @future
    public static void updateShippingFeeFuture(Set<Id> SOIds){
        updateShippingFee(SOIds);
    }
    
    
    public static void updateShippingFee(Set<Id> SOIds){
        if(SOIds.size() > 0){
            Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
            Set<Id>warehouseIds = new Set<Id>();
            Set<String>membershipLevels = new Set<String>();
            Set<Id> productIds = new Set<Id>();
            Map<Id,Sales_Order__c> salesOrderMap = new Map<Id,Sales_Order__c>([SELECT Id,Brand_Quote__r.Opportunity_Name__r.Order__c/*,Total_Revision__c,Listing_Fee__c*/, Total_Weight_Fee__c ,Opportunity_Name__r.Order__r.Name,Opportunity_Name__r.Order__r.State_License__r.Name,  Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Sample_Order__c,
                                                                               Total_Mileage_Fee__c  , Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__c,Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c,
                                                                               Stage_Manifest_Fee__c , Schedule_Dispatch_Fee__c ,Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c,Receiver_Name__r.DBA__c,Brand_Quote__r.Order_Type__c,Piggyback_sample__c,
                                                                               Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c,Supplier_Name__r.DBA__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c,
                                                                               Ownership__r.Membership_Level__c,Supplier_Name__r.Membership_Level__c,Order_Type__c,Receiver_Name__r.Membership_Level__c,Ownership__r.Platform_Level__c,Brand_Quote__r.recordtype.Name,
                                                                               Pack_Out_Fee__c , Order_Booking_Fee__c,Sales_Order__c.Opportunity_Name__r.Name,RecordType.Name,Shipping_Method__c,
                                                                               (SELECT Id,MOQ__c,Qty_Ordered__c,Pick_Pack_Fee__c,QA_Review_Fee__c, Listing_Fee__c,Total_Weight_lbs__c,Product_Name__c,Quantity_Cases__c,Product_Name__r.White_Labelled__c ,Product_Name__r.Producer_Name__r.Listing_Fee__c,Product_Name__r.Licensee_Name__r.Listing_Fee__c, Line_Total_Price__c,Ownership_Code__r.Membership_Level__c  FROM Sales_Order_Lines__r WHERE Status__c NOT IN (:STATUS_SALESORDERLINECANCELLED,:SALES_ORDER_LINE_STATUS_REJECTED))
                                                                               FROM Sales_Order__c 
                                                                               WHERE Id IN: SOIds
                                                                               AND Brand_Quote__r.Opportunity_Name__r.Order__c != NULL]);
            for(Sales_Order__c SO: salesOrderMap.values()){
                if(SO.Order_Type__c == SO_ORDER_TYPE_BRAND || SO.Order_Type__c == ORDER_TYPE_TRANSFER){ membershipLevels.add(SO.Ownership__r.Membership_Level__c);
                }else{
                    for(Sales_Order_Line__c SOLI: SO.Sales_Order_Lines__r){
                        membershipLevels.add(SOLI.Ownership_Code__r.Membership_Level__c);
                    }                    
                }
                warehouseIds.add(SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c);
                for(Sales_Order_Line__c oli: SO.Sales_Order_Lines__r){
                    productIds.add(oli.Product_Name__c );
                }
            }
            Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c, Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c,Membership_Level__c
                                                     FROM Fulfillment_Rates_Table__c 
                                                     WHERE Site__c IN :warehouseIds
                                                     AND Active__c = true
                                                     AND Rate_Effective_From__c <= :System.today()
                                                     AND Rate_Effective_To__c >= :System.today()
                                                     AND Membership_Level__c IN :membershipLevels
                                                     ORDER BY Weight_lbs__c DESC, MOQ__c DESC];
            Shipping_Rates_Table__c [] mileageSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                                         Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                         FROM Shipping_Rates_Table__c 
                                                         WHERE Site__c IN :warehouseIds
                                                         AND Active__c = true
                                                         AND Rate_Effective_From__c <= :System.today()
                                                         AND Rate_Effective_To__c >= :System.today()
                                                         AND Membership_Level__c IN :membershipLevels
                                                         Order By Mileage_Bracket__c];
            Shipping_Rates_Table__c [] weightSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c, Membership_Level__c,
                                                        Weight_Bracket__c, Weight_Bracket_Price__c,Site__c,Fixed_Mileage_Amount__c , Fixed_Mileage_Fee__c , Fixed_Weight_Amount__c ,Fixed_Weight_Fee__c 
                                                        FROM Shipping_Rates_Table__c 
                                                        WHERE Site__c IN :warehouseIds
                                                        AND Active__c = true
                                                        AND Rate_Effective_From__c <= :System.today()
                                                        AND Rate_Effective_To__c >= :System.today()
                                                        AND Membership_Level__c IN :membershipLevels
                                                        Order By Weight_Bracket__c];
            Map<String,Fulfillment_Rates_Table__c []> serviceBasedFRTMap = new Map<String,Fulfillment_Rates_Table__c []>();
            Map<Id,Map<String,Fulfillment_Rates_Table__c []>> warehouseserviceBasedFRTMap = new Map<Id,Map<String,Fulfillment_Rates_Table__c []>>();
            Map<String,Map<String,Fulfillment_Rates_Table__c []>> warehouseServiceBasedFRTMap2 = new Map<String,Map<String,Fulfillment_Rates_Table__c []>>();
        	Map<Id,Map<String,Map<String,Fulfillment_Rates_Table__c []>>> warehouseMLevelserviceBasedFRTMap = new Map<Id,Map<String,Map<String,Fulfillment_Rates_Table__c []>>>();
            if(FRTList.size() > 0){
                for(Fulfillment_Rates_Table__c FRT:FRTList){
                    if(warehouseMLevelserviceBasedFRTMap.containsKey(FRT.Site__c)){
                        warehouseServiceBasedFRTMap2 = warehouseMLevelserviceBasedFRTMap.get(FRT.Site__c);
                    }else{
                        warehouseServiceBasedFRTMap2 = new Map<String,Map<String,Fulfillment_Rates_Table__c []>>();
                    }
                    if(warehouseServiceBasedFRTMap2.containsKey(FRT.Membership_Level__c)){
                        serviceBasedFRTMap = warehouseServiceBasedFRTMap2.get(FRT.Membership_Level__c);
                    }else{
                        serviceBasedFRTMap = new Map<String,Fulfillment_Rates_Table__c []>();
                    }
      
                    if(serviceBasedFRTMap.containsKey(FRT.Fulfillment_Services__c)){serviceBasedFRTMap.get(FRT.Fulfillment_Services__c).add(FRT);
                    }else{
                        serviceBasedFRTMap.put(FRT.Fulfillment_Services__c,new Fulfillment_Rates_Table__c[]{FRT});
                    }
                    warehouseServiceBasedFRTMap2.put(FRT.Membership_Level__c,serviceBasedFRTMap);
                    warehouseMLevelserviceBasedFRTMap.put(FRT.Site__c,warehouseServiceBasedFRTMap2);
                }
            }
            
            
            Map<Id,Product2> productsMap = new Map<Id,Product2>([SELECT Id, Name,MOQ__c, Unit_Shipping_Weight_lbs__c, Case_Shipping_Weight_lbs__c,Family FROM Product2 WHERE Id IN: productIds]);
            List<Sales_Order__c> SOToUpdate = new List<Sales_Order__c>();
            List<Sales_Order_Line__c> OLIsToUpdate = new List<Sales_Order_Line__c>();
            for(Id SOId: salesOrderMap.keySet()){
                Sales_Order__c SO = salesOrderMap.get(SOId);
                Decimal orderBookingFee = 0;
                Decimal packOutFee = 0;
                Decimal stageManifestFee = 0;
                Decimal scheduleDispatchFee = 0; 
                Decimal totalMileageFee = 0;
                Decimal totalWeightFee = 0;
                Decimal totalOrderWeight = 0;
                Decimal totalPickPack = 0;
                Decimal totalQAReview = 0;
                Decimal totalWeightLbs = 0;
                Decimal totalListingFee = 0;
                Boolean hasMOQ1Item = false;
                Sales_Order_Line__c[] OLIs = SO.Sales_Order_Lines__r;
                //serviceBasedFRTMap = warehouseserviceBasedFRTMap.get(SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c);
                warehouseServiceBasedFRTMap2 = warehouseMLevelserviceBasedFRTMap.get(SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c);
                String membershipLevel;
                 Boolean skipFees = false;
 if(SO.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE  && 
                       (
                           (SO.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || SO.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR) 
                           || (SO.Supplier_Name__r.DBA__c == Account_Plateformlevel_ZASP || SO.Supplier_Name__r.DBA__c == Account_Plateformlevel_IRR)
                       ) 
                       && (SO.Order_Type__c == ORDER_TYPE_TRANSFER || String.isBlank(SO.Brand_Quote__r.Order_Type__c))){//&& sOrder.Brand_Quote__r.recordtype.Name == TYPE_BUYQUOTE
                        skipFees = true;
                    }  
                     if(
                        (
                            (SO.Supplier_Name__r.DBA__c != Account_Plateformlevel_ZASP && SO.Supplier_Name__r.DBA__c != Account_Plateformlevel_IRR) 
                            || (SO.Receiver_Name__r.DBA__c != Account_Plateformlevel_ZASP && SO.Receiver_Name__r.DBA__c != Account_Plateformlevel_IRR)
                        ) && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__c != null && (SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_ZASP && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_IRR) && SO.Order_Type__c == ORDER_TYPE_TRANSFER ){
                        skipFees = true;
                    }
                for(Sales_Order_Line__c oli:OLIs){
                    Decimal pickPackFee = 0;
                    Decimal QAReviewFee = 0;
                    Decimal totalWeight = 0;
                    Product2 p = productsMap.get(oli.Product_Name__c);
                    decimal weight = 0;
                    decimal unitweight = 0;
                    decimal pickPackPrice = 0;
                    decimal QAReviewPrice = 0;
                    Decimal listingFee = 0;
                    Decimal listingFeePercent = 0;
                    if(SO.Order_Type__c == SO_ORDER_TYPE_BRAND || SO.Order_Type__c == ORDER_TYPE_TRANSFER){ membershipLevel = SO.Ownership__r.Membership_Level__c;
                    }else{
                        membershipLevel = oli.Ownership_Code__r.Membership_Level__c;
                    }
                    if(warehouseServiceBasedFRTMap2 != null)
                        serviceBasedFRTMap = warehouseServiceBasedFRTMap2.get(membershipLevel);
     
                    if(oli.Product_Name__r.White_Labelled__c == false && oli.Product_Name__r.Producer_Name__r.Listing_Fee__c != NULL){
                        listingFeePercent = oli.Product_Name__r.Producer_Name__r.Listing_Fee__c;}else if(oli.Product_Name__r.White_Labelled__c == true && oli.Product_Name__r.Licensee_Name__r.Listing_Fee__c != NULL){ listingFeePercent = oli.Product_Name__r.Licensee_Name__r.Listing_Fee__c;
                    }else{
                        listingFeePercent = ccs.Listing_Fee__c != NULL ?ccs.Listing_Fee__c :0;
                    }
                    if(listingFeePercent > 0){
                        listingFee = (listingFeePercent/100) * oli.Line_Total_Price__c;
                    }
                    
                    if(oli.MOQ__c > 1){
                        weight = p.Case_Shipping_Weight_lbs__c;
                    }else{
                        weight = p.Unit_Shipping_Weight_lbs__c;
                        hasMOQ1Item = true;
                    }
                    unitweight = p.Unit_Shipping_Weight_lbs__c;
                    //Calulate Pick Pack Fee
                    if(weight > 0 && serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_PICK_PACK)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_PICK_PACK);
                        if(!FRTs.isEmpty()){
                            for(Fulfillment_Rates_Table__c FRT: FRTs){
                                if(FRT.Weight_lbs__c <= weight){
                                    pickPackPrice = FRT.Bracket_Price__c;
                                    break;
                                }
                            }
                        }
                    }
                    if(oli.MOQ__c > 1){
                        pickPackFee = pickPackPrice * oli.Quantity_Cases__c;
                    }else{
                        pickPackFee = pickPackPrice * oli.Qty_Ordered__c;// * oli.MOQ__c;
                    }
                    //Calulate QA Review Fee
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_QA_REVIEW) && !Product_Families_to_Skip_QA_Review_Set.contains(p.Family)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_QA_REVIEW);
                        if(!FRTs.isEmpty()){
                            for(Fulfillment_Rates_Table__c FRT: FRTs){if(FRT.Weight_lbs__c  <= weight && FRT.MOQ__c <= oli.MOQ__c){
                                    QAReviewPrice = FRT.Bracket_Price__c;  break;
                                }
                            }
                        }
         
                        QAReviewFee = QAReviewPrice * oli.Qty_Ordered__c;// * oli.MOQ__c;
                      
                    }
                   if((SO.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_BASIC || SO.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE) 
                       && ((SO.Order_Type__c == ORDER_TYPE_TRANSFER && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Sample_Order__c == false ) || String.isBlank(SO.Brand_Quote__r.Order_Type__c)) &&
                       ((SO.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || SO.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR) 
                        || (SO.Supplier_Name__r.DBA__c == Account_Plateformlevel_ZASP || SO.Supplier_Name__r.DBA__c == Account_Plateformlevel_IRR))){
                        
                        QAReviewFee  = 0;
                    }
                    if(SO.Piggyback_sample__c != true && (SO.Order_Type__c == ORDER_TYPE_TRANSFER && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Sample_Order__c == true )){
                        QAReviewFee  = 0;
                    }
                    //Calulate Total Weight
                    if(oli.MOQ__c > 1){
                        totalWeight = weight * oli.Quantity_Cases__c;
                    }else{
                        totalWeight = weight * oli.Qty_Ordered__c;// * oli.MOQ__c;
                    }
                    oli.Pick_Pack_Fee__c = pickPackFee;
                    oli.QA_Review_Fee__c = QAReviewFee;
                    oli.Total_Weight_lbs__c = totalWeight;
                    if(SO.Order_Type__c == ORDER_TYPE_RETAIL){   oli.Listing_Fee__c = listingFee;
                    }
                    OLIsToUpdate.add(oli);
                    totalPickPack += pickPackFee;
                    totalQAReview += QAReviewFee;
                    totalOrderWeight += totalWeight;
                    //totalListingFee += listingFee;
                }
                if(SO.Order_Type__c != ORDER_TYPE_RETAIL){
                    //calculate OrderBooking Fee
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_ORDER_BOOKING)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_ORDER_BOOKING);
                        if(!FRTs.isEmpty()){
                            orderBookingFee = FRTs[0].Bracket_Price__c;
                        }
                    }
                    //calculate Stage & Manifest
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_STAGE_MANIFEST)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_STAGE_MANIFEST);
                        if(!FRTs.isEmpty()){
                            stageManifestFee = FRTs[0].Bracket_Price__c; 
                        }
                    }
                    //calculate Schedule & Dispatch
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_SCHEDULE_DISPATCH)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_SCHEDULE_DISPATCH);
                        if(!FRTs.isEmpty()){
                            scheduleDispatchFee = FRTs[0].Bracket_Price__c;
                        }
                    }
                }
                //calculate PackOut Fee
                if( hasMOQ1Item && serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_PACKOUT)){
                    Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_PACKOUT); if(!FRTs.isEmpty()){  packOutFee = FRTs[0].Bracket_Price__c;
                    }
                }
                
                Boolean createWMLines = true;
                if(SO.RecordType.Name == SALESORDER_RECORDTYPE_Transfer && SO.Shipping_Method__c != NULL && SO.Shipping_Method__c.contains(SO_SHIPPING_METHOD_PICK_UP)){createWMLines = false;
                }
                
                //calculate Total Mileage Fee
                if(createWMLines && !mileageSRTList.isEmpty() && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c != null){
                    for(Shipping_Rates_Table__c SRT: mileageSRTList){
                        if(SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c <= SRT.Mileage_Bracket__c && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c == SRT.Site__c && membershipLevel == SRT.Membership_Level__c){
                            if(SRT.Fixed_Mileage_Fee__c){ totalMileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                            }else{
                                totalMileageFee = SRT.Mileage_Bracket_Price__c * SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c; 
                            }
                            break;
                        }
                    }   
                    /*if(SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER && SO.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE){ totalMileageFee = 0;
                    }*/
                }
                
                //calculate Total Weight Fee
                if(createWMLines && !weightSRTList.isEmpty()){
                    for(Shipping_Rates_Table__c SRT: weightSRTList){
                        if(totalOrderWeight <= SRT.Weight_Bracket__c && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c == SRT.Site__c && membershipLevel == SRT.Membership_Level__c){
                            if(SRT.Fixed_Weight_Fee__c){  totalWeightFee = SRT.Fixed_Weight_Amount__c != null ? SRT.Fixed_Weight_Amount__c : 0;
                            }else{
                                totalWeightFee = SRT.Weight_Bracket_Price__c * totalOrderWeight; 
                            }
                            break;
                        }
                    }   
                }
                if(skipFees  && (SO.Order_Type__c == ORDER_TYPE_TRANSFER || String.isBlank(SO.Brand_Quote__r.Order_Type__c))){//&& R))
                    
                    totalMileageFee = 0;
                    totalWeightFee = 0;
                }
                if(SO.Piggyback_sample__c == true && SO.Order_Type__c == ORDER_TYPE_TRANSFER){
                       totalMileageFee = 0;
                    }
                SO.Order_Booking_Fee__c = orderBookingFee;
                SO.Pack_Out_Fee__c = packOutFee;
                SO.Stage_Manifest_Fee__c = stageManifestFee;
                SO.Schedule_Dispatch_Fee__c = scheduleDispatchFee;
                SO.Total_Mileage_Fee__c = totalMileageFee; //(SO.Total_Revision__c != NULL ? (SO.Total_Revision__c +1)* totalMileageFee:totalMileageFee);
                SO.Total_Weight_Fee__c = totalWeightFee; //(SO.Total_Revision__c != NULL ? (SO.Total_Revision__c +1)* totalWeightFee:totalWeightFee);
                //SO.Listing_Fee__c = totalListingFee;
                SOToUpdate.add(SO);
            }
            if(SOToUpdate.size() > 0) update SOToUpdate;
            if(OLIsToUpdate.size() > 0) update OLIsToUpdate;
            
        }
    }
    
    public static void reCalculateFees(List<Sales_Order_Line__c> items,Map<Id,Sales_Order_Line__c> oldMap){
        if(TestUtilData.skipTrigger) return;
        Set<Id> SOIds = new Set<Id>();
        for(Sales_Order_Line__c oli:items){
            if((Trigger.isInsert && oli.Pick_Pack_Fee__c == NULL && oli.QA_Review_Fee__c == NULL &&  oli.Total_Weight_lbs__c == NULL) || (Trigger.isUpdate && (oli.Qty_Ordered__c != oldMap.get(oli.Id).Qty_Ordered__c || oli.Status__c != oldMap.get(oli.Id).Status__c))){
                SOIds.add(oli.Sales_Order__c);
            }
        }
        if(SOIds.size() > 0 ){
            if(System.isFuture() == true || System.isBatch()){ updateShippingFee(SOIds);
            }else{
                updateShippingFeeFuture(SOIds);
            }
        }
    }
}