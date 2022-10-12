Public class OrderHelper {
    private static String Account_DBA_ZASP {
        get{
            return String.isNotBlank(Account_DBA_ZASP ) ? Account_DBA_ZASP  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_DBA_ZASP');
        }set;
    }
    private static String Account_DBA_IRR {
        get{
            return String.isNotBlank(Account_DBA_IRR ) ? Account_DBA_IRR  : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_DBA_IRR');
        }set;
    }
     private Static String Account_Service_Type_Margin {		
        get{
              return String.isNotBlank(Account_Service_Type_Margin) ? Account_Service_Type_Margin : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Service_Type_Margin');
        }set;
    }
     private static String Order_Status_Shipped{
        get{
            return String.isNotBlank(Order_Status_Shipped) ? Order_Status_Shipped : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Shipped');
        }set;
    }
    public static String PRODUCT_RECORD_TYPE_NAME_DISCOUNT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_DISCOUNT) ? PRODUCT_RECORD_TYPE_NAME_DISCOUNT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Discount');
        }set;
    }
    private Static String STATUS_APPROVED{
        get{
            return String.isNotBlank(STATUS_APPROVED) ? STATUS_APPROVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Approved');
        }set;
    }
    private static String TYPE_ADD_BRAND_CONTACT{
        get{
            return String.isNotBlank(TYPE_ADD_BRAND_CONTACT) ? TYPE_ADD_BRAND_CONTACT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Retailer_Related_Contact__c','Type_Add_Brand_Contact');
        }set;
    }
    private static String TYPE_ADD_RETAIL_CONTACT{
        get{
            return String.isNotBlank(TYPE_ADD_RETAIL_CONTACT) ? TYPE_ADD_RETAIL_CONTACT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Retailer_Related_Contact__c','Type_Add_Retail_Contact');
        }set;
    }
    public Static String STANDARD_PRICE_BOOK {
        get{
            return String.isNotBlank(STANDARD_PRICE_BOOK) ? STANDARD_PRICE_BOOK:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Pricebook','STANDARD_PRICE_BOOK');
        }set;
    }
    private static String STATUS_PENDING{
        get{
            return String.isNotBlank(STATUS_PENDING) ? STATUS_PENDING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Pending');
        }set;
    }
    public Static String ORDER_RECORD_TYPE_NAME_TRANSFER {
        get{
            return String.isNotBlank(ORDER_RECORD_TYPE_NAME_TRANSFER) ? ORDER_RECORD_TYPE_NAME_TRANSFER:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Record_Type_Name_Transfer');
        }set;
    }
    private Static String OPPORTUNITY_BUYSELL_RECORDTYPE {
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Oppty_Record_Type_Name_BuySell');
        }set;
    }
    private Static String OPPORTUNITY_SALES_ORIGIN_BRAND {
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Sales_Orgin_Brand');
        }set;
    }
    private Static String OPPORTUNITY_TYPE_EXISTING_BUSINESS {
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Type_Existing_Business');
        }set;
    }
    private Static String OPPORTUNITY_STAGE_PROPOSAL_PRICE_QUOTE {
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Stage_Proposal_Price_Quote');
        }set;
    }
    private Static String ORDER_TYPE_BRAND {
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Brand');
        }set;
    }
    public Static String ORDER_TYPE_TRANSFER {
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Transfer');
        }set;
    } 
    
    public static String RECURSYEARLY{
        get{
            return String.isNotBlank(RECURSYEARLY) ? RECURSYEARLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursYearly');
        }set;
    }
    private static String RECURSYEARLYNTH{
        get{
            return String.isNotBlank(RECURSYEARLYNTH) ? RECURSYEARLYNTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursYearlyNth');
        }set;
    }
    public static String HOLIDAY_RECURSMONTHLY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSMONTHLY) ? HOLIDAY_RECURSMONTHLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursMonthly');
        }set;
    }
    public static String HOLIDAY_RECURSMONTHLYNTH{
        get{
            return String.isNotBlank(HOLIDAY_RECURSMONTHLYNTH) ? HOLIDAY_RECURSMONTHLYNTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursMonthlyNth');
        }set;
    }
    public static String HOLIDAY_RECURSWEEKLY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSWEEKLY) ? HOLIDAY_RECURSWEEKLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursWeekly');
        }set;
    }
    public static String HOLIDAY_RECURSDAILY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSDAILY) ? HOLIDAY_RECURSDAILY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursDaily');
        }set;
    }
    public static String HOLIDAY_RECURSEVERYWEEKDAY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSEVERYWEEKDAY) ? HOLIDAY_RECURSEVERYWEEKDAY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursEveryWeekday');
        }set;
    }
    public static String HOLIDAY_RECURRENCE_FIRST{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_FIRST) ? HOLIDAY_RECURRENCE_FIRST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_First');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_SECOND{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_SECOND) ? HOLIDAY_RECURRENCE_SECOND : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Second');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_THIRD{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_THIRD) ? HOLIDAY_RECURRENCE_THIRD : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Third');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_FOURTH{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_FOURTH) ? HOLIDAY_RECURRENCE_FOURTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Fourth');
        }set;
    }
    public static String HOLIDAY_RECURRENCE_LAST{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_LAST) ? HOLIDAY_RECURRENCE_LAST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Last');
        }set;
    }
    private static String JANUARY_MONTH{
        get{
            return String.isNotBlank(JANUARY_MONTH) ? JANUARY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','January_Month');
        }set;
    }
    private static String FEBRUARY_MONTH{
        get{
            return String.isNotBlank(FEBRUARY_MONTH) ? FEBRUARY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','February_Month');
        }set;
    }
    private static String MARCH_MONTH{
        get{
            return String.isNotBlank(MARCH_MONTH) ? MARCH_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','March_Month');
        }set;
    }
    private static String APRIL_MONTH{
        get{
            return String.isNotBlank(APRIL_MONTH) ? APRIL_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','April_Month');
        }set;
    }
    private static String MAY_MONTH{
        get{
            return String.isNotBlank(MAY_MONTH) ? MAY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','May_Month');
        }set;
    }
    private static String JUNE_MONTH{
        get{
            return String.isNotBlank(JUNE_MONTH) ? JUNE_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','June_Month');
        }set;
    }
    private static String JULY_MONTH{
        get{
            return String.isNotBlank(JULY_MONTH) ? JULY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','July_Month');
        }set;
    }
    private static String AUGUST_MONTH{
        get{
            return String.isNotBlank(AUGUST_MONTH) ? AUGUST_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','August_Month');
        }set;
    }
    private static String SEPTEMBER_MONTH{
        get{
            return String.isNotBlank(SEPTEMBER_MONTH) ? SEPTEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','September_Month');
        }set;
    }
    private static String OCTOBER_MONTH{
        get{
            return String.isNotBlank(OCTOBER_MONTH) ? OCTOBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','October_Month');
        }set;
    }
    private static String NOVEMBER_MONTH{
        get{
            return String.isNotBlank(NOVEMBER_MONTH) ? NOVEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','November_Month');
        }set;
    }
    private static String DECEMBER_MONTH{
        get{
            return String.isNotBlank(DECEMBER_MONTH) ? DECEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','December_Month');
        }set;
    }
    public static String SOLI_STATUS_ALLOCATED{
        get{
            return String.isNotBlank(SOLI_STATUS_ALLOCATED) ? SOLI_STATUS_ALLOCATED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_Status_Allocated');
        }set;
    }
    public static String SOLI_STATUS_BACKORDERED{
        get{
            return String.isNotBlank(SOLI_STATUS_BACKORDERED) ? SOLI_STATUS_BACKORDERED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_Status_Back_Ordered');
        }set;
    }
    public static String SOLI_STATUS_PARTIALLY_ALLOCATED{
        get{
            return String.isNotBlank(SOLI_STATUS_PARTIALLY_ALLOCATED) ? SOLI_STATUS_PARTIALLY_ALLOCATED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_Status_Partially_Allocated');
        }set;
    }
    public static String STATE_LICENSE_ACTIVE{
        get{
            return String.isNotBlank(STATE_LICENSE_ACTIVE) ? STATE_LICENSE_ACTIVE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_Active');
        }set;
    }
    public static String STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE{
        get{
            return String.isNotBlank(STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE) ? STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_License_Holder_RecordType');
        }set;
    }
    public static String STATE_LICENSE_NONCANNABIS_RECORDTYPE{
        get{
            return String.isNotBlank(STATE_LICENSE_NONCANNABIS_RECORDTYPE) ? STATE_LICENSE_NONCANNABIS_RECORDTYPE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_NonCannabis_RecordType');
        }set;
    }
    public static String ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER{
        get{
            return String.isNotBlank(ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER) ? ACCOUNT_TYPE_FINANCIAL_INTEREST_HOLDER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Account','Account_Type_Financial_Interest_Holder');
        }set;
    }
    public static String SO_STATUS_DRAFT{
        get{
            return String.isNotBlank(SO_STATUS_DRAFT) ? SO_STATUS_DRAFT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Draft');
        }set;
    }
    private static String DL_ASR{
        get{
            return String.isNotBlank(DL_ASR) ? DL_ASR : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','DL_ASR');
        }set;
    }
    public static String Org_Base_URL{
        get{
            return String.isNotBlank(Org_Base_URL) ? Org_Base_URL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Org_Base_URL');
        }set;
    }
    
    public static String ORDER_STATUS_CANCELLED_BY_WOVN{
        get{
            return String.isNotBlank(ORDER_STATUS_CANCELLED_BY_WOVN) ? ORDER_STATUS_CANCELLED_BY_WOVN : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Filigreen');
        }set;
    }
    
    public static String OPP_STAGENAME_CLOSED_LOST{
        get{
            return String.isNotBlank(OPP_STAGENAME_CLOSED_LOST) ? OPP_STAGENAME_CLOSED_LOST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Opp_Stage_Name_Closed_Lost');
        }set;
    }
    public static String ERROR_OPP_ALREADY_EXISTS{
        get{
            return String.isNotBlank(ERROR_OPP_ALREADY_EXISTS) ? ERROR_OPP_ALREADY_EXISTS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Opportunity','Err_Msg_Opportunity_Already_Exists');
        }set;
    }
    
    
    
    
    public static boolean runningTrigger = false;
    public static Company_Custom_Settings__c companySetting = Company_Custom_Settings__c.getInstance();
    public static List<Opportunity>  oppList= new List<Opportunity>();
    public static List<OpportunityLineItem> OpportunityLineItemInsertList = new List<OpportunityLineItem>();
    public static Map<ID,ID>  oppOrderIdMap= new Map<ID,ID>();
    public static void onBeforeInsert(List<Order__c>orders){
        Id orderRecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get(ORDER_RECORD_TYPE_NAME_TRANSFER).getRecordTypeId();
        Map<Id,Order__c[]> stateLicenseOrdersMap = new Map<Id,Order__c[]>();
        if(orders.size() > 0){
            for(Order__c odr: orders){
                if(odr.State_License__c != NULL && odr.RecordTypeId != orderRecordTypeId){
                    if(stateLicenseOrdersMap.containsKey(odr.State_License__c)){
                        stateLicenseOrdersMap.get(odr.State_License__c).add(odr);
                    }else{
                        stateLicenseOrdersMap.put(odr.State_License__c,new List<Order__c>{odr});
                    }
                }
            }
            if(stateLicenseOrdersMap.size() > 0){
                for(State_Licenses__c SL: [SELECT Id, Default_Warehouse__c  FROM State_Licenses__c WHERE Id IN :stateLicenseOrdersMap.keySet()]){
                    if(stateLicenseOrdersMap.containsKey(SL.Id)){
                        List<Order__c> SLOrders = stateLicenseOrdersMap.get(SL.Id);
                        if(SLOrders != NULL && SLOrders.size() > 0){
                            for(Order__c o: SLOrders){
                                o.Site__c = SL.Default_Warehouse__c ;
                            }
                        }
                    }
                }
            }
        }
    }
    
   
    public static void createOpportunity(Map<ID,Order__c> newOrderMap,Map<ID,Order__c> oldOrderMap){
        Set<Id> orderIds = new Set<Id>();
        for(Order__c ordr : newOrderMap.values()){
            orderIds.add(ordr.Id);
        }
        
        if(orderIds.size() > 0){
            Savepoint sp = Database.setSavepoint();
            List<Order__c> dbOrderList =[select id,Name,Account__c,Sample_Order__c,Retailer__c,Retailer__r.Hold__c,Retailer__r.Auto_Order_Flow__c, Status__c,Payment_Terms__c,State_License__c,Site__c,
                                         State_License__r.Default_Warehouse__c , Total_Weight_Fee__c , Total_Milage_Fee__c , Sales_Person__c,isPreapproved__c,
                                         Stage_Manifest_Fee__c , Schedule_Dispatch_Fee__c , Pack_Out_Fee__c , Order_Booking_Fee__c ,Order_Type__c,
                                         Service_Booking_Fee__c, Service_Scheduling_Fee__c, Service_Staging_Fee__c, RecordType.Name, 
                                         (select id,Is_Sample__c,Product__c,Product__r.id,Ownership_Code__c,Price_Book_Entry_Id__c,
                                          UnitPrice__c,Total__c,MOQ__c,Quantity_Cases__c,Line_Total_Qty__c, Product_Title__c,
                                          Pick_Pack_Fee__c,QA_Review_Fee__c, Total_Weight_lbs__c,Listing_Fee__c
                                          from Order_Line_Items__r) from Order__c where ID =:orderIds];
            System.debug('##dbOrderList '+dbOrderList.size());
            List<Order__c> OppOrderList = new List<Order__c>();
            Map<Id,List<Id>> orderPBEsMap = new Map<Id,List<Id>>();
            Map<Id,Boolean> orderPriceBooksMap = new Map<Id,Boolean>();
            Set<Id> productIds = new Set<Id>();
            Map<Id,PriceBookEntry> PBEMap = new Map<Id,PriceBookEntry>();
            Boolean isSampleOrder = false;
            for(Order__c orderObj:dbOrderList){
                Order__c oldOrderObj = Trigger.isUpdate ? oldOrderMap.get(orderObj.Id):null;
                system.debug('##oldOrderObj : '+oldOrderObj);
               if(orderObj.Status__c == STATUS_APPROVED &&  oldOrderObj.Status__c != STATUS_APPROVED){
                    orderPriceBooksMap.put(orderObj.Id,true);
                    System.debug('##OLI '+orderObj.Order_Line_Items__r);
                    if(orderObj.Order_Line_Items__r != null & orderObj.Order_Line_Items__r.size() >0){
                        for(Order_Line_Item__c OLI :orderObj.Order_Line_Items__r){
                            productIds.add(OLI.Product__c);
                            if(String.isNotBlank(OLI.Price_Book_Entry_Id__c)){
                                if(orderPBEsMap.containsKey(orderObj.Id)){
                                    orderPBEsMap.get(orderObj.Id).add(Id.valueOf(OLI.Price_Book_Entry_Id__c));
                                }else{
                                    orderPBEsMap.put(orderObj.Id, new List<Id>{Id.valueOf(OLI.Price_Book_Entry_Id__c)});
                                }
                            }
                            if(OLI.Is_Sample__c){
                                isSampleOrder = true;
                            }
                        }
                    }
                    Opportunity opp=createOpportunityRec(orderObj);
                    oppList.add(opp);
                }
            }
            if(productIds.size() > 0){
                Map<Id,PriceBookEntry> productPBEMap = new Map<Id,PriceBookEntry>([SELECT Id,Product2Id, PriceBook2Id FROM PriceBookEntry WHERE Product2Id IN :productIds AND PriceBook2.Name =: STANDARD_PRICE_BOOK]);
                for(PriceBookEntry pbe: productPBEMap.values()){
                    productPBEMap.put(pbe.Product2Id,pbe);
                }
                if(oppList.size()>0){
                    try{
                        insert oppList;
                        
                        List<Id> PBEIds = new List<Id>();
                        for(Id orderId: orderPBEsMap.keySet()){
                            PBEIds.addAll(orderPBEsMap.get(orderId));
                        }
                        System.debug('###PBEIds::'+PBEIds);
                        if(!PBEIds.isEmpty()){
                            PBEMap = new Map<Id,PriceBookEntry>([SELECT Id, PriceBook2Id FROM PriceBookEntry WHERE Id IN :PBEIds]);
                            for(Id orderId: orderPBEsMap.keySet()){
                                Boolean hasSamePB = true;
                                List<Id> PBEIdList = orderPBEsMap.get(orderId);
                                Integer i=0;
                                if(!PBEIdList.isEmpty()){
                                    PriceBookEntry pbeCmp;
                                    for(Id PBEId: PBEIdList){
                                        PriceBookEntry pbe = PBEMap.get(PBEId);
                                        if(i==0){
                                            pbeCmp = PBEMap.get(PBEId);
                                        }else if(pbeCmp.Pricebook2Id != pbe.Pricebook2Id){
                                            hasSamePB = false; break;
                                        }
                                        i++;
                                    }
                                }
                                orderPriceBooksMap.put(orderId,hasSamePB);
                            }
                        }
                    }
                    catch (Exception ex)
                    { 
                        ErrorLogs.log('OrderHelper', ex.getStackTraceString(), ex.getMessage());
                    }
                    
                    
                    
                    try{
                        for(Opportunity var:oppList){
                            oppOrderIdMap.put(var.Order__c ,var.ID); //need to create Order__c  @opportunity.
                        }
                        for(Order__c orderObj:dbOrderList){
                            List<OpportunityLineItem> OpportunityLineItemList = createOpportunityLineItemRec(orderObj,oppOrderIdMap,orderPriceBooksMap,productPBEMap,PBEMap);
                            OpportunityLineItemInsertList.addAll(OpportunityLineItemList);
                        }
                        insert OpportunityLineItemInsertList;
                        if(orderIds.size() > 0 && isSampleOrder == false){
                            //ApproveProcessForAutoOrderFlow(oppListForApprove);
                            BatchToOrderAutomationFlow bat = new BatchToOrderAutomationFlow ();
                            bat.orderIds =  orderIds ;
                            database.executeBatch(bat,2) ;
                            
                        }
                    }
                    catch (Exception ex)
                    { 
                        Database.rollback(sp); ErrorLogs.log('OrderHelper', ex.getStackTraceString(), ex.getMessage());
                    }
                }
            }
            
            
        }
        
    }
    public static Opportunity createOpportunityRec(Order__c OrderObj){
        Opportunity  opp= new Opportunity();
        opp.Name=OrderObj.Name;//+'- Create from Apporved Order';
        opp.Sales_Origin__c = OPPORTUNITY_SALES_ORIGIN_BRAND;
        if(OrderObj.Order_Type__c == ORDER_TYPE_BRAND || OrderObj.Order_Type__c == ORDER_TYPE_TRANSFER){
            opp.Ownership__c= OrderObj.Account__c;
        } else { opp.Ownership__c= companySetting.Default_Distributor__c;
        }
        opp.AccountId= OrderObj.Retailer__c;
        opp.Type= OPPORTUNITY_TYPE_EXISTING_BUSINESS;
        opp.StageName= OPPORTUNITY_STAGE_PROPOSAL_PRICE_QUOTE;
        opp.CloseDate=date.today()+10; 
        opp.Site_Name__c= OrderObj.Site__c != NULL ?OrderObj.Site__c :OrderObj.State_License__r.Default_Warehouse__c; 
        opp.Order__c =OrderObj.ID;
        opp.Payment_Terms__c = OrderObj.Payment_Terms__c;
        if(OrderObj.RecordType.Name == ORDER_RECORD_TYPE_NAME_TRANSFER){ 
            Id oppTransferRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(ORDER_RECORD_TYPE_NAME_TRANSFER).getRecordTypeId();
            opp.RecordTypeId = oppTransferRecordTypeId;    
        }else{
            Id oppRecordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get(OPPORTUNITY_BUYSELL_RECORDTYPE).getRecordTypeId();
            opp.RecordTypeId = oppRecordTypeId;    
        }
        opp.Order_Booking_Fee__c = OrderObj.Order_Booking_Fee__c;
        opp.Service_Booking_Fee__c = OrderObj.Service_Booking_Fee__c;
        opp.Service_Scheduling_Fee__c = OrderObj.Service_Scheduling_Fee__c;
        opp.Service_Staging_Fee__c  = OrderObj.Service_Staging_Fee__c ;
        opp.Schedule_Dispatch_Fee__c = OrderObj.Schedule_Dispatch_Fee__c;
        opp.Stage_Manifest_Fee__c = OrderObj.Stage_Manifest_Fee__c;
        opp.Total_Mileage_Fee__c = OrderObj.Total_Milage_Fee__c;
        opp.Total_Weight_Fee__c = OrderObj.Total_Weight_Fee__c;
        opp.Pack_Out_Fee__c = OrderObj.Pack_Out_Fee__c;
        opp.Sample_Order__c = OrderObj.Sample_Order__c;
        return opp;
    }
    
    public static List<OpportunityLineItem> createOpportunityLineItemRec(Order__c OrderObj,Map<ID,ID>  oppOrderIdMap,Map<Id,Boolean> orderPriceBooksMap,Map<Id,PriceBookEntry> productPBEMap,Map<Id,PriceBookEntry> PBEMap){

        
        List<OpportunityLineItem> OpportunityLineItemList = new List<OpportunityLineItem>();
        if(OrderObj.Order_Line_Items__r != null & OrderObj.Order_Line_Items__r.size() >0){
            for(Order_Line_Item__c OLI :OrderObj.Order_Line_Items__r){
                OpportunityLineItem oppLineItem= new OpportunityLineItem();
                oppLineItem.Product2Id = OLI.Product__c; 
                oppLineItem.Order_Line_Item__c = OLI.Id;
                oppLineItem.Listing_Fee__c = OLI.Listing_Fee__c;
                oppLineItem.Ownership_Code__c = OLI.Ownership_Code__c;
                oppLineItem.Pick_Pack_Fee__c = OLI.Pick_Pack_Fee__c;
                oppLineItem.QA_Review_Fee__c = OLI.QA_Review_Fee__c;
                oppLineItem.Total_Weight_lbs__c = OLI.Total_Weight_lbs__c;
                oppLineItem.OpportunityID= oppOrderIdMap.get(OrderObj.ID); 
                PriceBookEntry pbe = productPBEMap.get(OLI.Product__c);
              
                PricebookEntry aPBE = PBEMap.get(OLI.Price_Book_Entry_Id__c);
                if(orderPriceBooksMap.get(OrderObj.ID)){
                    oppLineItem.PricebookEntryID=Id.valueOf(OLI.Price_Book_Entry_Id__c); 
                }else{
                    if(pbe != null){ oppLineItem.PricebookEntryID= pbe.Id;
                    }
                }
                if(aPBE != null){
                    oppLineItem.PriceBook_Id__c = aPBE.Pricebook2Id;
                }
                
                oppLineItem.UnitPrice=OLI.UnitPrice__c;
                oppLineItem.Is_Sample__c = OLI.Is_Sample__c;
                
                oppLineItem.Quantity=OLI.Quantity_Cases__c;
                oppLineItem.Product_Title__c = OLI.Product_Title__c;
               
                OpportunityLineItemList.add(oppLineItem);
            }
        }
        return OpportunityLineItemList;
    }
    public static void updateTotalOrderedQty(Order__c[] newList, Map<Id,Order__c> oldMap, Boolean isFromOrder){
        
        Map<Id,Order__c> processedOrdersMap = new Map<Id,Order__c>();
        Set<Id> calculateFeeOrderIds = new Set<Id>();
        for(Order__c o: newList){
            if(Trigger.isUpdate && o.Status__c != oldMap.get(o.Id).Status__c && o.Status__c == STATUS_PENDING){ calculateFeeOrderIds.add(o.Id);
            }
            if(!isFromOrder || Trigger.isInsert ||(Trigger.isUpdate && o.Status__c != oldMap.get(o.Id).Status__c)){
                processedOrdersMap.put(o.Id,o);
            }
        }
        if(calculateFeeOrderIds.size() > 0){ OrderLineItemHelper.updateShippingFee(calculateFeeOrderIds);
        }
        if(!processedOrdersMap.isEmpty()){
            Order_Line_Item__c[] items = [SELECT Id, Product__c FROM Order_Line_Item__c WHERE Order__c IN : processedOrdersMap.keySet()];
           List<Id>productIds = new List<Id>();
            for(Order_Line_Item__c oli: items){
                productIds.add(oli.Product__c);                
            }
            if(!productIds.isEmpty()){
                InventoryPositionsHelper.updateAvailableQty(productIds);
            }
           
        }
    }
    
  
    /*public static void sendEmailToReceiver(list<Order__c>newList,Map<Id,Order__c> oldMap){
        Set<Id> resultIds = (new Map<Id,Order__c>(newList)).keySet();
        orgwideemailaddress orgWide = [select Id,Address, displayName from orgwideemailaddress where displayName =: 'DL-Orders' limit 1];
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        //Get your document from document Object
        List<Document> doc = new List<Document>();
            doc = [SELECT Id, Name, Body, ContentType, DeveloperName, Type FROM Document WHERE DeveloperName =: 'X8300'];
        List<Order__c> updateOrderForRescheduleAgain = new List<Order__c>();
        for(Order__c ord : [SELECT Id,Name,Request_Ship_Date__c,Account__c,Customer__c,Customer__r.Email,Requested_Delivery_Earliest_Time__c,Retailer_DBA__c,Account_DBA__c,Status__c,
                            Requested_Delivery_Latest_Time__c,Retailer__r.DBA__c,Retailer__r.ShippingAddress,Retailer_PO__c,Total_Product_Price__c,Sales_Person__c,Sales_Person__r.Email,Sales_Person__r.Orders_Email_Opt_In__c,Sales_Person__r.Active__c,
                            Total__c,Payment_Terms__c,Total_Excise_Tax_Amount__c,State_License__r.License_Number__c,IsRescheduled__c,Additional_Brand_Contact__c,Additional_Brand_Contact__r.Email,
                            State_License__r.License_Address__c,State_License__r.License_City__c,State_License__r.License_Country__c,State_License__r.License_State__c,State_License__r.License_Zip__c,Planned_Ship_Date__c,
                            Retailer_Contact__c,Retailer_Contact__r.email,Retailer_Contact__r.FirstName,(SELECT Id, Name, Product__r.Name,Product__r.Product_Short_Description__c,Product__r.Family,Product__r.Description,UnitPrice__c,Quantity_Cases__c,
                                      MOQ__c,Line_Total_Qty__c,Product__r.Brand_Name__c,Product__r.RecordType.Name,
                                      Unit_Excise_Tax__c,Line_Total_Excise_Tax__c,Total__c ,Line_Total_Cost__c,IsPromo__c,Is_Sample__c
                                      FROM  Order_Line_Items__r),(SELECT id,Contact__c,Contact__r.Email FROM Retailer_Related_Contacts__r WHERE Contact__r.Active__c = true AND Type__c IN (:TYPE_ADD_BRAND_CONTACT,:TYPE_ADD_RETAIL_CONTACT) AND Contact__r.Email != null)
                            FROM Order__c WHERE Id IN : resultIds]){
                                if(ord.Request_Ship_Date__c != null && ord.Requested_Delivery_Earliest_Time__c != null && ord.Requested_Delivery_Latest_Time__c != null &&
                                   (Trigger.isInsert ||(Trigger.isUpdate && (((ord.Request_Ship_Date__c != oldMap.get(ord.Id).Request_Ship_Date__c || 
                                                                             ord.Requested_Delivery_Earliest_Time__c != oldMap.get(ord.Id).Requested_Delivery_Earliest_Time__c ||
                                                                             ord.Requested_Delivery_Latest_Time__c != oldMap.get(ord.Id).Requested_Delivery_Latest_Time__c) && ord.Status__c != oldMap.get(ord.Id).Status__c && ord.Status__c == STATUS_APPROVED ) && ord.IsRescheduled__c == true )))){
                                                                                 
                                                                                 String[] strTimeSplit = String.valueOf(ord.Requested_Delivery_Earliest_Time__c).split(':');
                                                                                 String earTime = Integer.valueOf(strTimeSplit[0]) > 12 ? String.valueOf(Integer.valueOf(strTimeSplit[0]) - 12)+':'+strTimeSplit[1]+' pm' : strTimeSplit[0]+':'+strTimeSplit[1]+(Integer.valueOf(strTimeSplit[0]) == 12 ?' PM': ' AM');
                                                                                 
                                                                                 
                                                                                 String[] strTimelateSplit = String.valueOf(ord.Requested_Delivery_Latest_Time__c).split(':');
                                                                                 String latTime = Integer.valueOf(strTimelateSplit[0]) > 12 ? String.valueOf(Integer.valueOf(strTimelateSplit[0]) - 12)+':'+strTimelateSplit[1]+' pm' : strTimelateSplit[0]+':'+strTimelateSplit[1]+(Integer.valueOf(strTimelateSplit[0]) == 12 ?' PM': ' AM');
                                                                                 
                                                                                 Datetime dt = DateTime.newInstance(ord.Request_Ship_Date__c, Time.newInstance(0, 0, 0, 0));
                                                                                 String dayOfWeek=dt.format('EEEE');
                                                                                 
                                                                                 Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                                                                 if(ord.IsRescheduled__c){
                                                                                     mail.setSubject('Please Confirm Delivery Date for Order '+ord.Name +' from '+ord.Account_DBA__c+' by WOVN');
                                                                                 }else{
                                                                                    mail.setSubject('Thanks for Scheduling Order '+ord.Name +' from '+ord.Account_DBA__c+' by WOVN'); 
                                                                                 }
                                                                                 
                                                                                 String htmlBody = 'Hello '+ord.Retailer_Contact__r.FirstName +',<br/><br/>';
                                                                                 if(ord.IsRescheduled__c){
                                                                                     Datetime redt = DateTime.newInstance(ord.Planned_Ship_Date__c, Time.newInstance(0, 0, 0, 0));
                                                                                     String dayOfWeekRe=redt.format('EEEE');
                                                                                     htmlBody += 'You previously requested a delivery on '+'<b>'+dayOfWeek +' '+ dt.format() +' @ '+earTime.toUppercase()+'-'+latTime.toUppercase()+'</b><br/><br/>';
                                                                                      htmlBody += 'Your delivery day and time has been updated to:<br/><br/>';
                                                                                     htmlBody += '<b>'+dayOfWeekRe +' '+ ord.Planned_Ship_Date__c.format() +' @ '+earTime.toUppercase()+'-'+latTime.toUppercase()+'</b><br/><br/>';
                                                                                     
                                                                                     htmlBody += '<b> <a href="'+Label.WOVN_Community_URL+'acceptorder?id='+ord.Id+'&reschedule=true-a">PLEASE CLICK HERE TO APPROVE OR REQUEST A NEW DELIVERY DATE.</a>  </b><br/><br/>';
                																	 //htmlBody += 'IF YOU’D LIKE TO CHANGE YOUR PREVIOUSLY REQUESTED DATE AND TIME,  <b> <a href="'+Label.WOVN_Community_URL+'acceptorder?id='+ord.Id+'&reschedule=true">CLICK HERE.</a>  </b><br/><br/>';
                                                                                 }else{
                                                                                     htmlBody += 'Thank you for approving and Scheduling your order '+ord.Name+' via the WOVN portal:<br/><br/>';
                                                                                 }
                                                                                 
                                                                                 htmlBody +='<b>ORDER DETAILS<b/><br/>';
                                                                                 htmlBody +='Retailer Name:&nbsp;'+ord.Retailer_DBA__c+'<br/>';
                                                                                 
                                                                                 String Retailer_PO =ord.Retailer_PO__c==null?'':ord.Retailer_PO__c;
                                                                                 htmlBody +='Retailer PO:&nbsp;'+Retailer_PO+'<br/>';
                                                                                 
                                                                                 
                                                                                 String add = '';
                                                                                 add += ord.State_License__r.License_Address__c != null ? ord.State_License__r.License_Address__c +' ':'';
                                                                                 add += ord.State_License__r.License_City__c != null ? ord.State_License__r.License_City__c +', ':'';
                                                                                 add += ord.State_License__r.License_State__c != null ? ord.State_License__r.License_State__c +' ':'';
                                                                                 add += ord.State_License__r.License_Zip__c != null ? ord.State_License__r.License_Zip__c +' ':'';
                                                                                 //add += ord.State_License__r.License_Country__c != null ? ord.State_License__r.License_Country__c +' ':'';
                                                                                 	
																				                                                                                 
                                                                                 htmlBody +='Total Product Price:&nbsp;$'+ord.Total_Product_Price__c+'<br/>';
                                                                                 htmlBody +='Total Excise Tax Amount:&nbsp;$'+ord.Total_Excise_Tax_Amount__c+' (Excise Tax is due COD at time of delivery.)<br/>';
                                                                                 htmlBody +='Total Order Price:&nbsp;$'+ord.Total__c+'<br/>';
                                                                                 htmlBody += '<b>Address:</b>&nbsp;'+add+'<br/>';
                                                                                 htmlBody +='<b>License Number:</b>&nbsp;'+ord.State_License__r.License_Number__c+'<br/>';
                                                                                 htmlBody +='<b>Payment Terms:</b>&nbsp;'+ord.Payment_Terms__c+'<br/><br/>';
                                                                                 
                                                                                 
                                                                                 
                                                                                 if(!ord.IsRescheduled__c){
                                                                                     htmlBody += '<b>Excise Tax is due COD at time of delivery.</b><br/><br/>';
                                                                                     htmlBody += 'Please note, as required by the Internal Revenue Service (IRS) we must report all transactions involving more than $10,000 in cash or cash equivalents as defined in 26 U.S.C. § 6050I.'; 
                                                                                     htmlBody += ' Pursuant to this requirement, please complete Part I and Part II of the attached Form 8300, and/or provide the identity of the individual from whom cash is received. This includes the individual’s name, address, and contact information.<br/><br/>';
                                                                                     htmlBody += ' We will deliver this order on - <br/><br/>';
                                                                                     htmlBody += '<b>'+dayOfWeek +' '+ ord.Request_Ship_Date__c.format() +' @ '+earTime.toUppercase()+'-'+latTime.toUppercase()+'</b>';
                                                                                     htmlBody += '<br/><br/> If you have any questions or concerns regarding your confirmed time and date, please feel free to reach out to us via email.<br/><br/> Thank you, <br/><br/> The WOVN Scheduling Team';
                                                                                 }else{
                                                                                     List<Order_Line_Item__c> discountOLIList = new List<Order_Line_Item__c>();
                                                                                     List<Order_Line_Item__c> oliList = new List<Order_Line_Item__c>();
                                                                                     for(Order_Line_Item__c oli : ord.Order_Line_Items__r){
                                                                                         if(oli.Product__r.RecordType.Name == PRODUCT_RECORD_TYPE_NAME_DISCOUNT) {
                                                                                             discountOLIList.add(oli);
                                                                                         }else{
                                                                                             oliList.add(oli);
                                                                                         } 
                                                                                     }
                                                                                     if(discountOLIList.size() > 0){
                                                                                         oliList.addAll(discountOLIList);
                                                                                     }
                                                                                     htmlBody += '<table cellspacing="0" style="border:1px solid #000">';
                                                                                     htmlBody += '<tr style="border:1px solid #000">'; htmlBody += '<th style="border:1px solid #000">Order Line ';
                                                                                     htmlBody += '</th><th style="border:1px solid #000">Product Name';  htmlBody += '</th><th style="border:1px solid #000">Product Description</th>';
                                                                                     htmlBody += '<th style="border:1px solid #000">Brand</th>'; htmlBody += '<th style="border:1px solid #000">Total Qty</th>';
                                                                                     //htmlBody += '<th style="border:1px solid #000">Type</th>';
                                                                                     htmlBody += '<th style="border:1px solid #000">Unit Price</th>';htmlBody += '<th style="border:1px solid #000">Unit Excise Tax</th>';htmlBody += '<th style="border:1px solid #000">Product Price</th>';
                                                                                     htmlBody += '<th style="border:1px solid #000">Total Excise Tax</th>';htmlBody += '<th style="border:1px solid #000">Total Quoted Price</th>';
                                                                                     htmlBody += '</tr> ';
                                                                                     if(oliList.size()>0){
                                                                                         for(Order_Line_Item__c oli : oliList){
                                                                                             htmlBody += '<tr style="border:1px solid #000">';
                                                                                             htmlBody += '<td style="border:1px solid #000;font-size: 11px;">'+oli.Name+'</td>';
                                                                                             htmlBody += '<td style="border:1px solid #000;font-size: 11px;">'+oli.Product__r.Product_Short_Description__c+'</td>';
                                                                                             htmlBody += '<td style="border:1px solid #000;font-size: 11px;">'+oli.Product__r.Description+'</td>';    
                                                                                             htmlBody += '<td style="border:1px solid #000;font-size: 11px;">'+oli.Product__r.Brand_Name__c+'</td>';    
                                                                                             htmlBody += '<td style="border:1px solid #000;font-size: 11px;">'+oli.Line_Total_Qty__c+'</td>';    
                                                                                             
                                                                                             htmlBody += '<td style="border:1px solid #000;text-align: left;font-size: 11px;">';
                                                                                             
                                                                                             if(oli.Product__r.Family == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                                                                                                 htmlBody += '($'+oli.UnitPrice__c+')';
                                                                                             else
                                                                                                 htmlBody += '$'+oli.UnitPrice__c;
                                                                                             
                                                                                             htmlBody += '</td>';    
                                                                                             htmlBody += '<td style="border: 1px solid #000; text-align: left;font-size: 11px;">$'+oli.Unit_Excise_Tax__c+'</td>';
                                                                                             htmlBody += '<td style="border: 1px solid #000; text-align: left;font-size: 11px;">';
                                                                                             if(oli.Product__r.Family == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                                                                                                 htmlBody += '($'+oli.Line_Total_Cost__c+')';
                                                                                             else
                                                                                                 htmlBody += '$'+oli.Line_Total_Cost__c;
                                                                                             htmlBody += '</td>';
                                                                                             htmlBody += '<td style="border: 1px solid #000; text-align: left;font-size: 11px;">$'+oli.Line_Total_Excise_Tax__c+'</td>';
                                                                                             htmlBody += '<td style="border: 1px solid #000; text-align: left;font-size: 11px;">';
                                                                                             if(oli.Product__r.Family == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                                                                                                 htmlBody += '($'+oli.Total__c+')';
                                                                                             else
                                                                                                 htmlBody += '$'+oli.Total__c;
                                                                                             htmlBody += '</td></tr>'; 
                                                                                         }
                                                                                     }
                                                                                     htmlBody += '</table>';htmlBody += '<br/><br/> Thank you, <br/><br/>';htmlBody += 'The WOVN Scheduling Team';
                                                                                 }
																				 
                                                                                 
                                                                                 List<String> listOfToAddresses = new List<String>();
                                                                                 List<String> listOfBCCAddresses = new List<String>();
                                                                                 listOfToAddresses.add(ord.Retailer_Contact__r.email);
                                                                                 if(orgWide != null) mail.setOrgWideEmailAddressId(orgWide.Id);
                                                                                 mail.setHtmlBody(htmlBody);
                                                                                 List<String> ccEmails = DL_ASR.split(',');//label.DL_ASR
                                                                                 for(Retailer_Related_Contact__c rrc: ord.Retailer_Related_Contacts__r){
                                                                                   
                                                                                         listOfToAddresses.add(rrc.Contact__r.Email);
                                                                                       
                                                                                 }
                                                                                 if( ord.Customer__c != null && ord.Customer__r.Email != null){ 
                                                                                     ccEmails.add(ord.Customer__r.Email);
                                                                                 }
                                                                                 if(ord.Additional_Brand_Contact__c != null){
                                                                                     if(ord.Additional_Brand_Contact__r.Email != null) 
                                                                                         ccEmails.add(ord.Additional_Brand_Contact__r.Email);
                                                                                 }
                                                                                 if(ord.Sales_Person__c  != null && ord.Sales_Person__r.Email != null && ord.Sales_Person__r.Orders_Email_Opt_In__c == true  && ord.Sales_Person__r.Active__c == true){
                                                                                     ccEmails.add(ord.Sales_Person__r.Email);
                                                                                 }
                                                                                 
                                                                                 if(doc.size() >0 && !ord.IsRescheduled__c){
                                                                                     //Create Email file attachment from document
                                                                                     Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
                                                                                     attach.setContentType(doc[0].ContentType);
                                                                                     attach.setFileName(doc[0].DeveloperName+'.'+doc[0].Type);
                                                                                     attach.setInline(false);
                                                                                     attach.Body = doc[0].Body;
                                                                                     
                                                                                     mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });//Set File Attachment                                                                                     
                                                                                 }
                                                                                 ccEmails.addAll(Label.Orders_Filigreen_Email.split(','));
                                                                               
                                                                                 mail.setCcAddresses(ccEmails); 
                                                                                 mail.setSaveAsActivity(false);
                                                                                 mail.setToAddresses(listOfToAddresses); 
                                                                                 mails.add(mail);
                                                                                 if(ord.IsRescheduled__c){
                                                                                     ord.IsRescheduled__c = False;
                                                                                     updateOrderForRescheduleAgain.add(ord);
                                                                                 }
                                                                             }
                            }
        if(mails.size() > 0){
            Messaging.sendEmail(mails);
        }
        if(updateOrderForRescheduleAgain.size() > 0 ){
            update updateOrderForRescheduleAgain;
        }
    }*/
    
    public static void updateOrderSubmitDate(list<Order__c>newList,Map<Id,Order__c> oldMap){
        
        List<string>holidayList = new List<string>();
        for(Holiday  businessHolidDay : [SELECT IsRecurrence,ActivityDate,RecurrenceMonthOfYear,RecurrenceEndDateOnly,RecurrenceInstance,RecurrenceDayOfWeekMask,RecurrenceInterval,RecurrenceType FROM Holiday]){
            if(businessHolidDay.IsRecurrence){
            	holidayList.addAll(getAllRecurrenceHoliday(businessHolidDay));
            }else{
            	holidayList.add(String.valueOf(businessHolidDay.ActivityDate));   
            }    
        }
        
        for(Order__c ord : newList){
            if(ord.Status__c == STATUS_PENDING && (Trigger.isInsert ||(Trigger.isUpdate &&ord.Status__c != oldMap.get(ord.Id).Status__c))){
                ord.Order_submitted_Date__c = system.now();
                Integer addHour = 48;
                for(Integer i =0;true;i++){
                    if(OrderHelper.checkifItisWorkingDay(ord.Order_submitted_Date__c.addHours(addHour).Date(),holidayList)){
                		ord.Order_Submit_After_48_Hours__c = ord.Order_submitted_Date__c.addHours(addHour);
                        break;
                	} 
                    addHour += 24;
                }
                addHour = 24;
                for(Integer i =0;true;i++){
                    if(OrderHelper.checkifItisWorkingDay(ord.Order_Submit_After_48_Hours__c.addHours(addHour).Date(),holidayList)){
                        ord.Order_Submit_After_72_Hours__c = ord.Order_Submit_After_48_Hours__c.addHours(addHour);
                        break;
                    }
                    addHour += 24;
                }
            }   
        }
    }
    
    public static boolean checkifItisWorkingDay(Date currentDate,List<String> holidays){
        Date weekStart  = currentDate.toStartofWeek();
        for(String hDay : holidays){
            if(currentDate.daysBetween(Date.valueOf(hDay)) == 0){
                return false;
            }
        }
        if(weekStart.daysBetween(currentDate) ==0 || weekStart.daysBetween(currentDate) == 6){
            return false;
        } else
            return true;
    }
    
    Public  static integer getMonthNumber(string monthName){
        if(monthName == JANUARY_MONTH){
            return 1;
        }else if(monthName == FEBRUARY_MONTH){
            return 2;
        }else if(monthName == MARCH_MONTH){
            return 3;
        }else if(monthName == APRIL_MONTH){
            return 4;
        }else if(monthName == MAY_MONTH){
            return 5;
        }else if(monthName == JUNE_MONTH){
            return 6;
        }else if(monthName == JULY_MONTH){
            return 7;
        }else if(monthName == AUGUST_MONTH){
            return 8;
        }else if(monthName == SEPTEMBER_MONTH){
            return 9;
        }else if(monthName == OCTOBER_MONTH){
            return 10;
        }else if(monthName == NOVEMBER_MONTH){
            return 11;
        }else if(monthName == DECEMBER_MONTH){
            return 12;
        }return 1;
    }
    
    Public  static Date getHolidayDate(Date todayDt,Holiday businessHolidDay){
        if(businessHolidDay.RecurrenceDayOfWeekMask == 127){
            integer year = todayDt.year();
            integer month = getMonthNumber(businessHolidDay.RecurrenceMonthOfYear);
            integer day = 0;
            if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_FIRST){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_SECOND){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_THIRD){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_FOURTH){
                day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_LAST){
                day = Date.daysInMonth(year, month);  
            } 
            return Date.newInstance(year,month,day);
        }else{
            date dt = todayDt;            
            Date weekDay = todayDt.toStartOfMonth().toStartOfWeek(); 
            
            if(businessHolidDay.RecurrenceDayOfWeekMask == 2)
                weekDay = weekDay.addDays(1);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 4)
                weekDay = weekDay.addDays(2);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 8)
                weekDay = weekDay.addDays(3);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 16)
                weekDay = weekDay.addDays(4);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 32)
                weekDay = weekDay.addDays(5);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 64)
                weekDay = weekDay.addDays(6);  
            
            if((todayDt.month() > 1 && weekDay.month() < todayDt.month()) || (todayDt.month() == 1 && weekDay.month() == 12))
                weekDay = weekDay.addDays(7);
            
            if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_SECOND){
                weekDay = weekDay.addDays(7);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_THIRD){
                weekDay = weekDay.addDays(14);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_FOURTH){
                weekDay = weekDay.addDays(21);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_LAST){
                weekDay = weekDay.addDays(28);        
            }
            
            if((todayDt.month() < 12 && weekDay.month() > todayDt.month()) || (todayDt.month() == 12 && weekDay.month() == 1))
                weekDay = weekDay.addDays(-7);
            return weekDay;
        }
    }
    
    public static list<String> getAllRecurrenceHoliday(Holiday businessHolidDay){
    	List<string>holidayList = new List<string>();
        date todayDt = businessHolidDay.ActivityDate;
        date holidayEndDt = businessHolidDay.RecurrenceEndDateOnly != null ? businessHolidDay.RecurrenceEndDateOnly : system.today();
        
        while(todayDt <= holidayEndDt){
        	if(businessHolidDay.RecurrenceType == RECURSYEARLY){
                todayDt = todayDt.addYears(1);
            }else if(businessHolidDay.RecurrenceType == RECURSYEARLYNTH){
                todayDt = todayDt.addYears(1);
                todayDt = getHolidayDate(todayDt,businessHolidDay);        
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSMONTHLY){
            	todayDt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);
                todayDt = getHolidayDate(todayDt,businessHolidDay);        
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSMONTHLYNTH){
            	date dt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);      
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSWEEKLY){
            	todayDt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);        
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSDAILY){
                todayDt = todayDt.addDays(businessHolidDay.RecurrenceInterval);
            }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSEVERYWEEKDAY){
            	todayDt = todayDt.addDays(1);
            }    
            holidayList.add(String.valueOf(todayDt)/*getDateStr(todayDt)*/);       
        }
        return holidayList;
    }
    
    public static void updateOrderRequestShipDate(list<Order__c>newList,Map<Id,Order__c> oldMap){
        Map<Id,Order__c> odrMap = new Map<Id,Order__c>();
        List<Brand_Quote__c> bqList = new List<Brand_Quote__c>();
        Map<Id,Order__c> updateOrderMap = new Map<Id,Order__c>();
        List<Sales_Order__c> SOList = new List<Sales_Order__c>();
        List<Shipping_Manifest__c> SMList = new List<Shipping_Manifest__c>();
        for(Order__c ord : newList){
            if(ord.Request_Ship_Date__c != null && Trigger.isUpdate && ord.Request_Ship_Date__c != oldMap.get(ord.Id).Request_Ship_Date__c){
                odrMap.put(ord.Id,ord);
            }
          
            if(ord.Request_Ship_Date__c != null && (Trigger.isInsert || (Trigger.isUpdate && oldMap.get(ord.Id).Request_Ship_Date__c == null))){
                ord.Original_Requested_Ship_Date__c = ord.Request_Ship_Date__c;
                 
            }
        }
        if(!odrMap.isEmpty()){
            List<Opportunity> oppList = [SELECT id,Order__c,(SELECT Id,Requested_Ship_Date__c,Previous_Planned_Ship_Date__c,Planned_Ship_Date__c FROM Quotes__r),(SELECT id,Previous_Planned_Ship_Date__c,Planned_Ship_Date__c FROM Sales_Orders__r),(SELECT id,Previous_Planned_Ship_Date__c,Planned_Ship_Transfer_Date__c FROM Shipping_Manifests__r) FROM Opportunity WHERE Order__c IN :odrMap.keySet()];
            if(oppList.size() > 0 ){
                for(Opportunity opp : oppList){
                    if(opp.Quotes__r.size() > 0){
                        for(Brand_Quote__c bq : opp.Quotes__r){
                            bq.Requested_Ship_Date__c = odrMap.get(opp.Order__c).Request_Ship_Date__c;                            bqList.add(bq);
                        }
                    }
                }
            }
        }
        if(bqList.size() > 0 ){
            update bqList;
        }
    }
  
  
    
    public static void checkOppBqExists(list<Order__c>newList,Map<Id,Order__c> oldMap){
        Set<Id> oppIds = new Set<Id>();
        Set<Id> bqIds = new Set<Id>();
        Id orderId = newList[0].Id;
        String orderStatus = newList[0].Status__c;
        if(orderStatus == ORDER_STATUS_CANCELLED_BY_WOVN)  
        {
            List<Opportunity> oppList = [select Id, name , Order__r.Name from Opportunity where Order__c=:orderId AND StageName!=:OPP_STAGENAME_CLOSED_LOST]; 
            for(Opportunity oppRes:oppList)
            {
                oppIds.add(oppRes.Id);
            }
            if(oppIds.size() > 0){
                newList[0].addError(ERROR_OPP_ALREADY_EXISTS);
            }
        }
    }
    
    public static void updateOrderLineStatusToCancel(list<Order__c>newList){
        Id orderId = newList[0].Id;
        String orderStatus = newList[0].Status__c;
        List<Opportunity> oppList = [select Id, name , Order__r.Name from Opportunity where Order__c=:orderId AND StageName!=:OPP_STAGENAME_CLOSED_LOST]; 
        if(oppList.size() == 0 && orderStatus == ORDER_STATUS_CANCELLED_BY_WOVN )
        {
            List<Order_Line_Item__c> orderLines = new List<Order_Line_Item__c>();
            for(Order_Line_Item__c orLineObj : [SELECT Order__c,OrderLine_Status__c FROM Order_Line_Item__c  Where Order__c=:orderId]){
                orLineObj.OrderLine_Status__c = ORDER_STATUS_CANCELLED_BY_WOVN; 
                orderLines.add(orLineObj);
            }
            if(orderLines.size() > 0 )
            {
                UPDATE orderLines;
            }
        }
    }

    public static void manageAccountSetting(list<Order__c>newList,Map<Id,Order__c> oldMap){
        Map<String,List<Order__c>> odrMap  = new Map<String,List<Order__c>>();
        set<id> odrIds = new set<id>();
        Integer currentMonth = System.Today().month();
        Integer currentYear = System.Today().year();
        Id orderRecordTypeId = Schema.SObjectType.Order__c.getRecordTypeInfosByName().get(ORDER_RECORD_TYPE_NAME_TRANSFER).getRecordTypeId();
        for(Order__c odr : newList){
            if(odr.Status__c == Order_Status_Shipped && odr.RecordTypeId == orderRecordTypeId && odr.Sample_Order__c == false){
                   odrIds.add(odr.Id);
               }
        }
        if(odrIds.size() > 0){
            for(Order__c o : [SELECT id,Delivered_Date__c,Account__c FROM Order__c WHERE Id IN :odrIds AND  CALENDAR_MONTH(Delivered_Date__c) =:currentMonth AND CALENDAR_YEAR(Delivered_Date__c) =: currentYear AND Status__c =: Order_Status_Shipped AND RecordType.Name =: Order_Type_Transfer AND Account__r.Service_Type__c =:Account_Service_Type_Margin AND Sample_Order__c = false AND (Retailer__r.DBA__c =: Account_DBA_ZASP OR Retailer__r.DBA__c =: Account_DBA_IRR) ]){
                if(odrMap.containsKey(o.Account__c)){
                    odrMap.get(o.Account__c).add(o);
                }else{
                    odrMap.put(o.Account__c,new List<Order__c>{o});
                }
            }
            if(!odrMap.isEmpty()){
                List<Account_Setting__c> accSettingUpdateList = new List<Account_Setting__c>();
                Set<String> alreadyCreatedAccs = new Set<String>();
                List<Account_Setting__c> accSettingList = [SELECT id,Mthly_IB__c,Mthly_OB__c,Account__c FROM Account_Setting__c WHERE Account__c IN :odrMap.keySet()];
                if(accSettingList.size() > 0){
                    for(Account_Setting__c accset : accSettingList){
                        accset.Mthly_OB__c = (accset.Mthly_OB__c != null ? accset.Mthly_OB__c : 0) + odrMap.get(accset.Account__c).size();
                        alreadyCreatedAccs.add(accset.Account__c);
                        accSettingUpdateList.add(accset);
                    }
                }
                for(String accId : odrMap.keySet()){
                    if(!alreadyCreatedAccs.contains(accId)){
                        Account_Setting__c accset = new Account_Setting__c();
                        accset.Account__c = accId;
                        accset.Mthly_OB__c = odrMap.get(accId).size();
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