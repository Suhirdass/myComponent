/**
 * Copyright (c) 2019 Filigreen Distro
 * All rights reserved.
 * PicklistSupport
 */
public class PicklistSupport{
    
    public Static String SHIPPING_MANIFEST_STATUS_DRAFT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_DRAFT) ? SHIPPING_MANIFEST_STATUS_DRAFT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Draft');
        }set;
    } 
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
    public Static String SALESORDER_RECORDTYPE_TRANSFER {		
        get{
            return String.isNotBlank(SALESORDER_RECORDTYPE_TRANSFER) ? SALESORDER_RECORDTYPE_TRANSFER: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Order_Type_Transfer');
        }set;
    }
    public Static String SALESORDER_RECORDTYPE_LAB {		
        get{
            return String.isNotBlank(SALESORDER_RECORDTYPE_LAB) ? SALESORDER_RECORDTYPE_LAB: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_RecordType_Lab');
        }set;
    }
    
    public Static String PICKLIST_QACONFIRM{
        get{
            return String.isNotBlank(PICKLIST_QACONFIRM) ? PICKLIST_QACONFIRM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','PickList_Status_QaConfirm');
        }set;
    } 
    public Static String PICKLIST_QAREVIEW{
        get{
            return String.isNotBlank(PICKLIST_QAREVIEW) ? PICKLIST_QAREVIEW: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Picklist_QAReveiew');
        }set;
    } 
    
    public static final string STATUS_DRAFT = SHIPPING_MANIFEST_STATUS_DRAFT;
    public static final string STATUS_QA_REVIEW = PICKLIST_QAREVIEW;
    public static final string STATUS_QA_CONFIRM = PICKLIST_QACONFIRM;
    /**
     * Create RSM instance
     *
     * @return The instance of RSM
     */
    public static Shipping_Manifest__c createRSM(Picklist__c picklistObj){
        Shipping_Manifest__c rsmObj  = new Shipping_Manifest__c();
        rsmObj.Shipment_Instructions__c     = picklistObj.Special_Instructions__c;
        rsmObj.Brand_Quote__c               = picklistObj.Sales_Order__r.Brand_Quote__c;
        rsmObj.Sales_Order__c               = picklistObj.Sales_Order__c;
        rsmObj.Customer_PO_or_Quote__c      = picklistObj.Sales_Order__r.Customer_PO_or_Quote__c;
        rsmObj.Distributor_Contact__c       = picklistObj.Sales_Order__r.Distributor_Contact__c;
        rsmObj.Distributor_License__c       = picklistObj.Sales_Order__r.Distributor_License__c;
        rsmObj.Distributor_Name__c          = picklistObj.Sales_Order__r.Distributor_Name__c;
        rsmObj.Opportunity_Name__c          = picklistObj.Sales_Order__r.Opportunity_Name__c;
        rsmObj.Payment_Terms__c             = picklistObj.Sales_Order__r.Payment_Terms__c;
        rsmObj.Picklist__c                  = picklistObj.Id;
        rsmObj.Planned_Ship_Transfer_Date__c = picklistObj.Sales_Order__r.Planned_Ship_Date__c;
        rsmObj.Receiver_Contact__c          = picklistObj.Sales_Order__r.Receiver_Contact__c;
        rsmObj.Receiver_License__c          = picklistObj.Sales_Order__r.Receiver_License__c;
        rsmObj.Receiver_Name__c             = picklistObj.Sales_Order__r.Receiver_Name__c;
        rsmObj.Status__c                    = STATUS_DRAFT;
        rsmObj.Sample_Order__c              = picklistObj.Sales_Order__r.Sample_Order__c;
        rsmObj.Shipping_Method__c           = picklistObj.Sales_Order__r.Shipping_Method__c;
        rsmObj.Shipping_Terms__c            = picklistObj.Sales_Order__r.Shipping_Terms__c;
        rsmObj.Site__c                      = picklistObj.Site__c;
        rsmObj.Supplier_Contact__c          = picklistObj.Sales_Order__r.Supplier_Contact__c;
        rsmObj.Supplier_License__c          = picklistObj.Sales_Order__r.Supplier_License__c;
        rsmObj.Supplier_Name__c             = picklistObj.Sales_Order__r.Supplier_Name__c;
        rsmObj.Ownership__c                 = picklistObj.Sales_Order__r.Ownership__c;
        rsmObj.driver__c                    = picklistObj.Sales_Order__r.driver__c;
        rsmObj.Vehicle__c                   = picklistObj.Sales_Order__r.Vehicle__c;
        rsmObj.Route_Start_Time__c 			= picklistObj.Sales_Order__r.Window_Start__c;
        rsmObj.Route_End_Time__c 			= picklistObj.Sales_Order__r.Window_End__c;
        rsmObj.Window_Start__c 			    = picklistObj.Sales_Order__r.Window_Start__c;
        rsmObj.Window_End__c 			    = picklistObj.Sales_Order__r.Window_End__c;
        rsmObj.Priority__c                  = picklistObj.Sales_Order__r.Priority__c;
        if(picklistObj.Sales_Order__c != NULL && picklistObj.Sales_Order__r.RecordType.Name == SALESORDER_RECORDTYPE_LAB){
            rsmObj.RecordTypeId = ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_LAB);    
        }else if(picklistObj.Sales_Order__c != NULL && picklistObj.Sales_Order__r.RecordType.Name == SALESORDER_RECORDTYPE_TRANSFER){
            rsmObj.RecordTypeId = ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER);    
        }else{
            rsmObj.RecordTypeId = ShippinManifestSupport.getRSMRecordTypeId();
        }
        
        if(picklistObj.Sales_Order__r.Brand_Quote__r.Opportunity_Name__c != null &&picklistObj.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c != null){
            rsmObj.Order_Number__c = picklistObj.Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c;
        }
        return rsmObj;
    }
    
    /**
     * Create RSM line instance
     *
     * @param picklistLineObj The instance of Picklist line record
     * @param rsmId The RSM Id
     *
     * @return The instance of RSM line
     */
    public static Shipping_Manifest_Line__c createRSMLine(Picklist_Line__c picklistLineObj, Id rsmId, Id recordTypeId){
        Shipping_Manifest_Line__c rsmLineObj = new Shipping_Manifest_Line__c();
        rsmLineObj.Picklist_Line__c                 = picklistLineObj.Id;
        rsmLineObj.Sales_Order_Line__c              = picklistLineObj.Sales_Order_Line__c;
        rsmLineObj.Product_Name__c                  = picklistLineObj.Product_Name__c;
        rsmLineObj.Product_Title__c                 = picklistLineObj.Sales_Order_Line__r.Product_Title__c;
        rsmLineObj.Is_Sample__c                     = picklistLineObj.Sales_Order_Line__r.Is_Sample__c;
        rsmLineObj.IsPromo__c                     = picklistLineObj.Sales_Order_Line__r.IsPromo__c;
        //rsmLineObj.Qty_Received__c                = picklistLineObj.Sales_Order_Line__r.Qty_Allocated__c;
        rsmLineObj.Shipping_Manifest__c             = rsmId;
        rsmLineObj.Retail_Wholesale_Price__c        = picklistLineObj.Sales_Order_Line__r.Retail_Wholesale_Price__c;
        rsmLineObj.UID__c                           = picklistLineObj.Sales_Order_Line__r.UID__c;
        rsmLineObj.Shipment_Qty__c                  = picklistLineObj.Qty_to_Pick__c;
        rsmLineObj.RecordTypeId                     = recordTypeId;
        rsmLineObj.Ownership_Code__c                = picklistLineObj.Ownership_Code__c;
        return rsmLineObj;
    }
     
    /**
     * Retrieve Picklist with lines record
     *
     * @return The picklist with lines record
     */         
    public static Picklist__c retrievePicklistAndLines(Id picklistId) {
        return [Select Sales_Order__c,Special_Instructions__c,
                       Sales_Order__r.Brand_Quote__c,
                Sales_Order__r.Driver__c,
                Sales_Order__r.Vehicle__c,
                       Sales_Order__r.RecordType.Name,
                       Sales_Order__r.Brand_Quote__r.Opportunity_Name__c,
                       Sales_Order__r.Brand_Quote__r.Opportunity_Name__r.Order__c,
                       Sales_Order__r.Customer_PO_or_Quote__c,
                       Sales_Order__r.Distributor_Contact__c,
                       Sales_Order__r.Distributor_License__c,
                       Sales_Order__r.Distributor_Name__c,
                       Sales_Order__r.Opportunity_Name__c,
                       Sales_Order__r.Payment_Terms__c,
                       Sales_Order__r.Planned_Ship_Date__c,
                       Sales_Order__r.Receiver_Contact__c,
                       Sales_Order__r.Receiver_License__c,
                       Sales_Order__r.Receiver_Name__c,
                       Sales_Order__r.Sample_Order__c,
                       Sales_Order__r.Shipping_Method__c,
                       Sales_Order__r.Shipping_Terms__c,
                       Sales_Order__r.Supplier_Contact__c,
                       Sales_Order__r.Supplier_License__c,
                       Sales_Order__r.Supplier_Name__c,
                       Sales_Order__r.Ownership__c,
                	   Sales_Order__r.Window_Start__c,
                	   Sales_Order__r.Window_End__c,
                	   Sales_Order__r.Priority__c,
                       Site__c,
                       Status__c,Pick_End__c,
                       (Select Product_Name__c,Sales_Order_Line__c,OwnerShip_code__c,
                               Sales_Order_Line__r.Product_Title__c,
                               Sales_Order_Line__r.Qty_Allocated__c,Qty_to_Pick__c,
                               Sales_Order_Line__r.Retail_Wholesale_Price__c,
                               Sales_Order_Line__r.UID__c,
                               Sales_Order_Line__r.Is_Sample__c,Sales_Order_Line__r.IsPromo__c,
                               Pack_out_UID__c,Pack_out_UID__r.In_Use__c,
                               Inventory_Position__c,Status__c,
                               Inventory_Position__r.Site__c
                        From Picklist_Lines__r)
                From Picklist__c
                Where Id =:picklistId];
    }
}