public class AssignDriverVehicleToSalesOrderCtlr{
    private ApexPages.StandardController stdController;
     private static String EARLIEST_DELIVERY_TIME {
        get{
            return String.isNotBlank(EARLIEST_DELIVERY_TIME) ? EARLIEST_DELIVERY_TIME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Earliest_Delivery_Time');
        }set;
    }
    private static String LATEST_DELIVERY_TIME { 
        get{
            return String.isNotBlank(LATEST_DELIVERY_TIME) ? LATEST_DELIVERY_TIME : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Order','Latest_Delivery_Time');
        }set;
    }
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
     public Static String REFRIGERATION_PRODUCT_FAMILIES{
        get{
            return String.isNotBlank(REFRIGERATION_PRODUCT_FAMILIES) ? REFRIGERATION_PRODUCT_FAMILIES: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Product','Refrigeration Product Families');
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
    public Static String Err_Msg_Select_Planned_Ship_Date{
        get{
            return String.isNotBlank(Err_Msg_Select_Planned_Ship_Date) ? Err_Msg_Select_Planned_Ship_Date: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Err_Msg_Select_Planned_Ship_Date');
        }set;
    } 
    public Static String Success_Msg_Assigned_Driver_Vehicle{
        get{
            return String.isNotBlank(Success_Msg_Assigned_Driver_Vehicle) ? Success_Msg_Assigned_Driver_Vehicle: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Sales Order','Success_Msg_Assigned_Driver_Vehicle');
        }set;
    } 
    public AssignDriverVehicleToSalesOrderCtlr(ApexPages.StandardController controller) {
        this.stdController = controller;
    }
    
     private static String RECURSYEARLY{
        get{
            return String.isNotBlank(RECURSYEARLY) ? RECURSYEARLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursYearly');
        }set;
    }
    private static String RECURSYEARLYNTH{
        get{
            return String.isNotBlank(RECURSYEARLYNTH) ? RECURSYEARLYNTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursYearlyNth');
        }set;
    }
    public static String HOLIDAY_RECURSMONTHLY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSMONTHLY) ? HOLIDAY_RECURSMONTHLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursMonthly');
        }set;
    }
    public static String HOLIDAY_RECURSMONTHLYNTH{
        get{
            return String.isNotBlank(HOLIDAY_RECURSMONTHLYNTH) ? HOLIDAY_RECURSMONTHLYNTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursMonthlyNth');
        }set;
    }
    public static String HOLIDAY_RECURSWEEKLY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSWEEKLY) ? HOLIDAY_RECURSWEEKLY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursWeekly');
        }set;
    }
    public static String HOLIDAY_RECURSDAILY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSDAILY) ? HOLIDAY_RECURSDAILY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursDaily');
        }set;
    }
    public static String HOLIDAY_RECURSEVERYWEEKDAY{
        get{
            return String.isNotBlank(HOLIDAY_RECURSEVERYWEEKDAY) ? HOLIDAY_RECURSEVERYWEEKDAY : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_RecursEveryWeekday');
        }set;
    }
    private static String JANUARY_MONTH{
        get{
            return String.isNotBlank(JANUARY_MONTH) ? JANUARY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','January_Month');
        }set;
    }
    private static String FEBRUARY_MONTH{
        get{
            return String.isNotBlank(FEBRUARY_MONTH) ? FEBRUARY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','February_Month');
        }set;
    }
    private static String MARCH_MONTH{
        get{
            return String.isNotBlank(MARCH_MONTH) ? MARCH_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','March_Month');
        }set;
    }
    private static String APRIL_MONTH{
        get{
            return String.isNotBlank(APRIL_MONTH) ? APRIL_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','April_Month');
        }set;
    }
    public static String MAY_MONTH{
        get{
            return String.isNotBlank(MAY_MONTH) ? MAY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','May_Month');
        }set;
    }
    public static String JUNE_MONTH{
        get{
            return String.isNotBlank(JUNE_MONTH) ? JUNE_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','June_Month');
        }set;
    }
    public static String JULY_MONTH{
        get{
            return String.isNotBlank(JULY_MONTH) ? JULY_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','July_Month');
        }set;
    }
    public static String AUGUST_MONTH{
        get{
            return String.isNotBlank(AUGUST_MONTH) ? AUGUST_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','August_Month');
        }set;
    }
    public static String SEPTEMBER_MONTH{
        get{
            return String.isNotBlank(SEPTEMBER_MONTH) ? SEPTEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','September_Month');
        }set;
    }
    public static String OCTOBER_MONTH{
        get{
            return String.isNotBlank(OCTOBER_MONTH) ? OCTOBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','October_Month');
        }set;
    }
    public static String NOVEMBER_MONTH{
        get{
            return String.isNotBlank(NOVEMBER_MONTH) ? NOVEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','November_Month');
        }set;
    }
    public static String DECEMBER_MONTH{
        get{
            return String.isNotBlank(DECEMBER_MONTH) ? DECEMBER_MONTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Month Name','December_Month');
        }set;
    }
    public static String HOLIDAY_RECURRENCE_FIRST{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_FIRST) ? HOLIDAY_RECURRENCE_FIRST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_First');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_SECOND{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_SECOND) ? HOLIDAY_RECURRENCE_SECOND : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Second');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_THIRD{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_THIRD) ? HOLIDAY_RECURRENCE_THIRD : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Third');
        }set;
    }
    private static String HOLIDAY_RECURRENCE_FOURTH{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_FOURTH) ? HOLIDAY_RECURRENCE_FOURTH : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Fourth');
        }set;
    }
    public static String HOLIDAY_RECURRENCE_LAST{
        get{
            return String.isNotBlank(HOLIDAY_RECURRENCE_LAST) ? HOLIDAY_RECURRENCE_LAST : FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Holiday','Holiday_Recurrence_Last');
        }set;
    }
    
    
    @AuraEnabled
    public static AuraResponse init(String recordId){
        AuraResponse r = new AuraResponse('AssignDriverVehicleToSalesOrderCtlr.init()'); 
        
        Sales_Order__c rsmObj = [select Id,Name,Vehicle__c,Vehicle__r.Name,Driver__c,Driver__r.Name,Total_Line_Items__c,Window_End__c,Window_Start__c, 
                                 Planned_Ship_Date__c from Sales_Order__c where Id = :recordId limit 1];
        
		 String earTime='None';
        String latTime = 'None';
        if( rsmObj.Window_Start__c != null && rsmObj.Window_End__c != null){
            
            String[] strTimeSplit = String.valueOf(rsmObj.Window_Start__c).split(':');
            earTime = Integer.valueOf(strTimeSplit[0]) > 12 ? String.valueOf(Integer.valueOf(strTimeSplit[0]) - 12)+':'+strTimeSplit[1]+' PM' : (Integer.valueOf(strTimeSplit[0]) == 0 ? '12' : strTimeSplit[0] )+':'+strTimeSplit[1]+(Integer.valueOf(strTimeSplit[0]) == 12 ?' PM': ' AM');
            
            String[] strTimelateSplit = String.valueOf(rsmObj.Window_End__c).split(':');
            latTime = Integer.valueOf(strTimelateSplit[0]) > 12 ? String.valueOf(Integer.valueOf(strTimelateSplit[0]) - 12)+':'+strTimelateSplit[1]+' PM' : (Integer.valueOf(strTimelateSplit[0]) == 0 ? '12' : strTimelateSplit[0] ) +':'+strTimelateSplit[1]+(Integer.valueOf(strTimeSplit[0]) == 12 ?' PM': ' AM');
        }
        r.data.put('earTime', earTime);
        r.data.put('latTime', latTime);     
         List<String> prodFamilies= REFRIGERATION_PRODUCT_FAMILIES.split(','); 
        List<Sales_Order_Line__c> getSOLineList = [Select Id, Product_Name__r.Name from Sales_Order_Line__c  WHERE 
				Sales_Order__c= :recordId AND  Product_Name__r.Family IN: prodFamilies];
             
        r.data.put('EARLIEST_DELIVERY_TIME',EARLIEST_DELIVERY_TIME);
        r.data.put('LATEST_DELIVERY_TIME',LATEST_DELIVERY_TIME);
        r.data.put('refProductCount', getSOLineList.size());
        r.data.put('rsmObj', rsmObj);     
        r.data.put('assignedVehicleId', rsmObj.Vehicle__c); 
        r.data.put('assignedDriverId', rsmObj.Driver__c); 
        r.data.put('assignedDate', rsmObj.Planned_Ship_Date__c);
        queryData(r,rsmObj,rsmObj.Vehicle__c,rsmObj.Driver__c,rsmObj.Planned_Ship_Date__c);     
        List<string>holidayList = new List<string>();
        for(Holiday  businessHolidDay : [SELECT IsRecurrence,ActivityDate,RecurrenceMonthOfYear,RecurrenceEndDateOnly,RecurrenceInstance,RecurrenceDayOfWeekMask,RecurrenceInterval,RecurrenceType FROM Holiday]){
            if(businessHolidDay.IsRecurrence){
                holidayList.addAll(getAllRecurrenceHoliday(businessHolidDay));
            }else{
                holidayList.add(getDateStr(businessHolidDay.ActivityDate));   
            }    
        }
        r.data.put('holidayList', holidayList);
        
        return r;
    }  
    private static AuraResponse queryData(AuraResponse r,Sales_Order__c rsmObj,String assignedVehicleId,String assignedDriverId,Date assignedDate){
    	List<Shipping_Manifest__c> rsmList = new List<Shipping_Manifest__c>();
        List<Shipping_Manifest__c> tsmList = new List<Shipping_Manifest__c>();
        Vehicles__c vehicleObj = new Vehicles__c();
        Drivers__c driverObj = new Drivers__c();
        Id driverObjId = null;
        Id vehicleObjId = null;
        Date plannedDate = rsmObj.Planned_Ship_Date__c;
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
        
        decimal totalOrderCubicVolumeCapacity = 0;
        AggregateResult[] groupedResults = [SELECT SUM(Total_Product_Volume__c) FROM Inventory_Position__c where Sales_Order_Line__r.Sales_Order__c =: rsmObj.Id AND Sales_Order_Line__r.Status__c NOT IN(:Sales_Order_Line_Status_Cancelled, :Sales_Order_Line_Status_Rejected, :Sales_Order_Line_Status_Shipment_Complet)];
        decimal totalCubicVolume = groupedResults.size() > 0 && groupedResults[0].get('expr0') != null ? decimal.Valueof(''+groupedResults[0].get('expr0')) : 0;
        r.data.put('totalCubicVolume', totalCubicVolume);
        
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
            totalOrderCubicVolumeCapacity += rsmTotalCV;
            rsmTotalCVMap.put(SM.Id,rsmTotalCV);            
        }        
        r.data.put('rsmTotalCVMap', rsmTotalCVMap);
        
        Map<String,Decimal>tsmTotalCVMap = new Map<String,Decimal>();
        for(AggregateResult aggRes : [SELECT Shipping_Manifest__c,SUM(Picklist_Line__r.Inventory_Position__r.Total_Product_Volume__c) FROM Shipping_Manifest_Line__c where Shipping_Manifest__c IN: tsmList AND Shipping_Manifest__r.RecordType.Id !=: devRecordTypeId GROUP BY Shipping_Manifest__c]){
            decimal rsmTotalCV = aggRes.get('expr0') != null ? decimal.Valueof(''+aggRes.get('expr0')) : 0;
            tsmTotalCVMap.put(''+aggres.get('Shipping_Manifest__c'),rsmTotalCV);
            totalOrderCubicVolumeCapacity += rsmTotalCV;
        }
        for(Shipping_Manifest__c SM : [SELECT Id, (SELECT Id,Qty_Ordered__c,Product_Name__c,Product_Name__r.Unit_Cubic_Volume__c,Product_Name__r.Case_Cubic_Volume__c,Product_Name__r.MOQ__c FROM Shipping_Manifest_Lines__r) FROM Shipping_Manifest__c where Id IN: tsmList AND RecordType.Id =: devRecordTypeId]){
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
        
        AggregateResult[] groupedResults2 = [SELECT SUM(Total_Product_Volume__c) FROM Inventory_Position__c where Sales_Order_Line__r.Status__c NOT IN(:Sales_Order_Line_Status_Cancelled, :Sales_Order_Line_Status_Rejected, :Sales_Order_Line_Status_Shipment_Complet) AND Sales_Order_Line__r.Sales_Order__r.Planned_Ship_Date__c =: rsmObj.Planned_Ship_Date__c AND Sales_Order_Line__r.Sales_Order__r.Planned_Ship_Date__c != null AND Sales_Order_Line__r.Sales_Order__r.Vehicle__c =: rsmObj.Vehicle__c AND Sales_Order_Line__r.Sales_Order__r.Vehicle__c != null AND Sales_Order_Line__r.Sales_Order__r.Driver__c =: rsmObj.Driver__c AND Sales_Order_Line__r.Sales_Order__r.Driver__c != null];
        totalOrderCubicVolumeCapacity += groupedResults2.size() > 0 && groupedResults2[0].get('expr0') != null ? decimal.Valueof(''+groupedResults2[0].get('expr0')) : 0;
        
        r.data.put('totalOrderCubicVolumeCapacity', totalOrderCubicVolumeCapacity);
        
        decimal estimatedVehiclUtilized = 0;
        if(assignedVehicleId != rsmObj.Vehicle__c || assignedDate != rsmObj.Planned_Ship_Date__c || assignedDriverId != rsmObj.Driver__c)
            estimatedVehiclUtilized = totalCubicVolume + totalOrderCubicVolumeCapacity; 
        else
            estimatedVehiclUtilized = totalOrderCubicVolumeCapacity; 
        r.data.put('estimatedVehiclUtilized', estimatedVehiclUtilized);
        
        Decimal totalCubicVolumePer = 0;
        Decimal totalOrderCubicVolumeCapacityPer = 0;
        Decimal estimatedVehiclUtilizedPer = 0;
        
        if(vehicleObj.Vehicle_Cubic_Volume_Capacity__c > 0 && totalCubicVolume > 0)
        	totalCubicVolumePer = (totalCubicVolume/vehicleObj.Vehicle_Cubic_Volume_Capacity__c) * 100;   
        
        if(vehicleObj.Vehicle_Cubic_Volume_Capacity__c > 0 && totalOrderCubicVolumeCapacity > 0)
        	totalOrderCubicVolumeCapacityPer = (totalOrderCubicVolumeCapacity/vehicleObj.Vehicle_Cubic_Volume_Capacity__c) * 100;   
        
        if(vehicleObj.Vehicle_Cubic_Volume_Capacity__c > 0 && estimatedVehiclUtilized > 0)
        	estimatedVehiclUtilizedPer = (estimatedVehiclUtilized/vehicleObj.Vehicle_Cubic_Volume_Capacity__c) * 100;           
        
        r.data.put('totalCubicVolumePer', totalCubicVolumePer.setScale(2));
        r.data.put('totalOrderCubicVolumeCapacityPer', totalOrderCubicVolumeCapacityPer.setScale(2));
        r.data.put('estimatedVehiclUtilizedPer', estimatedVehiclUtilizedPer.setScale(2));
        
        r.data.put('rsmList', rsmList);
        r.data.put('tsmList', tsmList);
        r.data.put('vehicleObj', vehicleObj);
        r.data.put('driverObj', driverObj);
        
        r.data.put('Err_Msg_Select_Vehicle_Name', Err_Msg_Select_Vehicle_Name);
        r.data.put('Err_Msg_Select_Driver_Name', Err_Msg_Select_Driver_Name);
        r.data.put('Err_Msg_Select_Planned_Ship_Date', Err_Msg_Select_Planned_Ship_Date);
        r.data.put('Success_Msg_Assigned_Driver_Vehicle', Success_Msg_Assigned_Driver_Vehicle);
        
        return r;
    }
    @AuraEnabled
    public static AuraResponse assignDriverVehicle(Sales_Order__c order ,string startTime,string endTime,String pDate) {
        AuraResponse r = new AuraResponse('AssignDriverVehicleToSalesOrderCtlr.assignDriverVehicle()');           
        Sales_Order__c rsmObj = order;        
        try {
            if(startTime != NULL && startTime != ''){
                String[] eTimeWithSpace = startTime.split(' ');
                String[] eTime = eTimeWithSpace[0].split(':');
                rsmObj.Window_Start__c = Time.newInstance((eTimeWithSpace[1].equalsIgnoreCase('pm') && Integer.valueOf(eTime[0]) != 12 ?(Integer.valueOf(eTime[0])+12):Integer.valueOf(eTime[0])),Integer.valueOf(eTime[1]), 0, 0); 
            }else{
                rsmObj.Window_Start__c=null;
            }
            if(endTime != NULL && endTime != ''){
                 String[] lTimeWithSpace = endTime.split(' ');
                    String[] lTime = lTimeWithSpace[0].split(':');
                rsmObj.Window_End__c = Time.newInstance((lTimeWithSpace[1].equalsIgnoreCase('pm') && Integer.valueOf(lTime[0]) != 12 ?(Integer.valueOf(lTime[0])+12):Integer.valueOf(lTime[0])),Integer.valueOf(lTime[1]), 0, 0); 
            }else{
                rsmObj.Window_End__c=null;
            }
            if(pDate!=NULL && pDate!='')
            {
                Date plannedShipConfirmDate = Date.valueOf(pDate); 
                rsmObj.Planned_Ship_Date__c =plannedShipConfirmDate;
            }
            update rsmObj;
        } 
        catch (Exception ex){
            ErrorLogs.log('AssignDriverVehicleToSalesOrderCtlr:assignDriverVehicle()', 
                          ex.getStackTraceString(), ex.getMessage());
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getMessage());
            message = String.valueOf(msg);
            r.data.put('errorMessage', message);
            return r;
        }
        return r;
    }                     
    @AuraEnabled
    public static AuraResponse retrieveDriverVehicleAndRelated(Sales_Order__c order,String assignedVehicleId,String assignedDriverId,String assignedDateStr){
        system.debug('order '+order);
        system.debug('order.Id '+order.Id);
        Date assignedDate = assignedDateStr != null && assignedDateStr != '' ? date.valueOf(assignedDateStr) : null;
        AuraResponse r = new AuraResponse('AssignDriverVehicleToSalesOrderCtlr.retrieveDriverVehicleAndRelated()');
        Sales_Order__c rsmObj = order;
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
    
    private static list<String> getAllRecurrenceHoliday(Holiday businessHolidDay){
        List<string>holidayList = new List<string>();
        date todayDt = businessHolidDay.ActivityDate;
        date holidayEndDt = businessHolidDay.RecurrenceEndDateOnly != null ? businessHolidDay.RecurrenceEndDateOnly : system.today();
        while(todayDt <= holidayEndDt){
            if(businessHolidDay.RecurrenceType == RECURSYEARLY){todayDt = todayDt.addYears(1);
                                                               }else if(businessHolidDay.RecurrenceType == RECURSYEARLYNTH){
                                                                   todayDt = todayDt.addYears(1);
                                                                   todayDt = getHolidayDate(todayDt,businessHolidDay);   }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSMONTHLY){todayDt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);  todayDt = getHolidayDate(todayDt,businessHolidDay);    }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSMONTHLYNTH){date dt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);      
                                                                                                                                                                                                                                                                                                                        }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSWEEKLY){todayDt = todayDt.addMonths(businessHolidDay.RecurrenceInterval);     }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSDAILY){ todayDt = todayDt.addDays(businessHolidDay.RecurrenceInterval);  }else if(businessHolidDay.RecurrenceType == HOLIDAY_RECURSEVERYWEEKDAY){todayDt = todayDt.addDays(1);
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                }    
            holidayList.add(getDateStr(todayDt));       
        }
        return holidayList;
    }
    Public  static string getDateStr(Date holidayDate){
    	string dtStr = holidayDate.month()+'/'+holidayDate.Day()+'/'+holidayDate.year();  
        return dtStr;
    }
    Public  static integer getMonthNumber(string monthName){
        if(monthName == JANUARY_MONTH){ return 1;
        }else if(monthName == FEBRUARY_MONTH){ return 2;
        }else if(monthName == MARCH_MONTH){return 3;
        }else if(monthName == APRIL_MONTH){return 4;
        }else if(monthName == MAY_MONTH){return 5;
        }else if(monthName == JUNE_MONTH){return 6;
        }else if(monthName == JULY_MONTH){return 7;
        }else if(monthName == AUGUST_MONTH){return 8;
        }else if(monthName == SEPTEMBER_MONTH){return 9;
        }else if(monthName == OCTOBER_MONTH){return 10;
        }else if(monthName == NOVEMBER_MONTH){return 11;
        }else if(monthName == DECEMBER_MONTH){return 12;}return 1;
    }
    Public  static Date getHolidayDate(Date todayDt,Holiday businessHolidDay){
          integer year = todayDt.year();
            integer month = getMonthNumber(businessHolidDay.RecurrenceMonthOfYear); integer day = 0;
        if(businessHolidDay.RecurrenceDayOfWeekMask == 127){  if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_FIRST){  day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_SECOND){ day = 1;    }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_THIRD){day = 1; }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_FOURTH){day = 1;    
            }else if(businessHolidDay.RecurrenceInstance== HOLIDAY_RECURRENCE_LAST){day = Date.daysInMonth(year, month);   } 
            return Date.newInstance(year,month,day);
        }else{
            date dt = todayDt;            
            Date weekDay = todayDt.toStartOfMonth().toStartOfWeek(); 
            
            if(businessHolidDay.RecurrenceDayOfWeekMask == 2) weekDay = weekDay.addDays(1);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 4)  weekDay = weekDay.addDays(2);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 8) weekDay = weekDay.addDays(3);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 16)
                weekDay = weekDay.addDays(4);    
            else if(businessHolidDay.RecurrenceDayOfWeekMask == 32)
                weekDay = weekDay.addDays(5);     else if(businessHolidDay.RecurrenceDayOfWeekMask == 64) weekDay = weekDay.addDays(6);  
            
            if((todayDt.month() > 1 && weekDay.month() < todayDt.month()) || (todayDt.month() == 1 && weekDay.month() == 12))
                weekDay = weekDay.addDays(7);
            
            if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_SECOND){ weekDay = weekDay.addDays(7);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_THIRD){weekDay = weekDay.addDays(14);        
            }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_FOURTH){
                weekDay = weekDay.addDays(21); }else if(businessHolidDay.RecurrenceInstance == HOLIDAY_RECURRENCE_LAST){weekDay = weekDay.addDays(28);        
            }
            
            if((todayDt.month() < 12 && weekDay.month() > todayDt.month()) || (todayDt.month() == 12 && weekDay.month() == 1))weekDay = weekDay.addDays(-7);
            return weekDay;
        }
    }
    
}