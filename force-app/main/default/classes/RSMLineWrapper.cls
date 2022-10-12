/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * RSMLineWrapper
 */
public class RSMLineWrapper{
    @AuraEnabled public boolean selected {get; set;}
    @AuraEnabled public boolean disabled {get; set;}
    @AuraEnabled public Shipping_Manifest_Line__c rsmLineSO {get; set;}
    @AuraEnabled public Decimal qtyToReceive {get; set;}
    
    public RSMLineWrapper(){
        selected = false;
        disabled = false;
        rsmLineSO = new Shipping_Manifest_Line__c();
    }
}