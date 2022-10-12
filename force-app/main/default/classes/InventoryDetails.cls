/**************************************************************************************
Apex Class Name    : InventoryDetails 
Test Class Name    :InventoryDetailsTest
Version            : 1.0
Created Date       : July 01 2018
Function           : Used for InventoryDetails VF page and used in "InventoryDetails" VF page.
Modification Log   :
------------------------------------------------------------------------------
* Developer                   Date                   Description
* ----------------------------------------------------------------------------
* Suresh                  07/01/2018              Original Version
*Suresh                   08/30/2018              updated the code for Products rollups fields
*  Manan                  10/21/2018              Added logic for mass transfer button
*******************************************************************************/

public class InventoryDetails {
    
    
    Public Product2 prod {get; set;}
    Public List<Inventory_Position__c> invPositionList {get; set;}
    Public String recordID {get; set;}
    Public Double totalInventory {get; set;}
    Public Double allocatedInventoryQty {get; set;}
    Public Double inventoryOnHoldQty {get; set;}
    Public Double availableInventoryQty {get; set;}
    Public Double availableQty {get; set;}
    Public Double itemToPutAway {get; set;}
    Public Double totalCannabisWeight {get; set;}
    public String selectedRecordId { get; set; }
    //public String targetField { get; set; }
    public Boolean searchPageRender{ get; set; }
    public String searchPageRender2{ get; set; }
    public Boolean miscIssueSectionRender{ get; set; }
    public Boolean invPosSectionRender{ get; set; }
    public Boolean showMassTransferBlock{ get; set; }
    Public List<InventoryPositionWrapper> invPositionWrappList {get; set;}
    Public Inventory_Perpetual_Adjustment__c invPerAdj { get; set;}
    private String uniqueKeyFormat = '{0}{1}{2}{3}{4}{5}{6}{7}{8}{9}{10}{11}{12}';
    @TestVisible private static String ONEBYTHREE = '1 X 3';
    @TestVisible private static String TWOBYFOUR = '2 X 4';
    @TestVisible private static String FOURBYSIX = '4 X 6';
    public transient  String  imageTextSrc {get; set;}
    public transient  String  imageTextSrc1 {get; set;}
    public String selectedDymoLabelLayout {get; set;}
    public String selectedDymoPrinters {get; set;}
    public transient String imageXml {get; set;}
    public Boolean isSelectedInventory {get; set;}
    public transient String inventoryInfo {get; set;}
    public static List<CustomSelectOptions> options;
    public static List<CustomSelectOptions> optionPrinter;
    public static Product2 productObjLight {get; set;}
    private static final String NONE_VALUE = Label.NONE_VALUE;
    Public List<PutAwayInventoryController.InventoryPositionWrapper> inventoryPositions {get; set;}
    
    // List of Inventory Position Wrapper by Inventory Position Id
    private Map<Id, PutAwayInventoryController.InventoryPositionWrapper> inventoryPositionById;
    
    // Map of Inventory location by rack Id 
    private Map<Id, Id> inventoryLocationByRackId;
    
    // Map of Inventory location by Site Id 
    private Map<Id, List<Inventory_Location__c>> inventoryLocationBySiteId;
    // Map of Inventory location by Site Id 
    private Map<Id, List<Rack__c>> rackByLocationId;
    
    // List  of sites by rack id FG-141
    private Map<Id, List<Site__c>> siteByRackId;
    
    // List  of locations by rack id FG-141
    private Map<Id, List<Inventory_Location__c>> locationByRackId;
    
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
    
    // Selected inventory position and related attribute Ids set from page
    public Id selectedInvPositionId {get; set;}
    public Id selectedRackId {get; set;}
    public Id selectedRackLevelId {get; set;}
    public Id selectedBinLocationId {get; set;}
    List<String> AssignedWarehouseIds = new List<String>();
    Public static List<InventoryPositionWrapperPut> inventoryPositionsLight;
    private static Map<Id, InventoryPositionWrapperPut> inventoryPositionByIdLight;
    private static List<CustomSelectOptions> typeOptions;
    public InventoryDetails(){}
    public InventoryDetails(ApexPages.StandardController controller) {
        
        List<Product2> prodList = new List<Product2>();
        invPositionWrappList = new List<InventoryPositionWrapper>();
        invPerAdj = new Inventory_Perpetual_Adjustment__c();
        totalInventory=0.0;
        allocatedInventoryQty=0.0;
        inventoryOnHoldQty = 0.0;
        availableInventoryQty=0.0;
        availableQty=0.0;
        itemToPutAway=0.0;
        searchPageRender=true;
        miscIssueSectionRender=false;
        showMassTransferBlock = false;
        invPosSectionRender=true;
        recordID =ApexPages.currentPage().getParameters().get('Id');
        searchPageRender2=ApexPages.currentPage().getParameters().get('searchPageRender2');
        inventoryPositions = new List<PutAwayInventoryController.InventoryPositionWrapper>();
        inventoryPositionById = new Map<Id, PutAwayInventoryController.InventoryPositionWrapper>();
        rackLevelsByRackId = new Map<Id, List<Rack_Level__c>>();
        inventoryLocationBySiteId = new Map<Id, List<Inventory_Location__c>>();
        rackByLocationId = new Map<Id, List<Rack__c>>();
        binLocationsByRackLevelId = new Map<Id, List<Bin_Location__c>>();
        inventoryLocationByRackId = new Map<Id, Id>();
        binLocationById = new Map<Id, Bin_Location__c>();
        binConsumedCapacityById = new Map<Id, Decimal>();
        totalProductVolumeByBinLocationId = new Map<Id, Decimal>();
        //Get Assigned warehouse from loggedIn User
        User loggedInUser = [SELECT Id,Assigned_Warehouse_Ids__c FROM User WHERE Id = :UserInfo.getUserId()];
        if(loggedInUser.Assigned_Warehouse_Ids__c != null){
            AssignedWarehouseIds = loggedInUser.Assigned_Warehouse_Ids__c.split(',');
        }
        if(recordID!=null){
            if(searchPageRender2== 'true') {searchPageRender=true;}else {searchPageRender=false;}
            fillInvPositionWrappList(prodList);
            
        }
    }
    
