/**
* Copyright (c) 2021 Filigreen Distro
* All rights reserved.
* ShippingManifestHandler
*/
public class ShippingManifestHandler {
    
    public static boolean isTestClass = false;
    public static boolean internShipmentComplete = false;
    public static boolean internNewOldShipmentStatus = false;
    public static boolean internsmStatusCompleteToReject = false;
    public static boolean internsmStatusRejectedToComplete = false;
    public static boolean internsmStatusCancelledToComplete = false;
     public static boolean internsmStatusCompleteToCancelled= false;
  
    
    public Static String SHIPPING_MANIFEST_DEVELOPER_NAME_PRODUCT_NAME{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_DEVELOPER_NAME_PRODUCT_NAME) ? SHIPPING_MANIFEST_DEVELOPER_NAME_PRODUCT_NAME: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Developer_ProductTSM');
        }set;
    }
    
     public Static String SHIPPING_MANIFEST_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_CANCELLED) ? SHIPPING_MANIFEST_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Cancelled');
        }set;
    }
    
    public static String Receiving_Inspection{
        get{
            return String.isNotBlank(Receiving_Inspection) ? Receiving_Inspection : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Receiving_Inspection');
        }set;
    }
    
      public Static String SHIPPING_MANIFEST_LINE_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_STATUS_CANCELLED) ? SHIPPING_MANIFEST_LINE_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Cancelled');
        }set;
    }
    
     public Static String SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE) ? SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Shipment_Complete');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_STATUS_INTRANSIT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_INTRANSIT) ? SHIPPING_MANIFEST_STATUS_INTRANSIT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_InTransit');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_STATUS_COMPLETE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_COMPLETE) ? SHIPPING_MANIFEST_STATUS_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Complete');
        }set;
    }
    
     public Static String SHIPPING_MANIFEST_LINE_STATUS_REJECTED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_STATUS_REJECTED) ? SHIPPING_MANIFEST_LINE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Rejected');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_REJECTED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_REJECTED) ? SHIPPING_MANIFEST_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Rejected');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_RECORDTYPE_TRANSFER{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER) ? SHIPPING_MANIFEST_RECORDTYPE_TRANSFER: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Transfer');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_LINE_RECORDTYPE_TRANSFERLINE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_RECORDTYPE_TRANSFERLINE) ? SHIPPING_MANIFEST_LINE_RECORDTYPE_TRANSFERLINE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Sm_Line_Record_Type_Transfer_Line');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_RECORDTYPE_CASHCOLLECTION{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_CASHCOLLECTION) ? SHIPPING_MANIFEST_RECORDTYPE_CASHCOLLECTION: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_CashCollect');
        }set;
    }
    
    
    public Static String SHIPPING_MANIFEST_LINE_RECORDTYPE_CASHCOLLECTION_LINE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_RECORDTYPE_CASHCOLLECTION_LINE) ? SHIPPING_MANIFEST_LINE_RECORDTYPE_CASHCOLLECTION_LINE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SM_Line_RecordType_Cash_Collection_Line');
        }set;
    } 
     public Static String SHIPPING_MANIFEST_RECORDTYPE_LAB{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_LAB) ? SHIPPING_MANIFEST_RECORDTYPE_LAB: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Lab');
        }set;
    }
    
     public Static String SHIPPING_MANIFEST_LINE_RECORDTYPE_LAB_LINE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_RECORDTYPE_LAB_LINE) ? SHIPPING_MANIFEST_LINE_RECORDTYPE_LAB_LINE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SM_Line_RecordType_Lab_Line');
        }set;
    } 
    public Static String SHIPPING_MANIFEST_RECORDTYPE_PRODUCT_TSM{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_PRODUCT_TSM) ? SHIPPING_MANIFEST_RECORDTYPE_PRODUCT_TSM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_ProductTSM');
        }set;
    }
      public Static String SHIPPING_MANIFEST_LINE_RECORDTYPE_PRODUCT_TSM_LINE {
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_RECORDTYPE_PRODUCT_TSM_LINE) ? SHIPPING_MANIFEST_LINE_RECORDTYPE_PRODUCT_TSM_LINE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SM_Line_RecordType_Product_TSM_Line');
        }set;
    } 
     public Static String SHIPPING_MANIFEST_RECORDTYPE_SERVICE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_SERVICE) ? SHIPPING_MANIFEST_RECORDTYPE_SERVICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Service');
        }set;
    }
     public Static String SHIPPING_MANIFEST_RECORDTYPE_SERVICE_LINE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_SERVICE_LINE) ? SHIPPING_MANIFEST_RECORDTYPE_SERVICE_LINE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Sm_Line_Record_Type_Service_Line');
        }set;
    }
      public Static String SHIPPING_MANIFEST_RECORDTYPE_RSM{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_RSM) ? SHIPPING_MANIFEST_RECORDTYPE_RSM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_RSM');
        }set;
    }
     public Static String SHIPPING_MANIFEST_RECORDTYPE_RSM_LINE {
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_RSM_LINE) ? SHIPPING_MANIFEST_RECORDTYPE_RSM_LINE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SM_Line_RecordType_RSMLine');
        }set;
    }
    public Static String INVOICE_RECORDTYPE_PRODUCT{
        get{
            return String.isNotBlank(INVOICE_RECORDTYPE_PRODUCT) ? INVOICE_RECORDTYPE_PRODUCT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Product');
        }set;
    }
    
      public Static String SHIPPING_MANIFEST_RECORDTYPE_DELIVERED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_DELIVERED) ? SHIPPING_MANIFEST_RECORDTYPE_DELIVERED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Delivered');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_RECORDTYPE_TRANSFFERED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_TRANSFFERED) ? SHIPPING_MANIFEST_RECORDTYPE_TRANSFFERED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Transferred');
        }set;
    }
    public Static String SHIPPING_MANIFEST_RECORDTYPE_TEST_SAMPLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_TEST_SAMPLED) ? SHIPPING_MANIFEST_RECORDTYPE_TEST_SAMPLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_TestSampled');
        }set;
    } 

    public Static String SALES_ORDER_STATUS_CANCELLED_BY_FILIGREEN{
        get{
            return  String.isNotBlank(SALES_ORDER_STATUS_CANCELLED_BY_FILIGREEN) ? SALES_ORDER_STATUS_CANCELLED_BY_FILIGREEN: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Filigreen');
        }set;
    }
    
    public Static String SALES_ORDER_STATUS_CANCELLED_BY_CUSTOMER{
        get{
            return  String.isNotBlank(SALES_ORDER_STATUS_CANCELLED_BY_CUSTOMER) ? SALES_ORDER_STATUS_CANCELLED_BY_CUSTOMER: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Customer');
        }set;
    }
    
     public Static String PICKLIST_STATUS_QA_CONFIRM{
        get{
            return  String.isNotBlank(PICKLIST_STATUS_QA_CONFIRM) ? PICKLIST_STATUS_QA_CONFIRM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','PickList_Status_QaConfirm');
        }set;
    }
	public Static String SALES_ORDER_STATUS_SHIPPED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_SHIPPED) ? SALES_ORDER_STATUS_SHIPPED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Shipped');
        }set;
    }
    public Static String SHIPPING_MANIFEST_SITETOSITE_SHIPMETHOD{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_SITETOSITE_SHIPMETHOD) ? SHIPPING_MANIFEST_SITETOSITE_SHIPMETHOD: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_SiteToSite_ShipMethod');
        }set;
    }
    
     public Static String SHIPPING_MANIFEST_STATUS_DRAFT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_DRAFT) ? SHIPPING_MANIFEST_STATUS_DRAFT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Draft');
        }set;
    }
    
    public Static String SO_STATUS_DRAFT {		
        get{
            return String.isNotBlank(SO_STATUS_DRAFT) ? SO_STATUS_DRAFT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Draft');
        }set;
    }
    
     public Static String SALES_ORDER_LINE_STATUS_ALLOCATED {		
        get{
            return String.isNotBlank(SALES_ORDER_LINE_STATUS_ALLOCATED) ? SALES_ORDER_LINE_STATUS_ALLOCATED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Allocated');
        }set;
    }
    
    public Static String SALES_ORDER_STATUS_APPROVED {		
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_APPROVED) ? SALES_ORDER_STATUS_APPROVED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Approved');
        }set;
    }
    
      public Static String INVOICE_AR_STATUS_SHIPPED{
        get{
            return String.isNotBlank(INVOICE_AR_STATUS_SHIPPED) ? INVOICE_AR_STATUS_SHIPPED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Shipped');
        }set;
    }
    private static String Sales_Order_Line_Status_Cancelled{
        get{
            return String.isNotBlank(Sales_Order_Line_Status_Cancelled) ? Sales_Order_Line_Status_Cancelled : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Cancelled');
        }set;
    }
    private static String Invoice_Ar_Status_Approved{
        get{
            return String.isNotBlank(Invoice_Ar_Status_Approved) ? Invoice_Ar_Status_Approved : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Ar_Status_Approved');
        }set;
    }
    private static String Invoice_Record_Type_Tax{
        get{
            return String.isNotBlank(Invoice_Record_Type_Tax) ? Invoice_Record_Type_Tax : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_Record_Type_Tax Protected');
        }set;
    }
    private static String STATE_LICENSE_ACTIVE{
        get{
            return String.isNotBlank(STATE_LICENSE_ACTIVE) ? STATE_LICENSE_ACTIVE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_Active');
        }set;
    }
    private static String STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE{
        get{
            return String.isNotBlank(STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE) ? STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_License_Holder_RecordType');
        }set;
    }
    private static String STATE_LICENSE_NONCANNABIS_RECORDTYPE{
        get{
            return String.isNotBlank(STATE_LICENSE_NONCANNABIS_RECORDTYPE) ? STATE_LICENSE_NONCANNABIS_RECORDTYPE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_NonCannabis_RecordType');
        }set;
    }
    public static String PRODUCT_RECORD_TYPE_NAME_DISCOUNT{
        get{
            return String.isNotBlank(PRODUCT_RECORD_TYPE_NAME_DISCOUNT) ? PRODUCT_RECORD_TYPE_NAME_DISCOUNT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Record_Type_Discount');
        }set;
    }
    Private Static String INVOICE_RECORD_TYPE_SERVICE{
        get{
            return String.isNotBlank(INVOICE_RECORD_TYPE_SERVICE) ? INVOICE_RECORD_TYPE_SERVICE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Invoice_RecordType_Service');
        }set;
    }
    private static String TYPE_ADD_BRAND_CONTACT{
        get{
            return String.isNotBlank(TYPE_ADD_BRAND_CONTACT) ? TYPE_ADD_BRAND_CONTACT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Retailer_Related_Contact__c','Type_Add_Brand_Contact');
        }set;
    }
    private static String TYPE_ADD_RETAIL_CONTACT{
        get{
            return String.isNotBlank(TYPE_ADD_RETAIL_CONTACT) ? TYPE_ADD_RETAIL_CONTACT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Retailer_Related_Contact__c','Type_Add_Retail_Contact');
        }set;
    }
    public static void routeMilesCalculation(List<Shipping_Manifest__c> manifestList, Map<Id,Shipping_Manifest__c> oldMap){
       
        List<Shipping_Manifest__c> manifests = new List<Shipping_Manifest__c>();
        List<Shipping_Manifest__c> records = [SELECT Id,recordType.DeveloperName, Geocode_Error__c ,Total_Route_Miles__c ,
                                              Distributor_Address__c,
                                              Distributor_City_State_Zip__c,
                                              Receiver_Address__c ,Receiver_City_State_Zip__c,
                                              Supplier_Address__c, Supplier_City_State_Zip__c,
                                              Distributor_License__c ,
                                              Receiver_License__c ,
                                              Supplier_License__c 
                                              
                                              FROM Shipping_Manifest__c WHERE Id IN :Trigger.New];
        if(oldMap.size() == 0){
            for(Shipping_Manifest__c obj : records){
                if(String.isNotBlank(obj.Receiver_License__c)){
                       if(obj.recordType.DeveloperName == SHIPPING_MANIFEST_DEVELOPER_NAME_PRODUCT_NAME &&
                          String.isNotBlank(obj.Supplier_License__c)){
                              manifests.add(obj);
                          }else{
                              if(String.isNotBlank(obj.Distributor_License__c)){ manifests.add(obj);
                                 }      
                          }
                   }
            }
        }else{
            for(Shipping_Manifest__c obj : records){
                if(oldMap.get(obj.Id).Receiver_License__c != obj.Receiver_License__c){  if(obj.recordType.DeveloperName == SHIPPING_MANIFEST_DEVELOPER_NAME_PRODUCT_NAME && 
                       obj.Supplier_License__c!= null){ manifests.add(obj);
                       }else if(obj.Distributor_License__c!= null){  manifests.add(obj);
                       }
                    
                }else if(obj.Receiver_License__c!= null && obj.recordType.DeveloperName == SHIPPING_MANIFEST_DEVELOPER_NAME_PRODUCT_NAME && (oldMap.get(obj.Id).Supplier_License__c != obj.Supplier_License__c)){  manifests.add(obj);
                         }else if(obj.Receiver_License__c!= null && oldMap.get(obj.Id).Distributor_License__c != obj.Distributor_License__c){ manifests.add(obj);
                         }
                
            }
        }
        if(!Test.isRunningTest()){ if(manifests.size() > 0){Database.executeBatch(new CalculateManifestMilesBtch(manifests), 1);    
            }
        }    
    }
    
    /**
     * Update Driver, Vehicle and Planned Ship/Transfer Date From Shipping Manifest to SO/PO
     */
    public static void syncPOSOFromShippingManifest(List<Shipping_Manifest__c> smList){
        List<Sales_Order__c> salesOrders = new List<Sales_Order__c>();
        List<Purchase_Order__c> purchaseOrders = new List<Purchase_Order__c>();
        Set<Id> soIds = new Set<Id>();
        Set<Id> poIds = new Set<Id>();
        for(Shipping_Manifest__c smObj : smList){
            
            // Add SO records
            if(smObj.Sales_Order__c != null && !soIds.contains(smObj.Sales_Order__c)){
                Sales_Order__c soObj = new Sales_Order__c();
                soObj.Id = smObj.Sales_Order__c;
               // if(String.isNotBlank(smObj.Driver__c)){
                    soObj.Driver__c = smObj.Driver__c;
               // }
              //  if(String.isNotBlank(smObj.Vehicle__c)){
                	soObj.Vehicle__c = smObj.Vehicle__c;    
               // }
                /*soObj.Driver__c = smObj.Driver__c;
                soObj.Vehicle__c = smObj.Vehicle__c;*/
                soObj.Planned_Ship_Date__c = smObj.Planned_Ship_Transfer_Date__c;
                salesOrders.add(soObj);
                soIds.add(soObj.Id);
            }
            
            // Add PO records
            if(smObj.Purchase_Order__c != null && !poIds.contains(smObj.Purchase_Order__c)){
                Purchase_Order__c poObj = new Purchase_Order__c(); poObj.Id = smObj.Purchase_Order__c;
             //   if(String.isNotBlank(smObj.Driver__c)){
                    poObj.Driver__c = smObj.Driver__c;
             //   }
               // if(String.isNotBlank(smObj.Vehicle__c)){
                	poObj.Vehicle__c = smObj.Vehicle__c;    
              //  }
                /*poObj.Driver__c = smObj.Driver__c;
                poObj.Vehicle__c = smObj.Vehicle__c;*/
                poObj.Planned_Ship_Transfer_Date__c = smObj.Planned_Ship_Transfer_Date__c;   purchaseOrders.add(poObj);
                poIds.add(poObj.Id);
            }
        }
        
        // Update Sales Orders
        if(salesOrders.size() > 0){
            update salesOrders;
        }
        
        // Update Purchase Orders
        if(purchaseOrders.size() > 0){update purchaseOrders;
        }
    }
    
    public static void cancelLineItems(List<Shipping_Manifest__c> smList,Map<Id,Shipping_Manifest__c> oldMap){ List<Shipping_Manifest__c> toUpdate = new List<Shipping_Manifest__c>();
      internsmStatusCompleteToCancelled =True;
                                                                                                              for(Shipping_Manifest__c smObj : smList){
            if(oldMap.get(smObj.Id).Status__c != smObj.Status__c && smObj.Status__c == SHIPPING_MANIFEST_STATUS_CANCELLED){toUpdate.add(smObj);
            }
        }
        if(toUpdate.size() > 0){ List< Shipping_Manifest_Line__c > lines = new List< Shipping_Manifest_Line__c >();
            for( Shipping_Manifest_Line__c line : [SELECT Id FROM Shipping_Manifest_Line__c  WHERE SMLine_Status__c !=:SHIPPING_MANIFEST_LINE_STATUS_CANCELLED AND Shipping_Manifest__c IN :toUpdate]){
                lines.add(new Shipping_Manifest_Line__c(Id = line.Id, SMLine_Status__c = SHIPPING_MANIFEST_LINE_STATUS_CANCELLED));
            }
            if(lines.size() > 0){ShippingManifestLineTriggerHandler.cancel();update lines;
            }
            SMCancelAllRelatedItems.getRelatedItems(toUpdate);
        }
    }
    
    
    public static void afterInsert(List<Shipping_Manifest__c> smList){
        Set<Id> smIds = new Set<Id>();
        Set<Id> smTransIds = new Set<Id>();
        
        for(Shipping_Manifest__c sm : smList){
            if(sm.Status__c == SHIPPING_MANIFEST_STATUS_INTRANSIT){smIds.add(sm.Id);    
            }
            
            if(sm.recordTypeId != null){
            	Id devRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER).getRecordTypeId();
                if(sm.recordTypeId == devRecordTypeId && sm.Shipping_Method__c == SHIPPING_MANIFEST_SITETOSITE_SHIPMETHOD && sm.Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE){
                 	smTransIds.add(sm.Id);	   
                }
            }
        }
        if(smIds.size() > 0) ShippingManifestHandler.updateSMLines(smIds);
        if(smTransIds.size() > 0) ShippingManifestHandler.updateIpsForTransferOrder(smTransIds);
        
    }
    
    public static void afterUpdate(List<Shipping_Manifest__c> smList,Map<Id,Shipping_Manifest__c> oldMap){
        Set<Id> smIds = new Set<Id>();
        List<Shipping_Manifest__c> completedRecords = new List<Shipping_Manifest__c>();
        List<Shipping_Manifest__c> cancelRecords = new List<Shipping_Manifest__c>();
        List<Shipping_Manifest__c> rejectRecords = new List<Shipping_Manifest__c>();
        List<Shipping_Manifest__c> acceptRecords = new List<Shipping_Manifest__c>();
        List<Shipping_Manifest__c> partialRecords = new List<Shipping_Manifest__c>();
        
        List<Shipping_Manifest__c> updateEmailRecords = new List<Shipping_Manifest__c>();
        
        Set<Id> shipIds = (new Map<Id,Shipping_Manifest__c>(smList)).keySet();
        Set<Id> smTransIds = new Set<Id>();
        Set<Id> shippingManifestID = new Set<Id>();
        Set<String> smRecordTypeID = new Set<String>();
        Boolean smRecordtye;
        Set<Id> smID = new Set<Id>();
        Set<Id> internSMID = new Set<Id>();
        String smStatus;
        String smOldStatus;
        Set<String> soIds = new Set<String>();
        for(Shipping_Manifest__c sm : smList){
            
            Shipping_Manifest__c oldSM = oldMap.get(sm.Id);
            
            internSMID.add(sm.Id);  
            smStatus=sm.Status__c;
            smOldStatus =  oldSM.Status__c;
            
            if(sm.RecordTypeId != oldSM.RecordTypeId){smRecordtye = True;  shippingManifestID.add(sm.Id);    smRecordTypeID.add(sm.RecordTypeId);
            } 
            
            if(sm.Status__c == oldSM.Status__c && sm.Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE){
                
                internNewOldShipmentStatus = True;
            }
            
            if(sm.Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE && oldSM.Status__c == SHIPPING_MANIFEST_LINE_STATUS_CANCELLED){  internsmStatusCancelledToComplete = true;
            }
            
            if(sm.Status__c == SHIPPING_MANIFEST_STATUS_REJECTED && oldSM.Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE){  internsmStatusCompleteToReject = True;
            }
              if(sm.Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE && oldSM.Status__c ==SHIPPING_MANIFEST_STATUS_REJECTED){ internsmStatusRejectedToComplete = True;
            }
            
            
            if(sm.Status__c == SHIPPING_MANIFEST_STATUS_INTRANSIT && sm.Status__c != oldSM.Status__c){smIds.add(sm.Id);    
            } 
            if(sm.Payment_Terms__c != oldSM.Payment_Terms__c){  smID.add(sm.Id);    
            }
            Id devRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER).getRecordTypeId();
            Id labRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_LAB).getRecordTypeId();
            if(sm.recordTypeId != null){
            	
                if(sm.recordTypeId == devRecordTypeId && sm.Shipping_Method__c == SHIPPING_MANIFEST_SITETOSITE_SHIPMETHOD && sm.Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE && (sm.Shipping_Method__c != oldSM.Shipping_Method__c || sm.Status__c != oldSM.Status__c)){smTransIds.add(sm.Id);	   
                }
            }
			if(sm.Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE && sm.recordTypeId != devRecordTypeId && sm.recordTypeId != labRecordTypeId && oldMap.get(sm.Id).Status__c != sm.Status__c && sm.Sales_Order__c != null){
                soIds.add(sm.Sales_Order__c);
            }
        }
        if(soIds.size() > 0){
            system.debug('###soIds :'+soIds);
            ShippingManifestHandler.createCTInvoice(soIds);
        }
        if(smTransIds.size() > 0) ShippingManifestHandler.updateIpsForTransferOrder(smTransIds);
        Map<String,Order__c> updateDeliveredDateOnOrder = new Map<String,Order__c>();
        for(Shipping_Manifest__c sm : [SELECT Id,Name,Status__c,Is_Sent_Email__c,Order_Number__c,RecordType.Name,Supplier_Name__c,Receiver_Name__c,Ship_Confirmation_Date__c,(SELECT Id,Name,SMLine_Status__c,Shipment_Qty__c,Qty_Received__c,Ownership_Code__c,Actual_Shipment_Qty__c from Shipping_Manifest_Lines__r)	
                                       FROM Shipping_Manifest__c WHERE Id In : shipIds]){
                                           Shipping_Manifest__c oldSM = oldMap.get(sm.Id);
         if(sm.Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE && sm.Ship_Confirmation_Date__c != null && sm.Order_Number__c != null){
             Order__c o = new Order__c();
             o.id = sm.Order_Number__c;
             o.Delivered_Date__c = sm.Ship_Confirmation_Date__c;
            updateDeliveredDateOnOrder.put(sm.Order_Number__c,o);                                   
         }
        	if(sm.Status__c == SHIPPING_MANIFEST_STATUS_CANCELLED && sm.Status__c != oldSM.Status__c){
                List<Shipping_Manifest_Line__c> lstLineItems = sm.Shipping_Manifest_Lines__r;
                if(lstLineItems.size() > 0){
                	Boolean isSend = true;
                    for(Shipping_Manifest_Line__c item : lstLineItems){
                        if(item.SMLine_Status__c != SHIPPING_MANIFEST_LINE_STATUS_CANCELLED) {
                            isSend = false;
                            break;
                        }   
                    }
                    if(isSend){
                        if(sm.Is_Sent_Email__c == false){ cancelRecords.add(sm); sm.Is_Sent_Email__c = true;
                            updateEmailRecords.add(sm);
                        }                            
                    }
                } 
            } else if((sm.Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE || sm.Status__c == SHIPPING_MANIFEST_STATUS_REJECTED || oldSM.Status__c ==  SHIPPING_MANIFEST_STATUS_CANCELLED) && sm.Status__c != oldSM.Status__c){
             
                List<Shipping_Manifest_Line__c> shippingMLineList = new List<Shipping_Manifest_Line__c>();
                 //  internal sm status change from Full Rejected to Shipment Complete
        if(sm.Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE &&   (oldSM.Status__c == SHIPPING_MANIFEST_STATUS_REJECTED || oldSM.Status__c ==  SHIPPING_MANIFEST_STATUS_CANCELLED)){  internShipmentComplete = true;
                    
                    for(Shipping_Manifest_Line__c item : sm.Shipping_Manifest_Lines__r){
                        
                            item.Qty_Received__c = item.Shipment_Qty__c;  item.SMLine_Status__c = SHIPPING_MANIFEST_STATUS_COMPLETE;
                            shippingMLineList.add(item);
                      
                    }
           
                   update shippingMLineList;
                    updateInvoiceStatus(internSMID);
                   
                } else if(sm.Status__c == SHIPPING_MANIFEST_STATUS_REJECTED &&  oldSM.Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE ){ internShipmentComplete = true;
                    
                    for(Shipping_Manifest_Line__c item : sm.Shipping_Manifest_Lines__r){
                     
                           item.SMLine_Status__c=SHIPPING_MANIFEST_STATUS_REJECTED;  item.Qty_Received__c = 0;  shippingMLineList.add(item);
                     
                    }
         
                    updateInvoiceStatus(internSMID);
                   
                }
                
               
                if(ShippingManifestLineTriggerHandler.isSmlinePartialFromSmComple==true || ShippingManifestLineTriggerHandler.isSmlineRejectFromSmComple==True)
                {
                    updateInvoiceStatus(internSMID);
                }
                
                completedRecords.add(sm);
                Integer rejectCount = 0;
                Integer fullCount = 0;
                Integer partialCount = 0;
                Decimal rejQty = 0;
                for(Shipping_Manifest_Line__c item : sm.Shipping_Manifest_Lines__r){
                    if(item.SMLine_Status__c == SHIPPING_MANIFEST_LINE_STATUS_REJECTED ) {
                        rejectCount += 1; 
                        //partialCount +=1;
                    } else if(item.SMLine_Status__c == SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE) {
                        fullCount += 1; 
                        //partialCount +=1;
                        
                    }
                    if(item.Actual_Shipment_Qty__c != null && item.Qty_Received__c != null)
                     rejQty += (item.Actual_Shipment_Qty__c - item.Qty_Received__c);
                }
                system.debug('##rejQty : '+rejQty);
                system.debug('##rejectCount : '+rejectCount);
                system.debug('##fullCount : '+fullCount);
                system.debug('##partialCount : '+partialCount);
                if(sm.Is_Sent_Email__c == false){
                    if(rejectCount == sm.Shipping_Manifest_Lines__r.size() || rejQty > 0){
                        rejectRecords.add(sm);    
                    } else if(fullCount == sm.Shipping_Manifest_Lines__r.size() && rejQty == 0){
                        acceptRecords.add(sm); 
                    } else if(partialCount == sm.Shipping_Manifest_Lines__r.size()){ 
                        partialRecords.add(sm);
                    } 
                    sm.Is_Sent_Email__c = true;
                    updateEmailRecords.add(sm);
                }
                
            }	    
        }
		
        if(!updateDeliveredDateOnOrder.isEmpty()){
            update updateDeliveredDateOnOrder.values();
        }
       // Internal ShipConfirm Condition 
      if(ShippingManifestLineTriggerHandler.isSmlineRejectFromSmComple == false  && smOldStatus!= SHIPPING_MANIFEST_STATUS_COMPLETE  )
           {
       if((RSMTSMShipConfirmCotroller.IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED && ShipConfirmController.IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED && CancelRSMController.IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED ) && (smStatus == SHIPPING_MANIFEST_STATUS_COMPLETE || smStatus == SHIPPING_MANIFEST_STATUS_CANCELLED || smStatus == SHIPPING_MANIFEST_STATUS_REJECTED  )) updateShipConfirmInternal(internSMID, smStatus);
    }
        if(internsmStatusCompleteToReject==true && internShipmentComplete==true ){updateShipConfirmInternal(internSMID, smStatus);
        }
         // Internal Sm full cancel to Draft
       if((RSMTSMShipConfirmCotroller.IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED && ShipConfirmController.IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED && CancelRSMController.IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED ) && (smStatus == SHIPPING_MANIFEST_STATUS_DRAFT && smOldStatus == SHIPPING_MANIFEST_STATUS_CANCELLED  && QAConfirmController.smReverse ==false)) 	updateSmInternalCancelToDraft(internSMID, smStatus);

        
        if(shippingManifestID.size() > 0) ShippingManifestHandler.updateSMLinesRecordTypes(shippingManifestID,smRecordTypeID);
        if(smIds.size() > 0) ShippingManifestHandler.updateSMLines(smIds);
        system.debug('##acceptRecords : '+acceptRecords.size());
        if(cancelRecords.size() > 0) sendEmailOnCancel(cancelRecords);
        else if(rejectRecords.size() > 0) sendEmailOnReject(rejectRecords);
        else if(acceptRecords.size() > 0) sendEmailOnAccept(acceptRecords);
        else if(partialRecords.size() > 0) sendEmailOnPartial(partialRecords);
        
        if(completedRecords.size() > 0){ 
            updateLastSoldDateONLineCards(completedRecords);
        }
        /*payments terms sync*/
        if(smID.size() > 0){ updatePaymentTerms(smID);
        }
        
        if(updateEmailRecords.size() > 0){
            update updateEmailRecords;
        }
        
    }
    //@future
    public static void createCTInvoice(Set<String> soIds){
        Map<String,List<Map<String,List<Sales_Order_Line__c>>>> ownerShipCodeSOLIMap = new Map<String,List<Map<String,List<Sales_Order_Line__c>>>>();
        Set<String> OwnerShipIds = new Set<String>();
        Set<String> oppIds = new Set<String>();
        system.debug('###createCTInvoice >> soIds :'+soIds.size());
        List<Sales_Order__c> SOList= [select id ,name,Sample_Order__c,Ownership__c,Opportunity_Name__c,Distributor_Name__c,
                               Sales_Order_Instructions__c,Receiver_Name__r.Payment_Terms__c,
				Distributor_License__c,Distributor_Contact__c,Receiver_Name__c,Receiver_License__c,Receiver_Contact__c,
				Supplier_Name__c,Supplier_License__c,Supplier_Contact__c,Brand_Quote__c,Payment_Terms__c,Site__c,
				Shipping_Method__c,Shipping_Terms__c,Ship_Confirmation_Date__c from Sales_Order__c where id IN : soIds ];
        Map<String,List<Sales_Order_Line__c>> SOLIMap = new Map<String,List<Sales_Order_Line__c>>();
       for(Sales_Order_Line__c soli :[select id,name,Sales_Order__c,Product_Name__c,Sales_Order__r.Ownership__c,Sales_Order__r.Opportunity_Name__c,
				Product_Title__c,Qty_Ordered__c,Promised_Date__c,Ownership_Code__c, (Select Id, Unit_Cultivation_Tax_1__c,Unit_Cultivation_Tax__c,Unit_Cannabis_Weight__c,
				Unit_Cannabis_Weight_1__c,Receiving_Line__r.Purchase_Order_Line__c,Harvest_Batch_Code__c,Inventory_Qty__c,Product_Name__c
				From Inventory_Positions__r where Billable_Cultivation_Tax__c = 'Yes') from Sales_Order_Line__c where Sales_Order__c IN :soIds AND Status__c !=: Sales_Order_Line_Status_Cancelled AND  
				(Product_Name__r.Auto_Allocation__c = FALSE OR (Product_Name__r.Auto_Allocation__c = TRUE AND 
                                                                Product_Name__r.Apply_Cultivation_Tax__c = 'Yes' ))] )
       {
           
           /*if(SOLIMap.containsKey(soli.Sales_Order__c)) {
               SOLIMap.get(soli.Sales_Order__c).add(soli);
           }else{
               SOLIMap.put(soli.Sales_Order__c,new List<Sales_Order_Line__c>{soli});
           }  */
           List<Map<String,List<Sales_Order_Line__c>>> SOMapList = new List<Map<String,List<Sales_Order_Line__c>>>();
           if(ownerShipCodeSOLIMap.containsKey(soli.Sales_Order__c)){
               for(Map<String,List<Sales_Order_Line__c>> SOLIOwnerMap : ownerShipCodeSOLIMap.get(soli.Sales_Order__c)){
                   
                   if(SOLIOwnerMap.containsKey(soli.Ownership_Code__c)){
                            SOLIOwnerMap.get(soli.Ownership_Code__c).add(soli);
                        }else{
                            SOLIOwnerMap.put(soli.Ownership_Code__c, new List<Sales_Order_Line__c>{soli});
                        }
                   SOMapList.add(SOLIOwnerMap);
               }
               ownerShipCodeSOLIMap.put(soli.Sales_Order__c,SOMapList);
           }else{
               Map<String,List<Sales_Order_Line__c>> SOLIOwnerMap = new Map<String,List<Sales_Order_Line__c>>();
               SOLIOwnerMap.put(soli.Ownership_Code__c, new List<Sales_Order_Line__c>{soli});
               ownerShipCodeSOLIMap.put(soli.Sales_Order__c,new List<Map<String,List<Sales_Order_Line__c>>>{SOLIOwnerMap});
           }
           OwnerShipIds.add(soli.Ownership_Code__c);
           oppIds.add(soli.Sales_Order__r.Opportunity_Name__c);
       }
        if(!ownerShipCodeSOLIMap.values().isEmpty()){
            /*default reciever Name to iRR for CTI--reciver, contact & license*/
            Company_Custom_Settings__c cs = [select Default_Distributor__c, Default_License__c,Default_Contact__c from Company_Custom_Settings__c];
            /*Map<String,Service_Ticket__c> serviceTicketMap =new Map<String,Service_Ticket__c>();
            for(Service_Ticket__c ST : [SELECT Opportunity__c,Id,Licensed_Premise__c,Brand_Contact__c,Brand_Name__c,
                                                                         Brand_Contact__r.AccountId,Licensed_Premise__r.License_Name__c from Service_Ticket__c where Opportunity__c IN : 
                                                                         oppIds ])
            {
                if(!serviceTicketMap.containsKey(ST.Opportunity__c)){
                    serviceTicketMap.put(ST.Opportunity__c, ST);
                }
            }
            Map<Id,Account> ownerShipMap = new Map<Id,Account>([SELECT Id, Name, Type,Service_Type__c,(SELECT License_Name__c,id,RecordType.Name FROM State_Licenses__r WHERE RecordType.Name IN (:STATE_LICENSE_NONCANNABIS_RECORDTYPE,:STATE_LICENSE_LICENSE_HOLDER_RECORDTYPE) AND License_Status__c = : STATE_LICENSE_ACTIVE ORDER BY CreatedDate ASC),(SELECT AccountId,Id FROM Contacts WHERE Active__c = true ORDER BY CreatedDate ASC) FROM Account WHERE Id IN:OwnerShipIds]);
            */
            system.debug('###SOList :'+SOList.size());
            Map<String,List<Map<String,Invoice__c>>> newINVMap = new  Map<String,List<Map<String,Invoice__c>>>(); 
            Map<String,List<Map<String,List<Invoice_Line__c>>>> newILIMap = new Map<String,List<Map<String,List<Invoice_Line__c>>>>();
            for(Sales_Order__c objSO : SOList){
                for(Map<String,List<Sales_Order_Line__c>> ownerShipCode : ownerShipCodeSOLIMap.get(objSO.Id)){
                    for(String ownershipId : ownerShipCode.keySet()){
                        List<Sales_Order_Line__c> SOLIs = ownerShipCode.get(ownershipId);
                        if(SOLIs != NULL && SOLIs.size() > 0){
                            Invoice__c newInvoice = new Invoice__c();
                            newInvoice.Sales_Order__c= objSO.id;
                            newInvoice.AR_Status__c = Invoice_Ar_Status_Approved;
                            newInvoice.Site__c = objSO.Site__c;
                            newInvoice.Shipping_Method__c = objSO.Shipping_Method__c;
                            newInvoice.Shipping_Terms__c = objSO.Shipping_Terms__c;
                            
                            newInvoice.Invoice_Memo__c = objSO.Sales_Order_Instructions__c;
                            newInvoice.Sample_Order__c = objSO.Sample_Order__c;
                            newInvoice.Brand_Quote__c = objSO.Brand_Quote__c;
                            newInvoice.Opportunity_Name__c = objSO.Opportunity_Name__c;
                            
                            newInvoice.Distributor_Name__c = objSO.Distributor_Name__c;
                            newInvoice.Distributor_License__c = objSO.Distributor_License__c;
                            newInvoice.Distributor_Contact__c = objSO.Distributor_Contact__c;
                            newInvoice.Supplier_Name__c = objSO.Supplier_Name__c;
                            newInvoice.Supplier_License__c = objSO.Supplier_License__c;
                            newInvoice.Supplier_Contact__c = objSO.Supplier_Contact__c;
                            newInvoice.Receiver_Name__c = cs.Default_Distributor__c;
                            newInvoice.Receiver_License__c = cs.Default_License__c;
                            newInvoice.Receiver_Contact__c = cs.Default_Contact__c;
                            
                            newInvoice.Ownership__c = ownershipId;
                            newInvoice.Ship_Confirmation_Date__c = objSO.Ship_Confirmation_Date__c;
                            newInvoice.RecordTypeId = Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get(Invoice_Record_Type_Tax).getRecordTypeId();
                            newInvoice.Invoice_Due_Date__c = date.valueof(system.now());
                            newInvoice.Payment_Terms__c = objSO.Receiver_Name__r.Payment_Terms__c;
                            
                            List<Invoice_Line__c> invLineItems = new List<Invoice_Line__c>();
                            for(Sales_Order_Line__c objSOlines : SOLIs){
                                Map<String,Invoice_Line__c>batchInvoiceLineMap = new Map<String,Invoice_Line__c>();
                                for(Inventory_Position__c IP : objSOlines.Inventory_Positions__r){
                                    if(batchInvoiceLineMap.containsKey(IP.Product_Name__c)){//Ip.Product_Name__c
                                        Invoice_Line__c invLineItem =  batchInvoiceLineMap.get(IP.Product_Name__c);
                                        invLineItem.Invoice_Qty__c = invLineItem.Invoice_Qty__c + IP.Inventory_Qty__c;
                                        batchInvoiceLineMap.put(IP.Product_Name__c,invLineItem);
                                        system.debug('batchInvoiceLineMap>>'+batchInvoiceLineMap);
                                    }else{
                                        Invoice_Line__c invLineItem = new Invoice_Line__c();
                                        //invLineItem.Invoice__c = newInvoice.Id;
                                        invLineItem.Sales_Order_Line__c = objSOlines.Id;
                                        invLineItem.Product_Name__c = objSOlines.Product_Name__c;
                                        invLineItem.Product_Title__c = objSOlines.Product_Title__c;
                                        invLineItem.Purchased_Date__c = objSOlines.Promised_Date__c;
                                        invLineItem.Unit_Cultivation_Tax__c = IP.Unit_Cultivation_Tax__c;
                                        invLineItem.Unit_Cannabis_Weight__c = IP.Unit_Cannabis_Weight__c;
                                        invLineItem.PO_Line__c = IP.Receiving_Line__r.Purchase_Order_Line__c;
                                        invLineItem.Invoice_Qty__c = IP.Inventory_Qty__c; //objSOlines.Qty_Ordered__c;
                                        invLineItem.OwnershipCode__c = ownershipId;
                                        invLineItem.RecordTypeId = Schema.SObjectType.Invoice_Line__c.getRecordTypeInfosByName().get(Invoice_Record_Type_Tax).getRecordTypeId(); 
                                        batchInvoiceLineMap.put(IP.Product_Name__c,invLineItem);
                                        system.debug('batchInvoiceLineMap>>'+batchInvoiceLineMap);
                                    }    
                                }
                                invLineItems.addAll(batchInvoiceLineMap.values());
                            }
                            if(invLineItems.size() > 0){
                                Map<String,List<Invoice_Line__c>> ILIOwnerMap = new Map<String,List<Invoice_Line__c>>();
                                ILIOwnerMap.put(ownershipId, invLineItems);
                                if(newILIMap.containsKey(objSO.id)){
                                    newILIMap.get(objSO.id).add(ILIOwnerMap);
                                }else{
                                    newILIMap.put(objSO.id,new List<Map<String,List<Invoice_Line__c>>>{ILIOwnerMap});
                                }
                                Map<String,Invoice__c> INVOwnerMap = new Map<String,Invoice__c>();
                                INVOwnerMap.put(ownershipId,newInvoice);
                                if(newINVMap.containsKey(objSO.id)){
                                    newINVMap.get(objSO.id).add(INVOwnerMap);
                                }else{
                                    newINVMap.put(objSO.id,new List<Map<String,Invoice__c>>{INVOwnerMap});
                                }
                            }
                            
                        }
                    }
                }
                
                
                
               // newINVMap.put(objSO.id,newInvoice);
               // newILIMap.put(objSO.id,invLineItems);   
            }
            system.debug('###newILIMap :'+newILIMap.size());
            if(!newILIMap.values().isEmpty()){
                List<Invoice__c> updateINVList = new List<Invoice__c>();
                for(String  soId :newINVMap.keySet()){
                    for(Map<String,Invoice__c> invMap : newINVMap.get(soId)){
                        updateINVList.add(invMap.values());
                    }
                }
                system.debug('###updateINVList :'+updateINVList.size());
                insert updateINVList;
                List<Invoice_Line__c> newInvoiceLines = new List<Invoice_Line__c>();
                for(String  soId :newINVMap.keySet()){
                    for(Map<String,Invoice__c> invMap : newINVMap.get(soId)){
                        for(String  onrId :invMap.keySet()){
                            system.debug('###onrId 1 :'+onrId);
                            Invoice__c inv = invMap.get(onrId);
                            system.debug('###inv :'+inv);
                            for(Map<String,List<Invoice_Line__c>> onrLineMap: newILIMap.get(soId)){
                                system.debug('###onrLineMap keySet :'+onrLineMap.keySet());
                                
                                List<Invoice_Line__c> lines = onrLineMap.get(onrId);
                                
                                if(lines != null && lines.size() > 0){
                                    system.debug('###onrLineMap :'+lines.size());
                                    for(Invoice_Line__c line : lines){
                                        system.debug('line :'+inv.Id);
                                        system.debug('line.Invoice__c :'+line.Invoice__c);
                                        line.Invoice__c = inv.Id;
                                        newInvoiceLines.add(line);
                                    }
                                }
                                
                            }
                        }
                    }
                }
                insert newInvoiceLines;
            }
        }
	} 
    public static void updateLastSoldDateONLineCards(List<Shipping_Manifest__c> completedRecords){
        Set<Id> supplierIds = new Set<Id>();
        Set<Id> receiverIds = new Set<Id>();
        Map<String,Shipping_Manifest__c> SMMap = new Map<String,Shipping_Manifest__c>();
        for(Shipping_Manifest__c SM : completedRecords){
            receiverIds.add(SM.Receiver_Name__c);
            for(Shipping_Manifest_Line__c item : SM.Shipping_Manifest_Lines__r){
                if(item.SMLine_Status__c == SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE ) {
                    if(item.Ownership_Code__c != NULL){supplierIds.add(item.Ownership_Code__c);String key = item.Ownership_Code__c+'-'+SM.Receiver_Name__c;
                        if(SMMap.containsKey(key) == false || (SMMap.containsKey(key) && SMMap.get(key).Ship_Confirmation_Date__c < SM.Ship_Confirmation_Date__c)){
                            SMMap.put(key,SM);
                        }
                    }
                }
            }
        }
      
        if(supplierIds.size() > 0 && receiverIds.size() > 0){
            List<Line_Card__c> lineCards = [SELECT Id,Last_Sold_Date__c ,Retailer_Name__c ,Brand_Name__c FROM Line_Card__c WHERE Retailer_Name__c IN :receiverIds AND Brand_Name__c IN :supplierIds];
            List<Line_Card__c> updateLineCards  = new List<Line_Card__c>();
            for(Line_Card__c LC: lineCards){ String key = LC.Brand_Name__c+'-'+LC.Retailer_Name__c;
                if((SMMap.containsKey(key) && LC.Last_Sold_Date__c == NULL) || (SMMap.containsKey(key) && LC.Last_Sold_Date__c != NULL && SMMap.get(key).Ship_Confirmation_Date__c > LC.Last_Sold_Date__c)){
                    LC.Last_Sold_Date__c = SMMap.get(key).Ship_Confirmation_Date__c;
                    updateLineCards.add(LC);
                }
            }
         
            if(updateLineCards.size() > 0){ update updateLineCards;
            }       
        }
    }
    public static void sendEmailOnPartial(Shipping_Manifest__c[] newList){
        
    	Set<Id> brandIds = new Set<Id>();
        Map<Id,List<Shipping_Manifest_Line__c>> mapBrands = new Map<Id,List<Shipping_Manifest_Line__c>>();
        Set<Id> shipIds = (new Map<Id,Shipping_Manifest__c>(newList)).keySet();
        Set<Id> odrIds = new Set<Id>();
        for(Shipping_Manifest_Line__c ship : [SELECT Id,Name,Harvest_Batch_Code__c,Actual_Shipment_Qty__c,
                                              Shipping_Manifest__r.Metrc_Manifest__c,Product_Name__r.Licensee_Name__c,
                                              Shipping_Manifest__r.Payment_Terms__c,Shipping_Manifest__r.Receiver_Contact__r.Name,
                                              Shipping_Manifest__r.Receiver_Contact__c,Shipment_Qty__c,Batch_ID__c,UID_1__c,
                                              Shipping_Manifest__r.Receiver_Name__r.ShippingAddress,Shipping_Manifest__r.Total_Price__c,
                                              Shipping_Manifest__r.Receiver_Name__r.DBA__c,Shipping_Manifest__r.Receiver_Name__r.Name,Shipping_Manifest__r.Receiver_Name__c,Product_Name__c,
                                              Shipping_Manifest__c,Shipping_Manifest__r.Name,Shipping_Manifest__r.Order_Number__r.Name,
                                              Product_Name__r.Total_Order_Qty__c,Qty_Received__c,SMLine_Status__c,Shipping_Manifest__r.Opportunity_Name__r.Order__c,
                                              Product_Name__r.Producer_Name__c,Product_Name__r.White_Labelled__c,Ownership_Code__c,Product_Name__r.Name,
                                              Rejection_Reason__c,Product_Description__c FROM Shipping_Manifest_Line__c WHERE Shipping_Manifest__c In : shipIds]){
            if(ship.Product_Name__r.White_Labelled__c){
            	if(ship.Product_Name__r.Licensee_Name__c != null){
	            	brandIds.add(ship.Product_Name__r.Licensee_Name__c);   if(mapBrands.containsKey(ship.Product_Name__r.Licensee_Name__c)){
                        mapBrands.get(ship.Product_Name__r.Licensee_Name__c).add(ship);    
                    } else{
                        mapBrands.put(ship.Product_Name__r.Licensee_Name__c, new List<Shipping_Manifest_Line__c>{ship});
                    } 
                }  
            } else {
            	if(ship.Product_Name__r.Producer_Name__c != null){	brandIds.add(ship.Product_Name__r.Producer_Name__c); 
                    if(mapBrands.containsKey(ship.Product_Name__r.Producer_Name__c)){
                        mapBrands.get(ship.Product_Name__r.Producer_Name__c).add(ship);    
                    } else{
                        mapBrands.put(ship.Product_Name__r.Producer_Name__c, new List<Shipping_Manifest_Line__c>{ship});
                    } 
                }     
            }
             if(ship.Shipping_Manifest__r.Opportunity_Name__r.Order__c != null ){
                 
             	odrIds.add(ship.Shipping_Manifest__r.Opportunity_Name__r.Order__c);
                 
             }
        } 
        
        if(brandIds.size() > 0){
            List<Account> lstAcc = new List<Account>([SELECT Id,Name,shippingaddress,DBA__c,
                                                      (SELECT Id,Name,Email,FirstName,Shipment_Delivery_Alert__c from Contacts WHERE Email != null AND Active__c =: true )
                                                      FROM Account WHERE Id In : brandIds]); 
            
            orgwideemailaddress orgWide = [select Id,Address, displayName from orgwideemailaddress where displayName =: 'DL-Orders' limit 1];
            Set<Id> sendEmailToConIds  = new Set<Id>();
            if(odrIds.size() > 0){
                For(Order__c odr : [SELECT id,Customer__c,Customer__r.ContactId,Customer__r.Email,Sales_Person__c,Sales_Person__r.Email,Sales_Person__r.Active__c,
                                    Additional_Brand_Contact__c,Additional_Brand_Contact__r.Email,Retailer_Contact__c,Retailer_Contact__r.email,
                                    (SELECT id,Contact__c,Contact__r.Email FROM Retailer_Related_Contacts__r WHERE Contact__r.Active__c = true AND Type__c IN (:TYPE_ADD_BRAND_CONTACT,:TYPE_ADD_RETAIL_CONTACT) AND Contact__r.Email != null) FROM Order__c WHERE Id IN : odrIds]){
                                        if(odr.Sales_Person__c != null && odr.Sales_Person__r.Email != null && odr.Sales_Person__r.Active__c == true){
                                            sendEmailToConIds.add(odr.Sales_Person__c);
                                        }
                                        if(odr.Customer__r.ContactId != null ){
                                            sendEmailToConIds.add(odr.Customer__r.ContactId);
                                        }
                                        if(odr.Additional_Brand_Contact__c != null && odr.Additional_Brand_Contact__r.Email != null){
                                            sendEmailToConIds.add(odr.Additional_Brand_Contact__c);
                                        }
                                        if(odr.Retailer_Contact__c != null && odr.Retailer_Contact__r.Email != null){
                                            sendEmailToConIds.add(odr.Retailer_Contact__c);
                                        }
                                        for(Retailer_Related_Contact__c rrc : odr.Retailer_Related_Contacts__r){
                                            if(rrc.Contact__c != null && rrc.Contact__r.Email != null){
                                                sendEmailToConIds.add(rrc.Contact__c);
                                            }
                                        }
                                    }
            }
            if(lstAcc.size() > 0){
                 
                Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{};
                    for(Account acc : lstAcc){
                        List<Contact> lstCon = acc.Contacts;
                        List<Shipping_Manifest_Line__c> lstShip = mapBrands.get(acc.Id);
                        if(lstCon.size() > 0){
                            for(Contact con: lstCon){
                                
                                Boolean isSendEmail = true;
                                if(con.Shipment_Delivery_Alert__c == false && sendEmailToConIds.size() > 0 && sendEmailToConIds.contains(con.Id) == false){
                                    isSendEmail = false;
                                }
                                if(isSendEmail){
                                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                    mail.setSubject(lstShip[0].Shipping_Manifest__r.Order_Number__r.Name +' was partially rejected by ' + lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c);
                                    
                                    String htmlBody = 'Hello '+con.FirstName;
                                    htmlBody += ',<br/><br/>'+lstShip[0].Shipping_Manifest__r.Order_Number__r.Name+' was partially rejected by '+lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c;
                                    htmlBody += '. A summary of the order is listed below. Please contact your ASR if you have any questions.';
                                    
                                    htmlBody += '<br/><br/>Business:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Name__r.Name+ ' (' +lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c + ')';
                                    if(lstShip[0].Shipping_Manifest__r.Receiver_Contact__c != null){
                                        htmlBody += '<br/>Contact:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Contact__r.Name;    
                                    } else {
                                        htmlBody += '<br/>Contact:&nbsp;';
                                    }
                                    if(lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress != null){
                                        Address shAddress = lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress;
                                        String add = '';
                                        if(shAddress.getStreet() != null) add += shAddress.getStreet() + ' ';
                                        if(shAddress.getCity() != null) add += shAddress.getCity()+ ', ';
                                        if(shAddress.getState() != null) add += shAddress.getState()+ ' ';
                                        if(shAddress.getPostalCode() != null) add += shAddress.getPostalCode()+ ' ';
                                        if(shAddress.getCountry() != null) add += shAddress.getCountry();
                                        
                                        htmlBody += '<br/>Address:&nbsp;'+add;     
                                    } else htmlBody += '<br/>Address:';
                                    
                                    htmlBody += '<br/>Total Order Price:&nbsp;$'+lstShip[0].Shipping_Manifest__r.Total_Price__c.setScale(2);
                                    htmlBody += '<br/>Payment Terms:&nbsp;'+lstShip[0].Shipping_Manifest__r.Payment_Terms__c;
                                    if(lstShip[0].Shipping_Manifest__r.Metrc_Manifest__c != null){
                                        htmlBody += '<br/>METRC Manifest:&nbsp;'+lstShip[0].Shipping_Manifest__r.Metrc_Manifest__c;    
                                    } else {
                                        htmlBody += '<br/>METRC Manifest: '; 
                                    }
                                    
                                    htmlBody += '<br/><br/>Accepted Products:';
                                    
                                    htmlBody += '<br/><table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Product Name</th><th style="border:1px solid #000">Product Description</th>';
                                    htmlBody += '<th style="border:1px solid #000">Shipment Qty</th><th style="border:1px solid #000">Accepted Qty</th><th style="border:1px solid #000">Batch ID</th></tr>';
                                    
                                    for(Shipping_Manifest_Line__c comp : lstShip){
                                        if(comp.Product_Name__c != null && comp.SMLine_Status__c == 'Shipment Complete'){
                                            htmlBody += '<tr style="border:1px solid #000"><td style="border:1px solid #000">'+comp.Product_Name__r.Name+'</td>';
                                            htmlBody += '<td style="border:1px solid #000">'+comp.Product_Description__c+'</td>';
                                            
                                            if(comp.Actual_Shipment_Qty__c != null){
                                                Decimal actRec = comp.Actual_Shipment_Qty__c;  String strQty = actRec + '';
                                                String[] getDecimal = strQty.split('\\.');
                                                if(getDecimal[1] == '00'){actRec = actRec.setScale(0);
                                                                         }
                                                htmlBody += '<td style="border:1px solid #000">'+actRec+'</td>';    
                                            } else htmlBody += '<td style="border:1px solid #000"></td>';
                                            
                                            if(comp.Qty_Received__c != null){
                                                Decimal qtyRec = comp.Qty_Received__c;
                                                String strQty = qtyRec + ''; String[] getDecimal = strQty.split('\\.');
                                                if(getDecimal[1] == '00'){qtyRec = qtyRec.setScale(0);
                                                                         }
                                                htmlBody += '<td style="border:1px solid #000">'+qtyRec+'</td>';     
                                            } else htmlBody += '<td style="border:1px solid #000"></td>';
                                            
                                            if(comp.Harvest_Batch_Code__c != null){htmlBody += '<td style="border:1px solid #000">'+comp.Harvest_Batch_Code__c+'</td></tr>';    
                                                                                  } else htmlBody += '<td style="border:1px solid #000"></td></tr>';
                                        }        
                                    }
                                    htmlBody +='</table>';
                                    
                                    htmlBody += '<br/><br/>Rejected Products:';
                                    
                                    htmlBody += '<br/><table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Product Name</th><th style="border:1px solid #000">Product Description</th>';
                                    htmlBody += '<th style="border:1px solid #000">Batch ID</th><th style="border:1px solid #000">Shipment Qty</th><th style="border:1px solid #000">Accepted Qty</th>';
                                    htmlBody += '<th style="border:1px solid #000">Rejected Qty</th><th style="border:1px solid #000">Rejection Reason</th></tr>';
                                    
                                    for(Shipping_Manifest_Line__c comp : lstShip){
                                        if(comp.Product_Name__c != null && comp.SMLine_Status__c == 'Rejected'){
                                            htmlBody += '<tr style="border:1px solid #000"><td style="border:1px solid #000">'+comp.Product_Name__r.Name+'</td>';
                                            htmlBody += '<td style="border:1px solid #000">'+comp.Product_Description__c+'</td>';
                                            if(comp.Harvest_Batch_Code__c != null){                                        	htmlBody += '<td style="border:1px solid #000">'+comp.Harvest_Batch_Code__c+'</td>';    
                                                                                  } else htmlBody += '<td style="border:1px solid #000"></td>';
                                            
                                            if(comp.Actual_Shipment_Qty__c != null){
                                                Decimal actRec = comp.Actual_Shipment_Qty__c;
                                                String strQty = actRec + '';
                                                String[] getDecimal = strQty.split('\\.');
                                                if(getDecimal[1] == '00'){
                                                    actRec = actRec.setScale(0);
                                                }
                                                htmlBody += '<td style="border:1px solid #000">'+actRec+'</td>';    
                                            } else htmlBody += '<td style="border:1px solid #000"></td>';
                                            
                                            if(comp.Qty_Received__c != null){
                                                Decimal qtyRec = comp.Qty_Received__c; String strQty = qtyRec + '';
                                                String[] getDecimal = strQty.split('\\.');
                                                if(getDecimal[1] == '00'){	qtyRec = qtyRec.setScale(0);
                                                                         }
                                                htmlBody += '<td style="border:1px solid #000">'+qtyRec+'</td>';    
                                            } else htmlBody += '<td style="border:1px solid #000"></td>';
                                            
                                            if(comp.Qty_Received__c != null && comp.Shipment_Qty__c != null){
                                                Decimal rejQty = (comp.Actual_Shipment_Qty__c - comp.Qty_Received__c);
                                                String strQty = rejQty + '';String[] getDecimal = strQty.split('\\.');
                                                if(getDecimal[1] == '00'){
                                                    rejQty = rejQty.setScale(0);
                                                }
                                                htmlBody += '<td style="border:1px solid #000">'+ rejQty +'</td>';    
                                            } else htmlBody += '<td style="border:1px solid #000"></td>';
                                            
                                            if(comp.Rejection_Reason__c != null){htmlBody += '<td style="border:1px solid #000">'+comp.Rejection_Reason__c+'</td></tr>';    
                                                                                } else htmlBody += '<td style="border:1px solid #000"></td></tr>';
                                            
                                        }        
                                    }
                                    htmlBody +='</table>';
                                    
                                    List<String> listOfToAddresses = new List<String>();
                                    listOfToAddresses.add(con.Email);
                                    //mail.setBccAddresses(new List<String>{label.Brand_BCC_Addresses});
                                    if(orgWide != null) mail.setOrgWideEmailAddressId(orgWide.Id);
                                    mail.setHtmlBody(htmlBody);
                                    List<String> ccEmails = label.DL_ASR.split(',');
                                    //List<String> ccEmails = new List<String>{label.DL_ASR};
                                    mail.setCcAddresses(ccEmails); 
                                    mail.setToAddresses(listOfToAddresses); 
                                    emails.add(mail);
                                }
                            }
                        } else {
                            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                            mail.setSubject(lstShip[0].Shipping_Manifest__r.Order_Number__r.Name +' was partially rejected by ' + lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c);
                            
                            String htmlBody = 'Hello ';
                            htmlBody += ',<br/><br/>'+lstShip[0].Shipping_Manifest__r.Order_Number__r.Name+' was partially rejected by '+lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c;
                            htmlBody += '. A summary of the order is listed below. Please contact your ASR if you have any questions.';
                            
                            htmlBody += '<br/><br/>Business:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Name__r.Name+ ' (' +lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c + ')';
                            if(lstShip[0].Shipping_Manifest__r.Receiver_Contact__c != null){
                                htmlBody += '<br/>Contact:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Contact__r.Name;    
                            } else {
                                htmlBody += '<br/>Contact:&nbsp;';
                            }
                            if(lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress != null){
                                    Address shAddress = lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress;
                                String add = '';
                                if(shAddress.getStreet() != null) add += shAddress.getStreet() + ' ';
                                if(shAddress.getCity() != null) add += shAddress.getCity()+ ', ';
                                if(shAddress.getState() != null) add += shAddress.getState()+ ' ';
                                if(shAddress.getPostalCode() != null) add += shAddress.getPostalCode()+ ' ';
                                if(shAddress.getCountry() != null) add += shAddress.getCountry();
                                
                                htmlBody += '<br/>Address:&nbsp;'+add;    } else htmlBody += '<br/>Address:';
                            
                            htmlBody += '<br/>Total Order Price:&nbsp;$'+lstShip[0].Shipping_Manifest__r.Total_Price__c.setScale(2);
                            htmlBody += '<br/>Payment Terms:&nbsp;'+lstShip[0].Shipping_Manifest__r.Payment_Terms__c;  if(lstShip[0].Shipping_Manifest__r.Metrc_Manifest__c != null){
                                htmlBody += '<br/>METRC Manifest:&nbsp;'+lstShip[0].Shipping_Manifest__r.Metrc_Manifest__c;    
                            } else {
                                htmlBody += '<br/>METRC Manifest: '; 
                            }
                            
                            htmlBody += '<br/><br/>Accepted Products:';
                            
                            htmlBody += '<br/><table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Product Name</th><th style="border:1px solid #000">Product Description</th>';
                            htmlBody += '<th style="border:1px solid #000">Shipment Qty</th><th style="border:1px solid #000">Accepted Qty</th><th style="border:1px solid #000">Batch ID</th></tr>';
                            
                            for(Shipping_Manifest_Line__c comp : lstShip){
                                if(comp.Product_Name__c != null && comp.SMLine_Status__c == 'Shipment Complete'){
                                    htmlBody += '<tr style="border:1px solid #000"><td style="border:1px solid #000">'+comp.Product_Name__r.Name+'</td>';
                                    htmlBody += '<td style="border:1px solid #000">'+comp.Product_Description__c+'</td>';
                                    
                                    if(comp.Actual_Shipment_Qty__c != null){
                                        Decimal actRec = comp.Actual_Shipment_Qty__c;
                                        String strQty = actRec + ''; String[] getDecimal = strQty.split('\\.');
                                        if(getDecimal[1] == '00'){actRec = actRec.setScale(0);
                                        }
                                        htmlBody += '<td style="border:1px solid #000">'+actRec+'</td>';    
                                    } else htmlBody += '<td style="border:1px solid #000"></td>';
                                    
                                    if(comp.Qty_Received__c != null){ Decimal qtyRec = comp.Qty_Received__c;
                                        String strQty = qtyRec + '';   String[] getDecimal = strQty.split('\\.');
                                        if(getDecimal[1] == '00'){
                                            qtyRec = qtyRec.setScale(0);
                                        }
                                        htmlBody += '<td style="border:1px solid #000">'+qtyRec+'</td>';     
                                    } else htmlBody += '<td style="border:1px solid #000"></td>';
                                    
                                    if(comp.Harvest_Batch_Code__c != null){  htmlBody += '<td style="border:1px solid #000">'+comp.Harvest_Batch_Code__c+'</td></tr>';    
                                    } else htmlBody += '<td style="border:1px solid #000"></td></tr>';
                                }        
                            }
                            htmlBody +='</table>';
                            
                            htmlBody += '<br/><br/>Rejected Products:';
                            
                            htmlBody += '<br/><table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Product Name</th><th style="border:1px solid #000">Product Description</th>';
                            htmlBody += '<th style="border:1px solid #000">Batch ID</th><th style="border:1px solid #000">Shipment Qty</th><th style="border:1px solid #000">Accepted Qty</th>';
                            htmlBody += '<th style="border:1px solid #000">Rejected Qty</th><th style="border:1px solid #000">Rejection Reason</th></tr>';
                            
                            for(Shipping_Manifest_Line__c comp : lstShip){
                                if(comp.Product_Name__c != null && comp.SMLine_Status__c == 'Rejected'){
                                    htmlBody += '<tr style="border:1px solid #000"><td style="border:1px solid #000">'+comp.Product_Name__r.Name+'</td>';
                                    htmlBody += '<td style="border:1px solid #000">'+comp.Product_Description__c+'</td>';
                                    if(comp.Harvest_Batch_Code__c != null){ htmlBody += '<td style="border:1px solid #000">'+comp.Harvest_Batch_Code__c+'</td>';    
                                    } else htmlBody += '<td style="border:1px solid #000"></td>';
                                    
                                    if(comp.Actual_Shipment_Qty__c != null){ Decimal actRec = comp.Actual_Shipment_Qty__c; String strQty = actRec + '';
                                        String[] getDecimal = strQty.split('\\.');
                                        if(getDecimal[1] == '00'){  actRec = actRec.setScale(0);
                                        }
                                        htmlBody += '<td style="border:1px solid #000">'+actRec+'</td>';    
                                    } else htmlBody += '<td style="border:1px solid #000"></td>';
                                    
                                    if(comp.Qty_Received__c != null){
                                        Decimal qtyRec = comp.Qty_Received__c;  String strQty = qtyRec + '';
                                        String[] getDecimal = strQty.split('\\.');
                                        if(getDecimal[1] == '00'){ qtyRec = qtyRec.setScale(0);
                                        }
                                        htmlBody += '<td style="border:1px solid #000">'+qtyRec+'</td>';    
                                    } else htmlBody += '<td style="border:1px solid #000"></td>';
                                    
                                    if(comp.Qty_Received__c != null && comp.Shipment_Qty__c != null){
                                        Decimal rejQty = (comp.Actual_Shipment_Qty__c - comp.Qty_Received__c);
                                        String strQty = rejQty + '';   String[] getDecimal = strQty.split('\\.');
                                        if(getDecimal[1] == '00'){  rejQty = rejQty.setScale(0);
                                        }
                                        htmlBody += '<td style="border:1px solid #000">'+ rejQty +'</td>';    
                                    } else htmlBody += '<td style="border:1px solid #000"></td>';
                                    
                                    if(comp.Rejection_Reason__c != null){  htmlBody += '<td style="border:1px solid #000">'+comp.Rejection_Reason__c+'</td></tr>';    
                                    } else htmlBody += '<td style="border:1px solid #000"></td></tr>';
                                    
                                }        
                            }
                            htmlBody +='</table>';
                            List<String> listOfToAddresses = new List<String>();
                            //mail.setBccAddresses(new List<String>{label.Brand_BCC_Addresses});
                            if(orgWide != null) mail.setOrgWideEmailAddressId(orgWide.Id);
                            mail.setHtmlBody(htmlBody);
                            List<String> ccEmails = label.DL_ASR.split(',');
                            for(Integer i=0; i < ccEmails.size(); i++){
                                listOfToAddresses.add(ccEmails[i]);    
                            }
                            mail.setToAddresses(listOfToAddresses); 
                            emails.add(mail);
                        }
                    }
                if(emails.size() > 0){
                    Messaging.sendEmail(emails);
                }
            }
        }
    }
    
    public static void sendEmailOnAccept(Shipping_Manifest__c[] newList){
        
    	Set<Id> brandIds = new Set<Id>();
        Map<Id,List<Shipping_Manifest_Line__c>> mapBrands = new Map<Id,List<Shipping_Manifest_Line__c>>();
        Set<Id> shipIds = (new Map<Id,Shipping_Manifest__c>(newList)).keySet();
      
        Set<Id> odrIds = new Set<Id>();
       
        for(Shipping_Manifest_Line__c ship : [SELECT Id,Name,Harvest_Batch_Code__c,Actual_Shipment_Qty__c,Qty_Received__c,
                                              Shipping_Manifest__r.Metrc_Manifest__c,Product_Name__r.Licensee_Name__c,
                                              Shipping_Manifest__r.Payment_Terms__c,Shipping_Manifest__r.Receiver_Name__r.DBA__c,Shipping_Manifest__r.Receiver_Contact__r.Name,
                                              Shipping_Manifest__r.Receiver_Contact__c,Shipment_Qty__c,Batch_ID__c,UID_1__c,Shipping_Manifest__r.Order_Number__r.Retailer_PO__c,
                                              Shipping_Manifest__r.Receiver_Name__r.ShippingAddress,Shipping_Manifest__r.Total_Price__c,Product_Name__r.Family,Line_Total_Price__c,
                                              Shipping_Manifest__r.Receiver_Name__r.Name,Shipping_Manifest__r.Receiver_Name__c,Product_Name__c,
                                              Shipping_Manifest__c,Shipping_Manifest__r.Name,Shipping_Manifest__r.Order_Number__r.Name,SMLine_Status__c,
                                              Product_Name__r.Total_Order_Qty__c,Product_Name__r.RecordType.Name,Product_Name__r.Is_Sample__c,
                                              Product_Name__r.Producer_Name__c,Product_Name__r.White_Labelled__c,Ownership_Code__c,Product_Name__r.Name,
                                              Shipping_Manifest__r.Opportunity_Name__r.Order__c,
                                              Rejection_Reason__c,Product_Description__c FROM Shipping_Manifest_Line__c WHERE Shipping_Manifest__c In : shipIds]){
            if(ship.Product_Name__r.White_Labelled__c){
            	if(ship.Product_Name__r.Licensee_Name__c != null){
	            	brandIds.add(ship.Product_Name__r.Licensee_Name__c); 
                    if(mapBrands.containsKey(ship.Product_Name__r.Licensee_Name__c)){  mapBrands.get(ship.Product_Name__r.Licensee_Name__c).add(ship);    
                    } else{
                        mapBrands.put(ship.Product_Name__r.Licensee_Name__c, new List<Shipping_Manifest_Line__c>{ship});
                    } 
                }  
            } else {
            	if(ship.Product_Name__r.Producer_Name__c != null){brandIds.add(ship.Product_Name__r.Producer_Name__c); 
                    if(mapBrands.containsKey(ship.Product_Name__r.Producer_Name__c)){  mapBrands.get(ship.Product_Name__r.Producer_Name__c).add(ship);    
                    } else{
                        mapBrands.put(ship.Product_Name__r.Producer_Name__c, new List<Shipping_Manifest_Line__c>{ship});
                    } 
                }     
            }
             if(ship.Shipping_Manifest__r.Opportunity_Name__r.Order__c != null ){
                 
             	odrIds.add(ship.Shipping_Manifest__r.Opportunity_Name__r.Order__c);
                 
             }                                      
        } 
        
        if(brandIds.size() > 0){
            
            List<Account> lstAcc = new List<Account>([SELECT Id,Name,shippingaddress,DBA__c,
                                                      (SELECT Id,Name,Email,FirstName,Shipment_Delivery_Alert__c,Orders_Email_Opt_In__c from Contacts WHERE Email != null AND Active__c =: true )
                                                      FROM Account WHERE Id In : brandIds]); 
            
            orgwideemailaddress orgWide = [select Id,Address, displayName from orgwideemailaddress where displayName =: 'DL-Orders' limit 1];
            Set<Id> sendEmailToConIds  = new Set<Id>();
            if(odrIds.size() > 0){
                For(Order__c odr : [SELECT id,Customer__c,Customer__r.ContactId,Customer__r.Email,Sales_Person__c,Sales_Person__r.Email,Sales_Person__r.Active__c,
                                    Additional_Brand_Contact__c,Additional_Brand_Contact__r.Email,Retailer_Contact__c,Retailer_Contact__r.email,
                                    (SELECT id,Contact__c,Contact__r.Email FROM Retailer_Related_Contacts__r WHERE Contact__r.Active__c = true AND Type__c IN (:TYPE_ADD_BRAND_CONTACT,:TYPE_ADD_RETAIL_CONTACT) AND Contact__r.Email != null) FROM Order__c WHERE Id IN : odrIds]){
                                        if(odr.Sales_Person__c != null && odr.Sales_Person__r.Email != null && odr.Sales_Person__r.Active__c == true){
                                            sendEmailToConIds.add(odr.Sales_Person__c);
                                        }
                                        if(odr.Customer__r.ContactId != null ){
                                            sendEmailToConIds.add(odr.Customer__r.ContactId);
                                        }
                                        if(odr.Additional_Brand_Contact__c != null && odr.Additional_Brand_Contact__r.Email != null){
                                            sendEmailToConIds.add(odr.Additional_Brand_Contact__c);
                                        }
                                        if(odr.Retailer_Contact__c != null && odr.Retailer_Contact__r.Email != null){
                                            sendEmailToConIds.add(odr.Retailer_Contact__c);
                                        }
                                        for(Retailer_Related_Contact__c rrc : odr.Retailer_Related_Contacts__r){
                                            if(rrc.Contact__c != null && rrc.Contact__r.Email != null){
                                                sendEmailToConIds.add(rrc.Contact__c);
                                            }
                                        }
                                    }
            }
            if(lstAcc.size() > 0){
                system.debug('##lstAcc :'+lstAcc);
                Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{};
                    for(Account acc : lstAcc){
                        List<Contact> lstCon = acc.Contacts;
                        List<Shipping_Manifest_Line__c> lstShip = mapBrands.get(acc.Id);
                        system.debug('##lstCon :'+lstCon.size());
                        if(lstCon.size() > 0){
                            system.debug('##lstCon :'+lstCon);
                            for(Contact con: lstCon){
                               Boolean isSendEmail = true;
                                if(con.Shipment_Delivery_Alert__c == false && sendEmailToConIds.size() > 0 && sendEmailToConIds.contains(con.Id) == false){
                                    isSendEmail = false;
                                }
                                if(isSendEmail){
                                    
                                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                    mail.setSubject(lstShip[0].Shipping_Manifest__r.Order_Number__r.Name +' was accepted by ' + lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c);
                                    
                                    String htmlBody = 'Hello '+con.FirstName;
                                    htmlBody += ',<br/><br/>'+lstShip[0].Shipping_Manifest__r.Order_Number__r.Name+' has been accepted by '+ lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c +'. A summary of the order is listed ';
                                    htmlBody += 'below. Please contact your ASR if you have any questions.';
                                    
                                    htmlBody += '<br/><br/>Business:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Name__r.Name;//+ ' (' +lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c + ')';
                                    String Retailer_PO =lstShip[0].Shipping_Manifest__r.Order_Number__r.Retailer_PO__c==null?'':lstShip[0].Shipping_Manifest__r.Order_Number__r.Retailer_PO__c;
                                    htmlBody +='<br/>Retailer PO:&nbsp;'+Retailer_PO;
                                    
                                    if(lstShip[0].Shipping_Manifest__r.Receiver_Contact__c != null){
                                        htmlBody += '<br/>Contact:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Contact__r.Name;    
                                    } else {
                                        htmlBody += '<br/>Contact:  ';
                                    }
                                    
                                    if(lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress != null){
                                        Address shAddress = lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress;
                                        
                                        String add = '';
                                        if(shAddress.getStreet() != null) add += shAddress.getStreet() + ' ';
                                        if(shAddress.getCity() != null) add += shAddress.getCity()+ ', ';
                                        if(shAddress.getState() != null) add += shAddress.getState()+ ' ';
                                        if(shAddress.getPostalCode() != null) add += shAddress.getPostalCode()+ ' ';
                                        if(shAddress.getCountry() != null) add += shAddress.getCountry();
                                        
                                        htmlBody += '<br/>Address:&nbsp;'+add;     
                                    } else htmlBody += '<br/>Address: ';
                                    
                                    htmlBody += '<br/>Total Order Price:&nbsp;$'+lstShip[0].Shipping_Manifest__r.Total_Price__c.setScale(2);
                                    htmlBody += '<br/>Payment Terms:&nbsp;'+lstShip[0].Shipping_Manifest__r.Payment_Terms__c;
                                    
                                    htmlBody += '<br/><br/><table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Product Name</th><th style="border:1px solid #000">Product Description</th><th style="border:1px solid #000">Type</th><th style="border:1px solid #000">Shipment Qty</th><th style="border:1px solid #000">Accepted Qty</th><th style="border:1px solid #000">Batch ID</th><th style="border:1px solid #000">Product Price</th></tr>';
                                    
                                    for(Shipping_Manifest_Line__c comp : lstShip){
                                        if(comp.Product_Name__c != null && comp.SMLine_Status__c == SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE){
                                            htmlBody += '<tr style="border:1px solid #000"><td style="border:1px solid #000">'+comp.Product_Name__r.Name+'</td>';
                                            htmlBody += '<td style="border:1px solid #000">'+comp.Product_Description__c+'</td>';
                                            
                                            htmlBody += '<td style="border:1px solid #000">';
                                            if(comp.Product_Name__r.Is_Sample__c)
                                                htmlBody += 'Sample';
                                            if(comp.Product_Name__r.RecordType.Name == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                                                htmlBody += 'Discount';
                                            htmlBody +='</td>';
                                            
                                            if(comp.Shipment_Qty__c != null){	htmlBody += '<td style="border:1px solid #000">'+comp.Shipment_Qty__c.setScale(0)+'</td>';    
                                                                            }else htmlBody += '<td></td>';
                                            
                                            if(comp.Qty_Received__c != null){htmlBody += '<td style="border:1px solid #000">'+comp.Qty_Received__c.setScale(0)+'</td>';    
                                                                            } else htmlBody += '<td></td>';
                                            
                                            if(comp.Harvest_Batch_Code__c != null){htmlBody += '<td style="border:1px solid #000">'+comp.Harvest_Batch_Code__c+'</td>';    
                                                                                  } else htmlBody += '<td style="border:1px solid #000"></td>';
                                            
                                            htmlBody += '<td style="border:1px solid #000">';
                                            if(comp.Product_Name__r.Family == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                                                htmlBody += '($'+comp.Line_Total_Price__c+')';
                                            else
                                                htmlBody += '$'+comp.Line_Total_Price__c;
                                            htmlBody +='</td></tr>';
                                        }        
                                    }
                                    htmlBody +='</table>';
                                    List<String> listOfToAddresses = new List<String>();
                                    listOfToAddresses.add(con.Email);
                                    //mail.setBccAddresses(new List<String>{label.Brand_BCC_Addresses});
                                    if(orgWide != null) mail.setOrgWideEmailAddressId(orgWide.Id);
                                    mail.setHtmlBody(htmlBody);
                                    List<String> ccEmails = label.DL_ASR.split(',');
                                    //List<String> ccEmails = new List<String>{label.DL_ASR};
                                    mail.setCcAddresses(ccEmails); 
                                    mail.setToAddresses(listOfToAddresses); 
                                    emails.add(mail);
                                }
                            }
                        } else {
                            
                            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                            mail.setSubject(lstShip[0].Shipping_Manifest__r.Order_Number__r.Name +' was accepted by ' + lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c);
                            	
                                String htmlBody = 'Hello ';
                                htmlBody += ',<br/><br/>'+lstShip[0].Shipping_Manifest__r.Order_Number__r.Name+' has been accepted by '+ lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c +'. A summary of the order is listed ';
                            	htmlBody += 'below. Please contact your ASR if you have any questions.';
                                
                                htmlBody += '<br/><br/>Business:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Name__r.Name;//+ ' (' +lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c + ')';
                                String Retailer_PO =lstShip[0].Shipping_Manifest__r.Order_Number__r.Retailer_PO__c==null?'':lstShip[0].Shipping_Manifest__r.Order_Number__r.Retailer_PO__c;
                                htmlBody +='<br/>Retailer PO:&nbsp;'+Retailer_PO;
                                
                                if(lstShip[0].Shipping_Manifest__r.Receiver_Contact__c != null){
                                	htmlBody += '<br/>Contact:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Contact__r.Name;    
                                } else {
                                    htmlBody += '<br/>Contact:  ';
                                }
                                
                                if(lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress != null){
                                    Address shAddress = lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress;
                                    
                                    String add = '';
                                    if(shAddress.getStreet() != null) add += shAddress.getStreet() + ' ';
                                    if(shAddress.getCity() != null) add += shAddress.getCity()+ ', ';
                                    if(shAddress.getState() != null) add += shAddress.getState()+ ' ';
                                    if(shAddress.getPostalCode() != null) add += shAddress.getPostalCode()+ ' ';
                                    if(shAddress.getCountry() != null) add += shAddress.getCountry();
                                    
                                    htmlBody += '<br/>Address:&nbsp;'+add;     
                                } else htmlBody += '<br/>Address: ';
                                
                                htmlBody += '<br/>Total Order Price:&nbsp;$'+lstShip[0].Shipping_Manifest__r.Total_Price__c.setScale(2);
                                htmlBody += '<br/>Payment Terms:&nbsp;'+lstShip[0].Shipping_Manifest__r.Payment_Terms__c;
                                
                                htmlBody += '<br/><br/><table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Product Name</th><th style="border:1px solid #000">Product Description</th><th style="border:1px solid #000">Type</th><th style="border:1px solid #000">Shipment Qty</th><th style="border:1px solid #000">Accepted Qty</th><th style="border:1px solid #000">Batch ID</th><th style="border:1px solid #000">Product Price</th></tr>';
                                
                                for(Shipping_Manifest_Line__c comp : lstShip){
                                    if(comp.Product_Name__c != null && comp.SMLine_Status__c == SHIPPING_MANIFEST_LINE_STATUS_SHIPMENT_COMPLETE){
                                    	htmlBody += '<tr style="border:1px solid #000"><td style="border:1px solid #000">'+comp.Product_Name__r.Name+'</td>';
                                        htmlBody += '<td style="border:1px solid #000">'+comp.Product_Description__c+'</td>';
                                        
                                        htmlBody += '<td style="border:1px solid #000">';
                                            if(comp.Product_Name__r.Is_Sample__c)
                                                htmlBody += 'Sample';
                                            if(comp.Product_Name__r.RecordType.Name == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                                                htmlBody += 'Discount';
                                        htmlBody +='</td>';
                                        
                                        if(comp.Shipment_Qty__c != null){	htmlBody += '<td style="border:1px solid #000">'+comp.Shipment_Qty__c.setScale(0)+'</td>';    
                                        }else htmlBody += '<td></td>';
                                        
                                        if(comp.Qty_Received__c != null){htmlBody += '<td style="border:1px solid #000">'+comp.Qty_Received__c.setScale(0)+'</td>';    
                                        } else htmlBody += '<td></td>';

                                        if(comp.Harvest_Batch_Code__c != null){htmlBody += '<td style="border:1px solid #000">'+comp.Harvest_Batch_Code__c+'</td>';    
                                        } else htmlBody += '<td style="border:1px solid #000"></td>';
                                        
                                        htmlBody += '<td style="border:1px solid #000">';
                                        if(comp.Product_Name__r.Family == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                                            htmlBody += '($'+comp.Line_Total_Price__c+')';
                                        else
                                            htmlBody += '$'+comp.Line_Total_Price__c;
                                        htmlBody +='</td></tr>';
                                    }        
                                }
                                htmlBody +='</table>';
                            List<String> listOfToAddresses = new List<String>();
                            //mail.setBccAddresses(new List<String>{label.Brand_BCC_Addresses});
                            if(orgWide != null) mail.setOrgWideEmailAddressId(orgWide.Id);
                            mail.setHtmlBody(htmlBody);
                            List<String> ccEmails = label.DL_ASR.split(',');
                            for(Integer i=0; i < ccEmails.size(); i++){
                                listOfToAddresses.add(ccEmails[i]);    
                            }
                            mail.setToAddresses(listOfToAddresses);  
                            emails.add(mail);
                        }
                    }
                if(emails.size() > 0){
                    Messaging.sendEmail(emails);
                }
            }
        }
    }
    
    public static void sendEmailOnReject(Shipping_Manifest__c[] newList){
    	Set<Id> brandIds = new Set<Id>();
        Map<Id,List<Shipping_Manifest_Line__c>> mapBrands = new Map<Id,List<Shipping_Manifest_Line__c>>();
        Set<Id> shipIds = (new Map<Id,Shipping_Manifest__c>(newList)).keySet();
    	Set<Id> odrIds = new Set<Id>();

        for(Shipping_Manifest_Line__c ship : [SELECT Id,Name,Harvest_Batch_Code__c,Actual_Shipment_Qty__c,Qty_Received__c,
                                              Shipping_Manifest__r.Metrc_Manifest__c,Product_Name__r.Licensee_Name__c,
                                              Shipping_Manifest__r.Payment_Terms__c,Shipping_Manifest__r.Receiver_Name__r.DBA__c,Shipping_Manifest__r.Receiver_Contact__r.Name,
                                              Shipping_Manifest__r.Receiver_Contact__c,Shipment_Qty__c,Batch_ID__c,UID_1__c,Shipping_Manifest__r.Order_Number__r.Retailer_PO__c,
                                              Shipping_Manifest__r.Receiver_Name__r.ShippingAddress,Shipping_Manifest__r.Total_Price__c,Product_Name__r.Family,Line_Total_Price__c,
                                              Shipping_Manifest__r.Receiver_Name__r.Name,Shipping_Manifest__r.Receiver_Name__c,Product_Name__c,SMLine_Status__c,
                                              Shipping_Manifest__c,Shipping_Manifest__r.Name,Shipping_Manifest__r.Order_Number__r.Name,
                                              Product_Name__r.Total_Order_Qty__c,Product_Name__r.RecordType.Name,Product_Name__r.Is_Sample__c,
                                              Product_Name__r.Producer_Name__c,Product_Name__r.White_Labelled__c,Ownership_Code__c,Product_Name__r.Name,Shipping_Manifest__r.Opportunity_Name__r.Order__c,
                                              Rejection_Reason__c,Product_Description__c FROM Shipping_Manifest_Line__c WHERE Shipping_Manifest__c In : shipIds]){
            if(ship.Product_Name__r.White_Labelled__c){
            	if(ship.Product_Name__r.Licensee_Name__c != null){
	            	brandIds.add(ship.Product_Name__r.Licensee_Name__c);    if(mapBrands.containsKey(ship.Product_Name__r.Licensee_Name__c)){
                        mapBrands.get(ship.Product_Name__r.Licensee_Name__c).add(ship);    
                    } else{
                        mapBrands.put(ship.Product_Name__r.Licensee_Name__c, new List<Shipping_Manifest_Line__c>{ship});
                    } 
                }  
            } else {
            	if(ship.Product_Name__r.Producer_Name__c != null){
	            	brandIds.add(ship.Product_Name__r.Producer_Name__c); if(mapBrands.containsKey(ship.Product_Name__r.Producer_Name__c)){
                        mapBrands.get(ship.Product_Name__r.Producer_Name__c).add(ship);    
                    } else{
                        mapBrands.put(ship.Product_Name__r.Producer_Name__c, new List<Shipping_Manifest_Line__c>{ship});
                    } 
                }     
            }
             if(ship.Shipping_Manifest__r.Opportunity_Name__r.Order__c != null ){
                 
             	odrIds.add(ship.Shipping_Manifest__r.Opportunity_Name__r.Order__c);
                 
             }  
        } 
        
        if(brandIds.size() > 0){
            List<Account> lstAcc = new List<Account>([SELECT Id,Name,shippingaddress,DBA__c,
                                                      (SELECT Id,Name,Email,FirstName,Shipment_Delivery_Alert__c from Contacts WHERE Email != null AND Active__c =: true )
                                                      FROM Account WHERE Id In : brandIds]); 
            
            orgwideemailaddress orgWide = [select Id,Address, displayName from orgwideemailaddress where displayName =: 'DL-Orders' limit 1];
            Set<Id> sendEmailToConIds  = new Set<Id>();
            if(odrIds.size() > 0){
                For(Order__c odr : [SELECT id,Customer__c,Customer__r.ContactId,Customer__r.Email,Sales_Person__c,Sales_Person__r.Email,Sales_Person__r.Active__c,
                                    Additional_Brand_Contact__c,Additional_Brand_Contact__r.Email,Retailer_Contact__c,Retailer_Contact__r.email,
                                    (SELECT id,Contact__c,Contact__r.Email FROM Retailer_Related_Contacts__r WHERE Contact__r.Active__c = true AND Type__c IN (:TYPE_ADD_BRAND_CONTACT,:TYPE_ADD_RETAIL_CONTACT) AND Contact__r.Email != null) FROM Order__c WHERE Id IN : odrIds]){
                                        if(odr.Sales_Person__c != null && odr.Sales_Person__r.Email != null && odr.Sales_Person__r.Active__c == true){
                                            sendEmailToConIds.add(odr.Sales_Person__c);
                                        }
                                        if(odr.Customer__r.ContactId != null ){
                                            sendEmailToConIds.add(odr.Customer__r.ContactId);
                                        }
                                        if(odr.Additional_Brand_Contact__c != null && odr.Additional_Brand_Contact__r.Email != null){
                                            sendEmailToConIds.add(odr.Additional_Brand_Contact__c);
                                        }
                                        if(odr.Retailer_Contact__c != null && odr.Retailer_Contact__r.Email != null){
                                            sendEmailToConIds.add(odr.Retailer_Contact__c);
                                        }
                                        for(Retailer_Related_Contact__c rrc : odr.Retailer_Related_Contacts__r){
                                            if(rrc.Contact__c != null && rrc.Contact__r.Email != null){
                                                sendEmailToConIds.add(rrc.Contact__c);
                                            }
                                        }
                                    }
            }
            if(lstAcc.size() > 0){
                Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{};
                    for(Account acc : lstAcc){
                        List<Contact> lstCon = acc.Contacts;
                        List<Shipping_Manifest_Line__c> lstShip = mapBrands.get(acc.Id);
                        if(lstCon.size() > 0){
                            for(Contact con: lstCon){
                                Boolean isSendEmail = true;
                                if(con.Shipment_Delivery_Alert__c == false && sendEmailToConIds.size() > 0 && sendEmailToConIds.contains(con.Id) == false){
                                    isSendEmail = false;
                                }
                               
                                if(isSendEmail){
                                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                    mail.setSubject('Rejection on '+lstShip[0].Shipping_Manifest__r.Order_Number__r.Name +' by ' + lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c);
                                    
                                    String htmlBody = 'Hello '+con.FirstName;
                                    htmlBody += ',<br/><br/>There has been a rejection associated with '+lstShip[0].Shipping_Manifest__r.Order_Number__r.Name+' by '+lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c;
                                    htmlBody += '. A summary of the revised order quantities is listed below. Please contact your ASR if you have any questions.';
                                    
                                    htmlBody += '<br/><br/>Business:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Name__r.Name;//+ ' (' +lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c + ')';
                                    String Retailer_PO =lstShip[0].Shipping_Manifest__r.Order_Number__r.Retailer_PO__c==null?'':lstShip[0].Shipping_Manifest__r.Order_Number__r.Retailer_PO__c;
                                    htmlBody +='<br/>Retailer PO:&nbsp;'+Retailer_PO;
                                    if(lstShip[0].Shipping_Manifest__r.Receiver_Contact__c != null){
                                        htmlBody += '<br/>Contact:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Contact__r.Name;    
                                    } else {
                                        htmlBody += '<br/>Contact:&nbsp;';
                                    }
                                    if(lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress != null){
                                        Address shAddress = lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress;
                                        String add = '';
                                        if(shAddress.getStreet() != null) add += shAddress.getStreet() + ' ';
                                        if(shAddress.getCity() != null) add += shAddress.getCity()+ ', ';
                                        if(shAddress.getState() != null) add += shAddress.getState()+ ' ';
                                        if(shAddress.getPostalCode() != null) add += shAddress.getPostalCode()+ ' ';
                                        if(shAddress.getCountry() != null) add += shAddress.getCountry();
                                        
                                        htmlBody += '<br/>Address:&nbsp;'+add;     
                                    } else htmlBody += '<br/>Address:';
                                    
                                    htmlBody += '<br/>Revised Product Total:&nbsp;$'+lstShip[0].Shipping_Manifest__r.Total_Price__c.setScale(2);
                                    htmlBody += '<br/>Payment Terms:&nbsp;'+lstShip[0].Shipping_Manifest__r.Payment_Terms__c;
                                    
                                    htmlBody += '<br/><br/><table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Product Name</th><th style="border:1px solid #000">Product Description</th>';
                                    htmlBody += '<th style="border:1px solid #000">Type</th><th style="border:1px solid #000">Shipment Qty</th><th style="border:1px solid #000">Accepted Qty</th><th style="border:1px solid #000">Batch ID</th><th style="border:1px solid #000">Product Price</th><th style="border:1px solid #000">Line Item Rejection Reason</th></tr>';
                                    
                                    for(Shipping_Manifest_Line__c comp : lstShip){
                                        //if(comp.Product_Name__c != null && comp.SMLine_Status__c == SHIPPING_MANIFEST_LINE_STATUS_REJECTED){
                                        htmlBody += '<tr style="border:1px solid #000"><td style="border:1px solid #000">'+comp.Product_Name__r.Name+'</td>';
                                        htmlBody += '<td style="border:1px solid #000">'+comp.Product_Description__c+'</td>';
                                        htmlBody += '<td style="border:1px solid #000">';
                                        if(comp.Product_Name__r.Is_Sample__c)
                                            htmlBody += 'Sample';
                                        if(comp.Product_Name__r.RecordType.Name == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                                            htmlBody += 'Discount';
                                        htmlBody +='</td>';
                                        
                                        if(comp.Actual_Shipment_Qty__c != null){
                                            Decimal actRec = comp.Actual_Shipment_Qty__c;  String strQty = actRec + '';
                                            String[] getDecimal = strQty.split('\\.');
                                            if(getDecimal[1] == '00'){actRec = actRec.setScale(0);
                                                                     }
                                            htmlBody += '<td style="border:1px solid #000">'+actRec+'</td>';    
                                        } else htmlBody += '<td style="border:1px solid #000"></td>';
                                        
                                        if(comp.Qty_Received__c != null){
                                            Decimal qtyRec = comp.Qty_Received__c;
                                            String strQty = qtyRec + ''; String[] getDecimal = strQty.split('\\.');
                                            if(getDecimal[1] == '00'){qtyRec = qtyRec.setScale(0);
                                                                     }
                                            htmlBody += '<td style="border:1px solid #000">'+qtyRec+'</td>';     
                                        } else htmlBody += '<td style="border:1px solid #000"></td>';
                                        
                                        if(comp.Harvest_Batch_Code__c != null){htmlBody += '<td style="border:1px solid #000">'+comp.Harvest_Batch_Code__c+'</td>';    
                                                                              } else htmlBody += '<td style="border:1px solid #000"></td>';
                                        
                                        htmlBody += '<td style="border:1px solid #000">';
                                        if(comp.Product_Name__r.Family == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                                            htmlBody += '($'+comp.Line_Total_Price__c+')';
                                        else
                                            htmlBody += '$'+comp.Line_Total_Price__c;
                                        htmlBody +='</td>';
                                        
                                        if(comp.Rejection_Reason__c != null){htmlBody += '<td style="border:1px solid #000">'+comp.Rejection_Reason__c+'</td>';    
                                                                            } else htmlBody += '<td style="border:1px solid #000"></td>';
                                        htmlBody += '</tr>';
                                       // }        
                                    }
                                    htmlBody +='</table>';
                                    
                                    List<String> listOfToAddresses = new List<String>();
                                    listOfToAddresses.add(con.Email);
                                    //mail.setBccAddresses(new List<String>{label.Brand_BCC_Addresses});
                                    if(orgWide != null) mail.setOrgWideEmailAddressId(orgWide.Id);
                                    mail.setHtmlBody(htmlBody);
                                    List<String> ccEmails = label.DL_ASR.split(',');
                                    //List<String> ccEmails = new List<String>{label.DL_ASR};
                                    mail.setCcAddresses(ccEmails); 
                                    mail.setToAddresses(listOfToAddresses); 
                                    emails.add(mail);
                                }
                            }
                        } else {
                             Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                mail.setSubject('Rejection on '+lstShip[0].Shipping_Manifest__r.Order_Number__r.Name +' by ' + lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c);
                            	
                                String htmlBody = 'Hello ';
                                htmlBody += ',<br/><br/>There has been a rejection associated with '+lstShip[0].Shipping_Manifest__r.Order_Number__r.Name+' by '+lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c;
                            	htmlBody += '. A summary of the revised order quantities is listed below. Please contact your ASR if you have any questions.';
                                
                                htmlBody += '<br/><br/>Business:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Name__r.Name;//+ ' (' +lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c + ')';
                                String Retailer_PO =lstShip[0].Shipping_Manifest__r.Order_Number__r.Retailer_PO__c==null?'':lstShip[0].Shipping_Manifest__r.Order_Number__r.Retailer_PO__c;
                                htmlBody +='<br/>Retailer PO:&nbsp;'+Retailer_PO;
                                if(lstShip[0].Shipping_Manifest__r.Receiver_Contact__c != null){
                                	htmlBody += '<br/>Contact:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Contact__r.Name;    
                                } else {
                                    htmlBody += '<br/>Contact:&nbsp;';
                                }
                                if(lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress != null){
                                    Address shAddress = lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress;
                                    String add = '';
                                    if(shAddress.getStreet() != null) add += shAddress.getStreet() + ' ';
                                    if(shAddress.getCity() != null) add += shAddress.getCity()+ ', ';
                                    if(shAddress.getState() != null) add += shAddress.getState()+ ' ';
                                    if(shAddress.getPostalCode() != null) add += shAddress.getPostalCode()+ ' ';
                                    if(shAddress.getCountry() != null) add += shAddress.getCountry();
                                    
                                    htmlBody += '<br/>Address:&nbsp;'+add;     
                                } else htmlBody += '<br/>Address:';
                                
                                htmlBody += '<br/>Revised Product Total:&nbsp;$'+lstShip[0].Shipping_Manifest__r.Total_Price__c.setScale(2);
                                htmlBody += '<br/>Payment Terms:&nbsp;'+lstShip[0].Shipping_Manifest__r.Payment_Terms__c;
                                
                                htmlBody += '<br/><br/><table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Product Name</th><th style="border:1px solid #000">Product Description</th>';
                                htmlBody += '<th style="border:1px solid #000">Type</th><th style="border:1px solid #000">Shipment Qty</th><th style="border:1px solid #000">Accepted Qty</th><th style="border:1px solid #000">Batch ID</th><th style="border:1px solid #000">Product Price</th><th style="border:1px solid #000">Line Item Rejection Reason</th></tr>';
                                
                                for(Shipping_Manifest_Line__c comp : lstShip){
                                    //if(comp.Product_Name__c != null && comp.SMLine_Status__c == SHIPPING_MANIFEST_LINE_STATUS_REJECTED){
                                    	htmlBody += '<tr style="border:1px solid #000"><td style="border:1px solid #000">'+comp.Product_Name__r.Name+'</td>';
                                        htmlBody += '<td style="border:1px solid #000">'+comp.Product_Description__c+'</td>';
                                        htmlBody += '<td style="border:1px solid #000">';
                                            if(comp.Product_Name__r.Is_Sample__c)
                                                htmlBody += 'Sample';
                                            if(comp.Product_Name__r.RecordType.Name == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                                                htmlBody += 'Discount';
                                        htmlBody +='</td>';
                                        
                                        if(comp.Actual_Shipment_Qty__c != null){
                                        	Decimal actRec = comp.Actual_Shipment_Qty__c;  String strQty = actRec + '';
                                            String[] getDecimal = strQty.split('\\.');
                                            if(getDecimal[1] == '00'){actRec = actRec.setScale(0);
                                            }
                                        	htmlBody += '<td style="border:1px solid #000">'+actRec+'</td>';    
                                        } else htmlBody += '<td style="border:1px solid #000"></td>';
                                        
                                        if(comp.Qty_Received__c != null){
                                            Decimal qtyRec = comp.Qty_Received__c;
                                            String strQty = qtyRec + ''; String[] getDecimal = strQty.split('\\.');
                                            if(getDecimal[1] == '00'){qtyRec = qtyRec.setScale(0);
                                            }
                                        	htmlBody += '<td style="border:1px solid #000">'+qtyRec+'</td>';     
                                        } else htmlBody += '<td style="border:1px solid #000"></td>';

                                        if(comp.Harvest_Batch_Code__c != null){htmlBody += '<td style="border:1px solid #000">'+comp.Harvest_Batch_Code__c+'</td>';    
                                        } else htmlBody += '<td style="border:1px solid #000"></td>';
                                        
                                        htmlBody += '<td style="border:1px solid #000">';
                                        if(comp.Product_Name__r.Family == PRODUCT_RECORD_TYPE_NAME_DISCOUNT)
                                            htmlBody += '($'+comp.Line_Total_Price__c+')';
                                        else
                                            htmlBody += '$'+comp.Line_Total_Price__c;
                                        htmlBody +='</td>';
                                        
                                        if(comp.Rejection_Reason__c != null){htmlBody += '<td style="border:1px solid #000">'+comp.Rejection_Reason__c+'</td>';    
                                        } else htmlBody += '<td style="border:1px solid #000"></td>';
                                    htmlBody += '</tr>'; 
                                   // }
                                }
                                htmlBody +='</table>';
                                
                            List<String> listOfToAddresses = new List<String>();
                            //mail.setBccAddresses(new List<String>{label.Brand_BCC_Addresses});
                            if(orgWide != null) mail.setOrgWideEmailAddressId(orgWide.Id);
                            mail.setHtmlBody(htmlBody);
                            List<String> ccEmails = label.DL_ASR.split(',');
                            for(Integer i=0; i < ccEmails.size(); i++){
                                listOfToAddresses.add(ccEmails[i]);    
                            }
                            mail.setToAddresses(listOfToAddresses); 
                            emails.add(mail);
                        }
                    }
                if(emails.size() > 0){
                    Messaging.sendEmail(emails);
                }
            }
        }
    }
    
    public static void sendEmailOnCancel(Shipping_Manifest__c[] newList){
    	Set<Id> brandIds = new Set<Id>();
        Map<Id,List<Shipping_Manifest_Line__c>> mapBrands = new Map<Id,List<Shipping_Manifest_Line__c>>();
        Set<Id> shipIds = (new Map<Id,Shipping_Manifest__c>(newList)).keySet();
      
        
        for(Shipping_Manifest_Line__c ship : [SELECT Id,Name,Harvest_Batch_Code__c,Actual_Shipment_Qty__c,
                                              Shipping_Manifest__r.Metrc_Manifest__c,Product_Name__r.Licensee_Name__c,
                                              Shipping_Manifest__r.Payment_Terms__c,Shipping_Manifest__r.Receiver_Contact__r.Name,
                                              Shipping_Manifest__r.Receiver_Contact__c,Shipment_Qty__c,Batch_ID__c,UID_1__c,
                                              Shipping_Manifest__r.Receiver_Name__r.ShippingAddress,Shipping_Manifest__r.Total_Price__c,
                                              Shipping_Manifest__r.Receiver_Name__r.Name,Shipping_Manifest__r.Receiver_Name__c,Product_Name__c,
                                              Shipping_Manifest__c,Shipping_Manifest__r.Name,Shipping_Manifest__r.Order_Number__r.Name,
                                              Product_Name__r.Total_Order_Qty__c,Shipping_Manifest__r.Receiver_Name__r.DBA__c,
                                              Product_Name__r.Producer_Name__c,Product_Name__r.White_Labelled__c,Ownership_Code__c,Product_Name__r.Name,
                                              Rejection_Reason__c,Product_Description__c FROM Shipping_Manifest_Line__c WHERE Shipping_Manifest__c In : shipIds]){
            if(ship.Product_Name__r.White_Labelled__c){
            	if(ship.Product_Name__r.Licensee_Name__c != null){
	            	brandIds.add(ship.Product_Name__r.Licensee_Name__c); if(mapBrands.containsKey(ship.Product_Name__r.Licensee_Name__c)){
                        mapBrands.get(ship.Product_Name__r.Licensee_Name__c).add(ship);    
                    } else{
                        mapBrands.put(ship.Product_Name__r.Licensee_Name__c, new List<Shipping_Manifest_Line__c>{ship});
                    } 
                }  
            } else {
            	if(ship.Product_Name__r.Producer_Name__c != null){
	            	brandIds.add(ship.Product_Name__r.Producer_Name__c); 
                    if(mapBrands.containsKey(ship.Product_Name__r.Producer_Name__c)){
                        mapBrands.get(ship.Product_Name__r.Producer_Name__c).add(ship);    
                    } else{
                        mapBrands.put(ship.Product_Name__r.Producer_Name__c, new List<Shipping_Manifest_Line__c>{ship});
                    } 
                }     
            }
        } 
        
        if(brandIds.size() > 0){
            List<Account> lstAcc = new List<Account>([SELECT Id,Name,shippingaddress,
                                                      (SELECT Id,Name,Email,FirstName,Shipment_Delivery_Alert__c from Contacts WHERE Email != null AND Active__c =: true AND Shipment_Delivery_Alert__c =: true)
                                                      FROM Account WHERE Id In : brandIds]); 
            
            orgwideemailaddress orgWide = [select Id,Address, displayName from orgwideemailaddress where displayName =: 'DL-Orders' limit 1];
            
            if(lstAcc.size() > 0){
                Messaging.SingleEmailMessage[] emails = new Messaging.SingleEmailMessage[]{};
                    for(Account acc : lstAcc){
                        List<Contact> lstCon = acc.Contacts;
                        List<Shipping_Manifest_Line__c> lstShip = mapBrands.get(acc.Id);
                        if(lstCon.size() > 0){
                            for(Contact con: lstCon){
                                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                                mail.setSubject(lstShip[0].Shipping_Manifest__r.Order_Number__r.Name +' to ' + lstShip[0].Shipping_Manifest__r.Receiver_Name__r.Name + ' has been cancelled');
                            	
                                String htmlBody = 'Hello '+con.FirstName;
                                htmlBody += ',<br/><br/>Shipping manifest '+lstShip[0].Shipping_Manifest__r.Name+' for '+lstShip[0].Shipping_Manifest__r.Order_Number__r.Name;
                            	htmlBody += ' has been canceled. Please contact your ASR for further details.';
                                
                                htmlBody += '<br/><br/>Business:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Name__r.Name+ ' (' +lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c + ')';
                                //htmlBody += '<br/><br/>Retailer Name:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Name__r.Name;
                                if(lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress != null){
                                    Address shAddress = lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress;
                                    String add = '';
                                    if(shAddress.getStreet() != null) add += shAddress.getStreet() + ' ';
                                    if(shAddress.getCity() != null) add += shAddress.getCity()+ ' ';
                                    if(shAddress.getState() != null) add += shAddress.getState()+ ' ';
                                    if(shAddress.getPostalCode() != null) add += shAddress.getPostalCode()+ ' ';
                                    if(shAddress.getCountry() != null) add += shAddress.getCountry();
                                       
                                    htmlBody += '<br/>Address:&nbsp;'+ add;     
                                } else htmlBody += '<br/>Address: ';
                                
                                htmlBody += '<br/>Total Order:&nbsp;$'+lstShip[0].Shipping_Manifest__r.Total_Price__c.setScale(2);
                                
                                htmlBody += '<br/><br/><table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Product Name</th><th style="border:1px solid #000">Total Qty</th></tr>';
                                
                                for(Shipping_Manifest_Line__c sml : lstShip){
                                    if(sml.Product_Name__c != null){
                                    	htmlBody += '<tr style="border:1px solid #000"><td style="border:1px solid #000">'+sml.Product_Name__r.Name+'</td>';
                                        if(sml.Shipment_Qty__c != null){htmlBody += '<td style="border:1px solid #000">'+sml.Shipment_Qty__c.setScale(0)+'</td></tr>';    
                                        }else{
                                            htmlBody += '<td></td></tr>';
                                        }
                                    }        
                                }
                                htmlBody +='</table>';
                                List<String> listOfToAddresses = new List<String>();
                                listOfToAddresses.add(con.Email);
                                //mail.setBccAddresses(new List<String>{label.Brand_BCC_Addresses});
                                if(orgWide != null) mail.setOrgWideEmailAddressId(orgWide.Id);
                                mail.setHtmlBody(htmlBody);
                                List<String> ccEmails = label.DL_ASR.split(',');
                                //List<String> ccEmails = new List<String>{label.DL_ASR};
                                mail.setCcAddresses(ccEmails); 
                                mail.setToAddresses(listOfToAddresses); 
                                emails.add(mail);
                            }
                        } else {
                            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                            mail.setSubject(lstShip[0].Shipping_Manifest__r.Order_Number__r.Name +' to ' + lstShip[0].Shipping_Manifest__r.Receiver_Name__r.Name + ' has been cancelled');
                            
                            String htmlBody = 'Hello ';
                            htmlBody += ',<br/><br/>Shipping manifest '+lstShip[0].Shipping_Manifest__r.Name+' for '+lstShip[0].Shipping_Manifest__r.Order_Number__r.Name;
                            htmlBody += ' has been canceled. Please contact your ASR for further details.';
                            
                            htmlBody += '<br/><br/>Business:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Name__r.Name+ ' (' +lstShip[0].Shipping_Manifest__r.Receiver_Name__r.DBA__c + ')';
                            //htmlBody += '<br/><br/>Retailer Name:&nbsp;'+lstShip[0].Shipping_Manifest__r.Receiver_Name__r.Name;
                            if(lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress != null){
                                    Address shAddress = lstShip[0].Shipping_Manifest__r.Receiver_Name__r.shippingaddress;
                                String add = '';
                                if(shAddress.getStreet() != null) add += shAddress.getStreet() + ' ';
                                if(shAddress.getCity() != null) add += shAddress.getCity()+ ' ';
                                if(shAddress.getState() != null) add += shAddress.getState()+ ' ';
                                if(shAddress.getPostalCode() != null) add += shAddress.getPostalCode()+ ' ';
                                if(shAddress.getCountry() != null) add += shAddress.getCountry();
                                
                                htmlBody += '<br/>Address:&nbsp;'+ add;   } else htmlBody += '<br/>Address: ';
                            
                            htmlBody += '<br/>Total Order:&nbsp;$'+lstShip[0].Shipping_Manifest__r.Total_Price__c.setScale(2);
                            
                            htmlBody += '<br/><br/><table cellspacing="0" cellpadding="5" style="border:1px solid #000"><tr style="border:1px solid #000"><th style="border:1px solid #000">Product Name</th><th style="border:1px solid #000">Total Qty</th></tr>';
                            
                            for(Shipping_Manifest_Line__c sml : lstShip){
                                if(sml.Product_Name__c != null){
                                    htmlBody += '<tr style="border:1px solid #000"><td style="border:1px solid #000">'+sml.Product_Name__r.Name+'</td>';
                                    if(sml.Shipment_Qty__c != null){htmlBody += '<td style="border:1px solid #000">'+sml.Shipment_Qty__c.setScale(0)+'</td></tr>';    
                                    }else{
                                        htmlBody += '<td></td></tr>';
                                    }
                                }        
                            }
                            htmlBody +='</table>';
                            List<String> listOfToAddresses = new List<String>();
                            //mail.setBccAddresses(new List<String>{label.Brand_BCC_Addresses});
                            if(orgWide != null) mail.setOrgWideEmailAddressId(orgWide.Id);
                            mail.setHtmlBody(htmlBody);
                            List<String> ccEmails = label.DL_ASR.split(',');
                            for(Integer i=0; i < ccEmails.size(); i++){
                                listOfToAddresses.add(ccEmails[i]);    
                            }
                            mail.setToAddresses(listOfToAddresses); 
                            emails.add(mail);    
                        }
                    }
                if(emails.size() > 0){
                    Messaging.sendEmail(emails);
                }
            }
        }
    }
    
    public static void updateSMLines(Set<Id> smIds){
    	List<Shipping_Manifest_Line__c> lstSMLines = new List<Shipping_Manifest_Line__c>([SELECT Id,Name,Actual_Shipment_Qty__c,Shipment_Qty__c FROM Shipping_Manifest_Line__c WHERE Shipping_Manifest__c In : smIds]);
        if(lstSMLines.size() > 0){
            for(Shipping_Manifest_Line__c smLine : lstSMLines){
            	smLine.Actual_Shipment_Qty__c = smLine.Shipment_Qty__c;   
            }
            update lstSMLines;
        }
    }
    
    public static void updateSMLinesRecordTypes(Set<Id> smIds, Set<String> smRcId){
        
        
        List<Shipping_Manifest_Line__c> lstSMLines = new List<Shipping_Manifest_Line__c>([SELECT Id,Name,RecordTypeId FROM Shipping_Manifest_Line__c WHERE Shipping_Manifest__c In : smIds]);
        
        if(lstSMLines.size() > 0){
            Id transferRecordTypeID =  Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER).getRecordTypeId();
            Id transferLineRecordTypeID =  Schema.SObjectType.Shipping_Manifest_Line__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_LINE_RECORDTYPE_TRANSFERLINE).getRecordTypeId();
            Id cashRecordTypeID =  Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_CASHCOLLECTION).getRecordTypeId();
            Id cashLineRecordTypeID =  Schema.SObjectType.Shipping_Manifest_Line__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_LINE_RECORDTYPE_CASHCOLLECTION_LINE).getRecordTypeId();
            Id LabRecordTypeID =  Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_LAB).getRecordTypeId();
            Id LabLineRecordTypeID =  Schema.SObjectType.Shipping_Manifest_Line__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_LINE_RECORDTYPE_LAB_LINE).getRecordTypeId();
            Id ProductTsmRecordTypeID =  Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_PRODUCT_TSM).getRecordTypeId();
            Id ProductTsmLineRecordTypeID =  Schema.SObjectType.Shipping_Manifest_Line__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_LINE_RECORDTYPE_PRODUCT_TSM_LINE).getRecordTypeId();
            Id ServiceRecordTypeID =  Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_SERVICE).getRecordTypeId();
            Id ServiceLineRecordTypeID =  Schema.SObjectType.Shipping_Manifest_Line__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_SERVICE_LINE).getRecordTypeId();
            Id RsmRecordTypeID =  Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_RSM).getRecordTypeId();
            Id RsmLineRecordTypeID =  Schema.SObjectType.Shipping_Manifest_Line__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_RSM_LINE).getRecordTypeId();
            
           
            
            for(Shipping_Manifest_Line__c smLine : lstSMLines){
                
                // Transfer
                if(smRcId.contains(transferRecordTypeID)){ smLine.RecordTypeId = transferLineRecordTypeID;
                }
                
                //cash
                if(smRcId.contains(cashRecordTypeID)){ smLine.RecordTypeId = cashLineRecordTypeID;
                }
                
                //Lab
                if(smRcId.contains(LabRecordTypeID)){smLine.RecordTypeId = LabLineRecordTypeID;
                }    
                
                  //Product Tsm
                if(smRcId.contains(ProductTsmRecordTypeID)){smLine.RecordTypeId = ProductTsmLineRecordTypeID;
                }
                
                  //Retail
                if(smRcId.contains(RsmRecordTypeID)){smLine.RecordTypeId = RsmLineRecordTypeID;
                }
                  //Service
                if(smRcId.contains(ServiceRecordTypeID)){smLine.RecordTypeId = ServiceLineRecordTypeID;
                }
                
            }
            update lstSMLines;
        }
    }
    
     public static void updatePaymentTerms(Set<Id> smIds){
        
      Id productInvoiceRecordTypeID =  Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_PRODUCT).getRecordTypeId();  
      Shipping_Manifest__c smPaytermUpdate = [SELECT Id, Name,Payment_Terms__c, Opportunity_Name__c, Opportunity_Name__r.Payment_Terms__c, Order_Number__c,Order_Number__r.Payment_Terms__c,  Invoice__c, Invoice__r.Payment_Terms__c, 
                                                           Invoice__r.RecordType.name, Brand_Quote__c, Brand_Quote__r.Payment_Terms__c, Sales_Order__c,Sales_Order__r.Payment_Terms__c  
                                                           FROM Shipping_Manifest__c WHERE Id =: smIds];
        
        if(smPaytermUpdate.Sales_Order__c != NULL){
            Sales_Order__c soData = new Sales_Order__c();
            soData.Id = smPaytermUpdate.Sales_Order__c; 
            soData.Payment_Terms__c = smPaytermUpdate.Payment_Terms__c;
            Update soData;
        }
            
        if(smPaytermUpdate.Brand_Quote__c != NULL){
            Brand_Quote__c brandQuoteData = new Brand_Quote__c();
            brandQuoteData.Id = smPaytermUpdate.Brand_Quote__c;
            brandQuoteData.Payment_Terms__c = smPaytermUpdate.Payment_Terms__c;
            Update brandQuoteData;
        }
        
        if(smPaytermUpdate.Opportunity_Name__c != NULL){
            Opportunity oppData = new Opportunity();
            oppData.Id = smPaytermUpdate.Opportunity_Name__c;
            oppData.Payment_Terms__c = smPaytermUpdate.Payment_Terms__c;
            Update oppData;
        }
        
         if(smPaytermUpdate.Sales_Order__c != NULL){
             List<Invoice__c> invoicelst= [select Id, Name, Payment_Terms__c, RecordTypeId, RecordType.Name  from Invoice__c where Sales_Order__c =:smPaytermUpdate.Sales_Order__c AND RecordTypeId =:productInvoiceRecordTypeID];
             List<Invoice__c> inList = new List<Invoice__c>();
             if(invoicelst.size()>0 || isTestClass == true){
                for(Invoice__c inv: invoicelst){ Invoice__c invoiceData = new Invoice__c();
                 invoiceData.Id = inv.Id;
                 invoiceData.Payment_Terms__c = smPaytermUpdate.Payment_Terms__c;
                 inList.add(invoiceData);
             }
               update  inList;  
             }
             
        }
        if(smPaytermUpdate.Order_Number__c != NULL){
            Order__c orderData = new Order__c();
            orderData.Id = smPaytermUpdate.Order_Number__c;
            orderData.Payment_Terms__c = smPaytermUpdate.Payment_Terms__c;
            Update orderData;
        }
        
    }
   
    public static void updateIpsForTransferOrder(Set<Id> smIds){
        
        Set<Id> invPositionIds = new Set<Id>();
        Set<Id> siteIds = new Set<Id>();
        Map<Id,Id> mapDefaultSites = new Map<Id,Id>();
        Map<Id,Id> mapIpSiteLocation = new Map<Id,Id>();
        Map<String,String> mapUid = new Map<String,String>();
        List<Inventory_Position__c> invPositions = new List<Inventory_Position__c>();
        
        for(Shipping_Manifest_Line__c rsmLineObj : [SELECT Id,Picklist_Line__r.Inventory_Position__c,
                                                    Shipping_Manifest__r.Receiver_License__c,
                                                    Picklist_Line__r.Pack_out_UID__c,
                                                    Shipping_Manifest__r.Receiver_License__r.Default_Warehouse__c
                                                    FROM Shipping_Manifest_Line__c 
                                                    WHERE Shipping_Manifest__c IN :smIds]){
        	if(rsmLineObj.Picklist_Line__r != null && rsmLineObj.Picklist_Line__r.Inventory_Position__c != null){invPositionIds.add(rsmLineObj.Picklist_Line__r.Inventory_Position__c);
                if(rsmLineObj.Shipping_Manifest__r.Receiver_License__c != null && rsmLineObj.Shipping_Manifest__r.Receiver_License__r.Default_Warehouse__c != null){
                    mapDefaultSites.put(rsmLineObj.Picklist_Line__r.Inventory_Position__c, rsmLineObj.Shipping_Manifest__r.Receiver_License__r.Default_Warehouse__c);
                }
               
            } 
            
            if(rsmLineObj.Picklist_Line__r.Pack_out_UID__c != null && !mapUid.containsKey(rsmLineObj.Picklist_Line__r.Inventory_Position__c)){  
                mapUid.put(rsmLineObj.Picklist_Line__r.Inventory_Position__c, rsmLineObj.Picklist_Line__r.Pack_out_UID__c);
            }
        }
        
        for(Inventory_Location__c invLoc : [select Id,Name,Site_Name__c from Inventory_Location__c where Name =: Receiving_Inspection AND Site_Name__c IN :mapDefaultSites.values()]){
        	mapIpSiteLocation.put(invLoc.Site_Name__c, invLoc.Id);    
        }
        
        for(Inventory_Position__c invPosition : [SELECT Id,Site__c,Rack__c,Rack_Level__c,Bin_Location__c,UID_New__c,Inventory_Location__c FROM Inventory_Position__c Where Id IN: invPositionIds]){
            if(mapDefaultSites.containsKey(invPosition.Id)){
                invPosition.Site__c = mapDefaultSites.get(invPosition.Id);
            }
        	invPosition.Rack__c =  null;
            invPosition.Rack_Level__c =  null;invPosition.Bin_Location__c =  null;
            if(mapUid.containsKey(invPosition.Id)){ 
                invPosition.UID_New__c = mapUid.get(invPosition.Id);    
            }
            if(mapIpSiteLocation.containsKey(invPosition.Site__c)){
            	invPosition.Inventory_Location__c = mapIpSiteLocation.get(invPosition.Site__c);    
            }
            invPositions.add(invPosition);    
        } 
        if(invPositions.size() > 0){
        	update invPositions;    
        }
    }
    
      /* Method - Shipping Manifest Internal Shipment Complete, Cancelled and Rejected */
    
    public static void updateShipConfirmInternal(Set<Id> smIds, String smStatus){
   
      
        Boolean allSMLinesCancelled = true;
        String smRecordStatus;
        String smRecordOrderStatus;
        Set<Id> soId = new Set<Id>();
        List<Shipping_Manifest_Line__c> lstSMLines = new List<Shipping_Manifest_Line__c>([SELECT ID, Name, Product_Name__r.Name, Shipping_Manifest__r.Name,Purchase_Order_Line__c,
                                                                                          Product_Description__c,Producer_Name__c,Retail_Wholesale_Price__c,Actual_Shipment_Qty__c,
                                                                                          Shipment_Qty__c,Rejection_Reason__c, Qty_Received__c,
                                                                                          Picklist_Line__r.Inventory_Position__c,Picklist_Line__r.Inventory_Position__r.Site__c,
                                                                                          SMLine_Status__c,Product_Name__c,Picklist_Line__c,Picklist_Line__r.Sales_Order_Line__r.Sales_Order__c,
                                                                                          Picklist_Line__r.Sales_Order_Line__c,Sales_Order_Line__c,Picklist_Line__r.Pack_out_UID__c,Qty_Ordered__c,
                                                                                          Unit_Cost__c FROM Shipping_Manifest_Line__c WHERE SMLine_Status__c NOT IN (:SHIPPING_MANIFEST_LINE_STATUS_CANCELLED,:SHIPPING_MANIFEST_LINE_STATUS_REJECTED) AND  Shipping_Manifest__c In : smIds]);
        if(lstSMLines.size() > 0 ){
            for(Shipping_Manifest_Line__c smLine : lstSMLines){
                
                if(smStatus==SHIPPING_MANIFEST_STATUS_COMPLETE)
                {
                    smLine.Actual_Shipment_Qty__c  =  smLine.Shipment_Qty__c; 
                    
                    smLine.Qty_Received__c =  smLine.Shipment_Qty__c; 
                    
                }else if(smStatus==SHIPPING_MANIFEST_LINE_STATUS_REJECTED  )
                {
                    smLine.Qty_Received__c =0;
                    smLine.Actual_Shipment_Qty__c  =  smLine.Shipment_Qty__c;  }else{ smLine.Qty_Received__c =0;
                                                                                    }
                smLine.SMLine_Status__c = smStatus;
            }
            
            update lstSMLines;
            
        }
        
        List<Shipping_Manifest__c> updateShippingManifest = [SELECT RecordTypeId,Id, Name, Status__c,Actual_Receiver_Name__c,Ship_Confirmation_Date__c,
                                                             Actual_Arrival_Date_Time__c,Actual_Departure_Date_Time__c,Receiver_Acceptance_Date__c,
                                                             Receiver_Contact__r.Name,Brand_Quote__c,Order_Number__c,Sales_Order__c,Picklist__c FROM Shipping_Manifest__c WHERE Id =: smIds];
      
        
        if(smStatus == SHIPPING_MANIFEST_STATUS_COMPLETE ){
            smRecordStatus = RSMTSMShipConfirmCotroller.SALES_ORDER_STATUS_SHIPPED;
            smRecordOrderStatus = RSMTSMShipConfirmCotroller.SALES_ORDER_STATUS_SHIPPED;
        }
        if(smStatus == SHIPPING_MANIFEST_LINE_STATUS_REJECTED ){ smRecordStatus = SHIPPING_MANIFEST_STATUS_REJECTED;
            smRecordOrderStatus = SALES_ORDER_STATUS_CANCELLED_BY_CUSTOMER;    
        }
        if(smStatus == SHIPPING_MANIFEST_STATUS_CANCELLED ){  smRecordStatus = SHIPPING_MANIFEST_STATUS_CANCELLED;
            smRecordOrderStatus = SALES_ORDER_STATUS_CANCELLED_BY_FILIGREEN;  
        }
        
        
        if(smStatus == SHIPPING_MANIFEST_STATUS_COMPLETE || smStatus == SHIPPING_MANIFEST_LINE_STATUS_REJECTED ){
            
            if(updateShippingManifest[0].Sales_Order__c != NULL){
                Sales_Order__c soData = new Sales_Order__c();
                soId.add(updateShippingManifest[0].Sales_Order__c);
                soData.Id = updateShippingManifest[0].Sales_Order__c; 
                soData.SO_Status__c = smRecordStatus;
                soData.Ship_Confirmation_Date__c = System.Today();
                Update soData;
            }
            
            if(updateShippingManifest[0].Brand_Quote__c != NULL){
                Brand_Quote__c brandQuoteData = new Brand_Quote__c();
                brandQuoteData.Id = updateShippingManifest[0].Brand_Quote__c;
                brandQuoteData.BQ_Status__c = smRecordStatus;
                brandQuoteData.Ship_Confirmation_Date__c = System.Today();
                Update brandQuoteData;
                if(smRecordStatus=='Rejected'){
                    Purchase_Order__c pores = [Select Id,PO_Status__c,Brand_Quote__c From Purchase_Order__c where Brand_Quote__c=:updateShippingManifest[0].Brand_Quote__c]; 
                    pores.PO_Status__c = 'Rejected';
                    Update pores;
                }
            }
            
            if(updateShippingManifest[0].Order_Number__c != NULL){Order__c orderData = new Order__c();
                orderData.Id = updateShippingManifest[0].Order_Number__c;
                orderData.Status__c = smRecordOrderStatus;
                Update orderData;
            }
            /*if(updateShippingManifest[0].Brand_Quote__c != null){
                List<Invoice__c> invList = new List<Invoice__c>() ;
                for(Invoice__c inv :[SELECT id,Ship_Confirmation_Date__c FROM Invoice__c WHERE Brand_Quote__c =: updateShippingManifest[0].Brand_Quote__c AND RecordType.Name =: INVOICE_RECORD_TYPE_SERVICE]){
                    inv.Ship_Confirmation_Date__c  =System.Today();
                    invList.add(inv);
                }
                if(invList.size() > 0){
                    update invList;
                }
            }*/
            
        }
        
        if(smStatus!= SHIPPING_MANIFEST_STATUS_CANCELLED){
            
            List<Inventory_Position__c> invPositions;
            if(updateShippingManifest[0].RecordTypeId == ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER)){ invPositions = ShipConfirmController.setInvPositionToDelivered(lstSMLines,SHIPPING_MANIFEST_RECORDTYPE_TRANSFFERED);
                
            }else if(updateShippingManifest[0].RecordTypeId == ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_LAB)){ invPositions = ShipConfirmController.setInvPositionToDelivered(lstSMLines,SHIPPING_MANIFEST_RECORDTYPE_TEST_SAMPLED);
            }else{
                
                // Update inventory position to update with Delivered
                invPositions = ShipConfirmController.setInvPositionToDelivered(lstSMLines,SHIPPING_MANIFEST_RECORDTYPE_DELIVERED);
            } 
            if(smStatus == SHIPPING_MANIFEST_STATUS_COMPLETE)
            {
                upsert invPositions;
            }
            
            if(internNewOldShipmentStatus==False ||  internsmStatusCancelledToComplete== true){
                            RSMSupport.updateInvPositionsAndSOLines(lstSMLines,true);
                
            }
             
             updateBqAndOrderLineItems(soId);

        }else{
            
            if(updateShippingManifest[0].Picklist__c != null){  Picklist__c picklistObj = new Picklist__c();
                picklistObj.Id = updateShippingManifest[0].Picklist__c; picklistObj.Status__c = SHIPPING_MANIFEST_STATUS_CANCELLED;
                update picklistObj;
            }
            
            if(updateShippingManifest[0].Order_Number__c != NULL){   Order__c orderData = new Order__c();
                orderData.Id = updateShippingManifest[0].Order_Number__c;
                orderData.Status__c = smRecordOrderStatus;  Update orderData;
            }
            RSMSupport.updateInvPositionsAndSOLines(lstSMLines,true,true);
            updateBqAndOrderLineItems(soId);
        }
    }
    
    
    
    /* bqline & order line & poline update - code updated for 101 */
   @future
    public static void  updateBqAndOrderLineItems(Set<Id> soId) { 
        
        AuraResponse r = new AuraResponse('updateBqAndOrderLineItems()'); 
        ShippingManifestHandler assign = new ShippingManifestHandler();
        List<Sales_Order__c> soRes = new List<Sales_Order__c>();
        List<Sales_Order_Line__c> items = new List<Sales_Order_Line__c>();
        Map<Id,Brand_Quote_Line__c> BQLineMap = new Map<Id,Brand_Quote_Line__c>();
        Set<Id> SOLIds = new Set<Id>();
        Set<Id> bqId = new Set<Id>();
        Set<Id> bqLineIds = new Set<Id>();
        soRes = [SELECT Id, Name,Brand_Quote__c,(SELECT Id, Name,Brand_Quote_Line__c, Status__c,Qty_Ordered__c,MOQ__c FROM Sales_Order_Lines__r)  FROM Sales_Order__c WHERE Id=: soId ];
        for(Sales_Order__c sRes : soRes){ 
            bqId.add(sRes.Brand_Quote__c);
            for(Sales_Order_Line__c sli : sRes.Sales_Order_Lines__r){ 
                if(sli.MOQ__c != 0)
                {
                BQLineMap.put(sli.Brand_Quote_Line__c,new Brand_Quote_Line__c(Id = sli.Brand_Quote_Line__c,Status__c = sli.Status__c,Quantity_Cases__c = sli.Qty_Ordered__c/sli.MOQ__c));  
                SOLIds.add(sli.Id);
                bqLineIds.add(sli.Brand_Quote_Line__c);
                    }
            }
        }
        
        if(SOLIds.size() > 0){
            items = [SElECT Status__c,Qty_Ordered__c,MOQ__c,Qty_Allocated__c, Balance_Qty_to_Allocate__c ,Brand_Quote_Line__c, Sales_Order__c  FROM Sales_Order_Line__c WHERE Id IN: SOLIds AND Sales_Order__r.SO_Status__c =: SO_STATUS_DRAFT];
            List<Brand_Quote_Line__c> BQLToUpdate = new List<Brand_Quote_Line__c>();
            for(Sales_Order_Line__c sli: items){ Brand_Quote_Line__c bql = new Brand_Quote_Line__c();
                if(sli.Brand_Quote_Line__c != null){
                    bql = new Brand_Quote_Line__c(Id = sli.Brand_Quote_Line__c,Quantity_Cases__c=sli.Qty_Ordered__c/sli.MOQ__c,Status__c = sli.Status__c);  
                }
                if(bql != null && bql.Id != null){
                    BQLineMap.put(sli.Brand_Quote_Line__c,bql);    
                }
            }
            if(BQLineMap.size() > 0){
                
                update BQLineMap.values();
            }
            
            List<Purchase_Order_Line__c> polineList = new List<Purchase_Order_Line__c>();
            List<Purchase_Order_Line__c> polineToUpdate = new List<Purchase_Order_Line__c>();
            polineList= [select Id,Brand_Quote_Line__c,Brand_Quote_Line__r.Line_Total_Qty__c,Brand_Quote_Line__r.Status__c  from Purchase_Order_Line__c where Brand_Quote_Line__c IN:bqLineIds];
            if(polineList.size()>0 ){for(Purchase_Order_Line__c po: polineList){ 
                Purchase_Order_Line__c poIoood = new Purchase_Order_Line__c();
                poIoood.Id = po.Id;
                if(po.Brand_Quote_Line__r.Status__c =='Cancelled' ){  
                    
                    poIoood.POLI_Status__c = 'Cancelled';  }
                else  if( po.Brand_Quote_Line__r.Status__c =='Rejected' ){
                    poIoood.POLI_Status__c = 'Rejected';  
                }
                poIoood.Qty_Ordered__c =  po.Brand_Quote_Line__r.Line_Total_Qty__c;
                polineToUpdate.add(poIoood);
            }
       if(polineToUpdate.size() >0){
         update polineToUpdate;  
          }
                                     
      }
            
        }
    }
    
       
     /* Method - Shipping Manifest Internal Shipment Complete, Cancelled and Rejected */
    
    public static void updateSmInternalCancelToDraft(Set<Id> smIds, String smStatus){
        
        Boolean allSMLinesCancelled = true;
        String smRecordStatus;  String smRecordOrderStatus;
        List<Shipping_Manifest_Line__c> lstSMLines = new List<Shipping_Manifest_Line__c>();
        Map<Id, Sales_Order_Line__c> SOLToUpdate = new Map<Id, Sales_Order_Line__c>();
        Map<Id, Picklist_Line__c> pkLineToUpdate = new Map<Id, Picklist_Line__c>();
        List<Brand_Quote_Line__c > bqLines = new List<Brand_Quote_Line__c >();
        Set<Id> soLineIds = new Set<Id>();
        
        lstSMLines = new List<Shipping_Manifest_Line__c>([SELECT ID, Name, Product_Name__r.Name, Shipping_Manifest__r.Name,Purchase_Order_Line__c,
                                                          Product_Description__c,Producer_Name__c,Retail_Wholesale_Price__c,Actual_Shipment_Qty__c,
                                                          Shipment_Qty__c,Rejection_Reason__c, Qty_Received__c,
                                                          Picklist_Line__r.Inventory_Position__c,Picklist_Line__r.Inventory_Position__r.Site__c,
                                                          SMLine_Status__c,Product_Name__c,Picklist_Line__c,Picklist_Line__r.Sales_Order_Line__r.Sales_Order__c,
                                                          Picklist_Line__r.Sales_Order_Line__c,Sales_Order_Line__c,Picklist_Line__r.Pack_out_UID__c,Qty_Ordered__c,
                                                          Unit_Cost__c FROM Shipping_Manifest_Line__c WHERE   Shipping_Manifest__c In : smIds]);
        
        
        if(lstSMLines.size() > 0 ){
            for(Shipping_Manifest_Line__c smLine : lstSMLines){
                
                smLine.SMLine_Status__c = Null;
                Sales_Order_Line__c soLine = SOLToUpdate.get(smLine.Sales_Order_Line__c);
                soLine = new Sales_Order_Line__c(Id = smLine.Sales_Order_Line__c, Status__c  = SALES_ORDER_LINE_STATUS_ALLOCATED);
                SOLToUpdate.put(smLine.Sales_Order_Line__c, soLine); 
                soLineIds.add(smLine.Sales_Order_Line__c);  
                Picklist_Line__c pkLine = pkLineToUpdate.get(smLine.Picklist_Line__c);
                pkLine = new Picklist_Line__c(Id = smLine.Picklist_Line__c, Status__c  = Null);
                pkLineToUpdate.put(smLine.Picklist_Line__c, pkLine); 
                
            }
            update lstSMLines;
            
            if(!SOLToUpdate.isEmpty()){
                update SOLToUpdate.values();}
            
        }
        
        
        List<Shipping_Manifest__c> updateShippingManifest = [SELECT RecordTypeId,Id, Name, Status__c,Actual_Receiver_Name__c,Ship_Confirmation_Date__c,
                                                             Actual_Arrival_Date_Time__c,Actual_Departure_Date_Time__c,Receiver_Acceptance_Date__c,
                                                             Receiver_Contact__r.Name,Brand_Quote__c,Order_Number__c,Sales_Order__c,Picklist__c FROM Shipping_Manifest__c WHERE Id =: smIds];
        
        smRecordStatus =SALES_ORDER_STATUS_APPROVED;
        smRecordOrderStatus =  smRecordStatus;
        
        if(updateShippingManifest[0].Sales_Order__c != NULL){
            Sales_Order__c soData = new Sales_Order__c();
            soData.Id = updateShippingManifest[0].Sales_Order__c;    soData.SO_Status__c = smRecordStatus;
            soData.Ship_Confirmation_Date__c = System.Today();
            Update soData;
        }
        
        if(updateShippingManifest[0].Brand_Quote__c != NULL){
            Brand_Quote__c brandQuoteData = new Brand_Quote__c();
            brandQuoteData.Id = updateShippingManifest[0].Brand_Quote__c; brandQuoteData.BQ_Status__c = smRecordStatus;
            brandQuoteData.Ship_Confirmation_Date__c = System.Today();
            Update brandQuoteData;
            
            List<Sales_Order_Line__c> soLineItems = new List<Sales_Order_Line__c>();
            Map<Id,Brand_Quote_Line__c> BQLineMap = new Map<Id,Brand_Quote_Line__c>();
            if(soLineIds.size() > 0){soLineItems = [SElECT Status__c,Qty_Ordered__c,Qty_Allocated__c ,Brand_Quote_Line__c, Sales_Order__c,Actual_Qty_Ordered__c,MOQ__c  FROM Sales_Order_Line__c WHERE Id IN:soLineIds];
                                     List<Brand_Quote_Line__c> BQLToUpdate = new List<Brand_Quote_Line__c>();
                                     for(Sales_Order_Line__c sli: soLineItems){
                                         if(sli.Brand_Quote_Line__c != null){  BQLineMap.put(sli.Brand_Quote_Line__c,new Brand_Quote_Line__c(Id = sli.Brand_Quote_Line__c,Status__c =Null));
                                                                            }
                                     }
                                    }
            if(BQLineMap.size() > 0){
                update BQLineMap.values();
            }
            
            
        }
        
        if(updateShippingManifest[0].Order_Number__c != NULL){
            Order__c orderData = new Order__c();
            orderData.Id = updateShippingManifest[0].Order_Number__c; orderData.Status__c = smRecordOrderStatus;
            Update orderData;
            
            List<Order_Line_Item__c> orderLineItems = new List<Order_Line_Item__c>();
            Map<Id,Order_Line_Item__c> OLIProductMap = new Map<Id,Order_Line_Item__c>();
            orderLineItems = [SELECT Id,Order__c,OrderLine_Status__c, Status__c  FROM Order_Line_Item__c WHERE Order__c =: updateShippingManifest[0].Order_Number__c ];
            
            for(Order_Line_Item__c oli: orderLineItems){
                
                oli.Status__c = SALES_ORDER_STATUS_APPROVED;
                oli.OrderLine_Status__c = Null;
                
            }
            if(orderLineItems.size() > 0){
                update orderLineItems;
            }
        } 
    }
    
    // Internal SM status change from Rejected to Shipment Complete
    @future
    public static void updateInvoiceStatus(Set<Id> internSMID){
        Id productInvoiceRecordTypeID =  Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_PRODUCT).getRecordTypeId();  
        
        Shipping_Manifest__c smPaytermUpdate = [SELECT Id, Name, Sales_Order__c,Sales_Order__r.Payment_Terms__c,Picklist__c 
                                                FROM Shipping_Manifest__c WHERE Id =: internSMID];
        if(smPaytermUpdate.Sales_Order__c != NULL){
            List<Invoice__c> invoicelst= [select Id, Name, AR_Status__c  from Invoice__c where Sales_Order__c =:smPaytermUpdate.Sales_Order__c AND RecordTypeId =:productInvoiceRecordTypeID];
            List<Invoice__c> inList = new List<Invoice__c>();
            if(invoicelst.size()>0 ){
                for(Invoice__c inv: invoicelst){ Invoice__c invoiceData = new Invoice__c();
                                                invoiceData.Id = inv.Id;  invoiceData.AR_Status__c = INVOICE_AR_STATUS_SHIPPED;
                                                inList.add(invoiceData);
                                               }
               if(inList.size() > 0 ) update  inList;  
            }
            
        }
        
        // Map IP to salesorder
        if(smPaytermUpdate.Picklist__c !=NULL)
        {
            //line list iplineid
            List<Inventory_Position__c> invPositions = new List<Inventory_Position__c>();
            List<Picklist_Line__c> picklistLineItem= [select Id, Sales_Order_Line__c,Inventory_Position__c from Picklist_Line__c where Picklist__c =:smPaytermUpdate.Picklist__c];
            
            if(picklistLineItem.size()>0 ){for(Picklist_Line__c pickRes: picklistLineItem){  Inventory_Position__c ipData = new Inventory_Position__c(); ipData.Id = pickRes.Inventory_Position__c; ipData.Sales_Order_Line__c = pickRes.Sales_Order_Line__c;invPositions.add(ipData);
                                                                                          }
                                           update  invPositions;  
                                          }
            Picklist__c pklistUpdate = [SELECT Id, Status__c FROM Picklist__c WHERE Id =: smPaytermUpdate.Picklist__c];
            pklistUpdate.Status__c = PICKLIST_STATUS_QA_CONFIRM;
            Update pklistUpdate;
        }
    }
    
     // Internal SM status change from Rejected to Shipment Complete  - soline map to Invoice
    @future
    public static void updateInvoiceLineStatus(Set<Id> internSMID){
        Id productInvoiceRecordTypeID =  Schema.SObjectType.Invoice__c.getRecordTypeInfosByName().get(INVOICE_RECORDTYPE_PRODUCT).getRecordTypeId();  
        
        Set<Id> soLineIds = new Set<Id>();
        Set<Id> pkLineIds = new Set<Id>();
        Shipping_Manifest_Line__c smPaytermUpdate = [SELECT Id, Name, Sales_Order_Line__c,Picklist_Line__c
                                                     FROM Shipping_Manifest_Line__c WHERE Id =: internSMID];
        
        
        
        if(smPaytermUpdate.Sales_Order_Line__c != NULL){
            List<Invoice_Line__c> invoicelst= [select Id, Name, InvoiceLine_Status__c  from Invoice_Line__c where Sales_Order_Line__c =:smPaytermUpdate.Sales_Order_Line__c ];
            List<Invoice_Line__c> inList = new List<Invoice_Line__c>();
            if(invoicelst.size()>0 ){
                for(Invoice_Line__c inv: invoicelst){ Invoice_Line__c invoiceData = new Invoice_Line__c();
                                                     invoiceData.Id = inv.Id;  invoiceData.InvoiceLine_Status__c = INVOICE_AR_STATUS_SHIPPED;
                                                     inList.add(invoiceData);
                                                    }
                update  inList;  
            }
            
        }
        
        // Map IP to salesorder
        if(smPaytermUpdate.Picklist_Line__c !=NULL || Test.isRunningTest() ) 
        {
            //line list iplineid
            List<Inventory_Position__c> invPositions = new List<Inventory_Position__c>();
            List<Picklist_Line__c> picklistLineItem= [select Id, Sales_Order_Line__c,Inventory_Position__c from Picklist_Line__c where Id =:smPaytermUpdate.Picklist_Line__c];
            
            if(picklistLineItem.size()>0 || Test.isRunningTest()){
                for(Picklist_Line__c pickRes: picklistLineItem){ 
                    Inventory_Position__c ipData = new Inventory_Position__c(); 
                    ipData.Id = pickRes.Inventory_Position__c; ipData.Sales_Order_Line__c = pickRes.Sales_Order_Line__c;
                    invPositions.add(ipData);
                }
                update  invPositions;  
            }
            
        }
        
    }
    public static void updateWinStartEnd(List<Shipping_Manifest__c> newSMList, Map<Id, Shipping_Manifest__c> oldSMMap)   {
        Id cashRecordTypeID =  Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_CASHCOLLECTION).getRecordTypeId();
        Id ProductTsmRecordTypeID =  Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_PRODUCT_TSM).getRecordTypeId();
        Set<Id> soIds = new Set<Id>();
         Map<Id,Shipping_Manifest__c> oppMap = new Map<Id,Shipping_Manifest__c>();
        List<Sales_Order__c> soList = new List<Sales_Order__c>();
        List<Purchase_Order__c> poList = new List<Purchase_Order__c>();
        system.debug('###updateWinStartEnd');
            for(Shipping_Manifest__c sm: newSMList){
                if( (sm.Planned_Ship_Transfer_Date__c != oldSMMap.get(sm.Id).Planned_Ship_Transfer_Date__c || sm.Vehicle__c != oldSMMap.get(sm.Id).Vehicle__c || sm.Driver__c != oldSMMap.get(sm.Id).Driver__c || sm.Window_Start__c != oldSMMap.get(sm.Id).Window_Start__c || sm.Window_End__c != oldSMMap.get(sm.Id).Window_End__c || sm.Priority__c != oldSMMap.get(sm.Id).Priority__c )){
                    if(sm.RecordTypeId != cashRecordTypeID && sm.RecordTypeId != ProductTsmRecordTypeID && sm.Sales_Order__c != null){
                        Sales_Order__c so = new Sales_Order__c();
                        so.id = sm.Sales_Order__c;
                        so.Priority__c = sm.Priority__c != null ? sm.Priority__c : '';
                        so.Window_Start__c = sm.Window_Start__c != null ? sm.Window_Start__c : null;
                        so.Window_End__c = sm.Window_End__c != null ? sm.Window_End__c : null;
                        so.Driver__c = sm.Driver__c != null ? sm.Driver__c : null ;
                        so.Vehicle__c = sm.Vehicle__c != null ? sm.Vehicle__c : null;
                        so.Planned_Ship_Date__c = sm.Planned_Ship_Transfer_Date__c != null ? sm.Planned_Ship_Transfer_Date__c : null;
                        soList.add(so);
                    }else if(sm.Purchase_Order__c != null){
                        Purchase_Order__c po = new Purchase_Order__c();
                        po.id = sm.Purchase_Order__c;
                        po.Priority__c = sm.Priority__c != null ? sm.Priority__c : '';
                        po.Window_Start__c = sm.Window_Start__c != null ? sm.Window_Start__c : null;
                        po.Window_End__c = sm.Window_End__c != null ? sm.Window_End__c : null;
                        po.Driver__c = sm.Driver__c != null ? sm.Driver__c : null ;
                        po.Vehicle__c = sm.Vehicle__c != null ? sm.Vehicle__c : null;
                        po.Planned_Ship_Transfer_Date__c = sm.Planned_Ship_Transfer_Date__c != null ? sm.Planned_Ship_Transfer_Date__c : null;
                        poList.add(po);
                    }
                    
                    
                }
                
            }
        system.debug('###soList : '+soList.size());
        if(soList.size() > 0){
            update soList;
        }
        if(poList.size() > 0){
            update poList;
        }
    }
 
}