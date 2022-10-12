/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * InterBankAmountTransferController
 */
public class InterBankAmountTransferController{

    private ApexPages.StandardController stdController;
    public Bank_Register__c bankRegisterSO {get; set;}
    public Id selectedBankRegisterId {get; set;}
    public Id selectedPayee {get; set;}
    public Register_Entry_Line__c dummyRegisterEntry {get; set;}
    public BankTransferWrapper bankTransferObj {get; set;}
    public List<Bank_Register__c> bankDetails {get; set;}
    
    // Constructor
    public InterBankAmountTransferController(ApexPages.StandardController controller) {
        this.stdController = controller;
        bankRegisterSO = (Bank_Register__c)stdController.getRecord();
        bankTransferObj = new BankTransferWrapper();
        dummyRegisterEntry = new Register_Entry_Line__c();
        dummyRegisterEntry.Entry_Date__c = System.Today();
    }
    
    /**
     * Retrieve all bank register details
     */
    public void retrieveBankDetails() {
        bankDetails = [Select Account__r.dBA__c, 
                        Bank_Name__c, 
                        Register_Type__c,
                        Account_Number__c,
                        Routing_Number__c,
                        Total_Running_Balance_Amount__c,
                        Account__c
                       From Bank_Register__c
                       Where Active__c = true
                       AND Id != :bankRegisterSO.Id];
    }
    
    /**
     * Transfer Amount from source bank to transfer bank
     */
    public PageReference transferAmount(){
        if(checkValidation()){
            return null;
        }
        
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        try{
            registerEntries.add(createCreditDebitEntry(bankTransferObj, dummyRegisterEntry.Entry_Date__c, true));
            registerEntries.add(createCreditDebitEntry(bankTransferObj, dummyRegisterEntry.Entry_Date__c, false));
            insert registerEntries;
        }catch(DmlException e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Exception occrred while transfering amount: ' + e.getMessage()));
            return null;
        }
        return stdController.view();
    }
    
    /**
     * Create credit entry to transfer bank
     * Create debit entry to source bank
     * @param bankTransferObj The instance of BankTransferWrapper
     * @param isCredit The flag set to true for credit and set to false for debit
     *
     * @return The instance of Register entry line 
     */
    public Register_Entry_Line__c createCreditDebitEntry(BankTransferWrapper bankTransferObj, 
                                                         Date transactionDate,
                                                         Boolean isCredit){
        Register_Entry_Line__c registerEntrySO = new Register_Entry_Line__c();
        registerEntrySO.Entry_Date__c = transactionDate;
        registerEntrySO.Entry_Memo__c = bankTransferObj.paymentMemo;
        registerEntrySO.Reconciled__c = false;
        registerEntrySO.Reference__c = bankTransferObj.reference;
        
        // For credit, store payment amount value as credit amount in bank
        if(isCredit){
            registerEntrySO.Credit_Amount__c = bankTransferObj.amountToTransfer;
            registerEntrySO.Payee__c = selectedPayee;
            registerEntrySO.Bank_Register__c = selectedBankRegisterId;
        // For debit, store payment amount value as debit amount in bank
        }else{
            registerEntrySO.Debit_Amount__c = bankTransferObj.amountToTransfer;
            registerEntrySO.Payee__c = bankRegisterSO.Account__c;
            registerEntrySO.Bank_Register__c = bankRegisterSO.Id;
        }
        String recordTypeName = isCredit ? BankRegisterSupport.REGISTER_ENTRY_LINE_RECORD_TYPE_DEPOSIT :
                                           BankRegisterSupport.REGISTER_ENTRY_LINE_RECORD_TYPE_PAYMENT; 
        registerEntrySO.RecordTypeId = 
                   BankRegisterSupport.getRecordTypeId(BankRegisterSupport.REGISTER_ENTRY_LINE_SOBJECT_API_NAME, 
                                                       recordTypeName);
        return registerEntrySO;
    }
    
    /**
     * Perform validation before transferring amount
     *
     * @return Boolean flag to indicate if any validation fails
     */
    public Boolean checkValidation(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        
        // Target bank selection
        if(selectedBankRegisterId == null){
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            Label.SelectTargetBank);
            ApexPages.addMessage(message);
       
        // Valid amount to transfer
        }else if(bankTransferObj.amountToTransfer == null || bankTransferObj.amountToTransfer <= 0){
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            Label.Provide_Payment_Amount);
            ApexPages.addMessage(message);
        
        // Valid amount to transfer
        }else if(dummyRegisterEntry.Entry_Date__c == null){
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            Label.Select_Transaction_Date);
            ApexPages.addMessage(message);
            
        // Amount should be less than available balance
        }else if(bankTransferObj.amountToTransfer > bankRegisterSO.Total_Running_Balance_Amount__c){
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            Label.Amount_Less_Than_Available_Balance);
            ApexPages.addMessage(message);
        }
        
        return hasValidationError;
    }
    
    public class UserException extends Exception {}
    
    // Wrapper class for Amount transfer attributes
    public class BankTransferWrapper{
        public Decimal amountToTransfer {get; set;}
        public String paymentMemo {get; set;}
        public Id payee {get; set;}
        public String reference {get; set;}
        
        public BankTransferWrapper(){
            amountToTransfer = 0.0;
        }
    }
}