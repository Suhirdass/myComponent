/*
Copyright (c) 2018 Filigreen Distro
All rights reserved.

*/
public class CancelSO{
    
    public Static String SHIPPING_MANIFEST_STATUS_COMPLETE{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_COMPLETE) ? SHIPPING_MANIFEST_STATUS_COMPLETE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Complete');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_CANCELLED{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_CANCELLED) ? SHIPPING_MANIFEST_STATUS_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Cancelled');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_DRAFT{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_DRAFT) ? SHIPPING_MANIFEST_STATUS_DRAFT: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Draft');
        }set;
    }
    public Static String ERR_SO_CAN_BE_CANCELLED_FOR_OPEN_RSM{
        get{
            return String.isNotBlank(ERR_SO_CAN_BE_CANCELLED_FOR_OPEN_RSM) ? ERR_SO_CAN_BE_CANCELLED_FOR_OPEN_RSM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Err_SO_can_be_cancelled_for_open_RSM');
        }set;
    }
    public Static String SHIPPING_MANIFEST_STATUS_PENDING_DELIVERY{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_STATUS_PENDING_DELIVERY) ? SHIPPING_MANIFEST_STATUS_PENDING_DELIVERY: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Pending_Deliver');
        }set;
    }
    private Static String STATUS_OPEN{
        get{
            return String.isNotBlank(STATUS_OPEN) ? STATUS_OPEN: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Picklist_Open');
        }set;
    }
    private Static String STATUS_QAREVIEW{
        get{
            return String.isNotBlank(STATUS_QAREVIEW) ? STATUS_QAREVIEW:  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Picklist_QAReveiew');
        }set;
    }
    private Static String ERR_SO_ALREADY_SHIP_CONFIRM_CLICK_YES{
        get{
            return String.isNotBlank(ERR_SO_ALREADY_SHIP_CONFIRM_CLICK_YES) ? ERR_SO_ALREADY_SHIP_CONFIRM_CLICK_YES: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Err_So_already_Ship_confirm_click_yes');
        }set;
    }
    private Static String ERR_SO_ALREADY_SHIP_CONFIRM_CLICK_CONTINUE{
        get{
            return String.isNotBlank(ERR_SO_ALREADY_SHIP_CONFIRM_CLICK_CONTINUE) ? ERR_SO_ALREADY_SHIP_CONFIRM_CLICK_CONTINUE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Err_So_already_Ship_confirm_click_contin');
        }set;
    }
    private static String PL_STATUS_IN_PROGRESS{
        get{
            return String.isNotBlank(PL_STATUS_IN_PROGRESS) ? PL_STATUS_IN_PROGRESS : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','PL_Status_In_Progress');
        }set;
    }
    public Static String PICKLIST_STATUS_QACONFIRM{
        get{
            return String.isNotBlank(PICKLIST_STATUS_QACONFIRM) ? PICKLIST_STATUS_QACONFIRM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','PickList_Status_QaConfirm');
        }set;
    }
    public Static String PICKLIST_STATUS_CONFIRMED{
        get{
            return String.isNotBlank(PICKLIST_STATUS_CONFIRMED) ? PICKLIST_STATUS_CONFIRMED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','PickList_Status_Confirmed');
        }set;
    }
    public Static String ERR_MSG_CANT_CANCEL_SO_CANCEL_PICKLIST{
        get{
            return String.isNotBlank(ERR_MSG_CANT_CANCEL_SO_CANCEL_PICKLIST) ? ERR_MSG_CANT_CANCEL_SO_CANCEL_PICKLIST: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','Err_Msg_Can_t_Cancel_SO_Cancel_picklist');
        }set;
    }
    public Static String SALES_ORDER_STATUS_APPROVED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_APPROVED) ? SALES_ORDER_STATUS_APPROVED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Approved');
        }set;
    }
    private Static String PICKLST_STATUS_CONFIRMED{
        get{
            return String.isNotBlank(PICKLST_STATUS_CONFIRMED) ? PICKLST_STATUS_CONFIRMED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','PickList_Status_Confirmed');
        }set;
    }
    public Static String Sales_Order_Line_Status_Cancelled{
        get{
            return String.isNotBlank(Sales_Order_Line_Status_Cancelled) ? Sales_Order_Line_Status_Cancelled: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Cancelled');
        }set;
    }
    private Static String STATUS_SALESORDERCANCELLED{
        get{
            return String.isNotBlank(STATUS_SALESORDERCANCELLED) ? STATUS_SALESORDERCANCELLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SalesOrder_Cancelled');
        }set;
    }
    private Static String SO_STATUS_DRAFT {		
        get{
              return String.isNotBlank(SO_STATUS_DRAFT) ? SO_STATUS_DRAFT : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Draft');
        }set;
    }
    private Static String SO_STATUS_HOLD {		
        get{
              return String.isNotBlank(SO_STATUS_HOLD) ? SO_STATUS_HOLD : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SO_Status_Hold');
        }set;
    }
    
    private static String SOLI_STATUS_OPEN{
        get{
            return String.isNotBlank(SOLI_STATUS_OPEN) ? SOLI_STATUS_OPEN : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_Status_Open');
        }set;
    }
    private static String SOLI_STATUS_BACK_ORDERED{
        get{
            return String.isNotBlank(SOLI_STATUS_BACK_ORDERED) ? SOLI_STATUS_BACK_ORDERED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','SOLI_Status_Back_Ordered');
        }set;
    }
    private Static String SALES_ORDER_STATUS_REJECTED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_REJECTED) ? SALES_ORDER_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Rejected');
        }set;
    }
    private Static String ERR_SO_ALREADY_CANCELLED{
        get{
            return String.isNotBlank(ERR_SO_ALREADY_CANCELLED) ? ERR_SO_ALREADY_CANCELLED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Err_SO_is_already_Cancelled');
        }set;
    }
    private Static String ERR_SO_ALREADY_REJECTED{
        get{
            return String.isNotBlank(ERR_SO_ALREADY_REJECTED) ? ERR_SO_ALREADY_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Err_SO_is_already_Rejected');
        }set;
    }
    
      private Static String STATUS_ORDERCANCELLEDBYFILIGREEN{
        get{
            return  FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Filigreen');
        }set;
    }
    
     public static String ORDERCANCELLED_CUSTOMER{
        get{
            return String.isNotBlank(ORDERCANCELLED_CUSTOMER) ? ORDERCANCELLED_CUSTOMER : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Customer');
        }set;
    }
      private Static String ORDER_CANCELLED_BY_WOVN{
        get{
            return String.isNotBlank(ORDER_CANCELLED_BY_WOVN) ? ORDER_CANCELLED_BY_WOVN: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','OrderCancelled_Filigreen');
        }set;
    }
    
    @testvisible
    private static final string SHIPMENT_COMPLETE = SHIPPING_MANIFEST_STATUS_COMPLETE;
    @testvisible
    private static final string PENDING_DELIVERY = SHIPPING_MANIFEST_STATUS_PENDING_DELIVERY;
    @AuraEnabled public Sales_Order__c salesorder {get; set;}
    public Sales_Order__c SOObj {get; set;}
    public List<Shipping_Manifest__c> rsmList{get; set;}
    public static String message;
    private ApexPages.StandardController stdController;
    private Sales_Order__c SO = null;  
    @testvisible
    private static Boolean isConfirmed {get; set;}  
    private static List<Shipping_Manifest__c> rsmList;  
     public static boolean CANCELSO = False;  
    public  CancelSO(){ }
    
    public CancelSO(ApexPages.StandardController controller) {
        this.stdController = controller;isConfirmed = false;
        rsmList = new List<Shipping_Manifest__c>();
        System.assertNotEquals(null, controller, 'controller is null');
        SO = ((Sales_Order__c)stdController.getRecord());
        System.assertNotEquals(null, SO, 'Sales Order record is null');
    }
    
    public class UserException extends Exception{ }
    
    public PageReference CancelProcess() {
        PageReference retPage = null;
        try{
            retPage = CancelProcess(SO.Id);
            if(retPage != null){
                retPage.setRedirect(true);
            }
        } 
        catch (Exception ex)
        {
            ErrorLogs.log('CancelSO:CancelProcess()',ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage()); ApexPages.addMessage(myMsg);
        }
        return retPage;
    }
    
    @AuraEnabled
    public static AuraResponse CancelSorder (String recordId, Boolean isConfirmed) {
        
        AuraResponse r = new AuraResponse('CancelSO.CancelSorder()');
        CANCELSO = True;
        CancelSO assign = new CancelSO();
        try{
            assign.SO = new Sales_Order__c();  
            assign.SO = [select id ,name,RecordTypeId ,SO_Status__c,Ownership__c,Allocated__c,Brand_Quote__c,Opportunity_Name__c,Opportunity_Name__r.Order__c,
                         (select id, name,Sales_Order__c,Qty_Ordered__c,Product_Name__c,Qty_Allocated__c,Balance_Qty_to_Allocate__c,Status__c from Sales_Order_Lines__r),
                         (SELECT Id,Status__c,Is_Pick_Started__c FROM Picklists__r WHERE Is_Pick_Started__c = true)
                         FROM Sales_Order__c where id =: recordId]; 
  			 Set<Id> setOpp = new Set<Id>();
            if(assign.SO.Picklists__r.size() > 0){
                r.data.put('message', ERR_MSG_CANT_CANCEL_SO_CANCEL_PICKLIST);
                        return r;
            }
            
            if(checkValidation2( assign.SO)){
                r.data.put('message', message);
              
                return r;
            }
            
            map<ID,Sales_Order_Line__c> mapofSOlinebySoLineID = new map<ID,Sales_Order_Line__c>();
            List<Sales_Order_Line__c> Soline  = assign.SO.Sales_Order_Lines__r;
            
            for(Sales_Order_Line__c objSOline : Soline){
                mapofSOlinebySoLineID.put(objSOline.Id,objSOline);
            }
            
            map<Id,List<Inventory_Position__c>> mapofIPsbySoLine = new map<Id,List<Inventory_Position__c>> ();
            
            // Retrieve all Inventory Positions related to SO line and create map of inventory position by so line id
            for(Inventory_Position__c inventoryPositionObj : [SELECT Id, 
                                                              Qty_On_Hand__c, 
                                                              Qty_Allocated__c,
                                                              Sales_Order_Line__c
                                                              FROM Inventory_Position__c 
                                                              where Sales_Order_Line__c =: mapofSOlinebySoLineID.keySet()
                                                              Order by Date_Received__c]){
                                                                  system.debug('##inventoryPositionObj  :'+inventoryPositionObj.Qty_Allocated__c);
                                                                  List<Inventory_Position__c> inventoryPositionsTemp = 
                                                                      mapofIPsbySoLine.get(inventoryPositionObj.Sales_Order_Line__c);
                                                                  
                                                                  if(inventoryPositionsTemp == null) {
                                                                      inventoryPositionsTemp = new List<Inventory_Position__c>();
                                                                      mapofIPsbySoLine.put(inventoryPositionObj.Sales_Order_Line__c, inventoryPositionsTemp);
                                                                  }
                                                                  inventoryPositionsTemp.add(inventoryPositionObj);
                                                              }
            
            List<Picklist__c> pickLists = new List<Picklist__c>();
            pickLists = [select id, Sales_Order__c, Status__c, Picklist_Lines__c            
                         from Picklist__c where Sales_Order__c =: recordId]; 
            
            if( assign.SO.SO_Status__c == SALES_ORDER_STATUS_APPROVED) {
                if(pickLists.size() > 0 && pickLists[0].Status__c == PICKLST_STATUS_CONFIRMED){
                  
                    if(isConfirmed == false) { message = ERR_SO_ALREADY_SHIP_CONFIRM_CLICK_YES; 
                        r.data.put('message', message);
                        string status = assign.SO.SO_Status__c;
                        r.data.put('status',status);
                        return r;
                    }
                }
                List<Sales_Order_Line__c> lstSOline = new List<Sales_Order_Line__c>();
                List<Inventory_Position__c> lstIps = new List<Inventory_Position__c>();
                for(Id keyId: mapofSOlinebySoLineID.Keyset()){if(reverseAllocate(mapofSOlinebySoLineID.get(keyId), mapofIPsbySoLine).size() > 0){
                     	lstIps.addAll(reverseAllocate(mapofSOlinebySoLineID.get(keyId), mapofIPsbySoLine));    
                    }
                 mapofSOlinebySoLineID.get(keyId).Status__c = Sales_Order_Line_Status_Cancelled;                     
                 lstSOline.add(mapofSOlinebySoLineID.get(keyId));
                } 
                if(lstIps.size() > 0) update lstIps;
				if(lstSOline.size() > 0) update lstSOline;                
                assign.SO.SO_Status__c = STATUS_SALESORDERCANCELLED;
                assign.SO.Allocated__c = false;
                update  assign.SO;
                
                  // Cancel invoice and invoice Line item
                Set<Id> invoiceIds = new Set<Id>();
                List<Invoice__c> invoices = new List<Invoice__c>();
                List<Invoice_Line__c> lines = new List<Invoice_Line__c>();
                for(Invoice__c  invoiceObj : [SELECT Id FROM Invoice__c WHERE Sales_Order__c = :assign.SO.ID AND AR_Status__c != 'Cancelled' AND RecordType.Name = 'Product']){
                    invoices.add(new Invoice__c(
                        Id = invoiceObj.Id,
                        AR_Status__c = STATUS_SALESORDERCANCELLED
                    ));
                    invoiceIds.add(invoiceObj.Id);
                }
                for(Invoice_Line__c lineObj : [SELECT Id FROM Invoice_Line__c WHERE Invoice__c IN :invoiceIds AND InvoiceLine_Status__c != 'Cancelled']){
                    lines.add(new Invoice_Line__c(
                        Id = lineObj.Id,
                        InvoiceLine_Status__c  = STATUS_SALESORDERCANCELLED
                    ));
                }
                if(invoices.size() > 0) update invoices;
                if(lines.size() > 0) update lines;
                
                
                Brand_Quote__c brandQuoteData = new Brand_Quote__c();
                brandQuoteData.Id = assign.So.Brand_Quote__c;
                brandQuoteData.BQ_Status__c = STATUS_SALESORDERCANCELLED;
                brandQuoteData.Ship_Confirmation_Date__c = System.Today();
                Update brandQuoteData;
            
            setOpp.add(assign.So.Opportunity_Name__c);
            
            if(setOpp.size() > 0){   List<Opportunity> lstOpp = [select Id,Name,Order__c from Opportunity where Id In :setOpp];
                Set<Id> setOrd = new Set<Id>();
                for(Opportunity opp : lstOpp){
                    if(opp.Order__c != null)  setOrd.add(opp.Order__c);   
                }if(setOrd.size() > 0){
                    List<Order__c> lstOrd = [select id,Name,Status__c from Order__c where Id In :setOrd];  
                    for(Order__c order : lstOrd){  order.Status__c = STATUS_ORDERCANCELLEDBYFILIGREEN;
                    }
                  update lstOrd;   
                }
            }
                
               
                
            }else if( assign.SO.SO_Status__c == SO_STATUS_DRAFT ||  assign.SO.SO_Status__c == SO_STATUS_HOLD) {
                List<Sales_Order_Line__c> lstSOline = new List<Sales_Order_Line__c>();
                List<Inventory_Position__c> lstIps = new List<Inventory_Position__c>();
                for(Id keyId: mapofSOlinebySoLineID.Keyset()){
                    if(mapofSOlinebySoLineID.get(keyId).Status__c == SOLI_STATUS_BACK_ORDERED) {
                        if(mapofSOlinebySoLineID.get(keyId).Qty_Allocated__c > 0) {
                            if(reverseAllocate(mapofSOlinebySoLineID.get(keyId), mapofIPsbySoLine).size() > 0){
                            	lstIps.addAll(reverseAllocate(mapofSOlinebySoLineID.get(keyId), mapofIPsbySoLine));    
                            }
                        }
                    } else if(mapofSOlinebySoLineID.get(keyId).Status__c != SOLI_STATUS_BACK_ORDERED && mapofSOlinebySoLineID.get(keyId).Status__c != SOLI_STATUS_OPEN) {
                        if(reverseAllocate(mapofSOlinebySoLineID.get(keyId), mapofIPsbySoLine).size() > 0){
                            lstIps.addAll(reverseAllocate(mapofSOlinebySoLineID.get(keyId), mapofIPsbySoLine));    
                        }
                    } 
                    mapofSOlinebySoLineID.get(keyId).Status__c = Sales_Order_Line_Status_Cancelled;
                    lstSOline.add(mapofSOlinebySoLineID.get(keyId));
                     }
                if(lstIps.size() > 0) update lstIps;
                if(lstSOline.size() > 0) update lstSOline;
                assign.SO.SO_Status__c = STATUS_SALESORDERCANCELLED;
                assign.SO.Allocated__c = false;
                update  assign.SO;
                
                                // Cancel invoice and invoice Line item
                Set<Id> invoiceIds = new Set<Id>();
                List<Invoice__c> invoices = new List<Invoice__c>();
                List<Invoice_Line__c> lines = new List<Invoice_Line__c>();
                for(Invoice__c  invoiceObj : [SELECT Id FROM Invoice__c WHERE Sales_Order__c = :assign.SO.ID AND AR_Status__c != 'Cancelled' AND RecordType.Name = 'Product']){
                    invoices.add(new Invoice__c( Id = invoiceObj.Id, AR_Status__c = STATUS_SALESORDERCANCELLED
                    ));
                    invoiceIds.add(invoiceObj.Id);
                }
                for(Invoice_Line__c lineObj : [SELECT Id FROM Invoice_Line__c WHERE Invoice__c IN :invoiceIds AND InvoiceLine_Status__c != 'Cancelled']){
                    lines.add(new Invoice_Line__c(   Id = lineObj.Id,InvoiceLine_Status__c  = STATUS_SALESORDERCANCELLED
                    ));
                } if(invoices.size() > 0) update invoices;
                if(lines.size() > 0) update lines;
                Brand_Quote__c brandQuoteData = new Brand_Quote__c();
                brandQuoteData.Id = assign.So.Brand_Quote__c;
                brandQuoteData.BQ_Status__c = STATUS_SALESORDERCANCELLED;
                brandQuoteData.Ship_Confirmation_Date__c = System.Today();
                Update brandQuoteData;
            setOpp.add(assign.So.Opportunity_Name__c);
            
            if(setOpp.size() > 0){List<Opportunity> lstOpp = [select Id,Name,Order__c from Opportunity where Id In :setOpp];
                Set<Id> setOrd = new Set<Id>();
                for(Opportunity opp : lstOpp){
                    if(opp.Order__c != null)  setOrd.add(opp.Order__c);   
                }
                 if(setOrd.size() > 0){
                    List<Order__c> lstOrd = [select id,Name,Status__c from Order__c where Id In :setOrd];  
                    for(Order__c order : lstOrd){ order.Status__c = STATUS_ORDERCANCELLEDBYFILIGREEN;
                        }
                    update lstOrd;   
                 }
            }
            }
            if(pickLists.size() > 0){
                delete pickLists;
            }
            if(rsmList.size() > 0) delete rsmList;
            
            string status = assign.SO.SO_Status__c;
           
            r.data.put('status',status);  
            return r;
        }
        catch(Exception ex){
            ErrorLogs.log('CancelSO:CancelSorder()',ex.getStackTraceString(), ex.getMessage()); message = ex.getMessage(); r.data.put('message', message);  return r;
        }
    }
    
    public static PageReference CancelProcess(Id soid)
    {
        PageReference retPage = null;

        ID sOrderId = soid;
            Set<Id> setOpp = new Set<Id>();
        Sales_Order__c So = [select id ,name,RecordTypeId
                             ,SO_Status__c
                             ,Ownership__c
                             ,Allocated__c, Brand_Quote__c,Opportunity_Name__c, (select id
                                             ,name
                                             ,Sales_Order__c
                                             ,Qty_Ordered__c
                                             ,Product_Name__c
                                             ,Qty_Allocated__c
                                             ,Balance_Qty_to_Allocate__c
                                             ,Status__c
                                             from Sales_Order_Lines__r )
                             from Sales_Order__c where id =: sOrderId];
        
        if(checkValidation(So)){
            return null;
        }
        
        map<ID,Sales_Order_Line__c> mapofSOlinebySoLineID = new map<ID,Sales_Order_Line__c>();
        List<Sales_Order_Line__c> Soline  = So.Sales_Order_Lines__r;
        
        for(Sales_Order_Line__c objSOline : Soline){
            mapofSOlinebySoLineID.put(objSOline.Id,objSOline);
        }
        
        map<Id,List<Inventory_Position__c>> mapofIPsbySoLine = new map<Id,List<Inventory_Position__c>> ();
        
        // Retrieve all Inventory Positions related to SO line and create map of inventory position by so line id
        for(Inventory_Position__c inventoryPositionObj : [SELECT Id, 
                                                          Qty_On_Hand__c, 
                                                          Qty_Allocated__c,
                                                          Sales_Order_Line__c
                                                          FROM Inventory_Position__c 
                                                          where Sales_Order_Line__c =: mapofSOlinebySoLineID.keySet()
                                                          Order by Date_Received__c]){
                                                              
                                                              List<Inventory_Position__c> inventoryPositionsTemp = 
                                                                  mapofIPsbySoLine.get(inventoryPositionObj.Sales_Order_Line__c);
                                                              
                                                              if(inventoryPositionsTemp == null) {
                                                                  inventoryPositionsTemp = new List<Inventory_Position__c>();
                                                                  mapofIPsbySoLine.put(inventoryPositionObj.Sales_Order_Line__c, inventoryPositionsTemp);
                                                              }
                                                              inventoryPositionsTemp.add(inventoryPositionObj);
                                                          }
        
        List<Picklist__c> pickLists = new List<Picklist__c>();
        pickLists = [select id, Sales_Order__c, Status__c, Picklist_Lines__c            
                     from Picklist__c where Sales_Order__c =: sOrderId]; 
        
        if(So.SO_Status__c == SALES_ORDER_STATUS_APPROVED) {
            
            if(pickLists.size() > 0 && pickLists[0].Status__c == PICKLST_STATUS_CONFIRMED){
                
                if(isConfirmed == false) {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.WARNING,ERR_SO_ALREADY_SHIP_CONFIRM_CLICK_CONTINUE));
                    return retPage;
                }                              
               
            }
            List<Sales_Order_Line__c> lstSoLine = new List<Sales_Order_Line__c>();
            List<Inventory_Position__c> lstIps = new List<Inventory_Position__c>();
            for(Id keyId: mapofSOlinebySoLineID.Keyset()){
               
                if(reverseAllocate(mapofSOlinebySoLineID.get(keyId), mapofIPsbySoLine).size() > 0){
                    lstIps.addAll(reverseAllocate(mapofSOlinebySoLineID.get(keyId), mapofIPsbySoLine));
                }                  
                mapofSOlinebySoLineID.get(keyId).Status__c = Sales_Order_Line_Status_Cancelled; lstSoLine.add(mapofSOlinebySoLineID.get(keyId));                     
               
            }   
            if(lstIps.size() > 0) update lstIps;
            if(lstSoLine.size() > 0) update lstSoLine;
            So.SO_Status__c = STATUS_SALESORDERCANCELLED;
            So.Allocated__c = false;
            update So;
            Brand_Quote__c brandQuoteData = new Brand_Quote__c();
            brandQuoteData.Id = So.Brand_Quote__c;
            brandQuoteData.BQ_Status__c = STATUS_SALESORDERCANCELLED;
            brandQuoteData.Ship_Confirmation_Date__c = System.Today();
            Update brandQuoteData;
            
            setOpp.add(So.Opportunity_Name__c);
            
            if(setOpp.size() > 0){
                List<Opportunity> lstOpp = [select Id,Name,Order__c from Opportunity where Id In :setOpp];
                Set<Id> setOrd = new Set<Id>();
                for(Opportunity opp : lstOpp){
                    if(opp.Order__c != null)  setOrd.add(opp.Order__c);   
                }
                
                if(setOrd.size() > 0){
                    List<Order__c> lstOrd = [select id,Name,Status__c from Order__c where Id In :setOrd];  
                    for(Order__c order : lstOrd){
                        order.Status__c = STATUS_ORDERCANCELLEDBYFILIGREEN;
                    }
                    update lstOrd;   
                }
            }
           
        }else if(So.SO_Status__c == SO_STATUS_DRAFT || So.SO_Status__c == SO_STATUS_HOLD) {
            List<Sales_Order_Line__c> lstSoLine = new List<Sales_Order_Line__c>();
            List<Inventory_Position__c> lstIps = new List<Inventory_Position__c>();
            for(Id keyId: mapofSOlinebySoLineID.Keyset()){
                if(mapofSOlinebySoLineID.get(keyId).Status__c == SOLI_STATUS_BACK_ORDERED) {
                    if(mapofSOlinebySoLineID.get(keyId).Qty_Allocated__c > 0) {
                        if(reverseAllocate(mapofSOlinebySoLineID.get(keyId), mapofIPsbySoLine).size() > 0){lstIps.addAll(reverseAllocate(mapofSOlinebySoLineID.get(keyId), mapofIPsbySoLine));
                       }
                       
                    }
                } else if(mapofSOlinebySoLineID.get(keyId).Status__c != SOLI_STATUS_BACK_ORDERED && mapofSOlinebySoLineID.get(keyId).Status__c != SOLI_STATUS_OPEN) {
                   
                    if(reverseAllocate(mapofSOlinebySoLineID.get(keyId), mapofIPsbySoLine).size() > 0){  lstIps.addAll(reverseAllocate(mapofSOlinebySoLineID.get(keyId), mapofIPsbySoLine));    
                    }
                } 
                
                mapofSOlinebySoLineID.get(keyId).Status__c = Sales_Order_Line_Status_Cancelled;lstSoLine.add(mapofSOlinebySoLineID.get(keyId));
                
            }
            if(lstIps.size() > 0) update lstIps;
            if(lstSoLine.size() > 0) update lstSoLine;
            So.SO_Status__c = STATUS_SALESORDERCANCELLED;
            So.Allocated__c = false;
            update So;
            Brand_Quote__c brandQuoteData = new Brand_Quote__c();
            brandQuoteData.Id = So.Brand_Quote__c;
            brandQuoteData.BQ_Status__c = STATUS_SALESORDERCANCELLED;
            brandQuoteData.Ship_Confirmation_Date__c = System.Today();
            Update brandQuoteData;
            
            setOpp.add(So.Opportunity_Name__c);
            
            if(setOpp.size() > 0){
                List<Opportunity> lstOpp = [select Id,Name,Order__c from Opportunity where Id In :setOpp];
                Set<Id> setOrd = new Set<Id>();
                for(Opportunity opp : lstOpp){
                    if(opp.Order__c != null)  setOrd.add(opp.Order__c);   
                }
                
                if(setOrd.size() > 0){
                    List<Order__c> lstOrd = [select id,Name,Status__c from Order__c where Id In :setOrd];  
                    for(Order__c order : lstOrd){
                        order.Status__c = STATUS_ORDERCANCELLEDBYFILIGREEN;
                    }
                    update lstOrd;   
                }
            }
        }
        
        if(pickLists.size() > 0){
            delete pickLists;
        }
        if(rsmList.size() > 0) delete rsmList; retPage = new PageReference('/'+SO.Id);
       return retPage;
    }
    public static List<Inventory_Position__c> reverseAllocate(Sales_Order_Line__c soLineObj, map<Id,List<Inventory_Position__c>> mapofIPsbySoLine) { 
        List<Inventory_Position__c> inventoryPositions = mapofIPsbySoLine.get(soLineObj.Id);
        List<Inventory_Position__c> inventoryPositionsToUpdate = new List<Inventory_Position__c>();
        if(inventoryPositions != null){
            // Update Qty On Hand with Qty Allocated of Inventory Position
            // Remove Sales Order Line from Inventory Position
            for(Inventory_Position__c invPositionObj : inventoryPositions){ 
                system.debug('##Qty_Allocated__c  :'+invPositionObj.Qty_Allocated__c);
                if(invPositionObj.Qty_Allocated__c > 0){
                    invPositionObj.Qty_On_Hand__c = invPositionObj.Qty_Allocated__c;
                }
               	invPositionObj.Qty_Allocated__c = 0.0;
                invPositionObj.Sales_Order_Line__c = null;
                inventoryPositionsToUpdate.add(invPositionObj);
             }
        }
        
        // Update SO line status and Qty Allocated
        soLineObj.Qty_Allocated__c = 0.0;
        soLineObj.Status__c = Sales_Order_Line_Status_Cancelled; 
        return inventoryPositionsToUpdate;
                //update inventoryPositionsToUpdate;
    }
    
    
    public PageReference goBack() {return stdController.view().setRedirect(true);
         }
    
    /**
* Perform validation to cancel SO
* 
* @param so The sales order record
*
* @return Boolean flag to indicate if any validation fails
*/
    public static Boolean checkValidation(Sales_Order__c so){ ApexPages.Message message;
        Boolean hasValidationError = false;
        if(so.SO_Status__c == STATUS_SALESORDERCANCELLED) {
            message = new ApexPages.Message(ApexPages.Severity.ERROR, ERR_SO_ALREADY_CANCELLED);
            ApexPages.addMessage(message);
            hasValidationError = true;
        }else{
            
            rsmList = new List<Shipping_Manifest__c>(); 
            rsmList = [Select Status__c from Shipping_Manifest__c Where Sales_Order__c =: so.Id];
            
            if(rsmList.size() == 0){
                return hasValidationError;
            }
            
            for(Shipping_Manifest__c rsmSO : rsmList){
                if(rsmSO.Status__c == SHIPMENT_COMPLETE){ message = new ApexPages.Message(ApexPages.Severity.ERROR, ERR_SO_CAN_BE_CANCELLED_FOR_OPEN_RSM);
                   ApexPages.addMessage(message);
                    hasValidationError = true;
                    break;
                }
                
            }
        }
        return hasValidationError;
    }
    public static Boolean checkValidation2(Sales_Order__c so){
        Boolean hasValidationError = false;
        // Check for Driver value
        if(so.SO_Status__c == STATUS_SALESORDERCANCELLED) {
            hasValidationError = true;
            message = ERR_SO_ALREADY_CANCELLED;
        }
        else if(so.SO_Status__c == SALES_ORDER_STATUS_REJECTED){ hasValidationError = true;
            message = ERR_SO_ALREADY_REJECTED;
        }
        else{ rsmList = new List<Shipping_Manifest__c>(); rsmList = [Select Status__c from Shipping_Manifest__c Where Sales_Order__c =: so.Id]; if(rsmList.size() == 0){
             return hasValidationError;
            }for(Shipping_Manifest__c rsmSO : rsmList){
                if(rsmSO.Status__c == SHIPMENT_COMPLETE){ hasValidationError = true;
                    message = ERR_SO_CAN_BE_CANCELLED_FOR_OPEN_RSM;
                    break;
                }
                 }
        }
        return hasValidationError;
    }
    /*get record name*/
    @Auraenabled
    public static String getRecordName(Id recordId){
        String objName = recordId.getSObjectType().getDescribe().getName();
      
        String q = 'SELECT Name FROM ' + objName + ' WHERE Id=\'' + recordId + '\'';
        List<SObject> records = Database.query(q);
        if(records.size()>0){
            return (String) (records[0].get('Name'));}  return '';
    }
    
}