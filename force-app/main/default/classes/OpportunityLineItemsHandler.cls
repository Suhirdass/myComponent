/**
* Copyright (c) 2021 WOVN
* All rights reserved.
* OpportunityLineItemsHandler
*/
public class OpportunityLineItemsHandler {
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
    
     private Static String ORDER_CANCELLED_BY_WOVN{
        get{
            return String.isNotBlank(ORDER_CANCELLED_BY_WOVN) ? ORDER_CANCELLED_BY_WOVN: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Filigreen');
        }set;
    }
     public static String ORDERCANCELLED_CUSTOMER{
        get{
            return String.isNotBlank(ORDERCANCELLED_CUSTOMER) ? ORDERCANCELLED_CUSTOMER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Customer');
        }set;
    }
     public Static String SHIPPING_MANIFEST_STATUS_REJECTED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_REJECTED) ? SHIPPING_MANIFEST_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Rejected');
        }set;
    }
    public Static String ORDER_LINE_STATUS_CANCELLED{
        get{
            return String.isNotBlank(ORDER_LINE_STATUS_CANCELLED) ? ORDER_LINE_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order Line Item','Order_Line_Status_Cancelled');
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
    public static void mapOwnershipCode(List<OpportunityLineItem> items){
        Set<Id> pIds = new Set<Id>();
        for(OpportunityLineItem oli : items){
            pIds.add(oli.product2Id);
        }
        Map<Id,Product2> products = new Map<Id,Product2>([SELECT Producer_Name__c,Licensee_Name__c,White_Labelled__c FROM Product2 WHERE Id IN :pIds]);
        if(!products.isEmpty()){
            for(OpportunityLineItem oli : items){
                if(products.get(oli.Product2Id) != null){
                    if(products.get(oli.Product2Id).White_Labelled__c)
                        oli.Ownership_Code__c = products.get(oli.Product2Id).Licensee_Name__c;
                    else
                        oli.Ownership_Code__c = products.get(oli.Product2Id).Producer_Name__c;    
                }
            }    
        }
    }
    public static void updateQuanitityOnOrderLineItems(List<OpportunityLineItem> items,Map<Id,OpportunityLineItem> oldMap){
        items = [SELECT id,Quantity,Opportunity.Order__c,Product2Id,Opportunity_Line_Status__c,Order_Line_Item__c FROM OpportunityLineItem WHERE ID IN :oldMap.keySet()];
        Map<Id,Set<OpportunityLineItem>> orderProductsMap = new Map<Id,Set<OpportunityLineItem>>();
        Set<Id> productIds = new Set<Id>();
          Set<String> oppLineLStatusesToUpdate = new Set<String>{'Cancelled','Rejected','Shipment Complete'};
        for(OpportunityLineItem oli:items){
            if(oli.Opportunity.Order__c != null && oli.Quantity != oldMap.get(oli.Id).Quantity || (oli.Opportunity_Line_Status__c != oldMap.get(oli.Id).Opportunity_Line_Status__c && oppLineLStatusesToUpdate.contains(oli.Opportunity_Line_Status__c))){
                if(orderProductsMap.containsKey(oli.Opportunity.Order__c)){
                    orderProductsMap.get(oli.Opportunity.Order__c).add(oli);
                }else{
                    orderProductsMap.put(oli.Opportunity.Order__c, new Set<OpportunityLineItem>{oli});
                }
                productIds.add(oli.Product2Id);
            }
        }
        if(!orderProductsMap.isEmpty() && !productIds.isEmpty()){
            List<Order_Line_Item__c> olisToUpdate = new List<Order_Line_Item__c>();
            Map<String,Order_Line_Item__c> OLIMap = new Map<String,Order_Line_Item__c>();
            Map<String,Order_Line_Item__c> OLIProductMap = new Map<String,Order_Line_Item__c>();
            Order_Line_Item__c[] orderLineItems = [SELECT Id,Order__c,Product__c, Quantity_Cases__c FROM Order_Line_Item__c WHERE Order__c IN: orderProductsMap.keySet() AND Product__c IN :productIds];
            OLIMap = new Map<String,Order_Line_Item__c>(orderLineItems);
            for(Order_Line_Item__c oli: orderLineItems){
                OLIProductMap.put(oli.Order__c+'-'+oli.Product__c,oli);
            }
            for(Id orderId: orderProductsMap.keySet()){
                Set<OpportunityLineItem> orderProducts = orderProductsMap.get(orderId);
                if(!orderProducts.isEmpty()){
                    for(OpportunityLineItem oli : orderProducts){
                        String key = orderId+'-'+oli.Product2Id; 
                        if(oli.Order_Line_Item__c != NULL || OLIProductMap.containsKey(key)){
                            Order_Line_Item__c odrLine = oli.Order_Line_Item__c != NULL ? OLIMap.get(oli.Order_Line_Item__c) : OLIProductMap.get(key);
                            if(odrLine != null){
                                 if(oli.Opportunity_Line_Status__c != oldMap.get(oli.Id).Opportunity_Line_Status__c && oppLineLStatusesToUpdate.contains(oli.Opportunity_Line_Status__c)){
                                    //odrLine.OrderLine_Status__c = oli.Opportunity_Line_Status__c;
                                     if(RSMTSMShipConfirmCotroller.IS_FULL_REJECT || oli.Opportunity_Line_Status__c==SHIPPING_MANIFEST_STATUS_REJECTED )
                                     {
                                         odrLine.OrderLine_Status__c = ORDERCANCELLED_CUSTOMER; 
                                     }else if(oli.Opportunity_Line_Status__c== ORDER_LINE_STATUS_CANCELLED)
                                     {
                                         odrLine.OrderLine_Status__c = ORDER_CANCELLED_BY_WOVN;
                                     }else{
                                         odrLine.OrderLine_Status__c = oli.Opportunity_Line_Status__c;
                                     }
                                }
                                if(oli.Quantity != oldMap.get(oli.Id).Quantity){
                                    odrLine.Quantity_Cases__c = oli.Quantity;
                                }
                                if(oli.Quantity != oldMap.get(oli.Id).Quantity || (oli.Opportunity_Line_Status__c != oldMap.get(oli.Id).Opportunity_Line_Status__c && oppLineLStatusesToUpdate.contains(oli.Opportunity_Line_Status__c))){
                                    olisToUpdate.add(odrLine);
                                } 
                               /* odrLine.Quantity_Cases__c = oli.Quantity;
                                olisToUpdate.add(odrLine);*/
                            }
                        }
                    }
                }
            }
            if(!olisToUpdate.isEmpty()){
                update olisToUpdate;
            }
        }
    }
    @future
    public static void updateShippingFee(Set<Id> opportunityIds){
        if(!opportunityIds.isEmpty()){
            Set<Id>warehouseIds = new Set<Id>();
            Set<String>membershipLevels = new Set<String>();
            Set<Id> productIds = new Set<Id>();
            Map<Id,Opportunity> opportunityMap = new Map<Id,Opportunity>([SELECT Id, Order__c,Total_Weight_Fee__c ,Order__r.Account__r.Membership_Level__c, Order__r.Retailer_DBA__c,Order__r.Sample_Order__c,Order__r.Piggyback_sample__c,
                                     Total_Mileage_Fee__c  , Order__r.State_License__c,Order__r.State_License__r.Default_Warehouse__c,Order__r.State_License__r.Total_Miles__c,Order__r.Transporter__c,
                                     Stage_Manifest_Fee__c , Order__r.Total_Milage_Fee__c, Schedule_Dispatch_Fee__c , Order_Type__c,Order__r.Order_Type__c,Order__r.Account__r.Platform_Level__c,
                                     Pack_Out_Fee__c , Order_Booking_Fee__c,Order__r.Retailer__r.DBA__c,Order__r.Transporter__r.License_Name__r.DBA__c,Order__r.Account__r.DBA__c,
                                     (SELECT Id,MOQ__c,Quantity,Pick_Pack_Fee__c,QA_Review_Fee__c, Total_Weight_lbs__c,Product2Id,Ownership_Code__r.Membership_Level__c FROM OpportunityLineItems) 
                                                                          FROM Opportunity 
                                                                          WHERE Id IN: opportunityIds
                                                                         AND Order__c != null]);
            for(Opportunity opp: opportunityMap.values()){
                warehouseIds.add(opp.Order__r.State_License__r.Default_Warehouse__c);
                if(opp.Order_Type__c == ORDER_TYPE_BRAND || opp.Order_Type__c == ORDER_TYPE_TRANSFER){
                    if(opp.Order__r.Account__r.Membership_Level__c != NULL){
                        membershipLevels.add(opp.Order__r.Account__r.Membership_Level__c);
                    }
                }else{
                    for(OpportunityLineItem oli: opp.OpportunityLineItems){
                        membershipLevels.add(oli.Ownership_Code__r.Membership_Level__c);
                    }
                }
                for(OpportunityLineItem oli: opp.OpportunityLineItems){
                    productIds.add(oli.Product2Id);
                }
                
            }
            Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c,Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c, Membership_Level__c 
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
            }
        }
            
            
            Map<Id,Product2> productsMap = new Map<Id,Product2>([SELECT Id, Name,MOQ__c, Unit_Shipping_Weight_lbs__c, Case_Shipping_Weight_lbs__c,Family FROM Product2 WHERE Id IN: productIds]);
            List<Opportunity> oppToUpdate = new List<Opportunity>();
            List<OpportunityLineItem> OLIsToUpdate = new List<OpportunityLineItem>();
            for(Id oppId: opportunityMap.keySet()){
                Opportunity opp = opportunityMap.get(oppId);
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
                Boolean hasMOQ1Item = false;
                String membershipLevel = '';
                OpportunityLineItem[] OLIs = opp.OpportunityLineItems;
                //serviceBasedFRTMap = warehouseserviceBasedFRTMap.get(opp.Order__r.State_License__r.Default_Warehouse__c);
                warehouseServiceBasedFRTMap2 = warehouseMLevelserviceBasedFRTMap.get(opp.Order__r.State_License__r.Default_Warehouse__c);
                
                boolean skipFees = false;
                if(opp.Order__r.Account__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE  && 
                       (
                           (opp.Order__r.Account__r.DBA__c == Account_Plateformlevel_ZASP || opp.Order__r.Account__r.DBA__c == Account_Plateformlevel_IRR) 
                           || (opp.Order__r.Retailer_DBA__c == Account_Plateformlevel_ZASP || opp.Order__r.Retailer_DBA__c == Account_Plateformlevel_IRR)
                       ) 
                       && opp.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER ){
                        skipFees = true;
                    }  
                    if(
                        (
                            (opp.Order__r.Account__r.DBA__c != Account_Plateformlevel_ZASP && opp.Order__r.Account__r.DBA__c != Account_Plateformlevel_IRR) 
                            || (opp.Order__r.Retailer_DBA__c != Account_Plateformlevel_ZASP && opp.Order__r.Retailer_DBA__c != Account_Plateformlevel_IRR)
                        ) && opp.Order__r.Transporter__c != null && (opp.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_ZASP && opp.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_IRR)){
                        skipFees = true;
                    }
                
                for(OpportunityLineItem oli:OLIs){
                    Decimal pickPackFee = 0;
                    Decimal QAReviewFee = 0;
                    Decimal totalWeight = 0;
                    Product2 p = productsMap.get(oli.Product2Id);
                    decimal weight = 0;
                    decimal unitweight = 0;
                    decimal pickPackPrice = 0;
                    decimal QAReviewPrice = 0;
                    
                    if(opp.Order_Type__c == ORDER_TYPE_BRAND || opp.Order_Type__c == ORDER_TYPE_TRANSFER){
                        membershipLevel = opp.Order__r.Account__r.Membership_Level__c;
                    }else{
                        membershipLevel = oli.Ownership_Code__r.Membership_Level__c;
                    }
                    
                    if(warehouseServiceBasedFRTMap2 != null)
                	serviceBasedFRTMap = warehouseServiceBasedFRTMap2.get(membershipLevel);
                    
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
                        pickPackFee = pickPackPrice * oli.Quantity;
                    }else{
                        System.debug('###OLI:'+oli.Quantity+'==>'+oli.MOQ__c);
                        pickPackFee = pickPackPrice * oli.Quantity * oli.MOQ__c;
                    }
                    //Calulate QA Review Fee
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey('QA Review') && !Product_Families_to_Skip_QA_Review_Set.contains(p.Family)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get('QA Review');
                        if(!FRTs.isEmpty()){
                            for(Fulfillment_Rates_Table__c FRT: FRTs){
                                if(FRT.Weight_lbs__c  <= unitweight && FRT.MOQ__c <= oli.MOQ__c){
                                    QAReviewPrice = FRT.Bracket_Price__c;
                                    break;
                                }
                            }
                        }
                        QAReviewFee = QAReviewPrice * oli.Quantity * oli.MOQ__c;
                        /*if(!FRTs.isEmpty()){
                            QAReviewFee = FRTs[0].Bracket_Price__c * oli.Quantity * oli.MOQ__c;
                        }*/
                    }
                    if( opp.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER  && opp.Order__r.Sample_Order__c == false && (opp.Order__r.Account__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_BASIC || opp.Order__r.Account__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE)
                      && ((opp.Order__r.Account__r.DBA__c == Account_Plateformlevel_ZASP || opp.Order__r.Account__r.DBA__c == Account_Plateformlevel_IRR) 
                        || (opp.Order__r.Retailer_DBA__c == Account_Plateformlevel_ZASP || opp.Order__r.Retailer_DBA__c == Account_Plateformlevel_IRR))){
                        
                        QAReviewFee  = 0;
                    }
                    if(opp.Order__r.Piggyback_sample__c != true && opp.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER  && opp.Order__r.Sample_Order__c == true){
                        QAReviewFee  = 0;
                    }
                    //Calulate Total Weight
                    if(oli.MOQ__c > 1){
                        totalWeight = weight * oli.Quantity;
                    }else{
                        totalWeight = weight * oli.Quantity * oli.MOQ__c;
                    }
                    System.debug('pickPackFee::'+p.MOQ__c+'==>'+pickPackFee);
                    oli.Pick_Pack_Fee__c = pickPackFee;
                    oli.QA_Review_Fee__c = QAReviewFee;
                    oli.Total_Weight_lbs__c = totalWeight;
                    OLIsToUpdate.add(oli);
                    totalPickPack += pickPackFee;
                    totalQAReview += QAReviewFee;
                    totalOrderWeight += totalWeight;
                }
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
                //calculate PackOut Fee
                if( hasMOQ1Item && serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey('Pack-Out')){
                    Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get('Pack-Out');
                    if(!FRTs.isEmpty()){
                        packOutFee = FRTs[0].Bracket_Price__c;
                    }
                }
                
                //calculate Total Mileage Fee
                if(!mileageSRTList.isEmpty() && opp.Order__r.State_License__r.Total_Miles__c != null){
                    for(Shipping_Rates_Table__c SRT: mileageSRTList){
                        if(opp.Order__r.State_License__r.Total_Miles__c <= SRT.Mileage_Bracket__c && opp.Order__r.State_License__r.Default_Warehouse__c == SRT.Site__c && membershipLevel == SRT.Membership_Level__c){
                            if(SRT.Fixed_Mileage_Fee__c){
                                totalMileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                            }else{
                                //totalMileageFee = SRT.Mileage_Bracket_Price__c * opp.Order__r.State_License__r.Total_Miles__c; 
                                totalMileageFee = opp.Order__r.Total_Milage_Fee__c;
                            }
                            break;
                        }
                    }
                    /*if(opp.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER && opp.Order__r.Account__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE){
                        totalMileageFee = 0;
                    }*/
                }
                
                //calculate Total Weight Fee
                if(!weightSRTList.isEmpty()){
                    for(Shipping_Rates_Table__c SRT: weightSRTList){
                        if(totalOrderWeight <= SRT.Weight_Bracket__c && opp.Order__r.State_License__r.Default_Warehouse__c == SRT.Site__c && membershipLevel == SRT.Membership_Level__c){
                            if(SRT.Fixed_Weight_Fee__c){
                                totalWeightFee = SRT.Fixed_Weight_Amount__c != null ? SRT.Fixed_Weight_Amount__c : 0;
                            }else{
                            	totalWeightFee = SRT.Weight_Bracket_Price__c * totalOrderWeight; 
                            }
                            break;
                        }
                    }   
                }
                if(skipFees  && opp.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER ){
                    
                    totalMileageFee = 0;
                    totalWeightFee = 0;
                }
                if(opp.Order__r.Piggyback_sample__c == true && opp.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER){
                    totalMileageFee = 0;
                }
                opp.Order_Booking_Fee__c = orderBookingFee;
                opp.Pack_Out_Fee__c = packOutFee;
                opp.Stage_Manifest_Fee__c = stageManifestFee;
                opp.Schedule_Dispatch_Fee__c = scheduleDispatchFee;
                opp.Total_Mileage_Fee__c = totalMileageFee;
                opp.Total_Weight_Fee__c = totalWeightFee;
                oppToUpdate.add(opp);
            }
            update oppToUpdate;
            update OLIsToUpdate;
        }
    }
    public static void reCalculateFees(List<OpportunityLineItem> items,Map<Id,OpportunityLineItem> oldMap){
        if(TestUtilData.skipTrigger) return;
        Set<Id> opportunityIds = new Set<Id>();
        for(OpportunityLineItem oli:items){
            if((Trigger.isInsert && oli.Pick_Pack_Fee__c == NULL && oli.QA_Review_Fee__c == NULL &&  oli.Total_Weight_lbs__c == NULL) || (Trigger.isUpdate && oli.Quantity != oldMap.get(oli.Id).Quantity )){
                opportunityIds.add(oli.OpportunityId);
            }
        }
        if(!opportunityIds.isEmpty()){
            updateShippingFee(opportunityIds);
        }
    }
}