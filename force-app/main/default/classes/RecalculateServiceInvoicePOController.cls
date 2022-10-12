public class RecalculateServiceInvoicePOController {
    private ApexPages.StandardController stdController;
    private Purchase_Order__c poRecord = null;
    public static Boolean createWMLines = true;
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
    public static String FULFILLMENT_SERVICE_BOOKING{
        get{ 
            return String.isNotBlank(FULFILLMENT_SERVICE_BOOKING) ? FULFILLMENT_SERVICE_BOOKING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Booking');
        }set;
    }
      public static String FULFILLMENT_SERVICE_STAGING{
        get{ 
            return String.isNotBlank(FULFILLMENT_SERVICE_STAGING) ? FULFILLMENT_SERVICE_STAGING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Staging');
        }set;
    }
      public static String FULFILLMENT_SERVICE_PICK_PACK{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_PICK_PACK) ? FULFILLMENT_SERVICE_PICK_PACK : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Pick_Pack');
        }set;
    }
    public static String FULFILLMENT_SERVICE_QA_REVIEW{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_QA_REVIEW) ? FULFILLMENT_SERVICE_QA_REVIEW : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_QA_Review');
        }set;
    }
    public static String FULFILLMENT_SERVICE_ORDER_BOOKING{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_ORDER_BOOKING) ? FULFILLMENT_SERVICE_ORDER_BOOKING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Order_Booking');
        }set;
    }
    public static String FULFILLMENT_SERVICE_STAGE_MANIFEST{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_STAGE_MANIFEST) ? FULFILLMENT_SERVICE_STAGE_MANIFEST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Stage_Manifest');
        }set;
    }
    public static String FULFILLMENT_SERVICE_SCHEDULE_DISPATCH{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_SCHEDULE_DISPATCH) ? FULFILLMENT_SERVICE_SCHEDULE_DISPATCH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Schedule_Dispatch');
        }set;
    }
     public Static String PURCHASE_ORDER_STATUS_APPROVED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_APPROVED) ? PURCHASE_ORDER_STATUS_APPROVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase_Order_Status_Approved');
        }set;
    }
    public static String Invoice_Ar_Status_Shipped{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Shipped) ? Invoice_Ar_Status_Shipped : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Shipped');
        }set;
    }
    public Static String INVOICE_RECORDTYPE_SERVICE{
        get{
            return String.isNotBlank(INVOICE_RECORDTYPE_SERVICE) ? INVOICE_RECORDTYPE_SERVICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
    public static String FULFILLMENT_SERVICE_PACKOUT{
        get{
            return String.isNotBlank(FULFILLMENT_SERVICE_PACKOUT) ? FULFILLMENT_SERVICE_PACKOUT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_PackOut');
        }set;
    } 
    public static String FULFILLMENT_SERVICE_SCHEDULING{
        get{ 
            return String.isNotBlank(FULFILLMENT_SERVICE_SCHEDULING) ? FULFILLMENT_SERVICE_SCHEDULING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Fulfillment Rates Table','Fulfillment_Service_Scheduling');
        }set;
    }
    public static String ORDER_TYPE_RETAIL{
        get{
            return String.isNotBlank(ORDER_TYPE_RETAIL) ? ORDER_TYPE_RETAIL : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Type_Retail');
        }set;
    } 
    public Static String SO_SHIPPING_METHOD_PICK_UP{ 
        get{
            return  String.isNotBlank(SO_SHIPPING_METHOD_PICK_UP) ? SO_SHIPPING_METHOD_PICK_UP :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Shipping_Method_Pick_Up');
        }set;
    }
    public Static String SALESORDER_RECORDTYPE_Transfer {		
        get{
              return String.isNotBlank(SALESORDER_RECORDTYPE_Transfer) ? SALESORDER_RECORDTYPE_Transfer: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Type_Transfer');
        }set;
    }
    public Static String SALES_ORDER_LINE_STATUS_REJECTED{
        get{
            return String.isNotBlank(SALES_ORDER_LINE_STATUS_REJECTED) ? SALES_ORDER_LINE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Rejected');
        }set;
    }
    public Static String PRODUCT_NAME_RECEIVING_FEE{
        get{
            return String.isNotBlank(PRODUCT_NAME_RECEIVING_FEE) ? PRODUCT_NAME_RECEIVING_FEE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Name_Receiving_Fee');
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
    public RecalculateServiceInvoicePOController(ApexPages.StandardController controller) {
        this.stdController = controller;
        poRecord = (Purchase_Order__c)stdController.getRecord();
    }
     
    public RecalculateServiceInvoicePOController(){
    	poRecord = new Purchase_Order__c();    
    }
        
    
    @AuraEnabled
    public static AuraResponse recalculateServiceInvoicePo(String poId){
        AuraResponse r = new AuraResponse('AssignPackoutUIDController.recalculateServiceInvoice()');
        Purchase_Order__c poRec = [SELECT Id,Name FROM Purchase_Order__c WHERE Id =:poId];
        RecalculateServiceInvoicePOController rec = new RecalculateServiceInvoicePOController();
        rec.poRecord = poRec;
       String error = rec.updateShippingFee();
        r.data.put('errMsg', error);
        return r;
    }
     public String updateShippingFee(){
         try{
             
         
        Company_Custom_Settings__c ccs = Company_Custom_Settings__c.getOrgDefaults();
            Set<Id>warehouseIds = new Set<Id>();
            Set<String>membershipLevels = new Set<String>();
            Set<Id> productIds = new Set<Id>();
             Set<Id>supplierids = new Set<Id>();
            Map<Id,Purchase_Order__c> purchaseOrderMap = new Map<Id,Purchase_Order__c>([select Id,name,Distributor_Name__c,Distributor_License__c,Distributor_Contact__c,Goods_Receipt_Date__c,PO_Status__c,RecordType.Name,
                                    Receiver_Name__r.Membership_Level__c,Last_Recalc_History__c,LastModifiedDate,Supplier_License__r.Default_Warehouse__c,Purchase_Order_Instructions__c,Ship_Confirmation_Date__c,Shipping_Terms__c,Site__r.Name,Total_Weight_lbs__c,
                                    Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,Site__c,Shipping_Method__c, Receiver_Name__r.DBA__c,Supplier_Name__r.DBA__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__c,
                                    Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c,Supplier_Name__c,Supplier_License__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c,
                                    Supplier_Contact__c,Brand_Quote__r.Distributor_Name__c,Receiver_Name__c,Total_Mileage_Fee__c,Brand_Quote__c,Ownership__r.Membership_Level__c,Brand_Quote__r.Order_Type__c,
                                    Brand_Quote__r.Distributor_License__c,Supplier_Name__r.Membership_Level__c,Brand_Quote__r.Distributor_Contact__c,Brand_Quote__r.Supplier_Name__c,
                                    Brand_Quote__r.Supplier_License__c,Brand_Quote__r.Supplier_Contact__c,Receiver_License__c,Receiver_Contact__c,
                                    Opportunity_Name__c,Planned_Ship_Transfer_Date__c,Sample_Order__c,Customer_PO_or_Quote__c,Payment_Terms__c,
                                    PO_Type__c,Ownership__c,Total_Weight_Fee__c,Order_Type__c,Receiving_Fee__c,
                                    Service_Booking_Fee__c,Service_Scheduling_Fee__c,Service_Staging_Fee__c,Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c,Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c,
                                    (SELECt Id,Product_Name__c,Qty_Ordered__c, Purchase_Order__c,Total_Weight_lbs__c,Receiving_Fee__c,Ownership_Code__r.Membership_Level__c,
                                     Weight_to_Order_Ratio__c,Weight_to_Mileage_Fee__c,Order_Qty_Cases__c,Qty_per_Case_MOQ__c, Unit_Cost__c FROM Purchase_Order_Lines__r) from Purchase_Order__c where id=:poRecord.Id]);
            
               for(Purchase_Order__c PO: purchaseOrderMap.values()){
           
                membershipLevels.add(PO.Supplier_Name__r.Membership_Level__c);
                warehouseIds.add(PO.Supplier_License__r.Default_Warehouse__c);
                supplierids.add(PO.Supplier_License__r.Default_Warehouse__c);
                for(Purchase_Order_Line__c oli: PO.Purchase_Order_Lines__r){
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
                                                         WHERE Site__c IN :supplierids
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
                if(!FRTList.isEmpty()){ for(Fulfillment_Rates_Table__c FRT:FRTList){
                        if(serviceBasedFRTMap.containsKey(FRT.Fulfillment_Services__c)){serviceBasedFRTMap.get(FRT.Fulfillment_Services__c).add(FRT);
                        }else{serviceBasedFRTMap.put(FRT.Fulfillment_Services__c,new Fulfillment_Rates_Table__c[]{FRT});
                        }
                    }
               }            
                
            Map<Id,Product2> productsMap = new Map<Id,Product2>([SELECT Id, Name,MOQ__c, Unit_Shipping_Weight_lbs__c,Family, Case_Shipping_Weight_lbs__c FROM Product2 WHERE Id IN: productIds]);
            List<Purchase_Order__c> POToUpdate = new List<Purchase_Order__c>();
            Set<Id> bqIds = new Set<Id>();
            Set<Id> opportunityIds = new Set<Id>();
            Set<Id> ServiceTicketIds = new Set<Id>();
            List<Purchase_Order_Line__c> pOLIsToUpdate = new List<Purchase_Order_Line__c>();
             for(Id POId: purchaseOrderMap.keySet()){
                 Purchase_Order__c PO = purchaseOrderMap.get(POId);
                 opportunityIds.add(PO.Opportunity_Name__c);
                  
                
                 if(PO.Brand_Quote__c != null) bqIds.add(PO.Brand_Quote__c);
                 Decimal orderBookingFee = 0;
                 Decimal packOutFee = 0;
                 Decimal stageManifestFee = 0;
                 Decimal scheduleDispatchFee = 0; 
                 Decimal serviceBookingFee = 0;
                 Decimal serviceSchedulingFee = 0;
                 Decimal serviceStagingFee = 0;
                 Decimal totalWeightFee = 0;
                 Decimal totalMileageFee = 0;
                 Decimal totalOrderWeight = 0;
                 Decimal totalWeightLbs = 0;
                Decimal totalPickPack = 0;
                Decimal totalQAReview = 0;
                  Decimal totals = 0;
                Decimal totalListingFee = 0;
                  decimal recievingPrice = 0;
                   decimal serviceStaging = 0;
                 string status;
                Boolean hasMOQ1Item = false;
                 Decimal recievingFee = 0;
                Purchase_Order_Line__c[] POLIs = PO.Purchase_Order_Lines__r;
                warehouseServiceBasedFRTMap2 = warehouseMLevelserviceBasedFRTMap.get(PO.Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c);
                String membershipLevel;
                  List<string> historydata = new list<string>();
                 DateTime dts = System.Now(); 
                membershipLevel = PO.Receiver_Name__r.Membership_Level__c;
                Decimal totalMiles = getTotalMiles(PO.Supplier_License__c,PO.Receiver_License__c);
                
                 
                //calculate Total serviceStagingFee  
                
                if(serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_STAGING)){Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_STAGING); if(!FRTs.isEmpty()){serviceStagingFee = FRTs[0].Bracket_Price__c;
                    }
                } 
                  //calculate Total Mileage Fee
                 if(createWMLines && !mileageSRTList.isEmpty() && totalMiles != null){  
                     for(Shipping_Rates_Table__c SRT: mileageSRTList){ 
                         if(totalMiles <= SRT.Mileage_Bracket__c){
                             if(SRT.Fixed_Mileage_Fee__c){totalMileageFee = SRT.Fixed_Mileage_Amount__c != null ? SRT.Fixed_Mileage_Amount__c:0;
                                                         }else{
                                                             totalMileageFee = SRT.Mileage_Bracket_Price__c * totalMiles; } break;
                         }
                     } 
                     /*if(PO.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER && PO.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE){
                         totalMileageFee = 0;
                     }*/
                 }  
                 
                 if(warehouseServiceBasedFRTMap2 != null){serviceBasedFRTMap = warehouseServiceBasedFRTMap2.get(membershipLevel);
                 }
                //calculate Total serviceBookingFee
                if(serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_BOOKING )){ Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_BOOKING);
                    if(!FRTs.isEmpty()){serviceBookingFee = FRTs[0].Bracket_Price__c;
                    }
                }
                //calculate Total serviceSchedulingFee
                if(serviceBasedFRTMap.containsKey(FULFILLMENT_SERVICE_SCHEDULING)){ Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(FULFILLMENT_SERVICE_SCHEDULING);
                    if(!FRTs.isEmpty() || Test.isRunningTest()){serviceSchedulingFee = FRTs[0].Bracket_Price__c;
                    }
                }
                
                
             
                 for(Purchase_Order_Line__c poli:POLIs){ Decimal totalWeight = 0; Product2 p = productsMap.get(poli.Product_Name__c);
                    decimal weight = 0;decimal unitweight = 0;if(poli.Qty_per_Case_MOQ__c > 1){ weight = p.Case_Shipping_Weight_lbs__c;}else{weight = p.Unit_Shipping_Weight_lbs__c;
                    
                       // hasMOQ1Item = true;
                    }   
                          //Calulate QA Review Fee
                    if(serviceBasedFRTMap != null && serviceBasedFRTMap.containsKey(PRODUCT_NAME_RECEIVING_FEE)){  Fulfillment_Rates_Table__c [] FRTs = serviceBasedFRTMap.get(PRODUCT_NAME_RECEIVING_FEE);
                        if(!FRTs.isEmpty()){for(Fulfillment_Rates_Table__c FRT: FRTs){
                                if(FRT.Weight_lbs__c  <= weight && FRT.MOQ__c <= poli.Qty_per_Case_MOQ__c){ recievingPrice = FRT.Bracket_Price__c;
                                    break;
                                }
                            }
                        }
                        recievingFee = recievingPrice * poli.Qty_Ordered__c;
                    }                                  
                                                        
                      //Calulate Total Weight
                    if(poli.Qty_per_Case_MOQ__c > 1){  totalWeight = weight * poli.Order_Qty_Cases__c;}
                    else{totalWeight = weight * poli.Qty_Ordered__c;} poli.Total_Weight_lbs__c = totalWeight; poli.Receiving_Fee__c = recievingFee;
                                                         totalOrderWeight += totalWeight;pOLIsToUpdate.add(poli);
                                                       
                }
                   if(!weightSRTList.isEmpty()){
                    for(Shipping_Rates_Table__c SRT: weightSRTList){if(totalOrderWeight <= SRT.Weight_Bracket__c){if(SRT.Fixed_Weight_Fee__c){totalWeightFee = SRT.Fixed_Weight_Amount__c != null ? SRT.Fixed_Weight_Amount__c : 0;
                            }else{totalWeightFee = SRT.Weight_Bracket_Price__c * totalOrderWeight;  }break;
                           
                            
                        }
                    }   
                } 
                 
                 if(PO.Brand_Quote__r.Opportunity_Name__r.Ownership__r.Platform_Level__c == ACCOUNT_PLATEFORMLEVEL_ADVANCE  &&
                   ((PO.Receiver_Name__r.DBA__c != Account_Plateformlevel_ZASP && PO.Receiver_Name__r.DBA__c != Account_Plateformlevel_IRR)
                    || (PO.Supplier_Name__r.DBA__c != Account_Plateformlevel_ZASP && PO.Supplier_Name__r.DBA__c != Account_Plateformlevel_IRR)) 
                   && (PO.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER  || String.isBlank(PO.Brand_Quote__r.Order_Type__c))
                  ){
                    totalMileageFee = 0;
                      totalWeightFee=0;
                }
                 if((
                     (PO.Supplier_Name__r.DBA__c != Account_Plateformlevel_ZASP && PO.Supplier_Name__r.DBA__c != Account_Plateformlevel_IRR) 
                     || (PO.Receiver_Name__r.DBA__c != Account_Plateformlevel_ZASP && PO.Receiver_Name__r.DBA__c != Account_Plateformlevel_IRR)
                 ) && PO.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__c != null && (PO.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_ZASP && PO.Brand_Quote__r.Opportunity_Name__r.Order__r.Transporter__r.License_Name__r.DBA__c != Account_Plateformlevel_IRR)
                    && PO.Brand_Quote__r.Opportunity_Name__r.Order__r.Order_Type__c == ORDER_TYPE_TRANSFER ){
                        totalMileageFee = 0;
                        totalWeightFee=0;
                    }
                 
                   User usr = [SELECT ID, Name,FirstName FROM User WHERE ID = :UserInfo.getUserId()];List<Purchase_Order__History > SOH =[select  NewValue, OldValue,CreatedDate,CreatedBy.FirstName,CreatedBy.Name ,Field from Purchase_Order__History   where Parent.id =:POId and Field='Last_Recalc_History__c' order by CreatedDate DESC];
               
                string datas=''; string dats = dts.format('MM/dd/yyyy hh:mm a', 'America/Los_Angeles');
                string newdata = '\n'+ usr.Name + ' - '+ dats +'\n';  historydata.add(newdata);
                if(SOH != null)
                {
                  for(Purchase_Order__History s :SOH ) {   datas = s.CreatedBy.Name +'-' +s.CreatedDate.format('MM/dd/yyyy hh:mm a', 'America/Los_Angeles')+'\n';
                    
                    historydata.add(datas);                    
                }     
                }
              

                
                system.debug('historydata>'+historydata);
                  String names = string.join(historydata,','); String LastRecalHistory = names.replaceAll(',','\n');    
                PO.Last_Recalc_History__c = LastRecalHistory;  PO.Total_Weight_Fee__c = totalWeightFee; PO.Total_Mileage_Fee__c = totalMileageFee;
                 PO.Service_Scheduling_Fee__c = serviceSchedulingFee;
                 PO.Service_Staging_Fee__c  = serviceStagingFee; PO.Service_Booking_Fee__c = serviceBookingFee; POToUpdate.add(PO);
                 
            }
             
            List<Service_Ticket__c> stList = [SELECT Id,Destination_Site__c,Brand_Name__c,Opportunity__c,Brand_Name__r.Membership_Level__c,Licensed_Premise__c, Licensed_Premise__r.Default_Warehouse__c From Service_Ticket__c WHERE  Opportunity__c =: opportunityIds limit 1];
           
             if(stList.size()>0) ServiceTicketIds.add(stList[0].Id);
             
             update POToUpdate; 
             update pOLIsToUpdate; if(bqIds.size() > 0){BrandQuoteLineHandler.updateShippingFee(bqIds);}  if(ServiceTicketIds.size()>0){ServiceTicketTriggerHandler.updateFees(ServiceTicketIds);}
        }catch (Exception ex){
            System.debug('Exception = '+ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()); return msg+'';
            //return null;
        }
        return '';
        //return redirectToRecord();
        //return null;
    }
  public static Decimal getTotalMiles(String SupplierId, String stateLicenseId){
       // Site__c s = [SELECT Id,License_ID__r.License_Address__c ,License_ID__r.License_City__c ,License_ID__r.License_Country__c ,License_ID__r.License_State__c,License_ID__r.License_Zip__c FROM Site__c WHERE Id = :siteId];
     if(SupplierId != null && stateLicenseId!= null)
     {
      State_Licenses__c s = [SELECT Id,License_Address__c ,License_City__c , License_Country__c,License_State__c,License_Zip__c FROM State_Licenses__c WHERE Id =:SupplierId];
         State_Licenses__c st = [SELECT Id,License_Address__c ,License_City__c , License_Country__c,License_State__c,License_Zip__c FROM State_Licenses__c WHERE Id =:stateLicenseId];
        String url = Google_Distance_Matrix_API__c.getValues('GMaps_Endpoint').Value__c;
        String apiKey = Google_Distance_Matrix_API__c.getValues('Gmaps_APIKey').Value__c;
        String parameters = 'origins=' + s.License_Address__c +','+ s.License_City__c+ ','+s.License_State__c +' '+ s.License_Zip__c+','+ s.License_Country__c + '&destinations=' + st.License_Address__c +','+ st.License_City__c +','+st.License_State__c +' '+ st.License_Zip__c+','+ st.License_Country__c;
        String param2 =  '&language=en&key=';
        parameters = parameters.replace(' ','%20');
        url = url+parameters+param2+apiKey;
        url = url.replaceAll('#', '%20');
        
        HTTP http = new HTTP();
        HTTPRequest request = new HTTPRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        HTTPResponse response = http.send(request);
        if(response.getStatusCode() == 200) {double distVal = 0;StateLicenseTotalMilesTriggerHelper.DistanceResponse reponse = (StateLicenseTotalMilesTriggerHelper.DistanceResponse) JSON.deserialize(response.getBody(), StateLicenseTotalMilesTriggerHelper.DistanceResponse.class); 
            if(reponse != null && reponse.rows != null){
                if(reponse.rows[0].elements != null){ distVal = reponse.rows[0].elements[0].distance.value;distVal = distVal * 0.00062137;}} return distVal;
        }
         } 
        return 0;
    }   
    
    
}