public with sharing class ReceivePaymentsCtlr {
    
    Private Static String REGISTER_ENTRY_LINE_SOBJECT_API_NAME{
        get{
            return String.isNotBlank(REGISTER_ENTRY_LINE_SOBJECT_API_NAME) ? REGISTER_ENTRY_LINE_SOBJECT_API_NAME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Register Entry Line','Register_Entry_Obj_Name');
        }set;
    }
    Private Static String REGISTER_ENTRY_LINE_RECORD_TYPE_DEPOSIT{
        get{
            return String.isNotBlank(REGISTER_ENTRY_LINE_RECORD_TYPE_DEPOSIT) ? REGISTER_ENTRY_LINE_RECORD_TYPE_DEPOSIT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Register Entry Line','Register_Entry_Record_Type_Deposit');
        }set;
    }
    Private Static String REGISTER_ENTRY_LINE_RECORD_TYPE_PAYMENT{
        get{
            return String.isNotBlank(REGISTER_ENTRY_LINE_RECORD_TYPE_PAYMENT) ? REGISTER_ENTRY_LINE_RECORD_TYPE_PAYMENT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Register Entry Line','Register_Entry_Record_Type_Payment');
        }set;
    }
    Private Static String INVOICE_SOBJECT_API_NAME{
        get{
            return String.isNotBlank(INVOICE_SOBJECT_API_NAME) ? INVOICE_SOBJECT_API_NAME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_obj_Name');
        }set;
    }
    Private Static String 	PURCHASE_ORDER_SOBJECT_API_NAME{
        get{
            return String.isNotBlank(PURCHASE_ORDER_SOBJECT_API_NAME) ? PURCHASE_ORDER_SOBJECT_API_NAME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase_Order_Obj_Name');
        }set;
    }
    Private Static String ERR_MSG_PAYMENT_AMOUNT{
        get{
            return String.isNotBlank(ERR_MSG_PAYMENT_AMOUNT) ? ERR_MSG_PAYMENT_AMOUNT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Err_Msg_PaymentAmt_Gt_Than_Out_Amt');
        }set;
    }
    Private Static String ERR_MSG_INVOICE_DOES_NOT_EXIT{
        get{
            return String.isNotBlank(ERR_MSG_INVOICE_DOES_NOT_EXIT) ? ERR_MSG_INVOICE_DOES_NOT_EXIT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Err_Msg_Invoice_Does_Not_Exit');
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
    Private Static String RECEIVE_PAYMENTS_PAYMENT_PAYMENTFORM{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_PAYMENT_PAYMENTFORM) ? RECEIVE_PAYMENTS_PAYMENT_PAYMENTFORM : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_PayForm_PickValues');
        }set;
    }
    Private Static String ERR_MSG_RECEIVE_PAYMENTS_VALID_PAYMENT_FORM{
        get{
            return String.isNotBlank(ERR_MSG_RECEIVE_PAYMENTS_VALID_PAYMENT_FORM) ? ERR_MSG_RECEIVE_PAYMENTS_VALID_PAYMENT_FORM : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','Err_Msg_Valid_Paymet_Form');
        }set;
    }
    
    @AuraEnabled
    public static AuraResponse savePayments(String paymentsData, Boolean isSupplierBills){
        AuraResponse r = new AuraResponse('ReceivePaymentsCtlr.savePayments()');
        List<Payment> payments = (List<Payment>)JSON.deserialize(paymentsData, List<Payment>.class);
        Set<String> invoices = new Set<String>();
        Set<String> purchaseOrders = new Set<String>();
        Set<String> recordTypeIds = new Set<String>();
        Set<String> Chartofacc = new Set<String>();
        Set<String> Supplierbills = new Set<String>(); 
        for(Payment p:payments){
            if(isSupplierBills){
                Supplierbills.add(p.Billpaysupplier);
                Chartofacc.add(p.ChartofAccount);
                purchaseOrders.add(p.PONumber);
            }else{
                invoices.add(p.InvoiceNumber);
                recordTypeIds.add(p.RecordType);
            }
        } 
        
        Map<String, Id> invoicesMap = new Map<String, Id>();
        Map<String,Id> SupplierbillsMap = new Map<String, Id>();
        Map<String, Id> recordTypeIdsMap = new Map<String, Id>();
        Map<String, Id> ChartofAccMap = new Map<String, Id>();
        Map<String,Decimal> supplierOutStandingAmt=new Map<String,Decimal>();                     
        Map<String, Id> purchaseOrdersMap = new Map<String, Id>();
        if(isSupplierBills){
            List<Supplier_Bill__c> SPlist =[SELECT Id,Name,Outstanding_Balance__c FROM Supplier_Bill__c WHERE Name IN:Supplierbills];
            
            List<Chart_of_Account__c> CAlist =[SELECT Id, Name FROM Chart_of_Account__c WHERE Name IN:Chartofacc];
            for(Supplier_Bill__c SP :SPlist)
            {
                SupplierbillsMap.put(SP.Name, SP.Id);
                supplierOutStandingAmt.put(SP.Name,SP.Outstanding_Balance__c);  
            }
            for(Chart_of_Account__c CA :CAlist)
            {
                ChartofAccMap.put(CA.Name, CA.Id);  
            }
        }
        
        else{
            List<Invoice__c> invoice =[SELECT Id, Name FROM Invoice__c WHERE Name IN:invoices];
            List<RecordType> rectype =[SELECT Id,Name, DeveloperName FROM RecordType WHERE Name IN: recordTypeIds AND SobjectType = :'Receive_Payment__c'];
            for(Invoice__c i: invoice){
                invoicesMap.put(i.Name, i.Id);
            }
            for(RecordType rt: rectype){
                recordTypeIdsMap.put(rt.Name, rt.Id);
            }
        }
        List<Receive_Payment__c> createPayments = new List<Receive_Payment__c>();
        Map<String,Receive_Payment__c[]> creditToAccountMap = new Map<String,Receive_Payment__c[]>();
        List<Bill_Pay__c> createBillpays = new List<Bill_Pay__c>();
        Map<String,Bill_Pay__c[]> debitToAccountMap = new Map<String,Bill_Pay__c[]>();
        List<String> errors = new List<String>();
        List<String> errorsinvoice = new List<String>();
        List<String> Warnings = new List<String>();
        List<String> successBillSuppliers=new List<String>();
        Date  paymentReceiveDatePost;
        Date paymentReceiveDate;
        Date reconciliationDate;
        for(Payment p:payments){
            if(String.isNotBlank(p.paymentReceiveDate)){
                paymentReceiveDate = Date.parse(String.valueOf(p.paymentReceiveDate));
                reconciliationDate = Date.parse(String.valueOf(p.ReconciliationDate));
                
            }
            if(String.isNotBlank(p.paymentReceiveDatePost)){
                paymentReceiveDatePost = Date.parse(String.valueOf(p.paymentReceiveDatePost));
                
            }   
            
            Decimal outstandinAmount=   supplierOutStandingAmt.get(p.Billpaysupplier);
            decimal amt =outstandinAmount	;
            decimal amountdata = Decimal.valueOf(p.Amount != null?p.Amount.trim():'-0.00');
            if(isSupplierBills){
                if(amountdata <= outstandinAmount)
                {
                    if(SupplierbillsMap.get(p.Billpaysupplier) != null){
                        Bill_Pay__c Billpay = new Bill_Pay__c(
                            Supplier_Bill__c = SupplierbillsMap.get(p.Billpaysupplier),
                            Payment_Date__c=reconciliationDate,
                            Post_Date__c = paymentReceiveDate,
                            Chart_of_Account__c	=ChartofAccMap.get(p.ChartofAccount),
                            Payment_Form__c=p.PaymentForm,
                            Payment_Memo__c=p.PaymentMemo,
                            Reconciliation_Notes__c=p.ReconciliationNotes,
                            Debit_from_Account__c=p.DebitToAccount,
                            Payment_Amount__c	 =amountdata);
                         List<String> payformStatus = RECEIVE_PAYMENTS_PAYMENT_PAYMENTFORM.split(',');
                    
                    if(payformStatus.contains(p.PaymentForm))  {
                            createBillpays.add(Billpay);
                            successBillSuppliers.add(p.Billpaysupplier);
                            r.data.put('successBillSuppliers', successBillSuppliers);
                        }
                        else
                        {
                            Warnings.add(String.format(ERR_MSG_RECEIVE_PAYMENTS_VALID_PAYMENT_FORM, new List<String>{String.valueOf(p.Billpaysupplier)}));
                            
                            r.data.put('warning', String.join(Warnings, ', ')); 
                            
                            
                        }
                        
                    }
                    continue;
                }
                else{
                    errors.add(String.format(ERR_MSG_PAYMENT_AMOUNT,new List<String>{String.valueOf(p.Ponumber),String.valueOf(p.Billpaysupplier),String.valueOf(amt)}));
                    continue;
                }  
            }
            
            else{
                if(String.isNotBlank(p.ReconciliationDate)){
                    reconciliationDate = Date.parse(String.valueOf(p.ReconciliationDate));
                }  
                
                if(invoicesMap.get(p.InvoiceNumber) != null){
                    Receive_Payment__c rp = new Receive_Payment__c(
                        Invoice__c = invoicesMap.get(p.InvoiceNumber),
                        RecordTypeId = recordTypeIdsMap.get(p.RecordType),
                        Payment_Form__c = p.PaymentForm,
                        Payment_Amount__c = Decimal.valueOf(p.Amount != null?p.Amount.trim():'0'),
                        Reference__c = p.Reference,
                        Payment_Memo__c = p.PaymentMemo,
                        Payment_Received_Date__c = reconciliationDate,
                        Posted_Date__c =paymentReceiveDatePost ,
                        Reconciliation_Notes__c = p.ReconciliationNotes,
                        Credit_to_Account__c = p.CreditToAccount);
                    List<String> payformStatus = RECEIVE_PAYMENTS_PAYMENT_PAYMENTFORM.split(',');
                    
                    if(payformStatus.contains(p.PaymentForm))  {
                                                       
                         createPayments.add(rp);
                        successBillSuppliers.add(p.InvoiceNumber);
                        r.data.put('successBillSuppliers', successBillSuppliers);    
                        } 
                    else
                    {
                        Warnings.add(String.format(ERR_MSG_RECEIVE_PAYMENTS_VALID_PAYMENT_FORM, new List<String>{String.valueOf(p.InvoiceNumber)}));
                        
                        r.data.put('warning', String.join(Warnings, ', ')); 
                        
                        
                    }
                   

                  /* if(p.PaymentForm == RECEIVE_PAYMENTS_PAYMENT_FORM_CASH || p.PaymentForm == RECEIVE_PAYMENTS_PAYMENT_FORM_WIRE || p.PaymentForm == RECEIVE_PAYMENTS_PAYMENT_FORM_CHECK ||  p.PaymentForm == RECEIVE_PAYMENTS_PAYMENT_FORM_CREDIT_CARD || p.PaymentForm == RECEIVE_PAYMENTS_PAYMENT_FORM_DEBIT_CARD||p.PaymentForm == RECEIVE_PAYMENTS_PAYMENT_FORM_ACH  ||p.PaymentForm == RECEIVE_PAYMENTS_PAYMENT_FORM_CLEARING_ACCOUNT ||p.PaymentForm == RECEIVE_PAYMENTS_PAYMENT_EXCISETAX )
                    {
                        createPayments.add(rp);
                        successBillSuppliers.add(p.InvoiceNumber);
                        r.data.put('successBillSuppliers', successBillSuppliers);
                    }
                    else
                    {
                        Warnings.add(String.format(ERR_MSG_RECEIVE_PAYMENTS_VALID_PAYMENT_FORM, new List<String>{String.valueOf(p.InvoiceNumber)}));
                        
                        r.data.put('warning', String.join(Warnings, ', ')); 
                        
                        
                    }
                    */
                    
              //  }
                    if(p.CreditToAccount != null){
                        if(creditToAccountMap.containsKey(p.CreditToAccount)){ creditToAccountMap.get(p.CreditToAccount).add(rp);
                      }else{
                       creditToAccountMap.put(p.CreditToAccount, new Receive_Payment__c[]{rp});
                            }
                    }
                }
                else{
                    errorsinvoice.add(String.format(ERR_MSG_INVOICE_DOES_NOT_EXIT,new List<String>{String.valueOf(p.InvoiceNumber)}));
                    
                    
                }            
            }                   
             
        } 
            
        try{
            r.data.put('error', String.join(errors, ', ')); 
            r.data.put('errorinv', String.join(errorsinvoice, ', ')); 
            
            if(!createBillpays.isEmpty()){	
                insert createBillpays;
                r.data.put('message', createBillpays.size());
            }
            
            if(!createPayments.isEmpty()){
                insert createPayments;
                r.data.put('messagePayments', createPayments.size());
                
                
            }
        }
        catch(Exception e){
            throw new AuraHandledException(e.getMessage());	
        }
        return r;
    }
    
    
    
    public static String[] createBankRegisterEntry(Map<String,Receive_Payment__c[]> creditToAccountMap,String entityToPay){
        String[] errors = new String[]{};
            Register_Entry_Line__c[] reLines = new Register_Entry_Line__c[]{};
                if(creditToAccountMap.size() > 0){
                    Bank_Register__c [] bankRegisters = [SELECT Id,Name,Bank_Name__c, Starting_Balance__c,
                                                         (Select Old_Balance__c, Credit_Amount__c,
                                                          Debit_Amount__c, Running_Balance__c
                                                          From Register_Entry_Lines__r
                                                          Order By Id ASC) FROM Bank_Register__c WHERE Bank_Name__c IN: creditToAccountMap.keySet()];
                    Map<String,Bank_Register__c> bankRegisterMap = new Map<String,Bank_Register__c>();
                    for(Bank_Register__c br: bankRegisters){
                        bankRegisterMap.put(br.Bank_Name__c, br);
                    }
                    Register_Entry_Line__c[] allRELines = new Register_Entry_Line__c[]{};
                        for(String bankName: creditToAccountMap.keySet()){
                            if(bankRegisterMap.containsKey(bankName)){
                                Receive_Payment__c[] rps = creditToAccountMap.get(bankName);
                                if(rps != null && rps.size() > 0){
                                    allRELines.addAll(createRegisterEntryLines(bankRegisterMap.get(bankName),rps,entityToPay));
                                }
                            }
                        }
                    if(!allRELines.isEmpty()){
                        for (Database.SaveResult sr:Database.insert(allRELines, false)) {
                            if(!sr.isSuccess()){
                                for(Database.Error err : sr.getErrors()) {
                                    errors.add(err.getMessage());
                                }
                            }
                        }
                    }
                }
        return errors;
    }
    public static Register_Entry_Line__c[] createRegisterEntryLines(Bank_Register__c br,Receive_Payment__c[] rps,String entityToPay){
        String recordTypeName = entityToPay == INVOICE_SOBJECT_API_NAME ? REGISTER_ENTRY_LINE_RECORD_TYPE_DEPOSIT :REGISTER_ENTRY_LINE_RECORD_TYPE_PAYMENT;
        rps = [Select Reconciliation_Notes__c,
               Posted_Date__c,
               Payment_Amount__c,
               Invoice__r.Receiver_Name__c,
               Bill_Pay__r.Supplier_Name__c,
               Name
               From Receive_Payment__c
               Where Id IN : rps];
        Register_Entry_Line__c[] reLines = new Register_Entry_Line__c[]{};
            for(Receive_Payment__c receivePaymentSO: rps){
                Register_Entry_Line__c registerEntrySO = new Register_Entry_Line__c();
                registerEntrySO.Entry_Date__c = receivePaymentSO.Posted_Date__c;
                registerEntrySO.Entry_Memo__c = receivePaymentSO.Reconciliation_Notes__c;
                registerEntrySO.Related_Payment__c = receivePaymentSO.Id;
                registerEntrySO.Reconciled__c = false;
                // For invoice, store payment amount value as credit amount in bank
                if(entityToPay == INVOICE_SOBJECT_API_NAME){
                    registerEntrySO.Credit_Amount__c = receivePaymentSO.Payment_Amount__c;
                    registerEntrySO.Payee__c = receivePaymentSO.Invoice__r.Receiver_Name__c;
                }else if(entityToPay == PURCHASE_ORDER_SOBJECT_API_NAME){
                    registerEntrySO.Debit_Amount__c = receivePaymentSO.Payment_Amount__c;
                }
                registerEntrySO.Old_Balance__c = getOldBalanceOfRegisterEntry(br);
                registerEntrySO.RecordTypeId = getRecordTypeId(REGISTER_ENTRY_LINE_SOBJECT_API_NAME,recordTypeName);
                registerEntrySO.Bank_Register__c = br.Id;
                reLines.add(registerEntrySO);
            }
        return reLines;
    }
    public static Id getRecordTypeId(String objectAPIName, String recordTypeName){
        Schema.DescribeSObjectResult sobjectResult = Schema.getGlobalDescribe().get(objectAPIName).getDescribe();
        return sobjectResult.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
    }
    public static Decimal getOldBalanceOfRegisterEntry(Bank_Register__c br){
        Decimal oldBalance = 0;
        if(br.Register_Entry_Lines__r == null || br.Register_Entry_Lines__r.size() == 0){
            oldBalance =  0.0;
        }else{
            oldBalance = br.Register_Entry_Lines__r[br.Register_Entry_Lines__r.size() - 1].Running_Balance__c;
        }
        return oldBalance;
    }
    public class Payment{
        public String InvoiceNumber{get;set;}
        public String PONumber{get;set;}
        public String BQNumber{get;set;}
        public String RecordType{get;set;}
        public String PaymentForm{get;set;}
        public String Amount{get;set;}
        public String Reference{get;set;}
        public String PaymentMemo{get;set;}
        public String paymentReceiveDate{get;set;}
        public String paymentReceiveDatePost{get;set;}
        public String ReconciliationDate{get;set;}
        public String ReconciliationNotes{get;set;}
        public String CreditToAccount{get;set;}
        public String DebitToAccount{get;set;}
        public String ChartofAccount{get;set;}
        public String Billpaysupplier{get;set;}
        public decimal amountdata{get;set;}
        
        
        
    }
}