/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * ReceivePaymentForPOEditOverrideCtrlTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class ReceivePaymentForPOEditOverrideCtrlTest{
    
    static Receive_Payment__c receivePaymentSO;
    static Account accountSO;
    static Bank_Register__c bankReisterSO;
    static Purchase_Order__c objPO;
    
    // Do not generate register entry line for blank payment amount
    static testMethod void testNoRegisterEntryLineCreatedForBlankPaymentAmount(){
        retrieveData();
        
        PageReference pageRef = Page.ReceivePaymentListOverride;
        pageRef.getParameters().put('id', objPO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(new List<Purchase_Order__c>{objPO});
        ReceivePaymentEditOverrideController controllerObj = new ReceivePaymentEditOverrideController(stdSetController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        // Do not provide payment amount
        controllerObj.receivePaymentObj.Payment_Memo__c = 'This is new Update';
        controllerObj.receivePaymentObj.Payment_Amount__c = null;
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        Test.startTest();
        pageRef = controllerObj.doSaveAction();
        Test.stopTest();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Provide_Payment_Amount), 'Validation message mis-match');
        
        System.assertEquals(null, pageRef, 'Page Reference mis-match');
        System.assertEquals(null, controllerObj.receivePaymentObj.Id, 'Receive Payment Should not be created');
        
        // Verify no register entry created for selected bank register
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
        System.assertEquals(0, registerEntries.size(), 'Register entry count mis-match');
    }
    
    // Do not generate register entry line for blank reconciliation date
    static testMethod void testNoRegisterEntryLineCreatedForBlankReconciliationDate(){
        retrieveData();
        
        PageReference pageRef = Page.ReceivePaymentListOverride;
        pageRef.getParameters().put('id', objPO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(new List<Purchase_Order__c>{objPO});
        ReceivePaymentEditOverrideController controllerObj = new ReceivePaymentEditOverrideController(stdSetController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        controllerObj.receivePaymentObj.Payment_Memo__c = 'This is new Update';
        controllerObj.receivePaymentObj.Payment_Amount__c = 200;
        controllerObj.receivePaymentObj.Payment_Form__c = 'Cash';
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        Test.startTest();
        pageRef = controllerObj.doSaveAction();
        Test.stopTest();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Provide_Reconciliation_Date_And_Information), 'Validation message mis-match');
        
        System.assertEquals(null, pageRef, 'Page Reference mis-match');
        System.assertEquals(null, controllerObj.receivePaymentObj.Id, 'Receive Payment Should not be created');
        
        // Verify no register entry created for selected bank register
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
        System.assertEquals(0, registerEntries.size(), 'Register entry count mis-match');
    }
    
    // Do validate if reconciled date is provided but bank register is not selected
    static testMethod void testValidateBankRegisterSelection_ReconcilationDateProvided(){
        retrieveData();
        
        PageReference pageRef = Page.ReceivePaymentListOverride;
        pageRef.getParameters().put('id', objPO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(new List<Purchase_Order__c>{objPO});
        ReceivePaymentEditOverrideController controllerObj = new ReceivePaymentEditOverrideController(stdSetController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        controllerObj.receivePaymentObj.Payment_Memo__c = 'This is new Update';
        controllerObj.receivePaymentObj.Payment_Amount__c = 200;
        controllerObj.receivePaymentObj.Payment_Form__c = 'Cash';
        controllerObj.receivePaymentObj.Posted_Date__c = System.Today();
        
        // Do not select bank for receive payment
        
        // Do save
        Test.startTest();
        pageRef = controllerObj.doSaveAction();
        Test.stopTest();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Select_Bank_Register), 'Validation message mis-match');
        
        System.assertEquals(null, pageRef, 'Page Reference mis-match');
        System.assertEquals(null, controllerObj.receivePaymentObj.Id, 'Receive Payment Should not be created');
        
        // Verify no register entry created for selected bank register
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
        System.assertEquals(0, registerEntries.size(), 'Register entry count mis-match');
    }
    
    // Do generate register entry line for receive payment
    static testMethod void testCreateRegisterEntryLineForReceivePayment(){
        retrieveData();
        
        PageReference pageRef = Page.ReceivePaymentListOverride;
        pageRef.getParameters().put('id', objPO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardSetController stdSetController = new ApexPages.StandardSetController(new List<Purchase_Order__c>{objPO});
        ReceivePaymentEditOverrideController controllerObj = new ReceivePaymentEditOverrideController(stdSetController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        controllerObj.receivePaymentObj.Payment_Memo__c = 'This is new Update';
        controllerObj.receivePaymentObj.Payment_Amount__c = 200;
        controllerObj.receivePaymentObj.Payment_Form__c = 'Cash';
        controllerObj.receivePaymentObj.Posted_Date__c = System.Today();
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        Test.startTest();
        pageRef = controllerObj.doSaveAction();
        Test.stopTest();
        
        System.assertEquals('/'+controllerObj.receivePaymentObj.Id, pageRef.getURL(), 'Page Reference mis-match');
        
        // Verify updated attributes of receive payment
        receivePaymentSO = retrieveReceivePayment(controllerObj.receivePaymentObj.Id);
                                   
        System.assertEquals('This is new Update', receivePaymentSO.Payment_Memo__c, 'Payment memo mis-match');
        System.assertEquals(200, receivePaymentSO.Payment_Amount__c, 'Payment amount mis-match');
        
        // Verify no register entry created for selected bank register
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  receivePaymentSO.Id,
                                                  null);
                           
        System.assertEquals(1, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO.Reconciliation_Notes__c,
                              receivePaymentSO.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO.Payment_Amount__c,
                              0.0,
                              -200.00);
    }
    
    // Update existing register entry line related to receive payment - Set Reconciled flag to false
    static testMethod void testUpdateRegisterEntryLineRelatedToReceivePayment_ReconciledFlagFalse(){
        retrieveData();
        
        receivePaymentSO.Posted_Date__c = System.Today();
        update receivePaymentSO;
        
        // Create register entry line related to receive payment
        Register_Entry_Line__c registerEntrySO = 
                                createBankRegisterEntry(accountSO.Id,
                                                                     bankReisterSO.Id,
                                                                     receivePaymentSO.Posted_Date__c,
                                                                     receivePaymentSO.Reconciliation_Notes__c,
                                                                     receivePaymentSO.Id,
                                                                     false,
                                                                     receivePaymentSO.Payment_Amount__c,
                                                                     null,
                                                                     true);
        PageReference pageRef = Page.ReceivePaymentEditOverride;
        pageRef.getParameters().put('id', receivePaymentSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(receivePaymentSO);
        ReceivePaymentEditOverrideController controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO.Payment_Memo__c = 'This is new Update';
        receivePaymentSO.Payment_Amount__c = 200;
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        Test.startTest();
        pageRef = controllerObj.doSaveAction();
        Test.stopTest();
        
        System.assertEquals('/'+receivePaymentSO.Id, pageRef.getURL(), 'Page Reference mis-match');
        
        // Verify updated attributes of receive payment
        receivePaymentSO = retrieveReceivePayment(receivePaymentSO.Id);
                                   
        System.assertEquals('This is new Update', receivePaymentSO.Payment_Memo__c, 'Payment memo mis-match');
        System.assertEquals(200, receivePaymentSO.Payment_Amount__c, 'Payment amount mis-match');
        
        // Verify register entry updated for selected bank register
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  receivePaymentSO.Id,
                                                  registerEntrySO.Id);
                           
        System.assertEquals(1, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO.Reconciliation_Notes__c,
                              receivePaymentSO.Id,
                              false,
                              false,
                              100.00,
                              200.00,
                              0.0,
                              -100.00);
    }
    
    // Update existing register entry line related to receive payment - Set Reconciled flag to true
    // Only update changes made flag
    static testMethod void testUpdateRegisterEntryLineRelatedToReceivePayment_ReconciledFlagTrue(){
        retrieveData();
        
        receivePaymentSO.Posted_Date__c = System.Today();
        update receivePaymentSO;
        
        // Create chart of account
        Chart_of_Account__c chartofAccountSO = new Chart_of_Account__c();
        chartofAccountSO.Account_Type__c = 'Equity';
        insert chartofAccountSO;
        
        // Create register entry line related to receive payment
        Register_Entry_Line__c registerEntrySO = 
                                createBankRegisterEntry(accountSO.Id,
                                                                     bankReisterSO.Id,
                                                                     receivePaymentSO.Posted_Date__c,
                                                                     receivePaymentSO.Reconciliation_Notes__c,
                                                                     receivePaymentSO.Id,
                                                                     true,
                                                                     null,
                                                                     receivePaymentSO.Payment_Amount__c,
                                                                     false);
        registerEntrySO.Chart_of_Account__c = chartofAccountSO.Id;
        insert registerEntrySO;
        
        PageReference pageRef = Page.ReceivePaymentEditOverride;
        pageRef.getParameters().put('id', receivePaymentSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(receivePaymentSO);
        ReceivePaymentEditOverrideController controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO.Payment_Memo__c = 'This is new Update';
        receivePaymentSO.Payment_Amount__c = 200;
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        Test.startTest();
        pageRef = controllerObj.doSaveAction();
        Test.stopTest();
        
        System.assertEquals('/'+receivePaymentSO.Id, pageRef.getURL(), 'Page Reference mis-match');
        
        // Verify updated attributes of receive payment
        receivePaymentSO = retrieveReceivePayment(receivePaymentSO.Id);
                                   
        System.assertEquals('This is new Update', receivePaymentSO.Payment_Memo__c, 'Payment memo mis-match');
        System.assertEquals(200, receivePaymentSO.Payment_Amount__c, 'Payment amount mis-match');
        
        // Verify register entry updated for selected bank register
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  receivePaymentSO.Id,
                                                  registerEntrySO.Id);
        System.assertEquals(1, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO.Reconciliation_Notes__c,
                              receivePaymentSO.Id,
                              true,
                              true,
                              null,
                              100,
                              0.0,
                              -100.00);
    }
    
    // Do generate/update multiple register entry line related to different receive payments
    static testMethod void testGenerateAndUpdateMultipleRegisterEntryLineRelatedToDifferentReceivePayments(){
        retrieveData();
        
        receivePaymentSO.Posted_Date__c = System.Today();
        update receivePaymentSO;
        
        // Create multiple receive payments
        List<Receive_Payment__c> receivePayments = new List<Receive_Payment__c>();
        Receive_Payment__c receivePaymentSO1 = receivePaymentSO.clone(false, true);
        Receive_Payment__c receivePaymentSO2 = receivePaymentSO.clone(false, true);
        
        receivePayments.add(receivePaymentSO1);
        receivePayments.add(receivePaymentSO2);
        
        insert receivePayments;
        
        // Generate register entry for first receive payment
        PageReference pageRef = Page.ReceivePaymentEditOverride;
        pageRef.getParameters().put('id', receivePaymentSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(receivePaymentSO);
        ReceivePaymentEditOverrideController controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO.Payment_Memo__c = 'This is new Update';
        receivePaymentSO.Payment_Amount__c = 200;
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        Test.startTest();
        pageRef = controllerObj.doSaveAction();
        Test.stopTest();
        
        System.assertEquals('/'+receivePaymentSO.Id, pageRef.getURL(), 'Page Reference mis-match');
        
        // Verify updated attributes of receive payment
        receivePaymentSO = retrieveReceivePayment(receivePaymentSO.Id);
                                   
        System.assertEquals('This is new Update', receivePaymentSO.Payment_Memo__c, 'Payment memo mis-match');
        System.assertEquals(200, receivePaymentSO.Payment_Amount__c, 'Payment amount mis-match');
        
        // Verify no register entry created for selected bank register
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  receivePaymentSO.Id,
                                                  null);
                           
        System.assertEquals(1, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO.Reconciliation_Notes__c,
                              receivePaymentSO.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO.Payment_Amount__c,
                              0.0,
                              -200.00);
                              
        // Generate register entry for second receive payment
        pageRef = Page.ReceivePaymentEditOverride;
        pageRef.getParameters().put('id', receivePaymentSO1.Id);
        Test.setCurrentPage(pageRef);
        
        stdController = new ApexPages.StandardController(receivePaymentSO1);
        controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO1.Payment_Memo__c = 'This is new Update';
        receivePaymentSO1.Payment_Amount__c = 400;
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        pageRef = controllerObj.doSaveAction();
        
        System.assertEquals('/'+receivePaymentSO1.Id, pageRef.getURL(), 'Page Reference mis-match');
        
        // Verify no register entry created for selected bank register
        registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
                           
        System.assertEquals(2, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[1],
                              bankReisterSO.Id,
                              receivePaymentSO1.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO1.Reconciliation_Notes__c,
                              receivePaymentSO1.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO1.Payment_Amount__c,
                              -200,
                              -600);
                              
        // Generate register entry for third receive payment
        pageRef = Page.ReceivePaymentEditOverride;
        pageRef.getParameters().put('id', receivePaymentSO2.Id);
        Test.setCurrentPage(pageRef);
        
        stdController = new ApexPages.StandardController(receivePaymentSO2);
        controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO2.Payment_Memo__c = 'This is new Update';
        receivePaymentSO2.Payment_Amount__c = 600;
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        pageRef = controllerObj.doSaveAction();
        
        System.assertEquals('/'+receivePaymentSO2.Id, pageRef.getURL(), 'Page Reference mis-match');
        
        // Verify no register entry created for selected bank register
        registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
                           
        System.assertEquals(3, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[2],
                              bankReisterSO.Id,
                              receivePaymentSO2.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO2.Reconciliation_Notes__c,
                              receivePaymentSO2.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO2.Payment_Amount__c,
                              -600,
                              -1200);
                              
        // Update first receive payment
        pageRef = Page.ReceivePaymentEditOverride;
        pageRef.getParameters().put('id', receivePaymentSO.Id);
        Test.setCurrentPage(pageRef);
        
        stdController = new ApexPages.StandardController(receivePaymentSO);
        controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO.Payment_Amount__c = 500;
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        pageRef = controllerObj.doSaveAction();
        
        System.assertEquals('/'+receivePaymentSO.Id, pageRef.getURL(), 'Page Reference mis-match');
        
        // Verify register entry updated for selected bank register
        registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
                           
        System.assertEquals(3, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO.Reconciliation_Notes__c,
                              receivePaymentSO.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO.Payment_Amount__c,
                              0.0,
                              -500);
        
        /*validateRegisterEntry(registerEntries[1],
                              bankReisterSO.Id,
                              receivePaymentSO1.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO1.Reconciliation_Notes__c,
                              receivePaymentSO1.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO1.Payment_Amount__c,
                              -500,
                              -900);
                              
        validateRegisterEntry(registerEntries[2],
                              bankReisterSO.Id,
                              receivePaymentSO2.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO2.Reconciliation_Notes__c,
                              receivePaymentSO2.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO2.Payment_Amount__c,
                              -900,
                              -1500);*/
                              
        // Update second receive payment
        pageRef = Page.ReceivePaymentEditOverride;
        pageRef.getParameters().put('id', receivePaymentSO1.Id);
        Test.setCurrentPage(pageRef);
        
        stdController = new ApexPages.StandardController(receivePaymentSO1);
        controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO1.Payment_Amount__c = 100;
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        pageRef = controllerObj.doSaveAction();
        
        System.assertEquals('/'+receivePaymentSO1.Id, pageRef.getURL(), 'Page Reference mis-match');
        
        // Verify register entry updated for selected bank register
        registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
                           
        System.assertEquals(3, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO.Reconciliation_Notes__c,
                              receivePaymentSO.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO.Payment_Amount__c,
                              0.0,
                              -500);
        
        /*validateRegisterEntry(registerEntries[1],
                              bankReisterSO.Id,
                              receivePaymentSO1.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO1.Reconciliation_Notes__c,
                              receivePaymentSO1.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO1.Payment_Amount__c,
                              -500,
                              -600);
                              
        validateRegisterEntry(registerEntries[2],
                              bankReisterSO.Id,
                              receivePaymentSO2.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO2.Reconciliation_Notes__c,
                              receivePaymentSO2.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO2.Payment_Amount__c,
                              -600,
                              -1200);*/
                              
        // Update third receive payment
        pageRef = Page.ReceivePaymentEditOverride;
        pageRef.getParameters().put('id', receivePaymentSO2.Id);
        Test.setCurrentPage(pageRef);
        
        stdController = new ApexPages.StandardController(receivePaymentSO2);
        controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO2.Payment_Amount__c = 100;
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        pageRef = controllerObj.doSaveAction();
        
        System.assertEquals('/'+receivePaymentSO2.Id, pageRef.getURL(), 'Page Reference mis-match');
        
        // Verify register entry updated for selected bank register
        registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
                           
        System.assertEquals(3, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO.Reconciliation_Notes__c,
                              receivePaymentSO.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO.Payment_Amount__c,
                              0.0,
                              -500);
        
        /*validateRegisterEntry(registerEntries[1],
                              bankReisterSO.Id,
                              receivePaymentSO1.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO1.Reconciliation_Notes__c,
                              receivePaymentSO1.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO1.Payment_Amount__c,
                              -500,
                              -600);
                              
        validateRegisterEntry(registerEntries[2],
                              bankReisterSO.Id,
                              receivePaymentSO2.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO2.Reconciliation_Notes__c,
                              receivePaymentSO2.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO2.Payment_Amount__c,
                              -600,
                              -700);*/
    }
    
    // Do generate/update multiple register entry line related to different receive payments
    // Register entries contain debit and credit amounts
    static testMethod void testGenerateAndUpdateMultipleRegisterEntryLineRelatedToDebitAndCreditAmounts(){
        retrieveData();
        
        receivePaymentSO.Posted_Date__c = System.Today();
        update receivePaymentSO;
        
        // Create multiple receive payments
        List<Receive_Payment__c> receivePayments = new List<Receive_Payment__c>();
        Receive_Payment__c receivePaymentSO1 = receivePaymentSO.clone(false, true);
        Receive_Payment__c receivePaymentSO2 = receivePaymentSO.clone(false, true);
        
        receivePayments.add(receivePaymentSO1);
        receivePayments.add(receivePaymentSO2);
        
        insert receivePayments;
        
        // Generate register entry for first receive payment
        PageReference pageRef = Page.ReceivePaymentEditOverride;
        pageRef.getParameters().put('id', receivePaymentSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(receivePaymentSO);
        ReceivePaymentEditOverrideController controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO.Payment_Memo__c = 'This is new Update';
        receivePaymentSO.Payment_Amount__c = 200;
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        Test.startTest();
        pageRef = controllerObj.doSaveAction();
        Test.stopTest();
        
        System.assertEquals('/'+receivePaymentSO.Id, pageRef.getURL(), 'Page Reference mis-match');
        
        // Verify updated attributes of receive payment
        receivePaymentSO = retrieveReceivePayment(receivePaymentSO.Id);
                                   
        System.assertEquals('This is new Update', receivePaymentSO.Payment_Memo__c, 'Payment memo mis-match');
        System.assertEquals(200, receivePaymentSO.Payment_Amount__c, 'Payment amount mis-match');
        
        // Verify no register entry created for selected bank register
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  receivePaymentSO.Id,
                                                  null);
                           
        System.assertEquals(1, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO.Reconciliation_Notes__c,
                              receivePaymentSO.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO.Payment_Amount__c,
                              0.0,
                              -200.00);
                              
        // Credit payment (credit) entry for register bank entry
        Register_Entry_Line__c creditEntry = 
                                createBankRegisterEntry(null,
                                                         bankReisterSO.Id,
                                                         receivePaymentSO.Posted_Date__c,
                                                         '',
                                                         null,
                                                         false,
                                                         100.00,
                                                         null,
                                                         true);
        registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
                           
        System.assertEquals(2, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[1],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              null,
                              null,
                              null,
                              false,
                              false,
                              100.00,
                              null,
                              -200.00,
                              -100.00);
        
        // Generate register entry for second receive payment
        pageRef = Page.ReceivePaymentEditOverride;
        pageRef.getParameters().put('id', receivePaymentSO1.Id);
        Test.setCurrentPage(pageRef);
        
        stdController = new ApexPages.StandardController(receivePaymentSO1);
        controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO1.Payment_Memo__c = 'This is new Update';
        receivePaymentSO1.Payment_Amount__c = 400;
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        pageRef = controllerObj.doSaveAction();
        
        System.assertEquals('/'+receivePaymentSO1.Id, pageRef.getURL(), 'Page Reference mis-match');
        
        // Verify no register entry created for selected bank register
        registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
                           
        System.assertEquals(3, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[2],
                              bankReisterSO.Id,
                              receivePaymentSO1.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO1.Reconciliation_Notes__c,
                              receivePaymentSO1.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO1.Payment_Amount__c,
                              -100,
                              -500);
                              
        // Generate register entry for third receive payment
        pageRef = Page.ReceivePaymentEditOverride;
        pageRef.getParameters().put('id', receivePaymentSO2.Id);
        Test.setCurrentPage(pageRef);
        
        stdController = new ApexPages.StandardController(receivePaymentSO2);
        controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO2.Payment_Memo__c = 'This is new Update';
        receivePaymentSO2.Payment_Amount__c = 600;
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        pageRef = controllerObj.doSaveAction();
        
        System.assertEquals('/'+receivePaymentSO2.Id, pageRef.getURL(), 'Page Reference mis-match');
        
        // Verify no register entry created for selected bank register
        registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
                           
        System.assertEquals(4, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[3],
                              bankReisterSO.Id,
                              receivePaymentSO2.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO2.Reconciliation_Notes__c,
                              receivePaymentSO2.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO2.Payment_Amount__c,
                              -500,
                              -1100);
                              
        // Update first receive payment
        pageRef = Page.ReceivePaymentEditOverride;
        pageRef.getParameters().put('id', receivePaymentSO.Id);
        Test.setCurrentPage(pageRef);
        
        stdController = new ApexPages.StandardController(receivePaymentSO);
        controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO.Payment_Amount__c = 500;
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        pageRef = controllerObj.doSaveAction();
        
        System.assertEquals('/'+receivePaymentSO.Id, pageRef.getURL(), 'Page Reference mis-match');
        
        // Verify register entry updated for selected bank register
        registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  null,
                                                  null);
                           
        System.assertEquals(4, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO.Reconciliation_Notes__c,
                              receivePaymentSO.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO.Payment_Amount__c,
                              0.0,
                              -500);
        
        /*validateRegisterEntry(registerEntries[1],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              null,
                              null,
                              null,
                              false,
                              false,
                              100.00,
                              null,
                              -500.00,
                              -400.00);
                              
        validateRegisterEntry(registerEntries[2],
                              bankReisterSO.Id,
                              receivePaymentSO1.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO1.Reconciliation_Notes__c,
                              receivePaymentSO1.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO1.Payment_Amount__c,
                              -400.00,
                              -800.00);
                              
        validateRegisterEntry(registerEntries[3],
                              bankReisterSO.Id,
                              receivePaymentSO2.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO2.Reconciliation_Notes__c,
                              receivePaymentSO2.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO2.Payment_Amount__c,
                              -800.00,
                              -1400.00);*/
                              
    }
    
    // Do not generate New Receive Payment record - For blank payment
    static testMethod void testDoNotGenerateNewReceivePayment_ForBlankPaymentAmount(){
        retrieveData();
        
        // Delete receive payment
        delete receivePaymentSO;
        receivePaymentSO = new Receive_Payment__c();
        receivePaymentSO.Bill_Pay__c = objPO.Id;
        
        PageReference pageRef = Page.ReceivePaymentEditOverride;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(receivePaymentSO);
        ReceivePaymentEditOverrideController controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Do not provide payment amount
        receivePaymentSO.Payment_Amount__c = null;
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        Test.startTest();
        pageRef = controllerObj.doSaveAction();
        Test.stopTest();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Provide_Payment_Amount), 'Validation message mis-match');
        
        System.assertEquals(null, pageRef, 'Page Reference mis-match');
        
        // Verify receive payment is not created
        List<Receive_Payment__c> receivePayments = [Select Id From Receive_Payment__c Where Bill_Pay__c =: objPO.Id];
        System.assertEquals(0, receivePayments.size(), 'Receive Payment mis-match');
    }
    
    // Do not generate new receive payment for blank reconciliation date
    static testMethod void testDoNotGenerateNewReceivePayment_ForBlankReconciliationDate(){
        retrieveData();
        
        // Delete receive payment
        delete receivePaymentSO;
        receivePaymentSO = new Receive_Payment__c();
        receivePaymentSO.Bill_Pay__c = objPO.Id;
        
        PageReference pageRef = Page.ReceivePaymentEditOverride;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(receivePaymentSO);
        ReceivePaymentEditOverrideController controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO.Payment_Received_Date__c = System.Today();
        receivePaymentSO.Payment_Form__c = 'Cash';
        receivePaymentSO.Payment_Amount__c = 100;
        receivePaymentSO.Posted_Date__c = null;
        receivePaymentSO.Payment_Memo__c = 'This is Payment memo';
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        Test.startTest();
        pageRef = controllerObj.doSaveAction();
        Test.stopTest();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Provide_Reconciliation_Date_And_Information), 'Validation message mis-match');
        
        System.assertEquals(null, pageRef, 'Page Reference mis-match');
        
        // Verify receive payment is not created
        List<Receive_Payment__c> receivePayments = [Select Id From Receive_Payment__c Where Bill_Pay__c =: objPO.Id];
        System.assertEquals(0, receivePayments.size(), 'Receive Payment mis-match');
    }
    
    // Do validate if reconciled date is provided but bank register is not selected
    // Do not generate new receive payment
    static testMethod void testDoNotGenerateNewReceivePayment_NoBankRegisterSelection_ReconcilationDateProvided(){
        retrieveData();
        
        // Delete receive payment
        delete receivePaymentSO;
        receivePaymentSO = new Receive_Payment__c();
        receivePaymentSO.Bill_Pay__c = objPO.Id;
        
        PageReference pageRef = Page.ReceivePaymentEditOverride;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(receivePaymentSO);
        ReceivePaymentEditOverrideController controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO.Payment_Received_Date__c = System.Today();
        receivePaymentSO.Payment_Form__c = 'Cash';
        receivePaymentSO.Payment_Amount__c = 100;
        receivePaymentSO.Payment_Memo__c = 'This is Payment memo';
        receivePaymentSO.Posted_Date__c = System.Today();
        
        // Do not select bank for receive payment
        
        // Do save
        Test.startTest();
        pageRef = controllerObj.doSaveAction();
        Test.stopTest();
        
        // Verify validation messages
        List<ApexPages.Message> msgList = ApexPages.getMessages();
        System.assertEquals(1, msgList.size(), 'Number of Validation messages mis-match');
        System.assert(msgList[0].getDetail().contains(Label.Select_Bank_Register), 'Validation message mis-match');
        
        System.assertEquals(null, pageRef, 'Page Reference mis-match');
        
        // Verify receive payment is not created
        List<Receive_Payment__c> receivePayments = [Select Id From Receive_Payment__c Where Bill_Pay__c =: objPO.Id];
        System.assertEquals(0, receivePayments.size(), 'Receive Payment mis-match');
    }
    
    // Do generate register entry line for new receive payment
    static testMethod void testCreateNewReceivePaymentAndRegisterEntryLine(){
        retrieveData();
        
        // Delete receive payment
        delete receivePaymentSO;
        receivePaymentSO = new Receive_Payment__c();
        receivePaymentSO.Bill_Pay__c = objPO.Id;
        
        PageReference pageRef = Page.ReceivePaymentEditOverride;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(receivePaymentSO);
        ReceivePaymentEditOverrideController controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO.Payment_Received_Date__c = System.Today();
        receivePaymentSO.Payment_Form__c = 'Cash';
        receivePaymentSO.Payment_Amount__c = 100;
        receivePaymentSO.Posted_Date__c = System.Today();
        receivePaymentSO.Payment_Memo__c = 'This is payment memo';
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        Test.startTest();
        pageRef = controllerObj.doSaveAction();
        Test.stopTest();
        
        // Verify receive payment is created
        List<Receive_Payment__c> receivePayments = [Select Id From Receive_Payment__c Where Bill_Pay__c =: objPO.Id];
        System.assertEquals(1, receivePayments.size(), 'Receive Payment mis-match');
        
        System.assertEquals('/'+receivePayments[0].Id, pageRef.getURL(), 'Page Reference mis-match');
        
        // Verify updated attributes of receive payment
        receivePaymentSO = retrieveReceivePayment(receivePayments[0].Id);
                                   
        System.assertEquals('This is payment memo', receivePaymentSO.Payment_Memo__c, 'Payment memo mis-match');
        System.assertEquals(100, receivePaymentSO.Payment_Amount__c, 'Payment amount mis-match');
        
        // Verify no register entry created for selected bank register
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  receivePaymentSO.Id,
                                                  null);
                           
        System.assertEquals(1, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO.Reconciliation_Notes__c,
                              receivePaymentSO.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO.Payment_Amount__c,
                              0.0,
                              -100.00);
    }
    
    // Do generate register entry line for receive payment - Use Save and New button
    static testMethod void testCreateRegisterEntryLineForReceivePayment_SaveAndNewButton(){
        retrieveData();
        
        receivePaymentSO.Posted_Date__c = System.Today();
        update receivePaymentSO;
        
        PageReference pageRef = Page.ReceivePaymentEditOverride;
        pageRef.getParameters().put('id', receivePaymentSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(receivePaymentSO);
        ReceivePaymentEditOverrideController controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Update some attributes of receive payment
        receivePaymentSO.Payment_Memo__c = 'This is new Update';
        receivePaymentSO.Payment_Amount__c = 200;
        
        // Select bank for receive payment
        controllerObj.selectedBankRegisterId = bankReisterSO.Id;
        
        // Do save
        Test.startTest();
        controllerObj.actionType = 'Save and New';
        pageRef = controllerObj.doSaveAction();
        Test.stopTest();
        
        System.assert(pageRef.getURL().contains('/apex/ReceivePaymentEditOverride'));
        
        // Verify updated attributes of receive payment
        receivePaymentSO = retrieveReceivePayment(receivePaymentSO.Id);
                                   
        System.assertEquals('This is new Update', receivePaymentSO.Payment_Memo__c, 'Payment memo mis-match');
        System.assertEquals(200, receivePaymentSO.Payment_Amount__c, 'Payment amount mis-match');
        
        // Verify no register entry created for selected bank register
        List<Register_Entry_Line__c> registerEntries = new List<Register_Entry_Line__c>();
        registerEntries = retrieveRegisterEntries(controllerObj.selectedBankRegisterId,
                                                  receivePaymentSO.Id,
                                                  null);
                           
        System.assertEquals(1, registerEntries.size(), 'Register entry count mis-match');
        validateRegisterEntry(registerEntries[0],
                              bankReisterSO.Id,
                              receivePaymentSO.Posted_Date__c,
                              accountSO.Id,
                              receivePaymentSO.Reconciliation_Notes__c,
                              receivePaymentSO.Id,
                              false,
                              false,
                              null,
                              receivePaymentSO.Payment_Amount__c,
                              0.0,
                              -200.00);
    }
    
    // Test Cancel action for new and existing receive payment record
    static testMethod void testCancelAction(){
        retrieveData();
        
        receivePaymentSO.Posted_Date__c = System.Today();
        update receivePaymentSO;
        
        PageReference pageRef = Page.ReceivePaymentEditOverride;
        pageRef.getParameters().put('id', receivePaymentSO.Id);
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController = new ApexPages.StandardController(receivePaymentSO);
        ReceivePaymentEditOverrideController controllerObj = new ReceivePaymentEditOverrideController(stdController);
        controllerObj.retrieveBankDetails();
        
        // Do Cancel
        Test.startTest();
        pageRef = controllerObj.doCancelAction();
        Test.stopTest();
        
        // Verify cancel action for existing receive payment - Should go to receive payment detail page
        System.assertEquals(pageRef.getURL().subString(0, 16), '/'+stdController.getId(), 'Page Reference mis-match');
        
        // Clone new Receive payment
        Receive_Payment__c newRPSO = receivePaymentSO.clone(false, true);
        newRPSO.Bill_Pay__c = objPO.Id;
        pageRef = Page.ReceivePaymentEditOverride;
        Test.setCurrentPage(pageRef);
        
        ApexPages.StandardController stdController1 = new ApexPages.StandardController(newRPSO);
        ReceivePaymentEditOverrideController controllerObj1 = new ReceivePaymentEditOverrideController(stdController1);
        controllerObj1.retrieveBankDetails();
        pageRef = controllerObj1.doCancelAction();
        
        // Verify cancel action for existing receive payment - Should go to PO record
        System.assertEquals(pageRef.getURL(), '/'+newRPSO.Bill_Pay__c, 'Page Reference mis-match');
    }
    
    @TestSetUp
    static void testDataSetUp(){
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        objPO = new Purchase_Order__c();
        objpO.PO_Status__c = 'Draft';
        objpO.PO_Type__c = 'Buy Quote';
        objPO.Supplier_Name__c = objAccount.Id;
        insert objPO;
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        accountSO = [Select Id From Account LIMIT 1];
        objPO = [Select Id, Supplier_Name__c From Purchase_Order__c];
        
        // Create receive payment record
        receivePaymentSO = new Receive_Payment__c();
        receivePaymentSO.Bill_Pay__c = objPO.Id;
        receivePaymentSO.Payment_Memo__c = 'Test PO memo';
        receivePaymentSO.Payment_Received_Date__c = System.Today();
        receivePaymentSO.Payment_Form__c = 'Cash';
        receivePaymentSO.Payment_Amount__c = 100;
        receivePaymentSO.Posted_Date__c = null;
        insert receivePaymentSO;
        
        // Create bank register entry
        bankReisterSO = createBankRegister(accountSO.Id, true);
    }
    
    // Retrieve retrieve payment record
    private static Receive_Payment__c retrieveReceivePayment(Id receivePaymentId){
        return [Select Payment_Amount__c, 
                Payment_Memo__c,
                Payment_Form__c,
                Bill_Pay__c,
                Invoice__c,
                Posted_Date__c,
                Reconciliation_Notes__c
                From Receive_Payment__c Where Id =: receivePaymentId];
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
                                                  
        System.assertEquals(bankRegisterId, bankReisterSO.Id, 'Register entry bank Id mis-match');
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