/**
 * Copyright (c) 2021 WOVN
 * All rights reserved.
 * ShippinManifestSupportTest
 */
@isTest(OnInstall=false SeeAllData=false)
public class ShippinManifestSupportTest{
    
    static testMethod void testRecorTypeIds() {
        ShippinManifestSupport.getSMRecordTypeId(ShippinManifestSupport.RECORD_TYPE_RSM);
        ShippinManifestSupport.getSMLineRecordTypeId(ShippinManifestSupport.RECORD_TYPE_RSMLINE);
        ShippinManifestSupport.getRSMRecordTypeId();
        ShippinManifestSupport.getRSMLineRecordTypeId();
        ShippinManifestSupport.getTSMRecordTypeId();
        ShippinManifestSupport.getTSMLineRecordTypeId();
        ShippinManifestSupport.getPOProductRecordTypeId(DisplayRSMTSMController.PURCHASE_ORDER_RECORDTYPE_PRODUCT);
        ShippinManifestSupport.getSOProductRecordTypeId(DisplayRSMTSMController.SALES_ORDER_RECORDTYPE_PRODUCT);
        ShippinManifestSupport.getSOTransferRecordTypeId(DisplayRSMTSMController.SALES_ORDER_RECORDTYPE_TRANSFER);
    }
}