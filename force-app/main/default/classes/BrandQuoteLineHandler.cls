public class BrandQuoteLineHandler {
    
    public static boolean internalBqlineQtyChange = false;
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
    private static String ORDER_RECORD_TYPE_NAME_TRANSFER{
        get{
            return String.isNotBlank(ORDER_RECORD_TYPE_NAME_TRANSFER) ? ORDER_RECORD_TYPE_NAME_TRANSFER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_Transfer');
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
    public Static String BRAND_QUOTE_RECORDTYPE_TRANSFER_QUOTE{
        get{
            return String.isNotBlank(BRAND_QUOTE_RECORDTYPE_TRANSFER_QUOTE) ? BRAND_QUOTE_RECORDTYPE_TRANSFER_QUOTE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BQ_Record_Type_Name_Transfer_Quote');
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
    public static void mapOwnershipCode(List<Brand_Quote_Line__c> items){
        Set<Id> pIds = new Set<Id>();
        for(Brand_Quote_Line__c oli : items){
            pIds.add(oli.Product_Name__c);
        }
        
       
        Map<Id,Product2> products = new Map<Id,Product2>([SELECT Producer_Name__c,Licensee_Name__c,White_Labelled__c FROM Product2 WHERE Id IN :pIds]);
        for(Brand_Quote_Line__c oli : items){
            
            if(products.get(oli.Product_Name__c ).White_Labelled__c)
                oli.Ownership_Code__c = products.get(oli.Product_Name__c ).Licensee_Name__c;
            else
                oli.Ownership_Code__c = products.get(oli.Product_Name__c ).Producer_Name__c;
        }
    }
    public static void updateQuanitityOnOrderLineItems(List<Brand_Quote_Line__c> items,Map<Id,Brand_Quote_Line__c> oldMap){
      
        Set<Id> bqLineIds = new Set<Id>();
        items = [SElECT Quantity_Cases__c,Product_Name__c,Status__c ,Brand_Quote_Number__r.Opportunity_Name__c,Billed_Quantity__c, 
                 Brand_Quote_Number__r.Opportunity_Name__r.Order__c,Brand_Quote_Number__r.Opportunity_Name__r.Order__r.RecordType.Name,Opportunity_Line_Item_Id__c FROM Brand_Quote_Line__c 
                 WHERE Id IN: oldMap.keySet()];

        Map<Id,Set<Brand_Quote_Line__c>> orderProductsMap = new Map<Id,Set<Brand_Quote_Line__c>>();
        Set<Id> productIds = new Set<Id>();
        Set<Id> oppIds = new Set<Id>();
        Set<String> BQLStatusesToUpdate = new Set<String>{'Cancelled','Rejected','Shipment Complete'};
            for(Brand_Quote_Line__c bql:items){
                if(bql.Quantity_Cases__c != oldMap.get(bql.Id).Quantity_Cases__c ){
                     bqLineIds.add(bql.Id);
                }
                
                if(bql.Brand_Quote_Number__r.Opportunity_Name__r.Order__c != null && ((bql.Quantity_Cases__c != oldMap.get(bql.Id).Quantity_Cases__c && bql.Brand_Quote_Number__r.Opportunity_Name__r.Order__r.RecordType.Name != ORDER_RECORD_TYPE_NAME_TRANSFER) || (bql.Status__c != oldMap.get(bql.Id).Status__c && BQLStatusesToUpdate.contains(bql.Status__c))) ){
               
                    if(orderProductsMap.containsKey(bql.Brand_Quote_Number__r.Opportunity_Name__r.Order__c)){
                        orderProductsMap.get(bql.Brand_Quote_Number__r.Opportunity_Name__r.Order__c).add(bql);
                    }else{
                        orderProductsMap.put(bql.Brand_Quote_Number__r.Opportunity_Name__r.Order__c, new Set<Brand_Quote_Line__c>{bql});
                    }
                    productIds.add(bql.Product_Name__c);
                    oppIds.add(bql.Brand_Quote_Number__r.Opportunity_Name__c);
                }
                
                if(bql.Status__c == oldMap.get(bql.Id).Status__c && oldMap.get(bql.Id).Status__c!='' ){
                    internalBqlineQtyChange = true;
                }
            }
        if(!orderProductsMap.isEmpty() && !productIds.isEmpty()){
               
            Map<Id,OpportunityLineItem> olisToUpdateMap = new Map<Id,OpportunityLineItem>();
            Map<String,OpportunityLineItem> OLIMap = new Map<String,OpportunityLineItem>();
            Map<String,OpportunityLineItem> OLIProductMap = new Map<String,OpportunityLineItem>();
            OpportunityLineItem[] opportunityLineItems = [SELECT Id,Opportunity_Line_Status__c,Opportunity.Order__c,Product2Id, Quantity,TotalPrice FROM OpportunityLineItem WHERE OpportunityId IN :oppIds AND Opportunity.Order__c IN: orderProductsMap.keySet() AND Product2Id IN :productIds];
            OLIMap = new Map<String,OpportunityLineItem>(opportunityLineItems);
            for(OpportunityLineItem oli: opportunityLineItems){
                    
                OLIProductMap.put(oli.Opportunity.Order__c+'-'+oli.Product2Id,oli);
            }
            for(Id orderId: orderProductsMap.keySet()){
                       
                Set<Brand_Quote_Line__c> orderProducts = orderProductsMap.get(orderId);
                if(!orderProducts.isEmpty()){
                  
                    for(Brand_Quote_Line__c bql : orderProducts){
                            
                        String key = orderId+'-'+bql.Product_Name__c;
                        if(bql.Opportunity_Line_Item_Id__c != NULL || OLIProductMap.containsKey(key)){
                            OpportunityLineItem odrLine = bql.Opportunity_Line_Item_Id__c != NULL ? OLIMap.get(bql.Opportunity_Line_Item_Id__c): OLIProductMap.get(key);
                            if(odrLine != null){
                                if(bql.Status__c != oldMap.get(bql.Id).Status__c && BQLStatusesToUpdate.contains(bql.Status__c)){
                                    odrLine.Opportunity_Line_Status__c = bql.Status__c;
                                }
                                if(bql.Quantity_Cases__c != oldMap.get(bql.Id).Quantity_Cases__c){
                                    odrLine.Quantity = bql.Quantity_Cases__c;
                                }
                                if(bql.Quantity_Cases__c != oldMap.get(bql.Id).Quantity_Cases__c || (bql.Status__c != oldMap.get(bql.Id).Status__c && BQLStatusesToUpdate.contains(bql.Status__c))){
                                    olisToUpdateMap.put(odrLine.Id,odrLine);
                                }
                                
                            }
                        }
                    }
                }
            }
            if(olisToUpdateMap.size() > 0){
                update olisToUpdateMap.values();
            }
            
            
        }
        // update POLI order qty from Bqline total qty
        if(bqLineIds.size() > 0  && internalBqlineQtyChange == true) {
            List<Purchase_Order_Line__c> updatepolineQty = new List<Purchase_Order_Line__c>();
            List<Purchase_Order_Line__c> polineList = [select Id,Brand_Quote_Line__c,Brand_Quote_Line__r.Line_Total_Qty__c,Qty_Ordered__c  from Purchase_Order_Line__c where  Brand_Quote_Line__c =:bqLineIds ];
            for(Purchase_Order_Line__c res: polineList){ 
                Purchase_Order_Line__c poList = new Purchase_Order_Line__c();
                poList.Id = res.Id;
                poList.Qty_Ordered__c =  res.Brand_Quote_Line__r.Line_Total_Qty__c;
                updatepolineQty.add(poList);
            }
           
            if(updatepolineQty.size() > 0){
                update updatepolineQty;
            }
           
        }
        
        
    }
    @future
    public static void updateShippingFee(Set<Id> BQIds){
     
        if(!BQIds.isEmpty()){
            Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
            Set<Id>warehouseIds = new Set<Id>();
            Set<String>membershipLevels = new Set<String>();
            Set<Id> productIds = new Set<Id>();
            Map<Id,Brand_Quote__c> brandQuoteMap = new Map<Id,Brand_Quote__c>([SELECT Id,Opportunity_Name__r.Order__c, Total_Weight_Fee__c /*,Listing_Fee__c*/, Order_Type__c,Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c ,RecordType.Name,
                                                                               Total_Mileage_Fee__c  , Opportunity_Name__r.Order__r.State_License__c,Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c,
                                                                               Stage_Manifest_Fee__c , Schedule_Dispatch_Fee__c ,Supplier_Name__r.Membership_Level__c, Supplier_Name__r.DBA__c,Receiver_Name__r.DBA__c,
                                                                               Pack_Out_Fee__c , Order_Booking_Fee__c,Opportunity_Name__r.Order__r.Total_Milage_Fee__c,
                                                                               Opportunity_Name__r.Order__r.Order_Type__c,Opportunity_Name__r.Ownership__r.Platform_Level__c,Ownership__r.Platform_Level__c,
                                                                               (SELECT Id,MOQ__c,Quantity_Cases__c,Pick_Pack_Fee__c,QA_Review_Fee__c, Total_Weight_lbs__c,Product_Name__c,Product_Name__r.White_Labelled__c ,Product_Name__r.Producer_Name__r.Listing_Fee__c,Product_Name__r.Licensee_Name__r.Listing_Fee__c, Line_Total_Retail_Wholesale_Price__c,Ownership_Code__r.Membership_Level__c  FROM Brand_Quote_Lines__r) 
                                                                               FROM Brand_Quote__c 
                                                                               WHERE Id IN: BQIds
                                                                               AND Opportunity_Name__r.Order__c != NULL]);
            for(Brand_Quote__c BQ: brandQuoteMap.values()){
                if(BQ.Order_Type__c == ORDER_TYPE_BRAND || BQ.Order_Type__c == ORDER_TYPE_TRANSFER){
                    if(BQ.Supplier_Name__r.Membership_Level__c != null){
                        membershipLevels.add(BQ.Supplier_Name__r.Membership_Level__c);
                    }
                }else{
                    for(Brand_Quote_Line__c oli:BQ.Brand_Quote_Lines__r){
                        membershipLevels.add(oli.Ownership_Code__r.Membership_Level__c);
                    }
                }
                
                warehouseIds.add(BQ.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c);
                for(Brand_Quote_Line__c oli: BQ.Brand_Quote_Lines__r){
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
              
                    if(serviceBasedFRTMap.containsKey(FRT.Fulfillment_Services__c)){
                        serviceBasedFRTMap.get(FRT.Fulfillment_Services__c).add(FRT);
                    }else{
                        serviceBasedFRTMap.put(FRT.Fulfillment_Services__c,new Fulfillment_Rates_Table__c[]{FRT});
                    }
                    warehouseServiceBasedFRTMap2.put(FRT.Membership_Level__c,serviceBasedFRTMap);
                    warehouseMLevelserviceBasedFRTMap.put(FRT.Site__c,warehouseServiceBasedFRTMap2);
                }
            }
            
            
            Map<Id,Product2> productsMap = new Map<Id,Product2>([SELECT Id, Name,MOQ__c, Unit_Shipping_Weight_lbs__c, 
                                                                 Case_Shipping_Weight_lbs__c,Family FROM Product2 WHERE Id IN: productIds]);
            List<Brand_Quote__c> BQToUpdate = new List<Brand_Quote__c>();
            List<Brand_Quote_Line__c> OLIsToUpdate = new List<Brand_Quote_Line__c>();
            for(Id BQId: brandQuoteMap.keySet()){
                Brand_Quote__c BQ = brandQuoteMap.get(BQId);
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
                String membershipLevel = '';
                Boolean hasMOQ1Item = false;
                Brand_Quote_Line__c[] OLIs = BQ.Brand_Quote_Lines__r;
                //serviceBasedFRTMap = warehouseserviceBasedFRTMap.get(BQ.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c);
                warehouseServiceBasedFRTMap2 = warehouseMLevelserviceBasedFRTMap.get(BQ.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c);
                
                for(Brand_Quote_Line__c oli:OLIs){
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
                    
                    
                    if(BQ.Order_Type__c == ORDER_TYPE_BRAND || BQ.Order_Type__c == ORDER_TYPE_TRANSFER){
                        membershipLevel = BQ.Supplier_Name__r.Membership_Level__c;
                    }else{
                        membershipLevel = oli.Ownership_Code__r.Membership_Level__c;
                    }
                    if(warehouseServiceBasedFRTMap2 != null)
                	serviceBasedFRTMap = warehouseServiceBasedFRTMap2.get(membershipLevel);
                    
                    if(oli.Product_Name__r.White_Labelled__c == false && oli.Product_Name__r.Producer_Name__r.Listing_Fee__c != NULL){
                        listingFeePercent = oli.Product_Name__r.Producer_Name__r.Listing_Fee__c;
                    }else if(oli.Product_Name__r.White_Labelled__c == true && oli.Product_Name__r.Licensee_Name__r.Listing_Fee__c != NULL){
                        listingFeePercent = oli.Product_Name__r.Licensee_Name__r.Listing_Fee__c;
                    }else{
                        listingFeePercent = ccs.Listing_Fee__c != NULL ?ccs.Listing_Fee__c :0;
                    }
                    if(listingFeePercent > 0){
                        listingFee = (listingFeePercent/100) * oli.Line_Total_Retail_Wholesale_Price__c;
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
                                if( FRT.Weight_lbs__c <= weight && FRT.Bracket_Price__c != null){
                                    pickPackPrice = FRT.Bracket_Price__c;
                                    break;
                                }
                            }
                        }
                    }
                    if(oli.MOQ__c > 1 && oli.Quantity_Cases__c != null){
                        pickPackFee = pickPackPrice * oli.Quantity_Cases__c;
                    }else{
                        if(oli.Quantity_Cases__c != null && oli.MOQ__c != null){
                            pickPackFee = pickPackPrice * oli.Quantity_Cases__c * oli.MOQ__c;
                        }
                    }
                    //Calulate QA Review Fee
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey('QA Review')  && !Product_Families_to_Skip_QA_Review_Set.contains(p.Family)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get('QA Review');
                        if(!FRTs.isEmpty()){
                            for(Fulfillment_Rates_Table__c FRT: FRTs){
                                if(FRT.Weight_lbs__c  <= weight && FRT.MOQ__c <= oli.MOQ__c){
                                    QAReviewPrice = FRT.Bracket_Price__c;
                                    break;
                                }
                            }
                        }
                    }
                    QAReviewFee = QAReviewPrice * oli.Quantity_Cases__c * oli.MOQ__c;
                    //Calulate Total Weight
                    if(oli.MOQ__c > 1){
                        totalWeight = weight * oli.Quantity_Cases__c;
                    }else{
                        totalWeight = weight * oli.Quantity_Cases__c * oli.MOQ__c;
                    }
                    System.debug('pickPackFee::'+p.MOQ__c+'==>'+pickPackFee);
                    oli.Pick_Pack_Fee__c = pickPackFee;
                    oli.QA_Review_Fee__c = QAReviewFee;
                    oli.Total_Weight_lbs__c = totalWeight;
                 
                    if(BQ.Order_Type__c == ORDER_TYPE_RETAIL){
                        oli.Listing_Fee__c = listingFee;
                    }
                    OLIsToUpdate.add(oli);
                    totalPickPack += pickPackFee;
                    totalQAReview += QAReviewFee;
                    totalOrderWeight += totalWeight;
                    //totalListingFee += listingFee;
                }
                if(BQ.Order_Type__c != ORDER_TYPE_RETAIL){
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
                if(BQ.Order_Type__c == 'Brand' && hasMOQ1Item && serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey('Pack-Out')){
                    Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get('Pack-Out');
                    if(!FRTs.isEmpty()){
                        packOutFee = FRTs[0].Bracket_Price__c;
                    }
                }
                
                //calculate Total Mileage Fee
                if(!mileageSRTList.isEmpty() && BQ.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c != null){
                    for(Shipping_Rates_Table__c SRT: mileageSRTList){
                        if(BQ.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c <= SRT.Mileage_Bracket__c && BQ.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c == SRT.Site__c  && membershipLevel == SRT.Membership_Level__c){
                            if(SRT.Fixed_Mileage_Fee__c){
                                totalMileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                            }else{
                                totalMileageFee = BQ.Opportunity_Name__r.Order__r.Total_Milage_Fee__c;
                            }
                            break;
                        }
                    }    
                    /*if(BQ.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER && BQ.Opportunity_Name__r.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE){
                        totalMileageFee = 0;
                    }*/
                }
                
                //calculate Total Weight Fee
                if(!weightSRTList.isEmpty()){
                    for(Shipping_Rates_Table__c SRT: weightSRTList){
                        if(totalOrderWeight <= SRT.Weight_Bracket__c && BQ.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c == SRT.Site__c   && membershipLevel == SRT.Membership_Level__c){
                            if(SRT.Fixed_Weight_Fee__c){
                                totalWeightFee = SRT.Fixed_Weight_Amount__c != null ? SRT.Fixed_Weight_Amount__c : 0;
                            }else{
                                totalWeightFee = SRT.Weight_Bracket_Price__c * totalOrderWeight; 
                            }
                            break;
                        }
                    }   
                }
               Boolean skipMWFee = false;
                           
        if(BQ.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE  && 
           (
               (BQ.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || BQ.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR) 
               || (BQ.Supplier_Name__r.DBA__c == Account_Plateformlevel_ZASP || BQ.Supplier_Name__r.DBA__c == Account_Plateformlevel_IRR)
           ) 
           && BQ.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER){
               skipMWFee = true;
           }  
        if(
            (
                (BQ.Supplier_Name__r.DBA__c != Account_Plateformlevel_ZASP && BQ.Supplier_Name__r.DBA__c != Account_Plateformlevel_IRR) 
                || (BQ.Receiver_Name__r.DBA__c != Account_Plateformlevel_ZASP && BQ.Receiver_Name__r.DBA__c != Account_Plateformlevel_IRR)
            ) && (BQ.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_ZASP && BQ.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_IRR)
            && BQ.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER){
                skipMWFee = true;
            }
                if(skipMWFee == true && BQ.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER){
                    totalMileageFee = 0;
                    totalWeightFee = 0; 
                }
                BQ.Order_Booking_Fee__c = orderBookingFee;
                BQ.Pack_Out_Fee__c = packOutFee;
                BQ.Stage_Manifest_Fee__c = stageManifestFee;
                BQ.Schedule_Dispatch_Fee__c = scheduleDispatchFee;
                BQ.Total_Mileage_Fee__c = totalMileageFee;
                BQ.Total_Weight_Fee__c = totalWeightFee;
                BQToUpdate.add(BQ);
            }
            update BQToUpdate;
            update OLIsToUpdate;
        }
    }
    public static void reCalculateFees(List<Brand_Quote_Line__c> items,Map<Id,Brand_Quote_Line__c> oldMap){
        if(TestUtilData.skipTrigger) return;
        Set<Id> BQIds = new Set<Id>();
        for(Brand_Quote_Line__c oli:items){
            if((Trigger.isInsert && oli.Pick_Pack_Fee__c == NULL && oli.QA_Review_Fee__c == NULL &&  oli.Total_Weight_lbs__c == NULL) || (Trigger.isUpdate && oli.Quantity_Cases__c != oldMap.get(oli.Id).Quantity_Cases__c )){
                BQIds.add(oli.Brand_Quote_Number__c);
            }
        }
        if(!BQIds.isEmpty()){
            updateShippingFee(BQIds);
        }
    }
}