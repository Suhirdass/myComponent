/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * ReverseAllocationProcessForSOController
 */
public class ReverseAllocationProcessForSOController{

    private Static String SALES_ORDER_STATUS_REJECTED{
        get{
            return String.isNotBlank(SALES_ORDER_STATUS_REJECTED) ? SALES_ORDER_STATUS_REJECTED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Sales_Order_Status_Rejected');
        }set;
    }
    private Static String STATUS_SALESORDERCANCELLED{
        get{
            return String.isNotBlank(STATUS_SALESORDERCANCELLED) ? STATUS_SALESORDERCANCELLED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','SalesOrder_Cancelled');
        }set;
    }
    private Static String PICKLST_STATUS_CONFIRMED{
        get{
            return String.isNotBlank(PICKLST_STATUS_CONFIRMED) ? PICKLST_STATUS_CONFIRMED : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Picklist','PickList_Status_Confirmed');
        }set;
    }
    
    
    private ApexPages.StandardController stdController;
    private Sales_Order__c salesOrderObj = null;
    public List<Picklist__c> pickLists;
    public static String messagelightning;
    private static final String SO_LINE_STATUS_OPEN = SalesOrderSupport.SO_LINE_STATUS_OPEN; 
    private static final String SO_LINE_STATUS_CANCELLED = SalesOrderSupport.SO_LINE_STATUS_CANCELLED; 
    private static final String SO_STATUS_CANCELLED = SalesOrderSupport.SO_STATUS_CANCELLED; 
	private static final String SO_STATUS_DRAFT = SalesOrderSupport.SO_STATUS_DRAFT; 
    private static final String PICKLIST_STATUS_CONFIRMED = PICKLST_STATUS_CONFIRMED;
    
    // Constructor
    public ReverseAllocationProcessForSOController(ApexPages.StandardController controller) {
        this.stdController = controller;
        salesOrderObj = (Sales_Order__c)stdController.getRecord();
        pickLists = new List<Picklist__c>();
    }
    
    public class UserException extends Exception{ }
    
    public  ReverseAllocationProcessForSOController()
    { 
        
    }
    
