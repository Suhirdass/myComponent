/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * SalesOrderTrigger
 */
trigger SalesOrderTrigger on Sales_Order__c (before insert, before update,After Update) {
    if(!ShippingManifestLineTriggerHandler.isSMCancelled){
        if(Trigger.isBefore && trigger.isUpdate){
            SalesOrderHelper.updatePrePlannedDate(trigger.new, trigger.oldMap);
            //SalesOrderHelper.updateSiteFromReceiverLicense(Trigger.New,Trigger.oldMap);
        }
        if(Trigger.isAfter && Trigger.isUpdate){
                SalesOrderHelper.createDeletePickListAndLines(trigger.new, trigger.oldMap);
                SalesOrderHelper.updateTotalMileageFeeOnSO(trigger.new, trigger.oldMap);
                //LocalTaxCalculateHelper.calculateTaxOnCity(Trigger.new,Trigger.oldMap);
                SalesOrderHelper.updateWinStartEnd(trigger.new, trigger.oldMap);
        }
    }
    //FG-206 GLOBAL 
    if(Trigger.isBefore && Trigger.isUpdate){
        SalesOrderHelper.approvalHoldAccount(Trigger.New,Trigger.oldMap);
    }
}