/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * AssignVehicleToPurchaseOrderCtlr
 */
public class AssignVehicleToPurchaseOrderCtlr{
    public Static String SM_Line_Status_Shipment_Complete{
        get{
            return String.isNotBlank(SM_Line_Status_Shipment_Complete) ? SM_Line_Status_Shipment_Complete: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','SM_Line_Status_Shipment_Complete');
        }set;
    }
    public Static String Shipping_Manifest_LineStatus_Cancelled{
        get{
            return String.isNotBlank(Shipping_Manifest_LineStatus_Cancelled) ? Shipping_Manifest_LineStatus_Cancelled: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Cancelled');
        }set;
    }
    public Static String Shipping_Manifest_LineStatus_Rejected{
        get{
            return String.isNotBlank(Shipping_Manifest_LineStatus_Rejected) ? Shipping_Manifest_LineStatus_Rejected: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest Line','Shipping_Manifest_LineStatus_Rejected');
        }set;
    }
    public Static String Shipping_Manifest_Status_Cancelled{
        get{
            return String.isNotBlank(Shipping_Manifest_Status_Cancelled) ? Shipping_Manifest_Status_Cancelled: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Cancelled');
        }set;
    }
    public Static String Shipping_Manifest_Status_Complete{
        get{
            return String.isNotBlank(Shipping_Manifest_Status_Complete) ? Shipping_Manifest_Status_Complete: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Complete');
        }set;
    }
    public Static String POLI_Status_Closed{
        get{
            return String.isNotBlank(POLI_Status_Closed) ? POLI_Status_Closed: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POLI_Status_Closed');
        }set;
    }
    public Static String POLI_Status_Rejected{
        get{
            return String.isNotBlank(POLI_Status_Rejected) ? POLI_Status_Rejected: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POLI_Status_Rejected');
        }set;
    }
    public Static String POLI_Status_Cancelled{
        get{
            return String.isNotBlank(POLI_Status_Cancelled) ? POLI_Status_Cancelled: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POLI_Status_Cancelled');
        }set;
    }
    public Static String POLI_Status_Partially_Received{
        get{
            return String.isNotBlank(POLI_Status_Partially_Received) ? POLI_Status_Partially_Received: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order Line','POLI_Status_Partially_Received');
        }set;
    }
    public Static String SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM) ? SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_ProductTSM');
        }set;
    } 
    public Static String Shipping_Manifest_Status_Received{
        get{
            return String.isNotBlank(Shipping_Manifest_Status_Received) ? Shipping_Manifest_Status_Received: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Received');
        }set;
    }
    private ApexPages.StandardController stdController;
    public Purchase_Order__c rsmObj {get; set;}
    public List<Shipping_Manifest__c> rsmList {get; set;}
    public List<Shipping_Manifest__c> tsmList {get; set;}
    public Vehicles__c vehicleObj {get; set;}
    public Integer totalProduct {get; set;}
    private Id rsmRecordTypeId;
    private Id tsmRecordTypeId;
    public static String message;
    
    


    
    public AssignVehicleToPurchaseOrderCtlr(ApexPages.StandardController controller) {
        this.stdController = controller;
        rsmObj = (Purchase_Order__c)stdController.getRecord();
        rsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get('RSM').getRecordTypeId();
        tsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get('Product TSM').getRecordTypeId();
        reset();
    }  
    
       
       public AssignVehicleToPurchaseOrderCtlr() {
        reset();
    } 
    
    
     @AuraEnabled
    public static AuraResponse assignVehicleToPurchaseOrder(String recordId){
        AuraResponse r = new AuraResponse('AssignVehicleToPurchaseOrderCtlr.assignVehicleToPurchaseOrder()'); 
        AssignVehicleToPurchaseOrderCtlr assign = new AssignVehicleToPurchaseOrderCtlr();
        
        assign.rsmObj = new Purchase_Order__c();
          assign.rsmObj = [select Id,Name,Vehicle__c,Vehicle__r.Name,Driver__c,Planned_Ship_Transfer_Date__c,Total_Line_Items__c  from Purchase_Order__c where Id = :recordId limit 1];
      
        assign.rsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get('RSM').getRecordTypeId();
        assign.tsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get('Product TSM').getRecordTypeId();
        assign.reset();
        assign.doPrepare();
        r.data.put('rsmList', assign.rsmList);
        r.data.put('tsmList', assign.tsmList);
        r.data.put('vehicleObj', assign.vehicleObj);
        r.data.put('rsmObj', assign.rsmObj);
        
        decimal totalCubicVolume = 0;
        for(Purchase_Order_Line__c POL : [SELECT Id,Qty_Ordered__c,Product_Name__c,Product_Name__r.Unit_Cubic_Volume__c,Product_Name__r.Case_Cubic_Volume__c,Product_Name__r.MOQ__c FROM Purchase_Order_Line__c WHERE Purchase_Order__c =: recordId AND POLI_Status__c NOT IN(:POLI_Status_Rejected, :POLI_Status_Cancelled, :POLI_Status_Partially_Received, :POLI_Status_Closed)]){
            Decimal qtyOrdered  = POL.Qty_Ordered__c != null ? POL.Qty_Ordered__c : 0;
            Decimal CubicVolume = (POL.Product_Name__r.MOQ__c == 1 && POL.Product_Name__r.Unit_Cubic_Volume__c != null) ? POL.Product_Name__r.Unit_Cubic_Volume__c : (POL.Product_Name__r.MOQ__c > 1 && POL.Product_Name__r.Case_Cubic_Volume__c != null) ? POL.Product_Name__r.Case_Cubic_Volume__c : 0;
            totalCubicVolume += qtyOrdered * CubicVolume;	    
        }
        r.data.put('totalCubicVolume', totalCubicVolume);
        
        decimal totalOrderCubicVolumeCapacity = 0;
        for(Purchase_Order_Line__c POL : [SELECT Id,Purchase_Order__c,Qty_Ordered__c,Product_Name__c,Product_Name__r.Unit_Cubic_Volume__c,Product_Name__r.Case_Cubic_Volume__c,Product_Name__r.MOQ__c FROM Purchase_Order_Line__c WHERE POLI_Status__c NOT IN(:POLI_Status_Rejected, :POLI_Status_Cancelled,:POLI_Status_Partially_Received, :POLI_Status_Closed) AND Purchase_Order__r.Planned_Ship_Transfer_Date__c =: assign.rsmObj.Planned_Ship_Transfer_Date__c AND Purchase_Order__r.Planned_Ship_Transfer_Date__c != null AND Purchase_Order__r.Vehicle__c =: assign.rsmObj.Vehicle__c AND Purchase_Order__r.Vehicle__c != null]){
        	Decimal qtyOrdered  = POL.Qty_Ordered__c != null ? POL.Qty_Ordered__c : 0;
            Decimal CubicVolume = (POL.Product_Name__r.MOQ__c == 1 && POL.Product_Name__r.Unit_Cubic_Volume__c != null) ? POL.Product_Name__r.Unit_Cubic_Volume__c : (POL.Product_Name__r.MOQ__c > 1 && POL.Product_Name__r.Case_Cubic_Volume__c != null) ? POL.Product_Name__r.Case_Cubic_Volume__c : 0;
            totalOrderCubicVolumeCapacity += qtyOrdered * CubicVolume;	
        }  
        
        r.data.put('assignedVehicleId', assign.rsmObj.Vehicle__c); 
        r.data.put('assignedVehicleDate', assign.rsmObj.Planned_Ship_Transfer_Date__c);  
        
        Id devRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM).getRecordTypeId();
        Map<String,Decimal>rsmTotalCVMap = new Map<String,Decimal>();
        for(AggregateResult aggRes : [SELECT Shipping_Manifest__c,SUM(Picklist_Line__r.Inventory_Position__r.Total_Product_Volume__c) FROM Shipping_Manifest_Line__c where Shipping_Manifest__c IN: assign.rsmList AND Shipping_Manifest__r.RecordType.Id !=: devRecordTypeId /*AND SMLine_Status__c NOT IN(:SM_Line_Status_Shipment_Complete, :Shipping_Manifest_LineStatus_Cancelled, :Shipping_Manifest_LineStatus_Rejected)*/ GROUP BY Shipping_Manifest__c]){
            decimal rsmTotalCV = aggRes.get('expr0') != null ? decimal.Valueof(''+aggRes.get('expr0')) : 0;
            rsmTotalCVMap.put(''+aggres.get('Shipping_Manifest__c'),rsmTotalCV);
            totalOrderCubicVolumeCapacity += rsmTotalCV;
        }
        for(Shipping_Manifest__c SM : [SELECT Id, (SELECT Id,Qty_Ordered__c,Product_Name__c,Product_Name__r.Unit_Cubic_Volume__c,Product_Name__r.Case_Cubic_Volume__c,Product_Name__r.MOQ__c FROM Shipping_Manifest_Lines__r /*WHERE SMLine_Status__c NOT IN(:SM_Line_Status_Shipment_Complete, :Shipping_Manifest_LineStatus_Cancelled, :Shipping_Manifest_LineStatus_Rejected) AND Shipping_Manifest__r.Status__c !=: Shipping_Manifest_Status_Received*/) FROM Shipping_Manifest__c where Id IN: assign.rsmList AND RecordType.Id =: devRecordTypeId]){
        	Decimal rsmTotalCV = 0;
            for(Shipping_Manifest_Line__c SML : SM.Shipping_Manifest_Lines__r){
                Decimal qtyOrdered  = SML.Qty_Ordered__c != null ? SML.Qty_Ordered__c : 0;
                Decimal CubicVolume = (SML.Product_Name__r.MOQ__c == 1 && SML.Product_Name__r.Unit_Cubic_Volume__c != null) ? SML.Product_Name__r.Unit_Cubic_Volume__c : (SML.Product_Name__r.MOQ__c > 1 && SML.Product_Name__r.Case_Cubic_Volume__c != null) ? SML.Product_Name__r.Case_Cubic_Volume__c : 0;
                rsmTotalCV += qtyOrdered * CubicVolume;	
            }
            rsmTotalCVMap.put(SM.Id,rsmTotalCV);            
        }
        r.data.put('rsmTotalCVMap', rsmTotalCVMap);
        
        Map<String,Decimal>tsmTotalCVMap = new Map<String,Decimal>();
        for(AggregateResult aggRes : [SELECT Shipping_Manifest__c,SUM(Picklist_Line__r.Inventory_Position__r.Total_Product_Volume__c) FROM Shipping_Manifest_Line__c where Shipping_Manifest__c IN: assign.tsmList AND Shipping_Manifest__r.RecordType.Id !=: devRecordTypeId /*AND SMLine_Status__c NOT IN(:SM_Line_Status_Shipment_Complete, :Shipping_Manifest_LineStatus_Cancelled, :Shipping_Manifest_LineStatus_Rejected)*/ GROUP BY Shipping_Manifest__c]){
            decimal rsmTotalCV = aggRes.get('expr0') != null ? decimal.Valueof(''+aggRes.get('expr0')) : 0;
            tsmTotalCVMap.put(''+aggres.get('Shipping_Manifest__c'),rsmTotalCV);
            totalOrderCubicVolumeCapacity += rsmTotalCV;
        }
        for(Shipping_Manifest__c SM : [SELECT Id,Purchase_Order__c, (SELECT Id,Qty_Ordered__c,Product_Name__c,Product_Name__r.Unit_Cubic_Volume__c,Product_Name__r.Case_Cubic_Volume__c,Product_Name__r.MOQ__c FROM Shipping_Manifest_Lines__r /*WHERE SMLine_Status__c NOT IN(:SM_Line_Status_Shipment_Complete, :Shipping_Manifest_LineStatus_Cancelled, :Shipping_Manifest_LineStatus_Rejected) AND Shipping_Manifest__r.Status__c !=: Shipping_Manifest_Status_Received*/) FROM Shipping_Manifest__c where Id IN: assign.tsmList AND RecordType.Id =: devRecordTypeId]){
        	Decimal rsmTotalCV = 0;
            for(Shipping_Manifest_Line__c SML : SM.Shipping_Manifest_Lines__r){
                Decimal qtyOrdered  = SML.Qty_Ordered__c != null ? SML.Qty_Ordered__c : 0;
                Decimal CubicVolume = (SML.Product_Name__r.MOQ__c == 1 && SML.Product_Name__r.Unit_Cubic_Volume__c != null) ? SML.Product_Name__r.Unit_Cubic_Volume__c : (SML.Product_Name__r.MOQ__c > 1 && SML.Product_Name__r.Case_Cubic_Volume__c != null) ? SML.Product_Name__r.Case_Cubic_Volume__c : 0;
                rsmTotalCV += qtyOrdered * CubicVolume;	    
            }
            tsmTotalCVMap.put(SM.Id,rsmTotalCV);            
        }
        r.data.put('tsmTotalCVMap', tsmTotalCVMap);
        
        r.data.put('totalOrderCubicVolumeCapacity', totalOrderCubicVolumeCapacity);
        
        decimal estimatedVehiclUtilized = 0;
        if(assign.rsmObj.Vehicle__c != null)
        	estimatedVehiclUtilized = totalOrderCubicVolumeCapacity;   
        else
            estimatedVehiclUtilized = totalCubicVolume + totalOrderCubicVolumeCapacity;        
        r.data.put('estimatedVehiclUtilized', estimatedVehiclUtilized);
        
        return r;
    }
     // reset variables
    public void reset(){
        if(rsmObj == null){
            rsmObj = new Purchase_Order__c();
        }
        rsmList = new List<Shipping_Manifest__c>();
        tsmList = new List<Shipping_Manifest__c>();
        vehicleObj = new Vehicles__c();
    }
     public class UserException extends Exception{ }
    
    /**
     * Assign Vehicle to RSM
     *
     * @return PageReference of RSM detail page
     */
    @AuraEnabled
    public static AuraResponse assignVehicle(Purchase_Order__c order){
    	AuraResponse r = new AuraResponse('AssignVehicleToPurchaseOrderCtlr.assignVehicle()'); 
        AssignVehicleToPurchaseOrderCtlr assign = new AssignVehicleToPurchaseOrderCtlr();
        assign.rsmObj = order;
        
        if(checkValidation(assign.rsmObj)){
            r.data.put('errorMessage', message);
            return r;
        }
        
        try {
            update assign.rsmObj;
        } catch (Exception ex){
            ErrorLogs.log('AssignDriverController:assignDriver()', 
                          ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            message = String.valueOf(msg);
            r.data.put('errorMessage', message);
            return r;
        }
        return r;
    }
    
    /**
     * Assign Vehicle to RSM
     *
     * @return PageReference of RSM detail page
     */
    public PageReference assignVehicle() {
        
        PageReference pageRef = null;
        
        // Perform validations for required field Vehicle
        if(checkValidation()){
            return pageRef;
        }
        
        try {
            update rsmObj;
        } 
        catch (Exception ex){
            ErrorLogs.log('AssignVehicleController:assignVehicle()', 
                          ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            ApexPages.addMessage(msg);
            return null;
        }
        return redirectToRSM();
    }

    /**
     * Retrieve RSM with lines record
     *
     * @return blank page reference
     */         
    public PageReference doPrepare() {
        if(rsmObj != null && rsmObj.Id != null){
            
            // Retrieve RSM details
            rsmObj = [Select Name,Planned_Ship_Transfer_Date__c,
                             Vehicle__c,Vehicle__r.Name,
                             Ship_Confirmation_Date__c,Total_Line_Items__c
                      From Purchase_Order__c
                      Where Id =: rsmObj.Id];
                      //AND RecordTypeId =: rsmRecordTypeId];
            //totalProduct = rsmObj.Shipping_Manifest_Lines__r.size();
            retrieveVehicleAndRelatedRSMs();
        }
        return null;
    }
    
   /**
     * Retrieve Vehicle details and list of RSMs associated with Vehicle
     *
     * @return blank page reference
     */         
    public PageReference retrieveVehicleAndRelatedRSMs() {
        reset();
        if(rsmObj.Vehicle__c != null){
            vehicleObj = [Select Name, 
                                Vehicle_Cubic_Volume_Capacity__c,
                                Vehicle_Height__c,
                                Vehicle_in_Use__c,
                                Vehicle_Length__c,
                                Vehicle_License_Plate_Number__c,
                                Vehicle_Make__c,
                                Vehicle_Model__c,
                                Vehicle_Width__c
                        From Vehicles__c
                        Where Id =: rsmObj.Vehicle__c];
                        
            Date plannedDate = rsmObj.Planned_Ship_Transfer_Date__c;
            Id vehicleObjId = vehicleObj.Id;
            
            String rsmQuery = 'Select Name, ' +
                                   'Vehicle__c,Driver__c,Vehicle__r.Name,Driver__r.Name, ' +
                                   'Planned_Ship_Transfer_Date__c, ' +
                                   'Status__c,Total_Route_Miles__c, Route_Miles__c,' +
                                   'Actual_Departure_Date_Time__c, ' +
                                   'Receiver_Acceptance_Date__c,Sales_Order__c,Sales_Order__r.Name,Total_Line_Items__c  ' +
                              'From Shipping_Manifest__c ' +
                              'Where Vehicle__c =: vehicleObjId ' +
                              'AND RecordTypeId =: rsmRecordTypeId ';
            if(rsmObj.Id != null){
                rsmQuery += 'AND Planned_Ship_Transfer_Date__c =: plannedDate ';
            }
            rsmQuery += ' AND Status__c NOT IN(:Shipping_Manifest_Status_Received)';
            rsmQuery += 'Order By Receiver_Acceptance_Date__c DESC NULLS FIRST';
            rsmList = Database.query(rsmQuery);
            
            String tsmQuery = 'Select Name, ' +
                                   'Vehicle__c,Vehicle__r.Name,Driver__r.Name,Driver__c, ' +
                                   'Planned_Ship_Transfer_Date__c, ' +
                                   'Status__c,Total_Route_Miles__c, Route_Miles__c,' +
                                   'Actual_Departure_Date_Time__c, ' +
                                   'Actual_Arrival_Date_Time__c,Purchase_Order__c,Purchase_Order__r.Name,Total_Line_Items__c  ' +
                              'From Shipping_Manifest__c ' +
                              'Where Vehicle__c =: vehicleObjId ' +
                              'AND RecordTypeId =: tsmRecordTypeId ';
            if(rsmObj.Id != null){
                tsmQuery += 'AND Planned_Ship_Transfer_Date__c =: plannedDate ';
            }
            tsmQuery += ' AND Status__c NOT IN(:Shipping_Manifest_Status_Received)';
            tsmQuery += 'Order By Actual_Arrival_Date_Time__c DESC NULLS FIRST';
            tsmList = Database.query(tsmQuery);
        }
        return null;
    }   
    
    
    
    
    /**
     * Retrieve Vehicle details and list of RSMs associated with Vehicle
     *
     * @return blank page reference
     */    
    @AuraEnabled
    public static AuraResponse retrieveVehicleAndRelatedRSMLight(Purchase_Order__c order,String assignedVehicleId,String assignedVehicleDateStr){
        Date assignedVehicleDate = assignedVehicleDateStr != null && assignedVehicleDateStr != '' ? date.valueOf(assignedVehicleDateStr) : null;
        AuraResponse r = new AuraResponse('AssignVehicleToPurchaseOrderCtlr.retrieveVehicleAndRelatedRSMLight()'); 
        AssignVehicleToPurchaseOrderCtlr assign = new AssignVehicleToPurchaseOrderCtlr();
        
        assign.reset();
        assign.rsmObj = order;
        assign.rsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get('RSM').getRecordTypeId();
        assign.tsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get('Product TSM').getRecordTypeId();
        
        if(assign.rsmObj.Vehicle__c != NULL && !String.isBlank(assign.rsmObj.Vehicle__c)){
        	assign.vehicleObj = [Select Name, Vehicle_Cubic_Volume_Capacity__c,Vehicle_Height__c,Vehicle_in_Use__c,
                                Vehicle_Length__c,Vehicle_License_Plate_Number__c,Vehicle_Make__c,Vehicle_Model__c,Vehicle_Width__c
                        From Vehicles__c
                        Where Id =: assign.rsmObj.Vehicle__c];
                        
            Date plannedDate = assign.rsmObj.Planned_Ship_Transfer_Date__c;
            Id vehicleObjId = assign.vehicleObj.Id;
            
            String rsmQuery = 'Select Name, Vehicle__c,Driver__c,Vehicle__r.Name,Driver__r.Name,Planned_Ship_Transfer_Date__c,Status__c,Total_Route_Miles__c, Route_Miles__c,Actual_Departure_Date_Time__c,' +
                                   'Receiver_Acceptance_Date__c,Sales_Order__c,Sales_Order__r.Name,Total_Line_Items__c From Shipping_Manifest__c ' +
                              'Where Vehicle__c =: vehicleObjId ' +
                ' AND RecordTypeId =\''+ String.escapeSingleQuotes(assign.rsmRecordTypeId)+'\' ';
                            //  'AND RecordTypeId =: rsmRecordTypeId ';
            if(assign.rsmObj.Id != null){
                rsmQuery += 'AND Planned_Ship_Transfer_Date__c =: plannedDate ';
            }
            rsmQuery += ' AND Status__c NOT IN(:Shipping_Manifest_Status_Complete, :Shipping_Manifest_Status_Cancelled,:Shipping_Manifest_Status_Received)';
            rsmQuery += 'Order By Receiver_Acceptance_Date__c DESC NULLS FIRST';
            assign.rsmList = Database.query(rsmQuery);
            
            String tsmQuery = 'Select Name, Vehicle__c,Driver__c,Vehicle__r.Name,Driver__r.Name,Planned_Ship_Transfer_Date__c, Status__c,Total_Route_Miles__c, Route_Miles__c,Actual_Departure_Date_Time__c,' +
                                   'Actual_Arrival_Date_Time__c,Purchase_Order__c,Purchase_Order__r.Name,Total_Line_Items__c From Shipping_Manifest__c ' +
                              'Where Vehicle__c =: vehicleObjId ' +
                		 'AND RecordTypeId =\''+ String.escapeSingleQuotes(assign.tsmRecordTypeId)+'\' ';
                              //'AND RecordTypeId =: tsmRecordTypeId ';
            if(assign.rsmObj.Id != null){
                tsmQuery += 'AND Planned_Ship_Transfer_Date__c =: plannedDate ';
            }
            tsmQuery += ' AND Status__c NOT IN(:Shipping_Manifest_Status_Complete, :Shipping_Manifest_Status_Cancelled,:Shipping_Manifest_Status_Received)';
            tsmQuery += 'Order By Actual_Arrival_Date_Time__c DESC NULLS FIRST';
            assign.tsmList = Database.query(tsmQuery);
        }
        r.data.put('rsmList', assign.rsmList);
        r.data.put('tsmList', assign.tsmList);
        r.data.put('vehicleObj', assign.vehicleObj);
        r.data.put('rsmObj', assign.rsmObj);
        
        decimal totalCubicVolume = 0;
        for(Purchase_Order_Line__c POL : [SELECT Id,Qty_Ordered__c,Product_Name__c,Product_Name__r.Unit_Cubic_Volume__c,Product_Name__r.Case_Cubic_Volume__c,Product_Name__r.MOQ__c FROM Purchase_Order_Line__c WHERE Purchase_Order__c =: assign.rsmObj.Id AND POLI_Status__c NOT IN(:POLI_Status_Rejected, :POLI_Status_Cancelled, :POLI_Status_Partially_Received, :POLI_Status_Closed)]){
        	Decimal qtyOrdered  = POL.Qty_Ordered__c != null ? POL.Qty_Ordered__c : 0;
            Decimal CubicVolume = (POL.Product_Name__r.MOQ__c == 1 && POL.Product_Name__r.Unit_Cubic_Volume__c != null) ? POL.Product_Name__r.Unit_Cubic_Volume__c : (POL.Product_Name__r.MOQ__c > 1 && POL.Product_Name__r.Case_Cubic_Volume__c != null) ? POL.Product_Name__r.Case_Cubic_Volume__c : 0;
            totalCubicVolume += qtyOrdered * CubicVolume;	    
        }
        r.data.put('totalCubicVolume', totalCubicVolume);
        
        decimal totalOrderCubicVolumeCapacity = 0;
        for(Purchase_Order_Line__c POL : [SELECT Id,Qty_Ordered__c,Product_Name__c,Product_Name__r.Unit_Cubic_Volume__c,Product_Name__r.Case_Cubic_Volume__c,Product_Name__r.MOQ__c FROM Purchase_Order_Line__c WHERE POLI_Status__c NOT IN(:POLI_Status_Rejected, :POLI_Status_Cancelled,:POLI_Status_Partially_Received, :POLI_Status_Closed) AND Purchase_Order__r.Planned_Ship_Transfer_Date__c =: assign.rsmObj.Planned_Ship_Transfer_Date__c AND Purchase_Order__r.Planned_Ship_Transfer_Date__c != null AND Purchase_Order__r.Vehicle__c =: assign.rsmObj.Vehicle__c AND Purchase_Order__r.Vehicle__c != null]){
        	Decimal qtyOrdered  = POL.Qty_Ordered__c != null ? POL.Qty_Ordered__c : 0;
            Decimal CubicVolume = (POL.Product_Name__r.MOQ__c == 1 && POL.Product_Name__r.Unit_Cubic_Volume__c != null) ? POL.Product_Name__r.Unit_Cubic_Volume__c : (POL.Product_Name__r.MOQ__c > 1 && POL.Product_Name__r.Case_Cubic_Volume__c != null) ? POL.Product_Name__r.Case_Cubic_Volume__c : 0;
            totalOrderCubicVolumeCapacity += qtyOrdered * CubicVolume;	    
        }
        
        Id devRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM).getRecordTypeId();
        Map<String,Decimal>rsmTotalCVMap = new Map<String,Decimal>();
        for(AggregateResult aggRes : [SELECT Shipping_Manifest__c,SUM(Picklist_Line__r.Inventory_Position__r.Total_Product_Volume__c) FROM Shipping_Manifest_Line__c where Shipping_Manifest__c IN: assign.rsmList AND Shipping_Manifest__r.RecordType.Id !=: devRecordTypeId /*AND SMLine_Status__c NOT IN(:SM_Line_Status_Shipment_Complete, :Shipping_Manifest_LineStatus_Cancelled, :Shipping_Manifest_LineStatus_Rejected)*/ GROUP BY Shipping_Manifest__c]){
            decimal rsmTotalCV = aggRes.get('expr0') != null ? decimal.Valueof(''+aggRes.get('expr0')) : 0;
            rsmTotalCVMap.put(''+aggres.get('Shipping_Manifest__c'),rsmTotalCV);
            totalOrderCubicVolumeCapacity += rsmTotalCV;
        }
        for(Shipping_Manifest__c SM : [SELECT Id, (SELECT Id,Qty_Ordered__c,Product_Name__c,Product_Name__r.Unit_Cubic_Volume__c,Product_Name__r.Case_Cubic_Volume__c,Product_Name__r.MOQ__c FROM Shipping_Manifest_Lines__r /*WHERE SMLine_Status__c NOT IN(:SM_Line_Status_Shipment_Complete, :Shipping_Manifest_LineStatus_Cancelled, :Shipping_Manifest_LineStatus_Rejected) AND Shipping_Manifest__r.Status__c !=: Shipping_Manifest_Status_Received*/) FROM Shipping_Manifest__c where Id IN: assign.rsmList AND RecordType.Id =: devRecordTypeId]){
        	Decimal rsmTotalCV = 0;
            for(Shipping_Manifest_Line__c SML : SM.Shipping_Manifest_Lines__r){
                Decimal qtyOrdered  = SML.Qty_Ordered__c != null ? SML.Qty_Ordered__c : 0;
                Decimal CubicVolume = (SML.Product_Name__r.MOQ__c == 1 && SML.Product_Name__r.Unit_Cubic_Volume__c != null) ? SML.Product_Name__r.Unit_Cubic_Volume__c : (SML.Product_Name__r.MOQ__c > 1 && SML.Product_Name__r.Case_Cubic_Volume__c != null) ? SML.Product_Name__r.Case_Cubic_Volume__c : 0;
                rsmTotalCV += qtyOrdered * CubicVolume;	    
            }
            rsmTotalCVMap.put(SM.Id,rsmTotalCV);            
        }
        r.data.put('rsmTotalCVMap', rsmTotalCVMap);
        
        Map<String,Decimal>tsmTotalCVMap = new Map<String,Decimal>();
        for(AggregateResult aggRes : [SELECT Shipping_Manifest__c,SUM(Picklist_Line__r.Inventory_Position__r.Total_Product_Volume__c) FROM Shipping_Manifest_Line__c where Shipping_Manifest__c IN: assign.tsmList AND Shipping_Manifest__r.RecordType.Id !=: devRecordTypeId /*AND SMLine_Status__c NOT IN(:SM_Line_Status_Shipment_Complete, :Shipping_Manifest_LineStatus_Cancelled, :Shipping_Manifest_LineStatus_Rejected)*/ GROUP BY Shipping_Manifest__c]){
            decimal rsmTotalCV = aggRes.get('expr0') != null ? decimal.Valueof(''+aggRes.get('expr0')) : 0;
            tsmTotalCVMap.put(''+aggres.get('Shipping_Manifest__c'),rsmTotalCV);
            totalOrderCubicVolumeCapacity += rsmTotalCV;
        }
        for(Shipping_Manifest__c SM : [SELECT Id, (SELECT Id,Qty_Ordered__c,Product_Name__c,Product_Name__r.Unit_Cubic_Volume__c,Product_Name__r.Case_Cubic_Volume__c,Product_Name__r.MOQ__c FROM Shipping_Manifest_Lines__r /*WHERE SMLine_Status__c NOT IN(:SM_Line_Status_Shipment_Complete, :Shipping_Manifest_LineStatus_Cancelled, :Shipping_Manifest_LineStatus_Rejected) AND Shipping_Manifest__r.Status__c !=: Shipping_Manifest_Status_Received*/) FROM Shipping_Manifest__c where Id IN: assign.tsmList AND RecordType.Id =: devRecordTypeId]){
        	Decimal rsmTotalCV = 0;
            for(Shipping_Manifest_Line__c SML : SM.Shipping_Manifest_Lines__r){
                Decimal qtyOrdered  = SML.Qty_Ordered__c != null ? SML.Qty_Ordered__c : 0;
                Decimal CubicVolume = (SML.Product_Name__r.MOQ__c == 1 && SML.Product_Name__r.Unit_Cubic_Volume__c != null) ? SML.Product_Name__r.Unit_Cubic_Volume__c : (SML.Product_Name__r.MOQ__c > 1 && SML.Product_Name__r.Case_Cubic_Volume__c != null) ? SML.Product_Name__r.Case_Cubic_Volume__c : 0;
                rsmTotalCV += qtyOrdered * CubicVolume;	    
            }
            tsmTotalCVMap.put(SM.Id,rsmTotalCV);            
        }
        r.data.put('tsmTotalCVMap', tsmTotalCVMap);
        
        r.data.put('totalOrderCubicVolumeCapacity', totalOrderCubicVolumeCapacity);
        
        decimal estimatedVehiclUtilized = 0;
        if(assignedVehicleId != assign.rsmObj.Vehicle__c || assignedVehicleDate != assign.rsmObj.Planned_Ship_Transfer_Date__c)
            estimatedVehiclUtilized = totalCubicVolume + totalOrderCubicVolumeCapacity; 
        else
            estimatedVehiclUtilized = totalOrderCubicVolumeCapacity; 
        
        r.data.put('estimatedVehiclUtilized', estimatedVehiclUtilized);
        
        return r;
    }
    
  
    
    /**
     * Check validation to create invoice
     *
     * @return Boolean flag to indicate if any validation fails
     */
    public static Boolean checkValidation(Purchase_Order__c rsmObj){
    	Boolean hasValidationError = false;    
        // Check for Vehicle value
        if(rsmObj.Id != null && rsmObj.Vehicle__c == null){
            hasValidationError = true;
            message = Label.Select_Vehicle;
        }
        return hasValidationError;
    }
    
    /**
     * Check validation to create invoice
     *
     * @return Boolean flag to indicate if any validation fails
     */
    public Boolean checkValidation(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        
        // Check for Vehicle value
        if(rsmObj.Id != null && rsmObj.Vehicle__c == null){
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, Label.Select_Vehicle);
            ApexPages.addMessage(message);
        }
        return hasValidationError;
    }
    
    /**
     * Cancel action - Redirect to RSM detail page
     *
     * @return PageReference
     */
    public PageReference cancelAction() {
        return redirectToRSM();
    }
    
    /**
     * Redirect to RSM detail page
     *
     * @return PageReference
     */         
    public PageReference redirectToRSM() {
        PageReference pageRef = null;
        if(stdController != null){
            pageRef = stdController.view().setRedirect(true);
        }
        return pageRef;
    }

}