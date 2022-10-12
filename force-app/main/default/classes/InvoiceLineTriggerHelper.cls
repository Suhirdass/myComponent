public class InvoiceLineTriggerHelper {
    private static String ORDER_TYPE_RETAIL{
        get{
            return String.isNotBlank(ORDER_TYPE_RETAIL) ? ORDER_TYPE_RETAIL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Retail');
        }set;
    }
    private static String Invoice_Record_Type_Product{
        get{
            return String.isNotBlank(Invoice_Record_Type_Product) ? Invoice_Record_Type_Product : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Product');
        }set;
    }
    Public Static String INVOICE_AR_STATUS_REJECTED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_REJECTED) ? INVOICE_AR_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Rejected');
        }set;
    }
    Public Static String INVOICE_AR_STATUS_CANCELLED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_CANCELLED) ? INVOICE_AR_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Cancelled');
        }set;
    }
    
    public static void preventUpdatationOnLockedInvoice(List<Invoice_Line__c> newInvoieLines,List<Invoice_Line__c> oldInvoieLines){
        Set<Id> invoiceIds = new Set<Id>(); 
        if(Trigger.isDelete){
            for(Invoice_Line__c IL: oldInvoieLines){
                invoiceIds.add(IL.Invoice__c);
            }
        }else{
            for(Invoice_Line__c IL: newInvoieLines){
                invoiceIds.add(IL.Invoice__c);
            }
        }
        if(invoiceIds.size() > 0){
            List<Invoice__c> invoices = [SELECT Id FROM Invoice__c WHERE Id IN: invoiceIds AND IsLocked__c = true];
            if(invoices.size() > 0){
                if(Trigger.isDelete){
                    oldInvoieLines[0].addError('Can not delete Invoice Lines for Locked Invoice');
                    return;
                }else{
                    newInvoieLines[0].addError('Can not insert/update Invoice Lines for Locked Invoice');
                    return;
                }
            }
        }
    }
    //@future
    public static void updateShippingFee(Set<Id> invoiceIds){
        if(!invoiceIds.isEmpty()){
            Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
            Set<Id>warehouseIds = new Set<Id>();
            Set<String>membershipLevels = new Set<String>();
            Set<Id> productIds = new Set<Id>();
            Map<Id,Invoice__c> invoiceMap = new Map<Id,Invoice__c>([SELECT Id,RecordType.Name,Brand_Quote__r.Opportunity_Name__r.Order__c, Total_Weight_Fee__c ,/*Listing_Fee__c,*/ Order_Type__c,
                                     Total_Mileage_Fee__c  , Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__c,Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c,
                                     Stage_Manifest_Fee__c , Schedule_Dispatch_Fee__c , Supplier_Name__r.Membership_Level__c, 
                                     Pack_Out_Fee__c , Order_Booking_Fee__c,
                                     (SELECT Id,MOQ__c,Invoice_Qty__c,Pick_Pack_Fee__c,QA_Review_Fee__c, Total_Weight_lbs__c,Product_Name__c,Product_Name__r.White_Labelled__c,Listing_Fee__c ,Product_Name__r.Producer_Name__r.Listing_Fee__c,Product_Name__r.Licensee_Name__r.Listing_Fee__c, Line_Total_Product_Price__c  FROM Invoice_Lines__r) 
                                      FROM Invoice__c 
                                      WHERE Id IN: invoiceIds
                                      AND Brand_Quote__r.Opportunity_Name__r.Order__c != NULL]);
            for(Invoice__c inv: invoiceMap.values()){
                membershipLevels.add(inv.Supplier_Name__r.Membership_Level__c);
                warehouseIds.add(inv.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c);
                for(Invoice_Line__c oli: inv.Invoice_Lines__r){
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
        Shipping_Rates_Table__c [] weightSRTList = [SELECT Id, Active__c, Mileage_Bracket__c, Mileage_Bracket_Price__c,Rate_Effective_From__c,Rate_Effective_To__c,Membership_Level__c ,
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
            
            
            Map<Id,Product2> productsMap = new Map<Id,Product2>([SELECT Id, Name,MOQ__c, Unit_Shipping_Weight_lbs__c, Case_Shipping_Weight_lbs__c FROM Product2 WHERE Id IN: productIds]);
            List<Invoice__c> invoiceToUpdate = new List<Invoice__c>();
            List<Invoice_Line__c> OLIsToUpdate = new List<Invoice_Line__c>();
            for(Id invId: invoiceMap.keySet()){
                Invoice__c inv = invoiceMap.get(invId);
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
                Invoice_Line__c[] OLIs = inv.Invoice_Lines__r;
                //serviceBasedFRTMap = warehouseserviceBasedFRTMap.get(inv.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c);
                warehouseServiceBasedFRTMap2 = warehouseMLevelserviceBasedFRTMap.get(inv.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c);
                if(warehouseServiceBasedFRTMap2 != null)
                	serviceBasedFRTMap = warehouseServiceBasedFRTMap2.get(inv.Supplier_Name__r.Membership_Level__c);
                for(Invoice_Line__c oli:OLIs){
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
                    if(oli.Product_Name__r.White_Labelled__c == false && oli.Product_Name__r.Producer_Name__r.Listing_Fee__c != NULL){
                        listingFeePercent = oli.Product_Name__r.Producer_Name__r.Listing_Fee__c;
                    }else if(oli.Product_Name__r.White_Labelled__c == true && oli.Product_Name__r.Licensee_Name__r.Listing_Fee__c != NULL){
                        listingFeePercent = oli.Product_Name__r.Licensee_Name__r.Listing_Fee__c;
                    }else{
                        listingFeePercent = ccs.Listing_Fee__c != NULL ?ccs.Listing_Fee__c :0;
                    }
                    if(listingFeePercent > 0){
                        listingFee = (listingFeePercent/100) * oli.Line_Total_Product_Price__c;
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
                        pickPackFee = pickPackPrice * (oli.Invoice_Qty__c  / ((oli.MOQ__c == 0 || oli.MOQ__c == 0)?1:oli.MOQ__c));
                    }else{
                        pickPackFee = pickPackPrice * oli.Invoice_Qty__c;
                    }
                    //Calulate QA Review Fee
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey('QA Review')){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get('QA Review');
                        if(!FRTs.isEmpty()){
                            for(Fulfillment_Rates_Table__c FRT: FRTs){
                                if(FRT.Weight_lbs__c  <= unitweight && FRT.MOQ__c <= oli.MOQ__c){
                                    QAReviewPrice = FRT.Bracket_Price__c;
                                    break;
                                }
                            }
                        }
                        QAReviewFee = QAReviewPrice * oli.Invoice_Qty__c * oli.MOQ__c;
                        /*if(!FRTs.isEmpty()){
                            QAReviewFee = FRTs[0].Bracket_Price__c * oli.Invoice_Qty__c * oli.MOQ__c;
                        }*/
                    }
                    
                    //Calulate Total Weight
                    if(p.MOQ__c > 1){
                        totalWeight = weight * (oli.Invoice_Qty__c  / ((oli.MOQ__c == 0 || oli.MOQ__c == 0)?1:oli.MOQ__c));
                    }else{
                        totalWeight = weight * oli.Invoice_Qty__c;
                    }
                    System.debug('pickPackFee::'+p.MOQ__c+'==>'+pickPackFee);
                    oli.Pick_Pack_Fee__c = pickPackFee;
                    oli.QA_Review_Fee__c = QAReviewFee;
                    oli.Total_Weight_lbs__c = totalWeight;
                    if(inv.Order_Type__c == ORDER_TYPE_RETAIL){
                        oli.Listing_Fee__c = listingFee;
                    }
                    OLIsToUpdate.add(oli);
                    totalPickPack += pickPackFee;
                    totalQAReview += QAReviewFee;
                    totalOrderWeight += totalWeight;
                    //totalListingFee += listingFee;
                }
                if(inv.Order_Type__c != ORDER_TYPE_RETAIL && inv.RecordType.Name != Invoice_Record_Type_Product){
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
                if(hasMOQ1Item && serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey('Pack-Out')){
                    Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get('Pack-Out');
                    if(!FRTs.isEmpty()){
                        packOutFee = FRTs[0].Bracket_Price__c;
                    }
                }
                
                //calculate Total Mileage Fee
                if(!mileageSRTList.isEmpty() && inv.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c != null){
                    for(Shipping_Rates_Table__c SRT: mileageSRTList){
                        if(inv.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c <= SRT.Mileage_Bracket__c && inv.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c == SRT.Site__c && inv.Supplier_Name__r.Membership_Level__c == SRT.Membership_Level__c){
                            if(SRT.Fixed_Mileage_Fee__c){
                                totalMileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                            }else{
                                totalMileageFee = SRT.Mileage_Bracket_Price__c * inv.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c; 
                            }
                            break;
                        }
                    }    
                }
                
                //calculate Total Weight Fee
                if(!weightSRTList.isEmpty()){
                    for(Shipping_Rates_Table__c SRT: weightSRTList){
                        if(totalOrderWeight <= SRT.Weight_Bracket__c && inv.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c == SRT.Site__c  && inv.Supplier_Name__r.Membership_Level__c == SRT.Membership_Level__c){
                            if(SRT.Fixed_Weight_Fee__c){
                                totalWeightFee = SRT.Fixed_Weight_Amount__c != null ? SRT.Fixed_Weight_Amount__c : 0;
                            }else{
                            	totalWeightFee = SRT.Weight_Bracket_Price__c * totalOrderWeight; 
                            }
                            break;
                        }
                    }   
                }
                inv.Order_Booking_Fee__c = orderBookingFee;
                inv.Pack_Out_Fee__c = packOutFee;
                inv.Stage_Manifest_Fee__c = stageManifestFee;
                inv.Schedule_Dispatch_Fee__c = scheduleDispatchFee;
                inv.Total_Mileage_Fee__c = totalMileageFee;
                inv.Total_Weight_Fee__c = totalWeightFee;
                //inv.Listing_Fee__c = totalListingFee;
                invoiceToUpdate.add(inv);
            }
            update invoiceToUpdate;
            update OLIsToUpdate;
        }
    }
	public static void reCalculateFees(List<Invoice_Line__c> items,Map<Id,Invoice_Line__c> oldMap){
        if(TestUtilData.skipTrigger) return;
        Set<Id> invoiceIds = new Set<Id>();
        for(Invoice_Line__c oli:items){
            if((Trigger.isInsert && oli.Pick_Pack_Fee__c == NULL && oli.QA_Review_Fee__c == NULL &&  oli.Total_Weight_lbs__c == NULL) || (Trigger.isUpdate && oli.Invoice_Qty__c  != oldMap.get(oli.Id).Invoice_Qty__c  )){
                invoiceIds.add(oli.Invoice__c);
            }
        }
        if(!invoiceIds.isEmpty()){
            updateShippingFee(invoiceIds);
        }
    }
    public static void checkAllINLIisCancelled(List<Invoice_Line__c> items,Map<Id,Invoice_Line__c> oldMap){
        Map<Id,String> invoiceMap = new Map<Id,String> ();
        Set<Id> InvIds = new Set<Id>();
        for(Invoice_Line__c oli:items){
            if(Trigger.isUpdate && oli.InvoiceLine_Status__c  != oldMap.get(oli.Id).InvoiceLine_Status__c && (oli.InvoiceLine_Status__c == INVOICE_AR_STATUS_REJECTED || oli.InvoiceLine_Status__c == INVOICE_AR_STATUS_CANCELLED)  ){
                invoiceMap.put(oli.Invoice__c,oli.InvoiceLine_Status__c);
                InvIds.add(oli.Invoice__c);
            }
        }
        System.debug('##invoiceMap : '+invoiceMap);
        if(invoiceMap.size() > 0 && InvIds.size() > 0){
            List<Invoice__c> updateInvoiceList = new List<Invoice__c>();
            for(Invoice__c inv : [SELECT Id ,AR_Status__c,(SELECT id,Invoice__c,InvoiceLine_Status__c From Invoice_Lines__r WHERE InvoiceLine_Status__c NOT IN (:INVOICE_AR_STATUS_REJECTED,:INVOICE_AR_STATUS_CANCELLED)) FROM Invoice__c WHERE Id IN :InvIds]){
                if(inv.Invoice_Lines__r.size() ==  0 && (inv.AR_Status__c != INVOICE_AR_STATUS_REJECTED || inv.AR_Status__c != INVOICE_AR_STATUS_CANCELLED)){
                    inv.AR_Status__c = invoiceMap.get(inv.Id) == INVOICE_AR_STATUS_CANCELLED ? INVOICE_AR_STATUS_CANCELLED : INVOICE_AR_STATUS_REJECTED;
                    updateInvoiceList.add(inv);
                }
            }
            System.debug('##updateInvoiceList : '+updateInvoiceList);
            if(updateInvoiceList.size() >0){
                update updateInvoiceList;
            }
        }
        
    }
}