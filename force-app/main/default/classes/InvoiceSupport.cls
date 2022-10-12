/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * InvoiceSupport
 */
public with sharing class InvoiceSupport {
    public static Map<String, Tax_Table__c > cityTaxMap{
        get{
            if(cityTaxMap == null){
                cityTaxMap = new Map<String, Tax_Table__c >();
                for(Tax_Table__c tt: [SELECT Id,Active__c ,Actual_Tax_Rate_on_Product_Rev__c ,City__c, End_Date__c , Start_Date__c , Taxable_Gross_Receipts_Rate__c, Tax_Due_Rate__c  FROM Tax_Table__c WHERE Active__c = true]){
                    cityTaxMap.put(tt.City__c,tt);
                }
            }
            return cityTaxMap;
        }set;
    }
    public static final String INVOICE_STATUS_CANCELLED = 'Cancelled';
    public static final String INVOICE_COLLECTION_STATUS_PAID_IN_FULL = 'Paid in Full';
    public static final String INVOICE_COLLECTION_STATUS_PAST_DUE = 'Past Due';
    
    /**
     * Calculate Invoice Due date based on SO planned ship date and Payment terms
     * @param plannedShipDate The planned ship date of SO
     * @param paymentTerms The payment term value
     *
     * @return Calculated invoice due date
     */
    public static Date calculateInvoiceDueDate(Date plannedShipDate,
                                               String paymentTerms){
        
        if(plannedShipDate == null || String.isBlank(paymentTerms)){
            return plannedShipDate;
        }
        
        Date invoiceDueDate = plannedShipDate;
        
        // Get payment term custom settings and find the offset to add days
        Payment_Terms_Settings__c paymentTermSettings = Payment_Terms_Settings__c.getInstance(paymentTerms);
        
        if(paymentTermSettings != null && paymentTermSettings.Offset__c != null){
            invoiceDueDate = invoiceDueDate.addDays(Integer.valueOf(paymentTermSettings.Offset__c));
        }
        return invoiceDueDate;
    }
    public static Date calculateInvoiceDueDate(Date shipConfirmationDate,Date plannedShipDate, String paymentTerms){
        System.Debug('##shipConfirmationDate:'+shipConfirmationDate);
        Date invoiceDueDate = NULL;//System.today();
        if(shipConfirmationDate != null){
            invoiceDueDate = shipConfirmationDate;
            System.Debug('##invoiceDueDate updating from Ship Confirmation:'+invoiceDueDate);
        }/*else  if(plannedShipDate != null){
            invoiceDueDate = plannedShipDate;
            System.Debug('##invoiceDueDate updating from Plan Ship date:'+invoiceDueDate);
        }*/
        if(String.isNotBlank(paymentTerms) && invoiceDueDate != NULL){
            // Get payment term custom settings and find the offset to add days
            Payment_Terms_Settings__c paymentTermSettings = Payment_Terms_Settings__c.getInstance(paymentTerms);
            System.Debug('##invoiceDueDate before adding days:'+invoiceDueDate);
            if(paymentTermSettings != null && paymentTermSettings.Offset__c != null){
                System.debug('##Offset:'+Integer.valueOf(paymentTermSettings.Offset__c));
                invoiceDueDate = invoiceDueDate.addDays(Integer.valueOf(paymentTermSettings.Offset__c));
            }
        }
        System.Debug('##invoiceDueDate:'+invoiceDueDate);
        return invoiceDueDate;
    }
    public static void calculateTaxOnCity(Invoice__c[] newList, Map<Id,Invoice__c> oldInvoiceMap){
        Set<Id> invoiceNewRLIds = new Set<Id>();
        Set<Id> invoiceRemovedRLIds = new Set<Id>();
        for(Invoice__c inv: newList){
            if(Trigger.isInsert || inv.Receiver_License__c != oldInvoiceMap.get(inv.Id).Receiver_License__c){
                invoiceNewRLIds.add(inv.Id);
            }
        }
        if(!invoiceNewRLIds.isEmpty()){
            Invoice_Line__c[] invoiceLines = new Invoice_Line__c[]{};
            Invoice__c[] invoices = [SELECT Id, Invoice_Date__c ,Delivery_City__c,(SELECT Id,Line_Total_Product_Price__c ,Subtotal_Local_Cannabis_Tax__c FROM Invoice_Lines__r) FROM Invoice__c WHERE Id =:invoiceNewRLIds];
            for(Invoice__c inv: invoices){
                System.debug('#####Delivery_City:'+inv.Delivery_City__c);
                if(cityTaxMap.containsKey(inv.Delivery_City__c)){
                    Tax_Table__c tt = cityTaxMap.get(inv.Delivery_City__c);
                    System.debug('###Tax_Table__c:::'+tt);
                    Decimal subTotal = 0;
                    decimal taxRateOnProd = tt.Actual_Tax_Rate_on_Product_Rev__c != null?tt.Actual_Tax_Rate_on_Product_Rev__c/100:0;
                    decimal taxableGrossReceiptsRate = tt.Taxable_Gross_Receipts_Rate__c != null?tt.Taxable_Gross_Receipts_Rate__c/100:0; 
                    decimal taxDueRate = tt.Tax_Due_Rate__c != null?tt.Tax_Due_Rate__c/100:0;
                    if(tt != null && tt.End_Date__c >= inv.Invoice_Date__c){
                        for(Invoice_Line__c invLine: inv.Invoice_Lines__r){
                            subTotal = invLine.Line_Total_Product_Price__c * taxableGrossReceiptsRate * taxDueRate;
                            if(taxRateOnProd > 0){
                                subTotal = subTotal * taxRateOnProd;
                            }
                            invLine.Subtotal_Local_Cannabis_Tax__c = subTotal;
                            invoiceLines.add(invLine);
                        }
                        
                    }else{
                        for(Invoice_Line__c invLine: inv.Invoice_Lines__r){
                            invLine.Subtotal_Local_Cannabis_Tax__c = 0;
                            invoiceLines.add(invLine);
                        }
                    }
                    
                }else{
                    for(Invoice_Line__c invLine: inv.Invoice_Lines__r){
                        invLine.Subtotal_Local_Cannabis_Tax__c = 0;
                        invoiceLines.add(invLine);
                    }
                }
            }
            if(!invoiceLines.isEmpty()){
                update invoiceLines;
            }
        }
    }
}