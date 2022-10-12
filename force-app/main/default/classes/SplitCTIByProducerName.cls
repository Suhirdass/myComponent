public class SplitCTIByProducerName {
        public static String PAYMENT_TERMS_COD = 'COD';
     private Static String INVOICE_LINE_RECORDTYPE_SERVICE { 
        get{
            return  String.isNotBlank(INVOICE_LINE_RECORDTYPE_SERVICE) ? INVOICE_LINE_RECORDTYPE_SERVICE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice Line','Invoice_Line_RecordType_Service');
        }set;
    }
    private Static String INVOICE_RECORDTYPE_SERVICE { 
        get{
            return  String.isNotBlank(INVOICE_RECORDTYPE_SERVICE) ? INVOICE_RECORDTYPE_SERVICE :  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
     public Static String ERR_SELECT_SOLINE_TO_CREATE_SERVICE_INVOICE {
        get{
            return String.isNotBlank(ERR_SELECT_SOLINE_TO_CREATE_SERVICE_INVOICE) ? ERR_SELECT_SOLINE_TO_CREATE_SERVICE_INVOICE:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Err_Select_SOLine_to_create_Ser_Invoice');
        }set;
    }
      private static String SO_Status_Draft{
        get{
            return String.isNotBlank(SO_Status_Draft) ? SO_Status_Draft : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Draft');
        }set;
    }
     private Static String SALES_ORDER_LINE_STATUS_REJECTED{
        get{
            return String.isNotBlank(SALES_ORDER_LINE_STATUS_REJECTED) ? SALES_ORDER_LINE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Rejected');
        }set;
    }
    private static String SO_Status_Cancelled{
        get{
            return String.isNotBlank(SO_Status_Cancelled) ? SO_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Cancelled');
        }set;
    }
     private static String STATE_LICENSE_ACTIVE{
        get{
            return String.isNotBlank(STATE_LICENSE_ACTIVE) ? STATE_LICENSE_ACTIVE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_Active');
        }set;
    }
    private static String SO_Status_Rejected{
        get{
            return String.isNotBlank(SO_Status_Rejected) ? SO_Status_Rejected : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Rejected');
        }set;
    }
    public static String Sales_Order_Status_Approved{
        get{
            return String.isNotBlank(Sales_Order_Status_Approved) ? Sales_Order_Status_Approved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Approved');
        }set;
    }
    public static String Sales_Order_Line_Status_Cancelled{
        get{
            return String.isNotBlank(Sales_Order_Line_Status_Cancelled) ? Sales_Order_Line_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Cancelled');
        }set;
    }
    public static String Sales_Order_Line_Status_Open{
        get{
            return String.isNotBlank(Sales_Order_Line_Status_Open) ? Sales_Order_Line_Status_Open : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Open');
        }set;
    }
    public static String Label_Not_For_Resale_Product{
        get{
            return String.isNotBlank(Label_Not_For_Resale_Product) ? Label_Not_For_Resale_Product : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Label_Not_For_Resale_Product');
        }set;
    }
    public static String Sample_Product_Price{
        get{
            return String.isNotBlank(Sample_Product_Price) ? Sample_Product_Price : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Sample_Product_Price');
        }set;
    }
     public static String Invoice_Ar_Status_Approved{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Approved) ? Invoice_Ar_Status_Approved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Approved');
        }set;
    }
    public static String Invoice_Ar_Status_Shipped{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Shipped) ? Invoice_Ar_Status_Shipped : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Shipped');
        }set;
    }
    public static String Invoice_Record_Type_Tax{
        get{
            return String.isNotBlank(Invoice_Record_Type_Tax) ? Invoice_Record_Type_Tax : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Tax Protected');
        }set;
    }
    public static String ErrMsgSubmitSOForApprovalToCreateCTI{
        get{
            return String.isNotBlank(ErrMsgSubmitSOForApprovalToCreateCTI) ? ErrMsgSubmitSOForApprovalToCreateCTI : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','ErrMsgSubmitSOForApprovalToCreateCTI');
        }set;
    }
    public static String ErrMsgCan_tCreateCTIForCancelledSO{
        get{
            return String.isNotBlank(ErrMsgCan_tCreateCTIForCancelledSO) ? ErrMsgCan_tCreateCTIForCancelledSO : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','ErrMsgCan_tCreateCTIForCancelledSO');
        }set;
    }
    public static String ErrMsgCan_tCreateCTIForRejectedSO{
        get{
            return String.isNotBlank(ErrMsgCan_tCreateCTIForRejectedSO) ? ErrMsgCan_tCreateCTIForRejectedSO : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','ErrMsgCan_tCreateCTIForRejectedSO');
        }set;
    }
    public static String ErrMsgCTIAlreadyCreated{
        get{
            return String.isNotBlank(ErrMsgCTIAlreadyCreated) ? ErrMsgCTIAlreadyCreated : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','ErrMsgCTIAlreadyCreated');
        }set;
    }
    public static String ErrMsgCan_tCreateCTIForNonApproved{
        get{
            return String.isNotBlank(ErrMsgCan_tCreateCTIForNonApproved) ? ErrMsgCan_tCreateCTIForNonApproved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','ErrMsgCan_tCreateCTIForNonApproved');
        }set;
    }
    public static String ErrMsgBillableCultivationTaxIP{
        get{
            return String.isNotBlank(ErrMsgBillableCultivationTaxIP) ? ErrMsgBillableCultivationTaxIP : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','ErrMsgBillableCultivationTaxIP');
        }set;
    }
    public static String Success_Msg_CTI_Created{
        get{
            return String.isNotBlank(Success_Msg_CTI_Created) ? Success_Msg_CTI_Created : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Success_Msg_CTI_Created');
        }set;
    }
  
   
    public Static String STATUS_SALESORDERLINECANCELLED{
        get{
            return String.isNotBlank(STATUS_SALESORDERLINECANCELLED) ? STATUS_SALESORDERLINECANCELLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SalesOrderLines_Cancelled');
        }set;
    }
      public static String PRODUCT_RECORD_TYPE_NAME_PRODUCT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_PRODUCT) ? PRODUCT_RECORD_TYPE_NAME_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Name_Product');
        }set;
    }
      @AuraEnabled
    public static AuraResponse getSalesOrderDetails(String recordId){
        AuraResponse r = new AuraResponse('ReceivingServiceInvoiceCtlr.getSalesOrderDetails()');
        try{
            Sales_Order__c statusSO = [select id, SO_Status__c, (Select id from Sales_Order_Lines__r where Status__c =: 
			Sales_Order_Line_Status_Open limit 1), (Select id from Invoices__r where Recordtype.Name =: 
			Invoice_Record_Type_Tax AND (AR_Status__c =: Invoice_Ar_Status_Approved or AR_Status__c =: 
			Invoice_Ar_Status_Shipped) Limit 1) from Sales_Order__c where Id  =: recordId];   
        Boolean hasBillableCultivationTax = true;
        for(Sales_Order_Line__c sol : [select id,Product_Name__r.Licensee_Name__c, (Select Id From Inventory_Positions__r where Billable_Cultivation_Tax__c = 'Yes') 
				from Sales_Order_Line__c where Sales_Order__c =: recordId and Status__c !=: Sales_Order_Line_Status_Cancelled AND  
				(Product_Name__r.Auto_Allocation__c = FALSE OR (Product_Name__r.Auto_Allocation__c = TRUE AND 
				Product_Name__r.Apply_Cultivation_Tax__c = 'Yes' ))]){
			if(sol.Inventory_Positions__r.size() > 0)	
                hasBillableCultivationTax = false;
		}
       
        
        if(statusSO.SO_Status__c == SO_Status_Draft){
            r.data.put('statusSOerror',ErrMsgSubmitSOForApprovalToCreateCTI);
             r.data.put('recordId',recordId);
        }else if(statusSO.SO_Status__c == SO_Status_Cancelled){
            r.data.put('statusSOerror',ErrMsgCan_tCreateCTIForCancelledSO);
            r.data.put('recordId',recordId);
        }else if(statusSO.SO_Status__c == SO_Status_Rejected){
            r.data.put('statusSOerror', ErrMsgCan_tCreateCTIForRejectedSO);
           r.data.put('recordId',recordId);
        }else{
           
            Sales_Order__c salesOrder = getSalesOrder(recordId);
            Map<String,List<Sales_Order_Line__c>>ProducerDetailsMap = new Map<String,List<Sales_Order_Line__c>>();
            List<ProducerDetails>ProducerDetailsList = new List<ProducerDetails>();
            if(salesOrder.Sales_Order_Lines__r.size() > 0){
                for(Sales_Order_Line__c SOL: salesOrder.Sales_Order_Lines__r){
                    list<Sales_Order_Line__c> sList = new List<Sales_Order_Line__c>();
                    
                    if(SOL.Product_Name__r.White_Labelled__c && SOL.Product_Name__r.Licensee_Name__c != null){
                        if(ProducerDetailsMap.containsKey(SOL.Product_Name__r.Licensee_Name__c))
                            sList = ProducerDetailsMap.get(SOL.Product_Name__r.Licensee_Name__c);
                    } else {
                        if(SOL.Product_Name__r.Producer_Name__c != null && ProducerDetailsMap.containsKey(SOL.Product_Name__r.Producer_Name__c))
                            sList = ProducerDetailsMap.get(SOL.Product_Name__r.Producer_Name__c);
                    }
                    sList.add(SOL);
                    if(SOL.Product_Name__r.White_Labelled__c){
                        ProducerDetailsMap.put(SOL.Product_Name__r.Licensee_Name__c,sList);
                    } else {
                        ProducerDetailsMap.put(SOL.Product_Name__r.Producer_Name__c,sList);
                    }
                }
                for(string str : ProducerDetailsMap.keySet()){
                    list<Sales_Order_Line__c>sList = ProducerDetailsMap.get(str);
                    SOLineDetails SD = new SOLineDetails(sList[0]);
                    ProducerDetails PD;
                    if(sList[0].Product_Name__r.White_Labelled__c){
                        PD = new ProducerDetails(str,sList[0].Product_Name__r.Licensee_Name__r.Name,sList.size(),SD); 
                    } else {
                        PD = new ProducerDetails(str,sList[0].Product_Name__r.Producer_Name__r.Name,sList.size(),SD); 
                    }
                    
                    ProducerDetailsList.add(PD);
                    for(Integer i=1;i<sList.size();i++){
                        SOLineDetails SD1 = new SOLineDetails(sList[i]);  
                        ProducerDetails PD1 = new ProducerDetails(str,'',0,SD1); 
                        ProducerDetailsList.add(PD1);
                    }
                }
            }
            r.data.put('salesOrder',salesOrder);
            r.data.put('producerSOLines',ProducerDetailsList);
                    }   
         r.data.put('recordId',recordId);
            
        }catch(Exception e){
            r.data.put('Error',e.getMessage());
        }
        return r;
    }
     public static Sales_Order__c getSalesOrder(String recordId){
         
        return [SELECT Name,Brand_Quote__c,Distributor_Contact__c,Distributor_License__c,SO_Status__c, Brand_Quote__r.Opportunity_Name__c,Brand_Quote__r.Site__c,
                Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Total_Miles__c, Brand_Quote__r.Opportunity_Name__r.Order__r.Customer__r.ContactId,
                Brand_Quote__r.Planned_Transfer_Date__c,Brand_Quote__r.Opportunity_Name__r.Order__r.State_License__r.Default_Warehouse__c,
                Brand_Quote__r.Payment_Terms__c,Brand_Quote__r.Ownership__c,Brand_Quote__r.RecordTypeId,Brand_Quote__r.RecordType.Name,Distributor_Name__c,Distributor_DBA__c,Customer_PO_or_Quote__c,Payment_Terms__c,SO_Type__c,
                Opportunity_Name__r.Name,Retailer_PO__c,Factoring_Contact__c, Planned_Ship_Date__c, Receiver_Name__r.Payment_Terms__c,
                Receiver_Contact__c,Receiver_License__c,Receiver_Name__c,Receiver_DBA__c,SO_Date__c,Receiver_Name__r.Name,
                Sales_Order_Instructions__c,Ship_Confirmation_Date__c,Factoring_Assignee__c,
                Total_Price__c,Factoring_Rate__c,Sample_Order__c,Shipping_Method__c,Shipping_Terms__c,
                Site__r.Name,Site__r.Warehouse_Name__c,Total_Line_Items__c,Supplier_Contact__c,
                Supplier_License__c,Supplier_Name__c,Supplier_DBA__c,Allocated__c,RecordTypeId,
                Ownership__c,Ownership__r.Type,RecordType.Name,Opportunity_Name__c,Id,Site__c,Order_Booking_Fee__c,
                Pack_Out_Fee__c,Schedule_Dispatch_Fee__c,Stage_Manifest_Fee__c,Total_Mileage_Fee__c,Total_Weight_Fee__c,
                Supplier_Name__r.Membership_Level__c,Order_Type__c,Receiver_Name__r.Membership_Level__c,Change_Order_Fee__c,
                (SELECT Name,Arrival_Date__c,Brand_Quote_Line__c,Product_Name__c,Qty_To_Invoiced__c,Brand_Quote_Line__r.Retail_Wholesale_Price__c,
                 Brand_Quote_Line__r.Product_Name__c,Brand_Quote_Line__r.Product_Title__c,Brand_Quote_Line__r.Line_Total_Qty__c,Brand_Quote_Line__r.Is_Sample__c,
                 Product_Name__r.Producer_Name__c,Product_Name__r.Producer_Name__r.Type,Product_Name__r.Producer_Name__r.Name,Is_Sample__c,Product_Name__r.Licensee_Name__c,Product_Name__r.Licensee_Name__r.Type, 
                 Product_Name__r.Name,Product_Name__r.White_Labelled__c,Product_Title__c,Product_Description__c,Promised_Date__c,
                 Producer_Name__c, MOQ__c,Qty_Ordered__c,Qty_Invoiced__c,Quantity_Cases__c,Product_Name__r.Licensee_Name__r.Name,
                 Request_Date__c,Retail_Wholesale_Price__c,Line_Total_Price__c,Sales_Order__c,
                 Ownership_Code__c,Status__c,RecordType.Name,Id,Pick_Pack_Fee__c,QA_Review_Fee__c,
                 Total_Weight_lbs__c, Pack_Out_Fee__c ,UID__c, Weight_to_Mileage_Fee__c , Weight_to_Order_Fee__c, Listing_Fee__c  
                 FROM Sales_Order_Lines__r WHERE Status__c NOT IN (:SALES_ORDER_LINE_STATUS_REJECTED,:STATUS_SALESORDERLINECANCELLED) AND Product_Name__r.RecordType.Name =: PRODUCT_RECORD_TYPE_NAME_PRODUCT ORDER BY Name)
                FROM Sales_Order__c 
                WHERE Id =: recordId];
        
         
         
    }
 
    
      @AuraEnabled
    public static AuraResponse createInvoices(String recordId, String salesOrderLineData,Boolean multi){
         system.debug('salesOrderLineData>>'+salesOrderLineData);
        AuraResponse r = new AuraResponse('FullfullmentServiceInvoiceController.createInvoices()');//ReceivingServiceInvoiceCtlr
    //    Set<String> serviceFeeProductSet = new Set<String>{PRODUCT_NAME_MILEAGE_FEE,PRODUCT_NAME_PICK_AND_PACK_FEE,PRODUCT_NAME_QA_REVIEW_FEE,PRODUCT_NAME_ORDER_BOOKING,PRODUCT_NAME_PACK_OUT,PRODUCT_NAME_WEIGHT_FEE,PRODUCT_NAME_SCHEDULE_AND_DISPATCH,PRODUCT_NAME_STAGE_AND_MANIFEST,PRODUCT_NAME_CHANGE_ORDER_FEE,PRODUCT_NAME_LISTING_FEE,PRODUCT_NAME_AGENT_FEE,PRODUCT_NAME_DISTRIBUTION_FEE};
           Savepoint sp;        
        try{
             Sales_Order__c sOrder = getSalesOrder(recordId);
            system.debug('sOrder'+sOrder);
           sp = Database.setSavepoint();
    
             List<Sales_Order_Line__c> soLinesQuery= [select id,name,Sales_Order__c,Product_Name__r.White_Labelled__c,Product_Name__r.Licensee_Name__c,Qty_To_Invoiced__c,Product_Name__r.Producer_Name__c,Product_Name__c,Sales_Order__r.Ownership__c,Producer_Name__c,Product_Name__r.Name,
				Product_Title__c,Qty_Ordered__c,Promised_Date__c,Ownership_Code__c,Ownership_Code__r.Payment_Terms__c, (Select Id, Unit_Cultivation_Tax__c,Ownership__c,Product_Name__c,
				Unit_Cannabis_Weight__c,Billable_Cultivation_Tax__c,Receiving_Line__r.Purchase_Order_Line__c,Harvest_Batch_Code__c,Inventory_Qty__c,Product_Name__r.Producer_Name__c
				From Inventory_Positions__r where Billable_Cultivation_Tax__c = 'Yes') from Sales_Order_Line__c where 
				Sales_Order__c =: recordId and Status__c !=: Sales_Order_Line_Status_Cancelled AND  
				(Product_Name__r.Auto_Allocation__c = FALSE OR (Product_Name__r.Auto_Allocation__c = TRUE AND 
				Product_Name__r.Apply_Cultivation_Tax__c = 'Yes' ))];
            
            List<ProducerDetails> ProducerDetailsList = (List<ProducerDetails>)JSON.deserialize(salesOrderLineData, List<ProducerDetails>.class);  
            system.debug('ProducerDetailsList>>'+ProducerDetailsList);
            //Map<Invoice__c,List<Invoice_Line__c>>invoiceList = new Map<Invoice__c,List<Invoice_Line__c>>();
            Map<String,Invoice__c>newInvoiceMap = new Map<String,Invoice__c>();
            Map<String,List<Invoice_Line__c>>invoiceLineMap = new Map<String,List<Invoice_Line__c>>();
            Map<String,Purchase_Order__c>newPOMap = new Map<String,Purchase_Order__c>();
            Map<String,List<Purchase_Order_Line__c>>POLineMap = new Map<String,List<Purchase_Order_Line__c>>();
            integer i=0;
            Map<String,ProducerDetails[]> ProducerDetailsMap = new Map<String,ProducerDetails[]>();
            for(ProducerDetails PD : ProducerDetailsList){
                if(ProducerDetailsMap.containsKey(PD.producerId)){
                    ProducerDetailsMap.get(PD.producerId).add(PD);
                }else{
                    ProducerDetailsMap.put(PD.producerId,new ProducerDetails[]{PD});
                }
            }
            for(Id producerId : ProducerDetailsMap.keySet()){
                ProducerDetails[] lines = ProducerDetailsMap.get(producerId);
                Boolean isProducerSelected = false;
                for(ProducerDetails line: lines){
                    if(line.isSelected){
                        isProducerSelected = true;
                        break;
                    }
                }
                if(isProducerSelected){
                    for(ProducerDetails line: lines){
                        line.isSelected = true;
                    }
                }
                
            }
            Map<String,Sales_Order_Line__c[]> producerSOLinesMap = new Map<String,Sales_Order_Line__c[]>();
            for(ProducerDetails PD : ProducerDetailsList){
                System.debug('##PD::'+PD.producerId);
                System.debug('##PD Selected::'+PD.isSelected);
                if(PD.isSelected){
                    if(producerSOLinesMap.containsKey(PD.producerId)){
                        producerSOLinesMap.get(PD.producerId).add(PD.SOLine.SOLine);
                    }else{
                        producerSOLinesMap.put(PD.producerId , new List<Sales_Order_Line__c>{PD.SOLine.SOLine});
                    }
                }
            }
              Set<String> producerIds = producerSOLinesMap.keySet();
            if(multi== False || producerIds.size()==1)
           {
               r = FullfullmentServiceInvoiceController.createCultivationTaxInvoice(recordId);
           }
            else{
                
            
            
          
           
            Map<Id,Account> producerMap = new Map<Id,Account>([SELECT Id, Name, (SELECT Id FROM State_Licenses__r WHERE License_Status__c  = :STATE_LICENSE_ACTIVE),(SELECT Id FROM Contacts WHERE Active__c = true Order By Name) FROM Account WHERE Id IN :producerIds]);
           
            for(String producerId : producerSOLinesMap.keySet()){
                List<Invoice_Line__c> invoiceLines = new List<Invoice_Line__c>();
                Sales_Order_Line__c[] SOLines = producerSOLinesMap.get(producerId);
                Company_Custom_Settings__c companySettingRec = Company_Custom_Settings__c.getOrgDefaults();
                Invoice__c newInvoice = createProducerInvoice(sOrder,producerId);
                system.debug('newInvoice----'+newInvoice);
                  system.debug('newInvoice.Receiver_Name__c----'+newInvoice.Receiver_Name__r.Name);
                  system.debug('producerId----'+producerId);
                   system.debug('newInvoice.Receiver_Name__r.Payment_Terms__c----'+newInvoice.Receiver_Name__r.Payment_Terms__c);
            for(Sales_Order_Line__c sl :soLinesQuery)
            {
             if(sl.Ownership_Code__c== producerId) 
             {
                newInvoice.Payment_Terms__c = sl.Ownership_Code__r.Payment_Terms__c; 
             }else
             {
                newInvoice.Payment_Terms__c ='COD';       
             }
            }
                
                
                newInvoice.Ownership__c = companySettingRec.Default_Distributor__c;
                newInvoice.Supplier_Name__c = companySettingRec.Default_Distributor__c;
                newInvoice.Supplier_License__c = companySettingRec.Default_License__c;
                newInvoiceMap.put(producerId,newInvoice);
                invoiceLineMap.put(producerId,invoiceLines);
                system.debug('invoiceLineMap'+invoiceLineMap);
            }
            system.debug('newInvoiceMap.values()'+newInvoiceMap.size());
           if(newInvoiceMap.size()>0){                
               insert newInvoiceMap.values();
              List<Invoice_Line__c> invLineItems = new List<Invoice_Line__c>();
                 Map<string,Invoice_Line__c> invLineItemsmaps = new Map<string,Invoice_Line__c>();
               set<id>prodlicenceids = new set<id>();
                Map<Id, Invoice_Line__c> mapSObj = new Map<Id, Invoice_Line__c>();
     List<Invoice_Line__c> noDupes ;
                        //   Map<String,Invoice_Line__c>batchInvoiceLineMap = new Map<String,Invoice_Line__c>();

           //  for(String producerId : invoiceLineMap.keyset()){
           for(String producerId : producerSOLinesMap.keySet()){       
        for (Sales_Order_Line__c objSOlines: soLinesQuery){
      if((producerId == objSOlines.Product_Name__r.Producer_Name__c && objSOlines.Product_Name__r.White_Labelled__c== False)  || (producerId == objSOlines.Product_Name__r.Licensee_Name__c && objSOlines.Product_Name__r.White_Labelled__c==True))
      {
          
     
            Map<String,Invoice_Line__c>batchInvoiceLineMap = new Map<String,Invoice_Line__c>();
            for(Inventory_Position__c IP : objSOlines.Inventory_Positions__r){
                system.debug('IP >>'+IP);
                if(batchInvoiceLineMap.containsKey(IP.Product_Name__c)){
                	Invoice_Line__c invLineItem =  batchInvoiceLineMap.get(IP.Product_Name__c);
                    invLineItem.Invoice_Qty__c = invLineItem.Invoice_Qty__c + IP.Inventory_Qty__c;
                    batchInvoiceLineMap.put(IP.Product_Name__c,invLineItem);
                    system.debug('batchInvoiceLineMap>>'+batchInvoiceLineMap);
                }else{
                	Invoice_Line__c invLineItem = new Invoice_Line__c();
                    invLineItem.Invoice__c = newInvoiceMap.get(producerId).Id;
                    invLineItem.Sales_Order_Line__c = objSOlines.Id;
                    invLineItem.Product_Name__c = objSOlines.Product_Name__c;
                    invLineItem.Product_Title__c = objSOlines.Product_Title__c;
                    invLineItem.Purchased_Date__c = objSOlines.Promised_Date__c;
                    invLineItem.Unit_Cultivation_Tax__c = IP.Unit_Cultivation_Tax__c;
                    invLineItem.Unit_Cannabis_Weight__c = IP.Unit_Cannabis_Weight__c;
                    invLineItem.PO_Line__c = IP.Receiving_Line__r.Purchase_Order_Line__c;
                    invLineItem.Invoice_Qty__c = IP.Inventory_Qty__c; //objSOlines.Qty_Ordered__c;
                    if(objSOlines.Ownership_Code__c != null){
                        invLineItem.OwnershipCode__c = objSOlines.Ownership_Code__c;    
                    } else{
                        invLineItem.OwnershipCode__c = objSOlines.Sales_Order__r.Ownership__c;
                    }
                    invLineItem.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get(Invoice_Record_Type_Tax).getRecordTypeId(); 
                    batchInvoiceLineMap.put(IP.Product_Name__c,invLineItem);
                     system.debug('batchInvoiceLineMap>>'+batchInvoiceLineMap);
                }    
            
           }
            invLineItems.addAll(batchInvoiceLineMap.values());
             system.debug('invLineItems>>'+invLineItems);
        }
            }
           }
        insert invLineItems;
         
          }else{
             r.data.put('Error','Please select Sales Order Line to create CTI');
           } 
           }
            r.data.put('recordId',recordId);
        }catch(Exception e){
            System.debug('Exception:'+e.getMessage()+'==>Line:'+e.getStackTraceString());
            r.handleException(e);
            if(!Test.isRunningTest()){
                Database.rollback(sp);
            }
        }        
        return r;
    }
  
    
    public static Invoice__c createProducerInvoice(Sales_Order__c sOrder,String producerId){
         Invoice__c newInvoice = new Invoice__c();
        if(sOrder !=null)
        {
            
       
         newInvoice.Sales_Order__c= sOrder.Id;
        newInvoice.AR_Status__c = Invoice_Ar_Status_Approved;
        newInvoice.Site__c = sOrder.Site__c;
        newInvoice.Shipping_Method__c = sOrder.Shipping_Method__c;
        newInvoice.Shipping_Terms__c = sOrder.Shipping_Terms__c;
       // newInvoice.Payment_Terms__c = 'COD';
        newInvoice.Invoice_Memo__c = sOrder.Sales_Order_Instructions__c;
        newInvoice.Sample_Order__c = sOrder.Sample_Order__c;
        newInvoice.Brand_Quote__c = sOrder.Brand_Quote__c;
        newInvoice.Opportunity_Name__c = sOrder.Opportunity_Name__c;
        newInvoice.Distributor_Name__c = sOrder.Distributor_Name__c;
        newInvoice.Distributor_License__c = sOrder.Distributor_License__c;
        newInvoice.Distributor_Contact__c = sOrder.Distributor_Contact__c;
        newInvoice.Supplier_Name__c = sOrder.Supplier_Name__c;
        newInvoice.Supplier_License__c = sOrder.Supplier_License__c;
        newInvoice.Supplier_Contact__c = sOrder.Supplier_Contact__c;
        newInvoice.Receiver_Name__c = producerId;
       // newInvoice.Receiver_License__c = cs.Default_License__c;
      //  newInvoice.Receiver_Contact__c = cs.Default_Contact__c;
        newInvoice.Ownership__c = sOrder.Ownership__c;
        newInvoice.Ship_Confirmation_Date__c = sOrder.Ship_Confirmation_Date__c;
        newInvoice.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get(Invoice_Record_Type_Tax).getRecordTypeId();
        newInvoice.Invoice_Due_Date__c = date.valueof(system.now());
     
            
            
       }
         return newInvoice;
       
    }

    
     public class ProducerWrpr{
        @AuraEnabled public String producerName{get;set;}
        @AuraEnabled public OpportunityLineItem productDescription{get;set;}
        @AuraEnabled public List<OpportunityLineItem> items{get;set;}
    }
    
    public class ProducerDetails{
        @AuraEnabled
        public Boolean isSelected {get; set;}
        @AuraEnabled
        public String producerName {get; set;}
        @AuraEnabled
        public String producerId {get; set;}
        @Auraenabled 
        public Integer rowSpan{get;set;}
        @Auraenabled 
        public SOLineDetails SOLine{get;set;}        
        public ProducerDetails(String producerId,String producerName,Integer rowSpan,SOLineDetails SOLine){
            this.isSelected = True;
            this.producerId = producerId;
            this.producerName = producerName;
            this.rowSpan = rowSpan;
            this.SOLine = SOLine;
        }
    }
    public class SOLineDetails{
        @AuraEnabled
        public Boolean isSelected {get; set;}
        @AuraEnabled 
        public Sales_Order_Line__c SOLine {get; set;}        
        public SOLineDetails(Sales_Order_Line__c SOLine){
            this.isSelected = false;         
            this.SOLine = SOLine;
        }
    }
}