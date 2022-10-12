/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * AssignVehicleToSalesOrderCtlr
 */
public class AssignVehicleToSalesOrderCtlr{

    private ApexPages.StandardController stdController;
    public Sales_Order__c rsmObj {get; set;}
    public List<Shipping_Manifest__c> rsmList {get; set;}
    public List<Shipping_Manifest__c> tsmList {get; set;}
    public List<Sales_Order_Line__c> getSOLineList {get; set;}
    public Integer refProductCount {get; set;}
    public Vehicles__c vehicleObj {get; set;}
    public Integer totalProduct {get; set;}
    private Id rsmRecordTypeId;
    private Id tsmRecordTypeId;
    public static String message {get;set;}
    
    
    public Static String SHIPPING_MANIFEST_RECORDTYPE_RSM{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_RSM) ? SHIPPING_MANIFEST_RECORDTYPE_RSM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_RSM');
        }set;
    } 
    
    public Static String SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM{
        get{
            return String.isNotBlank(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM) ? SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_RecordType_ProductTSM');
        }set;
    } 
    public Static String PRODUCT_FAMILY_STRING_CONCENTRATES{
        get{
            return String.isNotBlank(PRODUCT_FAMILY_STRING_CONCENTRATES) ? PRODUCT_FAMILY_STRING_CONCENTRATES: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Family_String_Concentrates');
        }set;
    } 
    public Static String PRODUCT_FAMILY_STRING_EDIBLES{
        get{
            return String.isNotBlank(PRODUCT_FAMILY_STRING_EDIBLES) ? PRODUCT_FAMILY_STRING_EDIBLES: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Family_String_Edibles');
        }set;
    } 
    public Static String PRODUCT_FAMILY_STRING_LIVEPLANTS{
        get{
            return String.isNotBlank(PRODUCT_FAMILY_STRING_LIVEPLANTS) ? PRODUCT_FAMILY_STRING_LIVEPLANTS: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Product_Family_String_Live_plants');
        }set;
    } 
    
    public Static String ERR_MSG_SELECT_VEHICLE{
        get{
            return String.isNotBlank(ERR_MSG_SELECT_VEHICLE) ? ERR_MSG_SELECT_VEHICLE: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Vehicle','Err_Msg_Select_Vehicle');
        }set;
    } 
    
    public Static String Sales_Order_Line_Status_Cancelled{
        get{
            return String.isNotBlank(Sales_Order_Line_Status_Cancelled) ? Sales_Order_Line_Status_Cancelled: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Cancelled');
        }set;
    }
    public Static String Sales_Order_Line_Status_Rejected{
        get{
            return String.isNotBlank(Sales_Order_Line_Status_Rejected) ? Sales_Order_Line_Status_Rejected: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Rejected');
        }set;
    }
    public Static String Sales_Order_Line_Status_Shipment_Complet{
        get{
            return String.isNotBlank(Sales_Order_Line_Status_Shipment_Complet) ? Sales_Order_Line_Status_Shipment_Complet: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order Line','Sales_Order_Line_Status_Shipment_Complet');
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
    public Static String Shipping_Manifest_Status_Received{
        get{
            return String.isNotBlank(Shipping_Manifest_Status_Received) ? Shipping_Manifest_Status_Received: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Received');
        }set;
    }
    // Standard controller constructor
    public AssignVehicleToSalesOrderCtlr(ApexPages.StandardController controller) {
        this.stdController = controller;
        rsmObj = (Sales_Order__c)stdController.getRecord();
        rsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_RSM).getRecordTypeId();
        tsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM).getRecordTypeId();
        reset();
    }
    
    //  Default constructor
    public AssignVehicleToSalesOrderCtlr() {
        reset();
    }
    
    @AuraEnabled
    public static AuraResponse assignVehicleToSalesOrder(String recordId){
    	AuraResponse r = new AuraResponse('AssignVehicleToSalesOrderCtlr.AssignVehicleToSalesOrder()');
        
        AssignVehicleToSalesOrderCtlr assign = new AssignVehicleToSalesOrderCtlr();
        assign.rsmObj = [select Id,Name,Vehicle__c,Vehicle__r.Name,Driver__c,Total_Line_Items__c from Sales_Order__c where Id = :recordId limit 1];
        assign.rsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_RSM).getRecordTypeId();
        assign.tsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM).getRecordTypeId();
        assign.reset();
        assign.doPrepare();
        
        List<Sales_Order_Line__c> getSOLineList = [Select Id, Product_Name__r.Name from Sales_Order_Line__c  WHERE Sales_Order__c= :recordId AND (Product_Name__r.Family=:PRODUCT_FAMILY_STRING_CONCENTRATES OR Product_Name__r.Family=:PRODUCT_FAMILY_STRING_EDIBLES OR Product_Name__r.Family=:PRODUCT_FAMILY_STRING_LIVEPLANTS)];
        assign.refProductCount = getSOLineList.size();
        
        r.data.put('refProductCount', assign.refProductCount);
        r.data.put('rsmObj', assign.rsmObj);
        r.data.put('rsmList', assign.rsmList);
        r.data.put('tsmList', assign.tsmList);
        r.data.put('vehicleObj', assign.vehicleObj);
        
        decimal totalOrderCubicVolumeCapacity = 0;
        AggregateResult[] groupedResults = [SELECT SUM(Total_Product_Volume__c) FROM Inventory_Position__c where Sales_Order_Line__r.Sales_Order__c =: recordId AND Sales_Order_Line__r.Status__c NOT IN(:Sales_Order_Line_Status_Cancelled, :Sales_Order_Line_Status_Rejected, :Sales_Order_Line_Status_Shipment_Complet)];
		decimal totalCubicVolume = groupedResults.size() > 0 && groupedResults[0].get('expr0') != null ? decimal.Valueof(''+groupedResults[0].get('expr0')) : 0;
        r.data.put('totalCubicVolume', totalCubicVolume);        
        
        r.data.put('assignedVehicleId', assign.rsmObj.Vehicle__c);  
        r.data.put('assignedVehicleDate', assign.rsmObj.Planned_Ship_Date__c);  
        
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
            totalOrderCubicVolumeCapacity += rsmTotalCV;
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
            totalOrderCubicVolumeCapacity += rsmTotalCV;
            tsmTotalCVMap.put(SM.Id,rsmTotalCV);            
        }
        r.data.put('tsmTotalCVMap', tsmTotalCVMap);
        
        if(assign.rsmList.size() == 0 &&  assign.tsmList.size() == 0){
        	AggregateResult[] groupedResults2 = [SELECT SUM(Total_Product_Volume__c) FROM Inventory_Position__c where Sales_Order_Line__r.Status__c NOT IN(:Sales_Order_Line_Status_Cancelled, :Sales_Order_Line_Status_Rejected, :Sales_Order_Line_Status_Shipment_Complet) AND Sales_Order_Line__r.Sales_Order__r.Planned_Ship_Date__c =: assign.rsmObj.Planned_Ship_Date__c AND Sales_Order_Line__r.Sales_Order__r.Planned_Ship_Date__c != null AND Sales_Order_Line__r.Sales_Order__r.Vehicle__c =: assign.rsmObj.Vehicle__c AND Sales_Order_Line__r.Sales_Order__r.Vehicle__c != null];
        	totalOrderCubicVolumeCapacity += groupedResults2.size() > 0 && groupedResults2[0].get('expr0') != null ? decimal.Valueof(''+groupedResults2[0].get('expr0')) : 0;
        }
        
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
            rsmObj = new Sales_Order__c();
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
     * Assign Vehicle to RSM
     *
     * @return PageReference of RSM detail page
     */
    @AuraEnabled
    public static AuraResponse assignVehicle(Sales_Order__c order) {
        AuraResponse r = new AuraResponse('AssignVehicleToSalesOrderCtlr.assignVehicle()');
        
        AssignVehicleToSalesOrderCtlr assign = new AssignVehicleToSalesOrderCtlr();
        
        assign.rsmObj = order;
        // Perform validations for required field Vehicle
        if(checkValidation(assign.rsmObj)){
            r.data.put('errorMessage', message);
            return r;
        }
        
        try {
            update assign.rsmObj;
        } 
        catch (Exception ex){
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
     * Retrieve RSM with lines record
     *
     * @return blank page reference
     */         
    public PageReference doPrepare() {
        if(rsmObj != null && rsmObj.Id != null){
            // Retrieve RSM details
            rsmObj = [Select Name, Vehicle__c,Vehicle__r.Name, Planned_Ship_Date__c,Total_Line_Items__c From Sales_Order__c Where Id =: rsmObj.Id];
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
            vehicleObj = [Select Name, Vehicle_Cubic_Volume_Capacity__c, Vehicle_Height__c, Vehicle_in_Use__c, Vehicle_Length__c,
                          Vehicle_License_Plate_Number__c, Vehicle_Make__c, Vehicle_Model__c, Vehicle_Width__c From Vehicles__c Where Id =: rsmObj.Vehicle__c];
            
            Date plannedDate = rsmObj.Planned_Ship_Date__c;
            Id vehicleObjId = vehicleObj.Id;
            
            String rsmQuery = 'Select Name, Vehicle__c,Driver__c,Driver__r.Name, Planned_Ship_Transfer_Date__c, Status__c, Route_Miles__c,Total_Route_Miles__c,Actual_Departure_Date_Time__c, ' +
                'Receiver_Acceptance_Date__c,Sales_Order__c,Sales_Order__r.Name,Total_Line_Items__c From Shipping_Manifest__c ' +
                'Where Vehicle__c =: vehicleObjId ' +
                'AND RecordTypeId =: rsmRecordTypeId ';
            if(rsmObj.Id != null){
                rsmQuery += 'AND Planned_Ship_Transfer_Date__c =: plannedDate ';
            }
            rsmQuery += ' AND Status__c NOT IN(:Shipping_Manifest_Status_Complete, :Shipping_Manifest_Status_Cancelled,:Shipping_Manifest_Status_Received)';
            rsmQuery += 'Order By Receiver_Acceptance_Date__c DESC NULLS FIRST';
            rsmList = Database.query(rsmQuery);
            
            String tsmQuery = 'Select Name, Vehicle__c,Driver__c,Driver__r.Name, Planned_Ship_Transfer_Date__c, Status__c,Total_Route_Miles__c, Route_Miles__c,' +
                'Actual_Departure_Date_Time__c, Actual_Arrival_Date_Time__c,Purchase_Order__c,Purchase_Order__r.Name,Total_Line_Items__c From Shipping_Manifest__c ' +
                'Where Vehicle__c =: vehicleObjId ' +
                'AND RecordTypeId =: tsmRecordTypeId ';
            tsmQuery += ' AND Status__c NOT IN(:Shipping_Manifest_Status_Received)';
            if(rsmObj.Id != null){
                tsmQuery += 'AND Planned_Ship_Transfer_Date__c =: plannedDate ';
            }
            tsmQuery += 'Order By Actual_Arrival_Date_Time__c DESC NULLS FIRST';
            tsmList = Database.query(tsmQuery);
        }
        return null;
    }
    
    /**
     * Retrieve TSM with lines record
     *
     * @return blank page reference
     */   
    @AuraEnabled
    public static AuraResponse retrieveVehicleAndRelated(Sales_Order__c order,String assignedVehicleId,String assignedVehicleDateStr){
        
        Date assignedVehicleDate = assignedVehicleDateStr != null && assignedVehicleDateStr != '' ? date.valueOf(assignedVehicleDateStr) : null;
        AuraResponse r = new AuraResponse('AssignVehicleToSalesOrderCtlr.retrieveVehicleAndRelated()');
        
        AssignVehicleToSalesOrderCtlr assign = new AssignVehicleToSalesOrderCtlr();
        assign.rsmObj = order;
        assign.rsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_RSM).getRecordTypeId();
        assign.tsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM).getRecordTypeId();
        assign.reset();
        if(assign.rsmObj.Vehicle__c != NULL && !String.isBlank(assign.rsmObj.Vehicle__c)){
            assign.vehicleObj = [Select Name, Vehicle_Cubic_Volume_Capacity__c,Vehicle_Height__c,Vehicle_in_Use__c,
                                 Vehicle_Length__c,Vehicle_License_Plate_Number__c,Vehicle_Make__c,Vehicle_Model__c,Vehicle_Width__c
                                 From Vehicles__c
                                 Where Id =: assign.rsmObj.Vehicle__c];
            Date plannedDate = assign.rsmObj.Planned_Ship_Date__c;
            Id vehicleObjId = assign.vehicleObj.Id;
            
            String rsmQuery = 'Select Name, Vehicle__c,Driver__c,Driver__r.Name, Planned_Ship_Transfer_Date__c, Status__c, Route_Miles__c,Total_Route_Miles__c,Actual_Departure_Date_Time__c, ' +
                'Receiver_Acceptance_Date__c,Sales_Order__c,Sales_Order__r.Name,Total_Line_Items__c From Shipping_Manifest__c ' +
                'Where Vehicle__c =: vehicleObjId ' +
                'AND RecordTypeId =\''+ String.escapeSingleQuotes(assign.rsmRecordTypeId)+'\' ';
            if(assign.rsmObj.Id != null){
                rsmQuery += 'AND Planned_Ship_Transfer_Date__c =: plannedDate ';
            }
            rsmQuery += ' AND Status__c NOT IN(:Shipping_Manifest_Status_Complete, :Shipping_Manifest_Status_Cancelled, :Shipping_Manifest_Status_Received)';
            rsmQuery += 'Order By Receiver_Acceptance_Date__c DESC NULLS FIRST';
            assign.rsmList = Database.query(rsmQuery);
            
            String tsmQuery = 'Select Name, Vehicle__c,Driver__c,Driver__r.Name, Planned_Ship_Transfer_Date__c, Status__c,Total_Route_Miles__c, Route_Miles__c,' +
                'Actual_Departure_Date_Time__c, Actual_Arrival_Date_Time__c,Purchase_Order__c,Purchase_Order__r.Name,Total_Line_Items__c From Shipping_Manifest__c ' +
                'Where Vehicle__c =: vehicleObjId ' +
                'AND RecordTypeId =\''+ String.escapeSingleQuotes(assign.tsmRecordTypeId)+'\' ';
            if(assign.rsmObj.Id != null){
                tsmQuery += 'AND Planned_Ship_Transfer_Date__c =: plannedDate ';
            }
            tsmQuery += ' AND Status__c NOT IN(:Shipping_Manifest_Status_Complete, :Shipping_Manifest_Status_Cancelled, :Shipping_Manifest_Status_Received)';
            tsmQuery += 'Order By Actual_Arrival_Date_Time__c DESC NULLS FIRST';
            assign.tsmList = Database.query(tsmQuery);
        }
        r.data.put('rsmObj', assign.rsmObj);
        r.data.put('rsmList', assign.rsmList);
        r.data.put('tsmList', assign.tsmList);
        r.data.put('vehicleObj', assign.vehicleObj);
        
        decimal totalOrderCubicVolumeCapacity = 0;
        AggregateResult[] groupedResults = [SELECT SUM(Total_Product_Volume__c) FROM Inventory_Position__c where Sales_Order_Line__r.Sales_Order__c =: assign.rsmObj.Id AND Sales_Order_Line__r.Status__c NOT IN(:Sales_Order_Line_Status_Cancelled, :Sales_Order_Line_Status_Rejected, :Sales_Order_Line_Status_Shipment_Complet)];
        decimal totalCubicVolume = groupedResults.size() > 0 && groupedResults[0].get('expr0') != null ? decimal.Valueof(''+groupedResults[0].get('expr0')) : 0;
        r.data.put('totalCubicVolume', totalCubicVolume);
        
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
            totalOrderCubicVolumeCapacity += rsmTotalCV;
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
            totalOrderCubicVolumeCapacity += rsmTotalCV;
            tsmTotalCVMap.put(SM.Id,rsmTotalCV);            
        }
        r.data.put('tsmTotalCVMap', tsmTotalCVMap);
        
        if(assign.rsmList.size() ==0 &&  assign.tsmList.size() ==0 ){
        	AggregateResult[] groupedResults2 = [SELECT SUM(Total_Product_Volume__c) FROM Inventory_Position__c where Sales_Order_Line__r.Status__c NOT IN(:Sales_Order_Line_Status_Cancelled, :Sales_Order_Line_Status_Rejected, :Sales_Order_Line_Status_Shipment_Complet) AND Sales_Order_Line__r.Sales_Order__r.Planned_Ship_Date__c =: assign.rsmObj.Planned_Ship_Date__c AND Sales_Order_Line__r.Sales_Order__r.Planned_Ship_Date__c != null AND Sales_Order_Line__r.Sales_Order__r.Vehicle__c =: assign.rsmObj.Vehicle__c AND Sales_Order_Line__r.Sales_Order__r.Vehicle__c != null];
        	totalOrderCubicVolumeCapacity += groupedResults2.size() > 0 && groupedResults2[0].get('expr0') != null ? decimal.Valueof(''+groupedResults2[0].get('expr0')) : 0;
        }
        
        r.data.put('totalOrderCubicVolumeCapacity', totalOrderCubicVolumeCapacity);
        
        decimal estimatedVehiclUtilized = 0;
        if(assignedVehicleId != assign.rsmObj.Vehicle__c || assignedVehicleDate != assign.rsmObj.Planned_Ship_Date__c)
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
    public Boolean checkValidation(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        
        // Check for Vehicle value
        if(rsmObj.Id != null && rsmObj.Vehicle__c == null){
            hasValidationError = true;
            message = new ApexPages.Message(ApexPages.Severity.ERROR, ERR_MSG_SELECT_VEHICLE);
            ApexPages.addMessage(message);
        }
        return hasValidationError;
    }
    
    
    public static Boolean checkValidation(Sales_Order__c rsmObj){
        Boolean hasValidationError = false;
        
        // Check for Vehicle value
        if(rsmObj.Id != null && rsmObj.Vehicle__c == null){
            hasValidationError = true;
            message = Label.Select_Vehicle;
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