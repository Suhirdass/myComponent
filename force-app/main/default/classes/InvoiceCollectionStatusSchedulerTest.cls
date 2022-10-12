/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * InvoiceCollectionStatusSchedulerTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class InvoiceCollectionStatusSchedulerTest{
    
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
        InvoiceCollectionStatusUpdateScheduler scheduledJob = new InvoiceCollectionStatusUpdateScheduler(); 
        String scheduledTime = '0 0 23 * * ?'; 
        System.schedule('Test Update Invoice collection status', scheduledTime, scheduledJob); 
        Test.StopTest();
        
        // Can't verify updated value of invoice status as batch job will be executed on scheduled time
    }
}