/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * ReceivePaymentTrigger
 */
trigger ReceivePaymentTrigger on Receive_Payment__c (after insert, after update,before update, before delete,after delete,before insert) {
    if(Trigger.isBefore){
        ReceivePaymentTriggerHandler.preventUpdatationOnLockedInvoice(Trigger.New,Trigger.Old);
        
    }
    if(Trigger.isAfter && trigger.isDelete){
        ReceivePaymentTriggerHandler.onDeleteCreditApplied(Trigger.Old);
    }
    if(Trigger.isUpdate && Trigger.isAfter){
        ReceivePaymentTriggerHandler.creditAppliedCount(trigger.new,true,(trigger.isUpdate?trigger.oldMap:null));
    }
    if(!(Trigger.isUpdate && Trigger.isBefore)){
        if(!Trigger.isDelete){
            ReceivePaymentTriggerHandler.updateLastPaymentDate(trigger.new);
        }
        if(Trigger.isAfter && trigger.isInsert){
            ReceivePaymentTriggerHandler.creditAppliedCount(trigger.new,false,(trigger.isUpdate?trigger.oldMap:null));
        } 
        List<Receive_Payment__c> receivePayments = new List<Receive_Payment__c>();
        Map<Id, Receive_Payment__c> oldReceivePayments = new Map<Id, Receive_Payment__c>();
        if(trigger.isInsert || trigger.isUpdate){	
            receivePayments = trigger.new;
            ReceivePaymentTriggerHandler.updatePostedDate(trigger.new,(trigger.isUpdate?trigger.oldMap:null));
            
        } else if(trigger.isDelete){ receivePayments = trigger.old;
                                    oldReceivePayments = trigger.oldMap;
                                   }
        ReceivePaymentTriggerHandler.updateInvoiceAttributesRelatedToReceivePayments(receivePayments,
                                                                                     oldReceivePayments,
                                                                                     trigger.isDelete);
    }
}