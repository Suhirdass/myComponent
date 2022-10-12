/**
 * Copyright (c) 2021 WOVN
 * All rights reserved.
 * ShipConfirmController
 */
public class ShipConfirmController{ 
    
    public static String errorMessage;
    public static String validateerrorMessage;
    public static List<string> errorslt;
    public Shipping_Manifest__c setSM {get; set;}
    public List<Invoice__c> invoiceDt {get; set;}
    public List<rsmlinesWrapper> setRsmLines {get; set;}
    
    public Static String SHIPPING_MANIFEST_CASH_COLLECTION_RT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_CASH_COLLECTION_RT) ? SHIPPING_MANIFEST_CASH_COLLECTION_RT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_CashCollect');
        }set;
    }
    public Static String SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM) ? SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_ProductTSM');
        }set;
    }
    public Static String SHIPPING_MANIFEST_RECORDTYPE_SERVICE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_SERVICE) ? SHIPPING_MANIFEST_RECORDTYPE_SERVICE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Service');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_COMPLETE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_COMPLETE) ? SHIPPING_MANIFEST_STATUS_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Complete');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_PENDING_DELIVERY{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_PENDING_DELIVERY) ? SHIPPING_MANIFEST_STATUS_PENDING_DELIVERY: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Pending_Deliver');
        }set;
    }
    private static String NAME_TEST_SAMPLED{
        get{
            return String.isNotBlank(NAME_TEST_SAMPLED) ? NAME_TEST_SAMPLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Test_Sampled');
        }set;
    }
    private static String NAME_TRANSFERRED{
        get{
            return String.isNotBlank(NAME_TRANSFERRED) ? NAME_TRANSFERRED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Transferred');
        }set;
    }
    private static String NAME_DELIVERED{
        get{
            return String.isNotBlank(NAME_DELIVERED) ? NAME_DELIVERED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Inventory Location','Name_Delivered');
        }set;
    }
    private static String STATE_LICENSE_ACTIVE{
        get{
            return String.isNotBlank(STATE_LICENSE_ACTIVE) ? STATE_LICENSE_ACTIVE : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('State License','State_License_Active');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_PENDING{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_PENDING) ? SHIPPING_MANIFEST_STATUS_PENDING: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_ShipmentPending');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_DRAFT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_DRAFT) ? SHIPPING_MANIFEST_STATUS_DRAFT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Draft');
        }set;
    }
    
    public Static String ERR_MSG_ASSIGN_DRIVER_AND_VEHICLE{
        get{
            return String.isNotBlank(ERR_MSG_ASSIGN_DRIVER_AND_VEHICLE) ? ERR_MSG_ASSIGN_DRIVER_AND_VEHICLE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_assign_Driver_And_Vehicle');
        }set;
    }
    public Static String ERR_MSG_COMPLETE_DEPART_CONFIRM{
        get{
            return String.isNotBlank(ERR_MSG_COMPLETE_DEPART_CONFIRM) ? ERR_MSG_COMPLETE_DEPART_CONFIRM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Complete_Depart_Confirm');
        }set;
    }
    public Static String ERR_MSG_COMPLETE_PICKLIST_QA_CONFIRM{
        get{
            return String.isNotBlank(ERR_MSG_COMPLETE_PICKLIST_QA_CONFIRM) ? ERR_MSG_COMPLETE_PICKLIST_QA_CONFIRM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Complete_Picklist_QA_Confirm');
        }set;
    }
    public Static String ERR_MSG_SITE{
        get{
            return String.isNotBlank(ERR_MSG_SITE) ? ERR_MSG_SITE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Site');
        }set;
    }
    public Static String ERR_MSG_BRAND_QUOTE{
        get{
            return String.isNotBlank(ERR_MSG_BRAND_QUOTE) ? ERR_MSG_BRAND_QUOTE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Brand_Quote');
        }set;
    }
    public Static String ERR_MSG_CUSTOMER_PO_OR_QUOTE{
        get{
            return String.isNotBlank(ERR_MSG_CUSTOMER_PO_OR_QUOTE) ? ERR_MSG_CUSTOMER_PO_OR_QUOTE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Customer_PO_or_Quote');
        }set;
    }
    public Static String ERR_MSG_OPPORTUNITY_NAME{
        get{
            return String.isNotBlank(ERR_MSG_OPPORTUNITY_NAME) ? ERR_MSG_OPPORTUNITY_NAME: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Opportunity_Name');
        }set;
    }
    public Static String ERR_MSG_PICKLIST{
        get{
            return String.isNotBlank(ERR_MSG_PICKLIST) ? ERR_MSG_PICKLIST: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Picklist');
        }set;
    }    
    public Static String ERR_MSG_SHIPPING_TERMS{
        get{
            return String.isNotBlank(ERR_MSG_SHIPPING_TERMS) ? ERR_MSG_SHIPPING_TERMS: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Shipping_Terms');
        }set;
    }
    public Static String ERR_MSG_SHIPPING_METHOD{
        get{
            return String.isNotBlank(ERR_MSG_SHIPPING_METHOD) ? ERR_MSG_SHIPPING_METHOD: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Shipping_Method');
        }set;
    }
    public Static String ERR_MSG_PAYMENT_TERMS{
        get{
            return String.isNotBlank(ERR_MSG_PAYMENT_TERMS) ? ERR_MSG_PAYMENT_TERMS: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Payment_Terms');
        }set;
    }
    public Static String ERR_MSG_DRIVER{
        get{
            return String.isNotBlank(ERR_MSG_DRIVER) ? ERR_MSG_DRIVER: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Driver');
        }set;
    }
    public Static String ERR_MSG_VEHICLE{
        get{
            return String.isNotBlank(ERR_MSG_VEHICLE) ? ERR_MSG_VEHICLE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Vehicle');
        }set;
    }
    public Static String ERR_MSG_DISTRIBUTOR_CONTACT{
        get{
            return String.isNotBlank(ERR_MSG_DISTRIBUTOR_CONTACT) ? ERR_MSG_DISTRIBUTOR_CONTACT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Distributor_Contact');
        }set;
    }
	public Static String ERR_MSG_DISTRIBUTOR_LICENSE{
        get{
            return String.isNotBlank(ERR_MSG_DISTRIBUTOR_LICENSE) ? ERR_MSG_DISTRIBUTOR_LICENSE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Distributor_License');
        }set;
    }
    public Static String ERR_MSG_DISTI_LICENSE_ACTIVE{
        get{
            return String.isNotBlank(ERR_MSG_DISTI_LICENSE_ACTIVE) ? ERR_MSG_DISTI_LICENSE_ACTIVE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Disti_License_Active');
        }set;
    }
	public Static String ERR_MSG_DISTI_LICENSE_ALREADY_EXIPIRED{
        get{
            return String.isNotBlank(ERR_MSG_DISTI_LICENSE_ALREADY_EXIPIRED) ? ERR_MSG_DISTI_LICENSE_ALREADY_EXIPIRED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Disti_License_Already_Exipired');
        }set;
    } 
    public Static String ERR_MSG_DISTI_DISTRIBUTOR_NAME{
        get{
            return String.isNotBlank(ERR_MSG_DISTI_DISTRIBUTOR_NAME) ? ERR_MSG_DISTI_DISTRIBUTOR_NAME: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Disti_Distributor_Name');
        }set;
    }
    public Static String ERR_MSG_SUPPLIER_CONTACT{
        get{
            return String.isNotBlank(ERR_MSG_SUPPLIER_CONTACT) ? ERR_MSG_SUPPLIER_CONTACT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Supplier_Contact');
        }set;
    }
    
    public Static String ERR_MSG_SUPPLIER_NAME{
        get{
            return String.isNotBlank(ERR_MSG_SUPPLIER_NAME) ? ERR_MSG_SUPPLIER_NAME: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Supplier_Name');
        }set;
    }
    
    public Static String ERR_MSG_RECEIVER_CONTACT{
        get{
            return String.isNotBlank(ERR_MSG_RECEIVER_CONTACT) ? ERR_MSG_RECEIVER_CONTACT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Receier_Contact');
        }set;
    }
    
    public Static String ERR_MSG_RECEIVER_NAME{
        get{
            return String.isNotBlank(ERR_MSG_RECEIVER_NAME) ? ERR_MSG_RECEIVER_NAME: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_Receier_Name');
        }set;
    }
     public Static String SHIPPING_MANIFEST_STATUS_REJECT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_REJECT) ? SHIPPING_MANIFEST_STATUS_REJECT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Rejected');
        }set;
    }
   
      public Static String SHIPPING_MANIFEST_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_CANCELLED) ? SHIPPING_MANIFEST_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Cancelled');
        }set;
    }
       public Static String ERR_MSG_REJECT{
        get{
            return String.isNotBlank(ERR_MSG_REJECT) ? ERR_MSG_REJECT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_SM_Rejected');
        }set;
    }
    public Static String ERR_MSG_CANCELLED{
        get{
            return String.isNotBlank(ERR_MSG_CANCELLED) ? ERR_MSG_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_SM_Cancelled');
        }set;
    }
    public Static String ERR_MSG_STATUS_ALREADY_COMPLETE{
        get{
            return String.isNotBlank(ERR_MSG_STATUS_ALREADY_COMPLETE) ? ERR_MSG_STATUS_ALREADY_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_SM_Already_Complete');
        }set;
    }
    public Static String BRAND_QUOTE_STATUS_SHIPPED {
        get{
            return String.isNotBlank(BRAND_QUOTE_STATUS_SHIPPED) ? BRAND_QUOTE_STATUS_SHIPPED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Status_Shipped');
        }set;
    }
    public Static String ORDER_STATUS_SHIPPED{
        get{
            return String.isNotBlank(ORDER_STATUS_SHIPPED) ? ORDER_STATUS_SHIPPED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Order_Status_Shipped');
        }set;
    }
    public Static String SALES_ORDER_STATUS_SHIPPED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_SHIPPED) ? SALES_ORDER_STATUS_SHIPPED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Shipped');
        }set;
    }
    
    
      public Static String SHIPPING_MANIFEST_EXCEPTION_ERROR_UPDATING_RSM_TSM{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_EXCEPTION_ERROR_UPDATING_RSM_TSM) ? SHIPPING_MANIFEST_EXCEPTION_ERROR_UPDATING_RSM_TSM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Exception_Error');
        }set;
    }
    
     public Static String SHIPPING_MANIFEST_STATUS_RECEIVED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_RECEIVED) ? SHIPPING_MANIFEST_STATUS_RECEIVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Received');
        }set;
    }
     public Static String SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION) ? SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_CashCollect');
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
    public Static String BRAND_QUOTE_STATUS_REJECTED{
        get{
            return String.isNotBlank(BRAND_QUOTE_STATUS_REJECTED) ? BRAND_QUOTE_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Brand_Quote__c','BrandQuote_Status_Rejected');
        }set;
    } 
       public static String ORDERCANCELLED_CUSTOMER{
        get{
            return String.isNotBlank(ORDERCANCELLED_CUSTOMER) ? ORDERCANCELLED_CUSTOMER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Customer');
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
    public Static String SHIPPING_MANIFEST_RECORDTYPE_DELIVERED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_DELIVERED) ? SHIPPING_MANIFEST_RECORDTYPE_DELIVERED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Delivered');
        }set;
    }
    
    public Static String SHIPPING_MANIFEST_LINE_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_STATUS_CANCELLED) ? SHIPPING_MANIFEST_LINE_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Cancelled');
        }set;
    }
        public Static String SALES_ORDER_STATUS_CANCELLED_BY_FILIGREEN{
        get{
            return  String.isNotBlank(SALES_ORDER_STATUS_CANCELLED_BY_FILIGREEN) ? SALES_ORDER_STATUS_CANCELLED_BY_FILIGREEN: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Filigreen');
        }set;
    }
    public Static String SO_STATUS_DRAFT {		
        get{
            return String.isNotBlank(SO_STATUS_DRAFT) ? SO_STATUS_DRAFT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Draft');
        }set;
    }
     public Static String PURCHASE_ORDER_STATUS_REJECTED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_REJECTED) ? PURCHASE_ORDER_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','Purchase Order Status Rejected');
        }set;
    } 
       
    
    
    private ApexPages.StandardController stdController;
    private Shipping_Manifest__c rsmObj = null;
    private static final String LICENSE_STATUS_ACTIVE = STATE_LICENSE_ACTIVE; 
    public static boolean IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED = True;
    
    public static final String DELIVERED = NAME_DELIVERED;
    public static final String TRANSFERRED = NAME_TRANSFERRED;
    public static final String TEST_SAMPLED = NAME_TEST_SAMPLED;
   public List<String> errors {get;set;}
    
    @testVisible
    private static final String RSM_STATUS_SHIPMENT_COMPLETE = SHIPPING_MANIFEST_STATUS_COMPLETE; 
    @testVisible
    private static final String RSM_STATUS_PENDING_DELIVERY = SHIPPING_MANIFEST_STATUS_PENDING_DELIVERY;
    Id productTSMRecordTypeId;
    Id serviceRecordTypeId;
    Id cashCollectionRecordTypeId;
    
    // Constructor
    public ShipConfirmController(ApexPages.StandardController controller) {
        this.stdController = controller;
       errors = new List<String>();
        rsmObj = (Shipping_Manifest__c)stdController.getRecord();
        productTSMRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM).getRecordTypeId();
        serviceRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_SERVICE).getRecordTypeId();
        cashCollectionRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_CASH_COLLECTION_RT).getRecordTypeId();
    }
    
    public class UserException extends Exception{ }
    
    
    public ShipConfirmController(){}
   @AuraEnabled
    public static AuraResponse shipConfirmlt (String recordId) {
        
        AuraResponse r = new AuraResponse('shipConfirmlt()');
        ShipConfirmController assign = new ShipConfirmController();
        Savepoint savePoint;
        try {
            savePoint = Database.setSavepoint();
           errorslt = new List<String>();  
                Shipping_Manifest__c sm = [select id ,Purchase_Order__c,Purchase_Order__r.Supplier_Name__r.Hold__c ,Purchase_Order__r.Receiver_Name__r.Hold__c,Purchase_Order__r.Distributor_Name__r.Hold__c,Purchase_Order__r.Supplier_Name__r.DBA__c ,Purchase_Order__r.Receiver_Name__r.DBA__c,Purchase_Order__r.Distributor_Name__r.DBA__c ,Picklist__c,Invoice__c, Sales_Order__c, Payment_Terms__c from  Shipping_Manifest__c where id  =: recordId];
          
            assign.rsmObj= assign.retrieveRSMAndLineslt(recordId) ;
               Boolean hasValidationError = false;
            if(assign.rsmObj.Status__c != RSM_STATUS_SHIPMENT_COMPLETE){
                if(assign.checkValidation2()){
                r.data.put('validatelite', validateerrorMessage);
                   return r;
                }
            }else{
                  errorMessage = ERR_MSG_STATUS_ALREADY_COMPLETE;
                  hasValidationError = true;
              r.data.put('messagelightning', errorMessage);
            }
            
         
            assign.updateRSMAndLines(); 
        }catch (Exception ex){Database.rollback(savePoint);
            return r;
        }
        return r;
    } 
    
    
 public  Boolean checkValidation2(){
        
        Boolean hasValidationError = false;
            if(rsmObj.Status__c == SHIPPING_MANIFEST_STATUS_DRAFT || rsmObj.Status__c == SHIPPING_MANIFEST_STATUS_PENDING )
            {
             validateerrorMessage = ERR_MSG_COMPLETE_DEPART_CONFIRM;
             hasValidationError = true;
                
            }
    
        if(rsmObj.Status__c == SHIPPING_MANIFEST_STATUS_REJECT){ validateerrorMessage = ERR_MSG_REJECT; hasValidationError = true;
            
        }else if(rsmObj.Status__c == SHIPPING_MANIFEST_STATUS_CANCELLED){ validateerrorMessage = ERR_MSG_CANCELLED; hasValidationError = true;
            
        }else if(rsmObj.Actual_Departure_Date_Time__c != null && 
                 rsmObj.Distributor_License_Expiration_Date__c < rsmObj.Actual_Departure_Date_Time__c){ validateerrorMessage = ERR_MSG_DISTI_LICENSE_ALREADY_EXIPIRED;    
                     hasValidationError = true;
                     
       }  else if(rsmObj.Distributor_License_Expiration_Date__c < rsmObj.Planned_Ship_Transfer_Date__c){ validateerrorMessage = ERR_MSG_DISTI_LICENSE_ALREADY_EXIPIRED; 
         hasValidationError = true;
         
     }
    

     
        return hasValidationError;
    } 
    /**
     * Change Status to RSM status, Ship Confirmation date and RSM Line Shipment Qty
     *
     * @return PageReference of RSM detail page
     */
    public PageReference shipConfirm() {
        PageReference pageRef = null;
        Savepoint savePoint;
        
        try {
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            Shipping_Manifest__c sm = [select id ,Purchase_Order__c,Purchase_Order__r.Supplier_Name__r.Hold__c ,Purchase_Order__r.Receiver_Name__r.Hold__c,Purchase_Order__r.Distributor_Name__r.Hold__c,Purchase_Order__r.Supplier_Name__r.DBA__c ,Purchase_Order__r.Receiver_Name__r.DBA__c,Purchase_Order__r.Distributor_Name__r.DBA__c ,Picklist__c,Invoice__c, Sales_Order__c, Payment_Terms__c from  Shipping_Manifest__c where id  =: rsmObj.Id];
            if(sm.Picklist__c != null){
                Sales_Order__c SOHold = [select id,Supplier_Name__c ,Receiver_Name__c,Distributor_Name__c,Account_Hold_Exception__c, (select id, Sales_Order__c from picklists__r)  from Sales_Order__c where id =: sm.Sales_Order__c];  

                Account  supAcc = [SELECT  id , Hold__c,DBA__c  from Account  where id =:SOHold.Supplier_Name__c Limit 1];
                Account  recAcc = [SELECT  id , Hold__c,DBA__c  from Account  where id =:SOHold.Receiver_Name__c Limit 1];
                Account  disAcc = [SELECT  id , Hold__c,DBA__c from Account  where id =:SOHold.Distributor_Name__c Limit 1];
                
                String accountName = '';
                Set<String> my_list = new Set<String>();
                if((supAcc.Hold__c == true || recAcc.Hold__c == true || disAcc.Hold__c == true) && SOHold.Account_Hold_Exception__c == false)
                {
                   
                }
            }
            rsmObj = retrieveRSMAndLines();
            
            // Check validation if RSM status is not Shipment Complete
            if(rsmObj.Status__c != RSM_STATUS_SHIPMENT_COMPLETE){
                if(checkValidation()){
                    return null;
                }
            }else{
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,Label.Already_Shipment_Complete);
                errors.add(Label.Already_Shipment_Complete);
                return null;
            }
            
            // If all validation pass then update RSM and lines
            updateRSMAndLines();   }catch (Exception ex){ Database.rollback(savePoint);  return null;
            
        }
        return null;
    } 

    /**
     * Retrieve RSM with lines record
     *
     * @return The RSM with lines record
     */         
    public Shipping_Manifest__c retrieveRSMAndLines() {
        Set<Id> recordTypeIds = new Set<Id>();
        recordTypeIds.add(ShippinManifestSupport.getRSMRecordTypeId());
        recordTypeIds.add(ShippinManifestSupport.getTransferRecordTypeId(ShippinManifestSupport.RECORD_TYPE_TRANSFER));
        recordTypeIds.add(ShippinManifestSupport.getTransferRecordTypeId(ShippinManifestSupport.RECORD_TYPE_LAB));
        recordTypeIds.add(Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_SERVICE).getRecordTypeId());
        recordTypeIds.add(Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_CASH_COLLECTION_RT).getRecordTypeId());
        
        return  [Select Brand_Quote__c,
                        Invoice__c,
                        Driver__c,
                        Vehicle__c,
                 		RecordTypeId,
                        Vehicle__r.Name,
                        Customer_PO_or_Quote__c,
                        Distributor_Contact__c,
                        Distributor_License__c,
                        Distributor_License__r.License_Status__c,
                        Distributor_License_Expiration_Date__c,
                        Distributor_Name__c,
                        Opportunity_Name__c,
                 		Order_Number__c,
                        Payment_Terms__c,
                        Picklist__c,
                        Planned_Ship_Transfer_Date__c,
                        Receiver_Contact__c,
                        Receiver_License__c,
                        Receiver_License__r.License_Status__c,
                        Receiver_License_Expiration_Date__c,
                        Receiver_Name__c,
                        Status__c,
                        Sample_Order__c,
                 		Sales_Order__c,
                        Shipping_Method__c,
                        Shipping_Terms__c,
                        Site__c,
                        Supplier_Contact__c,
                        Supplier_License__c,
                        Supplier_License__r.License_Status__c,
                        Supplier_License_Expiration_Date__c,
                        Supplier_Name__c,
                        Ship_Confirmation_Date__c,
                        Actual_Arrival_Date_Time__c,
                        Actual_Departure_Date_Time__c,
                        Receiver_Acceptance_Date__c, RecordType.Name,
                 		Sales_Order__r.id,
                 		Picklist__r.Id,
                        Picklist__r.Status__c,
                        (Select Product_Name__c,
                                Product_Title__c,
                         		SMLine_Status__c,
                                Qty_Received__c,Shipment_Qty__c,
                                Retail_Wholesale_Price__c,
                                Picklist_Line__c,
                         		Picklist_Line__r.Sales_Order_Line__c,
                         		Picklist_Line__r.Sales_Order_Line__r.Sales_Order__c,
                                Picklist_Line__r.Inventory_Location__c,
                                Picklist_Line__r.Inventory_Position__r.Inventory_Location__c,
                                Picklist_Line__r.Inventory_Position__c,
                         		Picklist_Line__r.Pack_out_UID__c,
                                Picklist_Line__r.Inventory_Position__r.Site__c,
                                Name
                         From Shipping_Manifest_Lines__r 
                         WHERE SMLine_Status__c NOT IN (:RSMSupport.STATUS_CANCELLED, 
                                                         :RSMSupport.STATUS_REJECTED)
                        ORDER By Name)
                From Shipping_Manifest__c
                Where Id =: rsmObj.Id AND RecordTypeId IN :recordTypeIds];
    }
    
   /**
     * Retrieve RSM with lines record
     *
     * @return The RSM with lines record
     */         
    public Shipping_Manifest__c retrieveRSMAndLineslt(id recordId) {
        Set<Id> recordTypeIds = new Set<Id>();
        recordTypeIds.add(ShippinManifestSupport.getRSMRecordTypeId());
        recordTypeIds.add(ShippinManifestSupport.getTransferRecordTypeId(ShippinManifestSupport.RECORD_TYPE_TRANSFER));
        recordTypeIds.add(ShippinManifestSupport.getTransferRecordTypeId(ShippinManifestSupport.RECORD_TYPE_LAB));
        recordTypeIds.add(Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_SERVICE).getRecordTypeId());
        recordTypeIds.add(Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_CASH_COLLECTION_RT).getRecordTypeId());
        
        return  [Select Brand_Quote__c,
                        Invoice__c,
                        Driver__c,
                        Vehicle__c,
                 		RecordTypeId,
                        Vehicle__r.Name,
                        Customer_PO_or_Quote__c,
                        Distributor_Contact__c,
                        Distributor_License__c,
                        Distributor_License__r.License_Status__c,
                        Distributor_License_Expiration_Date__c,
                        Distributor_Name__c,
                        Opportunity_Name__c,
                 		Order_Number__c,
                        Payment_Terms__c,
                        Picklist__c,
                        Planned_Ship_Transfer_Date__c,
                        Receiver_Contact__c,
                        Receiver_License__c,
                        Receiver_License__r.License_Status__c,
                        Receiver_License_Expiration_Date__c,
                        Receiver_Name__c,
                        Status__c,
                 		Sales_Order__c,
                        Sample_Order__c,
                        Shipping_Method__c,
                        Shipping_Terms__c,
                        Site__c,
                        Supplier_Contact__c,
                        Supplier_License__c,
                        Supplier_License__r.License_Status__c,
                        Supplier_License_Expiration_Date__c,
                        Supplier_Name__c,
                        Ship_Confirmation_Date__c,
                        Actual_Arrival_Date_Time__c,
                        Actual_Departure_Date_Time__c,
                        Receiver_Acceptance_Date__c, RecordType.Name,
                 		Picklist__r.Id,
                        Picklist__r.Status__c,
                        (Select Product_Name__c,
                                Product_Title__c,
                         		SMLine_Status__c,
                                Qty_Received__c,Shipment_Qty__c,
                                Retail_Wholesale_Price__c,
                                Picklist_Line__c,
                         		Picklist_Line__r.Sales_Order_Line__c,
                         		Picklist_Line__r.Sales_Order_Line__r.Sales_Order__c,
                                Picklist_Line__r.Inventory_Location__c,
                                Picklist_Line__r.Inventory_Position__r.Inventory_Location__c,
                                Picklist_Line__r.Inventory_Position__c,
                         		Picklist_Line__r.Pack_out_UID__c,
                                Picklist_Line__r.Inventory_Position__r.Site__c,
                                Name
                         From Shipping_Manifest_Lines__r 
                         WHERE SMLine_Status__c NOT IN (:RSMSupport.STATUS_CANCELLED, 
                                                         :RSMSupport.STATUS_REJECTED)
                        ORDER By Name)
                From Shipping_Manifest__c
                Where Id =:recordId  AND RecordTypeId IN :recordTypeIds];
    }
      
    
    
    
    
    
    
    
    
    
    /**
     * Perform validation of all required fields of RSM and Lines
     *
     * @return Boolean flag to indicate if any validation fails
     */
    public Boolean checkValidation(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        String missingFieldError = Label.RSM_Mandatory_Fields_Error + '<BR/>';
        
        if(cashCollectionRecordTypeId == rsmObj.RecordTypeId ){  if(rsmObj.Status__c == SHIPPING_MANIFEST_STATUS_DRAFT)
            {
                hasValidationError = true;missingFieldError += '<li>' + ERR_MSG_ASSIGN_DRIVER_AND_VEHICLE + '</li>';
              //missingFieldError += '<li> Please assign Driver and Vehicle to Complete Depart Confirm and try again to Ship Confirm </li>';

                
            }else if(rsmObj.Status__c == SHIPPING_MANIFEST_STATUS_PENDING){hasValidationError = true; missingFieldError += '<li>'+ ERR_MSG_COMPLETE_DEPART_CONFIRM +'</li>';
            }
            
        }else{
            
            if(  serviceRecordTypeId != rsmObj.RecordTypeId && productTSMRecordTypeId != rsmObj.RecordTypeId && rsmObj.Picklist__r.Status__c != PicklistSupport.STATUS_QA_CONFIRM){
                hasValidationError = true;
                missingFieldError += '<li>'+ ERR_MSG_COMPLETE_PICKLIST_QA_CONFIRM +'</li>';
            }
            
            if(rsmObj.Site__c == null){
                hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_SITE+'</li>';
            }
            
            if(serviceRecordTypeId != rsmObj.RecordTypeId && rsmObj.Brand_Quote__c == null){
                hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_BRAND_QUOTE+'</li>';
            }
            
            if(serviceRecordTypeId != rsmObj.RecordTypeId && rsmObj.Customer_PO_or_Quote__c == null){
                hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_CUSTOMER_PO_OR_QUOTE+'</li>';
            }
            
            if(serviceRecordTypeId != rsmObj.RecordTypeId && rsmObj.Opportunity_Name__c == null){
                hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_OPPORTUNITY_NAME+'</li>';
            }
            
            if( serviceRecordTypeId != rsmObj.RecordTypeId && rsmObj.Picklist__c == null){
                hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_PICKLIST+'</li>';
            }
            
            if(rsmObj.Shipping_Terms__c == null){
                hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_SHIPPING_TERMS+'</li>';
            }
            
            if(rsmObj.Shipping_Method__c == null){ hasValidationError = true; missingFieldError += '<li>'+ERR_MSG_SHIPPING_METHOD+'</li>';
            }
            
            if(rsmObj.Payment_Terms__c == null){hasValidationError = true;missingFieldError += '<li>'+ERR_MSG_PAYMENT_TERMS+'</li>';
            }
            
            if(rsmObj.Driver__c == null){
                hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_DRIVER+'</li>';
            }
            
            if(rsmObj.Vehicle__c == null){
                hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_VEHICLE+'</li>';
            }
            
            if(rsmObj.Distributor_Contact__c == null){
                hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_DISTRIBUTOR_CONTACT+'</li>';
            }
            
            // Validate Distributor license with status and expiration date
            // First check expiration date with actual departure date and time if it is not null
            // else check expiration date with planned ship date
            if(rsmObj.Distributor_License__c == null){
                hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_DISTRIBUTOR_LICENSE+'</li>';
            }else if(rsmObj.Distributor_License__r.License_Status__c != LICENSE_STATUS_ACTIVE){ hasValidationError = true;   missingFieldError += '<li>'+ERR_MSG_DISTI_LICENSE_ACTIVE+'</li>';
            }else if(rsmObj.Actual_Departure_Date_Time__c != null && 
                     rsmObj.Distributor_License_Expiration_Date__c < rsmObj.Actual_Departure_Date_Time__c){ hasValidationError = true;
                         missingFieldError += '<li>'+ERR_MSG_DISTI_LICENSE_ALREADY_EXIPIRED+'</li>';         
                     } 
            else if(rsmObj.Distributor_License_Expiration_Date__c < rsmObj.Planned_Ship_Transfer_Date__c){ hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_DISTI_LICENSE_ALREADY_EXIPIRED+'</li>'; 
            }
            
            if(rsmObj.Distributor_Name__c == null){
                hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_DISTI_DISTRIBUTOR_NAME+'</li>';
            }
            
            if(rsmObj.Supplier_Contact__c == null){
                hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_SUPPLIER_CONTACT+'</li>';
            }
            
         
            
            if(rsmObj.Supplier_Name__c == null){
                hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_SUPPLIER_NAME+'</li>';
            }
            
            if(rsmObj.Receiver_Contact__c == null){
                hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_RECEIVER_CONTACT+'</li>';
            }
            

            
            if(rsmObj.Receiver_Name__c == null){
                hasValidationError = true;
                missingFieldError += '<li>'+ERR_MSG_RECEIVER_NAME+'</li>';
            }
            
            // Validate fields for RSM Lines
         /*   for(Shipping_Manifest_Line__c rsmLineObj : rsmObj.Shipping_Manifest_Lines__r){
                if(rsmLineObj.Product_Name__c == null){
                    hasValidationError = true;
                    missingFieldError += '<li>Product Name of RSM Line ' + rsmLineObj.Name + '</li>';
                }
            
                
                if( serviceRecordTypeId != rsmObj.RecordTypeId && rsmLineObj.Picklist_Line__c == null){
                    hasValidationError = true;
                    missingFieldError += '<li>Picklist Line of RSM Line ' + rsmLineObj.Name + '</li>';
                }
                
                if(rsmLineObj.Retail_Wholesale_Price__c == null){
                    hasValidationError = true;
                    missingFieldError += '<li>Retail Wholesale Price of RSM Line ' + rsmLineObj.Name + '</li>';
                }
            
            }*/
            
        }
        if(hasValidationError){
            message = new ApexPages.Message(ApexPages.Severity.ERROR, missingFieldError);
          
            missingFieldError = missingFieldError.replace('<li>', ' ');
            missingFieldError = missingFieldError.replace('</li>', ', ');
            missingFieldError = missingFieldError.replace('<BR/>', ' ');
            missingFieldError = missingFieldError.subString(0,missingFieldError.Length()-2);
            errors.add(missingFieldError);
        }
        return hasValidationError;
    }
    
    /**
     * Update RSM and Lines
     * Update RSM status to Shipment Complete and Ship Confirmation Date as today and 
     * Update Shipment Qty of RSM line as Qty Received
     */         
    public void updateRSMAndLines() {
        IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED = False;
        
        List<Shipping_Manifest_Line__c> rsmLines = rsmObj.Shipping_Manifest_Lines__r;
        
        // Update RSM lines
        for(Shipping_Manifest_Line__c rsmLineObj : rsmLines){
            rsmLineObj.SMLine_Status__c = RSM_STATUS_SHIPMENT_COMPLETE;
            //rsmLineObj.Shipment_Qty__c = rsmLineObj.Qty_Received__c;
            rsmLineObj.Qty_Received__c = rsmLineObj.Shipment_Qty__c;
        }
        update rsmLines;
        
        rsmObj.Status__c = RSM_STATUS_SHIPMENT_COMPLETE;
        rsmObj.Ship_Confirmation_Date__c = System.Today();
        rsmObj.Actual_Arrival_Date_Time__c = Datetime.now();
        rsmObj.Receiver_Acceptance_Date__c = Datetime.now();
        update rsmObj;
        
        if(rsmObj.Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE ){
            if(rsmObj.Sales_Order__c != NULL){
                Sales_Order__c soData = new Sales_Order__c();
                soData.Id = rsmObj.Sales_Order__c;
                soData.SO_Status__c = SALES_ORDER_STATUS_SHIPPED;
                soData.Ship_Confirmation_Date__c = System.Today();
                Update soData;
            }
            
            if(rsmObj.Brand_Quote__c != NULL){
                Brand_Quote__c brandQuoteData = new Brand_Quote__c();
                brandQuoteData.Id = rsmObj.Brand_Quote__c;
                brandQuoteData.BQ_Status__c = BRAND_QUOTE_STATUS_SHIPPED;
                brandQuoteData.Ship_Confirmation_Date__c = System.Today();
                Update brandQuoteData;
            }
            
            if(rsmObj.Order_Number__c != NULL){ Order__c orderData = new Order__c();
                orderData.Id = rsmObj.Order_Number__c; orderData.Status__c = ORDER_STATUS_SHIPPED;
                Update orderData;
            }
            
        }

        List<Inventory_Position__c> invPositions;
        if(rsmObj.RecordType.Name == ShippinManifestSupport.RECORD_TYPE_TRANSFER){ invPositions = setInvPositionToDelivered(rsmLines, TRANSFERRED);
        }else if(rsmObj.RecordType.Name == ShippinManifestSupport.RECORD_TYPE_LAB){ invPositions = setInvPositionToDelivered(rsmLines, TEST_SAMPLED);
        }else{
            // Update Inventory Position - Inventory Location, Rack, Rack Level and Bin Location to Delivered
            invPositions = setInvPositionToDelivered(rsmLines, DELIVERED);
        }
        
        upsert invPositions;
        
        // Update inventory positions and SO lines related to RSM lines
        RSMSupport.updateInvPositionsAndSOLines(rsmLines, true);
        
    }
    
    /**
     * Set Inventory Position - Inventory Location, Rack, Rack Level and Bin Location to Delivered
     * @param rsmLines The list of RSM Lines
     * @param deliveredName The hard coded Delivered string
     *
     * @return The list of updated inventory positions
     */         
    public static List<Inventory_Position__c> setInvPositionToDelivered(List<Shipping_Manifest_Line__c> rsmLines,
                                                                        String deliveredName) {
        system.debug('rsmLines>>+'+rsmLines);
                                                                            system.debug('deliveredName>>+'+deliveredName);
        Set<Id> invPositionIds = new Set<Id>();
        List<Inventory_Position__c> invPositions = new List<Inventory_Position__c>();
        List<Inventory_Position__c> invPositionsToUpdate = new List<Inventory_Position__c>();
        Set<Id> siteIds = new Set<Id>();
        Map<Id, Id> invLocationIdBySiteId = new Map<Id, Id>();
        Map<Id, Id> rpInvLocationIdBySiteId = new Map<Id, Id>();
        Map<Id, Id> rackIdByInvLocationId = new Map<Id, Id>();
        Map<Id, Id> rackLevelIdByRackId = new Map<Id, Id>();
        Map<Id, Id> binLocationIdByRackLevelId = new Map<Id, Id>();
        Map<Id, Decimal> qtyReceivedByInvPosId = new Map<Id, Decimal>();
        
        Map<String,String> mapUid = new Map<String,String>();
                                                                            
        for(Shipping_Manifest_Line__c rsmLineObj : rsmLines){
            invPositionIds.add(rsmLineObj.Picklist_Line__r.Inventory_Position__c);
            siteIds.add(rsmLineObj.Picklist_Line__r.Inventory_Position__r.Site__c);
            
            qtyReceivedByInvPosId.put(rsmLineObj.Picklist_Line__r.Inventory_Position__c, rsmLineObj.Qty_Received__c != Null ? rsmLineObj.Qty_Received__c :0);
            
            if(rsmLineObj.Picklist_Line__r.Pack_out_UID__c != null && !mapUid.containsKey(rsmLineObj.Picklist_Line__r.Inventory_Position__c)){  mapUid.put(rsmLineObj.Picklist_Line__r.Inventory_Position__c, rsmLineObj.Picklist_Line__r.Pack_out_UID__c);
            }    
        }
        
                                                                           
        invPositions = [Select Site__c, 
                               Inventory_Location__c,
                               Rack__c,Harvest_Batch_Code__c,UID_New__c, 
                               Rack_Level__c, 
                               Bin_Location__c,
                               Qty_Allocated__c,
                               Qty_On_Hand__c,
                               Sales_Order_Line__c, 
                               Product_Name__c, 
                               Ownership__c, Receiving_Line__c, Harvest_Batch_or_Lot_Code__c,  
                               Lab_Test_Status__c, COA_Issued_Date__c, COA_Number__c, 
                               COA_Expiration_Date__c,Aged_Bucket__c
                               From Inventory_Position__c 
                               Where Id IN: invPositionIds];
                                                                            
            system.debug('invPositions>>'+invPositions);
        // Create map of Inventory location Id by Site Id
        for(Inventory_Location__c invLocation : [Select Name, Site_Name__c from Inventory_Location__c 
                                                 Where Site_Name__c IN: siteIds 
                                                 AND (Name =: deliveredName OR 
                                                      Name =: Label.Default_Inventory_Location)]){
            if(invLocation.Name == deliveredName){
                invLocationIdBySiteId.put(invLocation.Site_Name__c, invLocation.Id);
            }else if(invLocation.Name == Label.Default_Inventory_Location){
                rpInvLocationIdBySiteId.put(invLocation.Site_Name__c, invLocation.Id);
            } 
        }
        
                                                                          
        // Create map of rack Id by Inventory location Id
        for(Rack__c rackSO : [Select Inventory_Location__c from Rack__c Where Inventory_Location__c IN: invLocationIdBySiteId.values() AND Name =: deliveredName]){
            rackIdByInvLocationId.put(rackSO.Inventory_Location__c, rackSO.Id);
        }
                                                                             
        
        // Create map of rack level Id by rack Id
        for(Rack_Level__c rackLevelSO : [Select Rack__c from Rack_Level__c Where Rack__c IN: rackIdByInvLocationId.values() AND Name =: deliveredName]){
            rackLevelIdByRackId.put(rackLevelSO.Rack__c, rackLevelSO.Id);
        }
        
                                                                              
        // Create map of bin location Id by rack level Id
        for(Bin_Location__c binLocationSO : [Select Rack_Level__c from Bin_Location__c Where Rack_Level__c IN: rackLevelIdByRackId.values() AND Name =: deliveredName]){
            binLocationIdByRackLevelId.put(binLocationSO.Rack_Level__c, binLocationSO.Id);
        }
                                                                              
        
        // Update inventory positions
        Decimal actualQtyReceived;
                   system.debug('invPositions>>>'+invPositions);                                                         
        for(Inventory_Position__c invPosition : invPositions){
            
             actualQtyReceived = qtyReceivedByInvPosId.get(invPosition.Id);
            
            if(actualQtyReceived==0 && invPosition.Qty_Allocated__c==0)
            {
                invPosition.Inventory_Location__c = rpInvLocationIdBySiteId.get(invPosition.Site__c);
                invPosition.Rack__c = null;
                invPosition.Rack_Level__c = null;
                invPosition.Bin_Location__c =null;
            }else{
                invPosition.Inventory_Location__c = invLocationIdBySiteId.get(invPosition.Site__c);
                invPosition.Rack__c = rackIdByInvLocationId.get(invPosition.Inventory_Location__c);
                invPosition.Rack_Level__c = rackLevelIdByRackId.get(invPosition.Rack__c);
                invPosition.Bin_Location__c = binLocationIdByRackLevelId.get(invPosition.Rack_Level__c);
                 invPosition.Aged_Bucket__c = invPosition.Aged_Bucket__c;
            }

            // If actual qty received is not same as qty allocated then split the inventory position
            // Create new inventory position with balance qty and put it into put away screen
            // Existing inventory will be updated as actual qty received and mark as delivered
            if(ShippingManifestLineTriggerHandler.isSmlineRejectFromSmComple== false && ShippingManifestLineTriggerHandler.isSmlineRejToSmComple == false && ShippingManifestHandler.internsmStatusCancelledToComplete == false)
            {
                if(actualQtyReceived != invPosition.Qty_Allocated__c   ){
                    // Create new inventory position for partial qty  
                    Inventory_Position__c cloneInventoryPositionSO = invPosition.clone(false, true);
                    cloneInventoryPositionSO.Qty_Allocated__c = 0;
                    if(mapUid.containsKey(invPosition.Id)){ invPosition.UID_New__c = mapUid.get(invPosition.Id);    
                                                          }
                    cloneInventoryPositionSO.Harvest_Batch_Code__c = invPosition.Harvest_Batch_Code__c;
                    cloneInventoryPositionSO.Qty_On_Hand__c = invPosition.Qty_Allocated__c - actualQtyReceived;
                    cloneInventoryPositionSO.Rack__c = null;
                    cloneInventoryPositionSO.Rack_Level__c = null;
                    cloneInventoryPositionSO.Bin_Location__c = null;
                    cloneInventoryPositionSO.Sales_Order_Line__c = null;
                    cloneInventoryPositionSO.Aged_Bucket__c = invPosition.Aged_Bucket__c;
                    cloneInventoryPositionSO.Inventory_Location__c = rpInvLocationIdBySiteId.get(invPosition.Site__c);
                    invPositionsToUpdate.add(cloneInventoryPositionSO);
                }
            }
            
            

            
            if(actualQtyReceived!=0 && invPosition.Qty_Allocated__c!=0)
            {
                invPosition.Qty_Allocated__c = actualQtyReceived;
            }
            
            if(ShippingManifestLineTriggerHandler.isSmlineRejToSmComple== True  || ShippingManifestHandler.internsmStatusCancelledToComplete == True){
                 invPosition.Qty_Allocated__c = actualQtyReceived;
                invPosition.Qty_On_Hand__c = 0;
            }
            
            invPositionsToUpdate.add(invPosition);
        }
                                                                           
                                                                            
        return invPositionsToUpdate;
    }
    
    public PageReference redirectToRSM() {
        PageReference pageRef = stdController.view().setRedirect(true);
        return pageRef;
    }
    
    
    
    /** 
    * Ship Confirm Console  - Internal Ship confirm Lightning
    * RSM Line - Recevied QTY EDIT OPTION
    * 
    */

    // Constructor
    @AuraEnabled
    public static AuraResponse getSmLines(String recordId, String smId, String invoiceId){ 
        
        AuraResponse r = new AuraResponse('CancelRsm.getSmLines()'); 
        ShipConfirmController assign = new ShipConfirmController();
        assign.setSM = getShipMan(recordId);
        
        Shipping_Manifest__c getRecordType = [SELECT RecordType.Name FROM Shipping_Manifest__c where  Id =: recordId];
        if(getRecordType.RecordType.Name!= SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION || getRecordType.RecordType.Name!= SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM ){
            assign.invoiceDt = getinvoiceDetail(recordId); 
        }else{
            assign.invoiceDt =null;
        }
        
        
        assign.setRsmLines = getRsmLines(recordId); 
        r.data.put('setSM', assign.setSM);
        r.data.put('invoiceDt', assign.invoiceDt);
        r.data.put('setRsmLines', assign.setRsmLines);
        string SMLI_Rejection_Reason_Validation_Config = FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SMLI_Rejection_Reason_Validation_Config');
        
        r.data.put('SMLI_Rejection_Reason_Validation_Config', SMLI_Rejection_Reason_Validation_Config != null ? SMLI_Rejection_Reason_Validation_Config : '');        
        return r; 
    } 
    
	// Retrieve Shipmainfest Detail
	public static Shipping_Manifest__c getShipMan(String recordId){
        
    	Shipping_Manifest__c shipManLines = [Select Sales_Order__c,Sales_Order__r.Id,Sales_Order__r.Name, Site__r.Name, Name, Payment_Terms__c, Window_Start_End__c, Priority__c, Receiver_Contact__r.Name,Receiver_Name__r.Name, Supplier_Name__c,Receiver_Name__c,Distributor_Name__r.Name,Distributor_Name__c,
        	Metrc_Manifest__c, Status__c,Customer_PO_or_Quote__c,Site__r.Id,Planned_Ship_Transfer_Date__c,RecordType.Name,Supplier_Name__r.Name,Supplier_Name__r.Id,Picklist__r.Name,Picklist__r.Id,Order_Number__r.Id,Supplier_Name__r.DBA__c,Receiver_Name__r.DBA__c,
            Distributor_Name__r.DBA__c,Driver__c,Vehicle__c  From Shipping_Manifest__c where  Id =: recordId];
        return shipManLines;
    }
    
    // Retrieve Invoice Detail
	public static List<Invoice__c> getinvoiceDetail(String recordId){
        
    	Shipping_Manifest__c shipManLines = [Select Sales_Order__c From Shipping_Manifest__c where  Id =: recordId];
        Id salesorderId = shipManLines.Sales_Order__c;
        List<Invoice__c> invoiceDetail = [Select Id,Name From Invoice__c where  Sales_Order__c =: salesorderId];
        if(invoiceDetail.size() > 0){
            return invoiceDetail;
        }else{
            return null;
        }
        
    }
    
    
    //RSM Line Wrapper 
    public class rsmlinesWrapper{
        @AuraEnabled 
        public Shipping_Manifest_Line__c rsmlinesIL {get; set;}
        public rsmlinesWrapper(Shipping_Manifest_Line__c rsmlinesIL){
            this.rsmlinesIL = rsmlinesIL;
        }
        public rsmlinesWrapper(){ this.rsmlinesIL = rsmlinesIL;
        }
    }
    
    //RSM Line Instance Wrapper Class
    public static List<rsmlinesWrapper>  getRsmLinesOLD(Id recordID){ 
        List<rsmlinesWrapper> rsmLnWrapper = new List<rsmlinesWrapper>();
        List<Shipping_Manifest_Line__c> ShippingManifestLineValue = [SELECT Id, Name, Product_Name__r.Name, Shipping_Manifest__r.Name,Product_Description__c,Producer_Name__c,Product_Name__c,
                                                                     Retail_Wholesale_Price__c,Shipment_Qty__c,Rejection_Reason__c,Shipping_Manifest__r.Customer_PO_or_Quote__c,Shipping_Manifest__r.Status__c, Shipping_Manifest__r.Picklist__c,Shipping_Manifest__r.Site__c,
                                                                     Qty_Received__c,Picklist_Line__r.Name,Picklist_Line__r.Inventory_Position__c,Picklist_Line__r.Sales_Order_Line__c,Picklist_Line__r.Id,Picklist_Line__r.Inventory_Position__r.Site__c,Picklist_Line__r.Inventory_Position__r.Id,Sales_Order_Line__r.Name,Sales_Order_Line__r.Id,Sales_Order_Line__r.Sales_Order__c,Sales_Order_Line__r.RecordTypeId,Picklist_Line__c,Sales_Order_Line__c,Line_Total_Price__c,SMLine_Status__c,RecordTypeId
                                                                     FROM Shipping_Manifest_Line__c WHERE (SMLine_Status__c!= 'Rejected' AND SMLine_Status__c!= 'Shipment Complete' ) AND Shipping_Manifest__c =:recordID];
        for(Shipping_Manifest_Line__c rsmres : ShippingManifestLineValue){
            rsmlinesWrapper inLinersmlineWrapper = new rsmlinesWrapper(rsmres);
            rsmLnWrapper.add(inLinersmlineWrapper);
        }
        return rsmLnWrapper;
    }
    
     // rsm lines instance  Wrapper Class
    public static List<rsmlinesWrapper>  getRsmLines(Id recordID){ 
        // RSM Lines
        List<rsmlinesWrapper> rsmLnWrapper = new List<rsmlinesWrapper>();
        List<Shipping_Manifest_Line__c> ShippingManifestLineValue = [ SELECT ID, Name, Product_Name__r.Name, Shipping_Manifest__r.Name,Purchase_Order_Line__c,
                                                                     Product_Description__c,Producer_Name__c,Retail_Wholesale_Price__c,Actual_Shipment_Qty__c,
                                                                     Shipment_Qty__c,Rejection_Reason__c, Qty_Received__c,Sales_Order_Line__r.Name,
                                                                     Picklist_Line__r.Inventory_Position__c,Picklist_Line__r.Inventory_Position__r.Site__c,Picklist_Line__r.Name,
                                                                     SMLine_Status__c,Product_Name__c,Picklist_Line__c,Picklist_Line__r.Sales_Order_Line__r.Sales_Order__c,
                                                                     Picklist_Line__r.Sales_Order_Line__c,Sales_Order_Line__c,Picklist_Line__r.Pack_out_UID__c,Qty_Ordered__c,
                                                                     Unit_Cost__c FROM Shipping_Manifest_Line__c WHERE SMLine_Status__c NOT IN (:SHIPPING_MANIFEST_LINE_STATUS_CANCELLED,:SHIPPING_MANIFEST_LINE_STATUS_REJECTED) AND  
                                                                     Shipping_Manifest__c =:recordID ];
        for(Shipping_Manifest_Line__c rsmres : ShippingManifestLineValue){  
            rsmlinesWrapper inLinersmlineWrapper = new rsmlinesWrapper(rsmres); 
            rsmLnWrapper.add(inLinersmlineWrapper);
        }
        return rsmLnWrapper;
    }
    
    
    
     @AuraEnabled
    public static AuraResponse updateShipmentConfirm( List<rsmlinesWrapper> setRsmLines,  String smRtypeName, String recordId){
        AuraResponse r = new AuraResponse('ShipConfirmController.updateShipmentConfirm()');
        ShipConfirmController assigns = new ShipConfirmController(); 
     	IS_INTERNALSTATUSCHANGE_TRIGGER_ENABLED = False;
        SavePoint savePoint;
        
        try{
            // Define Savepoint for rollback
            savePoint = Database.setSavepoint();
            RSMTSMShipConfirmCotroller assign = new RSMTSMShipConfirmCotroller();
            Set<Id> shipManifest =new Set<Id>(); List<Shipping_Manifest_Line__c> allRSMLines = new List<Shipping_Manifest_Line__c>();  
            List<Shipping_Manifest_Line__c> rsmLinesToUpdates = new List<Shipping_Manifest_Line__c>();
            Id extaxRecordTypeId = Schema.SObjectType.Receive_Payment__c.getRecordTypeInfosByName().get('Excise Tax').getRecordTypeId();
            Id smRecordtypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(smRtypeName).getRecordTypeId();
            Shipping_Manifest_Line__c  rsmSOLines = new Shipping_Manifest_Line__c();
            String RSM_STATUS_SHIPMENT_COMPLETE =SHIPPING_MANIFEST_STATUS_COMPLETE; 
            if(smRtypeName== SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM) {  RSM_STATUS_SHIPMENT_COMPLETE = SHIPPING_MANIFEST_STATUS_RECEIVED;
            } 
            
            Set<ID> opCId = new Set<ID>();Boolean allSMLinesCancelled = true;
            Integer fullRejectCount = 0;  Boolean fullReject = false;
            List<Shipping_Manifest_Line__c> shippingMLineList = new List<Shipping_Manifest_Line__c>();
            for (rsmlinesWrapper res :setRsmLines){  Shipping_Manifest_Line__c invObj=res.rsmlinesIL;
               
                invObj.SMLine_Status__c = RSM_STATUS_SHIPMENT_COMPLETE;  invObj.Actual_Shipment_Qty__c  =  invObj.Shipment_Qty__c;         
                if((invObj.Qty_Received__c == 0.0 || invObj.Qty_Received__c == null ) && (smRtypeName!=SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM || smRtypeName!=SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION)) {   
                    invObj.SMLine_Status__c = SHIPPING_MANIFEST_LINE_STATUS_REJECTED;
                } else{
                    /* New line for 101 issue fix - Process Builder - Map SML Qty Received to POLI Qty Ordered */
                   invObj.SMLine_Status__c = SHIPPING_MANIFEST_STATUS_COMPLETE; 
                }
                
                if(smRtypeName ==SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM){  invObj.Qty_Received__c =  invObj.Qty_Ordered__c;
                }
                if(smRtypeName == SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION){   invObj.Qty_Received__c =  invObj.Qty_Received__c;
                   
                }                
                if(invObj.Qty_Received__c == 0.0){  fullRejectCount++;
                }
                
                shipManifest.add(invObj.Shipping_Manifest__c); shippingMLineList.add(invObj);
            }
            
            if(shippingMLineList.size() > 0){ update shippingMLineList; 
                if(shippingMLineList.size() == fullRejectCount){fullReject = true;
                }
            }
            
            
            if(shipManifest.size() > 0){ List<Shipping_Manifest__c> updateShippingManifest = [SELECT RecordTypeId,Id, Name, Status__c,Actual_Receiver_Name__c,Ship_Confirmation_Date__c,Actual_Arrival_Date_Time__c,Actual_Departure_Date_Time__c,Receiver_Acceptance_Date__c,Receiver_Contact__r.Name,Brand_Quote__c,Order_Number__c,Sales_Order__c, Slack_Notes__c FROM Shipping_Manifest__c WHERE Id =: shipManifest];
                
                for(Shipping_Manifest__c newshipManifest : updateShippingManifest){
                    if(fullReject){ newshipManifest.Status__c = SHIPPING_MANIFEST_STATUS_REJECTED;
                    }else{
                         newshipManifest.Status__c = RSM_STATUS_SHIPMENT_COMPLETE;
                    }
                   
                    newshipManifest.Ship_Confirmation_Date__c = System.Today();
                    newshipManifest.Actual_Arrival_Date_Time__c = Datetime.now();newshipManifest.Receiver_Acceptance_Date__c = Datetime.now();
                 
                }
                if(updateShippingManifest.size() > 0)   update updateShippingManifest;
                 
                
                                        
			if(smRtypeName != SHIPPING_MANIFEST_RECORDTYPE_CASH_COLLECTION){        
                
                     List<Invoice__c> InvList = [select id, Name, Shipping_Manifest__c  from Invoice__c where Sales_Order__c =: updateShippingManifest[0].Sales_Order__c];
                
                    for(Invoice__c inv : InvList){  inv.Shipping_Manifest__c = updateShippingManifest[0].Id;
                    }
                    update InvList;
                
                
                // new code for 101 Update - PB -> SM Ship Confirmation Date to Related Objects V1.2  - Start
                if(updateShippingManifest[0].Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE )
                {
                    if(updateShippingManifest[0].Brand_Quote__c != NULL){  Brand_Quote__c brandQuoteData = new Brand_Quote__c();
                        brandQuoteData.Id = updateShippingManifest[0].Brand_Quote__c;   
                        brandQuoteData.BQ_Status__c = BRAND_QUOTE_STATUS_SHIPPED;
                        brandQuoteData.Ship_Confirmation_Date__c = System.Today();
                        Update brandQuoteData;
                    }
                    
                    if(updateShippingManifest[0].Order_Number__c != NULL){
                        Order__c orderData = new Order__c();
                        orderData.Id = updateShippingManifest[0].Order_Number__c;
                        orderData.Status__c = ORDER_STATUS_SHIPPED;
                        Update orderData;
                    }
                    
                    if(updateShippingManifest[0].Sales_Order__c != NULL){ Sales_Order__c soData = new Sales_Order__c();
                        soData.Id = updateShippingManifest[0].Sales_Order__c;
                        soData.SO_Status__c = SALES_ORDER_STATUS_SHIPPED;
                        soData.Ship_Confirmation_Date__c = System.Today(); Update soData;
                        
                    }
                    


            }if(updateShippingManifest[0].Status__c == SHIPPING_MANIFEST_STATUS_REJECTED)
            {
                
                Brand_Quote__c brandQuoteData = new Brand_Quote__c();
                brandQuoteData.Id = updateShippingManifest[0].Brand_Quote__c; brandQuoteData.BQ_Status__c = BRAND_QUOTE_STATUS_REJECTED;
                brandQuoteData.Ship_Confirmation_Date__c = System.Today();                Update brandQuoteData;
                Purchase_Order__c pores = [Select Id,PO_Status__c,Brand_Quote__c From Purchase_Order__c where Brand_Quote__c=:updateShippingManifest[0].Brand_Quote__c];  pores.PO_Status__c = PURCHASE_ORDER_STATUS_REJECTED;Update pores;
                
                Order__c orderData = new Order__c(); orderData.Id = updateShippingManifest[0].Order_Number__c;
                orderData.Status__c = ORDERCANCELLED_CUSTOMER; Update orderData;
                
            }
               // new code for 101 Update SM Ship Confirmation Date to Related Objects V1.2  - End

                if(shippingMLineList.size() > 0 && smRtypeName!= SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM){String STATUS_CANCELLED = SHIPPING_MANIFEST_STATUS_CANCELLED;
                    
                    // Update RSM Lines for ship confirm - Line Items having non zero qty to receive
                    for(Shipping_Manifest_Line__c rsmLineSO : shippingMLineList){ if(rsmLineSO.Shipment_Qty__c != 0.0 && rsmLineSO.SMLine_Status__c != SHIPPING_MANIFEST_STATUS_CANCELLED ){ rsmLinesToUpdates.add(rsmLineSO);
                        }
                    }
                    
                    updateInventoryPosition(JSOn.serialize(rsmLinesToUpdates),smRecordtypeId);
                    // Update inventory positions and SO lines related to RSM lines
                    RSMSupport.updateInvPositionsAndSOLines(shippingMLineList, allSMLinesCancelled);
                }
                 
              }         
               
		}           
        }catch(Exception ex){ Database.rollback(savePoint); r.errors.add( SHIPPING_MANIFEST_EXCEPTION_ERROR_UPDATING_RSM_TSM + ex.getMessage());
        }
        return r;
    }
    
    @testVisible
    @future
    public static void updateInventoryPosition(String rsmLinesDataToUpdates, Id rTypeId){
        
        List<Shipping_Manifest_Line__c> rsmLinesToUpdates = (List<Shipping_Manifest_Line__c>)JSON.deserialize(rsmLinesDataToUpdates, List<Shipping_Manifest_Line__c>.class);
        List<Inventory_Position__c> invPositionsObj = new List<Inventory_Position__c>();
        
        if(rTypeId == ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER)){ invPositionsObj = ShipConfirmController.setInvPositionToDelivered(rsmLinesToUpdates,SHIPPING_MANIFEST_RECORDTYPE_TRANSFFERED);
            
        }else if(rTypeId == ShippinManifestSupport.getTransferRecordTypeId(SHIPPING_MANIFEST_RECORDTYPE_LAB)){ invPositionsObj = ShipConfirmController.setInvPositionToDelivered(rsmLinesToUpdates,SHIPPING_MANIFEST_RECORDTYPE_TEST_SAMPLED);
        }else{
            
            // Update inventory position to update with Delivered
            invPositionsObj = ShipConfirmController.setInvPositionToDelivered(rsmLinesToUpdates,SHIPPING_MANIFEST_RECORDTYPE_DELIVERED);
        }
        upsert invPositionsObj;
        
    }

    
 
    
     @AuraEnabled
    public static AuraResponse updateBqAndOrderLineItems(Id soId) { 
        
        AuraResponse r = new AuraResponse('updateBqAndOrderLineItems()'); 
        RSMTSMShipConfirmCotroller assign = new RSMTSMShipConfirmCotroller();
        List<Sales_Order__c> soRes = new List<Sales_Order__c>();
        List<Sales_Order_Line__c> items = new List<Sales_Order_Line__c>();
        Map<Id,Brand_Quote_Line__c> BQLineMap = new Map<Id,Brand_Quote_Line__c>();
        Set<Id> SOLIds = new Set<Id>(); Set<Id> bqId = new Set<Id>();
         Set<Id> bqLineIds = new Set<Id>();
        soRes = [SELECT Id, Name,Brand_Quote__c,(SELECT Id, Name,Brand_Quote_Line__c, Status__c,Qty_Ordered__c,MOQ__c FROM Sales_Order_Lines__r)  FROM Sales_Order__c WHERE Id=: soId ];
        
        for(Sales_Order__c sRes : soRes){  bqId.add(sRes.Brand_Quote__c); for(Sales_Order_Line__c sli : sRes.Sales_Order_Lines__r){ 
                BQLineMap.put(sli.Brand_Quote_Line__c,new Brand_Quote_Line__c(Id = sli.Brand_Quote_Line__c,Status__c = sli.Status__c,Quantity_Cases__c = sli.Qty_Ordered__c/sli.MOQ__c));  
                SOLIds.add(sli.Id);bqLineIds.add(sli.Brand_Quote_Line__c);
            }
        }

        if(SOLIds.size() > 0){ items = [SElECT Status__c,Qty_Ordered__c,MOQ__c,Qty_Allocated__c, Balance_Qty_to_Allocate__c ,Brand_Quote_Line__c, Sales_Order__c  FROM Sales_Order_Line__c WHERE Id IN: SOLIds AND Sales_Order__r.SO_Status__c =: SO_STATUS_DRAFT];
            List<Brand_Quote_Line__c> BQLToUpdate = new List<Brand_Quote_Line__c>();
            for(Sales_Order_Line__c sli: items){ Brand_Quote_Line__c bql = new Brand_Quote_Line__c();
                if(sli.Brand_Quote_Line__c != null){ bql = new Brand_Quote_Line__c(Id = sli.Brand_Quote_Line__c,Quantity_Cases__c=sli.Qty_Ordered__c/sli.MOQ__c);  
                }
                if(bql != null && bql.Id != null){  BQLineMap.put(sli.Brand_Quote_Line__c,bql);    
                }
                
            }
            
            if(BQLineMap.size() > 0){update BQLineMap.values();
            }
            
            
            List<Purchase_Order_Line__c> polineList = new List<Purchase_Order_Line__c>();
            List<Purchase_Order_Line__c> polineToUpdate = new List<Purchase_Order_Line__c>();
            polineList= [select Id,Brand_Quote_Line__c,Brand_Quote_Line__r.Line_Total_Qty__c  from Purchase_Order_Line__c where Brand_Quote_Line__c IN:bqLineIds];
                              if(polineList.size()>0 ){for(Purchase_Order_Line__c po: polineList){ 
                                  Purchase_Order_Line__c poids = new Purchase_Order_Line__c();
                                  poids.Id = po.Id;
                                  poids.Qty_Ordered__c =  po.Brand_Quote_Line__r.Line_Total_Qty__c;
                                  polineToUpdate.add(poids);

                              }
                             if(polineToUpdate.size() >0) {    update polineToUpdate;  
                                                                                    }
                                                      }
                              
                             }
        
        
        
        return r; 
        
    }
    
        
}