    @AuraEnabled
    public static AuraResponse inventoryDetails(String recId,String srchPageRender2){
        
        InventoryDetails inv = new InventoryDetails();
        
        AuraResponse r = new AuraResponse('InventoryDetails.inventoryDetails()');
        List<Product2> prodList = new List<Product2>();
        inv.invPositionWrappList = new List<InventoryPositionWrapper>();
        inv.invPerAdj = new Inventory_Perpetual_Adjustment__c();
        inv.totalInventory=0.0;
        inv.allocatedInventoryQty=0.0;
        inv.inventoryOnHoldQty = 0.0;
        inv.availableInventoryQty=0.0;
        inv.availableQty=0.0;
        inv.itemToPutAway=0.0;
        inv.searchPageRender=true;
        inv.miscIssueSectionRender=false;
        inv.showMassTransferBlock = false;
        inv.invPosSectionRender=true;
        inv.recordID = recId;
        inv.searchPageRender2 = srchPageRender2;
        inventoryPositionsLight = new List<InventoryPositionWrapperPut>();
        inventoryPositionByIdLight = new Map<Id, InventoryPositionWrapperPut>();
        inv.rackLevelsByRackId = new Map<Id, List<Rack_Level__c>>();
        inv.inventoryLocationBySiteId = new Map<Id, List<Inventory_Location__c>>();
        inv.rackByLocationId = new Map<Id, List<Rack__c>>();
        inv.binLocationsByRackLevelId = new Map<Id, List<Bin_Location__c>>();
        inv.inventoryLocationByRackId = new Map<Id, Id>();
        inv.binLocationById = new Map<Id, Bin_Location__c>();
        inv.binConsumedCapacityById = new Map<Id, Decimal>();
        inv.totalProductVolumeByBinLocationId = new Map<Id, Decimal>();
        
        User loggedInUser = [SELECT Id,Assigned_Warehouse_Ids__c FROM User WHERE Id = :UserInfo.getUserId()];
        if(loggedInUser.Assigned_Warehouse_Ids__c != null){
            inv.AssignedWarehouseIds = loggedInUser.Assigned_Warehouse_Ids__c.split(',');
        }
        
        if(inv.recordID != null){
            if(inv.searchPageRender2 == 'true') 
            {
                inv.searchPageRender=true;
            }else  {
                inv.searchPageRender=false;
            }
            inv.fillInvPositionWrappList(prodList);
        }
        options = new List<CustomSelectOptions>();
        options.add(new CustomSelectOptions('', 'Select Layout'));
        options.add(new CustomSelectOptions(ONEBYTHREE, ONEBYTHREE));
        options.add(new CustomSelectOptions(TWOBYFOUR, TWOBYFOUR));
        options.add(new CustomSelectOptions(FOURBYSIX, FOURBYSIX));
        optionPrinter = new List<CustomSelectOptions>();
        optionPrinter.add(new CustomSelectOptions('', 'Select Printer'));
        
        AllProductDetails allRec= new AllProductDetails();
        allRec.prod = inv.prod;
        allRec.availableQty = inv.availableQty; 
        allRec.inventoryOnHoldQty = inv.inventoryOnHoldQty;
        allRec.invPositionWrappList = inv.invPositionWrappList; //Table data goes from here
        allRec.totalInventory = inv.totalInventory;
        allRec.allocatedInventoryQty = inv.allocatedInventoryQty;
        allRec.availableInventoryQty = inv.availableInventoryQty;
        allRec.itemToPutAway = inv.itemToPutAway;
        allRec.invPosSectionRender = inv.invPosSectionRender;
        allRec.invPerAdj = inv.invPerAdj;
        allRec.AssignedWarehouseIds = inv.AssignedWarehouseIds;
        allRec.dymoLabelLayouts = options;
        allRec.printers = optionPrinter;
        allRec.selectedDymoLabelLayout = '';
        allRec.selectedDymoPrinters ='';
        r.data.put('records', allRec);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse fetchFilterProducts(String str,String JSONStr1,String recId){
        
        AuraResponse r = new AuraResponse('InventoryDetails.fetchFilterProducts()');
        
        InventoryDetails inv = new InventoryDetails();
        
        List<InventoryPositionWrapper> invPositionWrappListNew = new List<InventoryPositionWrapper>();
        
        inv.invPositionWrappList = (List<InventoryPositionWrapper>) System.JSON.deserialize(jsonStr1, List<InventoryPositionWrapper>.class);
        //InventoryDetails.inventoryDetails(recId,'true');
        
        for( InventoryPositionWrapper var : inv.invPositionWrappList ){
            if(var.invPos.Name.indexOf(str) != -1){
                invPositionWrappListNew.add(var);
            }
        }
        if(invPositionWrappListNew.size() > 0){
            r.data.put('records', invPositionWrappListNew);    
        } else {
            InventoryDetails.inventoryDetails(recId,'true');
            r.data.put('records', inv.invPositionWrappList);    
        }
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse redirectToMiscIssue(String jsonStr1,String recId){
        AuraResponse r = new AuraResponse('InventoryDetails.redirectToMiscIssue()');
        InventoryDetails inv = new InventoryDetails();
        AllProductDetails allRec= new AllProductDetails();
        AuraResponse aura = InventoryDetails.inventoryDetails(recId,'true');
        allRec = (AllProductDetails) aura.data.get('records');
        inv.invPositionWrappList = (List<InventoryPositionWrapper>) System.JSON.deserialize(jsonStr1, List<InventoryPositionWrapper>.class);
        List<InventoryPositionWrapper> invPositionWrappListNew = new List<InventoryPositionWrapper>();
        inv.miscIssueSectionRender=true;
        inv.invPosSectionRender =false;
        inv.searchPageRender=false;
        
        for( InventoryPositionWrapper var : inv.invPositionWrappList ){
            if(var.isSelected == true){
                invPositionWrappListNew.add(var);
            }
        }
        inv.invPositionWrappList.clear();
        inv.invPositionWrappList.addAll(invPositionWrappListNew);
        
        List<String> pickListValuesList = new List<String>();
        Schema.SObjectType convertToObj = Schema.getGlobalDescribe().get('Inventory_Perpetual_Adjustment__c');
        Schema.DescribeSObjectResult res = convertToObj.getDescribe();
        Schema.DescribeFieldResult fieldResult = res.fields.getMap().get('Type__c').getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        
        typeOptions = new List<CustomSelectOptions>();
        typeOptions.add(new CustomSelectOptions('', NONE_VALUE));
        
        for( Schema.PicklistEntry pickListVal : ple){
            typeOptions.add(new CustomSelectOptions(pickListVal.getLabel(),pickListVal.getLabel()));    
        }
        
        allRec.invPositionWrappList = inv.invPositionWrappList;
        allRec.invPosSectionRender = inv.invPosSectionRender;
        allRec.miscIssueSectionRender = inv.miscIssueSectionRender;
        allRec.invPerAdjTypes = typeOptions;
        
        r.data.put('records', allRec);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse SaveRecord(String jsonStr1,Inventory_Perpetual_Adjustment__c invPer,String recId){
        AuraResponse r = new AuraResponse('InventoryDetails.SaveRecord()');
        
        InventoryDetails inv = new InventoryDetails();
        inv.invPositionWrappList = (List<InventoryPositionWrapper>) System.JSON.deserialize(jsonStr1, List<InventoryPositionWrapper>.class);
        inv.invPerAdj = invPer;
        
        List<Inventory_Position__c> invPositionList = new List<Inventory_Position__c>();
        Set<Id> inventorySiteIds = new Set<Id>();
        for( InventoryPositionWrapper var : inv.invPositionWrappList ){
            inventorySiteIds.add(var.invPos.Site__c);
        }
        Map<Id,Site__c> inventorySiteMap = new Map<Id,Site__c>();
        if(inventorySiteIds.size() > 0){
            inventorySiteMap = new Map<Id,Site__c>([SELECT Id,Name ,(SELECT Id, Name FROM Inventory_Locations__r WHERE Name = 'Inventory Write-Off') FROM Site__c WHERE Id IN :inventorySiteIds]);
        }
        for( InventoryPositionWrapper var : inv.invPositionWrappList ){
            
            Inventory_Position__c invObj=var.invPos;
            if(var.invPos.Sales_Order_Line__c != null && (var.invPos.Sales_Order_Line__r.Status__c =='Allocated' || var.invPos.Sales_Order_Line__r.Status__c =='Partially Allocated')){
                String message1 = '"Sales Order Line" has value and SO Line item Status = "Partially Allocated" or "Allocated"';
                r.data.put('Error', message1);
                return r;
            }
            if(var.invPos.Qty_On_Hand__c ==0){
                String message = 'We cannot do MIsc.Issue where Qty on hand = 0';
                r.data.put('Error', message);
                return r;
            }
            else if(var.qtyToAdjust <= 0 || var.qtyToAdjust > var.invPos.Qty_On_Hand__c){
                String message ='Please enter valid entry for "Qty to Adjust" field';
                r.data.put('Error', message);
                return r;
            }
            else if( var.qtyToAdjust > 0 && var.qtyToAdjust <= var.invPos.Qty_On_Hand__c && var.qtyToAdjust != var.invPos.Qty_On_Hand__c){
                invObj.Qty_On_Hand__c=var.invPos.Qty_On_Hand__c - var.qtyToAdjust;
                var.invPos.Qty_On_Hand__c =invObj.Qty_On_Hand__c;
            }
            else{
                if(inventorySiteMap.containsKey(var.invPos.Site__c)){
                    Site__c site = inventorySiteMap.get(var.invPos.Site__c);
                    if(site.Inventory_Locations__r.size() == 0){
                        String message =site.Name + ' do not have Inventory Write-Off Inventory Location.';
                        r.data.put('Error', message);
                        return r;
                    }else{
                        var.invPos.Inventory_Location__c = site.Inventory_Locations__r[0].Id;//'a0Q2F000002bx3bUAA';
                        var.invPos.Rack__c = null;
                        var.invPos.Rack_Level__c = null;
                        var.invPos.Bin_Location__c = null;
                        //invObj.Qty_On_Hand__c=var.invPos.Qty_On_Hand__c - var.qtyToAdjust;
                        //var.invPos.Qty_On_Hand__c =invObj.Qty_On_Hand__c;
                    }
                }
                
            }
            invPositionList.add(invObj);
        }
        update invPositionList;
        createInventoryPerpetualAdjustment(inv.invPositionWrappList,inv.invPerAdj);
        AuraResponse aura = InventoryDetails.inventoryDetails(recId,'true');
        AllProductDetails allRec= new AllProductDetails();
        allRec = (AllProductDetails) aura.data.get('records');
        r.data.put('records', allRec);
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse holdUnHoldIps(String selectedIds1,String type,String recId){
        AuraResponse r = new AuraResponse('InventoryDetails.holdUnHoldIps()');
        
        InventoryDetails inv = new InventoryDetails();
        
        inv.recordID = recId;
        AllProductDetails allRec= new AllProductDetails();
        
        List<string> wrapperList = (List<string>) System.JSON.deserialize(selectedIds1, List<String>.class);
        Set<Id> setIds = new Set<Id>();
        for(String str : wrapperList)
            setIds.add(str);
        List<Inventory_Position__c> updateIPs = new List<Inventory_Position__c>();
        for(Inventory_Position__c ip : [SELECT Id,Hold__c,Sales_Order_Line__c FROM Inventory_Position__c
                                        WHERE Id IN :setIds Order By CreatedDate Asc]){
                                            System.debug('Hello');
                                            if(String.isBlank(ip.Sales_Order_Line__c)){
                                                Inventory_Position__c uip = new Inventory_Position__c();
                                                uip.Id = ip.Id;
                                                if(type == 'Hold')
                                                    uip.Hold__c = true;
                                                else
                                                    uip.Hold__c = false;
                                                updateIPs.add(uip);
                                            } else{
                                                allRec.errorMsg = 'SOLI Exists';
                                                r.data.put('Error', allRec);
                                                return r;
                                            }  
                                        }
        if(!updateIPs.isEmpty()){
            update updateIPs;
            AuraResponse aura = InventoryDetails.inventoryDetails(recId,'true');
            allRec = (AllProductDetails) aura.data.get('records');
        }
        r.data.put('records', allRec);
        return r;
    }
    
    /**
* Mass transfer action - Move inventory from one location to another with specific qty
*/
    @AuraEnabled
    public static AuraResponse massTransferAction(String jsonStr1,String recId){
        AuraResponse r = new AuraResponse('InventoryDetails.massTransferAction()');
        
        InventoryDetails inv = new InventoryDetails();
        inv.inventoryLocationByRackId = new Map<Id,Id>();
        inv.inventoryLocationBySiteId = new Map<Id, List<Inventory_Location__c>>();
        inv.rackByLocationId = new Map<Id, List<Rack__c>>();
        inv.rackLevelsByRackId = new Map<Id, List<Rack_Level__c>>();
        inv.binConsumedCapacityById = new Map<Id, Decimal>();
        inv.totalProductVolumeByBinLocationId = new Map<Id, Decimal>();
        inv.binLocationById = new Map<Id, Bin_Location__c>();
        inv.binLocationsByRackLevelId = new Map<Id, List<Bin_Location__c>>();
        
        AllProductDetails allRec= new AllProductDetails();
        
        Set<Id> invPositionIds = new Set<Id>();
        
        AuraResponse aura = InventoryDetails.inventoryDetails(recId,'true');
        allRec = (AllProductDetails) aura.data.get('records');
        inv.invPositionWrappList = (List<InventoryPositionWrapper>) System.JSON.deserialize(jsonStr1, List<InventoryPositionWrapper>.class);
        
        // Check if any unassigned inventory is selected to transfer. If not then give warning message to select it
        // Filter inventory having receiving inspection location
        for( InventoryPositionWrapper var : inv.invPositionWrappList ){
            if(var.isSelected == true && var.invPos.Sales_Order_Line__c == null
               && var.invPos.Inventory_Location__r.Name != Label.Default_Inventory_Location){
                   invPositionIds.add(var.invPos.Id);
               }
        }
        
        if(invPositionIds.size() == 0){
            allRec.errorMsg = Label.No_Inventory_Selected_To_Transfer;
            r.data.put('Error', allRec);
            return r;
        }else{
            inv.showMassTransferBlock = true; // Show mass transfer page block
            inv.invPosSectionRender = false; // Hide default inventory position table
        }
        
        List<Inventory_Position__c> inventoryPositionList = new List<Inventory_Position__c>();
        List<Inventory_Position__c> filteredInventoryPositionList = new List<Inventory_Position__c>();
        List<Rack__c> racks = new List<Rack__c>();
        List<Rack_Level__c> rackLevels = new List<Rack_Level__c>();
        List<Bin_Location__c> binLocations = new List<Bin_Location__c>();
        
        List<CustomSelectOptions> rackOptions = new List<CustomSelectOptions>();
        List<CustomSelectOptions> siteOptions = new List<CustomSelectOptions>();
        List<CustomSelectOptions> locationOptions = new List<CustomSelectOptions>();
        rackOptions.add(new CustomSelectOptions('', NONE_VALUE));
        siteOptions.add(new CustomSelectOptions('', NONE_VALUE));
        locationOptions.add(new CustomSelectOptions('', NONE_VALUE));
        Map<Id, List<CustomSelectOptions>> locationOptionsBySiteId = new Map<Id, List<CustomSelectOptions>>();
        Map<Id, List<CustomSelectOptions>> rackOptionsByLocationId = new Map<Id, List<CustomSelectOptions>>();
        Map<Id, List<CustomSelectOptions>> rackLevelOptionsByRackId = new Map<Id, List<CustomSelectOptions>>();
        Map<Id, List<CustomSelectOptions>> binLocationOptionsByRackLevelId = new Map<Id, List<CustomSelectOptions>>();
        
        
        Map<Id, List<Inventory_Location__c>> invlocBySiteId = new Map<Id, List<Inventory_Location__c>>();
        
        Set<Id> siteIds = new Set<Id>();
        Set<Id> rackIds = new Set<Id>();
        Set<Id> rackLevelIds = new Set<Id>();
        inventoryPositionList = new List<Inventory_Position__c>();
        List<String> invPositionFieldNames = inv.getSObjectFieldNames('Inventory_Position__c'); 
        
        String invPositionQuery = 'Select ' +
            String.join( invPositionFieldNames, ',' ) + ' ' +
            ', Rack_Level__r.Name ' +
            ', Bin_Location__r.Name ' +
            ', Ownership__r.Name ' +
            ', Site__r.Name ' +
            ', Product_Name__r.Unit_Cubic_Volume__c ' +
            ', Product_Name__r.Name ' +
            ', Product_Name__r.Description ' +
            ', Inventory_Location__r.Name ' +
            ', Inventory_Location__r.Include_in_Inventory_Transfer__c ' +
            ', Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_Name__r.Name ' +
            ', Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Name ' +
            'From Inventory_Position__c ' +
            'Where Id IN: invPositionIds ' +
            'AND Sales_Order_Line__c = null ' +
            'ORDER BY Name';
        
        inventoryPositionList = Database.query(invPositionQuery);
        
        
        // Add all site Ids from all inventory positions
        for(Inventory_Position__c inventoryPositionSO : inventoryPositionList){
            // Add site ids
            siteIds.add(inventoryPositionSO.Site__c);
        }
        List<String> AssignedWarehouseIds = new List<String>();
        //Get Assigned warehouse from loggedIn User
        User loggedInUser = [SELECT Id,Assigned_Warehouse_Ids__c FROM User WHERE Id = :UserInfo.getUserId()];
        if(loggedInUser.Assigned_Warehouse_Ids__c != null){
            AssignedWarehouseIds = loggedInUser.Assigned_Warehouse_Ids__c.split(',');
            for(Site__c site:[SELECT Id, Name, Active__c FROM Site__c WHERE Id IN: AssignedWarehouseIds and Active__c =: true]){
                siteOptions.add(new CustomSelectOptions(site.Id,site.Name));
            }
            
            
            for(Inventory_Location__c IL: [SELECT Id,Name,Site_Name__c FROM Inventory_Location__c WHERE Site_Name__c IN: AssignedWarehouseIds and Include_in_Inventory_Transfer__c =: true]){
            	if(inv.inventoryLocationBySiteId.containsKey(IL.Site_Name__c)){
                    inv.inventoryLocationBySiteId.get(IL.Site_Name__c).add(IL);
                } else {
                    inv.inventoryLocationBySiteId.put(IL.Site_Name__c, new List<Inventory_Location__c>{IL});
                }
                
                locationOptions.add(new CustomSelectOptions(IL.Id,IL.Name));
                
                if(locationOptionsBySiteId.containsKey(IL.Site_Name__c)){
                    locationOptionsBySiteId.get(IL.Site_Name__c).add(new CustomSelectOptions(IL.Id, IL.Name));
                }else{
                    locationOptionsBySiteId.put(IL.Site_Name__c,new List<CustomSelectOptions>{new CustomSelectOptions(IL.Id, IL.Name)});
                }
            }
        }
        // Get all racks related to all inventory locations pertain to all sites
        // Create list of rack options to display on page at the time of page load
        for(Rack__c rackSO : [Select Name, Inventory_Location__c, Inventory_Location__r.Name From Rack__c 
                              Where Inventory_Location__r.Site_Name__c IN: AssignedWarehouseIds ORDER BY NAME]){
                                  racks.add(rackSO);
                                  rackIds.add(rackSO.Id);
                                  //rackOptions.add(new CustomSelectOptions(rackSO.Id, rackSO.Inventory_Location__r.Name + ' - ' +rackSO.Name));
                                  rackOptions.add(new CustomSelectOptions(rackSO.Id, rackSO.Name));
                                  rackOptions = doSortOption(rackOptions);
                                  inv.inventoryLocationByRackId.put(rackSO.Id, rackSO.Inventory_Location__c);
                                  if(rackOptionsByLocationId.containsKey(rackSO.Inventory_Location__c)){
                                      //rackOptionsByLocationId.get(rackSO.Inventory_Location__c).add(new CustomSelectOptions(rackSO.Id, rackSO.Inventory_Location__r.Name + ' - ' +rackSO.Name));
                                      rackOptionsByLocationId.get(rackSO.Inventory_Location__c).add(new CustomSelectOptions(rackSO.Id,rackSO.Name));
                                  }else{
                                      //rackOptionsByLocationId.put(rackSO.Inventory_Location__c,new List<CustomSelectOptions>{new CustomSelectOptions(rackSO.Id, rackSO.Inventory_Location__r.Name + ' - ' +rackSO.Name)});
                                      rackOptionsByLocationId.put(rackSO.Inventory_Location__c,new List<CustomSelectOptions>{new CustomSelectOptions(rackSO.Id, rackSO.Name)});
                                  }
                                  if(inv.rackByLocationId.containsKey(rackSO.Inventory_Location__c)){
                                      inv.rackByLocationId.get(rackSO.Inventory_Location__c).add(rackSO);
                                  }else{
                                      inv.rackByLocationId.put(rackSO.Inventory_Location__c, new List<Rack__c>{rackSO});
                                  }
                              }
        
        // Construct map of all rack levels by rack id
        for(Rack_Level__c rackLevelSO : [Select Name, Rack__c From Rack_Level__c Where Rack__c IN: rackIds ORDER BY NAME]) {
            List<Rack_Level__c> rackLevelsTemp = inv.rackLevelsByRackId.get(rackLevelSO.Rack__c);
            List<CustomSelectOptions> rackLevelOptionsTemp = rackLevelOptionsByRackId.get(rackLevelSO.Rack__c);
            
            if(rackLevelsTemp == null) {
                rackLevelsTemp = new List<Rack_Level__c>();
                inv.rackLevelsByRackId.put(rackLevelSO.Rack__c, rackLevelsTemp);
                rackLevelOptionsTemp = new List<CustomSelectOptions>();
                rackLevelOptionsTemp.add(new CustomSelectOptions('', NONE_VALUE));
                rackLevelOptionsByRackId.put(rackLevelSO.Rack__c, rackLevelOptionsTemp);
            }
            rackLevelsTemp.add(rackLevelSO);
            rackLevelIds.add(rackLevelSO.Id);
            rackLevelOptionsTemp.add(new CustomSelectOptions(rackLevelSO.Id, rackLevelSO.Name));
            rackLevelOptionsTemp = doSortOption(rackLevelOptionsTemp);
        }
        
        // Construct map of all bin locations by rack level id
        for(Bin_Location__c binLocationSO : [Select Name, Bin_Volume_Capacity__c, Rack_Level__c, Ignore_Storage_Limit__c From Bin_Location__c Where Rack_Level__c IN: rackLevelIds ORDER BY NAME]) {
            // Initialize the map for storing total capacity of bin
            inv.binConsumedCapacityById.put(binLocationSO.Id, binLocationSO.Bin_Volume_Capacity__c);
            
            // Initialize the map for storing allocated space of bin location 
            inv.totalProductVolumeByBinLocationId.put(binLocationSO.Id, 0.0);
            inv.binLocationById.put(binLocationSO.Id, binLocationSO);
            List<Bin_Location__c> binLocationsTemp = inv.binLocationsByRackLevelId.get(binLocationSO.Rack_Level__c);
            List<CustomSelectOptions> binLocationOptionsTemp = binLocationOptionsByRackLevelId.get(binLocationSO.Rack_Level__c);
            
            if(binLocationsTemp == null) {
                binLocationsTemp = new List<Bin_Location__c>();
                inv.binLocationsByRackLevelId.put(binLocationSO.Rack_Level__c, binLocationsTemp);
                binLocationOptionsTemp = new List<CustomSelectOptions>();
                binLocationOptionsTemp.add(new CustomSelectOptions('', NONE_VALUE));
                binLocationOptionsByRackLevelId.put(binLocationSO.Rack_Level__c, binLocationOptionsTemp);
            }
            binLocationsTemp.add(binLocationSO);
            binLocationOptionsTemp.add(new CustomSelectOptions(binLocationSO.Id, binLocationSO.Name));
            binLocationOptionsTemp = doSortOption(binLocationOptionsTemp);
        }
        
        // Calculate balance capacity of bin location
        Decimal consumedSpace = 0.0;
        for(Inventory_Position__c inventoryPositionSO : inventoryPositionList){
            // Add consumed space of bin of products assigned in inventory position
            consumedSpace = inv.binConsumedCapacityById.get(inventoryPositionSO.Bin_Location__c);
            if(consumedSpace != null && consumedSpace > 0.0){
                consumedSpace -= (inventoryPositionSO.Total_Product_Volume__c);
                inv.binConsumedCapacityById.put(inventoryPositionSO.Bin_Location__c, consumedSpace);
            }
        }
        
        // Create wrapper list of inventory position
        for(Inventory_Position__c inventoryPositionSO : inventoryPositionList){
            // Add inventory position in iterable interface
            // 
            InventoryPositionWrapperPut invPositionWrapper = new InventoryPositionWrapperPut(inventoryPositionSO);
            invPositionWrapper.siteOptions = siteOptions;
            invPositionWrapper.locationOptions = locationOptionsBySiteId.get(inventoryPositionSO.Site__c);//locationOptions;
            invPositionWrapper.rackOptions = rackOptionsByLocationId.get(inventoryPositionSO.Inventory_Location__c);
            invPositionWrapper.rackLevelOptions = rackLevelOptionsByRackId.get(inventoryPositionSO.Rack__c);
            invPositionWrapper.binLocationOptions = binLocationOptionsByRackLevelId.get(inventoryPositionSO.Rack_Level__c);
            
            if(invPositionWrapper.locationOptions != null && invPositionWrapper.locationOptions.size() > 1){
                Map<String, CustomSelectOptions> mapping = new Map<String, CustomSelectOptions>();
                // Suffix to avoid duplicate values like same labels or values are in inbound list 
                Integer suffix = 1;
                for (CustomSelectOptions opt : invPositionWrapper.locationOptions) {
                    mapping.put((opt.value + suffix++), opt);   
                }
                
                List<String> sortKeys = new List<String>();
                sortKeys.addAll(mapping.keySet());
                sortKeys.sort();
                invPositionWrapper.locationOptions.clear();
                
                for (String key : sortKeys) {
                    invPositionWrapper.locationOptions.add(mapping.get(key));
                }
            }
            
            Decimal availableBinLocationCapacity = 0.0;
            
            if(inv.binConsumedCapacityById.containsKey(inventoryPositionSO.Bin_Location__c)){
                availableBinLocationCapacity = inv.binConsumedCapacityById.get(inventoryPositionSO.Bin_Location__c);    
            }
            
            Decimal unitProductVoume = inventoryPositionSO.Product_Name__r.Unit_Cubic_Volume__c;
            Decimal remainingQtyToPutAway = 0.0;
            if(availableBinLocationCapacity != null && availableBinLocationCapacity != 0.0 && 
               unitProductVoume != null && unitProductVoume != 0){
                   remainingQtyToPutAway = availableBinLocationCapacity.divide(unitProductVoume, 2);
               }
            invPositionWrapper.balanceQtyToPutAway = remainingQtyToPutAway;
            
            inventoryPositionsLight.add(invPositionWrapper);
            inventoryPositionByIdLight.put(inventoryPositionSO.Id, invPositionWrapper);
        }
        
        allRec.invPositionWrappList = inv.invPositionWrappList;
        allRec.totalProductVolumeByBinLocationId = inv.totalProductVolumeByBinLocationId;
        allRec.binLocationById = inv.binLocationById;
        allRec.binConsumedCapacityById = inv.binConsumedCapacityById;
        allRec.inventoryPositionByIdLight = inventoryPositionByIdLight;
        allRec.rackLevelsByRackId = inv.rackLevelsByRackId;
        allRec.rackByLocationId = inv.rackByLocationId;
        allRec.inventoryLocationBySiteId = inv.inventoryLocationBySiteId;
        allRec.binLocationsByRackLevelId = inv.binLocationsByRackLevelId;
        allRec.invPosSectionRender = inv.invPosSectionRender;
        allRec.inventoryPositions = inventoryPositionsLight;
        allRec.showMassTransferBlock = inv.showMassTransferBlock;
        r.data.put('records', allRec);
        r.data.put('inventoryDetails', inv);
        
        return r;
    }
    
    @AuraEnabled
    public static AuraResponse loadIPSitesRec(String selectedInvPositionId, String inventoryPos, String selectedSiteId, String locations,
                                              String racks, String rackLevel, String binLevel, String binConsume, String selectedBinLocationId){
                                                  AuraResponse r = new AuraResponse('InventoryDetails.loadIPSitesRec()');
                                                  
                                                  List<InventoryPositionWrapperPut> lstInvWrp =(List<InventoryPositionWrapperPut>) System.JSON.deserialize(inventoryPos, List<InventoryPositionWrapperPut>.class);
                                                  
                                                  Map<Id, List<Inventory_Location__c>> locationBySiteId =  new Map<Id, List<Inventory_Location__c>>();
                                                  Map<Id, List<Rack__c>> racksByLocationId =  new Map<Id, List<Rack__c>>();
                                                  Map<Id, List<Rack_Level__c>> racksLevelByRackId =  new Map<Id, List<Rack_Level__c>>();
                                                  Map<Id, List<Bin_Location__c>> binLevelByRackLevelId =  new Map<Id, List<Bin_Location__c>>();
                                                  
                                                  Map<String, Object> metaLocation = locations != null ? (Map<String, Object>) JSON.deserializeUntyped(locations) : new Map<String, Object>();
                                                  Map<String, Object> metaRacks = racks != null ? (Map<String, Object>) JSON.deserializeUntyped(racks) : new Map<String, Object>();
                                                  Map<String, Object> metaRackLevel = rackLevel != null ? (Map<String, Object>) JSON.deserializeUntyped(rackLevel) : new Map<String, Object>(); 
                                                  Map<String, Object> metaBinLevel = binLevel != null ? (Map<String, Object>) JSON.deserializeUntyped(binLevel) : new Map<String, Object>(); 
                                                  Map<String, Object> metaBin = binConsume != null ? (Map<String, Object>) JSON.deserializeUntyped(binConsume) : new Map<String, Object>();
                                                  
                                                  
                                                  Map<Id, Decimal> binConsumedCapacityById =  new Map<Id,Decimal>();
                                                  for(Object target : metaBin.keySet()) { 
                                                      binConsumedCapacityById.put(Id.valueOf(String.valueOf(target)),(Decimal)metaBin.get(String.valueOf(target)));
                                                  } 
                                                  
                                                  for(Object target : metaLocation.keySet()) { 
                                                      String jsonStr = JSON.serialize(metaLocation.get(String.valueOf(target)));
                                                      System.debug('##target:'+String.valueOf(target));
                                                      System.debug('##jsonStr:'+jsonStr);
                                                      locationBySiteId.put(Id.valueOf(String.valueOf(target)),(List<Inventory_Location__c>)System.JSON.deserialize(jsonStr, List<Inventory_Location__c>.class));
                                                  }
                                                  
                                                  for(Object target : metaRacks.keySet()) { 
                                                      String jsonStr = JSON.serialize(metaRacks.get(String.valueOf(target)));
                                                      racksByLocationId.put(Id.valueOf(String.valueOf(target)),(List<Rack__c>)System.JSON.deserialize(jsonStr, List<Rack__c>.class));
                                                  } 
                                                  
                                                  for(Object target : metaRackLevel.keySet()) { 
                                                      String jsonStr = JSON.serialize(metaRackLevel.get(String.valueOf(target)));
                                                      racksLevelByRackId.put(Id.valueOf(String.valueOf(target)),(List<Rack_Level__c>)System.JSON.deserialize(jsonStr, List<Rack_Level__c>.class));
                                                  }                                          
                                                  
                                                  for(Object target : metaBinLevel.keySet()) { 
                                                      String jsonStr = JSON.serialize(metaBinLevel.get(String.valueOf(target)));
                                                      binLevelByRackLevelId.put(Id.valueOf(String.valueOf(target)),(List<Bin_Location__c>)System.JSON.deserialize(jsonStr, List<Bin_Location__c>.class));
                                                  } 
                                                  
                                                  for(InventoryPositionWrapperPut inv : lstInvWrp){
                                                      if(inv.invPositionSO.Id == selectedInvPositionId){
                                                          InventoryDetails invRec = new InventoryDetails();
                                                          List<CustomSelectOptions> locationOptions = new List<CustomSelectOptions>();
                                                          List<CustomSelectOptions> rackOptions = new List<CustomSelectOptions>();
                                                          List<CustomSelectOptions> rackLevelOptions = new List<CustomSelectOptions>();
                                                          List<CustomSelectOptions> binLocationOptions = new List<CustomSelectOptions>();
                                                          
                                                          inv.invPositionSO.Inventory_Location__c = null;
                                                          inv.invPositionSO.Rack__c = null;
                                                          inv.invPositionSO.Rack_Level__c = null;
                                                          inv.invPositionSO.Bin_Location__c = null;
                                                          
                                                          inv.rackOptions = new List<CustomSelectOptions>();
                                                          inv.rackLevelOptions = new List<CustomSelectOptions>();
                                                          inv.binLocationOptions = new List<CustomSelectOptions>();
                                                          inv.balanceQtyToPutAway = 0.0;
                                                          invRec.selectedRackLevelId = null;
                                                          
                                                          locationOptions.add(new CustomSelectOptions('', NONE_VALUE));
                                                          rackOptions.add(new CustomSelectOptions('', NONE_VALUE));
                                                          rackLevelOptions.add(new CustomSelectOptions('', NONE_VALUE));
                                                          binLocationOptions.add(new CustomSelectOptions('', NONE_VALUE));
                                                          
                                                          List<Inventory_Location__c> filteredLocation = new List<Inventory_Location__c>();
                                                          List<Rack__c> filteredRacks = new List<Rack__c>();
                                                          List<Rack_Level__c> filteredRackLevels = new List<Rack_Level__c>();
                                                          List<Bin_Location__c> filteredBinLevels = new List<Bin_Location__c>();
                                                          
                                                          if(String.isNotBlank(selectedSiteId)){
                                                              filteredLocation = locationBySiteId.get(selectedSiteId);    
                                                          }
                                                          
                                                          System.debug('##filteredLocation:'+filteredLocation);
                                                          for(Integer i=0; i<filteredLocation.size(); i++){
                                                              locationOptions.add(new CustomSelectOptions(filteredLocation[i].Id, filteredLocation[i].Name));
                                                          }
                                                          
                                                          if(locationOptions.size() > 1){
                                                              Map<String, CustomSelectOptions> mapping = new Map<String, CustomSelectOptions>();
                                                              // Suffix to avoid duplicate values like same labels or values are in inbound list 
                                                              Integer suffix = 1;
                                                              for (CustomSelectOptions opt : locationOptions) {
                                                                  mapping.put((opt.value + suffix++), opt);   
                                                              }
                                                              
                                                              List<String> sortKeys = new List<String>();
                                                              sortKeys.addAll(mapping.keySet());
                                                              sortKeys.sort();
                                                              locationOptions.clear();
                                                              
                                                              for (String key : sortKeys) {
                                                                  locationOptions.add(mapping.get(key));
                                                              }    
                                                          }
                                                          
                                                          inv.locationOptions = locationOptions;
                                                          inv.rackOptions = rackOptions;
                                                          inv.rackLevelOptions = rackLevelOptions;
                                                          inv.binLocationOptions = binLocationOptions;
                                                          Decimal remainingQtyToPutAway = 0.0; 
                                                          inv.balanceQtyToPutAway = remainingQtyToPutAway;
                                                      }
                                                  }
                                                  r.data.put('records', lstInvWrp);
                                                  return r;
                                              }
    
    
    @AuraEnabled
    public static AuraResponse loadIPLocationRec(String selectedInvPositionId, String inventoryPos, String selectedLocationId,String racks,
                                                 String rackLevel, String binLevel, String binConsume, String selectedBinLocationId){
                                                     AuraResponse r = new AuraResponse('InventoryDetails.loadIPLocationRec()');
                                                     
                                                     List<InventoryPositionWrapperPut> lstInvWrp =(List<InventoryPositionWrapperPut>) System.JSON.deserialize(inventoryPos, List<InventoryPositionWrapperPut>.class);
                                                     
                                                     Map<Id, List<Rack__c>> racksByLocationId =  new Map<Id, List<Rack__c>>();
                                                     Map<Id, List<Rack_Level__c>> racksLevelByRackId =  new Map<Id, List<Rack_Level__c>>();
                                                     Map<Id, List<Bin_Location__c>> binLevelByRackLevelId =  new Map<Id, List<Bin_Location__c>>();
                                                     
                                                     Map<String, Object> metaRacks = (Map<String, Object>) JSON.deserializeUntyped(racks);
                                                     Map<String, Object> metaRackLevel = (Map<String, Object>) JSON.deserializeUntyped(rackLevel); 
                                                     Map<String, Object> metaBinLevel = (Map<String, Object>) JSON.deserializeUntyped(binLevel); 
                                                     Map<String, Object> metaBin = (Map<String, Object>) JSON.deserializeUntyped(binConsume);
                                                     
                                                     
                                                     Map<Id, Decimal> binConsumedCapacityById =  new Map<Id,Decimal>();
                                                     for(Object target : metaBin.keySet()) { 
                                                         binConsumedCapacityById.put(Id.valueOf(String.valueOf(target)),(Decimal)metaBin.get(String.valueOf(target)));
                                                     } 
                                                     
                                                     
                                                     for(Object target : metaRacks.keySet()) { 
                                                         String jsonStr = JSON.serialize(metaRacks.get(String.valueOf(target)));
                                                         racksByLocationId.put(Id.valueOf(String.valueOf(target)),(List<Rack__c>)System.JSON.deserialize(jsonStr, List<Rack__c>.class));
                                                     } 
                                                     
                                                     for(Object target : metaRackLevel.keySet()) { 
                                                         String jsonStr = JSON.serialize(metaRackLevel.get(String.valueOf(target)));
                                                         racksLevelByRackId.put(Id.valueOf(String.valueOf(target)),(List<Rack_Level__c>)System.JSON.deserialize(jsonStr, List<Rack_Level__c>.class));
                                                     }                                          
                                                     
                                                     for(Object target : metaBinLevel.keySet()) { 
                                                         String jsonStr = JSON.serialize(metaBinLevel.get(String.valueOf(target)));
                                                         binLevelByRackLevelId.put(Id.valueOf(String.valueOf(target)),(List<Bin_Location__c>)System.JSON.deserialize(jsonStr, List<Bin_Location__c>.class));
                                                     } 
                                                     
                                                     for(InventoryPositionWrapperPut inv : lstInvWrp){
                                                         if(inv.invPositionSO.Id == selectedInvPositionId){
                                                             InventoryDetails invRec = new InventoryDetails();
                                                             
                                                             List<CustomSelectOptions> rackOptions = new List<CustomSelectOptions>();
                                                             List<CustomSelectOptions> rackLevelOptions = new List<CustomSelectOptions>();
                                                             List<CustomSelectOptions> binLocationOptions = new List<CustomSelectOptions>();
                                                             
                                                             inv.invPositionSO.Rack__c = null;
                                                             inv.invPositionSO.Rack_Level__c = null;
                                                             inv.invPositionSO.Bin_Location__c = null;
                                                             
                                                             inv.rackOptions = new List<CustomSelectOptions>();
                                                             inv.rackLevelOptions = new List<CustomSelectOptions>();
                                                             inv.binLocationOptions = new List<CustomSelectOptions>();
                                                             inv.balanceQtyToPutAway = 0.0;
                                                             invRec.selectedRackLevelId = null;
                                                             
                                                             rackOptions.add(new CustomSelectOptions('', NONE_VALUE));
                                                             rackLevelOptions.add(new CustomSelectOptions('', NONE_VALUE));
                                                             binLocationOptions.add(new CustomSelectOptions('', NONE_VALUE));
                                                             
                                                             List<Inventory_Location__c> filteredLocation = new List<Inventory_Location__c>();
                                                             List<Rack__c> filteredRacks = new List<Rack__c>();
                                                             List<Rack_Level__c> filteredRackLevels = new List<Rack_Level__c>();
                                                             List<Bin_Location__c> filteredBinLevels = new List<Bin_Location__c>();
                                                             
                                                             if(selectedLocationId != '' && selectedLocationId != NULL && racksByLocationId.containsKey(selectedLocationId)){
                                                                 filteredRacks = racksByLocationId.get(selectedLocationId);    
                                                             }
                                                             
                                                             for(Integer i=0; i<filteredRacks.size(); i++){
                                                                 rackOptions.add(new CustomSelectOptions(filteredRacks[i].Id, filteredRacks[i].Name));
                                                             }
                                                             
                                                             inv.rackOptions = rackOptions;
                                                             inv.rackLevelOptions = rackLevelOptions;
                                                             inv.binLocationOptions = binLocationOptions;
                                                             Decimal remainingQtyToPutAway = 0.0; 
                                                             inv.balanceQtyToPutAway = remainingQtyToPutAway;
                                                         }
                                                     }
                                                     r.data.put('records', lstInvWrp);
                                                     return r;
                                                 }
    
    @AuraEnabled
    public static AuraResponse updateInventoryLocations(String invPos,String jsonStr1,String recId){
        AuraResponse r = new AuraResponse('InventoryDetails.updateInventoryLocations()');
        
        InventoryDetails inv = new InventoryDetails();
        //inv.inventoryLocationByRackId = new Map<Id,Id>();
        
        AllProductDetails allRec= new AllProductDetails();
        
        AuraResponse aura = InventoryDetails.massTransferAction(jsonStr1,recId);
        allRec = (AllProductDetails) aura.data.get('records');
        inv = (InventoryDetails) aura.data.get('inventoryDetails');
        
        inventoryPositionsLight = (List<InventoryPositionWrapperPut>) System.JSON.deserialize(invPos, List<InventoryPositionWrapperPut>.class);
        
        
        // Perform validations - If any validation fails then do not need to process transfer inventory locations
        validate val = validateMassTransferInputLight(allRec.totalProductVolumeByBinLocationId,allRec.binLocationById,allRec.binConsumedCapacityById);
        if(val.isError){
            allRec.errorMsg = val.errMsg;
            r.data.put('Error', allRec);
            return r;
        }
        Savepoint savePoint;
        
        try {
            // Define Savepoint for rollback
            savePoint = Database.setSavepoint();
            List<Inventory_Position__c> invPositionsToUpdate = new List<Inventory_Position__c>();
            for(InventoryPositionWrapperPut invPositionWrapper : inventoryPositionsLight){
                
                Inventory_Position__c inventoryPositionSO = invPositionWrapper.invPositionSO;
                
                
                // Assign updated Inventory Location
                if(inv.inventoryLocationByRackId.containsKey(inventoryPositionSO.Rack__c)){
                    inventoryPositionSO.Inventory_Location__c = inv.inventoryLocationByRackId.get(inventoryPositionSO.Rack__c);    
                }
                
                
                // Check for partial quantity
                if(invPositionWrapper.qtyToPutAway != inventoryPositionSO.Qty_On_Hand__c){
                    
                    // Create new inventory position for partial qty  
                    Inventory_Position__c cloneInventoryPositionSO = inventoryPositionSO.clone(false, true);
                    cloneInventoryPositionSO.Hold__c = inventoryPositionSO.Hold__c;
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
            
            upsert invPositionsToUpdate;
            
            inv.showMassTransferBlock = inv.miscIssueSectionRender = false;
            inv.invPosSectionRender = true;
            r.data.put('showMassTransferBlock', inv.showMassTransferBlock);
            r.data.put('invPosSectionRender', true);
            r.data.put('miscIssueSectionRender', inv.miscIssueSectionRender);
            AuraResponse aura1 = InventoryDetails.inventoryDetails(recId,'true');
            AllProductDetails allRec1= new AllProductDetails();
            allRec1 = (AllProductDetails) aura1.data.get('records');
            r.data.put('records', allRec1);
            return r;
            
        } catch (Exception ex) {
            Database.rollback(savePoint);
            allRec.errorMsg = String.valueOf(ex.getMessage());
            r.data.put('Error', allRec);
            return r;
        }
    }
    
    
    @AuraEnabled
    public static AuraResponse mergeIPs(String selectedIds1,String recId){
        AuraResponse r = new AuraResponse('InventoryDetails.mergeIPs()');
        InventoryDetails inv = new InventoryDetails();
        
        List<string> wrapperList = (List<string>) System.JSON.deserialize(selectedIds1, List<String>.class);
        
        Set<Id> setIds = new Set<Id>();
        for(String str : wrapperList)
            setIds.add(str);
        
        Boolean isMerge = true;
        String mergeTo = '';
        Decimal totalQty = 0;
        Decimal totalQtyAllocated = 0;
        Map<String,String> valueChecker = new Map<String,String>();
        
        List<Inventory_Position__c> ls = [SELECT Id,Qty_On_Hand__c,Qty_Allocated__c, Site__c ,Inventory_Location__c,Inventory_Location__r.Name ,Rack__c,Rack__r.Name, Rack_Level__c,Rack_Level__r.Name, Bin_Location__c,Bin_Location__r.Name,
                                          Ownership__c, Sales_Order_Line__c, Harvest_Batch_or_Lot_Code__c, UID__c,Hold__c, UID_New__c,UID_New__r.Name,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Name,
                                          Lab_Test_Status__c,Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c
                                          FROM Inventory_Position__c WHERE Id IN :setIds Order By CreatedDate Asc];
        
        for(Inventory_Position__c obj : ls){
            if(obj.Hold__c){
                String message1 = 'Selected Items can not be merge as its on hold.';
                r.data.put('Error', message1);
                return r;
            }
            if(valueChecker.size() == 0){
                mergeTo = obj.Id;
                totalQty = obj.Qty_On_Hand__c;
                totalQtyAllocated = obj.Qty_Allocated__c != null ? obj.Qty_Allocated__c : 0;
                valueChecker.put('Site__c',obj.Site__c);
                valueChecker.put('Inventory_Location__c',obj.Inventory_Location__c);
                valueChecker.put('Rack__c',obj.Rack__c);
                valueChecker.put('Rack_Level__c',obj.Rack_Level__c);
                valueChecker.put('Bin_Location__c',obj.Bin_Location__c);
                valueChecker.put('Ownership__c',obj.Ownership__c);
                valueChecker.put('Sales_Order_Line__c',obj.Sales_Order_Line__c);
                valueChecker.put('Harvest_Batch_Code__c',obj.Harvest_Batch_Code__c);
                valueChecker.put('UID_New__c',obj.UID_New__c);
                valueChecker.put('Lab_Test_Status__c',obj.Lab_Test_Status__c);
                valueChecker.put('Purchase_Order__c',obj.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c);
            }else{
                Boolean isValid =inv.isSameInventoryPositions(obj,valueChecker);
                if(!isValid){
                    isMerge = false;
                    break;
                }
                totalQty += obj.Qty_On_Hand__c != null ? obj.Qty_On_Hand__c : 0;
                totalQtyAllocated += obj.Qty_Allocated__c != null ? obj.Qty_Allocated__c : 0;
            }
        }  //end for
        if(!isMerge){
            String message1 = 'Selected Items does not Match';
            r.data.put('Error', message1);
            return r;
        } else {
            setIds.remove(mergeTo);
            Inventory_Position__c mergeObj = new Inventory_Position__c(Id = mergeTo,Qty_On_Hand__c = totalQty, Qty_Allocated__c = totalQtyAllocated);
            try{
                update mergeObj;
                DELETE [SELECT Id FROM Inventory_Position__c WHERE Id IN :setIds];
                inv.invPositionWrappList = new List<InventoryPositionWrapper>();
                inv.fillInvPositionWrappList(new List<Product2>());
            }catch(Exception ex){
                String message1 = ex.getMessage();
                r.data.put('Error', message1);
                return r;
            }
            AuraResponse aura1 = InventoryDetails.inventoryDetails(recId,'true');
            AllProductDetails allRec1= new AllProductDetails();
            allRec1 = (AllProductDetails) aura1.data.get('records');
            r.data.put('records', allRec1);
            return r;
        }
    }
    
    public static validate validateMassTransferInputLight(Map<Id, Decimal> totalProductVolumeByBinLocationId,Map<Id, Bin_Location__c> binLocationById,Map<Id, Decimal> binConsumedCapacityById){
        
        validate val = new validate();
        
        String message;
        Boolean hasValidationError = false;
        Boolean hasInvPositionSelected = false;
        Decimal allocatedSpace;
        Decimal availableBinLocationCapacity;
        totalProductVolumeByBinLocationId = new Map<Id, Decimal>();
        
        for(InventoryPositionWrapperPut invPositionWrapper : inventoryPositionsLight){
            
            Decimal qtyToPutAway = invPositionWrapper.qtyToPutAway;
            Inventory_Position__c inventoryPositionSO = invPositionWrapper.invPositionSO;
            Bin_Location__c binLocationObj = new Bin_Location__c();
            
            if(binLocationById.containsKey(inventoryPositionSO.Bin_Location__c)){
                binLocationObj = binLocationById.get(inventoryPositionSO.Bin_Location__c);    
            }
            
            hasInvPositionSelected = true;
            allocatedSpace = 0.0;
            availableBinLocationCapacity = 0.0;
            
            // Check qty to put away cannot be blank and must be positive
            if(qtyToPutAway == null || qtyToPutAway <= 0.0 ){
                message = Label.Qty_To_Put_Away_Positive_Value + inventoryPositionSO.Product_Name__r.Name;
                hasValidationError = true;
            }
            
            // Check qty to put away cannot be greater than qty on hand
            else if(qtyToPutAway > inventoryPositionSO.Qty_On_Hand__c){
                message = Label.Qty_To_Put_Away_Cannot_Be_Greater_Than_Qty_On_Hand + inventoryPositionSO.Product_Name__r.Name;
                hasValidationError = true;
                
                // Check Rack, Rack Level and Bin Location cannot be null
            }else if(inventoryPositionSO.Rack__c == null || inventoryPositionSO.Rack_Level__c == null || inventoryPositionSO.Bin_Location__c == null){
                
                message = Label.Rack_Rack_Level_Bin_Location_Cannot_Be_Null + inventoryPositionSO.Product_Name__r.Name;
                hasValidationError = true;
                // Check volume capacity of total product and selected bin if ignore storage limit is false
            }else if(!binLocationObj.Ignore_Storage_Limit__c && qtyToPutAway > 0.0 &&
                     qtyToPutAway > invPositionWrapper.balanceQtyToPutAway){
                         
                         String binLocationName = '';
                         if(binLocationObj.Name != null)
                             binLocationName = binLocationObj.Name;
                         
                         message = Label.Bin_Location_Capacity_Validation +' '+binLocationName +' '+ invPositionWrapper.qtyToPutAway +' '+ inventoryPositionSO.Product_Name__r.Name;    
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
                             
                             message = Label.Total_Allocated_Space_Exceeds_Bin_Capacity +' '+String.valueOf(allocatedSpace) +' '+ binLocationName +' '+ String.valueOf(availableBinLocationCapacity);   
                             hasValidationError = true;
                         }
                     }
        }
        val.errMsg = message;
        val.isError = hasValidationError;
        return val;
    }
    
    private static List<CustomSelectOptions> doSortOption(List<CustomSelectOptions> opts) {
        Map<String, CustomSelectOptions> mapping = new Map<String, CustomSelectOptions>();
        // Suffix to avoid duplicate values like same labels or values are in inbound list 
        Integer suffix = 1;
        for (CustomSelectOptions opt : opts) {
            mapping.put((opt.label + suffix++), opt);   
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
    
    
    public void fillInvPositionWrappList(List<Product2> prodList){
        prodList =[Select ID,name,Producer_Name__c,Strain__r.Name,Producer_Name__r.name,Description ,Cannabis_Weight__c,Cannabis_Weight_UOM__c,IsActive,Family,Quantity_Type__c ,Supplier_UOM__c,Strain__c,Strain_Type__c,MOQ__c,
                   ItemToPutAway__c,Allocated_Inventory__c,Brand_Name__c,Total_Order_Qty__c,Hide_From_Marketplace__c,Available_Inventory__c,Inventory_On_Hold_Qty__c ,Available_Qty__c ,Total_Inventory__c,TotalCannabisWeight__c,
                   (Select id,Name,Site__c,Site__r.Name,Product_Name__c,Inventory_Location__c,Inventory_Location__r.Name,Rack__c,
                    Sales_Order_Line__c,Sales_Order_Line__r.Name,Sales_Order_Line__r.Status__c,Rack_Level__c,Rack__r.Name,Rack_Level__r.Name,Ownership__r.Name,
                    Date_Received__c,Bin_Location__c,Ownership__c,Qty_On_Hand__c,Qty_Allocated__c,Bin_Location__r.Name,
                    Harvest_Batch_or_Lot_Code__c,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Name,Lab_Test_Status__c,UID__c,UID_New__c,UID_New__r.Name,Hold__c ,
                    Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c, Inventory_Location__r.Include_in_Inventory_Transfer__c,Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Name 
                    from Inventory_Positions__r where Inventory_Location__r.Include_in_Inventory__c = true AND Inventory_Location__r.Site_Name__c IN :AssignedWarehouseIds)
                   from Product2 where ID=:recordID ];
        if(prodList.size()>0){
            prod=prodList[0];  
            invPositionList =prod.Inventory_Positions__r;
            for(Inventory_Position__c invPosRec :invPositionList){
                InventoryPositionWrapper wrap= new InventoryPositionWrapper(false,invPosRec);
                invPositionWrappList.add(wrap);
            }
            
            totalInventory=prod.Total_Inventory__c;
            
            allocatedInventoryQty=prod.Allocated_Inventory__c;
            
            availableInventoryQty=prod.Available_Inventory__c;
            
            inventoryOnHoldQty = prod.Inventory_On_Hold_Qty__c;
            
            availableQty=prod.Available_Qty__c;         
            
            itemToPutAway=prod.ItemToPutAway__c;
            
            totalCannabisWeight=prod.TotalCannabisWeight__c;
        }
    }
    
    @AuraEnabled
    public static AuraResponse sortOrderList(String recordId,String sortField,List<String> AssignedWarehouseIds,String orderSort){
        AuraResponse r = new AuraResponse('InventoryDetails.sortOrderList()');
        Set<String> recIds = new Set<String>{recordId};
            
            if(orderSort == ' ASC ')
            orderSort = ' DESC ';
        else
            orderSort = ' ASC ';
        
        List<InventoryPositionWrapper> invPositionWrappList= new List<InventoryPositionWrapper>();
        
        string querystr = '';
        
        querystr += 'Select ID,name,Producer_Name__c,Strain__r.Name,Producer_Name__r.name,Description ,Cannabis_Weight__c,Cannabis_Weight_UOM__c,IsActive,Family,Quantity_Type__c ,Supplier_UOM__c,Strain__c,Strain_Type__c,MOQ__c,';
        querystr += 'ItemToPutAway__c,Allocated_Inventory__c,Brand_Name__c,Total_Order_Qty__c,Hide_From_Marketplace__c,Available_Inventory__c,Inventory_On_Hold_Qty__c ,Available_Qty__c ,Total_Inventory__c,TotalCannabisWeight__c,';
        querystr += '(Select id,Name,Site__c,Site__r.Name,Product_Name__c,Inventory_Location__c,Inventory_Location__r.Name,Rack__c,Sales_Order_Line__c,Sales_Order_Line__r.Name,Sales_Order_Line__r.Status__c,Rack_Level__c,Rack__r.Name,Rack_Level__r.Name,Ownership__r.Name,';
        querystr +=  'Date_Received__c,Bin_Location__c,Ownership__c,Qty_On_Hand__c,Qty_Allocated__c,Bin_Location__r.Name,Harvest_Batch_or_Lot_Code__c,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Name,Lab_Test_Status__c,UID__c,UID_New__c,UID_New__r.Name,Hold__c ,';
        querystr += 'Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c,Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Name from Inventory_Positions__r where Inventory_Location__r.Include_in_Inventory__c = true AND Inventory_Location__r.Site_Name__c IN : AssignedWarehouseIds Order By ';
        querystr += sortField + orderSort+' )';
        querystr += 'from Product2 where Id in : recIds';
        
        List<Product2> prodList = database.query(querystr);
        
        
        
        if(prodList.size()>0){
            List<Inventory_Position__c> invPositionList = new List<Inventory_Position__c>();
            invPositionList =  prodList[0].Inventory_Positions__r;
            
            
            
            for(Inventory_Position__c invPosRec :invPositionList){
                InventoryPositionWrapper wrap= new InventoryPositionWrapper(false,invPosRec);
                invPositionWrappList.add(wrap);
            }
        }
        r.data.put('records', invPositionWrappList);
        r.data.put('sortOrder', orderSort);
        return r;
    }
    
    public PageReference redirectItemDetail(){
        if(String.isNotBlank(recordID )){
            PageReference pageRef = new PageReference('/'+recordID );
            pageRef.setRedirect(true);
            
            return pageRef;
        }else return null;
    }
    
    public PageReference refreshInventoryDetails() {
        
        
        if(String.isNotBlank(selectedRecordId) && selectedRecordId.length()==18){
            PageReference pageRef = new PageReference('/apex/InventoryDetails?id='+selectedRecordId );
            pageRef.getParameters().put('searchPageRender2', 'true');
            pageRef.setRedirect(true);
            return pageRef;
        }if(String.isBlank(selectedRecordId) && String.isNOTBlank(recordID)){
            PageReference pageRef = new PageReference('/apex/InventoryDetails?id='+recordID);
            pageRef.getParameters().put('searchPageRender2', 'true');
            pageRef.setRedirect(true);
            return pageRef;
        }
        else return null;
    }
    
    public PageReference redirectToMiscReceipt(){
        
        PageReference pageRef = new PageReference('/apex/MiscReceipt?id='+recordID );
        pageRef.setRedirect(false);
        return pageRef;
    }
    
    public void redirectToMiscIssue(){
        List<InventoryPositionWrapper> invPositionWrappListNew = new List<InventoryPositionWrapper>();
        
        miscIssueSectionRender=true;
        invPosSectionRender =false;
        searchPageRender=false;
        for( InventoryPositionWrapper var :invPositionWrappList ){
            if(var.isSelected == true){
                invPositionWrappListNew.add(var);
            }
        }
        invPositionWrappList.clear();
        invPositionWrappList.addAll(invPositionWrappListNew);
        
    }
    public PageReference cancelRedirect() {
        PageReference pageRef = new PageReference('/apex/InventoryDetails?id='+recordID );
        // pageRef.getParameters().put('searchPageRender2', 'true');
        pageRef.getParameters().put('searchPageRender2', 'false');
        pageRef.setRedirect(true);
        return pageRef;
    }
    
    public PageReference SaveRecord(){
        
        List<Inventory_Position__c> invPositionList = new List<Inventory_Position__c>();
        for( InventoryPositionWrapper var :invPositionWrappList ){
            
            Inventory_Position__c invObj=var.invPos;
            if(var.invPos.Sales_Order_Line__c != null && (var.invPos.Sales_Order_Line__r.Status__c =='Allocated' || var.invPos.Sales_Order_Line__r.Status__c =='Partially Allocated')){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'"Sales Order Line" has value and SO Line item Status = "Partially Allocated" or "Allocated"'));
                return null;
            }
            if(var.invPos.Qty_On_Hand__c ==0){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'We cannot do Misc Issue where Qty on hand = 0'));
                return null;
            }
            else if(var.qtyToAdjust <= 0 || var.qtyToAdjust > var.invPos.Qty_On_Hand__c){
                
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter valid entry for "Qty to Adjust" field'));
                return null;
            }
            else if( var.qtyToAdjust > 0 && var.qtyToAdjust <= var.invPos.Qty_On_Hand__c){
                
                invObj.Qty_On_Hand__c=var.invPos.Qty_On_Hand__c - var.qtyToAdjust;
                var.invPos.Qty_On_Hand__c =invObj.Qty_On_Hand__c;
                
            }
            invPositionList.add(invObj);
            
        }
        
        
        update invPositionList;
        createInventoryPerpetualAdjustment(invPositionWrappList,invPerAdj);
        PageReference pageRef = new PageReference('/apex/InventoryDetails?id='+recordID );
        pageRef.getParameters().put('searchPageRender2', 'false');
        pageRef.setRedirect(true);
        return pageRef;
    }
    public static List<Inventory_Perpetual_Adjustment__c> createInventoryPerpetualAdjustment(List<InventoryPositionWrapper> invPositionReclst,Inventory_Perpetual_Adjustment__c invPerAdj){
        List<Inventory_Perpetual_Adjustment__c> invPositionReclist= new List<Inventory_Perpetual_Adjustment__c>();
        for(InventoryPositionWrapper invPositionRec :invPositionReclst){
            Inventory_Perpetual_Adjustment__c rec= new Inventory_Perpetual_Adjustment__c();
            rec.Inventory_Position__c=invPositionRec.invPos.Id;
            rec.Product__c=invPositionRec.invPos.Product_Name__c;
            rec.Quantity__c=invPositionRec.qtyToAdjust;
            rec.New_balance_Qty__c=invPositionRec.invPos.Qty_On_Hand__c;
            rec.Old_balance_Qty__c=invPositionRec.qtyToAdjust+invPositionRec.invPos.Qty_On_Hand__c; //
            rec.Reason_for_Adjustments__c=invPerAdj.Reason_for_Adjustments__c;
            rec.Type__c=invPerAdj.Type__c;
            rec.Ownership__c=invPositionRec.invPos.Ownership__c;
            rec.Site__c=invPositionRec.invPos.Site__c;
            rec.Inventory_Location__c=invPositionRec.invPos.Inventory_Location__c; //need to add some logic here
            rec.Adjustment_Date__c=System.now();
            rec.Rack__c=invPositionRec.invPos.Rack__c;
            rec.Rack_Level__c=invPositionRec.invPos.Rack_Level__c;
            rec.Bin_Location__c=invPositionRec.invPos.Bin_Location__c;
            rec.UID_New__c=invPositionRec.invPos.UID_New__c;
            rec.Receiving_Line__c=invPositionRec.invPos.Receiving_Line__c;
            rec.Harvest_Batch_Code__c=invPositionRec.invPos.Harvest_Batch_Code__c;
            invPositionReclist.add(rec);
        }
        insert invPositionReclist;
        
        return invPositionReclist;
    }
    
    /**
* Mass transfer action - Move inventory from one location to another with specific qty
*/
    public void massTransferAction(){
        
        Set<Id> invPositionIds = new Set<Id>();
        
        // Check if any unassigned inventory is selected to transfer. If not then give warning message to select it
        // Filter inventory having receiving inspection location
        for( InventoryPositionWrapper var :invPositionWrappList ){
            if(var.isSelected == true && var.invPos.Sales_Order_Line__c == null
               && var.invPos.Inventory_Location__r.Name != Label.Default_Inventory_Location){
                   invPositionIds.add(var.invPos.Id);
               }
        }
        
        if(invPositionIds.size() == 0){
            ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.WARNING,
                                                              Label.No_Inventory_Selected_To_Transfer);
            ApexPages.addMessage(message);
            return;
        }else{
            showMassTransferBlock = true; // Show mass transfer page block
            invPosSectionRender = false; // Hide default inventory position table
        }
        
        List<Inventory_Position__c> inventoryPositionList = new List<Inventory_Position__c>();
        List<Inventory_Position__c> filteredInventoryPositionList = new List<Inventory_Position__c>();
        List<Rack__c> racks = new List<Rack__c>();
        List<Rack_Level__c> rackLevels = new List<Rack_Level__c>();
        List<Bin_Location__c> binLocations = new List<Bin_Location__c>();
        
        List<SelectOption> rackOptions = new List<SelectOption>();
        rackOptions.add(new SelectOption('', NONE_VALUE));
        Map<Id, List<SelectOption>> rackLevelOptionsByRackId = new Map<Id, List<SelectOption>>();
        Map<Id, List<SelectOption>> binLocationOptionsByRackLevelId = new Map<Id, List<SelectOption>>();
        
        Set<Id> siteIds = new Set<Id>();
        Set<Id> rackIds = new Set<Id>();
        Set<Id> rackLevelIds = new Set<Id>();
        inventoryPositionList = new List<Inventory_Position__c>();
        List<String> invPositionFieldNames = getSObjectFieldNames('Inventory_Position__c'); 
        
        String invPositionQuery = 'Select ' +
            String.join( invPositionFieldNames, ',' ) + ' ' +
            ', Rack_Level__r.Name ' +
            ', Bin_Location__r.Name ' +
            ', Ownership__r.Name ' +
            ', Product_Name__r.Unit_Cubic_Volume__c ' +
            ', Product_Name__r.Name ' +
            ', Product_Name__r.Description ' +
            ', Inventory_Location__r.Name ' +
            ', Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Supplier_Name__r.Name ' +
            ', Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__r.Name ' +
            'From Inventory_Position__c ' +
            'Where Id IN: invPositionIds ' +
            'AND Sales_Order_Line__c = null ' +
            'ORDER BY Name';
        
        inventoryPositionList = Database.query(invPositionQuery);
        
        // Add all site Ids from all inventory positions
        for(Inventory_Position__c inventoryPositionSO : inventoryPositionList){
            // Add site ids
            siteIds.add(inventoryPositionSO.Site__c);
        }
        
        // Get all racks related to all inventory locations pertain to all sites
        // Create list of rack options to display on page at the time of page load
        for(Rack__c rackSO : [Select Name, 
                              Inventory_Location__c,
                              Inventory_Location__r.Name
                              From Rack__c 
                              Where Inventory_Location__r.Site_Name__c IN: siteIds
                              ORDER BY NAME]){
                                  racks.add(rackSO);
                                  rackIds.add(rackSO.Id);
                                  rackOptions.add(new SelectOption(rackSO.Id, rackSO.Inventory_Location__r.Name + ' - ' +rackSO.Name));
                                  rackOptions = doSortOption(rackOptions);
                                  inventoryLocationByRackId.put(rackSO.Id, rackSO.Inventory_Location__c);
                              }
        
        // Construct map of all rack levels by rack id
        for(Rack_Level__c rackLevelSO : [Select Name, Rack__c From Rack_Level__c 
                                         Where Rack__c IN: rackIds
                                         ORDER BY NAME]) {
                                             
                                             List<Rack_Level__c> rackLevelsTemp = rackLevelsByRackId.get(rackLevelSO.Rack__c);
                                             List<SelectOption> rackLevelOptionsTemp = rackLevelOptionsByRackId.get(rackLevelSO.Rack__c);
                                             
                                             if(rackLevelsTemp == null) {
                                                 rackLevelsTemp = new List<Rack_Level__c>();
                                                 rackLevelsByRackId.put(rackLevelSO.Rack__c, rackLevelsTemp);
                                                 
                                                 rackLevelOptionsTemp = new List<SelectOption>();
                                                 rackLevelOptionsTemp.add(new SelectOption('', NONE_VALUE));
                                                 rackLevelOptionsByRackId.put(rackLevelSO.Rack__c, rackLevelOptionsTemp);
                                             }
                                             rackLevelsTemp.add(rackLevelSO);
                                             rackLevelIds.add(rackLevelSO.Id);
                                             rackLevelOptionsTemp.add(new SelectOption(rackLevelSO.Id, rackLevelSO.Name));
                                             rackLevelOptionsTemp = doSortOption(rackLevelOptionsTemp);
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
                                                 List<SelectOption> binLocationOptionsTemp = binLocationOptionsByRackLevelId.get(binLocationSO.Rack_Level__c);
                                                 
                                                 if(binLocationsTemp == null) {
                                                     binLocationsTemp = new List<Bin_Location__c>();
                                                     binLocationsByRackLevelId.put(binLocationSO.Rack_Level__c, binLocationsTemp);
                                                     
                                                     binLocationOptionsTemp = new List<SelectOption>();
                                                     binLocationOptionsTemp.add(new SelectOption('', NONE_VALUE));
                                                     binLocationOptionsByRackLevelId.put(binLocationSO.Rack_Level__c, binLocationOptionsTemp);
                                                 }
                                                 binLocationsTemp.add(binLocationSO);
                                                 binLocationOptionsTemp.add(new SelectOption(binLocationSO.Id, binLocationSO.Name));
                                                 binLocationOptionsTemp = doSortOption(binLocationOptionsTemp);
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
        for(Inventory_Position__c inventoryPositionSO : inventoryPositionList){
            
            // Add inventory position in iterable interface
            PutAwayInventoryController.InventoryPositionWrapper invPositionWrapper = new PutAwayInventoryController.InventoryPositionWrapper(inventoryPositionSO);
            invPositionWrapper.rackOptions = rackOptions;
            invPositionWrapper.rackLevelOptions = rackLevelOptionsByRackId.get(inventoryPositionSO.Rack__c);
            invPositionWrapper.binLocationOptions = binLocationOptionsByRackLevelId.get(inventoryPositionSO.Rack_Level__c);
            
            inventoryPositions.add(invPositionWrapper);
            
            // Construct map of inventory position wrapper by inventory position id
            // This map is used when assigning dynamic values of rack level and bin location based on
            // selected value of inventory position id and rack/rack level id
            inventoryPositionById.put(inventoryPositionSO.Id, invPositionWrapper);
        }
    }
    
    
    /**
* load Rack levels based on selected rack
*/
    public void loadRackLevels() {
        
        // Retrieve selected inventory position wrapper record based on selected inventory position id
        PutAwayInventoryController.InventoryPositionWrapper invPositionWrapper = inventoryPositionById.get(selectedInvPositionId);
        
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
    
    
    @AuraEnabled
    public static AuraResponse loadRackLevelsLight(String selectedInvPositionId, String inventoryPos, String rackLevelsByRack, string binLocationsByRackLevel, String selectedRackId,
                                                   String binConsume, String selectedBinLocationId){
                                                       
                                                       AuraResponse r = new AuraResponse('InventoryDetails.loadRackLevelsLight()');
                                                       
                                                       List<InventoryPositionWrapperPut> lstInvWrp =(List<InventoryPositionWrapperPut>) System.JSON.deserialize(inventoryPos, List<InventoryPositionWrapperPut>.class);
                                                       
                                                       Map<String, Object> metaRack = (Map<String, Object>) JSON.deserializeUntyped(rackLevelsByRack);
                                                       Map<String, Object> metaBin = (Map<String, Object>) JSON.deserializeUntyped(binLocationsByRackLevel);
                                                       
                                                       Map<Id, List<Rack_Level__c>> rackLevelsByRackId =  new Map<Id, List<Rack_Level__c>>();
                                                       Map<Id, List<Bin_Location__c>> binLocationsByRackLevelId =  new Map<Id, List<Bin_Location__c>>();
                                                       
                                                       Map<String, Object> meta = (Map<String, Object>) JSON.deserializeUntyped(binConsume);
                                                       
                                                       Map<Id, Decimal> binConsumedCapacityById =  new Map<Id,Decimal>();
                                                       for(Object target : meta.keySet()) { 
                                                           binConsumedCapacityById.put(Id.valueOf(String.valueOf(target)),(Decimal)meta.get(String.valueOf(target)));
                                                       }                                              
                                                       
                                                       for(Object target : metaRack.keySet()) { 
                                                           String jsonStr = JSON.serialize(metaRack.get(String.valueOf(target)));
                                                           
                                                           rackLevelsByRackId.put(Id.valueOf(String.valueOf(target)),(List<Rack_Level__c>)System.JSON.deserialize(jsonStr, List<Rack_Level__c>.class));
                                                       }
                                                       
                                                       for(Object target : metaBin.keySet()) { 
                                                           String jsonStr = JSON.serialize(metaBin.get(String.valueOf(target)));
                                                           binLocationsByRackLevelId.put(Id.valueOf(String.valueOf(target)),(List<Bin_Location__c>)System.JSON.deserialize(jsonStr, List<Bin_Location__c>.class));
                                                       }
                                                       
                                                       
                                                       for(InventoryPositionWrapperPut inv : lstInvWrp){
                                                           
                                                           if(inv.invPositionSO.Id == selectedInvPositionId){
                                                               InventoryDetails invRec = new InventoryDetails();
                                                               // Reset rack level, bin location picklists and balance qty to put away
                                                               List<CustomSelectOptions> rackLevelOptions = new List<CustomSelectOptions>();
                                                               List<CustomSelectOptions> binLocationOptions = new List<CustomSelectOptions>();
                                                               inv.binLocationOptions = new List<CustomSelectOptions>();
                                                               inv.balanceQtyToPutAway = 0.0;
                                                               
                                                               
                                                               rackLevelOptions.add(new CustomSelectOptions('', NONE_VALUE));
                                                               binLocationOptions.add(new CustomSelectOptions('', NONE_VALUE));
                                                               
                                                               // Retrieve list of rack levels based on selected rack id  nd create picklists of rack levels
                                                               List<Rack_Level__c> filteredRackLevels = new List<Rack_Level__c>();
                                                               if(selectedRackId != '' && selectedRackId != NULL && rackLevelsByRackId.containsKey(selectedRackId)){
                                                                   filteredRackLevels = rackLevelsByRackId.get(selectedRackId);    
                                                               }
                                                               
                                                               
                                                               if(filteredRackLevels.size() > 0){
                                                                   for(Integer i=0; i<filteredRackLevels.size(); i++){
                                                                       
                                                                       rackLevelOptions.add(new CustomSelectOptions(filteredRackLevels[i].Id, filteredRackLevels[i].Name));
                                                                   }
                                                                   rackLevelOptions = doSortOption(rackLevelOptions);
                                                                   
                                                               }
                                                               inv.rackLevelOptions = rackLevelOptions;
                                                               inv.binLocationOptions = binLocationOptions;
                                                               
                                                               Decimal remainingQtyToPutAway = 0.0; 
                                                               
                                                               inv.balanceQtyToPutAway = remainingQtyToPutAway;
                                                           }
                                                       }
                                                       r.data.put('records', lstInvWrp);
                                                       return r;
                                                   }
    
    @AuraEnabled
    public static AuraResponse loadBinLocationsLight(String selectedInvPositionId,String inventoryPos,String binLocationsByRackLevel,String selectedRackLevelId,
                                                     String binConsume, String selectedBinLocationId){
                                                         AuraResponse r = new AuraResponse('InventoryDetails.loadBinLocationsLight()');
                                                         
                                                         List<InventoryPositionWrapperPut> lstInvWrp =(List<InventoryPositionWrapperPut>) System.JSON.deserialize(inventoryPos, List<InventoryPositionWrapperPut>.class);
                                                         
                                                         Map<String, Object> metaBin = (Map<String, Object>) JSON.deserializeUntyped(binLocationsByRackLevel);
                                                         Map<Id, List<Bin_Location__c>> binLocationsByRackLevelId =  new Map<Id, List<Bin_Location__c>>();
                                                         
                                                         for(Object target : metaBin.keySet()) { 
                                                             String jsonStr = JSON.serialize(metaBin.get(String.valueOf(target)));
                                                             binLocationsByRackLevelId.put(Id.valueOf(String.valueOf(target)),(List<Bin_Location__c>)System.JSON.deserialize(jsonStr, List<Bin_Location__c>.class));
                                                         }
                                                         
                                                         Map<String, Object> meta = (Map<String, Object>) JSON.deserializeUntyped(binConsume);
                                                         
                                                         Map<Id, Decimal> binConsumedCapacityById =  new Map<Id,Decimal>();
                                                         for(Object target : meta.keySet()) { 
                                                             binConsumedCapacityById.put(Id.valueOf(String.valueOf(target)),(Decimal)meta.get(String.valueOf(target)));
                                                         }                                                
                                                         
                                                         InventoryDetails invRec = new InventoryDetails();
                                                         for(InventoryPositionWrapperPut inv : lstInvWrp){
                                                             if(inv.invPositionSO.Id == selectedInvPositionId){
                                                                 // Reset bin location picklists
                                                                 List<CustomSelectOptions> binLocationOptions = new List<CustomSelectOptions>();
                                                                 invRec.selectedBinLocationId = null;   
                                                                 
                                                                 binLocationOptions.add(new CustomSelectOptions('', NONE_VALUE));
                                                                 
                                                                 // Retrieve list of bin locations based on selected rack level id and create picklists of bin locations
                                                                 List<Bin_Location__c> filteredBinLocations = new List<Bin_Location__c>();
                                                                 
                                                                 if(selectedRackLevelId != '' && selectedRackLevelId != NULL && binLocationsByRackLevelId.containsKey(selectedRackLevelId)){
                                                                     filteredBinLocations = binLocationsByRackLevelId.get(selectedRackLevelId);    
                                                                 }   
                                                                 
                                                                 if(filteredBinLocations != null){
                                                                     for(Integer i=0; i<filteredBinLocations.size(); i++){
                                                                         
                                                                         binLocationOptions.add(new CustomSelectOptions(filteredBinLocations[i].Id, filteredBinLocations[i].Name));
                                                                     }
                                                                     binLocationOptions = doSortOption(binLocationOptions);
                                                                 }
                                                                 inv.binLocationOptions = binLocationOptions;
                                                                 
                                                                 Decimal remainingQtyToPutAway = 0.0; 
                                                                 
                                                                 
                                                                 inv.balanceQtyToPutAway = remainingQtyToPutAway;
                                                             }
                                                         }
                                                         r.data.put('records', lstInvWrp);
                                                         return r;
                                                     }
    
    //----------------   2
    /**
* load Bin Locations based on selected rack level
*/
    public void loadBinLocations() {
        
        // Retrieve selected inventory position wrapper record based on selected inventory position id
        PutAwayInventoryController.InventoryPositionWrapper invPositionWrapper = inventoryPositionById.get(selectedInvPositionId);
        
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
    
    @AuraEnabled
    public static AuraResponse loadBalanceQtyToPutAwayLight(String selectedInvPositionId, String inventoryPos, String binConsume, String selectedBinLocationId){
        AuraResponse r = new AuraResponse('InventoryDetails.loadBalanceQtyToPutAwayLight()');
        
        List<InventoryPositionWrapperPut> lstInvWrp =(List<InventoryPositionWrapperPut>) System.JSON.deserialize(inventoryPos, List<InventoryPositionWrapperPut>.class);
        
        Map<String, Object> meta = (Map<String, Object>) JSON.deserializeUntyped(binConsume);
        
        Map<Id, Decimal> binConsumedCapacityById =  new Map<Id,Decimal>();
        for(Object target : meta.keySet()) { 
            binConsumedCapacityById.put(Id.valueOf(String.valueOf(target)),(Decimal)meta.get(String.valueOf(target)));
        }
        
        for(InventoryPositionWrapperPut inv : lstInvWrp){
            if(inv.invPositionSO.Id == selectedInvPositionId){
                Decimal availableBinLocationCapacity = 0.0;
                
                if(selectedBinLocationId != '' && selectedBinLocationId != NULL && binConsumedCapacityById.containsKey(selectedBinLocationId)){
                    availableBinLocationCapacity = binConsumedCapacityById.get(selectedBinLocationId);    
                }
                
                
                Decimal unitProductVoume = inv.invPositionSO.Product_Name__r.Unit_Cubic_Volume__c;
                Decimal remainingQtyToPutAway = 0.0; 
                
                if(availableBinLocationCapacity != null && availableBinLocationCapacity != 0.0 && 
                   unitProductVoume != null && unitProductVoume != 0){
                       remainingQtyToPutAway = availableBinLocationCapacity.divide(unitProductVoume, 2);
                   }
                inv.balanceQtyToPutAway = remainingQtyToPutAway;
            }
        }
        r.data.put('records', lstInvWrp);
        return r;
    }
    /**
* load balance qty To Put Away for selected bin location
*/
    public void loadBalanceQtyToPutAway() {
        // Retrieve selected inventory position wrapper record based on selected inventory position id
        PutAwayInventoryController.InventoryPositionWrapper invPositionWrapper = inventoryPositionById.get(selectedInvPositionId);
        invPositionWrapper.balanceQtyToPutAway = calculateRemainingQtyToPutAway(invPositionWrapper);
    }
    
    /**
* Calculate remaining qty to put away
*
* @param selectedInvPositionWrapper The selected instance of inventory position wrapper class
*
* @return Remaining qty to put away
*/
    public Decimal calculateRemainingQtyToPutAway(PutAwayInventoryController.InventoryPositionWrapper selectedInvPositionWrapper) {
        
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
    
    /**
* Apply validations and update Inventory Locations based on user input
*
* @return PageReference of current page
*/
    public PageReference updateInventoryLocations(){
        
        // Perform validations - If any validation fails then do not need to process transfer inventory locations
        if(validateMassTransferInputs()){
            return null;
        }
        
        Savepoint savePoint;
        
        try {
            
            // Define Savepoint for rollback
            savePoint = Database.setSavepoint();
            
            List<Inventory_Position__c> invPositionsToUpdate = new List<Inventory_Position__c>();
            
            for(PutAwayInventoryController.InventoryPositionWrapper invPositionWrapper : inventoryPositions){
                
                Inventory_Position__c inventoryPositionSO = invPositionWrapper.invPositionSO;
                
                // Assign updated Inventory Location
                inventoryPositionSO.Inventory_Location__c = inventoryLocationByRackId.get(inventoryPositionSO.Rack__c);
                
                // Check for partial quantity
                if(invPositionWrapper.qtyToPutAway != inventoryPositionSO.Qty_On_Hand__c){
                    
                    // Create new inventory position for partial qty  
                    Inventory_Position__c cloneInventoryPositionSO = inventoryPositionSO.clone(false, true);
                    cloneInventoryPositionSO.Hold__c = inventoryPositionSO.Hold__c;
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
            
            upsert invPositionsToUpdate;
            
            showMassTransferBlock = false;
            invPosSectionRender = true;
            return redirectToPutAwayInventoryPage();
            
        } catch (Exception ex) {
            Database.rollback(savePoint);
            
            ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage());
            ApexPages.addMessage(message);
            return null;
        }
    }
    
    /**
* Validate inventory location details updated by user
*
* @return Boolean flag to indicate if any validation fails
*/
    public Boolean validateMassTransferInputs(){
        
        ApexPages.Message message;
        Boolean hasValidationError = false;
        Boolean hasInvPositionSelected = false;
        Decimal allocatedSpace;
        Decimal availableBinLocationCapacity;
        totalProductVolumeByBinLocationId = new Map<Id, Decimal>();
        
        for(PutAwayInventoryController.InventoryPositionWrapper invPositionWrapper : inventoryPositions){
            
            Decimal qtyToPutAway = invPositionWrapper.qtyToPutAway;
            Inventory_Position__c inventoryPositionSO = invPositionWrapper.invPositionSO;
            Bin_Location__c binLocationObj = binLocationById.get(inventoryPositionSO.Bin_Location__c);
            
            hasInvPositionSelected = true;
            allocatedSpace = 0.0;
            availableBinLocationCapacity = 0.0;
            
            // Check qty to put away cannot be blank and must be positive
            if(qtyToPutAway == null || qtyToPutAway <= 0.0 ){
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
                     }else if(!binLocationObj.Ignore_Storage_Limit__c && qtyToPutAway > 0.0 &&
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
        return hasValidationError;
    }
    
    /**
* Redirect to default view of available inventory page
*
* @return PageReference of current page
*/
    private PageReference redirectToPutAwayInventoryPage() {
        PageReference page = new PageReference('/apex/InventoryDetails?id='+recordID);
        page.setRedirect(true);
        return page;
    }
    
    public void holdUnHoldIps(){
        String selectedIds = Apexpages.currentPage().getParameters().get('selectedIps');
        String type = Apexpages.currentPage().getParameters().get('holdType');
        if(String.isNotBlank(selectedIds)){
            Set<String> ids = new Set<String>(selectedIds.split(','));
            List<Inventory_Position__c> updateIPs = new List<Inventory_Position__c>();
            for(Inventory_Position__c ip : [SELECT Id,Hold__c,Sales_Order_Line__c
                                            FROM Inventory_Position__c
                                            WHERE Id IN :ids 
                                            Order By CreatedDate Asc]){
                                                if(String.isBlank(ip.Sales_Order_Line__c)){
                                                    Inventory_Position__c uip = new Inventory_Position__c();
                                                    uip.Id = ip.Id;
                                                    if(type == 'Hold')
                                                        uip.Hold__c = true;
                                                    else
                                                        uip.Hold__c = false;
                                                    updateIPs.add(uip);
                                                } else{
                                                    ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.WARNING,'SOLI Exists');
                                                    ApexPages.addMessage(message);
                                                    return;
                                                }  
                                            }
            if(!updateIPs.isEmpty()){
                update updateIPs;
                invPositionWrappList = new List<InventoryPositionWrapper>();
                fillInvPositionWrappList(new List<Product2>());
            }
        }else{
            ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.WARNING,'Please select the items');
            ApexPages.addMessage(message);
            return;
        }
    }
    public void mergeIPs(){
        String selectedIds = Apexpages.currentPage().getParameters().get('selectedIds');
        System.debug('##selectedIds::'+selectedIds);
        if(String.isNotBlank(selectedIds)){
            Set<String> ids = new Set<String>(selectedIds.split(','));
            if(ids.size()<2){
                ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.WARNING,'Please select atleast 2 items to merge.');
                ApexPages.addMessage(message);
                return;
            }
            Boolean isMerge = true;
            String mergeTo = '';
            Decimal totalQty = 0;
            Decimal totalQtyAllocated = 0;
            Map<String,String> valueChecker = new Map<String,String>();
            List<Inventory_Position__c> ls = [SELECT Id,Qty_On_Hand__c,Qty_Allocated__c, Site__c ,Inventory_Location__c,Inventory_Location__r.Name ,Rack__c,Rack__r.Name, Rack_Level__c,Rack_Level__r.Name, Bin_Location__c,Bin_Location__r.Name,
                                              Ownership__c, Sales_Order_Line__c, Harvest_Batch_or_Lot_Code__c, UID__c,Hold__c, UID_New__c,UID_New__r.Name,Harvest_Batch_Code__c,Harvest_Batch_Code__r.Name,
                                              Lab_Test_Status__c,Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c
                                              FROM Inventory_Position__c WHERE Id IN :ids Order By CreatedDate Asc];
            
            for(Inventory_Position__c obj : ls){
                if(obj.Hold__c){
                    ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.WARNING,'Selected Items can not be merge as its on hold.');
                    ApexPages.addMessage(message);
                    return;
                }
                if(valueChecker.size() == 0){
                    mergeTo = obj.Id;
                    totalQty = obj.Qty_On_Hand__c;
                    totalQtyAllocated = obj.Qty_Allocated__c != null ? obj.Qty_Allocated__c : 0;
                    valueChecker.put('Site__c',obj.Site__c);
                    valueChecker.put('Inventory_Location__c',obj.Inventory_Location__c);
                    valueChecker.put('Rack__c',obj.Rack__c);
                    valueChecker.put('Rack_Level__c',obj.Rack_Level__c);
                    valueChecker.put('Bin_Location__c',obj.Bin_Location__c);
                    valueChecker.put('Ownership__c',obj.Ownership__c);
                    valueChecker.put('Sales_Order_Line__c',obj.Sales_Order_Line__c);
                    valueChecker.put('Harvest_Batch_Code__c',obj.Harvest_Batch_Code__c);
                    valueChecker.put('UID_New__c',obj.UID_New__c);
                    valueChecker.put('Lab_Test_Status__c',obj.Lab_Test_Status__c);
                    valueChecker.put('Purchase_Order__c',obj.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c);
                }else{
                    if(!isSameInventoryPositions(obj,valueChecker)){
                        isMerge = false;
                        break;
                    }
                    totalQty += obj.Qty_On_Hand__c != null ? obj.Qty_On_Hand__c : 0;
                    totalQtyAllocated += obj.Qty_Allocated__c != null ? obj.Qty_Allocated__c : 0;
                }
            }  //end for
            
            if(!isMerge){
                ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.WARNING,'Selected Items does not Match');
                ApexPages.addMessage(message);
                return;
            }else{
                ids.remove(mergeTo);
                Inventory_Position__c mergeObj = new Inventory_Position__c(Id = mergeTo,Qty_On_Hand__c = totalQty, Qty_Allocated__c = totalQtyAllocated);
                try{
                    update mergeObj;
                    DELETE [SELECT Id FROM Inventory_Position__c WHERE Id IN :ids];
                    invPositionWrappList = new List<InventoryPositionWrapper>();
                    fillInvPositionWrappList(new List<Product2>());
                }catch(Exception ex){
                    ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.WARNING,ex.getMessage());
                    ApexPages.addMessage(message);
                    return;
                }
            }
            
        }else{
            ApexPages.Message message = new ApexPages.Message(ApexPages.Severity.WARNING,'Please select the items to merge.');
            ApexPages.addMessage(message);
            return;
        }
    }
    public Boolean isSameInventoryPositions(Inventory_Position__c obj,Map<String,String> valueChecker){
        String QA_REVIEW = 'QA Review';
        if(obj.Inventory_Location__r.Name == QA_REVIEW ||
           obj.Rack__r.Name == QA_REVIEW ||
           obj.Rack_Level__r.Name == QA_REVIEW ||
           obj.Bin_Location__r.Name == QA_REVIEW ||
           obj.Site__c != valueChecker.get('Site__c') || 
           obj.Inventory_Location__c != valueChecker.get('Inventory_Location__c') ||
           obj.Rack__c != valueChecker.get('Rack__c') ||
           obj.Rack_Level__c != valueChecker.get('Rack_Level__c') ||
           obj.Bin_Location__c != valueChecker.get('Bin_Location__c') ||
           obj.Ownership__c != valueChecker.get('Ownership__c') ||
           obj.Sales_Order_Line__c != valueChecker.get('Sales_Order_Line__c') ||
           obj.Harvest_Batch_Code__c != valueChecker.get('Harvest_Batch_Code__c') ||
           obj.UID_New__c != valueChecker.get('UID_New__c') ||
           obj.Lab_Test_Status__c != valueChecker.get('Lab_Test_Status__c') ||
           obj.Receiving_Line__r.Purchase_Order_Line__r.Purchase_Order__c != valueChecker.get('Purchase_Order__c')){
               return false;
           }
        return true;
    }
    
    public class AllProductDetails{
        @AuraEnabled public Product2 prod {get; set;} 
        @AuraEnabled public Double itemToPutAway {get; set;}
        @AuraEnabled public Double totalInventory {get; set;}
        @AuraEnabled public Double allocatedInventoryQty {get; set;}
        @AuraEnabled public Double availableInventoryQty {get; set;}
        @AuraEnabled public Double availableQty {get; set;}
        @AuraEnabled public Double inventoryOnHoldQty {get; set;} 
        @AuraEnabled public List<InventoryPositionWrapper> invPositionWrappList {get; set;}
        @AuraEnabled public Boolean invPosSectionRender {get; set;}
        @AuraEnabled public Boolean miscIssueSectionRender {get; set;}
        @AuraEnabled public Boolean showMassTransferBlock { get; set; }
        @AuraEnabled public List<InventoryPositionWrapperPut> inventoryPositions {get; set;}
        @AuraEnabled public String errorMsg { get; set; }
        @AuraEnabled Public Inventory_Perpetual_Adjustment__c invPerAdj;
        @AuraEnabled public List<CustomSelectOptions> invPerAdjTypes {get; set;}
        @AuraEnabled public Map<Id, Decimal> totalProductVolumeByBinLocationId {get;set;}
        @AuraEnabled public Map<Id, Bin_Location__c> binLocationById {get;set;}
        @AuraEnabled public Map<Id, Decimal> binConsumedCapacityById {get;set;}
        @AuraEnabled public List<String> AssignedWarehouseIds {get;set;}
        @AuraEnabled public Map<Id, InventoryPositionWrapperPut> inventoryPositionByIdLight {get;set;}
        @AuraEnabled public Map<Id, List<Rack_Level__c>> rackLevelsByRackId {get;set;}
        @AuraEnabled public Map<Id, List<Bin_Location__c>> binLocationsByRackLevelId {get;set;}
        @AuraEnabled public Map<Id, List<Inventory_Location__c>> inventoryLocationBySiteId{get;set;}
        @AuraEnabled public Map<Id, List<Rack__c>> rackByLocationId{get;set;}
        @AuraEnabled public List<CustomSelectOptions> dymoLabelLayouts {get; set;}
        @AuraEnabled public List<CustomSelectOptions> printers {get; set;}
        @AuraEnabled public Boolean isSelectedInventory {get; set;} 
        @AuraEnabled public String inventoryInfo {get; set;}
        @AuraEnabled public String imageXml {get; set;}
        @AuraEnabled public String selectedDymoLabelLayout {get; set;}
        @AuraEnabled public String selectedDymoPrinters {get; set;} 
    }
    
    public class validate{
        public String errMsg {get;set;}
        public Boolean isError {get;set;}
    }
    
    public class InventoryPositionWrapperPut{
        @AuraEnabled public Boolean isSelected {get; set;}
        @AuraEnabled public Inventory_Position__c invPositionSO {get; set;}
        @AuraEnabled public Decimal qtyToPutAway {get; set;}
        @AuraEnabled public Decimal qtyToAdjust {get; set;} 
        @AuraEnabled public Decimal balanceQtyToPutAway {get; set;}
        @AuraEnabled public List<CustomSelectOptions> siteOptions {get; set;}
        @AuraEnabled public List<CustomSelectOptions> locationOptions {get; set;}
        @AuraEnabled public List<CustomSelectOptions> rackOptions {get; set;}
        @AuraEnabled public List<CustomSelectOptions> rackLevelOptions {get; set;}
        @AuraEnabled public List<CustomSelectOptions> binLocationOptions {get; set;}
        
        // Constructor
        public InventoryPositionWrapperPut(Inventory_Position__c invPositionSO){
            this.isSelected = false;
            this.invPositionSO = invPositionSO;
            this.qtyToPutAway = 0.00;
            this.balanceQtyToPutAway = 0.00;
            this.siteOptions = new List<CustomSelectOptions>();
            this.rackOptions = new List<CustomSelectOptions>();
            this.locationOptions = new List<CustomSelectOptions>();
            this.rackLevelOptions = new List<CustomSelectOptions>();
            this.binLocationOptions = new List<CustomSelectOptions>();
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
    
    
    /***********************************print Dymo Label functionality *********************************************
* 
* Get Dymo Label layouts
*/
    public List<SelectOption> getDymoLabelLayouts() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('', 'Select Layout'));
        options.add(new SelectOption(ONEBYTHREE, ONEBYTHREE));
        options.add(new SelectOption(TWOBYFOUR, TWOBYFOUR));
        options.add(new SelectOption(FOURBYSIX, FOURBYSIX));
        return options; 
    }
     
     @AuraEnabled
    public static AuraResponse generateImageXmlQR(String recId,String wrpJson,String layout,String imageXml,Boolean isSelectedInventory){
       system.debug('generateImageXmlQR');
        AuraResponse r = new AuraResponse('InventoryDetails.generateImageXml()');
        InventoryDetails.inventoryDetails(recId,'true');
        imageXml = '';
        isSelectedInventory = false;
        String inventoryInfo;
        String selectedDymoLabelLayout = layout;
        List<String> inventoriesToPrint = new List<String>();
        List<InventoryPositionWrapper> invPositionWrappList = (List<InventoryPositionWrapper>) System.JSON.deserialize(wrpJson, List<InventoryPositionWrapper>.class);
        for(InventoryPositionWrapper invPositionWrapper : invPositionWrappList){
            if(invPositionWrapper.isSelected){
                 if(selectedDymoLabelLayout == TWOBYFOUR){
                    imageXml =IPPrintLabels.getImage2X4XmlQR(invPositionWrapper.invPos);
                }
                isSelectedInventory = true;
                inventoriesToPrint.add(imageXml);
            }
        }
        inventoryInfo = JSON.serialize(inventoriesToPrint);
        if(imageXml == ''){
            isSelectedInventory = false;
        }
        
        AllProductDetails allRec = new AllProductDetails();      
        allRec.invPositionWrappList = invPositionWrappList;
        allRec.imageXml = imageXml;
        allRec.prod = productObjLight;
        allRec.inventoryInfo = inventoryInfo;
        allRec.isSelectedInventory = isSelectedInventory;
        allRec.dymoLabelLayouts = options;
        allRec.selectedDymoLabelLayout = selectedDymoLabelLayout;
        allRec.printers = optionPrinter;
        r.data.put('records', allRec);
        return r;
        
    } 
    // Generate inventory info as image to print functionality
    @AuraEnabled
    public static AuraResponse generateImageXml(String recId,String wrpJson,String layout,String imageXml,Boolean isSelectedInventory){
        AuraResponse r = new AuraResponse('InventoryDetails.generateImageXml()');
        InventoryDetails.inventoryDetails(recId,'true');
        imageXml = '';
        isSelectedInventory = false;
        String inventoryInfo;
        String selectedDymoLabelLayout = layout;
        List<String> inventoriesToPrint = new List<String>();
        List<InventoryPositionWrapper> invPositionWrappList = (List<InventoryPositionWrapper>) System.JSON.deserialize(wrpJson, List<InventoryPositionWrapper>.class);
        for(InventoryPositionWrapper invPositionWrapper : invPositionWrappList){
            if(invPositionWrapper.isSelected){
                if(selectedDymoLabelLayout == ONEBYTHREE){
                    imageXml =IPPrintLabels.getImage1X3Xml(invPositionWrapper.invPos); 
                }else if(selectedDymoLabelLayout == TWOBYFOUR){
                    imageXml =IPPrintLabels.getImage2X4Xml(invPositionWrapper.invPos);
                }else if(selectedDymoLabelLayout == FOURBYSIX){
                    imageXml =IPPrintLabels.getImage4X6Xml(invPositionWrapper.invPos);                    
                }
                isSelectedInventory = true;
                inventoriesToPrint.add(imageXml);
            }
        }
        inventoryInfo = JSON.serialize(inventoriesToPrint);
        if(imageXml == ''){
            isSelectedInventory = false;
        }
        
        AllProductDetails allRec = new AllProductDetails();      
        allRec.invPositionWrappList = invPositionWrappList;
        allRec.imageXml = imageXml;
        allRec.prod = productObjLight;
        allRec.inventoryInfo = inventoryInfo;
        allRec.isSelectedInventory = isSelectedInventory;
        allRec.dymoLabelLayouts = options;
        allRec.selectedDymoLabelLayout = selectedDymoLabelLayout;
        allRec.printers = optionPrinter;
        r.data.put('records', allRec);
        return r;
        
    }
    
}