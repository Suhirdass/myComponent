/**
* Copyright (c) 2018 Filigreen Distro
* All rights reserved.
* ReceivePaymentEditOverrideController
*/
public class ReceivePaymentEditOverrideController{
        public Map<String, String> getPaymentformStatusData { get; set; }

    private static final String SAVE = 'Save';
    private string rpPrefix;
    private ApexPages.StandardController stdController;
    public Receive_Payment__c receivePaymentObj {get; set;}
    public Invoice__c invoiceObj {get; set;}
    public List<Invoice__c> lstinvoice {get; set;}
    public List<Invoice__c> lstinvoices {get; set;}
    public List<BankDetailsWrapper> bankDetails {get; set;}
    public Id selectedBankRegisterId {get; set;}
    public Bank_Register__c associatedBank {get; set;}
    public String actionType {get; set;}
    public static String message;
    public static String RPRecordTypeID;
    public static String RPProductRecordTypeID;
    
    
    private Static String RECEIVE_PAYMENTS_ERR_PROVIDE_PAYMENT_FORM{
        
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_ERR_PROVIDE_PAYMENT_FORM) ? RECEIVE_PAYMENTS_ERR_PROVIDE_PAYMENT_FORM : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Err_Provide_Payment_Form');
        }set;
    }
    public Static String RECEIVE_PAYMENTS_ERR_SELECT_BANK_AVAILABLE_RECONCILE{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_ERR_SELECT_BANK_AVAILABLE_RECONCILE) ? RECEIVE_PAYMENTS_ERR_SELECT_BANK_AVAILABLE_RECONCILE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Err_Select_Bank_Available_Reconcile');
        }set;
    }
    private Static String RECEIVE_PAYMENTS_ERR_PROVIDE_RECONCILATION_DATE_AND_INFORMATION {
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_ERR_PROVIDE_RECONCILATION_DATE_AND_INFORMATION) ? RECEIVE_PAYMENTS_ERR_PROVIDE_RECONCILATION_DATE_AND_INFORMATION : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Err_Reconciliatio_Posted_Date');
        }set;
    }
    public Static String RECEIVE_PAYMENTS_ERR_PROVIDE_INVOICE_NUMBER {
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_ERR_PROVIDE_INVOICE_NUMBER) ? RECEIVE_PAYMENTS_ERR_PROVIDE_INVOICE_NUMBER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Err_Provide_Invoice_Number');
        }set;
    }
    
    private Static String RECEIVE_PAYMENTS_ERR_SELECT_BANK_REGISTER{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_ERR_SELECT_BANK_REGISTER) ? RECEIVE_PAYMENTS_ERR_SELECT_BANK_REGISTER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Err_Select_Bank_Register');
        }set;
    }
    public Static String RECEIVE_PAYMENTS_CHECK_CREDIT_CARD{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_CHECK_CREDIT_CARD) ? RECEIVE_PAYMENTS_CHECK_CREDIT_CARD : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Err_Checking_CreditCard');
        }set;
    }
    public Static String RECEIVE_PAYMENTS_CHECK_PAYMENT_MEMO_LENGTH{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_CHECK_PAYMENT_MEMO_LENGTH) ? RECEIVE_PAYMENTS_CHECK_PAYMENT_MEMO_LENGTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Err_Checking_Payment_Memo');
        }set;
    }
    public Static String RECEIVE_PAYMENTS_CHECK_REFERNCE_LENGTH{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_CHECK_REFERNCE_LENGTH) ? RECEIVE_PAYMENTS_CHECK_REFERNCE_LENGTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Err_Reference_Length');
        }set;
    }
    public Static String RECEIVE_PAYMENTS_CHECK_RECONCILIATION {
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_CHECK_RECONCILIATION) ? RECEIVE_PAYMENTS_CHECK_RECONCILIATION : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Err_Reconciliation_Length');
        }set;
    }
    public Static String RECEIVE_PAYMENTS_CHECK_SECURITY_CODE_LENGTH {
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_CHECK_SECURITY_CODE_LENGTH) ? RECEIVE_PAYMENTS_CHECK_SECURITY_CODE_LENGTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Err_Security_Code_Length');
        }set;
    }
    public Static String Validation_Msg_for_insert_update_RecePay{
        get{
            return String.isNotBlank(Validation_Msg_for_insert_update_RecePay) ? Validation_Msg_for_insert_update_RecePay: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','Validation_Msg_for_insert_update_RecePay');
        }set;
    }
    
    
    Private Static String RECEIVE_PAYMENTS_RECORD_TYPE_CREDITMEMO{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_CREDITMEMO) ? RECEIVE_PAYMENTS_RECORD_TYPE_CREDITMEMO : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_CreditCard');
        }set;
    }
    public Static String INVOICE_RECORD_TYPE_PRODUCT{
        get{
            return String.isNotBlank(INVOICE_RECORD_TYPE_PRODUCT) ? INVOICE_RECORD_TYPE_PRODUCT	 : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Product');
        }set;
    }
    Private Static String RECEIVE_PAYMENTS_OBJ{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_OBJ) ? RECEIVE_PAYMENTS_OBJ : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','ReceivePayment_Obj');
        }set;
    }
    Private Static String RECEIVE_PAYMENTS_FIELD_PAYMENTFORM{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_FIELD_PAYMENTFORM) ? RECEIVE_PAYMENTS_FIELD_PAYMENTFORM : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','ReceivePayment_Field_PaymentForm');
        }set;
    }
    Private Static String RECEIVE_PAYMENTS_FIELD_BANKNAME{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_FIELD_BANKNAME) ? RECEIVE_PAYMENTS_FIELD_BANKNAME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','ReceivePayment_Field_BankName');
        }set;
    }
    public Static String RECEIVE_PAYMENTS_RECORD_TYPE_BILLPAY{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_BILLPAY) ? RECEIVE_PAYMENTS_RECORD_TYPE_BILLPAY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_BillPay');
        }set;
    }
    Private Static String INVOICE_OBJ_NAME{
        get{
            return String.isNotBlank(INVOICE_OBJ_NAME) ? INVOICE_OBJ_NAME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_obj_Name');
        }set;
    }
    public Static String PO_OBJ_NAME{
        get{
            return String.isNotBlank(PO_OBJ_NAME) ? PO_OBJ_NAME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase_Order_Obj_Name');
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
    Private Static String RECEIVE_PAYMENTS_PAYMENT_FORM_CHECK{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_PAYMENT_FORM_CHECK) ? RECEIVE_PAYMENTS_PAYMENT_FORM_CHECK : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Payment_Form_Check');
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
     Private Static String RECEIVE_PAYMENTS_PAYMENT_FORM_CREDIT_MEMO{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_PAYMENT_FORM_CREDIT_MEMO) ? RECEIVE_PAYMENTS_PAYMENT_FORM_CREDIT_MEMO : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Payment_Form_Credit_Memo');
        }set;
    }
     Private Static String RECEIVE_PAYMENTS_PAYMENT_FORM_AP_NEETING{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_PAYMENT_FORM_AP_NEETING) ? RECEIVE_PAYMENTS_PAYMENT_FORM_AP_NEETING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Payment_Form_Ap_Netting');
        }set;
    }
      Private Static String RECEIVE_PAYMENTS_PAYMENT_FORM_BAD_DEBIT{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_PAYMENT_FORM_BAD_DEBIT) ? RECEIVE_PAYMENTS_PAYMENT_FORM_BAD_DEBIT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Payment_Form_Bad_Debt');
        }set;
    }
      Private Static String RECEIVE_PAYMENTS_PAYMENT_FORM_BOUNCED_CHECK{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_PAYMENT_FORM_BOUNCED_CHECK) ? RECEIVE_PAYMENTS_PAYMENT_FORM_BOUNCED_CHECK : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Payment_Form_Bounced_Check');
        }set;
    }
    Private Static String RECEIVE_PAYMENTS_PAYMENT_FORM_CHARGE_OFF{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_PAYMENT_FORM_CHARGE_OFF) ? RECEIVE_PAYMENTS_PAYMENT_FORM_CHARGE_OFF : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Payment_Form_Charge_Off');
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
    
    Private Static String INVOICE_RECORD_TYPE_CREDIT_MEMO{
        get{
            return String.isNotBlank(INVOICE_RECORD_TYPE_CREDIT_MEMO) ? INVOICE_RECORD_TYPE_CREDIT_MEMO : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','INVOICE_RECORD_TYPE_CREDIT_MEMO');
        }set;
    }
    
    Private Static String Invoice_Record_Type_Factoring{
        get{
            return String.isNotBlank(Invoice_Record_Type_Factoring) ? Invoice_Record_Type_Factoring : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Factoring');
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
      
    
    // Constructor
    public ReceivePaymentEditOverrideController(ApexPages.StandardController controller) {
        this.stdController = controller;
        receivePaymentObj = (Receive_Payment__c)stdController.getRecord();
        String recordTypeParamValue = ApexPages.currentPage().getParameters().get('RecordType');        
        if(recordTypeParamValue !=null){ receivePaymentObj.RecordTypeId=recordTypeParamValue ;
                                       }
        init();
    }
    
    public ReceivePaymentEditOverrideController(ApexPages.StandardSetController controller) {
        String billPayId = ApexPages.currentPage().getParameters().get('id');
        receivePaymentObj = new Receive_Payment__c();
        receivePaymentObj.Bill_Pay__c = billPayId;
        init();
    }
    
    public ReceivePaymentEditOverrideController(){}
    
    @AuraEnabled
    public static AuraResponse receivePaymentEditOverride(String recordId,String invoiceId,String recordTypesId,String billId){
        AuraResponse r = new AuraResponse('ReceivePaymentEditOverrideController.receivePaymentEditOverride()'); 
        ReceivePaymentEditOverrideController receive  = new ReceivePaymentEditOverrideController();
        RPRecordTypeID   = Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get(RECEIVE_PAYMENTS_RECORD_TYPE_CREDITMEMO).getRecordTypeId();
        RPProductRecordTypeID   = Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get(RECEIVE_PAYMENTS_RECORD_TYPE_PRODUCT).getRecordTypeId();
        List<Invoice__c> lstinvoice = [SELECT id, Name,RecordTypeId,RecordType.name,IsLocked__c FROM Invoice__c where id=:invoiceId];
        boolean invRPCreditMemo = False;
        boolean RPCreditMemo = False;
        boolean nonCreditMemo = False;
        if(lstinvoice.size()>0){
            if(RPRecordTypeID == recordTypesId &&  lstinvoice[0].RecordType.Name == RECEIVE_PAYMENTS_RECORD_TYPE_CREDITMEMO){
                //invRPCreditMemo = True;
                
            }else if( lstinvoice[0].RecordType.Name != INVOICE_RECORD_TYPE_CREDIT_MEMO){//RPRecordTypeID != recordTypesId || RPProductRecordTypeID == recordTypesId) && (lstinvoice[0].RecordType.Name == INVOICE_RECORD_TYPE_PRODUCT || lstinvoice[0].RecordType.Name == INVOICE_RECORD_TYPE_SERVICE || lstinvoice[0].RecordType.Name == INVOICE_RECORD_TYPE_TAX || lstinvoice[0].RecordType.Name == INVOICE_RECORD_TYPE_CREDIT_MEMO || lstinvoice[0].RecordType.Name == INVOICE_RECORD_TYPE_FACTORING) 
                RPCreditMemo= True;  r.data.put('RPCreditMemo',RPCreditMemo);
                
            }else if(RPRecordTypeID != recordTypesId && lstinvoice[0].RecordType.Name != INVOICE_RECORD_TYPE_PRODUCT)
            {
                nonCreditMemo=True; r.data.put('nonCreditMemo',nonCreditMemo);
                
            }
        }
        if(recordId != null && !String.isBlank(recordId)){
            List<Receive_Payment__c> lstReceive = [select id,Name,Invoice__c,Bill_Pay__c,Bill_Pay__r.Name,Invoice__r.Name,Payment_Memo__c,Bank_Name__c,
                                                   Payment_Received_Date__c,Payment_Form__c,Payment_Amount__c,Reference__c,RecordTypeId,Credit_Memo__c,Credit_Memo__r.Name,
                                                   Credit_Card_Number__c,Valid_Thru_Month__c,Security_Code__c,Valid_Thru_Year__c,
                                                   Posted_Date__c,Reconciliation_Notes__c
                                                   from Receive_Payment__c where id =: recordId];
            
            
            
            if(lstReceive.size() > 0)
                receive.receivePaymentObj = lstReceive[0];    
        } else {
            receive.receivePaymentObj = new Receive_Payment__c();  
            if(recordTypesId != null){receive.receivePaymentObj.recordTypeId = recordTypesId; 
                                     }
            if(invoiceId != null && invoiceId != ''){
                List<Invoice__c> lstInv = [select Id,Name from Invoice__c where Id =: invoiceId];
                if(invRPCreditMemo){
                    r.data.put('invRPCreditMemo',invRPCreditMemo);
                    receive.receivePaymentObj.Invoice__c = null;
                    receive.receivePaymentObj.Invoice__r = null;   
                    receive.receivePaymentObj.Credit_Memo__c = lstInv[0].Id;
                    receive.receivePaymentObj.Credit_Memo__r = lstInv[0];
                    
                }else{
                    r.data.put('invRPCreditMemo',invRPCreditMemo);
                    r.data.put('RPCreditMemo',RPCreditMemo);
                    receive.receivePaymentObj.Invoice__c = lstInv[0].Id;
                    receive.receivePaymentObj.Invoice__r = lstInv[0];    
                }
                
            }
            if(billId != null && billId != ''){
                List<Purchase_Order__c> lstInv = [select Id,Name from Purchase_Order__c where Id =: billId];
                if(lstInv.size() > 0){
                    receive.receivePaymentObj.Bill_Pay__c = lstInv[0].Id;  receive.receivePaymentObj.Bill_Pay__r = lstInv[0];    
                }
            }
        }
        receive.init();
        receive.retrieveBankDetails(); 
        
        List<Map<String, String>> paymentForm = Utility.getPicklistItems(RECEIVE_PAYMENTS_OBJ,RECEIVE_PAYMENTS_FIELD_PAYMENTFORM);
        List<Map<String, String>> bankNames = Utility.getPicklistItems(RECEIVE_PAYMENTS_OBJ,RECEIVE_PAYMENTS_FIELD_BANKNAME);
        
        r.data.put('records',receive.receivePaymentObj);
        receive.getPaymentformStatusData =getLabStatus();
        //  r.data.put('paymentForm',receive.getLabStatus());
        r.data.put('paymentForm', receive.getPaymentformStatusData);
        r.data.put('bankNames',bankNames);
        r.data.put('lstinvoice',lstinvoice);
        r.data.put('Validation_Msg_for_insert_update_RecePay',Validation_Msg_for_insert_update_RecePay);
        r.data.put('associatedBank',receive.associatedBank);
        r.data.put('bankDetails',receive.bankDetails);
        r.data.put('selectedBankRegisterId',receive.selectedBankRegisterId);
        r.data.put('rpPrefix',receive.rpPrefix);
        return r;
    }
    
 @AuraEnabled
    public static Map<String, String> getLabStatus(){
        Map<String, String> options = new Map<String, String>();
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_ACH,RECEIVE_PAYMENTS_PAYMENT_FORM_ACH);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_AP_NEETING,RECEIVE_PAYMENTS_PAYMENT_FORM_AP_NEETING);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_BOUNCED_CHECK,RECEIVE_PAYMENTS_PAYMENT_FORM_BOUNCED_CHECK);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_BAD_DEBIT,RECEIVE_PAYMENTS_PAYMENT_FORM_BAD_DEBIT);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CASH,RECEIVE_PAYMENTS_PAYMENT_FORM_CASH);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CHARGE_OFF,RECEIVE_PAYMENTS_PAYMENT_FORM_CHARGE_OFF);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CHECK,RECEIVE_PAYMENTS_PAYMENT_FORM_CHECK);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CREDIT_MEMO,RECEIVE_PAYMENTS_PAYMENT_FORM_CREDIT_MEMO);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CLEARING_ACCOUNT,RECEIVE_PAYMENTS_PAYMENT_FORM_CLEARING_ACCOUNT);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CREDIT_CARD,RECEIVE_PAYMENTS_PAYMENT_FORM_CREDIT_CARD);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_DEBIT_CARD,RECEIVE_PAYMENTS_PAYMENT_FORM_DEBIT_CARD);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_EXCISETAX_DEPOSIT,RECEIVE_PAYMENTS_PAYMENT_FORM_EXCISETAX_DEPOSIT);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_WIRE,RECEIVE_PAYMENTS_PAYMENT_FORM_WIRE);
        return options;
    }    
    /**
* Initialize the constructor for standard and standard set controller
*/
    public void init(){
        bankDetails = new List<BankDetailsWrapper>();
        associatedBank = new Bank_Register__c();
        actionType = SAVE;
        rpPrefix = getObjectPrefix(RECEIVE_PAYMENTS_OBJ);
    }
    
    public class UserException extends Exception {}
    
    /**
* Retrieve all bank register details
*/
    public PageReference retrieveBankDetails() {
        
        // Check if Receive Payment is created or edited
        // If it is created then check if it is created from Invoice or from PO
        // If it is created from Invoice then redirect it to Record Type selection page
        // Make sure it redirects to record type selection page only once by checking record type Id 
        PageReference pageRef;
        if(receivePaymentObj.Id == null && receivePaymentObj.Invoice__c != null && receivePaymentObj.RecordTypeId == null){
            String invoiceURLParameter = ApexPages.currentPage().getParameters().get(Label.Invoice_Field_Id_For_Receive_Payment);
          
        }
        
        Boolean isSelected = true;
        for(Bank_Register__c bankRegisterSO : [Select Account__r.dBA__c, 
                                               Bank_Name__c, 
                                               Register_Type__c,
                                               Account_Number__c,
                                               Routing_Number__c,Account__r.Name,Total_Running_Balance_Amount__c,
                                               (Select Id From Register_Entry_Lines__r
                                                Where Related_Payment__c =: receivePaymentObj.Id LIMIT 1)
                                               From Bank_Register__c
                                               Where Active__c = true]){
                                                   BankDetailsWrapper bankDetailsWrapper = new BankDetailsWrapper(bankRegisterSO);
                                                   
                                                   if(receivePaymentObj != null && receivePaymentObj.Id != null && 
                                                      bankRegisterSO.Register_Entry_Lines__r.size() == 1){
                                                          associatedBank = bankRegisterSO;
                                                          selectedBankRegisterId = bankRegisterSO.Id;
                                                      }
                                                   bankDetails.add(bankDetailsWrapper);
                                               }
        return pageRef;
    }
    
    /**
* Save Receive Payment and related bank register entry Light
*/
    @AuraEnabled
    public static AuraResponse doSaveActionLight(Receive_Payment__c receivePaymentObj,Id selectedBankRegisterId) {
        //boolean creditcheck, string creditmemo,boolean creditmemorps,boolean creditcheckmemo, string inrec
        AuraResponse r = new AuraResponse('ReceivePaymentEditOverrideController.doSaveActionLight()'); 
        ReceivePaymentEditOverrideController receive  = new ReceivePaymentEditOverrideController();
        // Perform validations
        if(validateInputLight(receivePaymentObj,selectedBankRegisterId)){  r.data.put('Error', message);
            return r;
        }
        
        Savepoint savePoint;
        try{
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            // Set Record Type of Receive Payment if created from PO
            if(receivePaymentObj.Bill_Pay__c != null){  receivePaymentObj.RecordTypeId = getRecordTypeId(RECEIVE_PAYMENTS_OBJ, RECEIVE_PAYMENTS_RECORD_TYPE_BILLPAY);
            }
            upsert receivePaymentObj;
                           List<Receive_Payment__c> lstrp = new list<Receive_Payment__c>();

               
            // Generate bank entry id reconciliation date is provided
            if(receivePaymentObj.Posted_Date__c != null){
                if(selectedBankRegisterId != null){
                    BankRegisterSupport.generateBankEntryRelatedToReceivePayment(receivePaymentObj.Id,selectedBankRegisterId, receive.getParentObjectName(receivePaymentObj));
	                }
            }
            r.data.put('record', receivePaymentObj); return r;
            
            
        }catch(Exception ex){
            Database.rollback(savePoint);
            message = 'Exception occured while updating Receive Payment record: ' + ex.getMessage();


           r.data.put('Error', message);
            return r;
        }
    }
    
    
    /**
* Save Receive Payment and related bank register entry
*/
    public PageReference doSaveAction() {
        
        // Perform validations
        if(validateInputs()){
            return null;
        }
        
        PageReference pageRef;
        
        Savepoint savePoint;
        try{
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            
            // Set Record Type of Receive Payment if created from PO
            if(receivePaymentObj.Bill_Pay__c != null){receivePaymentObj.RecordTypeId = getRecordTypeId(RECEIVE_PAYMENTS_OBJ, RECEIVE_PAYMENTS_RECORD_TYPE_BILLPAY);
            }
            
            upsert receivePaymentObj;
            // Generate bank entry id reconciliation date is provided
            if(receivePaymentObj.Posted_Date__c != null){
                
                // If bank register is selected then create register entry line for that bank
                if(selectedBankRegisterId != null){
                    BankRegisterSupport.generateBankEntryRelatedToReceivePayment(receivePaymentObj.Id, 
                                                                                 selectedBankRegisterId,
                                                                                 getParentObjectName(receivePaymentObj));
                }
            }
            
            String newRPURL = '';
            
            if(actionType == SAVE){
                pageRef = new PageReference('/'+receivePaymentObj.Id);
            }else{
                newRPURL = '/apex/ReceivePaymentEditOverride?';
                newRPURL += receivePaymentObj.Invoice__c != null ? 
                    Label.Invoice_Field_Id_For_Receive_Payment + '=' + receivePaymentObj.Invoice__c :
                Label.PO_Field_Id_For_Receive_Payment + '=' + receivePaymentObj.Bill_Pay__c;
                newRPURL += '&RecordType=' + receivePaymentObj.RecordTypeId +
                    '&save_new=1&sfdc.override=1';
                pageRef = new PageReference(newRPURL);
            }
            
            pageRef.setRedirect(true);
            return pageRef;
            
        }catch(Exception ex){
            
            Database.rollback(savePoint);
            
        }
        return null;
    }
    
    public class BankDetailsWrapper{
        @AuraEnabled public Bank_Register__c bankRegisterSO {get; set;}
        
        public BankDetailsWrapper(Bank_Register__c bankRegisterSO){
            this.bankRegisterSO = bankRegisterSO;
        }
    }
    
    
    public static Boolean validateInputLight(Receive_Payment__c receivePaymentObj,Id selectedBankRegisterId){
        Boolean hasValidationError = false;
        integer creditCardLength;
       integer ReconciliationLength;
               integer PaymentmemoLength;
               integer ReferenceLength ;
       integer SecurityLength;

     
        if(receivePaymentObj.Payment_Form__c == null){ message = RECEIVE_PAYMENTS_ERR_PROVIDE_PAYMENT_FORM;
            hasValidationError = true;
        }
         if(receivePaymentObj.Payment_Form__c == null){  message = RECEIVE_PAYMENTS_ERR_PROVIDE_PAYMENT_FORM;
            hasValidationError = true;
        }
        // Check if bank register is selected while reconciliation date is not null
        else if(receivePaymentObj.Posted_Date__c != null && selectedBankRegisterId == null){message = RECEIVE_PAYMENTS_ERR_SELECT_BANK_AVAILABLE_RECONCILE;
            hasValidationError = true;
        }
        // Check if reconciliation dates and notes provided while selected bank register is not null
        else if(receivePaymentObj.Posted_Date__c == null && selectedBankRegisterId != null){ message =RECEIVE_PAYMENTS_ERR_PROVIDE_RECONCILATION_DATE_AND_INFORMATION;
            hasValidationError = true;
        }
      
        
        
        return hasValidationError;
        
    }
    
    /**
* Validate Receive payment attributes validation
*
* @return Boolean flag to indicate if any validation fails
*/
    public Boolean validateInputs(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        if(receivePaymentObj.Payment_Form__c == null){
            message = new ApexPages.Message(ApexPages.Severity.ERROR, RECEIVE_PAYMENTS_ERR_PROVIDE_PAYMENT_FORM);
            ApexPages.addMessage(message);
            hasValidationError = true;
        }
        // Check if bank register is selected while reconciliation date is not null
        else if(receivePaymentObj.Posted_Date__c != null && selectedBankRegisterId == null){
            message = new ApexPages.Message(ApexPages.Severity.ERROR, RECEIVE_PAYMENTS_ERR_SELECT_BANK_REGISTER);
            ApexPages.addMessage(message);
            hasValidationError = true;
        }
        // Check if reconciliation dates and notes provided while selected bank register is not null
        else if(receivePaymentObj.Posted_Date__c == null && selectedBankRegisterId != null){
            message = new ApexPages.Message(ApexPages.Severity.ERROR, RECEIVE_PAYMENTS_ERR_PROVIDE_RECONCILATION_DATE_AND_INFORMATION);
            ApexPages.addMessage(message);
            hasValidationError = true;
        }
        return hasValidationError;
    }
    
    /**
* Cancel action of Receive payment page
* If Id found then redirect to detail page otherwise redirect to invoice home page
*/
    public PageReference doCancelAction() {
        PageReference pageRef;
        if(receivePaymentObj.Id != null){
            pageRef = new PageReference('/'+receivePaymentObj.Id);
        }else{
            String cancelURL;
            if(receivePaymentObj.Invoice__c != null){
                cancelURL = receivePaymentObj.Invoice__c;
            }else if(receivePaymentObj.Bill_Pay__c != null){
                cancelURL = receivePaymentObj.Bill_Pay__c;
            }else{
                cancelURL = rpPrefix;
            }
            pageRef = new PageReference('/' + cancelURL);
        }
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    /**
* Get object prefix
* @param objectName The name of object
* @return The 3 digit prefix of object
*/
    public String getObjectPrefix(String objectName) {
        return Schema.getGlobalDescribe().get(objectName).getDescribe().getKeyPrefix();
    }
    
    /**
* Get the parent object API name
* @param receivePaymentObj The Receive Payment object
* @return The parent object API name
*/
    public String getParentObjectName(Receive_Payment__c receivePaymentObj){
        String parentObjectName = '';
        if(receivePaymentObj.Invoice__c != null) {
            parentObjectName = INVOICE_OBJ_NAME;
        }else if(receivePaymentObj.Bill_Pay__c != null) {
            parentObjectName = PO_OBJ_NAME;
        }
        return parentObjectName;
    }
    
    /**
* Edit existing bank register entry related to Receive payment
* @param receivePaymentSO The Receive Payment record
* @param registerEntrySO The Register entry line record
*/
    public static Id getRecordTypeId(String objectAPIName, String recordTypeName){
        Schema.DescribeSObjectResult sobjectResult = Schema.getGlobalDescribe().get(objectAPIName).getDescribe();
        return sobjectResult.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
    }
}