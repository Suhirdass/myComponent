public class OrderLineItemHelper {
    private static String ACCOUNT_PLATEFORMLEVEL_BASIC {
        get{
            return String.isNotBlank(ACCOUNT_PLATEFORMLEVEL_BASIC ) ? ACCOUNT_PLATEFORMLEVEL_BASIC  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Plateformlevel_Basic');
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
    private static String ORDER_TYPE_RETAIL{
        get{
            return String.isNotBlank(ORDER_TYPE_RETAIL) ? ORDER_TYPE_RETAIL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Retail');
        }set;
    }
    private static String ORDER_TYPE_BRAND{
        get{
            return String.isNotBlank(ORDER_TYPE_BRAND) ? ORDER_TYPE_BRAND : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Brand');
        }set;
    }
    private Static String ORDER_TYPE_TRANSFER {
        get{
            return String.isNotBlank(ORDER_TYPE_TRANSFER) ? ORDER_TYPE_TRANSFER :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Transfer');
        }set;
    } 
    private static String ACCOUNT_PLATEFORMLEVEL_ADVANCE {
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
    public static void updateShippingFee(Set<Id> orderIds){
        Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
        Set<Id> productIds = new Set<Id>();
        Set<Id>warehouseIds = new Set<Id>();
            Set<String>membershipLevels = new Set<String>();
            Map<Id,Order__c> orderMap = new Map<Id,Order__c>([SELECT Id, Total_Weight_Fee__c /*,Listing_Fee__c*/ , Order_Type__c,Retailer_DBA__c,Account_DBA__c,Sample_Order__c,
                                     Total_Milage_Fee__c  , State_License__c,State_License__r.Default_Warehouse__c,State_License__r.Total_Miles__c,Transporter__c,
                                     Stage_Manifest_Fee__c , Schedule_Dispatch_Fee__c , Account__r.Platform_Level__c,Account__r.DBA__c,Piggyback_sample__c,
                                     Pack_Out_Fee__c , Order_Booking_Fee__c,Account__r.Membership_Level__c,Retailer__r.DBA__c,Transporter__r.License_Name__r.DBA__c,
                                     (SELECT Id,MOQ__c,Quantity_Cases__c,Pick_Pack_Fee__c,QA_Review_Fee__c, Total_Weight_lbs__c,Product__c,Product__r.White_Labelled__c ,Product__r.Producer_Name__r.Listing_Fee__c,Product__r.Licensee_Name__r.Listing_Fee__c,Line_Total_Cost__c, Total__c,Ownership_Code__r.Membership_Level__c  FROM Order_Line_Items__r) FROM Order__c WHERE Id IN: orderIds]);
            for(Order__c odr: orderMap.values()){
                
                warehouseIds.add(odr.State_License__r.Default_Warehouse__c);
                if(odr.Order_Type__c == ORDER_TYPE_BRAND || odr.Order_Type__c == ORDER_TYPE_TRANSFER){
                    if(odr.Account__r.Membership_Level__c != null){
                        membershipLevels.add(odr.Account__r.Membership_Level__c);
                    }
                }else{
                    for(Order_Line_Item__c oli:odr.Order_Line_Items__r){
                        membershipLevels.add(oli.Ownership_Code__r.Membership_Level__c);
                    }
                }
                
                for(Order_Line_Item__c oli: odr.Order_Line_Items__r){
                    productIds.add(oli.Product__c);
                }
                
            }
            Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c,Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c ,Membership_Level__c
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
        Shipping_Rates_Table__c [] weightSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c,Membership_Level__c, 
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
        if(!FRTList.isEmpty()){
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
                /*if(warehouseserviceBasedFRTMap.containsKey(FRT.Site__c)){
                    serviceBasedFRTMap = warehouseserviceBasedFRTMap.get(FRT.Site__c);
                }else{
                    serviceBasedFRTMap = new Map<String,Fulfillment_Rates_Table__c []>();
                }*/
                if(serviceBasedFRTMap.containsKey(FRT.Fulfillment_Services__c)){
                    serviceBasedFRTMap.get(FRT.Fulfillment_Services__c).add(FRT);
                }else{
                    serviceBasedFRTMap.put(FRT.Fulfillment_Services__c,new Fulfillment_Rates_Table__c[]{FRT});
                }
                warehouseServiceBasedFRTMap2.put(FRT.Membership_Level__c,serviceBasedFRTMap);
                warehouseMLevelserviceBasedFRTMap.put(FRT.Site__c,warehouseServiceBasedFRTMap2);
                //warehouseserviceBasedFRTMap.put(FRT.Site__c,serviceBasedFRTMap);
            }
        }
            
            
            Map<Id,Product2> productsMap = new Map<Id,Product2>([SELECT Id, Name,MOQ__c, Unit_Shipping_Weight_lbs__c, Case_Shipping_Weight_lbs__c,Family FROM Product2 WHERE Id IN: productIds]);
            List<Order__c> ordersToUpdate = new List<Order__c>();
            List<Order_Line_Item__c> OLIsToUpdate = new List<Order_Line_Item__c>();
            for(Id orderId: orderIds){
                Order__c odr = orderMap.get(orderId);
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
                String membershipLevel = '';
                Order_Line_Item__c[] OLIs = odr.Order_Line_Items__r;
                System.debug('##ML:'+odr.Account__r.Membership_Level__c);
                //serviceBasedFRTMap = warehouseserviceBasedFRTMap.get(odr.State_License__r.Default_Warehouse__c);
                warehouseServiceBasedFRTMap2 = warehouseMLevelserviceBasedFRTMap.get(odr.State_License__r.Default_Warehouse__c);
                
                System.debug('###serviceBasedFRTMap::'+serviceBasedFRTMap);
                
                boolean skipFees = false;
                if(odr.Account__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE  && 
                       (
                           (odr.Account__r.DBA__c == Account_Plateformlevel_ZASP || odr.Account__r.DBA__c == Account_Plateformlevel_IRR) 
                           || (odr.Retailer_DBA__c == Account_Plateformlevel_ZASP || odr.Retailer_DBA__c == Account_Plateformlevel_IRR)
                       ) 
                       && odr.Order_Type__c == ORDER_TYPE_TRANSFER ){
                        skipFees = true;
                    }  
                    if(
                        (
                            (odr.Account__r.DBA__c != Account_Plateformlevel_ZASP && odr.Account__r.DBA__c != Account_Plateformlevel_IRR) 
                            || (odr.Retailer_DBA__c != Account_Plateformlevel_ZASP && odr.Retailer_DBA__c != Account_Plateformlevel_IRR)
                        ) && odr.Transporter__c != null && (odr.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_ZASP && odr.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_IRR)){
                        skipFees = true;
                    }
                
                for(Order_Line_Item__c oli:OLIs){
                    Decimal pickPackFee = 0;
                    Decimal QAReviewFee = 0;
                    Decimal totalWeight = 0;
                    Product2 p = productsMap.get(oli.Product__c);
                    decimal weight = 0;
                    decimal unitweight = 0;
                    decimal pickPackPrice = 0;
                    decimal QAReviewPrice = 0;
                    Decimal listingFee = 0;
                    Decimal listingFeePercent = 0;
                    
                    if(odr.Order_Type__c == ORDER_TYPE_BRAND || odr.Order_Type__c == ORDER_TYPE_TRANSFER){
                        membershipLevel = odr.Account__r.Membership_Level__c;
                    }else{
                        membershipLevel = oli.Ownership_Code__r.Membership_Level__c;
                    }
                    if(warehouseServiceBasedFRTMap2 != null)
                	serviceBasedFRTMap = warehouseServiceBasedFRTMap2.get(membershipLevel);
                    
                    if(oli.Product__r.White_Labelled__c == false && oli.Product__r.Producer_Name__r.Listing_Fee__c != NULL){
                        listingFeePercent = oli.Product__r.Producer_Name__r.Listing_Fee__c;
                    }else if(oli.Product__r.White_Labelled__c == true && oli.Product__r.Licensee_Name__r.Listing_Fee__c != NULL){
                        listingFeePercent = oli.Product__r.Licensee_Name__r.Listing_Fee__c;
                    }else{
                        listingFeePercent = ccs.Listing_Fee__c != NULL ?ccs.Listing_Fee__c :0;
                    }
                    if(listingFeePercent > 0){
                        listingFee = (listingFeePercent/100) * oli.Line_Total_Cost__c;
                    }
                    if(oli.MOQ__c > 1){
                        weight = p.Case_Shipping_Weight_lbs__c;
                    }else{
                        weight = p.Unit_Shipping_Weight_lbs__c;
                        hasMOQ1Item = true;
                    }
                    unitweight = p.Unit_Shipping_Weight_lbs__c;
                    //Calulate Pick Pack Fee
                    if(weight > 0 && serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey('Pick & Pack')){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get('Pick & Pack');
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
                        pickPackFee = pickPackPrice * oli.Quantity_Cases__c * oli.MOQ__c;
                    }
                    //Calulate QA Review Fee
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey('QA Review') && !Product_Families_to_Skip_QA_Review_Set.contains(p.Family)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get('QA Review');
                        if(!FRTs.isEmpty()){
                            for(Fulfillment_Rates_Table__c FRT: FRTs){
                                if(FRT.Weight_lbs__c  <= weight && FRT.MOQ__c <= oli.MOQ__c){
                                    QAReviewPrice = FRT.Bracket_Price__c;
                                    break;
                                }
                            }
                        }
                        QAReviewFee = QAReviewPrice * oli.Quantity_Cases__c * oli.MOQ__c;
                        /*
                        if(!FRTs.isEmpty()){
                            QAReviewFee = FRTs[0].Bracket_Price__c * oli.Quantity_Cases__c * oli.MOQ__c;
                        }*/
                    }
                    if(odr.Order_Type__c == ORDER_TYPE_TRANSFER  && odr.Sample_Order__c == false && (odr.Account__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_BASIC || odr.Account__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE ) 
                       && ((odr.Account__r.DBA__c == Account_Plateformlevel_ZASP || odr.Account__r.DBA__c == Account_Plateformlevel_IRR) 
                        || (odr.Retailer_DBA__c == Account_Plateformlevel_ZASP || odr.Retailer_DBA__c == Account_Plateformlevel_IRR))){
                        
                        
                        QAReviewFee  = 0;
                    }
                    if(odr.Piggyback_sample__c != true && odr.Order_Type__c == ORDER_TYPE_TRANSFER && odr.Sample_Order__c == true){
                        QAReviewFee  = 0;
                    }
                    //Calulate Total Weight
                    if(oli.MOQ__c > 1){
                        totalWeight = weight * oli.Quantity_Cases__c;
                    }else{
                        totalWeight = weight * oli.Quantity_Cases__c * oli.MOQ__c;
                    }
                    oli.Pick_Pack_Fee__c = pickPackFee;
                    oli.QA_Review_Fee__c = QAReviewFee;
                    oli.Total_Weight_lbs__c = totalWeight;
                    if(odr.Order_Type__c == ORDER_TYPE_RETAIL){
                        oli.Listing_Fee__c = listingFee;
                    }
                    OLIsToUpdate.add(oli);
                    //totalListingFee += listingFee;
                    totalPickPack += pickPackFee;
                    totalQAReview += QAReviewFee;
                    totalOrderWeight += totalWeight;
                }
                if(odr.Order_Type__c != ORDER_TYPE_RETAIL){
                    //calculate OrderBooking Fee
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey('Order Booking')){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get('Order Booking');
                        if(!FRTs.isEmpty()){
                            orderBookingFee = FRTs[0].Bracket_Price__c;
                        }
                    }
                    //calculate Stage & Manifest
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey('Stage & Manifest')){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get('Stage & Manifest');
                        if(!FRTs.isEmpty()){
                            stageManifestFee = FRTs[0].Bracket_Price__c; 
                        }
                    }
                    //calculate Schedule & Dispatch
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey('Schedule & Dispatch')){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get('Schedule & Dispatch');
                        if(!FRTs.isEmpty()){
                            scheduleDispatchFee = FRTs[0].Bracket_Price__c;
                        }
                    }
                }
                
                //calculate PackOut Fee
                if( hasMOQ1Item && serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey('Pack-Out')){
                    Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get('Pack-Out');
                    if(!FRTs.isEmpty()){
                        packOutFee = FRTs[0].Bracket_Price__c;
                    }
                }
                
                //calculate Total Mileage Fee
                if(!mileageSRTList.isEmpty() && odr.State_License__r.Total_Miles__c != null){
                    for(Shipping_Rates_Table__c SRT: mileageSRTList){
                        if(odr.State_License__r.Total_Miles__c <= SRT.Mileage_Bracket__c && odr.State_License__r.Default_Warehouse__c == SRT.Site__c && membershipLevel == SRT.Membership_Level__c){
                            if(SRT.Fixed_Mileage_Fee__c){
                                totalMileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                            }else{
                                totalMileageFee = SRT.Mileage_Bracket_Price__c * odr.State_License__r.Total_Miles__c; 
                            }
                            break;
                        }
                    }    
                    /*if(odr.Order_Type__c == ORDER_TYPE_TRANSFER && odr.Account__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE){
                        totalMileageFee = 0;
                    }*/
                }
                
                
                
                //calculate Total Weight Fee
                if(!weightSRTList.isEmpty()){
                    for(Shipping_Rates_Table__c SRT: weightSRTList){
                        if(totalOrderWeight <= SRT.Weight_Bracket__c && odr.State_License__r.Default_Warehouse__c == SRT.Site__c && membershipLevel == SRT.Membership_Level__c){
                            if(SRT.Fixed_Weight_Fee__c){
                                totalWeightFee = SRT.Fixed_Weight_Amount__c != null ? SRT.Fixed_Weight_Amount__c : 0;
                            }else{
                                totalWeightFee = SRT.Weight_Bracket_Price__c * totalOrderWeight; 
                            }
                            break;
                        }
                    }   
                }
                if(skipFees && odr.Order_Type__c == ORDER_TYPE_TRANSFER ){
                    
                    totalMileageFee = 0;
                    totalWeightFee = 0;
                }
                if( odr.Piggyback_sample__c == true && odr.Order_Type__c == ORDER_TYPE_TRANSFER ){
                    totalMileageFee = 0;
                }
                
                odr.Order_Booking_Fee__c = orderBookingFee;
                odr.Pack_Out_Fee__c = packOutFee;
                odr.Stage_Manifest_Fee__c = stageManifestFee;
                odr.Schedule_Dispatch_Fee__c = scheduleDispatchFee;
                odr.Total_Milage_Fee__c = totalMileageFee;
                odr.Total_Weight_Fee__c = totalWeightFee;
                //odr.Listing_Fee__c = totalListingFee;
                ordersToUpdate.add(odr);
            }
            update ordersToUpdate;
            update OLIsToUpdate;
    }
    public static void reCalculateFees(List<Order_Line_Item__c> newList, Map<Id,Order_Line_Item__c> oldMap){
        if(TestUtilData.skipTrigger) return;
        Map<Id,Order_Line_Item__c[]> orderOLIsMap = new Map<Id,Order_Line_Item__c[]>();
        Set<Id> productIds = new Set<Id>();
        for(Order_Line_Item__c oli: newList){
            if((Trigger.isInsert && oli.Pick_Pack_Fee__c == NULL && oli.QA_Review_Fee__c == NULL &&  oli.Total_Weight_lbs__c == NULL) || (Trigger.isUpdate && (oli.Quantity_Cases__c != oldMap.get(oli.Id).Quantity_Cases__c || oli.MOQ__c != oldMap.get(oli.Id).MOQ__c))){
                if(orderOLIsMap.containsKey(oli.Order__c)){
                    orderOLIsMap.get(oli.Order__c).add(oli);
                }else{
                    orderOLIsMap.put(oli.Order__c , new Order_Line_Item__c[]{oli});
                }
                
            }
        }
        if(!orderOLIsMap.isEmpty()){
            updateShippingFee(orderOLIsMap.keySet());  
        }
    }
}