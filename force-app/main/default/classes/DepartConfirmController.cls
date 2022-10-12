/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * DepartConfirmController
 */
public class DepartConfirmController{
        public static String errorMessage;
    public static List<string> errorslt;
        private static final String STATUS_RECEIVED = TSMSupport.STATUS_RECEIVED; 

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
    public Static String SHIPPING_MANIFEST_RECORDTYPE_TRANSFER{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER) ? SHIPPING_MANIFEST_RECORDTYPE_TRANSFER: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_Transfer');
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
    private Static String SHIPPING_MANIFEST_LINE_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_LINE_STATUS_CANCELLED) ? SHIPPING_MANIFEST_LINE_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Cancelled');
        }set;
    }
     public Static String ERR_MSG_ASSIGN_DRIVER_AND_VEHICLES{
        get{
            return String.isNotBlank(ERR_MSG_ASSIGN_DRIVER_AND_VEHICLES) ? ERR_MSG_ASSIGN_DRIVER_AND_VEHICLES: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_assign_Driver_And_Vehicle');
        }set;
    }
     private Static String SHIPPING_MANIFEST_STATUS_DRAFT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_DRAFT) ? SHIPPING_MANIFEST_STATUS_DRAFT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Draft');
        }set;
    }
     private Static String ERR_MSG_ALREADY_PENDING_STATUS{
        get{
            return String.isNotBlank(ERR_MSG_ALREADY_PENDING_STATUS) ? ERR_MSG_ALREADY_PENDING_STATUS: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_SM_Already_Pending');
        }set;
    }
     public Static String ERR_MSG_ALREADY_COMPLETE_STATUS{
        get{
            return String.isNotBlank(ERR_MSG_ALREADY_COMPLETE_STATUS) ? ERR_MSG_ALREADY_COMPLETE_STATUS: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_SM_Already_Complete');
        }set; 
    }
     public Static String SHIPPING_MANIFEST_STATUS_REJECT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_REJECT) ? SHIPPING_MANIFEST_STATUS_REJECT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Rejected');
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
      public Static String SHIPPING_MANIFEST_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_CANCELLED) ? SHIPPING_MANIFEST_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Cancelled');
        }set;
    }
        public Static String ERR_MSG_TSM_RECEIVED{
        get{
            return String.isNotBlank(ERR_MSG_TSM_RECEIVED) ? ERR_MSG_TSM_RECEIVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_Msg_TSM_Already_Received');
        }set;
    }
    private ApexPages.StandardController stdController;
    private Shipping_Manifest__c rsmObj = null;
    public List<String> errors {get;set;}
    
    @testVisible
    private static final String RSM_STATUS_SHIPMENT_COMPLETE = SHIPPING_MANIFEST_STATUS_COMPLETE; 
    @testVisible
    private static final String RSM_STATUS_PENDING_DELIVERY = SHIPPING_MANIFEST_STATUS_PENDING_DELIVERY;
    Id productTSMRecordTypeId;
    Id serviceRecordTypeId;
    Id transferRecordTypeId;
    Id cashCollectionRecordTypeId;
    
    // Constructor
    public DepartConfirmController(ApexPages.StandardController controller) {
        this.stdController = controller;
        errors = new List<String>();
        rsmObj = (Shipping_Manifest__c)stdController.getRecord();
        productTSMRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM).getRecordTypeId();
        serviceRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_SERVICE).getRecordTypeId();
        transferRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER).getRecordTypeId();
        cashCollectionRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_CASH_COLLECTION_RT).getRecordTypeId();

    }
    
    public class UserException extends Exception{ }
  public DepartConfirmController()
  {
     
  }
  
    @AuraEnabled
    public static AuraResponse departConfirmlt (String recordId) {
        
        AuraResponse r = new AuraResponse('departConfirm()');
        DepartConfirmController assign = new DepartConfirmController();
        Savepoint savePoint;
        try {
           if(Test.isRunningTest()){ 
            savePoint = Database.setSavepoint();
            errorslt = new List<String>();  
            assign.productTSMRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM).getRecordTypeId();
            assign.serviceRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_SERVICE).getRecordTypeId();
            assign.transferRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_TRANSFER).getRecordTypeId();
            assign.cashCollectionRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_CASH_COLLECTION_RT).getRecordTypeId();
            Shipping_Manifest__c sm = [select id,Purchase_Order__c,Purchase_Order__r.Supplier_Name__r.Hold__c ,Purchase_Order__r.Receiver_Name__r.Hold__c,Purchase_Order__r.Distributor_Name__r.Hold__c,Purchase_Order__r.Supplier_Name__r.DBA__c ,Purchase_Order__r.Receiver_Name__r.DBA__c,Purchase_Order__r.Distributor_Name__r.DBA__c ,Picklist__c,Invoice__c,Payment_Terms__c from  Shipping_Manifest__c where id  =:recordId];
            
            if(sm.Picklist__c != null){ 
                picklist__c pick = [select id ,Sales_Order__c from  picklist__c where id  =: sm.Picklist__c];
                
                
                Sales_Order__c SOHold = [select id,Supplier_Name__c ,Receiver_Name__c,Distributor_Name__c,Account_Hold_Exception__c, (select id, Sales_Order__c from picklists__r)  from Sales_Order__c where id =: pick.Sales_Order__c];  
                Account  supAcc = [SELECT  id , Hold__c, DBA__c  from Account  where id =:SOHold.Supplier_Name__c];
                Account  recAcc = [SELECT  id , Hold__c, DBA__c  from Account  where id =:SOHold.Receiver_Name__c];
                Account  disAcc = [SELECT  id , Hold__c, DBA__c  from Account  where id =:SOHold.Distributor_Name__c];
                
                String accountName = '';
                Set<String> my_list = new Set<String>();
                if((supAcc.Hold__c == true || recAcc.Hold__c == true || disAcc.Hold__c == true) && SOHold.Account_Hold_Exception__c == false)
                {
                    if(supAcc.Hold__c == true){
                        my_list.add(supAcc.DBA__c);
                    }
                    if(disAcc.Hold__c == true){
                        my_list.add(disAcc.DBA__c);
                    }
                    if(recAcc.Hold__c == true){  my_list.add(recAcc.DBA__c);
                       
                    }
                    accountName = String.join(new List<String>(my_list), ', '); 
                    String ErrorMessage = 'Account: '+ accountName + ' is on HOLD. Please check with Finance team.';
                    errorslt.add(ErrorMessage);
                    return null;    
                    
                }
            }
               else if(sm.Purchase_Order__c != null){
                List<String> holdAccounts = new List<String>();
                if(sm.Purchase_Order__r.Supplier_Name__r.Hold__c == true || sm.Purchase_Order__r.Receiver_Name__r.Hold__c == true || sm.Purchase_Order__r.Distributor_Name__r.Hold__c == true){
                    if(sm.Purchase_Order__r.Supplier_Name__r.Hold__c == true){
                        holdAccounts.add(sm.Purchase_Order__r.Supplier_Name__r.DBA__c);
                    }
                    if(sm.Purchase_Order__r.Receiver_Name__r.Hold__c == true){
                        holdAccounts.add(sm.Purchase_Order__r.Receiver_Name__r.DBA__c);
                    }
                    if(sm.Purchase_Order__r.Distributor_Name__r.Hold__c == true){
                        holdAccounts.add(sm.Purchase_Order__r.Distributor_Name__r.DBA__c);
                    }
                    String accountNames = String.join(new List<String>(holdAccounts), ', '); 
                    String ErrorMessage = 'Account: '+ accountNames + ' is on HOLD. Please check with Finance team.';
                    errorslt.add(ErrorMessage);
                    return null;    
                }
            }
           }
            assign.rsmObj= assign.retrieveRSMAndLineslt(recordId) ;
               Boolean hasValidationError = false;
             
            if(assign.checkValidation()){ 
                r.data.put('messagelightning', errorMessage);
                return r;
            }
          
            assign.updateRSMAndInvPostions(); 
            
            List<Shipping_Manifest__c>SMList = [SELECT Id,Brand_Quote__c FROM Shipping_Manifest__c WHERE Id =: recordId];
            List<Brand_Quote__c>BQList = [SELECT Id,(SELECT Id FROM Purchase_Orders__r) FROM Brand_Quote__c WHERE Id =: SMList[0].Brand_Quote__c];
            if(BQList.size() > 0){
            	for(Purchase_Order__c PO : BQList[0].Purchase_Orders__r){
                    PO.Flash_Title_Date__c = system.now();
            	}   
                update BQList[0].Purchase_Orders__r;
            }
            
        }catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('DepartConfirmController:departConfirm()', ex.getStackTraceString(), ex.getMessage());
            return r;
        }
        return r;
    }
    public  Boolean checkValidation(){
        
        Boolean hasValidationError = false;
        // Check validation if RSM status is not Shipment Complete and Pending delivery
        if(rsmObj.Status__c == SHIPPING_MANIFEST_STATUS_COMPLETE){
            errorMessage = ERR_MSG_ALREADY_COMPLETE_STATUS;
            hasValidationError = true;  
        }else if(rsmObj.Status__c == SHIPPING_MANIFEST_STATUS_PENDING_DELIVERY){
            errorMessage = ERR_MSG_ALREADY_PENDING_STATUS;
            hasValidationError = true;
            // Check if Departure Date and Time is already provided or not QA Review
        }  
       else if(rsmObj.Status__c == SHIPPING_MANIFEST_STATUS_DRAFT){
            errorMessage = ERR_MSG_ASSIGN_DRIVER_AND_VEHICLES;
            hasValidationError = true;
            
        }else if(rsmObj.Status__c == SHIPPING_MANIFEST_STATUS_REJECT){ errorMessage = ERR_MSG_REJECT; 
            
            hasValidationError = true;
            
        }else if(rsmObj.Status__c == SHIPPING_MANIFEST_STATUS_CANCELLED){  errorMessage = ERR_MSG_CANCELLED;
           
            hasValidationError = true;
            
        }else if(rsmObj.Actual_Departure_Date_Time__c != null){
            errorMessage = Label.Departure_Date_Already_Provided;
            hasValidationError = true;
            
        }
       
        
        return hasValidationError;
    } 
    /**
     * Change Status to RSM status, Actual Departure time of RSM
     * Change Inv Location, Rack, Rack Level and Bin Location of Inv Position as vehicle name
     *
     * @return PageReference of RSM detail page
     */
    public PageReference departConfirm() {
        PageReference pageRef = null;
        Savepoint savePoint;
        
        try {
            
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            Shipping_Manifest__c sm = [select id,Purchase_Order__c,Purchase_Order__r.Supplier_Name__r.Hold__c ,Purchase_Order__r.Receiver_Name__r.Hold__c,Purchase_Order__r.Distributor_Name__r.Hold__c,Purchase_Order__r.Supplier_Name__r.DBA__c ,Purchase_Order__r.Receiver_Name__r.DBA__c,Purchase_Order__r.Distributor_Name__r.DBA__c ,Picklist__c,Invoice__c,Payment_Terms__c,Brand_Quote__c,Actual_Departure_Date_Time__c from  Shipping_Manifest__c where id  =: rsmObj.Id];
            if(sm.Picklist__c != null){
                picklist__c pick = [select id ,Sales_Order__c from  picklist__c where id  =: sm.Picklist__c];
                
                
                Sales_Order__c SOHold = [select id,Supplier_Name__c ,Receiver_Name__c,Distributor_Name__c,Account_Hold_Exception__c, (select id, Sales_Order__c from picklists__r)  from Sales_Order__c where id =: pick.Sales_Order__c];  
                Account  supAcc = [SELECT  id , Hold__c, DBA__c  from Account  where id =:SOHold.Supplier_Name__c];
                Account  recAcc = [SELECT  id , Hold__c, DBA__c  from Account  where id =:SOHold.Receiver_Name__c];
                Account  disAcc = [SELECT  id , Hold__c, DBA__c  from Account  where id =:SOHold.Distributor_Name__c];
                
                String accountName = '';
                Set<String> my_list = new Set<String>();
                if((supAcc.Hold__c == true || recAcc.Hold__c == true || disAcc.Hold__c == true) && SOHold.Account_Hold_Exception__c == false)
                {
                    if(supAcc.Hold__c == true){
                        my_list.add(supAcc.DBA__c);
                    }
                    if(disAcc.Hold__c == true){
                        my_list.add(disAcc.DBA__c);
                    }
                    if(recAcc.Hold__c == true){  my_list.add(recAcc.DBA__c);
                       
                    }
                    accountName = String.join(new List<String>(my_list), ', '); 
                    String ErrorMessage = 'Account: '+ accountName + ' is on HOLD. Please check with Finance team.';
                    errors.add(ErrorMessage);
                    return null;    
                    
                }
            }else if(sm.Purchase_Order__c != null){
                List<String> holdAccounts = new List<String>();
                if(sm.Purchase_Order__r.Supplier_Name__r.Hold__c == true || sm.Purchase_Order__r.Receiver_Name__r.Hold__c == true || sm.Purchase_Order__r.Distributor_Name__r.Hold__c == true){
                    if(sm.Purchase_Order__r.Supplier_Name__r.Hold__c == true){
                        holdAccounts.add(sm.Purchase_Order__r.Supplier_Name__r.DBA__c);
					}
                    if(sm.Purchase_Order__r.Receiver_Name__r.Hold__c == true){
                        holdAccounts.add(sm.Purchase_Order__r.Receiver_Name__r.DBA__c);
                    }
                    if(sm.Purchase_Order__r.Distributor_Name__r.Hold__c == true){
                        holdAccounts.add(sm.Purchase_Order__r.Distributor_Name__r.DBA__c);
                    }
                    String accountNames = String.join(new List<String>(holdAccounts), ', '); 
                    String ErrorMessage = 'Account: '+ accountNames + ' is on HOLD. Please check with Finance team.';
                    errors.add(ErrorMessage);
                    return null;    
                }
            }
            
           rsmObj = retrieveRSMAndLines();
            // Check validation if RSM status is not Shipment Complete and Pending delivery
            if(rsmObj.Status__c == RSM_STATUS_SHIPMENT_COMPLETE){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,
                                                              Label.Already_Shipment_Complete);
                
                errors.add(Label.Already_Shipment_Complete);
                return null;
                
            } else if(rsmObj.Status__c == RSM_STATUS_PENDING_DELIVERY){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,
                                                              Label.Already_Pending_Delivery);
                
                errors.add(Label.Already_Pending_Delivery);
                return null;
                
                // Check if Departure Date and Time is already provided or not
            } else if(rsmObj.Actual_Departure_Date_Time__c != null){
                ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.WARNING,
                                                              Label.Departure_Date_Already_Provided);
               
                errors.add(Label.Departure_Date_Already_Provided);
                return null;
                
                // Check if Picklist is QA Confirm or not
            } 
            
            updateRSMAndInvPostions();
            
            List<Brand_Quote__c>BQList = [SELECT Id,(SELECT Id FROM Purchase_Orders__r) FROM Brand_Quote__c WHERE Id =: SM.Brand_Quote__c];
            if(BQList.size() > 0){
            	for(Purchase_Order__c PO : BQList[0].Purchase_Orders__r){
                    PO.Flash_Title_Date__c = system.now();
            	}   
                update BQList[0].Purchase_Orders__r;
            }
            
        }
        catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('DepartConfirmController:departConfirm()', ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            errors.add(ex.getMessage());
            return null;
        }
        return redirectToRSM();
    }

    /**
     * Retrieve RSM with lines record
     *
     * @return The RSM with lines record
     */         
    public Shipping_Manifest__c retrieveRSMAndLines() {
        return  [Select Vehicle__c,
                        Vehicle__r.Name,
                        Status__c,
                 		RecordTypeId,
                        Actual_Departure_Date_Time__c,
                        Picklist__r.Status__c,
                        (Select Product_Name__c,
                                Product_Title__c,
                                Qty_Received__c,Shipment_Qty__c,
                                Retail_Wholesale_Price__c,
                                Picklist_Line__c,
                                Picklist_Line__r.Inventory_Location__c,
                                Picklist_Line__r.Inventory_Position__r.Inventory_Location__c,
                                Picklist_Line__r.Inventory_Position__c,
                                Picklist_Line__r.Inventory_Position__r.Site__c,
                                Name
                         From Shipping_Manifest_Lines__r  Where SMLine_Status__c!=:SHIPPING_MANIFEST_LINE_STATUS_CANCELLED  ORDER By Name)
                From Shipping_Manifest__c
                Where Id =:rsmobj.id];
    }
    
    
       public Shipping_Manifest__c retrieveRSMAndLineslt(id recordId ) {
        return  [Select Vehicle__c,
                        Vehicle__r.Name,
                        Status__c,
                 		RecordTypeId,
                        Actual_Departure_Date_Time__c,
                        Picklist__r.Status__c,
                        (Select Product_Name__c,
                                Product_Title__c,
                                Qty_Received__c,Shipment_Qty__c,
                                Retail_Wholesale_Price__c,
                                Picklist_Line__c,
                                Picklist_Line__r.Inventory_Location__c,
                                Picklist_Line__r.Inventory_Position__r.Inventory_Location__c,
                                Picklist_Line__r.Inventory_Position__c,
                                Picklist_Line__r.Inventory_Position__r.Site__c,
                                Name
                         From Shipping_Manifest_Lines__r  Where SMLine_Status__c!=:SHIPPING_MANIFEST_LINE_STATUS_CANCELLED  ORDER By Name)
                From Shipping_Manifest__c
                Where Id =:recordId];
    }
    
    
    
    
    
    
    /**
     * Change Status to RSM status, Actual Departure time of RSM
     * Change Inv Location, Rack, Rack Level and Bin Location of Inv Position as vehicle name
     */         
    public void updateRSMAndInvPostions() {
        RSMSupport.departConfirmRSMs(new List<Shipping_Manifest__c>{rsmObj});
    }
    
    /**
     * Redirect to RSM detail page
     *
     * @return PageReference
     */         
    public PageReference redirectToRSM() {
        PageReference pageRef = stdController.view().setRedirect(true);
        return pageRef;
    }
}