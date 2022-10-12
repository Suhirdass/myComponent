public with sharing class  massInvoiceRP {
    public List<Bill_Pay__c> BillPayData { get; set; }
    public List<BilPaysWrapper> setBilPays {get; set;}
    public Map<String, String> getLabStatusData { get; set; }
    public Map<id, String> getbank { get; set; }
    public static string searchString;
    public Map<String, String> getLabStatusDataRP { get; set; }
    public Map<String, String> getRecordTypesRP { get; set; } 
    public List<Receive_Payment__c> RPData { get; set; }
    public List<RPWrapper> setinvoice {get; set;}
    public static Decimal invbalnceval {get; set;}
    public static boolean REGISTER_LINE_CHECK = False;
    public static  List<RPWrapper> plWrapper;
    

      private static String PO_STATUS_APPROVED{
        get{
            return String.isNotBlank(PO_STATUS_APPROVED) ? PO_STATUS_APPROVED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase_Order_Status_Approved');
        }set;
    }
     private static String PO_STATUS_CLOSED{
        get{
            return String.isNotBlank(PO_STATUS_CLOSED) ? PO_STATUS_CLOSED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase_Order_Status_Closed');
        }set;
    }
     private static String INVOICE_AR_STATUS_APPROVED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_APPROVED) ? INVOICE_AR_STATUS_APPROVED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Approved');
        }set;
    }
     private static String INVOICE_AR_STATUS_SHIPPED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_SHIPPED) ? INVOICE_AR_STATUS_SHIPPED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Shipped');
        }set;
    }
     private static String INVOICE_COLLECTION_STATUS_PENDING{
        get{
            return String.isNotBlank(INVOICE_COLLECTION_STATUS_PENDING) ? INVOICE_COLLECTION_STATUS_PENDING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','invoice_Collection_Status_Pending');
        }set;
    }
     private static String INVOICE_COLLECTION_STATUS_PASTDUE{
        get{
            return String.isNotBlank(INVOICE_COLLECTION_STATUS_PASTDUE) ? INVOICE_COLLECTION_STATUS_PASTDUE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','invoice_Collection_Status_PastDue');
        }set;
    }
     private static String INVOICE_COLLECTION_STATUS_PARTIALPAYMENT{
        get{
            return String.isNotBlank(INVOICE_COLLECTION_STATUS_PARTIALPAYMENT) ? INVOICE_COLLECTION_STATUS_PARTIALPAYMENT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','invoice_Collection_Status_partialPaymente');
        }set;
    }
    
     Private Static String RECEIVE_PAYMENTS_PAYMENT_FORM_CHECK{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_PAYMENT_FORM_CHECK) ? RECEIVE_PAYMENTS_PAYMENT_FORM_CHECK : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Payment_Form_Check');
        }set;
    }
    Private Static String RECEIVE_PAYMENTS_PAYMENT_FORM_CASH{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_PAYMENT_FORM_CASH) ? RECEIVE_PAYMENTS_PAYMENT_FORM_CASH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Payment_Form_Cash');
        }set;
    }
    Private Static String RECEIVE_PAYMENTS_PAYMENT_FORM_CREDIT_CARD{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_PAYMENT_FORM_CREDIT_CARD) ? RECEIVE_PAYMENTS_PAYMENT_FORM_CREDIT_CARD : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Payment_Form_CreditCard');
        }set;
    }
    Private Static String RECEIVE_PAYMENTS_PAYMENT_FORM_DEBIT_CARD{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_PAYMENT_FORM_DEBIT_CARD) ? RECEIVE_PAYMENTS_PAYMENT_FORM_DEBIT_CARD : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Payment_Form_DebitCard');
        }set;
    }
    Private Static String RECEIVE_PAYMENTS_PAYMENT_FORM_CLEARING_ACCOUNT{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_PAYMENT_FORM_CLEARING_ACCOUNT) ? RECEIVE_PAYMENTS_PAYMENT_FORM_CLEARING_ACCOUNT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Payment_Form_Clearing_Account');
        }set;
    }
    Private Static String RECEIVE_PAYMENTS_PAYMENT_FORM_ACH{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_PAYMENT_FORM_ACH) ? RECEIVE_PAYMENTS_PAYMENT_FORM_ACH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Payment_Form_ACH');
        }set;
    }
     Private Static String RECEIVE_PAYMENTS_PAYMENT_FORM_WIRE{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_PAYMENT_FORM_WIRE) ? RECEIVE_PAYMENTS_PAYMENT_FORM_WIRE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Payment_Form_Wire');
        }set;
    }
    Private Static String RECEIVE_PAYMENTS_PAYMENT_FORM_EXCISETAX_DEPOSIT{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_PAYMENT_FORM_EXCISETAX_DEPOSIT) ? RECEIVE_PAYMENTS_PAYMENT_FORM_EXCISETAX_DEPOSIT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Payment_Form_ExciseTax');
        }set;
    }
    Private Static String RECEIVE_PAYMENTS_RECORD_TYPE_CREDITMEMO{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_CREDITMEMO) ? RECEIVE_PAYMENTS_RECORD_TYPE_CREDITMEMO : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_CreditCard');
        }set;
    }
     Private Static String RECEIVE_PAYMENTS_RECORD_TYPE_BILLPAY{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_BILLPAY) ? RECEIVE_PAYMENTS_RECORD_TYPE_BILLPAY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_BillPay');
        }set;
    }
     Private Static String RECEIVE_PAYMENTS_RECORD_TYPE_CLEARING_ACCOUNT{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_CLEARING_ACCOUNT) ? RECEIVE_PAYMENTS_RECORD_TYPE_CLEARING_ACCOUNT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_ClearingAccount');
        }set;
    }
     Private Static String RECEIVE_PAYMENTS_RECORD_TYPE_CUTIVATION_TAX{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_CUTIVATION_TAX) ? RECEIVE_PAYMENTS_RECORD_TYPE_CUTIVATION_TAX : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_Cultivation_Tax');
        }set;
    }
     Private Static String RECEIVE_PAYMENTS_RECORD_TYPE_EXCISETAX{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_EXCISETAX) ? RECEIVE_PAYMENTS_RECORD_TYPE_EXCISETAX : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_ExciseTax');
        }set;
    }
     Private Static String RECEIVE_PAYMENTS_RECORD_TYPE_FACTORING{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_FACTORING) ? RECEIVE_PAYMENTS_RECORD_TYPE_FACTORING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_Factoring');
        }set;
    }
     Private Static String RECEIVE_PAYMENTS_RECORD_TYPE_LATECHARGE{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_LATECHARGE) ? RECEIVE_PAYMENTS_RECORD_TYPE_LATECHARGE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_LateCharge');
        }set;
    }	
     Private Static String RECEIVE_PAYMENTS_RECORD_TYPE_LOCAL_CANNABIS_TAX{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_LOCAL_CANNABIS_TAX) ? RECEIVE_PAYMENTS_RECORD_TYPE_LOCAL_CANNABIS_TAX : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_LocalCannabisTax');
        }set;
    }
    Private Static String RECEIVE_PAYMENTS_RECORD_TYPE_PRODUCT{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_PRODUCT) ? RECEIVE_PAYMENTS_RECORD_TYPE_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_Product');
        }set;
    }
    Private Static String RECEIVE_PAYMENTS_RECORD_TYPE_RETURNCHECK{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_RETURNCHECK) ? RECEIVE_PAYMENTS_RECORD_TYPE_RETURNCHECK : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_ReturnCheck');
        }set;
    }	
     Private Static String RECEIVE_PAYMENTS_RECORD_TYPE_SERVICE{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_SERVICE) ? RECEIVE_PAYMENTS_RECORD_TYPE_SERVICE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_Service');
        }set;
    }
    Private Static String RECEIVE_PAYMENTS_RECORD_TYPE_WIREOFF{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_WIREOFF) ? RECEIVE_PAYMENTS_RECORD_TYPE_WIREOFF : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_wireoff');
        }set;
    }
    Private Static String INVOICE_RECORD_TYPE_SERVICE{
        get{
            return String.isNotBlank(INVOICE_RECORD_TYPE_SERVICE) ? INVOICE_RECORD_TYPE_SERVICE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
    Private Static String INVOICE_RECORD_TYPE_PRODUCT{
        get{
            return String.isNotBlank(INVOICE_RECORD_TYPE_PRODUCT) ? INVOICE_RECORD_TYPE_PRODUCT	 : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Product');
        }set;
    }
    Private Static String INVOICE_RECORD_TYPE_TAX{
        get{
            return String.isNotBlank(INVOICE_RECORD_TYPE_TAX) ? INVOICE_RECORD_TYPE_TAX : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Tax Protected');
        }set;
    }
   Private Static String REGISTER_ENTRY_LINE_RECORD_TYPE_CREDIT{
        get{
            return String.isNotBlank(REGISTER_ENTRY_LINE_RECORD_TYPE_CREDIT) ? REGISTER_ENTRY_LINE_RECORD_TYPE_CREDIT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Register Entry Line','Register_Entry_Record_Type_Payment');
        }set;
    }
       
    // Fetching BillSupplier data 
    @AuraEnabled
    public static AuraResponse BillPaysdetails(string searchText,string Recordstypes){
        AuraResponse r = new AuraResponse('CreateRLfromPOline.purchaseOrderDeatils()');
        massInvoiceRP assign = new massInvoiceRP();
        assign.getLabStatusData = getLabStatus();
        assign.getbank = getbank();
        r.data.put('getbank', assign.getbank);
        assign.setBilPays = getbillpaysPO( searchText, Recordstypes);
        r.data.put('setBilPays', assign.setBilPays);
        r.data.put('getLabStatusData', assign.getLabStatusData);
        return r;	
    } 
    // picklist values 
     @AuraEnabled
    public static Map<String, String> getLabStatus(){
        Map<String, String> options = new Map<String, String>();
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_ACH,RECEIVE_PAYMENTS_PAYMENT_FORM_ACH);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CASH,RECEIVE_PAYMENTS_PAYMENT_FORM_CASH);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CHECK,RECEIVE_PAYMENTS_PAYMENT_FORM_CHECK);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CLEARING_ACCOUNT,RECEIVE_PAYMENTS_PAYMENT_FORM_CLEARING_ACCOUNT);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CREDIT_CARD,RECEIVE_PAYMENTS_PAYMENT_FORM_CREDIT_CARD);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_DEBIT_CARD,RECEIVE_PAYMENTS_PAYMENT_FORM_DEBIT_CARD);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_EXCISETAX_DEPOSIT,RECEIVE_PAYMENTS_PAYMENT_FORM_EXCISETAX_DEPOSIT);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_WIRE,RECEIVE_PAYMENTS_PAYMENT_FORM_WIRE);
        return options;
    }
 // supplierbill Search records based on search test and recordtypes 
      public static List<BilPaysWrapper>  getbillpaysPO(string searchText,string Recordstypes){
          List<BilPaysWrapper> plWrapper = new List<BilPaysWrapper>();
          String searchString = '%' + searchText.trim() + '%';          
          List<String> POStatus = new List<String>{PO_STATUS_APPROVED,PO_STATUS_CLOSED}; 
              List <Supplier_Bill__c> lstPOline = [select id , name,Purchase_Order__r.Name,Purchase_Order__r.PO_Status__c,Ship_Confirmation_Date__c,Bill_Due_Date__c, Purchase_Order__c, Bill_Amount__c, Outstanding_Balance__c,  
                                                   Purchase_Order__r.Ownership__r.Name, Purchase_Order__r.RecordType.Name from Supplier_Bill__c  
                                                   WHERE Purchase_Order__r.PO_Status__c =: POStatus  AND Outstanding_Balance__c != 0.0 AND (Purchase_Order__r.Ownership__r.Name Like : searchString OR  Purchase_Order__r.Ownership__r.DBA__c Like : searchString)  AND Purchase_Order__r.RecordType.Name  Like: Recordstypes order by Ship_Confirmation_Date__c ASC];
          for(Supplier_Bill__c BP : lstPOline){BilPaysWrapper bpWrapper = new BilPaysWrapper(BP); plWrapper.add(bpWrapper);
                                              }
          for(BilPaysWrapper rpdata : plWrapper){
              system.debug('Invoice_Balance__c'+rpdata.SB.Outstanding_Balance__c);
              rpdata.recQty= rpdata.SB.Outstanding_Balance__c;
          }
          return plWrapper;
    }   
  //To create Bill Pays 
    @AuraEnabled
    public static AuraResponse CreatebillPays(List<BilPaysWrapper> setPurchaseOrderLines){
        AuraResponse r = new AuraResponse('massInvoiceRP.CreatebillPays()');
        massInvoiceRP assign = new massInvoiceRP();
        List<String> pordNames = new List<String>();
        set<id>ids = new set<id>();
        List<Bill_Pay__c> BillPayToCreate = new List<Bill_Pay__c>();
        List<Bill_Pay__c> BillPayToClear = new List<Bill_Pay__c>();
        List<Register_Entry_Line__c> bklist = new List<Register_Entry_Line__c>();
        List<Register_Entry_Line__c> bklistupdate = new List<Register_Entry_Line__c>();
        for(BilPaysWrapper poLineWrapper : setPurchaseOrderLines){  Bill_Pay__c pOrderLineSO = poLineWrapper.BillPays;
            if(poLineWrapper.isSelected){  Bill_Pay__c receivingLinePO = createbilpay(pOrderLineSO, poLineWrapper.recQty, poLineWrapper.Paymentmemo, poLineWrapper.TransactionDate,  poLineWrapper.postdate, poLineWrapper.ReconcilitionNotes, poLineWrapper.Reconciled, poLineWrapper.BankReg,poLineWrapper.SB.Id,poLineWrapper.labTestStat );
                BillPayToCreate.add(receivingLinePO); Id poRecordTypeID   = Schema.SObjectType.Register_Entry_Line__c.getRecordTypeInfosByName().get('Credit').getRecordTypeId();
        Register_Entry_Line__c bk = new Register_Entry_Line__c();
        bk.Bank_Register__c=poLineWrapper.BankReg;  bk.RecordTypeId=poRecordTypeID; bklist.add(bk);
            }
           
        }
        //update poLineToUpdate; 
        insert BillPayToCreate;
        insert bklist;
        Id PayRecordTypeID   = Schema.SObjectType.Register_Entry_Line__c.getRecordTypeInfosByName().get(REGISTER_ENTRY_LINE_RECORD_TYPE_CREDIT).getRecordTypeId();
        for(Bill_Pay__c b :BillPayToCreate){  ids.add(b.Id);
            for(Register_Entry_Line__c bb :bklist ) {  if(b.Credit_Card_Number__c ==bb.Bank_Register__c ){Register_Entry_Line__c bks = new Register_Entry_Line__c();
                    bks.Bill_Pay__c=b.Id;bks.RecordTypeId=PayRecordTypeID;bks.Bank_Register__c =bb.Bank_Register__c; 
                    bklistupdate.add(bks);   
                }
                 
            }
          
        }
        upsert bklistupdate;
        List<Bill_Pay__c> bplst =[select id ,Credit_Card_Number__c,Supplier_Bill__c from Bill_Pay__c where id=:ids];
        for(Bill_Pay__c bpay : bplst){  Bill_Pay__c b = new Bill_Pay__c();   b.Credit_Card_Number__c =' ';
                                      b.Supplier_Bill__c = bpay.Supplier_Bill__c;  b.Id=bpay.Id;
                                      BillPayToClear.add(b); 
                                     }
        upsert BillPayToClear;
        return r;
    }
      public static Bill_Pay__c createbilpay( Bill_Pay__c poLinePO,Decimal recQty,string Paymentmemo,Date TransactionDate,Date postdate,string ReconcilitionNotes,Boolean Reconciled,string bank,string SupplierBills, String labStat){
          Bill_Pay__c recLineSO = new Bill_Pay__c();
          recLineSO.Supplier_Bill__c =SupplierBills;  recLineSO.Payment_Amount__c = recQty;
          recLineSO.Payment_Memo__c =Paymentmemo ;
          recLineSO.Payment_Date__c = TransactionDate; recLineSO.Post_Date__c = postdate;
          recLineSO.Reconciliation_Notes__c =ReconcilitionNotes ;   recLineSO.Reconciled__c =Reconciled ;
          recLineSO.Credit_Card_Number__c=bank;recLineSO.Payment_Form__c = labStat;
          return recLineSO;
     } 
    
    
    // retriving invoice records by record types and search key word
     @AuraEnabled
    public static AuraResponse RPdetails(string searchText,string Recordstypes){
        AuraResponse r = new AuraResponse('massInvoiceRP.RPdetails()');
        massInvoiceRP assign = new massInvoiceRP();
        assign.getbank = getbank();
        r.data.put('getbank', assign.getbank);
        assign.getLabStatusDataRP = getLabStatusRP();
        assign.getRecordTypesRP = getReordTypesRP();
        assign.setinvoice = getRPINVData(searchText, Recordstypes);
        r.data.put('setinvoice', assign.setinvoice);
        r.data.put('getLabStatusDataRP', assign.getLabStatusDataRP);
        r.data.put('getRecordTypesRP', assign.getRecordTypesRP);
        return r;
    } 
     @AuraEnabled
    public static Map<String, String> getLabStatusRP(){
        Map<String, String> options = new Map<String, String>();
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_ACH,RECEIVE_PAYMENTS_PAYMENT_FORM_ACH);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CASH,RECEIVE_PAYMENTS_PAYMENT_FORM_CASH);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CHECK,RECEIVE_PAYMENTS_PAYMENT_FORM_CHECK);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CLEARING_ACCOUNT,RECEIVE_PAYMENTS_PAYMENT_FORM_CLEARING_ACCOUNT);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CREDIT_CARD,RECEIVE_PAYMENTS_PAYMENT_FORM_CREDIT_CARD);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_DEBIT_CARD,RECEIVE_PAYMENTS_PAYMENT_FORM_DEBIT_CARD);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_EXCISETAX_DEPOSIT,RECEIVE_PAYMENTS_PAYMENT_FORM_EXCISETAX_DEPOSIT);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_WIRE,RECEIVE_PAYMENTS_PAYMENT_FORM_WIRE);
        return options;
    }
      @AuraEnabled
    public static  Map<id, String> getbank(){
               Map<id, String> optionsbank = new Map<id, String>();
      List<Bank_Register__c> br =[select id,name,Active__c from Bank_Register__c where Active__c=True Order BY Name ] ;
        for(Bank_Register__c bb : br){ optionsbank.put(bb.id, bb.Name);
        }
        return optionsbank;
    }
     @AuraEnabled
    public static Map<String, String> getReordTypesRP(){
        Map<String, String> options = new Map<String, String>();
       
         options.put(RECEIVE_PAYMENTS_RECORD_TYPE_BILLPAY,RECEIVE_PAYMENTS_RECORD_TYPE_BILLPAY);
         options.put(RECEIVE_PAYMENTS_RECORD_TYPE_CLEARING_ACCOUNT,RECEIVE_PAYMENTS_RECORD_TYPE_CLEARING_ACCOUNT);
         options.put(RECEIVE_PAYMENTS_RECORD_TYPE_CREDITMEMO,RECEIVE_PAYMENTS_RECORD_TYPE_CREDITMEMO);
         options.put(RECEIVE_PAYMENTS_RECORD_TYPE_CUTIVATION_TAX,RECEIVE_PAYMENTS_RECORD_TYPE_CUTIVATION_TAX);
         options.put(RECEIVE_PAYMENTS_RECORD_TYPE_EXCISETAX,RECEIVE_PAYMENTS_RECORD_TYPE_EXCISETAX);
         options.put(RECEIVE_PAYMENTS_RECORD_TYPE_FACTORING,RECEIVE_PAYMENTS_RECORD_TYPE_FACTORING);
         options.put(RECEIVE_PAYMENTS_RECORD_TYPE_LATECHARGE,RECEIVE_PAYMENTS_RECORD_TYPE_LATECHARGE);
         options.put(RECEIVE_PAYMENTS_RECORD_TYPE_LOCAL_CANNABIS_TAX,RECEIVE_PAYMENTS_RECORD_TYPE_LOCAL_CANNABIS_TAX);
          options.put(RECEIVE_PAYMENTS_RECORD_TYPE_PRODUCT,RECEIVE_PAYMENTS_RECORD_TYPE_PRODUCT);
         options.put(RECEIVE_PAYMENTS_RECORD_TYPE_RETURNCHECK,RECEIVE_PAYMENTS_RECORD_TYPE_RETURNCHECK);
         options.put(RECEIVE_PAYMENTS_RECORD_TYPE_SERVICE,RECEIVE_PAYMENTS_RECORD_TYPE_SERVICE);
         options.put(RECEIVE_PAYMENTS_RECORD_TYPE_WIREOFF,RECEIVE_PAYMENTS_RECORD_TYPE_WIREOFF);
        return options;
    }
    
    public static List<RPWrapper>  getRPINVData(string searchText,string Recordstypes){
       plWrapper = new list<RPWrapper>();
   String searchString = '%' + searchText.trim() + '%';     
              List <Invoice__c > lstRP = new List<Invoice__c>();
        List<String> collectionStatus = new List<String>{INVOICE_COLLECTION_STATUS_PENDING,INVOICE_COLLECTION_STATUS_PASTDUE,INVOICE_COLLECTION_STATUS_PARTIALPAYMENT};
                    List<String> ARStatus = new List<String>{INVOICE_AR_STATUS_APPROVED,INVOICE_AR_STATUS_SHIPPED};
            if(Recordstypes ==INVOICE_RECORD_TYPE_SERVICE){
            lstRP= [SELECT id , name ,AR_Status__c, Ship_Confirmation_Date__c, RecordType.Name, Ownership__r.Name, Receiver_DBA__c,Invoice_Due_Date__c, Total_Invoice_Amount__c, Collections_Status__c,Receiver_Name__r.Name,Receiver_Name__c, Invoice_Balance__c from Invoice__c   WHERE  Invoice_Balance__c != 0.0 AND AR_Status__c=:ARStatus AND  Collections_Status__c =:collectionStatus AND (Receiver_Name__r.Name Like : searchString OR Receiver_DBA__c Like : searchString)  AND RecordType.Name =: Recordstypes AND Ship_Confirmation_Date__c !=null  order by Ship_Confirmation_Date__c ASC];
            
            }else if(Recordstypes ==INVOICE_RECORD_TYPE_TAX || Recordstypes ==INVOICE_RECORD_TYPE_PRODUCT){
          lstRP= [SELECT id , name ,AR_Status__c, Ship_Confirmation_Date__c, RecordType.Name, Ownership__r.Name, Receiver_DBA__c,Invoice_Due_Date__c,
                                    Total_Invoice_Amount__c, Collections_Status__c,Receiver_Name__r.Name,Receiver_Name__c, Invoice_Balance__c from Invoice__c  
                            WHERE  Invoice_Balance__c != 0.0 AND AR_Status__c=:ARStatus AND  Collections_Status__c =:collectionStatus AND (Ownership__r.Name Like : searchString OR Ownership__r.DBA__c Like : searchString ) 
                                    AND RecordType.Name =: Recordstypes AND Ship_Confirmation_Date__c !=null  order by Ship_Confirmation_Date__c ASC];   
            }
       
        for(Invoice__c BP : lstRP){RPWrapper bpWrapper = new RPWrapper(BP);
                plWrapper.add(bpWrapper);
        }
      
          for(RPWrapper rpdata : plWrapper){rpdata.recQty= rpdata.inv.Invoice_Balance__c;
              decimal vals = rpdata.inv.Invoice_Balance__c;
            }
        
        return plWrapper;
    }    
     
    
    
  // create Receive payment 
      @AuraEnabled
    public static AuraResponse CreateRP(List<RPWrapper> setrpdatas){
        REGISTER_LINE_CHECK = True;
        AuraResponse r = new AuraResponse('massInvoiceRP.CreateRP()');
        massInvoiceRP assign = new massInvoiceRP();
        List<String> pordNames = new List<String>();
        set<id>ids = new set<id>();
        List<Receive_Payment__c> BillPayToClear = new List<Receive_Payment__c>();
        List<Register_Entry_Line__c> bklist = new List<Register_Entry_Line__c>();
        List<Register_Entry_Line__c> bklistupdate = new List<Register_Entry_Line__c>();
        List<Receive_Payment__c>RPToCreate = new List<Receive_Payment__c>();
        for(RPWrapper poLineWrapper : setrpdatas){  Receive_Payment__c pOrderLineSO = poLineWrapper.RP;
            if(poLineWrapper.isSelected){          
                Receive_Payment__c RPLst = createRPData(pOrderLineSO, poLineWrapper.recQty, poLineWrapper.Paymentmemo, poLineWrapper.TransactionDate,poLineWrapper.postdate,poLineWrapper.ReconcilitionNotes, poLineWrapper.Reconciled, poLineWrapper.Reference, poLineWrapper.BankRegRP,  poLineWrapper.inv.Id, poLineWrapper.RecordType, poLineWrapper.labTestStat);
                RPToCreate.add(RPLst);
                Id poRecordTypeID   = Schema.SObjectType.Register_Entry_Line__c.getRecordTypeInfosByName().get(REGISTER_ENTRY_LINE_RECORD_TYPE_CREDIT).getRecordTypeId();
                Register_Entry_Line__c bk = new Register_Entry_Line__c();
                if(poLineWrapper.BankRegRP ==''){bk.Bank_Register__c=null;
                }else{
                    bk.Bank_Register__c=poLineWrapper.BankRegRP;
                }
                bk.RecordTypeId=poRecordTypeID; bklist.add(bk); 
                
            }
            
        }
      
        insert RPToCreate;
      
        for(Receive_Payment__c b :RPToCreate){ ids.add(b.Id);
            for(Register_Entry_Line__c bb :bklist )
            {
                    Register_Entry_Line__c bks = new Register_Entry_Line__c();
                  bks.Related_Payment__c=b.Id; bks.Bank_Register__c =bb.Bank_Register__c; 
                    bklistupdate.add(bks);   
            }
          
        }
        upsert bklistupdate;
        List<Receive_Payment__c> bplst =[select id ,Credit_Card_Number__c from Receive_Payment__c where id=:ids];

       for(Receive_Payment__c bpay : bplst){
           Receive_Payment__c b = new Receive_Payment__c();  
            b.Credit_Card_Number__c =' ';   b.Id=bpay.Id;
           BillPayToClear.add(b); 
        }
          upsert BillPayToClear;

        return r;
    }
      public static Receive_Payment__c createRPData( Receive_Payment__c RPOBJData,Decimal recQty,string Paymentmemo,Date TransactionDate,Date postdate,string ReconcilitionNotes,Boolean Reconciled,string Reference,string RPBank,string invoice, String RecordTypes ,String labStat){
          Receive_Payment__c RPOBJ = new Receive_Payment__c();
          Id RPRecordTypeID ;
          if(RPRecordTypeID != null){ RPRecordTypeID   = Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get(RecordTypes).getRecordTypeId();
  
         }
      	  RPOBJ.Invoice__c = invoice;
          RPOBJ.Payment_Amount__c = recQty;
          RPOBJ.Payment_Memo__c =Paymentmemo ;
          RPOBJ.Payment_Received_Date__c=TransactionDate;
          RPOBJ.Posted_Date__c = postdate;         
          RPOBJ.Reconciliation_Notes__c =ReconcilitionNotes ; 
          RPOBJ.Reconciled__c =Reconciled ;
          RPOBJ.Reference__c=  Reference;
          RPOBJ.Credit_Card_Number__c = RPBank;
          RPOBJ.RecordTypeId=RPRecordTypeID;
          RPOBJ.Payment_Form__c = labStat; 
       
          return RPOBJ;
     } 
  
    
    
    public class RPWrapper{
        @AuraEnabled
        public Boolean isSelected {get; set;}
        @AuraEnabled
        public Receive_Payment__c RP {get; set;}
        @AuraEnabled
        public Invoice__c inv {get; set;}
        
        @AuraEnabled
        public Decimal recQty {get; set;}
        @AuraEnabled
        public String labTestStat {get; set;}
        @AuraEnabled
        public Date TransactionDate {get; set;}
        @AuraEnabled
        public String Paymentmemo {get; set;}
        @AuraEnabled
        public String Reference {get; set;}
        @AuraEnabled
        public Date postdate {get; set;}
        @AuraEnabled
        public String ReconcilitionNotes {get; set;}
        @AuraEnabled
        public Boolean Reconciled {get; set;}
        @AuraEnabled
        public string BankRegRP {get; set;}
        @AuraEnabled
        public string RecordType {get; set;}
         
        // Constructor
        public RPWrapper(Invoice__c inv){
            this.isSelected = false;
            // this.isDisabled = false;
            this.RP = RP;
            this.inv = inv;
          
            this.recQty = 0;
            this.labTestStat = 'null';
            this.TransactionDate = system.today();
            this.Paymentmemo = '';
            this.Reference = '';
            this.postdate =system.today();
            this.ReconcilitionNotes = '';
            this.Reconciled =false;
          this.BankRegRP='null';
            this.RecordType='';
        }
        public RPWrapper(){
            this.isSelected = false;
            this.RP = RP;
            this.recQty =0;
            this.labTestStat = 'null';
            this.TransactionDate = system.today();
            this.Paymentmemo = '';
            this.Reference = '';
            this.postdate =  system.today();
            this.ReconcilitionNotes = '';
            this.Reconciled =false;
            this.inv = inv;
          // this.pickbank='';
            this.BankRegRP='null';
            this.RecordType='';
            
        }
    } 
    
    public class BilPaysWrapper{
        @AuraEnabled
        public Boolean isSelected {get; set;}
        
        @AuraEnabled
        public Bill_Pay__c BillPays {get; set;}
        @AuraEnabled
        public Supplier_Bill__c  SB {get; set;}
        @AuraEnabled
        public Decimal recQty {get; set;}
        @AuraEnabled
        public String labTestStat {get; set;}
        @AuraEnabled
        public Date TransactionDate {get; set;}
        @AuraEnabled
        public String Paymentmemo {get; set;}
        @AuraEnabled
        public String Reference {get; set;}
        @AuraEnabled
        public Date postdate {get; set;}
        @AuraEnabled
        public String ReconcilitionNotes {get; set;}
        @AuraEnabled
        public Boolean Reconciled {get; set;}
        @AuraEnabled
        public string BankReg {get; set;}
        // Constructor
        public BilPaysWrapper(Supplier_Bill__c SB){
            this.isSelected = false;
            this.BillPays = BillPays;
            this.SB = SB;
            this.recQty = 0;
            this.labTestStat = '';
            this.TransactionDate = system.today();
            this.Paymentmemo = '';
            this.Reference = '';
            this.postdate =system.today();
            this.ReconcilitionNotes = '';
            this.Reconciled =false;
            this.BankReg='';
        }
        public BilPaysWrapper(){
            this.isSelected = false;
            this.BillPays = BillPays;
            this.SB = SB;
            this.recQty = 0;
            this.labTestStat = '';
            this.TransactionDate = system.today();
            this.Paymentmemo = '';
            this.Reference = '';
            this.postdate =  system.today();
            this.ReconcilitionNotes = '';
            this.Reconciled =false;
            this.BankReg='';
        }
        
        
     
        
    } 
      @AuraEnabled
    public static AuraResponse res(){ AuraResponse r = new AuraResponse('massInvoiceRP.res()'); 
      return r;  
    }
   
    
}