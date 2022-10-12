/**
 * Copyright (c) 2018 Filigreen Distro
 * All rights reserved.
 * PutAwayInventoryController
 */
public with sharing class PutAwayInventoryController {
 public Static String PURCHASE_ORDER_STATUS_QACONFIRMED{
        get{
            return String.isNotBlank(PURCHASE_ORDER_STATUS_QACONFIRMED) ? PURCHASE_ORDER_STATUS_QACONFIRMED: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Purchase Order','PO_QA_status_Confirmed');
        }set;
    }
    
     public Static String ERR_MSG_RECEIVING_QTY_GRATERTHEN_PA{
        get{
            return String.isNotBlank(ERR_MSG_RECEIVING_QTY_GRATERTHEN_PA) ? ERR_MSG_RECEIVING_QTY_GRATERTHEN_PA: FiligreenConfigurationUtility.getConfigValueByObjectAndKey('Invoice','Err_Msg_ReceivingQty_GreaterThen_PA');
        }set;
    }
    
    // private final variables
    private static final String RECEIVING_INSPECTION = Label.Default_Inventory_Location;
    private static final String NONE_VALUE = Label.NONE_VALUE;
    
    // List of Inventory position to display per page
    public List<InventoryPositionWrapper> setInventoryPositions {get; set;}
    
    // Total Inventory position Iterable to process
    public CustomIterable inventoryPositionsIterable {get; set;}
    
    // Total Inventory position Wrapper list to process
    @testVisible
    private List<InventoryPositionWrapper> inventoryPositions;
    
    @testVisible
    private List<InventoryPositionWrapper> masterInventoryPositions;
    
    // Page size to display number of inventory position per page
    public String pageSize {get; set;}
    
    // Selected inventory position and related attribute Ids set from page
    public Id selectedInvPositionId {get; set;}
    public Id selectedRackId {get; set;}
    public Id selectedRackLevelId {get; set;}
    public Id selectedBinLocationId {get; set;}
    
    // Flag to check if any inventory position exists to update
    public Boolean hasInventoryPosition {get; set;}
    
    // List of Inventory Position Wrapper by Inventory Position Id
    private Map<Id, InventoryPositionWrapper> inventoryPositionById;
    
    // Map of Inventory location by rack Id
    private Map<Id, Id> inventoryLocationByRackId;
    
    // List  of rack levels by rack id
    private Map<Id, List<Rack_Level__c>> rackLevelsByRackId;
    
    // List of bin locations by rack level id
    private Map<Id, List<Bin_Location__c>> binLocationsByRackLevelId;
    
    // Map of bin location by bin location id
    private Map<Id, Bin_Location__c> binLocationById;
    
    // Map of existing total consumed bin location capacity by bin location id
    private Map<Id, Decimal> binConsumedCapacityById;
    
    // Map of total product volume by bin location id - Based on qty to put away input 
    private Map<Id, Decimal> totalProductVolumeByBinLocationId;
    
    public String searchText {get; set;}
    public SelectOption[] siteOptions{set;get;}
    public CustomSelectOptions[] siteOptionsL{set;get;}
    public String selectedSiteId {get; set;}
    List<String> AssignedWarehouseIds = new List<String>();
    // Constructor - Initialize the values
    public PutAwayInventoryController(){
        selectedSiteId = 'All';
        inventoryPositions = new List<InventoryPositionWrapper>();
        masterInventoryPositions =  new List<InventoryPositionWrapper>();
        setInventoryPositions = new List<InventoryPositionWrapper>();
        inventoryPositionById = new Map<Id, InventoryPositionWrapper>();
        rackLevelsByRackId = new Map<Id, List<Rack_Level__c>>();
        binLocationsByRackLevelId = new Map<Id, List<Bin_Location__c>>();
        inventoryLocationByRackId = new Map<Id, Id>();
        binLocationById = new Map<Id, Bin_Location__c>();
        binConsumedCapacityById = new Map<Id, Decimal>();
        totalProductVolumeByBinLocationId = new Map<Id, Decimal>();
        hasInventoryPosition = false;
        pageSize = '25';
        siteOptions = new SelectOption[]{new SelectOption('All','All')};
        siteOptionsL = new CustomSelectOptions[]{new CustomSelectOptions('All','All')};
        //Get Assigned warehouse from loggedIn User
        User loggedInUser = [SELECT Id,Assigned_Warehouse_Ids__c FROM User WHERE Id = :UserInfo.getUserId()];
        if(loggedInUser.Assigned_Warehouse_Ids__c != null){
            AssignedWarehouseIds = loggedInUser.Assigned_Warehouse_Ids__c.split(',');
            for(Site__c site:[SELECT Id, Name,Active__c FROM Site__c WHERE Id IN: AssignedWarehouseIds AND Active__c= True]){
                siteOptions.add(new SelectOption(site.Id,site.Name));
                siteOptionsL.add(new CustomSelectOptions(site.Id,site.Name));
            }
        }
        
    }
    
    @AuraEnabled
    public static AuraResponse putAwayInventoryCtrl(){
        system.debug('putAwayInventoryCtrlputAwayInventoryCtrl');
    	AuraResponse r = new AuraResponse('PutAwayInventoryController.putAwayInventoryCtrl()');
        try{
        	PutAwayInventoryController putAway = new PutAwayInventoryController();
            putAway.retrieveInventoryPositions();
            r.data.put('putAway',putAway.setInventoryPositions);  
            r.data.put('siteOptions',putAway.siteOptionsL);
            r.data.put('rackLevelsByRackId',putAway.rackLevelsByRackId);
            r.data.put('binLocationsByRackLevelId',putAway.binLocationsByRackLevelId);
            r.data.put('binConsumedCapacityById',putAway.binConsumedCapacityById);
            r.data.put('inventoryPositionById',putAway.inventoryPositionById);
            r.data.put('hasInventoryPosition',putAway.hasInventoryPosition);
            r.data.put('masterInventoryPositions',putAway.masterInventoryPositions);
            
            
          set<id>relids = new set<id>();
            for(InventoryPositionWrapper ip : putAway.masterInventoryPositions ){
                relids.add(ip.invPositionSO.Receiving_Line__c);
            }
         
            
            AggregateResult[] groupedResults = [SELECT COUNT(Id), Receiving_Line__c FROM Quality_Assurance__c where Receiving_Line__c IN :relids and Receiving_Line__c !=null  GROUP BY Receiving_Line__c ];
            
			Map<id,Integer > AggRes = new Map<id, Integer>();
              for(AggregateResult ar:groupedResults) {
                    Id RECLinetid = (ID)ar.get('Receiving_Line__c');
                    Integer count  = (INTEGER)ar.get('expr0');
                  AggRes.put(RECLinetid, count);
              }
            for(InventoryPositionWrapper ip : putAway.masterInventoryPositions ){
                
                if(ip.invPositionSO.Last_IP_Location__c != null){
                    ip.invPositionSO.Last_IP_Location__c = '  Last IP: ' + ip.invPositionSO.Last_IP_Location__c;   
                    ip.DisplayEyeIcon = true; 
                }
                if(AggRes.containsKey(ip.invPositionSO.Receiving_Line__c)){
                        ip.QARecCheck = true; 
                        ip.DisplayEyeIcon = true; 
                        ip.Displayvalues='QA Confirmed';
               }
                }    
                
        
                     
        } catch(Exception ex){
            System.debug('ERRROR = '+ex);
                        System.debug('Exception e '+ex.getLineNumber());

        }
        
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse onSiteChange(String siteId,String direction, String orderField){
    	AuraResponse r = new AuraResponse('PutAwayInventoryController.onSiteChange()');
        try{
        	PutAwayInventoryController putAway = new PutAwayInventoryController();
            putAway.selectedSiteId = siteId;
            putAway.sortDir = direction;
            putAway.sortField = orderField;
            putAway.retrieveInventoryPositions();
            System.debug('masterInventoryPositions'+putAway.masterInventoryPositions.size());
            r.data.put('putAway',putAway.setInventoryPositions); 
            r.data.put('masterInventoryPositions',putAway.masterInventoryPositions);
            r.data.put('hasInventoryPosition',putAway.hasInventoryPosition);
            r.data.put('selectedSiteId',putAway.selectedSiteId);
                set<id>relids = new set<id>();
            for(InventoryPositionWrapper ip : putAway.masterInventoryPositions ){
                relids.add(ip.invPositionSO.Receiving_Line__c);
            }
         
            
            AggregateResult[] groupedResults = [SELECT COUNT(Id), Receiving_Line__c FROM Quality_Assurance__c where Receiving_Line__c IN :relids and Receiving_Line__c !=null  GROUP BY Receiving_Line__c ];
            
			Map<id,Integer > AggRes = new Map<id, Integer>();
              for(AggregateResult ar:groupedResults) {
                    Id RECLinetid = (ID)ar.get('Receiving_Line__c');
                    Integer count  = (INTEGER)ar.get('expr0');
                  AggRes.put(RECLinetid, count);
              }
            for(InventoryPositionWrapper ip : putAway.masterInventoryPositions ){
                
                if(ip.invPositionSO.Last_IP_Location__c != null){
                    ip.invPositionSO.Last_IP_Location__c = '  Last IP: ' + ip.invPositionSO.Last_IP_Location__c;   
                    ip.DisplayEyeIcon = true; 
                }
                if(AggRes.containsKey(ip.invPositionSO.Receiving_Line__c)){
                        ip.QARecCheck = true; 
                        ip.DisplayEyeIcon = true; 
                        ip.Displayvalues='QA Confirmed';
               }
                }    
            //r.data.put('siteOptions',putAway.siteOptionsL);
        } catch(Exception ex){
            System.debug('ERRROR = '+ex);
        }
        
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse onOrderSort(String direction, String orderField, String selectedSiteId){
    	AuraResponse r = new AuraResponse('PutAwayInventoryController.onOrderSort()'); 
        PutAwayInventoryController putAway = new PutAwayInventoryController();
        putAway.sortDir = direction;
        putAway.sortField = orderField;
        putAway.selectedSiteId = selectedSiteId;
        putAway.retrieveInventoryPositions();
        r.data.put('putAway',putAway.setInventoryPositions);  
        r.data.put('siteOptions',putAway.siteOptionsL);
        r.data.put('rackLevelsByRackId',putAway.rackLevelsByRackId);
        r.data.put('binLocationsByRackLevelId',putAway.binLocationsByRackLevelId);
        r.data.put('binConsumedCapacityById',putAway.binConsumedCapacityById);
        r.data.put('inventoryPositionById',putAway.inventoryPositionById);
        r.data.put('hasInventoryPosition',putAway.hasInventoryPosition);
        r.data.put('masterInventoryPositions',putAway.masterInventoryPositions);
        r.data.put('selectedSiteId',putAway.selectedSiteId);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse updateInventoryPositions (String jsonInvPos){
    	AuraResponse r = new AuraResponse('PutAwayInventoryController.updateInventoryPositions()');
        PutAwayInventoryController putAway = new PutAwayInventoryController();
        putAway.retrieveInventoryPositions();
        
        putAway.inventoryPositions = (List<InventoryPositionWrapper>) System.JSON.deserialize(jsonInvPos, List<InventoryPositionWrapper>.class);
        
        String errorMsg = validateInputs(putAway.inventoryPositions,putAway.binLocationById,putAway.binConsumedCapacityById);
        if(errorMsg != 'No Error'){
            r.data.put('Error',errorMsg);
        } else {
        	Savepoint savePoint;
            try {
                
                // Define Savepoint for rollback
                savePoint = Database.setSavepoint();
                
                List<Inventory_Position__c> invPositionsToUpdate = new List<Inventory_Position__c>();
                Map<Id,Decimal> selectedIpIds = new Map<Id,Decimal>();
                for(InventoryPositionWrapper invPositionWrapper : putAway.inventoryPositions){
                    if(invPositionWrapper.isSelected){
                        selectedIpIds.put(invPositionWrapper.invPositionSO.Id,invPositionWrapper.qtyToPutAway);
                    }
                }
                Boolean isErrorExist = false;
                if(selectedIpIds.size() > 0){
                    for(Inventory_Position__c ip : [SELECT Id,Qty_On_Hand__c FROM Inventory_Position__c WHERE Id IN :selectedIpIds.keySet()]){
                        Decimal qtytoPut = selectedIpIds.get(ip.Id);
                        if(qtytoPut > ip.Qty_On_Hand__c){
                            r.data.put('Error',ERR_MSG_RECEIVING_QTY_GRATERTHEN_PA);
                            isErrorExist = true;
                        }
                    }
                }
                
                if(!isErrorExist){
                    for(InventoryPositionWrapper invPositionWrapper : putAway.inventoryPositions){
                        Inventory_Position__c inventoryPositionSO = invPositionWrapper.invPositionSO;
                        if(invPositionWrapper.isSelected){
                            // Assign updated Inventory Location
                            inventoryPositionSO.Inventory_Location__c = putAway.inventoryLocationByRackId.get(inventoryPositionSO.Rack__c);
                            
                            // Check for partial quantity
                            if(invPositionWrapper.qtyToPutAway != inventoryPositionSO.Qty_On_Hand__c){

                                // Create new inventory position for partial qty  
                                Inventory_Position__c cloneInventoryPositionSO = inventoryPositionSO.clone(false, true);
                                cloneInventoryPositionSO.Qty_On_Hand__c = invPositionWrapper.qtyToPutAway;
                                 if(cloneInventoryPositionSO.Harvest_Batch_Code__r.Batch_ID_Hold__c == False){
                                  cloneInventoryPositionSO.Hold__c = False;   
                                }else if(cloneInventoryPositionSO.Harvest_Batch_Code__r.Batch_ID_Hold__c == True){
                                  cloneInventoryPositionSO.Hold__c = True;    
                                }
                                invPositionsToUpdate.add(cloneInventoryPositionSO);
                                system.debug('update inv');
                                // Update existing inventory position with only balance qty - Do not change any other details
                                Id invPositionId = inventoryPositionSO.Id;
                                Decimal balanceQty = inventoryPositionSO.Qty_On_Hand__c - invPositionWrapper.qtyToPutAway;
                                inventoryPositionSO = new Inventory_Position__c();
                                inventoryPositionSO.Id = invPositionId;
                                inventoryPositionSO.Qty_On_Hand__c = balanceQty;
                                /*if(inventoryPositionSO.Harvest_Batch_Code__r.Batch_ID_Hold__c == False){
                                  inventoryPositionSO.Hold__c = False;   
                                }else if(inventoryPositionSO.Harvest_Batch_Code__r.Batch_ID_Hold__c == True){
                                  inventoryPositionSO.Hold__c = True;    
                                }*/
                               
                            }
                             if(inventoryPositionSO.Harvest_Batch_Code__r.Batch_ID_Hold__c == False){
                                  inventoryPositionSO.Hold__c = False;   
                                }else if(inventoryPositionSO.Harvest_Batch_Code__r.Batch_ID_Hold__c == True){
                                  inventoryPositionSO.Hold__c = True;    
                                }

                            invPositionsToUpdate.add(inventoryPositionSO);
                        }
                    }
                    upsert invPositionsToUpdate;
                    system.debug('invPositionsToUpdate'+invPositionsToUpdate);
                }
            } catch (Exception ex) {
                Database.rollback(savePoint);
                r.data.put('Error',ex.getMessage());
            }
        }
        return r;
    }
    
    // Get sort direction of column - Default is ascending order
    public String sortDir {
        get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;  }
        set;
    }
      
    // Get sortable field name - Default is Product name
    public String sortField {
        get  { if (sortField == null) {sortField = 'Product_Name__r.Name'; } return sortField;  }
        set;
    }
    
    // Switch sort direction from asc to desc and vice versa
    public void toggleSort() {
        // simply toggle the direction
        sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
        // run the query again
        runQuery();
    }
    
    /**
     * Generate dynamic query string of Inventory Positions based on sortable column and direction
     * Every time it generates when sorting column is clicked
     *
     * @param receivingInspection The hard coded value of Receiving Inspection to use in dynamic query
     * @param limitRecords The hard coded value of Limit to use in dynamic query
     *
     * @return The dynamic query string
     */
    public String generateDynamicQuery(String receivingInspection,
                                       Integer limitRecords) {
        String invPositionQuery;
        //List<String> invPositionFieldNames = getSObjectFieldNames('Inventory_Position__c'); 
        invPositionQuery = 'Select Total_Product_Volume__c' +
                              //String.join( invPositionFieldNames, ',' ) + ' ' +
                              ', Bin_Location__c' +
                                ', Id' +
                                ', Name' +
                              ', Rack_Level__c' +
                              ', Rack__c' +
                              ', Qty_On_Hand__c' +
                              ', Site__c' +
             					', Hold__c' +
            				  ', Site__r.Name' +
                              ', Date_Received__c' +
                              ', Product_Name__c' +
                              ', Ownership__c' +
                              ', Inventory_Location__c' +
            				  ', Harvest_Batch_Code__c' +
            				  ', Last_IP_Location__c ' +
            					', Harvest_Batch_Code__r.Batch_ID_Hold__c'+
            				  ', Harvest_Batch_Code__r.Name' +
                              ', Producer_Name__c' +
                              ', Harvest_Batch_or_Lot_Code__c' +
                              ', UID__c' +
            			      ', UID_New__c' +
            				  ', UID_New__r.Name' +
                              ', Lab_Test_Status__c' +
                              ', Product_Title__c' +
                              ', Rack_Level__r.Name ' +
                              ', Bin_Location__r.Name ' +
                              ', Ownership__r.Name ' +
                              ', Product_Name__r.Unit_Cubic_Volume__c ' +
                              ', Product_Name__r.Name ' +
                              ', Product_Name__r.Description ' +
                              ', Inventory_Location__r.Name ' +
                              ', Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_Name__r.Name ' +
                              ', Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.QA_Status__c' +
                              ', Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Name ' +
                              'From Inventory_Position__c ' +
                              'Where Inventory_Location__r.Name =: receivingInspection ';
                              if(AssignedWarehouseIds.size() > 0 && selectedSiteId == 'All'){
                              	invPositionQuery += ' AND Site__c IN :AssignedWarehouseIds';	 
                              }else if(selectedSiteId != 'All'){
                                  invPositionQuery += ' AND Site__c = :selectedSiteId';	 
                              }                         		
                              System.debug('###selectedSiteId::'+selectedSiteId+'==>Query:'+invPositionQuery);
                              invPositionQuery += ' ORDER BY ' + sortField + ' ' + sortDir + ' NULLS LAST ' +
                              'LIMIT :limitRecords';  
    system.debug('invPositionQuery'+invPositionQuery);
        return invPositionQuery;
    }
    
    /**
     * Retrieve Inventory position records based on sortable column and direction
     */
    public void runQuery() {
        List<Inventory_Position__c> inventoryPositionList = new List<Inventory_Position__c>();
        try {
            Integer limitRecords = LIMITS.getLimitQueryRows();
            String receivingInspection = RECEIVING_INSPECTION;
            String invPositionQuery = generateDynamicQuery(receivingInspection, limitRecords);
        
            inventoryPositionList = Database.query(invPositionQuery);
            
            inventoryPositions = new List<InventoryPositionWrapper>();
        
            if(inventoryPositionList != null){
                for(Inventory_Position__c inventoryPositionSO : inventoryPositionList){
                    InventoryPositionWrapper invPositionWrapper = inventoryPositionById.get(inventoryPositionSO.Id);
                    inventoryPositions.add(invPositionWrapper);
                }
                
                inventoryPositionsIterable = new CustomIterable(inventoryPositions, Integer.valueOf(pageSize));
                nextInventoryPositions();
            }
        
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Error occurred while loading inventory positions'));
        }
        
    }
        
    /**
     * Retrieve all sobject field names related to sobject
     *
     * @param objectName The name of sObjectFieldNames
     *
     * @return List of sobject field names
     */
    public List<String> getSObjectFieldNames(String objectName){
        List<String> sObjectFieldNames = 
                new List<String>(Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap().keySet());
        return sObjectFieldNames;
    }
    /**
     * Retrieve all inventory positions, Racks, Rack levels by Rack Id, Bin Locations by Rack Level Id
     */
    public void retrieveInventoryPositions(){
                       system.debug('retrieveInventoryPositions.Last_IP_Location__c'); 

        setInventoryPositions = new List<InventoryPositionWrapper>();
        inventoryPositions = new List<InventoryPositionWrapper>();
        List<Inventory_Position__c> inventoryPositionList = new List<Inventory_Position__c>();
        List<Inventory_Position__c> filteredInventoryPositionList = new List<Inventory_Position__c>();
        List<Rack__c> racks = new List<Rack__c>();
        List<Rack_Level__c> rackLevels = new List<Rack_Level__c>();
        List<Bin_Location__c> binLocations = new List<Bin_Location__c>();
        List<SelectOption> rackOptions = new List<SelectOption>();
        rackOptions.add(new SelectOption('', NONE_VALUE));
        
        Set<Id> siteIds = new Set<Id>();
        Set<Id> rackIds = new Set<Id>();
        Set<Id> rackLevelIds = new Set<Id>();
        
        /*List<String> invPositionFieldNames = getSObjectFieldNames('Inventory_Position__c'); 
        
        // Retrieve all inventory positions where location is Receiving Inspection
        Integer limitRecords = LIMITS.getLimitQueryRows();
        String invPositionQuery = 'Select ' +
                                  String.join( invPositionFieldNames, ',' ) + ' ' +
                                  ', Rack_Level__r.Name ' +
                                  ', Bin_Location__r.Name ' +
                                  ', Product_Name__r.Unit_Cubic_Volume__c ' +
                                  ', Product_Name__r.Name ' +
  								   ', Last_IP_Location__c ' +
                                  ', Product_Name__r.Description ' +
                                  ', Inventory_Location__r.Name ' +
                                  ', Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_Name__r.Name ' +
                                  ', Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Name ' +
                                  'From Inventory_Position__c ' +
                                  'ORDER BY Product_Name__r.Name ' +
                                  'LIMIT :limitRecords';  
                                  
        inventoryPositionList = Database.query(invPositionQuery);*/
        Integer limitRecords = LIMITS.getLimitQueryRows();
        String receivingInspection = RECEIVING_INSPECTION;
        String invPositionQuery = generateDynamicQuery(receivingInspection, limitRecords);
        inventoryPositionList = Database.query(invPositionQuery);
        System.debug('####inventoryPositionList::'+inventoryPositionList.size());
        inventoryPositionList = inventoryPositionList != null ? inventoryPositionList : new List<Inventory_Position__c>();
        system.debug('inventoryPositionList>>>'+inventoryPositionList);
        // Add all site Ids from all inventory positions
          Set<id>idsrecline= new set<id>();
        
       
        
       
        
        for(Inventory_Position__c inventoryPositionSO : inventoryPositionList){
            if(inventoryPositionSO.Inventory_Location__r.Name == RECEIVING_INSPECTION){
                filteredInventoryPositionList.add(inventoryPositionSO);
                hasInventoryPosition = true;
            }
            // Add site ids
            siteIds.add(inventoryPositionSO.Site__c);
        }
          
        // Get all racks related to all inventory locations pertain to all sites
        // Create list of rack options to display on page at the time of page load
        Map<Id,Rack__c[]> inventoryPositionRackMap = new Map<Id,Rack__c[]>();
        for(Rack__c rackSO : [Select Name, 
                                    Inventory_Location__c,
                                    Inventory_Location__r.Name,Inventory_Location__r.Site_Name__c
                              From Rack__c 
                              Where Inventory_Location__r.Site_Name__c IN: siteIds
                              ORDER BY NAME]){
            racks.add(rackSO);
            rackIds.add(rackSO.Id);
            rackOptions.add(new SelectOption(rackSO.Id, rackSO.Inventory_Location__r.Name + ' - ' +rackSO.Name));
            rackOptions = doSortOption(rackOptions);
            inventoryLocationByRackId.put(rackSO.Id, rackSO.Inventory_Location__c);
                                  if(inventoryPositionRackMap.containsKey(rackSO.Inventory_Location__r.Site_Name__c)){
                                      inventoryPositionRackMap.get(rackSO.Inventory_Location__r.Site_Name__c).add(rackSO);
                                  }else{
                                      inventoryPositionRackMap.put(rackSO.Inventory_Location__r.Site_Name__c, new Rack__c[]{rackSO});
                                  }                     
        }
        
        // Construct map of all rack levels by rack id
        for(Rack_Level__c rackLevelSO : [Select Name, Rack__c From Rack_Level__c 
                                         Where Rack__c IN: rackIds
                                         ORDER BY NAME]) {
                    
            List<Rack_Level__c> rackLevelsTemp = rackLevelsByRackId.get(rackLevelSO.Rack__c);
            
            if(rackLevelsTemp == null) {
                rackLevelsTemp = new List<Rack_Level__c>();
                rackLevelsByRackId.put(rackLevelSO.Rack__c, rackLevelsTemp);
            }
            rackLevelsTemp.add(rackLevelSO);
            rackLevelIds.add(rackLevelSO.Id);
        }
        
        // Construct map of all bin locations by rack level id
        for(Bin_Location__c binLocationSO : [Select Name, Bin_Volume_Capacity__c, Rack_Level__c,
                                             Ignore_Storage_Limit__c From Bin_Location__c 
                                             Where Rack_Level__c IN: rackLevelIds 
                                             ORDER BY NAME]) {
                    
            // Initialize the map for storing total capacity of bin
            binConsumedCapacityById.put(binLocationSO.Id, binLocationSO.Bin_Volume_Capacity__c);
            
            // Initialize the map for storing allocated space of bin location 
            totalProductVolumeByBinLocationId.put(binLocationSO.Id, 0.0);
            binLocationById.put(binLocationSO.Id, binLocationSO);
            List<Bin_Location__c> binLocationsTemp = binLocationsByRackLevelId.get(binLocationSO.Rack_Level__c);
            
            if(binLocationsTemp == null) {
                binLocationsTemp = new List<Bin_Location__c>();
                binLocationsByRackLevelId.put(binLocationSO.Rack_Level__c, binLocationsTemp);
            }
            binLocationsTemp.add(binLocationSO);
        }
        
        // Calculate balance capacity of bin location
        Decimal consumedSpace = 0.0;
        for(Inventory_Position__c inventoryPositionSO : inventoryPositionList){
            // Add consumed space of bin of products assigned in inventory position
            consumedSpace = binConsumedCapacityById.get(inventoryPositionSO.Bin_Location__c);
            
            if(consumedSpace != null && consumedSpace > 0.0){
                consumedSpace -= (inventoryPositionSO.Total_Product_Volume__c);
                binConsumedCapacityById.put(inventoryPositionSO.Bin_Location__c, consumedSpace);
            }
        }
        
        // Create wrapper list of inventory position
        for(Inventory_Position__c inventoryPositionSO : filteredInventoryPositionList){
            
            // Add inventory position in iterable interface
            InventoryPositionWrapper invPositionWrapper = new InventoryPositionWrapper(inventoryPositionSO);
            List<SelectOption> IPRackOptions = new List<SelectOption>();
            List<CustomSelectOptions> IPRackOptionsL = new List<CustomSelectOptions>();
            IPRackOptions.add(new SelectOption('', NONE_VALUE));
            //IPRackOptionsL.add(new CustomSelectOptions('', NONE_VALUE));
            if(inventoryPositionRackMap.containsKey(inventoryPositionSO.Site__c)){
                Rack__c[] IPRacks = inventoryPositionRackMap.get(inventoryPositionSO.Site__c);
                
                if(!IPRacks.isEmpty()){
                    for(Rack__c rackSO: IPRacks){
                        IPRackOptionsL.add(new CustomSelectOptions(rackSO.Id, rackSO.Inventory_Location__r.Name + ' - ' +rackSO.Name));
                        IPRackOptions.add(new SelectOption(rackSO.Id, rackSO.Inventory_Location__r.Name + ' - ' +rackSO.Name));
                    }
                }
            }
            invPositionWrapper.rackOptions = IPRackOptions;
            
            Map<String, CustomSelectOptions> mapping = new Map<String, CustomSelectOptions>();
            // Suffix to avoid duplicate values like same labels or values are in inbound list 
            Integer suffix = 1;
            for (CustomSelectOptions opt : IPRackOptionsL) {
                mapping.put((opt.value + suffix++), opt);   
            }
            
            List<String> sortKeys = new List<String>();
            sortKeys.addAll(mapping.keySet());
            sortKeys.sort();
            IPRackOptionsL.clear();
            
            for (String key : sortKeys) {
                IPRackOptionsL.add(mapping.get(key));
            }
            
            
            invPositionWrapper.rackOptionsL = IPRackOptionsL;
            
            // Assign Rack Level value of inventory location and display it on page
            if(inventoryPositionSO.Rack_Level__c != null){
                invPositionWrapper.rackLevelOptions.add(new SelectOption(inventoryPositionSO.Rack_Level__c, inventoryPositionSO.Rack_Level__r.Name));
                invPositionWrapper.rackLevelOptionsL.add(new CustomSelectOptions(inventoryPositionSO.Rack_Level__c, inventoryPositionSO.Rack_Level__r.Name));
            }
            
            // Assign Bin Location value of inventory location and display it on page
            if(inventoryPositionSO.Bin_Location__c != null){
                invPositionWrapper.binLocationOptions.add(new SelectOption(inventoryPositionSO.Bin_Location__c, inventoryPositionSO.Bin_Location__r.Name));
                invPositionWrapper.binLocationOptionsL.add(new CustomSelectOptions(inventoryPositionSO.Bin_Location__c, inventoryPositionSO.Bin_Location__r.Name));
            }
            
            inventoryPositions.add(invPositionWrapper);
            masterInventoryPositions.add(invPositionWrapper);
            
            // Construct map of inventory position wrapper by inventory position id
            // This map is used when assigning dynamic values of rack level and bin location based on
            // selected value of inventory position id and rack/rack level id
            inventoryPositionById.put(inventoryPositionSO.Id, invPositionWrapper);
        }
        inventoryPositionsIterable = new CustomIterable(inventoryPositions, Integer.valueOf(pageSize)); 
        nextInventoryPositions();
    }
    
    
    /**
     * Apply validations and update Inventory Locations based on user input
     *
     * @return PageReference of current page
     */
    public PageReference updateInventoryLocations(){
        
        // Perform validations - If any validation fails then do not need to process inventory locations
        if(validateInputs()){
            return null;
        }
        
        Savepoint savePoint;
        
        try {
        
            // Define Savepoint for rollback
            savePoint = Database.setSavepoint();
        
            List<Inventory_Position__c> invPositionsToUpdate = new List<Inventory_Position__c>();
            
            for(InventoryPositionWrapper invPositionWrapper : inventoryPositions){
                
                Inventory_Position__c inventoryPositionSO = invPositionWrapper.invPositionSO;
                
                if(invPositionWrapper.isSelected){
                    
                    // Assign updated Inventory Location
                    inventoryPositionSO.Inventory_Location__c = inventoryLocationByRackId.get(inventoryPositionSO.Rack__c);
                    
                    // Check for partial quantity
                    if(invPositionWrapper.qtyToPutAway != inventoryPositionSO.Qty_On_Hand__c){
                        
                        // Create new inventory position for partial qty  
                        Inventory_Position__c cloneInventoryPositionSO = inventoryPositionSO.clone(false, true);
                        cloneInventoryPositionSO.Qty_On_Hand__c = invPositionWrapper.qtyToPutAway;
                        invPositionsToUpdate.add(cloneInventoryPositionSO);
                        
                        // Update existing inventory position with only balance qty - Do not change any other details
                        Id invPositionId = inventoryPositionSO.Id;
                        Decimal balanceQty = inventoryPositionSO.Qty_On_Hand__c - invPositionWrapper.qtyToPutAway;
                        inventoryPositionSO = new Inventory_Position__c();
                        inventoryPositionSO.Id = invPositionId;
                        inventoryPositionSO.Qty_On_Hand__c = balanceQty;
                    }
                    invPositionsToUpdate.add(inventoryPositionSO);
                }
            }
        
            upsert invPositionsToUpdate;
            
        } catch (Exception ex) {
            Database.rollback(savePoint);
            
            ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
            ApexPages.addMessage(message);
            return null;
        }
        return redirectToPutAwayInventoryPage();
    }
    
    public static String validateInputs(List<InventoryPositionWrapper> inventoryPositions,Map<Id, Bin_Location__c> binLocationById,Map<Id, Decimal> binConsumedCapacityById){
        Boolean hasInvPositionSelected = false;
        String errorMsg = 'No Error';
        Decimal allocatedSpace;
        Decimal availableBinLocationCapacity;
        Map<Id, Decimal> totalProductVolumeByBinLocationId = new Map<Id, Decimal>();
        
        for(InventoryPositionWrapper invPositionWrapper : inventoryPositions){
            System.debug('qtyToPutAway2 = '+ invPositionWrapper.qtyToPutAway);
        	Decimal qtyToPutAway = invPositionWrapper.qtyToPutAway;
            Inventory_Position__c inventoryPositionSO = invPositionWrapper.invPositionSO;
            Bin_Location__c binLocationObj = binLocationById.get(inventoryPositionSO.Bin_Location__c);
            if(invPositionWrapper.isSelected){
                hasInvPositionSelected = true;
                allocatedSpace = 0.0;
                availableBinLocationCapacity = 0.0;
                
                // Check qty to put away cannot be blank and must be positive
                if(qtyToPutAway == null || qtyToPutAway <= 0.00 ){
                    errorMsg = Label.Qty_To_Put_Away_Positive_Value + ' '+ inventoryPositionSO.Product_Name__r.Name;
                    return errorMsg;
                }
                
                // Check qty to put away cannot be greater than qty on hand
                else if(qtyToPutAway > inventoryPositionSO.Qty_On_Hand__c){
                    errorMsg = Label.Qty_To_Put_Away_Cannot_Be_Greater_Than_Qty_On_Hand +' '+ inventoryPositionSO.Product_Name__r.Name;
                    return errorMsg;
                    // Check Rack, Rack Level and Bin Location cannot be null
                }else if(inventoryPositionSO.Rack__c == null || inventoryPositionSO.Rack_Level__c == null || inventoryPositionSO.Bin_Location__c == null){
                             
                    errorMsg = Label.Rack_Rack_Level_Bin_Location_Cannot_Be_Null +' '+ inventoryPositionSO.Product_Name__r.Name;
                    return errorMsg;
                    // Check volume capacity of total product and selected bin if ignore storage limit is false
                }else if(!binLocationObj.Ignore_Storage_Limit__c && qtyToPutAway > 0.00 && qtyToPutAway > invPositionWrapper.balanceQtyToPutAway){
                    String binLocationName = binLocationObj.Name;
                    errorMsg = Label.Bin_Location_Capacity_Validation+' '+ binLocationName + ' '+String.valueOf(invPositionWrapper.qtyToPutAway) + ' '+inventoryPositionSO.Product_Name__r.Name;
                    return errorMsg;
                    // check total allocated space vs available bin location capacity
                } else {
                
                    // Add consumed space of bin of products assigned in inventory position
                    allocatedSpace = totalProductVolumeByBinLocationId.get(inventoryPositionSO.Bin_Location__c);
                    allocatedSpace = allocatedSpace == null ? 0.0 : allocatedSpace;
                    Decimal totalVolume = 0.0;
                    
                    // Do not add volume if selected bin location has ignore storage limit as true
                    if(!binLocationObj.Ignore_Storage_Limit__c){
                        totalVolume = invPositionWrapper.qtyToPutAway * inventoryPositionSO.Product_Name__r.Unit_Cubic_Volume__c;
                        totalVolume = totalVolume == null ? 0.0 : totalVolume;
                    
                        allocatedSpace += totalVolume;
                    }
                    totalProductVolumeByBinLocationId.put(inventoryPositionSO.Bin_Location__c, allocatedSpace);
                    
                    // get total available capacity of bin location
                    availableBinLocationCapacity = binConsumedCapacityById.get(inventoryPositionSO.Bin_Location__c);
                    
                    // check if total capacity exceeds available capacity
                    if(allocatedSpace > availableBinLocationCapacity){
                        String binLocationName = binLocationById.get(inventoryPositionSO.Bin_Location__c).Name;
                        errorMsg = String.format(Label.Total_Allocated_Space_Exceeds_Bin_Capacity, 
                                                        new List<String>{String.valueOf(allocatedSpace),
                                                                         binLocationName,
                                                                         String.valueOf(availableBinLocationCapacity)});
                        return errorMsg;
                    }
                }
            }
        }
        // Validation to check if any inventory position selected or not
        if(!hasInvPositionSelected){
            errorMsg = Label.No_Inventory_Position_Selected;
            return errorMsg;
        }
        return errorMsg;
    }
    
    /**
     * Validate inventory location details updated by user
     *
     * @return Boolean flag to indicate if any validation fails
     */
    public Boolean validateInputs(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        Boolean hasInvPositionSelected = false;
        Decimal allocatedSpace;
        Decimal availableBinLocationCapacity;
        totalProductVolumeByBinLocationId = new Map<Id, Decimal>();
        
        for(InventoryPositionWrapper invPositionWrapper : inventoryPositions){
            
            Decimal qtyToPutAway = invPositionWrapper.qtyToPutAway;
            Inventory_Position__c inventoryPositionSO = invPositionWrapper.invPositionSO;
            Bin_Location__c binLocationObj = binLocationById.get(inventoryPositionSO.Bin_Location__c);
            
            if(invPositionWrapper.isSelected){
                hasInvPositionSelected = true;
                allocatedSpace = 0.0;
                availableBinLocationCapacity = 0.0;
                
                // Check qty to put away cannot be blank and must be positive
                if(qtyToPutAway == null || qtyToPutAway <= 0.00 ){
                    message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                    String.format(Label.Qty_To_Put_Away_Positive_Value, 
                                                    new List<String>{inventoryPositionSO.Product_Name__r.Name}));
                    ApexPages.addMessage(message);
                    hasValidationError = true;
                }
                
                // Check qty to put away cannot be greater than qty on hand
                else if(qtyToPutAway > inventoryPositionSO.Qty_On_Hand__c){
                    message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                              String.format(Label.Qty_To_Put_Away_Cannot_Be_Greater_Than_Qty_On_Hand, 
                                              new List<String>{inventoryPositionSO.Product_Name__r.Name}));
                    ApexPages.addMessage(message);
                    hasValidationError = true;
                
                // Check Rack, Rack Level and Bin Location cannot be null
                }else if(inventoryPositionSO.Rack__c == null ||
                       inventoryPositionSO.Rack_Level__c == null ||
                       inventoryPositionSO.Bin_Location__c == null){
                        
                        message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                    String.format(Label.Rack_Rack_Level_Bin_Location_Cannot_Be_Null, 
                                                        new List<String>{inventoryPositionSO.Product_Name__r.Name}));
                        ApexPages.addMessage(message);
                        hasValidationError = true;
                
                // Check volume capacity of total product and selected bin if ignore storage limit is false
                }else if(!binLocationObj.Ignore_Storage_Limit__c && qtyToPutAway > 0.00 &&
                    qtyToPutAway > invPositionWrapper.balanceQtyToPutAway){
                    
                    String binLocationName = binLocationObj.Name;
                    message = new ApexPages.Message(ApexPages.Severity.ERROR,
                                                    String.format(Label.Bin_Location_Capacity_Validation, 
                                                                 new List<String>{binLocationName,
                                                                 String.valueOf(invPositionWrapper.qtyToPutAway),
                                                                 inventoryPositionSO.Product_Name__r.Name}));
                    ApexPages.addMessage(message);
                    hasValidationError = true;
                
                // check total allocated space vs available bin location capacity
                }else{
                
                    // Add consumed space of bin of products assigned in inventory position
                    allocatedSpace = totalProductVolumeByBinLocationId.get(inventoryPositionSO.Bin_Location__c);
                    allocatedSpace = allocatedSpace == null ? 0.0 : allocatedSpace;
                    Decimal totalVolume = 0.0;
                    
                    // Do not add volume if selected bin location has ignore storage limit as true
                    if(!binLocationObj.Ignore_Storage_Limit__c){
                        totalVolume = invPositionWrapper.qtyToPutAway * inventoryPositionSO.Product_Name__r.Unit_Cubic_Volume__c;
                        totalVolume = totalVolume == null ? 0.0 : totalVolume;
                    
                        allocatedSpace += totalVolume;
                    }
                    totalProductVolumeByBinLocationId.put(inventoryPositionSO.Bin_Location__c, allocatedSpace);
                    
                    // get total available capacity of bin location
                    availableBinLocationCapacity = binConsumedCapacityById.get(inventoryPositionSO.Bin_Location__c);
                    
                    // check if total capacity exceeds available capacity
                    if(allocatedSpace > availableBinLocationCapacity){
                        String binLocationName = binLocationById.get(inventoryPositionSO.Bin_Location__c).Name;
                        message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                                        String.format(Label.Total_Allocated_Space_Exceeds_Bin_Capacity, 
                                                        new List<String>{String.valueOf(allocatedSpace),
                                                                         binLocationName,
                                                                         String.valueOf(availableBinLocationCapacity)}));
                        ApexPages.addMessage(message);
                        hasValidationError = true;
                    }
                }
            }
        }
        
        // Validation to check if any inventory position selected or not
        if(!hasInvPositionSelected){
            message = new ApexPages.Message(ApexPages.Severity.ERROR, 
                                            Label.No_Inventory_Position_Selected);
            ApexPages.addMessage(message);
            hasValidationError = true;
        }
        return hasValidationError;
    }
    
    /**
     * Change the number of inventory positions to display according to selected page size
     */
    public PageReference doResetInventoryPositionsPageSize() {
        inventoryPositionsIterable = new CustomIterable(inventoryPositions, Integer.valueOf(pageSize)); 
        nextInventoryPositions(); 
        return null;
    }
    
    /**
     * Get Page size options to display number of inventory positions per page
     */
    public List<SelectOption> getPageSizeOptions() {
        List<SelectOption> options = new List<SelectOption>();
        
        options.add(new SelectOption('10', '10'));
        options.add(new SelectOption('25', '25'));
        options.add(new SelectOption('50', '50'));
        options.add(new SelectOption('100', '100'));
        
        return options; 
    }
    
    // flag to check if next and last link should be disabled or not
    public Boolean hasNextInventoryPositions {
        get{
            return inventoryPositionsIterable.hasNext();
        }
        set;
    }
    
    // flag to check if previous and first link should be disabled or not
    public Boolean hasPreviousInventoryPositions {
        get{
            return inventoryPositionsIterable.hasPrevious();
        }
        set;
    }
    
    // Inventory positions to be displayed on next link
    public void nextInventoryPositions(){
        setInventoryPositions.clear();
        System.debug('###setInventoryPositions::'+setInventoryPositions.size());
        for(Object inventoryPositionSO :inventoryPositionsIterable.next()) {
            setInventoryPositions.add((InventoryPositionWrapper)inventoryPositionSO);
        }
        System.debug('###setInventoryPositions22::'+setInventoryPositions.size());
    }
    
    // Inventory positions to be displayed on previous link
    public void previousInventoryPositions(){
        setInventoryPositions.clear();
        for(Object inventoryPositionSO :inventoryPositionsIterable.previous()) {
            setInventoryPositions.add((InventoryPositionWrapper)inventoryPositionSO);
        }
    }
    
    // Inventory positions to be displayed on first link
    public void firstInventoryPositions(){
        setInventoryPositions.clear();
        for(Object inventoryPositionSO :inventoryPositionsIterable.first()) {
            setInventoryPositions.add((InventoryPositionWrapper)inventoryPositionSO);
        }
    }
    
    // Inventory positions to be displayed on last link
    public void lastInventoryPositions(){
        setInventoryPositions.clear();
        for(Object inventoryPositionSO :inventoryPositionsIterable.last()) {
            setInventoryPositions.add((InventoryPositionWrapper)inventoryPositionSO);
        }
    }
    
    /**
     * Cancel action - Redirect to default view of put away inventory page
     *
     * @return PageReference of current page
     */
    public PageReference cancelAction() {
        return redirectToPutAwayInventoryPage();
    }
    
    
    /**
     * load Rack levels based on selected rack
     */
    public void loadRackLevels() {
        
        // Retrieve selected inventory position wrapper record based on selected inventory position id
        InventoryPositionWrapper invPositionWrapper = inventoryPositionById.get(selectedInvPositionId);
        
        // Reset rack level, bin location picklists and balance qty to put away
        List<SelectOption> rackLevelOptions = new List<SelectOption>();
        invPositionWrapper.binLocationOptions = new List<SelectOption>();
        invPositionWrapper.balanceQtyToPutAway = 0.0;
        selectedRackLevelId = null;
        
        // Retrieve list of rack levels based on selected rack id and create picklists of rack levels
        List<Rack_Level__c> filteredRackLevels = rackLevelsByRackId.get(selectedRackId);

        if(filteredRackLevels != null){
            for(Integer i=0; i<filteredRackLevels.size(); i++){
                if(i == 0){
                    selectedRackLevelId = filteredRackLevels[0].Id;
                }
                rackLevelOptions.add(new SelectOption(filteredRackLevels[i].Id, filteredRackLevels[i].Name));
            }
            rackLevelOptions = doSortOption(rackLevelOptions);
            if(selectedRackLevelId != null){
                loadBinLocations();
            }
        }
        invPositionWrapper.rackLevelOptions = rackLevelOptions;
    }
    
    /**
     * load Bin Locations based on selected rack level
     */
    public void loadBinLocations() {
        
        // Retrieve selected inventory position wrapper record based on selected inventory position id
        InventoryPositionWrapper invPositionWrapper = inventoryPositionById.get(selectedInvPositionId);
        
        // Reset bin location picklists
        List<SelectOption> binLocationOptions = new List<SelectOption>();
        selectedBinLocationId = null;
        
        // Retrieve list of bin locations based on selected rack level id and create picklists of bin locations
        List<Bin_Location__c> filteredBinLocations = binLocationsByRackLevelId.get(selectedRackLevelId);

        if(filteredBinLocations != null){
            for(Integer i=0; i<filteredBinLocations.size(); i++){
                if(i == 0){
                    selectedBinLocationId = filteredBinLocations[0].Id;
                }
                binLocationOptions.add(new SelectOption(filteredBinLocations[i].Id, filteredBinLocations[i].Name));
            }
            binLocationOptions = doSortOption(binLocationOptions);
        }
        invPositionWrapper.binLocationOptions = binLocationOptions;
        loadBalanceQtyToPutAway();
    }
    
    /**
     * load balance qty To Put Away for selected bin location
     */
    public void loadBalanceQtyToPutAway() {
        // Retrieve selected inventory position wrapper record based on selected inventory position id
        InventoryPositionWrapper invPositionWrapper = inventoryPositionById.get(selectedInvPositionId);
        invPositionWrapper.balanceQtyToPutAway = calculateRemainingQtyToPutAway(invPositionWrapper);
    }
    
    /**
     * Calculate remaining qty to put away
     *
     * @param selectedInvPositionWrapper The selected instance of inventory position wrapper class
     *
     * @return Remaining qty to put away
     */
    public Decimal calculateRemainingQtyToPutAway(InventoryPositionWrapper selectedInvPositionWrapper) {
        
        Decimal availableBinLocationCapacity = binConsumedCapacityById.get(selectedBinLocationId);
        Decimal unitProductVoume = selectedInvPositionWrapper.invPositionSO.Product_Name__r.Unit_Cubic_Volume__c;
        Decimal remainingQtyToPutAway = 0.0; 
        
        if(availableBinLocationCapacity != null && availableBinLocationCapacity != 0.0 && 
           unitProductVoume != null && unitProductVoume != 0){
            remainingQtyToPutAway = availableBinLocationCapacity.divide(unitProductVoume, 2);
        }
        return remainingQtyToPutAway;
    }
    
    /**
     * Search Inventory positios by Supplier Name, Product Name, Producer Name or PO number
     */
    public void runSearch() {
        
        inventoryPositions = new List<InventoryPositionWrapper>();
        
        if(!String.isBlank(searchText)){
            searchText = searchText.trim();
            for(Integer i=0; i<masterInventoryPositions.size(); i++){
                
                Inventory_Position__c invPositionTemp = masterInventoryPositions[i].invPositionSO;
                String supplierName = invPositionTemp.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_Name__r.Name;
                String poNumber = invPositionTemp.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Name;
                
                if((invPositionTemp.Product_Name__c != null && invPositionTemp.Product_Name__r.Name.containsIgnoreCase(searchText)) ||
                
                   (!String.isBlank(invPositionTemp.Producer_Name__c) && invPositionTemp.Producer_Name__c.containsIgnoreCase(searchText)) ||
                   
                   (!String.isBlank(supplierName) && supplierName.containsIgnoreCase(searchText)) ||
                   
                   (!String.isBlank(poNumber) && poNumber.containsIgnoreCase(searchText))){
                       
                    inventoryPositions.add(masterInventoryPositions[i]);
                }
            }
        }
        
        inventoryPositionsIterable = new CustomIterable(inventoryPositions, Integer.valueOf(pageSize)); 
        nextInventoryPositions();
    }
    
    // Reset search result - Load all records
    public void resetSearch() {
        
        inventoryPositions = masterInventoryPositions;
        inventoryPositionsIterable = new CustomIterable(inventoryPositions, Integer.valueOf(pageSize)); 
        nextInventoryPositions();
    }
    
    /**
     * Redirect to default view of put away inventory page
     *
     * @return PageReference of current page
     */
    private PageReference redirectToPutAwayInventoryPage() {
        PageReference page = new PageReference('/apex/PutAwayInventory');
        page.setRedirect(true);
        return page;
    }
    
    /**
     * Sort selectoptions based on labels
     *
     * @param opts The selectoptions
     *
     * @return  The sorted selectoptions
     */
    private List<Selectoption> doSortOption(List<Selectoption> opts) {
        
        Map<String, Selectoption> mapping = new Map<String, Selectoption>();
        // Suffix to avoid duplicate values like same labels or values are in inbound list 
        Integer suffix = 1;
        for (Selectoption opt : opts) {
            mapping.put((opt.getLabel() + suffix++), opt);   
        }
        
        List<String> sortKeys = new List<String>();
        sortKeys.addAll(mapping.keySet());
        sortKeys.sort();
        opts.clear();
        
        for (String key : sortKeys) {
            opts.add(mapping.get(key));
        }
        return opts;
    }
    // Wrapper class to store inventory position details
    public class InventoryPositionWrapper{
        @AuraEnabled public Boolean isSelected {get; set;}
       @AuraEnabled public Boolean QARecCheck {get; set;}
               @AuraEnabled public Boolean DisplayEyeIcon {get; set;}
               @AuraEnabled public List<string> DisplayEyeIconvalues {get; set;}
               @AuraEnabled public string Displayvalues {get; set;}

        @AuraEnabled public Inventory_Position__c invPositionSO {get; set;}
        @AuraEnabled public Decimal qtyToPutAway {get; set;}
        @AuraEnabled public Decimal balanceQtyToPutAway {get; set;}
        public List<SelectOption> rackOptions {get; set;}
        public List<SelectOption> rackLevelOptions {get; set;}
        public List<SelectOption> binLocationOptions {get; set;}
        @AuraEnabled public List<CustomSelectOptions> rackOptionsL {get; set;}
        @AuraEnabled public List<CustomSelectOptions> rackLevelOptionsL {get; set;}
        @AuraEnabled public List<CustomSelectOptions> binLocationOptionsL {get; set;}
        
        // Constructor
        public InventoryPositionWrapper(Inventory_Position__c invPositionSO){
            this.isSelected = false;
            this.QARecCheck=false;
            this.DisplayEyeIcon=false;
            this.Displayvalues='';
            this.DisplayEyeIconvalues = new List<string>();
            this.invPositionSO = invPositionSO;
            this.qtyToPutAway = 0.00;
            this.balanceQtyToPutAway = 0.00;
            this.rackOptions = new List<SelectOption>();
            this.rackLevelOptions = new List<SelectOption>();
            this.binLocationOptions = new List<SelectOption>();
            this.rackOptionsL = new List<CustomSelectOptions>();
            this.rackLevelOptionsL = new List<CustomSelectOptions>();
            this.binLocationOptionsL = new List<CustomSelectOptions>();
        }
    }
    
    public class CustomSelectOptions{
        @AuraEnabled public String label {get;set;}
        @AuraEnabled public String value {get;set;}
        
        public CustomSelectOptions() {
            this.label = '';
            this.value = '';
        }
        
        public CustomSelectOptions(String lab, String val) {
            this.label = lab;
            this.value = val;
        }
    }
}