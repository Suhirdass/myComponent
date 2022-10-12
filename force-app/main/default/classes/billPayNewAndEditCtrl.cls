public class billPayNewAndEditCtrl {
          public Map<String, String> getPaymentformStatusData { get; set; }

    private static final String SAVE = 'Save';
    private string rpPrefix;
    private ApexPages.StandardController stdController;
    public Bill_Pay__c billPayObj {get; set;}  public Supplier_Bill__c invoiceObj {get; set;}
    public List<Supplier_Bill__c> lstinvoice {get; set;}
    public List<BankDetailsWrapper> bankDetails {get; set;}
    public Id selectedBankRegisterId {get; set;}
    public Bank_Register__c associatedBank {get; set;}
    public String actionType {get; set;}
    public static String message;
    
      public Static String RECEIVE_PAYMENTS_ERR_PROVIDE_PAYMENT_FORM{

         get{
            return String.isNotBlank(RECEIVE_PAYMENTS_ERR_PROVIDE_PAYMENT_FORM) ? RECEIVE_PAYMENTS_ERR_PROVIDE_PAYMENT_FORM : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Err_Provide_Payment_Form');
        }set;
    }
     public Static String RECEIVE_PAYMENTS_ERR_SELECT_BANK_AVAILABLE_RECONCILE{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_ERR_SELECT_BANK_AVAILABLE_RECONCILE) ? RECEIVE_PAYMENTS_ERR_SELECT_BANK_AVAILABLE_RECONCILE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Err_Select_Bank_Available_Reconcile');
        }set;
    }
    public Static String RECEIVE_PAYMENTS_ERR_PROVIDE_RECONCILATION_DATE_AND_INFORMATION {
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_ERR_PROVIDE_RECONCILATION_DATE_AND_INFORMATION) ? RECEIVE_PAYMENTS_ERR_PROVIDE_RECONCILATION_DATE_AND_INFORMATION : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Err_Reconciliatio_Posted_Date');
        }set;
    }
     public Static String RECEIVE_PAYMENTS_ERR_PROVIDE_INVOICE_NUMBER {
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_ERR_PROVIDE_INVOICE_NUMBER) ? RECEIVE_PAYMENTS_ERR_PROVIDE_INVOICE_NUMBER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Err_Provide_Invoice_Number');
        }set;
    }
    
    public Static String RECEIVE_PAYMENTS_ERR_SELECT_BANK_REGISTER{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_ERR_SELECT_BANK_REGISTER) ? RECEIVE_PAYMENTS_ERR_SELECT_BANK_REGISTER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_Err_Select_Bank_Register');
        }set;
    }
       
    public Static String Validation_Msg_for_insert_update_RecePay{
        get{
            return String.isNotBlank(Validation_Msg_for_insert_update_RecePay) ? Validation_Msg_for_insert_update_RecePay: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','Validation_Msg_for_insert_update_RecePay');
        }set;
    }
    
    
     public Static String OBJECT_BILL_PAY {
        get{
            return String.isNotBlank(OBJECT_BILL_PAY) ? OBJECT_BILL_PAY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','Obj_Name_BillPay');
        }set;
    }
  Private Static String RECEIVE_PAYMENTS_FIELD_PAYMENTFORM{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_FIELD_PAYMENTFORM) ? RECEIVE_PAYMENTS_FIELD_PAYMENTFORM : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','ReceivePayment_Field_PaymentForm');
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
    
   
     public Static String RECEIVE_PAYMENTS_RECORD_TYPE_CLEARING_ACCOUNT{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_CLEARING_ACCOUNT) ? RECEIVE_PAYMENTS_RECORD_TYPE_CLEARING_ACCOUNT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_ClearingAccount');
        }set;
    }
     public Static String RECEIVE_PAYMENTS_RECORD_TYPE_CUTIVATION_TAX{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_CUTIVATION_TAX) ? RECEIVE_PAYMENTS_RECORD_TYPE_CUTIVATION_TAX : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_Cultivation_Tax');
        }set;
    }
     public Static String RECEIVE_PAYMENTS_RECORD_TYPE_EXCISETAX{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_EXCISETAX) ? RECEIVE_PAYMENTS_RECORD_TYPE_EXCISETAX : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_ExciseTax');
        }set;
    }
     public Static String RECEIVE_PAYMENTS_RECORD_TYPE_FACTORING{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_FACTORING) ? RECEIVE_PAYMENTS_RECORD_TYPE_FACTORING : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_Factoring');
        }set;
    }
     public Static String RECEIVE_PAYMENTS_RECORD_TYPE_LATECHARGE{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_LATECHARGE) ? RECEIVE_PAYMENTS_RECORD_TYPE_LATECHARGE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_LateCharge');
        }set;
    }	
     public Static String RECEIVE_PAYMENTS_RECORD_TYPE_LOCAL_CANNABIS_TAX{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_LOCAL_CANNABIS_TAX) ? RECEIVE_PAYMENTS_RECORD_TYPE_LOCAL_CANNABIS_TAX : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_LocalCannabisTax');
        }set;
    }
    public Static String RECEIVE_PAYMENTS_RECORD_TYPE_PRODUCT{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_PRODUCT) ? RECEIVE_PAYMENTS_RECORD_TYPE_PRODUCT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_Product');
        }set;
    }
    public Static String RECEIVE_PAYMENTS_RECORD_TYPE_RETURNCHECK{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_RETURNCHECK) ? RECEIVE_PAYMENTS_RECORD_TYPE_RETURNCHECK : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_ReturnCheck');
        }set;
    }	
     public Static String RECEIVE_PAYMENTS_RECORD_TYPE_SERVICE{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_SERVICE) ? RECEIVE_PAYMENTS_RECORD_TYPE_SERVICE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_Service');
        }set;
    }
    public Static String RECEIVE_PAYMENTS_RECORD_TYPE_WIREOFF{
        get{
            return String.isNotBlank(RECEIVE_PAYMENTS_RECORD_TYPE_WIREOFF) ? RECEIVE_PAYMENTS_RECORD_TYPE_WIREOFF : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Receive Payments','RP_RecordType_wireoff');
        }set;
    }
    public billPayNewAndEditCtrl(){}
    
    @AuraEnabled
    public static AuraResponse billPayNewAndEdit(String recordId,String SBIds){
        AuraResponse r = new AuraResponse('billPayNewAndEditCtrl.billPayNewAndEdit()'); 
        billPayNewAndEditCtrl receive  = new billPayNewAndEditCtrl();
        List<Supplier_Bill__c> lstinvoice = [SELECT id, Name ,Purchase_Order__r.Name FROM Supplier_Bill__c where id=:SBIds];
        
        if(recordId != null && !String.isBlank(recordId)){
            List<Bill_Pay__c> lstbillpay = [select id,Name,Supplier_Bill__c,Payment_Form__c,Purchase_Order__c,Payment_Memo__c,Payment_Amount__c,Payment_Date__c,Reconciliation_Notes__c
                                                   from Bill_Pay__c where id =: recordId];
            
            
            
            if(lstbillpay.size() > 0)
                receive.billPayObj = lstbillpay[0];    
        } else {
            receive.billPayObj = new Bill_Pay__c();  
           
            if(SBIds != null && SBIds != ''){ List<Supplier_Bill__c> lstsb= [select Id,Name ,Purchase_Order__r.Name from Supplier_Bill__c where Id =: SBIds];
                if(lstsb.size() > 0){ receive.billPayObj.Supplier_Bill__c = lstsb[0].Id;
                    receive.billPayObj.Supplier_Bill__r = lstsb[0];
                }
            }
         
        }
        receive.init();
        receive.retrieveBankDetails();
        
        List<Map<String, String>> paymentForm = Utility.getPicklistItems(OBJECT_BILL_PAY,RECEIVE_PAYMENTS_FIELD_PAYMENTFORM);
      
        r.data.put('records',receive.billPayObj);
         receive.getPaymentformStatusData =getLabStatus();
       r.data.put('paymentForm', receive.getPaymentformStatusData);
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
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CASH,RECEIVE_PAYMENTS_PAYMENT_FORM_CASH);
        options.put(RECEIVE_PAYMENTS_PAYMENT_FORM_CHECK,RECEIVE_PAYMENTS_PAYMENT_FORM_CHECK);
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
        rpPrefix = getObjectPrefix(OBJECT_BILL_PAY);
    }
    
    public class UserException extends Exception {}
    
    /**
* Retrieve all bank register details
*/
    public PageReference retrieveBankDetails() {
        
        PageReference pageRef;
  
        
        Boolean isSelected = true;
        for(Bank_Register__c bankRegisterSO : [Select Account__r.dBA__c, 
                                               Bank_Name__c, 
                                               Register_Type__c,
                                               Account_Number__c,
                                               Routing_Number__c,Account__r.Name,Total_Running_Balance_Amount__c,
                                               (Select Id From Register_Entry_Lines__r
                                                Where Bill_Pay__c =: billPayObj.Id LIMIT 1)
                                               From Bank_Register__c
                                               Where Active__c = true]){
                                                   BankDetailsWrapper bankDetailsWrapper = new BankDetailsWrapper(bankRegisterSO);
                                                   
                                                   if(billPayObj != null && billPayObj.Id != null && 
                                                      bankRegisterSO.Register_Entry_Lines__r.size() == 1){  associatedBank = bankRegisterSO;
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
    public static AuraResponse doSaveActionLight(Bill_Pay__c billPayObj,Id selectedBankRegisterId) {
        AuraResponse r = new AuraResponse('billPayNewAndEditCtrl.doSaveActionLight()'); 
        
        billPayNewAndEditCtrl receive  = new billPayNewAndEditCtrl();
           
         if(validateInputLight(billPayObj,selectedBankRegisterId)){
            r.data.put('Error', message);
            return r;
        }

        
        Savepoint savePoint;
        try{
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            
            upsert billPayObj;
           
              String parentObjectName = PO_OBJ_NAME;
            if(selectedBankRegisterId != null){BankRegisterSupport.generateBankEntryRelatedToBillPay(billPayObj.Id, selectedBankRegisterId,parentObjectName);
               }
            r.data.put('record', billPayObj);
            return r;
            
            
        }catch(Exception ex){Database.rollback(savePoint);message = 'Exception occured while updating Receive Payment record: ' + ex.getMessage();
           r.data.put('Error', message); return r;
        }
    }
    
    
    public class BankDetailsWrapper{
        @AuraEnabled public Bank_Register__c bankRegisterSO {get; set;}
        
        public BankDetailsWrapper(Bank_Register__c bankRegisterSO){
            this.bankRegisterSO = bankRegisterSO;
        }
    }
    
     public static Boolean validateInputLight(Bill_Pay__c billPayObj,Id selectedBankRegisterId){
        Boolean hasValidationError = false;
      

        if(billPayObj.Payment_Form__c == null){
            message = RECEIVE_PAYMENTS_ERR_PROVIDE_PAYMENT_FORM;
            hasValidationError = true;
        }
         if(billPayObj.Payment_Form__c == null){
            message = RECEIVE_PAYMENTS_ERR_PROVIDE_PAYMENT_FORM;
            hasValidationError = true;
        }
        // Check if bank register is selected while reconciliation date is not null
        else if(billPayObj.Post_Date__c != null && selectedBankRegisterId == null){
            message = RECEIVE_PAYMENTS_ERR_SELECT_BANK_AVAILABLE_RECONCILE;hasValidationError = true;
        }
        // Check if reconciliation dates and notes provided while selected bank register is not null
        else if(billPayObj.Post_Date__c == null && selectedBankRegisterId != null){message =RECEIVE_PAYMENTS_ERR_PROVIDE_RECONCILATION_DATE_AND_INFORMATION;
            hasValidationError = true;
        }
     
      
        
        return hasValidationError;
        
    }
  
    /**

  
    /**
* Get object prefix
* @param objectName The name of object
* @return The 3 digit prefix of object
*/
    public String getObjectPrefix(String objectName) {
        return Schema.getGlobalDescribe().get(objectName).getDescribe().getKeyPrefix();
    }
    

    /**
* Edit existing bank register entry related to Receive payment
* @param receivePaymentSO The Receive Payment record
* @param registerEntrySO The Register entry line record
*/
    public static Id getRecordTypeId(String objectAPIName, String recordTypeName){ Schema.DescribeSObjectResult sobjectResult = Schema.getGlobalDescribe().get(objectAPIName).getDescribe();
        return sobjectResult.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
    }
}