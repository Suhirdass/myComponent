/**
 * Copyright (c) 2021 WOVN
 * All rights reserved.
 * ShippinManifestSupport
 */
public class ShippinManifestSupport{

    public Static String SHIPPING_MANIFEST_RECORDTYPE_TRANSFER{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER) ? SHIPPING_MANIFEST_RECORDTYPE_TRANSFER: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Transfer');
        }set;
    }
    public Static String SHIPPING_MANIFEST_RECORDTYPE_LAB{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_LAB) ? SHIPPING_MANIFEST_RECORDTYPE_LAB: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Lab');
        }set;
    }
    public Static String SHIPPING_MANIFEST_RECORDTYPE_RSM{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_RSM) ? SHIPPING_MANIFEST_RECORDTYPE_RSM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_RSM');
        }set;
    }
    public Static String SHIPPING_MANIFEST_RECORDTYPE_PRODUCT_TSM{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_PRODUCT_TSM) ? SHIPPING_MANIFEST_RECORDTYPE_PRODUCT_TSM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Product_TSM');
        }set;
    }
    public Static String SHIPPING_MANIFEST_LINE_RECORDTYPE_PRODUCT_TSM_LINE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_RECORDTYPE_PRODUCT_TSM_LINE) ? SHIPPING_MANIFEST_LINE_RECORDTYPE_PRODUCT_TSM_LINE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SM_Line_RecordType_Product_TSM_Line_ID');
        }set;
    }
    public Static String SHIPPING_MANIFEST_LINE_RECORDTYPE_RSM_LINE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_RECORDTYPE_RSM_LINE) ? SHIPPING_MANIFEST_LINE_RECORDTYPE_RSM_LINE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SM_Line_RecordType_RSM_Line');
        }set;
    }
    


    public static final String RECORD_TYPE_TSM = SHIPPING_MANIFEST_RECORDTYPE_PRODUCT_TSM;
    public static final String RECORD_TYPE_RSM = SHIPPING_MANIFEST_RECORDTYPE_RSM;
    
    public static final String RECORD_TYPE_TSMLINE = SHIPPING_MANIFEST_LINE_RECORDTYPE_PRODUCT_TSM_LINE;
    public static final String RECORD_TYPE_RSMLINE = SHIPPING_MANIFEST_LINE_RECORDTYPE_RSM_LINE;
    
    public static final String RECORD_TYPE_TRANSFER = SHIPPING_MANIFEST_RECORDTYPE_TRANSFER;
    public static final String RECORD_TYPE_LAB = SHIPPING_MANIFEST_RECORDTYPE_LAB;
    
    // Get record type Id of shipping manifest object
    public static Id getSMRecordTypeId(String recordTypeName){ 
        return Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId();
    }
    
    // Get record type Id of shipping manifest object
    public static Id getTransferRecordTypeId(String recordTypeName){
        return Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId();
    }

    // Get record type Id of cash collection shipping manifest object
    public static Id getCashCollectionRecordTypeId(String recordTypeName){
        return Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId();
    }
    
    // Get record type Id of shipping manifest line object
    public static Id getSMLineRecordTypeId(String recordTypeName){
        return Schema.SObjectType.Shipping_Manifest_Line__c.getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId();
    }
    
    // Get RSM record type Id of shipping manifest object
    public static Id getRSMRecordTypeId(){
        return Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByDeveloperName().get(RECORD_TYPE_RSM).getRecordTypeId();
    }
    
    // Get RSM Line record type Id of shipping manifest line object
    public static Id getRSMLineRecordTypeId(){
        return Schema.SObjectType.Shipping_Manifest_Line__c.getRecordTypeInfosByDeveloperName().get(RECORD_TYPE_RSMLINE).getRecordTypeId();
    }
    
    // Get TSM record type Id of shipping manifest object
    public static Id getTSMRecordTypeId(){
        return Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByDeveloperName().get(RECORD_TYPE_TSM).getRecordTypeId();
    }
    
    // Get TSM Line record type Id of shipping manifest line object
    public static Id getTSMLineRecordTypeId(){
        return Schema.SObjectType.Shipping_Manifest_Line__c.getRecordTypeInfosByDeveloperName().get(RECORD_TYPE_TSMLINE).getRecordTypeId();
    }
     // Get Product record type Id of purchase order object
    public static Id getPOProductRecordTypeId(String recordTypeName){
        return Schema.SObjectType.Purchase_Order__c.getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId();
    }
    
     // Get Product record type Id of sales order object
    public static Id getSOProductRecordTypeId(String recordTypeName){
        return Schema.SObjectType.Sales_Order__c.getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId();
    }
       // Get Transfer record type Id of sales order object
    public static Id getSOTransferRecordTypeId(String recordTypeName){
        return Schema.SObjectType.Sales_Order__c.getRecordTypeInfosByDeveloperName().get(recordTypeName).getRecordTypeId();
    }
}