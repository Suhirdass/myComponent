/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * InterBankAmountTransferControllerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class InterBankAmountTransferControllerTest{
    
    static Bank_Register__c bankRegisterSO;
    static Account accountSO;
    
    // Test validation - Target bank should be selected
    static testMethod void testValidation_TargetBankShouldBeSelected(){
        retrieveData();
        
        PageReference pageRef = Page.InterBankAmountTransfer;
        pageRef.getParameters().put('id', bankRegisterSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(bankRegisterSO);
        InterBankAmountTransferController controllerObj = new InterBankAmountTransferController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Do save
        Test.startTest();
        pageRef = controllerObj.transferAmount();
        Test.stopTest();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.SelectTargetBank), 'Validation message mis-match');
        
        System.assertEquals(null, pageRef, 'Page Reference mis-match');
        
        // Verify no register entry created for selected bank register
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
        System.assertEquals(0, registerEntries.size(), 'Register entry count mis-match');
    }
    
    // Test validation - Provide payment Amount as blank
    static testMethod void testValidation_ProvidePaymentAmountAsBlank(){
        retrieveData();
        
        // Create another bank
        Account newAccountSO = accountSO.clone(false, true);
        insert newAccountSO;
        Bank_Register__c targetBank = createBankRegister(newAccountSO.Id, true);
        
        PageReference pageRef = Page.InterBankAmountTransfer;
        pageRef.getParameters().put('id', bankRegisterSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(bankRegisterSO);
        InterBankAmountTransferController controllerObj = new InterBankAmountTransferController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Do save
        Test.startTest();
        controllerObj.selectedBankRegisterId = targetBank.Id;
        controllerObj.bankTransferObj.amountToTransfer = null;
        pageRef = controllerObj.transferAmount();
        Test.stopTest();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Provide_Payment_Amount), 'Validation message mis-match');
        
        System.assertEquals(null, pageRef, 'Page Reference mis-match');
        
        // Verify no register entry created for selected bank register
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
        System.assertEquals(0, registerEntries.size(), 'Register entry count mis-match');
    }
    
    // Test validation - Do not provide transaction date
    static testMethod void testValidation_DoNotProvideTransactionDate(){
        retrieveData();
        
        // Create another bank
        Account newAccountSO = accountSO.clone(false, true);
        insert newAccountSO;
        Bank_Register__c targetBank = createBankRegister(newAccountSO.Id, true);
        
        PageReference pageRef = Page.InterBankAmountTransfer;
        pageRef.getParameters().put('id', bankRegisterSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(bankRegisterSO);
        InterBankAmountTransferController controllerObj = new InterBankAmountTransferController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Do save
        Test.startTest();
        controllerObj.selectedBankRegisterId = targetBank.Id;
        controllerObj.bankTransferObj.amountToTransfer = 100.00;
        controllerObj.dummyRegisterEntry.Entry_Date__c = null;
        pageRef = controllerObj.transferAmount();
        Test.stopTest();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Select_Transaction_Date), 'Validation message mis-match');
        
        System.assertEquals(null, pageRef, 'Page Reference mis-match');
        
        // Verify no register entry created for selected bank register
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
        System.assertEquals(0, registerEntries.size(), 'Register entry count mis-match');
    }
    
    // Test validation - Provide payment Amount greater than source bank available balance
    static testMethod void testValidation_ProvidePaymentAmountGreaterThanAvailableBalance(){
        retrieveData();
        
        // Create another bank
        Account newAccountSO = accountSO.clone(false, true);
        insert newAccountSO;
        Bank_Register__c targetBank = createBankRegister(newAccountSO.Id, true);
        
        // Create bank register entry
        // Create register entry line related to receive payment
        Register_Entry_Line__c registerEntrySO = 
                                createBankRegisterEntry(accountSO.Id,
                                                                     bankRegisterSO.Id,
                                                                     System.Today(),
                                                                     'Test Notes',
                                                                     null,
                                                                     false,
                                                                     1000.00,
                                                                     null,
                                                                     true);
        
        PageReference pageRef = Page.InterBankAmountTransfer;
        pageRef.getParameters().put('id', bankRegisterSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(bankRegisterSO);
        InterBankAmountTransferController controllerObj = new InterBankAmountTransferController(stdController);
        controllerObj.retrieveBankDetails();
        controllerObj.bankRegisterSO = retrieveBankRegisterEntry(bankRegisterSO.Id);
        System.assertEquals(1000.00, controllerObj.bankRegisterSO.Total_Running_Balance_Amount__c,'Source Bank Available balance mis-match');
        
        // Do save
        Test.startTest();
        controllerObj.selectedBankRegisterId = targetBank.Id;
        controllerObj.bankTransferObj.amountToTransfer = 2000.00;
        pageRef = controllerObj.transferAmount();
        Test.stopTest();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Amount_Less_Than_Available_Balance), 'Validation message mis-match');
        
        System.assertEquals(null, pageRef, 'Page Reference mis-match');
        
        // Verify no register entry created for selected bank register
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
        System.assertEquals(0, registerEntries.size(), 'Register entry count mis-match');
    }
    
    // Test provide valid payment Amount to transfer
    static testMethod void testProvideValidPaymentAmountToTransfer(){
        retrieveData();
        
        // Create another bank
        Account newAccountSO = accountSO.clone(false, true);
        insert newAccountSO;
        Bank_Register__c targetBank = createBankRegister(newAccountSO.Id, true);
        
        // Create bank register entry
        // Create register entry line related to receive payment
        Register_Entry_Line__c registerEntrySO = 
                                createBankRegisterEntry(accountSO.Id,
                                                                     bankRegisterSO.Id,
                                                                     System.Today(),
                                                                     'Test Notes',
                                                                     null,
                                                                     false,
                                                                     1000.00,
                                                                     null,
                                                                     true);
        
        PageReference pageRef = Page.InterBankAmountTransfer;
        pageRef.getParameters().put('id', bankRegisterSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(bankRegisterSO);
        InterBankAmountTransferController controllerObj = new InterBankAmountTransferController(stdController);
        controllerObj.retrieveBankDetails();
        controllerObj.bankRegisterSO = retrieveBankRegisterEntry(bankRegisterSO.Id);
        System.assertEquals(1000.00, controllerObj.bankRegisterSO.Total_Running_Balance_Amount__c,'Source Bank Available balance mis-match');
        
        // Do save
        Test.startTest();
        controllerObj.selectedBankRegisterId = targetBank.Id;
        controllerObj.selectedPayee = newAccountSO.Id;
        controllerObj.bankTransferObj.amountToTransfer = 400.00;
        controllerObj.bankTransferObj.paymentMemo = 'Test Memo';
        pageRef = controllerObj.transferAmount();
        Test.stopTest();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(0, msgList.size(), 'Number of Validation messages mis-match');
        System.assertEquals('/'+String.valueOf(bankRegisterSO.Id).subString(0, 15), pageRef.getURL(), 'Page Reference mis-match');
        
        // Verify register entry should be created for selected target bank register
        targetBank = retrieveBankRegisterEntry(controllerObj.selectedBankRegisterId);
        System.assertEquals(400.00, targetBank.Total_Running_Balance_Amount__c,'Target Bank Available balance mis-match');
        
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
        System.assertEquals(1, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              controllerObj.selectedBankRegisterId,
                              controllerObj.dummyRegisterEntry.Entry_Date__c,
                              newAccountSO.Id,
                              'Test Memo',
                              null,
                              false,
                              false,
                              400.00,
                              null,
                              0.0,
                              400.00);
                              
        // Verify register entry should be created for selected source bank register
        targetBank = retrieveBankRegisterEntry(bankRegisterSO.Id);
        System.assertEquals(600.00, targetBank.Total_Running_Balance_Amount__c,'Source Bank Available balance mis-match');
        
        registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(bankRegisterSO.Id,
                                                  null,
                                                  null);
        System.assertEquals(2, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankRegisterSO.Id,
                              controllerObj.dummyRegisterEntry.Entry_Date__c,
                              accountSO.Id,
                              'Test Notes',
                              null,
                              false,
                              false,
                              1000.00,
                              null,
                              0.0,
                              1000.00);
                              
        validateRegisterEntry(registerEntries[1],
                              bankRegisterSO.Id,
                              controllerObj.dummyRegisterEntry.Entry_Date__c,
                              accountSO.Id,
                              'Test Memo',
                              null,
                              false,
                              false,
                              null,
                              400.00,
                              1000.0,
                              600.00);
    }
    
    @TestSetUp
    static void testDataSetUp(){
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        accountSO = [Select Id, Name From Account LIMIT 1];
        
        // Create bank register entry
        bankRegisterSO = createBankRegister(accountSO.Id, true);
    }
    
    // Retrieve Bank Register record
    private static Bank_Register__c retrieveBankRegisterEntry(Id bankRegisterId){
        return [Select Total_Running_Balance_Amount__c, Account__c From Bank_Register__c
                Where Id =: bankRegisterId];
    }
    
    // Retrieve register entries
    private static List<Register_Entry_Line__c> retrieveRegisterEntries(Id bankRegisterId,
                                                                        Id receivePaymentId,
                                                                        Id registerEntryId){
        String query = 'Select Entry_Date__c, ' +
                       'Payee__c, ' +
                       'Entry_Memo__c, ' +
                       'Related_Payment__c, ' +
                       'Reconciled__c, ' +
                       'Credit_Amount__c, ' +
                       'Debit_Amount__c, ' +
                       'Old_Balance__c, ' +
                       'Bank_Register__c, ' +
                       'Running_Balance__c, ' +
                       'Changes_Made_after_Reconciliation__c ' +
                       'From Register_Entry_Line__c  ' +
                       'Where Bank_Register__c =: bankRegisterId ';
        
        if(receivePaymentId != null){
            query += 'AND Related_Payment__c =: receivePaymentId ';
        }
        
        if(registerEntryId != null){
            query += 'AND Id =: registerEntryId ';
        }
        
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
                                              Decimal oldBalance,
                                              Decimal runningBalance){
        validateRegisterEntry(registerEntrySO, bankRegisterId, entryDate, payee, entryMemo, relatedPaymentId, 
                              reconciledFlag, changesMadeFlag, creditAmount, null, oldBalance, runningBalance);
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
                                                  
        System.assertEquals(bankRegisterId, registerEntrySO.Bank_Register__c, 'Register entry bank Id mis-match');
        System.assertEquals(entryDate, registerEntrySO.Entry_Date__c, 'Register entry date mis-match');
        System.assertEquals(payee, registerEntrySO.Payee__c, 'Register entry payee mis-match');
        System.assertEquals(entryMemo, registerEntrySO.Entry_Memo__c, 'Register entry memo mis-match');
        System.assertEquals(relatedPaymentId, registerEntrySO.Related_Payment__c, 'Register entry related payment mis-match');
        System.assertEquals(reconciledFlag, registerEntrySO.Reconciled__c, 'Register entry reconciled flag  mis-match');
        System.assertEquals(changesMadeFlag, registerEntrySO.Changes_Made_after_Reconciliation__c, 'Register entry changes made flag  mis-match');
        System.assertEquals(creditAmount, registerEntrySO.Credit_Amount__c, 'Register entry credit amount  mis-match');
        System.assertEquals(debitAmount, registerEntrySO.Debit_Amount__c, 'Register entry debit amount  mis-match');
        System.assertEquals(oldBalance, registerEntrySO.Old_Balance__c, 'Register entry old balance  mis-match');
        System.assertEquals(runningBalance, registerEntrySO.Running_Balance__c, 'Register entry running balance  mis-match');
    }
    
    // Create Bank Register record
    public static Bank_Register__c createBankRegister(Id accountId, Boolean isCreate){
        Bank_Register__c bankRegisterSO = new Bank_Register__c();
        bankRegisterSO.Account__c = accountId;
        bankRegisterSO.Account_Number__c = 'Test123';
        bankRegisterSO.Register_Type__c = 'Savings';
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
        if(isCreate){
            insert registerEntrySO;
        }
        return registerEntrySO;
    }
}