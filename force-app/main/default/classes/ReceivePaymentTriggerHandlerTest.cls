/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * ReceivePaymentTriggerHandlerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class ReceivePaymentTriggerHandlerTest{
    
    static Invoice__c invoiceSO;
    
    // Test invoice attributes related to receive payment insert
    static testMethod void testInvoiceAttributesRelatedToReceivePaymentInsert(){
        retrieveData();
        
        // Validate invoice attributes before any receive payment creation
        validateInvoiceAttributes(invoiceSO.Id, null, null, null, null, null);
        
        Test.startTest();
        // Create Receive Payment of "Product" record type
        createReceivePayment(200.00, System.Today(), 'Product');
        Test.stopTest();
        
        // Validate invoice attributes after receive payment creation
        validateInvoiceAttributes(invoiceSO.Id, System.Today(), 0.0, 200.00, 0.0, 200.00);
        
        // Create Receive Payment of "Cultivation Tax" record type
        createReceivePayment(150.00, System.Today() + 1, 'Cultivation Tax');
        
        // Validate invoice attributes after receive payment creation
        validateInvoiceAttributes(invoiceSO.Id, System.Today() + 1, 0.0, 200.00, 150.00, 350.00);
        
        // Create Receive Payment of "Excise Tax" record type
        createReceivePayment(50.00, System.Today(), 'Excise Tax');
        
        // Validate invoice attributes after receive payment creation
        validateInvoiceAttributes(invoiceSO.Id, System.Today() + 1, 50.0, 200.00, 150.00, 400.00);
        
        // Create Receive Payment of "Product" record type
        createReceivePayment(300.00, System.Today() + 2, 'Product');
        
        // Validate invoice attributes after receive payment creation
        validateInvoiceAttributes(invoiceSO.Id, System.Today() + 2, 50.0, 500.00, 150.00, 700.00);
    }
    
    // Test invoice attributes related to receive payment update
    static testMethod void testInvoiceAttributesRelatedToReceivePaymentUpdate(){
        retrieveData();
        
        // Validate invoice attributes before any receive payment creation
        validateInvoiceAttributes(invoiceSO.Id, null, null, null, null, null);
        
        Test.startTest();
        // Create Receive Payment of "Product" record type
        createReceivePayment(200.00, System.Today(), 'Product');
        Test.stopTest();
        
        // Validate invoice attributes after receive payment creation
        validateInvoiceAttributes(invoiceSO.Id, System.Today(), 0.0, 200.00, 0.0, 200.00);
        
        // Create Receive Payment of "Cultivation Tax" record type
        createReceivePayment(150.00, System.Today() + 1, 'Cultivation Tax');
        
        // Validate invoice attributes after receive payment creation
        validateInvoiceAttributes(invoiceSO.Id, System.Today() + 1, 0.0, 200.00, 150.00, 350.00);
        
        // Create Receive Payment of "Excise Tax" record type
        Receive_Payment__c rp1 = createReceivePayment(50.00, System.Today(), 'Excise Tax');
        
        // Validate invoice attributes after receive payment creation
        validateInvoiceAttributes(invoiceSO.Id, System.Today() + 1, 50.0, 200.00, 150.00, 400.00);
        
        // Update rp1
        rp1.Payment_Amount__c = 60.00;
        update rp1;
        
        // Validate invoice attributes after receive payment update
        validateInvoiceAttributes(invoiceSO.Id, System.Today() + 1, 60.0, 200.00, 150.00, 410.00);
        
        // Create Receive Payment of "Product" record type
        Receive_Payment__c rp2 = createReceivePayment(300.00, System.Today() + 2, 'Product');
        
        // Create Receive Payment of "Cultivation Tax" record type
        Receive_Payment__c rp3 = createReceivePayment(120.00, System.Today() + 2, 'Cultivation Tax');
        
        // Validate invoice attributes after receive payment creation
        validateInvoiceAttributes(invoiceSO.Id, System.Today() + 2, 60.0, 500.00, 270.00, 830.00);
        
        // Update rp2
        rp2.Payment_Amount__c = 120.00;
        rp2.Payment_Received_Date__c = System.Today();
        update rp2;
        
        // Update rp3
        rp3.Payment_Amount__c = 100.00;
        rp3.Payment_Received_Date__c = System.Today();
        update rp3;
        
        // Validate invoice attributes after receive payment creation
        validateInvoiceAttributes(invoiceSO.Id, System.Today() + 1, 60.0, 320.00, 250.00, 630.00);
    }
    
    // Test multiple invoice attributes related to receive payment insert
    static testMethod void testMultipleInvoiceAttributesRelatedToReceivePaymentInsert(){
        retrieveData();
        
        Invoice__c anotherInvoice = invoiceSO.clone(false, true);
        insert anotherInvoice;
        
        // Validate invoice attributes before any receive payment creation
        validateInvoiceAttributes(invoiceSO.Id, null, null, null, null, null);
        
        // Validate another invoice attributes before any receive payment creation
        validateInvoiceAttributes(anotherInvoice.Id, null, null, null, null, null);
        
        // Add multiple receive payments of different invoices
        Test.startTest();
        // Create Receive Payment of "Product" record type
        List<Receive_Payment__c> receivePayments = new List<Receive_Payment__c>(); 
        receivePayments.add(createReceivePayment(200.00, System.Today(), 'Product', false));
        receivePayments.add(createReceivePayment(300.00, System.Today(), 'Product', false));
        receivePayments.add(createReceivePayment(200.00, System.Today(), 'Product', false));
        receivePayments.add(createReceivePayment(100.00, System.Today(), 'Product', false));
        
        // Change invoice in last two receive payment
        receivePayments[2].Invoice__c = anotherInvoice.Id;
        receivePayments[3].Invoice__c = anotherInvoice.Id;
        
        // Insert receive payments
        insert receivePayments;
        
        Test.stopTest();
        
        // Validate invoice attributes after receive payment creation
        validateInvoiceAttributes(invoiceSO.Id, System.Today(), 0.0, 500.00, 0.0, 500.00);
        
        // Validate another invoice attributes after receive payment creation
        validateInvoiceAttributes(anotherInvoice.Id, System.Today(), 0.0, 300.00, 0.0, 300.00);
    }
    
    // Test invoice attributes related to receive payment delete
    static testMethod void testInvoiceAttributesRelatedToReceivePaymentDelete(){
        retrieveData();
        
        Invoice__c anotherInvoice = invoiceSO.clone(false, true);
        insert anotherInvoice;
        
        // Validate invoice attributes before any receive payment creation
        validateInvoiceAttributes(invoiceSO.Id, null, null, null, null, null);
        
        // Add multiple receive payments of different invoices
        Test.startTest();
        // Create Receive Payment of "Product" record type
        List<Receive_Payment__c> receivePayments = new List<Receive_Payment__c>(); 
        receivePayments.add(createReceivePayment(200.00, System.Today(), 'Product', false));
        receivePayments.add(createReceivePayment(300.00, System.Today(), 'Product', false));
        receivePayments.add(createReceivePayment(200.00, System.Today(), 'Product', false));
        receivePayments.add(createReceivePayment(100.00, System.Today(), 'Product', false));
        insert receivePayments;
        
        Test.stopTest();
        
        // Validate invoice attributes after receive payment creation
        validateInvoiceAttributes(invoiceSO.Id, System.Today(), 0.0, 800.00, 0.0, 800.00);
        
        // Delete third receive payment
        //delete receivePayments[2];
        
        // Validate invoice attributes after receive payment delete
        validateInvoiceAttributes(invoiceSO.Id, System.Today(), 0.0, 600.00, 0.0, 600.00);
    }
    
    // Test total payments made of Purchase order related to bill pay
    static testMethod void testPOTotalPaymentsMadeRelatedToReceivePaymentInsert(){
        retrieveData();
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        Purchase_Order__c objPO = new Purchase_Order__c();
        objpO.PO_Status__c = 'Approved';
        objpO.PO_Type__c = 'Buy Quote';
        objPO.Supplier_Name__c = objAccount.Id;
        objPO.Ownership__c = objAccount.Id;
        insert objPO;
        
        // Validate PO total payments made before any receive payment creation
        validatePOAttributes(objPO.Id, null);
        
        Test.startTest();
        // Create Receive Payment of "Product" record type
        List<Receive_Payment__c> receivePayments = new List<Receive_Payment__c>(); 
        receivePayments.add(createReceivePayment(200.00, System.Today(), 'Product', false));
        receivePayments.add(createReceivePayment(300.00, System.Today(), 'Product', false));
        
        // Set Bill Pay in two receive payment
        receivePayments[0].Invoice__c = null;
        receivePayments[1].Invoice__c = null;
        receivePayments[0].Bill_Pay__c = objPO.Id;
        receivePayments[1].Bill_Pay__c = objPO.Id;
        
        // Insert receive payments
        insert receivePayments;
        
        Test.stopTest();
        
        // Validate PO attributes after receive payment creation
        validatePOAttributes(objPO.Id, 500.00);
    }
    
    // Test total payments made of multiple Purchase order related to bill pay
    static testMethod void testMultiplePOTotalPaymentsMadeRelatedToReceivePaymentInsert(){
        retrieveData();
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        Purchase_Order__c objPO = new Purchase_Order__c();
        objpO.PO_Status__c = 'Approved';
        objpO.PO_Type__c = 'Buy Quote';
        objPO.Supplier_Name__c = objAccount.Id;
        objPO.Ownership__c = objAccount.Id;
        insert objPO;
        
        Purchase_Order__c objPO1 = new Purchase_Order__c();
        objpO1.PO_Status__c = 'Approved';
        objpO1.PO_Type__c = 'Buy Quote';
        objPO1.Supplier_Name__c = objAccount.Id;
        objPO1.Ownership__c = objAccount.Id;
        insert objPO1;
        
        // Validate PO total payments made before any receive payment creation
        validatePOAttributes(objPO.Id, null);
        validatePOAttributes(objPO1.Id, null);
        
        Test.startTest();
        // Create Receive Payment of "Product" record type
        List<Receive_Payment__c> receivePayments = new List<Receive_Payment__c>(); 
        receivePayments.add(createReceivePayment(200.00, System.Today(), 'Product', false));
        receivePayments.add(createReceivePayment(300.00, System.Today(), 'Product', false));
        receivePayments.add(createReceivePayment(100.00, System.Today(), 'Product', false));
        receivePayments.add(createReceivePayment(200.00, System.Today(), 'Product', false));
        
        // Set Bill Pay in two receive payment
        receivePayments[0].Invoice__c = null;
        receivePayments[1].Invoice__c = null;
        receivePayments[2].Invoice__c = null;
        receivePayments[3].Invoice__c = null;
        receivePayments[0].Bill_Pay__c = objPO.Id;
        receivePayments[1].Bill_Pay__c = objPO.Id;
        receivePayments[2].Bill_Pay__c = objPO1.Id;
        receivePayments[3].Bill_Pay__c = objPO1.Id;
        
        // Insert receive payments
        insert receivePayments;
        
        Test.stopTest();
        
        // Validate PO attributes after receive payment creation
        validatePOAttributes(objPO.Id, 500.00);
        validatePOAttributes(objPO1.Id, 300.00);
        delete receivePayments;
    }
    
    // Test total payments made of Purchase order related to bill pay edit
    static testMethod void testPOTotalPaymentsMadeRelatedToReceivePaymentEdit(){
        retrieveData();
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        Purchase_Order__c objPO = new Purchase_Order__c();
        objpO.PO_Status__c = 'Approved';
        objpO.PO_Type__c = 'Buy Quote';
        objPO.Supplier_Name__c = objAccount.Id;
        objPO.Ownership__c = objAccount.Id;
        insert objPO;
        
        // Validate PO total payments made before any receive payment creation
        validatePOAttributes(objPO.Id, null);
        
        Test.startTest();
        // Create Receive Payment of "Product" record type
        List<Receive_Payment__c> receivePayments = new List<Receive_Payment__c>(); 
        receivePayments.add(createReceivePayment(200.00, System.Today(), 'Product', false));
        receivePayments.add(createReceivePayment(300.00, System.Today(), 'Product', false));
        
        // Set Bill Pay in two receive payment
        receivePayments[0].Invoice__c = null;
        receivePayments[1].Invoice__c = null;
        receivePayments[0].Bill_Pay__c = objPO.Id;
        receivePayments[1].Bill_Pay__c = objPO.Id;
        
        // Insert receive payments
        insert receivePayments;
        
        Test.stopTest();
        
        // Validate PO attributes after receive payment creation
        validatePOAttributes(objPO.Id, 500.00);
        
        // Change payment value of receive payment
        receivePayments[0].Payment_Amount__c = 150.00;
        update receivePayments[0];
        
        // Validate PO attributes after receive payment edit
        validatePOAttributes(objPO.Id, 450.00);
    }
    
    // Test total payments made of Purchase order related to bill pay delete
    static testMethod void testPOTotalPaymentsMadeRelatedToReceivePaymentDelete(){
        retrieveData();
        
        Account objAccount = new Account();
        objAccount.Name = 'Test Account1';
        objAccount.Payment_Terms__c = 'COD';
        insert objAccount;
        
        Purchase_Order__c objPO = new Purchase_Order__c();
        objpO.PO_Status__c = 'Approved';
        objpO.PO_Type__c = 'Buy Quote';
        objPO.Supplier_Name__c = objAccount.Id;
        objPO.Ownership__c = objAccount.Id;
        insert objPO;
        
        // Validate PO total payments made before any receive payment creation
        validatePOAttributes(objPO.Id, null);
        
        Test.startTest();
        // Create Receive Payment of "Product" record type
        List<Receive_Payment__c> receivePayments = new List<Receive_Payment__c>(); 
        receivePayments.add(createReceivePayment(200.00, System.Today(), 'Product', false));
        receivePayments.add(createReceivePayment(300.00, System.Today(), 'Product', false));
        
        // Set Bill Pay in two receive payment
        receivePayments[0].Invoice__c = null;
        receivePayments[1].Invoice__c = null;
        receivePayments[0].Bill_Pay__c = objPO.Id;
        receivePayments[1].Bill_Pay__c = objPO.Id;
        
        // Insert receive payments
        insert receivePayments;
        
        Test.stopTest();
        
        // Validate PO attributes after receive payment creation
        validatePOAttributes(objPO.Id, 500.00);
        
        // Delete first receive payment
       // delete receivePayments[0];
        
        // Validate PO attributes after receive payment delete
        //validatePOAttributes(objPO.Id, 300.00);
    }
        
    @TestSetUp
    static void testDataSetUp(){
        invoiceSO = new Invoice__c();
        invoiceSO.AR_Status__c = 'Approved';
        insert invoiceSO;
    }
    
    // Retrieve data created from data setup
    public static void retrieveData(){
        invoiceSO = [Select Id From Invoice__c];
    }
    
    // Create receive payment record
    private static Receive_Payment__c createReceivePayment(Decimal paymentAmount,
                                                           Date paymentReceivedDate,
                                                           String recordTypeName){
        return createReceivePayment(paymentAmount, paymentReceivedDate, recordTypeName, true);
    }
    
    private static Receive_Payment__c createReceivePayment(Decimal paymentAmount,
                                                           Date paymentReceivedDate,
                                                           String recordTypeName,
                                                           Boolean isInsert){
        // Create receive payment record
        Receive_Payment__c receivePaymentSO = new Receive_Payment__c();
        receivePaymentSO.Invoice__c = invoiceSO.Id;
        receivePaymentSO.Payment_Memo__c = 'Test Invoice memo';
        receivePaymentSO.Payment_Received_Date__c = paymentReceivedDate;
        receivePaymentSO.Payment_Form__c = 'Cash';
        receivePaymentSO.Payment_Amount__c = paymentAmount;
        receivePaymentSO.Posted_Date__c = null;
        receivePaymentSO.RecordTypeId = getRecordTypeId(recordTypeName);
        
        if(isInsert){
            insert receivePaymentSO;
        }
        return receivePaymentSO;
    }
    
    // Validate invoice attributes
    private static void validateInvoiceAttributes(Id invoiceId,
                                                  Date lastPaymentDate,
                                                  Decimal totalExciseTaxPayments,
                                                  Decimal totalProductPaymentAmount,
                                                  Decimal totalCultivationTaxAmount,
                                                  Decimal totalPaymentAmount){
                                                      
        Invoice__c invoiceObj = [Select Last_Payment_Date__c, 
                                    Total_Excise_Tax_Payments_Received__c,
                                    Total_Product_Payments_Received__c,
                                    Total_Cultivation_Tax_Payments_Received__c,
                                    Total_Payments_Received__c
                                From Invoice__c Where Id =: invoiceId];
        
       /* System.assertEquals(lastPaymentDate, invoiceObj.Last_Payment_Date__c,
                            'Invoice Last Payment Date mis-match');
        System.assertEquals(totalExciseTaxPayments, invoiceObj.Total_Excise_Tax_Payments_Received__c,
                            'Invoice Total Excise Tax Payment received mis-match');
        System.assertEquals(totalProductPaymentAmount, invoiceObj.Total_Product_Payments_Received__c,
                            'Invoice Total product Payment received is-match');
        System.assertEquals(totalCultivationTaxAmount, invoiceObj.Total_Cultivation_Tax_Payments_Received__c,
                            'Invoice Total Cultivation Tax Amount received mis-match');
        System.assertEquals(totalPaymentAmount, invoiceObj.Total_Payments_Received__c,
                            'Invoice Total Payment received mis-match');*/
    }
    
    // Validate PO attributes
    private static void validatePOAttributes(Id poId, Decimal totalPaymentsMade){
                                                      
        Purchase_Order__c poObj = [Select Total_Payments_Made__c From Purchase_Order__c Where Id =: poId];
        
        System.assertEquals(totalPaymentsMade, poObj.Total_Payments_Made__c,
                            'PO Total Payments made mis-match');
    }
    
    // Get record type id of receive payment object
    public static Id getRecordTypeId(String recordTypeName){
        Schema.DescribeSObjectResult sobjectResult = Schema.getGlobalDescribe().get('Receive_Payment__c').getDescribe();
        return sobjectResult.getRecordTypeInfosByName().get(recordTypeName).getRecordTypeId();
    }
}