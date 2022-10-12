public class RecalculateServiceInvoiceController {
    
    private ApexPages.StandardController stdController;
    private Sales_Order__c soRecord = null;
    private static String ACCOUNT_PLATEFORMLEVEL_BASIC {
        get{
            return String.isNotBlank(ACCOUNT_PLATEFORMLEVEL_BASIC ) ? ACCOUNT_PLATEFORMLEVEL_BASIC  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Plateformlevel_Basic');
        }set;
    }
    private static String ORDER_TYPE_RETAIL{
        get{
            return String.isNotBlank(ORDER_TYPE_RETAIL) ? ORDER_TYPE_RETAIL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Retail');
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
    public Static String SO_ORDER_TYPE_BRAND {
        get{
            return String.isNotBlank(SO_ORDER_TYPE_BRAND) ? SO_ORDER_TYPE_BRAND:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Type_Brand');
        }set;
    }
    public Static String SO_ORDER_TYPE_TRANSFER {
        get{
            return String.isNotBlank(SO_ORDER_TYPE_TRANSFER) ? SO_ORDER_TYPE_TRANSFER :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Type_Transfer');
        }set;
    }
    public Static String ERR_SO_RES_lICENSE_NOT_MATCH_WITH_ORDER {
        get{
            return String.isNotBlank(ERR_SO_RES_lICENSE_NOT_MATCH_WITH_ORDER) ? ERR_SO_RES_lICENSE_NOT_MATCH_WITH_ORDER:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Err_SO_Rec_license_not_match_with_order');
        }set;
    }
    private static String FULFILLMENT_SERVICE_PICK_PACK{
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
    private static String FULFILLMENT_SERVICE_PACKOUT{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_PACKOUT) ? FULFILLMENT_SERVICE_PACKOUT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_PackOut');
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
    
    // Constructor
    public RecalculateServiceInvoiceController(ApexPages.StandardController controller) {
        this.stdController = controller;
        soRecord = (Sales_Order__c)stdController.getRecord();
    }
    
    public RecalculateServiceInvoiceController(){
    	soRecord = new Sales_Order__c();    
    }
    
    @AuraEnabled
    public static AuraResponse recalculateServiceInvoice(String soId){
        AuraResponse r = new AuraResponse('AssignPackoutUIDController.recalculateServiceInvoice()');
        Sales_Order__c soRec = [SELECT Id,Name FROM Sales_Order__c WHERE Id =:soId];
        RecalculateServiceInvoiceController rec = new RecalculateServiceInvoiceController();
        rec.soRecord = soRec;
        String error = rec.updateShippingFee();
        r.data.put('errMsg', error);
        return r;
    }
    
    public String updateShippingFee(){
        
        try{
            Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
            Set<Id>warehouseIds = new Set<Id>();
            Set<Id>SiteIds = new Set<Id>();
            Set<String>membershipLevels = new Set<String>();
            Set<Id> productIds = new Set<Id>();
            Map<Id,Sales_Order__c> salesOrderMap = new Map<Id,Sales_Order__c>([select id ,name
                                     ,Distributor_Name__c
                                     ,Distributor_License__c
                                     ,Distributor_Contact__c
                                     ,Supplier_Name__c
                                     ,Supplier_License__c
                                     ,Supplier_Contact__c
                                     ,Sales_Order_Instructions__c
                                     ,Brand_Quote__r.Distributor_Name__c
                                     ,Brand_Quote__r.Distributor_License__c
                                     ,Brand_Quote__r.Distributor_Contact__c
                                     ,Brand_Quote__r.Supplier_Name__c
                                     ,Brand_Quote__r.Supplier_License__c
                                     ,Brand_Quote__r.Supplier_Contact__c
                                     ,Receiver_Name__c
                                     ,Receiver_License__c
                                     ,Receiver_Contact__c
                                     ,Site__c,Supplier_Name__r.Payment_Terms__c
                                     ,Site__r.Name,Piggyback_sample__c
                                     ,Opportunity_Name__c
                                     ,Planned_Ship_Date__c
                                     ,Sample_Order__c
                                     ,Customer_PO_or_Quote__c
                                     ,Brand_Quote__c
                                     ,Shipping_Terms__c
                                     ,Shipping_Method__c
                                     ,Payment_Terms__c
                                     ,SO_Type__c
                                     ,Ownership__c,Ownership__r.Type,Ownership__r.Service_Type__c
                                     ,Ownership__r.Membership_Level__c
                                     ,Total_Weight_Fee__c , 
                                     Total_Mileage_Fee__c  , 
                                     RecordType.Name,Brand_Quote__r.Opportunity_Name__r.Order__r.Sample_Order__c,
                                     Stage_Manifest_Fee__c , Schedule_Dispatch_Fee__c , 
                                     Pack_Out_Fee__c , Order_Booking_Fee__c,Total_Pick_Pack_Fee__c,
                                     Total_QA_Review_Fee__c,Change_Order_Fee__c,
                                     Total_Weight_lbs__c,Brand_Quote__r.Order_Type__c,Listing_Fee__c,
                                     Supplier_Name__r.Membership_Level__c, Brand_Quote__r.recordtype.Name,
                                     Receiver_Name__r.Platform_Level__c,Ownership__r.DBA__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__c,
                                     Receiver_Name__r.Membership_Level__c, Supplier_Name__r.Service_Type__c,Supplier_Name__r.Distribution_Fee__c,Total_Distribution_Fees__c,Total_Price__c,Distribution__c,
                                     Order_Type__c,Brand_Quote__r.Opportunity_Name__c,Receiver_Name__r.DBA__c,Supplier_Name__r.DBA__c,
                                     Ship_Confirmation_Date__c,Brand_Quote__r.Opportunity_Name__r.Order__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.Invoice_Memo__c,Ownership__r.Platform_Level__c,
                                     Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c,
                                     Brand_Quote__r.Opportunity_Name__r.Order__r.Customer__r.ContactId,Total_Manifest_Revision__c,Total_Change_Fee__c,
                                     (SELECT Id,MOQ__c,Qty_Ordered__c,Pick_Pack_Fee__c,QA_Review_Fee__c,Ownership_Code__r.Membership_Level__c, Total_Weight_lbs__c,Product_Name__c,Listing_Fee__c,Quantity_Cases__c,Product_Name__r.White_Labelled__c ,Product_Name__r.Producer_Name__r.Listing_Fee__c,Product_Name__r.Licensee_Name__r.Listing_Fee__c, Line_Total_Price__c FROM Sales_Order_Lines__r WHERE Status__c NOT IN (:STATUS_SALESORDERLINECANCELLED,:SALES_ORDER_LINE_STATUS_REJECTED))
                                     from Sales_Order__c WHERE Id =: soRecord.Id
                                     AND Brand_Quote__r.Opportunity_Name__r.Order__c != NULL]);
            /*Map<Id,Sales_Order__c> salesOrderMap = new Map<Id,Sales_Order__c>([SELECT Id,Receiver_License__c,Site__c,Brand_Quote__r.Opportunity_Name__r.Order__c, Total_Weight_Fee__c ,Brand_Quote__c, Brand_Quote__r.Opportunity_Name__c,
                                                                               Total_Mileage_Fee__c  ,LastModifiedDate,Last_Recalc_History__c, Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__c,Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c,
                                                                               Stage_Manifest_Fee__c ,Receiver_Name__r.Membership_Level__c, Schedule_Dispatch_Fee__c,Ownership__r.Membership_Level__c ,Supplier_Name__r.DBA__c,Supplier_Name__r.Membership_Level__c,RecordType.Name,RecordTypeId,  
                                                                               Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c,Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c,
                                                                               Pack_Out_Fee__c , Order_Booking_Fee__c,Order_Type__c,Shipping_Method__c,
                                                                               (SELECT Id,MOQ__c,Qty_Ordered__c,Pick_Pack_Fee__c,QA_Review_Fee__c,Ownership_Code__r.Membership_Level__c, Total_Weight_lbs__c,Product_Name__c,Listing_Fee__c,Quantity_Cases__c,Product_Name__r.White_Labelled__c ,Product_Name__r.Producer_Name__r.Listing_Fee__c,Product_Name__r.Licensee_Name__r.Listing_Fee__c, Line_Total_Price__c FROM Sales_Order_Lines__r WHERE Status__c NOT IN (:STATUS_SALESORDERLINECANCELLED,:SALES_ORDER_LINE_STATUS_REJECTED))
                                                                               FROM Sales_Order__c 
                                                                               WHERE Id =: soRecord.Id
                                                                               AND Brand_Quote__r.Opportunity_Name__r.Order__c != NULL]);*/
            for(Sales_Order__c SO: salesOrderMap.values()){
                /*if(SO.Receiver_License__c != SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__c){
                	String msg = ERR_SO_RES_lICENSE_NOT_MATCH_WITH_ORDER;
                    return msg;
                }
                
				*/
                if(SO.Order_Type__c == SO_ORDER_TYPE_BRAND || SO.Order_Type__c == SO_ORDER_TYPE_TRANSFER){
                    membershipLevels.add(SO.Ownership__r.Membership_Level__c);
                    //membershipLevels.add(SO.Supplier_Name__r.Membership_Level__c);
                }else{
                    for(Sales_Order_Line__c SOLI: SO.Sales_Order_Lines__r){
                        membershipLevels.add(SOLI.Ownership_Code__r.Membership_Level__c);
                    } 
                    //membershipLevels.add(SO.Receiver_Name__r.Membership_Level__c);
                }
                //membershipLevels.add(SO.Ownership__r.Membership_Level__c);
                warehouseIds.add(SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c);
                SiteIds.add(SO.Site__c);
                for(Sales_Order_Line__c oli: SO.Sales_Order_Lines__r){
                    productIds.add(oli.Product_Name__c );
                }
                
            }
            Fulfillment_Rates_Table__c [] FRTList = [SELECT Id, Active__c, Fulfillment_Services__c, Bracket_Price__c ,Rate_Effective_From__c ,Rate_Effective_To__c, Site__c,MOQ__c ,Weight_lbs__c ,Membership_Level__c
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
            if(!FRTList.isEmpty() ||Test.isRunningTest()){
                for(Fulfillment_Rates_Table__c FRT:FRTList){
                    if(warehouseMLevelserviceBasedFRTMap.containsKey(FRT.Site__c)){warehouseServiceBasedFRTMap2 = warehouseMLevelserviceBasedFRTMap.get(FRT.Site__c);
                    }else{warehouseServiceBasedFRTMap2 = new Map<String,Map<String,Fulfillment_Rates_Table__c []>>();
                    }
                    if(warehouseServiceBasedFRTMap2.containsKey(FRT.Membership_Level__c)){serviceBasedFRTMap = warehouseServiceBasedFRTMap2.get(FRT.Membership_Level__c);
                    }else{ serviceBasedFRTMap = new Map<String,Fulfillment_Rates_Table__c []>();}
                    if(serviceBasedFRTMap.containsKey(FRT.Fulfillment_Services__c)){serviceBasedFRTMap.get(FRT.Fulfillment_Services__c).add(FRT);
                    }else{serviceBasedFRTMap.put(FRT.Fulfillment_Services__c,new Fulfillment_Rates_Table__c[]{FRT});}
                    warehouseServiceBasedFRTMap2.put(FRT.Membership_Level__c,serviceBasedFRTMap);
                    warehouseMLevelserviceBasedFRTMap.put(FRT.Site__c,warehouseServiceBasedFRTMap2);
                }
            }
            
            
            Map<Id,Product2> productsMap = new Map<Id,Product2>([SELECT Id, Name,MOQ__c, Unit_Shipping_Weight_lbs__c, Case_Shipping_Weight_lbs__c,Family FROM Product2 WHERE Id IN: productIds]);
            List<Sales_Order__c> SOToUpdate = new List<Sales_Order__c>();
            Set<Id> bqIds = new Set<Id>();
            Set<Id> opportunityIds = new Set<Id>();
            Set<Id> orderIds = new Set<Id>();
            List<Sales_Order_Line__c> OLIsToUpdate = new List<Sales_Order_Line__c>();
            for(Id SOId: salesOrderMap.keySet()){
                Sales_Order__c SO = salesOrderMap.get(SOId);
                
                if(SO.Brand_Quote__c != null) bqIds.add(SO.Brand_Quote__c);
                if(SO.Brand_Quote__r.Opportunity_Name__c != null) opportunityIds.add(SO.Brand_Quote__r.Opportunity_Name__c);
                if(SO.Brand_Quote__r.Opportunity_Name__r.Order__c != null) orderIds.add(SO.Brand_Quote__r.Opportunity_Name__r.Order__c);
                
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
                    if(SO.Order_Type__c == SO_ORDER_TYPE_BRAND || SO.Order_Type__c == SO_ORDER_TYPE_TRANSFER){
                        membershipLevel = SO.Ownership__r.Membership_Level__c;}
                    else{ 
                        membershipLevel = oli.Ownership_Code__r.Membership_Level__c;
                    }
                    if(warehouseServiceBasedFRTMap2 != null)
                        serviceBasedFRTMap = warehouseServiceBasedFRTMap2.get(membershipLevel);
                    if(oli.Product_Name__r.White_Labelled__c == false && oli.Product_Name__r.Producer_Name__r.Listing_Fee__c != NULL){
                        listingFeePercent = oli.Product_Name__r.Producer_Name__r.Listing_Fee__c;
                    }else if(oli.Product_Name__r.White_Labelled__c == true && oli.Product_Name__r.Licensee_Name__r.Listing_Fee__c != NULL){
                        listingFeePercent = oli.Product_Name__r.Licensee_Name__r.Listing_Fee__c;
                    }else{listingFeePercent = ccs.Listing_Fee__c != NULL ?ccs.Listing_Fee__c :0;}
                    if(listingFeePercent > 0){listingFee = (listingFeePercent/100) * oli.Line_Total_Price__c;}
                    
                    if(oli.MOQ__c > 1){ weight = p.Case_Shipping_Weight_lbs__c;}
                    else{
                        weight = p.Unit_Shipping_Weight_lbs__c;
                        hasMOQ1Item = true;
                    }
                    unitweight = p.Unit_Shipping_Weight_lbs__c;
                    //Calulate Pick Pack Fee
                    if(weight > 0 && serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_PICK_PACK)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_PICK_PACK);
                        if(!FRTs.isEmpty()){
                            for(Fulfillment_Rates_Table__c FRT: FRTs){
                                if(FRT.Weight_lbs__c <= weight){pickPackPrice = FRT.Bracket_Price__c;
                                    break;
                                }
                            }
                        }
                    }
                    if(oli.MOQ__c > 1){pickPackFee = pickPackPrice * oli.Quantity_Cases__c;}
                    else{pickPackFee = pickPackPrice * oli.Qty_Ordered__c;}
                    //Calulate QA Review Fee
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_QA_REVIEW) && !Product_Families_to_Skip_QA_Review_Set.contains(p.Family)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_QA_REVIEW);
                        if(!FRTs.isEmpty()){
                            for(Fulfillment_Rates_Table__c FRT: FRTs){
                                if(FRT.Weight_lbs__c  <= weight && FRT.MOQ__c <= oli.MOQ__c){ QAReviewPrice = FRT.Bracket_Price__c;
                                    break;
                                }
                            }
                        }
                        QAReviewFee = QAReviewPrice * oli.Qty_Ordered__c;// * oli.MOQ__c;
                        /*if(!FRTs.isEmpty()){
                            QAReviewFee = FRTs[0].Bracket_Price__c * oli.Qty_Ordered__c;// * oli.MOQ__c;
                        }*/
                    }
                    if((SO.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_BASIC || SO.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE)  
                       && ((SO.Order_Type__c == ORDER_TYPE_TRANSFER  && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Sample_Order__c == false) || String.isBlank(SO.Brand_Quote__r.Order_Type__c)) &&
                       ((SO.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || SO.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR) 
                        || (SO.Supplier_Name__r.DBA__c == Account_Plateformlevel_ZASP || SO.Supplier_Name__r.DBA__c == Account_Plateformlevel_IRR))){
                            QAReviewFee = 0;
                    }
                    if(SO.Piggyback_sample__c != true && (SO.Order_Type__c == ORDER_TYPE_TRANSFER  && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Sample_Order__c == true)){
                        QAReviewFee = 0;
                    }
                    //Calulate Total Weight
                    if(oli.MOQ__c > 1){totalWeight = weight * oli.Quantity_Cases__c;}
                    else{totalWeight = weight * oli.Qty_Ordered__c;}
                    oli.Pick_Pack_Fee__c = pickPackFee;
                    oli.QA_Review_Fee__c = QAReviewFee;
                    oli.Total_Weight_lbs__c = totalWeight;
                    if(SO.Order_Type__c == ORDER_TYPE_RETAIL){oli.Listing_Fee__c = listingFee;}
                    OLIsToUpdate.add(oli);
                    totalPickPack += pickPackFee;
                    totalQAReview += QAReviewFee;
                    totalOrderWeight += totalWeight;
                    System.debug('##SO pickPackFee : '+pickPackFee + ' QAReviewFee :  '+QAReviewFee+' totalWeight : '+totalWeight);
                    //totalListingFee += listingFee;
                }
                if(SO.Order_Type__c != ORDER_TYPE_RETAIL){
                    //calculate OrderBooking Fee
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_ORDER_BOOKING)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_ORDER_BOOKING);
                        System.debug('##FULFILLMENT_SERVICE_ORDER_BOOKING : '+FRTs);
                        if(!FRTs.isEmpty()){
                            orderBookingFee = FRTs[0].Bracket_Price__c;
                        }
                    }
                    //calculate Stage & Manifest
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_STAGE_MANIFEST)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_STAGE_MANIFEST);
                        System.debug('##FULFILLMENT_SERVICE_STAGE_MANIFEST : '+FRTs);
                        if(!FRTs.isEmpty()){
                            stageManifestFee = FRTs[0].Bracket_Price__c; 
                        }
                    }
                    //calculate Schedule & Dispatch
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_SCHEDULE_DISPATCH)){
                        Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_SCHEDULE_DISPATCH);
                        System.debug('##FULFILLMENT_SERVICE_SCHEDULE_DISPATCH : '+FRTs);
                        if(!FRTs.isEmpty()){
                            scheduleDispatchFee = FRTs[0].Bracket_Price__c;
                        }
                    }
                }
                //calculate PackOut Fee
                if(hasMOQ1Item && serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_PACKOUT)){
                    Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_PACKOUT);
                    if(!FRTs.isEmpty()){
                        packOutFee = FRTs[0].Bracket_Price__c;
                    }
                }
                
                Boolean createWMLines = true;
                if(SO.RecordType.Name == SALESORDER_RECORDTYPE_Transfer && SO.Shipping_Method__c != NULL && SO.Shipping_Method__c.contains(SO_SHIPPING_METHOD_PICK_UP)){
                    createWMLines = false;
                }
                
                Decimal totalMiles = getTotalMiles(SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,SO.Receiver_License__c);
                
                //calculate Total Mileage Fee
 				System.debug('##mileageSRTList : '+mileageSRTList.size());
                if(createWMLines && !mileageSRTList.isEmpty() && totalMiles != null){     
                for(Shipping_Rates_Table__c SRT: mileageSRTList){
                        //if(SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c <= SRT.Mileage_Bracket__c && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c == SRT.Site__c && membershipLevel == SRT.Membership_Level__c){
                    if(totalMiles <= SRT.Mileage_Bracket__c ){
                        if(SRT.Fixed_Mileage_Fee__c){
                            totalMileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                        }else{
                            totalMileageFee = SRT.Mileage_Bracket_Price__c * totalMiles;
                        }
                            break;
                        }
                    }   
                    
                }
                /*if(SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER && SO.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE){
                    totalMileageFee = 0;
                }*/
                System.debug('##weightSRTList : '+weightSRTList.size());
                //calculate Total Weight Fee
                if(createWMLines && !weightSRTList.isEmpty()){
                    for(Shipping_Rates_Table__c SRT: weightSRTList){
                        if(totalOrderWeight <= SRT.Weight_Bracket__c && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c == SRT.Site__c && membershipLevel == SRT.Membership_Level__c){
                            if(SRT.Fixed_Weight_Fee__c){
                                
                                totalWeightFee = SRT.Fixed_Weight_Amount__c != null ? SRT.Fixed_Weight_Amount__c : 0;
                            }else{totalWeightFee = SRT.Weight_Bracket_Price__c * totalOrderWeight;}
                            break;
                        }
                    }   
                }
                System.debug('##SO orderBookingFee : '+orderBookingFee + ' packOutFee :  '+packOutFee+' stageManifestFee : '+stageManifestFee+' totalMileageFee : '+totalMileageFee+' totalWeightFee : '+ totalWeightFee);
                 Boolean skipMWFee = false;
                /*if(
                    (
                        (
                            (SO.Supplier_Name__r.DBA__c != Account_Plateformlevel_ZASP && SO.Supplier_Name__r.DBA__c != Account_Plateformlevel_IRR ) || (SO.Receiver_Name__r.DBA__c != Account_Plateformlevel_ZASP && SO.Receiver_Name__r.DBA__c != Account_Plateformlevel_IRR)
                        ) && (SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_ZASP 
                              || SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_IRR)
                    ) && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER && SO.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE){
                    System.debug('###Setting Mileage and Weight fee to 0');
                       skipMWFee = false;
                } */
                if(SO.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE  && 
                       (
                           (SO.Receiver_Name__r.DBA__c == Account_Plateformlevel_ZASP || SO.Receiver_Name__r.DBA__c == Account_Plateformlevel_IRR) 
                           || (SO.Supplier_Name__r.DBA__c == Account_Plateformlevel_ZASP || SO.Supplier_Name__r.DBA__c == Account_Plateformlevel_IRR)
                       ) 
                       && (SO.Order_Type__c == SO_ORDER_TYPE_TRANSFER || String.isBlank(SO.Brand_Quote__r.Order_Type__c))){//&& sOrder.Brand_Quote__r.recordtype.Name == TYPE_BUYQUOTE
                        skipMWFee = true;
                    }  
                    if(
                        (
                            (SO.Supplier_Name__r.DBA__c != Account_Plateformlevel_ZASP && SO.Supplier_Name__r.DBA__c != Account_Plateformlevel_IRR) 
                            || (SO.Receiver_Name__r.DBA__c != Account_Plateformlevel_ZASP && SO.Receiver_Name__r.DBA__c != Account_Plateformlevel_IRR)
                        ) && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__c != null && (SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_ZASP && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_IRR) && SO.Order_Type__c == SO_ORDER_TYPE_TRANSFER){
                        skipMWFee = true;
                    }
                System.debug('###totalWeightFee:'+totalWeightFee);
                System.debug('###totalMileageFee:'+totalMileageFee);
                if(skipMWFee == true && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER){
                    totalWeightFee = 0;
                    totalMileageFee = 0;
                }
                 if(SO.Piggyback_sample__c == true && SO.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER){
                       totalMileageFee = 0;
                    }
                User usr = [SELECT ID, Name,FirstName FROM User WHERE ID = :UserInfo.getUserId()];
                system.debug('SOH'+system.now());
                DateTime dt = System.Now();
                List<Sales_Order__History> SOH =[select  NewValue, OldValue,CreatedDate,CreatedBy.FirstName,CreatedBy.Name ,Field from Sales_Order__History  where Parent.id =:SOId and Field='Last_Recalc_History__c' order by CreatedDate DESC];
                
              
                List<string> historydata = new list<string>();
              
                DateTime dts = System.Now();
                string datas='';
                string dats = dts.format('MM/dd/yyyy hh:mm a', 'America/Los_Angeles');
                string newdata = '\n'+ usr.Name + ' - '+ dats +'\n';
                historydata.add(newdata);
                if(SOH != null)
                {
                  for(Sales_Order__History s :SOH )
                {
                    datas = s.CreatedBy.Name +'-' +s.CreatedDate.format('MM/dd/yyyy hh:mm a', 'America/Los_Angeles')+'\n';
                    
                    historydata.add(datas);                    
                }     
                }
              

                
                system.debug('historydata>'+historydata);
                  String names = string.join(historydata,',');
                String LastRecalHistory = names.replaceAll(',','\n');    
                SO.Last_Recalc_History__c = LastRecalHistory;

          
                   /*User usr = [SELECT ID, Name,FirstName FROM User WHERE ID = :UserInfo.getUserId()];
                // string dats = (SO.LastModifiedDate).format('MM/dd/yyyy hh:mm a');
                DateTime dt = System.Now();
				system.debug('');
				string dats = dt.format('MM/dd/yyyy hh:mm a', 'America/Los_Angeles');
                 if(SO.Last_Recalc_History__c != null)
                 {
                     SO.Last_Recalc_History__c += '\n'+ usr.Name + ' - '+ dats +'\n';
                 }else{
                     SO.Last_Recalc_History__c = usr.Name + ' - '+ dats + '\n';
                     
                 }
                 
                 string values =   SO.Last_Recalc_History__c;
                 system.debug('values'+values);
                 
                 String singleLineVersion = values.replaceAll('\\n', ', ');            
                 system.debug('singleLineVersion'+singleLineVersion);
                 List<String> lstAlpha = singleLineVersion.split(',');
                 System.debug('lstAlpha'+lstAlpha);
                 List<String> res = new List<String>();
                 for(Integer i = lstAlpha.size()-1; i>=0; i--) {
                     res.add(lstAlpha.get(i));
                 }
                 
                 System.Debug(res);                 
                 String names = string.join(res,',');
                 System.debug(names); 
                 String singleLineVersion2 = names.replaceAll(',', '\n ');            
                 system.debug('singleLineVersion'+singleLineVersion2);
                 SO.Last_Recalc_History__c =  singleLineVersion2; */
                System.Debug('## fee :'+orderBookingFee+'-'+packOutFee+'-'+stageManifestFee+'-'+scheduleDispatchFee+'-'+totalMileageFee+'-'+totalWeightFee); 
                SO.Order_Booking_Fee__c = orderBookingFee;
                SO.Pack_Out_Fee__c = packOutFee;
                SO.Stage_Manifest_Fee__c = stageManifestFee;
                SO.Schedule_Dispatch_Fee__c = scheduleDispatchFee;
                SO.Total_Mileage_Fee__c = totalMileageFee;
                SO.Total_Weight_Fee__c = totalWeightFee;
                //SO.Listing_Fee__c = totalListingFee;
                SOToUpdate.add(SO);
            }
            update SOToUpdate;
            update OLIsToUpdate; 
          
         
            if(bqIds.size() > 0){BrandQuoteLineHandler.updateShippingFee(bqIds);} 
            if(opportunityIds.size() > 0){OpportunityLineItemsHandler.updateShippingFee(opportunityIds);}
            if(orderIds.size() > 0){ OrderLineItemHelper.updateShippingFee(orderIds);}
            
        }catch (Exception ex){
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            return msg+'';
            //return null;
        }
        return '';
        //return redirectToRecord();
        //return null;
    }
    
    public PageReference redirectToRecord() {
        PageReference nextPage = new PageReference('/'+soRecord.Id);
        nextPage.setRedirect(true);
        return nextPage;
    }
    
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
        
        HTTP http = new HTTP();
        HTTPRequest request = new HTTPRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
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
            rec();
            return distVal;
        }
        
        return 0;
        
    }
     public static void rec()
     {
        List<Sales_Order__History> SOH =[select  NewValue, OldValue,CreatedDate,CreatedBy.FirstName,  Field from Sales_Order__History  where Parent.id ='a0d6s0000012Y1LAAU' and Field='Last_Recalc_History__c' order by CreatedDate DESC];
               
                 system.debug('CreatedDate'+SOH.size());    
     }
}