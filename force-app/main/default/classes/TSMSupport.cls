/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * TSMSupport
 */
public class TSMSupport{
    public static final string STATUS_RECEIVED = 'Received';
    public static final string STATUS_IN_TRASIT = 'In-Transit';
    
    /**
     * Change Status to TSM status, Actual Departure time of TSM
     * @param tsmList The list of TSMs to departConfirmTSM
     *
     * @return Updated TSM list
     */         
    public static List<Shipping_Manifest__c> departConfirmTSMs(List<Shipping_Manifest__c> tsmList) {
        for(Shipping_Manifest__c tsmObj : tsmList){
            tsmObj.Status__c = STATUS_IN_TRASIT;
            tsmObj.Actual_Departure_Date_Time__c = System.now();
        }
        return tsmList;
    }
}