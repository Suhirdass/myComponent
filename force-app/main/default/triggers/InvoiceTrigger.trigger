/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * InvoiceTrigger
 */
trigger InvoiceTrigger on Invoice__c (after insert,before insert,before delete, Before Update,after update) {
    
    if(trigger.isBefore){
        if(trigger.isUpdate && !ShippingManifestLineTriggerHandler.isSMCancelled){
            
            // Assign new calculated invoice due date if Shipped date or payment term of invoice updated
            for(Invoice__c invoiceSO : trigger.new){
                
                Invoice__c oldInvoice = trigger.oldMap.get(invoiceSO.Id);
                // Check if payment terms is updated. If yes then update invoice due date
                if(invoiceSO.Payment_Terms__c != oldInvoice.Payment_Terms__c ||
                   invoiceSO.Shipped_Date__c != oldInvoice.Shipped_Date__c|| invoiceSO.Ship_Confirmation_Date__c != oldInvoice.Ship_Confirmation_Date__c){
                    
                    invoiceSO.Invoice_Due_Date__c = InvoiceSupport.calculateInvoiceDueDate(invoiceSO.Ship_Confirmation_Date__c,invoiceSO.Shipped_Date__c,
                                                                                           invoiceSO.Payment_Terms__c);
                    
                }
            }
        }
        if(trigger.isUpdate){
        	InvoiceTriggerHandler.beforeUpdate(Trigger.new,Trigger.oldMap);    
        } else if(trigger.isInsert){
            InvoiceTriggerHandler.beforeInsert(Trigger.new);
        } else if(trigger.isDelete){
            InvoiceTriggerHandler.beforeDelete(Trigger.new,Trigger.oldMap);
        }
    }else if(trigger.isAfter){
        InvoiceSupport.calculateTaxOnCity(Trigger.New,Trigger.oldMap);
        InvoiceTriggerHandler.updateOpenBalance(Trigger.New);  
        if(Trigger.isInsert){
        	InvoiceTriggerHandler.afterInsert(Trigger.New);    
        } else if(Trigger.isUpdate){
        	InvoiceTriggerHandler.afterUpdate(Trigger.new,Trigger.oldMap);    
        }
    }
}