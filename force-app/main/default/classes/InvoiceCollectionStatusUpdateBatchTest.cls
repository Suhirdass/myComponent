/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * InvoiceCollectionStatusUpdateBatchTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class InvoiceCollectionStatusUpdateBatchTest{
    
    // Test method to update invoice status 
    public static testmethod void testUpdateInvoiceCollectionStatus(){
        
        TestUtilData.createTestData();
        
        String statusPaidInFull = InvoiceSupport.INVOICE_COLLECTION_STATUS_PAID_IN_FULL;
        String statusPastDue = InvoiceSupport.INVOICE_COLLECTION_STATUS_PAST_DUE;
        
        Invoice__c invoiceSO = [Select Invoice_Due_Date__c, Collections_Status__c From Invoice__c];
        invoiceSO.Invoice_Due_Date__c = System.Today () - 5;
        invoiceSO.Collections_Status__c = 'Pending';
        update invoiceSO;
        
        Invoice__c anotherInvoice = invoiceSO.clone(false, true);
        insert anotherInvoice;
        
        Test.StartTest();
        InvoiceCollectionStatusUpdateBatch batchJob = new InvoiceCollectionStatusUpdateBatch(); 
        database.executebatch(batchJob);
        Test.StopTest();
        
        List<Invoice__c> invoices = [Select Collections_Status__c From Invoice__c];
        System.assertEquals(2, invoices.size(), 'Invoice size mis-match');
        System.assertEquals(statusPastDue, invoices[0].Collections_Status__c, 'Invoice collection status mis-match');
        System.assertEquals(statusPastDue, invoices[1].Collections_Status__c, 'Invoice collection status mis-match');
    }
}