    /**
     * Process for Reverse allocation
     * Remove SO line from Inventory position
     * Update inventory position by increasing Qty on Hand
     * Update SO line by changing status and reducing Qty Allocated value
     *
     * @return PageReference of SO detail page
     */
    public PageReference reverseAllocationProcess() {
        PageReference pageRef = null;
        
        Savepoint savePoint;
        
        try {
            // Define save point for rollback
            savePoint = Database.setSavepoint();
            pageRef = updateSOLinesAndInventoryPositions();
            
            if(pageRef != null){
                pageRef.setRedirect(true);
            }
        } 
        catch (Exception ex){
            Database.rollback(savePoint);
            ErrorLogs.log('ReverseAllocationProcessForSOController:reverseAllocationProcess()', 
                          ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(myMsg);
        }
        return pageRef;
    }

    /*lightning Reveres Allocation process*/
    @Auraenabled
    public static AuraResponse checkPicklistExist(string recordId) {
        AuraResponse r = new AuraResponse('ReverseAllocationProcessForSOController.checkPicklistExist()');
        Boolean isPicklistExist = false;
        List<Picklist__c> lstPick = [SELECT Id,Sales_Order__c,Status__c FROM Picklist__c WHERE Sales_Order__c =: recordId AND Status__c NOT IN (:STATUS_SALESORDERCANCELLED,:SALES_ORDER_STATUS_REJECTED)];
        if(lstPick.size() > 0){
            isPicklistExist = true;
        }   
        r.data.put('isPicklistExist', isPicklistExist); 
        return r;
    }
    
    /*lightning Reveres Allocation process*/
    @Auraenabled
    public static AuraResponse updateSOLinesAndInventoryPositionslight(string recordId) {
        AuraResponse r = new AuraResponse('ReverseAllocationProcessForSOController.updateSOLinesAndInventoryPositionslight()');
        ReverseAllocationProcessForSOController assign = new ReverseAllocationProcessForSOController();
        try{
            // Set to add all SO line Ids
            Set<Id> soLineIds = new Set<Id>();
            
            // List to store all SO lines
            List<Sales_Order_Line__c> soLines = new List<Sales_Order_Line__c>();
            
            // List of Inventory Position By Sales Order Line Id
            Map<Id, List<Inventory_Position__c>> inventoryPositionsBySOLineId = new Map<Id, List<Inventory_Position__c>>();
            
            // List of Inventory Positions to Update
            List<Inventory_Position__c> inventoryPositionsToUpdate = new List<Inventory_Position__c>();
            
            assign.pickLists = [Select Id, Status__c From Picklist__c Where Sales_Order__c =:recordId LIMIT 1];
            
            // Retrieve SO detail and related SO lines
            assign.salesOrderObj = [Select Ownership__c,
                                    Allocated__c,
                                    SO_Status__c,
                                    (Select Sales_Order__c,
                                     Qty_Allocated__c,
                                     Status__c
                                     From Sales_Order_Lines__r 
                                     Where NOT Status__c IN (:SO_LINE_STATUS_OPEN,
                                                             :SO_LINE_STATUS_CANCELLED))
                                    From Sales_Order__c where Id =:recordId];
            
            soLines = assign.salesOrderObj.Sales_Order_Lines__r;
            
            if(assign.checkValidationLight()) {
                r.data.put('messagelightning', messagelightning);
                return r;
            }
            
            
            if(soLines != null){
                for(Sales_Order_Line__c objSOline : soLines){
                    soLineIds.add(objSOline.Id);
                }
                
                // Retrieve all Inventory Positions related to SO line and create map of inventory position by so line id
                for(Inventory_Position__c inventoryPositionObj : [SELECT Id, 
                                                                  Qty_On_Hand__c, 
                                                                  Qty_Allocated__c,
                                                                  Sales_Order_Line__c
                                                                  FROM Inventory_Position__c where Sales_Order_Line__c IN: soLineIds
                                                                  Order by Date_Received__c]){
                                                                      
                                                                      List<Inventory_Position__c> inventoryPositionsTemp = 
                                                                          inventoryPositionsBySOLineId.get(inventoryPositionObj.Sales_Order_Line__c);
                                                                      
                                                                      if(inventoryPositionsTemp == null) {
                                                                          inventoryPositionsTemp = new List<Inventory_Position__c>();
                                                                          inventoryPositionsBySOLineId.put(inventoryPositionObj.Sales_Order_Line__c, inventoryPositionsTemp);
                                                                      }
                                                                      inventoryPositionsTemp.add(inventoryPositionObj);
                                                                  }
                
                // Iterate on all SO lines
                for(Sales_Order_Line__c soLineObj: soLines){
                    
                    List<Inventory_Position__c> inventoryPositions = inventoryPositionsBySOLineId.get(soLineObj.Id);
                    
                    if(inventoryPositions != null){
                        // Update Qty On Hand with Qty Allocated of Inventory Position
                        // Remove Sales Order Line from Inventory Position
                        for(Inventory_Position__c invPositionObj : inventoryPositions){
                            
                            invPositionObj.Qty_On_Hand__c = invPositionObj.Qty_Allocated__c;
                            invPositionObj.Qty_Allocated__c = 0.0;
                            invPositionObj.Sales_Order_Line__c = null;
                            inventoryPositionsToUpdate.add(invPositionObj);
                        }
                    }
                    
                    // Update SO line status and Qty to Allocated
                    soLineObj.Qty_Allocated__c = 0.0;
                    soLineObj.Status__c = SO_LINE_STATUS_OPEN;
                }
                
                // Change Allocated flag of SO
                assign.salesOrderObj.Allocated__c = false;
                assign.salesOrderObj.SO_Status__c = SO_STATUS_DRAFT;
                
                update assign.salesOrderObj;
                update soLines;
                update inventoryPositionsToUpdate;
                delete assign.pickLists;
            }  
            
            return r ;    
        }
        catch(Exception ex){
            ErrorLogs.log('ReverseAllocationProcessForSOController:updateSOLinesAndInventoryPositionslight()', ex.getStackTraceString(), ex.getMessage());
            messagelightning = ex.getMessage();
            r.data.put('messagelightning', messagelightning); 
            return r;
        }        
    }

    /**
     * Process for Reverse allocation
     * Remove SO line from Inventory position
     * Update inventory position by increasing Qty on Hand
     * Update SO line by changing status and reducing Qty Allocated value
     *
     * @return PageReference of SO detail page
     */
    public PageReference updateSOLinesAndInventoryPositions(){
        // Set to add all SO line Ids
        Set<Id> soLineIds = new Set<Id>();
        
        // List to store all SO lines
        List<Sales_Order_Line__c> soLines = new List<Sales_Order_Line__c>();
         
        // List of Inventory Position By Sales Order Line Id
        Map<Id, List<Inventory_Position__c>> inventoryPositionsBySOLineId = new Map<Id, List<Inventory_Position__c>>();
        
        // List of Inventory Positions to Update
        List<Inventory_Position__c> inventoryPositionsToUpdate = new List<Inventory_Position__c>();
        
        pickLists = [Select Id, Status__c From Picklist__c Where Sales_Order__c =: salesOrderObj.Id LIMIT 1];
        
        // Retrieve SO detail and related SO lines
        salesOrderObj = [Select Ownership__c,
                                Allocated__c,
                                SO_Status__c,
                                (Select Sales_Order__c,
                                        Qty_Allocated__c,
                                       Status__c
                                From Sales_Order_Lines__r 
                                Where NOT Status__c IN (:SO_LINE_STATUS_OPEN,
                                                        :SO_LINE_STATUS_CANCELLED))
                         From Sales_Order__c where Id =: salesOrderObj.Id];
                  
        soLines = salesOrderObj.Sales_Order_Lines__r;
    
        if(checkValidation()){
            return null;
        }
        
        if(soLines != null){
            for(Sales_Order_Line__c objSOline : soLines){
                soLineIds.add(objSOline.Id);
            }
        
            // Retrieve all Inventory Positions related to SO line and create map of inventory position by so line id
            for(Inventory_Position__c inventoryPositionObj : [SELECT Id, 
                                                                 Qty_On_Hand__c, 
                                                                 Qty_Allocated__c,
                                                                 Sales_Order_Line__c
                                                               FROM Inventory_Position__c where Sales_Order_Line__c IN: soLineIds
                                                               Order by Date_Received__c]){
                
                List<Inventory_Position__c> inventoryPositionsTemp = 
                                          inventoryPositionsBySOLineId.get(inventoryPositionObj.Sales_Order_Line__c);
                
                if(inventoryPositionsTemp == null) {
                    inventoryPositionsTemp = new List<Inventory_Position__c>();
                    inventoryPositionsBySOLineId.put(inventoryPositionObj.Sales_Order_Line__c, inventoryPositionsTemp);
                }
                inventoryPositionsTemp.add(inventoryPositionObj);
            }
            
            // Iterate on all SO lines
            for(Sales_Order_Line__c soLineObj: soLines){
               
                List<Inventory_Position__c> inventoryPositions = inventoryPositionsBySOLineId.get(soLineObj.Id);
                
                if(inventoryPositions != null){
                    // Update Qty On Hand with Qty Allocated of Inventory Position
                    // Remove Sales Order Line from Inventory Position
                    for(Inventory_Position__c invPositionObj : inventoryPositions){
                        
                        invPositionObj.Qty_On_Hand__c = invPositionObj.Qty_Allocated__c;
                        invPositionObj.Qty_Allocated__c = 0.0;
                        invPositionObj.Sales_Order_Line__c = null;
                        inventoryPositionsToUpdate.add(invPositionObj);
                    }
                }
                
                // Update SO line status and Qty to Allocated
                soLineObj.Qty_Allocated__c = 0.0;
                soLineObj.Status__c = SO_LINE_STATUS_OPEN;
            }
            
            // Change Allocated flag of SO
            salesOrderObj.Allocated__c = false;
			salesOrderObj.SO_Status__c = SO_STATUS_DRAFT;
            
            update salesOrderObj;
            update soLines;
            update inventoryPositionsToUpdate;
            delete pickLists;
        }
        return redirectToSalesOrder(); 
    }
    
    /**
     * Perform validation - SO cannot be cancelled
     *
     * @return Boolean flag to indicate if any validation fails
     */
    public Boolean checkValidationLight(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        
        if(salesOrderObj.SO_Status__c == SO_STATUS_CANCELLED || 
          (pickLists.size() > 0 && pickLists[0].Status__c == PICKLIST_STATUS_CONFIRMED)){
            hasValidationError = true;
               messagelightning = Label.No_Reverse_Allocation_For_Cancelled_SO;
        }
        return hasValidationError;
    }
    
    public Boolean checkValidation(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        
        if(salesOrderObj.SO_Status__c == SO_STATUS_CANCELLED || 
          (pickLists.size() > 0 && pickLists[0].Status__c == PICKLIST_STATUS_CONFIRMED)){
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            Label.No_Reverse_Allocation_For_Cancelled_SO);
            ApexPages.addMessage(message);
        }
        return hasValidationError;
    }
    
    /**
     * Redirect to SO detail page
     *
     * @return PageReference
     */         
    public PageReference redirectToSalesOrder() {
        return stdController.view().setRedirect(true);
    }

}