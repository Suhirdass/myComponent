/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * InvoiceCollectionStatusUpdateBatch
 */
public class InvoiceCollectionStatusUpdateBatch implements Database.Batchable<sObject>{

    private static final String statusPastDue = InvoiceSupport.INVOICE_COLLECTION_STATUS_PAST_DUE;
    
    // Start method having scope of invoice object
    public Database.QueryLocator start(Database.BatchableContext BC){
        String statusPaidInFull = InvoiceSupport.INVOICE_COLLECTION_STATUS_PAID_IN_FULL;
        String statusPastDue = InvoiceSupport.INVOICE_COLLECTION_STATUS_PAST_DUE;
        String query= 'Select Collections_Status__c From Invoice__c '+
                      'Where Invoice_Aged__c > 0 ' + 
                      'AND Collections_Status__c NOT IN (:statusPaidInFull, :statusPastDue)';
        return Database.getQueryLocator(Query);
    }

    // execute method to update invoice status
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        List<Invoice__c> scopeList = (List<Invoice__c>)scope;
        for(Invoice__c invoiceSO : scopeList){
            invoiceSO.Collections_Status__c = statusPastDue;
        }
        update scopeList;
    }

    // finish method - nothing to do as of now
    public void finish(Database.BatchableContext BC){}
}