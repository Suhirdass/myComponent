/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * RegisterEntryLineTriggerHandlerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class RegisterEntryLineTriggerHandlerTest{
    
    static Receive_Payment__c receivePaymentSO;
    static Account accountSO;
    static Bank_Register__c bankReisterSO;
    
    // Do generate single register entry line and set old balance from trigger
    static testMethod void testCreateSingleRegisterEntryLine(){
        retrieveData();
        
        // Do save
        Test.startTest();
        // Create register entry line related to receive payment
        createBankRegisterEntry(accountSO.Id,
                                             bankReisterSO.Id,
                                             receivePaymentSO.Posted_Date__c,
                                             receivePaymentSO.Reconciliation_Notes__c,
                                             receivePaymentSO.Id,
                                             false,
                                             receivePaymentSO.Payment_Amount__c,
                                             null,
                                             true);
        Test.stopTest();
        
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(new Set<Id>{bankReisterSO.Id});
                           
        System.assertEquals(1, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO.Reconciliation_Notes__c,
                              receivePaymentSO.Id,
                              false,
                              false,
                              receivePaymentSO.Payment_Amount__c,
                              null,
                              0.0,
                              100.00);
                              
        // Create another register entry line related to debit payment
        createBankRegisterEntry(null,
                                             bankReisterSO.Id,
                                             null,
                                             null,
                                             null,
                                             false,
                                             null,
                                             50.00,
                                             true);
        
        registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(new Set<Id>{bankReisterSO.Id});
                           
        System.assertEquals(2, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO.Reconciliation_Notes__c,
                              receivePaymentSO.Id,
                              false,
                              false,
                              receivePaymentSO.Payment_Amount__c,
                              null,
                              0.0,
                              100.00);
                              
        validateRegisterEntry(registerEntries[1],
                              bankReisterSO.Id,
                              null,
                              null,
                              null,
                              null,
                              false,
                              false,
                              null,
                              50.00,
                              100.0,
                              50.00);
                              
        // Create another register entry line related to credit payment
        Receive_Payment__c receivePaymentSO1 = receivePaymentSO.clone(false, true);
        receivePaymentSO1.Payment_Amount__c = 500.00;
        insert receivePaymentSO1;
        createBankRegisterEntry(accountSO.Id,
                                             bankReisterSO.Id,
                                             receivePaymentSO1.Posted_Date__c,
                                             receivePaymentSO1.Reconciliation_Notes__c,
                                             receivePaymentSO1.Id,
                                             false,
                                             receivePaymentSO1.Payment_Amount__c,
                                             null,
                                             true);
        
        registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(new Set<Id>{bankReisterSO.Id});
                           
        System.assertEquals(3, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO.Reconciliation_Notes__c,
                              receivePaymentSO.Id,
                              false,
                              false,
                              receivePaymentSO.Payment_Amount__c,
                              null,
                              0.0,
                              100.00);
                              
        validateRegisterEntry(registerEntries[1],
                              bankReisterSO.Id,
                              null,
                              null,
                              null,
                              null,
                              false,
                              false,
                              null,
                              50.00,
                              100.0,
                              50.00);
        validateRegisterEntry(registerEntries[2],
                              bankReisterSO.Id,
                              receivePaymentSO1.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO1.Reconciliation_Notes__c,
                              receivePaymentSO1.Id,
                              false,
                              false,
                              receivePaymentSO1.Payment_Amount__c,
                              null,
                              50.0,
                              550.00);
    }
    
    // Do generate multiple register entry lines and set old balance from trigger
    static testMethod void testCreateMultipleRegisterEntryLines(){
        retrieveData();
        
        // Do save
        Test.startTest();
        // Create register entry line related to receive payment
        Register_Entry_Line__c registerEntry1 = createBankRegisterEntry(accountSO.Id,
                                                                 bankReisterSO.Id,
                                                                 receivePaymentSO.Posted_Date__c,
                                                                 receivePaymentSO.Reconciliation_Notes__c,
                                                                 receivePaymentSO.Id,
                                                                 false,
                                                                 receivePaymentSO.Payment_Amount__c,
                                                                 null,
                                                                 false);
                                             
        Register_Entry_Line__c registerEntry2 = createBankRegisterEntry(null,
                                                                 bankReisterSO.Id,
                                                                 null,
                                                                 null,
                                                                 null,
                                                                 false,
                                                                 null,
                                                                 50.00,
                                                                 false);
                                                                 
        insert new List<Register_Entry_Line__c>{registerEntry1, registerEntry2};
        
        Test.stopTest();
        
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(new Set<Id>{bankReisterSO.Id});
                           
        System.assertEquals(2, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO.Reconciliation_Notes__c,
                              receivePaymentSO.Id,
                              false,
                              false,
                              receivePaymentSO.Payment_Amount__c,
                              null,
                              0.0,
                              100.00);
                              
        validateRegisterEntry(registerEntries[1],
                              bankReisterSO.Id,
                              null,
                              null,
                              null,
                              null,
                              false,
                              false,
                              null,
                              50.00,
                              100.0,
                              50.00);
    }
    
    @TestSetUp
    static void testDataSetUp(){
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        Invoice__c inv = new Invoice__c();
        //inv.Sales_Order__c = objSO.id;
        inv.AR_Status__c = 'Draft';
        insert inv;
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        accountSO = [Select Id From Account LIMIT 1];
        Invoice__c invoiceSO = [Select Id, Receiver_Name__c From Invoice__c];
        invoiceSO.Receiver_Name__c = accountSO.Id;
        update invoiceSO;
        
        // Create receive payment record
        receivePaymentSO = new Receive_Payment__c();
        receivePaymentSO.Invoice__c = invoiceSO.Id;
        receivePaymentSO.Payment_Memo__c = 'Test Invoice memo';
        receivePaymentSO.Payment_Received_Date__c = System.Today();
        receivePaymentSO.Payment_Form__c = 'Cash';
        receivePaymentSO.Payment_Amount__c = 100;
        receivePaymentSO.Posted_Date__c = System.Today();
        insert receivePaymentSO;
        
        
        
        // Create bank register entry
        bankReisterSO = createBankRegister(accountSO.Id, true);
    }
    
    // Retrieve register entries
    private static List<Register_Entry_Line__c> retrieveRegisterEntries(Set<Id> bankRegisterIds){
        String query = 'Select Entry_Date__c, ' +
                       'Payee__c, ' +
                       'Entry_Memo__c, ' +
                       'Related_Payment__c, ' +
                       'Reconciled__c, ' +
                       'Credit_Amount__c, ' +
                       'Debit_Amount__c, ' +
                       'Old_Balance__c, ' +
                       'Running_Balance__c, ' +
                       'Changes_Made_after_Reconciliation__c ' +
                       'From Register_Entry_Line__c  ' +
                       'Where Bank_Register__c =: bankRegisterIds ';
        
        return Database.query(query);
    }
    
    // Validate Register entry attributes
    private static void validateRegisterEntry(Register_Entry_Line__c registerEntrySO,
                                              Id bankRegisterId,
                                              Date entryDate,
                                              Id payee,
                                              String entryMemo,
                                              Id relatedPaymentId,
                                              Boolean reconciledFlag,
                                              Boolean changesMadeFlag,
                                              Decimal creditAmount,
                                              Decimal debitAmount,
                                              Decimal oldBalance,
                                              Decimal runningBalance){
                                                  
        System.assertEquals(bankRegisterId, bankReisterSO.Id, 'Register entry bank Id mis-match');
        System.assertEquals(entryDate, registerEntrySO.Entry_Date__c, 'Register entry date mis-match');
        System.assertEquals(payee, registerEntrySO.Payee__c, 'Register entry payee mis-match');
        System.assertEquals(entryMemo, registerEntrySO.Entry_Memo__c, 'Register entry memo mis-match');
        System.assertEquals(relatedPaymentId, registerEntrySO.Related_Payment__c, 'Register entry related payment mis-match');
        System.assertEquals(reconciledFlag, registerEntrySO.Reconciled__c, 'Register entry reconciled flag  mis-match');
        System.assertEquals(changesMadeFlag, registerEntrySO.Changes_Made_after_Reconciliation__c, 'Register entry changes made flag  mis-match');
        System.assertEquals(creditAmount, registerEntrySO.Credit_Amount__c, 'Register entry credit amount  mis-match');
        System.assertEquals(debitAmount, registerEntrySO.Debit_Amount__c, 'Register entry credit amount  mis-match');
        System.assertEquals(oldBalance, registerEntrySO.Old_Balance__c, 'Register entry old balance  mis-match');
        System.assertEquals(runningBalance, registerEntrySO.Running_Balance__c, 'Register entry running balance  mis-match');
    }
    
    // Create Bank Register record
    public static Bank_Register__c createBankRegister(Id accountId, Boolean isCreate){
        Bank_Register__c bankRegisterSO = new Bank_Register__c();
        bankRegisterSO.Account__c = accountId;
        bankRegisterSO.Account_Number__c = 'Test123';
       // bankRegisterSO.Register_Type__c = 'Clearing Account';
        bankRegisterSO.Bank_Name__c = 'Test Bank';
        bankRegisterSO.Starting_Balance__c = 100000;
        bankRegisterSO.Active__c = true;
        if(isCreate){
            insert bankRegisterSO;
        }
        return bankRegisterSO;
    }
    
    // Create Bank Register Entry record
    public static Register_Entry_Line__c createBankRegisterEntry(Id accountId,
                                                               Id bankReisterId, 
                                                               Date entryDate,
                                                               String entryMemo,
                                                               Id receivePaymentId,
                                                               Boolean reconciledFlag,
                                                               Decimal creditAmount,
                                                               Decimal debitAmount, 
                                                               Boolean isCreate){
        Register_Entry_Line__c registerEntrySO = new Register_Entry_Line__c();
        registerEntrySO.Bank_Register__c = bankReisterId;
        registerEntrySO.Entry_Date__c = entryDate;
        registerEntrySO.Payee__c = accountId;
        registerEntrySO.Entry_Memo__c = entryMemo;
        registerEntrySO.Related_Payment__c = receivePaymentId;
        registerEntrySO.Reconciled__c = reconciledFlag;
        registerEntrySO.Credit_Amount__c = creditAmount;
        registerEntrySO.Debit_Amount__c = debitAmount;
         system.debug('registerEntrySO>>>'+registerEntrySO);                                                          
                                                                   
        if(isCreate){
            insert registerEntrySO;
        }
        return registerEntrySO;
    }
}