public class AssignDriverVehicleToPOCtlr{
    private ApexPages.StandardController stdController;
    Public Static String message{
        get{
            return String.isNotBlank(message) ? message : Label.Select_Vehicle;
        }set;
    }
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
    public Static String Shipping_Manifest_Status_Rejected{
        get{
            return String.isNotBlank(Shipping_Manifest_Status_Rejected) ? Shipping_Manifest_Status_Rejected: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Shipping Manifest','Shipping_Manifest_Status_Rejected');
        }set;
    } 
    public Static String Err_Msg_Select_Vehicle_Name{
        get{
            return String.isNotBlank(Err_Msg_Select_Vehicle_Name) ? Err_Msg_Select_Vehicle_Name: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Err_Msg_Select_Vehicle_Name');
        }set;
    } 
    public Static String Err_Msg_Select_Driver_Name{
        get{
            return String.isNotBlank(Err_Msg_Select_Driver_Name) ? Err_Msg_Select_Driver_Name: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Err_Msg_Select_Driver_Name');
        }set;
    } 
    public Static String Err_Msg_Select_Planned_Transfer_Date{
        get{
            return String.isNotBlank(Err_Msg_Select_Planned_Transfer_Date) ? Err_Msg_Select_Planned_Transfer_Date: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Err_Msg_Select_Planned_Transfer_Date');
        }set;
    } 
    public Static String Success_Msg_Assigned_Driver_Vehicle{
        get{
            return String.isNotBlank(Success_Msg_Assigned_Driver_Vehicle) ? Success_Msg_Assigned_Driver_Vehicle: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Success_Msg_Assigned_Driver_Vehicle');
        }set;
    } 
    public AssignDriverVehicleToPOCtlr(ApexPages.StandardController controller) {
        this.stdController = controller;
    }
     public Static String REFRIGERATION_PRODUCT_FAMILIES{
        get{
            return String.isNotBlank(REFRIGERATION_PRODUCT_FAMILIES) ? REFRIGERATION_PRODUCT_FAMILIES: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Refrigeration Product Families');
        }set;
    }  
    @AuraEnabled
    public static AuraResponse init(String recordId){
        AuraResponse r = new AuraResponse('AssignDriverVehicleToPOCtl.init()'); 
        
        Purchase_Order__c rsmObj =[select Id, Name, Vehicle__c, Vehicle__r.Name, Driver__c, Driver__r.Name,Total_Line_Items__c,
				Planned_Ship_Transfer_Date__c, Ship_Confirmation_Date__c  from Purchase_Order__c where Id = :recordId limit 1];
        
           List<String> prodFamilies= REFRIGERATION_PRODUCT_FAMILIES.split(','); 
        List<Purchase_Order_Line__c> getPOLineList = [Select Id, Product_Name__r.Name from Purchase_Order_Line__c  WHERE 
				Purchase_Order__c= :recordId AND  Product_Name__r.Family IN: prodFamilies];
             
        r.data.put('refProductCount', getPOLineList.size());
        
        r.data.put('rsmObj', rsmObj);     
        r.data.put('assignedVehicleId', rsmObj.Vehicle__c); 
        r.data.put('assignedDriverId', rsmObj.Driver__c); 
        r.data.put('assignedDate', rsmObj.Planned_Ship_Transfer_Date__c);
        queryData(r,rsmObj,rsmObj.Vehicle__c,rsmObj.Driver__c,rsmObj.Planned_Ship_Transfer_Date__c);        
        return r;
    }  
    private static AuraResponse queryData(AuraResponse r,Purchase_Order__c rsmObj,String assignedVehicleId,String assignedDriverId,Date assignedDate){
    	List<Shipping_Manifest__c> rsmList = new List<Shipping_Manifest__c>();
        List<Shipping_Manifest__c> tsmList = new List<Shipping_Manifest__c>();
        Vehicles__c vehicleObj = new Vehicles__c();
        Drivers__c driverObj = new Drivers__c();
        Id driverObjId = null;
        Id vehicleObjId = null;
        Date plannedDate = rsmObj.Planned_Ship_Transfer_Date__c;
        Id rsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_RSM).getRecordTypeId();
        Id tsmRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM).getRecordTypeId();
        
        if(rsmObj.Driver__c != NULL && !String.isBlank(rsmObj.Driver__c)){
        	driverObj = [Select Name, Active__c, Driver_License_Class__c, Driver_License_Number__c, Expiration_Date__c, 
                         License_Expired__c, State_Issued__c From Drivers__c Where Id =: rsmObj.Driver__c]; 
            driverObjId = driverObj.Id;
        }
        
        if(rsmObj.Vehicle__c != NULL && !String.isBlank(rsmObj.Vehicle__c)){            
            vehicleObj = [Select Name, Vehicle_Cubic_Volume_Capacity__c, Vehicle_Height__c, Vehicle_in_Use__c, Vehicle_Length__c,
                          Vehicle_License_Plate_Number__c, Vehicle_Make__c, Vehicle_Model__c, Vehicle_Width__c From Vehicles__c Where Id =: rsmObj.Vehicle__c];
            vehicleObjId = vehicleObj.Id;
        }            
            
        String rsmQuery = 'Select Name, Vehicle__c, Driver__c, Driver__r.Name, Planned_Ship_Transfer_Date__c, Status__c, ' +
		'Route_Miles__c, Total_Route_Miles__c, Actual_Departure_Date_Time__c, Receiver_Acceptance_Date__c, Sales_Order__c, ' +
		'Sales_Order__r.Name, Total_Line_Items__c,Receiver_DBA__c,Receiver_License__r.License_City__c From Shipping_Manifest__c' +
        ' Where RecordTypeId =: rsmRecordTypeId AND Status__c NOT IN(:Shipping_Manifest_Status_Complete, ' + 
        ':Shipping_Manifest_Status_Cancelled, :Shipping_Manifest_Status_Received, :Shipping_Manifest_Status_Rejected)';
        
        if(plannedDate != null)
            rsmQuery += ' AND Planned_Ship_Transfer_Date__c =: plannedDate ';
        if(rsmObj.Vehicle__c != NULL && !String.isBlank(rsmObj.Vehicle__c))
			rsmQuery += ' AND Vehicle__c =: vehicleObjId';
		if(rsmObj.Driver__c != NULL && !String.isBlank(rsmObj.Driver__c))
			rsmQuery += ' AND Driver__c =: driverObjId';
             
        rsmQuery += ' Order By Receiver_Acceptance_Date__c DESC NULLS FIRST';
        rsmList = Database.query(rsmQuery);
        
        String tsmQuery = 'Select Name, Vehicle__c, Driver__c, Driver__r.Name, Planned_Ship_Transfer_Date__c, Status__c, ' +
		'Total_Route_Miles__c, Route_Miles__c, Actual_Departure_Date_Time__c, Actual_Arrival_Date_Time__c, Purchase_Order__c'+
		', Purchase_Order__r.Name, Total_Line_Items__c,Supplier_DBA__c,Supplier_License__r.License_City__c From ' + 
        'Shipping_Manifest__c Where RecordTypeId =: tsmRecordTypeId AND Status__c NOT IN(:Shipping_Manifest_Status_Complete, ' + 
        ':Shipping_Manifest_Status_Cancelled, :Shipping_Manifest_Status_Received, :Shipping_Manifest_Status_Rejected)';
        
        if(plannedDate != null)
            tsmQuery += ' AND Planned_Ship_Transfer_Date__c =: plannedDate ';
        if(rsmObj.Vehicle__c != NULL && !String.isBlank(rsmObj.Vehicle__c))
			tsmQuery += ' AND Vehicle__c =: vehicleObjId';
		if(rsmObj.Driver__c != NULL && !String.isBlank(rsmObj.Driver__c))
			tsmQuery += ' AND Driver__c =: driverObjId';
        
        tsmQuery += ' Order By Actual_Arrival_Date_Time__c DESC NULLS FIRST';
        tsmList = Database.query(tsmQuery); 
        
        decimal totalCubicVolume = 0;
        for(Purchase_Order_Line__c POL : [SELECT Id,Qty_Ordered__c,Product_Name__c,Product_Name__r.Unit_Cubic_Volume__c,Product_Name__r.Case_Cubic_Volume__c,Product_Name__r.MOQ__c FROM Purchase_Order_Line__c WHERE Purchase_Order__c =: rsmObj.Id AND POLI_Status__c NOT IN(:POLI_Status_Rejected, :POLI_Status_Cancelled, :POLI_Status_Partially_Received, :POLI_Status_Closed)]){
            Decimal qtyOrdered  = POL.Qty_Ordered__c != null ? POL.Qty_Ordered__c : 0;
            Decimal CubicVolume = (POL.Product_Name__r.MOQ__c == 1 && POL.Product_Name__r.Unit_Cubic_Volume__c != null) ? POL.Product_Name__r.Unit_Cubic_Volume__c : (POL.Product_Name__r.MOQ__c > 1 && POL.Product_Name__r.Case_Cubic_Volume__c != null) ? POL.Product_Name__r.Case_Cubic_Volume__c : 0;
            totalCubicVolume += qtyOrdered * CubicVolume;	    
        }
        r.data.put('totalCubicVolume', totalCubicVolume);
        
        decimal totalOrderCubicVolumeCapacity = 0;
        for(Purchase_Order_Line__c POL : [SELECT Id,Purchase_Order__c,Qty_Ordered__c,Product_Name__c,Product_Name__r.Unit_Cubic_Volume__c,Product_Name__r.Case_Cubic_Volume__c,Product_Name__r.MOQ__c FROM Purchase_Order_Line__c WHERE POLI_Status__c NOT IN(:POLI_Status_Rejected, :POLI_Status_Cancelled,:POLI_Status_Partially_Received, :POLI_Status_Closed) AND Purchase_Order__r.Planned_Ship_Transfer_Date__c =: rsmObj.Planned_Ship_Transfer_Date__c AND Purchase_Order__r.Planned_Ship_Transfer_Date__c != null AND Purchase_Order__r.Vehicle__c =: rsmObj.Vehicle__c AND Purchase_Order__r.Vehicle__c != null AND Purchase_Order__r.Driver__c =: rsmObj.Driver__c AND Purchase_Order__r.Driver__c != null]){
        	Decimal qtyOrdered  = POL.Qty_Ordered__c != null ? POL.Qty_Ordered__c : 0;
            Decimal CubicVolume = (POL.Product_Name__r.MOQ__c == 1 && POL.Product_Name__r.Unit_Cubic_Volume__c != null) ? POL.Product_Name__r.Unit_Cubic_Volume__c : (POL.Product_Name__r.MOQ__c > 1 && POL.Product_Name__r.Case_Cubic_Volume__c != null) ? POL.Product_Name__r.Case_Cubic_Volume__c : 0;
            totalOrderCubicVolumeCapacity += qtyOrdered * CubicVolume;	
        }
        
        Id devRecordTypeId = Schema.SObjectType.Shipping_Manifest__c.getRecordTypeInfosByName().get(SHIPPING_MANIFEST_RECORDTYPE_PRODUCTTSM).getRecordTypeId();
        Map<String,Decimal>rsmTotalCVMap = new Map<String,Decimal>();
        for(AggregateResult aggRes : [SELECT Shipping_Manifest__c,SUM(Picklist_Line__r.Inventory_Position__r.Total_Product_Volume__c) FROM Shipping_Manifest_Line__c where Shipping_Manifest__c IN: rsmList AND Shipping_Manifest__r.RecordType.Id !=: devRecordTypeId GROUP BY Shipping_Manifest__c]){
            decimal rsmTotalCV = aggRes.get('expr0') != null ? decimal.Valueof(''+aggRes.get('expr0')) : 0;
            rsmTotalCVMap.put(''+aggres.get('Shipping_Manifest__c'),rsmTotalCV);
            totalOrderCubicVolumeCapacity += rsmTotalCV;
        }
        for(Shipping_Manifest__c SM : [SELECT Id, (SELECT Id,Qty_Ordered__c,Product_Name__c,Product_Name__r.Unit_Cubic_Volume__c,Product_Name__r.Case_Cubic_Volume__c,Product_Name__r.MOQ__c FROM Shipping_Manifest_Lines__r) FROM Shipping_Manifest__c where Id IN: rsmList AND RecordType.Id =: devRecordTypeId]){
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
        for(AggregateResult aggRes : [SELECT Shipping_Manifest__c,SUM(Picklist_Line__r.Inventory_Position__r.Total_Product_Volume__c) FROM Shipping_Manifest_Line__c where Shipping_Manifest__c IN: tsmList AND Shipping_Manifest__r.RecordType.Id !=: devRecordTypeId GROUP BY Shipping_Manifest__c]){
            decimal rsmTotalCV = aggRes.get('expr0') != null ? decimal.Valueof(''+aggRes.get('expr0')) : 0;
            tsmTotalCVMap.put(''+aggres.get('Shipping_Manifest__c'),rsmTotalCV);
            totalOrderCubicVolumeCapacity += rsmTotalCV;
        }
        for(Shipping_Manifest__c SM : [SELECT Id,Purchase_Order__c, (SELECT Id,Qty_Ordered__c,Product_Name__c,Product_Name__r.Unit_Cubic_Volume__c,Product_Name__r.Case_Cubic_Volume__c,Product_Name__r.MOQ__c FROM Shipping_Manifest_Lines__r ) FROM Shipping_Manifest__c where Id IN: tsmList AND RecordType.Id =: devRecordTypeId]){
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
        if(assignedVehicleId != rsmObj.Vehicle__c || assignedDate != rsmObj.Planned_Ship_Transfer_Date__c || assignedDriverId != rsmObj.Driver__c)
        	estimatedVehiclUtilized = totalCubicVolume + totalOrderCubicVolumeCapacity;        
        else
            estimatedVehiclUtilized = totalOrderCubicVolumeCapacity;   
        r.data.put('estimatedVehiclUtilized', estimatedVehiclUtilized);
        
        Decimal totalCubicVolumePer = 0;
        Decimal totalOrderCubicVolumeCapacityPer = 0;
        Decimal estimatedVehiclUtilizedPer = 0;
        
        if(vehicleObj.Vehicle_Cubic_Volume_Capacity__c > 0 && totalCubicVolume > 0)
        	totalCubicVolumePer = (totalCubicVolume / vehicleObj.Vehicle_Cubic_Volume_Capacity__c) * 100;   
        
        if(vehicleObj.Vehicle_Cubic_Volume_Capacity__c > 0 && totalOrderCubicVolumeCapacity > 0)
        	totalOrderCubicVolumeCapacityPer = (totalOrderCubicVolumeCapacity / vehicleObj.Vehicle_Cubic_Volume_Capacity__c ) * 100;   
        
        if(vehicleObj.Vehicle_Cubic_Volume_Capacity__c > 0 && estimatedVehiclUtilized > 0)
        	estimatedVehiclUtilizedPer = (estimatedVehiclUtilized / vehicleObj.Vehicle_Cubic_Volume_Capacity__c ) * 100;           
        
        r.data.put('totalCubicVolumePer', totalCubicVolumePer.setScale(2));
        r.data.put('totalOrderCubicVolumeCapacityPer', totalOrderCubicVolumeCapacityPer.setScale(2));
        r.data.put('estimatedVehiclUtilizedPer', estimatedVehiclUtilizedPer.setScale(2));
        
        r.data.put('rsmList', rsmList);
        r.data.put('tsmList', tsmList);
        r.data.put('vehicleObj', vehicleObj);
        r.data.put('driverObj', driverObj);
        
        r.data.put('Err_Msg_Select_Vehicle_Name', Err_Msg_Select_Vehicle_Name);
        r.data.put('Err_Msg_Select_Driver_Name', Err_Msg_Select_Driver_Name);
        r.data.put('Err_Msg_Select_Planned_Transfer_Date', Err_Msg_Select_Planned_Transfer_Date);
        r.data.put('Success_Msg_Assigned_Driver_Vehicle', Success_Msg_Assigned_Driver_Vehicle);
        
        return r;
    }
    @AuraEnabled
    public static AuraResponse assignDriverVehicle(Purchase_Order__c order) {
        AuraResponse r = new AuraResponse('AssignDriverVehicleToPOCtlr.assignDriverVehicle()');           
        Purchase_Order__c rsmObj = order;        
        try {
            update rsmObj;
        } 
        catch (Exception ex){
            ErrorLogs.log('AssignDriverVehicleToPOCtlr:assignDriverVehicle()', 
                          ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            message = String.valueOf(msg);
            r.data.put('errorMessage', message);
            return r;
        }
        return r;
    }                     
    @AuraEnabled
    public static AuraResponse retrieveDriverVehicleAndRelated(Purchase_Order__c order,String assignedVehicleId,String assignedDriverId,String assignedDateStr){
        Date assignedDate = assignedDateStr != null && assignedDateStr != '' ? date.valueOf(assignedDateStr) : null;
        AuraResponse r = new AuraResponse('AssignDriverVehicleToPOCtlr.retrieveDriverVehicleAndRelated()');
        Purchase_Order__c rsmObj = order;
        r.data.put('rsmObj', rsmObj);
        queryData(r,rsmObj,assignedVehicleId,assignedDriverId,assignedDate);        
        return r;
    }
    public PageReference cancelAction() {
        return redirectToRSM();
    }            
    public PageReference redirectToRSM() {
        PageReference pageRef = null;
        if(stdController != null){
            pageRef = stdController.view().setRedirect(true);
        }
        return pageRef;
    }
}